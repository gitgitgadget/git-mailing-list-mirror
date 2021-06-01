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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEEEC47093
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 092DD613A9
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbhFAPAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 11:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbhFAPAW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 11:00:22 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED09C06175F
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 07:58:40 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n4so14698217wrw.3
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 07:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BrtiK6c6E7EWL2CwKQrOLK27at71WBUrJ7plYPI5xiY=;
        b=Y1SqhhieNkP0AGHKmEGbkaNikvNHFPLg+ChnQ81WnJ7tg57R2QI2cBvvPmHrLK2h8E
         v6O4gI6jHpCczZpF4ZGpvHU4r3aQibpDeYMmJU0ez9nlILSiOZ07dBrEwHt4d3nDGo7N
         dd+r7E6d44QNWqlT5wiCf7p8UzJfUV3Tq1ie2uxfl6i/UIF5m2dKcKc9qqCzRid2Bjrl
         BAOVNE/KkaHkvp5lIJ+m1J6IiQzrNWAMW9Bf46Met+6k8WZYA8gdlZiai7kz0CUSpkvs
         WD2geSLqBMdaNzPpMP9dgZmfcyRMn5oweeWd4W8uRan9falvfYiAqN0Yfk6BNh5ra6IX
         NI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BrtiK6c6E7EWL2CwKQrOLK27at71WBUrJ7plYPI5xiY=;
        b=WQr7/jMzi37IZu/8w0CeL0L+pzyr2QmSTXSS2RjkmusvSlEULfsANR/WEXmJ/5VDkx
         5+OE2BkkEhXObcBi127+OHY3CgiQdp75kDoPtFJb9epflMbUW6+U4qq3Q98TxzRgybOi
         MC4QdvVTSBnHy4+1BTHu4l5UfJaZ0CNc9025m9xf/qtH7YgzPugCfu8pKVcWhjwv8/be
         6gUK2UD8Fvzve9i7bFe4hQjYY20zxd2QRdnmTF8V2Bf+cMP/l7IthX9P08hx2YyR9GKg
         DPWmzuZW9EL0mQ6V/FdqjE/S5TjflAp19iXZXTVD7xHnkHYaQGcPX1BoxlSCNFkdk0hU
         yjvQ==
X-Gm-Message-State: AOAM532rLjZKhh6JVSUBEr/f0V1rJw+0/AgBtKRsV/RfFkaONcBHW7qI
        SdPuAjriyqq/u8eTuTROMr0HLeyGKxU=
X-Google-Smtp-Source: ABdhPJwhf1V71Kjl1iu61NSeKOX40CKEYIKrz71ukLXrT/BtvZC7rJKBJ0A/bL2zaRhuWCaFD4z2eA==
X-Received: by 2002:a5d:638b:: with SMTP id p11mr28136327wru.90.1622559519307;
        Tue, 01 Jun 2021 07:58:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm3478289wrr.48.2021.06.01.07.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:58:39 -0700 (PDT)
Message-Id: <45e1de5fe7808f5297d5e33d14c239d74de33bdc.1622559516.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
References: <pull.962.git.1622104642.gitgitgadget@gmail.com>
        <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Jun 2021 14:58:33 +0000
Subject: [PATCH v2 3/5] diffcore-rename: enable limiting rename detection to
 relevant destinations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
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
index 0fe2eaf02eb2..28951c35ddc2 100644
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

