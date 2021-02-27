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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A240C433E0
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 00:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D2964E33
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 00:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhB0Act (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 19:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhB0AcR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 19:32:17 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A1AC061794
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 16:30:57 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id w11so10196626wrr.10
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 16:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GOSeeKvtRdz0GID/eiY63VEW9+XRRBYv7jvX2cxk/lQ=;
        b=M3iDYFzLse8YFzQdBaYZ1TjYIDutEg2H+s6YIi0cKeVvk1pWMT3ccZiQ2bNmuIib6i
         yOjrO6Y16oTfqJ0ntlPUNU48419zZZdmbBWkuL7Th2jLzZNUfjyMqv/5OSfSAzEQlHzE
         EUtaFoU1FpH54j03NKaPBKD+H9xEA212/pU5EvtMzhAN7aQ5Hgc1QCd+aOqec2dg4xvX
         0RmreKN0mxkg961rBVT3dy2Smkgoz9PD+hcw6Wx63qF/G6DzCYlbDRt1t9Q+MdgftQE0
         +NO4ISK6pFyXSBT8eTjKcAIRcZofmQmR9oQhXI+fFqD7leNbmQsvQCQun+0DUmRYloaM
         HcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GOSeeKvtRdz0GID/eiY63VEW9+XRRBYv7jvX2cxk/lQ=;
        b=iLdtTIhz1jRlaehnRX1EyOBhGkSqnbFgKQrR3yozuF44ClD1AyT8Lc0U6a3unlQ0s+
         T2YLQU9beBFyjyChGxN8UPsI5pPupdEq/7pCyvhq3fL4gIeAlE8NaIzGQhjR0Gs9kqFZ
         j0FzTQXVK5DmaFgMhX/PUuAjuJLUnZ1IX6CkLuwpZgxXm359B75y6K4li+jC4FqWRlB3
         uyd9wIS3fPPhfJhz7AuvS1cTYoN93mteRXq1HJWZpzxeaNFdhi3wR/ML8TXdmCPzyea8
         E8XWoHfO/NJbJcAFbyrG4JG1vYaVVg51lP2RlbWwC+TjhHvxQ50R+DlvoBCdiogbYjYv
         /r+Q==
X-Gm-Message-State: AOAM5337wAMo0Zgt7p6eTl6yjEd2qOyN9eQ7dJOMFoSC+H1TK4SBX6lM
        8DeYhe9E7rXBmYAsU+Zqq+lnc7xaBnY=
X-Google-Smtp-Source: ABdhPJzLcrt3O8DZoNdnTrXPVUE/im84GUAhM9MaGKm5SIBNcrBfXu+qaDrHTHY1e9REt+Epi5FMiA==
X-Received: by 2002:a5d:66c8:: with SMTP id k8mr5765766wrw.163.1614385856000;
        Fri, 26 Feb 2021 16:30:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z3sm16102307wrw.96.2021.02.26.16.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 16:30:55 -0800 (PST)
Message-Id: <6bd398d3707eb514d8758dcff0a21cae11c897b5.1614385849.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v4.git.1614385849.gitgitgadget@gmail.com>
References: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
        <pull.844.v4.git.1614385849.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Feb 2021 00:30:46 +0000
Subject: [PATCH v4 08/10] diffcore-rename: compute dir_rename_counts in stages
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

Compute dir_rename_counts based just on exact renames to start, as that
can provide us useful information in find_basename_matches().  This is
done by moving the code from compute_dir_rename_counts() into
initialize_dir_rename_info(), resulting in it being computed earlier and
based just on exact renames.  Since that's an incomplete result, we
augment the counts via calling update_dir_rename_counts() after each
basename-guide and inexact rename detection match is found.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 110 +++++++++++++++++++++++++++++-----------------
 1 file changed, 70 insertions(+), 40 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 2cf9c47c6364..10f8f4a301e3 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -419,6 +419,28 @@ static void update_dir_rename_counts(struct dir_rename_info *info,
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
@@ -479,45 +501,29 @@ static void update_dir_rename_counts(struct dir_rename_info *info,
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
 
-	info->setup = 1;
-	info->dir_rename_count = dir_rename_count;
-
-	for (i = 0; i < rename_dst_nr; ++i) {
-		/* File not part of directory rename counts if not a rename */
-		if (!rename_dst[i].is_rename)
-			continue;
-
-		/*
-		 * Make dir_rename_count contain a map of a map:
-		 *   old_directory -> {new_directory -> count}
-		 * In other words, for every pair look at the directories for
-		 * the old filename and the new filename and count how many
-		 * times that pairing occurs.
-		 */
-		update_dir_rename_counts(info, dirs_removed,
-					 rename_dst[i].p->one->path,
-					 rename_dst[i].p->two->path);
+	if (!dirs_removed) {
+		info->setup = 0;
+		return;
 	}
-}
-
-static void initialize_dir_rename_info(struct dir_rename_info *info)
-{
-	int i;
-
 	info->setup = 1;
 
+	info->dir_rename_count = dir_rename_count;
+	if (!info->dir_rename_count) {
+		info->dir_rename_count = xmalloc(sizeof(*dir_rename_count));
+		strmap_init(info->dir_rename_count);
+	}
 	strintmap_init_with_options(&info->idx_map, -1, NULL, 0);
 	strmap_init_with_options(&info->dir_rename_guess, NULL, 0);
-	info->dir_rename_count = NULL;
 
 	/*
-	 * Loop setting up both info->idx_map.
+	 * Loop setting up both info->idx_map, and doing setup of
+	 * info->dir_rename_count.
 	 */
 	for (i = 0; i < rename_dst_nr; ++i) {
 		/*
@@ -527,7 +533,20 @@ static void initialize_dir_rename_info(struct dir_rename_info *info)
 		if (!rename_dst[i].is_rename) {
 			char *filename = rename_dst[i].p->two->path;
 			strintmap_set(&info->idx_map, filename, i);
+			continue;
 		}
+
+		/*
+		 * For everything else (i.e. renamed files), make
+		 * dir_rename_count contain a map of a map:
+		 *   old_directory -> {new_directory -> count}
+		 * In other words, for every pair look at the directories for
+		 * the old filename and the new filename and count how many
+		 * times that pairing occurs.
+		 */
+		update_dir_rename_counts(info, dirs_removed,
+					 rename_dst[i].p->one->path,
+					 rename_dst[i].p->two->path);
 	}
 }
 
@@ -682,7 +701,8 @@ static int idx_possible_rename(char *filename, struct dir_rename_info *info)
 
 static int find_basename_matches(struct diff_options *options,
 				 int minimum_score,
-				 struct dir_rename_info *info)
+				 struct dir_rename_info *info,
+				 struct strset *dirs_removed)
 {
 	/*
 	 * When I checked in early 2020, over 76% of file renames in linux
@@ -810,6 +830,8 @@ static int find_basename_matches(struct diff_options *options,
 				continue;
 			record_rename_pair(dst_index, src_index, score);
 			renames++;
+			update_dir_rename_counts(info, dirs_removed,
+						 one->path, two->path);
 
 			/*
 			 * Found a rename so don't need text anymore; if we
@@ -893,7 +915,12 @@ static int too_many_rename_candidates(int num_destinations, int num_sources,
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
 
@@ -910,6 +937,9 @@ static int find_renames(struct diff_score *mx, int dst_cnt, int minimum_score, i
 			continue;
 		record_rename_pair(mx[i].dst, mx[i].src, mx[i].score);
 		count++;
+		update_dir_rename_counts(info, dirs_removed,
+					 rename_src[mx[i].src].p->one->path,
+					 rename_dst[mx[i].dst].p->two->path);
 	}
 	return count;
 }
@@ -981,6 +1011,8 @@ void diffcore_rename_extended(struct diff_options *options,
 	info.setup = 0;
 	assert(!dir_rename_count || strmap_empty(dir_rename_count));
 	want_copies = (detect_rename == DIFF_DETECT_COPY);
+	if (dirs_removed && (break_idx || want_copies))
+		BUG("dirs_removed incompatible with break/copy detection");
 	if (!minimum_score)
 		minimum_score = DEFAULT_RENAME_SCORE;
 
@@ -1074,14 +1106,15 @@ void diffcore_rename_extended(struct diff_options *options,
 
 		/* Preparation for basename-driven matching. */
 		trace2_region_enter("diff", "dir rename setup", options->repo);
-		initialize_dir_rename_info(&info);
+		initialize_dir_rename_info(&info,
+					   dirs_removed, dir_rename_count);
 		trace2_region_leave("diff", "dir rename setup", options->repo);
 
 		/* Utilize file basenames to quickly find renames. */
 		trace2_region_enter("diff", "basename matches", options->repo);
 		rename_count += find_basename_matches(options,
 						      min_basename_score,
-						      &info);
+						      &info, dirs_removed);
 		trace2_region_leave("diff", "basename matches", options->repo);
 
 		/*
@@ -1167,18 +1200,15 @@ void diffcore_rename_extended(struct diff_options *options,
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
-- 
gitgitgadget

