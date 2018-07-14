Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36A991F915
	for <e@80x24.org>; Sat, 14 Jul 2018 21:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbeGNWFa (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 18:05:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38937 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731432AbeGNWFa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jul 2018 18:05:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id h10-v6so28272246wre.6
        for <git@vger.kernel.org>; Sat, 14 Jul 2018 14:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y3uV+0fh0t9OZRHkm5g5zeQO5W2eAME5T6l6xBnniNs=;
        b=vM2z+uGzgVCanwWhcXTIpKfJTHP+zuiCg4dsazLW3lttuk+XMJgbKFhm6GLiTzixo/
         f1oAgXtw2SHnrtf3UBHu4e+oi/T+g6yM10eDz8ol3hCfUzuFoOqTP07kq1J5RKH7Us8r
         VazxXNrfOv7dg1t47zzCGjn3DNU+6bj4CteJ/4tSQRsEDdRo3DF50ZRK7frFnlBgJYzk
         fLbxnZPeLssVE2Ga+S4lvtTEIRNXo3G7RfLRIqhAXo+KAkFnn03KJ1spWpGDXl3/cu6p
         xWh0R5GhRtwmsohLb56mOG5Z1zyhNB4kkElafMLsrg9Wmk/cSIL+6UOjnMJLAUFPRcg0
         ttYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y3uV+0fh0t9OZRHkm5g5zeQO5W2eAME5T6l6xBnniNs=;
        b=RCtvwoeWanKPTmtoHtXpWviOBsmOOAAP1EoIRr+FTOMzplVxLc+x96KEmfyjUQBz08
         QpqWC4cimCqTl2TX8AGk0gTPg1r/N+BxgH0zY89tGgRDIDHu6774fVBeZ1zsMcrCVwui
         fZLo3elsKOLMLT0BhxcHlAiqrsINrDz5zETQRNDk6lp6QOKldGxiRQz+UsUSvFAtXI7g
         CDpyTo3B3VSorKPINhb2IXmfwG9UZV6lN0PwRce/znobb1QONy6ahUjFxEBve71ZaH4m
         lY2MyCL0c/YEmfCyGXTsyLlda1vOIhImZ14tRZ93oxVIymZElH0QAdNfPgUnigamtnOz
         krvA==
X-Gm-Message-State: AOUpUlF7FlAkva4wAD8VxpKmagfYoN7odCsNCIqgxHvcQY+B0YpJGv7a
        FO9JOkGVCEMk8/xk1XUyKIzKFcZs
X-Google-Smtp-Source: AAOMgpeu70ebQSNEA6GKtRJdiZOCGSP4Qm16dcZ3S+MjBJlhD3KQrd+aE4ZmJpKwr1pK2uapBjRDjw==
X-Received: by 2002:adf:e642:: with SMTP id b2-v6mr9044173wrn.254.1531604702803;
        Sat, 14 Jul 2018 14:45:02 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id z3-v6sm25979633wru.27.2018.07.14.14.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Jul 2018 14:45:02 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 09/11] rerere: return strbuf from handle path
Date:   Sat, 14 Jul 2018 22:44:41 +0100
Message-Id: <20180714214443.7184-10-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g65aef3a6c4
In-Reply-To: <20180714214443.7184-1-t.gummerer@gmail.com>
References: <20180605215219.28783-1-t.gummerer@gmail.com>
 <20180714214443.7184-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently we write the conflict to disk directly in the handle_path
function.  To make it re-usable for nested conflicts, instead of
writing the conflict out directly, store it in a strbuf and let the
caller write it out.

This does mean some slight increase in memory usage, however that
increase is limited to the size of the largest conflict we've
currently processed.  We already keep one copy of the conflict in
memory, and it shouldn't be too large, so the increase in memory usage
seems acceptable.

As a bonus this lets us get replace the rerere_io_putconflict function
with a trivial two line function.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 rerere.c | 58 ++++++++++++++++++--------------------------------------
 1 file changed, 18 insertions(+), 40 deletions(-)

diff --git a/rerere.c b/rerere.c
index 2d62251943..a35b88916c 100644
--- a/rerere.c
+++ b/rerere.c
@@ -302,38 +302,6 @@ static void rerere_io_putstr(const char *str, struct rerere_io *io)
 		ferr_puts(str, io->output, &io->wrerror);
 }
 
-/*
- * Write a conflict marker to io->output (if defined).
- */
-static void rerere_io_putconflict(int ch, int size, struct rerere_io *io)
-{
-	char buf[64];
-
-	while (size) {
-		if (size <= sizeof(buf) - 2) {
-			memset(buf, ch, size);
-			buf[size] = '\n';
-			buf[size + 1] = '\0';
-			size = 0;
-		} else {
-			int sz = sizeof(buf) - 1;
-
-			/*
-			 * Make sure we will not write everything out
-			 * in this round by leaving at least 1 byte
-			 * for the next round, giving the next round
-			 * a chance to add the terminating LF.  Yuck.
-			 */
-			if (size <= sz)
-				sz -= (sz - size) + 1;
-			memset(buf, ch, sz);
-			buf[sz] = '\0';
-			size -= sz;
-		}
-		rerere_io_putstr(buf, io);
-	}
-}
-
 static void rerere_io_putmem(const char *mem, size_t sz, struct rerere_io *io)
 {
 	if (io->output)
@@ -384,7 +352,14 @@ static int is_cmarker(char *buf, int marker_char, int marker_size)
 	return isspace(*buf);
 }
 
-static int handle_conflict(struct rerere_io *io, int marker_size, git_SHA_CTX *ctx)
+static void rerere_strbuf_putconflict(struct strbuf *buf, int ch, size_t size)
+{
+	strbuf_addchars(buf, ch, size);
+	strbuf_addch(buf, '\n');
+}
+
+static int handle_conflict(struct strbuf *out, struct rerere_io *io,
+			   int marker_size, git_SHA_CTX *ctx)
 {
 	enum {
 		RR_SIDE_1 = 0, RR_SIDE_2, RR_ORIGINAL
@@ -410,11 +385,11 @@ static int handle_conflict(struct rerere_io *io, int marker_size, git_SHA_CTX *c
 			if (strbuf_cmp(&one, &two) > 0)
 				strbuf_swap(&one, &two);
 			has_conflicts = 1;
-			rerere_io_putconflict('<', marker_size, io);
-			rerere_io_putmem(one.buf, one.len, io);
-			rerere_io_putconflict('=', marker_size, io);
-			rerere_io_putmem(two.buf, two.len, io);
-			rerere_io_putconflict('>', marker_size, io);
+			rerere_strbuf_putconflict(out, '<', marker_size);
+			strbuf_addbuf(out, &one);
+			rerere_strbuf_putconflict(out, '=', marker_size);
+			strbuf_addbuf(out, &two);
+			rerere_strbuf_putconflict(out, '>', marker_size);
 			if (ctx) {
 				git_SHA1_Update(ctx, one.buf ? one.buf : "",
 					    one.len + 1);
@@ -451,21 +426,24 @@ static int handle_conflict(struct rerere_io *io, int marker_size, git_SHA_CTX *c
 static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_size)
 {
 	git_SHA_CTX ctx;
-	struct strbuf buf = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT, out = STRBUF_INIT;
 	int has_conflicts = 0;
 	if (sha1)
 		git_SHA1_Init(&ctx);
 
 	while (!io->getline(&buf, io)) {
 		if (is_cmarker(buf.buf, '<', marker_size)) {
-			has_conflicts = handle_conflict(io, marker_size,
+			has_conflicts = handle_conflict(&out, io, marker_size,
 							sha1 ? &ctx : NULL);
 			if (has_conflicts < 0)
 				break;
+			rerere_io_putmem(out.buf, out.len, io);
+			strbuf_reset(&out);
 		} else
 			rerere_io_putstr(buf.buf, io);
 	}
 	strbuf_release(&buf);
+	strbuf_release(&out);
 
 	if (sha1)
 		git_SHA1_Final(sha1, &ctx);
-- 
2.17.0.410.g65aef3a6c4

