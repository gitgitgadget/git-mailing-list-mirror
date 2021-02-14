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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB95C433E0
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 07:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EA8264E26
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 07:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhBNHxW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 02:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhBNHwf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 02:52:35 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714B6C061756
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:51:54 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id n8so4854138wrm.10
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=imkn48KVkeyWZiio9RmiGLhdeb79xMbCtQ/qiUDRWqU=;
        b=bvqvW/R+7JlG9y/ZfAKNT2UbyZNL5AiUOnXwB8wYDjdPh/p79PcTDpl9mgZnTT+g3G
         mqSdnSh1l2GPam04JkBBOmIcLvDl5Bk0Cz89qLDbeySNSZQBQfebT2bZVrulbFBCzAvq
         6wYGz7btqhbGkPx+8nz/K9RNsipJswTqwtXcRT27xxl6UotiVPdKMR2xqCdUDGYp6ovT
         FvNkaHb5zXLGXG/9TZTWqXvuzsZcGCm/0GL1omH+iWcagbO/OJGIZ/5frGP59BSXbj1N
         bgiXg9RLldDs0Yg+jn/s6DNbNn1Y56OZirQk9//8Leh/rMYPKrnnkxLFePQ0MxvE75aJ
         etSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=imkn48KVkeyWZiio9RmiGLhdeb79xMbCtQ/qiUDRWqU=;
        b=UJYOzjZkapPBAxQn9VO3QBgT0VXPpYWriqjdmUNCkoQWvk+Se34aoXcvBrvpQfNZaT
         hJdPVW4chXJML+tQ7BpL8d1zWp+eZwgANcR3fygc5gZcYFkof7WEiWqjgUZySj7ypMqJ
         VX3nqC7l51DwsnsKin6WMM1wVk+4fFLSJUazzSqqNa96GUbxVDqDlBJUQkCjnivgUm91
         XTcomRbmWqEj5i7s+JTv0/6JEHnV0L3oTr8RinGprp8ObOkAS1w/aq9MUbfz7P4zRAYV
         AbRunV8He2VMCOPv5SRvEqVhkRv3pGO4V0RaO6KwJIJyvB7PqCgasCwLjsCtBMw2YIvM
         jJVQ==
X-Gm-Message-State: AOAM530Qi2vmRuAo10n5sRPQbFoKdPi7MUqcMdcrpPw/e2yckTAjwZth
        sVe7yZTMhMlFiGFasLwFC3bosk/lCco=
X-Google-Smtp-Source: ABdhPJzr9AmjCJpiouW6dadQL7Z8/1F8i5pY7jcLtvdRkve0Dlm1PwVABbH95fMsY0OLlSe7JTNjYA==
X-Received: by 2002:a5d:6d06:: with SMTP id e6mr12545821wrq.425.1613289113085;
        Sat, 13 Feb 2021 23:51:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15sm17260737wrt.8.2021.02.13.23.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 23:51:52 -0800 (PST)
Message-Id: <pull.843.v5.git.1613289112.gitgitgadget@gmail.com>
In-Reply-To: <pull.843.v4.git.1613031350.gitgitgadget@gmail.com>
References: <pull.843.v4.git.1613031350.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Feb 2021 07:51:45 +0000
Subject: [PATCH v5 0/6] Optimization batch 7: use file basenames to guide rename detection
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

This series depends on ort-perf-batch-6. It appears Junio has appended an
earlier round of this series on that one and called the combined series
en/diffcore-rename. I'm still resubmitting the two separately to preserve
the threaded discussion in the archives and because gitgitgadget can provide
proper range-diffs that way.

This series uses file basenames (portion of the path after final '/',
including extension) in a basic fashion to guide rename detection.

Changes since v4:

 * add wording to make it clearer that we are considering remaining
   basenames after exact rename detection
 * add three minor optimizations to patch 3. (All three will have to be
   undone by the next series, but this series is probably clearer with
   them.)
 * a typo fix or two
 * v2 of ort-perf-batch-6 added some changes around consistency of
   rename_src_nr; make similar changes in using this variable in
   find_basename_changes() for consistency
 * fix the testcase so the expected comments about the change in behavior
   only show up after we change the behavior
 * attempt a rewrite of the commit message for the new testcase, who knows
   if I'll get it right this time.

Elijah Newren (6):
  t4001: add a test comparing basename similarity and content similarity
  diffcore-rename: compute basenames of source and dest candidates
  diffcore-rename: complete find_basename_matches()
  diffcore-rename: guide inexact rename detection based on basenames
  gitdiffcore doc: mention new preliminary step for rename detection
  merge-ort: call diffcore_rename() directly

 Documentation/gitdiffcore.txt |  20 ++++
 diffcore-rename.c             | 190 +++++++++++++++++++++++++++++++++-
 merge-ort.c                   |  66 ++++++++++--
 t/t4001-diff-rename.sh        |  24 +++++
 4 files changed, 289 insertions(+), 11 deletions(-)


base-commit: dd6595b45640ee9894293e8b729ef9a254564a49
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-843%2Fnewren%2Fort-perf-batch-7-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-843/newren/ort-perf-batch-7-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/843

Range-diff vs v4:

 1:  3e6af929d135 ! 1:  6848422e47e8 t4001: add a test comparing basename similarity and content similarity
     @@ Commit message
      
          Add a simple test where a removed file is similar to two different added
          files; one of them has the same basename, and the other has a slightly
     -    higher content similarity.  Without break detection, filename similarity
     -    of 100% trumps content similarity for pairing up related files.  For
     -    any filename similarity less than 100%, the opposite is true -- content
     -    similarity is all that matters.  Add a testcase that documents this.
     +    higher content similarity.  In the current test, content similarity is
     +    weighted higher than filename similarity.
      
     -    Subsequent commits will add a new rule that includes an inbetween state,
     -    where a mixture of filename similarity and content similarity are
     -    weighed, and which will change the outcome of this testcase.
     +    Subsequent commits will add a new rule that weighs a mixture of filename
     +    similarity and content similarity in a manner that will change the
     +    outcome of this testcase.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ t/t4001-diff-rename.sh: test_expect_success 'diff-tree -l0 defaults to a big ren
      +	git add file.txt file.md &&
      +	git commit -a -m "rename" &&
      +	git diff-tree -r -M --name-status HEAD^ HEAD >actual &&
     -+	# subdir/file.txt is 89% similar to file.md, 78% similar to file.txt,
     -+	# but since same basenames are checked first...
     ++	# subdir/file.txt is 88% similar to file.md and 78% similar to file.txt
      +	cat >expected <<-\EOF &&
      +	R088	subdir/file.txt	file.md
      +	A	file.txt
 2:  4fff9b1ff57b ! 2:  73baae2535d0 diffcore-rename: compute basenames of all source and dest candidates
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    diffcore-rename: compute basenames of all source and dest candidates
     +    diffcore-rename: compute basenames of source and dest candidates
      
     -    We want to make use of unique basenames to help inform rename detection,
     -    so that more likely pairings can be checked first.  (src/moduleA/foo.txt
     -    and source/module/A/foo.txt are likely related if there are no other
     -    'foo.txt' files among the deleted and added files.)  Add a new function,
     -    not yet used, which creates a map of the unique basenames within
     -    rename_src and another within rename_dst, together with the indices
     -    within rename_src/rename_dst where those basenames show up.  Non-unique
     -    basenames still show up in the map, but have an invalid index (-1).
     +    We want to make use of unique basenames among remaining source and
     +    destination files to help inform rename detection, so that more likely
     +    pairings can be checked first.  (src/moduleA/foo.txt and
     +    source/module/A/foo.txt are likely related if there are no other
     +    'foo.txt' files among the remaining deleted and added files.)  Add a new
     +    function, not yet used, which creates a map of the unique basenames
     +    within rename_src and another within rename_dst, together with the
     +    indices within rename_src/rename_dst where those basenames show up.
     +    Non-unique basenames still show up in the map, but have an invalid index
     +    (-1).
      
          This function was inspired by the fact that in real world repositories,
          files are often moved across directories without changing names.  Here
     @@ diffcore-rename.c: static int find_exact_renames(struct diff_options *options)
      +static const char *get_basename(const char *filename)
      +{
      +	/*
     -+	 * gitbasename() has to worry about special drivers, multiple
     ++	 * gitbasename() has to worry about special drives, multiple
      +	 * directory separator characters, trailing slashes, NULL or
      +	 * empty strings, etc.  We only work on filenames as stored in
      +	 * git, and thus get to ignore all those complications.
     @@ diffcore-rename.c: static int find_exact_renames(struct diff_options *options)
      +
      +MAYBE_UNUSED
      +static int find_basename_matches(struct diff_options *options,
     -+				 int minimum_score,
     -+				 int num_src)
     ++				 int minimum_score)
      +{
      +	int i;
      +	struct strintmap sources;
      +	struct strintmap dests;
      +
     -+	/* Create maps of basename -> fullname(s) for sources and dests */
     ++	/*
     ++	 * Create maps of basename -> fullname(s) for remaining sources and
     ++	 * dests.
     ++	 */
      +	strintmap_init_with_options(&sources, -1, NULL, 0);
      +	strintmap_init_with_options(&dests, -1, NULL, 0);
     -+	for (i = 0; i < num_src; ++i) {
     ++	for (i = 0; i < rename_src_nr; ++i) {
      +		char *filename = rename_src[i].p->one->path;
      +		const char *base;
      +
 3:  dc26881e4ed3 ! 3:  ece76429dc35 diffcore-rename: complete find_basename_matches()
     @@ Commit message
          This means we are adding a set of preliminary additional comparisons,
          but for each file we only compare it with at most one other file.  For
          example, if there was a include/media/device.h that was deleted and a
     -    src/module/media/device.h that was added, and there were no other
     -    device.h files added or deleted between the commits being compared,
     -    then these two files would be compared in the preliminary step.
     +    src/module/media/device.h that was added, and there are no other
     +    device.h files in the remaining sets of added and deleted files after
     +    exact rename detection, then these two files would be compared in the
     +    preliminary step.
      
          This commit does not yet actually employ this new optimization, it
          merely adds a function which can be used for this purpose.  The next
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diffcore-rename.c ##
     -@@ diffcore-rename.c: static int find_basename_matches(struct diff_options *options,
     - 				 int minimum_score,
     - 				 int num_src)
     +@@ diffcore-rename.c: MAYBE_UNUSED
     + static int find_basename_matches(struct diff_options *options,
     + 				 int minimum_score)
       {
      -	int i;
      +	/*
     @@ diffcore-rename.c: static int find_basename_matches(struct diff_options *options
      +	int i, renames = 0;
       	struct strintmap sources;
       	struct strintmap dests;
     - 
     ++	struct hashmap_iter iter;
     ++	struct strmap_entry *entry;
     ++
      +	/*
      +	 * The prefeteching stuff wants to know if it can skip prefetching
      +	 * blobs that are unmodified...and will then do a little extra work
     @@ diffcore-rename.c: static int find_basename_matches(struct diff_options *options
      +	 * unmodified would be a small waste.
      +	 */
      +	int skip_unmodified = 0;
     -+
     - 	/* Create maps of basename -> fullname(s) for sources and dests */
     - 	strintmap_init_with_options(&sources, -1, NULL, 0);
     - 	strintmap_init_with_options(&dests, -1, NULL, 0);
     + 
     + 	/*
     + 	 * Create maps of basename -> fullname(s) for remaining sources and
      @@ diffcore-rename.c: static int find_basename_matches(struct diff_options *options,
       			strintmap_set(&dests, base, i);
       	}
       
      -	/* TODO: Make use of basenames source and destination basenames */
      +	/* Now look for basename matchups and do similarity estimation */
     -+	for (i = 0; i < num_src; ++i) {
     -+		char *filename = rename_src[i].p->one->path;
     -+		const char *base = NULL;
     -+		intptr_t src_index;
     ++	strintmap_for_each_entry(&sources, &iter, entry) {
     ++		const char *base = entry->key;
     ++		intptr_t src_index = (intptr_t)entry->value;
      +		intptr_t dst_index;
     -+
     -+		/* Find out if this basename is unique among sources */
     -+		base = get_basename(filename);
     -+		src_index = strintmap_get(&sources, base);
      +		if (src_index == -1)
     -+			continue; /* not a unique basename; skip it */
     -+		assert(src_index == i);
     ++			continue;
      +
     -+		if (strintmap_contains(&dests, base)) {
     ++		if (0 <= (dst_index = strintmap_get(&dests, base))) {
      +			struct diff_filespec *one, *two;
      +			int score;
      +
     -+			/* Find out if this basename is unique among dests */
     -+			dst_index = strintmap_get(&dests, base);
     -+			if (dst_index == -1)
     -+				continue; /* not a unique basename; skip it */
     -+
     -+			/* Ignore this dest if already used in a rename */
     -+			if (rename_dst[dst_index].is_rename)
     -+				continue; /* already used previously */
     -+
      +			/* Estimate the similarity */
      +			one = rename_src[src_index].p->one;
      +			two = rename_dst[dst_index].p->two;
 4:  2493f4b2f55d ! 4:  122902e2706f diffcore-rename: guide inexact rename detection based on basenames
     @@ Commit message
          files based on basenames.  As a quick reminder (see the last two commit
          messages for more details), this means for example that
          docs/extensions.txt and docs/config/extensions.txt are considered likely
     -    renames if there are no 'extensions.txt' files elsewhere among the added
     -    and deleted files, and if a similarity check confirms they are similar,
     -    then they are marked as a rename without looking for a better similarity
     -    match among other files.  This is a behavioral change, as covered in
     -    more detail in the previous commit message.
     +    renames if there are no remaining 'extensions.txt' files elsewhere among
     +    the added and deleted files, and if a similarity check confirms they are
     +    similar, then they are marked as a rename without looking for a better
     +    similarity match among other files.  This is a behavioral change, as
     +    covered in more detail in the previous commit message.
      
          We do not use this heuristic together with either break or copy
          detection.  The point of break detection is to say that filename
     @@ diffcore-rename.c: static const char *get_basename(const char *filename)
       
      -MAYBE_UNUSED
       static int find_basename_matches(struct diff_options *options,
     - 				 int minimum_score,
     - 				 int num_src)
     + 				 int minimum_score)
     + {
      @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
       	if (minimum_score == MAX_SCORE)
       		goto cleanup;
       
     -+	num_sources = rename_src_nr;
     -+
     +-	/* Calculate how many renames are left */
     +-	num_destinations = (rename_dst_nr - rename_count);
     +-	remove_unneeded_paths_from_src(want_copies);
     + 	num_sources = rename_src_nr;
     + 
      +	if (want_copies || break_idx) {
      +		/*
      +		 * Cull sources:
     @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
      +		/* Utilize file basenames to quickly find renames. */
      +		trace2_region_enter("diff", "basename matches", options->repo);
      +		rename_count += find_basename_matches(options,
     -+						      min_basename_score,
     -+						      rename_src_nr);
     ++						      min_basename_score);
      +		trace2_region_leave("diff", "basename matches", options->repo);
      +
      +		/*
     @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
      +		trace2_region_leave("diff", "cull basename", options->repo);
      +	}
      +
     - 	/*
     --	 * Calculate how many renames are left
     -+	 * Calculate how many rename destinations are left
     - 	 */
     - 	num_destinations = (rename_dst_nr - rename_count);
     --	remove_unneeded_paths_from_src(want_copies);
     --	num_sources = rename_src_nr;
     ++	/* Calculate how many rename destinations are left */
     ++	num_destinations = (rename_dst_nr - rename_count);
      +	num_sources = rename_src_nr; /* rename_src_nr reflects lower number */
     - 
     ++
       	/* All done? */
       	if (!num_destinations || !num_sources)
     + 		goto cleanup;
      @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
       		struct diff_score *m;
       
     @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
      
       ## t/t4001-diff-rename.sh ##
      @@ t/t4001-diff-rename.sh: test_expect_success 'basename similarity vs best similarity' '
     - 	# subdir/file.txt is 89% similar to file.md, 78% similar to file.txt,
     - 	# but since same basenames are checked first...
     + 	git add file.txt file.md &&
     + 	git commit -a -m "rename" &&
     + 	git diff-tree -r -M --name-status HEAD^ HEAD >actual &&
     +-	# subdir/file.txt is 88% similar to file.md and 78% similar to file.txt
     ++	# subdir/file.txt is 88% similar to file.md, 78% similar to file.txt,
     ++	# but since same basenames are checked first...
       	cat >expected <<-\EOF &&
      -	R088	subdir/file.txt	file.md
      -	A	file.txt
 5:  4e86ed3f29d4 ! 5:  6f5584f61350 gitdiffcore doc: mention new preliminary step for rename detection
     @@ Documentation/gitdiffcore.txt: a similarity score different from the default of
      +preliminary "match same filename" step uses a bit higher threshold to
      +mark a file pair as a rename and stop considering other candidates for
      +better matches.  At most, one comparison is done per file in this
     -+preliminary pass; so if there are several ext.txt files throughout the
     -+directory hierarchy that were added and deleted, this preliminary step
     -+will be skipped for those files.
     ++preliminary pass; so if there are several remaining ext.txt files
     ++throughout the directory hierarchy after exact rename detection, this
     ++preliminary step will be skipped for those files.
      +
       Note.  When the "-C" option is used with `--find-copies-harder`
       option, 'git diff-{asterisk}' commands feed unmodified filepairs to
 6:  fedb3d323d94 = 6:  aeca14f748af merge-ort: call diffcore_rename() directly

-- 
gitgitgadget
