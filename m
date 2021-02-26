Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786B7C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 01:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E1864F0D
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 01:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhBZB7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 20:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBZB7E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 20:59:04 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B5AC061574
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 17:58:23 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id 7so7099662wrz.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 17:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=VZ9Kv+AWOtba4ET9NDAd+vh6zTju7Q2JDjXk1zBSnjs=;
        b=PkkuuUFFYWy9BfpbeNqQGAT6lQkysKo2oZCj8I7ZMivh4odiib1q/Qbv5gfmGPVyhO
         7jBflnNknANNg/9d1wBhGZFfDy1PNcc8VofgxIsQYuV3eYp7g2Xth5S0mHcYHfcRD0y+
         HYfB6+0KPpW2vebNqLnBUqVwwgrSfNtgug7fqmmlUGXrzz7oE+QwCis5U0EQ157Hkjd0
         bILWnRAiNMGckSfq/GXXvt+oBnz7lwWutnpLkGTcNLpirDf1NRUY6IfkPNn7chlc+1eJ
         Pu8lQ5HwpfAwnKiRdrdvABfV6LQYcxZIGkei7sIRZftLdlIHPAP/BjOLTTJHJNKtjlUL
         Ohzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=VZ9Kv+AWOtba4ET9NDAd+vh6zTju7Q2JDjXk1zBSnjs=;
        b=gXfS4r5kWOzfFOQQCB43ee6ofBrPTNLnEinbGSKPPo1G07O6iQQdiBxWEVAjmdw0vA
         6i/BMZmFhBPyDXY8s2hlZF6R8krPqQjhGy38oVrxH6eLjy61zCXDGnWLC+03niwFsIPW
         h5HSI4ZtLltCiQsgytV6+YuEqY2fWtZSuIdZQDL+OneeXkwy9gvitlq4lVoqGWbxFrVJ
         bKQRS4vxzZrczJDyAMvkIxGiLRxkZ+HqAu3DyQbcb6DU8hUHIGLhTwsls0YuDpOCIwaQ
         5RyxY7uGXVa34PiPFMb7TMBDbgR5UHKX/hk9Qx4NP69QK8rkUYoRMyPItHDLXlNUFx9j
         QBEA==
X-Gm-Message-State: AOAM532zS2Xg1dNAqIKGNndEtRiEOh+53zRg7GJRp9xnh6xaMiAL+1OX
        oekI1Ece3n1mLF1GLjkQvVaxFRJfG3Q=
X-Google-Smtp-Source: ABdhPJwC6hvsX4Ll+LwEgWGzxS/z/Wb0TUYhD0H6LByMMgis4+0lab7NhYfNDizPwWe2uBEKDpPwSA==
X-Received: by 2002:adf:e5c8:: with SMTP id a8mr697332wrn.352.1614304701773;
        Thu, 25 Feb 2021 17:58:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8sm833636wrx.43.2021.02.25.17.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 17:58:21 -0800 (PST)
Message-Id: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
References: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Feb 2021 01:58:09 +0000
Subject: [PATCH v3 00/10] Optimization batch 8: use file basenames even more
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on en/diffcore-rename (a concatenation of what I was
calling ort-perf-batch-6 and ort-perf-batch-7).

Changes since v2:

 * Rearrange the patches in the series to have a top-down ordering rather
   than bottom-up -- as suggested by Stolee, Ævar, and Junio
 * Several comments and style improvements suggested by Stolee
 * Replace xstrfmt() with a few strbuf_add*() calls, as suggested by Stolee

Elijah Newren (10):
  diffcore-rename: use directory rename guided basename comparisons
  diffcore-rename: add a new idx_possible_rename function
  diffcore-rename: add a mapping of destination names to their indices
  Move computation of dir_rename_count from merge-ort to diffcore-rename
  diffcore-rename: add function for clearing dir_rename_count
  diffcore-rename: move dir_rename_counts into dir_rename_info struct
  diffcore-rename: extend cleanup_dir_rename_info()
  diffcore-rename: compute dir_rename_counts in stages
  diffcore-rename: limit dir_rename_counts computation to relevant dirs
  diffcore-rename: compute dir_rename_guess from dir_rename_counts

 Documentation/gitdiffcore.txt |   2 +-
 diffcore-rename.c             | 449 ++++++++++++++++++++++++++++++++--
 diffcore.h                    |   7 +
 merge-ort.c                   | 144 +----------
 4 files changed, 449 insertions(+), 153 deletions(-)


base-commit: aeca14f748afc7fb5b65bca56ea2ebd970729814
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-844%2Fnewren%2Fort-perf-batch-8-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-844/newren/ort-perf-batch-8-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/844

Range-diff vs v2:

 10:  805c101cfd84 !  1:  6afa9add40b9 diffcore-rename: use directory rename guided basename comparisons
     @@ Metadata
       ## Commit message ##
          diffcore-rename: use directory rename guided basename comparisons
      
     -    Hook the work from the last several patches together so that when
     -    basenames in the sets of possible remaining rename sources or
     -    destinations aren't unique, we can guess which directory source files
     -    were renamed into.  When that guess gives us a pairing of files, and
     -    those files are sufficiently similar, we record the two files as a
     -    rename and remove them from the large matrix of comparisons for inexact
     -    rename detection.
     +    A previous commit noted that it is very common for people to move files
     +    across directories while keeping their filename the same.  The last few
     +    commits took advantage of this and showed that we can accelerate rename
     +    detection significantly using basenames; since files with the same
     +    basename serve as likely rename candidates, we can check those first and
     +    remove them from the rename candidate pool if they are sufficiently
     +    similar.
      
     -    For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
     -    performance work; instrument with trace2_region_* calls", 2020-10-28),
     -    this change improves the performance as follows:
     +    Unfortunately, the previous optimization was limited by the fact that
     +    the remaining basenames after exact rename detection are not always
     +    unique.  Many repositories have hundreds of build files with the same
     +    name (e.g. Makefile, .gitignore, build.gradle, etc.), and may even have
     +    hundreds of source files with the same name.  (For example, the linux
     +    kernel has 100 setup.c, 87 irq.c, and 112 core.c files.  A repository at
     +    $DAYJOB has a lot of ObjectFactory.java and Plugin.java files).
      
     -                                Before                  After
     -        no-renames:       12.775 s ±  0.062 s    12.596 s ±  0.061 s
     -        mega-renames:    188.754 s ±  0.284 s   130.465 s ±  0.259 s
     -        just-one-mega:     5.599 s ±  0.019 s     3.958 s ±  0.010 s
     +    For these files with non-unique basenames, we are faced with the task of
     +    attempting to determine or guess which directory they may have been
     +    relocated to.  Such a task is precisely the job of directory rename
     +    detection.  However, there are two catches: (1) the directory rename
     +    detection code has traditionally been part of the merge machinery rather
     +    than diffcore-rename.c, and (2) directory rename detection currently
     +    runs after regular rename detection is complete.  The 1st catch is just
     +    an implementation issue that can be overcome by some code shuffling.
     +    The 2nd requires us to add a further approximation: we only have access
     +    to exact renames at this point, so we need to do directory rename
     +    detection based on just exact renames.  In some cases we won't have
     +    exact renames, in which case this extra optimization won't apply.  We
     +    also choose to not apply the optimization unless we know that the
     +    underlying directory was removed, which will require extra data to be
     +    passed in to diffcore_rename_extended().  Also, even if we get a
     +    prediction about which directory a file may have relocated to, we will
     +    still need to check to see if there is a file in the predicted
     +    directory, and then compare the two files to see if they meet the higher
     +    min_basename_score threshold required for marking the two files as
     +    renames.
     +
     +    This commit introduces an idx_possible_rename() function which will give
     +    do this directory rename detection for us and give us the index within
     +    rename_dst of the resulting filename.  For now, this function is
     +    hardcoded to return -1 (not found) and just hooks up how its results
     +    would be used once we have a more complete implementation in place.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ diffcore-rename.c: static const char *get_basename(const char *filename)
       	return base ? base + 1 : filename;
       }
       
     --MAYBE_UNUSED
     - static int idx_possible_rename(char *filename, struct dir_rename_info *info)
     ++static int idx_possible_rename(char *filename)
     ++{
     ++	/* Unconditionally return -1, "not found", for now */
     ++	return -1;
     ++}
     ++
     + static int find_basename_matches(struct diff_options *options,
     + 				 int minimum_score)
       {
     - 	/*
      @@ diffcore-rename.c: static int find_basename_matches(struct diff_options *options,
       	int i, renames = 0;
       	struct strintmap sources;
     @@ diffcore-rename.c: static int find_basename_matches(struct diff_options *options
      -			continue;
       
      -		if (0 <= (dst_index = strintmap_get(&dests, base))) {
     -+		/* Is this basename unique among remaining sources? */
     ++		/*
     ++		 * If the basename is unique among remaining sources, then
     ++		 * src_index will equal 'i' and we can attempt to match it
     ++		 * to a unique basename in the destinations.  Otherwise,
     ++		 * use directory rename heuristics, if possible.
     ++		 */
      +		base = get_basename(filename);
      +		src_index = strintmap_get(&sources, base);
      +		assert(src_index == -1 || src_index == i);
     @@ diffcore-rename.c: static int find_basename_matches(struct diff_options *options
      +			dst_index = strintmap_get(&dests, base);
      +			if (src_index == -1 || dst_index == -1) {
      +				src_index = i;
     -+				dst_index = idx_possible_rename(filename, info);
     ++				dst_index = idx_possible_rename(filename);
      +			}
      +			if (dst_index == -1)
      +				continue;
  8:  cbd055ab3399 !  2:  40f57bcc2055 diffcore-rename: add a new idx_possible_rename function
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diffcore-rename.c ##
     -@@ diffcore-rename.c: struct dir_rename_info {
     - 	unsigned setup;
     - };
     +@@ diffcore-rename.c: static int find_exact_renames(struct diff_options *options)
     + 	return renames;
     + }
       
     ++struct dir_rename_info {
     ++	struct strintmap idx_map;
     ++	struct strmap dir_rename_guess;
     ++	struct strmap *dir_rename_count;
     ++	unsigned setup;
     ++};
     ++
      +static char *get_dirname(const char *filename)
      +{
      +	char *slash = strrchr(filename, '/');
     -+	return slash ? xstrndup(filename, slash-filename) : xstrdup("");
     ++	return slash ? xstrndup(filename, slash - filename) : xstrdup("");
      +}
      +
     - static void dirname_munge(char *filename)
     + static const char *get_basename(const char *filename)
       {
     - 	char *slash = strrchr(filename, '/');
     + 	/*
      @@ diffcore-rename.c: static const char *get_basename(const char *filename)
       	return base ? base + 1 : filename;
       }
       
     -+MAYBE_UNUSED
     +-static int idx_possible_rename(char *filename)
      +static int idx_possible_rename(char *filename, struct dir_rename_info *info)
     -+{
     + {
     +-	/* Unconditionally return -1, "not found", for now */
     +-	return -1;
      +	/*
      +	 * Our comparison of files with the same basename (see
      +	 * find_basename_matches() below), is only helpful when after exact
     @@ diffcore-rename.c: static const char *get_basename(const char *filename)
      +	 *       rename.
      +	 *
      +	 * This function, idx_possible_rename(), is only responsible for (4).
     -+	 * The conditions/steps in (1)-(3) are handled via setting up
     -+	 * dir_rename_count and dir_rename_guess in
     -+	 * initialize_dir_rename_info().  Steps (0) and (5) are handled by
     -+	 * the caller of this function.
     ++	 * The conditions/steps in (1)-(3) will be handled via setting up
     ++	 * dir_rename_count and dir_rename_guess in a future
     ++	 * initialize_dir_rename_info() function.  Steps (0) and (5) are
     ++	 * handled by the caller of this function.
      +	 */
     -+	char *old_dir, *new_dir, *new_path;
     ++	char *old_dir, *new_dir;
     ++	struct strbuf new_path = STRBUF_INIT;
      +	int idx;
      +
      +	if (!info->setup)
     @@ diffcore-rename.c: static const char *get_basename(const char *filename)
      +	if (!new_dir)
      +		return -1;
      +
     -+	new_path = xstrfmt("%s/%s", new_dir, get_basename(filename));
     ++	strbuf_addstr(&new_path, new_dir);
     ++	strbuf_addch(&new_path, '/');
     ++	strbuf_addstr(&new_path, get_basename(filename));
      +
     -+	idx = strintmap_get(&info->idx_map, new_path);
     -+	free(new_path);
     ++	idx = strintmap_get(&info->idx_map, new_path.buf);
     ++	strbuf_release(&new_path);
      +	return idx;
     -+}
     -+
     + }
     + 
       static int find_basename_matches(struct diff_options *options,
     - 				 int minimum_score,
     - 				 struct dir_rename_info *info,
     +-				 int minimum_score)
     ++				 int minimum_score,
     ++				 struct dir_rename_info *info)
     + {
     + 	/*
     + 	 * When I checked in early 2020, over 76% of file renames in linux
     +@@ diffcore-rename.c: static int find_basename_matches(struct diff_options *options,
     + 			dst_index = strintmap_get(&dests, base);
     + 			if (src_index == -1 || dst_index == -1) {
     + 				src_index = i;
     +-				dst_index = idx_possible_rename(filename);
     ++				dst_index = idx_possible_rename(filename, info);
     + 			}
     + 			if (dst_index == -1)
     + 				continue;
     +@@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
     + 	int num_destinations, dst_cnt;
     + 	int num_sources, want_copies;
     + 	struct progress *progress = NULL;
     ++	struct dir_rename_info info;
     + 
     + 	trace2_region_enter("diff", "setup", options->repo);
     ++	info.setup = 0;
     + 	want_copies = (detect_rename == DIFF_DETECT_COPY);
     + 	if (!minimum_score)
     + 		minimum_score = DEFAULT_RENAME_SCORE;
     +@@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
     + 		/* Utilize file basenames to quickly find renames. */
     + 		trace2_region_enter("diff", "basename matches", options->repo);
     + 		rename_count += find_basename_matches(options,
     +-						      min_basename_score);
     ++						      min_basename_score,
     ++						      &info);
     + 		trace2_region_leave("diff", "basename matches", options->repo);
     + 
     + 		/*
  6:  dffecc064dd3 !  3:  0e14961574ea diffcore-rename: add a mapping of destination names to their indices
     @@ Metadata
       ## Commit message ##
          diffcore-rename: add a mapping of destination names to their indices
      
     -    Add an idx_map member to struct dir_rename_info, which tracks a mapping
     -    of the full filename to the index within rename_dst where that filename
     -    is found.  We will later use this for quickly finding an array entry in
     -    rename_dst given the pathname.
     +    Compute a mapping of full filename to the index within rename_dst where
     +    that filename is found, and store it in idx_map.  idx_possible_rename()
     +    needs this to quickly finding an array entry in rename_dst given the
     +    pathname.
     +
     +    While at it, add placeholder initializations for dir_rename_count and
     +    dir_rename_guess; these will be more fully populated in subsequent
     +    commits.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diffcore-rename.c ##
     -@@ diffcore-rename.c: static int find_exact_renames(struct diff_options *options)
     +@@ diffcore-rename.c: static char *get_dirname(const char *filename)
     + 	return slash ? xstrndup(filename, slash - filename) : xstrdup("");
       }
       
     - struct dir_rename_info {
     -+	struct strintmap idx_map;
     - 	struct strmap *dir_rename_count;
     - 	unsigned setup;
     - };
     -@@ diffcore-rename.c: static void initialize_dir_rename_info(struct dir_rename_info *info,
     - 		info->dir_rename_count = xmalloc(sizeof(*dir_rename_count));
     - 		strmap_init(info->dir_rename_count);
     - 	}
     ++static void initialize_dir_rename_info(struct dir_rename_info *info)
     ++{
     ++	int i;
     ++
     ++	info->setup = 1;
     ++
      +	strintmap_init_with_options(&info->idx_map, -1, NULL, 0);
     - 
     ++	strmap_init_with_options(&info->dir_rename_guess, NULL, 0);
     ++	info->dir_rename_count = NULL;
     ++
      +	/*
     -+	 * Loop setting up both info->idx_map, and doing setup of
     -+	 * info->dir_rename_count.
     ++	 * Loop setting up both info->idx_map.
      +	 */
     - 	for (i = 0; i < rename_dst_nr; ++i) {
     - 		/*
     --		 * Make dir_rename_count contain a map of a map:
     ++	for (i = 0; i < rename_dst_nr; ++i) {
     ++		/*
      +		 * For non-renamed files, make idx_map contain mapping of
      +		 *   filename -> index (index within rename_dst, that is)
      +		 */
      +		if (!rename_dst[i].is_rename) {
      +			char *filename = rename_dst[i].p->two->path;
      +			strintmap_set(&info->idx_map, filename, i);
     -+			continue;
      +		}
     ++	}
     ++}
     ++
     ++static void cleanup_dir_rename_info(struct dir_rename_info *info)
     ++{
     ++	if (!info->setup)
     ++		return;
      +
     -+		/*
     -+		 * For everything else (i.e. renamed files), make
     -+		 * dir_rename_count contain a map of a map:
     - 		 *   old_directory -> {new_directory -> count}
     - 		 * In other words, for every pair look at the directories for
     - 		 * the old filename and the new filename and count how many
     -@@ diffcore-rename.c: static void cleanup_dir_rename_info(struct dir_rename_info *info,
     - 	if (!info->setup)
     - 		return;
     - 
      +	/* idx_map */
      +	strintmap_clear(&info->idx_map);
      +
     - 	if (!keep_dir_rename_count) {
     - 		partial_clear_dir_rename_count(info->dir_rename_count);
     - 		strmap_clear(info->dir_rename_count, 1);
     ++	/* dir_rename_guess */
     ++	strmap_clear(&info->dir_rename_guess, 1);
     ++
     ++	/* Nothing to do for dir_rename_count, yet */
     ++}
     ++
     + static const char *get_basename(const char *filename)
     + {
     + 	/*
     +@@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
     + 		remove_unneeded_paths_from_src(want_copies);
     + 		trace2_region_leave("diff", "cull after exact", options->repo);
     + 
     ++		/* Preparation for basename-driven matching. */
     ++		trace2_region_enter("diff", "dir rename setup", options->repo);
     ++		initialize_dir_rename_info(&info);
     ++		trace2_region_leave("diff", "dir rename setup", options->repo);
     ++
     + 		/* Utilize file basenames to quickly find renames. */
     + 		trace2_region_enter("diff", "basename matches", options->repo);
     + 		rename_count += find_basename_matches(options,
     +@@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
     + 		if (rename_dst[i].filespec_to_free)
     + 			free_filespec(rename_dst[i].filespec_to_free);
     + 
     ++	cleanup_dir_rename_info(&info);
     + 	FREE_AND_NULL(rename_dst);
     + 	rename_dst_nr = rename_dst_alloc = 0;
     + 	FREE_AND_NULL(rename_src);
  1:  fec4f1d44c06 !  4:  9b9d5b207b03 Move computation of dir_rename_count from merge-ort to diffcore-rename
     @@ Metadata
       ## Commit message ##
          Move computation of dir_rename_count from merge-ort to diffcore-rename
      
     -    A previous commit noted that it is very common for people to move files
     -    across directories while keeping their filename the same.  The last few
     -    commits took advantage of this and showed that we can accelerate rename
     -    detection significantly using basenames; since files with the same
     -    basename serve as likely rename candidates, we can check those first and
     -    remove them from the rename candidate pool if they are sufficiently
     -    similar.
     +    Move the computation of dir_rename_count from merge-ort.c to
     +    diffcore-rename.c, making slight adjustments to the data structures
     +    based on the move.  While the diffstat looks large, viewing this commit
     +    with --color-moved makes it clear that only about 20 lines changed.
      
     -    Unfortunately, the previous optimization was limited by the fact that
     -    the remaining basenames after exact rename detection are not always
     -    unique.  Many repositories have hundreds of build files with the same
     -    name (e.g. Makefile, .gitignore, build.gradle, etc.), and may even have
     -    hundreds of source files with the same name.  (For example, the linux
     -    kernel has 100 setup.c, 87 irq.c, and 112 core.c files.  A repository at
     -    $DAYJOB has a lot of ObjectFactory.java and Plugin.java files).
     -
     -    For these files with non-unique basenames, we are faced with the task of
     -    attempting to determine or guess which directory they may have been
     -    relocated to.  Such a task is precisely the job of directory rename
     -    detection.  However, there are two catches: (1) the directory rename
     -    detection code has traditionally been part of the merge machinery rather
     -    than diffcore-rename.c, and (2) directory rename detection currently
     -    runs after regular rename detection is complete.  The 1st catch is just
     -    an implementation issue that can be overcome by some code shuffling.
     -    The 2nd requires us to add a further approximation: we only have access
     -    to exact renames at this point, so we need to do directory rename
     -    detection based on just exact renames.  In some cases we won't have
     -    exact renames, in which case this extra optimization won't apply.  We
     -    also choose to not apply the optimization unless we know that the
     -    underlying directory was removed, which will require extra data to be
     -    passed in to diffcore_rename_extended().  Also, even if we get a
     -    prediction about which directory a file may have relocated to, we will
     -    still need to check to see if there is a file in the predicted
     -    directory, and then compare the two files to see if they meet the higher
     -    min_basename_score threshold required for marking the two files as
     -    renames.
     -
     -    This commit and the next few will set up the necessary infrastructure to
     -    do such computations.  This commit merely moves the computation of
     -    dir_rename_count from merge-ort.c to diffcore-rename.c, making slight
     -    adjustments to the data structures based on the move.  While the
     -    diffstat looks large, viewing this commit with --color-moved makes it
     -    clear that only about 20 lines changed.  With this patch, the
     -    computation of dir_rename_count is still only done after inexact rename
     -    detection, but subsequent commits will add a preliminary computation of
     -    dir_rename_count after exact rename detection, followed by some updates
     -    after inexact rename detection.
     +    With this patch, the computation of dir_rename_count is still only done
     +    after inexact rename detection, but subsequent commits will add a
     +    preliminary computation of dir_rename_count after exact rename
     +    detection, followed by some updates after inexact rename detection.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diffcore-rename.c ##
     -@@ diffcore-rename.c: static int find_exact_renames(struct diff_options *options)
     - 	return renames;
     +@@ diffcore-rename.c: static char *get_dirname(const char *filename)
     + 	return slash ? xstrndup(filename, slash - filename) : xstrdup("");
       }
       
      +static void dirname_munge(char *filename)
     @@ diffcore-rename.c: static int find_exact_renames(struct diff_options *options)
      +
      +	/* Set up dir_rename_count */
      +	for (i = 0; i < rename_dst_nr; ++i) {
     ++		/* File not part of directory rename counts if not a rename */
     ++		if (!rename_dst[i].is_rename)
     ++			continue;
     ++
      +		/*
      +		 * Make dir_rename_count contain a map of a map:
      +		 *   old_directory -> {new_directory -> count}
     @@ diffcore-rename.c: static int find_exact_renames(struct diff_options *options)
      +	}
      +}
      +
     - static const char *get_basename(const char *filename)
     + static void initialize_dir_rename_info(struct dir_rename_info *info)
       {
     - 	/*
     + 	int i;
      @@ diffcore-rename.c: static void remove_unneeded_paths_from_src(int detecting_copies)
       	rename_src_nr = new_num_src;
       }
     @@ diffcore-rename.c: static void remove_unneeded_paths_from_src(int detecting_copi
       	int detect_rename = options->detect_rename;
       	int minimum_score = options->rename_score;
      @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
     - 	struct progress *progress = NULL;
       
       	trace2_region_enter("diff", "setup", options->repo);
     + 	info.setup = 0;
      +	assert(!dir_rename_count || strmap_empty(dir_rename_count));
       	want_copies = (detect_rename == DIFF_DETECT_COPY);
       	if (!minimum_score)
  2:  612da82f049c !  5:  f286e89464ea diffcore-rename: add functions for clearing dir_rename_count
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    diffcore-rename: add functions for clearing dir_rename_count
     +    diffcore-rename: add function for clearing dir_rename_count
      
     -    As we adjust the usage of dir_rename_count we want to have functions for
     -    clearing, or partially clearing it out.  Add such functions.
     +    As we adjust the usage of dir_rename_count we want to have a function
     +    for clearing, or partially clearing it out.  Add a
     +    partial_clear_dir_rename_count() function for this purpose.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diffcore-rename.c ##
     -@@ diffcore-rename.c: static void compute_dir_rename_counts(struct strmap *dir_rename_count,
     +@@ diffcore-rename.c: static void initialize_dir_rename_info(struct dir_rename_info *info)
       	}
       }
       
     @@ diffcore-rename.c: static void compute_dir_rename_counts(struct strmap *dir_rena
      +	strmap_partial_clear(dir_rename_count, 1);
      +}
      +
     -+MAYBE_UNUSED
     -+static void clear_dir_rename_count(struct strmap *dir_rename_count)
     -+{
     -+	partial_clear_dir_rename_count(dir_rename_count);
     -+	strmap_clear(dir_rename_count, 1);
     -+}
     -+
     - static const char *get_basename(const char *filename)
     + static void cleanup_dir_rename_info(struct dir_rename_info *info)
       {
     - 	/*
     + 	if (!info->setup)
      
       ## diffcore.h ##
      @@ diffcore.h: struct diff_filepair *diff_queue(struct diff_queue_struct *,
  3:  93f98fc0b264 !  6:  ab353f2e75eb diffcore-rename: move dir_rename_counts into a dir_rename_info struct
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    diffcore-rename: move dir_rename_counts into a dir_rename_info struct
     +    diffcore-rename: move dir_rename_counts into dir_rename_info struct
      
     -    This is a purely cosmetic change for now, but we will be adding
     -    additional information to the struct and changing where and how it is
     -    setup and used in subsequent patches.
     +    This continues the migration of the directory rename detection code into
     +    diffcore-rename, now taking the simple step of combining it with the
     +    dir_rename_info struct.  Future commits will then make dir_rename_counts
     +    be computed in stages, and add computation of dir_rename_guess.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diffcore-rename.c ##
     -@@ diffcore-rename.c: static int find_exact_renames(struct diff_options *options)
     - 	return renames;
     - }
     - 
     -+struct dir_rename_info {
     -+	struct strmap *dir_rename_count;
     -+	unsigned setup;
     -+};
     -+
     - static void dirname_munge(char *filename)
     - {
     - 	char *slash = strrchr(filename, '/');
      @@ diffcore-rename.c: static void dirname_munge(char *filename)
       	*slash = '\0';
       }
     @@ diffcore-rename.c: static void update_dir_rename_counts(struct strmap *dir_renam
      +	info->dir_rename_count = dir_rename_count;
      +
       	for (i = 0; i < rename_dst_nr; ++i) {
     - 		/*
     - 		 * Make dir_rename_count contain a map of a map:
     + 		/* File not part of directory rename counts if not a rename */
     + 		if (!rename_dst[i].is_rename)
      @@ diffcore-rename.c: static void compute_dir_rename_counts(struct strmap *dir_rename_count,
       		 * the old filename and the new filename and count how many
       		 * times that pairing occurs.
     @@ diffcore-rename.c: static void compute_dir_rename_counts(struct strmap *dir_rena
       					 rename_dst[i].p->one->path,
       					 rename_dst[i].p->two->path);
       	}
     -@@ diffcore-rename.c: void partial_clear_dir_rename_count(struct strmap *dir_rename_count)
     - }
     +@@ diffcore-rename.c: static void cleanup_dir_rename_info(struct dir_rename_info *info)
     + 	/* dir_rename_guess */
     + 	strmap_clear(&info->dir_rename_guess, 1);
       
     - MAYBE_UNUSED
     --static void clear_dir_rename_count(struct strmap *dir_rename_count)
     -+static void cleanup_dir_rename_info(struct dir_rename_info *info)
     - {
     --	partial_clear_dir_rename_count(dir_rename_count);
     --	strmap_clear(dir_rename_count, 1);
     -+	if (!info->setup)
     -+		return;
     -+
     +-	/* Nothing to do for dir_rename_count, yet */
     ++	/* dir_rename_count */
      +	partial_clear_dir_rename_count(info->dir_rename_count);
      +	strmap_clear(info->dir_rename_count, 1);
       }
       
       static const char *get_basename(const char *filename)
     -@@ diffcore-rename.c: void diffcore_rename_extended(struct diff_options *options,
     - 	int num_destinations, dst_cnt;
     - 	int num_sources, want_copies;
     - 	struct progress *progress = NULL;
     -+	struct dir_rename_info info;
     - 
     - 	trace2_region_enter("diff", "setup", options->repo);
     -+	info.setup = 0;
     - 	assert(!dir_rename_count || strmap_empty(dir_rename_count));
     - 	want_copies = (detect_rename == DIFF_DETECT_COPY);
     - 	if (!minimum_score)
      @@ diffcore-rename.c: void diffcore_rename_extended(struct diff_options *options,
       	/*
       	 * Now that renames have been computed, compute dir_rename_count */
  4:  f7bdad78219d !  7:  bd50d9e53804 diffcore-rename: extend cleanup_dir_rename_info()
     @@ Commit message
      
       ## diffcore-rename.c ##
      @@ diffcore-rename.c: void partial_clear_dir_rename_count(struct strmap *dir_rename_count)
     + 	strmap_partial_clear(dir_rename_count, 1);
       }
       
     - MAYBE_UNUSED
      -static void cleanup_dir_rename_info(struct dir_rename_info *info)
      +static void cleanup_dir_rename_info(struct dir_rename_info *info,
      +				    struct strset *dirs_removed,
     @@ diffcore-rename.c: void partial_clear_dir_rename_count(struct strmap *dir_rename
       {
      +	struct hashmap_iter iter;
      +	struct strmap_entry *entry;
     ++	struct string_list to_remove = STRING_LIST_INIT_NODUP;
     ++	int i;
      +
       	if (!info->setup)
       		return;
       
     +@@ diffcore-rename.c: static void cleanup_dir_rename_info(struct dir_rename_info *info)
     + 	strmap_clear(&info->dir_rename_guess, 1);
     + 
     + 	/* dir_rename_count */
      -	partial_clear_dir_rename_count(info->dir_rename_count);
      -	strmap_clear(info->dir_rename_count, 1);
      +	if (!keep_dir_rename_count) {
      +		partial_clear_dir_rename_count(info->dir_rename_count);
      +		strmap_clear(info->dir_rename_count, 1);
      +		FREE_AND_NULL(info->dir_rename_count);
     -+	} else {
     -+		/*
     -+		 * Although dir_rename_count was passed in
     -+		 * diffcore_rename_extended() and we want to keep it around and
     -+		 * return it to that caller, we first want to remove any data
     -+		 * associated with directories that weren't renamed.
     -+		 */
     -+		struct string_list to_remove = STRING_LIST_INIT_NODUP;
     -+		int i;
     ++		return;
     ++	}
      +
     -+		strmap_for_each_entry(info->dir_rename_count, &iter, entry) {
     -+			const char *source_dir = entry->key;
     -+			struct strintmap *counts = entry->value;
     ++	/*
     ++	 * Although dir_rename_count was passed in
     ++	 * diffcore_rename_extended() and we want to keep it around and
     ++	 * return it to that caller, we first want to remove any data
     ++	 * associated with directories that weren't renamed.
     ++	 */
     ++	strmap_for_each_entry(info->dir_rename_count, &iter, entry) {
     ++		const char *source_dir = entry->key;
     ++		struct strintmap *counts = entry->value;
      +
     -+			if (!strset_contains(dirs_removed, source_dir)) {
     -+				string_list_append(&to_remove, source_dir);
     -+				strintmap_clear(counts);
     -+				continue;
     -+			}
     ++		if (!strset_contains(dirs_removed, source_dir)) {
     ++			string_list_append(&to_remove, source_dir);
     ++			strintmap_clear(counts);
     ++			continue;
      +		}
     -+		for (i=0; i<to_remove.nr; ++i)
     -+			strmap_remove(info->dir_rename_count,
     -+				      to_remove.items[i].string, 1);
     -+		string_list_clear(&to_remove, 0);
      +	}
     ++	for (i = 0; i < to_remove.nr; ++i)
     ++		strmap_remove(info->dir_rename_count,
     ++			      to_remove.items[i].string, 1);
     ++	string_list_clear(&to_remove, 0);
       }
       
       static const char *get_basename(const char *filename)
     +@@ diffcore-rename.c: void diffcore_rename_extended(struct diff_options *options,
     + 		if (rename_dst[i].filespec_to_free)
     + 			free_filespec(rename_dst[i].filespec_to_free);
     + 
     +-	cleanup_dir_rename_info(&info);
     ++	cleanup_dir_rename_info(&info, dirs_removed, dir_rename_count != NULL);
     + 	FREE_AND_NULL(rename_dst);
     + 	rename_dst_nr = rename_dst_alloc = 0;
     + 	FREE_AND_NULL(rename_src);
  5:  3a29cf9e526f !  8:  44cfae6505f2 diffcore-rename: compute dir_rename_counts in stages
     @@ Metadata
       ## Commit message ##
          diffcore-rename: compute dir_rename_counts in stages
      
     -    We want to first compute dir_rename_counts based just on exact renames
     -    to start, as that can provide us useful information in
     -    find_basename_matches().  That will give us an incomplete result, which
     -    we can then later augment as basename and inexact rename matches are
     -    found.
     +    Compute dir_rename_counts based just on exact renames to start, as that
     +    can provide us useful information in find_basename_matches().  This is
     +    done by moving the code from compute_dir_rename_counts() into
     +    initialize_dir_rename_info(), resulting in it being computed earlier and
     +    based just on exact renames.  Since that's an incomplete result, we
     +    augment the counts via calling update_dir_rename_counts() after each
     +    basename-guide and inexact rename detection match is found.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ diffcore-rename.c: static void update_dir_rename_counts(struct dir_rename_info *
       {
       	int i;
       
     -+	info->setup = 0;
     -+	if (!dirs_removed)
     +-	info->setup = 1;
     +-	info->dir_rename_count = dir_rename_count;
     +-
     +-	for (i = 0; i < rename_dst_nr; ++i) {
     +-		/* File not part of directory rename counts if not a rename */
     +-		if (!rename_dst[i].is_rename)
     +-			continue;
     +-
     +-		/*
     +-		 * Make dir_rename_count contain a map of a map:
     +-		 *   old_directory -> {new_directory -> count}
     +-		 * In other words, for every pair look at the directories for
     +-		 * the old filename and the new filename and count how many
     +-		 * times that pairing occurs.
     +-		 */
     +-		update_dir_rename_counts(info, dirs_removed,
     +-					 rename_dst[i].p->one->path,
     +-					 rename_dst[i].p->two->path);
     ++	if (!dirs_removed) {
     ++		info->setup = 0;
      +		return;
     + 	}
     +-}
     +-
     +-static void initialize_dir_rename_info(struct dir_rename_info *info)
     +-{
     +-	int i;
     +-
       	info->setup = 1;
     -+
     - 	info->dir_rename_count = dir_rename_count;
     + 
     ++	info->dir_rename_count = dir_rename_count;
      +	if (!info->dir_rename_count) {
      +		info->dir_rename_count = xmalloc(sizeof(*dir_rename_count));
      +		strmap_init(info->dir_rename_count);
      +	}
     + 	strintmap_init_with_options(&info->idx_map, -1, NULL, 0);
     + 	strmap_init_with_options(&info->dir_rename_guess, NULL, 0);
     +-	info->dir_rename_count = NULL;
       
     + 	/*
     +-	 * Loop setting up both info->idx_map.
     ++	 * Loop setting up both info->idx_map, and doing setup of
     ++	 * info->dir_rename_count.
     + 	 */
       	for (i = 0; i < rename_dst_nr; ++i) {
       		/*
     -@@ diffcore-rename.c: void partial_clear_dir_rename_count(struct strmap *dir_rename_count)
     - 	strmap_partial_clear(dir_rename_count, 1);
     +@@ diffcore-rename.c: static void initialize_dir_rename_info(struct dir_rename_info *info)
     + 		if (!rename_dst[i].is_rename) {
     + 			char *filename = rename_dst[i].p->two->path;
     + 			strintmap_set(&info->idx_map, filename, i);
     ++			continue;
     + 		}
     ++
     ++		/*
     ++		 * For everything else (i.e. renamed files), make
     ++		 * dir_rename_count contain a map of a map:
     ++		 *   old_directory -> {new_directory -> count}
     ++		 * In other words, for every pair look at the directories for
     ++		 * the old filename and the new filename and count how many
     ++		 * times that pairing occurs.
     ++		 */
     ++		update_dir_rename_counts(info, dirs_removed,
     ++					 rename_dst[i].p->one->path,
     ++					 rename_dst[i].p->two->path);
     + 	}
       }
       
     --MAYBE_UNUSED
     - static void cleanup_dir_rename_info(struct dir_rename_info *info,
     - 				    struct strset *dirs_removed,
     - 				    int keep_dir_rename_count)
     -@@ diffcore-rename.c: static const char *get_basename(const char *filename)
     - }
     +@@ diffcore-rename.c: static int idx_possible_rename(char *filename, struct dir_rename_info *info)
       
       static int find_basename_matches(struct diff_options *options,
     --				 int minimum_score)
     -+				 int minimum_score,
     + 				 int minimum_score,
     +-				 struct dir_rename_info *info)
      +				 struct dir_rename_info *info,
      +				 struct strset *dirs_removed)
       {
     @@ diffcore-rename.c: void diffcore_rename_extended(struct diff_options *options,
       		minimum_score = DEFAULT_RENAME_SCORE;
       
      @@ diffcore-rename.c: void diffcore_rename_extended(struct diff_options *options,
     - 		remove_unneeded_paths_from_src(want_copies);
     - 		trace2_region_leave("diff", "cull after exact", options->repo);
       
     -+		/* Preparation for basename-driven matching. */
     -+		trace2_region_enter("diff", "dir rename setup", options->repo);
     + 		/* Preparation for basename-driven matching. */
     + 		trace2_region_enter("diff", "dir rename setup", options->repo);
     +-		initialize_dir_rename_info(&info);
      +		initialize_dir_rename_info(&info,
      +					   dirs_removed, dir_rename_count);
     -+		trace2_region_leave("diff", "dir rename setup", options->repo);
     -+
     + 		trace2_region_leave("diff", "dir rename setup", options->repo);
     + 
       		/* Utilize file basenames to quickly find renames. */
       		trace2_region_enter("diff", "basename matches", options->repo);
       		rename_count += find_basename_matches(options,
     --						      min_basename_score);
     -+						      min_basename_score,
     + 						      min_basename_score,
     +-						      &info);
      +						      &info, dirs_removed);
       		trace2_region_leave("diff", "basename matches", options->repo);
       
     @@ diffcore-rename.c: void diffcore_rename_extended(struct diff_options *options,
       	/* At this point, we have found some renames and copies and they
       	 * are recorded in rename_dst.  The original list is still in *q.
       	 */
     -@@ diffcore-rename.c: void diffcore_rename_extended(struct diff_options *options,
     - 		if (rename_dst[i].filespec_to_free)
     - 			free_filespec(rename_dst[i].filespec_to_free);
     - 
     -+	cleanup_dir_rename_info(&info, dirs_removed, dir_rename_count != NULL);
     - 	FREE_AND_NULL(rename_dst);
     - 	rename_dst_nr = rename_dst_alloc = 0;
     - 	FREE_AND_NULL(rename_src);
  9:  4e095ea7c439 !  9:  752aff3a7995 diffcore-rename: limit dir_rename_counts computation to relevant dirs
     @@ Commit message
          for directories that disappeared, though, so we can return early from
          update_dir_rename_counts() for other paths.
      
     -    While dirs_removed provides the relevant information for us right now,
     -    we introduce a new info->relevant_source_dirs parameter because future
     -    optimizations will want to change how things are called somewhat.
     +    If dirs_removed is passed to diffcore_rename_extended(), then it
     +    provides the relevant bits of information for us to limit this counting
     +    to relevant dirs.  If dirs_removed is not passed, we would need to
     +    compute some replacement in order to do this limiting.  Introduce a new
     +    info->relevant_source_dirs variable for this purpose, even though at
     +    this stage we will only set it to dirs_removed for simplicity.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
  7:  4983a1c2f908 ! 10:  65f7bfb735f2 diffcore-rename: add a dir_rename_guess field to dir_rename_info
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    diffcore-rename: add a dir_rename_guess field to dir_rename_info
     +    diffcore-rename: compute dir_rename_guess from dir_rename_counts
      
          dir_rename_counts has a mapping of a mapping, in particular, it has
             old_dir => { new_dir => count }
          We want a simple mapping of
             old_dir => new_dir
          based on which new_dir had the highest count for a given old_dir.
     -    Introduce dir_rename_guess for this purpose.
     +    Compute this and store it in dir_rename_guess.
     +
     +    This is the final piece of the puzzle needed to make our guesses at
     +    which directory files have been moved to when basenames aren't unique.
     +
     +    For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
     +    performance work; instrument with trace2_region_* calls", 2020-10-28),
     +    this change improves the performance as follows:
     +
     +                                Before                  After
     +        no-renames:       12.775 s ±  0.062 s    12.596 s ±  0.061 s
     +        mega-renames:    188.754 s ±  0.284 s   130.465 s ±  0.259 s
     +        just-one-mega:     5.599 s ±  0.019 s     3.958 s ±  0.010 s
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diffcore-rename.c ##
     -@@ diffcore-rename.c: static int find_exact_renames(struct diff_options *options)
     - 
     - struct dir_rename_info {
     - 	struct strintmap idx_map;
     -+	struct strmap dir_rename_guess;
     - 	struct strmap *dir_rename_count;
     - 	unsigned setup;
     - };
      @@ diffcore-rename.c: static void dirname_munge(char *filename)
       	*slash = '\0';
       }
     @@ diffcore-rename.c: static void initialize_dir_rename_info(struct dir_rename_info
      +	struct strmap_entry *entry;
       	int i;
       
     - 	info->setup = 0;
     -@@ diffcore-rename.c: static void initialize_dir_rename_info(struct dir_rename_info *info,
     - 		strmap_init(info->dir_rename_count);
     - 	}
     - 	strintmap_init_with_options(&info->idx_map, -1, NULL, 0);
     -+	strmap_init_with_options(&info->dir_rename_guess, NULL, 0);
     - 
     - 	/*
     - 	 * Loop setting up both info->idx_map, and doing setup of
     + 	if (!dirs_removed) {
      @@ diffcore-rename.c: static void initialize_dir_rename_info(struct dir_rename_info *info,
       					 rename_dst[i].p->one->path,
       					 rename_dst[i].p->two->path);
     @@ diffcore-rename.c: static void initialize_dir_rename_info(struct dir_rename_info
       }
       
       void partial_clear_dir_rename_count(struct strmap *dir_rename_count)
     -@@ diffcore-rename.c: static void cleanup_dir_rename_info(struct dir_rename_info *info,
     - 	/* idx_map */
     - 	strintmap_clear(&info->idx_map);
     - 
     -+	/* dir_rename_guess */
     -+	strmap_clear(&info->dir_rename_guess, 1);
     -+
     - 	if (!keep_dir_rename_count) {
     - 		partial_clear_dir_rename_count(info->dir_rename_count);
     - 		strmap_clear(info->dir_rename_count, 1);
     +@@ diffcore-rename.c: static int idx_possible_rename(char *filename, struct dir_rename_info *info)
     + 	 *       rename.
     + 	 *
     + 	 * This function, idx_possible_rename(), is only responsible for (4).
     +-	 * The conditions/steps in (1)-(3) will be handled via setting up
     +-	 * dir_rename_count and dir_rename_guess in a future
     +-	 * initialize_dir_rename_info() function.  Steps (0) and (5) are
     +-	 * handled by the caller of this function.
     ++	 * The conditions/steps in (1)-(3) are handled via setting up
     ++	 * dir_rename_count and dir_rename_guess in
     ++	 * initialize_dir_rename_info().  Steps (0) and (5) are handled by
     ++	 * the caller of this function.
     + 	 */
     + 	char *old_dir, *new_dir;
     + 	struct strbuf new_path = STRBUF_INIT;

-- 
gitgitgadget
