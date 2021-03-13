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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEFFC4332B
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 22:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60C2064EE6
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 22:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbhCMWWb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 17:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbhCMWWO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 17:22:14 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E9FC061762
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 14:22:12 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g8so5898036wmd.4
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 14:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FzCINOHNf8xwE1PptmsRwO2vcZm9Tg9OMKQCcL411Aw=;
        b=htGS2StS1HsFcG81ZMrqfCb/gKhW17qyDIPvM3/bhtN9l8rpLlpgt2Eh4nmditX1KK
         5+mA8ynJSeMGwKgB7kLQgM+dEBieVqQfanC/6ptCLWTnEi0Ga7BJuDaUouzMNHhep7ya
         SLpUU23Eb2D14KqEMBnJ0djSxIPUrPOqqvbiLW1SJ8HJAlufXU0Hnjmfz4Li7CNETZZw
         xzlAJxa9Saq2eN0Kf9yQF3eHwdpKGfZzF2hyHibRNfLZsb6VCf+2DEmZWtvwbtzmd6E5
         DyviESJO16k2WuxPjmnb1/F4Tn5VrTeYe0ydIwPHjBiapEf+Axc5q4C39DIPzQx47Ykz
         UkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FzCINOHNf8xwE1PptmsRwO2vcZm9Tg9OMKQCcL411Aw=;
        b=OM4xfooS8jeRxuhYYa9xfwOEaI9+lgG/IVxL0eT3dWpGUtAcEtFqE2tB2yvy2dtrw5
         T1dZwDTGC2pKXP1A32BQFD69QwT0TCOR4O1jVSVV82LhhbIxOgGPiJw5OOASRCuJDCa1
         lxHN5f51OeI020ozsjK15Fq1mtx1cL6zSJYMBm9kxq6a5vVtCewQqZ5JPcx10EXCH0mf
         ibocDSMmCJ605uuea/q8aV2Fa5xQd13bepxcM0IjwYDl+JpTrPAGrUuwJZxX6ndlx5XK
         /mWRgeIX8oyNxs07V1jKJ9IaUIXQSulOVS9zAkcVrp95Z9nW/hSMetABLWtu3hRRpJKj
         S9BA==
X-Gm-Message-State: AOAM532C0oFHP8wjK55Ty6ueNIyR+xxdBd9PoO43MehLu+sb1f9QafdM
        dSJyGWlwwfrEQKTOZCAK8R3br2dmMoQ=
X-Google-Smtp-Source: ABdhPJxGPXrWf9K80dB2254CxlZXA+FIumEhEorsPK3NbtTcDZoWtU2m41wycCFDp98aAyXiS9ztxw==
X-Received: by 2002:a7b:c303:: with SMTP id k3mr19670313wmj.100.1615674131006;
        Sat, 13 Mar 2021 14:22:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14sm7669623wmf.7.2021.03.13.14.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 14:22:10 -0800 (PST)
Message-Id: <927252a1cb45cc34ee964fdf59fe06558f4d792f.1615674128.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.853.git.1615674128.gitgitgadget@gmail.com>
References: <pull.853.git.1615674128.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Mar 2021 22:22:02 +0000
Subject: [PATCH 2/8] merge-ort, diffcore-rename: tweak dirs_removed and
 relevant_source type
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

As noted in the previous commit, we want to be able to take advantage of
the "majority rules" portion of directory rename detection to avoid
detecting more renames than necessary.  However, for diffcore-rename to
take advantage of that, it needs to know whether a rename source file
was needed for just directory rename detection reasons, or if it is
wanted for potential three-way content merging.  Modify relevant_sources
from a strset to a strintmap, so we can encode additional information.

We also modify dirs_removed from a strset to a strintmap at the same
time because trying to determine what files are needed for directory
rename detection will require us tracking a bit more information for
each directory.

This commit only changes the types of the two variables from strset to
strintmap; it does not actually store any special values yet and for now
only checks for presence of entries in the strintmap.  Thus, the code is
functionally identical to how it behaved before.  Future commits will
start associating values with each key for these two maps.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 47 ++++++++++++++++++++++++-----------------------
 diffcore.h        |  6 +++---
 merge-ort.c       | 28 ++++++++++++++--------------
 3 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index a5d10afa221a..6487825317ff 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -371,7 +371,7 @@ struct dir_rename_info {
 	struct strintmap idx_map;
 	struct strmap dir_rename_guess;
 	struct strmap *dir_rename_count;
-	struct strset *relevant_source_dirs;
+	struct strintmap *relevant_source_dirs;
 	unsigned setup;
 };
 
@@ -429,7 +429,7 @@ static void increment_count(struct dir_rename_info *info,
 }
 
 static void update_dir_rename_counts(struct dir_rename_info *info,
-				     struct strset *dirs_removed,
+				     struct strintmap *dirs_removed,
 				     const char *oldname,
 				     const char *newname)
 {
@@ -464,7 +464,7 @@ static void update_dir_rename_counts(struct dir_rename_info *info,
 		/* Get old_dir, skip if its directory isn't relevant. */
 		dirname_munge(old_dir);
 		if (info->relevant_source_dirs &&
-		    !strset_contains(info->relevant_source_dirs, old_dir))
+		    !strintmap_contains(info->relevant_source_dirs, old_dir))
 			break;
 
 		/* Get new_dir */
@@ -509,7 +509,7 @@ static void update_dir_rename_counts(struct dir_rename_info *info,
 			}
 		}
 
-		if (strset_contains(dirs_removed, old_dir))
+		if (strintmap_contains(dirs_removed, old_dir))
 			increment_count(info, old_dir, new_dir);
 		else
 			break;
@@ -527,8 +527,8 @@ static void update_dir_rename_counts(struct dir_rename_info *info,
 }
 
 static void initialize_dir_rename_info(struct dir_rename_info *info,
-				       struct strset *relevant_sources,
-				       struct strset *dirs_removed,
+				       struct strintmap *relevant_sources,
+				       struct strintmap *dirs_removed,
 				       struct strmap *dir_rename_count)
 {
 	struct hashmap_iter iter;
@@ -555,12 +555,13 @@ static void initialize_dir_rename_info(struct dir_rename_info *info,
 		info->relevant_source_dirs = dirs_removed; /* might be NULL */
 	} else {
 		info->relevant_source_dirs = xmalloc(sizeof(struct strintmap));
-		strset_init(info->relevant_source_dirs);
-		strset_for_each_entry(relevant_sources, &iter, entry) {
+		strintmap_init(info->relevant_source_dirs, 0 /* unused */);
+		strintmap_for_each_entry(relevant_sources, &iter, entry) {
 			char *dirname = get_dirname(entry->key);
 			if (!dirs_removed ||
-			    strset_contains(dirs_removed, dirname))
-				strset_add(info->relevant_source_dirs, dirname);
+			    strintmap_contains(dirs_removed, dirname))
+				strintmap_set(info->relevant_source_dirs,
+					      dirname, 0 /* value irrelevant */);
 			free(dirname);
 		}
 	}
@@ -624,7 +625,7 @@ void partial_clear_dir_rename_count(struct strmap *dir_rename_count)
 }
 
 static void cleanup_dir_rename_info(struct dir_rename_info *info,
-				    struct strset *dirs_removed,
+				    struct strintmap *dirs_removed,
 				    int keep_dir_rename_count)
 {
 	struct hashmap_iter iter;
@@ -644,7 +645,7 @@ static void cleanup_dir_rename_info(struct dir_rename_info *info,
 	/* relevant_source_dirs */
 	if (info->relevant_source_dirs &&
 	    info->relevant_source_dirs != dirs_removed) {
-		strset_clear(info->relevant_source_dirs);
+		strintmap_clear(info->relevant_source_dirs);
 		FREE_AND_NULL(info->relevant_source_dirs);
 	}
 
@@ -666,7 +667,7 @@ static void cleanup_dir_rename_info(struct dir_rename_info *info,
 		const char *source_dir = entry->key;
 		struct strintmap *counts = entry->value;
 
-		if (!strset_contains(dirs_removed, source_dir)) {
+		if (!strintmap_contains(dirs_removed, source_dir)) {
 			string_list_append(&to_remove, source_dir);
 			strintmap_clear(counts);
 			continue;
@@ -770,8 +771,8 @@ static int idx_possible_rename(char *filename, struct dir_rename_info *info)
 static int find_basename_matches(struct diff_options *options,
 				 int minimum_score,
 				 struct dir_rename_info *info,
-				 struct strset *relevant_sources,
-				 struct strset *dirs_removed)
+				 struct strintmap *relevant_sources,
+				 struct strintmap *dirs_removed)
 {
 	/*
 	 * When I checked in early 2020, over 76% of file renames in linux
@@ -863,7 +864,7 @@ static int find_basename_matches(struct diff_options *options,
 
 		/* Skip irrelevant sources */
 		if (relevant_sources &&
-		    !strset_contains(relevant_sources, filename))
+		    !strintmap_contains(relevant_sources, filename))
 			continue;
 
 		/*
@@ -994,7 +995,7 @@ static int find_renames(struct diff_score *mx,
 			int minimum_score,
 			int copies,
 			struct dir_rename_info *info,
-			struct strset *dirs_removed)
+			struct strintmap *dirs_removed)
 {
 	int count = 0, i;
 
@@ -1019,7 +1020,7 @@ static int find_renames(struct diff_score *mx,
 }
 
 static void remove_unneeded_paths_from_src(int detecting_copies,
-					   struct strset *interesting)
+					   struct strintmap *interesting)
 {
 	int i, new_num_src;
 
@@ -1061,7 +1062,7 @@ static void remove_unneeded_paths_from_src(int detecting_copies,
 			continue;
 
 		/* If we don't care about the source path, skip it */
-		if (interesting && !strset_contains(interesting, one->path))
+		if (interesting && !strintmap_contains(interesting, one->path))
 			continue;
 
 		if (new_num_src < i)
@@ -1074,8 +1075,8 @@ static void remove_unneeded_paths_from_src(int detecting_copies,
 }
 
 static void handle_early_known_dir_renames(struct dir_rename_info *info,
-					   struct strset *relevant_sources,
-					   struct strset *dirs_removed)
+					   struct strintmap *relevant_sources,
+					   struct strintmap *dirs_removed)
 {
 	/*
 	 * Not yet implemented; directory renames are determined via an
@@ -1092,8 +1093,8 @@ static void handle_early_known_dir_renames(struct dir_rename_info *info,
 }
 
 void diffcore_rename_extended(struct diff_options *options,
-			      struct strset *relevant_sources,
-			      struct strset *dirs_removed,
+			      struct strintmap *relevant_sources,
+			      struct strintmap *dirs_removed,
 			      struct strmap *dir_rename_count)
 {
 	int detect_rename = options->detect_rename;
diff --git a/diffcore.h b/diffcore.h
index 737c93a6cc79..4f168b385fde 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -8,8 +8,8 @@
 
 struct diff_options;
 struct repository;
+struct strintmap;
 struct strmap;
-struct strset;
 struct userdiff_driver;
 
 /* This header file is internal between diff.c and its diff transformers
@@ -166,8 +166,8 @@ void partial_clear_dir_rename_count(struct strmap *dir_rename_count);
 void diffcore_break(struct repository *, int);
 void diffcore_rename(struct diff_options *);
 void diffcore_rename_extended(struct diff_options *options,
-			      struct strset *relevant_sources,
-			      struct strset *dirs_removed,
+			      struct strintmap *relevant_sources,
+			      struct strintmap *dirs_removed,
 			      struct strmap *dir_rename_count);
 void diffcore_merge_broken(void);
 void diffcore_pickaxe(struct diff_options *);
diff --git a/merge-ort.c b/merge-ort.c
index bd089cb9a76f..6fa670396ce4 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -74,7 +74,7 @@ struct rename_info {
 	/*
 	 * dirs_removed: directories removed on a given side of history.
 	 */
-	struct strset dirs_removed[3];
+	struct strintmap dirs_removed[3];
 
 	/*
 	 * dir_rename_count: tracking where parts of a directory were renamed to
@@ -106,7 +106,7 @@ struct rename_info {
 	 * If neither of those are true, we can skip rename detection for
 	 * that path.
 	 */
-	struct strset relevant_sources[3];
+	struct strintmap relevant_sources[3];
 
 	/*
 	 * dir_rename_mask:
@@ -362,8 +362,8 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 	int i;
 	void (*strmap_func)(struct strmap *, int) =
 		reinitialize ? strmap_partial_clear : strmap_clear;
-	void (*strset_func)(struct strset *) =
-		reinitialize ? strset_partial_clear : strset_clear;
+	void (*strintmap_func)(struct strintmap *) =
+		reinitialize ? strintmap_partial_clear : strintmap_clear;
 
 	/*
 	 * We marked opti->paths with strdup_strings = 0, so that we
@@ -395,7 +395,7 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 
 	/* Free memory used by various renames maps */
 	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; ++i) {
-		strset_func(&renames->dirs_removed[i]);
+		strintmap_func(&renames->dirs_removed[i]);
 
 		partial_clear_dir_rename_count(&renames->dir_rename_count[i]);
 		if (!reinitialize)
@@ -403,7 +403,7 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 
 		strmap_func(&renames->dir_renames[i], 0);
 
-		strset_func(&renames->relevant_sources[i]);
+		strintmap_func(&renames->relevant_sources[i]);
 	}
 
 	if (!reinitialize) {
@@ -674,7 +674,7 @@ static void add_pair(struct merge_options *opt,
 		unsigned location_relevant = (dir_rename_mask == 0x07);
 
 		if (content_relevant || location_relevant)
-			strset_add(&renames->relevant_sources[side], pathname);
+			strintmap_set(&renames->relevant_sources[side], pathname, 1);
 	}
 
 	one = alloc_filespec(pathname);
@@ -730,9 +730,9 @@ static void collect_rename_info(struct merge_options *opt,
 		/* absent_mask = 0x07 - dirmask; sides = absent_mask/2 */
 		unsigned sides = (0x07 - dirmask)/2;
 		if (sides & 1)
-			strset_add(&renames->dirs_removed[1], fullname);
+			strintmap_set(&renames->dirs_removed[1], fullname, 1);
 		if (sides & 2)
-			strset_add(&renames->dirs_removed[2], fullname);
+			strintmap_set(&renames->dirs_removed[2], fullname, 1);
 	}
 
 	if (filemask == 0 || filemask == 7)
@@ -2161,7 +2161,7 @@ static inline int possible_side_renames(struct rename_info *renames,
 					unsigned side_index)
 {
 	return renames->pairs[side_index].nr > 0 &&
-	       !strset_empty(&renames->relevant_sources[side_index]);
+	       !strintmap_empty(&renames->relevant_sources[side_index]);
 }
 
 static inline int possible_renames(struct rename_info *renames)
@@ -3445,14 +3445,14 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	/* Initialization of various renames fields */
 	renames = &opt->priv->renames;
 	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; i++) {
-		strset_init_with_options(&renames->dirs_removed[i],
-					 NULL, 0);
+		strintmap_init_with_options(&renames->dirs_removed[i],
+					    0, NULL, 0);
 		strmap_init_with_options(&renames->dir_rename_count[i],
 					 NULL, 1);
 		strmap_init_with_options(&renames->dir_renames[i],
 					 NULL, 0);
-		strset_init_with_options(&renames->relevant_sources[i],
-					 NULL, 0);
+		strintmap_init_with_options(&renames->relevant_sources[i],
+					    0, NULL, 0);
 	}
 
 	/*
-- 
gitgitgadget

