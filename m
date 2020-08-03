Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6B5C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ABCE207DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="z2QdCo+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgHCS5h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCS5h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:57:37 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EE6C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 11:57:36 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id a19so11844975qvy.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 11:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZxXVLs5DonXr+kjvzSFyk6wm7fSdLNDNaNqVO0Z40YE=;
        b=z2QdCo+clwKciSWCCkHmd6/lfgC8ZFfJ1O3CBEJs3MYjR+Wd0l5WCAEDF3u+p+bsFL
         j7md6CRIJ3TkFM6t+VDLE34JBqLyVbbqfwHKCqzs5oF2LLwtPJhyL2KsmHTI7jXFGmOk
         UrzTo7TDE/wn23LwDR4J9O757FR2PLaXG90w37ts5ORinmjwbPGHUrjkJAUsDqEA4FNh
         4pEp40MNRBRH8NdQOZE9bFyRyYZAhl5mB0q3Hj9F/su2v7u+F08yJQ+2+swqwe2mwYn1
         24VLVtDt4+Ch4tG9oXv9oXF1bAzyrFNvYcWe80oeYUaG8EgHnpa48gj4uk1keNQ39ClN
         X8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZxXVLs5DonXr+kjvzSFyk6wm7fSdLNDNaNqVO0Z40YE=;
        b=pjy4/for6zZ5ak8SxrcgME0+/eFTphUM4WBylecb16C87RSgHKqBpCKPvBnKpR/Cs0
         lnl6zE/mFhI/D2AtBTueZo0ORZ/2x2S2UytlfesKSu4J2/Bu1wPaJ8I88WMOm7rUmgUI
         03Bna4VanVQN5z7wzaavZ3kw1SbJH6WJuvoRqrrZhxsva/GktnA/1EEY1cJYdu5X103D
         +8Fq6DphQgI9jupxGi+dhq9qvyjr2KeBQyOgX7wKo/BBbbVQsSzhsUbkOpNjIeo9LZH8
         bkM99Cu64x6goKlzt7Mcc+zI3UPnoY7FDH7qNcbr+Qbs527NJiLLyp6G6W5rZ81HEz9j
         aFdQ==
X-Gm-Message-State: AOAM5329Wd9sDgqmvjGCME12RQi8F5SeQYnrEFdcJkl3sZpQaiSIv25V
        OR3ddOtwrluwa7t5lKSrv5IJyMUh+ujaoQ==
X-Google-Smtp-Source: ABdhPJxgAZS29Nw9W4i6elY1RxSW60XjnhK57Sv2UYBSO7PJgtfRjEJEsVt2yKosJTZLfRUJSuyd8A==
X-Received: by 2002:a0c:b591:: with SMTP id g17mr18495982qve.4.1596481055440;
        Mon, 03 Aug 2020 11:57:35 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id m17sm24148669qkn.45.2020.08.03.11.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:57:34 -0700 (PDT)
Date:   Mon, 3 Aug 2020 14:57:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 07/10] commit-graph: add large-filters bitmap chunk
Message-ID: <ab789072331127079347742b6ce3b3415bbbe4f6.1596480582.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596480582.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a commit has 512 changed paths or greater, the commit-graph
machinery represents it as a zero-length filter since having many
entries in the Bloom filter has undesirable effects on the false
positivity rate.

In addition to these too-large filters, the commit-graph machinery also
represents commits with no filter and commits with no changed paths in
the same way.

When writing a commit-graph that aggregates several incremental
commit-graph layers (eg., with '--split=replace'), the commit-graph
machinery first computes all of the Bloom filters that it wants to write
but does not already know about from existing graph layers. Because we
overload the zero-length filter in the above fashion, this leads to
recomputing large filters over and over again.

This is already undesirable, since it means that we are wasting
considerable effort to discover that a commit has at least 512 changed
paths, only to throw that effort away (and then repeat the process the
next time a roll-up is performed).

In a subsequent patch, we will add a '--max-new-filters' option, which
specifies an upper-bound on the number of new filters we are willing to
compute from scratch. Suppose that there are 'N' too-large filters, and
we specify '--max-new-filters=M'. If 'N >= M', it is unlikely that any
filters will be generated, since we'll spend most of our effort on
filters that we ultimately throw away. If 'N < M', filters will trickle
in over time, but only at most 'M - N' per-write.

To address this, add a new chunk which encodes a bitmap where the ith
bit is on iff the ith commit has zero or at least 512 changed paths.
When computing Bloom filters, first consult the relevant bitmap (in the
case that we are rolling up existing layers) to see if computing the
Bloom filter from scratch would be a waste of time.

This patch implements a new chunk instead of extending the existing BIDX
and BDAT chunks because modifying these chunks would confuse old
clients. For example, consider setting the most-significant bit in an
entry in the BIDX chunk to indicate that that filter is too-large. New
clients would understand how to interpret this, but old clients would
treat that entry as a really large filter.

By avoiding the need to move to new versions of the BDAT and BIDX chunk,
we can give ourselves more time to consider whether or not other
modifications to these chunks are worthwhile without holding up this
change.

Another approach would be to introduce a new BIDX chunk (say, one
identified by 'BID2') which is identical to the existing BIDX chunk,
except the most-significant bit of each offset is interpreted as "this
filter is too big" iff looking at a BID2 chunk. This avoids having to
write a bitmap, but forces older clients to rewrite their commit-graphs
(as well as reduces the theoretical largest Bloom filters we couldl
write, and forces us to maintain the code necessary to translate BIDX
chunks to BID2 ones).  Separately from this patch, I implemented this
alternate approach and did not find it to be advantageous.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 .../technical/commit-graph-format.txt         |  9 ++
 commit-graph.c                                | 85 ++++++++++++++++++-
 commit-graph.h                                |  2 +
 t/t4216-log-bloom.sh                          | 20 ++++-
 4 files changed, 112 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index 440541045d..a7191c03d3 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -123,6 +123,15 @@ CHUNK DATA:
       of length zero.
     * The BDAT chunk is present if and only if BIDX is present.
 
+  Large Bloom Filters (ID: {'B', 'F', 'X', 'L'}) [Optional]
+    * It contains a list of 'eword_t's (the length of this list is determined by
+      the width of the chunk) which is a bitmap. The 'i'th bit is set exactly
+      when the 'i'th commit in the graph has a changed-path Bloom filter with
+      zero entries (either because the commit is empty, or because it contains
+      more than 512 changed paths).
+    * The BFXL chunk is present on newer versions of Git iff the BIDX and BDAT
+      chunks are also present.
+
   Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
       This list of H-byte hashes describe a set of B commit-graph files that
       form a commit-graph chain. The graph position for the ith commit in this
diff --git a/commit-graph.c b/commit-graph.c
index d6ea556649..c870ffe0ed 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -41,8 +41,9 @@ void git_test_write_commit_graph_or_die(void)
 #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
 #define GRAPH_CHUNKID_BLOOMINDEXES 0x42494458 /* "BIDX" */
 #define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
+#define GRAPH_CHUNKID_BLOOMLARGE 0x4246584c /* "BFXL" */
 #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
-#define MAX_NUM_CHUNKS 7
+#define MAX_NUM_CHUNKS 8
 
 #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
 
@@ -429,6 +430,17 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 				graph->bloom_filter_settings->bits_per_entry = get_be32(data + chunk_offset + 8);
 			}
 			break;
+
+		case GRAPH_CHUNKID_BLOOMLARGE:
+			if (graph->bloom_large.word_alloc)
+				chunk_repeated = 1;
+			else if (r->settings.commit_graph_read_changed_paths) {
+				uint32_t alloc = get_be64(chunk_lookup + 4) - chunk_offset;
+
+				graph->bloom_large.word_alloc = alloc;
+				graph->bloom_large.words = (eword_t *)(data + chunk_offset);
+			}
+			break;
 		}
 
 		if (chunk_repeated) {
@@ -443,6 +455,8 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 		/* We need both the bloom chunks to exist together. Else ignore the data */
 		graph->chunk_bloom_indexes = NULL;
 		graph->chunk_bloom_data = NULL;
+		graph->bloom_large.words = NULL;
+		graph->bloom_large.word_alloc = 0;
 		FREE_AND_NULL(graph->bloom_filter_settings);
 	}
 
@@ -933,6 +947,21 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
 	return get_commit_tree_in_graph_one(r, r->objects->commit_graph, c);
 }
 
+static int get_bloom_filter_large_in_graph(struct commit_graph *g,
+					   const struct commit *c)
+{
+	uint32_t graph_pos = commit_graph_position(c);
+	if (graph_pos == COMMIT_NOT_FROM_GRAPH)
+		return 0;
+
+	while (g && graph_pos < g->num_commits_in_base)
+		g = g->base_graph;
+
+	if (!(g && g->bloom_large.word_alloc))
+		return 0;
+	return bitmap_get(&g->bloom_large, graph_pos - g->num_commits_in_base);
+}
+
 struct packed_oid_list {
 	struct object_id *list;
 	int nr;
@@ -969,6 +998,11 @@ struct write_commit_graph_context {
 	const struct split_commit_graph_opts *split_opts;
 	size_t total_bloom_filter_data_size;
 	const struct bloom_filter_settings *bloom_settings;
+	struct bitmap *bloom_large;
+
+	int count_bloom_filter_known_large;
+	int count_bloom_filter_found_large;
+	int count_bloom_filter_computed;
 };
 
 static int write_graph_chunk_fanout(struct hashfile *f,
@@ -1231,6 +1265,15 @@ static int write_graph_chunk_bloom_data(struct hashfile *f,
 	return 0;
 }
 
+static int write_graph_chunk_bloom_large(struct hashfile *f,
+					  struct write_commit_graph_context *ctx)
+{
+	trace2_region_enter("commit-graph", "bloom_large", ctx->r);
+	hashwrite(f, ctx->bloom_large->words, ctx->bloom_large->word_alloc * sizeof(eword_t));
+	trace2_region_leave("commit-graph", "bloom_large", ctx->r);
+	return 0;
+}
+
 static int oid_compare(const void *_a, const void *_b)
 {
 	const struct object_id *a = (const struct object_id *)_a;
@@ -1389,6 +1432,24 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
+static void trace2_bloom_filter_write_statistics(struct write_commit_graph_context *ctx)
+{
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	jw_object_intmax(&jw, "filter_known_large",
+			 ctx->count_bloom_filter_known_large);
+	jw_object_intmax(&jw, "filter_found_large",
+			 ctx->count_bloom_filter_found_large);
+	jw_object_intmax(&jw, "filter_computed",
+			 ctx->count_bloom_filter_computed);
+	jw_end(&jw);
+
+	trace2_data_json("commit-graph", the_repository, "bloom_statistics", &jw);
+
+	jw_release(&jw);
+}
+
 static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 {
 	int i;
@@ -1396,6 +1457,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 	int *sorted_commits;
 
 	init_bloom_filters();
+	ctx->bloom_large = bitmap_word_alloc(ctx->commits.nr / BITS_IN_EWORD);
 
 	if (ctx->report_progress)
 		progress = start_delayed_progress(
@@ -1412,11 +1474,24 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 	for (i = 0; i < ctx->commits.nr; i++) {
 		int pos = sorted_commits[i];
 		struct commit *c = ctx->commits.list[pos];
-		struct bloom_filter *filter = get_bloom_filter(ctx->r, c, 1);
-		ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
+		if (get_bloom_filter_large_in_graph(ctx->r->objects->commit_graph, c)) {
+			bitmap_set(ctx->bloom_large, pos);
+			ctx->count_bloom_filter_known_large++;
+		} else {
+			struct bloom_filter *filter = get_bloom_filter(ctx->r, c, 1);
+			if (!filter->len) {
+				bitmap_set(ctx->bloom_large, pos);
+				ctx->count_bloom_filter_found_large++;
+			}
+			ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
+			ctx->count_bloom_filter_computed++;
+		}
 		display_progress(progress, i + 1);
 	}
 
+	if (trace2_is_enabled())
+		trace2_bloom_filter_write_statistics(ctx);
+
 	free(sorted_commits);
 	stop_progress(&progress);
 }
@@ -1739,6 +1814,10 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 					  + ctx->total_bloom_filter_data_size;
 		chunks[num_chunks].write_fn = write_graph_chunk_bloom_data;
 		num_chunks++;
+		chunks[num_chunks].id = GRAPH_CHUNKID_BLOOMLARGE;
+		chunks[num_chunks].size = sizeof(eword_t) * ctx->bloom_large->word_alloc;
+		chunks[num_chunks].write_fn = write_graph_chunk_bloom_large;
+		num_chunks++;
 	}
 	if (ctx->num_commit_graphs_after > 1) {
 		chunks[num_chunks].id = GRAPH_CHUNKID_BASE;
diff --git a/commit-graph.h b/commit-graph.h
index d9acb22bac..afbc5fa41e 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -4,6 +4,7 @@
 #include "git-compat-util.h"
 #include "object-store.h"
 #include "oidset.h"
+#include "ewah/ewok.h"
 
 #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
 #define GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE "GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE"
@@ -71,6 +72,7 @@ struct commit_graph {
 	const unsigned char *chunk_base_graphs;
 	const unsigned char *chunk_bloom_indexes;
 	const unsigned char *chunk_bloom_data;
+	struct bitmap bloom_large;
 
 	struct bloom_filter_settings *bloom_filter_settings;
 };
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index b3d1f596f8..231dc8a3a7 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -33,7 +33,7 @@ test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
 	git commit-graph write --reachable --changed-paths
 '
 graph_read_expect () {
-	NUM_CHUNKS=5
+	NUM_CHUNKS=6
 	cat >expect <<- EOF
 	header: 43475048 1 1 $NUM_CHUNKS 0
 	num_commits: $1
@@ -195,5 +195,23 @@ test_expect_success 'correctly report changes over limit' '
 		done
 	)
 '
+test_bloom_filters_computed () {
+	commit_graph_args=$1
+	bloom_trace_prefix="{\"filter_known_large\":$2,\"filter_found_large\":$3,\"filter_computed\":$4"
+	rm -f "$TRASH_DIRECTORY/trace.event" &&
+	GIT_TRACE2_EVENT="$TRASH_DIRECTORY/trace.event" git commit-graph write $commit_graph_args &&
+	grep "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.event"
+}
+
+test_expect_success 'Bloom generation does not recompute too-large filters' '
+	(
+		cd 513changes &&
+		git commit-graph write --reachable --changed-paths \
+			--split=replace &&
+		test_commit c1 filter &&
+		test_bloom_filters_computed "--reachable --changed-paths --split=replace" \
+			1 0 1
+	)
+'
 
 test_done
-- 
2.28.0.rc1.13.ge78abce653

