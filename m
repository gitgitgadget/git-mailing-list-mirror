Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC8EC433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 01:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF3364EF5
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 01:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBZB7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 20:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhBZB7H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 20:59:07 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BCBC061788
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 17:58:26 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o16so6443134wmh.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 17:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=27QwbnfyU7xRAkJdwTNBJy+nkzCZE4EF0LFhVYzSZbs=;
        b=UoysllefD7ROQJaeyfS0x6Bpg5C80Q1miKy3JNphdqQxw4GglMh57d0sN97z9gkY4T
         n+QyZen7hcU+PxKXhnMAKTYTWruYKtJe3pYHeB8AAJXZsSpNA+4xhh44xuxZNFVy31eb
         TzezE4IlHR3I+OAg6gkAXmB1K4JU/19jcOy4FcBirKU7zGBm/82OdC2lCbM7YsDsptEd
         KpULJdcfpGJ+S4kty5dR0Q4iKwEKiNS2QYV/zvUIPObuHiqytfKluBLD/v/u9QK4534m
         oU2M56VL43X/b9LqtzRAX7o73JfOVN+Hs9Zpy8NIx2I9cnwYQrQbdJKSZSO2O0eLC4hP
         BIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=27QwbnfyU7xRAkJdwTNBJy+nkzCZE4EF0LFhVYzSZbs=;
        b=Il4UyTBikqxiQCae5qFecByH+4TohKolT02SIXWZ0SZGBqntfeTGsNJt0ZND4mmPeb
         QGTIFALBNSvK2ZE90KrPC+r17NzL34EvrrnIVw80a3N7z0/xcmRYK8+khyybac/xPeRy
         jeV87rkExJsKaaeGYdi2oBsZdQtpVmExEr8R6jTF0SfAr18fJTmZ7YYJejC2acb1OL86
         Oq9OoDBNZRX9n1bR3t2bN7fuSYhqQZIzircJp9ObyJuFfxcE9YaYiHPCYAXbdZH2ZrOE
         y7rJ5UO43Be/4RgMQU79ZeTTqQ/qBCKmtctbA56aFsC4Ft569CYkyVLsqT9esCKb7VBp
         s9Mg==
X-Gm-Message-State: AOAM532zyFvO4eg3fKQH0zV6LM5jSii8s6jQGaR480wNwJjTtUDNCqpl
        GIcLOTY7KSWNZtwK4M40vX9nYYzkOvM=
X-Google-Smtp-Source: ABdhPJzTwewAhCXtQy1bA672X8jjhmMemjQJlMkNB+kzRtQRXHIseC19kQvGlB6dEIZ02ZugVYLdLw==
X-Received: by 2002:a05:600c:210f:: with SMTP id u15mr381443wml.119.1614304705273;
        Thu, 25 Feb 2021 17:58:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13sm12892601wro.15.2021.02.25.17.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 17:58:24 -0800 (PST)
Message-Id: <9b9d5b207b034ec4181020e0bf3ac46561f55b28.1614304700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
References: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
        <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Feb 2021 01:58:13 +0000
Subject: [PATCH v3 04/10] Move computation of dir_rename_count from merge-ort
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

