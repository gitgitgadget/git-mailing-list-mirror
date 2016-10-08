Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB8CB207EC
	for <e@80x24.org>; Sat,  8 Oct 2016 11:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935119AbcJHL0M (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Oct 2016 07:26:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35587 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932750AbcJHLZx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2016 07:25:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id f193so6634998wmg.2
        for <git@vger.kernel.org>; Sat, 08 Oct 2016 04:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IQ2hG4bGRVXrYZLcozRb/QBEBzTemEuIT+uH9yb1mno=;
        b=FEBW9BGIexCbW2KSgGYAOpOAUOSDFDZ0DxWoXKwaVRUzQ0X9jAMtDNpnSKoSQ/XM4v
         wvlKJVMi/4wSjb4ZEZC43J7RLk6UmVeGL/RBmb1WrBGm34dkPdIYbQ9GUr18GXkQHXGU
         /Wn/bF0WtRC1iXl0SipsKTFo1ilsDUoTDKCrIb4ixyE4NsMGOPvrd1iANA42b2f1s1vV
         mkVfY96po80XS385cp4Si44LuaDMyQklDX9ubqQedS73DDKEZoQNwkR+BsHw0+XV8e37
         T54mP7PFImGUmZk0Z3hfwz/sDx+9xcLtULaI96TqNjhNC4TvZgaWg+GF7zfOquIjXS/g
         +z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IQ2hG4bGRVXrYZLcozRb/QBEBzTemEuIT+uH9yb1mno=;
        b=QBObVJqMcvb3Bs7ItVId0z1rYyesFtat/qM8Q7kIii88+GoPNxvF+wJafKZIbzS0XA
         zGj+lvNzzb/17SVMVamxP++JCtMuiBbgSFJL2WjgRuAPIqhEc8W9N+zoDybvi4xkJ6tQ
         3qKn+xBqqgRUFBIKJnND9GGv7zG89ANlKMoIoUu+7dpZRAQH2N/DswDCoFFpcvxbIM4Q
         j6b5dY/HPL3TrfhNu8rAsVua2RWWjjQVM0U1mI131OKRoVobaXuX2KyC+UKEGaahJEf1
         7K5NvNj37/gLmegHJlvFV/IHLH//5KqqxkN5f3JZF0I4Cozzi7nDc/CTc8KL5fmMReWu
         QUoQ==
X-Gm-Message-State: AA6/9RmfTD7TGRHLj7GAy8gvQ1HQKhzs0gOqPD/pTnkYbBAnO/3TKsJLlcN/XO+Anmmfew==
X-Received: by 10.28.169.198 with SMTP id s189mr2481430wme.23.1475925946097;
        Sat, 08 Oct 2016 04:25:46 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB73B1.dip0.t-ipconnect.de. [93.219.115.177])
        by smtp.gmail.com with ESMTPSA id a1sm24599623wju.41.2016.10.08.04.25.44
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 08 Oct 2016 04:25:45 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v10 10/14] pkt-line: add functions to read/write flush terminated packet streams
Date:   Sat,  8 Oct 2016 13:25:26 +0200
Message-Id: <20161008112530.15506-11-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161008112530.15506-1-larsxschneider@gmail.com>
References: <20161008112530.15506-1-larsxschneider@gmail.com>
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

