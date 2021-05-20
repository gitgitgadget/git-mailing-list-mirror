Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54428C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D409610CC
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhETGLH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 02:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhETGLG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 02:11:06 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402CAC061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:09:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d11so16266242wrw.8
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=geBDNUpPuQRzmZPSFgM7xD8U+X5F6w9T/k+4QMhOC5Y=;
        b=TxBd8Xl+avhgmuy1Tc9wlsijo4Afl2zL04+upLuBYfo92u3OyaJiNDoWIZmncF5kxM
         Ci7ayKpj+oTPL2kJwCIiIX0mD/oH2yZ9oigzt3ySN31t3uUKLCGGcG+I+dExWIFwN1Wu
         dZOPlMq0qg8NvmheR0uMIPmcojOikNnrDxzZYvUqdUCaquhoRGupxguJb9RJXSXhYxzN
         c/vOdZMa6B7ZUtyU69WNg48LO/s0ruIvKI5eRhl6bajN/bsMkS4rQTR8JtzAr7c0o96S
         OKhM0jK/semYA1tHJmgiGa38WEC0ahjYSzb1axUwW16kkG+bU1wltVRxU6ZlEJnfvUQc
         epKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=geBDNUpPuQRzmZPSFgM7xD8U+X5F6w9T/k+4QMhOC5Y=;
        b=pYyHEniAYQZZFMbHOp6XFGt4fjv1GceU1nBksBNOUbzZ0xZH70eYSsSCw/BibSEqIN
         5R+UWT1Er7K05cKBQ/xnX0yDAn5gjOeyOYDDmAguJuYmx4vFQpOdhy7qpNYOnHdxqVPe
         Wr2kklMidkvA71kVI3gP6iGoECAxt2+UBiM/npHZJ56zF6bl9+WYBs9+bysV6hPmWZnw
         MA22kWfkJDKSxj8WaWG3u1AnXabxKFTkw4tLB1/lmWE6ix7qkKJXrHwdAAfy7S01GR+V
         WxcqD4APCtnoFzQvamHa1OREU7rQmUFn0dUVsY/aBVW1n2ohvwMfOJmmt2O9lyMvF3/u
         UnEg==
X-Gm-Message-State: AOAM5337P1ntoI1kZ0tejEnzocSyqa4KOdG4+oHi9EEdjkzowyuZfkRw
        Xnc+QrT/yxA4/vfma98vbb7IBxUON3o=
X-Google-Smtp-Source: ABdhPJzneHnWKP1p9fFS8LnzRSuCVC93GG4tBv9qIVEWjzoNAYG177J6Vm6tL8rejelbEN5CuiTerg==
X-Received: by 2002:a5d:4e0c:: with SMTP id p12mr2427710wrt.268.1621490983731;
        Wed, 19 May 2021 23:09:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm1797052wrx.38.2021.05.19.23.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 23:09:43 -0700 (PDT)
Message-Id: <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
References: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 May 2021 06:09:28 +0000
Subject: [PATCH v3 00/13] Optimization batch 11: avoid repeatedly detecting same renames
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
merges such as a rebase or cherry-pick of several commits.

Changes since v2 (thanks to Stolee for the reviews!):

 * Patch 2: Wording cleanups (typo fixes and whatnot in the documentation)
 * Patch 5: Expand the comment to explain the purpose of cached_irrelevant
 * Patch 6: Add a cache_new_pairs() helper, remove extraneous line deletion
 * Patch 7: Typo fix

Not included: Additional trace2 metadata beyond that found in v2; I'm not
sure what to record that would help (see
https://lore.kernel.org/git/CABPp-BFdxn9f0-jUjY6Ake_6kX-jeN1EEzpeJeTg+TV4wfepwg@mail.gmail.com/)

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
 merge-ort.c                                   | 331 ++++++++-
 merge-ort.h                                   |   2 +
 t/helper/test-fast-rebase.c                   |  54 +-
 t/t6423-merge-rename-directories.sh           |  58 ++
 t/t6429-merge-sequence-rename-caching.sh      | 700 ++++++++++++++++++
 8 files changed, 1804 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/technical/remembering-renames.txt
 create mode 100755 t/t6429-merge-sequence-rename-caching.sh


base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-859%2Fnewren%2Fort-perf-batch-11-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-859/newren/ort-perf-batch-11-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/859

Range-diff vs v2:

  1:  129136a10c9d =  1:  129136a10c9d t6423: rename file within directory that other side renamed
  2:  027c446286d9 !  2:  4246d0193fed Documentation/technical: describe remembering renames optimization
     @@ Documentation/technical/remembering-renames.txt (new)
      +The first assumption is merely for the purposes of making this document
      +clearer; the optimization implementation does not actually depend upon it.
      +However, the assumption does hold in all cases because it reflects the way
     -+that both rebase and cherry-pick where implemented; and the implementation
     ++that both rebase and cherry-pick were implemented; and the implementation
      +of cherry-pick and rebase are not readily changeable for backwards
      +compatibility reasons (see for example the discussion of the --ours and
      +--theirs flag in the documentation of `git checkout`, particularly the
     @@ Documentation/technical/remembering-renames.txt (new)
      +However, the above is focusing on the common scenarios.  Let's try to look
      +at all possible unusual scenarios and compare without the optimization to
      +with the optimization.  Consider the following theoretical cases; we will
     -+the dive into each to determine which of them are possible,
     ++then dive into each to determine which of them are possible,
      +and if so, what they mean:
      +
      +  1. Without the optimization, the second merge results in a conflict.
     @@ Documentation/technical/remembering-renames.txt (new)
      +tree for the user to deal with and no hints about the potential similarity
      +between the two.  With the optimization, we'll have a three-way content
      +merged A:oldfile, A':newfile, and B:oldfile with conflict markers
     -+suggesting we though the files were related but giving the user the chance
     ++suggesting we thought the files were related but giving the user the chance
      +to resolve.  As noted above, I don't think users will find us treating
      +'oldfile' and 'newfile' as related as a surprise since they were between E
      +and G.  In any event, though, this case shouldn't be concerning since we
     @@ Documentation/technical/remembering-renames.txt (new)
      +  * 9bd342137e ("diffcore-rename: determine which relevant_sources are
      +		no longer relevant", 2021-03-13)
      +
     -+However, relevance is always determined by what the _other_ side of
     -+history has done, in terms of modifing a file that our side renamed,
     -+or adding a file to a directory which our side renamed.  However, this
     -+means that a path that is "irrelevant" when picking the first commit
     -+of a series in a rebase or cherry-pick, may suddenly become "relevant"
     -+when picking the next commit.
     ++Relevance is always determined by what the _other_ side of history has
     ++done, in terms of modifing a file that our side renamed, or adding a
     ++file to a directory which our side renamed.  This means that a path
     ++that is "irrelevant" when picking the first commit of a series in a
     ++rebase or cherry-pick, may suddenly become "relevant" when picking the
     ++next commit.
      +
      +The upshot of this is that we can only cache rename detection results
      +for relevant paths, and need to re-check relevance in subsequent
  3:  7dc273d458ea =  3:  22b121ae1143 fast-rebase: change assert() to BUG()
  4:  887b151c26ff =  4:  cfd8cbef17f0 fast-rebase: write conflict state to working tree, index, and HEAD
  5:  54c126f38098 =  5:  f1c20da12744 t6429: testcases for remembering renames
  6:  2a9e73de2bee !  6:  304a2768c97b merge-ort: add data structures for in-memory caching of rename detection
     @@ merge-ort.c: struct rename_info {
      +	/*
      +	 * cached_irrelevant: Caching of rename_sources that aren't relevant.
      +	 *
     -+	 * cached_pairs records both renames and deletes.  Sometimes we
     -+	 * do not know if a path is a rename or a delete because we pass
     -+	 * RELEVANT_LOCATION to diffcore_rename_extended() and based on
     -+	 * various optimizations it returns without detecting whether that
     -+	 * path is actually a rename or a delete.  We need to cache such
     -+	 * paths too, but separately from cached_pairs.
     ++	 * If we try to detect a rename for a source path and succeed, it's
     ++	 * part of a rename.  If we try to detect a rename for a source path
     ++	 * and fail, then it's a delete.  If we do not try to detect a rename
     ++	 * for a path, then we don't know if it's a rename or a delete.  If
     ++	 * merge-ort doesn't think the path is relevant, then we just won't
     ++	 * cache anything for that path.  But there's a slight problem in
     ++	 * that merge-ort can think a path is RELEVANT_LOCATION, but due to
     ++	 * commit 9bd342137e ("diffcore-rename: determine which
     ++	 * relevant_sources are no longer relevant", 2021-03-13),
     ++	 * diffcore-rename can downgrade the path to RELEVANT_NO_MORE.  To
     ++	 * avoid excessive calls to diffcore_rename_extended() we still need
     ++	 * to cache such paths, though we cannot record them as either
     ++	 * renames or deletes.  So we cache them here as a "turned out to be
     ++	 * irrelevant *for this commit*" as they are often also irrelevant
     ++	 * for subsequent commits, though we will have to do some extra
     ++	 * checking to see whether such paths become relevant for rename
     ++	 * detection when cherry-picking/rebasing subsequent commits.
      +	 */
      +	struct strset cached_irrelevant[3];
      +
  7:  02d517f052a3 !  7:  5a2f3b7b8672 merge-ort: populate caches of rename detection results
     @@ merge-ort.c: static void resolve_diffpair_statuses(struct diff_queue_struct *q)
       	}
       }
       
     ++static void cache_new_pair(struct rename_info *renames,
     ++			   int side,
     ++			   char *old_path,
     ++			   char *new_path,
     ++			   int free_old_value)
     ++{
     ++	char *old_value;
     ++	new_path = xstrdup(new_path);
     ++	old_value = strmap_put(&renames->cached_pairs[side],
     ++			       old_path, new_path);
     ++	strset_add(&renames->cached_target_names[side], new_path);
     ++	if (free_old_value)
     ++		free(old_value);
     ++	else
     ++		assert(!old_value);
     ++}
     ++
      +static void possibly_cache_new_pair(struct rename_info *renames,
      +				    struct diff_filepair *p,
      +				    unsigned side,
      +				    char *new_path)
      +{
     -+	char *old_value;
      +	int dir_renamed_side = 0;
      +
      +	if (new_path) {
     @@ merge-ort.c: static void resolve_diffpair_statuses(struct diff_queue_struct *q)
      +		 */
      +		strmap_put(&renames->cached_pairs[side], p->one->path, NULL);
      +	} else if (p->status == 'R') {
     -+		if (new_path) {
     -+			new_path = xstrdup(new_path);
     -+			old_value = strmap_put(&renames->cached_pairs[dir_renamed_side],
     -+					       p->two->path, new_path);
     -+			strset_add(&renames->cached_target_names[dir_renamed_side],
     -+				   new_path);
     -+			assert(!old_value);
     -+		}
      +		if (!new_path)
      +			new_path = p->two->path;
     -+		new_path = xstrdup(new_path);
     -+		old_value = strmap_put(&renames->cached_pairs[side],
     -+				       p->one->path, new_path);
     -+		strset_add(&renames->cached_target_names[side],
     -+			   new_path);
     -+		free(old_value);
     ++		else
     ++			cache_new_pair(renames, dir_renamed_side,
     ++				       p->two->path, new_path, 0);
     ++		cache_new_pair(renames, side, p->one->path, new_path, 1);
      +	} else if (p->status == 'A' && new_path) {
     -+		new_path = xstrdup(new_path);
     -+		old_value = strmap_put(&renames->cached_pairs[dir_renamed_side],
     -+				       p->two->path, new_path);
     -+		strset_add(&renames->cached_target_names[dir_renamed_side],
     -+			   new_path);
     -+		assert(!old_value);
     ++		cache_new_pair(renames, dir_renamed_side,
     ++			       p->two->path, new_path, 0);
      +	}
      +}
      +
     @@ merge-ort.c: static int collect_renames(struct merge_options *opt,
       		if (p->status != 'R' && !new_path) {
       			diff_free_filepair(p);
       			continue;
     - 		}
     --
     - 		if (new_path)
     - 			apply_directory_rename_modifications(opt, p, new_path);
     - 
      @@ merge-ort.c: static void merge_start(struct merge_options *opt, struct merge_result *result)
       					 NULL, 1);
       		strmap_init_with_options(&renames->dir_renames[i],
  8:  731b6bd15531 !  8:  e4a97b1b16ca merge-ort: add code to check for whether cached renames can be reused
     @@ merge-ort.c: struct rename_info {
      +	 * this data also is stored in merge_result->priv.  If a sequence of
      +	 * merges are being done (such as when cherry-picking or rebasing),
      +	 * the next merge can look at this and re-use information from
     -+	 * previous merges under certain cirumstances.
     ++	 * previous merges under certain circumstances.
      +	 *
      +	 * See also all the cached_* variables.
      +	 */
     @@ merge-ort.c: static void merge_start(struct merge_options *opt, struct merge_res
      +	assert(merge_trees[0] && merge_trees[1] && merge_trees[2]);
      +
      +	/* Check if we meet a condition for re-using cached_pairs */
     -+	if (     oideq(&merge_base->object.oid, &merge_trees[2]->object.oid) &&
     -+		 oideq(     &side1->object.oid, &result->tree->object.oid))
     ++	if (oideq(&merge_base->object.oid, &merge_trees[2]->object.oid) &&
     ++	    oideq(&side1->object.oid, &result->tree->object.oid))
      +		renames->cached_pairs_valid_side = MERGE_SIDE1;
      +	else if (oideq(&merge_base->object.oid, &merge_trees[1]->object.oid) &&
     -+		 oideq(     &side2->object.oid, &result->tree->object.oid))
     ++		 oideq(&side2->object.oid, &result->tree->object.oid))
      +		renames->cached_pairs_valid_side = MERGE_SIDE2;
      +	else
      +		renames->cached_pairs_valid_side = 0; /* neither side valid */
  9:  becd45103018 =  9:  441e66fb2d19 merge-ort: avoid accidental API mis-use
 10:  2163dded5798 = 10:  472a539d1809 merge-ort: preserve cached renames for the appropriate side
 11:  c0c1956e75c6 ! 11:  386fd24cb0e3 merge-ort: add helper functions for using cached renames
     @@ merge-ort.c: static void resolve_diffpair_statuses(struct diff_queue_struct *q)
      +	}
      +}
      +
     - static void possibly_cache_new_pair(struct rename_info *renames,
     - 				    struct diff_filepair *p,
     - 				    unsigned side,
     + static void cache_new_pair(struct rename_info *renames,
     + 			   int side,
     + 			   char *old_path,
 12:  28b622a8261b = 12:  886a17115f30 merge-ort: handle interactions of caching and rename/rename(1to1) cases
 13:  91b6768adf2d = 13:  76e253793c9a merge-ort, diffcore-rename: employ cached renames when possible

-- 
gitgitgadget
