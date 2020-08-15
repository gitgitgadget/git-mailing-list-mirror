Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFF2C433DF
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9ABD23447
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLBg1qEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgHOWAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbgHOVvg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:36 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F25C0A3BF4
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:39:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g8so9878901wmk.3
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=DHDhFjl1hDkzjQZSWcMqXTXs/ruIOAbqHvg+QbxqMK4=;
        b=rLBg1qEWlyjVt7eQUa4HIY+GdqBgqjeOXrsQ6ctVd+rB7f9I8DAH0VYg0j71fgPl4X
         FjuhFobmyWxkkIPuQYTBqsXPkW8s9Kj/u3QXr887LUjwdfeDHZzWsbqjYXSUoj2fpIuf
         SicbX4tTq8quvYi7bvg/VBzZDiO/8q5xEbTE4Ylkeckog3Z4jz4OqFgX8rFOHhSNpgS7
         9X5h7gKdt9CPE2fp3RXra+1CBD28M7M2WrXu6CLmahYzZdCqmGZfOysgl6Ga/0SE2UYL
         IL8aRmLreWphe9ZiJPxAihZnS1VVbk2sTWZCmWcM+cYTmIU7ph6O5uLTbUfTqmh+bC5s
         qe+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=DHDhFjl1hDkzjQZSWcMqXTXs/ruIOAbqHvg+QbxqMK4=;
        b=Q8S4YMR8sLlXXGp/MGekLwJH0Hb3clttplvyV2p1ywzaMYEupwusbqepO+H6xkeRHB
         ZtDSzXix+pHFULR1fNVhsGLLGNgJegi2zhvgG16EMgcaaIyXhIofug4f5WIoe4zlGaLe
         REcGgmkicDigYSXBXaZGaUu7bjxrz3sFz/+1LJg4cn8rNPDwUCF/3pcdlbtEVSqUiqjy
         eN3ueHKL0iY1FEBZw7KWPbRvr7bj9duS7rLCPiypNjqmkx1gSHU+SHeDwn4/ePYcUikV
         18RQKd4nB9y4r/y+ItnmJYcILP2xwkeZ5WBoneczPvpd7gOYFQO9PtquQTfTEwshK9VC
         zJQQ==
X-Gm-Message-State: AOAM531uxTym76GOPkHQUVIPEc/CFXsdXap7ZOO9Nki8NX0JiMQNzem5
        iEzTmFrsGKhy46PpYrf2c8FpGBaxO3Y=
X-Google-Smtp-Source: ABdhPJwEkK4eR8/RhkdECBcNiXA+OiCZAtnZe1F3k+5U7WR/1dyCIS0Gxrl40vZVDW/NYM6m8opX6Q==
X-Received: by 2002:a1c:c913:: with SMTP id f19mr7105658wmb.173.1597509591968;
        Sat, 15 Aug 2020 09:39:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o2sm25247087wrh.70.2020.08.15.09.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 09:39:51 -0700 (PDT)
Message-Id: <4e746628acdb49af5e8eb788864156f54724d4fa.1597509583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Aug 2020 16:39:40 +0000
Subject: [PATCH v3 08/11] commit-graph: implement generation data chunk
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
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

As discovered by Ævar, we cannot increment graph version to
distinguish between generation numbers v1 and v2 [1]. Thus, one of
pre-requistes before implementing generation number was to distinguish
between graph versions in a backwards compatible manner.

We are going to introduce a new chunk called Generation Data chunk (or
GDAT). GDAT stores generation number v2 (and any subsequent versions),
whereas CDAT will still store topological level.

Old Git does not understand GDAT chunk and would ignore it, reading
topological levels from CDAT. New Git can parse GDAT and take advantage
of newer generation numbers, falling back to topological levels when
GDAT chunk is missing (as it would happen with a commit graph written
by old Git).

We introduce a test environment variable 'GIT_TEST_COMMIT_GRAPH_NO_GDAT'
which forces commit-graph file to be written without generation data
chunk to emulate a commit-graph file written by old Git.

[1]: https://lore.kernel.org/git/87a7gdspo4.fsf@evledraar.gmail.com/

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c                | 48 ++++++++++++++++++++++++---
 commit-graph.h                |  2 ++
 t/README                      |  3 ++
 t/helper/test-read-graph.c    |  2 ++
 t/t4216-log-bloom.sh          |  4 +--
 t/t5318-commit-graph.sh       | 27 +++++++--------
 t/t5324-split-commit-graph.sh | 12 +++----
 t/t6600-test-reach.sh         | 62 +++++++++++++++++++----------------
 8 files changed, 107 insertions(+), 53 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index fd69534dd5..b7a72b40db 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -38,11 +38,12 @@ void git_test_write_commit_graph_or_die(void)
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
 #define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
 #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
+#define GRAPH_CHUNKID_GENERATION_DATA 0x47444154 /* "GDAT" */
 #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
 #define GRAPH_CHUNKID_BLOOMINDEXES 0x42494458 /* "BIDX" */
 #define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
 #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
-#define MAX_NUM_CHUNKS 7
+#define MAX_NUM_CHUNKS 8
 
 #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
 
@@ -389,6 +390,13 @@ struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size)
 				graph->chunk_commit_data = data + chunk_offset;
 			break;
 
+		case GRAPH_CHUNKID_GENERATION_DATA:
+			if (graph->chunk_generation_data)
+				chunk_repeated = 1;
+			else
+				graph->chunk_generation_data = data + chunk_offset;
+			break;
+
 		case GRAPH_CHUNKID_EXTRAEDGES:
 			if (graph->chunk_extra_edges)
 				chunk_repeated = 1;
@@ -755,7 +763,11 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	date_low = get_be32(commit_data + g->hash_len + 12);
 	item->date = (timestamp_t)((date_high << 32) | date_low);
 
-	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
+	if (g->chunk_generation_data)
+		graph_data->generation = item->date +
+			(timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
+	else
+		graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
 
 	if (g->topo_levels)
 		*topo_level_slab_at(g->topo_levels, item) = get_be32(commit_data + g->hash_len + 8) >> 2;
@@ -951,7 +963,8 @@ struct write_commit_graph_context {
 		 report_progress:1,
 		 split:1,
 		 changed_paths:1,
-		 order_by_pack:1;
+		 order_by_pack:1,
+		 write_generation_data:1;
 
 	struct topo_level_slab *topo_levels;
 	const struct split_commit_graph_opts *split_opts;
@@ -1106,8 +1119,25 @@ static int write_graph_chunk_data(struct hashfile *f,
 	return 0;
 }
 
+static int write_graph_chunk_generation_data(struct hashfile *f,
+					      struct write_commit_graph_context *ctx)
+{
+	int i;
+	for (i = 0; i < ctx->commits.nr; i++) {
+		struct commit *c = ctx->commits.list[i];
+		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
+		display_progress(ctx->progress, ++ctx->progress_cnt);
+
+		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX)
+			offset = GENERATION_NUMBER_V2_OFFSET_MAX;
+		hashwrite_be32(f, offset);
+	}
+
+	return 0;
+}
+
 static int write_graph_chunk_extra_edges(struct hashfile *f,
-					 struct write_commit_graph_context *ctx)
+					  struct write_commit_graph_context *ctx)
 {
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
@@ -1726,6 +1756,15 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	chunks[2].id = GRAPH_CHUNKID_DATA;
 	chunks[2].size = (hashsz + 16) * ctx->commits.nr;
 	chunks[2].write_fn = write_graph_chunk_data;
+
+	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_NO_GDAT, 0))
+		ctx->write_generation_data = 0;
+	if (ctx->write_generation_data) {
+		chunks[num_chunks].id = GRAPH_CHUNKID_GENERATION_DATA;
+		chunks[num_chunks].size = sizeof(uint32_t) * ctx->commits.nr;
+		chunks[num_chunks].write_fn = write_graph_chunk_generation_data;
+		num_chunks++;
+	}
 	if (ctx->num_extra_edges) {
 		chunks[num_chunks].id = GRAPH_CHUNKID_EXTRAEDGES;
 		chunks[num_chunks].size = 4 * ctx->num_extra_edges;
@@ -2130,6 +2169,7 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
 	ctx->split_opts = split_opts;
 	ctx->total_bloom_filter_data_size = 0;
+	ctx->write_generation_data = 1;
 
 	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
 		ctx->changed_paths = 1;
diff --git a/commit-graph.h b/commit-graph.h
index 1152a9642e..f78c892fc0 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -6,6 +6,7 @@
 #include "oidset.h"
 
 #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
+#define GIT_TEST_COMMIT_GRAPH_NO_GDAT "GIT_TEST_COMMIT_GRAPH_NO_GDAT"
 #define GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE "GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE"
 #define GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS "GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS"
 
@@ -67,6 +68,7 @@ struct commit_graph {
 	const uint32_t *chunk_oid_fanout;
 	const unsigned char *chunk_oid_lookup;
 	const unsigned char *chunk_commit_data;
+	const unsigned char *chunk_generation_data;
 	const unsigned char *chunk_extra_edges;
 	const unsigned char *chunk_base_graphs;
 	const unsigned char *chunk_bloom_indexes;
diff --git a/t/README b/t/README
index 70ec61cf88..6647ef132e 100644
--- a/t/README
+++ b/t/README
@@ -379,6 +379,9 @@ GIT_TEST_COMMIT_GRAPH=<boolean>, when true, forces the commit-graph to
 be written after every 'git commit' command, and overrides the
 'core.commitGraph' setting to true.
 
+GIT_TEST_COMMIT_GRAPH_NO_GDAT=<boolean>, when true, forces the
+commit-graph to be written without generation data chunk.
+
 GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=<boolean>, when true, forces
 commit-graph write to compute and write changed path Bloom filters for
 every 'git commit-graph write', as if the `--changed-paths` option was
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 6d0c962438..1c2a5366c7 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -32,6 +32,8 @@ int cmd__read_graph(int argc, const char **argv)
 		printf(" oid_lookup");
 	if (graph->chunk_commit_data)
 		printf(" commit_metadata");
+	if (graph->chunk_generation_data)
+		printf(" generation_data");
 	if (graph->chunk_extra_edges)
 		printf(" extra_edges");
 	if (graph->chunk_bloom_indexes)
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index c21cc160f3..55c94e9ebd 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -33,11 +33,11 @@ test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
 	git commit-graph write --reachable --changed-paths
 '
 graph_read_expect () {
-	NUM_CHUNKS=5
+	NUM_CHUNKS=6
 	cat >expect <<- EOF
 	header: 43475048 1 1 $NUM_CHUNKS 0
 	num_commits: $1
-	chunks: oid_fanout oid_lookup commit_metadata bloom_indexes bloom_data
+	chunks: oid_fanout oid_lookup commit_metadata generation_data bloom_indexes bloom_data
 	EOF
 	test-tool read-graph >actual &&
 	test_cmp expect actual
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 044cf8a3de..b41b2160c6 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -71,7 +71,7 @@ graph_git_behavior 'no graph' full commits/3 commits/1
 graph_read_expect() {
 	OPTIONAL=""
 	NUM_CHUNKS=3
-	if test ! -z $2
+	if test ! -z "$2"
 	then
 		OPTIONAL=" $2"
 		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
@@ -98,14 +98,14 @@ test_expect_success 'exit with correct error on bad input to --stdin-commits' '
 	# valid commit and tree OID
 	git rev-parse HEAD HEAD^{tree} >in &&
 	git commit-graph write --stdin-commits <in &&
-	graph_read_expect 3
+	graph_read_expect 3 generation_data
 '
 
 test_expect_success 'write graph' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write &&
 	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "3"
+	graph_read_expect "3" generation_data
 '
 
 test_expect_success POSIXPERM 'write graph has correct permissions' '
@@ -214,7 +214,7 @@ test_expect_success 'write graph with merges' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write &&
 	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "10" "extra_edges"
+	graph_read_expect "10" "generation_data extra_edges"
 '
 
 graph_git_behavior 'merge 1 vs 2' full merge/1 merge/2
@@ -249,7 +249,7 @@ test_expect_success 'write graph with new commit' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write &&
 	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "11" "extra_edges"
+	graph_read_expect "11" "generation_data extra_edges"
 '
 
 graph_git_behavior 'full graph, commit 8 vs merge 1' full commits/8 merge/1
@@ -259,7 +259,7 @@ test_expect_success 'write graph with nothing new' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write &&
 	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "11" "extra_edges"
+	graph_read_expect "11" "generation_data extra_edges"
 '
 
 graph_git_behavior 'cleared graph, commit 8 vs merge 1' full commits/8 merge/1
@@ -269,7 +269,7 @@ test_expect_success 'build graph from latest pack with closure' '
 	cd "$TRASH_DIRECTORY/full" &&
 	cat new-idx | git commit-graph write --stdin-packs &&
 	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "9" "extra_edges"
+	graph_read_expect "9" "generation_data extra_edges"
 '
 
 graph_git_behavior 'graph from pack, commit 8 vs merge 1' full commits/8 merge/1
@@ -282,7 +282,7 @@ test_expect_success 'build graph from commits with closure' '
 	git rev-parse merge/1 >>commits-in &&
 	cat commits-in | git commit-graph write --stdin-commits &&
 	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "6"
+	graph_read_expect "6" "generation_data"
 '
 
 graph_git_behavior 'graph from commits, commit 8 vs merge 1' full commits/8 merge/1
@@ -292,7 +292,7 @@ test_expect_success 'build graph from commits with append' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git rev-parse merge/3 | git commit-graph write --stdin-commits --append &&
 	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "10" "extra_edges"
+	graph_read_expect "10" "generation_data extra_edges"
 '
 
 graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merge/1
@@ -302,7 +302,7 @@ test_expect_success 'build graph using --reachable' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write --reachable &&
 	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "11" "extra_edges"
+	graph_read_expect "11" "generation_data extra_edges"
 '
 
 graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merge/1
@@ -323,7 +323,7 @@ test_expect_success 'write graph in bare repo' '
 	cd "$TRASH_DIRECTORY/bare" &&
 	git commit-graph write &&
 	test_path_is_file $baredir/info/commit-graph &&
-	graph_read_expect "11" "extra_edges"
+	graph_read_expect "11" "generation_data extra_edges"
 '
 
 graph_git_behavior 'bare repo with graph, commit 8 vs merge 1' bare commits/8 merge/1
@@ -420,8 +420,9 @@ test_expect_success 'replace-objects invalidates commit-graph' '
 
 test_expect_success 'git commit-graph verify' '
 	cd "$TRASH_DIRECTORY/full" &&
-	git rev-parse commits/8 | git commit-graph write --stdin-commits &&
-	git commit-graph verify >output
+	git rev-parse commits/8 | GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --stdin-commits &&
+	git commit-graph verify >output &&
+	graph_read_expect 9 extra_edges
 '
 
 NUM_COMMITS=9
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index ea28d522b8..531016f405 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -13,11 +13,11 @@ test_expect_success 'setup repo' '
 	infodir=".git/objects/info" &&
 	graphdir="$infodir/commit-graphs" &&
 	test_oid_cache <<-EOM
-	shallow sha1:1760
-	shallow sha256:2064
+	shallow sha1:2132
+	shallow sha256:2436
 
-	base sha1:1376
-	base sha256:1496
+	base sha1:1408
+	base sha256:1528
 	EOM
 '
 
@@ -28,9 +28,9 @@ graph_read_expect() {
 		NUM_BASE=$2
 	fi
 	cat >expect <<- EOF
-	header: 43475048 1 1 3 $NUM_BASE
+	header: 43475048 1 1 4 $NUM_BASE
 	num_commits: $1
-	chunks: oid_fanout oid_lookup commit_metadata
+	chunks: oid_fanout oid_lookup commit_metadata generation_data
 	EOF
 	test-tool read-graph >output &&
 	test_cmp expect output
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 475564bee7..d14b129f06 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -55,10 +55,13 @@ test_expect_success 'setup' '
 	git show-ref -s commit-5-5 | git commit-graph write --stdin-commits &&
 	mv .git/objects/info/commit-graph commit-graph-half &&
 	chmod u+w commit-graph-half &&
+	GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --reachable &&
+	mv .git/objects/info/commit-graph commit-graph-no-gdat &&
+	chmod u+w commit-graph-no-gdat &&
 	git config core.commitGraph true
 '
 
-run_three_modes () {
+run_all_modes () {
 	test_when_finished rm -rf .git/objects/info/commit-graph &&
 	"$@" <input >actual &&
 	test_cmp expect actual &&
@@ -67,11 +70,14 @@ run_three_modes () {
 	test_cmp expect actual &&
 	cp commit-graph-half .git/objects/info/commit-graph &&
 	"$@" <input >actual &&
+	test_cmp expect actual &&
+	cp commit-graph-no-gdat .git/objects/info/commit-graph &&
+	"$@" <input >actual &&
 	test_cmp expect actual
 }
 
-test_three_modes () {
-	run_three_modes test-tool reach "$@"
+test_all_modes () {
+	run_all_modes test-tool reach "$@"
 }
 
 test_expect_success 'ref_newer:miss' '
@@ -80,7 +86,7 @@ test_expect_success 'ref_newer:miss' '
 	B:commit-4-9
 	EOF
 	echo "ref_newer(A,B):0" >expect &&
-	test_three_modes ref_newer
+	test_all_modes ref_newer
 '
 
 test_expect_success 'ref_newer:hit' '
@@ -89,7 +95,7 @@ test_expect_success 'ref_newer:hit' '
 	B:commit-2-3
 	EOF
 	echo "ref_newer(A,B):1" >expect &&
-	test_three_modes ref_newer
+	test_all_modes ref_newer
 '
 
 test_expect_success 'in_merge_bases:hit' '
@@ -98,7 +104,7 @@ test_expect_success 'in_merge_bases:hit' '
 	B:commit-8-8
 	EOF
 	echo "in_merge_bases(A,B):1" >expect &&
-	test_three_modes in_merge_bases
+	test_all_modes in_merge_bases
 '
 
 test_expect_success 'in_merge_bases:miss' '
@@ -107,7 +113,7 @@ test_expect_success 'in_merge_bases:miss' '
 	B:commit-5-9
 	EOF
 	echo "in_merge_bases(A,B):0" >expect &&
-	test_three_modes in_merge_bases
+	test_all_modes in_merge_bases
 '
 
 test_expect_success 'is_descendant_of:hit' '
@@ -118,7 +124,7 @@ test_expect_success 'is_descendant_of:hit' '
 	X:commit-1-1
 	EOF
 	echo "is_descendant_of(A,X):1" >expect &&
-	test_three_modes is_descendant_of
+	test_all_modes is_descendant_of
 '
 
 test_expect_success 'is_descendant_of:miss' '
@@ -129,7 +135,7 @@ test_expect_success 'is_descendant_of:miss' '
 	X:commit-7-6
 	EOF
 	echo "is_descendant_of(A,X):0" >expect &&
-	test_three_modes is_descendant_of
+	test_all_modes is_descendant_of
 '
 
 test_expect_success 'get_merge_bases_many' '
@@ -144,7 +150,7 @@ test_expect_success 'get_merge_bases_many' '
 		git rev-parse commit-5-6 \
 			      commit-4-7 | sort
 	} >expect &&
-	test_three_modes get_merge_bases_many
+	test_all_modes get_merge_bases_many
 '
 
 test_expect_success 'reduce_heads' '
@@ -166,7 +172,7 @@ test_expect_success 'reduce_heads' '
 			      commit-2-8 \
 			      commit-1-10 | sort
 	} >expect &&
-	test_three_modes reduce_heads
+	test_all_modes reduce_heads
 '
 
 test_expect_success 'can_all_from_reach:hit' '
@@ -189,7 +195,7 @@ test_expect_success 'can_all_from_reach:hit' '
 	Y:commit-8-1
 	EOF
 	echo "can_all_from_reach(X,Y):1" >expect &&
-	test_three_modes can_all_from_reach
+	test_all_modes can_all_from_reach
 '
 
 test_expect_success 'can_all_from_reach:miss' '
@@ -211,7 +217,7 @@ test_expect_success 'can_all_from_reach:miss' '
 	Y:commit-8-5
 	EOF
 	echo "can_all_from_reach(X,Y):0" >expect &&
-	test_three_modes can_all_from_reach
+	test_all_modes can_all_from_reach
 '
 
 test_expect_success 'can_all_from_reach_with_flag: tags case' '
@@ -234,7 +240,7 @@ test_expect_success 'can_all_from_reach_with_flag: tags case' '
 	Y:commit-8-1
 	EOF
 	echo "can_all_from_reach_with_flag(X,_,_,0,0):1" >expect &&
-	test_three_modes can_all_from_reach_with_flag
+	test_all_modes can_all_from_reach_with_flag
 '
 
 test_expect_success 'commit_contains:hit' '
@@ -250,8 +256,8 @@ test_expect_success 'commit_contains:hit' '
 	X:commit-9-3
 	EOF
 	echo "commit_contains(_,A,X,_):1" >expect &&
-	test_three_modes commit_contains &&
-	test_three_modes commit_contains --tag
+	test_all_modes commit_contains &&
+	test_all_modes commit_contains --tag
 '
 
 test_expect_success 'commit_contains:miss' '
@@ -267,8 +273,8 @@ test_expect_success 'commit_contains:miss' '
 	X:commit-9-3
 	EOF
 	echo "commit_contains(_,A,X,_):0" >expect &&
-	test_three_modes commit_contains &&
-	test_three_modes commit_contains --tag
+	test_all_modes commit_contains &&
+	test_all_modes commit_contains --tag
 '
 
 test_expect_success 'rev-list: basic topo-order' '
@@ -280,7 +286,7 @@ test_expect_success 'rev-list: basic topo-order' '
 		commit-6-2 commit-5-2 commit-4-2 commit-3-2 commit-2-2 commit-1-2 \
 		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
 	>expect &&
-	run_three_modes git rev-list --topo-order commit-6-6
+	run_all_modes git rev-list --topo-order commit-6-6
 '
 
 test_expect_success 'rev-list: first-parent topo-order' '
@@ -292,7 +298,7 @@ test_expect_success 'rev-list: first-parent topo-order' '
 		commit-6-2 \
 		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
 	>expect &&
-	run_three_modes git rev-list --first-parent --topo-order commit-6-6
+	run_all_modes git rev-list --first-parent --topo-order commit-6-6
 '
 
 test_expect_success 'rev-list: range topo-order' '
@@ -304,7 +310,7 @@ test_expect_success 'rev-list: range topo-order' '
 		commit-6-2 commit-5-2 commit-4-2 \
 		commit-6-1 commit-5-1 commit-4-1 \
 	>expect &&
-	run_three_modes git rev-list --topo-order commit-3-3..commit-6-6
+	run_all_modes git rev-list --topo-order commit-3-3..commit-6-6
 '
 
 test_expect_success 'rev-list: range topo-order' '
@@ -316,7 +322,7 @@ test_expect_success 'rev-list: range topo-order' '
 		commit-6-2 commit-5-2 commit-4-2 \
 		commit-6-1 commit-5-1 commit-4-1 \
 	>expect &&
-	run_three_modes git rev-list --topo-order commit-3-8..commit-6-6
+	run_all_modes git rev-list --topo-order commit-3-8..commit-6-6
 '
 
 test_expect_success 'rev-list: first-parent range topo-order' '
@@ -328,7 +334,7 @@ test_expect_success 'rev-list: first-parent range topo-order' '
 		commit-6-2 \
 		commit-6-1 commit-5-1 commit-4-1 \
 	>expect &&
-	run_three_modes git rev-list --first-parent --topo-order commit-3-8..commit-6-6
+	run_all_modes git rev-list --first-parent --topo-order commit-3-8..commit-6-6
 '
 
 test_expect_success 'rev-list: ancestry-path topo-order' '
@@ -338,7 +344,7 @@ test_expect_success 'rev-list: ancestry-path topo-order' '
 		commit-6-4 commit-5-4 commit-4-4 commit-3-4 \
 		commit-6-3 commit-5-3 commit-4-3 \
 	>expect &&
-	run_three_modes git rev-list --topo-order --ancestry-path commit-3-3..commit-6-6
+	run_all_modes git rev-list --topo-order --ancestry-path commit-3-3..commit-6-6
 '
 
 test_expect_success 'rev-list: symmetric difference topo-order' '
@@ -352,7 +358,7 @@ test_expect_success 'rev-list: symmetric difference topo-order' '
 		commit-3-8 commit-2-8 commit-1-8 \
 		commit-3-7 commit-2-7 commit-1-7 \
 	>expect &&
-	run_three_modes git rev-list --topo-order commit-3-8...commit-6-6
+	run_all_modes git rev-list --topo-order commit-3-8...commit-6-6
 '
 
 test_expect_success 'get_reachable_subset:all' '
@@ -372,7 +378,7 @@ test_expect_success 'get_reachable_subset:all' '
 			      commit-1-7 \
 			      commit-5-6 | sort
 	) >expect &&
-	test_three_modes get_reachable_subset
+	test_all_modes get_reachable_subset
 '
 
 test_expect_success 'get_reachable_subset:some' '
@@ -390,7 +396,7 @@ test_expect_success 'get_reachable_subset:some' '
 		git rev-parse commit-3-3 \
 			      commit-1-7 | sort
 	) >expect &&
-	test_three_modes get_reachable_subset
+	test_all_modes get_reachable_subset
 '
 
 test_expect_success 'get_reachable_subset:none' '
@@ -404,7 +410,7 @@ test_expect_success 'get_reachable_subset:none' '
 	Y:commit-2-8
 	EOF
 	echo "get_reachable_subset(X,Y)" >expect &&
-	test_three_modes get_reachable_subset
+	test_all_modes get_reachable_subset
 '
 
 test_done
-- 
gitgitgadget

