Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A8C12098B
	for <e@80x24.org>; Sun, 16 Oct 2016 23:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757135AbcJPXV2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 19:21:28 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33498 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757097AbcJPXV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 19:21:27 -0400
Received: by mail-pa0-f66.google.com with SMTP id hh10so8539919pac.0
        for <git@vger.kernel.org>; Sun, 16 Oct 2016 16:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IQ2hG4bGRVXrYZLcozRb/QBEBzTemEuIT+uH9yb1mno=;
        b=EjrqZADeIKrn17Z/3Xfo83siTfgbhCOEzde58aGLd+hMqDVO4TAYX/vwrGFDMvDNRg
         q+0hSSbDUuRSgOPjmDBmRjlpybQihx9Ny/gtl8mkfpIo8rjvpGIhwHFsH4aArRQxujb2
         PpjrW/UtDyOoMowXl/6sXxcJZwv2ErywGEK+4Mqab0INQggFCQx33EfClw8PHBPHNWvW
         bXY3VrBtsKssbVZiQWjLgq+jMb1y/LsecPU77w/56NGalE3OVip7O1oZv8Rhsl5eEGzx
         7D26ygb4EccmFvtrQTXD+tS4bw7rY789k80DmrkwBBJUFc3Xy9LsnhGmft3kqN0trP03
         cB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IQ2hG4bGRVXrYZLcozRb/QBEBzTemEuIT+uH9yb1mno=;
        b=KSYIcUioR2aY92cbu1mdADNlQsscsV8PixrBVIVGPQ3eawuOFqegdy4z1f/AffB06A
         48cjTX6/HoSJux9WajNAtecgiXnSFxsL08PH+zFMZGn1VobYaex5ibStWAs+AtaiAYSe
         fmBle8vL4F76WgtiZGaVHDnFUlGNHgQWn7wpUkl7gv8y49i8+1nVgXZra0vijcaAtS9c
         skTONX7itqF75PEVTAaeOHWsnapGR3HaSUZm0U2KNNrivA9c87ijs+CVoyXiBDUWzBwy
         cqtudRbJUvZhZ1TrLXyHn01fNJUz37f+N7XZA/8hMI1AHolaT0vDSmo0YbNciB2ZkDcL
         51kA==
X-Gm-Message-State: AA6/9Rnnd16WBUovKdIm6siN2LIn6H7bGIu35KGzHUM4BB2Fqsfm4r5mK5YoBCfCe2nOUQ==
X-Received: by 10.67.7.100 with SMTP id db4mr28395175pad.106.1476660086762;
        Sun, 16 Oct 2016 16:21:26 -0700 (PDT)
Received: from rem3n8pj12.ads.autodesk.com (adsk-nat-ip4.autodesk.com. [132.188.71.4])
        by smtp.gmail.com with ESMTPSA id cp2sm10325691pad.3.2016.10.16.16.21.21
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 16 Oct 2016 16:21:26 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, tboegi@web.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 10/14] pkt-line: add functions to read/write flush terminated packet streams
Date:   Sun, 16 Oct 2016 16:20:34 -0700
Message-Id: <20161016232038.84951-11-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161016232038.84951-1-larsxschneider@gmail.com>
References: <20161016232038.84951-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

write_packetized_from_fd() and write_packetized_from_buf() write a
stream of packets. All content packets use the maximal packet size
except for the last one. After the last content packet a `flush` control
packet is written.

read_packetized_to_strbuf() reads arbitrary sized packets until it
detects a `flush` packet.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pkt-line.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 pkt-line.h |  8 +++++++
 2 files changed, 80 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index dca5a64..0b5125f 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -197,6 +197,46 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 	va_end(args);
 }
 
+int write_packetized_from_fd(int fd_in, int fd_out)
+{
+	static char buf[LARGE_PACKET_DATA_MAX];
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
+	int err = 0;
+	size_t bytes_written = 0;
+	size_t bytes_to_write;
+
+	while (!err) {
+		if ((len - bytes_written) > LARGE_PACKET_DATA_MAX)
+			bytes_to_write = LARGE_PACKET_DATA_MAX;
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
@@ -306,3 +346,35 @@ char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
 {
 	return packet_read_line_generic(-1, src, src_len, dst_len);
 }
+
+ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
+{
+	int packet_len;
+
+	size_t orig_len = sb_out->len;
+	size_t orig_alloc = sb_out->alloc;
+
+	for (;;) {
+		strbuf_grow(sb_out, LARGE_PACKET_DATA_MAX);
+		packet_len = packet_read(fd_in, NULL, NULL,
+			/* strbuf_grow() above always allocates one extra byte to
+			 * store a '\0' at the end of the string. packet_read()
+			 * writes a '\0' extra byte at the end, too. Let it know
+			 * that there is already room for the extra byte.
+			 */
+			sb_out->buf + sb_out->len, LARGE_PACKET_DATA_MAX+1,
+			PACKET_READ_GENTLE_ON_EOF);
+		if (packet_len <= 0)
+			break;
+		sb_out->len += packet_len;
+	}
+
+	if (packet_len < 0) {
+		if (orig_alloc == 0)
+			strbuf_release(sb_out);
+		else
+			strbuf_setlen(sb_out, orig_len);
+		return packet_len;
+	}
+	return sb_out->len - orig_len;
+}
diff --git a/pkt-line.h b/pkt-line.h
index 3fa0899..18eac64 100644
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
@@ -77,8 +79,14 @@ char *packet_read_line(int fd, int *size);
  */
 char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
 
+/*
+ * Reads a stream of variable sized packets until a flush packet is detected.
+ */
+ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out);
+
 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
+#define LARGE_PACKET_DATA_MAX (LARGE_PACKET_MAX - 4)
 extern char packet_buffer[LARGE_PACKET_MAX];
 
 #endif
-- 
2.10.0

