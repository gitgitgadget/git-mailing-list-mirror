Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC381C41604
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 14:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 566FA2076C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 14:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEy5o4FN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgJGOJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 10:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgJGOJv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 10:09:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1983FC0613D3
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 07:09:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q5so2542831wmq.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 07:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=YrESpjk1p6CnLRfeJsQH8P3xj5qHZ/7iabwpl0SjsWA=;
        b=tEy5o4FNgWnSdlE33mXKsY4fqBRVgQp3hHp/n8lKjYTafT8jiAddj+6Y7HuxOZvIOD
         Kn3Dmm/Mzh2QedA3AA/UsDdEKrcAAE4tcTKRvld1RblOsMWXUbEqSHyyBBypBNvXyM+y
         7tr5TKJFej3kBHkvudlN4/0F9hrQWlfNneYfDkcJcKSe7GEunZGKIi5PN8e6rOSkfTZT
         sv1f+zURIKjMInA9+uTztusryrxlOzy6G3rFvBiTacsIzMtmJZ5yR1I72P9L3jxgluYB
         tYR0ktVQthJ+z5gHZofwuQp/8hGPcMEt+gnsKUjtimfnwIbZzwCjznHoMuzhF9XnpBM7
         WcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=YrESpjk1p6CnLRfeJsQH8P3xj5qHZ/7iabwpl0SjsWA=;
        b=A6q5n1xIU6P3zgsWb+cSvYU163YAxBixUVUlMiP249iRfsCvMNbVa/wHDfNdE1N6Uu
         E01KGMTMri9/XcbFlyN64CRygYi9Gb+a6tRVYM2zFRdPvw1fE8F2o+sExlJEOyX+y6G4
         iderLoq/nkHX4ejNZ+7f8/uoz/Sr/hD4AMa8x9oPSBD57dJbxlS09iTKKSUHSCd6H7NR
         j1/7HbRHGZ+OS813hCv0HQfaKGPVchO6QieiRjcweOH1GjCTgDx3EJnjJsnsYlH9gjHy
         zLXyy7DdwPaEtOGLl/BwwNM6l/82WQg0C6R1t+swmXIclYQ6KrhXnkX80GyyTiJTlbBx
         RPLA==
X-Gm-Message-State: AOAM532BTEAU26v+rKA7tPpgC0pA4G3s/3nOaTd6jO9A/ziNyMGsHwTe
        nMi3feB+Z3tJkPK9D8QSDRhS0pNNfeo=
X-Google-Smtp-Source: ABdhPJwpMST5SNb7vLOCcVmjsDhHNZ1CPC0whqHOpGXtMjPnGDgvMByoDXiO1Kw9pW//bX9TsJZn+A==
X-Received: by 2002:a1c:2394:: with SMTP id j142mr3378334wmj.3.1602079787841;
        Wed, 07 Oct 2020 07:09:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g14sm3097777wrx.22.2020.10.07.07.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 07:09:47 -0700 (PDT)
Message-Id: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Oct 2020 14:09:35 +0000
Subject: [PATCH v4 00/10] [GSoC] Implement Corrected Commit Date
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series implements the corrected commit date offsets as generation
number v2, along with other pre-requisites.

Git uses topological levels in the commit-graph file for commit-graph
traversal operations like git log --graph. Unfortunately, using topological
levels can result in a worse performance than without them when compared
with committer date as a heuristics. For example, git merge-base v4.8 v4.9 
on the Linux repository walks 635,579 commits using topological levels and
walks 167,468 using committer date.

Thus, the need for generation number v2 was born. New generation number
needed to provide good performance, increment updates, and backward
compatibility. Due to an unfortunate problem 1
[https://public-inbox.org/git/87a7gdspo4.fsf@evledraar.gmail.com/], we also
needed a way to distinguish between the old and new generation number
without incrementing graph version.

Various candidates were examined (https://github.com/derrickstolee/gen-test, 
https://github.com/abhishekkumar2718/git/pull/1). The proposed generation
number v2, Corrected Commit Date with Mononotically Increasing Offsets 
performed much worse than committer date (506,577 vs. 167,468 commits walked
for git merge-base v4.8 v4.9) and was dropped.

Using Generation Data chunk (GDAT) relieves the requirement of backward
compatibility as we would continue to store topological levels in Commit
Data (CDAT) chunk. Thus, Corrected Commit Date was chosen as generation
number v2. The Corrected Commit Date is defined as:

For a commit C, let its corrected commit date be the maximum of the commit
date of C and the corrected commit dates of its parents plus 1. Then 
corrected commit date offset is the difference between corrected commit date
of C and commit date of C. As a special case, a root commit with timestamp
zero has corrected commit date of 1 to be able distinguish it from
GENERATION_NUMBER_ZERO (that is, an uncomputed corrected commit date).

We will introduce an additional commit-graph chunk, Generation Data chunk,
and store corrected commit date offsets in GDAT chunk while storing
topological levels in CDAT chunk. The old versions of Git would ignore GDAT
chunk, using topological levels from CDAT chunk. In contrast, new versions
of Git would use corrected commit dates, falling back to topological level
if the generation data chunk is absent in the commit-graph file.

While storing corrected commit date offsets saves us 4 bytes per commit (as
compared with storing corrected commit dates directly), it's possible for
the offset to overflow the space allocated. To handle such cases, we
introduce a new chunk, Generation Data Overflow (GDOV) that stores the
corrected commit date. For overflowing offsets, we set MSB and store the
position into the GDOV chunk, in a mechanism similar to the Extra Edges list
chunk.

For mixed generation number environment (for example new Git on the command
line, old Git used by GUI client), we can encounter a mixed-chain
commit-graph (a commit-graph chain where some of split commit-graph files
have GDAT chunk and others do not). As backward compatibility is one of the
goals, we can define the following behavior:

While reading a mixed-chain commit-graph version, we fall back on
topological levels as corrected commit dates and topological levels cannot
be compared directly.

While writing on top of a split commit-graph, we check if the tip of the
chain has a GDAT chunk. If it does, we append to the chain, writing GDAT
chunk. Thus, we guarantee if the topmost split commit-graph file has a GDAT
chunk, rest of the chain does too.

If the topmost split commit-graph file does not have a GDAT chunk (meaning
it has been appended by the old Git), we write without GDAT chunk. We do
write a GDAT chunk when the existing chain does not have GDAT chunk - when
we are writing to the commit-graph chain with the 'replace' strategy.

Thanks to Dr. Stolee, Dr. Narębski, and Taylor for their reviews.

I look forward to everyone's reviews!

Thanks

 * Abhishek


----------------------------------------------------------------------------

Changes in version 4:

 * Added GDOV to handle overflows in generation data.
 * Added a test for writing tip graph for a generation number v2 graph chain
   in t5324-split-commit-graph.sh
 * Added a section on how mixed generation number chains are handled in 
   Documentation/technical/commit-graph-format.txt
 * Reverted unimportant whitespace, style changes in commit-graph.c
 * Added header comments about the order of comparision for
   compare_commits_by_gen_then_commit_date in commit.h,
   compare_commits_by_gen in commit-graph.h
 * Elaborated on why t6404 fails with corrected commit date and must be run
   with GIT_TEST_COMMIT_GRAPH=1in the commit "commit-reach: use corrected
   commit dates in paint_down_to_common()"
 * Elaborated on write behavior for mixed generation number chains in the
   commit "commit-graph: use generation v2 only if entire chain does"
 * Added notes about adding the topo_level slab to struct
   write_commit_graph_context as well as struct commit_graph.
 * Clarified commit message for "commit-graph: consolidate
   fill_commit_graph_info"
 * Removed the claim "GDAT can store future generation numbers" because it
   hasn't been tested yet.

Changes in version 3:

 * Reordered patches as discussed in 2
   [https://lore.kernel.org/git/aee0ae56-3395-6848-d573-27a318d72755@gmail.com/]
   .
 * Split "implement corrected commit date" into two patches - one
   introducing the topo level slab and other implementing corrected commit
   dates.
 * Extended split-commit-graph tests to verify at the end of test.
 * Use topological levels as generation number if any of split commit-graph
   files do not have generation data chunk.

Changes in version 2:

 * Add tests for generation data chunk.
 * Add an option GIT_TEST_COMMIT_GRAPH_NO_GDAT to control whether to write
   generation data chunk.
 * Compare commits with corrected commit dates if present in
   paint_down_to_common().
 * Update technical documentation.
 * Handle mixed generation commit chains.
 * Improve commit messages for "commit-graph: fix regression when computing
   bloom filter", "commit-graph: consolidate fill_commit_graph_info",
 * Revert unnecessary whitespace changes.
 * Split uint_32 -> timestamp_t change into a new commit.

Abhishek Kumar (10):
  commit-graph: fix regression when computing Bloom filters
  revision: parse parent in indegree_walk_step()
  commit-graph: consolidate fill_commit_graph_info
  commit-graph: return 64-bit generation number
  commit-graph: add a slab to store topological levels
  commit-graph: implement corrected commit date
  commit-graph: implement generation data chunk
  commit-graph: use generation v2 only if entire chain does
  commit-reach: use corrected commit dates in paint_down_to_common()
  doc: add corrected commit date info

 .../technical/commit-graph-format.txt         |  21 +-
 Documentation/technical/commit-graph.txt      |  62 ++++-
 commit-graph.c                                | 256 ++++++++++++++----
 commit-graph.h                                |  17 +-
 commit-reach.c                                |  38 +--
 commit-reach.h                                |   2 +-
 commit.c                                      |   4 +-
 commit.h                                      |   5 +-
 revision.c                                    |  13 +-
 t/README                                      |   3 +
 t/helper/test-read-graph.c                    |   4 +
 t/t4216-log-bloom.sh                          |   4 +-
 t/t5000-tar-tree.sh                           |  20 +-
 t/t5318-commit-graph.sh                       |  70 ++++-
 t/t5324-split-commit-graph.sh                 |  98 ++++++-
 t/t6404-recursive-merge.sh                    |   5 +-
 t/t6600-test-reach.sh                         |  68 ++---
 upload-pack.c                                 |   2 +-
 18 files changed, 534 insertions(+), 158 deletions(-)


base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-676%2Fabhishekkumar2718%2Fcorrected_commit_date-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-676/abhishekkumar2718/corrected_commit_date-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/676

Range-diff vs v3:

  1:  c6b7ade7af !  1:  fae81b534b commit-graph: fix regression when computing bloom filter
     @@ Metadata
      Author: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
       ## Commit message ##
     -    commit-graph: fix regression when computing bloom filter
     +    commit-graph: fix regression when computing Bloom filters
      
          commit_gen_cmp is used when writing a commit-graph to sort commits in
          generation order before computing Bloom filters. Since c49c82aa (commit:
     @@ Commit message
          'commit_graph_data_at(c)->generation') in order to access it while
          writing.
      
     +    While measuring performance with `git commit-graph write --reachable
     +    --changed-paths` on the linux repository led to around 1m40s for both
     +    HEAD and master (and could be due to fault in my measurements), it is
     +    still the "right" thing to do.
     +
          Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
       ## commit-graph.c ##
  2:  e673867234 !  2:  4470d91642 revision: parse parent in indegree_walk_step()
     @@ revision.c: static void indegree_walk_step(struct rev_info *revs)
       		struct commit *parent = p->item;
       		int *pi = indegree_slab_at(&info->indegree, parent);
       
     -+		if (parse_commit_gently(parent, 1) < 0)
     ++		if (repo_parse_commit_gently(revs->repo, parent, 1) < 0)
      +			return;
      +
       		if (*pi)
  3:  18d5864f81 !  3:  18bb3318a1 commit-graph: consolidate fill_commit_graph_info
     @@ Commit message
          implementation by calling fill_commit_graph_info() within
          fill_commit_in_graph().
      
     -    The test 'generate tar with future mtime' creates a commit with commit
     -    time of (2 ^ 36 + 1) seconds since EPOCH. The commit time overflows into
     -    generation number (within CDAT chunk) and has undefined behavior.
     +    fill_commit_graph_info() used to not load committer data from commit data
     +    chunk. However, with the corrected committer date, we have to load
     +    committer date to calculate generation number value.
      
     -    The test used to pass as fill_commit_in_graph() guarantees the values of
     -    graph position and generation number, and did not load timestamp.
     -    However, with corrected commit date we will need load the timestamp as
     -    well to populate the generation number.
     +    e51217e15 (t5000: test tar files that overflow ustar headers,
     +    30-06-2016) introduced a test 'generate tar with future mtime' that
     +    creates a commit with committer date of (2 ^ 36 + 1) seconds since
     +    EPOCH. The CDAT chunk provides 34-bits for storing committer date, thus
     +    committer time overflows into generation number (within CDAT chunk) and
     +    has undefined behavior.
      
     -    Let's fix the test by setting a timestamp of (2 ^ 34 - 1) seconds.
     +    The test used to pass as fill_commit_graph_info() would not set struct
     +    member `date` of struct commit and loads committer date from the object
     +    database, generating a tar file with the expected mtime.
     +
     +    However, with corrected commit date, we will load the committer date
     +    from CDAT chunk (truncated to lower 34-bits to populate the generation
     +    number. Thus, Git sets date and generates tar file with the truncated
     +    mtime.
     +
     +    The ustar format (the header format used by most modern tar programs)
     +    only has room for 11 (or 12, depending om some implementations) octal
     +    digits for the size and mtime of each files.
     +
     +    Thus, setting a timestamp of 2 ^ 33 + 1 would overflow the 11-octal
     +    digit implementations while still fitting into commit data chunk.
     +
     +    Since we want to test 12-octal digit implementations of ustar as well,
     +    let's modify the existing test to no longer use commit-graph file.
      
          Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
     @@ commit-graph.c: static int fill_commit_in_graph(struct repository *r,
      -	graph_data->graph_pos = pos;
       	lex_index = pos - g->num_commits_in_base;
      -
     --	commit_data = g->chunk_commit_data + (g->hash_len + 16) * lex_index;
     -+	commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
     + 	commit_data = g->chunk_commit_data + (g->hash_len + 16) * lex_index;
       
       	item->object.parsed = 1;
       
     @@ commit-graph.c: static int fill_commit_in_graph(struct repository *r,
       	edge_value = get_be32(commit_data + g->hash_len);
      
       ## t/t5000-tar-tree.sh ##
     -@@ t/t5000-tar-tree.sh: test_expect_success TIME_IS_64BIT 'set up repository with far-future commit' '
     +@@ t/t5000-tar-tree.sh: test_expect_success TAR_HUGE,LONG_IS_64BIT 'system tar can read our huge size' '
     + 	test_cmp expect actual
     + '
     + 
     ++test_expect_success TIME_IS_64BIT 'set up repository with far-future commit' '
     ++	rm -f .git/index &&
     ++	echo foo >file &&
     ++	git add file &&
     ++	GIT_COMMITTER_DATE="@17179869183 +0000" \
     ++		git commit -m "tempori parendum"
     ++'
     ++
     ++test_expect_success TIME_IS_64BIT 'generate tar with future mtime' '
     ++	git archive HEAD >future.tar
     ++'
     ++
     ++test_expect_success TAR_HUGE,TIME_IS_64BIT,TIME_T_IS_64BIT 'system tar can read our future mtime' '
     ++	echo 2514 >expect &&
     ++	tar_info future.tar | cut -d" " -f2 >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     + test_expect_success TIME_IS_64BIT 'set up repository with far-future commit' '
       	rm -f .git/index &&
       	echo content >file &&
       	git add file &&
      -	GIT_COMMITTER_DATE="@68719476737 +0000" \
     -+	GIT_COMMITTER_DATE="@17179869183 +0000" \
     ++	GIT_TEST_COMMIT_GRAPH=0 GIT_COMMITTER_DATE="@68719476737 +0000" \
       		git commit -m "tempori parendum"
       '
       
     -@@ t/t5000-tar-tree.sh: test_expect_success TIME_IS_64BIT 'generate tar with future mtime' '
     - '
     - 
     - test_expect_success TAR_HUGE,TIME_IS_64BIT,TIME_T_IS_64BIT 'system tar can read our future mtime' '
     --	echo 4147 >expect &&
     -+	echo 2514 >expect &&
     - 	tar_info future.tar | cut -d" " -f2 >actual &&
     - 	test_cmp expect actual
     - '
  4:  6a0cde983d <  -:  ---------- commit-graph: consolidate compare_commits_by_gen
  5:  6be759a954 !  4:  011b0aa497 commit-graph: return 64-bit generation number
     @@ Commit message
          commit_graph_generation(), use timestamp_t for local variables and
          define GENERATION_NUMBER_INFINITY as (2 ^ 63 - 1) instead.
      
     +    We rename GENERATION_NUMBER_MAX to GENERATION_NUMBER_V1_MAX to
     +    represent the largest topological level we can store in the commit data
     +    chunk.
     +
     +    With corrected commit dates implemented, we will have two such *_MAX
     +    variables to denote the largest offset and largest topological level
     +    that can be stored.
     +
          Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
       ## commit-graph.c ##
     @@ commit-graph.c: uint32_t commit_graph_position(const struct commit *c)
       {
       	struct commit_graph_data *data =
       		commit_graph_data_slab_peek(&commit_graph_data_slab, c);
     -@@ commit-graph.c: uint32_t commit_graph_generation(const struct commit *c)
     - int compare_commits_by_gen(const void *_a, const void *_b)
     - {
     - 	const struct commit *a = _a, *b = _b;
     --	const uint32_t generation_a = commit_graph_generation(a);
     --	const uint32_t generation_b = commit_graph_generation(b);
     -+	const timestamp_t generation_a = commit_graph_generation(a);
     -+	const timestamp_t generation_b = commit_graph_generation(b);
     - 
     - 	/* older commits first */
     - 	if (generation_a < generation_b)
      @@ commit-graph.c: static int commit_gen_cmp(const void *va, const void *vb)
       	const struct commit *a = *(const struct commit **)va;
       	const struct commit *b = *(const struct commit **)vb;
     @@ commit-graph.c: static int commit_gen_cmp(const void *va, const void *vb)
       	if (generation_a < generation_b)
       		return -1;
      @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph_context *ctx)
     - 		uint32_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
     + 					_("Computing commit graph generation numbers"),
     + 					ctx->commits.nr);
     + 	for (i = 0; i < ctx->commits.nr; i++) {
     +-		uint32_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
     ++		timestamp_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
       
       		display_progress(ctx->progress, i + 1);
     --		if (generation != GENERATION_NUMBER_INFINITY &&
     -+		if (generation != GENERATION_NUMBER_V1_INFINITY &&
     - 		    generation != GENERATION_NUMBER_ZERO)
     - 			continue;
     - 
     + 		if (generation != GENERATION_NUMBER_INFINITY &&
      @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph_context *ctx)
     - 			for (parent = current->parents; parent; parent = parent->next) {
     - 				generation = commit_graph_data_at(parent->item)->generation;
     - 
     --				if (generation == GENERATION_NUMBER_INFINITY ||
     -+				if (generation == GENERATION_NUMBER_V1_INFINITY ||
     - 				    generation == GENERATION_NUMBER_ZERO) {
     - 					all_parents_computed = 0;
     - 					commit_list_insert(parent->item, &list);
     + 				data->generation = max_generation + 1;
     + 				pop_commit(&list);
     + 
     +-				if (data->generation > GENERATION_NUMBER_MAX)
     +-					data->generation = GENERATION_NUMBER_MAX;
     ++				if (data->generation > GENERATION_NUMBER_V1_MAX)
     ++					data->generation = GENERATION_NUMBER_V1_MAX;
     + 			}
     + 		}
     + 	}
      @@ commit-graph.c: int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
       	for (i = 0; i < g->num_commits; i++) {
       		struct commit *graph_commit, *odb_commit;
     @@ commit-graph.c: int verify_commit_graph(struct repository *r, struct commit_grap
       
       		display_progress(progress, i + 1);
       		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
     +@@ commit-graph.c: int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
     + 			continue;
     + 
     + 		/*
     +-		 * If one of our parents has generation GENERATION_NUMBER_MAX, then
     +-		 * our generation is also GENERATION_NUMBER_MAX. Decrement to avoid
     ++		 * If one of our parents has generation GENERATION_NUMBER_V1_MAX, then
     ++		 * our generation is also GENERATION_NUMBER_V1_MAX. Decrement to avoid
     + 		 * extra logic in the following condition.
     + 		 */
     +-		if (max_generation == GENERATION_NUMBER_MAX)
     ++		if (max_generation == GENERATION_NUMBER_V1_MAX)
     + 			max_generation--;
     + 
     + 		generation = commit_graph_generation(graph_commit);
      
       ## commit-graph.h ##
      @@ commit-graph.h: void disable_commit_graph(struct repository *r);
     @@ commit-graph.h: void disable_commit_graph(struct repository *r);
      -uint32_t commit_graph_generation(const struct commit *);
      +timestamp_t commit_graph_generation(const struct commit *);
       uint32_t commit_graph_position(const struct commit *);
     - 
     - int compare_commits_by_gen(const void *_a, const void *_b);
     + #endif
      
       ## commit-reach.c ##
      @@ commit-reach.c: static int queue_has_nonstale(struct prio_queue *queue)
     @@ commit-reach.c: int repo_in_merge_bases_many(struct repository *r, struct commit
       {
       	struct commit_list *bases;
       	int ret = 0, i;
     --	uint32_t generation, min_generation = GENERATION_NUMBER_INFINITY;
     -+	timestamp_t generation, min_generation = GENERATION_NUMBER_INFINITY;
     +-	uint32_t generation, max_generation = GENERATION_NUMBER_ZERO;
     ++	timestamp_t generation, max_generation = GENERATION_NUMBER_INFINITY;
       
       	if (repo_parse_commit(r, commit))
       		return ret;
     @@ commit-reach.c: static enum contains_result contains_tag_algo(struct commit *can
       		struct commit *c = p->item;
       		load_commit_graph_info(the_repository, c);
       		generation = commit_graph_generation(c);
     +@@ commit-reach.c: static int compare_commits_by_gen(const void *_a, const void *_b)
     + 	const struct commit *a = *(const struct commit * const *)_a;
     + 	const struct commit *b = *(const struct commit * const *)_b;
     + 
     +-	uint32_t generation_a = commit_graph_generation(a);
     +-	uint32_t generation_b = commit_graph_generation(b);
     ++	timestamp_t generation_a = commit_graph_generation(a);
     ++	timestamp_t generation_b = commit_graph_generation(b);
     + 
     + 	if (generation_a < generation_b)
     + 		return -1;
      @@ commit-reach.c: int can_all_from_reach_with_flag(struct object_array *from,
       				 unsigned int with_flag,
       				 unsigned int assign_flag,
     @@ commit-reach.h: int can_all_from_reach_with_flag(struct object_array *from,
       		       int commit_date_cutoff);
       
      
     + ## commit.c ##
     +@@ commit.c: int compare_commits_by_author_date(const void *a_, const void *b_,
     + int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused)
     + {
     + 	const struct commit *a = a_, *b = b_;
     +-	const uint32_t generation_a = commit_graph_generation(a),
     +-		       generation_b = commit_graph_generation(b);
     ++	const timestamp_t generation_a = commit_graph_generation(a),
     ++			  generation_b = commit_graph_generation(b);
     + 
     + 	/* newer commits first */
     + 	if (generation_a < generation_b)
     +
       ## commit.h ##
      @@
       #include "commit-slab.h"
       
       #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
      -#define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
     +-#define GENERATION_NUMBER_MAX 0x3FFFFFFF
      +#define GENERATION_NUMBER_INFINITY ((1ULL << 63) - 1)
     -+#define GENERATION_NUMBER_V1_INFINITY 0xFFFFFFFF
     - #define GENERATION_NUMBER_MAX 0x3FFFFFFF
     ++#define GENERATION_NUMBER_V1_MAX 0x3FFFFFFF
       #define GENERATION_NUMBER_ZERO 0
       
     + struct commit_list {
      
       ## revision.c ##
      @@ revision.c: define_commit_slab(indegree_slab, int);
     @@ revision.c: static void init_topo_walk(struct rev_info *revs)
      -		uint32_t generation;
      +		timestamp_t generation;
       
     - 		if (parse_commit_gently(c, 1))
     + 		if (repo_parse_commit_gently(revs->repo, c, 1))
       			continue;
      @@ revision.c: static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
       	for (p = commit->parents; p; p = p->next) {
  6:  b347dbb01b !  5:  e067f653ad commit-graph: add a slab to store topological levels
     @@ Metadata
       ## Commit message ##
          commit-graph: add a slab to store topological levels
      
     -    As we are writing topological levels to commit data chunk to ensure
     -    backwards compatibility with "Old" Git and the member `generation` of
     -    struct commit_graph_data will store corrected commit date in a later
     -    commit, let's introduce a commit-slab to store topological levels while
     -    writing commit-graph.
     +    In a later commit we will introduce corrected commit date as the
     +    generation number v2. This value will be stored in the new seperate
     +    Generation Data chunk. However, to ensure backwards compatibility with
     +    "Old" Git we need to continue to write generation number v1, which is
     +    topological level, to the commit data chunk. This means that we need to
     +    compute both versions of generation numbers when writing the
     +    commit-graph file. Therefore, let's introduce a commit-slab to store
     +    topological levels; corrected commit date will be stored in the member
     +    `generation` of struct commit_graph_data.
      
          When Git creates a split commit-graph, it takes advantage of the
          generation values that have been computed already and present in
          existing commit-graph files.
      
     -    So, let's add a pointer to struct commit_graph to the topological level
     -    commit-slab and populate it with topological levels while writing a
     -    split commit-graph.
     +    So, let's add a pointer to struct commit_graph as well as struct
     +    write_commit_graph_context to the topological level commit-slab
     +    and populate it with topological levels while writing a commit-graph
     +    file.
      
          Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
     @@ commit-graph.c: struct write_commit_graph_context {
       		 order_by_pack:1;
       
      +	struct topo_level_slab *topo_levels;
     - 	const struct split_commit_graph_opts *split_opts;
     + 	const struct commit_graph_opts *opts;
       	size_t total_bloom_filter_data_size;
       	const struct bloom_filter_settings *bloom_settings;
      @@ commit-graph.c: static int write_graph_chunk_data(struct hashfile *f,
     @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph
       					_("Computing commit graph generation numbers"),
       					ctx->commits.nr);
       	for (i = 0; i < ctx->commits.nr; i++) {
     --		uint32_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
     -+		uint32_t level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
     +-		timestamp_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
     ++		timestamp_t level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
       
       		display_progress(ctx->progress, i + 1);
     --		if (generation != GENERATION_NUMBER_V1_INFINITY &&
     +-		if (generation != GENERATION_NUMBER_INFINITY &&
      -		    generation != GENERATION_NUMBER_ZERO)
     -+		if (level != GENERATION_NUMBER_V1_INFINITY &&
     ++		if (level != GENERATION_NUMBER_INFINITY &&
      +		    level != GENERATION_NUMBER_ZERO)
       			continue;
       
     @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph
      -				generation = commit_graph_data_at(parent->item)->generation;
      +				level = *topo_level_slab_at(ctx->topo_levels, parent->item);
       
     --				if (generation == GENERATION_NUMBER_V1_INFINITY ||
     +-				if (generation == GENERATION_NUMBER_INFINITY ||
      -				    generation == GENERATION_NUMBER_ZERO) {
     -+				if (level == GENERATION_NUMBER_V1_INFINITY ||
     ++				if (level == GENERATION_NUMBER_INFINITY ||
      +				    level == GENERATION_NUMBER_ZERO) {
       					all_parents_computed = 0;
       					commit_list_insert(parent->item, &list);
     @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph
      -				data->generation = max_generation + 1;
       				pop_commit(&list);
       
     --				if (data->generation > GENERATION_NUMBER_MAX)
     --					data->generation = GENERATION_NUMBER_MAX;
     -+				if (max_level > GENERATION_NUMBER_MAX - 1)
     -+					max_level = GENERATION_NUMBER_MAX - 1;
     +-				if (data->generation > GENERATION_NUMBER_V1_MAX)
     +-					data->generation = GENERATION_NUMBER_V1_MAX;
     ++				if (max_level > GENERATION_NUMBER_V1_MAX - 1)
     ++					max_level = GENERATION_NUMBER_V1_MAX - 1;
      +				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
       			}
       		}
       	}
      @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
     - 	uint32_t i, count_distinct = 0;
       	int res = 0;
       	int replace = 0;
     + 	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
      +	struct topo_level_slab topo_levels;
       
       	if (!commit_graph_compatible(the_repository))
       		return 0;
      @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
     - 		}
     - 	}
     + 							 bloom_settings.max_changed_paths);
     + 	ctx->bloom_settings = &bloom_settings;
       
      +	init_topo_level_slab(&topo_levels);
      +	ctx->topo_levels = &topo_levels;
     @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
      +		}
      +	}
      +
     - 	if (pack_indexes) {
     - 		ctx->order_by_pack = 1;
     - 		if ((res = fill_oids_from_packs(ctx, pack_indexes)))
     + 	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
     + 		ctx->changed_paths = 1;
     + 	if (!(flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {
      
       ## commit-graph.h ##
      @@ commit-graph.h: struct commit_graph {
     @@ commit-graph.h: struct commit_graph {
       	struct bloom_filter_settings *bloom_filter_settings;
       };
       
     -
     - ## commit.h ##
     -@@
     - #define GENERATION_NUMBER_V1_INFINITY 0xFFFFFFFF
     - #define GENERATION_NUMBER_MAX 0x3FFFFFFF
     - #define GENERATION_NUMBER_ZERO 0
     -+#define GENERATION_NUMBER_V2_OFFSET_MAX 0xFFFFFFFF
     - 
     - struct commit_list {
     - 	struct commit *item;
  7:  4074ace65b !  6:  694ef1ec08 commit-graph: implement corrected commit date
     @@ Commit message
            the maximum of its commit date and one more than the largest corrected
            commit date among its parents.
      
     +    As a special case, a root commit with timestamp of zero (01.01.1970
     +    00:00:00Z) has corrected commit date of one, to be able to distinguish
     +    from GENERATION_NUMBER_ZERO (that is, an uncomputed corrected commit
     +    date).
     +
          To minimize the space required to store corrected commit date, Git
          stores corrected commit date offsets into the commit-graph file. The
          corrected commit date offset for a commit is defined as the difference
          between its corrected commit date and actual commit date.
      
     +    Storing corrected commit date requires sizeof(timestamp_t) bytes, which
     +    in most cases is 64 bits (uintmax_t). However, corrected commit date
     +    offsets can be safely stored using only 32-bits. This halves the size
     +    of GDAT chunk, which is a reduction of around 6% in the size of
     +    commit-graph file.
     +
     +    However, using offsets be problematic if one of commits is malformed but
     +    valid and has committerdate of 0 Unix time, as the offset would be the
     +    same as corrected commit date and thus require 64-bits to be stored
     +    properly.
     +
          While Git does not write out offsets at this stage, Git stores the
          corrected commit dates in member generation of struct commit_graph_data.
          It will begin writing commit date offsets with the introduction of
     @@ commit-graph.c: static int commit_gen_cmp(const void *va, const void *vb)
      @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph_context *ctx)
       					ctx->commits.nr);
       	for (i = 0; i < ctx->commits.nr; i++) {
     - 		uint32_t level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
     + 		timestamp_t level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
      +		timestamp_t corrected_commit_date = commit_graph_data_at(ctx->commits.list[i])->generation;
       
       		display_progress(ctx->progress, i + 1);
     - 		if (level != GENERATION_NUMBER_V1_INFINITY &&
     + 		if (level != GENERATION_NUMBER_INFINITY &&
      -		    level != GENERATION_NUMBER_ZERO)
      +		    level != GENERATION_NUMBER_ZERO &&
      +		    corrected_commit_date != GENERATION_NUMBER_INFINITY &&
     @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph
       
       			for (parent = current->parents; parent; parent = parent->next) {
       				level = *topo_level_slab_at(ctx->topo_levels, parent->item);
     +-
      +				corrected_commit_date = commit_graph_data_at(parent->item)->generation;
     - 
     - 				if (level == GENERATION_NUMBER_V1_INFINITY ||
     + 				if (level == GENERATION_NUMBER_INFINITY ||
      -				    level == GENERATION_NUMBER_ZERO) {
      +				    level == GENERATION_NUMBER_ZERO ||
      +				    corrected_commit_date == GENERATION_NUMBER_INFINITY ||
     @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph
       			}
       
      @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph_context *ctx)
     - 				if (max_level > GENERATION_NUMBER_MAX - 1)
     - 					max_level = GENERATION_NUMBER_MAX - 1;
     + 				if (max_level > GENERATION_NUMBER_V1_MAX - 1)
     + 					max_level = GENERATION_NUMBER_V1_MAX - 1;
       				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
      +
     -+				if (current->date > max_corrected_commit_date)
     ++				if (current->date && current->date > max_corrected_commit_date)
      +					max_corrected_commit_date = current->date - 1;
      +				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
       			}
       		}
       	}
     -@@ commit-graph.c: int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
     - 	for (i = 0; i < g->num_commits; i++) {
     - 		struct commit *graph_commit, *odb_commit;
     - 		struct commit_list *graph_parents, *odb_parents;
     --		timestamp_t max_generation = 0;
     --		timestamp_t generation;
     -+		timestamp_t max_corrected_commit_date = 0;
     -+		timestamp_t corrected_commit_date;
     - 
     - 		display_progress(progress, i + 1);
     - 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
     -@@ commit-graph.c: int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
     - 					     oid_to_hex(&graph_parents->item->object.oid),
     - 					     oid_to_hex(&odb_parents->item->object.oid));
     - 
     --			generation = commit_graph_generation(graph_parents->item);
     --			if (generation > max_generation)
     --				max_generation = generation;
     -+			corrected_commit_date = commit_graph_generation(graph_parents->item);
     -+			if (corrected_commit_date > max_corrected_commit_date)
     -+				max_corrected_commit_date = corrected_commit_date;
     - 
     - 			graph_parents = graph_parents->next;
     - 			odb_parents = odb_parents->next;
      @@ commit-graph.c: int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
       		if (generation_zero == GENERATION_ZERO_EXISTS)
       			continue;
       
      -		/*
     --		 * If one of our parents has generation GENERATION_NUMBER_MAX, then
     --		 * our generation is also GENERATION_NUMBER_MAX. Decrement to avoid
     +-		 * If one of our parents has generation GENERATION_NUMBER_V1_MAX, then
     +-		 * our generation is also GENERATION_NUMBER_V1_MAX. Decrement to avoid
      -		 * extra logic in the following condition.
      -		 */
     --		if (max_generation == GENERATION_NUMBER_MAX)
     +-		if (max_generation == GENERATION_NUMBER_V1_MAX)
      -			max_generation--;
      -
     --		generation = commit_graph_generation(graph_commit);
     + 		generation = commit_graph_generation(graph_commit);
      -		if (generation != max_generation + 1)
      -			graph_report(_("commit-graph generation for commit %s is %u != %u"),
     -+		corrected_commit_date = commit_graph_generation(graph_commit);
     -+		if (corrected_commit_date < max_corrected_commit_date + 1)
     ++		if (generation < max_generation + 1)
      +			graph_report(_("commit-graph generation for commit %s is %"PRItime" < %"PRItime),
       				     oid_to_hex(&cur_oid),
     --				     generation,
     --				     max_generation + 1);
     -+				     corrected_commit_date,
     -+				     max_corrected_commit_date + 1);
     - 
     - 		if (graph_commit->date != odb_commit->date)
     - 			graph_report(_("commit date for commit %s in commit-graph is %"PRItime" != %"PRItime),
     + 				     generation,
     + 				     max_generation + 1);
  8:  4e746628ac !  7:  b903efe2ea commit-graph: implement generation data chunk
     @@ Commit message
          between graph versions in a backwards compatible manner.
      
          We are going to introduce a new chunk called Generation Data chunk (or
     -    GDAT). GDAT stores generation number v2 (and any subsequent versions),
     -    whereas CDAT will still store topological level.
     +    GDAT). GDAT stores corrected committer date offsets whereas CDAT will
     +    still store topological level.
      
          Old Git does not understand GDAT chunk and would ignore it, reading
          topological levels from CDAT. New Git can parse GDAT and take advantage
     @@ Commit message
          which forces commit-graph file to be written without generation data
          chunk to emulate a commit-graph file written by old Git.
      
     +    While storing corrected commit date offset instead of the corrected
     +    commit date saves us 4 bytes per commit, it's possible for the offsets
     +    to overflow the 4-bytes allocated. As such overflows are exceedingly
     +    rare, we use the following overflow management scheme:
     +
     +    We introduce a new commit-graph chunk, GENERATION_DATA_OVERFLOW ('GDOV')
     +    to store corrected commit dates for commits with offsets greater than
     +    GENERATION_NUMBER_V2_OFFSET_MAX.
     +
     +    If the offset is greater than GENERATION_NUMBER_V2_OFFSET_MAX, we set
     +    the MSB of the offset and the other bits store the position of corrected
     +    commit date in GDOV chunk, similar to how Extra Edge List is maintained.
     +
     +    We test the overflow-related code with the following repo history:
     +
     +               F - N - U
     +              /         \
     +    U - N - U            N
     +             \          /
     +              N - F - N
     +
     +    Where the commits denoted by U have committer date of zero seconds
     +    since Unix epoch, the commits denoted by N have committer date of
     +    1112354055 (default committer date for the test suite) seconds since
     +    Unix epoch and the commits denoted by F have committer date of
     +    (2 ^ 31 - 2) seconds since Unix epoch.
     +
     +    The largest offset observed is 2 ^ 31, just large enough to overflow.
     +
          [1]: https://lore.kernel.org/git/87a7gdspo4.fsf@evledraar.gmail.com/
      
          Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
     @@ commit-graph.c: void git_test_write_commit_graph_or_die(void)
       #define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
       #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
      +#define GRAPH_CHUNKID_GENERATION_DATA 0x47444154 /* "GDAT" */
     ++#define GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW 0x47444f56 /* "GDOV" */
       #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
       #define GRAPH_CHUNKID_BLOOMINDEXES 0x42494458 /* "BIDX" */
       #define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
       #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
      -#define MAX_NUM_CHUNKS 7
     -+#define MAX_NUM_CHUNKS 8
     ++#define MAX_NUM_CHUNKS 9
       
       #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
       
     -@@ commit-graph.c: struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size)
     +@@ commit-graph.c: void git_test_write_commit_graph_or_die(void)
     + #define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
     + 			+ GRAPH_FANOUT_SIZE + the_hash_algo->rawsz)
     + 
     ++#define CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW (1ULL << 31)
     ++
     + /* Remember to update object flag allocation in object.h */
     + #define REACHABLE       (1u<<15)
     + 
     +@@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repository *r,
       				graph->chunk_commit_data = data + chunk_offset;
       			break;
       
     @@ commit-graph.c: struct commit_graph *parse_commit_graph(void *graph_map, size_t
      +			else
      +				graph->chunk_generation_data = data + chunk_offset;
      +			break;
     ++
     ++		case GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW:
     ++			if (graph->chunk_generation_data_overflow)
     ++				chunk_repeated = 1;
     ++			else
     ++				graph->chunk_generation_data_overflow = data + chunk_offset;
     ++			break;
      +
       		case GRAPH_CHUNKID_EXTRAEDGES:
       			if (graph->chunk_extra_edges)
       				chunk_repeated = 1;
     +@@ commit-graph.c: static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
     + {
     + 	const unsigned char *commit_data;
     + 	struct commit_graph_data *graph_data;
     +-	uint32_t lex_index;
     +-	uint64_t date_high, date_low;
     ++	uint32_t lex_index, offset_pos;
     ++	uint64_t date_high, date_low, offset;
     + 
     + 	while (pos < g->num_commits_in_base)
     + 		g = g->base_graph;
      @@ commit-graph.c: static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
       	date_low = get_be32(commit_data + g->hash_len + 12);
       	item->date = (timestamp_t)((date_high << 32) | date_low);
       
      -	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
     -+	if (g->chunk_generation_data)
     -+		graph_data->generation = item->date +
     -+			(timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
     -+	else
     ++	if (g->chunk_generation_data) {
     ++		offset = (timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
     ++
     ++		if (offset & CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW) {
     ++			offset_pos = offset ^ CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW;
     ++			graph_data->generation = get_be64(g->chunk_generation_data_overflow + 8 * offset_pos);
     ++		} else
     ++			graph_data->generation = item->date + offset;
     ++	} else
      +		graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
       
       	if (g->topo_levels)
       		*topo_level_slab_at(g->topo_levels, item) = get_be32(commit_data + g->hash_len + 8) >> 2;
     +@@ commit-graph.c: struct write_commit_graph_context {
     + 	struct packed_oid_list oids;
     + 	struct packed_commit_list commits;
     + 	int num_extra_edges;
     ++	int num_generation_data_overflows;
     + 	unsigned long approx_nr_objects;
     + 	struct progress *progress;
     + 	int progress_done;
      @@ commit-graph.c: struct write_commit_graph_context {
       		 report_progress:1,
       		 split:1,
     @@ commit-graph.c: struct write_commit_graph_context {
      +		 write_generation_data:1;
       
       	struct topo_level_slab *topo_levels;
     - 	const struct split_commit_graph_opts *split_opts;
     + 	const struct commit_graph_opts *opts;
      @@ commit-graph.c: static int write_graph_chunk_data(struct hashfile *f,
       	return 0;
       }
     @@ commit-graph.c: static int write_graph_chunk_data(struct hashfile *f,
      +static int write_graph_chunk_generation_data(struct hashfile *f,
      +					      struct write_commit_graph_context *ctx)
      +{
     -+	int i;
     ++	int i, num_generation_data_overflows = 0;
      +	for (i = 0; i < ctx->commits.nr; i++) {
      +		struct commit *c = ctx->commits.list[i];
      +		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
      +		display_progress(ctx->progress, ++ctx->progress_cnt);
      +
     -+		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX)
     -+			offset = GENERATION_NUMBER_V2_OFFSET_MAX;
     ++		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX) {
     ++			offset = CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW | num_generation_data_overflows;
     ++			num_generation_data_overflows++;
     ++		}
     ++
      +		hashwrite_be32(f, offset);
      +	}
      +
      +	return 0;
      +}
     ++
     ++static int write_graph_chunk_generation_data_overflow(struct hashfile *f,
     ++						       struct write_commit_graph_context *ctx)
     ++{
     ++	int i;
     ++	for (i = 0; i < ctx->commits.nr; i++) {
     ++		struct commit *c = ctx->commits.list[i];
     ++		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
     ++		display_progress(ctx->progress, ++ctx->progress_cnt);
     ++
     ++		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX) {
     ++			hashwrite_be32(f, offset >> 32);
     ++			hashwrite_be32(f, (uint32_t) offset);
     ++		}
     ++	}
     ++
     ++	return 0;
     ++}
      +
       static int write_graph_chunk_extra_edges(struct hashfile *f,
     --					 struct write_commit_graph_context *ctx)
     -+					  struct write_commit_graph_context *ctx)
     + 					 struct write_commit_graph_context *ctx)
       {
     - 	struct commit **list = ctx->commits.list;
     - 	struct commit **last = ctx->commits.list + ctx->commits.nr;
     +@@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph_context *ctx)
     + 
     + 				if (current->date && current->date > max_corrected_commit_date)
     + 					max_corrected_commit_date = current->date - 1;
     ++
     + 				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
     ++
     ++				if (commit_graph_data_at(current)->generation - current->date > GENERATION_NUMBER_V2_OFFSET_MAX)
     ++					ctx->num_generation_data_overflows++;
     + 			}
     + 		}
     + 	}
      @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_context *ctx)
       	chunks[2].id = GRAPH_CHUNKID_DATA;
       	chunks[2].size = (hashsz + 16) * ctx->commits.nr;
     @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_con
      +		chunks[num_chunks].size = sizeof(uint32_t) * ctx->commits.nr;
      +		chunks[num_chunks].write_fn = write_graph_chunk_generation_data;
      +		num_chunks++;
     ++	}
     ++	if (ctx->num_generation_data_overflows) {
     ++		chunks[num_chunks].id = GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW;
     ++		chunks[num_chunks].size = sizeof(timestamp_t) * ctx->num_generation_data_overflows;
     ++		chunks[num_chunks].write_fn = write_graph_chunk_generation_data_overflow;
     ++		num_chunks++;
      +	}
       	if (ctx->num_extra_edges) {
       		chunks[num_chunks].id = GRAPH_CHUNKID_EXTRAEDGES;
       		chunks[num_chunks].size = 4 * ctx->num_extra_edges;
      @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
       	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
     - 	ctx->split_opts = split_opts;
     + 	ctx->opts = opts;
       	ctx->total_bloom_filter_data_size = 0;
      +	ctx->write_generation_data = 1;
     ++	ctx->num_generation_data_overflows = 0;
       
     - 	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
     - 		ctx->changed_paths = 1;
     + 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
     + 						      bloom_settings.bits_per_entry);
      
       ## commit-graph.h ##
      @@
     @@ commit-graph.h: struct commit_graph {
       	const unsigned char *chunk_oid_lookup;
       	const unsigned char *chunk_commit_data;
      +	const unsigned char *chunk_generation_data;
     ++	const unsigned char *chunk_generation_data_overflow;
       	const unsigned char *chunk_extra_edges;
       	const unsigned char *chunk_base_graphs;
       	const unsigned char *chunk_bloom_indexes;
      
     + ## commit.h ##
     +@@
     + #define GENERATION_NUMBER_INFINITY ((1ULL << 63) - 1)
     + #define GENERATION_NUMBER_V1_MAX 0x3FFFFFFF
     + #define GENERATION_NUMBER_ZERO 0
     ++#define GENERATION_NUMBER_V2_OFFSET_MAX ((1ULL << 31) - 1)
     + 
     + struct commit_list {
     + 	struct commit *item;
     +
       ## t/README ##
      @@ t/README: GIT_TEST_COMMIT_GRAPH=<boolean>, when true, forces the commit-graph to
       be written after every 'git commit' command, and overrides the
     @@ t/helper/test-read-graph.c: int cmd__read_graph(int argc, const char **argv)
       		printf(" commit_metadata");
      +	if (graph->chunk_generation_data)
      +		printf(" generation_data");
     ++	if (graph->chunk_generation_data_overflow)
     ++		printf(" generation_data_overflow");
       	if (graph->chunk_extra_edges)
       		printf(" extra_edges");
       	if (graph->chunk_bloom_indexes)
      
       ## t/t4216-log-bloom.sh ##
      @@ t/t4216-log-bloom.sh: test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
     - 	git commit-graph write --reachable --changed-paths
       '
     + 
       graph_read_expect () {
      -	NUM_CHUNKS=5
      +	NUM_CHUNKS=6
       	cat >expect <<- EOF
     - 	header: 43475048 1 1 $NUM_CHUNKS 0
     + 	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
       	num_commits: $1
      -	chunks: oid_fanout oid_lookup commit_metadata bloom_indexes bloom_data
      +	chunks: oid_fanout oid_lookup commit_metadata generation_data bloom_indexes bloom_data
     @@ t/t5318-commit-graph.sh: test_expect_success 'write graph in bare repo' '
       '
       
       graph_git_behavior 'bare repo with graph, commit 8 vs merge 1' bare commits/8 merge/1
     -@@ t/t5318-commit-graph.sh: test_expect_success 'replace-objects invalidates commit-graph' '
     +@@ t/t5318-commit-graph.sh: test_expect_success 'warn on improper hash version' '
       
       test_expect_success 'git commit-graph verify' '
       	cd "$TRASH_DIRECTORY/full" &&
     @@ t/t5318-commit-graph.sh: test_expect_success 'replace-objects invalidates commit
       '
       
       NUM_COMMITS=9
     +@@ t/t5318-commit-graph.sh: test_expect_success 'corrupt commit-graph write (missing tree)' '
     + 	)
     + '
     + 
     ++test_commit_with_date() {
     ++  file="$1.t" &&
     ++  echo "$1" >"$file" &&
     ++  git add "$file" &&
     ++  GIT_COMMITTER_DATE="$2" GIT_AUTHOR_DATE="$2" git commit -m "$1"
     ++  git tag "$1"
     ++}
     ++
     ++test_expect_success 'overflow corrected commit date offset' '
     ++	objdir=".git/objects" &&
     ++	UNIX_EPOCH_ZERO="1970-01-01 00:00 +0000" &&
     ++	FUTURE_DATE="@2147483646 +0000" &&
     ++	test_oid_cache <<-EOF &&
     ++	oid_version sha1:1
     ++	oid_version sha256:2
     ++	EOF
     ++	cd "$TRASH_DIRECTORY" &&
     ++	mkdir repo &&
     ++	cd repo &&
     ++	git init &&
     ++	test_commit_with_date 1 "$UNIX_EPOCH_ZERO" &&
     ++	test_commit 2 &&
     ++	test_commit_with_date 3 "$UNIX_EPOCH_ZERO" &&
     ++	git commit-graph write --reachable &&
     ++	graph_read_expect 3 generation_data &&
     ++	test_commit_with_date 4 "$FUTURE_DATE" &&
     ++	test_commit 5 &&
     ++	test_commit_with_date 6 "$UNIX_EPOCH_ZERO" &&
     ++	git branch left &&
     ++	git reset --hard 3 &&
     ++	test_commit 7 &&
     ++	test_commit_with_date 8 "$FUTURE_DATE" &&
     ++	test_commit 9 &&
     ++	git branch right &&
     ++	git reset --hard 3 &&
     ++	git merge left right &&
     ++	git commit-graph write --reachable &&
     ++	graph_read_expect 10 "generation_data generation_data_overflow" &&
     ++	git commit-graph verify
     ++'
     ++
     ++graph_git_behavior 'overflow corrected commit date offset' repo left right
     ++
     + test_done
      
       ## t/t5324-split-commit-graph.sh ##
      @@ t/t5324-split-commit-graph.sh: test_expect_success 'setup repo' '
     @@ t/t5324-split-commit-graph.sh: test_expect_success 'setup repo' '
      -	base sha256:1496
      +	base sha1:1408
      +	base sha256:1528
     - 	EOM
     - '
       
     + 	oid_version sha1:1
     + 	oid_version sha256:2
      @@ t/t5324-split-commit-graph.sh: graph_read_expect() {
       		NUM_BASE=$2
       	fi
       	cat >expect <<- EOF
     --	header: 43475048 1 1 3 $NUM_BASE
     -+	header: 43475048 1 1 4 $NUM_BASE
     +-	header: 43475048 1 $(test_oid oid_version) 3 $NUM_BASE
     ++	header: 43475048 1 $(test_oid oid_version) 4 $NUM_BASE
       	num_commits: $1
      -	chunks: oid_fanout oid_lookup commit_metadata
      +	chunks: oid_fanout oid_lookup commit_metadata generation_data
     @@ t/t6600-test-reach.sh: test_expect_success 'in_merge_bases:miss' '
      +	test_all_modes in_merge_bases
       '
       
     + test_expect_success 'in_merge_bases_many:hit' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'in_merge_bases_many:hit' '
     + 	X:commit-5-7
     + 	EOF
     + 	echo "in_merge_bases_many(A,X):1" >expect &&
     +-	test_three_modes in_merge_bases_many
     ++	test_all_modes in_merge_bases_many
     + '
     + 
     + test_expect_success 'in_merge_bases_many:miss' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'in_merge_bases_many:miss' '
     + 	X:commit-8-6
     + 	EOF
     + 	echo "in_merge_bases_many(A,X):0" >expect &&
     +-	test_three_modes in_merge_bases_many
     ++	test_all_modes in_merge_bases_many
     + '
     + 
     + test_expect_success 'in_merge_bases_many:miss-heuristic' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'in_merge_bases_many:miss-heuristic' '
     + 	X:commit-6-6
     + 	EOF
     + 	echo "in_merge_bases_many(A,X):0" >expect &&
     +-	test_three_modes in_merge_bases_many
     ++	test_all_modes in_merge_bases_many
     + '
     + 
       test_expect_success 'is_descendant_of:hit' '
      @@ t/t6600-test-reach.sh: test_expect_success 'is_descendant_of:hit' '
       	X:commit-1-1
  9:  5a147a9704 !  8:  8ec119edc6 commit-graph: use generation v2 only if entire chain does
     @@ Commit message
          commits in the lower layer before allowing the topo-order queue to write
          anything to output (depending on the size of the upper layer).
      
     +    When writing the new layer in split commit-graph, we write a GDAT chunk
     +    only if the topmost layer has a GDAT chunk. This guarantees that if a
     +    layer has GDAT chunk, all lower layers must have a GDAT chunk as well.
     +
     +    Rewriting layers follows similar approach: if the topmost layer below
     +    the set of layers being rewritten (in the split commit-graph chain)
     +    exists, and it does not contain GDAT chunk, then the result of rewrite
     +    does not have GDAT chunks either.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
     @@ commit-graph.c: static struct commit_graph *load_commit_graph_chain(struct repos
       	return graph_chain;
       }
       
     -+static void validate_mixed_generation_chain(struct repository *r)
     ++static void validate_mixed_generation_chain(struct commit_graph *g)
      +{
     -+	struct commit_graph *g = r->objects->commit_graph;
     -+	int read_generation_data = 1;
     ++	int read_generation_data;
      +
     -+	while (g) {
     -+		if (!g->chunk_generation_data) {
     -+			read_generation_data = 0;
     -+			break;
     -+		}
     -+		g = g->base_graph;
     -+	}
     ++	if (!g)
     ++		return;
      +
     -+	g = r->objects->commit_graph;
     ++	read_generation_data = !!g->chunk_generation_data;
      +
      +	while (g) {
      +		g->read_generation_data = read_generation_data;
     @@ commit-graph.c: struct commit_graph *read_commit_graph_one(struct repository *r,
       	if (!g)
       		g = load_commit_graph_chain(r, odb);
       
     -+	validate_mixed_generation_chain(r);
     ++	validate_mixed_generation_chain(g);
      +
       	return g;
       }
     @@ commit-graph.c: static void fill_commit_graph_info(struct commit *item, struct c
       	date_low = get_be32(commit_data + g->hash_len + 12);
       	item->date = (timestamp_t)((date_high << 32) | date_low);
       
     --	if (g->chunk_generation_data)
     -+	if (g->chunk_generation_data && g->read_generation_data)
     - 		graph_data->generation = item->date +
     - 			(timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
     - 	else
     -@@ commit-graph.c: void load_commit_graph_info(struct repository *r, struct commit *item)
     - 	uint32_t pos;
     - 	if (!prepare_commit_graph(r))
     - 		return;
     +-	if (g->chunk_generation_data) {
     ++	if (g->chunk_generation_data && g->read_generation_data) {
     + 		offset = (timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
     + 
     + 		if (offset & CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW) {
     +@@ commit-graph.c: static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
     + 		}
     + 	}
     + 
     ++	if (!ctx->write_generation_data && g->chunk_generation_data)
     ++		ctx->write_generation_data = 1;
      +
     - 	if (find_commit_in_graph(item, r->objects->commit_graph, &pos))
     - 		fill_commit_graph_info(item, r->objects->commit_graph, pos);
     - }
     + 	if (flags != COMMIT_GRAPH_SPLIT_REPLACE)
     + 		ctx->new_base_graph = g;
     + 	else if (ctx->num_commit_graphs_after != 1)
     +@@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
     + 		struct commit_graph *g = ctx->r->objects->commit_graph;
     + 
     + 		while (g) {
     ++			g->read_generation_data = 1;
     + 			g->topo_levels = &topo_levels;
     + 			g = g->base_graph;
     + 		}
      @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
       
       		g = ctx->r->objects->commit_graph;
     @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
       			g = g->base_graph;
      @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
       
     - 		if (ctx->split_opts)
     - 			replace = ctx->split_opts->flags & COMMIT_GRAPH_SPLIT_REPLACE;
     + 		if (ctx->opts)
     + 			replace = ctx->opts->split_flags & COMMIT_GRAPH_SPLIT_REPLACE;
      +
      +		if (replace)
      +			ctx->write_generation_data = 1;
     @@ commit-graph.h: struct commit_graph {
       	struct object_directory *odb;
       
       	uint32_t num_commits_in_base;
     -+	uint32_t read_generation_data;
     ++	unsigned int read_generation_data;
       	struct commit_graph *base_graph;
       
       	const uint32_t *chunk_oid_fanout;
      
       ## t/t5324-split-commit-graph.sh ##
     -@@ t/t5324-split-commit-graph.sh: done <<\EOF
     - 0600 -r--------
     - EOF
     +@@ t/t5324-split-commit-graph.sh: test_expect_success '--split=replace with partial Bloom data' '
     + 	verify_chain_files_exist $graphdir
     + '
       
      +test_expect_success 'setup repo for mixed generation commit-graph-chain' '
      +	mkdir mixed &&
      +	graphdir=".git/objects/info/commit-graphs" &&
     ++	test_oid_cache <<-EOM &&
     ++	oid_version sha1:1
     ++	oid_version sha256:2
     ++	EOM
      +	cd "$TRASH_DIRECTORY/mixed" &&
      +	git init &&
      +	git config core.commitGraph true &&
     @@ t/t5324-split-commit-graph.sh: done <<\EOF
      +	GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --reachable --split=no-merge &&
      +	test-tool read-graph >output &&
      +	cat >expect <<-EOF &&
     -+	header: 43475048 1 1 4 1
     ++	header: 43475048 1 $(test_oid oid_version) 4 1
      +	num_commits: 2
      +	chunks: oid_fanout oid_lookup commit_metadata
      +	EOF
     @@ t/t5324-split-commit-graph.sh: done <<\EOF
      +	git commit-graph write --reachable --split=no-merge &&
      +	test-tool read-graph >output &&
      +	cat >expect <<-EOF &&
     -+	header: 43475048 1 1 4 2
     ++	header: 43475048 1 $(test_oid oid_version) 4 2
      +	num_commits: 3
      +	chunks: oid_fanout oid_lookup commit_metadata
      +	EOF
     @@ t/t5324-split-commit-graph.sh: done <<\EOF
      +	graph_read_expect 15 &&
      +	git commit-graph verify
      +'
     ++
     ++test_expect_success 'add one commit, write a tip graph' '
     ++	cd "$TRASH_DIRECTORY/mixed" &&
     ++	test_commit 11 &&
     ++	git branch commits/11 &&
     ++	git commit-graph write --reachable --split &&
     ++	test_path_is_missing $infodir/commit-graph &&
     ++	test_path_is_file $graphdir/commit-graph-chain &&
     ++	ls $graphdir/graph-*.graph >graph-files &&
     ++	test_line_count = 2 graph-files &&
     ++	verify_chain_files_exist $graphdir
     ++'
      +
       test_done
 10:  439adc1718 !  9:  bb9b02af32 commit-reach: use corrected commit dates in paint_down_to_common()
     @@ Commit message
          With corrected commit dates implemented, we no longer have to rely on
          commit date as a heuristic in paint_down_to_common().
      
     -    t6024-recursive-merge setups a unique repository where all commits have
     -    the same committer date without well-defined merge-base. As this has
     -    already caused problems (as noted in 859fdc0 (commit-graph: define
     -    GIT_TEST_COMMIT_GRAPH, 2018-08-29)), we disable commit graph within the
     -    test script.
     +    While using corrected commit dates Git walks nearly the same number of
     +    commits as commit date, the process is slower as for each comparision we
     +    have to access a commit-slab (for corrected committer date) instead of
     +    accessing struct member (for committer date).
     +
     +    For example, the command `git merge-base v4.8 v4.9` on the linux
     +    repository walks 167468 commits, taking 0.135s for committer date and
     +    167496 commits, taking 0.157s for corrected committer date respectively.
     +
     +    t6404-recursive-merge setups a unique repository where all commits have
     +    the same committer date without well-defined merge-base.
     +
     +    While running tests with GIT_TEST_COMMIT_GRAPH unset, we use committer
     +    date as a heuristic in paint_down_to_common(). 6404.1 'combined merge
     +    conflicts' merges commits in the order:
     +    - Merge C with B to form a intermediate commit.
     +    - Merge the intermediate commit with A.
     +
     +    With GIT_TEST_COMMIT_GRAPH=1, we write a commit-graph and subsequently
     +    use the corrected committer date, which changes the order in which
     +    commits are merged:
     +    - Merge A with B to form a intermediate commit.
     +    - Merge the intermediate commit with C.
     +
     +    While resulting repositories are equivalent, 6404.4 'virtual trees were
     +    processed' fails with GIT_TEST_COMMIT_GRAPH=1 as we are selecting
     +    different merge-bases and thus have different object ids for the
     +    intermediate commits.
     +
     +    As this has already causes problems (as noted in 859fdc0 (commit-graph:
     +    define GIT_TEST_COMMIT_GRAPH, 2018-08-29)), we disable commit graph
     +    within t6404-recursive-merge.
      
          Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
     @@ commit-graph.c: int generation_numbers_enabled(struct repository *r)
      +	if (!g->num_commits)
      +		return 0;
      +
     -+	return !!g->chunk_generation_data;
     ++	return g->read_generation_data;
      +}
      +
     - static void close_commit_graph_one(struct commit_graph *g)
     + struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r)
       {
     - 	if (!g)
     + 	struct commit_graph *g = r->objects->commit_graph;
      
       ## commit-graph.h ##
     -@@ commit-graph.h: struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size);
     +@@ commit-graph.h: struct commit_graph *read_commit_graph_one(struct repository *r,
     + struct commit_graph *parse_commit_graph(struct repository *r,
     + 					void *graph_map, size_t graph_size);
     + 
     ++struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r);
     ++
     + /*
     +  * Return 1 if and only if the repository has a commit-graph
     +  * file and generation numbers are computed in that file.
        */
       int generation_numbers_enabled(struct repository *r);
       
     +-struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r);
      +/*
      + * Return 1 if and only if the repository has a commit-graph
      + * file and generation data chunk has been written for the file.
      + */
      +int corrected_commit_dates_enabled(struct repository *r);
     -+
     + 
       enum commit_graph_write_flags {
       	COMMIT_GRAPH_WRITE_APPEND     = (1 << 0),
     - 	COMMIT_GRAPH_WRITE_PROGRESS   = (1 << 1),
      
       ## commit-reach.c ##
      @@ commit-reach.c: static struct commit_list *paint_down_to_common(struct repository *r,
     @@ commit-reach.c: static struct commit_list *paint_down_to_common(struct repositor
       
       	one->object.flags |= PARENT1;
      
     - ## t/t6024-recursive-merge.sh ##
     -@@ t/t6024-recursive-merge.sh: GIT_COMMITTER_DATE="2006-12-12 23:28:00 +0100"
     + ## t/t6404-recursive-merge.sh ##
     +@@ t/t6404-recursive-merge.sh: GIT_COMMITTER_DATE="2006-12-12 23:28:00 +0100"
       export GIT_COMMITTER_DATE
       
       test_expect_success 'setup tests' '
     @@ t/t6024-recursive-merge.sh: GIT_COMMITTER_DATE="2006-12-12 23:28:00 +0100"
       	echo 1 >a1 &&
       	git add a1 &&
       	GIT_AUTHOR_DATE="2006-12-12 23:00:00" git commit -m 1 a1 &&
     -@@ t/t6024-recursive-merge.sh: test_expect_success 'setup tests' '
     +@@ t/t6404-recursive-merge.sh: test_expect_success 'setup tests' '
       '
       
       test_expect_success 'combined merge conflicts' '
     @@ t/t6024-recursive-merge.sh: test_expect_success 'setup tests' '
       '
       
       test_expect_success 'result contains a conflict' '
     +@@ t/t6404-recursive-merge.sh: test_expect_success 'result contains a conflict' '
     + '
     + 
     + test_expect_success 'virtual trees were processed' '
     ++	# TODO: fragile test, relies on ambigious merge-base resolution
     + 	git ls-files --stage >out &&
     + 
     + 	cat >expect <<-EOF &&
 11:  f6f91af305 ! 10:  9ada43967d doc: add corrected commit date info
     @@ Documentation/technical/commit-graph-format.txt: Git commit graph format
       - The root tree OID.
       
      @@ Documentation/technical/commit-graph-format.txt: CHUNK DATA:
     +       position. If there are more than two parents, the second value
     +       has its most-significant bit on and the other bits store an array
     +       position into the Extra Edge List chunk.
     +-    * The next 8 bytes store the generation number of the commit and
     ++    * The next 8 bytes store the topological level (generation number v1)
     ++      of the commit and
     +       the commit time in seconds since EPOCH. The generation number
     +       uses the higher 30 bits of the first 4 bytes, while the commit
     +       time uses the 32 bits of the second 4 bytes, along with the lowest
             2 bits of the lowest byte, storing the 33rd and 34th bit of the
             commit time.
       
     -+  Generation Data (ID: {'G', 'D', 'A', 'T' }) (N * 4 bytes) [Optional]
     ++  Generation Data (ID: {'G', 'D', 'A', 'T' }) (N * 4 bytes)
      +    * This list of 4-byte values store corrected commit date offsets for the
      +      commits, arranged in the same order as commit data chunk.
     -+    * This list can be later modified to store future generation number related
     -+      data.
     ++    * If the corrected commit date offset cannot be stored within 31 bits,
     ++      the value has its most-significant bit on and the other bits store
     ++      the position of corrected commit date into the Generation Data Overflow
     ++      chunk.
     ++
     ++  Generation Data Overflow (ID: {'G', 'D', 'O', 'V' }) [Optional]
     ++    * This list of 8-byte values stores the corrected commit dates for commits
     ++      with corrected commit date offsets that cannot be stored within 31 bits.
      +
         Extra Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
             This list of 4-byte values store the second through nth parents for
     @@ Documentation/technical/commit-graph.txt: A consumer may load the following info
       
      -Define the "generation number" of a commit recursively as follows:
      +There are two definitions of generation number:
     -+1. Corrected committer dates
     -+2. Topological levels
     -+
     ++1. Corrected committer dates (generation number v2)
     ++2. Topological levels (generation nummber v1)
     + 
     +- * A commit with no parents (a root commit) has generation number one.
      +Define "corrected committer date" of a commit recursively as follows:
     -+
     + 
     +- * A commit with at least one parent has generation number one more than
     +-   the largest generation number among its parents.
      +  * A commit with no parents (a root commit) has corrected committer date
      +    equal to its committer date.
     -+
     + 
     +-Equivalently, the generation number of a commit A is one more than the
      +  * A commit with at least one parent has corrected committer date equal to
      +    the maximum of its commiter date and one more than the largest corrected
      +    committer date among its parents.
      +
     ++  * As a special case, a root commit with timestamp zero has corrected commit
     ++    date of 1, to be able to distinguish it from GENERATION_NUMBER_ZERO
     ++    (that is, an uncomputed corrected commit date).
     ++
      +Define the "topological level" of a commit recursively as follows:
     - 
     -  * A commit with no parents (a root commit) has generation number one.
     - 
     -- * A commit with at least one parent has generation number one more than
     --   the largest generation number among its parents.
     ++
     ++ * A commit with no parents (a root commit) has topological level of one.
     ++
      + * A commit with at least one parent has topological level one more than
      +   the largest topological level among its parents.
     - 
     --Equivalently, the generation number of a commit A is one more than the
     ++
      +Equivalently, the topological level of a commit A is one more than the
       length of a longest path from A to a root commit. The recursive definition
       is easier to use for computation and observing the following property:
       
     +@@ Documentation/technical/commit-graph.txt: is easier to use for computation and observing the following property:
     +     generation numbers, then we always expand the boundary commit with highest
     +     generation number and can easily detect the stopping condition.
     + 
     ++The properties applies to both versions of generation number, that is both
     ++corrected committer dates and topological levels.
     ++
     + This property can be used to significantly reduce the time it takes to
     + walk commits and determine topological relationships. Without generation
     + numbers, the general heuristic is the following:
      @@ Documentation/technical/commit-graph.txt: numbers, the general heuristic is the following:
           If A and B are commits with commit time X and Y, respectively, and
           X < Y, then A _probably_ cannot reach B.
       
      -This heuristic is currently used whenever the computation is allowed to
     --violate topological relationships due to clock skew (such as "git log"
     --with default order), but is not used when the topological order is
     --required (such as merge base calculations, "git log --graph").
     --
     - In practice, we expect some commits to be created recently and not stored
     - in the commit graph. We can treat these commits as having "infinite"
     ++In absence of corrected commit dates (for example, old versions of Git or
     ++mixed generation graph chains),
     ++this heuristic is currently used whenever the computation is allowed to
     + violate topological relationships due to clock skew (such as "git log"
     + with default order), but is not used when the topological order is
     + required (such as merge base calculations, "git log --graph").
     +@@ Documentation/technical/commit-graph.txt: in the commit graph. We can treat these commits as having "infinite"
       generation number and walk until reaching commits with known generation
       number.
       
     @@ Documentation/technical/commit-graph.txt: fully-computed generation numbers. Usi
       with generation number *_INFINITY or *_ZERO is valuable.
       
      -We use the macro GENERATION_NUMBER_MAX = 0x3FFFFFFF to for commits whose
     --generation numbers are computed to be at least this value. We limit at
     --this value since it is the largest value that can be stored in the
     --commit-graph file using the 30 bits available to generation numbers. This
     --presents another case where a commit can have generation number equal to
     --that of a parent.
     -+We use the macro GENERATION_NUMBER_MAX for commits whose generation numbers
     -+are computed to be at least this value. We limit at this value since it is
     -+the largest value that can be stored in the commit-graph file using the
     -+available to generation numbers. This presents another case where a
     -+commit can have generation number equal to that of a parent.
     - 
     - Design Details
     - --------------
     ++We use the macro GENERATION_NUMBER_MAX for commits whose
     + generation numbers are computed to be at least this value. We limit at
     + this value since it is the largest value that can be stored in the
     + commit-graph file using the 30 bits available to generation numbers. This
      @@ Documentation/technical/commit-graph.txt: The merge strategy values (2 for the size multiple, 64,000 for the maximum
       number of commits) could be extracted into config settings for full
       flexibility.
       
     -+We also merge commit-graph chains when we try to write a commit graph with
     -+two different generation number definitions as they cannot be compared directly.
     -+We overwrite the existing chain and create a commit-graph with the newer or more
     -+efficient defintion. For example, overwriting topological levels commit graph
     -+chain to create a corrected commit dates commit graph chain.
     ++## Handling Mixed Generation Number Chains
     ++
     ++With the introduction of generation number v2 and generation data chunk, the
     ++following scenario is possible:
     ++
     ++1. "New" Git writes a commit-graph with the corrected commit dates.
     ++2. "Old" Git writes a split commit-graph on top without corrected commit dates.
     ++
     ++A naive approach of using the newest available generation number from
     ++each layer would lead to violated expectations: the lower layer would
     ++use corrected commit dates which are much larger than the topological
     ++levels of the higher layer. For this reason, Git inspects each layer to
     ++see if any layer is missing corrected commit dates. In such a case, Git
     ++only uses topological level
     ++
     ++When writing a new layer in split commit-graph, we write corrected commit
     ++dates if the topmost layer has corrected commit dates written. This
     ++guarantees that if a layer has corrected commit dates, all lower layers
     ++must have corrected commit dates as well.
     ++
     ++When merging layers, we do not consider whether the merged layers had corrected
     ++commit dates. Instead, the new layer will have corrected commit dates if and
     ++only if all existing layers below the new layer have corrected commit dates.
      +
       ## Deleting graph-{hash} files
       

-- 
gitgitgadget
