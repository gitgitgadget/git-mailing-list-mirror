Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 249A71FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935330AbcHJT33 (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:29:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36327 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934191AbcHJT30 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 15:29:26 -0400
Received: by mail-wm0-f68.google.com with SMTP id i138so11472542wmf.3
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 12:29:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dVIaAjz9gRI1XrQ5Dss+3R0OpaYgEhqxtnI0uCiPfqc=;
        b=ApFawEt96JTOkxKg7zeCF6n5wUFwiBeecHFvGNdeWeWAiD4C0V17MxiblJbKDMVhPm
         YYmp30Cdase6kukYicRPIR0sirNLQsMBR96gu9ZgP9fR66MHFlfaC++inMNWVVBTKLqA
         lNYhvJl+j0DJDksWbxN+GUw1+7XxNuJ67sNQBt3RLaxTRF2m28vzvEZ0xIsXzrGIcWQH
         k8dMiVmg6FsIMUNbfvs8u0FZig8Ps0v2MvMzjGMR2fUok086Wokq6Ar25R0zbKV75q9h
         jbZygOHdGUL9m+HX5ngn+yPxywCxQYSmHk09IuK0RYUkbek6GjtoE2+wGTJpWBuhvNax
         qDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dVIaAjz9gRI1XrQ5Dss+3R0OpaYgEhqxtnI0uCiPfqc=;
        b=TYfcD2zPJB6kjXHkm4NMErHMNjete0lkM4f9hYfwF+JI40bILcNnAzCQXFX6USvuxK
         cB1XlMA8EqxK7JTQ+TaHeGV5COszOhVGqPVOxqN5kVD0w4nElBG/MF26BGXySJUEc1mq
         k0/of7P5mmqz+BhL78FJ3/YnfjimgBJJG4fMpUAPueL6Nco9phCnic9PGy3YkV90OVwT
         ODYxeyreyIU5BuxYLADziKBXKMmUoF78QYWnQ6W/0et0LTeATZyqVNGPHcoGzuzVeanQ
         TTK1ZvO3gGFgyBax1fsY47QJqjxqO4lkIIPZ49hi5MyJFRqjPpd9aml4ku/i8aTjIJlR
         6SdQ==
X-Gm-Message-State: AEkoouv9F2ZzwPI90nG3aEuZyuW08p4akhDJocXPLtD8HxhD66T4biN8qWM5UhII2AeeCA==
X-Received: by 10.194.123.228 with SMTP id md4mr3712035wjb.91.1470834260561;
        Wed, 10 Aug 2016 06:04:20 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p83sm8319899wma.18.2016.08.10.06.04.19
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 06:04:20 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, mlbright@gmail.com,
	e@80x24.org, peff@peff.net, Johannes.Schindelin@gmx.de,
	ben@wijen.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v5 07/15] pkt-line: add functions to read/write flush terminated packet streams
Date:	Wed, 10 Aug 2016 15:04:03 +0200
Message-Id: <20160810130411.12419-8-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160810130411.12419-1-larsxschneider@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
 <20160810130411.12419-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

packet_write_stream_with_flush_from_fd() and
packet_write_stream_with_flush_from_buf() write a stream of packets. All
content packets use the maximal packet size except for the last one.
After the last content packet a `flush` control packet is written.

packet_read_till_flush() reads arbitary sized packets until it detects
a `flush` packet.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 pkt-line.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 pkt-line.h |  7 +++++
 2 files changed, 96 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index e6a0924..4b526e1 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -181,6 +181,45 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 	va_end(args);
 }
 
+int packet_write_stream_with_flush_from_fd(int fd_in, int fd_out)
+{
+	int err = 0;
+	ssize_t bytes_to_write;
+	while (!err) {
+		bytes_to_write = xread(fd_in, packet_write_buffer, PKTLINE_DATA_MAXLEN);
+		if (bytes_to_write < 0)
+			return COPY_READ_ERROR;
+		if (bytes_to_write == 0)
+			break;
+		if (bytes_to_write > PKTLINE_DATA_MAXLEN)
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
+	while (!err) {
+		if ((len - bytes_written) > PKTLINE_DATA_MAXLEN)
+			bytes_to_write = PKTLINE_DATA_MAXLEN;
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
@@ -290,3 +329,53 @@ char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
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
index b6c8bcd..89063ee 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -25,6 +25,8 @@ void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int packet_flush_gently(int fd);
 int packet_write_gently_fmt(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
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
 #define PKTLINE_DATA_MAXLEN (LARGE_PACKET_MAX - 4)
-- 
2.9.2

