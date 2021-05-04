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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B889C43460
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DA361090
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhEDCNb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 22:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhEDCN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 22:13:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA05AC061761
        for <git@vger.kernel.org>; Mon,  3 May 2021 19:12:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l2so7576917wrm.9
        for <git@vger.kernel.org>; Mon, 03 May 2021 19:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=VHq4eFBssq3qbrsKbo9x1MjyEgTohsx7I6PXz2mZkXA=;
        b=NBJCfvvaq7cq89AjY+6JpzEJjr0zGP6TO2FxGbZNR9eOqUyGGEYUxNfbv8Xx/npRS6
         KUSNqoUxq+Z96jUPmXtNSkzK4YVut9zauXMB5+fwvfCoGhNMMKNefG45Etg5poaS7SVi
         iln2m4xT3BwxD+PM/Xw36ZcdJDqIo7tcCkoycK5DeJRBtLT3lu/4FTAZuvcYfWWMN0B5
         UT7kd2jAdEPLGwRTOgjVepK97S8M4pRkl87zrZWc3SjeWl1kt1MLXjlg7Bq6b6HaD8sz
         jpMU5bv2Yw41pYG7+C3YP2sKWyYfpDxvPDhNETB8aQH9B0Gwtofz3RU1M5D/qYo8+SsL
         MFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=VHq4eFBssq3qbrsKbo9x1MjyEgTohsx7I6PXz2mZkXA=;
        b=CYKEbTQfzyQQT3G8Od0BUEwAtM/DiEnu/2yVKB7z8r6rXwaMt9kVvDkMWmqUiW5lrX
         o92Q0ZMpCVYu7wB+XatYlN80oW+nnBS5gor28DBpm1hcPm9J7/yGdl+5SafRg5RfQ+3f
         z0CXMLrLdpqylwVtYqVhTWTDagFOGnDHz7pOiQzar+kVwJ9WRUi2tk/LPrUQrb1NHFmI
         8eNuvRmbbVYFW6ZKrR9TgQvI4y2EF+ABF7hXOg+0XkcROz31wpzl39Q3dTEVTrBsGk5t
         gvLkr5xICSw57VHXBirPxX3wNjwObQxAIaa7ErfaKM0SOUJdn9/NDO6ok8b4rTXseCZe
         HOZg==
X-Gm-Message-State: AOAM531v+0NAcxc9uDMy08yng/9Q+j2+jKxtl1oEZ/qQc2ZbVGpUonf5
        I09AHglGQwYxc6jBqLLdmH9hfXIu7vs=
X-Google-Smtp-Source: ABdhPJx9YrXqmsj7Xya/jszSnH+Seyh+a0CIOSrx71fZKTmdHzg56uBHWYOQgH4X2MUPnofJ98z6Rw==
X-Received: by 2002:adf:f60d:: with SMTP id t13mr19877400wrp.189.1620094351477;
        Mon, 03 May 2021 19:12:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7sm13814751wri.14.2021.05.03.19.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 19:12:31 -0700 (PDT)
Message-Id: <91b6768adf2d1777219fb2d83cc2363f1497dbbd.1620094339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
        <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 May 2021 02:12:19 +0000
Subject: [PATCH v2 13/13] merge-ort, diffcore-rename: employ cached renames
 when possible
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
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
    no-renames:        5.665 s ±  0.129 s     5.622 s ±  0.059 s
    mega-renames:     11.435 s ±  0.158 s    10.127 s ±  0.073 s
    just-one-mega:   494.2  ms ±  6.1  ms   500.3  ms ±  3.8  ms

That's a fairly small improvement, but mostly because the previous
optimizations were so effective for these particular testcases; this
optimization only kicks in when the others don't.  If we undid the
basename-guided rename detection and skip-irrelevant-renames
optimizations, then we'd see that this series by itself improved
performance as follows:

                   Before Basename Series   After Just This Series
    no-renames:      13.815 s ±  0.062 s      5.697 s ±  0.080 s
    mega-renames:  1799.937 s ±  0.493 s    205.709 s ±  0.457 s

Since this optimization kicks in to help accelerate cases where the
previous optimizations do not apply, this last comparison shows that
this cached-renames optimization has the potential to help signficantly
in cases that don't meet the requirements for the other optimizations to
be effective.

The changes made in this optimization also lay some important groundwork
for a future optimization around having collect_merge_info() avoid
recursing into subtrees in more cases.

However, for this optimization to be effective, merge_switch_to_result()
should only be called when the rebase or cherry-pick operation has
either completed or hit a case where the user needs to resolve a
conflict or edit the result.  If it is called after every commit, as
sequencer.c does, then the working tree and index are needlessly updated
with every commit and the cached metadata is tossed, defeating this
optimization.  Refactoring sequencer.c to only call
merge_switch_to_result() at the end of the operation is a bigger
undertaking, and the practical benefits of this optimization will not be
realized until that work is performed.  Since `test-tool fast-rebase`
only updates at the end of the operation, it was used to obtain the
timings above.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c                        | 22 +++++++++--
 diffcore.h                               |  3 +-
 merge-ort.c                              | 47 ++++++++++++++++++++---
 t/t6429-merge-sequence-rename-caching.sh | 48 ++++++++++++++----------
 4 files changed, 90 insertions(+), 30 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 963ca582216b..3375e24659ea 100644
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
@@ -1560,5 +1574,5 @@ void diffcore_rename_extended(struct diff_options *options,
 
 void diffcore_rename(struct diff_options *options)
 {
-	diffcore_rename_extended(options, NULL, NULL, NULL);
+	diffcore_rename_extended(options, NULL, NULL, NULL, NULL);
 }
diff --git a/diffcore.h b/diffcore.h
index f5c6de4841ed..533b30e21e7f 100644
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
index 2fc98b803d1c..17dc3deb3c73 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -753,15 +753,48 @@ static void add_pair(struct merge_options *opt,
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
@@ -2349,7 +2382,9 @@ static inline int possible_side_renames(struct rename_info *renames,
 static inline int possible_renames(struct rename_info *renames)
 {
 	return possible_side_renames(renames, 1) ||
-	       possible_side_renames(renames, 2);
+	       possible_side_renames(renames, 2) ||
+	       !strmap_empty(&renames->cached_pairs[1]) ||
+	       !strmap_empty(&renames->cached_pairs[2]);
 }
 
 static void resolve_diffpair_statuses(struct diff_queue_struct *q)
@@ -2373,7 +2408,6 @@ static void resolve_diffpair_statuses(struct diff_queue_struct *q)
 	}
 }
 
-MAYBE_UNUSED
 static void prune_cached_from_relevant(struct rename_info *renames,
 				       unsigned side)
 {
@@ -2393,7 +2427,6 @@ static void prune_cached_from_relevant(struct rename_info *renames,
 	}
 }
 
-MAYBE_UNUSED
 static void use_cached_pairs(struct merge_options *opt,
 			     struct strmap *cached_pairs,
 			     struct diff_queue_struct *pairs)
@@ -2494,6 +2527,7 @@ static void detect_regular_renames(struct merge_options *opt,
 	struct diff_options diff_opts;
 	struct rename_info *renames = &opt->priv->renames;
 
+	prune_cached_from_relevant(renames, side_index);
 	if (!possible_side_renames(renames, side_index)) {
 		/*
 		 * No rename detection needed for this side, but we still need
@@ -2522,7 +2556,8 @@ static void detect_regular_renames(struct merge_options *opt,
 	diffcore_rename_extended(&diff_opts,
 				 &renames->relevant_sources[side_index],
 				 &renames->dirs_removed[side_index],
-				 &renames->dir_rename_count[side_index]);
+				 &renames->dir_rename_count[side_index],
+				 &renames->cached_pairs[side_index]);
 	trace2_region_leave("diff", "diffcore_rename", opt->repo);
 	resolve_diffpair_statuses(&diff_queued_diff);
 
@@ -2629,6 +2664,8 @@ static int detect_and_process_renames(struct merge_options *opt,
 	trace2_region_enter("merge", "regular renames", opt->repo);
 	detect_regular_renames(opt, MERGE_SIDE1);
 	detect_regular_renames(opt, MERGE_SIDE2);
+	use_cached_pairs(opt, &renames->cached_pairs[1], &renames->pairs[1]);
+	use_cached_pairs(opt, &renames->cached_pairs[2], &renames->pairs[2]);
 	trace2_region_leave("merge", "regular renames", opt->repo);
 
 	trace2_region_enter("merge", "directory renames", opt->repo);
diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
index f47d8924ee73..035edc40b1eb 100755
--- a/t/t6429-merge-sequence-rename-caching.sh
+++ b/t/t6429-merge-sequence-rename-caching.sh
@@ -101,10 +101,10 @@ test_expect_success 'caching renames does not preclude finding new ones' '
 # dramatic change in size of the file, but remembering the rename and
 # reusing it is reasonable too.
 #
-# Rename detection (diffcore_rename_extended()) will run twice here; it is
-# not needed on the topic side of history for either of the two commits
-# being merged, but it is needed on the upstream side of history for each
-# commit being picked.
+# We do test here that we expect rename detection to only be run once total
+# (the topic side of history doesn't need renames, and with caching we
+# should be able to only run rename detection on the upstream side one
+# time.)
 test_expect_success 'cherry-pick both a commit and its immediate revert' '
 	test_create_repo pick-commit-and-its-immediate-revert &&
 	(
@@ -140,11 +140,11 @@ test_expect_success 'cherry-pick both a commit and its immediate revert' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test_might_fail test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		test-tool fast-rebase --onto HEAD upstream~1 topic &&
 		#git cherry-pick upstream~1..topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
-		test_line_count = 2 calls
+		test_line_count = 1 calls
 	)
 '
 
@@ -304,9 +304,11 @@ test_expect_success 'rename same file identically, then add file to old dir' '
 # Here we are just concerned that cached renames might prevent us from seeing
 # the rename conflict, and we want to ensure that we do get a conflict.
 #
-# While at it, also test that we do rename detection three times.  We have to
-# detect renames on the upstream side of history once for each merge, plus
-# Topic_2 has renames.
+# While at it, though, we do test that we only try to detect renames 2
+# times and not three.  (The first merge needs to detect renames on the
+# upstream side.  Traditionally, the second merge would need to detect
+# renames on both sides of history, but our caching of upstream renames
+# should avoid the need to re-detect upstream renames.)
 #
 test_expect_success 'cached dir rename does not prevent noticing later conflict' '
 	test_create_repo dir-rename-cache-not-occluding-later-conflict &&
@@ -357,7 +359,7 @@ test_expect_success 'cached dir rename does not prevent noticing later conflict'
 		grep CONFLICT..rename/rename output &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
-		test_line_count = 3 calls
+		test_line_count = 2 calls
 	)
 '
 
@@ -412,10 +414,17 @@ test_setup_upstream_rename () {
 # commit to mess up its location either.  We want to make sure that
 # olddir/newfile doesn't exist in the result and that newdir/newfile does.
 #
-# We also expect rename detection to occur three times.  Although it is
-# typically needed two times per commit, there are no deleted files on the
-# topic side of history, so we only need to detect renames on the upstream
-# side for each of the 3 commits we need to pick.
+# We also test that we only do rename detection twice.  We never need
+# rename detection on the topic side of history, but we do need it twice on
+# the upstream side of history.  For the first topic commit, we only need
+# the
+#   relevant-rename -> renamed
+# rename, because olddir is unmodified by Topic_1.  For Topic_2, however,
+# the new file being added to olddir means files that were previously
+# irrelevant for rename detection are now relevant, forcing us to repeat
+# rename detection for the paths we don't already have cached.  Topic_3 also
+# tweaks olddir/newfile, but the renames in olddir/ will have been cached
+# from the second rename detection run.
 #
 test_expect_success 'dir rename unneeded, then add new file to old dir' '
 	test_setup_upstream_rename dir-rename-unneeded-until-new-file &&
@@ -450,7 +459,7 @@ test_expect_success 'dir rename unneeded, then add new file to old dir' '
 		#git cherry-pick upstream..topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
-		test_line_count = 3 calls &&
+		test_line_count = 2 calls &&
 
 		git ls-files >tracked &&
 		test_line_count = 5 tracked &&
@@ -516,7 +525,7 @@ test_expect_success 'dir rename unneeded, then rename existing file into old dir
 		#git cherry-pick upstream..topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
-		test_line_count = 4 calls &&
+		test_line_count = 3 calls &&
 
 		test_path_is_missing somefile &&
 		test_path_is_missing olddir/newfile &&
@@ -648,9 +657,8 @@ test_expect_success 'caching renames only on upstream side, part 1' '
 # for the wrong side of history.
 #
 #
-# This testcase should only need three calls to diffcore_rename_extended(),
-# because there are no renames on the topic side of history for picking
-# Topic_2.
+# This testcase should only need two calls to diffcore_rename_extended(),
+# both for the first merge, one for each side of history.
 #
 test_expect_success 'caching renames only on upstream side, part 2' '
 	test_setup_topic_rename cache-renames-only-upstream-rename-file &&
@@ -677,7 +685,7 @@ test_expect_success 'caching renames only on upstream side, part 2' '
 		#git cherry-pick upstream..topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
-		test_line_count = 3 calls &&
+		test_line_count = 2 calls &&
 
 		git ls-files >tracked &&
 		test_line_count = 4 tracked &&
-- 
gitgitgadget
