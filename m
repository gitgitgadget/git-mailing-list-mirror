Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C3201F597
	for <e@80x24.org>; Sun,  5 Aug 2018 17:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeHET0P (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 15:26:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34385 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeHET0P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 15:26:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so10143007wrt.1
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 10:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o9ciw62nBlmvT4TjhM5c9pppveP7E4LAxQdE9NZuXbI=;
        b=XjKUUnOwzWTkfR5AGTjij+JlH0c27TU12YAXKfeyOe/Fv4vxTOpAvySSg/uPOvuoF7
         KzLLMrPuz0dkBaG+3t/1aH+K9nGjWKL0chozefkEWJE13jN2FVV23SfqPweE6ytrC+4q
         y0T4OR3wFV2xG3GDjOpzTdyBjnAI3vc0qVQIUGSwceiT73jgxOVpGQE1tj90+yAXv+Vi
         TzCo0zlgX3t/ONrEqpoyjIxGXPWqHKOU2yiYl/BaqMtcpCDidGKsCjcUpMqzzf9VHc8w
         7l+4Fl5EwxQN2Oh6pyFdczym1ci/CB6YXdYEBZ3pXogZdTUdV5TznZBlXMzhfTlmfUkz
         x1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o9ciw62nBlmvT4TjhM5c9pppveP7E4LAxQdE9NZuXbI=;
        b=ulkqtdb86pNRm3uL6I7xsp88n0wSrfvFP2FaEW3CkKh7TWrlGdBTG/wq+4OmbKRDhy
         qotzvKJMvevCZW4X4xSZdfob8skkkQ9vAPY9vHX3avzPflTYXiqZ+pIBqm8QNAuuYldH
         PkbXiRB6ydI0CHKVMAJkcgiwbh+xp6Y93XY8EYTX8v9ZQpyikVA1bLbeN2A6jFE5lOg4
         o2Ao6G/vlZhZDhGEt2FedBTx0IF7W8KbsecwQpVy/pDxzkqoG4PvOmI6LQ2ESSepgJE4
         bFLNEtBDIk1QpWVggvOxXoh7ubs70MMeoSEO0dtP28LqSeRtiHxdbnLYBnGCLtZAz++P
         rlgQ==
X-Gm-Message-State: AOUpUlHyjjaoyCudrs4UqxvtpX/WsfiVNxq+SFA9sfBNYXug9jAIXJZt
        CaDsjaQteZl/5IgyeMRKC64wYC00
X-Google-Smtp-Source: AAOMgpfZKytYFWmpQslxle/doVvT/ODQ8KvGdKiHTKOwo4h/wT6iahtnfyvlRDuQeOqYnMIOJTGCpw==
X-Received: by 2002:adf:e34d:: with SMTP id n13-v6mr7938037wrj.158.1533489657071;
        Sun, 05 Aug 2018 10:20:57 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id y203-v6sm6796750wmd.1.2018.08.05.10.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Aug 2018 10:20:56 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 08/11] rerere: factor out handle_conflict function
Date:   Sun,  5 Aug 2018 18:20:34 +0100
Message-Id: <20180805172037.12530-9-t.gummerer@gmail.com>
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

Factor out the handle_conflict function, which handles a single
conflict in a path.  This is in preparation for a subsequent commit,
where this function will be re-used.

Note that this does change the behaviour of 'git rerere' slightly.
Where previously we'd consider all files where an unmatched conflict
marker is found as invalid, we now only consider files invalid when
the "ours" conflict marker ("<<<<<<< <text>") is unmatched, not when
other conflict markers (e.g. "=======") is unmatched.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 rerere.c | 87 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 47 insertions(+), 40 deletions(-)

diff --git a/rerere.c b/rerere.c
index bf803043e2..2d62251943 100644
--- a/rerere.c
+++ b/rerere.c
@@ -384,85 +384,92 @@ static int is_cmarker(char *buf, int marker_char, int marker_size)
 	return isspace(*buf);
 }
 
-/*
- * Read contents a file with conflicts, normalize the conflicts
- * by (1) discarding the common ancestor version in diff3-style,
- * (2) reordering our side and their side so that whichever sorts
- * alphabetically earlier comes before the other one, while
- * computing the "conflict ID", which is just an SHA-1 hash of
- * one side of the conflict, NUL, the other side of the conflict,
- * and NUL concatenated together.
- *
- * Return 1 if conflict hunks are found, 0 if there are no conflict
- * hunks and -1 if an error occured.
- */
-static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_size)
+static int handle_conflict(struct rerere_io *io, int marker_size, git_SHA_CTX *ctx)
 {
-	git_SHA_CTX ctx;
-	int has_conflicts = 0;
 	enum {
-		RR_CONTEXT = 0, RR_SIDE_1, RR_SIDE_2, RR_ORIGINAL
-	} hunk = RR_CONTEXT;
+		RR_SIDE_1 = 0, RR_SIDE_2, RR_ORIGINAL
+	} hunk = RR_SIDE_1;
 	struct strbuf one = STRBUF_INIT, two = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
-
-	if (sha1)
-		git_SHA1_Init(&ctx);
+	int has_conflicts = -1;
 
 	while (!io->getline(&buf, io)) {
 		if (is_cmarker(buf.buf, '<', marker_size)) {
-			if (hunk != RR_CONTEXT)
-				goto bad;
-			hunk = RR_SIDE_1;
+			break;
 		} else if (is_cmarker(buf.buf, '|', marker_size)) {
 			if (hunk != RR_SIDE_1)
-				goto bad;
+				break;
 			hunk = RR_ORIGINAL;
 		} else if (is_cmarker(buf.buf, '=', marker_size)) {
 			if (hunk != RR_SIDE_1 && hunk != RR_ORIGINAL)
-				goto bad;
+				break;
 			hunk = RR_SIDE_2;
 		} else if (is_cmarker(buf.buf, '>', marker_size)) {
 			if (hunk != RR_SIDE_2)
-				goto bad;
+				break;
 			if (strbuf_cmp(&one, &two) > 0)
 				strbuf_swap(&one, &two);
 			has_conflicts = 1;
-			hunk = RR_CONTEXT;
 			rerere_io_putconflict('<', marker_size, io);
 			rerere_io_putmem(one.buf, one.len, io);
 			rerere_io_putconflict('=', marker_size, io);
 			rerere_io_putmem(two.buf, two.len, io);
 			rerere_io_putconflict('>', marker_size, io);
-			if (sha1) {
-				git_SHA1_Update(&ctx, one.buf ? one.buf : "",
+			if (ctx) {
+				git_SHA1_Update(ctx, one.buf ? one.buf : "",
 					    one.len + 1);
-				git_SHA1_Update(&ctx, two.buf ? two.buf : "",
+				git_SHA1_Update(ctx, two.buf ? two.buf : "",
 					    two.len + 1);
 			}
-			strbuf_reset(&one);
-			strbuf_reset(&two);
+			break;
 		} else if (hunk == RR_SIDE_1)
 			strbuf_addbuf(&one, &buf);
 		else if (hunk == RR_ORIGINAL)
 			; /* discard */
 		else if (hunk == RR_SIDE_2)
 			strbuf_addbuf(&two, &buf);
-		else
-			rerere_io_putstr(buf.buf, io);
-		continue;
-	bad:
-		hunk = 99; /* force error exit */
-		break;
 	}
 	strbuf_release(&one);
 	strbuf_release(&two);
 	strbuf_release(&buf);
 
+	return has_conflicts;
+}
+
+/*
+ * Read contents a file with conflicts, normalize the conflicts
+ * by (1) discarding the common ancestor version in diff3-style,
+ * (2) reordering our side and their side so that whichever sorts
+ * alphabetically earlier comes before the other one, while
+ * computing the "conflict ID", which is just an SHA-1 hash of
+ * one side of the conflict, NUL, the other side of the conflict,
+ * and NUL concatenated together.
+ *
+ * Return 1 if conflict hunks are found, 0 if there are no conflict
+ * hunks and -1 if an error occured.
+ */
+static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_size)
+{
+	git_SHA_CTX ctx;
+	struct strbuf buf = STRBUF_INIT;
+	int has_conflicts = 0;
+	if (sha1)
+		git_SHA1_Init(&ctx);
+
+	while (!io->getline(&buf, io)) {
+		if (is_cmarker(buf.buf, '<', marker_size)) {
+			has_conflicts = handle_conflict(io, marker_size,
+							sha1 ? &ctx : NULL);
+			if (has_conflicts < 0)
+				break;
+		} else
+			rerere_io_putstr(buf.buf, io);
+	}
+	strbuf_release(&buf);
+
 	if (sha1)
 		git_SHA1_Final(sha1, &ctx);
-	if (hunk != RR_CONTEXT)
-		return -1;
+
 	return has_conflicts;
 }
 
-- 
2.18.0.720.gf7a957e2e7

