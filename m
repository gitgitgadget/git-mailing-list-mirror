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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B9FC47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 08:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832DA613D1
	for <git@archiver.kernel.org>; Thu, 27 May 2021 08:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbhE0IjC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 04:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbhE0IjB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 04:39:01 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AA4C061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 01:37:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g17so3610469wrs.13
        for <git@vger.kernel.org>; Thu, 27 May 2021 01:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nWGMIEMq36+TyKFGD8lw4MR52upZEZSPH0ppbRIQWmc=;
        b=XcEDse+WVExF1qkqnG+EKf7jn9IChT7/zFtpswM6I1X3cdUyk+p66GPHs66EMH0Rx4
         WdyYS7qUls9dZejbG4W5yfba41GYWfiuFHq1ax0P1oLX9pRY5a9mmKDuRRdrI+KepQiy
         qUjKGBzqu4D/t5NTYq3DDxjDCzuR3zxY67l0f1he6pWBepriIRoYZqDjB8ysaOO2ZUlj
         eH8lwiLAWeeeBdnH+PHUnvldhZfIWeQCCMhpmciTp6GIkQyANO29qdzRnE+5r5ddWOAn
         8RPEOuuWJXVARis8X1R+Ir0i6n+W/dWr7HviLnUEh/5l+vgiaLIT/G05nSt3VcTjYmKZ
         4q0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nWGMIEMq36+TyKFGD8lw4MR52upZEZSPH0ppbRIQWmc=;
        b=TL53vwlxdcR+/4DNjeVKXGZ+x7EKrDQBFTcwXF5E/o3yyavO8e3TJSvh74736tW77O
         Zg1A58imd0k6IJy5mdUrjOjnOolUiyBTM/OtOOlCmFtyIp7VKH582wiL2XEEUE/XePJu
         4jHSmHtECL4AHZNTNitq3xH4u/MbSxd/R096buu6XEgqluvfvNkoWBw9g9S78UQ3VKJc
         L+5TeNgLgchYkqLlgeLZGICN5fylI4JDb5wyRgs1d92FtfQRT/ycbaLu/FsYcJ77jvDy
         0uzHPoCxOYX9VECc6UApuk5eejmIu5WOTv77GZNAoe5xB56MnUUItt6G90xMvBQPO+5n
         n1WQ==
X-Gm-Message-State: AOAM533nlJJM5Au3oHvJBemT05yjNLvYGEstH4kdBAkdzs4AhyUiNvZD
        YC8JHUjwpWfwUkyhFGJz8us5mKi1xcM=
X-Google-Smtp-Source: ABdhPJx6d9JXKwKbNfTAT2Xkrg2PW1bPlR7MK2bpZbagMxRnDvLK0zT1xsSIz5xsRZfBRD8PuHh84Q==
X-Received: by 2002:a5d:4a81:: with SMTP id o1mr1984371wrq.177.1622104645711;
        Thu, 27 May 2021 01:37:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i1sm1946594wmb.46.2021.05.27.01.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 01:37:25 -0700 (PDT)
Message-Id: <19150b5750586996383dc26f3801a9441486f9f0.1622104642.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.962.git.1622104642.gitgitgadget@gmail.com>
References: <pull.962.git.1622104642.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 May 2021 08:37:19 +0000
Subject: [PATCH 3/5] diffcore-rename: enable limiting rename detection to
 relevant destinations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Our former optimizations focused on limiting rename detection to a
pre-specified set of relevant sources.  This was because the merge logic
only had a way of knowing which sources were relevant.  However, other
callers of rename detection might benefit from being able to limit
rename detection to a known set of relevant destinations.  In
particular, a properly implemented `git log --follow` might benefit from
such an ability.

Since the code to implement such limiting is very similar to what we've
already done, just implement it now even though we do not yet have any
callers making use of this ability.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 48 +++++++++++++++++++++++++++++++++++++++++------
 diffcore.h        |  2 ++
 merge-ort.c       |  1 +
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index e333a6d64791..8ff83a9f3b99 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -372,6 +372,7 @@ struct dir_rename_info {
 	struct strmap dir_rename_guess;
 	struct strmap *dir_rename_count;
 	struct strintmap *relevant_source_dirs;
+	struct strset *relevant_destination_dirs;
 	unsigned setup;
 };
 
@@ -491,8 +492,11 @@ static void update_dir_rename_counts(struct dir_rename_info *info,
 		    !strintmap_contains(info->relevant_source_dirs, old_dir))
 			break;
 
-		/* Get new_dir */
+		/* Get new_dir, skip if its directory isn't relevant. */
 		dirname_munge(new_dir);
+		if (info->relevant_destination_dirs &&
+		    !strset_contains(info->relevant_destination_dirs, new_dir))
+			break;
 
 		/*
 		 * When renaming
@@ -567,6 +571,7 @@ static void update_dir_rename_counts(struct dir_rename_info *info,
 
 static void initialize_dir_rename_info(struct dir_rename_info *info,
 				       struct strintmap *relevant_sources,
+				       struct strset *relevant_destinations,
 				       struct strintmap *dirs_removed,
 				       struct strmap *dir_rename_count,
 				       struct strmap *cached_pairs)
@@ -575,7 +580,7 @@ static void initialize_dir_rename_info(struct dir_rename_info *info,
 	struct strmap_entry *entry;
 	int i;
 
-	if (!dirs_removed && !relevant_sources) {
+	if (!dirs_removed && !relevant_sources && !relevant_destinations) {
 		info->setup = 0;
 		return;
 	}
@@ -589,6 +594,18 @@ static void initialize_dir_rename_info(struct dir_rename_info *info,
 	strintmap_init_with_options(&info->idx_map, -1, NULL, 0);
 	strmap_init_with_options(&info->dir_rename_guess, NULL, 0);
 
+	/* Setup info->relevant_destination_dirs */
+	info->relevant_destination_dirs = NULL;
+	if (relevant_destinations) {
+		info->relevant_destination_dirs = xmalloc(sizeof(struct strset));
+		strset_init(info->relevant_destination_dirs);
+		strset_for_each_entry(relevant_destinations, &iter, entry) {
+			char *dirname = get_dirname(entry->key);
+			strset_add(info->relevant_destination_dirs, dirname);
+			free(dirname);
+		}
+	}
+
 	/* Setup info->relevant_source_dirs */
 	info->relevant_source_dirs = NULL;
 	if (dirs_removed || !relevant_sources) {
@@ -700,6 +717,12 @@ static void cleanup_dir_rename_info(struct dir_rename_info *info,
 		FREE_AND_NULL(info->relevant_source_dirs);
 	}
 
+	/* relevant_destination_dirs */
+	if (info->relevant_destination_dirs) {
+		strset_clear(info->relevant_destination_dirs);
+		FREE_AND_NULL(info->relevant_destination_dirs);
+	}
+
 	/* dir_rename_count */
 	if (!keep_dir_rename_count) {
 		partial_clear_dir_rename_count(info->dir_rename_count);
@@ -827,6 +850,7 @@ static int find_basename_matches(struct diff_options *options,
 				 int minimum_score,
 				 struct dir_rename_info *info,
 				 struct strintmap *relevant_sources,
+				 struct strset *relevant_destinations,
 				 struct strintmap *dirs_removed)
 {
 	/*
@@ -949,9 +973,15 @@ static int find_basename_matches(struct diff_options *options,
 			if (rename_dst[dst_index].is_rename)
 				continue; /* already used previously */
 
-			/* Estimate the similarity */
 			one = rename_src[src_index].p->one;
 			two = rename_dst[dst_index].p->two;
+
+			/* Skip irrelevant destinations */
+			if (relevant_destinations &&
+			    !strset_contains(relevant_destinations, two->path))
+				continue;
+
+			/* Estimate the similarity */
 			score = estimate_similarity(options->repo, one, two,
 						    minimum_score, skip_unmodified);
 
@@ -1258,6 +1288,7 @@ static void handle_early_known_dir_renames(struct dir_rename_info *info,
 
 void diffcore_rename_extended(struct diff_options *options,
 			      struct strintmap *relevant_sources,
+			      struct strset *relevant_destinations,
 			      struct strintmap *dirs_removed,
 			      struct strmap *dir_rename_count,
 			      struct strmap *cached_pairs)
@@ -1376,8 +1407,8 @@ void diffcore_rename_extended(struct diff_options *options,
 		/* Preparation for basename-driven matching. */
 		trace2_region_enter("diff", "dir rename setup", options->repo);
 		initialize_dir_rename_info(&info, relevant_sources,
-					   dirs_removed, dir_rename_count,
-					   cached_pairs);
+					   relevant_destinations, dirs_removed,
+					   dir_rename_count, cached_pairs);
 		trace2_region_leave("diff", "dir rename setup", options->repo);
 
 		/* Utilize file basenames to quickly find renames. */
@@ -1386,6 +1417,7 @@ void diffcore_rename_extended(struct diff_options *options,
 						      min_basename_score,
 						      &info,
 						      relevant_sources,
+						      relevant_destinations,
 						      dirs_removed);
 		trace2_region_leave("diff", "basename matches", options->repo);
 
@@ -1441,6 +1473,10 @@ void diffcore_rename_extended(struct diff_options *options,
 		if (rename_dst[i].is_rename)
 			continue; /* exact or basename match already handled */
 
+		if (relevant_destinations &&
+		    !strset_contains(relevant_destinations, two->path))
+			continue;
+
 		m = &mx[dst_cnt * NUM_CANDIDATE_PER_DST];
 		for (j = 0; j < NUM_CANDIDATE_PER_DST; j++)
 			m[j].dst = -1;
@@ -1574,5 +1610,5 @@ void diffcore_rename_extended(struct diff_options *options,
 
 void diffcore_rename(struct diff_options *options)
 {
-	diffcore_rename_extended(options, NULL, NULL, NULL, NULL);
+	diffcore_rename_extended(options, NULL, NULL, NULL, NULL, NULL);
 }
diff --git a/diffcore.h b/diffcore.h
index 533b30e21e7f..435c7094f403 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -10,6 +10,7 @@ struct diff_options;
 struct repository;
 struct strintmap;
 struct strmap;
+struct strset;
 struct userdiff_driver;
 
 /* This header file is internal between diff.c and its diff transformers
@@ -180,6 +181,7 @@ void diffcore_break(struct repository *, int);
 void diffcore_rename(struct diff_options *);
 void diffcore_rename_extended(struct diff_options *options,
 			      struct strintmap *relevant_sources,
+			      struct strset *relevant_destinations,
 			      struct strintmap *dirs_removed,
 			      struct strmap *dir_rename_count,
 			      struct strmap *cached_pairs);
diff --git a/merge-ort.c b/merge-ort.c
index 367aec4b7def..db16cbc3bd33 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2568,6 +2568,7 @@ static void detect_regular_renames(struct merge_options *opt,
 	trace2_region_enter("diff", "diffcore_rename", opt->repo);
 	diffcore_rename_extended(&diff_opts,
 				 &renames->relevant_sources[side_index],
+				 NULL,
 				 &renames->dirs_removed[side_index],
 				 &renames->dir_rename_count[side_index],
 				 &renames->cached_pairs[side_index]);
-- 
gitgitgadget

