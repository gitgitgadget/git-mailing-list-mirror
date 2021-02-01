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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE9FC433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 12:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6767364E9E
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 12:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhBAMsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 07:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhBAMsL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 07:48:11 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9877FC061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 04:47:30 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id z6so16374367wrq.10
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 04:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mO83M52lNWd6wV8/UevsGDFQqDTiqpfwYE8RZKSA0Rk=;
        b=gA14YnOl2rx/EW7aZ5XTQHPZQ2ozYLPs7HlV74sOdukT1Kq3yhd0LR+Hm0reikpTiV
         HkWgudEl2yW7O4KunQ5IEftRUtpbesrHJO+2RjP0T1OjYC7j1/Fcr/BGUUsvsUL7A1o2
         Hp3GuhXDzaZzCKcQhc5a9cg1RAC3i5lFfgK5L0W4+3mWy3h9BQ/LaYS7Huh06iOMMDV2
         eJIS6qHX3tff7bTaBcUzSsjpzpXBuxi+gJRWLZRLnHZW/kPMCwUSPY1aE4nfUKYlCV/d
         7goLtGsIyHQpVGAh0PxXdo0Ojzyu+LX/dhstamLmyZLIoN+TaqxEOncAYGgVZ9nGa6Wg
         eY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mO83M52lNWd6wV8/UevsGDFQqDTiqpfwYE8RZKSA0Rk=;
        b=O7XayZ13xrSnbstv5cdHj4G3c0UH+N+OpYlIoBvruLZ8i/cPc+rwoyFSDBBv0fer7N
         b56yPKqciih2gsb0e6hDYDxJekUrOm7DQwlqR7R3J6jdkPARex3GsEbcsnS8mgCG7ZH/
         T/E6CUMobvAxRpbDiq3fyDP6O0ylHJxoeWRYlR3UQlYVSBxE8qBXPttCBpsP6JtlvZKa
         VQU8EKDtXzHK43DCkxF31NWYtCVyFwdRr38qgTTkxVz+EwvtFO95/aslH8cHVzuA6BPT
         LLAMjQwAIcSRkOTs5gMpEKiDp2TC5mdlX5GGc9JGbhC52CGZxMvq7A9V7+izolAMnU/y
         NK+g==
X-Gm-Message-State: AOAM530Jr/i2CvYHPsS+3s4H4DRVyhn9n21usy3v5EWasCMjPWTMOKYt
        oR93UQYXTkA16tUqAVlcpNbMZs/FNeU=
X-Google-Smtp-Source: ABdhPJy4zMF8z4YpAIvPCarXuXKkXFI730MXQb1K7XhFlQAgwRo7NIznz7dvfht9be/YC/T5OeEmlg==
X-Received: by 2002:a5d:690e:: with SMTP id t14mr17816042wru.64.1612183648739;
        Mon, 01 Feb 2021 04:47:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j13sm20800293wmi.24.2021.02.01.04.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 04:47:28 -0800 (PST)
Message-Id: <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
In-Reply-To: <pull.852.git.1611851095.gitgitgadget@gmail.com>
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 12:47:22 +0000
Subject: [PATCH v2 0/5] Speed up remove_redundant()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, me@ttaylorr.com,
        peff@peff.net, gitster@pobox.com,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty pointed out that git merge-base --independent is quite slow
when many commits are provided in the input. This boils down to some
quadratic behavior in remove_redundant() because it calls
paint_down_to_common() in a loop.

This series avoids that by using a single commit walk, pushing a flag that
means "this commit is reachable from a parent of a commit in the list." At
the end of the walk, the input commits without that flag are independent.

There is an extra performance enhancement using the first-parent history as
a heuristic. This helps only when there is a single independent result, as
we can short circuit the walk when all other inputs are found to be
reachable from the top one. It also gets faster when we discover the commit
with lowest generation and can restrict our walk further to the next-lowest
generation number.

My tests were on the Linux kernel repository, testing this command:

  git merge-base --independent $(git for-each-ref refs/tags --format="%(refname)")

       Before: 16.4s
After Patch 1:  1.1s
After Patch 2:  0.1s

This does not change the correctness of the function. It is tested carefully
in t6600-test-reach.c, among existing merge-base tests. There are also more
tests in scripts like t6012-rev-list-simplify.sh that trigger the new logic
under GIT_TEST_COMMIT_GRAPH=1.


Updates in V2
=============

 * The old algorithm is not entirely removed. It is still faster than the
   new algorithm if all input commits are not in the commit-graph file
   (unless the commit-graph file is really close to the input commits, but
   that is an unreasonable expectation). Now, the new logic only happens if
   there is an input commit with finite generation number.

 * There was a copy of 'array' being used for the final reorder which is now
   removed. We still need to be careful about the RESULT bit.

 * The final patch is new, adding yet another speedup in the form of
   increasing the min_generation cutoff when we find the input commit of
   smallest generation. This can reduce the time significantly when given
   many inputs. This does require copying the 'array' again, so we can sort
   by generation number while preserving the original order of 'array' which
   is required by some callers.

Thanks, -Stolee

Derrick Stolee (5):
  commit-reach: reduce requirements for remove_redundant()
  commit-reach: use one walk in remove_redundant()
  commit-reach: move compare_commits_by_gen
  commit-reach: use heuristic in remove_redundant()
  commit-reach: stale commits may prune generation further

 commit-reach.c | 188 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 166 insertions(+), 22 deletions(-)


base-commit: 5a3b130cad0d5c770f766e3af6d32b41766374c0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-852%2Fderrickstolee%2Fmerge-independent-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-852/derrickstolee/merge-independent-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/852

Range-diff vs v1:

 -:  ----------- > 1:  649f6799e6b commit-reach: reduce requirements for remove_redundant()
 1:  3fe74e339fc ! 2:  2f80ae5fcb0 commit-reach: use one walk in remove_redundant()
     @@ Commit message
           Before: 16.4s
            After:  1.1s
      
     +    This performance improvement requires the commit-graph file to be
     +    present. We keep the old algorithm around as remove_redundant_no_gen()
     +    and use it when generation_numbers_enabled() is false. This is similar
     +    to other algorithms within commit-reach.c. The new algorithm is
     +    implemented in remove_redundant_with_gen().
     +
          The basic approach is to do one commit walk instead of many. First, scan
          all commits in the list and mark their _parents_ with the STALE flag.
          This flag will indicate commits that are reachable from one of the
     @@ Commit message
          covering all commits up to the minimum generation number pushing the
          STALE flag throughout.
      
     -    At the end of the walk, commits in the input list that have the STALE
     -    flag are reachable from a _different_ commit in the list. These should
     -    be moved to the end of the array while the others are shifted to the
     -    front.
     +    At the end, we need to clear the STALE bit from all of the commits
     +    we walked. We move the non-stale commits in 'array' to the beginning of
     +    the list, and this might overwrite stale commits. However, we store an
     +    array of commits that started the walk, and use clear_commit_marks() on
     +    each of those starting commits. That method will walk the reachable
     +    commits with the STALE bit and clear them all. This makes the algorithm
     +    safe for re-entry or for other uses of those commits after this walk.
      
          This logic is covered by tests in t6600-test-reach.sh, so the behavior
     -    does not change.
     +    does not change. This is tested both in the case with a commit-graph and
     +    without.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## commit-reach.c ##
     +@@ commit-reach.c: struct commit_list *get_octopus_merge_bases(struct commit_list *in)
     + 	return ret;
     + }
     + 
     +-static int remove_redundant(struct repository *r, struct commit **array, int cnt)
     ++static int remove_redundant_no_gen(struct repository *r,
     ++				   struct commit **array, int cnt)
     + {
     +-	/*
     +-	 * Some commit in the array may be an ancestor of
     +-	 * another commit.  Move the independent commits to the
     +-	 * beginning of 'array' and return their number. Callers
     +-	 * should not rely upon the contents of 'array' after
     +-	 * that number.
     +-	 */
     + 	struct commit **work;
     + 	unsigned char *redundant;
     + 	int *filled_index;
      @@ commit-reach.c: static int remove_redundant(struct repository *r, struct commit **array, int cnt
     - 	 * the array, and return the number of commits that
     - 	 * are independent from each other.
     - 	 */
     --	struct commit **work;
     --	unsigned char *redundant;
     --	int *filled_index;
     --	int i, j, filled;
     + 	for (i = filled = 0; i < cnt; i++)
     + 		if (!redundant[i])
     + 			array[filled++] = work[i];
     ++	for (j = filled, i = 0; i < cnt; i++)
     ++		if (redundant[i])
     ++			array[j++] = work[i];
     + 	free(work);
     + 	free(redundant);
     + 	free(filled_index);
     + 	return filled;
     + }
     + 
     ++static int remove_redundant_with_gen(struct repository *r,
     ++				     struct commit **array, int cnt)
     ++{
      +	int i, count_non_stale = 0;
      +	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
     -+	struct commit **dup;
     ++	struct commit **walk_start;
     ++	size_t walk_start_nr = 0, walk_start_alloc = cnt;
      +	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
     - 
     --	work = xcalloc(cnt, sizeof(*work));
     --	redundant = xcalloc(cnt, 1);
     --	ALLOC_ARRAY(filled_index, cnt - 1);
     ++
     ++	ALLOC_ARRAY(walk_start, walk_start_alloc);
     ++
      +	/* Mark all parents of the input as STALE */
      +	for (i = 0; i < cnt; i++) {
      +		struct commit_list *parents;
      +		timestamp_t generation;
     - 
     --	for (i = 0; i < cnt; i++)
     - 		repo_parse_commit(r, array[i]);
     --	for (i = 0; i < cnt; i++) {
     --		struct commit_list *common;
     --		timestamp_t min_generation = commit_graph_generation(array[i]);
     ++
     ++		repo_parse_commit(r, array[i]);
      +		parents = array[i]->parents;
      +
      +		while (parents) {
      +			repo_parse_commit(r, parents->item);
      +			if (!(parents->item->object.flags & STALE)) {
      +				parents->item->object.flags |= STALE;
     ++				ALLOC_GROW(walk_start, walk_start_nr + 1, walk_start_alloc);
     ++				walk_start[walk_start_nr++] = parents->item;
      +				prio_queue_put(&queue, parents->item);
      +			}
      +			parents = parents->next;
     @@ commit-reach.c: static int remove_redundant(struct repository *r, struct commit
      +		struct commit *c = prio_queue_get(&queue);
      +
      +		repo_parse_commit(r, c);
     - 
     --		if (redundant[i])
     ++
      +		if (commit_graph_generation(c) < min_generation)
     - 			continue;
     --		for (j = filled = 0; j < cnt; j++) {
     --			timestamp_t curr_generation;
     --			if (i == j || redundant[j])
     --				continue;
     --			filled_index[filled] = j;
     --			work[filled++] = array[j];
     - 
     --			curr_generation = commit_graph_generation(array[j]);
     --			if (curr_generation < min_generation)
     --				min_generation = curr_generation;
     ++			continue;
     ++
      +		parents = c->parents;
      +		while (parents) {
      +			if (!(parents->item->object.flags & STALE)) {
     @@ commit-reach.c: static int remove_redundant(struct repository *r, struct commit
      +	}
      +
      +	/* rearrange array */
     -+	dup = xcalloc(cnt, sizeof(struct commit *));
     -+	COPY_ARRAY(dup, array, cnt);
     -+	for (i = 0; i < cnt; i++) {
     -+		if (dup[i]->object.flags & STALE) {
     -+			int insert = cnt - 1 - (i - count_non_stale);
     -+			array[insert] = dup[i];
     -+		} else {
     -+			array[count_non_stale] = dup[i];
     -+			count_non_stale++;
     -+		}
     ++	for (i = count_non_stale = 0; i < cnt; i++) {
     ++		if (!(array[i]->object.flags & STALE))
     ++			array[count_non_stale++] = array[i];
      +	}
     -+	free(dup);
      +
      +	/* clear marks */
     -+	for (i = 0; i < cnt; i++) {
     -+		struct commit_list *parents;
     -+		parents = array[i]->parents;
     ++	for (i = 0; i < walk_start_nr; i++)
     ++		clear_commit_marks(walk_start[i], STALE);
     ++	free(walk_start);
      +
     -+		while (parents) {
     -+			clear_commit_marks(parents->item, STALE);
     -+			parents = parents->next;
     - 		}
     --		common = paint_down_to_common(r, array[i], filled,
     --					      work, min_generation);
     --		if (array[i]->object.flags & PARENT2)
     --			redundant[i] = 1;
     --		for (j = 0; j < filled; j++)
     --			if (work[j]->object.flags & PARENT1)
     --				redundant[filled_index[j]] = 1;
     --		clear_commit_marks(array[i], all_flags);
     --		clear_commit_marks_many(filled, work, all_flags);
     --		free_commit_list(common);
     - 	}
     - 
     --	/* Now collect the result */
     --	COPY_ARRAY(work, array, cnt);
     --	for (i = filled = 0; i < cnt; i++)
     --		if (!redundant[i])
     --			array[filled++] = work[i];
     --	for (j = filled, i = 0; i < cnt; i++)
     --		if (redundant[i])
     --			array[j++] = work[i];
     --	free(work);
     --	free(redundant);
     --	free(filled_index);
     --	return filled;
      +	return count_non_stale;
     - }
     - 
     ++}
     ++
     ++static int remove_redundant(struct repository *r, struct commit **array, int cnt)
     ++{
     ++	/*
     ++	 * Some commit in the array may be an ancestor of
     ++	 * another commit.  Move the independent commits to the
     ++	 * beginning of 'array' and return their number. Callers
     ++	 * should not rely upon the contents of 'array' after
     ++	 * that number.
     ++	 */
     ++	if (generation_numbers_enabled(r)) {
     ++		int i;
     ++
     ++		/*
     ++		 * If we have a single commit with finite generation
     ++		 * number, then the _with_gen algorithm is preferred.
     ++		 */
     ++		for (i = 0; i < cnt; i++) {
     ++			if (commit_graph_generation(array[i]) < GENERATION_NUMBER_INFINITY)
     ++				return remove_redundant_with_gen(r, array, cnt);
     ++		}
     ++	}
     ++
     ++	return remove_redundant_no_gen(r, array, cnt);
     ++}
     ++
       static struct commit_list *get_merge_bases_many_0(struct repository *r,
     + 						  struct commit *one,
     + 						  int n,
 2:  4c58877a709 = 3:  009f64b53c9 commit-reach: move compare_commits_by_gen
 3:  fbe7bdc1ec2 ! 4:  83feabeebb5 commit-reach: use heuristic in remove_redundant()
     @@ Commit message
          the heuristic of searching the first parent history before continuing to
          expand the walk.
      
     +    The order in which we explore the commits matters, so update
     +    compare_commits_by_gen to break generation number ties with commit date.
     +    This has no effect when the commits are in a commit-graph file with
     +    corrected commit dates computed, but it will assist when the commits are
     +    in the region "above" the commit-graph with "infinite" generation
     +    number. Note that we cannot shift to use
     +    compare_commits_by_gen_then_commit_date as the method prototype is
     +    different. We use compare_commits_by_gen for QSORT() as opposed to as a
     +    priority function.
     +
          The important piece is to ensure we short-circuit the walk when we find
          that there is a single non-redundant commit. This happens frequently
          when looking for merge-bases or comparing several tags with 'git
     @@ Commit message
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## commit-reach.c ##
     -@@ commit-reach.c: static int remove_redundant(struct repository *r, struct commit **array, int cnt
     - 	 * the array, and return the number of commits that
     - 	 * are independent from each other.
     - 	 */
     +@@ commit-reach.c: static int compare_commits_by_gen(const void *_a, const void *_b)
     + 		return -1;
     + 	if (generation_a > generation_b)
     + 		return 1;
     ++	if (a->date < b->date)
     ++		return -1;
     ++	if (a->date > b->date)
     ++		return 1;
     + 	return 0;
     + }
     + 
     +@@ commit-reach.c: static int remove_redundant_no_gen(struct repository *r,
     + static int remove_redundant_with_gen(struct repository *r,
     + 				     struct commit **array, int cnt)
     + {
      -	int i, count_non_stale = 0;
      +	int i, count_non_stale = 0, count_still_independent = cnt;
       	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
     - 	struct commit **dup;
     + 	struct commit **walk_start;
     + 	size_t walk_start_nr = 0, walk_start_alloc = cnt;
      -	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
     -+	struct commit **walk_start;
     -+	size_t walk_start_nr = 0, walk_start_alloc = cnt;
     -+
     -+	ALLOC_ARRAY(walk_start, walk_start_alloc);
       
     - 	/* Mark all parents of the input as STALE */
     - 	for (i = 0; i < cnt; i++) {
     -@@ commit-reach.c: static int remove_redundant(struct repository *r, struct commit **array, int cnt
     + 	ALLOC_ARRAY(walk_start, walk_start_alloc);
     + 
     +@@ commit-reach.c: static int remove_redundant_with_gen(struct repository *r,
       		timestamp_t generation;
       
       		repo_parse_commit(r, array[i]);
     @@ commit-reach.c: static int remove_redundant(struct repository *r, struct commit
       		parents = array[i]->parents;
       
       		while (parents) {
     - 			repo_parse_commit(r, parents->item);
     - 			if (!(parents->item->object.flags & STALE)) {
     +@@ commit-reach.c: static int remove_redundant_with_gen(struct repository *r,
       				parents->item->object.flags |= STALE;
     + 				ALLOC_GROW(walk_start, walk_start_nr + 1, walk_start_alloc);
     + 				walk_start[walk_start_nr++] = parents->item;
      -				prio_queue_put(&queue, parents->item);
     -+				ALLOC_GROW(walk_start, walk_start_nr + 1, walk_start_alloc);
     -+				walk_start[walk_start_nr++] = parents->item;
       			}
       			parents = parents->next;
       		}
     -@@ commit-reach.c: static int remove_redundant(struct repository *r, struct commit **array, int cnt
     +@@ commit-reach.c: static int remove_redundant_with_gen(struct repository *r,
       			min_generation = generation;
       	}
       
     @@ commit-reach.c: static int remove_redundant(struct repository *r, struct commit
       		}
      +		free_commit_list(stack);
       	}
     -+	free(walk_start);
       
     ++	/* clear result */
     ++	for (i = 0; i < cnt; i++)
     ++		array[i]->object.flags &= ~RESULT;
     ++
       	/* rearrange array */
     - 	dup = xcalloc(cnt, sizeof(struct commit *));
     - 	COPY_ARRAY(dup, array, cnt);
     - 	for (i = 0; i < cnt; i++) {
     -+		dup[i]->object.flags &= ~RESULT;
     - 		if (dup[i]->object.flags & STALE) {
     - 			int insert = cnt - 1 - (i - count_non_stale);
     - 			array[insert] = dup[i];
     + 	for (i = count_non_stale = 0; i < cnt; i++) {
     + 		if (!(array[i]->object.flags & STALE))
 -:  ----------- > 5:  14f0974c987 commit-reach: stale commits may prune generation further

-- 
gitgitgadget
