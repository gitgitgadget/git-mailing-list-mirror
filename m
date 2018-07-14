Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A46B61F915
	for <e@80x24.org>; Sat, 14 Jul 2018 21:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbeGNWF3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 18:05:29 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52785 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731598AbeGNWF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jul 2018 18:05:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so5762158wmh.2
        for <git@vger.kernel.org>; Sat, 14 Jul 2018 14:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uT7t7DSh1YfRdcbRpJ0yOkdTqGfQyKljPX0naxPAgdA=;
        b=Nejf1DcTfcS5F8h92JIdEH4al/Airh4pD3TU6uk3VFI4HchZ46NqTp2MZVJvrTac+v
         RjNWxSL3ZHQSost0Bj8og0f4zvlsgc/yCtEfRu2oGjyBIKyhO8OLag8orKV0X8xvsz/Q
         XDS6fibETnqet4G6e3bpzeAXXKFI1P8GU5VFK/GW5H3Jbxg4BgZMkKfVYquXbGfL8Ab/
         MWcwUc4fevNnaAHzR8Q6binTjaaXF0ZuXrI5M1bHD1VypxOtObODZ7687oZv2TRGWBTe
         doQj6KcdA4Wt4+29bRcBCFpLw/jlCg/Ic48WvFLZBfMMy+r7F1Cb4RHErgImHSPzeeOV
         H9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uT7t7DSh1YfRdcbRpJ0yOkdTqGfQyKljPX0naxPAgdA=;
        b=bvoFekxKlhD+N24NV/NwI1CUYRs9uZZj41iRPe3MugtvXNjBo4K6FDnhrm1KsUP4xH
         IYBpS0c0ePJw1p/iozGPGAx5LKZ3ZoTQzSJu29Bbdfq0TEDbjlIJoG87r4QdnKuFQ66a
         +5JTD4Ojv/v7DTDYSl9atfJll0sCrDOyM3R5THhHUtXTjrAcu1DF1D/xR9F1gwhi+ux0
         Na6yHUXJLZAvpuU/duGufzE1NR/Zs5Umz1nx/P+YWMRfdMsOwF6cn7xXxRXwFydJMVB8
         99Im4ZShhM2s+K4HU/95iN/6k8b30LTQUm8CJalgIIHDBnKS1cr5qIMTvZ2Z0VtINOz8
         wiWQ==
X-Gm-Message-State: AOUpUlE3rnlhfglQPsvUbLp3Zdx0s8TfXaS8MQQ9GPtRnkVGqIfUuYc+
        uuJ0PzwknP2lABdV5OpVqiBPyEXj
X-Google-Smtp-Source: AAOMgpeG72zkkyNbyHavQrw5W85RmFJXRL0aTBoHDwUfa68nvxtWbZ9RIKdvo0W2hSNPSsiDhHFcQA==
X-Received: by 2002:a1c:f906:: with SMTP id x6-v6mr6646090wmh.63.1531604701359;
        Sat, 14 Jul 2018 14:45:01 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id m144-v6sm12157801wma.36.2018.07.14.14.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Jul 2018 14:45:00 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 08/11] rerere: factor out handle_conflict function
Date:   Sat, 14 Jul 2018 22:44:40 +0100
Message-Id: <20180714214443.7184-9-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g65aef3a6c4
In-Reply-To: <20180714214443.7184-1-t.gummerer@gmail.com>
References: <20180605215219.28783-1-t.gummerer@gmail.com>
 <20180714214443.7184-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out the handle_conflict function, which handles a single
conflict in a path.  This is in preparation for a subsequent commit,
where this function will be re-used.  No functional changes intended.

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
2.17.0.410.g65aef3a6c4

