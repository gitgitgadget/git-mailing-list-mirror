Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3451C41604
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 14:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 409C120870
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 14:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cbu5qWZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgJGOKE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 10:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbgJGOJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 10:09:58 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DD6C0613D3
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 07:09:57 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id n18so2355566wrs.5
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 07:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=RocCDtpoyRW0SLXFpraKO5FlpTJOQ4Sv19gqDP/ZfVQ=;
        b=Cbu5qWZmw33msUL/7stztqoR0p/M7O+e3qFkhPkfNrShws0iKF8JMYzDSYm4qVHe/s
         U9FfwEq7U1bU0PtEM+B1gLJQ7B2FmuhPPR7RvteR0ki2A3iObSTlT03ttQ21R1b2SFRx
         d66f19rHAlr+nZbt5NLKe2ylt1TCxrm0rQJl0N0OeNBfuHXADP6eVdxX+VoG9AJ2om8k
         ORew51BquT9rmWn5Jc7wBIcRQ96tG0HWGWAdiHVXkCfccTq6YNQJSJaV0PmqUYcXedLq
         yl88N2wEdYASX4jgVCp5pKvTtGSdCqRqC1veTT2JWwEqfQoAzIIpSqj32SCAOF6k7osg
         28tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=RocCDtpoyRW0SLXFpraKO5FlpTJOQ4Sv19gqDP/ZfVQ=;
        b=YFYci1z8PeRMR/4Ty4Ct0D/MfHV30e59g1XRmsgIYJ0jozoUW7YLTe7e3PwQyJpLGb
         +HBmEUm2g0e8yNSsmwI9NXBBmfdGI+0Tbs5yAgZ6d813I9cN7DQ+H5+3FM1erOxwOq2/
         mGiq8elgx+jwZ79quQBJLQPXiSG5tKmvzLRS8EvTOhMJZF1y1VgPPqgLhyngCKRBG//A
         Oh2+GGzQPUAJ6JQqMhFtKcvYoguC0WH/uxpN6HWUnFSvozl6P6O2YskjeVIdXpIg5oB/
         cJ5cd3eCX7d5yuc9R/T/ZQ2NbWOyfEZUU0fGTnBQarrXQ1JlAjuEFzQXQZa0jjJpiZcR
         9T3w==
X-Gm-Message-State: AOAM530lXdUxGNQ5xNDzhOOMiOAray9ZcPp0tbwMgiimyPIDfHIaEa6I
        Xq1Yy2KiwMYYEECNpwI7CYdY3WSm+3U=
X-Google-Smtp-Source: ABdhPJzv5rewMCf9KI3u3QMD9TWQDma/Nu06ZHYhVt7SkA2Q2M+ImAmVh6JohnavqMWWkqbiDFXjsQ==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr3651207wrs.186.1602079795644;
        Wed, 07 Oct 2020 07:09:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d18sm2979511wrm.10.2020.10.07.07.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 07:09:54 -0700 (PDT)
Message-Id: <b903efe2ea11bc0b7e1ef8f239ed34f72caa4f03.1602079786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Oct 2020 14:09:42 +0000
Subject: [PATCH v4 07/10] commit-graph: implement generation data chunk
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

As discovered by Ævar, we cannot increment graph version to
distinguish between generation numbers v1 and v2 [1]. Thus, one of
pre-requistes before implementing generation number was to distinguish
between graph versions in a backwards compatible manner.

We are going to introduce a new chunk called Generation Data chunk (or
GDAT). GDAT stores corrected committer date offsets whereas CDAT will
still store topological level.

Old Git does not understand GDAT chunk and would ignore it, reading
topological levels from CDAT. New Git can parse GDAT and take advantage
of newer generation numbers, falling back to topological levels when
GDAT chunk is missing (as it would happen with a commit graph written
by old Git).

We introduce a test environment variable 'GIT_TEST_COMMIT_GRAPH_NO_GDAT'
which forces commit-graph file to be written without generation data
chunk to emulate a commit-graph file written by old Git.

While storing corrected commit date offset instead of the corrected
commit date saves us 4 bytes per commit, it's possible for the offsets
to overflow the 4-bytes allocated. As such overflows are exceedingly
rare, we use the following overflow management scheme:

We introduce a new commit-graph chunk, GENERATION_DATA_OVERFLOW ('GDOV')
to store corrected commit dates for commits with offsets greater than
GENERATION_NUMBER_V2_OFFSET_MAX.

If the offset is greater than GENERATION_NUMBER_V2_OFFSET_MAX, we set
the MSB of the offset and the other bits store the position of corrected
commit date in GDOV chunk, similar to how Extra Edge List is maintained.

We test the overflow-related code with the following repo history:

           F - N - U
          /         \
U - N - U            N
         \          /
	  N - F - N

Where the commits denoted by U have committer date of zero seconds
since Unix epoch, the commits denoted by N have committer date of
1112354055 (default committer date for the test suite) seconds since
Unix epoch and the commits denoted by F have committer date of
(2 ^ 31 - 2) seconds since Unix epoch.

The largest offset observed is 2 ^ 31, just large enough to overflow.

[1]: https://lore.kernel.org/git/87a7gdspo4.fsf@evledraar.gmail.com/

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c                | 98 +++++++++++++++++++++++++++++++++--
 commit-graph.h                |  3 ++
 commit.h                      |  1 +
 t/README                      |  3 ++
 t/helper/test-read-graph.c    |  4 ++
 t/t4216-log-bloom.sh          |  4 +-
 t/t5318-commit-graph.sh       | 70 ++++++++++++++++++++-----
 t/t5324-split-commit-graph.sh | 12 ++---
 t/t6600-test-reach.sh         | 68 +++++++++++++-----------
 9 files changed, 206 insertions(+), 57 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 03948adfce..71d0b243db 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -38,11 +38,13 @@ void git_test_write_commit_graph_or_die(void)
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
 #define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
 #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
+#define GRAPH_CHUNKID_GENERATION_DATA 0x47444154 /* "GDAT" */
+#define GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW 0x47444f56 /* "GDOV" */
 #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
 #define GRAPH_CHUNKID_BLOOMINDEXES 0x42494458 /* "BIDX" */
 #define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
 #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
-#define MAX_NUM_CHUNKS 7
+#define MAX_NUM_CHUNKS 9
 
 #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
 
@@ -61,6 +63,8 @@ void git_test_write_commit_graph_or_die(void)
 #define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
 			+ GRAPH_FANOUT_SIZE + the_hash_algo->rawsz)
 
+#define CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW (1ULL << 31)
+
 /* Remember to update object flag allocation in object.h */
 #define REACHABLE       (1u<<15)
 
@@ -385,6 +389,20 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 				graph->chunk_commit_data = data + chunk_offset;
 			break;
 
+		case GRAPH_CHUNKID_GENERATION_DATA:
+			if (graph->chunk_generation_data)
+				chunk_repeated = 1;
+			else
+				graph->chunk_generation_data = data + chunk_offset;
+			break;
+
+		case GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW:
+			if (graph->chunk_generation_data_overflow)
+				chunk_repeated = 1;
+			else
+				graph->chunk_generation_data_overflow = data + chunk_offset;
+			break;
+
 		case GRAPH_CHUNKID_EXTRAEDGES:
 			if (graph->chunk_extra_edges)
 				chunk_repeated = 1;
@@ -745,8 +763,8 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 {
 	const unsigned char *commit_data;
 	struct commit_graph_data *graph_data;
-	uint32_t lex_index;
-	uint64_t date_high, date_low;
+	uint32_t lex_index, offset_pos;
+	uint64_t date_high, date_low, offset;
 
 	while (pos < g->num_commits_in_base)
 		g = g->base_graph;
@@ -764,7 +782,16 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	date_low = get_be32(commit_data + g->hash_len + 12);
 	item->date = (timestamp_t)((date_high << 32) | date_low);
 
-	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
+	if (g->chunk_generation_data) {
+		offset = (timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
+
+		if (offset & CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW) {
+			offset_pos = offset ^ CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW;
+			graph_data->generation = get_be64(g->chunk_generation_data_overflow + 8 * offset_pos);
+		} else
+			graph_data->generation = item->date + offset;
+	} else
+		graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
 
 	if (g->topo_levels)
 		*topo_level_slab_at(g->topo_levels, item) = get_be32(commit_data + g->hash_len + 8) >> 2;
@@ -942,6 +969,7 @@ struct write_commit_graph_context {
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
 	int num_extra_edges;
+	int num_generation_data_overflows;
 	unsigned long approx_nr_objects;
 	struct progress *progress;
 	int progress_done;
@@ -960,7 +988,8 @@ struct write_commit_graph_context {
 		 report_progress:1,
 		 split:1,
 		 changed_paths:1,
-		 order_by_pack:1;
+		 order_by_pack:1,
+		 write_generation_data:1;
 
 	struct topo_level_slab *topo_levels;
 	const struct commit_graph_opts *opts;
@@ -1120,6 +1149,44 @@ static int write_graph_chunk_data(struct hashfile *f,
 	return 0;
 }
 
+static int write_graph_chunk_generation_data(struct hashfile *f,
+					      struct write_commit_graph_context *ctx)
+{
+	int i, num_generation_data_overflows = 0;
+	for (i = 0; i < ctx->commits.nr; i++) {
+		struct commit *c = ctx->commits.list[i];
+		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
+		display_progress(ctx->progress, ++ctx->progress_cnt);
+
+		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX) {
+			offset = CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW | num_generation_data_overflows;
+			num_generation_data_overflows++;
+		}
+
+		hashwrite_be32(f, offset);
+	}
+
+	return 0;
+}
+
+static int write_graph_chunk_generation_data_overflow(struct hashfile *f,
+						       struct write_commit_graph_context *ctx)
+{
+	int i;
+	for (i = 0; i < ctx->commits.nr; i++) {
+		struct commit *c = ctx->commits.list[i];
+		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
+		display_progress(ctx->progress, ++ctx->progress_cnt);
+
+		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX) {
+			hashwrite_be32(f, offset >> 32);
+			hashwrite_be32(f, (uint32_t) offset);
+		}
+	}
+
+	return 0;
+}
+
 static int write_graph_chunk_extra_edges(struct hashfile *f,
 					 struct write_commit_graph_context *ctx)
 {
@@ -1399,7 +1466,11 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 
 				if (current->date && current->date > max_corrected_commit_date)
 					max_corrected_commit_date = current->date - 1;
+
 				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
+
+				if (commit_graph_data_at(current)->generation - current->date > GENERATION_NUMBER_V2_OFFSET_MAX)
+					ctx->num_generation_data_overflows++;
 			}
 		}
 	}
@@ -1765,6 +1836,21 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
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
+	if (ctx->num_generation_data_overflows) {
+		chunks[num_chunks].id = GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW;
+		chunks[num_chunks].size = sizeof(timestamp_t) * ctx->num_generation_data_overflows;
+		chunks[num_chunks].write_fn = write_graph_chunk_generation_data_overflow;
+		num_chunks++;
+	}
 	if (ctx->num_extra_edges) {
 		chunks[num_chunks].id = GRAPH_CHUNKID_EXTRAEDGES;
 		chunks[num_chunks].size = 4 * ctx->num_extra_edges;
@@ -2170,6 +2256,8 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
 	ctx->opts = opts;
 	ctx->total_bloom_filter_data_size = 0;
+	ctx->write_generation_data = 1;
+	ctx->num_generation_data_overflows = 0;
 
 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
 						      bloom_settings.bits_per_entry);
diff --git a/commit-graph.h b/commit-graph.h
index 2e9aa7824e..19a02001fd 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -6,6 +6,7 @@
 #include "oidset.h"
 
 #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
+#define GIT_TEST_COMMIT_GRAPH_NO_GDAT "GIT_TEST_COMMIT_GRAPH_NO_GDAT"
 #define GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE "GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE"
 #define GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS "GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS"
 
@@ -68,6 +69,8 @@ struct commit_graph {
 	const uint32_t *chunk_oid_fanout;
 	const unsigned char *chunk_oid_lookup;
 	const unsigned char *chunk_commit_data;
+	const unsigned char *chunk_generation_data;
+	const unsigned char *chunk_generation_data_overflow;
 	const unsigned char *chunk_extra_edges;
 	const unsigned char *chunk_base_graphs;
 	const unsigned char *chunk_bloom_indexes;
diff --git a/commit.h b/commit.h
index 33c66b2177..251d877fcf 100644
--- a/commit.h
+++ b/commit.h
@@ -14,6 +14,7 @@
 #define GENERATION_NUMBER_INFINITY ((1ULL << 63) - 1)
 #define GENERATION_NUMBER_V1_MAX 0x3FFFFFFF
 #define GENERATION_NUMBER_ZERO 0
+#define GENERATION_NUMBER_V2_OFFSET_MAX ((1ULL << 31) - 1)
 
 struct commit_list {
 	struct commit *item;
diff --git a/t/README b/t/README
index 2adaf7c2d2..975c054bc9 100644
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
index 5f585a1725..75927b2c81 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -33,6 +33,10 @@ int cmd__read_graph(int argc, const char **argv)
 		printf(" oid_lookup");
 	if (graph->chunk_commit_data)
 		printf(" commit_metadata");
+	if (graph->chunk_generation_data)
+		printf(" generation_data");
+	if (graph->chunk_generation_data_overflow)
+		printf(" generation_data_overflow");
 	if (graph->chunk_extra_edges)
 		printf(" extra_edges");
 	if (graph->chunk_bloom_indexes)
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index d11040ce41..dbde016188 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -40,11 +40,11 @@ test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
 '
 
 graph_read_expect () {
-	NUM_CHUNKS=5
+	NUM_CHUNKS=6
 	cat >expect <<- EOF
 	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
 	num_commits: $1
-	chunks: oid_fanout oid_lookup commit_metadata bloom_indexes bloom_data
+	chunks: oid_fanout oid_lookup commit_metadata generation_data bloom_indexes bloom_data
 	EOF
 	test-tool read-graph >actual &&
 	test_cmp expect actual
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 2ed0c1544d..0328e98564 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -76,7 +76,7 @@ graph_git_behavior 'no graph' full commits/3 commits/1
 graph_read_expect() {
 	OPTIONAL=""
 	NUM_CHUNKS=3
-	if test ! -z $2
+	if test ! -z "$2"
 	then
 		OPTIONAL=" $2"
 		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
@@ -103,14 +103,14 @@ test_expect_success 'exit with correct error on bad input to --stdin-commits' '
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
@@ -219,7 +219,7 @@ test_expect_success 'write graph with merges' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write &&
 	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "10" "extra_edges"
+	graph_read_expect "10" "generation_data extra_edges"
 '
 
 graph_git_behavior 'merge 1 vs 2' full merge/1 merge/2
@@ -254,7 +254,7 @@ test_expect_success 'write graph with new commit' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write &&
 	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "11" "extra_edges"
+	graph_read_expect "11" "generation_data extra_edges"
 '
 
 graph_git_behavior 'full graph, commit 8 vs merge 1' full commits/8 merge/1
@@ -264,7 +264,7 @@ test_expect_success 'write graph with nothing new' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write &&
 	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "11" "extra_edges"
+	graph_read_expect "11" "generation_data extra_edges"
 '
 
 graph_git_behavior 'cleared graph, commit 8 vs merge 1' full commits/8 merge/1
@@ -274,7 +274,7 @@ test_expect_success 'build graph from latest pack with closure' '
 	cd "$TRASH_DIRECTORY/full" &&
 	cat new-idx | git commit-graph write --stdin-packs &&
 	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "9" "extra_edges"
+	graph_read_expect "9" "generation_data extra_edges"
 '
 
 graph_git_behavior 'graph from pack, commit 8 vs merge 1' full commits/8 merge/1
@@ -287,7 +287,7 @@ test_expect_success 'build graph from commits with closure' '
 	git rev-parse merge/1 >>commits-in &&
 	cat commits-in | git commit-graph write --stdin-commits &&
 	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "6"
+	graph_read_expect "6" "generation_data"
 '
 
 graph_git_behavior 'graph from commits, commit 8 vs merge 1' full commits/8 merge/1
@@ -297,7 +297,7 @@ test_expect_success 'build graph from commits with append' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git rev-parse merge/3 | git commit-graph write --stdin-commits --append &&
 	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "10" "extra_edges"
+	graph_read_expect "10" "generation_data extra_edges"
 '
 
 graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merge/1
@@ -307,7 +307,7 @@ test_expect_success 'build graph using --reachable' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write --reachable &&
 	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "11" "extra_edges"
+	graph_read_expect "11" "generation_data extra_edges"
 '
 
 graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merge/1
@@ -328,7 +328,7 @@ test_expect_success 'write graph in bare repo' '
 	cd "$TRASH_DIRECTORY/bare" &&
 	git commit-graph write &&
 	test_path_is_file $baredir/info/commit-graph &&
-	graph_read_expect "11" "extra_edges"
+	graph_read_expect "11" "generation_data extra_edges"
 '
 
 graph_git_behavior 'bare repo with graph, commit 8 vs merge 1' bare commits/8 merge/1
@@ -454,8 +454,9 @@ test_expect_success 'warn on improper hash version' '
 
 test_expect_success 'git commit-graph verify' '
 	cd "$TRASH_DIRECTORY/full" &&
-	git rev-parse commits/8 | git commit-graph write --stdin-commits &&
-	git commit-graph verify >output
+	git rev-parse commits/8 | GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --stdin-commits &&
+	git commit-graph verify >output &&
+	graph_read_expect 9 extra_edges
 '
 
 NUM_COMMITS=9
@@ -741,4 +742,47 @@ test_expect_success 'corrupt commit-graph write (missing tree)' '
 	)
 '
 
+test_commit_with_date() {
+  file="$1.t" &&
+  echo "$1" >"$file" &&
+  git add "$file" &&
+  GIT_COMMITTER_DATE="$2" GIT_AUTHOR_DATE="$2" git commit -m "$1"
+  git tag "$1"
+}
+
+test_expect_success 'overflow corrected commit date offset' '
+	objdir=".git/objects" &&
+	UNIX_EPOCH_ZERO="1970-01-01 00:00 +0000" &&
+	FUTURE_DATE="@2147483646 +0000" &&
+	test_oid_cache <<-EOF &&
+	oid_version sha1:1
+	oid_version sha256:2
+	EOF
+	cd "$TRASH_DIRECTORY" &&
+	mkdir repo &&
+	cd repo &&
+	git init &&
+	test_commit_with_date 1 "$UNIX_EPOCH_ZERO" &&
+	test_commit 2 &&
+	test_commit_with_date 3 "$UNIX_EPOCH_ZERO" &&
+	git commit-graph write --reachable &&
+	graph_read_expect 3 generation_data &&
+	test_commit_with_date 4 "$FUTURE_DATE" &&
+	test_commit 5 &&
+	test_commit_with_date 6 "$UNIX_EPOCH_ZERO" &&
+	git branch left &&
+	git reset --hard 3 &&
+	test_commit 7 &&
+	test_commit_with_date 8 "$FUTURE_DATE" &&
+	test_commit 9 &&
+	git branch right &&
+	git reset --hard 3 &&
+	git merge left right &&
+	git commit-graph write --reachable &&
+	graph_read_expect 10 "generation_data generation_data_overflow" &&
+	git commit-graph verify
+'
+
+graph_git_behavior 'overflow corrected commit date offset' repo left right
+
 test_done
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index c334ee9155..651df89ab2 100755
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
 
 	oid_version sha1:1
 	oid_version sha256:2
@@ -31,9 +31,9 @@ graph_read_expect() {
 		NUM_BASE=$2
 	fi
 	cat >expect <<- EOF
-	header: 43475048 1 $(test_oid oid_version) 3 $NUM_BASE
+	header: 43475048 1 $(test_oid oid_version) 4 $NUM_BASE
 	num_commits: $1
-	chunks: oid_fanout oid_lookup commit_metadata
+	chunks: oid_fanout oid_lookup commit_metadata generation_data
 	EOF
 	test-tool read-graph >output &&
 	test_cmp expect output
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index f807276337..e2d33a8a4c 100755
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
 
 test_expect_success 'in_merge_bases_many:hit' '
@@ -117,7 +123,7 @@ test_expect_success 'in_merge_bases_many:hit' '
 	X:commit-5-7
 	EOF
 	echo "in_merge_bases_many(A,X):1" >expect &&
-	test_three_modes in_merge_bases_many
+	test_all_modes in_merge_bases_many
 '
 
 test_expect_success 'in_merge_bases_many:miss' '
@@ -127,7 +133,7 @@ test_expect_success 'in_merge_bases_many:miss' '
 	X:commit-8-6
 	EOF
 	echo "in_merge_bases_many(A,X):0" >expect &&
-	test_three_modes in_merge_bases_many
+	test_all_modes in_merge_bases_many
 '
 
 test_expect_success 'in_merge_bases_many:miss-heuristic' '
@@ -137,7 +143,7 @@ test_expect_success 'in_merge_bases_many:miss-heuristic' '
 	X:commit-6-6
 	EOF
 	echo "in_merge_bases_many(A,X):0" >expect &&
-	test_three_modes in_merge_bases_many
+	test_all_modes in_merge_bases_many
 '
 
 test_expect_success 'is_descendant_of:hit' '
@@ -148,7 +154,7 @@ test_expect_success 'is_descendant_of:hit' '
 	X:commit-1-1
 	EOF
 	echo "is_descendant_of(A,X):1" >expect &&
-	test_three_modes is_descendant_of
+	test_all_modes is_descendant_of
 '
 
 test_expect_success 'is_descendant_of:miss' '
@@ -159,7 +165,7 @@ test_expect_success 'is_descendant_of:miss' '
 	X:commit-7-6
 	EOF
 	echo "is_descendant_of(A,X):0" >expect &&
-	test_three_modes is_descendant_of
+	test_all_modes is_descendant_of
 '
 
 test_expect_success 'get_merge_bases_many' '
@@ -174,7 +180,7 @@ test_expect_success 'get_merge_bases_many' '
 		git rev-parse commit-5-6 \
 			      commit-4-7 | sort
 	} >expect &&
-	test_three_modes get_merge_bases_many
+	test_all_modes get_merge_bases_many
 '
 
 test_expect_success 'reduce_heads' '
@@ -196,7 +202,7 @@ test_expect_success 'reduce_heads' '
 			      commit-2-8 \
 			      commit-1-10 | sort
 	} >expect &&
-	test_three_modes reduce_heads
+	test_all_modes reduce_heads
 '
 
 test_expect_success 'can_all_from_reach:hit' '
@@ -219,7 +225,7 @@ test_expect_success 'can_all_from_reach:hit' '
 	Y:commit-8-1
 	EOF
 	echo "can_all_from_reach(X,Y):1" >expect &&
-	test_three_modes can_all_from_reach
+	test_all_modes can_all_from_reach
 '
 
 test_expect_success 'can_all_from_reach:miss' '
@@ -241,7 +247,7 @@ test_expect_success 'can_all_from_reach:miss' '
 	Y:commit-8-5
 	EOF
 	echo "can_all_from_reach(X,Y):0" >expect &&
-	test_three_modes can_all_from_reach
+	test_all_modes can_all_from_reach
 '
 
 test_expect_success 'can_all_from_reach_with_flag: tags case' '
@@ -264,7 +270,7 @@ test_expect_success 'can_all_from_reach_with_flag: tags case' '
 	Y:commit-8-1
 	EOF
 	echo "can_all_from_reach_with_flag(X,_,_,0,0):1" >expect &&
-	test_three_modes can_all_from_reach_with_flag
+	test_all_modes can_all_from_reach_with_flag
 '
 
 test_expect_success 'commit_contains:hit' '
@@ -280,8 +286,8 @@ test_expect_success 'commit_contains:hit' '
 	X:commit-9-3
 	EOF
 	echo "commit_contains(_,A,X,_):1" >expect &&
-	test_three_modes commit_contains &&
-	test_three_modes commit_contains --tag
+	test_all_modes commit_contains &&
+	test_all_modes commit_contains --tag
 '
 
 test_expect_success 'commit_contains:miss' '
@@ -297,8 +303,8 @@ test_expect_success 'commit_contains:miss' '
 	X:commit-9-3
 	EOF
 	echo "commit_contains(_,A,X,_):0" >expect &&
-	test_three_modes commit_contains &&
-	test_three_modes commit_contains --tag
+	test_all_modes commit_contains &&
+	test_all_modes commit_contains --tag
 '
 
 test_expect_success 'rev-list: basic topo-order' '
@@ -310,7 +316,7 @@ test_expect_success 'rev-list: basic topo-order' '
 		commit-6-2 commit-5-2 commit-4-2 commit-3-2 commit-2-2 commit-1-2 \
 		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
 	>expect &&
-	run_three_modes git rev-list --topo-order commit-6-6
+	run_all_modes git rev-list --topo-order commit-6-6
 '
 
 test_expect_success 'rev-list: first-parent topo-order' '
@@ -322,7 +328,7 @@ test_expect_success 'rev-list: first-parent topo-order' '
 		commit-6-2 \
 		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
 	>expect &&
-	run_three_modes git rev-list --first-parent --topo-order commit-6-6
+	run_all_modes git rev-list --first-parent --topo-order commit-6-6
 '
 
 test_expect_success 'rev-list: range topo-order' '
@@ -334,7 +340,7 @@ test_expect_success 'rev-list: range topo-order' '
 		commit-6-2 commit-5-2 commit-4-2 \
 		commit-6-1 commit-5-1 commit-4-1 \
 	>expect &&
-	run_three_modes git rev-list --topo-order commit-3-3..commit-6-6
+	run_all_modes git rev-list --topo-order commit-3-3..commit-6-6
 '
 
 test_expect_success 'rev-list: range topo-order' '
@@ -346,7 +352,7 @@ test_expect_success 'rev-list: range topo-order' '
 		commit-6-2 commit-5-2 commit-4-2 \
 		commit-6-1 commit-5-1 commit-4-1 \
 	>expect &&
-	run_three_modes git rev-list --topo-order commit-3-8..commit-6-6
+	run_all_modes git rev-list --topo-order commit-3-8..commit-6-6
 '
 
 test_expect_success 'rev-list: first-parent range topo-order' '
@@ -358,7 +364,7 @@ test_expect_success 'rev-list: first-parent range topo-order' '
 		commit-6-2 \
 		commit-6-1 commit-5-1 commit-4-1 \
 	>expect &&
-	run_three_modes git rev-list --first-parent --topo-order commit-3-8..commit-6-6
+	run_all_modes git rev-list --first-parent --topo-order commit-3-8..commit-6-6
 '
 
 test_expect_success 'rev-list: ancestry-path topo-order' '
@@ -368,7 +374,7 @@ test_expect_success 'rev-list: ancestry-path topo-order' '
 		commit-6-4 commit-5-4 commit-4-4 commit-3-4 \
 		commit-6-3 commit-5-3 commit-4-3 \
 	>expect &&
-	run_three_modes git rev-list --topo-order --ancestry-path commit-3-3..commit-6-6
+	run_all_modes git rev-list --topo-order --ancestry-path commit-3-3..commit-6-6
 '
 
 test_expect_success 'rev-list: symmetric difference topo-order' '
@@ -382,7 +388,7 @@ test_expect_success 'rev-list: symmetric difference topo-order' '
 		commit-3-8 commit-2-8 commit-1-8 \
 		commit-3-7 commit-2-7 commit-1-7 \
 	>expect &&
-	run_three_modes git rev-list --topo-order commit-3-8...commit-6-6
+	run_all_modes git rev-list --topo-order commit-3-8...commit-6-6
 '
 
 test_expect_success 'get_reachable_subset:all' '
@@ -402,7 +408,7 @@ test_expect_success 'get_reachable_subset:all' '
 			      commit-1-7 \
 			      commit-5-6 | sort
 	) >expect &&
-	test_three_modes get_reachable_subset
+	test_all_modes get_reachable_subset
 '
 
 test_expect_success 'get_reachable_subset:some' '
@@ -420,7 +426,7 @@ test_expect_success 'get_reachable_subset:some' '
 		git rev-parse commit-3-3 \
 			      commit-1-7 | sort
 	) >expect &&
-	test_three_modes get_reachable_subset
+	test_all_modes get_reachable_subset
 '
 
 test_expect_success 'get_reachable_subset:none' '
@@ -434,7 +440,7 @@ test_expect_success 'get_reachable_subset:none' '
 	Y:commit-2-8
 	EOF
 	echo "get_reachable_subset(X,Y)" >expect &&
-	test_three_modes get_reachable_subset
+	test_all_modes get_reachable_subset
 '
 
 test_done
-- 
gitgitgadget

