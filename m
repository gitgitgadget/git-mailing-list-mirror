Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 700A41F597
	for <e@80x24.org>; Sun,  5 Aug 2018 17:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeHET0N (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 15:26:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44995 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeHET0N (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 15:26:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16-v6so10108907wrt.11
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 10:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r8gXygDHmwDFvhaeD8e/XjghfegNIFhSYbVlWBcf1vU=;
        b=Cr7pFzq9F/9vKXpA6M6VLKUKtwACZ7kq29SJDkZlimeA+4HaJgP9o+l7yCpFujY+C2
         UdREJ7sDvNJJe9Wl1tLyLqyAOpWpIK3Dx50Fy8JHIyf7oz5I4tRHnaTO4rd7WNj/3NVE
         yp2fBb5OG5zERKyW+eQQ9uvo2dxocetwWSxSD/bmTZIdi8hm4NgcvOtOkB4GUiPrHJ2z
         Ro3hucRJPaChM4vcXCvbpUlptfKcasJfJkQGlWCEjo+jPCQgktvp283Cl+D2/buCMpY6
         FePr2zbXnSxbmI6ywKQ8AcKyKs6Y7lUzLJz+qtU0IvBD60eJmuDDQaFoM7ysuWrJmM4o
         iwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r8gXygDHmwDFvhaeD8e/XjghfegNIFhSYbVlWBcf1vU=;
        b=nwb4U8BR21cgFfhylzm00xDFQLyoM7k1/pj1l6Ep3FqfIHHC4/+OGus7gklpqdP15c
         ti/E95o49edZNQA3fcaWfyadaKpR/mPmE0lvNRCHHyhX52rQJHrceW4VzLd9lHijQ5RW
         WYYN5sBZcm+Ef4vwSJNeUPOTDJl5bA75iqLDyjkhdinYsW0MB959tt6Q866qdz0v3nhN
         X4YnwegKHbjBKG520UGMHfx4l85H99i5eleteI/C2L8ZrPumv4oqcnBK4dhBkxD6GxfS
         tGQwW5IxX9bpgu2w6PY80SEylosIV5I/pg7aHl3LVCnX4n/TuLrEtB9guWNUJroX08Bo
         QOlA==
X-Gm-Message-State: AOUpUlH5L5ElmXp+qsRpUw8x14JMicG0we3l3ZAspJez+tTZpWyDkjEC
        fOCnqjSgIs26nJzWAmZJjfnE8isW
X-Google-Smtp-Source: AAOMgpdEpAJnZop4P2ME9cVwLClVkKdTYQdCptgwSmwSzTjFSKuJjceEdHpszLwK5IwA1oUay5ru0Q==
X-Received: by 2002:adf:b2f4:: with SMTP id g107-v6mr7868757wrd.53.1533489655673;
        Sun, 05 Aug 2018 10:20:55 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id n7-v6sm8805064wmc.2.2018.08.05.10.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Aug 2018 10:20:54 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 07/11] rerere: only return whether a path has conflicts or not
Date:   Sun,  5 Aug 2018 18:20:33 +0100
Message-Id: <20180805172037.12530-8-t.gummerer@gmail.com>
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

We currently return the exact number of conflict hunks a certain path
has from the 'handle_paths' function.  However all of its callers only
care whether there are conflicts or not or if there is an error.
Return only that information, and document that only that information
is returned.  This will simplify the code in the subsequent steps.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 rerere.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/rerere.c b/rerere.c
index 895ad80c0c..bf803043e2 100644
--- a/rerere.c
+++ b/rerere.c
@@ -393,12 +393,13 @@ static int is_cmarker(char *buf, int marker_char, int marker_size)
  * one side of the conflict, NUL, the other side of the conflict,
  * and NUL concatenated together.
  *
- * Return the number of conflict hunks found.
+ * Return 1 if conflict hunks are found, 0 if there are no conflict
+ * hunks and -1 if an error occured.
  */
 static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_size)
 {
 	git_SHA_CTX ctx;
-	int hunk_no = 0;
+	int has_conflicts = 0;
 	enum {
 		RR_CONTEXT = 0, RR_SIDE_1, RR_SIDE_2, RR_ORIGINAL
 	} hunk = RR_CONTEXT;
@@ -426,7 +427,7 @@ static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_siz
 				goto bad;
 			if (strbuf_cmp(&one, &two) > 0)
 				strbuf_swap(&one, &two);
-			hunk_no++;
+			has_conflicts = 1;
 			hunk = RR_CONTEXT;
 			rerere_io_putconflict('<', marker_size, io);
 			rerere_io_putmem(one.buf, one.len, io);
@@ -462,7 +463,7 @@ static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_siz
 		git_SHA1_Final(sha1, &ctx);
 	if (hunk != RR_CONTEXT)
 		return -1;
-	return hunk_no;
+	return has_conflicts;
 }
 
 /*
@@ -471,7 +472,7 @@ static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_siz
  */
 static int handle_file(const char *path, unsigned char *sha1, const char *output)
 {
-	int hunk_no = 0;
+	int has_conflicts = 0;
 	struct rerere_io_file io;
 	int marker_size = ll_merge_marker_size(path);
 
@@ -491,7 +492,7 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
 		}
 	}
 
-	hunk_no = handle_path(sha1, (struct rerere_io *)&io, marker_size);
+	has_conflicts = handle_path(sha1, (struct rerere_io *)&io, marker_size);
 
 	fclose(io.input);
 	if (io.io.wrerror)
@@ -500,14 +501,14 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
 	if (io.io.output && fclose(io.io.output))
 		io.io.wrerror = error_errno(_("failed to flush '%s'"), path);
 
-	if (hunk_no < 0) {
+	if (has_conflicts < 0) {
 		if (output)
 			unlink_or_warn(output);
 		return error(_("could not parse conflict hunks in '%s'"), path);
 	}
 	if (io.io.wrerror)
 		return -1;
-	return hunk_no;
+	return has_conflicts;
 }
 
 /*
@@ -954,7 +955,7 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 	mmfile_t mmfile[3] = {{NULL}};
 	mmbuffer_t result = {NULL, 0};
 	const struct cache_entry *ce;
-	int pos, len, i, hunk_no;
+	int pos, len, i, has_conflicts;
 	struct rerere_io_mem io;
 	int marker_size = ll_merge_marker_size(path);
 
@@ -1008,11 +1009,11 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 	 * Grab the conflict ID and optionally write the original
 	 * contents with conflict markers out.
 	 */
-	hunk_no = handle_path(sha1, (struct rerere_io *)&io, marker_size);
+	has_conflicts = handle_path(sha1, (struct rerere_io *)&io, marker_size);
 	strbuf_release(&io.input);
 	if (io.io.output)
 		fclose(io.io.output);
-	return hunk_no;
+	return has_conflicts;
 }
 
 static int rerere_forget_one_path(const char *path, struct string_list *rr)
-- 
2.18.0.720.gf7a957e2e7

