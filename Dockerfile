FROM golang as builder
WORKDIR /code
ADD go.mod go.sum /code/
RUN go mod download
ADD . .
RUN go mod vendor
RUN go build -o /domain_exporter main.go

FROM gcr.io/distroless/base
EXPOSE 9222
WORKDIR /
COPY --from=builder /domain_exporter /usr/bin/domain_exporter
ENTRYPOINT ["/usr/bin/domain_exporter"]
