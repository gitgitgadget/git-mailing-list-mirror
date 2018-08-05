Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A71101F597
	for <e@80x24.org>; Sun,  5 Aug 2018 17:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeHET0S (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 15:26:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50784 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbeHET0R (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 15:26:17 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so11469700wmc.0
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 10:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v0BCJdFI/2LfOt6HWUQbu7Ux2q0Q/tHUxNWkIwvMBSg=;
        b=qMsXIoj05nLkWwARD5LX+28HgZzeyd2K9HEyT7NBiV1AoCHpYPDh+AC14G8TMPkvsv
         WjMm4hqOh0di9nBO9UcHmqi0TYG/pzps2BV/wT53zd/oIkBcVFAY66cJWdxC5xUTB3yw
         7uMJqhelIjQeudLUUCWymjZAIvb6mFqFr8U+e0edp8HPbxNKfKRhNLhoeR6rSNRoB8I9
         1FskZv5lpQm4i8wMXrRRTxwh1ZcULGZoQdMMjOMFs/Ao/uRVMIyZyiB+dkO6NIwIdr0d
         KiXbWtpw6WShu1uB7+AFbKve6mYf5Kl8wZaOdopPWDIZAlbftyJ5riWVYi5BQJX/klX5
         O3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v0BCJdFI/2LfOt6HWUQbu7Ux2q0Q/tHUxNWkIwvMBSg=;
        b=s1yGTqKYSj5KDTPhCf3y3RB2o4vNOijNNi/u1d38k9xD+qzTSHBDCc/ACYWMwGDm/1
         wwRGoCRdno65lwZxG6ykle+Xqs3Q6fePlMOsdDI1vSMsjkWsQSyTvTQd2GiDBXQqzCYC
         IaqIvQVPeom4QOg8JzJU2mnbHTFkUPLvfOo2V35U1O4Bjy5gqR0lkb0iImGjwM/QvQlf
         9h03Y+jwwqzlhwhCYYR/kbKcMtlEE6OwBcvmQMcjPUn9VPhPZeNIG7ZQJlMkNo1vyVsV
         /qtoaMIh5qz3vcZxr5XNbOOI9wElirGnvpMXNRD/PilIQRvBsmpKh8rm/fvw+ifI2q8I
         53iQ==
X-Gm-Message-State: AOUpUlGnTl64WAtb/zDVd/284EF7MDzMMldO7VRNPRdJBBws6cyiTt3q
        nOYPj4pNmG/0qNH6fhuB0GhGLdhH
X-Google-Smtp-Source: AAOMgpfXCJqbwLjK5JCOifD0VY86zciY3ePrtXhfV2iPDOGiGAjgJrpvp/TNXN/MwFjyAl4DRPOQjA==
X-Received: by 2002:a1c:ad4:: with SMTP id 203-v6mr9278360wmk.98.1533489658594;
        Sun, 05 Aug 2018 10:20:58 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id e12-v6sm7619483wrt.29.2018.08.05.10.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Aug 2018 10:20:57 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 09/11] rerere: return strbuf from handle path
Date:   Sun,  5 Aug 2018 18:20:35 +0100
Message-Id: <20180805172037.12530-10-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.18.0.720.gf7a957e2e7
In-Reply-To: <20180805172037.12530-1-t.gummerer@gmail.com>
References: <20180714214443.7184-1-t.gummerer@gmail.com>
 <20180805172037.12530-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.18.0.720.gf7a957e2e7

