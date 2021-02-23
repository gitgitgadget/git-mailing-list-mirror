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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CE9C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 23:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50DD464E83
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 23:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhBWXuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 18:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbhBWXoz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 18:44:55 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3D4C06174A
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 15:44:11 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v1so124017wrd.6
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 15:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DrzK4XLjW6/g9k0d7UOZEDc9hB0xPnmg5wOxP/Cp3Wg=;
        b=Z7ki+JtPtC93BQfwbQDGjXeLzV25cAYvizLyuq9YACi/XIDX66i3kaWhr5A39gpW+b
         zU1mjBwjFdu65iCDM8OZ7tuvBwY+r9CcNoHMSmJ+pLqkeni+sSbPRwTpIoJNuHMT7Xwq
         JAXe3SStnRQN25Ge8FAhi/BS24MV/2yQ2GW7cBDtIntgL1YDNvwCiyDu0HhKkOIKH3x+
         iscnkJpKX768KDH1a8Nw8P3t2PMirz2NeQvEWZhdE4JWI5qY2zmtDHXp6BuVa/UN9f/d
         8QABXzrs5nyRr9Zgc2Dan95dbJg7eVs/kkXJq6glbmTvozACRcrWzHYiKV8h77ISPTgX
         RjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DrzK4XLjW6/g9k0d7UOZEDc9hB0xPnmg5wOxP/Cp3Wg=;
        b=sco0bjkZK+J0lhXMnGou+tjb1AUKFVub9bKj6QJGw3QcKpRX4GiFtfilTA9sxXo5Ck
         +miH8Nk232Lb4uAo8JNW4u0BkZyB+KyXAtWLMkel+zImrL76Z4cUcitJNSiwOkZ0MBv3
         Q42HUM73OUJek8oYOamUhUF7WkGWYMmgOMGowwOylBStGmg+fgXhw0W6vSa5ZKbssVDa
         NpkP59HkQG/MhaCZOmOYjVDEdieOFYEISjn9kuqy5CTdD+EAx1snnl3PRJHknzc8nWuT
         fy1gfaW9j8iflVZEqR1wZK8vZNWrJfz6bKxgyqK9G97x5u2APTcL3Si+Rtb/s2+3cmqv
         mYTQ==
X-Gm-Message-State: AOAM532wgKKKgSQJkw9NzTOWnTDNlaTqEKmvgPT8ScIzlyJfFyzdO7Jd
        PJ+pOGG+6J78LnubMIMxp0sBel0r8T4=
X-Google-Smtp-Source: ABdhPJzFKMLdpI8F+nDRuPXQtZbJCllylWaRSFwUkhHujJT5KapwbX6JGt75rLfyh86lgFCNMZkNgw==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr27841230wrv.319.1614123849984;
        Tue, 23 Feb 2021 15:44:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g18sm355736wrw.40.2021.02.23.15.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 15:44:09 -0800 (PST)
Message-Id: <fec4f1d44c0694cf92c9b98f2b6519a15fb78188.1614123848.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
        <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 23:43:58 +0000
Subject: [PATCH v2 01/10] Move computation of dir_rename_count from merge-ort
 to diffcore-rename
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

A previous commit noted that it is very common for people to move files
across directories while keeping their filename the same.  The last few
commits took advantage of this and showed that we can accelerate rename
detection significantly using basenames; since files with the same
basename serve as likely rename candidates, we can check those first and
remove them from the rename candidate pool if they are sufficiently
similar.

Unfortunately, the previous optimization was limited by the fact that
the remaining basenames after exact rename detection are not always
unique.  Many repositories have hundreds of build files with the same
name (e.g. Makefile, .gitignore, build.gradle, etc.), and may even have
hundreds of source files with the same name.  (For example, the linux
kernel has 100 setup.c, 87 irq.c, and 112 core.c files.  A repository at
$DAYJOB has a lot of ObjectFactory.java and Plugin.java files).

For these files with non-unique basenames, we are faced with the task of
attempting to determine or guess which directory they may have been
relocated to.  Such a task is precisely the job of directory rename
detection.  However, there are two catches: (1) the directory rename
detection code has traditionally been part of the merge machinery rather
than diffcore-rename.c, and (2) directory rename detection currently
runs after regular rename detection is complete.  The 1st catch is just
an implementation issue that can be overcome by some code shuffling.
The 2nd requires us to add a further approximation: we only have access
to exact renames at this point, so we need to do directory rename
detection based on just exact renames.  In some cases we won't have
exact renames, in which case this extra optimization won't apply.  We
also choose to not apply the optimization unless we know that the
underlying directory was removed, which will require extra data to be
passed in to diffcore_rename_extended().  Also, even if we get a
prediction about which directory a file may have relocated to, we will
still need to check to see if there is a file in the predicted
directory, and then compare the two files to see if they meet the higher
min_basename_score threshold required for marking the two files as
renames.

This commit and the next few will set up the necessary infrastructure to
do such computations.  This commit merely moves the computation of
dir_rename_count from merge-ort.c to diffcore-rename.c, making slight
adjustments to the data structures based on the move.  While the
diffstat looks large, viewing this commit with --color-moved makes it
clear that only about 20 lines changed.  With this patch, the
computation of dir_rename_count is still only done after inexact rename
detection, but subsequent commits will add a preliminary computation of
dir_rename_count after exact rename detection, followed by some updates
after inexact rename detection.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 134 +++++++++++++++++++++++++++++++++++++++++++++-
 diffcore.h        |   5 ++
 merge-ort.c       | 132 ++-------------------------------------------
 3 files changed, 141 insertions(+), 130 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 41558185ae1d..33cfc5848611 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -367,6 +367,125 @@ static int find_exact_renames(struct diff_options *options)
 	return renames;
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
 static const char *get_basename(const char *filename)
 {
 	/*
@@ -640,7 +759,9 @@ static void remove_unneeded_paths_from_src(int detecting_copies)
 	rename_src_nr = new_num_src;
 }
 
-void diffcore_rename(struct diff_options *options)
+void diffcore_rename_extended(struct diff_options *options,
+			      struct strset *dirs_removed,
+			      struct strmap *dir_rename_count)
 {
 	int detect_rename = options->detect_rename;
 	int minimum_score = options->rename_score;
@@ -653,6 +774,7 @@ void diffcore_rename(struct diff_options *options)
 	struct progress *progress = NULL;
 
 	trace2_region_enter("diff", "setup", options->repo);
+	assert(!dir_rename_count || strmap_empty(dir_rename_count));
 	want_copies = (detect_rename == DIFF_DETECT_COPY);
 	if (!minimum_score)
 		minimum_score = DEFAULT_RENAME_SCORE;
@@ -841,6 +963,11 @@ void diffcore_rename(struct diff_options *options)
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
@@ -923,3 +1050,8 @@ void diffcore_rename(struct diff_options *options)
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

