Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72668C433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3988761090
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhEDCNS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 22:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhEDCNR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 22:13:17 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEE6C061574
        for <git@vger.kernel.org>; Mon,  3 May 2021 19:12:23 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l14so7592102wrx.5
        for <git@vger.kernel.org>; Mon, 03 May 2021 19:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=nWW/5M0+MCHAaRRFADFyiJ/9kBgqtjvGe0EnFPi5aBk=;
        b=ujsfKgogrjuEYxaJsuxYxJGIxudxSXA4i5pL1gfkq7VIzjqz//UO26vLg8Y9Ra0nnR
         dtVqgqvyiN+MmMlMvzk2yXoEPz7R2mqbD8DHD9lS9N0XFJNJ7ZA24GCCfm1rRsOOJPE0
         diRP7Qx4J1kD0S4WkkRE6XEP4K+gVRMYBpoLKjGh7g2D/DSEgKk005KGqIp9zjOYfoah
         xfieEZCpEXCqzZgFirFmL+cZu+CEhHyRD+lDmtE62YE5icy/YXtNb8zg4xi1CHRFryFE
         +Lum4Vs0GIb/469EwcDNg7foMCkOLgacDFgUpYnKiuzVwhb/PDOnGxgSAouBCT+KEp7H
         49Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=nWW/5M0+MCHAaRRFADFyiJ/9kBgqtjvGe0EnFPi5aBk=;
        b=AOHVBn396zQeg4trDO5HgRw+fmPc6Hg5LlOfu6YaSmbH3K8+iG7cQ4a5KgQ3iHxiGy
         XLABOnot7OD+vkF3G5rXgNCmX7Q1NQYJvB6FfdezF2tiGgbLbL7xoj3xmwbhMhTmek3/
         mH511cPhzgO7CxSRGx0FHar+JNgTNY9neX7cwF99EOK86sXqAtKztSCuI0ddFDFOKMLT
         /KW9nqNV0zK/WpM2J0dORE9b1vgKbHpHpq6f1gkHE6XGT8dMvGCigFNR0UtSN0yFTh9q
         KFKJyLjz1uVE1EtLbu3ZA8acA2tEs3Cq/ksPI7aZ3DVqcylhUXnjH+aRrfWhXQj2vcPU
         ifnw==
X-Gm-Message-State: AOAM533rki0CVLS3J6udxb0vQPpDjFfW/NQ2XygJNwf9dkPze6cApIRn
        a8AjRC37q34jLi3cXpZ8KOX/efTNXS8=
X-Google-Smtp-Source: ABdhPJy+YDolfkiT64WsB4zhMZjcFZTJE24TdWzo01bSS+XMuzrHOb9yIvtaoPimikDMQcGaO5ZItg==
X-Received: by 2002:a5d:5186:: with SMTP id k6mr24166260wrv.335.1620094342082;
        Mon, 03 May 2021 19:12:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y21sm942755wmi.15.2021.05.03.19.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 19:12:20 -0700 (PDT)
Message-Id: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.git.1616621553.gitgitgadget@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 May 2021 02:12:06 +0000
Subject: [PATCH v2 00/13] Optimization batch 11: avoid repeatedly detecting same renames
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
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series avoids repeatedly detecting the same renames in a sequence of
merges such as a rebase or cherry-pick of several commits. It's
unfortunately become a bit lengthy, but much of the length (the first five
patches) is owed to special testcases and documentation.

Changes since v1:

 * Found and fixed a few bugs affecting merge.directoryRenames=true, one of
   which would have caused excessive rename detection runs (not caching
   things right), and another that would cause conflicts to be reported when
   the merge should be able to succeed.

 * Updated timings. The speedups are approximately the same as in v1, but
   are slightly improved by fixing the above bugs. Also, my v1 cover letter
   appears to have had incorrect "percentage of overall time" reported. Not
   sure what happened there, but I have updated numbers below.

 * Five new patches added to the front of the series (explained in reverse
   order):
   
   * Patch 5: Add a bunch of testcases to cover all the special cases that
     could present problems for the remember renames optimization.
   
   * Patch 4: Extend test-tool fast-rebase slightly for the new testcases.
   
   * Patch 3: Fix an embarrassing bug in fast-rebase, for use in new
     testcases.
   
   * Patch 2: Add documentation that thoroughly explains all the nooks and
     crannies and special cases associated with this optimization to "prove"
     that it is safe. May help if future optimizations or feature changes
     call into question any assumptions in play (e.g. if break detection
     were ever turned on in the merge machinery).
   
   * Patch 1: While thoroughly covering all the special cases, I also found
     and documented a minor merge.directoryRenames=true bug that affects
     both merge-recursive and merge-ort, with or without this optimization;
     this bug has been there for years.

 * One additional patch inserted near the end of the series:
   
   * Patch 11: Special handling for rename/rename(1to1) situations, as
     discussed in Patch 2.

=== Basic Optimization idea ===

When there are many renames between the old base and the new base,
traditionally all those renames are re-detected for every commit that is
transplanted. This optimization avoids redoing that work. While that
description is a simple summary of the high level idea, the reasons why this
optimization are safe and correct can be somewhat intricate; the second
patch adds a document that goes to great length to explain every relevant
detail.

This represents "Optimization #4" from my Git Merge 2020 talk[1]; the
details are a bit more involved than I realized at the time, but the high
level idea is the same.

=== Comparison to previous series ===

I previously noted that we had three major rename-related optimizations:

 * exact rename detection (applies when unmodified on renamed side)
 * skip-because-irrelevant (applies when unmodified on unrenamed side)
 * basename-guided rename detection (applies when basename unchanged)

This one adds a fourth (remember-renames), with some interesting properties:

 * unlike basename-guided rename detection, there are no behavioral changes
   (there is no heuristic involved)[2].

 * like skip-because-irrelevant, this optimization does not apply to all git
   commands using the rename machinery. In fact, this one is even more
   restrictive since it is ONLY useful for rebases and cherry-picks (not
   even merges), and only for second and later commits in a linear series.

 * unlike the three previous optimizations, there are no requirements about
   the types of changes done to the file; it just caches renames on the
   "upstream" side of history for subsequent commit picking.

It's also worth noting despite wording about "remembering" or "caching"
renames, that this optimization does NOT write this cache to disk; it's an
in-memory only cache. When the rebase or cherry-pick completes (or hits a
conflict and stops), the cache is discarded.

=== Results ===

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28), the
changes in just this series improves the performance as follows:

                     Before Series           After Series
no-renames:        5.665 s ±  0.129 s     5.622 s ±  0.059 s
mega-renames:     11.435 s ±  0.158 s    10.127 s ±  0.073 s
just-one-mega:   494.2  ms ±  6.1  ms   500.3  ms ±  3.8  ms


By design, this optimization could not help the just-one-mega testcase. The
gains for the other two testcases may look somewhat smaller than one would
expect given the description (only ~13% for the mega-renames testcase), but
the point was to spend less time detecting renames...and there just wasn't
that much time spent in renames for these testcases before this series for
us to remove. However, if we undid the basename-guided rename detection and
skip-because-unnecessary optimizations, then this series alone would have
improved performance as follows:

               Before Basename Series   After Just This Series
no-renames:      13.815 s ±  0.062 s      5.697 s ±  0.080 s
mega-renames:  1799.937 s ±  0.493 s    205.709 s ±  0.457 s


Showing that this optimization has the ability to improve things when the
other optimizations do not apply. In fact, when I originally implemented
this optimization, it improved the mega-renames testcase by a factor of 2
(at the time, I did not have all the optimizations from ort-perf-batch-7
thru ort-perf-batch-10 in their current shape).

As a reminder, before any merge-ort/diffcore-rename performance work, the
performance results we started with were:

no-renames-am:      6.940 s ±  0.485 s
no-renames:        18.912 s ±  0.174 s
mega-renames:    5964.031 s ± 10.459 s
just-one-mega:    149.583 s ±  0.751 s


=== Further discussion of results ===

If we change our focus from absolute time taken, to the percentage of
overall time spent on rename detection, then we find the following picture
comparing our starting point at the beginning of the performance work to
what we achieve at the end of this series:

         Percentage of time spent on rename detection
   
                  commit 557ac0350d      After this Series
no-renames:             39.4%                   0.2%
mega-renames:           96.6%                   8.7%
just-one-mega:          95.0%                  15.6%


This optimization is only applicable for the first two testcases (because
the third only involves rebasing a single commit). This table makes it clear
that our attempts to accelerate rename detection have succeeded, and any
further work to accelerate merges needs to start concentrating on other
areas.

[1]
https://github.com/newren/presentations/blob/pdfs/merge-performance/merge-performance-slides.pdf

[2] Well, almost no changes. There's technically a very narrow way that this
could change the behavior...though in a way that does not affect correctness
of the merge; see section 5 of the new document in the second patch for the
details.

Elijah Newren (13):
  t6423: rename file within directory that other side renamed
  Documentation/technical: describe remembering renames optimization
  fast-rebase: change assert() to BUG()
  fast-rebase: write conflict state to working tree, index, and HEAD
  t6429: testcases for remembering renames
  merge-ort: add data structures for in-memory caching of rename
    detection
  merge-ort: populate caches of rename detection results
  merge-ort: add code to check for whether cached renames can be reused
  merge-ort: avoid accidental API mis-use
  merge-ort: preserve cached renames for the appropriate side
  merge-ort: add helper functions for using cached renames
  merge-ort: handle interactions of caching and rename/rename(1to1)
    cases
  merge-ort, diffcore-rename: employ cached renames when possible

 .../technical/remembering-renames.txt         | 671 +++++++++++++++++
 diffcore-rename.c                             |  22 +-
 diffcore.h                                    |   3 +-
 merge-ort.c                                   | 319 +++++++-
 merge-ort.h                                   |   2 +
 t/helper/test-fast-rebase.c                   |  54 +-
 t/t6423-merge-rename-directories.sh           |  58 ++
 t/t6429-merge-sequence-rename-caching.sh      | 700 ++++++++++++++++++
 8 files changed, 1791 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/technical/remembering-renames.txt
 create mode 100755 t/t6429-merge-sequence-rename-caching.sh


base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-859%2Fnewren%2Fort-perf-batch-11-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-859/newren/ort-perf-batch-11-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/859

Range-diff vs v1:

  -:  ------------ >  1:  129136a10c9d t6423: rename file within directory that other side renamed
  -:  ------------ >  2:  027c446286d9 Documentation/technical: describe remembering renames optimization
  -:  ------------ >  3:  7dc273d458ea fast-rebase: change assert() to BUG()
  -:  ------------ >  4:  887b151c26ff fast-rebase: write conflict state to working tree, index, and HEAD
  -:  ------------ >  5:  54c126f38098 t6429: testcases for remembering renames
  1:  689a7de56483 =  6:  2a9e73de2bee merge-ort: add data structures for in-memory caching of rename detection
  2:  5f34332c9605 !  7:  02d517f052a3 merge-ort: populate caches of rename detection results
     @@ merge-ort.c: static void resolve_diffpair_statuses(struct diff_queue_struct *q)
      +				    char *new_path)
      +{
      +	char *old_value;
     ++	int dir_renamed_side = 0;
      +
     -+	if (!new_path) {
     ++	if (new_path) {
     ++		/*
     ++		 * Directory renames happen on the other side of history from
     ++		 * the side that adds new files to the old directory.
     ++		 */
     ++		dir_renamed_side = 3 - side;
     ++	} else {
      +		int val = strintmap_get(&renames->relevant_sources[side],
      +					p->one->path);
     -+		if (val == 0) {
     ++		if (val == RELEVANT_NO_MORE) {
      +			assert(p->status == 'D');
      +			strset_add(&renames->cached_irrelevant[side],
      +				   p->one->path);
     @@ merge-ort.c: static void resolve_diffpair_statuses(struct diff_queue_struct *q)
      +		if (val <= 0)
      +			return;
      +	}
     ++
      +	if (p->status == 'D') {
      +		/*
      +		 * If we already had this delete, we'll just set it's value
     @@ merge-ort.c: static void resolve_diffpair_statuses(struct diff_queue_struct *q)
      +		 */
      +		strmap_put(&renames->cached_pairs[side], p->one->path, NULL);
      +	} else if (p->status == 'R') {
     ++		if (new_path) {
     ++			new_path = xstrdup(new_path);
     ++			old_value = strmap_put(&renames->cached_pairs[dir_renamed_side],
     ++					       p->two->path, new_path);
     ++			strset_add(&renames->cached_target_names[dir_renamed_side],
     ++				   new_path);
     ++			assert(!old_value);
     ++		}
      +		if (!new_path)
      +			new_path = p->two->path;
      +		new_path = xstrdup(new_path);
      +		old_value = strmap_put(&renames->cached_pairs[side],
      +				       p->one->path, new_path);
     -+		strset_add(&renames->cached_target_names[side], new_path);
     ++		strset_add(&renames->cached_target_names[side],
     ++			   new_path);
      +		free(old_value);
      +	} else if (p->status == 'A' && new_path) {
      +		new_path = xstrdup(new_path);
     -+		old_value = strmap_put(&renames->cached_pairs[side],
     ++		old_value = strmap_put(&renames->cached_pairs[dir_renamed_side],
      +				       p->two->path, new_path);
     -+		strset_add(&renames->cached_target_names[side], new_path);
     ++		strset_add(&renames->cached_target_names[dir_renamed_side],
     ++			   new_path);
      +		assert(!old_value);
      +	}
      +}
     @@ merge-ort.c: static void resolve_diffpair_statuses(struct diff_queue_struct *q)
       {
       	const struct diff_filepair *a = *((const struct diff_filepair **)a_);
      @@ merge-ort.c: static int collect_renames(struct merge_options *opt,
     - 		struct diff_filepair *p = side_pairs->queue[i];
       		char *new_path; /* non-NULL only with directory renames */
       
     -+		possibly_cache_new_pair(renames, p, side_index, NULL);
       		if (p->status != 'A' && p->status != 'R') {
     ++			possibly_cache_new_pair(renames, p, side_index, NULL);
       			diff_free_filepair(p);
       			continue;
     + 		}
      @@ merge-ort.c: static int collect_renames(struct merge_options *opt,
     + 						      &collisions,
     + 						      &clean);
     + 
     ++		possibly_cache_new_pair(renames, p, side_index, new_path);
     + 		if (p->status != 'R' && !new_path) {
       			diff_free_filepair(p);
       			continue;
       		}
      -
     -+		possibly_cache_new_pair(renames, p, side_index, new_path);
       		if (new_path)
       			apply_directory_rename_modifications(opt, p, new_path);
       
  3:  aa131c21d14f =  8:  731b6bd15531 merge-ort: add code to check for whether cached renames can be reused
  4:  df12cb5a158e =  9:  becd45103018 merge-ort: avoid accidental API mis-use
  5:  39f7e384611d ! 10:  2163dded5798 merge-ort: preserve cached renames for the appropriate side
     @@ merge-ort.c: static void clear_or_reinit_internal_opts(struct merge_options_inte
       	}
       	renames->cached_pairs_valid_side = 0;
       	renames->dir_rename_mask = 0;
     +@@ merge-ort.c: static void detect_regular_renames(struct merge_options *opt,
     + 		return;
     + 	}
     + 
     ++	partial_clear_dir_rename_count(&renames->dir_rename_count[side_index]);
     + 	repo_diff_setup(opt->repo, &diff_opts);
     + 	diff_opts.flags.recursive = 1;
     + 	diff_opts.flags.rename_empty = 0;
  6:  7d5d94b34ba5 = 11:  c0c1956e75c6 merge-ort: add helper functions for using cached renames
  -:  ------------ > 12:  28b622a8261b merge-ort: handle interactions of caching and rename/rename(1to1) cases
  7:  d1016c342d69 ! 13:  91b6768adf2d merge-ort, diffcore-rename: employ cached renames when possible
     @@ Commit message
          this change improves the performance as follows:
      
                                      Before                  After
     -        no-renames:        5.665 s ±  0.129 s     5.624 s ±  0.077 s
     -        mega-renames:     11.435 s ±  0.158 s    10.213 s ±  0.032 s
     -        just-one-mega:   494.2  ms ±  6.1  ms   497.6  ms ±  5.3  ms
     +        no-renames:        5.665 s ±  0.129 s     5.622 s ±  0.059 s
     +        mega-renames:     11.435 s ±  0.158 s    10.127 s ±  0.073 s
     +        just-one-mega:   494.2  ms ±  6.1  ms   500.3  ms ±  3.8  ms
      
          That's a fairly small improvement, but mostly because the previous
          optimizations were so effective for these particular testcases; this
     @@ Commit message
          performance as follows:
      
                             Before Basename Series   After Just This Series
     -        no-renames:      13.815 s ±  0.062 s      5.814 s ±  0.094 s
     -        mega-renames:  1799.937 s ±  0.493 s    303.225 s ±  1.330 s
     +        no-renames:      13.815 s ±  0.062 s      5.697 s ±  0.080 s
     +        mega-renames:  1799.937 s ±  0.493 s    205.709 s ±  0.457 s
      
          Since this optimization kicks in to help accelerate cases where the
          previous optimizations do not apply, this last comparison shows that
     @@ Commit message
          for a future optimization around having collect_merge_info() avoid
          recursing into subtrees in more cases.
      
     +    However, for this optimization to be effective, merge_switch_to_result()
     +    should only be called when the rebase or cherry-pick operation has
     +    either completed or hit a case where the user needs to resolve a
     +    conflict or edit the result.  If it is called after every commit, as
     +    sequencer.c does, then the working tree and index are needlessly updated
     +    with every commit and the cached metadata is tossed, defeating this
     +    optimization.  Refactoring sequencer.c to only call
     +    merge_switch_to_result() at the end of the operation is a bigger
     +    undertaking, and the practical benefits of this optimization will not be
     +    realized until that work is performed.  Since `test-tool fast-rebase`
     +    only updates at the end of the operation, it was used to obtain the
     +    timings above.
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diffcore-rename.c ##
     @@ merge-ort.c: static void detect_regular_renames(struct merge_options *opt,
       	if (!possible_side_renames(renames, side_index)) {
       		/*
       		 * No rename detection needed for this side, but we still need
     -@@ merge-ort.c: static void detect_regular_renames(struct merge_options *opt,
     - 		return;
     - 	}
     - 
     -+	partial_clear_dir_rename_count(&renames->dir_rename_count[side_index]);
     - 	repo_diff_setup(opt->repo, &diff_opts);
     - 	diff_opts.flags.recursive = 1;
     - 	diff_opts.flags.rename_empty = 0;
      @@ merge-ort.c: static void detect_regular_renames(struct merge_options *opt,
       	diffcore_rename_extended(&diff_opts,
       				 &renames->relevant_sources[side_index],
     @@ merge-ort.c: static int detect_and_process_renames(struct merge_options *opt,
       	trace2_region_leave("merge", "regular renames", opt->repo);
       
       	trace2_region_enter("merge", "directory renames", opt->repo);
     +
     + ## t/t6429-merge-sequence-rename-caching.sh ##
     +@@ t/t6429-merge-sequence-rename-caching.sh: test_expect_success 'caching renames does not preclude finding new ones' '
     + # dramatic change in size of the file, but remembering the rename and
     + # reusing it is reasonable too.
     + #
     +-# Rename detection (diffcore_rename_extended()) will run twice here; it is
     +-# not needed on the topic side of history for either of the two commits
     +-# being merged, but it is needed on the upstream side of history for each
     +-# commit being picked.
     ++# We do test here that we expect rename detection to only be run once total
     ++# (the topic side of history doesn't need renames, and with caching we
     ++# should be able to only run rename detection on the upstream side one
     ++# time.)
     + test_expect_success 'cherry-pick both a commit and its immediate revert' '
     + 	test_create_repo pick-commit-and-its-immediate-revert &&
     + 	(
     +@@ t/t6429-merge-sequence-rename-caching.sh: test_expect_success 'cherry-pick both a commit and its immediate revert' '
     + 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
     + 		export GIT_TRACE2_PERF &&
     + 
     +-		test_might_fail test-tool fast-rebase --onto HEAD upstream~1 topic &&
     ++		test-tool fast-rebase --onto HEAD upstream~1 topic &&
     + 		#git cherry-pick upstream~1..topic &&
     + 
     + 		grep region_enter.*diffcore_rename trace.output >calls &&
     +-		test_line_count = 2 calls
     ++		test_line_count = 1 calls
     + 	)
     + '
     + 
     +@@ t/t6429-merge-sequence-rename-caching.sh: test_expect_success 'rename same file identically, then add file to old dir' '
     + # Here we are just concerned that cached renames might prevent us from seeing
     + # the rename conflict, and we want to ensure that we do get a conflict.
     + #
     +-# While at it, also test that we do rename detection three times.  We have to
     +-# detect renames on the upstream side of history once for each merge, plus
     +-# Topic_2 has renames.
     ++# While at it, though, we do test that we only try to detect renames 2
     ++# times and not three.  (The first merge needs to detect renames on the
     ++# upstream side.  Traditionally, the second merge would need to detect
     ++# renames on both sides of history, but our caching of upstream renames
     ++# should avoid the need to re-detect upstream renames.)
     + #
     + test_expect_success 'cached dir rename does not prevent noticing later conflict' '
     + 	test_create_repo dir-rename-cache-not-occluding-later-conflict &&
     +@@ t/t6429-merge-sequence-rename-caching.sh: test_expect_success 'cached dir rename does not prevent noticing later conflict'
     + 		grep CONFLICT..rename/rename output &&
     + 
     + 		grep region_enter.*diffcore_rename trace.output >calls &&
     +-		test_line_count = 3 calls
     ++		test_line_count = 2 calls
     + 	)
     + '
     + 
     +@@ t/t6429-merge-sequence-rename-caching.sh: test_setup_upstream_rename () {
     + # commit to mess up its location either.  We want to make sure that
     + # olddir/newfile doesn't exist in the result and that newdir/newfile does.
     + #
     +-# We also expect rename detection to occur three times.  Although it is
     +-# typically needed two times per commit, there are no deleted files on the
     +-# topic side of history, so we only need to detect renames on the upstream
     +-# side for each of the 3 commits we need to pick.
     ++# We also test that we only do rename detection twice.  We never need
     ++# rename detection on the topic side of history, but we do need it twice on
     ++# the upstream side of history.  For the first topic commit, we only need
     ++# the
     ++#   relevant-rename -> renamed
     ++# rename, because olddir is unmodified by Topic_1.  For Topic_2, however,
     ++# the new file being added to olddir means files that were previously
     ++# irrelevant for rename detection are now relevant, forcing us to repeat
     ++# rename detection for the paths we don't already have cached.  Topic_3 also
     ++# tweaks olddir/newfile, but the renames in olddir/ will have been cached
     ++# from the second rename detection run.
     + #
     + test_expect_success 'dir rename unneeded, then add new file to old dir' '
     + 	test_setup_upstream_rename dir-rename-unneeded-until-new-file &&
     +@@ t/t6429-merge-sequence-rename-caching.sh: test_expect_success 'dir rename unneeded, then add new file to old dir' '
     + 		#git cherry-pick upstream..topic &&
     + 
     + 		grep region_enter.*diffcore_rename trace.output >calls &&
     +-		test_line_count = 3 calls &&
     ++		test_line_count = 2 calls &&
     + 
     + 		git ls-files >tracked &&
     + 		test_line_count = 5 tracked &&
     +@@ t/t6429-merge-sequence-rename-caching.sh: test_expect_success 'dir rename unneeded, then rename existing file into old dir
     + 		#git cherry-pick upstream..topic &&
     + 
     + 		grep region_enter.*diffcore_rename trace.output >calls &&
     +-		test_line_count = 4 calls &&
     ++		test_line_count = 3 calls &&
     + 
     + 		test_path_is_missing somefile &&
     + 		test_path_is_missing olddir/newfile &&
     +@@ t/t6429-merge-sequence-rename-caching.sh: test_expect_success 'caching renames only on upstream side, part 1' '
     + # for the wrong side of history.
     + #
     + #
     +-# This testcase should only need three calls to diffcore_rename_extended(),
     +-# because there are no renames on the topic side of history for picking
     +-# Topic_2.
     ++# This testcase should only need two calls to diffcore_rename_extended(),
     ++# both for the first merge, one for each side of history.
     + #
     + test_expect_success 'caching renames only on upstream side, part 2' '
     + 	test_setup_topic_rename cache-renames-only-upstream-rename-file &&
     +@@ t/t6429-merge-sequence-rename-caching.sh: test_expect_success 'caching renames only on upstream side, part 2' '
     + 		#git cherry-pick upstream..topic &&
     + 
     + 		grep region_enter.*diffcore_rename trace.output >calls &&
     +-		test_line_count = 3 calls &&
     ++		test_line_count = 2 calls &&
     + 
     + 		git ls-files >tracked &&
     + 		test_line_count = 4 tracked &&

-- 
gitgitgadget
