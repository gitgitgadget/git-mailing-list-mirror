Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4C6C4332B
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DAD9229C6
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbgL1LRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 06:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbgL1LRe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 06:17:34 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771C1C06179E
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 03:16:20 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id i9so11030611wrc.4
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 03:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=5FdB9pecxzRhb/f7Jf8BisIavo9M2IWJpKMI4JN0M44=;
        b=EFkNzmcJBuIHERzaDb+akIRGNp9sJOnmiOum6/nqEqzOGThEP3N23fOwYJ0rj8B7dI
         PCP/KLr6/VDJHpe/r13fMIBzcrIJVqlLQ9A/Wm/BWVxhPVoGdCKRtn9PWPIt/1u4Q+CM
         uOVgz5hvE3l8ZU01kuRIzuR3qM2iPkFWTf0oxIdej3GYd0KDnBxwfPIq3CgvDAHEP8KR
         DAiRwUgKHjhZd0EhDuEfXXzUXy30R/N9ORiihtXVWe2o3DLCyBkywtZJQdUzT+60aPcS
         oX+TcIUHs43ZsRy6Qx2aMudcKTC3n58P2hdDklxYtOXOdk4nWNVrpaEbVRDM2HjzriZb
         KCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=5FdB9pecxzRhb/f7Jf8BisIavo9M2IWJpKMI4JN0M44=;
        b=BIicPCtIYwNRka1xibCZR+YDOETEautAs3s2LVEbSvGfGNqdk34kF7N3+gd7wJ+NfD
         lh7jxrNUkojLlqmra5jDPxzHW0wncNMx8Wu+FKZlY/pHjYI2N+qsGD2tzT9KU/BmtoS2
         fgwg4N+LCXPk8E3v0RdtIeoNUbSRDjQdYM/WwW1ee6f+GeCTCJHHDcFsepymMxs0LvtO
         JQ4Tg0j1D1og1Ak9iOpjgDtJC9i5+HfTioVl62V0lMvK9Z9ApadSat6khbIGkgc3R8y0
         nm6E0jz/OCzFr2j267Jz8WdezM9akeKxgNiN6IdYjlVYAOX8idNeKHIUZB6s7FjFgVmm
         9A6w==
X-Gm-Message-State: AOAM533L9F6UBkRtux+OmxRqD6iozfydKnjrCos7FSOqHGTewNhuru7i
        cnUYxeU5ltmLpELaYALjdlSjkYY2exY=
X-Google-Smtp-Source: ABdhPJwFR36lunrmx7z5S+iftcsHtWrwB6x2BPocPn8TKgmP80G01Q/YKldx0L4drBqQs1FISG0MVw==
X-Received: by 2002:a5d:6a4f:: with SMTP id t15mr52213427wrw.62.1609154178848;
        Mon, 28 Dec 2020 03:16:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20sm58099510wra.19.2020.12.28.03.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 03:16:18 -0800 (PST)
Message-Id: <8403c4d025727bbc4b69ca12c42dd1db7826159b.1609154169.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
References: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Dec 2020 11:16:05 +0000
Subject: [PATCH v5 08/11] commit-graph: implement generation data chunk
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
pre-requistes before implementing generation number v2 was to
distinguish between graph versions in a backwards compatible manner.

We are going to introduce a new chunk called Generation DATa chunk (or
GDAT). GDAT will store corrected committer date offsets whereas CDAT
will still store topological level.

Old Git does not understand GDAT chunk and would ignore it, reading
topological levels from CDAT. New Git can parse GDAT and take advantage
of newer generation numbers, falling back to topological levels when
GDAT chunk is missing (as it would happen with a commit-graph written
by old Git).

We introduce a test environment variable 'GIT_TEST_COMMIT_GRAPH_NO_GDAT'
which forces commit-graph file to be written without generation data
chunk to emulate a commit-graph file written by old Git.

To minimize the space required to store corrrected commit date, Git
stores corrected commit date offsets into the commit-graph file, instea
of corrected commit dates. This saves us 4 bytes per commit, decreasing
the GDAT chunk size by half, but it's possible for the offset to
overflow the 4-bytes allocated for storage. As such overflows are and
should be exceedingly rare, we use the following overflow management
scheme:

We introduce a new commit-graph chunk, Generation Data OVerflow ('GDOV')
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
 commit-graph.c                | 111 ++++++++++++++++++++++++++++++----
 commit-graph.h                |   3 +
 commit.h                      |   1 +
 t/README                      |   3 +
 t/helper/test-read-graph.c    |   4 ++
 t/t4216-log-bloom.sh          |   4 +-
 t/t5318-commit-graph.sh       |  79 ++++++++++++++++++++----
 t/t5324-split-commit-graph.sh |  12 ++--
 t/t6600-test-reach.sh         |   6 ++
 t/test-lib-functions.sh       |   6 ++
 10 files changed, 197 insertions(+), 32 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index bfc3aae5f93..629b2f17fbc 100644
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
 
@@ -390,6 +394,20 @@ struct commit_graph *parse_commit_graph(struct repository *r,
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
@@ -750,8 +768,8 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 {
 	const unsigned char *commit_data;
 	struct commit_graph_data *graph_data;
-	uint32_t lex_index;
-	uint64_t date_high, date_low;
+	uint32_t lex_index, offset_pos;
+	uint64_t date_high, date_low, offset;
 
 	while (pos < g->num_commits_in_base)
 		g = g->base_graph;
@@ -769,7 +787,16 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	date_low = get_be32(commit_data + g->hash_len + 12);
 	item->date = (timestamp_t)((date_high << 32) | date_low);
 
-	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
+	if (g->chunk_generation_data) {
+		offset = (timestamp_t)get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
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
@@ -941,6 +968,7 @@ struct write_commit_graph_context {
 	struct oid_array oids;
 	struct packed_commit_list commits;
 	int num_extra_edges;
+	int num_generation_data_overflows;
 	unsigned long approx_nr_objects;
 	struct progress *progress;
 	int progress_done;
@@ -959,7 +987,8 @@ struct write_commit_graph_context {
 		 report_progress:1,
 		 split:1,
 		 changed_paths:1,
-		 order_by_pack:1;
+		 order_by_pack:1,
+		 write_generation_data:1;
 
 	struct topo_level_slab *topo_levels;
 	const struct commit_graph_opts *opts;
@@ -1119,6 +1148,45 @@ static int write_graph_chunk_data(struct hashfile *f,
 	return 0;
 }
 
+static int write_graph_chunk_generation_data(struct hashfile *f,
+					      struct write_commit_graph_context *ctx)
+{
+	int i, num_generation_data_overflows = 0;
+
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
@@ -1382,6 +1450,9 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 				if (current->date && current->date > max_corrected_commit_date)
 					max_corrected_commit_date = current->date - 1;
 				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
+
+				if (commit_graph_data_at(current)->generation - current->date > GENERATION_NUMBER_V2_OFFSET_MAX)
+					ctx->num_generation_data_overflows++;
 			}
 		}
 	}
@@ -1715,6 +1786,21 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
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
@@ -2135,6 +2221,8 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
 	ctx->opts = opts;
 	ctx->total_bloom_filter_data_size = 0;
+	ctx->write_generation_data = 1;
+	ctx->num_generation_data_overflows = 0;
 
 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
 						      bloom_settings.bits_per_entry);
@@ -2441,16 +2529,17 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 			continue;
 
 		/*
-		 * If one of our parents has generation GENERATION_NUMBER_V1_MAX, then
-		 * our generation is also GENERATION_NUMBER_V1_MAX. Decrement to avoid
-		 * extra logic in the following condition.
+		 * If we are using topological level and one of our parents has
+		 * generation GENERATION_NUMBER_V1_MAX, then our generation is
+		 * also GENERATION_NUMBER_V1_MAX. Decrement to avoid extra logic
+		 * in the following condition.
 		 */
-		if (max_generation == GENERATION_NUMBER_V1_MAX)
+		if (!g->chunk_generation_data && max_generation == GENERATION_NUMBER_V1_MAX)
 			max_generation--;
 
 		generation = commit_graph_generation(graph_commit);
-		if (generation != max_generation + 1)
-			graph_report(_("commit-graph generation for commit %s is %"PRItime" != %"PRItime),
+		if (generation < max_generation + 1)
+			graph_report(_("commit-graph generation for commit %s is %"PRItime" < %"PRItime),
 				     oid_to_hex(&cur_oid),
 				     generation,
 				     max_generation + 1);
diff --git a/commit-graph.h b/commit-graph.h
index 2e9aa7824ee..19a02001fde 100644
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
index 33c66b2177c..251d877fcf6 100644
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
index c730a707705..8a121487279 100644
--- a/t/README
+++ b/t/README
@@ -393,6 +393,9 @@ GIT_TEST_COMMIT_GRAPH=<boolean>, when true, forces the commit-graph to
 be written after every 'git commit' command, and overrides the
 'core.commitGraph' setting to true.
 
+GIT_TEST_COMMIT_GRAPH_NO_GDAT=<boolean>, when true, forces the
+commit-graph to be written without generation data chunk.
+
 GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=<boolean>, when true, forces
 commit-graph write to compute and write changed path Bloom filters for
 every 'git commit-graph write', as if the `--changed-paths` option was
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 5f585a17256..75927b2c81d 100644
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
index d11040ce41c..dbde0161882 100755
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
index 2ed0c1544da..fa27df579a5 100755
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
@@ -741,4 +742,56 @@ test_expect_success 'corrupt commit-graph write (missing tree)' '
 	)
 '
 
+# We test the overflow-related code with the following repo history:
+#
+#               4:F - 5:N - 6:U
+#              /                \
+# 1:U - 2:N - 3:U                M:N
+#              \                /
+#               7:N - 8:F - 9:N
+#
+# Here the commits denoted by U have committer date of zero seconds
+# since Unix epoch, the commits denoted by N have committer date
+# starting from 1112354055 seconds since Unix epoch (default committer
+# date for the test suite), and the commits denoted by F have committer
+# date of (2 ^ 31 - 2) seconds since Unix epoch.
+#
+# The largest offset observed is 2 ^ 31, just large enough to overflow.
+#
+
+test_expect_success 'set up and verify repo with generation data overflow chunk' '
+	objdir=".git/objects" &&
+	UNIX_EPOCH_ZERO="@0 +0000" &&
+	FUTURE_DATE="@2147483646 +0000" &&
+	test_oid_cache <<-EOF &&
+	oid_version sha1:1
+	oid_version sha256:2
+	EOF
+	cd "$TRASH_DIRECTORY" &&
+	mkdir repo &&
+	cd repo &&
+	git init &&
+	test_commit --date "$UNIX_EPOCH_ZERO" 1 &&
+	test_commit 2 &&
+	test_commit --date "$UNIX_EPOCH_ZERO" 3 &&
+	git commit-graph write --reachable &&
+	graph_read_expect 3 generation_data &&
+	test_commit --date "$FUTURE_DATE" 4 &&
+	test_commit 5 &&
+	test_commit --date "$UNIX_EPOCH_ZERO" 6 &&
+	git branch left &&
+	git reset --hard 3 &&
+	test_commit 7 &&
+	test_commit --date "$FUTURE_DATE" 8 &&
+	test_commit 9 &&
+	git branch right &&
+	git reset --hard 3 &&
+	test_merge M left right &&
+	git commit-graph write --reachable &&
+	graph_read_expect 10 "generation_data generation_data_overflow" &&
+	git commit-graph verify
+'
+
+graph_git_behavior 'generation data overflow chunk repo' repo left right
+
 test_done
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 4d3842b83b9..587757b62d9 100755
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
index af10f0dc090..e2d33a8a4c4 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -55,6 +55,9 @@ test_expect_success 'setup' '
 	git show-ref -s commit-5-5 | git commit-graph write --stdin-commits &&
 	mv .git/objects/info/commit-graph commit-graph-half &&
 	chmod u+w commit-graph-half &&
+	GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --reachable &&
+	mv .git/objects/info/commit-graph commit-graph-no-gdat &&
+	chmod u+w commit-graph-no-gdat &&
 	git config core.commitGraph true
 '
 
@@ -67,6 +70,9 @@ run_all_modes () {
 	test_cmp expect actual &&
 	cp commit-graph-half .git/objects/info/commit-graph &&
 	"$@" <input >actual &&
+	test_cmp expect actual &&
+	cp commit-graph-no-gdat .git/objects/info/commit-graph &&
+	"$@" <input >actual &&
 	test_cmp expect actual
 }
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 999982fe4a9..3ad712c3acc 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -202,6 +202,12 @@ test_commit () {
 		--signoff)
 			signoff="$1"
 			;;
+		--date)
+			notick=yes
+			GIT_COMMITTER_DATE="$2"
+			GIT_AUTHOR_DATE="$2"
+			shift
+			;;
 		-C)
 			indir="$2"
 			shift
-- 
gitgitgadget

