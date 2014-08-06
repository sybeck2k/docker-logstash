FROM jgoodall/ubuntu-confd

MAINTAINER Roberto Migli <robertomigli@gmail.com>

# Install Java
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y --force-yes openjdk-7-jre-headless curl

# Create directories
RUN mkdir -p /opt/logstash/ssl
RUN mkdir -p /etc/confd/conf.d
RUN mkdir -p /etc/confd/templates

# Install Logstash
RUN curl https://download.elasticsearch.org/logstash/logstash/logstash-1.4.0.tar.gz -o /tmp/logstash-1.4.0.tar.gz
RUn tar xfz /tmp/logstash-1.4.0.tar.gz -C /opt/logstash --strip-components=1

# Add files
ADD ./confd                   /etc/confd
ADD ./bin/boot.sh             /boot.sh

# Start the container
RUN chmod +x /boot.sh
CMD /boot.sh
