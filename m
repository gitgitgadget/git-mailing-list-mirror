Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E8581FD99
	for <e@80x24.org>; Thu, 25 Aug 2016 11:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756449AbcHYLTx (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 07:19:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34229 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753554AbcHYLTv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 07:19:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so6940964wma.1
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 04:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wZvdDYP7lHbSzHSyTXzM/uM78AyGAKZaB0IW/LXMMG8=;
        b=h2bDJf4vXO6Vu+PoV6CvaWoyi1DGM2fWorkkBlMIYGuiodhwXWaBmAz4eVPvTQa0Rn
         cQyZLtjJ/QR3PyI5tEN766PB7NVLFojLr0KY1Yc7pOA7Q2DOzaCTIJQcMm8nOKU9oRjl
         0bCJl9mkwe9T8dNy2+VDU7pExRGUb0IHxO/X/9NN5Pf6CBUknrbECiO5ptoW36Rq00TQ
         q/s/f9hINOT5fdfBfMZLMnuoyznjRo7w7Cvnr5nWu8BGFlDmbSZffqB+jrIHSp0kqPfp
         n1z/kz1CjRMG9X6+lo0NqdnnBck0/QrWOkhXXEyaJtugD1D2kVFjL6ikNG3OTQG+EtzT
         lqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wZvdDYP7lHbSzHSyTXzM/uM78AyGAKZaB0IW/LXMMG8=;
        b=f65IMXouH9NGlYtbgfAkugWoEVDRSg2IV7WtW3ffqyorU8WAdHaOlBO87DLPicy0z4
         5fEfieEyRlN6mOssMB0KtebYgwAulD6KZQidpguvww2vwZyfVv7ipbYg2HMadkWV3XaA
         PuY4CIgASnKIdXuUFiR+vdcwiGoGaDWrxv9eK30JkVWYe8D3luMR3A4W8J+d2wYAKQtT
         cpsXeMCrZv/Lt1KcC4lb+R7cG4f2GTYj0tqoTf6NcgKgL2ObOVe84Pmov+oCAKBJlE/r
         3+QAfZfuATJkKhlqGzrYpk/BmqToXfbJxN07QK4wRuubLEqqGpeedcrSzI7JQ2LleRhL
         hWBw==
X-Gm-Message-State: AE9vXwMqpHqUiV5dB1PQUgKzUEBe4MAphQXutMjePjsUbxrvRcgnIKPDz3A7tvKn7sM5/Q==
X-Received: by 10.28.14.68 with SMTP id 65mr7814716wmo.68.1472123284862;
        Thu, 25 Aug 2016 04:08:04 -0700 (PDT)
Received: from bcnf9f9l32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id p71sm38304839wmf.9.2016.08.25.04.08.03
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 25 Aug 2016 04:08:04 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v6 06/13] pkt-line: add functions to read/write flush terminated packet streams
Date:   Thu, 25 Aug 2016 13:07:45 +0200
Message-Id: <20160825110752.31581-7-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160825110752.31581-1-larsxschneider@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

packet_write_stream_with_flush_from_fd() and
packet_write_stream_with_flush_from_buf() write a stream of packets. All
content packets use the maximal packet size except for the last one.
After the last content packet a `flush` control packet is written.

packet_read_till_flush() reads arbitrary sized packets until it detects
a `flush` packet.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 pkt-line.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 pkt-line.h |  7 +++++
 2 files changed, 98 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 7e8a803..3033aa3 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -176,6 +176,47 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 	va_end(args);
 }
 
+int packet_write_stream_with_flush_from_fd(int fd_in, int fd_out)
+{
+	int err = 0;
+	ssize_t bytes_to_write;
+
+	while (!err) {
+		bytes_to_write = xread(fd_in, packet_write_buffer, sizeof(packet_write_buffer) - 4);
+		if (bytes_to_write < 0)
+			return COPY_READ_ERROR;
+		if (bytes_to_write == 0)
+			break;
+		if (bytes_to_write > sizeof(packet_write_buffer) - 4)
+			return COPY_WRITE_ERROR;
+		err = packet_write_gently(fd_out, packet_write_buffer, bytes_to_write);
+	}
+	if (!err)
+		err = packet_flush_gently(fd_out);
+	return err;
+}
+
+int packet_write_stream_with_flush_from_buf(const char *src_in, size_t len, int fd_out)
+{
+	int err = 0;
+	size_t bytes_written = 0;
+	size_t bytes_to_write;
+
+	while (!err) {
+		if ((len - bytes_written) > sizeof(packet_write_buffer) - 4)
+			bytes_to_write = sizeof(packet_write_buffer) - 4;
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
@@ -285,3 +326,53 @@ char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
 {
 	return packet_read_line_generic(-1, src, src_len, dst_len);
 }
+
+ssize_t packet_read_till_flush(int fd_in, struct strbuf *sb_out)
+{
+	int len, ret;
+	int options = PACKET_READ_GENTLE_ON_EOF;
+	char linelen[4];
+
+	size_t oldlen = sb_out->len;
+	size_t oldalloc = sb_out->alloc;
+
+	for (;;) {
+		/* Read packet header */
+		ret = get_packet_data(fd_in, NULL, NULL, linelen, 4, options);
+		if (ret < 0)
+			goto done;
+		len = packet_length(linelen);
+		if (len < 0)
+			die("protocol error: bad line length character: %.4s", linelen);
+		if (!len) {
+			/* Found a flush packet - Done! */
+			packet_trace("0000", 4, 0);
+			break;
+		}
+		len -= 4;
+
+		/* Read packet content */
+		strbuf_grow(sb_out, len);
+		ret = get_packet_data(fd_in, NULL, NULL, sb_out->buf + sb_out->len, len, options);
+		if (ret < 0)
+			goto done;
+
+		if (ret != len) {
+			error("protocol error: incomplete read (expected %d, got %d)", len, ret);
+			goto done;
+		}
+
+		packet_trace(sb_out->buf + sb_out->len, len, 0);
+		sb_out->len += len;
+	}
+
+done:
+	if (ret < 0) {
+		if (oldalloc == 0)
+			strbuf_release(sb_out);
+		else
+			strbuf_setlen(sb_out, oldlen);
+		return ret;  /* unexpected EOF */
+	}
+	return sb_out->len - oldlen;
+}
diff --git a/pkt-line.h b/pkt-line.h
index 3fa0899..9616117 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -25,6 +25,8 @@ void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+int packet_write_stream_with_flush_from_fd(int fd_in, int fd_out);
+int packet_write_stream_with_flush_from_buf(const char *src_in, size_t len, int fd_out);
 
 /*
  * Read a packetized line into the buffer, which must be at least size bytes
@@ -77,6 +79,11 @@ char *packet_read_line(int fd, int *size);
  */
 char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
 
+/*
+ * Reads a stream of variable sized packets until a flush packet is detected.
+ */
+ssize_t packet_read_till_flush(int fd_in, struct strbuf *sb_out);
+
 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
 extern char packet_buffer[LARGE_PACKET_MAX];
-- 
2.9.2

