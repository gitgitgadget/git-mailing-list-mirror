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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E09C433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 21:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C674861581
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 21:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbhCXVdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 17:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbhCXVcm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 17:32:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3326C06174A
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 14:32:41 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x13so226694wrs.9
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 14:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=S2bMsGGSF7D1TN6tGpEGniPpAauwDkTbmqQnwnF6mW8=;
        b=Nn0275kXVdprVf3cu6jqCTq0XOWRi/P7Mq8cAk8MXuEEFRRbnAYK6dqsVe4T98HR2Y
         fZJs7pXMTUmii2RKVMZOptduG6FlFJkgmdcrxoKNo8vsT2TylWlIgswB2oyLx1xuQ3zZ
         /Cuzlk7OXUGhOv0LrdsIFREdmZmBXaNrz2UrY2O2s/nPsPZGb42Z01O7WXunxRTwy0h9
         hxMToonKXShTPsgFjoZ93/ZtPQvx4viKD2DFTp+ymyuNDPJgdWK3SyxwVOTyyck8wUjK
         rqvYgZ0uIKeCfWgW0E3mR00HqTps8V9zFcEbFygJmW8NKQP3woDwYak/AsJ9E++fkpo9
         fPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=S2bMsGGSF7D1TN6tGpEGniPpAauwDkTbmqQnwnF6mW8=;
        b=aq7jc7kkuGtR3zw3Io+/6uNrIAkyl9xaHHKMvUnDY15ybk+nvxejfi9iCRBBF4qMg4
         P9UVx4wczgcTUeZWrIUXiXKWpiG9W5dc0GBvS882Gr5D9pHAf7pxC+mfRd7/ufnuqCg6
         qRHJvfdlDDcvlArHjhxhRB8NCuvRbuW7bZON5Qfhb+PtTRYDGtyDtpBCXquFLejDgVQP
         T4kddOdZkDJo84Uw6kI+so9vSAj8c4Pxzbljr/qU31e0XR0pUVVHDkx/SPOBHdGDj/Fs
         XN+GejbAz6q6tnolUY44+iCe2n2A/Xek5fd3uHb+dQNem2FuuxLyi7NJebRTFDJl/i/W
         oBwQ==
X-Gm-Message-State: AOAM533WU4VckY85VzPUtwbBX3bCPkYeaawlFQpKON9Va8wTaFp+eG3c
        wLjzl7q7+EWXU2GVkzCgoVMT+Y40eZU=
X-Google-Smtp-Source: ABdhPJwPTgOe2pcqSqOIng2Y/MoWXivEfYQfiH+3g9fEmeTmolfg8UkkLgrN5UoV35TWpGXhu8pflg==
X-Received: by 2002:a5d:5047:: with SMTP id h7mr5692228wrt.111.1616621560448;
        Wed, 24 Mar 2021 14:32:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d204sm4072068wmc.17.2021.03.24.14.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:32:40 -0700 (PDT)
Message-Id: <d1016c342d690b25da6f438bbcdd200917442531.1616621554.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.git.1616621553.gitgitgadget@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Mar 2021 21:32:33 +0000
Subject: [PATCH 7/7] merge-ort, diffcore-rename: employ cached renames when
 possible
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
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

When there are many renames between the old base of a series of commits
and the new base, the way sequencer.c, merge-recursive.c, and
diffcore-rename.c have traditionally split the work resulted in
redetecting the same renames with each and every commit being
transplanted.  To address this, the last several commits have been
creating a cache of rename detection results, determining when it was
safe to use such a cache in subsequent merge operations, adding helper
functions, and so on.  See the previous half dozen commit messages for
additional discussion of this optimization, particularly the message a
few commits ago entitled "add code to check for whether cached renames
can be reused".  This commit finally ties all of that work together,
modifying the merge algorithm to make use of these cached renames.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:        5.665 s ±  0.129 s     5.624 s ±  0.077 s
    mega-renames:     11.435 s ±  0.158 s    10.213 s ±  0.032 s
    just-one-mega:   494.2  ms ±  6.1  ms   497.6  ms ±  5.3  ms

That's a fairly small improvement, but mostly because the previous
optimizations were so effective for these particular testcases; this
optimization only kicks in when the others don't.  If we undid the
basename-guided rename detection and skip-irrelevant-renames
optimizations, then we'd see that this series by itself improved
performance as follows:

                   Before Basename Series   After Just This Series
    no-renames:      13.815 s ±  0.062 s      5.814 s ±  0.094 s
    mega-renames:  1799.937 s ±  0.493 s    303.225 s ±  1.330 s

Since this optimization kicks in to help accelerate cases where the
previous optimizations do not apply, this last comparison shows that
this cached-renames optimization has the potential to help signficantly
in cases that don't meet the requirements for the other optimizations to
be effective.

The changes made in this optimization also lay some important groundwork
for a future optimization around having collect_merge_info() avoid
recursing into subtrees in more cases.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 22 ++++++++++++++++++----
 diffcore.h        |  3 ++-
 merge-ort.c       | 48 ++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 63 insertions(+), 10 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 7cc24592617e..dfbe65c917e9 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -568,7 +568,8 @@ static void update_dir_rename_counts(struct dir_rename_info *info,
 static void initialize_dir_rename_info(struct dir_rename_info *info,
 				       struct strintmap *relevant_sources,
 				       struct strintmap *dirs_removed,
-				       struct strmap *dir_rename_count)
+				       struct strmap *dir_rename_count,
+				       struct strmap *cached_pairs)
 {
 	struct hashmap_iter iter;
 	struct strmap_entry *entry;
@@ -633,6 +634,17 @@ static void initialize_dir_rename_info(struct dir_rename_info *info,
 					 rename_dst[i].p->two->path);
 	}
 
+	/* Add cached_pairs to counts */
+	strmap_for_each_entry(cached_pairs, &iter, entry) {
+		const char *old_name = entry->key;
+		const char *new_name = entry->value;
+		if (!new_name)
+			/* known delete; ignore it */
+			continue;
+
+		update_dir_rename_counts(info, dirs_removed, old_name, new_name);
+	}
+
 	/*
 	 * Now we collapse
 	 *    dir_rename_count: old_directory -> {new_directory -> count}
@@ -1247,7 +1259,8 @@ static void handle_early_known_dir_renames(struct dir_rename_info *info,
 void diffcore_rename_extended(struct diff_options *options,
 			      struct strintmap *relevant_sources,
 			      struct strintmap *dirs_removed,
-			      struct strmap *dir_rename_count)
+			      struct strmap *dir_rename_count,
+			      struct strmap *cached_pairs)
 {
 	int detect_rename = options->detect_rename;
 	int minimum_score = options->rename_score;
@@ -1363,7 +1376,8 @@ void diffcore_rename_extended(struct diff_options *options,
 		/* Preparation for basename-driven matching. */
 		trace2_region_enter("diff", "dir rename setup", options->repo);
 		initialize_dir_rename_info(&info, relevant_sources,
-					   dirs_removed, dir_rename_count);
+					   dirs_removed, dir_rename_count,
+					   cached_pairs);
 		trace2_region_leave("diff", "dir rename setup", options->repo);
 
 		/* Utilize file basenames to quickly find renames. */
@@ -1561,5 +1575,5 @@ void diffcore_rename_extended(struct diff_options *options,
 
 void diffcore_rename(struct diff_options *options)
 {
-	diffcore_rename_extended(options, NULL, NULL, NULL);
+	diffcore_rename_extended(options, NULL, NULL, NULL, NULL);
 }
diff --git a/diffcore.h b/diffcore.h
index cf8d4cb8617d..de01e64becaf 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -181,7 +181,8 @@ void diffcore_rename(struct diff_options *);
 void diffcore_rename_extended(struct diff_options *options,
 			      struct strintmap *relevant_sources,
 			      struct strintmap *dirs_removed,
-			      struct strmap *dir_rename_count);
+			      struct strmap *dir_rename_count,
+			      struct strmap *cached_pairs);
 void diffcore_merge_broken(void);
 void diffcore_pickaxe(struct diff_options *);
 void diffcore_order(const char *orderfile);
diff --git a/merge-ort.c b/merge-ort.c
index 8d0353ffbca2..719222aa4364 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -752,15 +752,48 @@ static void add_pair(struct merge_options *opt,
 	struct rename_info *renames = &opt->priv->renames;
 	int names_idx = is_add ? side : 0;
 
-	if (!is_add) {
+	if (is_add) {
+		if (strset_contains(&renames->cached_target_names[side],
+				    pathname))
+			return;
+	} else {
 		unsigned content_relevant = (match_mask == 0);
 		unsigned location_relevant = (dir_rename_mask == 0x07);
 
+		/*
+		 * If pathname is found in cached_irrelevant[side] due to
+		 * previous pick but for this commit content is relevant,
+		 * then we need to remove it from cached_irrelevant.
+		 */
+		if (content_relevant)
+			/* strset_remove is no-op if strset doesn't have key */
+			strset_remove(&renames->cached_irrelevant[side],
+				      pathname);
+
+		/*
+		 * We do not need to re-detect renames for paths that we already
+		 * know the pairing, i.e. for cached_pairs (or
+		 * cached_irrelevant).  However, handle_deferred_entries() needs
+		 * to loop over the union of keys from relevant_sources[side] and
+		 * cached_pairs[side], so for simplicity we set relevant_sources
+		 * for all the cached_pairs too and then strip them back out in
+		 * prune_cached_from_relevant() at the beginning of
+		 * detect_regular_renames().
+		 */
 		if (content_relevant || location_relevant) {
 			/* content_relevant trumps location_relevant */
 			strintmap_set(&renames->relevant_sources[side], pathname,
 				      content_relevant ? RELEVANT_CONTENT : RELEVANT_LOCATION);
 		}
+
+		/*
+		 * Avoid creating pair if we've already cached rename results.
+		 * Note that we do this after setting relevant_sources[side]
+		 * as noted in the comment above.
+		 */
+		if (strmap_contains(&renames->cached_pairs[side], pathname) ||
+		    strset_contains(&renames->cached_irrelevant[side], pathname))
+			return;
 	}
 
 	one = alloc_filespec(pathname);
@@ -2336,7 +2369,9 @@ static inline int possible_side_renames(struct rename_info *renames,
 static inline int possible_renames(struct rename_info *renames)
 {
 	return possible_side_renames(renames, 1) ||
-	       possible_side_renames(renames, 2);
+	       possible_side_renames(renames, 2) ||
+	       !strmap_empty(&renames->cached_pairs[1]) ||
+	       !strmap_empty(&renames->cached_pairs[2]);
 }
 
 static void resolve_diffpair_statuses(struct diff_queue_struct *q)
@@ -2360,7 +2395,6 @@ static void resolve_diffpair_statuses(struct diff_queue_struct *q)
 	}
 }
 
-MAYBE_UNUSED
 static void prune_cached_from_relevant(struct rename_info *renames,
 				       unsigned side)
 {
@@ -2380,7 +2414,6 @@ static void prune_cached_from_relevant(struct rename_info *renames,
 	}
 }
 
-MAYBE_UNUSED
 static void use_cached_pairs(struct merge_options *opt,
 			     struct strmap *cached_pairs,
 			     struct diff_queue_struct *pairs)
@@ -2463,6 +2496,7 @@ static void detect_regular_renames(struct merge_options *opt,
 	struct diff_options diff_opts;
 	struct rename_info *renames = &opt->priv->renames;
 
+	prune_cached_from_relevant(renames, side_index);
 	if (!possible_side_renames(renames, side_index)) {
 		/*
 		 * No rename detection needed for this side, but we still need
@@ -2473,6 +2507,7 @@ static void detect_regular_renames(struct merge_options *opt,
 		return;
 	}
 
+	partial_clear_dir_rename_count(&renames->dir_rename_count[side_index]);
 	repo_diff_setup(opt->repo, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.flags.rename_empty = 0;
@@ -2490,7 +2525,8 @@ static void detect_regular_renames(struct merge_options *opt,
 	diffcore_rename_extended(&diff_opts,
 				 &renames->relevant_sources[side_index],
 				 &renames->dirs_removed[side_index],
-				 &renames->dir_rename_count[side_index]);
+				 &renames->dir_rename_count[side_index],
+				 &renames->cached_pairs[side_index]);
 	trace2_region_leave("diff", "diffcore_rename", opt->repo);
 	resolve_diffpair_statuses(&diff_queued_diff);
 
@@ -2597,6 +2633,8 @@ static int detect_and_process_renames(struct merge_options *opt,
 	trace2_region_enter("merge", "regular renames", opt->repo);
 	detect_regular_renames(opt, MERGE_SIDE1);
 	detect_regular_renames(opt, MERGE_SIDE2);
+	use_cached_pairs(opt, &renames->cached_pairs[1], &renames->pairs[1]);
+	use_cached_pairs(opt, &renames->cached_pairs[2], &renames->pairs[2]);
 	trace2_region_leave("merge", "regular renames", opt->repo);
 
 	trace2_region_enter("merge", "directory renames", opt->repo);
-- 
gitgitgadget
