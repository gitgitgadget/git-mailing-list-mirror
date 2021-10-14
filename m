Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03107C433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC3DC61108
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhJNURY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 16:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhJNURX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 16:17:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21ADC061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 13:15:17 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id a140-20020a1c7f92000000b0030d8315b593so598891wmd.5
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 13:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nSh7K4H1wm/YVf2afzpqSRKIH26+qVfopKX3h/6bcgo=;
        b=d/dy/pXYZ2u5UOP89SXQ5p0wIGarv1RIANFmf6RojcVPHITqjiweQVDB9dQ51XcFa8
         eIhzrzYG+YwZr5gA0z0MTbgyf2tZKDzJbyf6r0KYMseiiky81GkFS0q9jT1xy8PDHRuA
         WUC/hLY+Y69ozmuWHhc/NiE7mZDGOznUQCLwA2VFgYLOOcq4pA/R/9yuVg6//e2nRScc
         3ntwnbdPlmizIKrMZGplMp1uaMg6wIXrbF+wUDlJXJLQ2BM+JnOEtKlbZt1vVyoMGKe/
         dAR2635pZKjpCYJSzTTbmosnewUsvTdiH+fxQrDa307BT6g3h73ovafOoode+PwyCvUf
         k2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nSh7K4H1wm/YVf2afzpqSRKIH26+qVfopKX3h/6bcgo=;
        b=RJLhg+skJ4ghykCdtXP7CYPPCqT09Eq5zkLgQvUM84jr9rvp9qdw3Y/COUj1ZoIKN+
         tUyp+Afr8+VyIVssDxxiIFoBjJiWr4mW68kD2knZjZGxu+Qj2IByBKv2oqDGx0Ze1wvT
         NdF8DVV545BoXnHSSxph4DPkCzKyLeaiR4hyqfFRvtLUSbRzSgEuH67j06imdIt8my1C
         lGDVambZzQ0nmaZWOKmTS2D+4MV9SSTtUGTLQkDOk8835bIvOTm3mfM3umL1x7gUS+ub
         wUdj6GrzXmAfX+XKfB6O6zBCLqCLA+ZKI0sM1hjrodnu6MCnrAtHBM0UoSOQZ/BKqiuB
         Nuhw==
X-Gm-Message-State: AOAM532hcfsIzZlKr45k4+98Sj6VG0COlYfINIif/OmPfxrIDI6WZIJu
        2stKqElMa8Ycw7fdu/LSoxxHMvjD4ETS2Q==
X-Google-Smtp-Source: ABdhPJyPEWaA8mGmiCGM2LJkA6n4iCwHJiVEP+VnmbEWiUMObqAACylaZCj9NkLmMQLb9ZKlgBE57w==
X-Received: by 2002:a7b:c393:: with SMTP id s19mr8316388wmj.13.1634242516079;
        Thu, 14 Oct 2021 13:15:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b19sm9199265wmb.1.2021.10.14.13.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 13:15:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] pkt-line.[ch]: remove unused packet_read_line_buf()
Date:   Thu, 14 Oct 2021 22:15:12 +0200
Message-Id: <patch-2.2-ef854200f5a-20211014T201317Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-0.2-00000000000-20211014T201317Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211014T201317Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function was added in 4981fe750b1 (pkt-line: share
buffer/descriptor reading implementation, 2013-02-23), but in
01f9ec64c8a (Use packet_reader instead of packet_read_line,
2018-12-29) the code that was using it was removed.

Since it's being removed we can in turn remove the "src" and "src_len"
arguments to packet_read(), all the remaining users just passed a
NULL/NULL pair to it.

That function is only a thin wrapper for packet_read_with_status()
which still needs those arguments, but for the thin packet_read()
convenience wrapper we can do away with it for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/checkout--worker.c |  4 ++--
 daemon.c                   |  2 +-
 parallel-checkout.c        |  3 +--
 pkt-line.c                 | 29 +++++++----------------------
 pkt-line.h                 |  9 +--------
 remote-curl.c              |  2 +-
 6 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index fb9fd13b73c..ede7dc32a43 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -82,8 +82,8 @@ static void worker_loop(struct checkout *state)
 	size_t i, nr = 0, alloc = 0;
 
 	while (1) {
-		int len = packet_read(0, NULL, NULL, packet_buffer,
-				      sizeof(packet_buffer), 0);
+		int len = packet_read(0, packet_buffer, sizeof(packet_buffer),
+				      0);
 
 		if (len < 0)
 			BUG("packet_read() returned negative value");
diff --git a/daemon.c b/daemon.c
index 5c4cbad62d0..3b5f9a41ab2 100644
--- a/daemon.c
+++ b/daemon.c
@@ -770,7 +770,7 @@ static int execute(void)
 
 	set_keep_alive(0);
 	alarm(init_timeout ? init_timeout : timeout);
-	pktlen = packet_read(0, NULL, NULL, packet_buffer, sizeof(packet_buffer), 0);
+	pktlen = packet_read(0, packet_buffer, sizeof(packet_buffer), 0);
 	alarm(0);
 
 	len = strlen(line);
diff --git a/parallel-checkout.c b/parallel-checkout.c
index ddc0ff3c064..ed9c9995207 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -603,8 +603,7 @@ static void gather_results_from_workers(struct pc_worker *workers,
 				continue;
 
 			if (pfd->revents & POLLIN) {
-				int len = packet_read(pfd->fd, NULL, NULL,
-						      packet_buffer,
+				int len = packet_read(pfd->fd, packet_buffer,
 						      sizeof(packet_buffer), 0);
 
 				if (len < 0) {
diff --git a/pkt-line.c b/pkt-line.c
index 11e1adc872b..2dc8ac274bd 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -437,38 +437,28 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 	return PACKET_READ_NORMAL;
 }
 
-int packet_read(int fd, char **src_buffer, size_t *src_len,
-		char *buffer, unsigned size, int options)
+int packet_read(int fd, char *buffer, unsigned size, int options)
 {
 	int pktlen = -1;
 
-	packet_read_with_status(fd, src_buffer, src_len, buffer, size,
-				&pktlen, options);
+	packet_read_with_status(fd, NULL, NULL, buffer, size, &pktlen,
+				options);
 
 	return pktlen;
 }
 
-static char *packet_read_line_generic(int fd,
-				      char **src, size_t *src_len,
-				      int *dst_len)
+char *packet_read_line(int fd, int *dst_len)
 {
-	int len = packet_read(fd, src, src_len,
-			      packet_buffer, sizeof(packet_buffer),
+	int len = packet_read(fd, packet_buffer, sizeof(packet_buffer),
 			      PACKET_READ_CHOMP_NEWLINE);
 	if (dst_len)
 		*dst_len = len;
 	return (len > 0) ? packet_buffer : NULL;
 }
 
-char *packet_read_line(int fd, int *len_p)
-{
-	return packet_read_line_generic(fd, NULL, NULL, len_p);
-}
-
 int packet_read_line_gently(int fd, int *dst_len, char **dst_line)
 {
-	int len = packet_read(fd, NULL, NULL,
-			      packet_buffer, sizeof(packet_buffer),
+	int len = packet_read(fd, packet_buffer, sizeof(packet_buffer),
 			      PACKET_READ_CHOMP_NEWLINE|PACKET_READ_GENTLE_ON_EOF);
 	if (dst_len)
 		*dst_len = len;
@@ -477,11 +467,6 @@ int packet_read_line_gently(int fd, int *dst_len, char **dst_line)
 	return len;
 }
 
-char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
-{
-	return packet_read_line_generic(-1, src, src_len, dst_len);
-}
-
 ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out, int options)
 {
 	int packet_len;
@@ -491,7 +476,7 @@ ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out, int options)
 
 	for (;;) {
 		strbuf_grow(sb_out, LARGE_PACKET_DATA_MAX);
-		packet_len = packet_read(fd_in, NULL, NULL,
+		packet_len = packet_read(fd_in,
 			/* strbuf_grow() above always allocates one extra byte to
 			 * store a '\0' at the end of the string. packet_read()
 			 * writes a '\0' extra byte at the end, too. Let it know
diff --git a/pkt-line.h b/pkt-line.h
index beb589a8593..467ae013573 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -87,8 +87,7 @@ void packet_fflush(FILE *f);
 #define PACKET_READ_CHOMP_NEWLINE        (1u<<1)
 #define PACKET_READ_DIE_ON_ERR_PACKET    (1u<<2)
 #define PACKET_READ_GENTLE_ON_READ_ERROR (1u<<3)
-int packet_read(int fd, char **src_buffer, size_t *src_len, char
-		*buffer, unsigned size, int options);
+int packet_read(int fd, char *buffer, unsigned size, int options);
 
 /*
  * Convert a four hex digit packet line length header into its numeric
@@ -137,12 +136,6 @@ char *packet_read_line(int fd, int *size);
  */
 int packet_read_line_gently(int fd, int *size, char **dst_line);
 
-/*
- * Same as packet_read_line, but read from a buf rather than a descriptor;
- * see packet_read for details on how src_* is used.
- */
-char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
-
 /*
  * Reads a stream of variable sized packets until a flush packet is detected.
  */
diff --git a/remote-curl.c b/remote-curl.c
index 5975103b96a..d69156312bd 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1088,7 +1088,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
 		rpc->protocol_header = NULL;
 
 	while (!err) {
-		int n = packet_read(rpc->out, NULL, NULL, rpc->buf, rpc->alloc, 0);
+		int n = packet_read(rpc->out, rpc->buf, rpc->alloc, 0);
 		if (!n)
 			break;
 		rpc->pos = 0;
-- 
2.33.1.1338.g20da966911a

