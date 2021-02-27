Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDDBC433DB
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 00:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C74464E33
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 00:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhB0AcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 19:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhB0AcL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 19:32:11 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB41FC06178A
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 16:30:54 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id f12so6407101wrx.8
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 16:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wDEIi81r3GcUklVi7oBFLu8jyHzro2dKTvTKyeHL9m4=;
        b=q/AL8EaZljL5IXAQWsIe/uR6RA2F0Gbv+yMBEbuWINriNgZD5PkBIhrF0PdjpmLZq3
         Uv0qe92qOZFBCAl+h9DjDLIBa9kP9IkuQXOgM2azF/4R4v2qGVvctNB/CWcH1iRAjtoB
         hpQoF7hTBaOjTLEaMcwtWTKjxhUMhW9Ia15OlovhPCD1eBk7d+6ChxaodSlwHi7KVusq
         8dysIWPJTfxhpdXhDRdJBtR1+M67VJncHWrBylZrQ7QpALqzO9ko2F5FmCxGLc4l67oT
         PprYnT04+WZAWveRa0IlxgXj74b7nqrUb2fIA20TZT+i1j2ZrryGtQeCQqSa3JS7I1+4
         mMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wDEIi81r3GcUklVi7oBFLu8jyHzro2dKTvTKyeHL9m4=;
        b=ksR2dlHVZ8zMNZ664jvbqCVmr1NyU9M+MOK5Kl5/UZUa6h6kEnmrmCQaqFKRnwqErE
         ZzIEsZareTQQAqJX1DWOkA6iPNyAEhVejwPXihlkR5YER1oM0GvKOrjod3Fq7qTXkEzL
         Ov8QK6sc26gxkpSvYZpqeWbV/Q89j3CML7HPH5Q0fuHYcPAhx+4c8AE321jL+oyMrOU5
         nnDcH6OjletSRI7OfVaidZigi5v9HRLYienyjwN/M4w8IeqXvIUnJhJeAY1OtvOyi5t5
         3VpQlD9OVt7FKjymjsSNyQGjGLkvaDND2sxndwmmUygX+LqJdtsxdyo9Bl4Ceg+iiGCN
         Lslg==
X-Gm-Message-State: AOAM5331c2aA3oDifplXcnxGpkBF/C6Cgh8qnuaWu5WMv0qx4mU5/j77
        6aA0OK4w9Xb+5+HVO4TZnsfH4IE+efo=
X-Google-Smtp-Source: ABdhPJzZ7jfL2+1Efh7MWPtIDhrSNq9rVminBC+S/3tYWBvw0bptH7XeUf5jJ3JNbS5OwDQ+47mViA==
X-Received: by 2002:adf:f44b:: with SMTP id f11mr1778460wrp.345.1614385853461;
        Fri, 26 Feb 2021 16:30:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13sm18014496wro.15.2021.02.26.16.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 16:30:53 -0800 (PST)
Message-Id: <3617b0209cc44b01a75f42ca57341fedc64ca8fd.1614385849.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v4.git.1614385849.gitgitgadget@gmail.com>
References: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
        <pull.844.v4.git.1614385849.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Feb 2021 00:30:42 +0000
Subject: [PATCH v4 04/10] Move computation of dir_rename_count from merge-ort
 to diffcore-rename
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Move the computation of dir_rename_count from merge-ort.c to
diffcore-rename.c, making slight adjustments to the data structures
based on the move.  While the diffstat looks large, viewing this commit
with --color-moved makes it clear that only about 20 lines changed.

With this patch, the computation of dir_rename_count is still only done
after inexact rename detection, but subsequent commits will add a
preliminary computation of dir_rename_count after exact rename
detection, followed by some updates after inexact rename detection.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 138 +++++++++++++++++++++++++++++++++++++++++++++-
 diffcore.h        |   5 ++
 merge-ort.c       | 132 +-------------------------------------------
 3 files changed, 145 insertions(+), 130 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 8eeb8c73664c..39e23d57e7bc 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -380,6 +380,129 @@ static char *get_dirname(const char *filename)
 	return slash ? xstrndup(filename, slash - filename) : xstrdup("");
 }
 
+static void dirname_munge(char *filename)
+{
+	char *slash = strrchr(filename, '/');
+	if (!slash)
+		slash = filename;
+	*slash = '\0';
+}
+
+static void increment_count(struct strmap *dir_rename_count,
+			    char *old_dir,
+			    char *new_dir)
+{
+	struct strintmap *counts;
+	struct strmap_entry *e;
+
+	/* Get the {new_dirs -> counts} mapping using old_dir */
+	e = strmap_get_entry(dir_rename_count, old_dir);
+	if (e) {
+		counts = e->value;
+	} else {
+		counts = xmalloc(sizeof(*counts));
+		strintmap_init_with_options(counts, 0, NULL, 1);
+		strmap_put(dir_rename_count, old_dir, counts);
+	}
+
+	/* Increment the count for new_dir */
+	strintmap_incr(counts, new_dir, 1);
+}
+
+static void update_dir_rename_counts(struct strmap *dir_rename_count,
+				     struct strset *dirs_removed,
+				     const char *oldname,
+				     const char *newname)
+{
+	char *old_dir = xstrdup(oldname);
+	char *new_dir = xstrdup(newname);
+	char new_dir_first_char = new_dir[0];
+	int first_time_in_loop = 1;
+
+	while (1) {
+		dirname_munge(old_dir);
+		dirname_munge(new_dir);
+
+		/*
+		 * When renaming
+		 *   "a/b/c/d/e/foo.c" -> "a/b/some/thing/else/e/foo.c"
+		 * then this suggests that both
+		 *   a/b/c/d/e/ => a/b/some/thing/else/e/
+		 *   a/b/c/d/   => a/b/some/thing/else/
+		 * so we want to increment counters for both.  We do NOT,
+		 * however, also want to suggest that there was the following
+		 * rename:
+		 *   a/b/c/ => a/b/some/thing/
+		 * so we need to quit at that point.
+		 *
+		 * Note the when first_time_in_loop, we only strip off the
+		 * basename, and we don't care if that's different.
+		 */
+		if (!first_time_in_loop) {
+			char *old_sub_dir = strchr(old_dir, '\0')+1;
+			char *new_sub_dir = strchr(new_dir, '\0')+1;
+			if (!*new_dir) {
+				/*
+				 * Special case when renaming to root directory,
+				 * i.e. when new_dir == "".  In this case, we had
+				 * something like
+				 *    a/b/subdir => subdir
+				 * and so dirname_munge() sets things up so that
+				 *    old_dir = "a/b\0subdir\0"
+				 *    new_dir = "\0ubdir\0"
+				 * We didn't have a '/' to overwrite a '\0' onto
+				 * in new_dir, so we have to compare differently.
+				 */
+				if (new_dir_first_char != old_sub_dir[0] ||
+				    strcmp(old_sub_dir+1, new_sub_dir))
+					break;
+			} else {
+				if (strcmp(old_sub_dir, new_sub_dir))
+					break;
+			}
+		}
+
+		if (strset_contains(dirs_removed, old_dir))
+			increment_count(dir_rename_count, old_dir, new_dir);
+		else
+			break;
+
+		/* If we hit toplevel directory ("") for old or new dir, quit */
+		if (!*old_dir || !*new_dir)
+			break;
+
+		first_time_in_loop = 0;
+	}
+
+	/* Free resources we don't need anymore */
+	free(old_dir);
+	free(new_dir);
+}
+
+static void compute_dir_rename_counts(struct strmap *dir_rename_count,
+				      struct strset *dirs_removed)
+{
+	int i;
+
+	/* Set up dir_rename_count */
+	for (i = 0; i < rename_dst_nr; ++i) {
+		/* File not part of directory rename counts if not a rename */
+		if (!rename_dst[i].is_rename)
+			continue;
+
+		/*
+		 * Make dir_rename_count contain a map of a map:
+		 *   old_directory -> {new_directory -> count}
+		 * In other words, for every pair look at the directories for
+		 * the old filename and the new filename and count how many
+		 * times that pairing occurs.
+		 */
+		update_dir_rename_counts(dir_rename_count, dirs_removed,
+					 rename_dst[i].p->one->path,
+					 rename_dst[i].p->two->path);
+	}
+}
+
 static void initialize_dir_rename_info(struct dir_rename_info *info)
 {
 	int i;
@@ -790,7 +913,9 @@ static void remove_unneeded_paths_from_src(int detecting_copies)
 	rename_src_nr = new_num_src;
 }
 
-void diffcore_rename(struct diff_options *options)
+void diffcore_rename_extended(struct diff_options *options,
+			      struct strset *dirs_removed,
+			      struct strmap *dir_rename_count)
 {
 	int detect_rename = options->detect_rename;
 	int minimum_score = options->rename_score;
@@ -805,6 +930,7 @@ void diffcore_rename(struct diff_options *options)
 
 	trace2_region_enter("diff", "setup", options->repo);
 	info.setup = 0;
+	assert(!dir_rename_count || strmap_empty(dir_rename_count));
 	want_copies = (detect_rename == DIFF_DETECT_COPY);
 	if (!minimum_score)
 		minimum_score = DEFAULT_RENAME_SCORE;
@@ -999,6 +1125,11 @@ void diffcore_rename(struct diff_options *options)
 	trace2_region_leave("diff", "inexact renames", options->repo);
 
  cleanup:
+	/*
+	 * Now that renames have been computed, compute dir_rename_count */
+	if (dirs_removed && dir_rename_count)
+		compute_dir_rename_counts(dir_rename_count, dirs_removed);
+
 	/* At this point, we have found some renames and copies and they
 	 * are recorded in rename_dst.  The original list is still in *q.
 	 */
@@ -1082,3 +1213,8 @@ void diffcore_rename(struct diff_options *options)
 	trace2_region_leave("diff", "write back to queue", options->repo);
 	return;
 }
+
+void diffcore_rename(struct diff_options *options)
+{
+	diffcore_rename_extended(options, NULL, NULL);
+}
diff --git a/diffcore.h b/diffcore.h
index d2a63c5c71f4..db55d3853071 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -8,6 +8,8 @@
 
 struct diff_options;
 struct repository;
+struct strmap;
+struct strset;
 struct userdiff_driver;
 
 /* This header file is internal between diff.c and its diff transformers
@@ -161,6 +163,9 @@ void diff_q(struct diff_queue_struct *, struct diff_filepair *);
 
 void diffcore_break(struct repository *, int);
 void diffcore_rename(struct diff_options *);
+void diffcore_rename_extended(struct diff_options *options,
+			      struct strset *dirs_removed,
+			      struct strmap *dir_rename_count);
 void diffcore_merge_broken(void);
 void diffcore_pickaxe(struct diff_options *);
 void diffcore_order(const char *orderfile);
diff --git a/merge-ort.c b/merge-ort.c
index 603d30c52170..c4467e073b45 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1302,131 +1302,6 @@ static char *handle_path_level_conflicts(struct merge_options *opt,
 	return new_path;
 }
 
-static void dirname_munge(char *filename)
-{
-	char *slash = strrchr(filename, '/');
-	if (!slash)
-		slash = filename;
-	*slash = '\0';
-}
-
-static void increment_count(struct strmap *dir_rename_count,
-			    char *old_dir,
-			    char *new_dir)
-{
-	struct strintmap *counts;
-	struct strmap_entry *e;
-
-	/* Get the {new_dirs -> counts} mapping using old_dir */
-	e = strmap_get_entry(dir_rename_count, old_dir);
-	if (e) {
-		counts = e->value;
-	} else {
-		counts = xmalloc(sizeof(*counts));
-		strintmap_init_with_options(counts, 0, NULL, 1);
-		strmap_put(dir_rename_count, old_dir, counts);
-	}
-
-	/* Increment the count for new_dir */
-	strintmap_incr(counts, new_dir, 1);
-}
-
-static void update_dir_rename_counts(struct strmap *dir_rename_count,
-				     struct strset *dirs_removed,
-				     const char *oldname,
-				     const char *newname)
-{
-	char *old_dir = xstrdup(oldname);
-	char *new_dir = xstrdup(newname);
-	char new_dir_first_char = new_dir[0];
-	int first_time_in_loop = 1;
-
-	while (1) {
-		dirname_munge(old_dir);
-		dirname_munge(new_dir);
-
-		/*
-		 * When renaming
-		 *   "a/b/c/d/e/foo.c" -> "a/b/some/thing/else/e/foo.c"
-		 * then this suggests that both
-		 *   a/b/c/d/e/ => a/b/some/thing/else/e/
-		 *   a/b/c/d/   => a/b/some/thing/else/
-		 * so we want to increment counters for both.  We do NOT,
-		 * however, also want to suggest that there was the following
-		 * rename:
-		 *   a/b/c/ => a/b/some/thing/
-		 * so we need to quit at that point.
-		 *
-		 * Note the when first_time_in_loop, we only strip off the
-		 * basename, and we don't care if that's different.
-		 */
-		if (!first_time_in_loop) {
-			char *old_sub_dir = strchr(old_dir, '\0')+1;
-			char *new_sub_dir = strchr(new_dir, '\0')+1;
-			if (!*new_dir) {
-				/*
-				 * Special case when renaming to root directory,
-				 * i.e. when new_dir == "".  In this case, we had
-				 * something like
-				 *    a/b/subdir => subdir
-				 * and so dirname_munge() sets things up so that
-				 *    old_dir = "a/b\0subdir\0"
-				 *    new_dir = "\0ubdir\0"
-				 * We didn't have a '/' to overwrite a '\0' onto
-				 * in new_dir, so we have to compare differently.
-				 */
-				if (new_dir_first_char != old_sub_dir[0] ||
-				    strcmp(old_sub_dir+1, new_sub_dir))
-					break;
-			} else {
-				if (strcmp(old_sub_dir, new_sub_dir))
-					break;
-			}
-		}
-
-		if (strset_contains(dirs_removed, old_dir))
-			increment_count(dir_rename_count, old_dir, new_dir);
-		else
-			break;
-
-		/* If we hit toplevel directory ("") for old or new dir, quit */
-		if (!*old_dir || !*new_dir)
-			break;
-
-		first_time_in_loop = 0;
-	}
-
-	/* Free resources we don't need anymore */
-	free(old_dir);
-	free(new_dir);
-}
-
-static void compute_rename_counts(struct diff_queue_struct *pairs,
-				  struct strmap *dir_rename_count,
-				  struct strset *dirs_removed)
-{
-	int i;
-
-	for (i = 0; i < pairs->nr; ++i) {
-		struct diff_filepair *pair = pairs->queue[i];
-
-		/* File not part of directory rename if it wasn't renamed */
-		if (pair->status != 'R')
-			continue;
-
-		/*
-		 * Make dir_rename_count contain a map of a map:
-		 *   old_directory -> {new_directory -> count}
-		 * In other words, for every pair look at the directories for
-		 * the old filename and the new filename and count how many
-		 * times that pairing occurs.
-		 */
-		update_dir_rename_counts(dir_rename_count, dirs_removed,
-					 pair->one->path,
-					 pair->two->path);
-	}
-}
-
 static void get_provisional_directory_renames(struct merge_options *opt,
 					      unsigned side,
 					      int *clean)
@@ -1435,9 +1310,6 @@ static void get_provisional_directory_renames(struct merge_options *opt,
 	struct strmap_entry *entry;
 	struct rename_info *renames = &opt->priv->renames;
 
-	compute_rename_counts(&renames->pairs[side],
-			      &renames->dir_rename_count[side],
-			      &renames->dirs_removed[side]);
 	/*
 	 * Collapse
 	 *    dir_rename_count: old_directory -> {new_directory -> count}
@@ -2162,7 +2034,9 @@ static void detect_regular_renames(struct merge_options *opt,
 
 	diff_queued_diff = renames->pairs[side_index];
 	trace2_region_enter("diff", "diffcore_rename", opt->repo);
-	diffcore_rename(&diff_opts);
+	diffcore_rename_extended(&diff_opts,
+				 &renames->dirs_removed[side_index],
+				 &renames->dir_rename_count[side_index]);
 	trace2_region_leave("diff", "diffcore_rename", opt->repo);
 	resolve_diffpair_statuses(&diff_queued_diff);
 
-- 
gitgitgadget

