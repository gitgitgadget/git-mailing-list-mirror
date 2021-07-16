Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3188C07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 05:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 825B7613ED
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 05:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhGPFZh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 01:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbhGPFZg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 01:25:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148ACC06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 22:22:41 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k4so10566451wrc.8
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 22:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=DlxTLAz62R4gfwAmCex3Nx7uj1xGV2Y6gkuJdvINq5o=;
        b=MV7FNdUDwi92ozWE3PAt/bMNQ6fRddCSzALEulyuXC6mcUQaNXyDQbRi59bBCMw4P0
         pWX0ka8XPmEF/dxTJ4nOzA6vGIskLv1+USRsCFdIHNrfTXEPlRP0XUOQhRwvJmvjxt4+
         8wXukcAUcz+TwomLlMkmhj/mvcthYcu/vfLoMSzY5wzdZ5KxSUjUseCWPcbd+wuuqTds
         XHlKFmaT+ihbYlznKnKvkldS7hQVej9tL29fPBhFeXGLc+xGIOZl1Hky8N9hCZZF8XJO
         BMXM+dDdoqQwGGVgOK4z9fJbm4KArtuZ0tDXOWD2C/veckxRGLD3Lyw7hBiBwuE1TCcU
         65VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=DlxTLAz62R4gfwAmCex3Nx7uj1xGV2Y6gkuJdvINq5o=;
        b=qqmNCHvS5Raa/7ao6NpNfGmGVX6vh7IM0tUatMfLT2tNswUUUsp6HQmiUerY2TtK+d
         VfRV07vrRLiW77C0kkgqN0CC4IEfC7gquh19BpNN4vadfcFTrEHRJlWkYVjCvodG2FZV
         aGjayH5enN1JmXo07HA2PBnP0WeETSGxiCJXPAvtE5h8IrAlWXfC9+vdr7UyKeoIZbAt
         +cV7EszqC1ykGQX52aE40ms+CuKB6TdKBewv2BxkEc3wMRFnozLs4ImTSaepnNWKEHRk
         glUPpPK2qJvSK0n9RyBotMA/87mUPLFkMjZdL/5R2tWHqVqAJQc4kzG/SgJ4h+UaFBHT
         QkjQ==
X-Gm-Message-State: AOAM533o8vTlTfLaq+CA5HrO4wGh1gbDmF8JiFDV6Y2t3CBhqOIMsGVW
        dXg+wG/nxq88v3D9U1NasoG2lOjx/qM=
X-Google-Smtp-Source: ABdhPJwvQb3WVa3SPTNdFKVcUODPWDyAgwIv/Apw3ww+J0vOxTNVqmfu9VbRzLF6afhcqUBjT4Y/lQ==
X-Received: by 2002:adf:d088:: with SMTP id y8mr9779730wrh.69.1626412959507;
        Thu, 15 Jul 2021 22:22:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x9sm8908139wrm.82.2021.07.15.22.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 22:22:39 -0700 (PDT)
Message-Id: <pull.988.v3.git.1626412958.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
References: <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Jul 2021 05:22:30 +0000
Subject: [PATCH v3 0/7] Optimization batch 14: trivial directory resolution
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends textually on ort-perf-batch-12, but is semantically
independent. (It is both semantically and textually independent of
ort-perf-batch-13.)

Most of my previous series dramatically accelerated cases with lots of
renames, while providing comparatively minor benefits for cases with few or
no renames. This series is the opposite; it provides huge benefits when
there are few or no renames, and comparatively smaller (though still quite
decent) benefits for cases with many uncached renames.

Changes since v2, addressing feedback from Stolee:

 * Created a separate struct for three related variables to hint they are
   related
 * Simplified a lengthy comment that was duplicated by the commit message
 * Various other minor cleanups

Changes since v1:

 * Minor tweak to the final patch to correct implicit assumption that rename
   detection running implies all renames were found (rename limits could
   have been exceeded and prevented finding renames)

=== Basic Optimization idea ===

unpack_trees has had a concept of trivial merges for individual files (see
Documentation/technical/trivial-merge.txt). The same idea can be applied in
merge-ort. It'd be really nice to extend that idea to trees as well, as it
could provide a huge performance boost; sadly however, applying it in
general would wreck both regular rename detection (the unmatched side can
have new files that serve as potential destinations in rename detection) and
directory rename detection (the unmatched side could have a new directory
that was moved into it).

If we somehow knew rename detection wasn't needed, we could do trivial
directory resolution. In the past, this wasn't possible. However...

With recent optimizations we have created a possibility to do trivial
directory resolutions in some cases. These came from the addition of the
"skipping irrelevant renames" optimizations (from ort-perf-batch-9 and
ort-perf-batch-10), and in particular noting that we added an ability to
entirely skip rename detection in commit f89b4f2bee ("merge-ort: skip rename
detection entirely if possible", 2021-03-11) when there are no relevant
sources. We can detect if there are no relevant sources without recursing
into the directories in question.

As a cherry on top, the caching of renames (from ort-perf-batch-11) allows
us to cover additional cases.

This series is all about adding all the special checks needed to safely
perform trival directory resolutions.

=== Results ===

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28), the
changes in just this series improves the performance as follows:

                     Before Series           After Series
no-renames:        5.235 s ±  0.042 s   204.2  ms ±  3.0  ms
mega-renames:      9.419 s ±  0.107 s     1.076 s ±  0.015 s
just-one-mega:   480.1  ms ±  3.9  ms   364.1  ms ±  7.0  ms


As a reminder, before any merge-ort/diffcore-rename performance work, the
performance results we started with (for merge-recursive as of git-2.30.0)
were:

no-renames-am:      6.940 s ±  0.485 s
no-renames:        18.912 s ±  0.174 s
mega-renames:    5964.031 s ± 10.459 s
just-one-mega:    149.583 s ±  0.751 s


Elijah Newren (7):
  merge-ort: resolve paths early when we have sufficient information
  merge-ort: add some more explanations in collect_merge_info_callback()
  merge-ort: add data structures for allowable trivial directory
    resolves
  merge-ort: add a handle_deferred_entries() helper function
  merge-ort: defer recursing into directories when merge base is matched
  merge-ort: avoid recursing into directories when we don't need to
  merge-ort: restart merge with cached renames to reduce process entry
    cost

 merge-ort.c                         | 399 +++++++++++++++++++++++++++-
 t/t6423-merge-rename-directories.sh |   2 +-
 2 files changed, 389 insertions(+), 12 deletions(-)


base-commit: 2eeee12b02e441ac05054a5a5ecbcea6964a1e6b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-988%2Fnewren%2Fort-perf-batch-14-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-988/newren/ort-perf-batch-14-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/988

Range-diff vs v2:

 1:  5dca982c0b0 = 1:  5dca982c0b0 merge-ort: resolve paths early when we have sufficient information
 2:  8aea3713902 = 2:  8aea3713902 merge-ort: add some more explanations in collect_merge_info_callback()
 3:  f7ac01055d9 ! 3:  c2b45fef1d7 merge-ort: add data structures for allowable trivial directory resolves
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort.c ##
     -@@ merge-ort.c: struct rename_info {
     - 	 */
     - 	struct strintmap relevant_sources[3];
     +@@ merge-ort.c: struct traversal_callback_data {
     + 	struct name_entry names[3];
     + };
       
     ++struct deferred_traversal_data {
      +	/*
     -+	 * possible_trivial_merges: directories we defer recursing into
     ++	 * possible_trivial_merges: directories to be explored only when needed
      +	 *
      +	 * possible_trivial_merges is a map of directory names to
      +	 * dir_rename_mask.  When we detect that a directory is unchanged on
     @@ merge-ort.c: struct rename_info {
      +	 * information we need, other than the path, to resume the recursive
      +	 * traversal.
      +	 */
     -+	struct strintmap possible_trivial_merges[3];
     ++	struct strintmap possible_trivial_merges;
      +
      +	/*
      +	 * trivial_merges_okay: if trivial directory merges are okay
     @@ merge-ort.c: struct rename_info {
      +	 * to 1 initially and only clear when we determine it is unsafe to
      +	 * do trivial directory merges.
      +	 */
     -+	unsigned trivial_merges_okay[3];
     ++	unsigned trivial_merges_okay;
      +
      +	/*
      +	 * target_dirs: ancestor directories of rename targets
     @@ merge-ort.c: struct rename_info {
      +	 * target_dirs contains all directory names that are an ancestor of
      +	 * any rename destination.
      +	 */
     -+	struct strset target_dirs[3];
     ++	struct strset target_dirs;
     ++};
     ++
     + struct rename_info {
     + 	/*
     + 	 * All variables that are arrays of size 3 correspond to data tracked
     +@@ merge-ort.c: struct rename_info {
     + 	 */
     + 	struct strintmap relevant_sources[3];
     + 
     ++	struct deferred_traversal_data deferred[3];
      +
       	/*
       	 * dir_rename_mask:
       	 *   0: optimization removing unmodified potential rename source okay
      @@ merge-ort.c: static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
     - 		strintmap_func(&renames->dirs_removed[i]);
     - 		strmap_func(&renames->dir_renames[i], 0);
     - 		strintmap_func(&renames->relevant_sources[i]);
     -+		strintmap_func(&renames->possible_trivial_merges[i]);
     -+		strset_func(&renames->target_dirs[i]);
     -+		renames->trivial_merges_okay[i] = 1; /* 1 == maybe */
     - 		if (!reinitialize)
     - 			assert(renames->cached_pairs_valid_side == 0);
     - 		if (i != renames->cached_pairs_valid_side) {
     + 				strmap_clear(&renames->dir_rename_count[i], 1);
     + 		}
     + 	}
     ++	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; ++i) {
     ++		strintmap_func(&renames->deferred[i].possible_trivial_merges);
     ++		strset_func(&renames->deferred[i].target_dirs);
     ++		renames->deferred[i].trivial_merges_okay = 1; /* 1 == maybe */
     ++	}
     + 	renames->cached_pairs_valid_side = 0;
     + 	renames->dir_rename_mask = 0;
     + 
      @@ merge-ort.c: static void merge_start(struct merge_options *opt, struct merge_result *result)
     - 		strintmap_init_with_options(&renames->relevant_sources[i],
     - 					    -1 /* explicitly invalid */,
     - 					    NULL, 0);
     -+		strintmap_init_with_options(&renames->possible_trivial_merges[i],
     -+					    0, NULL, 0);
     -+		strset_init_with_options(&renames->target_dirs[i],
     -+					 NULL, 1);
     - 		strmap_init_with_options(&renames->cached_pairs[i],
     - 					 NULL, 1);
     - 		strset_init_with_options(&renames->cached_irrelevant[i],
     - 					 NULL, 1);
       		strset_init_with_options(&renames->cached_target_names[i],
       					 NULL, 0);
     -+		renames->trivial_merges_okay[i] = 1; /* 1 == maybe */
       	}
     ++	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; i++) {
     ++		strintmap_init_with_options(&renames->deferred[i].possible_trivial_merges,
     ++					    0, NULL, 0);
     ++		strset_init_with_options(&renames->deferred[i].target_dirs,
     ++					 NULL, 1);
     ++		renames->deferred[i].trivial_merges_okay = 1; /* 1 == maybe */
     ++	}
       
       	/*
     + 	 * Although we initialize opt->priv->paths with strdup_strings=0,
 4:  7e28323b624 ! 4:  1cf4a47562a merge-ort: add a handle_deferred_entries() helper function
     @@ merge-ort.c: static int collect_merge_info_callback(int n,
      +	int side, ret = 0;
      +
      +	for (side = MERGE_SIDE1; side <= MERGE_SIDE2; side++) {
     -+		renames->trivial_merges_okay[side] = 0;
     -+		strintmap_for_each_entry(&renames->possible_trivial_merges[side],
     ++		renames->deferred[side].trivial_merges_okay = 0;
     ++		strintmap_for_each_entry(&renames->deferred[side].possible_trivial_merges,
      +					 &iter, entry) {
      +			const char *path = entry->key;
      +			unsigned dir_rename_mask = (intptr_t)entry->value;
 5:  317553eadb6 ! 5:  79c51536829 merge-ort: defer recursing into directories when merge base is matched
     @@ merge-ort.c: static int collect_merge_info_callback(int n,
      +			side = dirmask / 2;
      +		}
      +		if (renames->dir_rename_mask != 0x07 &&
     -+		    (side != MERGE_BASE) &&
     -+		    renames->trivial_merges_okay[side] &&
     -+		    !strset_contains(&renames->target_dirs[side], pi.string)) {
     -+			strintmap_set(&renames->possible_trivial_merges[side],
     ++		    side != MERGE_BASE &&
     ++		    renames->deferred[side].trivial_merges_okay &&
     ++		    !strset_contains(&renames->deferred[side].target_dirs,
     ++				     pi.string)) {
     ++			strintmap_set(&renames->deferred[side].possible_trivial_merges,
      +				      pi.string, renames->dir_rename_mask);
      +			renames->dir_rename_mask = prev_dir_rename_mask;
      +			return mask;
 6:  3409a6cd631 ! 6:  572cc5e94d2 merge-ort: avoid recursing into directories when we don't need to
     @@ merge-ort.c: static int handle_deferred_entries(struct merge_options *opt,
       	int side, ret = 0;
       
       	for (side = MERGE_SIDE1; side <= MERGE_SIDE2; side++) {
     --		renames->trivial_merges_okay[side] = 0;
     --		strintmap_for_each_entry(&renames->possible_trivial_merges[side],
     +-		renames->deferred[side].trivial_merges_okay = 0;
     +-		strintmap_for_each_entry(&renames->deferred[side].possible_trivial_merges,
      -					 &iter, entry) {
      +		unsigned optimization_okay = 1;
      +		struct strintmap copy;
     @@ merge-ort.c: static int handle_deferred_entries(struct merge_options *opt,
      +			struct strmap_entry *e;
      +
      +			/*
     -+			 * if we don't know delete/rename info for this path,
     ++			 * If we don't know delete/rename info for this path,
      +			 * then we need to recurse into all trees to get all
      +			 * adds to make sure we have it.
      +			 */
     @@ merge-ort.c: static int handle_deferred_entries(struct merge_options *opt,
      +			dir = xstrdup(rename_target);
      +			while ((dir_marker = strrchr(dir, '/'))) {
      +				*dir_marker = '\0';
     -+				if (strset_contains(&renames->target_dirs[side],
     ++				if (strset_contains(&renames->deferred[side].target_dirs,
      +						    dir))
      +					break;
     -+				strset_add(&renames->target_dirs[side], dir);
     ++				strset_add(&renames->deferred[side].target_dirs,
     ++					   dir);
      +			}
      +			free(dir);
      +		}
     -+		renames->trivial_merges_okay[side] = optimization_okay;
     ++		renames->deferred[side].trivial_merges_okay = optimization_okay;
      +		/*
      +		 * We need to recurse into any directories in
      +		 * possible_trivial_merges[side] found in target_dirs[side].
     @@ merge-ort.c: static int handle_deferred_entries(struct merge_options *opt,
      +		 * and then we'll also iterate anything added into
      +		 * possible_trivial_merges[side] once this loop is done.
      +		 */
     -+		copy = renames->possible_trivial_merges[side];
     -+		strintmap_init_with_options(&renames->possible_trivial_merges[side],
     ++		copy = renames->deferred[side].possible_trivial_merges;
     ++		strintmap_init_with_options(&renames->deferred[side].possible_trivial_merges,
      +					    0,
      +					    NULL,
      +					    0);
     @@ merge-ort.c: static int handle_deferred_entries(struct merge_options *opt,
       			dirmask = ci->dirmask;
       
      +			if (optimization_okay &&
     -+			    !strset_contains(&renames->target_dirs[side],
     ++			    !strset_contains(&renames->deferred[side].target_dirs,
      +					     path)) {
      +				resolve_trivial_directory_merge(ci, side);
      +				continue;
     @@ merge-ort.c: static int handle_deferred_entries(struct merge_options *opt,
       				return ret;
       		}
      +		strintmap_clear(&copy);
     -+		strintmap_for_each_entry(&renames->possible_trivial_merges[side],
     ++		strintmap_for_each_entry(&renames->deferred[side].possible_trivial_merges,
      +					 &iter, entry) {
      +			const char *path = entry->key;
      +			struct conflict_info *ci;
     @@ merge-ort.c: static int handle_deferred_entries(struct merge_options *opt,
      +			ci = strmap_get(&opt->priv->paths, path);
      +			VERIFY_CI(ci);
      +
     -+			assert(renames->trivial_merges_okay[side] &&
     -+			       !strset_contains(&renames->target_dirs[side],
     ++			assert(renames->deferred[side].trivial_merges_okay &&
     ++			       !strset_contains(&renames->deferred[side].target_dirs,
      +						path));
      +			resolve_trivial_directory_merge(ci, side);
      +		}
 7:  7133f0efa52 ! 7:  a9cbc1d4f18 merge-ort: restart merge with cached renames to reduce process entry cost
     @@ merge-ort.c: struct rename_info {
       	 * needed_limit: value needed for inexact rename detection to run
       	 *
      @@ merge-ort.c: static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
     - 		renames->trivial_merges_okay[i] = 1; /* 1 == maybe */
     + 		strintmap_func(&renames->relevant_sources[i]);
       		if (!reinitialize)
       			assert(renames->cached_pairs_valid_side == 0);
      -		if (i != renames->cached_pairs_valid_side) {
     @@ merge-ort.c: static int handle_deferred_entries(struct merge_options *opt,
       	}
      +	if (path_count_after) {
      +		/*
     -+		 * Not sure were the right cut-off is for the optimization
     -+		 * to redo collect_merge_info after we've cached the
     -+		 * regular renames is.  Basically, collect_merge_info(),
     -+		 * detect_regular_renames(), and process_entries() are
     -+		 * similar costs and all big tent poles.  Caching the
     -+		 * result of detect_regular_renames() means that redoing
     -+		 * that one function will cost us virtually 0 extra, so it
     -+		 * depends on the other two functions, which are both O(N)
     -+		 * cost in the number of paths.  Thus, it makes sense that
     -+		 * if we can cut the number of paths in half, then redoing
     -+		 * collect_merge_info() at half cost in order to get
     -+		 * process_entries() at half cost should be about equal
     -+		 * cost.  If we can cut by more than half, then we would
     -+		 * win.  The fact that process_entries() is about 10%-20%
     -+		 * more expensive than collect_merge_info() suggests we
     -+		 * could make the factor be less than two.  The fact that
     -+		 * even when we have renames cached, we still have to
     -+		 * traverse down to the individual (relevant) renames,
     -+		 * which suggests we should perhaps use a bigger factor.
     -+		 *
     -+		 * The exact number isn't critical, since the code will
     -+		 * work even if we get the factor wrong -- it just might be
     -+		 * slightly slower if we're a bit off.  For now, just error
     -+		 * on the side of a bigger fudge.  For the linux kernel
     -+		 * testcases I was looking at with massive renames, the
     -+		 * ratio came in around 50 to 250, which clearly would
     -+		 * trigger this optimization and provided some *very* nice
     -+		 * speedups.
     ++		 * The choice of wanted_factor here does not affect
     ++		 * correctness, only performance.  When the
     ++		 *    path_count_after / path_count_before
     ++		 * ratio is high, redoing after renames is a big
     ++		 * performance boost.  I suspect that redoing is a wash
     ++		 * somewhere near a value of 2, and below that redoing will
     ++		 * slow things down.  I applied a fudge factor and picked
     ++		 * 3; see the commit message when this was introduced for
     ++		 * back of the envelope calculations for this ratio.
      +		 */
     -+		int wanted_factor = 3;
     ++		const int wanted_factor = 3;
      +
      +		/* We should only redo collect_merge_info one time */
      +		assert(renames->redo_after_renames == 0);
      +
     -+		if (path_count_after / path_count_before > wanted_factor) {
     ++		if (path_count_after / path_count_before >= wanted_factor) {
      +			renames->redo_after_renames = 1;
      +			renames->cached_pairs_valid_side = -1;
      +		}

-- 
gitgitgadget
