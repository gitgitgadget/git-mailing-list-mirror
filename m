Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFDC6209AA
	for <e@80x24.org>; Tue, 20 Sep 2016 19:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933005AbcITTDU (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 15:03:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34729 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932825AbcITTDA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 15:03:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id l132so4895589wmf.1
        for <git@vger.kernel.org>; Tue, 20 Sep 2016 12:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mRBDFum78QF5MKoZHTQKDh2oRX/7NRePIEOa9LWcOiM=;
        b=XAHa4GeimGqPfg9Sbua1HKjQrx+D1/WXiEZ82bUTa5J7D5U39NoWeBImYJGu3HDF17
         HK3gc2nCwj7678KlivLYj5ri+el14z+qsvOFzJDNFIJpg2clC/d+CWvE68IQCZxmWhZL
         QXXQWVW567ucKLDAiP0NePj9Nc9PUSeoWKN9x1grOsIs0it53XT9afO1M7ckcG8fyYCn
         qgNKqTtPyMs+rWVaLpS/cDZSlbSfy/vCpjzBmy4qBERlLFfmnWMR7S/54SG7RbcWlJEz
         6/WYLF0tfvkXK72aT5TwLsC6FdtmFgddTQMnIv2Q7ozk09TqUw6hNu08HpvCQV2TKkIr
         m78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mRBDFum78QF5MKoZHTQKDh2oRX/7NRePIEOa9LWcOiM=;
        b=lln2lkiwOervLNg4E+tp/tRDMiR6rCYTmjdwaGMksfedYIxYT+pNpUb5mfHTO31btw
         GP93cVhozOH5EXeXZXlUOTAgmWvaSOuLIZ6wTqcy9XefDuz6oPfuvr6OUtGgKTtAfTmz
         P+BJkhoerzqCKW2OLmEcmRX3d5WeLXg6asvUomX8IfvlBEZLHROrHqI91bI/WIcnwycA
         F7tWr4NAsw7Es1it5vFVGYV2YM5YJheQ0pnENwFmtkveA90EgMWizM7uEyJ1hmHSaBRF
         f/wAVHVAAf9J5F5e7Wcx+1zGexUeTDz4viuUpVXXVrirLWOKv5aDKG5HQoWDJna9x+5k
         gd2w==
X-Gm-Message-State: AE9vXwMDi9rGPzBzlcDq1Rjwb5zrabbnNPIw64v4ZkZvsM3PN2ekceqkjyYyEsnY1XiZZw==
X-Received: by 10.28.208.134 with SMTP id h128mr4422023wmg.101.1474398178945;
        Tue, 20 Sep 2016 12:02:58 -0700 (PDT)
Received: from slxBook4.fritz.box (p508BA5EF.dip0.t-ipconnect.de. [80.139.165.239])
        by smtp.gmail.com with ESMTPSA id gg10sm29820728wjd.4.2016.09.20.12.02.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 20 Sep 2016 12:02:58 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        jnareb@gmail.com, mlbright@gmail.com, tboegi@web.de,
        ramsay@ramsayjones.plus.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v8 07/11] pkt-line: add functions to read/write flush terminated packet streams
Date:   Tue, 20 Sep 2016 21:02:43 +0200
Message-Id: <20160920190247.82189-8-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160920190247.82189-1-larsxschneider@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

write_packetized_from_fd() and write_packetized_from_buf() write a
stream of packets. All content packets use the maximal packet size
except for the last one. After the last content packet a `flush` control
packet is written.

read_packetized_to_buf() reads arbitrary sized packets until it detects
a `flush` packet.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 pkt-line.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 pkt-line.h |  7 +++++++
 2 files changed, 75 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index fc0ac12..a0a8543 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -196,6 +196,47 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 	va_end(args);
 }
 
+int write_packetized_from_fd(int fd_in, int fd_out)
+{
+	static char buf[PKTLINE_DATA_MAXLEN];
+	int err = 0;
+	ssize_t bytes_to_write;
+
+	while (!err) {
+		bytes_to_write = xread(fd_in, buf, sizeof(buf));
+		if (bytes_to_write < 0)
+			return COPY_READ_ERROR;
+		if (bytes_to_write == 0)
+			break;
+		err = packet_write_gently(fd_out, buf, bytes_to_write);
+	}
+	if (!err)
+		err = packet_flush_gently(fd_out);
+	return err;
+}
+
+int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
+{
+	static char buf[PKTLINE_DATA_MAXLEN];
+	int err = 0;
+	size_t bytes_written = 0;
+	size_t bytes_to_write;
+
+	while (!err) {
+		if ((len - bytes_written) > sizeof(buf))
+			bytes_to_write = sizeof(buf);
+		else
+			bytes_to_write = len - bytes_written;
+		if (bytes_to_write == 0)
+			break;
+		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write);
+		bytes_written += bytes_to_write;
+	}
+	if (!err)
+		err = packet_flush_gently(fd_out);
+	return err;
+}
+
 static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 			   void *dst, unsigned size, int options)
 {
@@ -305,3 +346,30 @@ char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
 {
 	return packet_read_line_generic(-1, src, src_len, dst_len);
 }
+
+ssize_t read_packetized_to_buf(int fd_in, struct strbuf *sb_out)
+{
+	int paket_len;
+	int options = PACKET_READ_GENTLE_ON_EOF;
+
+	size_t oldlen = sb_out->len;
+	size_t oldalloc = sb_out->alloc;
+
+	for (;;) {
+		strbuf_grow(sb_out, PKTLINE_DATA_MAXLEN+1);
+		paket_len = packet_read(fd_in, NULL, NULL,
+			sb_out->buf + sb_out->len, PKTLINE_DATA_MAXLEN+1, options);
+		if (paket_len <= 0)
+			break;
+		sb_out->len += paket_len;
+	}
+
+	if (paket_len < 0) {
+		if (oldalloc == 0)
+			strbuf_release(sb_out);
+		else
+			strbuf_setlen(sb_out, oldlen);
+		return paket_len;
+	}
+	return sb_out->len - oldlen;
+}
diff --git a/pkt-line.h b/pkt-line.h
index 3fa0899..6df8449 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -25,6 +25,8 @@ void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+int write_packetized_from_fd(int fd_in, int fd_out);
+int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
 
 /*
  * Read a packetized line into the buffer, which must be at least size bytes
@@ -77,6 +79,11 @@ char *packet_read_line(int fd, int *size);
  */
 char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
 
+/*
+ * Reads a stream of variable sized packets until a flush packet is detected.
+ */
+ssize_t read_packetized_to_buf(int fd_in, struct strbuf *sb_out);
+
 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
 extern char packet_buffer[LARGE_PACKET_MAX];
-- 
2.10.0

