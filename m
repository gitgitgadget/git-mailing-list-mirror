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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E88C12002
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 04:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B10361019
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 04:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhGUDoi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 23:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbhGUDne (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 23:43:34 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76920C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 21:24:11 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f8-20020a1c1f080000b029022d4c6cfc37so2631413wmf.5
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 21:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=H61kpePd0RggohlQhvjJVORWuqGjEcvAkljU5/g4MKQ=;
        b=vaXIoWAFK1BxG/cAOGDXaqB4MnK4bjcf5pPwHSYIBCbOkl3OabXubs66pSPMXcKRw+
         07K3YpjF0/XfkL+OjWSfAJ+cxJTLeSCn+BIEJ0N8IZOeSNF+tZCnB8F7twuAMiJsOPEp
         0HF805oF3ImzZTZkdEzs+uJBf5b/5lU168zn+FpPmPDOr+fesN2yvct3m2jPZnvtZ/Gc
         sc89NaccfLDUECacsXDcvFhfObxnN13mrWY2eCeSJv18wMI+Cw8tnN9yNYZUTbbXN2hB
         p7vXlNMuPUmD4Z2vdxx57Gt2BQz4fvzn3vXH43aCd7dqXR8wpgVlfmq8kP7Dl61AHxM6
         89Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=H61kpePd0RggohlQhvjJVORWuqGjEcvAkljU5/g4MKQ=;
        b=gEorEIvUMwlTPSgKHOyAR1vtofePdEgQhgur6C7qNnX1PRKDvYnvBLISgU5zD+CHde
         Ff323laiq75g88BFrFOKEb95xMzfprhFXXWCh09AhMIcci7nJIIrH6Otm0oCcl0NR4/m
         5HL9E3TDXCooSiUZjGX4Owup/qPyPpF7MiscxaDFXy0qGkBWi9TLLy1lNF5udfFxht97
         wsKCg7Is3sMmvdm+oCs4xxo169Mni1q5jTd/3C583tzJqaCbV7KqxRBqDgmJpz6GTG0k
         wbiL2ojGWJKNZ7Q42EaJ2Fs62vgT4mp4IGBRCUJ6MRnMXPkhWjfegep2Cot6Z4jhAYPn
         je4g==
X-Gm-Message-State: AOAM531zsA7w08GjNUwpu3gwb4NwZhE/xUCC9bZUBDrP2wS8Wv0SLZva
        ibsfD1nYyzj6A7nrp3EcBhil6To+JjA=
X-Google-Smtp-Source: ABdhPJxOrDYJZnhKg/29P4sdCOLzHXQv4XitoCK76FVN3Ng3QT0W2gEkNzTT9pJ8rHC0gOmOwLKyDQ==
X-Received: by 2002:a05:600c:4f05:: with SMTP id l5mr1857147wmq.96.1626841450045;
        Tue, 20 Jul 2021 21:24:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s6sm30330834wrt.45.2021.07.20.21.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 21:24:09 -0700 (PDT)
Message-Id: <c9ada8369e6575be488028aae0f654422a9b1410.1626841444.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.v4.git.1626841444.gitgitgadget@gmail.com>
References: <pull.988.v3.git.1626412958.gitgitgadget@gmail.com>
        <pull.988.v4.git.1626841444.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jul 2021 04:24:04 +0000
Subject: [PATCH v4 7/7] merge-ort: restart merge with cached renames to reduce
 process entry cost
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The merge algorithm mostly consists of the following three functions:
   collect_merge_info()
   detect_and_process_renames()
   process_entries()
Prior to the trivial directory resolution optimization of the last half
dozen commits, process_entries() was consistently the slowest, followed
by collect_merge_info(), then detect_and_process_renames().  When the
trivial directory resolution applies, it often dramatically decreases
the amount of time spent in the two slower functions.

Looking at the performance results in the previous commit, the trivial
directory resolution optimization helps amazingly well when there are no
relevant renames.  It also helps really well when reapplying a long
series of linear commits (such as in a rebase or cherry-pick), since the
relevant renames may well be cached from the first reapplied commit.
But when there are any relevant renames that are not cached (represented
by the just-one-mega testcase), then the optimization does not help at
all.

Often, I noticed that when the optimization does not apply, it is
because there are a handful of relevant sources -- maybe even only one.
It felt frustrating to need to recurse into potentially hundreds or even
thousands of directories just for a single rename, but it was needed for
correctness.

However, staring at this list of functions and noticing that
process_entries() is the most expensive and knowing I could avoid it if
I had cached renames suggested a simple idea: change
   collect_merge_info()
   detect_and_process_renames()
   process_entries()
into
   collect_merge_info()
   detect_and_process_renames()
   <cache all the renames, and restart>
   collect_merge_info()
   detect_and_process_renames()
   process_entries()

This may seem odd and look like more work.  However, note that although
we run collect_merge_info() twice, the second time we get to employ
trivial directory resolves, which makes it much faster, so the increased
time in collect_merge_info() is small.  While we run
detect_and_process_renames() again, all renames are cached so it's
nearly a no-op (we don't call into diffcore_rename_extended() but we do
have a little bit of data structure checking and fixing up).  And the
big payoff comes from the fact that process_entries(), will be much
faster due to having far fewer entries to process.

This restarting only makes sense if we can save recursing into enough
directories to make it worth our while.  Introduce a simple heuristic to
guide this.  Note that this heuristic uses a "wanted_factor" that I have
virtually no actual real world data for, just some back-of-the-envelope
quasi-scientific calculations that I included in some comments and then
plucked a simple round number out of thin air.  It could be that
tweaking this number to make it either higher or lower improves the
optimization.  (There's slightly more here; when I first introduced this
optimization, I used a factor of 10, because I was completely confident
it was big enough to not cause slowdowns in special cases.  I was
certain it was higher than needed.  Several months later, I added the
rough calculations which make me think the optimal number is close to 2;
but instead of pushing to the limit, I just bumped it to 3 to reduce the
risk that there are special cases where this optimization can result in
slowing down the code a little.  If the ratio of path counts is below 3,
we probably will only see minor performance improvements at best
anyway.)

Also, note that while the diffstat looks kind of long (nearly 100
lines), more than half of it is in two comments explaining how things
work.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:      205.1  ms ±  3.8  ms   204.2  ms ±  3.0  ms
    mega-renames:      1.564 s ±  0.010 s     1.076 s ±  0.015 s
    just-one-mega:   479.5  ms ±  3.9  ms   364.1  ms ±  7.0  ms

Acked-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c                         | 92 +++++++++++++++++++++++++++--
 t/t6423-merge-rename-directories.sh |  2 +-
 2 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index a013708fa79..e361443087a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -213,6 +213,7 @@ struct rename_info {
 	 *   MERGE_SIDE2: cached data from side2 can be reused
 	 *   MERGE_SIDE1: cached data from side1 can be reused
 	 *   0:           no cached data can be reused
+	 *   -1:          See redo_after_renames; both sides can be reused.
 	 */
 	int cached_pairs_valid_side;
 
@@ -258,6 +259,28 @@ struct rename_info {
 	 */
 	struct strset cached_irrelevant[3];
 
+	/*
+	 * redo_after_renames: optimization flag for "restarting" the merge
+	 *
+	 * Sometimes it pays to detect renames, cache them, and then
+	 * restart the merge operation from the beginning.  The reason for
+	 * this is that when we know where all the renames are, we know
+	 * whether a certain directory has any paths under it affected --
+	 * and if a directory is not affected then it permits us to do
+	 * trivial tree merging in more cases.  Doing trivial tree merging
+	 * prevents the need to run process_entry() on every path
+	 * underneath trees that can be trivially merged, and
+	 * process_entry() is more expensive than collect_merge_info() --
+	 * plus, the second collect_merge_info() will be much faster since
+	 * it doesn't have to recurse into the relevant trees.
+	 *
+	 * Values for this flag:
+	 *   0 = don't bother, not worth it (or conditions not yet checked)
+	 *   1 = conditions for optimization met, optimization worthwhile
+	 *   2 = we already did it (don't restart merge yet again)
+	 */
+	unsigned redo_after_renames;
+
 	/*
 	 * needed_limit: value needed for inexact rename detection to run
 	 *
@@ -541,7 +564,8 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		strintmap_func(&renames->relevant_sources[i]);
 		if (!reinitialize)
 			assert(renames->cached_pairs_valid_side == 0);
-		if (i != renames->cached_pairs_valid_side) {
+		if (i != renames->cached_pairs_valid_side &&
+		    -1 != renames->cached_pairs_valid_side) {
 			strset_func(&renames->cached_target_names[i]);
 			strmap_func(&renames->cached_pairs[i], 1);
 			strset_func(&renames->cached_irrelevant[i]);
@@ -1249,7 +1273,9 @@ static int handle_deferred_entries(struct merge_options *opt,
 	struct hashmap_iter iter;
 	struct strmap_entry *entry;
 	int side, ret = 0;
+	int path_count_before, path_count_after = 0;
 
+	path_count_before = strmap_get_size(&opt->priv->paths);
 	for (side = MERGE_SIDE1; side <= MERGE_SIDE2; side++) {
 		unsigned optimization_okay = 1;
 		struct strintmap copy;
@@ -1385,7 +1411,32 @@ static int handle_deferred_entries(struct merge_options *opt,
 						path));
 			resolve_trivial_directory_merge(ci, side);
 		}
+		if (!optimization_okay || path_count_after)
+			path_count_after = strmap_get_size(&opt->priv->paths);
 	}
+	if (path_count_after) {
+		/*
+		 * The choice of wanted_factor here does not affect
+		 * correctness, only performance.  When the
+		 *    path_count_after / path_count_before
+		 * ratio is high, redoing after renames is a big
+		 * performance boost.  I suspect that redoing is a wash
+		 * somewhere near a value of 2, and below that redoing will
+		 * slow things down.  I applied a fudge factor and picked
+		 * 3; see the commit message when this was introduced for
+		 * back of the envelope calculations for this ratio.
+		 */
+		const int wanted_factor = 3;
+
+		/* We should only redo collect_merge_info one time */
+		assert(renames->redo_after_renames == 0);
+
+		if (path_count_after / path_count_before >= wanted_factor) {
+			renames->redo_after_renames = 1;
+			renames->cached_pairs_valid_side = -1;
+		}
+	} else if (renames->redo_after_renames == 2)
+		renames->redo_after_renames = 0;
 	return ret;
 }
 
@@ -2828,8 +2879,8 @@ static int compare_pairs(const void *a_, const void *b_)
 }
 
 /* Call diffcore_rename() to update deleted/added pairs into rename pairs */
-static void detect_regular_renames(struct merge_options *opt,
-				   unsigned side_index)
+static int detect_regular_renames(struct merge_options *opt,
+				  unsigned side_index)
 {
 	struct diff_options diff_opts;
 	struct rename_info *renames = &opt->priv->renames;
@@ -2842,7 +2893,7 @@ static void detect_regular_renames(struct merge_options *opt,
 		 * side had directory renames.
 		 */
 		resolve_diffpair_statuses(&renames->pairs[side_index]);
-		return;
+		return 0;
 	}
 
 	partial_clear_dir_rename_count(&renames->dir_rename_count[side_index]);
@@ -2868,6 +2919,8 @@ static void detect_regular_renames(struct merge_options *opt,
 	trace2_region_leave("diff", "diffcore_rename", opt->repo);
 	resolve_diffpair_statuses(&diff_queued_diff);
 
+	if (diff_opts.needed_rename_limit > 0)
+		renames->redo_after_renames = 0;
 	if (diff_opts.needed_rename_limit > renames->needed_limit)
 		renames->needed_limit = diff_opts.needed_rename_limit;
 
@@ -2877,6 +2930,8 @@ static void detect_regular_renames(struct merge_options *opt,
 	diff_queued_diff.nr = 0;
 	diff_queued_diff.queue = NULL;
 	diff_flush(&diff_opts);
+
+	return 1;
 }
 
 /*
@@ -2966,14 +3021,32 @@ static int detect_and_process_renames(struct merge_options *opt,
 	struct diff_queue_struct combined;
 	struct rename_info *renames = &opt->priv->renames;
 	int need_dir_renames, s, clean = 1;
+	unsigned detection_run = 0;
 
 	memset(&combined, 0, sizeof(combined));
 	if (!possible_renames(renames))
 		goto cleanup;
 
 	trace2_region_enter("merge", "regular renames", opt->repo);
-	detect_regular_renames(opt, MERGE_SIDE1);
-	detect_regular_renames(opt, MERGE_SIDE2);
+	detection_run |= detect_regular_renames(opt, MERGE_SIDE1);
+	detection_run |= detect_regular_renames(opt, MERGE_SIDE2);
+	if (renames->redo_after_renames && detection_run) {
+		int i, side;
+		struct diff_filepair *p;
+
+		/* Cache the renames, we found */
+		for (side = MERGE_SIDE1; side <= MERGE_SIDE2; side++) {
+			for (i = 0; i < renames->pairs[side].nr; ++i) {
+				p = renames->pairs[side].queue[i];
+				possibly_cache_new_pair(renames, p, side, NULL);
+			}
+		}
+
+		/* Restart the merge with the cached renames */
+		renames->redo_after_renames = 2;
+		trace2_region_leave("merge", "regular renames", opt->repo);
+		goto cleanup;
+	}
 	use_cached_pairs(opt, &renames->cached_pairs[1], &renames->pairs[1]);
 	use_cached_pairs(opt, &renames->cached_pairs[2], &renames->pairs[2]);
 	trace2_region_leave("merge", "regular renames", opt->repo);
@@ -4390,6 +4463,7 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 					       opt->subtree_shift);
 	}
 
+redo:
 	trace2_region_enter("merge", "collect_merge_info", opt->repo);
 	if (collect_merge_info(opt, merge_base, side1, side2) != 0) {
 		/*
@@ -4409,6 +4483,12 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 	result->clean = detect_and_process_renames(opt, merge_base,
 						   side1, side2);
 	trace2_region_leave("merge", "renames", opt->repo);
+	if (opt->priv->renames.redo_after_renames == 2) {
+		trace2_region_enter("merge", "reset_maps", opt->repo);
+		clear_or_reinit_internal_opts(opt->priv, 1);
+		trace2_region_leave("merge", "reset_maps", opt->repo);
+		goto redo;
+	}
 
 	trace2_region_enter("merge", "process_entries", opt->repo);
 	process_entries(opt, &working_tree_oid);
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index e834b7e6efe..d8919d276a1 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -4797,7 +4797,7 @@ test_setup_12f () {
 	)
 }
 
-test_expect_merge_algorithm failure failure '12f: Trivial directory resolve, caching, all kinds of fun' '
+test_expect_merge_algorithm failure success '12f: Trivial directory resolve, caching, all kinds of fun' '
 	test_setup_12f &&
 	(
 		cd 12f &&
-- 
gitgitgadget
