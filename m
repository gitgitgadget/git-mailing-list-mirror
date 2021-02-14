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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9579FC433DB
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 08:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC7964E26
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 08:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhBNIBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 03:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhBNIA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 03:00:28 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488BBC06178A
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:59:09 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id n6so4871834wrv.8
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QWJ9yu7X8wmM7ii3WiU9OKa150wYmtvxUxj7efV4mx4=;
        b=MzjSu9UgG+D/m4HldJNhwuDOtUwrWKA7UuDy9KksaYQtKapK6b2Q1tOPI/YxyzLdCZ
         inoIBmFLaHAd2CXGgV38QpQecfr36o6woQC242PqMeD9R/QJj/WFjt5GHoi+CxhVu259
         c1/2z3uZ4lYK1PdQJO4gxwCjG1F5XqrdRkr7lLbNcr4Wc9egJxDe++t/U0sRif/ngjSJ
         0dCydg8Z8tb/9711BnS3opnBeDguXkPSJkvDqYO8MrEc/DC7TsOtRJWwsGTLD/aYpCzp
         oTFH8yyP6Ar+2mJCAC3zJhpJvxtwACBksr+oVRG8zG73iYGGhS9y8fpJTDCWKKZXK3NS
         /ZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QWJ9yu7X8wmM7ii3WiU9OKa150wYmtvxUxj7efV4mx4=;
        b=GU8EAQ8Qjy0Tdww4coTxift4SpeosxUydbVNkoM1afzDJNPni+wsc19IlXlw+IJfGP
         d+R89HSq5fxg86O1BqKOHDacDwicuNYDf9geX7vrVu+aiI3MBSm0EHMpOP3EW8MN9qwE
         usA/rqPyZP6PhQj0cnZNQCYTh8X3A+AbtjLqGBjw3alWTnjFdiHQFC8OQ3dtk04uSvm2
         GlvZXQxebhAqSXuQKoCxg9aSapdH19iqygZSbdNPXcYUJmesuFcVf4VQAeLCzidDnksC
         Ga4H/bImJy9ciTP4zaVss4bvO8pg+xIGlaRQRxapGy4TmdVMw8ppsWyJUvcqzCymV8W+
         v5Hw==
X-Gm-Message-State: AOAM533etgAx/Hs7XrakbE6Oy6qPNJ5qpZf2lvlSx0tUH2fbkEWgSLJM
        rC9YehP88pDYFXIz0LFbQnR3KdBtTR8=
X-Google-Smtp-Source: ABdhPJzB2QOrtmeLzu/+jRZ5aI1yERMzW9iWarTW2ZbiUx4PDep0yc2nvucNeOUsmR7CExrFib2qBQ==
X-Received: by 2002:adf:ec89:: with SMTP id z9mr12504933wrn.410.1613289548042;
        Sat, 13 Feb 2021 23:59:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15sm18374921wrm.93.2021.02.13.23.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 23:59:07 -0800 (PST)
Message-Id: <3a29cf9e526fba0227a7eec92c0c6bd58a7850f0.1613289544.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.git.1613289544.gitgitgadget@gmail.com>
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Feb 2021 07:58:58 +0000
Subject: [PATCH 05/10] diffcore-rename: compute dir_rename_counts in stages
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

We want to first compute dir_rename_counts based just on exact renames
to start, as that can provide us useful information in
find_basename_matches().  That will give us an incomplete result, which
we can then later augment as basename and inexact rename matches are
found.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 76 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 62 insertions(+), 14 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index aa21d4e7175c..489e9cb0871e 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -411,6 +411,28 @@ static void update_dir_rename_counts(struct dir_rename_info *info,
 	char new_dir_first_char = new_dir[0];
 	int first_time_in_loop = 1;
 
+	if (!info->setup)
+		/*
+		 * info->setup is 0 here in two cases: (1) all auxiliary
+		 * vars (like dirs_removed) were NULL so
+		 * initialize_dir_rename_info() returned early, or (2)
+		 * either break detection or copy detection are active so
+		 * that we never called initialize_dir_rename_info().  In
+		 * the former case, we don't have enough info to know if
+		 * directories were renamed (because dirs_removed lets us
+		 * know about a necessary prerequisite, namely if they were
+		 * removed), and in the latter, we don't care about
+		 * directory renames or find_basename_matches.
+		 *
+		 * This matters because both basename and inexact matching
+		 * will also call update_dir_rename_counts().  In either of
+		 * the above two cases info->dir_rename_counts will not
+		 * have been properly initialized which prevents us from
+		 * updating it, but in these two cases we don't care about
+		 * dir_rename_counts anyway, so we can just exit early.
+		 */
+		return;
+
 	while (1) {
 		dirname_munge(old_dir);
 		dirname_munge(new_dir);
@@ -471,14 +493,22 @@ static void update_dir_rename_counts(struct dir_rename_info *info,
 	free(new_dir);
 }
 
-static void compute_dir_rename_counts(struct dir_rename_info *info,
-				      struct strset *dirs_removed,
-				      struct strmap *dir_rename_count)
+static void initialize_dir_rename_info(struct dir_rename_info *info,
+				       struct strset *dirs_removed,
+				       struct strmap *dir_rename_count)
 {
 	int i;
 
+	info->setup = 0;
+	if (!dirs_removed)
+		return;
 	info->setup = 1;
+
 	info->dir_rename_count = dir_rename_count;
+	if (!info->dir_rename_count) {
+		info->dir_rename_count = xmalloc(sizeof(*dir_rename_count));
+		strmap_init(info->dir_rename_count);
+	}
 
 	for (i = 0; i < rename_dst_nr; ++i) {
 		/*
@@ -506,7 +536,6 @@ void partial_clear_dir_rename_count(struct strmap *dir_rename_count)
 	strmap_partial_clear(dir_rename_count, 1);
 }
 
-MAYBE_UNUSED
 static void cleanup_dir_rename_info(struct dir_rename_info *info,
 				    struct strset *dirs_removed,
 				    int keep_dir_rename_count)
@@ -561,7 +590,9 @@ static const char *get_basename(const char *filename)
 }
 
 static int find_basename_matches(struct diff_options *options,
-				 int minimum_score)
+				 int minimum_score,
+				 struct dir_rename_info *info,
+				 struct strset *dirs_removed)
 {
 	/*
 	 * When I checked in early 2020, over 76% of file renames in linux
@@ -669,6 +700,8 @@ static int find_basename_matches(struct diff_options *options,
 				continue;
 			record_rename_pair(dst_index, src_index, score);
 			renames++;
+			update_dir_rename_counts(info, dirs_removed,
+						 one->path, two->path);
 
 			/*
 			 * Found a rename so don't need text anymore; if we
@@ -752,7 +785,12 @@ static int too_many_rename_candidates(int num_destinations, int num_sources,
 	return 1;
 }
 
-static int find_renames(struct diff_score *mx, int dst_cnt, int minimum_score, int copies)
+static int find_renames(struct diff_score *mx,
+			int dst_cnt,
+			int minimum_score,
+			int copies,
+			struct dir_rename_info *info,
+			struct strset *dirs_removed)
 {
 	int count = 0, i;
 
@@ -769,6 +807,9 @@ static int find_renames(struct diff_score *mx, int dst_cnt, int minimum_score, i
 			continue;
 		record_rename_pair(mx[i].dst, mx[i].src, mx[i].score);
 		count++;
+		update_dir_rename_counts(info, dirs_removed,
+					 rename_src[mx[i].src].p->one->path,
+					 rename_dst[mx[i].dst].p->two->path);
 	}
 	return count;
 }
@@ -840,6 +881,8 @@ void diffcore_rename_extended(struct diff_options *options,
 	info.setup = 0;
 	assert(!dir_rename_count || strmap_empty(dir_rename_count));
 	want_copies = (detect_rename == DIFF_DETECT_COPY);
+	if (dirs_removed && (break_idx || want_copies))
+		BUG("dirs_removed incompatible with break/copy detection");
 	if (!minimum_score)
 		minimum_score = DEFAULT_RENAME_SCORE;
 
@@ -931,10 +974,17 @@ void diffcore_rename_extended(struct diff_options *options,
 		remove_unneeded_paths_from_src(want_copies);
 		trace2_region_leave("diff", "cull after exact", options->repo);
 
+		/* Preparation for basename-driven matching. */
+		trace2_region_enter("diff", "dir rename setup", options->repo);
+		initialize_dir_rename_info(&info,
+					   dirs_removed, dir_rename_count);
+		trace2_region_leave("diff", "dir rename setup", options->repo);
+
 		/* Utilize file basenames to quickly find renames. */
 		trace2_region_enter("diff", "basename matches", options->repo);
 		rename_count += find_basename_matches(options,
-						      min_basename_score);
+						      min_basename_score,
+						      &info, dirs_removed);
 		trace2_region_leave("diff", "basename matches", options->repo);
 
 		/*
@@ -1020,18 +1070,15 @@ void diffcore_rename_extended(struct diff_options *options,
 	/* cost matrix sorted by most to least similar pair */
 	STABLE_QSORT(mx, dst_cnt * NUM_CANDIDATE_PER_DST, score_compare);
 
-	rename_count += find_renames(mx, dst_cnt, minimum_score, 0);
+	rename_count += find_renames(mx, dst_cnt, minimum_score, 0,
+				     &info, dirs_removed);
 	if (want_copies)
-		rename_count += find_renames(mx, dst_cnt, minimum_score, 1);
+		rename_count += find_renames(mx, dst_cnt, minimum_score, 1,
+					     &info, dirs_removed);
 	free(mx);
 	trace2_region_leave("diff", "inexact renames", options->repo);
 
  cleanup:
-	/*
-	 * Now that renames have been computed, compute dir_rename_count */
-	if (dirs_removed && dir_rename_count)
-		compute_dir_rename_counts(&info, dirs_removed, dir_rename_count);
-
 	/* At this point, we have found some renames and copies and they
 	 * are recorded in rename_dst.  The original list is still in *q.
 	 */
@@ -1103,6 +1150,7 @@ void diffcore_rename_extended(struct diff_options *options,
 		if (rename_dst[i].filespec_to_free)
 			free_filespec(rename_dst[i].filespec_to_free);
 
+	cleanup_dir_rename_info(&info, dirs_removed, dir_rename_count != NULL);
 	FREE_AND_NULL(rename_dst);
 	rename_dst_nr = rename_dst_alloc = 0;
 	FREE_AND_NULL(rename_src);
-- 
gitgitgadget

