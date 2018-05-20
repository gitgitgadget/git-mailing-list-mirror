Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 325691F51C
	for <e@80x24.org>; Sun, 20 May 2018 21:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbeETVM0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 17:12:26 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:53820 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbeETVMT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 17:12:19 -0400
Received: by mail-wm0-f43.google.com with SMTP id a67-v6so21967930wmf.3
        for <git@vger.kernel.org>; Sun, 20 May 2018 14:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QuOdZ7g7ypCs7Db/Mebnass3J6A/+6POp4hbn3GjDf8=;
        b=uONchKwUsjFnQrJ4DD4+oRLQkV3LFpehjUCoQ+fPlB9BE2c2/jE3KRDvaZt550Vhzy
         UFZSvBdoLeRzMAItEf+xPaabSS/FIV4H6Zy+W0tXLPkLzpCzz+bvGsCOJ0lmU9dRR+jO
         3Boh7c7LPcrJ/oT7Ds23H1HoHTWqxgg9F0B+7tp7VDUPBDy48sHpvADObiXCsucrPJ9P
         96Hah7XASHtCi9LWzlznL7wixBM5AsSz4lKFqHcchGAPgNnDlvtTiyDFGMwhw+9MOIUH
         65uCC2vlM1NHsLgD2SpTZGdicJM1ebaxkz5axUtlp0u8f4+q0I4pi5Zo9NGgS/u2tX+S
         NJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QuOdZ7g7ypCs7Db/Mebnass3J6A/+6POp4hbn3GjDf8=;
        b=swsmWI3zFBiSOfjNjy5DMF2+WVksYWP+wX3OHZK5lAd7LDeO7VOqRaJaEwyTuC83An
         Hd40n12gN6Dxi+SwBpECrfNECh7RTi8uOTEUwC6YXgAKbOGGTVWOoJpMpcwUpRa/9S88
         aCGxg2Y5qkClQwyIogv0kXps0pvvSZVgQUPStTIx7U+PpGJphkJPKGnsMkvT7mrNaFHk
         RWb0Qxf9g/VZzkBGHrQVvyG2OkNhrj0yKX8VfiKWnWXbR0fvwrI/j78eNWtVzyOZKrxp
         eevYDSvyt7E1Ja3J+qeM7A3VaTJ3XyUTtB6nEizsUFZWmNWFLwyJ0ohVIjFFOyaFaP7y
         Th1w==
X-Gm-Message-State: ALKqPwfO1IzROGYpqTX04l8LycoU1x1TSwu1KTbf7D5nkqhwuVEtIllp
        yL26opfLleo1Zq3EV9ZrpjinRvEH
X-Google-Smtp-Source: AB8JxZoVRkHN6xTLKNUzV6BVrZyubSwUbfM/9meusbKFOKkzCwiKkTn5k3C0bkdw43lmQDpv6czVnw==
X-Received: by 2002:a1c:b78a:: with SMTP id h132-v6mr8364380wmf.21.1526850737143;
        Sun, 20 May 2018 14:12:17 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id v196-v6sm9811564wmf.36.2018.05.20.14.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 May 2018 14:12:16 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [RFC/PATCH 6/7] rerere: factor out handle_conflict function
Date:   Sun, 20 May 2018 22:12:09 +0100
Message-Id: <20180520211210.1248-7-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.588.g4d217cdf8e.dirty
In-Reply-To: <20180520211210.1248-1-t.gummerer@gmail.com>
References: <20180520211210.1248-1-t.gummerer@gmail.com>
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
index f3e658e374..f3cfd1c09b 100644
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
2.17.0.588.g4d217cdf8e.dirty

