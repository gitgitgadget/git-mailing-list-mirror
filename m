Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A52C433E0
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F37206D8
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFpYik3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgHICxw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 22:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgHICxw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 22:53:52 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705F9C061A27
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 19:53:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id p20so5059096wrf.0
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 19:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=WA9VT/VhLOBGB/OWPTOqNPPjx6XFJJL8HOKNL7L2vWY=;
        b=NFpYik3m2pAj3CUyqGWiWoo2l2/VQ0RCOoRw1F5TRkBAJu894WyV2786jg5/5R0BjZ
         PxmIzdg0w9lTA786RSYYw43RpqpfJvTLOtb6xZRDd6zD80AbktA3rco/Y+qyXXRoiuDh
         j0CxP8ATPI2H/SEzE7jk/hPYbEx0G9wgfdN76EHTF7LiF6AkYMSnjqIasfWCKP57yx36
         H1ycOVcMQlUj0rxoQCiVBtX4d1w5skfexZ2HjVq8r+U/1z85yj1DUEqZKzfUQy0JUA/i
         bJlHh5dRCa+RiZAXJTXys6/iLxnG15PB1kuwQ+1vvFxN6mxlYPZJouANvm6JgumZ8tNl
         hb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=WA9VT/VhLOBGB/OWPTOqNPPjx6XFJJL8HOKNL7L2vWY=;
        b=VKIxrgmEj7nCzEmHTMiXbofr70ElhVlq6nxOzaTjLmgabFyJ15YEfXzn0vNNpMQOkF
         ShrMVBFJtUbR5M4AGXctsLeF+q70HDVnPKgequr9GE7qFqLUhj1PfGKhyLl3lTpKR72J
         4Rwn5+ek1uKtbTGp3ydXRmeHRk8nKHuE2HY/28DE28HfxXAdDcqtAR0LO3bdxezXhePe
         afM83jimQ+ugmEg6UN5Rxu146oWOBS/xqzcfYCxf0yRGVbUSjzaHhhHVhcvx6X3m0j26
         m8yPfzgvPznTkyMy8SXwjwdyE+QsidhJANHfkZ5jzDFgERwhqIxkdgqHbNTX3iLyDEd9
         1cwA==
X-Gm-Message-State: AOAM531pVZTVe8CqYsc05AnibGCzYF9+uJz1IcZpaImDjwU4ssGcdteq
        nlWoPrAZv6b9HiWpXb+oyDg7wWll
X-Google-Smtp-Source: ABdhPJz6okXd/XIoiyd4yiejgP8qdtWNJw0LiBoOS0SWzkcSqwgw+RAHtlbg0MeynVYJ2j04XQ7Jcg==
X-Received: by 2002:adf:e504:: with SMTP id j4mr19028927wrm.205.1596941628736;
        Sat, 08 Aug 2020 19:53:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y17sm16901083wrh.63.2020.08.08.19.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 19:53:46 -0700 (PDT)
Message-Id: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.git.1595927632.gitgitgadget@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Aug 2020 02:53:34 +0000
Subject: [PATCH v2 00/10] [GSoC] Implement Corrected Commit Date
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

Abhishek Kumar (10):
  commit-graph: fix regression when computing bloom filter
  revision: parse parent in indegree_walk_step()
  commit-graph: consolidate fill_commit_graph_info
  commit-graph: consolidate compare_commits_by_gen
  commit-graph: implement generation data chunk
  commit-graph: return 64-bit generation number
  commit-graph: implement corrected commit date
  commit-graph: handle mixed generation commit chains
  commit-reach: use corrected commit dates in paint_down_to_common()
  doc: add corrected commit date info

 .../technical/commit-graph-format.txt         |  12 +-
 Documentation/technical/commit-graph.txt      |  45 ++--
 commit-graph.c                                | 203 ++++++++++++------
 commit-graph.h                                |  14 +-
 commit-reach.c                                |  49 ++---
 commit-reach.h                                |   2 +-
 commit.c                                      |   9 +-
 commit.h                                      |   4 +-
 revision.c                                    |  13 +-
 t/README                                      |   3 +
 t/helper/test-read-graph.c                    |   2 +
 t/t4216-log-bloom.sh                          |   4 +-
 t/t5000-tar-tree.sh                           |   4 +-
 t/t5318-commit-graph.sh                       |  27 +--
 t/t5324-split-commit-graph.sh                 |  78 ++++++-
 t/t6024-recursive-merge.sh                    |   4 +-
 t/t6600-test-reach.sh                         |  62 +++---
 upload-pack.c                                 |   2 +-
 18 files changed, 354 insertions(+), 183 deletions(-)


base-commit: dc04167d378fb29d30e1647ff6ff51dd182bc9a3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-676%2Fabhishekkumar2718%2Fcorrected_commit_date-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-676/abhishekkumar2718/corrected_commit_date-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/676

Range-diff vs v1:

  1:  91e6e97a66 !  1:  a962b9ae4b commit-graph: fix regression when computing bloom filter
     @@ Metadata
       ## Commit message ##
          commit-graph: fix regression when computing bloom filter
      
     -    With 3d112755 (commit-graph: examine commits by generation number), Git
     -    knew to sort by generation number before examining the diff when not
     -    using pack order. c49c82aa (commit: move members graph_pos, generation
     -    to a slab, 2020-06-17) moved generation number into a slab and
     -    introduced a helper which returns GENERATION_NUMBER_INFINITY when
     -    writing the graph. Sorting is no longer useful and essentially reverts
     -    the earlier commit.
     -
     -    Let's fix this by accessing generation number directly through the slab.
     +    commit_gen_cmp is used when writing a commit-graph to sort commits in
     +    generation order before computing Bloom filters. Since c49c82aa (commit:
     +    move members graph_pos, generation to a slab, 2020-06-17) made it so
     +    that 'commit_graph_generation()' returns 'GENERATION_NUMBER_INFINITY'
     +    during writing, we cannot call it within this function. Instead, access
     +    the generation number directly through the slab (i.e., by calling
     +    'commit_graph_data_at(c)->generation') in order to access it while
     +    writing.
      
          Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
     @@ commit-graph.c: static int commit_gen_cmp(const void *va, const void *vb)
      -	uint32_t generation_b = commit_graph_generation(b);
      +	uint32_t generation_a = commit_graph_data_at(a)->generation;
      +	uint32_t generation_b = commit_graph_data_at(b)->generation;
     -+
       	/* lower generation commits first */
       	if (generation_a < generation_b)
       		return -1;
  2:  d23f67dc80 !  2:  cf61239f93 revision: parse parent in indegree_walk_step()
     @@ revision.c: static void indegree_walk_step(struct rev_info *revs)
       		int *pi = indegree_slab_at(&info->indegree, parent);
       
      +		if (parse_commit_gently(parent, 1) < 0)
     -+			return ;
     ++			return;
      +
       		if (*pi)
       			(*pi)++;
  3:  701f591236 !  3:  32da955e31 commit-graph: consolidate fill_commit_graph_info
     @@ Commit message
      
          The test 'generate tar with future mtime' creates a commit with commit
          time of (2 ^ 36 + 1) seconds since EPOCH. The commit time overflows into
     -    generation number and has undefined behavior. The test used to pass as
     -    fill_commit_in_graph() did not read commit time from commit graph,
     -    reading commit date from odb instead.
     +    generation number (within CDAT chunk) and has undefined behavior.
      
     -    Let's fix that by setting commit time of (2 ^ 34 - 1) seconds.
     +    The test used to pass as fill_commit_in_graph() guarantees the values of
     +    graph position and generation number, and did not load timestamp.
     +    However, with corrected commit date we will need load the timestamp as
     +    well to populate the generation number.
     +
     +    Let's fix the test by setting a timestamp of (2 ^ 34 - 1) seconds.
      
          Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
     @@ commit-graph.c: static int fill_commit_in_graph(struct repository *r,
       	const unsigned char *commit_data;
       	uint32_t lex_index;
       
     -+	fill_commit_graph_info(item, g, pos);
     -+
       	while (pos < g->num_commits_in_base)
       		g = g->base_graph;
       
      -	if (pos >= g->num_commits + g->num_commits_in_base)
      -		die(_("invalid commit position. commit-graph is likely corrupt"));
     --
     ++	fill_commit_graph_info(item, g, pos);
     + 
      -	/*
      -	 * Store the "full" position, but then use the
      -	 * "local" position for the rest of the calculation.
  4:  812fe75fc7 !  4:  b254782858 commit-graph: consolidate compare_commits_by_gen
     @@ Commit message
          compare_commits_by_gen() to commit-graph.
      
          Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
     +    Reviewed-by: Taylor Blau <me@ttaylorr.com>
      
       ## commit-graph.c ##
      @@ commit-graph.c: uint32_t commit_graph_generation(const struct commit *c)
  5:  80ea7da343 !  5:  cb797e20d7 commit-graph: implement generation data chunk
     @@ Metadata
       ## Commit message ##
          commit-graph: implement generation data chunk
      
     -    One of the essential pre-requisites before implementing generation
     -    number as to distinguish between generation numbers v1 and v2 while
     -    still being compatible with old Git.
     +    As discovered by Ævar, we cannot increment graph version to
     +    distinguish between generation numbers v1 and v2 [1]. Thus, one of
     +    pre-requistes before implementing generation number was to distinguish
     +    between graph versions in a backwards compatible manner.
      
          We are going to introduce a new chunk called Generation Data chunk (or
          GDAT). GDAT stores generation number v2 (and any subsequent versions),
          whereas CDAT will still store topological level.
      
          Old Git does not understand GDAT chunk and would ignore it, reading
     -    topological levels from CDAT. Newer versions of Git can parse GDAT and
     -    take advantage of newer generation numbers, falling back to topological
     -    levels when GDAT chunk is missing (as it would happen with a commit
     -    graph written by old Git).
     +    topological levels from CDAT. New Git can parse GDAT and take advantage
     +    of newer generation numbers, falling back to topological levels when
     +    GDAT chunk is missing (as it would happen with a commit graph written
     +    by old Git).
     +
     +    We introduce a test environment variable 'GIT_TEST_COMMIT_GRAPH_NO_GDAT'
     +    which forces commit-graph file to be written without generation data
     +    chunk to emulate a commit-graph file written by old Git.
     +
     +    [1]: https://lore.kernel.org/git/87a7gdspo4.fsf@evledraar.gmail.com/
      
          Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
     @@ commit-graph.c: static void fill_commit_graph_info(struct commit *item, struct c
       }
       
       static inline void set_commit_tree(struct commit *c, struct tree *t)
     -@@ commit-graph.c: static void write_graph_chunk_data(struct hashfile *f, int hash_len,
     - 	}
     +@@ commit-graph.c: struct write_commit_graph_context {
     + 		 report_progress:1,
     + 		 split:1,
     + 		 changed_paths:1,
     +-		 order_by_pack:1;
     ++		 order_by_pack:1,
     ++		 write_generation_data:1;
     + 
     + 	const struct split_commit_graph_opts *split_opts;
     + 	size_t total_bloom_filter_data_size;
     +@@ commit-graph.c: static int write_graph_chunk_data(struct hashfile *f,
     + 	return 0;
       }
       
     -+static void write_graph_chunk_generation_data(struct hashfile *f,
     ++static int write_graph_chunk_generation_data(struct hashfile *f,
      +					      struct write_commit_graph_context *ctx)
      +{
     -+	struct commit **list = ctx->commits.list;
     -+	int count;
     -+	for (count = 0; count < ctx->commits.nr; count++, list++) {
     ++	int i;
     ++	for (i = 0; i < ctx->commits.nr; i++) {
     ++		struct commit *c = ctx->commits.list[i];
      +		display_progress(ctx->progress, ++ctx->progress_cnt);
     -+		hashwrite_be32(f, commit_graph_data_at(*list)->generation);
     ++		hashwrite_be32(f, commit_graph_data_at(c)->generation);
      +	}
     ++
     ++	return 0;
      +}
      +
     - static void write_graph_chunk_extra_edges(struct hashfile *f,
     - 					  struct write_commit_graph_context *ctx)
     + static int write_graph_chunk_extra_edges(struct hashfile *f,
     +-					 struct write_commit_graph_context *ctx)
     ++					  struct write_commit_graph_context *ctx)
       {
     + 	struct commit **list = ctx->commits.list;
     + 	struct commit **last = ctx->commits.list + ctx->commits.nr;
      @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_context *ctx)
     - 	uint64_t chunk_offsets[MAX_NUM_CHUNKS + 1];
     - 	const unsigned hashsz = the_hash_algo->rawsz;
     - 	struct strbuf progress_title = STRBUF_INIT;
     --	int num_chunks = 3;
     -+	int num_chunks = 4;
     - 	struct object_id file_hash;
     - 	const struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
     - 
     -@@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_context *ctx)
     - 	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
     - 	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
     - 	chunk_ids[2] = GRAPH_CHUNKID_DATA;
     -+	chunk_ids[3] = GRAPH_CHUNKID_GENERATION_DATA;
     + 	chunks[2].id = GRAPH_CHUNKID_DATA;
     + 	chunks[2].size = (hashsz + 16) * ctx->commits.nr;
     + 	chunks[2].write_fn = write_graph_chunk_data;
     ++	if (ctx->write_generation_data) {
     ++		chunks[num_chunks].id = GRAPH_CHUNKID_GENERATION_DATA;
     ++		chunks[num_chunks].size = sizeof(uint32_t) * ctx->commits.nr;
     ++		chunks[num_chunks].write_fn = write_graph_chunk_generation_data;
     ++		num_chunks++;
     ++	}
       	if (ctx->num_extra_edges) {
     - 		chunk_ids[num_chunks] = GRAPH_CHUNKID_EXTRAEDGES;
     - 		num_chunks++;
     -@@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_context *ctx)
     - 	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
     - 	chunk_offsets[2] = chunk_offsets[1] + hashsz * ctx->commits.nr;
     - 	chunk_offsets[3] = chunk_offsets[2] + (hashsz + 16) * ctx->commits.nr;
     -+	chunk_offsets[4] = chunk_offsets[3] + sizeof(uint32_t) * ctx->commits.nr;
     + 		chunks[num_chunks].id = GRAPH_CHUNKID_EXTRAEDGES;
     + 		chunks[num_chunks].size = 4 * ctx->num_extra_edges;
     +@@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
     + 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
     + 	ctx->split_opts = split_opts;
     + 	ctx->total_bloom_filter_data_size = 0;
     ++	ctx->write_generation_data = !git_env_bool(GIT_TEST_COMMIT_GRAPH_NO_GDAT, 0);
       
     --	num_chunks = 3;
     -+	num_chunks = 4;
     - 	if (ctx->num_extra_edges) {
     - 		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
     - 						4 * ctx->num_extra_edges;
     -@@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_context *ctx)
     - 	write_graph_chunk_fanout(f, ctx);
     - 	write_graph_chunk_oids(f, hashsz, ctx);
     - 	write_graph_chunk_data(f, hashsz, ctx);
     -+	write_graph_chunk_generation_data(f, ctx);
     - 	if (ctx->num_extra_edges)
     - 		write_graph_chunk_extra_edges(f, ctx);
     - 	if (ctx->changed_paths) {
     + 	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
     + 		ctx->changed_paths = 1;
      
       ## commit-graph.h ##
     +@@
     + #include "oidset.h"
     + 
     + #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
     ++#define GIT_TEST_COMMIT_GRAPH_NO_GDAT "GIT_TEST_COMMIT_GRAPH_NO_GDAT"
     + #define GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE "GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE"
     + #define GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS "GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS"
     + 
      @@ commit-graph.h: struct commit_graph {
       	const uint32_t *chunk_oid_fanout;
       	const unsigned char *chunk_oid_lookup;
     @@ commit-graph.h: struct commit_graph {
       	const unsigned char *chunk_base_graphs;
       	const unsigned char *chunk_bloom_indexes;
      
     + ## t/README ##
     +@@ t/README: GIT_TEST_COMMIT_GRAPH=<boolean>, when true, forces the commit-graph to
     + be written after every 'git commit' command, and overrides the
     + 'core.commitGraph' setting to true.
     + 
     ++GIT_TEST_COMMIT_GRAPH_NO_GDAT=<boolean>, when true, forces the
     ++commit-graph to be written without generation data chunk.
     ++
     + GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=<boolean>, when true, forces
     + commit-graph write to compute and write changed path Bloom filters for
     + every 'git commit-graph write', as if the `--changed-paths` option was
     +
       ## t/helper/test-read-graph.c ##
      @@ t/helper/test-read-graph.c: int cmd__read_graph(int argc, const char **argv)
       		printf(" oid_lookup");
     @@ t/t4216-log-bloom.sh: test_expect_success 'setup test - repo, commits, commit gr
      
       ## t/t5318-commit-graph.sh ##
      @@ t/t5318-commit-graph.sh: graph_git_behavior 'no graph' full commits/3 commits/1
     - 
       graph_read_expect() {
       	OPTIONAL=""
     --	NUM_CHUNKS=3
     -+	NUM_CHUNKS=4
     - 	if test ! -z $2
     + 	NUM_CHUNKS=3
     +-	if test ! -z $2
     ++	if test ! -z "$2"
       	then
       		OPTIONAL=" $2"
     --		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
     -+		NUM_CHUNKS=$((4 + $(echo "$2" | wc -w)))
     - 	fi
     - 	cat >expect <<- EOF
     - 	header: 43475048 1 1 $NUM_CHUNKS 0
     - 	num_commits: $1
     --	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
     -+	chunks: oid_fanout oid_lookup commit_metadata generation_data$OPTIONAL
     - 	EOF
     - 	test-tool read-graph >output &&
     - 	test_cmp expect output
     -@@ t/t5318-commit-graph.sh: GRAPH_BYTE_HASH=5
     - GRAPH_BYTE_CHUNK_COUNT=6
     - GRAPH_CHUNK_LOOKUP_OFFSET=8
     - GRAPH_CHUNK_LOOKUP_WIDTH=12
     --GRAPH_CHUNK_LOOKUP_ROWS=5
     -+GRAPH_CHUNK_LOOKUP_ROWS=6
     - GRAPH_BYTE_OID_FANOUT_ID=$GRAPH_CHUNK_LOOKUP_OFFSET
     - GRAPH_BYTE_OID_LOOKUP_ID=$(($GRAPH_CHUNK_LOOKUP_OFFSET + \
     - 			    1 * $GRAPH_CHUNK_LOOKUP_WIDTH))
     -@@ t/t5318-commit-graph.sh: GRAPH_BYTE_COMMIT_TREE=$GRAPH_COMMIT_DATA_OFFSET
     - GRAPH_BYTE_COMMIT_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN))
     - GRAPH_BYTE_COMMIT_EXTRA_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 4))
     - GRAPH_BYTE_COMMIT_WRONG_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 3))
     --GRAPH_BYTE_COMMIT_GENERATION=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 11))
     - GRAPH_BYTE_COMMIT_DATE=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 12))
     - GRAPH_COMMIT_DATA_WIDTH=$(($HASH_LEN + 16))
     --GRAPH_OCTOPUS_DATA_OFFSET=$(($GRAPH_COMMIT_DATA_OFFSET + \
     --			     $GRAPH_COMMIT_DATA_WIDTH * $NUM_COMMITS))
     -+GRAPH_GENERATION_DATA_OFFSET=$(($GRAPH_COMMIT_DATA_OFFSET + \
     -+				$GRAPH_COMMIT_DATA_WIDTH * $NUM_COMMITS))
     -+GRAPH_GENERATION_DATA_WIDTH=4
     -+GRAPH_BYTE_COMMIT_GENERATION=$(($GRAPH_GENERATION_DATA_OFFSET + 3))
     -+GRAPH_OCTOPUS_DATA_OFFSET=$(($GRAPH_GENERATION_DATA_OFFSET + \
     -+			     $GRAPH_GENERATION_DATA_WIDTH * $NUM_COMMITS))
     - GRAPH_BYTE_OCTOPUS=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
     - GRAPH_BYTE_FOOTER=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4 * $NUM_OCTOPUS_EDGES))
     - 
     -@@ t/t5318-commit-graph.sh: test_expect_success 'detect incorrect generation number' '
     - '
     - 
     - test_expect_success 'detect incorrect generation number' '
     --	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\01" \
     -+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\00" \
     - 		"non-zero generation number"
     + 		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
     +@@ t/t5318-commit-graph.sh: test_expect_success 'exit with correct error on bad input to --stdin-commits' '
     + 	# valid commit and tree OID
     + 	git rev-parse HEAD HEAD^{tree} >in &&
     + 	git commit-graph write --stdin-commits <in &&
     +-	graph_read_expect 3
     ++	graph_read_expect 3 generation_data
     + '
     + 
     + test_expect_success 'write graph' '
     + 	cd "$TRASH_DIRECTORY/full" &&
     + 	git commit-graph write &&
     + 	test_path_is_file $objdir/info/commit-graph &&
     +-	graph_read_expect "3"
     ++	graph_read_expect "3" generation_data
       '
       
     + test_expect_success POSIXPERM 'write graph has correct permissions' '
     +@@ t/t5318-commit-graph.sh: test_expect_success 'write graph with merges' '
     + 	cd "$TRASH_DIRECTORY/full" &&
     + 	git commit-graph write &&
     + 	test_path_is_file $objdir/info/commit-graph &&
     +-	graph_read_expect "10" "extra_edges"
     ++	graph_read_expect "10" "generation_data extra_edges"
     + '
     + 
     + graph_git_behavior 'merge 1 vs 2' full merge/1 merge/2
     +@@ t/t5318-commit-graph.sh: test_expect_success 'write graph with new commit' '
     + 	cd "$TRASH_DIRECTORY/full" &&
     + 	git commit-graph write &&
     + 	test_path_is_file $objdir/info/commit-graph &&
     +-	graph_read_expect "11" "extra_edges"
     ++	graph_read_expect "11" "generation_data extra_edges"
     + '
     + 
     + graph_git_behavior 'full graph, commit 8 vs merge 1' full commits/8 merge/1
     +@@ t/t5318-commit-graph.sh: test_expect_success 'write graph with nothing new' '
     + 	cd "$TRASH_DIRECTORY/full" &&
     + 	git commit-graph write &&
     + 	test_path_is_file $objdir/info/commit-graph &&
     +-	graph_read_expect "11" "extra_edges"
     ++	graph_read_expect "11" "generation_data extra_edges"
     + '
     + 
     + graph_git_behavior 'cleared graph, commit 8 vs merge 1' full commits/8 merge/1
     +@@ t/t5318-commit-graph.sh: test_expect_success 'build graph from latest pack with closure' '
     + 	cd "$TRASH_DIRECTORY/full" &&
     + 	cat new-idx | git commit-graph write --stdin-packs &&
     + 	test_path_is_file $objdir/info/commit-graph &&
     +-	graph_read_expect "9" "extra_edges"
     ++	graph_read_expect "9" "generation_data extra_edges"
     + '
     + 
     + graph_git_behavior 'graph from pack, commit 8 vs merge 1' full commits/8 merge/1
     +@@ t/t5318-commit-graph.sh: test_expect_success 'build graph from commits with closure' '
     + 	git rev-parse merge/1 >>commits-in &&
     + 	cat commits-in | git commit-graph write --stdin-commits &&
     + 	test_path_is_file $objdir/info/commit-graph &&
     +-	graph_read_expect "6"
     ++	graph_read_expect "6" "generation_data"
     + '
     + 
     + graph_git_behavior 'graph from commits, commit 8 vs merge 1' full commits/8 merge/1
     +@@ t/t5318-commit-graph.sh: test_expect_success 'build graph from commits with append' '
     + 	cd "$TRASH_DIRECTORY/full" &&
     + 	git rev-parse merge/3 | git commit-graph write --stdin-commits --append &&
     + 	test_path_is_file $objdir/info/commit-graph &&
     +-	graph_read_expect "10" "extra_edges"
     ++	graph_read_expect "10" "generation_data extra_edges"
     + '
     + 
     + graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merge/1
     +@@ t/t5318-commit-graph.sh: test_expect_success 'build graph using --reachable' '
     + 	cd "$TRASH_DIRECTORY/full" &&
     + 	git commit-graph write --reachable &&
     + 	test_path_is_file $objdir/info/commit-graph &&
     +-	graph_read_expect "11" "extra_edges"
     ++	graph_read_expect "11" "generation_data extra_edges"
     + '
     + 
     + graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merge/1
     +@@ t/t5318-commit-graph.sh: test_expect_success 'write graph in bare repo' '
     + 	cd "$TRASH_DIRECTORY/bare" &&
     + 	git commit-graph write &&
     + 	test_path_is_file $baredir/info/commit-graph &&
     +-	graph_read_expect "11" "extra_edges"
     ++	graph_read_expect "11" "generation_data extra_edges"
     + '
     + 
     + graph_git_behavior 'bare repo with graph, commit 8 vs merge 1' bare commits/8 merge/1
     +@@ t/t5318-commit-graph.sh: test_expect_success 'replace-objects invalidates commit-graph' '
     + 
     + test_expect_success 'git commit-graph verify' '
     + 	cd "$TRASH_DIRECTORY/full" &&
     +-	git rev-parse commits/8 | git commit-graph write --stdin-commits &&
     +-	git commit-graph verify >output
     ++	git rev-parse commits/8 | GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --stdin-commits &&
     ++	git commit-graph verify >output &&
     ++	graph_read_expect 9 extra_edges
     + '
     + 
     + NUM_COMMITS=9
      
       ## t/t5324-split-commit-graph.sh ##
      @@ t/t5324-split-commit-graph.sh: test_expect_success 'setup repo' '
     @@ t/t5324-split-commit-graph.sh: graph_read_expect() {
       	EOF
       	test-tool read-graph >output &&
       	test_cmp expect output
     +
     + ## t/t6600-test-reach.sh ##
     +@@ t/t6600-test-reach.sh: test_expect_success 'setup' '
     + 	git show-ref -s commit-5-5 | git commit-graph write --stdin-commits &&
     + 	mv .git/objects/info/commit-graph commit-graph-half &&
     + 	chmod u+w commit-graph-half &&
     ++	GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --reachable &&
     ++	mv .git/objects/info/commit-graph commit-graph-no-gdat &&
     ++	chmod u+w commit-graph-no-gdat &&
     + 	git config core.commitGraph true
     + '
     + 
     +-run_three_modes () {
     ++run_all_modes () {
     + 	test_when_finished rm -rf .git/objects/info/commit-graph &&
     + 	"$@" <input >actual &&
     + 	test_cmp expect actual &&
     +@@ t/t6600-test-reach.sh: run_three_modes () {
     + 	test_cmp expect actual &&
     + 	cp commit-graph-half .git/objects/info/commit-graph &&
     + 	"$@" <input >actual &&
     ++	test_cmp expect actual &&
     ++	cp commit-graph-no-gdat .git/objects/info/commit-graph &&
     ++	"$@" <input >actual &&
     + 	test_cmp expect actual
     + }
     + 
     +-test_three_modes () {
     +-	run_three_modes test-tool reach "$@"
     ++test_all_modes () {
     ++	run_all_modes test-tool reach "$@"
     + }
     + 
     + test_expect_success 'ref_newer:miss' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'ref_newer:miss' '
     + 	B:commit-4-9
     + 	EOF
     + 	echo "ref_newer(A,B):0" >expect &&
     +-	test_three_modes ref_newer
     ++	test_all_modes ref_newer
     + '
     + 
     + test_expect_success 'ref_newer:hit' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'ref_newer:hit' '
     + 	B:commit-2-3
     + 	EOF
     + 	echo "ref_newer(A,B):1" >expect &&
     +-	test_three_modes ref_newer
     ++	test_all_modes ref_newer
     + '
     + 
     + test_expect_success 'in_merge_bases:hit' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'in_merge_bases:hit' '
     + 	B:commit-8-8
     + 	EOF
     + 	echo "in_merge_bases(A,B):1" >expect &&
     +-	test_three_modes in_merge_bases
     ++	test_all_modes in_merge_bases
     + '
     + 
     + test_expect_success 'in_merge_bases:miss' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'in_merge_bases:miss' '
     + 	B:commit-5-9
     + 	EOF
     + 	echo "in_merge_bases(A,B):0" >expect &&
     +-	test_three_modes in_merge_bases
     ++	test_all_modes in_merge_bases
     + '
     + 
     + test_expect_success 'is_descendant_of:hit' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'is_descendant_of:hit' '
     + 	X:commit-1-1
     + 	EOF
     + 	echo "is_descendant_of(A,X):1" >expect &&
     +-	test_three_modes is_descendant_of
     ++	test_all_modes is_descendant_of
     + '
     + 
     + test_expect_success 'is_descendant_of:miss' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'is_descendant_of:miss' '
     + 	X:commit-7-6
     + 	EOF
     + 	echo "is_descendant_of(A,X):0" >expect &&
     +-	test_three_modes is_descendant_of
     ++	test_all_modes is_descendant_of
     + '
     + 
     + test_expect_success 'get_merge_bases_many' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many' '
     + 		git rev-parse commit-5-6 \
     + 			      commit-4-7 | sort
     + 	} >expect &&
     +-	test_three_modes get_merge_bases_many
     ++	test_all_modes get_merge_bases_many
     + '
     + 
     + test_expect_success 'reduce_heads' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'reduce_heads' '
     + 			      commit-2-8 \
     + 			      commit-1-10 | sort
     + 	} >expect &&
     +-	test_three_modes reduce_heads
     ++	test_all_modes reduce_heads
     + '
     + 
     + test_expect_success 'can_all_from_reach:hit' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'can_all_from_reach:hit' '
     + 	Y:commit-8-1
     + 	EOF
     + 	echo "can_all_from_reach(X,Y):1" >expect &&
     +-	test_three_modes can_all_from_reach
     ++	test_all_modes can_all_from_reach
     + '
     + 
     + test_expect_success 'can_all_from_reach:miss' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'can_all_from_reach:miss' '
     + 	Y:commit-8-5
     + 	EOF
     + 	echo "can_all_from_reach(X,Y):0" >expect &&
     +-	test_three_modes can_all_from_reach
     ++	test_all_modes can_all_from_reach
     + '
     + 
     + test_expect_success 'can_all_from_reach_with_flag: tags case' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'can_all_from_reach_with_flag: tags case' '
     + 	Y:commit-8-1
     + 	EOF
     + 	echo "can_all_from_reach_with_flag(X,_,_,0,0):1" >expect &&
     +-	test_three_modes can_all_from_reach_with_flag
     ++	test_all_modes can_all_from_reach_with_flag
     + '
     + 
     + test_expect_success 'commit_contains:hit' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'commit_contains:hit' '
     + 	X:commit-9-3
     + 	EOF
     + 	echo "commit_contains(_,A,X,_):1" >expect &&
     +-	test_three_modes commit_contains &&
     +-	test_three_modes commit_contains --tag
     ++	test_all_modes commit_contains &&
     ++	test_all_modes commit_contains --tag
     + '
     + 
     + test_expect_success 'commit_contains:miss' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'commit_contains:miss' '
     + 	X:commit-9-3
     + 	EOF
     + 	echo "commit_contains(_,A,X,_):0" >expect &&
     +-	test_three_modes commit_contains &&
     +-	test_three_modes commit_contains --tag
     ++	test_all_modes commit_contains &&
     ++	test_all_modes commit_contains --tag
     + '
     + 
     + test_expect_success 'rev-list: basic topo-order' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'rev-list: basic topo-order' '
     + 		commit-6-2 commit-5-2 commit-4-2 commit-3-2 commit-2-2 commit-1-2 \
     + 		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
     + 	>expect &&
     +-	run_three_modes git rev-list --topo-order commit-6-6
     ++	run_all_modes git rev-list --topo-order commit-6-6
     + '
     + 
     + test_expect_success 'rev-list: first-parent topo-order' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'rev-list: first-parent topo-order' '
     + 		commit-6-2 \
     + 		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
     + 	>expect &&
     +-	run_three_modes git rev-list --first-parent --topo-order commit-6-6
     ++	run_all_modes git rev-list --first-parent --topo-order commit-6-6
     + '
     + 
     + test_expect_success 'rev-list: range topo-order' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'rev-list: range topo-order' '
     + 		commit-6-2 commit-5-2 commit-4-2 \
     + 		commit-6-1 commit-5-1 commit-4-1 \
     + 	>expect &&
     +-	run_three_modes git rev-list --topo-order commit-3-3..commit-6-6
     ++	run_all_modes git rev-list --topo-order commit-3-3..commit-6-6
     + '
     + 
     + test_expect_success 'rev-list: range topo-order' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'rev-list: range topo-order' '
     + 		commit-6-2 commit-5-2 commit-4-2 \
     + 		commit-6-1 commit-5-1 commit-4-1 \
     + 	>expect &&
     +-	run_three_modes git rev-list --topo-order commit-3-8..commit-6-6
     ++	run_all_modes git rev-list --topo-order commit-3-8..commit-6-6
     + '
     + 
     + test_expect_success 'rev-list: first-parent range topo-order' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'rev-list: first-parent range topo-order' '
     + 		commit-6-2 \
     + 		commit-6-1 commit-5-1 commit-4-1 \
     + 	>expect &&
     +-	run_three_modes git rev-list --first-parent --topo-order commit-3-8..commit-6-6
     ++	run_all_modes git rev-list --first-parent --topo-order commit-3-8..commit-6-6
     + '
     + 
     + test_expect_success 'rev-list: ancestry-path topo-order' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'rev-list: ancestry-path topo-order' '
     + 		commit-6-4 commit-5-4 commit-4-4 commit-3-4 \
     + 		commit-6-3 commit-5-3 commit-4-3 \
     + 	>expect &&
     +-	run_three_modes git rev-list --topo-order --ancestry-path commit-3-3..commit-6-6
     ++	run_all_modes git rev-list --topo-order --ancestry-path commit-3-3..commit-6-6
     + '
     + 
     + test_expect_success 'rev-list: symmetric difference topo-order' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'rev-list: symmetric difference topo-order' '
     + 		commit-3-8 commit-2-8 commit-1-8 \
     + 		commit-3-7 commit-2-7 commit-1-7 \
     + 	>expect &&
     +-	run_three_modes git rev-list --topo-order commit-3-8...commit-6-6
     ++	run_all_modes git rev-list --topo-order commit-3-8...commit-6-6
     + '
     + 
     + test_expect_success 'get_reachable_subset:all' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'get_reachable_subset:all' '
     + 			      commit-1-7 \
     + 			      commit-5-6 | sort
     + 	) >expect &&
     +-	test_three_modes get_reachable_subset
     ++	test_all_modes get_reachable_subset
     + '
     + 
     + test_expect_success 'get_reachable_subset:some' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'get_reachable_subset:some' '
     + 		git rev-parse commit-3-3 \
     + 			      commit-1-7 | sort
     + 	) >expect &&
     +-	test_three_modes get_reachable_subset
     ++	test_all_modes get_reachable_subset
     + '
     + 
     + test_expect_success 'get_reachable_subset:none' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'get_reachable_subset:none' '
     + 	Y:commit-2-8
     + 	EOF
     + 	echo "get_reachable_subset(X,Y)" >expect &&
     +-	test_three_modes get_reachable_subset
     ++	test_all_modes get_reachable_subset
     + '
     + 
     + test_done
  6:  647290d036 !  6:  1aa2a00a7a commit-graph: implement corrected commit date offset
     @@ Metadata
      Author: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
       ## Commit message ##
     -    commit-graph: implement corrected commit date offset
     +    commit-graph: return 64-bit generation number
      
     -    With preparations done, let's implement corrected commit date offset.
     -    We add a new commit-slab to store topological levels while writing
     -    commit graph and upgrade number of struct commit_graph_data to 64-bits.
     -
     -    We have to touch many files, upgrading generation number from uint32_t
     -    to timestamp_t.
     -
     -    We drop 'detect incorrect generation number' from t5318-commit-graph.sh,
     -    which tests if verify can detect if a commit graph have
     -    GENERATION_NUMBER_ZERO for a commit, followed by a non-zero generation.
     -    With corrected commit dates, GENERATION_NUMBER_ZERO is possible only if
     -    one of dates is Unix epoch zero.
     +    In a preparatory step, let's return timestamp_t values from
     +    commit_graph_generation(), use timestamp_t for local variables and
     +    define GENERATION_NUMBER_INFINITY as (2 ^ 63 - 1) instead.
      
          Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
     - ## blame.c ##
     -@@ blame.c: static int maybe_changed_path(struct repository *r,
     - 	if (!bd)
     - 		return 1;
     - 
     --	if (commit_graph_generation(origin->commit) == GENERATION_NUMBER_INFINITY)
     -+	if (commit_graph_generation(origin->commit) == GENERATION_NUMBER_V2_INFINITY)
     - 		return 1;
     - 
     - 	filter = get_bloom_filter(r, origin->commit, 0);
     -
       ## commit-graph.c ##
     -@@ commit-graph.c: void git_test_write_commit_graph_or_die(void)
     - /* Remember to update object flag allocation in object.h */
     - #define REACHABLE       (1u<<15)
     - 
     -+define_commit_slab(topo_level_slab, uint32_t);
     -+
     - /* Keep track of the order in which commits are added to our list. */
     - define_commit_slab(commit_pos, int);
     - static struct commit_pos commit_pos = COMMIT_SLAB_INIT(1, commit_pos);
      @@ commit-graph.c: uint32_t commit_graph_position(const struct commit *c)
       	return data ? data->graph_pos : COMMIT_NOT_FROM_GRAPH;
       }
     @@ commit-graph.c: uint32_t commit_graph_position(const struct commit *c)
       {
       	struct commit_graph_data *data =
       		commit_graph_data_slab_peek(&commit_graph_data_slab, c);
     - 
     - 	if (!data)
     --		return GENERATION_NUMBER_INFINITY;
     -+		return GENERATION_NUMBER_V2_INFINITY;
     - 	else if (data->graph_pos == COMMIT_NOT_FROM_GRAPH)
     --		return GENERATION_NUMBER_INFINITY;
     -+		return GENERATION_NUMBER_V2_INFINITY;
     - 
     - 	return data->generation;
     - }
      @@ commit-graph.c: uint32_t commit_graph_generation(const struct commit *c)
       int compare_commits_by_gen(const void *_a, const void *_b)
       {
     @@ commit-graph.c: static int commit_gen_cmp(const void *va, const void *vb)
       
      -	uint32_t generation_a = commit_graph_data_at(a)->generation;
      -	uint32_t generation_b = commit_graph_data_at(b)->generation;
     -+	timestamp_t generation_a = commit_graph_data_at(a)->generation;
     -+	timestamp_t generation_b = commit_graph_data_at(b)->generation;
     - 
     ++	const timestamp_t generation_a = commit_graph_data_at(a)->generation;
     ++	const timestamp_t generation_b = commit_graph_data_at(b)->generation;
       	/* lower generation commits first */
       	if (generation_a < generation_b)
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
     -@@ commit-graph.c: static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
     - 	item->date = (timestamp_t)((date_high << 32) | date_low);
     - 
     - 	if (g->chunk_generation_data)
     --		graph_data->generation = get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
     -+	{
     -+		/* Read corrected commit date offset from GDAT */
     -+		graph_data->generation = item->date +
     -+			(timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
     -+	}
     - 	else
     -+		/* Read topological level from CDAT */
     - 		graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
     - }
     - 
     -@@ commit-graph.c: struct write_commit_graph_context {
     - 	struct progress *progress;
     - 	int progress_done;
     - 	uint64_t progress_cnt;
     -+	struct topo_level_slab *topo_levels;
     - 
     - 	char *base_graph_name;
     - 	int num_commit_graphs_before;
     -@@ commit-graph.c: static void write_graph_chunk_data(struct hashfile *f, int hash_len,
     - 		else
     - 			packedDate[0] = 0;
     - 
     --		packedDate[0] |= htonl(commit_graph_data_at(*list)->generation << 2);
     -+		packedDate[0] |= htonl(*topo_level_slab_at(ctx->topo_levels, *list) << 2);
     - 
     - 		packedDate[1] = htonl((*list)->date);
     - 		hashwrite(f, packedDate, 8);
     -@@ commit-graph.c: static void write_graph_chunk_generation_data(struct hashfile *f,
     - 	struct commit **list = ctx->commits.list;
     - 	int count;
     - 	for (count = 0; count < ctx->commits.nr; count++, list++) {
     -+		timestamp_t offset = commit_graph_data_at(*list)->generation - (*list)->date;
     - 		display_progress(ctx->progress, ++ctx->progress_cnt);
     --		hashwrite_be32(f, commit_graph_data_at(*list)->generation);
     -+
     -+		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX)
     -+			offset = GENERATION_NUMBER_V2_OFFSET_MAX;
     -+
     -+		hashwrite_be32(f, offset);
     - 	}
     - }
     - 
     -@@ commit-graph.c: static void close_reachable(struct write_commit_graph_context *ctx)
     - 	stop_progress(&ctx->progress);
     - }
     - 
     --static void compute_generation_numbers(struct write_commit_graph_context *ctx)
     -+static void compute_corrected_commit_date_offsets(struct write_commit_graph_context *ctx)
     - {
     - 	int i;
     - 	struct commit_list *list = NULL;
     + 		return -1;
      @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph_context *ctx)
     - 					_("Computing commit graph generation numbers"),
     - 					ctx->commits.nr);
     - 	for (i = 0; i < ctx->commits.nr; i++) {
     --		uint32_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
     -+		uint32_t topo_level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
     + 		uint32_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
       
       		display_progress(ctx->progress, i + 1);
      -		if (generation != GENERATION_NUMBER_INFINITY &&
     --		    generation != GENERATION_NUMBER_ZERO)
     -+		if (topo_level != GENERATION_NUMBER_INFINITY &&
     -+		    topo_level != GENERATION_NUMBER_ZERO)
     ++		if (generation != GENERATION_NUMBER_V1_INFINITY &&
     + 		    generation != GENERATION_NUMBER_ZERO)
       			continue;
       
     - 		commit_list_insert(ctx->commits.list[i], &list);
      @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph_context *ctx)
     - 			struct commit *current = list->item;
     - 			struct commit_list *parent;
     - 			int all_parents_computed = 1;
     --			uint32_t max_generation = 0;
     -+			uint32_t max_level = 0;
     -+			timestamp_t max_corrected_commit_date = current->date;
     - 
       			for (parent = current->parents; parent; parent = parent->next) {
     --				generation = commit_graph_data_at(parent->item)->generation;
     -+				topo_level = *topo_level_slab_at(ctx->topo_levels, parent->item);
     + 				generation = commit_graph_data_at(parent->item)->generation;
       
      -				if (generation == GENERATION_NUMBER_INFINITY ||
     --				    generation == GENERATION_NUMBER_ZERO) {
     -+				if (topo_level == GENERATION_NUMBER_INFINITY ||
     -+				    topo_level == GENERATION_NUMBER_ZERO) {
     ++				if (generation == GENERATION_NUMBER_V1_INFINITY ||
     + 				    generation == GENERATION_NUMBER_ZERO) {
       					all_parents_computed = 0;
       					commit_list_insert(parent->item, &list);
     - 					break;
     --				} else if (generation > max_generation) {
     --					max_generation = generation;
     -+				} else {
     -+					struct commit_graph_data *data = commit_graph_data_at(parent->item);
     -+
     -+					if (topo_level > max_level)
     -+						max_level = topo_level;
     -+
     -+					if (data->generation > max_corrected_commit_date)
     -+						max_corrected_commit_date = data->generation;
     - 				}
     - 			}
     - 
     - 			if (all_parents_computed) {
     - 				struct commit_graph_data *data = commit_graph_data_at(current);
     - 
     --				data->generation = max_generation + 1;
     --				pop_commit(&list);
     -+				if (max_level > GENERATION_NUMBER_MAX - 1)
     -+					max_level = GENERATION_NUMBER_MAX - 1;
     -+
     -+				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
     -+				data->generation = max_corrected_commit_date + 1;
     - 
     --				if (data->generation > GENERATION_NUMBER_MAX)
     --					data->generation = GENERATION_NUMBER_MAX;
     -+				pop_commit(&list);
     - 			}
     - 		}
     - 	}
     -@@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
     - 	uint32_t i, count_distinct = 0;
     - 	int res = 0;
     - 	int replace = 0;
     -+	struct topo_level_slab topo_levels;
     - 
     - 	if (!commit_graph_compatible(the_repository))
     - 		return 0;
     -@@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
     - 	ctx->changed_paths = flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS ? 1 : 0;
     - 	ctx->total_bloom_filter_data_size = 0;
     - 
     -+	init_topo_level_slab(&topo_levels);
     -+	ctx->topo_levels = &topo_levels;
     -+
     - 	if (ctx->split) {
     - 		struct commit_graph *g;
     - 		prepare_commit_graph(ctx->r);
     -@@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
     - 	} else
     - 		ctx->num_commit_graphs_after = 1;
     - 
     --	compute_generation_numbers(ctx);
     -+	compute_corrected_commit_date_offsets(ctx);
     - 
     - 	if (ctx->changed_paths)
     - 		compute_bloom_filters(ctx);
      @@ commit-graph.c: int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
       	for (i = 0; i < g->num_commits; i++) {
       		struct commit *graph_commit, *odb_commit;
       		struct commit_list *graph_parents, *odb_parents;
      -		uint32_t max_generation = 0;
      -		uint32_t generation;
     -+		timestamp_t max_parent_corrected_commit_date = 0;
     -+		timestamp_t corrected_commit_date;
     ++		timestamp_t max_generation = 0;
     ++		timestamp_t generation;
       
       		display_progress(progress, i + 1);
       		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
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
     - 
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
      
       ## commit-graph.h ##
      @@ commit-graph.h: void disable_commit_graph(struct repository *r);
     @@ commit-reach.c: static int queue_has_nonstale(struct prio_queue *queue)
       	struct commit_list *result = NULL;
       	int i;
      -	uint32_t last_gen = GENERATION_NUMBER_INFINITY;
     -+	timestamp_t last_gen = GENERATION_NUMBER_V2_INFINITY;
     ++	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
       
       	if (!min_generation)
       		queue.compare = compare_commits_by_commit_date;
     @@ commit-reach.c: int repo_in_merge_bases_many(struct repository *r, struct commit
       	struct commit_list *bases;
       	int ret = 0, i;
      -	uint32_t generation, min_generation = GENERATION_NUMBER_INFINITY;
     -+	timestamp_t generation, min_generation = GENERATION_NUMBER_V2_INFINITY;
     ++	timestamp_t generation, min_generation = GENERATION_NUMBER_INFINITY;
       
       	if (repo_parse_commit(r, commit))
       		return ret;
     @@ commit-reach.c: static enum contains_result contains_tag_algo(struct commit *can
       	struct contains_stack contains_stack = { 0, 0, NULL };
       	enum contains_result result;
      -	uint32_t cutoff = GENERATION_NUMBER_INFINITY;
     -+	timestamp_t cutoff = GENERATION_NUMBER_V2_INFINITY;
     ++	timestamp_t cutoff = GENERATION_NUMBER_INFINITY;
       	const struct commit_list *p;
       
       	for (p = want; p; p = p->next) {
     @@ commit-reach.c: int can_all_from_reach(struct commit_list *from, struct commit_l
       	struct commit_list *from_iter = from, *to_iter = to;
       	int result;
      -	uint32_t min_generation = GENERATION_NUMBER_INFINITY;
     -+	timestamp_t min_generation = GENERATION_NUMBER_V2_INFINITY;
     ++	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
       
       	while (from_iter) {
       		add_object_array(&from_iter->item->object, NULL, &from_objs);
     @@ commit-reach.c: struct commit_list *get_reachable_subset(struct commit **from, i
       	struct commit **to_last = to + nr_to;
       	struct commit **from_last = from + nr_from;
      -	uint32_t min_generation = GENERATION_NUMBER_INFINITY;
     -+	timestamp_t min_generation = GENERATION_NUMBER_V2_INFINITY;
     ++	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
       	int num_to_find = 0;
       
       	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
     @@ commit-reach.h: int can_all_from_reach_with_flag(struct object_array *from,
      
       ## commit.h ##
      @@
     + #include "commit-slab.h"
     + 
     + #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
     +-#define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
     ++#define GENERATION_NUMBER_INFINITY ((1ULL << 63) - 1)
     ++#define GENERATION_NUMBER_V1_INFINITY 0xFFFFFFFF
       #define GENERATION_NUMBER_MAX 0x3FFFFFFF
       #define GENERATION_NUMBER_ZERO 0
       
     -+#define GENERATION_NUMBER_V2_INFINITY ((1ULL << 63) - 1)
     -+#define GENERATION_NUMBER_V2_OFFSET_MAX 0xFFFFFFFF
     -+
     - struct commit_list {
     - 	struct commit *item;
     - 	struct commit_list *next;
      
       ## revision.c ##
     -@@ revision.c: static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
     - 	if (!revs->repo->objects->commit_graph)
     - 		return -1;
     - 
     --	if (commit_graph_generation(commit) == GENERATION_NUMBER_INFINITY)
     -+	if (commit_graph_generation(commit) == GENERATION_NUMBER_V2_INFINITY)
     - 		return -1;
     - 
     - 	filter = get_bloom_filter(revs->repo, commit, 0);
      @@ revision.c: define_commit_slab(indegree_slab, int);
       define_commit_slab(author_date_slab, timestamp_t);
       
     @@ revision.c: static void indegree_walk_step(struct rev_info *revs)
       	struct topo_walk_info *info = revs->topo_walk_info;
       	struct commit *c;
      @@ revision.c: static void init_topo_walk(struct rev_info *revs)
     - 	info->explore_queue.compare = compare_commits_by_gen_then_commit_date;
     - 	info->indegree_queue.compare = compare_commits_by_gen_then_commit_date;
     - 
     --	info->min_generation = GENERATION_NUMBER_INFINITY;
     -+	info->min_generation = GENERATION_NUMBER_V2_INFINITY;
     + 	info->min_generation = GENERATION_NUMBER_INFINITY;
       	for (list = revs->commits; list; list = list->next) {
       		struct commit *c = list->item;
      -		uint32_t generation;
     @@ revision.c: static void expand_topo_walk(struct rev_info *revs, struct commit *c
       		if (parent->object.flags & UNINTERESTING)
       			continue;
      
     - ## t/t5318-commit-graph.sh ##
     -@@ t/t5318-commit-graph.sh: test_expect_success 'detect incorrect generation number' '
     - 		"generation for commit"
     - '
     - 
     --test_expect_success 'detect incorrect generation number' '
     -+test_expect_failure 'detect incorrect generation number' '
     - 	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\00" \
     - 		"non-zero generation number"
     - '
     -
       ## upload-pack.c ##
      @@ upload-pack.c: static int got_oid(struct upload_pack_data *data,
       
  -:  ---------- >  7:  bfe1473201 commit-graph: implement corrected commit date
  -:  ---------- >  8:  833779ad53 commit-graph: handle mixed generation commit chains
  -:  ---------- >  9:  58a2d5da01 commit-reach: use corrected commit dates in paint_down_to_common()
  -:  ---------- > 10:  4c34294602 doc: add corrected commit date info

-- 
gitgitgadget
