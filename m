Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C04C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 07:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7CC7206A5
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 07:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5Qy4dOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgD1HpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgD1HpF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 03:45:05 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A93EC03C1A9
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 00:45:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i10so23408611wrv.10
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 00:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eymd3qdYi9dGBrd6n4eWm4brMHJgWBCmeBcwt9l0sok=;
        b=R5Qy4dOR0xxwh5RcH45JUBUasF2tj3ewqDNK8+0cu0uydCc8FOdo08+TPQyLJbHeGY
         CB4jPsAvjnOWuR/gmPcU2Jw9LqBXTLEh+ideEOaaWdUFPMN1CAXVYNk2aw63uCtrufsP
         vovWZAmUoiX2Yww/Z54AOh6+DoQ4uFiCTb5XrQX5nJgQ/BI9uhxE21EK99pLzoIrbPWB
         6xGKmazYBPzTxjqs6L1fxZX01t4wuvd/FLWwza98E49y/NFhmDG+ISfPq6bV0PE8Z9Ih
         6Jrvz7XE1CXiOvBq0kcBsqgB17DxiA+vzTp7ZgOPpuXLC5VUC1yny+2RsdFPBGT4wVS5
         K9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eymd3qdYi9dGBrd6n4eWm4brMHJgWBCmeBcwt9l0sok=;
        b=XMtswbLmbyj+8ZUriROnpn5A2BeDEY01nfOXmjKi/c9FA9mP/lRfmAYeb8mjioqaQ9
         YVAyryyl9ZxFdam2OgwFAC8ZZ5tc2gzbeS9BDqj63JdM+iuz+yhsjvveiiyiAc3ja4lg
         kW5/gUwdd6lQ4lIwlrfTjawFnUtDZE61qF14zyCcvPIZ6RMLlQ6gw+LBGSop7fk9o8l4
         VpfEh/JX51fVOSjNzXnzxorLNlPUsiSHSGMjFNeffsPKRo8n7x4SZ9xbhIj/GIJ90Zft
         3Su6CUU+jT9gu2FdCYO2p+QzUz4dfp5UAhMAkaEwk/BPZF8MhuW6VmF+Lk+g0RFrGEmK
         aX+Q==
X-Gm-Message-State: AGi0PuZ0YZfsLYvfgjZh5fCxjrXyHERwg4NqsZC0thgs/z5w6zKGKCYr
        FC7sV5ICZnjmgtOVh8dXBqLSYjOafUc=
X-Google-Smtp-Source: APiQypJXEYCqrkrRG2P/YRYA8cRlGhMic+oY3Plt10TqytmxysroGLT5q5v7zxXWXOKS/2hl4FqTJA==
X-Received: by 2002:adf:a345:: with SMTP id d5mr30222806wrb.23.1588059901860;
        Tue, 28 Apr 2020 00:45:01 -0700 (PDT)
Received: from localhost.localdomain ([193.56.245.77])
        by smtp.gmail.com with ESMTPSA id h2sm2227626wmf.34.2020.04.28.00.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 00:45:01 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2] fetch-pack: try harder to read an ERR packet
Date:   Tue, 28 Apr 2020 09:44:42 +0200
Message-Id: <20200428074442.29830-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.26.2.267.g8b5eb5fb58.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: SZEDER Gábor <szeder.dev@gmail.com>

When the server has hung up after sending an ERR packet to the
client, the client might still be writing, for example a "done"
line. Therefore the client might get a write error before reading
the ERR packet.

When fetching, this could result in the client displaying a
"Broken pipe" error, instead of the more useful error sent by
the server in the ERR packet.

Instead of using write_in_full() which immediately returns an
error when the server has hung up, let's use a new
write_in_full_read_err() function which will read all the
packets left before returning an error.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h      | 10 +++++++++-
 fetch-pack.c | 13 +++++++------
 wrapper.c    |  7 +++++--
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index 0f0485ecfe..efeee637b8 100644
--- a/cache.h
+++ b/cache.h
@@ -1808,10 +1808,18 @@ int copy_file_with_time(const char *dst, const char *src, int mode);
 void write_or_die(int fd, const void *buf, size_t count);
 void fsync_or_die(int fd, const char *);
 
+struct packet_reader;
+
 ssize_t read_in_full(int fd, void *buf, size_t count);
-ssize_t write_in_full(int fd, const void *buf, size_t count);
+ssize_t write_in_full_read_err(int fd, const void *buf, size_t count,
+			       struct packet_reader *reader);
 ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
 
+static inline ssize_t write_in_full(int fd, const void *buf, size_t count)
+{
+	return write_in_full_read_err(fd, buf, count, NULL);
+}
+
 static inline ssize_t write_str_in_full(int fd, const char *str)
 {
 	return write_in_full(fd, str, strlen(str));
diff --git a/fetch-pack.c b/fetch-pack.c
index 0b07b3ee73..febdf54bf4 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -185,13 +185,14 @@ static enum ack_type get_ack(struct packet_reader *reader,
 }
 
 static void send_request(struct fetch_pack_args *args,
-			 int fd, struct strbuf *buf)
+			 int fd, struct strbuf *buf,
+			 struct packet_reader *reader)
 {
 	if (args->stateless_rpc) {
 		send_sideband(fd, -1, buf->buf, buf->len, LARGE_PACKET_MAX);
 		packet_flush(fd);
 	} else {
-		if (write_in_full(fd, buf->buf, buf->len) < 0)
+		if (write_in_full_read_err(fd, buf->buf, buf->len, reader) < 0)
 			die_errno(_("unable to write to remote"));
 	}
 }
@@ -349,7 +350,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 		const char *arg;
 		struct object_id oid;
 
-		send_request(args, fd[1], &req_buf);
+		send_request(args, fd[1], &req_buf, &reader);
 		while (packet_reader_read(&reader) == PACKET_READ_NORMAL) {
 			if (skip_prefix(reader.line, "shallow ", &arg)) {
 				if (get_oid_hex(arg, &oid))
@@ -372,7 +373,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 			die(_("expected shallow/unshallow, got %s"), reader.line);
 		}
 	} else if (!args->stateless_rpc)
-		send_request(args, fd[1], &req_buf);
+		send_request(args, fd[1], &req_buf, &reader);
 
 	if (!args->stateless_rpc) {
 		/* If we aren't using the stateless-rpc interface
@@ -395,7 +396,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 			int ack;
 
 			packet_buf_flush(&req_buf);
-			send_request(args, fd[1], &req_buf);
+			send_request(args, fd[1], &req_buf, &reader);
 			strbuf_setlen(&req_buf, state_len);
 			flushes++;
 			flush_at = next_flush(args->stateless_rpc, count);
@@ -470,7 +471,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 	trace2_region_leave("fetch-pack", "negotiation_v0_v1", the_repository);
 	if (!got_ready || !no_done) {
 		packet_buf_write(&req_buf, "done\n");
-		send_request(args, fd[1], &req_buf);
+		send_request(args, fd[1], &req_buf, &reader);
 	}
 	print_verbose(args, _("done"));
 	if (retval != 0) {
diff --git a/wrapper.c b/wrapper.c
index 3a1c0e0526..2da7a15382 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "config.h"
+#include "pkt-line.h"
 
 static int memory_limit_check(size_t size, int gentle)
 {
@@ -291,7 +292,8 @@ ssize_t read_in_full(int fd, void *buf, size_t count)
 	return total;
 }
 
-ssize_t write_in_full(int fd, const void *buf, size_t count)
+ssize_t write_in_full_read_err(int fd, const void *buf, size_t count,
+			       struct packet_reader *reader)
 {
 	const char *p = buf;
 	ssize_t total = 0;
@@ -300,7 +302,8 @@ ssize_t write_in_full(int fd, const void *buf, size_t count)
 		ssize_t written = xwrite(fd, p, count);
 		if (written < 0)
 			return -1;
-		if (!written) {
+		if (!written &&
+		    (!reader || packet_reader_read(reader) == PACKET_READ_EOF)) {
 			errno = ENOSPC;
 			return -1;
 		}
-- 
2.26.2.267.g8b5eb5fb58.dirty

