Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F86C433E5
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 542D3206B6
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5BbkS2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbgHOV4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbgHOVwN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:13 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7EEC0A3BED
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:39:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a15so10924985wrh.10
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=yPher7/vH7dg6ElB068bkFXCqwOPCW2T13purJWBvrQ=;
        b=G5BbkS2GC4155DtfiHid4YKlDN5sGFCfoyDUkSUu0tiMLSwiU2NKiue1StKpudjncj
         Kgu5vBf6pBlF1Nb/fzW+rz6bPvwpEIi1TjTxySVYg07AuQBulOpHqFzo5ELpJnQPQq4R
         JUjD6KuBjYPZ/AWDtWgjrw10nh5obVdHV5QlqkIkDEJ2jxH4qqJKtP880QmyETIWgx1e
         JndG8zhpg3DTprNfwiFtDKM6OwgNCv55OyI36Oh1xputhGxhlke8tkYlF/ao6LxONUyq
         l2Hg3LFe0Mwe5mgFPjej1FDOCDfnrnsPtCwJU8+8qq/6GkgvuhgehNE0jUkvk83WGwgg
         SWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=yPher7/vH7dg6ElB068bkFXCqwOPCW2T13purJWBvrQ=;
        b=rSaTmqnn89t9OVB3pkVsZWzHLouhDY+mkXcPZ8/CQ0KS9byBC9g302IpdowJQjDbM9
         +X9QnYCZjxr+kykgyaCQ09aUhNIGBbn7Ft0UZN6prY/HM4/+V5iSTMNrGmNvhzpxbXEG
         0iffI1cP2XvnZZeToDHUw24v7WfFH47ZqW7DanE/OHqiCnJrOu3zZvXyjggkD2sz65yV
         x5ypWq6sixcz0zaPeoTE1Ixjk0G981YWiD0Eb0HiSV8wgS9D3Qeial9uH1qWIzkBKiER
         zubTqFHkogPlJt7z5TAhjxztxRv85kCSJHChVU7C1HEjXQz2qTnIsyZUjF0nDQVoaAcW
         3OBQ==
X-Gm-Message-State: AOAM532/7II9AXopSrd0KSlSZ3DEVLyKt/BKDh0ohEP+6Ns+UAkyV33V
        e/wZJOJvzwgtb613OO4TW6BYHsx4fG0=
X-Google-Smtp-Source: ABdhPJxUUdAuJzbtvtWDPWX+G2oRTssu5Or5aQ7UaJo7N3+pY9CJb2rn0cCA4x+uCx05OnNQetN8lQ==
X-Received: by 2002:adf:fb01:: with SMTP id c1mr7235233wrr.119.1597509585111;
        Sat, 15 Aug 2020 09:39:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6sm21172330wrp.92.2020.08.15.09.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 09:39:44 -0700 (PDT)
Message-Id: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Aug 2020 16:39:32 +0000
Subject: [PATCH v3 00/11] [GSoC] Implement Corrected Commit Date
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Sender: git-owner@vger.kernel.org
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
compatibility. Due to an unfortunate problem, we also needed a way to
distinguish between the old and new generation number without incrementing
graph version.

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
date of C and the corrected commit dates of its parents. Then corrected
commit date offset is the difference between corrected commit date of C and
commit date of C.

We will introduce an additional commit-graph chunk, Generation Data chunk,
and store corrected commit date offsets in GDAT chunk while storing
topological levels in CDAT chunk. The old versions of Git would ignore GDAT
chunk, using topological levels from CDAT chunk. In contrast, new versions
of Git would use corrected commit dates, falling back to topological level
if the generation data chunk is absent in the commit-graph file.

Thanks to Dr. Stolee, Dr. Narębski, and Taylor for their reviews on the
first version.

I look forward to everyone's reviews!

Thanks

 * Abhishek


----------------------------------------------------------------------------

Changes in version 3:

 * Reordered patches as discussed in 1
   [https://lore.kernel.org/git/aee0ae56-3395-6848-d573-27a318d72755@gmail.com/]
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
 * Handle mixed graph version commit chains.
 * Improve commit messages for
 * Revert unnecessary whitespace changes.
 * Split uint_32 -> timestamp_t change into a new commit.

Abhishek Kumar (11):
  commit-graph: fix regression when computing bloom filter
  revision: parse parent in indegree_walk_step()
  commit-graph: consolidate fill_commit_graph_info
  commit-graph: consolidate compare_commits_by_gen
  commit-graph: return 64-bit generation number
  commit-graph: add a slab to store topological levels
  commit-graph: implement corrected commit date
  commit-graph: implement generation data chunk
  commit-graph: use generation v2 only if entire chain does
  commit-reach: use corrected commit dates in paint_down_to_common()
  doc: add corrected commit date info

 .../technical/commit-graph-format.txt         |  12 +-
 Documentation/technical/commit-graph.txt      |  45 ++--
 commit-graph.c                                | 241 +++++++++++++-----
 commit-graph.h                                |  16 +-
 commit-reach.c                                |  49 ++--
 commit-reach.h                                |   2 +-
 commit.c                                      |   9 +-
 commit.h                                      |   4 +-
 revision.c                                    |  13 +-
 t/README                                      |   3 +
 t/helper/test-read-graph.c                    |   2 +
 t/t4216-log-bloom.sh                          |   4 +-
 t/t5000-tar-tree.sh                           |   4 +-
 t/t5318-commit-graph.sh                       |  27 +-
 t/t5324-split-commit-graph.sh                 |  82 +++++-
 t/t6024-recursive-merge.sh                    |   4 +-
 t/t6600-test-reach.sh                         |  62 +++--
 upload-pack.c                                 |   2 +-
 18 files changed, 396 insertions(+), 185 deletions(-)


base-commit: 7814e8a05a59c0cf5fb186661d1551c75d1299b5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-676%2Fabhishekkumar2718%2Fcorrected_commit_date-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-676/abhishekkumar2718/corrected_commit_date-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/676

Range-diff vs v2:

  1:  a962b9ae4b =  1:  c6b7ade7af commit-graph: fix regression when computing bloom filter
  2:  cf61239f93 =  2:  e673867234 revision: parse parent in indegree_walk_step()
  3:  32da955e31 =  3:  18d5864f81 commit-graph: consolidate fill_commit_graph_info
  4:  b254782858 !  4:  6a0cde983d commit-graph: consolidate compare_commits_by_gen
     @@ Commit message
      
          Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
          Reviewed-by: Taylor Blau <me@ttaylorr.com>
     +    Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
       ## commit-graph.c ##
      @@ commit-graph.c: uint32_t commit_graph_generation(const struct commit *c)
  6:  1aa2a00a7a =  5:  6be759a954 commit-graph: return 64-bit generation number
  7:  bfe1473201 !  6:  b347dbb01b commit-graph: implement corrected commit date
     @@ Metadata
      Author: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
       ## Commit message ##
     -    commit-graph: implement corrected commit date
     +    commit-graph: add a slab to store topological levels
      
     -    With most of preparations done, let's implement corrected commit date
     -    offset. We add a new commit-slab to store topogical levels while
     -    writing commit graph and upgrade the generation member in struct
     -    commit_graph_data to a 64-bit timestamp. We store topological levels to
     -    ensure that older versions of Git will still have the performance
     -    benefits from generation number v2.
     +    As we are writing topological levels to commit data chunk to ensure
     +    backwards compatibility with "Old" Git and the member `generation` of
     +    struct commit_graph_data will store corrected commit date in a later
     +    commit, let's introduce a commit-slab to store topological levels while
     +    writing commit-graph.
     +
     +    When Git creates a split commit-graph, it takes advantage of the
     +    generation values that have been computed already and present in
     +    existing commit-graph files.
     +
     +    So, let's add a pointer to struct commit_graph to the topological level
     +    commit-slab and populate it with topological levels while writing a
     +    split commit-graph.
      
          Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
     @@ commit-graph.c: void git_test_write_commit_graph_or_die(void)
       /* Keep track of the order in which commits are added to our list. */
       define_commit_slab(commit_pos, int);
       static struct commit_pos commit_pos = COMMIT_SLAB_INIT(1, commit_pos);
     -@@ commit-graph.c: static int commit_gen_cmp(const void *va, const void *vb)
     - 	else if (generation_a > generation_b)
     - 		return 1;
     - 
     --	/* use date as a heuristic when generations are equal */
     --	if (a->date < b->date)
     --		return -1;
     --	else if (a->date > b->date)
     --		return 1;
     - 	return 0;
     - }
     - 
      @@ commit-graph.c: static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
       	item->date = (timestamp_t)((date_high << 32) | date_low);
       
     - 	if (g->chunk_generation_data)
     --		graph_data->generation = get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
     -+	{
     -+		graph_data->generation = item->date +
     -+			(timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
     -+	}
     - 	else
     - 		graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
     + 	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
     ++
     ++	if (g->topo_levels)
     ++		*topo_level_slab_at(g->topo_levels, item) = get_be32(commit_data + g->hash_len + 8) >> 2;
       }
     + 
     + static inline void set_commit_tree(struct commit *c, struct tree *t)
      @@ commit-graph.c: struct write_commit_graph_context {
     - 	struct progress *progress;
     - 	int progress_done;
     - 	uint64_t progress_cnt;
     -+	struct topo_level_slab *topo_levels;
     + 		 changed_paths:1,
     + 		 order_by_pack:1;
       
     - 	char *base_graph_name;
     - 	int num_commit_graphs_before;
     ++	struct topo_level_slab *topo_levels;
     + 	const struct split_commit_graph_opts *split_opts;
     + 	size_t total_bloom_filter_data_size;
     + 	const struct bloom_filter_settings *bloom_settings;
      @@ commit-graph.c: static int write_graph_chunk_data(struct hashfile *f,
       		else
       			packedDate[0] = 0;
     @@ commit-graph.c: static int write_graph_chunk_data(struct hashfile *f,
       
       		packedDate[1] = htonl((*list)->date);
       		hashwrite(f, packedDate, 8);
     -@@ commit-graph.c: static int write_graph_chunk_generation_data(struct hashfile *f,
     - 	int i;
     - 	for (i = 0; i < ctx->commits.nr; i++) {
     - 		struct commit *c = ctx->commits.list[i];
     -+		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
     - 		display_progress(ctx->progress, ++ctx->progress_cnt);
     --		hashwrite_be32(f, commit_graph_data_at(c)->generation);
     -+
     -+		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX)
     -+			offset = GENERATION_NUMBER_V2_OFFSET_MAX;
     -+
     -+		hashwrite_be32(f, offset);
     - 	}
     - 
     - 	return 0;
      @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph_context *ctx)
       					_("Computing commit graph generation numbers"),
       					ctx->commits.nr);
       	for (i = 0; i < ctx->commits.nr; i++) {
      -		uint32_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
     -+		uint32_t topo_level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
     ++		uint32_t level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
       
       		display_progress(ctx->progress, i + 1);
      -		if (generation != GENERATION_NUMBER_V1_INFINITY &&
      -		    generation != GENERATION_NUMBER_ZERO)
     -+		if (topo_level != GENERATION_NUMBER_V1_INFINITY &&
     -+		    topo_level != GENERATION_NUMBER_ZERO)
     ++		if (level != GENERATION_NUMBER_V1_INFINITY &&
     ++		    level != GENERATION_NUMBER_ZERO)
       			continue;
       
       		commit_list_insert(ctx->commits.list[i], &list);
     @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph
       			int all_parents_computed = 1;
      -			uint32_t max_generation = 0;
      +			uint32_t max_level = 0;
     -+			timestamp_t max_corrected_commit_date = current->date - 1;
       
       			for (parent = current->parents; parent; parent = parent->next) {
      -				generation = commit_graph_data_at(parent->item)->generation;
     -+				topo_level = *topo_level_slab_at(ctx->topo_levels, parent->item);
     ++				level = *topo_level_slab_at(ctx->topo_levels, parent->item);
       
      -				if (generation == GENERATION_NUMBER_V1_INFINITY ||
      -				    generation == GENERATION_NUMBER_ZERO) {
     -+				if (topo_level == GENERATION_NUMBER_V1_INFINITY ||
     -+				    topo_level == GENERATION_NUMBER_ZERO) {
     ++				if (level == GENERATION_NUMBER_V1_INFINITY ||
     ++				    level == GENERATION_NUMBER_ZERO) {
       					all_parents_computed = 0;
       					commit_list_insert(parent->item, &list);
       					break;
      -				} else if (generation > max_generation) {
      -					max_generation = generation;
     -+				} else {
     -+					struct commit_graph_data *data = commit_graph_data_at(parent->item);
     -+
     -+					if (topo_level > max_level)
     -+						max_level = topo_level;
     -+
     -+					if (data->generation > max_corrected_commit_date)
     -+						max_corrected_commit_date = data->generation;
     ++				} else if (level > max_level) {
     ++					max_level = level;
       				}
       			}
       
       			if (all_parents_computed) {
     - 				struct commit_graph_data *data = commit_graph_data_at(current);
     - 
     +-				struct commit_graph_data *data = commit_graph_data_at(current);
     +-
      -				data->generation = max_generation + 1;
     --				pop_commit(&list);
     -+				if (max_level > GENERATION_NUMBER_MAX - 1)
     -+					max_level = GENERATION_NUMBER_MAX - 1;
     -+
     -+				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
     -+				data->generation = max_corrected_commit_date + 1;
     + 				pop_commit(&list);
       
      -				if (data->generation > GENERATION_NUMBER_MAX)
      -					data->generation = GENERATION_NUMBER_MAX;
     -+				pop_commit(&list);
     ++				if (max_level > GENERATION_NUMBER_MAX - 1)
     ++					max_level = GENERATION_NUMBER_MAX - 1;
     ++				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
       			}
       		}
       	}
     @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
       	if (!commit_graph_compatible(the_repository))
       		return 0;
      @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
     - 	ctx->total_bloom_filter_data_size = 0;
     - 	ctx->write_generation_data = !git_env_bool(GIT_TEST_COMMIT_GRAPH_NO_GDAT, 0);
     + 		}
     + 	}
       
      +	init_topo_level_slab(&topo_levels);
      +	ctx->topo_levels = &topo_levels;
      +
     - 	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
     - 		ctx->changed_paths = 1;
     - 	if (!(flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {
     -@@ commit-graph.c: int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
     - 	for (i = 0; i < g->num_commits; i++) {
     - 		struct commit *graph_commit, *odb_commit;
     - 		struct commit_list *graph_parents, *odb_parents;
     --		timestamp_t max_generation = 0;
     --		timestamp_t generation;
     -+		timestamp_t max_parent_corrected_commit_date = 0;
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
     -+			if (corrected_commit_date > max_parent_corrected_commit_date)
     -+				max_parent_corrected_commit_date = corrected_commit_date;
     - 
     - 			graph_parents = graph_parents->next;
     - 			odb_parents = odb_parents->next;
     -@@ commit-graph.c: int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
     - 		if (generation_zero == GENERATION_ZERO_EXISTS)
     - 			continue;
     ++	if (ctx->r->objects->commit_graph) {
     ++		struct commit_graph *g = ctx->r->objects->commit_graph;
     ++
     ++		while (g) {
     ++			g->topo_levels = &topo_levels;
     ++			g = g->base_graph;
     ++		}
     ++	}
     ++
     + 	if (pack_indexes) {
     + 		ctx->order_by_pack = 1;
     + 		if ((res = fill_oids_from_packs(ctx, pack_indexes)))
     +
     + ## commit-graph.h ##
     +@@ commit-graph.h: struct commit_graph {
     + 	const unsigned char *chunk_bloom_indexes;
     + 	const unsigned char *chunk_bloom_data;
     + 
     ++	struct topo_level_slab *topo_levels;
     + 	struct bloom_filter_settings *bloom_filter_settings;
     + };
       
     --		/*
     --		 * If one of our parents has generation GENERATION_NUMBER_MAX, then
     --		 * our generation is also GENERATION_NUMBER_MAX. Decrement to avoid
     --		 * extra logic in the following condition.
     --		 */
     --		if (max_generation == GENERATION_NUMBER_MAX)
     --			max_generation--;
     --
     --		generation = commit_graph_generation(graph_commit);
     --		if (generation != max_generation + 1)
     --			graph_report(_("commit-graph generation for commit %s is %u != %u"),
     -+		corrected_commit_date = commit_graph_generation(graph_commit);
     -+		if (corrected_commit_date < max_parent_corrected_commit_date + 1)
     -+			graph_report(_("commit-graph generation for commit %s is %"PRItime" < %"PRItime),
     - 				     oid_to_hex(&cur_oid),
     --				     generation,
     --				     max_generation + 1);
     -+				     corrected_commit_date,
     -+				     max_parent_corrected_commit_date + 1);
     - 
     - 		if (graph_commit->date != odb_commit->date)
     - 			graph_report(_("commit date for commit %s in commit-graph is %"PRItime" != %"PRItime),
      
       ## commit.h ##
      @@
  -:  ---------- >  7:  4074ace65b commit-graph: implement corrected commit date
  5:  cb797e20d7 !  8:  4e746628ac commit-graph: implement generation data chunk
     @@ commit-graph.c: static void fill_commit_graph_info(struct commit *item, struct c
       
      -	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
      +	if (g->chunk_generation_data)
     -+		graph_data->generation = get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
     ++		graph_data->generation = item->date +
     ++			(timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
      +	else
      +		graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
     - }
       
     - static inline void set_commit_tree(struct commit *c, struct tree *t)
     + 	if (g->topo_levels)
     + 		*topo_level_slab_at(g->topo_levels, item) = get_be32(commit_data + g->hash_len + 8) >> 2;
      @@ commit-graph.c: struct write_commit_graph_context {
       		 report_progress:1,
       		 split:1,
     @@ commit-graph.c: struct write_commit_graph_context {
      +		 order_by_pack:1,
      +		 write_generation_data:1;
       
     + 	struct topo_level_slab *topo_levels;
       	const struct split_commit_graph_opts *split_opts;
     - 	size_t total_bloom_filter_data_size;
      @@ commit-graph.c: static int write_graph_chunk_data(struct hashfile *f,
       	return 0;
       }
     @@ commit-graph.c: static int write_graph_chunk_data(struct hashfile *f,
      +	int i;
      +	for (i = 0; i < ctx->commits.nr; i++) {
      +		struct commit *c = ctx->commits.list[i];
     ++		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
      +		display_progress(ctx->progress, ++ctx->progress_cnt);
     -+		hashwrite_be32(f, commit_graph_data_at(c)->generation);
     ++
     ++		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX)
     ++			offset = GENERATION_NUMBER_V2_OFFSET_MAX;
     ++		hashwrite_be32(f, offset);
      +	}
      +
      +	return 0;
     @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_con
       	chunks[2].id = GRAPH_CHUNKID_DATA;
       	chunks[2].size = (hashsz + 16) * ctx->commits.nr;
       	chunks[2].write_fn = write_graph_chunk_data;
     ++
     ++	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_NO_GDAT, 0))
     ++		ctx->write_generation_data = 0;
      +	if (ctx->write_generation_data) {
      +		chunks[num_chunks].id = GRAPH_CHUNKID_GENERATION_DATA;
      +		chunks[num_chunks].size = sizeof(uint32_t) * ctx->commits.nr;
     @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
       	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
       	ctx->split_opts = split_opts;
       	ctx->total_bloom_filter_data_size = 0;
     -+	ctx->write_generation_data = !git_env_bool(GIT_TEST_COMMIT_GRAPH_NO_GDAT, 0);
     ++	ctx->write_generation_data = 1;
       
       	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
       		ctx->changed_paths = 1;
     @@ t/t5318-commit-graph.sh: test_expect_success 'replace-objects invalidates commit
      
       ## t/t5324-split-commit-graph.sh ##
      @@ t/t5324-split-commit-graph.sh: test_expect_success 'setup repo' '
     + 	infodir=".git/objects/info" &&
       	graphdir="$infodir/commit-graphs" &&
     - 	test_oid_init &&
       	test_oid_cache <<-EOM
      -	shallow sha1:1760
      -	shallow sha256:2064
  8:  833779ad53 !  9:  5a147a9704 commit-graph: handle mixed generation commit chains
     @@ Metadata
      Author: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
       ## Commit message ##
     -    commit-graph: handle mixed generation commit chains
     +    commit-graph: use generation v2 only if entire chain does
      
     -    As corrected commit dates and topological levels cannot be compared
     -    directly, we must handle commit graph chains with mixed generation
     -    number definitions.
     +    Since there are released versions of Git that understand generation
     +    numbers in the commit-graph's CDAT chunk but do not understand the GDAT
     +    chunk, the following scenario is possible:
      
     -    While reading a commit graph file, we disable generation numbers if the
     -    chain contains mixed generation numbers.
     +    1. "New" Git writes a commit-graph with the GDAT chunk.
     +    2. "Old" Git writes a split commit-graph on top without a GDAT chunk.
      
     -    While writing to commit graph chain, we write generation data chunk only
     -    if the previous tip of chain had a generation data chunk. Using
     -    `--split=replace` overwrites the existing chain and writes generation
     -    data chunk regardless of previous tip.
     +    Because of the current use of inspecting the current layer for a
     +    chunk_generation_data pointer, the commits in the lower layer will be
     +    interpreted as having very large generation values (commit date plus
     +    offset) compared to the generation numbers in the top layer (topological
     +    level). This violates the expectation that the generation of a parent is
     +    strictly smaller than the generation of a child.
      
     -    In t5324-split-commit-graph, we set up a repo with twelve commits and
     -    write a base commit graph file with no generation data chunk. When add
     -    three commits and write to chain again, Git does not write generation
     -    data chunk even without setting GIT_TEST_COMMIT_GRAPH_NO_GDAT=1. Then,
     -    as we replace the existing chain, Git writes a commit graph file with
     -    generation data chunk.
     +    It is difficult to expose this issue in a test. Since we _start_ with
     +    artificially low generation numbers, any commit walk that prioritizes
     +    generation numbers will walk all of the commits with high generation
     +    number before walking the commits with low generation number. In all the
     +    cases I tried, the commit-graph layers themselves "protect" any
     +    incorrect behavior since none of the commits in the lower layer can
     +    reach the commits in the upper layer.
      
     +    This issue would manifest itself as a performance problem in this case,
     +    especially with something like "git log --graph" since the low
     +    generation numbers would cause the in-degree queue to walk all of the
     +    commits in the lower layer before allowing the topo-order queue to write
     +    anything to output (depending on the size of the upper layer).
     +
     +    Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
       ## commit-graph.c ##
     -@@ commit-graph.c: int generation_numbers_enabled(struct repository *r)
     - 	if (!g->num_commits)
     - 		return 0;
     +@@ commit-graph.c: static struct commit_graph *load_commit_graph_chain(struct repository *r,
     + 	return graph_chain;
     + }
       
     -+	/* We cannot compare topological levels and corrected commit dates */
     -+	while (g->base_graph) {
     -+		warning(_("commit-graph-chain contains mixed generation versions"));
     -+		if ((g->chunk_generation_data == NULL) ^ (g->base_graph->chunk_generation_data == NULL))
     -+			return 0;
     ++static void validate_mixed_generation_chain(struct repository *r)
     ++{
     ++	struct commit_graph *g = r->objects->commit_graph;
     ++	int read_generation_data = 1;
     ++
     ++	while (g) {
     ++		if (!g->chunk_generation_data) {
     ++			read_generation_data = 0;
     ++			break;
     ++		}
      +		g = g->base_graph;
      +	}
      +
     - 	first_generation = get_be32(g->chunk_commit_data +
     - 				    g->hash_len + 8) >> 2;
     ++	g = r->objects->commit_graph;
     ++
     ++	while (g) {
     ++		g->read_generation_data = read_generation_data;
     ++		g = g->base_graph;
     ++	}
     ++}
     ++
     + struct commit_graph *read_commit_graph_one(struct repository *r,
     + 					   struct object_directory *odb)
     + {
     +@@ commit-graph.c: struct commit_graph *read_commit_graph_one(struct repository *r,
     + 	if (!g)
     + 		g = load_commit_graph_chain(r, odb);
     + 
     ++	validate_mixed_generation_chain(r);
     ++
     + 	return g;
     + }
     + 
     +@@ commit-graph.c: static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
     + 	date_low = get_be32(commit_data + g->hash_len + 12);
     + 	item->date = (timestamp_t)((date_high << 32) | date_low);
       
     +-	if (g->chunk_generation_data)
     ++	if (g->chunk_generation_data && g->read_generation_data)
     + 		graph_data->generation = item->date +
     + 			(timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
     + 	else
     +@@ commit-graph.c: void load_commit_graph_info(struct repository *r, struct commit *item)
     + 	uint32_t pos;
     + 	if (!prepare_commit_graph(r))
     + 		return;
     ++
     + 	if (find_commit_in_graph(item, r->objects->commit_graph, &pos))
     + 		fill_commit_graph_info(item, r->objects->commit_graph, pos);
     + }
      @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
       
       		g = ctx->r->objects->commit_graph;
     @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
       
       	ctx->approx_nr_objects = approximate_object_count();
      
     + ## commit-graph.h ##
     +@@ commit-graph.h: struct commit_graph {
     + 	struct object_directory *odb;
     + 
     + 	uint32_t num_commits_in_base;
     ++	uint32_t read_generation_data;
     + 	struct commit_graph *base_graph;
     + 
     + 	const uint32_t *chunk_oid_fanout;
     +
       ## t/t5324-split-commit-graph.sh ##
      @@ t/t5324-split-commit-graph.sh: done <<\EOF
       0600 -r--------
     @@ t/t5324-split-commit-graph.sh: done <<\EOF
      +		test_commit $i &&
      +		git branch commits/$i || return 1
      +	done &&
     ++	git commit-graph write --reachable --split &&
      +	git reset --hard commits/2 &&
      +	git merge commits/4 &&
      +	git branch merge/1 &&
      +	git reset --hard commits/4 &&
      +	git merge commits/6 &&
      +	git branch merge/2 &&
     -+	GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --reachable --split &&
     ++	GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --reachable --split=no-merge &&
      +	test-tool read-graph >output &&
      +	cat >expect <<-EOF &&
     -+	header: 43475048 1 1 3 0
     -+	num_commits: 12
     ++	header: 43475048 1 1 4 1
     ++	num_commits: 2
      +	chunks: oid_fanout oid_lookup commit_metadata
      +	EOF
     -+	test_cmp expect output
     ++	test_cmp expect output &&
     ++	git commit-graph verify
      +'
      +
      +test_expect_success 'does not write generation data chunk if not present on existing tip' '
     @@ t/t5324-split-commit-graph.sh: done <<\EOF
      +	git merge commits/5 &&
      +	git merge merge/2 &&
      +	git branch merge/3 &&
     -+	git commit-graph write --reachable --split &&
     ++	git commit-graph write --reachable --split=no-merge &&
      +	test-tool read-graph >output &&
      +	cat >expect <<-EOF &&
     -+	header: 43475048 1 1 4 1
     ++	header: 43475048 1 1 4 2
      +	num_commits: 3
      +	chunks: oid_fanout oid_lookup commit_metadata
      +	EOF
     -+	test_cmp expect output
     ++	test_cmp expect output &&
     ++	git commit-graph verify
      +'
      +
      +test_expect_success 'writes generation data chunk when commit-graph chain is replaced' '
      +	cd "$TRASH_DIRECTORY/mixed" &&
     -+	git commit-graph write --reachable --split='replace' &&
     ++	git commit-graph write --reachable --split=replace &&
      +	test_path_is_file $graphdir/commit-graph-chain &&
      +	test_line_count = 1 $graphdir/commit-graph-chain &&
      +	verify_chain_files_exist $graphdir &&
     -+	graph_read_expect 15
     ++	graph_read_expect 15 &&
     ++	git commit-graph verify
      +'
      +
       test_done
  9:  58a2d5da01 = 10:  439adc1718 commit-reach: use corrected commit dates in paint_down_to_common()
 10:  4c34294602 = 11:  f6f91af305 doc: add corrected commit date info

-- 
gitgitgadget
