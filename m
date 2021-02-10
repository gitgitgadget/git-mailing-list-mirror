Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9B1C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 15:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD9D164E85
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 15:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhBJPQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 10:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhBJPQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 10:16:26 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F058C061574
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 07:15:45 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m13so2949435wro.12
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 07:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=6oo5jAxt/fhQM7L0uorGzqIvhNsdl62kzXobG52hazI=;
        b=uHBFDay1sD+fpNo/OKdj3HmRzLjC8thIOtBYbZmxwPNkNGKbBg1cPXwPqi1n4eQL7u
         PcSwDpCXS2zRNQbuOZ8jJC+G2xZ4XPoJWy/O4Z65jbYEEO4vT3ClVDn3jb2dDOIgeDCT
         czDm73llvmSX8uR9VPlVRe4Ayu6cZL23C2+JH3iQM4TFmUhSoQ7x99bAk5idMdZ3aWtK
         IpiVfbGdlOtY9vEAPDlWoVYXEhg8IGbEV42ruNxBP1zkWAs3SEpJNAX9TGk+Arc6Jdq9
         vkS4t+LyD0GTngbpu7qXKtjB1/ghoKot740KuI+gu6ZIJWIYs0Jq4jdvqFXHZyzDay2q
         1Mkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=6oo5jAxt/fhQM7L0uorGzqIvhNsdl62kzXobG52hazI=;
        b=GZrcqojAIWLKFzIqo/kdehVX1x7vgaXjcwshXG1/5bj0uQ2t+Aflo/HHynwOTKUjpl
         LzJi2IH1Y21W/pYlKUogzElXF7cjipMhvHkanxTnhuXOeabSIODCtiJY1V9phVlZvTf4
         XUOqvIklVvhSq1eXIOG+wpZoFYqeSppJCTF98bMcDHAuaNLhjEVahJJnLbEnAPDOpOQe
         Ntc5ydKtUu8sdGl6f8N6mtU9PTo0d1blmXVW5VGxGWyRObt9IwrGOve1BnnoEmFaSdIT
         NXR4l13jrt/b/UJUpgVoPThgvxh5sU10W9brKa29R0zZZdCwrAnJuKnJ0uuaBC9CA26R
         9OGg==
X-Gm-Message-State: AOAM532v+SUWyLXEPyq+K5TN6dDtX/VIisx6CL+KN1XjWzhP8aVdyfqx
        4ElRpCVd2Hd0puaf0UM161PIO5fc61Q=
X-Google-Smtp-Source: ABdhPJzPzhOkWqT8zv29a9Pr3rHiMG49jY0QNg87gLT5GQWAei/N3h0TmugEXDkk6nUNArs7QiUduQ==
X-Received: by 2002:adf:ec52:: with SMTP id w18mr4142241wrn.65.1612970143774;
        Wed, 10 Feb 2021 07:15:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm3686650wrw.76.2021.02.10.07.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 07:15:41 -0800 (PST)
Message-Id: <pull.843.v3.git.1612970140.gitgitgadget@gmail.com>
In-Reply-To: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
References: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Feb 2021 15:15:35 +0000
Subject: [PATCH v3 0/5] Optimization batch 7: use file basenames to guide rename detection
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on ort-perf-batch-6[1].

This series uses file basenames (portion of the path after final '/',
including extension) in a basic fashion to guide rename detection.

Changes since v2:

 * insert a new patch at the beginning to test expected old behavior, then
   have later patches change the test expectation
 * tweak commit message wording to clarify that rename stats merely
   motivated the optimization
 * factor out a simple get_basename() helper; have it document why we don't
   use gitbasename()
 * use a higher required threshold to mark same-basename files as a rename,
   defaulting to average of minimum_score and MAX_SCORE (since default
   rename threshold is 50%, this implies default basename threshold is 75%)
 * provide an environment variable (undocumented) that can be used to test
   appropriate threshold for basename-sameness
 * updated the timings based on the new threshold
 * modify the documentation with Junio's suggested simpler and clearer
   wording
 * clean up the wording on a few comments

[1] https://lore.kernel.org/git/xmqqlfc4byt6.fsf@gitster.c.googlers.com/ [2]
https://github.com/newren/presentations/blob/pdfs/merge-performance/merge-performance-slides.pdf

Elijah Newren (5):
  t4001: add a test comparing basename similarity and content similarity
  diffcore-rename: compute basenames of all source and dest candidates
  diffcore-rename: complete find_basename_matches()
  diffcore-rename: guide inexact rename detection based on basenames
  gitdiffcore doc: mention new preliminary step for rename detection

 Documentation/gitdiffcore.txt |  17 +++
 diffcore-rename.c             | 202 +++++++++++++++++++++++++++++++++-
 t/t4001-diff-rename.sh        |  24 ++++
 3 files changed, 239 insertions(+), 4 deletions(-)


base-commit: 7ae9460d3dba84122c2674b46e4339b9d42bdedd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-843%2Fnewren%2Fort-perf-batch-7-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-843/newren/ort-perf-batch-7-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/843

Range-diff vs v2:

 4:  a0e75d8cd6bd ! 1:  3e6af929d135 gitdiffcore doc: mention new preliminary step for rename detection
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    gitdiffcore doc: mention new preliminary step for rename detection
     +    t4001: add a test comparing basename similarity and content similarity
      
     -    The last few patches have introduced a new preliminary step when rename
     -    detection is on but both break detection and copy detection are off.
     -    Document this new step.  While we're at it, add a testcase that checks
     -    the new behavior as well.
     +    Add a simple test where a removed file is similar to two different added
     +    files; one of them has the same basename, and the other has a slightly
     +    higher content similarity.  Without break detection, filename similarity
     +    of 100% trumps content similarity for pairing up related files.  For
     +    any filename similarity less than 100%, the opposite is true -- content
     +    similarity is all that matters.  Add a testcase that documents this.
      
     -    Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Subsequent commits will add a new rule that includes an inbetween state,
     +    where a mixture of filename similarity and content similarity are
     +    weighed, and which will change the outcome of this testcase.
      
     - ## Documentation/gitdiffcore.txt ##
     -@@ Documentation/gitdiffcore.txt: a similarity score different from the default of 50% by giving a
     - number after the "-M" or "-C" option (e.g. "-M8" to tell it to use
     - 8/10 = 80%).
     - 
     -+Note that when rename detection is on but both copy and break
     -+detection are off, rename detection adds a preliminary step that first
     -+checks files with the same basename.  If files with the same basename
     -+are sufficiently similar, it will mark them as renames and exclude
     -+them from the later quadratic step (the one that pairwise compares all
     -+unmatched files to find the "best" matches, determined by the highest
     -+content similarity).  So, for example, if docs/extensions.txt and
     -+docs/config/extensions.txt have similar content, then they will be
     -+marked as a rename even if it turns out that docs/extensions.txt was
     -+more similar to src/extension-checks.c.  At most, one comparison is
     -+done per file in this preliminary pass; so if there are several
     -+extensions.txt files throughout the directory hierarchy that were
     -+added and deleted, this preliminary step will be skipped for those
     -+files.
     -+
     - Note.  When the "-C" option is used with `--find-copies-harder`
     - option, 'git diff-{asterisk}' commands feed unmodified filepairs to
     - diffcore mechanism as well as modified ones.  This lets the copy
     +    Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## t/t4001-diff-rename.sh ##
      @@ t/t4001-diff-rename.sh: test_expect_success 'diff-tree -l0 defaults to a big rename limit, not zero' '
     @@ t/t4001-diff-rename.sh: test_expect_success 'diff-tree -l0 defaults to a big ren
      +	# subdir/file.txt is 89% similar to file.md, 78% similar to file.txt,
      +	# but since same basenames are checked first...
      +	cat >expected <<-\EOF &&
     -+	A	file.md
     -+	R078	subdir/file.txt	file.txt
     ++	R088	subdir/file.txt	file.md
     ++	A	file.txt
      +	EOF
      +	test_cmp expected actual
      +'
 1:  381a45d239bb ! 2:  4fff9b1ff57b diffcore-rename: compute basenames of all source and dest candidates
     @@ Commit message
          basenames still show up in the map, but have an invalid index (-1).
      
          This function was inspired by the fact that in real world repositories,
     -    most renames often do not involve a basename change.  Here are some
     -    sample repositories and the percentage of their historical renames (as of
     -    early 2020) that did not involve a basename change:
     +    files are often moved across directories without changing names.  Here
     +    are some sample repositories and the percentage of their historical
     +    renames (as of early 2020) that preserved basenames:
            * linux: 76%
            * gcc: 64%
            * gecko: 79%
            * webkit: 89%
     +    These statistics alone don't prove that an optimization in this area
     +    will help or how much it will help, since there are also unpaired adds
     +    and deletes, restrictions on which basenames we consider, etc., but it
     +    certainly motivated the idea to try something in this area.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ diffcore-rename.c: static int find_exact_renames(struct diff_options *options)
       	return renames;
       }
       
     ++static const char *get_basename(const char *filename)
     ++{
     ++	/*
     ++	 * gitbasename() has to worry about special drivers, multiple
     ++	 * directory separator characters, trailing slashes, NULL or
     ++	 * empty strings, etc.  We only work on filenames as stored in
     ++	 * git, and thus get to ignore all those complications.
     ++	 */
     ++	const char *base = strrchr(filename, '/');
     ++	return base ? base + 1 : filename;
     ++}
     ++
      +MAYBE_UNUSED
      +static int find_basename_matches(struct diff_options *options,
      +				 int minimum_score,
     @@ diffcore-rename.c: static int find_exact_renames(struct diff_options *options)
      +	strintmap_init_with_options(&dests, -1, NULL, 0);
      +	for (i = 0; i < num_src; ++i) {
      +		char *filename = rename_src[i].p->one->path;
     -+		char *base;
     ++		const char *base;
      +
      +		/* exact renames removed in remove_unneeded_paths_from_src() */
      +		assert(!rename_src[i].p->one->rename_used);
      +
     -+		base = strrchr(filename, '/');
     -+		base = (base ? base+1 : filename);
     -+
      +		/* Record index within rename_src (i) if basename is unique */
     ++		base = get_basename(filename);
      +		if (strintmap_contains(&sources, base))
      +			strintmap_set(&sources, base, -1);
      +		else
     @@ diffcore-rename.c: static int find_exact_renames(struct diff_options *options)
      +	}
      +	for (i = 0; i < rename_dst_nr; ++i) {
      +		char *filename = rename_dst[i].p->two->path;
     -+		char *base;
     ++		const char *base;
      +
      +		if (rename_dst[i].is_rename)
      +			continue; /* involved in exact match already. */
      +
     -+		base = strrchr(filename, '/');
     -+		base = (base ? base+1 : filename);
     -+
      +		/* Record index within rename_dst (i) if basename is unique */
     ++		base = get_basename(filename);
      +		if (strintmap_contains(&dests, base))
      +			strintmap_set(&dests, base, -1);
      +		else
 2:  dcd0175229aa ! 3:  dc26881e4ed3 diffcore-rename: complete find_basename_matches()
     @@ diffcore-rename.c: static int find_basename_matches(struct diff_options *options
       {
      -	int i;
      +	/*
     -+	 * When I checked, over 76% of file renames in linux just moved
     -+	 * files to a different directory but kept the same basename.  gcc
     -+	 * did that with over 64% of renames, gecko did it with over 79%,
     -+	 * and WebKit did it with over 89%.
     ++	 * When I checked in early 2020, over 76% of file renames in linux
     ++	 * just moved files to a different directory but kept the same
     ++	 * basename.  gcc did that with over 64% of renames, gecko did it
     ++	 * with over 79%, and WebKit did it with over 89%.
      +	 *
      +	 * Therefore we can bypass the normal exhaustive NxM matrix
      +	 * comparison of similarities between all potential rename sources
     -+	 * and destinations by instead using file basename as a hint, checking
     -+	 * for similarity between files with the same basename, and if we
     -+	 * find a pair that are sufficiently similar, record the rename
     -+	 * pair and exclude those two from the NxM matrix.
     ++	 * and destinations by instead using file basename as a hint (i.e.
     ++	 * the portion of the filename after the last '/'), checking for
     ++	 * similarity between files with the same basename, and if we find
     ++	 * a pair that are sufficiently similar, record the rename pair and
     ++	 * exclude those two from the NxM matrix.
      +	 *
      +	 * This *might* cause us to find a less than optimal pairing (if
      +	 * there is another file that we are even more similar to but has a
     @@ diffcore-rename.c: static int find_basename_matches(struct diff_options *options
      +	 * basename matching provides, and given the frequency with which
      +	 * people use the same basename in real world projects, that's a
      +	 * trade-off we are willing to accept when doing just rename
     -+	 * detection.  However, if someone wants copy detection that
     -+	 * implies they are willing to spend more cycles to find
     -+	 * similarities between files, so it may be less likely that this
     -+	 * heuristic is wanted.
     ++	 * detection.
     ++	 *
     ++	 * If someone wants copy detection that implies they are willing to
     ++	 * spend more cycles to find similarities between files, so it may
     ++	 * be less likely that this heuristic is wanted.  If someone is
     ++	 * doing break detection, that means they do not want filename
     ++	 * similarity to imply any form of content similiarity, and thus
     ++	 * this heuristic would definitely be incompatible.
      +	 */
      +
      +	int i, renames = 0;
     @@ diffcore-rename.c: static int find_basename_matches(struct diff_options *options
       	struct strintmap dests;
       
      +	/*
     -+	 * The prefeteching stuff wants to know if it can skip prefetching blobs
     -+	 * that are unmodified.  unmodified blobs are only relevant when doing
     -+	 * copy detection.  find_basename_matches() is only used when detecting
     -+	 * renames, not when detecting copies, so it'll only be used when a file
     -+	 * only existed in the source.  Since we already know that the file
     -+	 * won't be unmodified, there's no point checking for it; that's just a
     -+	 * waste of resources.  So set skip_unmodified to 0 so that
     -+	 * estimate_similarity() and prefetch() won't waste resources checking
     -+	 * for something we already know is false.
     ++	 * The prefeteching stuff wants to know if it can skip prefetching
     ++	 * blobs that are unmodified...and will then do a little extra work
     ++	 * to verify that the oids are indeed different before prefetching.
     ++	 * Unmodified blobs are only relevant when doing copy detection;
     ++	 * when limiting to rename detection, diffcore_rename[_extended]()
     ++	 * will never be called with unmodified source paths fed to us, so
     ++	 * the extra work necessary to check if rename_src entries are
     ++	 * unmodified would be a small waste.
      +	 */
      +	int skip_unmodified = 0;
      +
     @@ diffcore-rename.c: static int find_basename_matches(struct diff_options *options
      +	/* Now look for basename matchups and do similarity estimation */
      +	for (i = 0; i < num_src; ++i) {
      +		char *filename = rename_src[i].p->one->path;
     -+		char *base = NULL;
     ++		const char *base = NULL;
      +		intptr_t src_index;
      +		intptr_t dst_index;
      +
     -+		/* Get the basename */
     -+		base = strrchr(filename, '/');
     -+		base = (base ? base+1 : filename);
     -+
      +		/* Find out if this basename is unique among sources */
     ++		base = get_basename(filename);
      +		src_index = strintmap_get(&sources, base);
      +		if (src_index == -1)
      +			continue; /* not a unique basename; skip it */
 3:  ce2173aa1fb7 ! 4:  2493f4b2f55d diffcore-rename: guide inexact rename detection based on basenames
     @@ Commit message
          this change improves the performance as follows:
      
                                      Before                  After
     -        no-renames:       13.815 s ±  0.062 s    13.138 s ±  0.086 s
     -        mega-renames:   1799.937 s ±  0.493 s   169.488 s ±  0.494 s
     -        just-one-mega:    51.289 s ±  0.019 s     5.061 s ±  0.017 s
     +        no-renames:       13.815 s ±  0.062 s    13.294 s ±  0.103 s
     +        mega-renames:   1799.937 s ±  0.493 s   187.248 s ±  0.882 s
     +        just-one-mega:    51.289 s ±  0.019 s     5.557 s ±  0.017 s
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diffcore-rename.c ##
     -@@ diffcore-rename.c: static int find_exact_renames(struct diff_options *options)
     - 	return renames;
     +@@ diffcore-rename.c: static const char *get_basename(const char *filename)
     + 	return base ? base + 1 : filename;
       }
       
      -MAYBE_UNUSED
     @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
      +		trace2_region_leave("diff", "cull after exact", options->repo);
      +	} else {
      +		/* Determine minimum score to match basenames */
     -+		int min_basename_score = (int)(5*minimum_score + 0*MAX_SCORE)/5;
     ++		double factor = 0.5;
     ++		char *basename_factor = getenv("GIT_BASENAME_FACTOR");
     ++		int min_basename_score;
     ++
     ++		if (basename_factor)
     ++			factor = strtol(basename_factor, NULL, 10)/100.0;
     ++		assert(factor >= 0.0 && factor <= 1.0);
     ++		min_basename_score = minimum_score +
     ++			(int)(factor * (MAX_SCORE - minimum_score));
      +
      +		/*
      +		 * Cull sources:
      +		 *   - remove ones involved in renames (found via exact match)
      +		 */
     -+		trace2_region_enter("diff", "cull exact", options->repo);
     ++		trace2_region_enter("diff", "cull after exact", options->repo);
      +		remove_unneeded_paths_from_src(want_copies);
     -+		trace2_region_leave("diff", "cull exact", options->repo);
     ++		trace2_region_leave("diff", "cull after exact", options->repo);
      +
      +		/* Utilize file basenames to quickly find renames. */
      +		trace2_region_enter("diff", "basename matches", options->repo);
     @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
       
       		m = &mx[dst_cnt * NUM_CANDIDATE_PER_DST];
       		for (j = 0; j < NUM_CANDIDATE_PER_DST; j++)
     +
     + ## t/t4001-diff-rename.sh ##
     +@@ t/t4001-diff-rename.sh: test_expect_success 'basename similarity vs best similarity' '
     + 	# subdir/file.txt is 89% similar to file.md, 78% similar to file.txt,
     + 	# but since same basenames are checked first...
     + 	cat >expected <<-\EOF &&
     +-	R088	subdir/file.txt	file.md
     +-	A	file.txt
     ++	A	file.md
     ++	R078	subdir/file.txt	file.txt
     + 	EOF
     + 	test_cmp expected actual
     + '
 -:  ------------ > 5:  fc72d24a3358 gitdiffcore doc: mention new preliminary step for rename detection

-- 
gitgitgadget
