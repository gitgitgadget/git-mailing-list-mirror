Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACE0120705
	for <e@80x24.org>; Thu,  8 Sep 2016 18:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758570AbcIHSWA (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 14:22:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36862 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758552AbcIHSVr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 14:21:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id l65so9002101wmf.3
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 11:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hyuGF7pi5Gg5R6otBdOABU0AbR+CgY/sbJgPqRbktGA=;
        b=BZXJmFP+Vb1zfwtsXVERaC3h6Mjk5CqLuP+FBnjTOCOohk2uhp4HDh3yEDZLHQH1S/
         hykdi+8FwryqIoqOpwfQBMi9jR8dPM2uRFZ9mqBOI8psf3zfSWMFz2B466kh35cv8+Lj
         vGIWfgsdMZe5F3LrWSCI4uulBwqhZ09IoHo+LF1rYCLbk08ZTMUPEhCcwyKwN4eccxqw
         5RB8ghz5ZGWv3skm5/v8LjwVWVm7E3o2wc/wQ1ovWCuvwDztMhrQ5f/M0mFWFeQTWHtt
         OvwzH8OSj5+7nCjs8c9Ns7zesqhxUxPJmzPKzNrKE3IG04x7gZe3hPXYaCwaRqS6Wxzo
         ob0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hyuGF7pi5Gg5R6otBdOABU0AbR+CgY/sbJgPqRbktGA=;
        b=Xrn7Wj0LDu7EJ8fYL6bnIFPfmYsOml98R1ktd/yzAet1WStpyQ4CbOyFwyoYPTrvX/
         HHaVTyApHI/eYpUN9Z/ick++f2tU0xDcr/svXqKtObVxXyMSLOglNhBZixgxdsb0CSjb
         ffvcfQtd0pKOqi6k21jJEdjVpjrRel0jYX6flEdLqBoPM2RJsoyGQDzzxTfxYeaeRRS4
         wMRpXTSAwWXQqJbsWdzyuWNVSQ8VFWHGdTzn/WwD6JWoS8lHtiqM4PnGdCZUrptiYw5p
         NwoH4YqDsosyXR/LTHUL98+g6hqsrgirposvcX2+5TBxPwX57CSAJjzDslA1xP6HnMKC
         jNTg==
X-Gm-Message-State: AE9vXwPvn1MbwzAOpTLovqwSaKfbkl944svVoEpPWULuB1z8IW07G1Z+vvT5BrUv1kvp9A==
X-Received: by 10.194.94.138 with SMTP id dc10mr1101357wjb.40.1473358906143;
        Thu, 08 Sep 2016 11:21:46 -0700 (PDT)
Received: from slxBook4.local.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id b128sm10967467wmb.21.2016.09.08.11.21.44
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 08 Sep 2016 11:21:45 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        tboegi@web.de, jacob.keller@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v7 06/10] pkt-line: add functions to read/write flush terminated packet streams
Date:   Thu,  8 Sep 2016 20:21:28 +0200
Message-Id: <20160908182132.50788-7-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160908182132.50788-1-larsxschneider@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com>
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
index 1d3d725..5001a07 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -209,6 +209,47 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
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
@@ -318,3 +359,30 @@ char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
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

