Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39DD91F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 16:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758117AbcHCQni (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:43:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36514 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757621AbcHCQnE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:43:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id x83so37153085wma.3
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 09:42:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YWBrjc0rbJ0f9RE3hn1Mr158uk9If5wBnbq1ck1EQ3k=;
        b=J7XGdch5fyZwtS7gqzlND2st178nnvoKncXrZNCiYDraTXGID7Dfu5zKRZvoh614SX
         enEU3Rdv06iNRph/+336xU8D1zx0KNlSPVLFEVzaneYvjlbJnXLwyYxc4vhiOe16DvdS
         nDinHRHUAqJvVryiJ8jrtZBmt0qHZ3cDoDkVoBzA0Bc02xMFpUt+o7omMeR/SiaVpFVu
         bTJXtLMnfQ7sdQ4dx6GXTc+1ANqY4dfkw1TaSB89uynaLBViGZQc0Ze8YvB7QdJMGDU8
         GHbHhkfNWKi5+ogGElzbgohXhFUVOXkOAQ8d1jtu5lQZP1Px1maej/wAjfEHfyl2Ywa2
         JFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YWBrjc0rbJ0f9RE3hn1Mr158uk9If5wBnbq1ck1EQ3k=;
        b=IUMV+yYwcY4de/QP7qfe2sCmRUNJqgncU9ZL+gbDTcIHGoV6LSKzOucqELu/jQtMOt
         WzSokd8WQTvWrFyfI6NLn2N62T/03+bHEjAtnGPAfoUIwRodwfmjvx7Twwn7KOd//c4v
         hoKt3A3QPFIJxUijAs3DqRQe1XOhzLWqJzK0vgBc2xnXeq+Lr7lFwnp+GX3OIILLcmTH
         JCOJUqdCkJdKqjuZQ3BgZqGz8/faS9nbSxqSRW0Xb5RmmKDApPrifp2RRufc0z/0h1il
         v+eqnzEyMBoXMkJ8qr9BGW2L5+w/07UAAFTEUvcqWubF1iPteOXrbkS+EpZH3fgWPehh
         /4RQ==
X-Gm-Message-State: AEkoouuTGuorDha//7RuITucsFbL8yeP7n8aBbf5ouDmBQYlf88kF2Ico/zRvQV4UQQU1g==
X-Received: by 10.28.198.140 with SMTP id w134mr69114277wmf.30.1470242553174;
        Wed, 03 Aug 2016 09:42:33 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 3sm8959736wms.1.2016.08.03.09.42.31
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 09:42:32 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v4 05/12] pkt-line: add functions to read/write flush terminated packet streams
Date:	Wed,  3 Aug 2016 18:42:18 +0200
Message-Id: <20160803164225.46355-6-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160803164225.46355-1-larsxschneider@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
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
 pkt-line.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 pkt-line.h |  7 +++++
 2 files changed, 95 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index d1368e6..f115537 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -193,6 +193,44 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 	va_end(args);
 }
 
+int packet_write_stream_with_flush_from_fd(const int fd_in, const int fd_out)
+{
+	int did_fail = 0;
+	ssize_t bytes_to_write;
+	while (!did_fail) {
+		bytes_to_write = xread(fd_in, PKTLINE_DATA_START(packet_buffer), PKTLINE_DATA_MAXLEN);
+		if (bytes_to_write < 0)
+			return COPY_READ_ERROR;
+		if (bytes_to_write == 0)
+			break;
+		did_fail |= direct_packet_write(fd_out, packet_buffer, PKTLINE_HEADER_LEN + bytes_to_write, 1);
+	}
+	if (!did_fail)
+		did_fail = packet_flush_gently(fd_out);
+	return (did_fail ? COPY_WRITE_ERROR : 0);
+}
+
+int packet_write_stream_with_flush_from_buf(const char *src_in, size_t len, int fd_out)
+{
+	int did_fail = 0;
+	size_t bytes_written = 0;
+	size_t bytes_to_write;
+	while (!did_fail) {
+		if ((len - bytes_written) > PKTLINE_DATA_MAXLEN)
+			bytes_to_write = PKTLINE_DATA_MAXLEN;
+		else
+			bytes_to_write = len - bytes_written;
+		if (bytes_to_write == 0)
+			break;
+		did_fail |= direct_packet_write_data(fd_out, src_in + bytes_written, bytes_to_write, 1);
+		bytes_written += bytes_to_write;
+	}
+	if (!did_fail)
+		did_fail = packet_flush_gently(fd_out);
+	return did_fail;
+}
+
+
 static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 			   void *dst, unsigned size, int options)
 {
@@ -302,3 +340,53 @@ char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
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
+		// Read packet header
+		ret = get_packet_data(fd_in, NULL, NULL, linelen, 4, options);
+		if (ret < 0)
+			goto done;
+		len = packet_length(linelen);
+		if (len < 0)
+			die("protocol error: bad line length character: %.4s", linelen);
+		if (!len) {
+			// Found a flush packet - Done!
+			packet_trace("0000", 4, 0);
+			break;
+		}
+		len -= 4;
+
+		// Read packet content
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
+		return ret;  // unexpected EOF
+	}
+	return sb_out->len - oldlen;
+}
diff --git a/pkt-line.h b/pkt-line.h
index 2fbaee9..3c0821f 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -26,6 +26,8 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((f
 int packet_flush_gently(int fd);
 int direct_packet_write(int fd, char *buf, size_t size, int gentle);
 int direct_packet_write_data(int fd, const char *data, size_t size, int gentle);
+int packet_write_stream_with_flush_from_fd(const int fd_in, const int fd_out);
+int packet_write_stream_with_flush_from_buf(const char *src_in, size_t len, int fd_out);
 
 /*
  * Read a packetized line into the buffer, which must be at least size bytes
@@ -78,6 +80,11 @@ char *packet_read_line(int fd, int *size);
  */
 char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
 
+/*
+ * Reads a stream of variable sized packets until a flush packet is detected.
+ */
+ssize_t packet_read_till_flush(int fd_in, struct strbuf *sb_out);
+
 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
 #define PKTLINE_HEADER_LEN 4
-- 
2.9.0

