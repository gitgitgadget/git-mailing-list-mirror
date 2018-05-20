Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA5FD1F51C
	for <e@80x24.org>; Sun, 20 May 2018 21:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbeETVMY (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 17:12:24 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42578 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbeETVMR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 17:12:17 -0400
Received: by mail-wr0-f195.google.com with SMTP id t16-v6so10902287wrm.9
        for <git@vger.kernel.org>; Sun, 20 May 2018 14:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qBJ/56gLncOmFetAhvGTShi/pFL6TAMIHklvRhDnghs=;
        b=gRZHHY7lZUnzI0sUTawB+jk/4AmysM25fuUWIesQhmR8RS5h1s7nltW/y01OCutNcz
         aLZDoSbQeMBs1R2r/pFF6BGlfvDp6PVohnAnQN2FfK5isVq8tf/zhRAMwFJgPxi8auhk
         toWckofsE/nnDjNGMrNBXIvLlUlz5Z5IK2ErReStf9kLyHT3lhUL9ke0fq/m/DMZKxKd
         bT3kL21N222mOD/OqRkLzjRwN0S91FZMLPShliu2tj06lcm7sRtq4UHO6flM+FpdRTx1
         QD4FQ0JXsecrhuh2umxGjwVvIH90f9PLNW1HQ+e36Slf5jXw2VXBN28zeEcZO5tiWLtt
         Em3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qBJ/56gLncOmFetAhvGTShi/pFL6TAMIHklvRhDnghs=;
        b=qFRyWC0lrOszRzHY2ZZeqMF5ojMN4s0ykpU5bzMhxYWjP26E8v7ozgj20TtKst9nPZ
         n4tVATWJSy7I3lU/pytvPjdsM8j0AjDV8JSqt9TzEO53tuqkxQpPjnkgRIMCxsQpxET/
         ghJLT2zi99rAIn9/ERnUs393HEKXXZAERRyuSYoK/NykZzTXvb9M6qj2WNZ7ix15IPld
         9nqI9nSmXAjXbAAhFb9jrU1Lq3PQu/07qa2nMKcmwbfCijQfHWdKB9ffBkjthRSTNef0
         ij4dL3Sq4NXC+l4g/K+fcLdNK/JjshZImv8QAvPrPkThS2yxNeGY4qMFaVAA6omysHgK
         g3sA==
X-Gm-Message-State: ALKqPwcAHIef2J9wN7x99Uwhf7Q1XutwQwD5XLxFCn07AfAXGb3hOA7B
        RKyg3HXSVSe2SmDPBVUzmYF5hp+b
X-Google-Smtp-Source: AB8JxZrIPBPZbpVB09uwxX09TcedYK4ozdzpTDMn0b1YVRNhloQYFePLtgQr2bLCv48ZjIqOxHEAWg==
X-Received: by 2002:adf:8407:: with SMTP id 7-v6mr15185431wrf.176.1526850735561;
        Sun, 20 May 2018 14:12:15 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id z10-v6sm16154159wre.43.2018.05.20.14.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 May 2018 14:12:14 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [RFC/PATCH 5/7] rerere: only return whether a path has conflicts or not
Date:   Sun, 20 May 2018 22:12:08 +0100
Message-Id: <20180520211210.1248-6-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.588.g4d217cdf8e.dirty
In-Reply-To: <20180520211210.1248-1-t.gummerer@gmail.com>
References: <20180520211210.1248-1-t.gummerer@gmail.com>
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
index 49ace8e108..f3e658e374 100644
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
 		io.io.wrerror = error_errno(_("Failed to flush %s"), path);
 
-	if (hunk_no < 0) {
+	if (has_conflicts < 0) {
 		if (output)
 			unlink_or_warn(output);
 		return error(_("Could not parse conflict hunks in %s"), path);
 	}
 	if (io.io.wrerror)
 		return -1;
-	return hunk_no;
+	return has_conflicts;
 }
 
 /*
@@ -955,7 +956,7 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 	mmfile_t mmfile[3] = {{NULL}};
 	mmbuffer_t result = {NULL, 0};
 	const struct cache_entry *ce;
-	int pos, len, i, hunk_no;
+	int pos, len, i, has_conflicts;
 	struct rerere_io_mem io;
 	int marker_size = ll_merge_marker_size(path);
 
@@ -1009,11 +1010,11 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
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
2.17.0.588.g4d217cdf8e.dirty

