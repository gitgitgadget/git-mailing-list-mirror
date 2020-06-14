Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE3FC433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 07:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F4420714
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 07:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdYyCi/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgFNHcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 03:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgFNHcO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 03:32:14 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAE6C08C5C3
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 00:32:12 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c12so10293768qtq.11
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 00:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P3BoSXlV2iwXhXGB0SB4Lvpxw5m2FRgbooQ0feO1Z18=;
        b=gdYyCi/+RHtmBiHtH9/x0uP+DycR8FoyTh/WMPYU2LuYofgfODfwTp9aV7iftRfdkG
         mLN05ezaAdW0KZFofKMtc+vT8kXuFEc5jv2rDqYpjfM/JeupNpbxlzajnUpnbV+xQPeJ
         0zpoU1Nyh75OZvvzJ1WOo8/wK0vV3fXUJqoOnh9pkfNdb2I7lvJHMfOlBuVZApdxQUf8
         f+fl66vC9ibUSX8LmqucOUixq/zJ/icIP78o5kqOODa3Mzdz7HKFGe5MS+E82QGO5aPw
         UXWLoe1nVMseOlss+XCTdP12LB7xPGaQlo5rTjndYMdLINoeBT7seM0CssF11c1UbgpP
         sxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P3BoSXlV2iwXhXGB0SB4Lvpxw5m2FRgbooQ0feO1Z18=;
        b=goN8tHruw0WLmtRSGSmF0e+it+frnYd+MWNN2CezTYg6DeokKNPVKlCq04PmOtS567
         7bK40YEnwuj8f5tbS/5RIPNKeEy3oxaaFnL72GyeZb/0iqUAZdDgjSuJ7hx/0rbJwnSk
         CfSipqYRMgw6kT4SvcX48VuRl6tVDG4o567yeU15REhGb/QtPuDJhSqgwyuajkKBHnRO
         MaYrSjMnzGtJMA72p8oHsJw+e7v+N852cIPEZrec/KWAQ/rIRz7bY7TgdFEH79RczPYU
         BWZHqsvYaHwuc4NK0yPTCW4jRC8Q9Lkv8LzeFnfUa+WXknDOOH9LIK6MvFS9o3YNq8co
         qaHw==
X-Gm-Message-State: AOAM530mpP5fk7I+xBa5YE4J8MMEIeyq2Qto40b2MNX7Y2aXhX4ZKpLJ
        0IV+k9neFrG+IqC0iE2SQBlSJbldS54=
X-Google-Smtp-Source: ABdhPJzQQIhb7EGHIjsfRwwbR9QBFn/FV8M1UwiGW39LOLgiqB+hv1XoU6KxcMk0fp7QDP9deKgSvg==
X-Received: by 2002:ac8:3267:: with SMTP id y36mr10885309qta.241.1592119931191;
        Sun, 14 Jun 2020 00:32:11 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id a82sm8834341qkb.29.2020.06.14.00.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 00:32:10 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 3/3] pkt-line: extract out PACKET_HEADER_SIZE
Date:   Sun, 14 Jun 2020 03:32:00 -0400
Message-Id: <aff4f6401d0ee70f6871f6d75078ddd1e0ca6e47.1592119902.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
In-Reply-To: <cover.1592119902.git.liu.denton@gmail.com>
References: <7e803a2ba9458ce35c657e67323edfe4409205ec.1592055716.git.liu.denton@gmail.com> <cover.1592119902.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In pkt-line and remote-curl, we have many instances of magic `4`
literals floating around which represent the number of bytes in the
packet line length header. Instead of using these magic numbers, replace
them with constant expressions.

In most cases, replace the `4` with `PACKET_HEADER_SIZE`. However, in
the case where there's a `char array[PACKET_HEADER_SIZE]`  and we are
reading data into it, replace the `4` with a `sizeof(array)` so that
it's clear that the logic has something to do with that array.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 pkt-line.c    | 20 ++++++++++----------
 pkt-line.h    |  6 ++++--
 remote-curl.c | 31 ++++++++++++++++---------------
 3 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 72c6c29e03..f1fe0888c1 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -163,7 +163,7 @@ static void format_packet(struct strbuf *out, const char *prefix,
 		die(_("protocol error: impossibly long line"));
 
 	set_packet_header(&out->buf[orig_len], n);
-	packet_trace(out->buf + orig_len + 4, n - 4, 1);
+	packet_trace(out->buf + orig_len + PACKET_HEADER_SIZE, n - PACKET_HEADER_SIZE, 1);
 }
 
 static int packet_write_fmt_1(int fd, int gently, const char *prefix,
@@ -209,13 +209,13 @@ static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 	static char packet_write_buffer[LARGE_PACKET_MAX];
 	size_t packet_size;
 
-	if (size > sizeof(packet_write_buffer) - 4)
+	if (size > sizeof(packet_write_buffer) - PACKET_HEADER_SIZE)
 		return error(_("packet write failed - data exceeds max packet size"));
 
 	packet_trace(buf, size, 1);
-	packet_size = size + 4;
+	packet_size = size + PACKET_HEADER_SIZE;
 	set_packet_header(packet_write_buffer, packet_size);
-	memcpy(packet_write_buffer + 4, buf, size);
+	memcpy(packet_write_buffer + PACKET_HEADER_SIZE, buf, size);
 	if (write_in_full(fd_out, packet_write_buffer, packet_size) < 0)
 		return error(_("packet write failed"));
 	return 0;
@@ -323,7 +323,7 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 	return ret;
 }
 
-int packet_length(const char lenbuf_hex[4])
+int packet_length(const char lenbuf_hex[PACKET_HEADER_SIZE])
 {
 	int val = hex2chr(lenbuf_hex);
 	return (val < 0) ? val : (val << 8) | hex2chr(lenbuf_hex + 2);
@@ -335,9 +335,9 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 						int options)
 {
 	int len;
-	char linelen[4];
+	char linelen[PACKET_HEADER_SIZE];
 
-	if (get_packet_data(fd, src_buffer, src_len, linelen, 4, options) < 0) {
+	if (get_packet_data(fd, src_buffer, src_len, linelen, sizeof(linelen), options) < 0) {
 		*pktlen = -1;
 		return PACKET_READ_EOF;
 	}
@@ -358,11 +358,11 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 		packet_trace_str("0002", 0);
 		*pktlen = 0;
 		return PACKET_READ_RESPONSE_END;
-	} else if (len < 4) {
+	} else if (len < PACKET_HEADER_SIZE) {
 		die(_("protocol error: bad line length %d"), len);
 	}
 
-	len -= 4;
+	len -= sizeof(linelen);
 	if ((unsigned)len >= size)
 		die(_("protocol error: bad line length %d"), len);
 
@@ -380,7 +380,7 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 
 	if ((options & PACKET_READ_DIE_ON_ERR_PACKET) &&
 	    starts_with(buffer, "ERR "))
-		die(_("remote error: %s"), buffer + 4);
+		die(_("remote error: %s"), buffer + PACKET_HEADER_SIZE);
 
 	*pktlen = len;
 	return PACKET_READ_NORMAL;
diff --git a/pkt-line.h b/pkt-line.h
index 5b373fe4cd..d6121b8044 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -5,6 +5,8 @@
 #include "strbuf.h"
 #include "sideband.h"
 
+#define PACKET_HEADER_SIZE 4
+
 /*
  * Write a packetized stream, where each line is preceded by
  * its length (including the header) as a 4-byte hex number.
@@ -82,7 +84,7 @@ int packet_read(int fd, char **src_buffer, size_t *src_len, char
  * If lenbuf_hex contains non-hex characters, return -1. Otherwise, return the
  * numeric value of the length header.
  */
-int packet_length(const char lenbuf_hex[4]);
+int packet_length(const char lenbuf_hex[PACKET_HEADER_SIZE]);
 
 /*
  * Read a packetized line into a buffer like the 'packet_read()' function but
@@ -211,7 +213,7 @@ enum packet_read_status packet_reader_peek(struct packet_reader *reader);
 
 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
-#define LARGE_PACKET_DATA_MAX (LARGE_PACKET_MAX - 4)
+#define LARGE_PACKET_DATA_MAX (LARGE_PACKET_MAX - PACKET_HEADER_SIZE)
 extern char packet_buffer[LARGE_PACKET_MAX];
 
 struct packet_writer {
diff --git a/remote-curl.c b/remote-curl.c
index 5536372b34..7ba1280a41 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -536,8 +536,8 @@ struct rpc_state {
 	unsigned initial_buffer : 1;
 
 	/*
-	 * Whenever a pkt-line is read into buf, append the 4 characters
-	 * denoting its length before appending the payload.
+	 * Whenever a pkt-line is read into buf, append the PACKET_HEADER_SIZE
+	 * characters denoting its length before appending the payload.
 	 */
 	unsigned write_line_lengths : 1;
 
@@ -556,8 +556,9 @@ struct rpc_state {
  * rpc->buf and rpc->len if there is enough space. Returns 1 if there was
  * enough space, 0 otherwise.
  *
- * If rpc->write_line_lengths is true, appends the line length as a 4-byte
- * hexadecimal string before appending the result described above.
+ * If rpc->write_line_lengths is true, appends the line length as a
+ * PACKET_HEADER_SIZE-byte hexadecimal string before appending the result
+ * described above.
  *
  * Writes the total number of bytes appended into appended.
  */
@@ -569,8 +570,8 @@ static int rpc_read_from_out(struct rpc_state *rpc, int options,
 	int pktlen_raw;
 
 	if (rpc->write_line_lengths) {
-		left = rpc->alloc - rpc->len - 4;
-		buf = rpc->buf + rpc->len + 4;
+		left = rpc->alloc - rpc->len - PACKET_HEADER_SIZE;
+		buf = rpc->buf + rpc->len + PACKET_HEADER_SIZE;
 	} else {
 		left = rpc->alloc - rpc->len;
 		buf = rpc->buf + rpc->len;
@@ -582,7 +583,7 @@ static int rpc_read_from_out(struct rpc_state *rpc, int options,
 	*status = packet_read_with_status(rpc->out, NULL, NULL, buf,
 			left, &pktlen_raw, options);
 	if (*status != PACKET_READ_EOF) {
-		*appended = pktlen_raw + (rpc->write_line_lengths ? 4 : 0);
+		*appended = pktlen_raw + (rpc->write_line_lengths ? PACKET_HEADER_SIZE : 0);
 		rpc->len += *appended;
 	}
 
@@ -593,7 +594,7 @@ static int rpc_read_from_out(struct rpc_state *rpc, int options,
 				die(_("shouldn't have EOF when not gentle on EOF"));
 			break;
 		case PACKET_READ_NORMAL:
-			set_packet_header(buf - 4, *appended);
+			set_packet_header(buf - PACKET_HEADER_SIZE, *appended);
 			break;
 		case PACKET_READ_DELIM:
 			memcpy(buf - strlen("0001"), "0001", strlen("0001"));
@@ -682,7 +683,7 @@ static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
 #endif
 
 struct check_pktline_state {
-	char len_buf[4];
+	char len_buf[PACKET_HEADER_SIZE];
 	int len_filled;
 	int remaining;
 };
@@ -691,7 +692,7 @@ static void check_pktline(struct check_pktline_state *state, const char *ptr, si
 {
 	while (size) {
 		if (!state->remaining) {
-			int digits_remaining = 4 - state->len_filled;
+			int digits_remaining = sizeof(state->len_buf) - state->len_filled;
 			if (digits_remaining > size)
 				digits_remaining = size;
 			memcpy(&state->len_buf[state->len_filled], ptr, digits_remaining);
@@ -699,16 +700,16 @@ static void check_pktline(struct check_pktline_state *state, const char *ptr, si
 			ptr += digits_remaining;
 			size -= digits_remaining;
 
-			if (state->len_filled == 4) {
+			if (state->len_filled == sizeof(state->len_buf)) {
 				state->remaining = packet_length(state->len_buf);
 				if (state->remaining < 0) {
 					die(_("remote-curl: bad line length character: %.4s"), state->len_buf);
 				} else if (state->remaining == 2) {
 					die(_("remote-curl: unexpected response end packet"));
-				} else if (state->remaining < 4) {
+				} else if (state->remaining < sizeof(state->len_buf)) {
 					state->remaining = 0;
 				} else {
-					state->remaining -= 4;
+					state->remaining -= sizeof(state->len_buf);
 				}
 				state->len_filled = 0;
 			}
@@ -804,7 +805,7 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, "0000");
-	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, 4);
+	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, PACKET_HEADER_SIZE);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buf);
@@ -1469,7 +1470,7 @@ int cmd_main(int argc, const char **argv)
 			parse_fetch(&buf);
 
 		} else if (!strcmp(buf.buf, "list") || starts_with(buf.buf, "list ")) {
-			int for_push = !!strstr(buf.buf + 4, "for-push");
+			int for_push = !!strstr(buf.buf + PACKET_HEADER_SIZE, "for-push");
 			output_refs(get_refs(for_push));
 
 		} else if (starts_with(buf.buf, "push ")) {
-- 
2.27.0.132.g321788e831

