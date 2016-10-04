Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A10B420987
	for <e@80x24.org>; Tue,  4 Oct 2016 13:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754150AbcJDNAP (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 09:00:15 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34477 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753957AbcJDNAD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 09:00:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id b201so14421502wmb.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 06:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fHtUL42V67ry56cJxl6rYoZbdhERbRQZJYeL4GkkrNA=;
        b=qZqySwu5kTbuIzRk6KpXY6iYB41JH/aOACwyZ4u9BeauP6MKvCpMcPt4NcBitevyEq
         7h+ekAvhCZ3KfclpieIb3MYNihia7LHZqJ/Tob0AoTacZolSFdAI2AWJvMIxpvTxJrmv
         0Hj6OfdBikckzJfkjlZRCb8993nuu2lCJdji9wJ7miA3TQZGcK3q6FxX+m7KfKpxlxvL
         bHiJJzPOUqQ9J1OKRRtkmK/hPkruZ+ld3gmtyMcfbEgeVM5+0v9ghBs0sbqzTlwdAkxw
         1pio0TR/4xu9a6hPdAEhPf6NOiGMeqF5+FgnSr68RAsDTinBdjihLDMojB8oCqmaQ63w
         rIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fHtUL42V67ry56cJxl6rYoZbdhERbRQZJYeL4GkkrNA=;
        b=RmEu5g4DN7KQ7FGYCiMqzAOjop297jjijZs40WWpdxhLsJAw7CBEPRK6Odx31mlZGc
         V/GHJcMa/lf2WmrcetezDEwci6vYXimsNIFyUpFkzJ6wZ6b+cuZuF1lXfdnq2Ay/pN0M
         coDvG1c7VKZf46J9IBFO/fFcPbLyh4Rj4fZhITTyOhUq8I8lqZNYbzvi+EiSckDiNKvC
         LMXFdZOAVC0RgLN82ibUv4uoikHPxU8XSvU1lWrOWkrvT4f8hsazPUsreJP5Dja70jlJ
         EesyCzqNUS9Aj8ZkbsFwhRct9+aLtkubaG4gk0Zy3HFxt2HwcAZSASP6ZXeCEK+S0M0X
         rHOg==
X-Gm-Message-State: AA6/9RmCgRRyOE0CgO4vAah7IG+CkyaVdZvrKAZZT1cj6R7zBG3hlQpMc5DCgH1XHsi8Dw==
X-Received: by 10.195.11.8 with SMTP id ee8mr2921847wjd.82.1475586001625;
        Tue, 04 Oct 2016 06:00:01 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id qo8sm3426934wjc.46.2016.10.04.06.00.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 04 Oct 2016 06:00:01 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     ramsay@ramsayjones.plus.com, jnareb@gmail.com, gitster@pobox.com,
        j6t@kdbg.org, tboegi@web.de, peff@peff.net, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v9 10/14] pkt-line: add functions to read/write flush terminated packet streams
Date:   Tue,  4 Oct 2016 14:59:43 +0200
Message-Id: <20161004125947.67104-11-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161004125947.67104-1-larsxschneider@gmail.com>
References: <20161004125947.67104-1-larsxschneider@gmail.com>
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
 pkt-line.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 pkt-line.h |  8 ++++++++
 2 files changed, 77 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 3fd4dc0..8ffde22 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -196,6 +196,47 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
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
+	static char buf[LARGE_PACKET_DATA_MAX];
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
@@ -305,3 +346,31 @@ char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
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
+			// TODO: explain + 1
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

