Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAA8A1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 20:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752242AbeFEUsT (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 16:48:19 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:41847 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752559AbeFEUsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 16:48:09 -0400
Received: by mail-wr0-f181.google.com with SMTP id h10-v6so3839651wrq.8
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 13:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y3kPmx/7Uih7O5IgtDZy1TKaW8YfAAqrNXu2aHguCOI=;
        b=cJDziBW6uLGKXbRAgbtTXDfTuLTCPXmD0jrOR7IN4qSIlQT08hKiWhJIgWRwnfPAWO
         zPYJRYtqZLryPZ7moCNRFtegil77P/Qg7Ei9ZBzIi4DAdUBUkfzf6gVjEHFUO4taqjp5
         Y6UFglZ74WQQgIGVfuhYxnQq0NM69FFeV1tKxxWEgG1qKygnKBMQGMLBkw5bBlfx/L4u
         pLV6F/ORlrfQOmcCM1uEWJI3w8lvt03JQJlGVG8BFjyp8ZXpETf0YWbgAdh4N3Pc8Xc1
         H0HnUq0PlHwHb2Kd7gZUm8q1Nw9s4VRoPKA8JNNrdr4gCpfYoSSvRpQuLWplf8k2htD+
         GOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y3kPmx/7Uih7O5IgtDZy1TKaW8YfAAqrNXu2aHguCOI=;
        b=d/9H3qdC/rJh82uNWrgsaBiw0BAiwF35oEvA/mHb3L0E7x4xLTf9yRANimf2XYTmK2
         XSJowjEzb8GhsT1nEnUQS47DFk7JZAf2eHFMQBTNsHd+W3xy7Xu8p5F39wyeKEz6Wt/p
         AhhnF4d4azkoj+jYtSNqaji4QPbrFXLEBb1cwWAR4ELwuInmduNtv8O3LOcR0uOl/9Ea
         zLNKKZJSyw3o8+YbNek37152/TKd0wHZUlnN5HXm+bpGuwlTdcBq4Ocjk4p59k3LXhHn
         rPF4XnozO/LekJGXvqOTm0xK/yF+aXCxnxDQ4oaHH8bg2b0rzaLr3YaEYp5nPM3dkCKT
         DYmA==
X-Gm-Message-State: APt69E3GYMNFggw1t1As2OUJShTTx486BMqtk31zk5IkaMVwqKG2+mms
        B+kxTcVhBnGD6i2cpYZzzZ6jZhVn
X-Google-Smtp-Source: ADUXVKKqX1Dj0OaoS9+Vfg/3CQxMiYeRNkfba5YPhevdKyXfj/2DtuQcoJ4/DMbO/lHv/sSAjuP9Kw==
X-Received: by 2002:adf:b3d4:: with SMTP id x20-v6mr128588wrd.272.1528231687992;
        Tue, 05 Jun 2018 13:48:07 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id f18-v6sm22819864wro.1.2018.06.05.13.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 13:48:07 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 08/10] rerere: factor out handle_conflict function
Date:   Tue,  5 Jun 2018 22:52:17 +0100
Message-Id: <20180605215219.28783-9-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g65aef3a6c4
In-Reply-To: <20180605215219.28783-1-t.gummerer@gmail.com>
References: <20180520211210.1248-1-t.gummerer@gmail.com>
 <20180605215219.28783-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out the handle_conflict function, which handles a single
conflict in a path.  This is a preparation for the next step, where
this function will be re-used.  No functional changes intended.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 rerere.c | 143 +++++++++++++++++++++++++------------------------------
 1 file changed, 65 insertions(+), 78 deletions(-)

diff --git a/rerere.c b/rerere.c
index da3744b86b..fac90663b0 100644
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
@@ -384,37 +352,25 @@ static int is_cmarker(char *buf, int marker_char, int marker_size)
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
+static void rerere_strbuf_putconflict(struct strbuf *buf, int ch, size_t size)
+{
+	strbuf_addchars(buf, ch, size);
+	strbuf_addch(buf, '\n');
+}
+
+static int handle_conflict(struct strbuf *out, struct rerere_io *io,
+			   int marker_size, git_SHA_CTX *ctx)
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
-
+	int has_conflicts = 1;
 	while (!io->getline(&buf, io)) {
-		if (is_cmarker(buf.buf, '<', marker_size)) {
-			if (hunk != RR_CONTEXT)
-				goto bad;
-			hunk = RR_SIDE_1;
-		} else if (is_cmarker(buf.buf, '|', marker_size)) {
+		if (is_cmarker(buf.buf, '<', marker_size))
+			goto bad;
+		else if (is_cmarker(buf.buf, '|', marker_size)) {
 			if (hunk != RR_SIDE_1)
 				goto bad;
 			hunk = RR_ORIGINAL;
@@ -427,42 +383,73 @@ static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_siz
 				goto bad;
 			if (strbuf_cmp(&one, &two) > 0)
 				strbuf_swap(&one, &two);
-			has_conflicts = 1;
-			hunk = RR_CONTEXT;
-			rerere_io_putconflict('<', marker_size, io);
-			rerere_io_putmem(one.buf, one.len, io);
-			rerere_io_putconflict('=', marker_size, io);
-			rerere_io_putmem(two.buf, two.len, io);
-			rerere_io_putconflict('>', marker_size, io);
-			if (sha1) {
-				git_SHA1_Update(&ctx, one.buf ? one.buf : "",
+			rerere_strbuf_putconflict(out, '<', marker_size);
+			strbuf_addbuf(out, &one);
+			rerere_strbuf_putconflict(out, '=', marker_size);
+			strbuf_addbuf(out, &two);
+			rerere_strbuf_putconflict(out, '>', marker_size);
+			if (ctx) {
+				git_SHA1_Update(ctx, one.buf ? one.buf : "",
 					    one.len + 1);
-				git_SHA1_Update(&ctx, two.buf ? two.buf : "",
+				git_SHA1_Update(ctx, two.buf ? two.buf : "",
 					    two.len + 1);
 			}
-			strbuf_reset(&one);
-			strbuf_reset(&two);
+			goto out;
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
+bad:
+	has_conflicts = -1;
+out:
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
+	struct strbuf out = STRBUF_INIT;
+	int has_conflicts = 0;
+	if (sha1)
+		git_SHA1_Init(&ctx);
+
+	while (!io->getline(&buf, io)) {
+		if (is_cmarker(buf.buf, '<', marker_size)) {
+			has_conflicts = handle_conflict(&out, io, marker_size,
+							    sha1 ? &ctx : NULL);
+			if (has_conflicts < 0)
+				break;
+			rerere_io_putmem(out.buf, out.len, io);
+			strbuf_reset(&out);
+		} else
+			rerere_io_putstr(buf.buf, io);
+	}
+	strbuf_release(&buf);
+	strbuf_release(&out);
+
 	if (sha1)
 		git_SHA1_Final(sha1, &ctx);
-	if (hunk != RR_CONTEXT)
-		return -1;
+
 	return has_conflicts;
 }
 
-- 
2.17.0.410.g65aef3a6c4

