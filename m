Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755E9C352A1
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F93B217BA
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IA6OxXzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgBEW4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:56:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46287 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbgBEW4k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 17:56:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so4786079wrl.13
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 14:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6m4xmWPWp4PlfreM/halgzRcA6EhR3dmwcmBLoJ/LrQ=;
        b=IA6OxXzUBDfAWgSgar4OiRkQRAKwXVnN9yhMYIWNMIGNPzfaH5RUR99VlpAF/X78T3
         f93XEXL6OGQmTxfvFgSgZSuA1YjgrTzFfpQmI305zyZrLqIk2ZH6riIUXz/+duPGu4KF
         Igu3kPmAdq4FFmPyFaVsqies+SDmQ4F2+oYbvfQjHx+iO5fLiMbcdUk8udcWN+c48ZpI
         yyMiQ+2CX/julYPy2l87w1E3u0es8qIxagTJkSdmHavmbrsmxGpyPBCJ5hIwfb1967Nu
         8BUbq5/3H1XU47k3a7klR0vjaQ5p1+4TvZeGiYotVS1bjQ/Irkszko5Thv/l0IAIL7q7
         T9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6m4xmWPWp4PlfreM/halgzRcA6EhR3dmwcmBLoJ/LrQ=;
        b=BC2jQZ7BRdcAMIccdkWFFVJ9N6+SQSerUBMlAD+4Sf1k/FBU2aUDFExJb4DQLwqnCl
         55oy8qPGU6Vp2uBDuRB/jdL6l4vvXRj+4HI95qc9SDXcGr9cJI7OKVpz0QP9shzMeXGM
         cZ0E9HzNxpO04hIsWyczbTnN3rlWdEZTS3HYbpcZ99NDhq2bvYtNsXnb5rAdcI4TxXMe
         fpMikJGROho4TuO3H48y9RoL8DbN1qmfS9owgQYi/zw+I02jWR1bJ2WmnGVnJzxydg6m
         O5QdHJmoIF8FTeDu+nKinPXOlzGzzhDZbBynoFs6bLK9wkCCCLJAH7VLAwa8wPn3F1wH
         SN8g==
X-Gm-Message-State: APjAAAWpUqiguhWi3asGFfhJtGczomBNOtTMwE4i6+++oBiJAlWAOc1/
        lv1T7CV0hWI0zRKjeP1Jn8dB316Y
X-Google-Smtp-Source: APXvYqzlcKKOeDq/N/pQQpzUVBI11kN3DOsbn1GgV/42uph/Wirt2kVhpYsZt3dCDqoF7wEzhzy6Eg==
X-Received: by 2002:a5d:6a10:: with SMTP id m16mr155191wru.411.1580943397573;
        Wed, 05 Feb 2020 14:56:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9sm1171007wmj.28.2020.02.05.14.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 14:56:37 -0800 (PST)
Message-Id: <b20c8d2b2096bf10fe1a5f37a5181c57873a9676.1580943390.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Feb 2020 22:56:27 +0000
Subject: [PATCH v2 08/11] commit-graph: reuse existing Bloom filters during
 write.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        garimasigit@gmail.com, jnareb@gmail.com,
        christian.couder@gmail.com, emilyshaffer@gmail.com,
        gitster@pobox.com, Garima Singh <garima.singh@microsoft.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

Read previously computed Bloom filters from the commit-graph file if
possible to avoid recomputing during commit-graph write.

See Documentation/technical/commit-graph-format for the format in which
the Bloom filter information is written to the commit graph file.

To read Bloom filter for a given commit with lexicographic position
'i' we need to:
1. Read BIDX[i] which essentially gives us the starting index in BDAT for
   filter of commit i+1. It is essentially the index past the end
   of the filter of commit i. It is called end_index in the code.

2. For i>0, read BIDX[i-1] which will give us the starting index in BDAT
   for filter of commit i. It is called the start_index in the code.
   For the first commit, where i = 0, Bloom filter data starts at the
   beginning, just past the header in the BDAT chunk. Hence, start_index
   will be 0.

3. The length of the filter will be end_index - start_index, because
   BIDX[i] gives the cumulative 8-byte words including the ith
   commit's filter.

We toggle whether Bloom filters should be recomputed based on the
compute_if_null flag.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 bloom.c               | 49 ++++++++++++++++++++++++++++++++++++++++++-
 bloom.h               |  4 +++-
 commit-graph.c        |  7 ++++---
 t/helper/test-bloom.c |  2 +-
 4 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/bloom.c b/bloom.c
index 818382c03b..90d84dc713 100644
--- a/bloom.c
+++ b/bloom.c
@@ -1,5 +1,7 @@
 #include "git-compat-util.h"
 #include "bloom.h"
+#include "commit.h"
+#include "commit-slab.h"
 #include "commit-graph.h"
 #include "object-store.h"
 #include "diff.h"
@@ -127,8 +129,39 @@ void add_key_to_filter(struct bloom_key *key,
 	}
 }
 
+static int load_bloom_filter_from_graph(struct commit_graph *g,
+				   struct bloom_filter *filter,
+				   struct commit *c)
+{
+	uint32_t lex_pos, start_index, end_index;
+
+	while (c->graph_pos < g->num_commits_in_base)
+		g = g->base_graph;
+
+	/* The commit graph commit 'c' lives in doesn't carry bloom filters. */
+	if (!g->chunk_bloom_indexes)
+		return 0;
+
+	lex_pos = c->graph_pos - g->num_commits_in_base;
+
+	end_index = get_be32(g->chunk_bloom_indexes + 4 * lex_pos);
+
+	if (lex_pos)
+		start_index = get_be32(g->chunk_bloom_indexes + 4 * (lex_pos - 1));
+	else
+		start_index = 0;
+
+	filter->len = end_index - start_index;
+	filter->data = (uint64_t *)(g->chunk_bloom_data +
+					sizeof(uint64_t) * start_index +
+					BLOOMDATA_CHUNK_HEADER_SIZE);
+
+	return 1;
+}
+
 struct bloom_filter *get_bloom_filter(struct repository *r,
-				      struct commit *c)
+				      struct commit *c,
+				      int compute_if_not_present)
 {
 	struct bloom_filter *filter;
 	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
@@ -141,6 +174,20 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 
 	filter = bloom_filter_slab_at(&bloom_filters, c);
 
+	if (!filter->data) {
+		load_commit_graph_info(r, c);
+		if (c->graph_pos != COMMIT_NOT_FROM_GRAPH &&
+			r->objects->commit_graph->chunk_bloom_indexes) {
+			if (load_bloom_filter_from_graph(r->objects->commit_graph, filter, c))
+				return filter;
+			else
+				return NULL;
+		}
+	}
+
+	if (filter->data || !compute_if_not_present)
+		return filter;
+
 	repo_diff_setup(r, &diffopt);
 	diffopt.flags.recursive = 1;
 	diffopt.max_changes = max_changes;
diff --git a/bloom.h b/bloom.h
index 7f40c751f7..76f8a9ad0c 100644
--- a/bloom.h
+++ b/bloom.h
@@ -13,6 +13,7 @@ struct bloom_filter_settings {
 
 #define DEFAULT_BLOOM_FILTER_SETTINGS { 1, 7, 10 }
 #define BITS_PER_WORD 64
+#define BLOOMDATA_CHUNK_HEADER_SIZE 3*sizeof(uint32_t)
 
 /*
  * A bloom_filter struct represents a data segment to
@@ -47,7 +48,8 @@ void add_key_to_filter(struct bloom_key *key,
 					   struct bloom_filter_settings *settings);
 
 struct bloom_filter *get_bloom_filter(struct repository *r,
-				      struct commit *c);
+				      struct commit *c,
+				      int compute_if_not_present);
 
 int bloom_filter_contains(struct bloom_filter *filter,
 			  struct bloom_key *key,
diff --git a/commit-graph.c b/commit-graph.c
index 4585b3b702..c0e9834bf2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1094,7 +1094,7 @@ static void write_graph_chunk_bloom_indexes(struct hashfile *f,
 			ctx->commits.nr);
 
 	while (list < last) {
-		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
 		cur_pos += filter->len;
 		display_progress(progress, ++i);
 		hashwrite_be32(f, cur_pos);
@@ -1123,7 +1123,7 @@ static void write_graph_chunk_bloom_data(struct hashfile *f,
 	hashwrite_be32(f, settings->bits_per_entry);
 
 	while (list < last) {
-		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
 		display_progress(progress, ++i);
 		hashwrite(f, filter->data, filter->len * sizeof(uint64_t));
 		list++;
@@ -1304,7 +1304,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = sorted_by_pos[i];
-		struct bloom_filter *filter = get_bloom_filter(ctx->r, c);
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, c, 1);
 		ctx->total_bloom_filter_data_size += sizeof(uint64_t) * filter->len;
 		display_progress(progress, i + 1);
 	}
@@ -2314,6 +2314,7 @@ void free_commit_graph(struct commit_graph *g)
 		g->data = NULL;
 		close(g->graph_fd);
 	}
+	free(g->bloom_filter_settings);
 	free(g->filename);
 	free(g);
 }
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 331957011b..9b4be97f75 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -47,7 +47,7 @@ static void get_bloom_filter_for_commit(const struct object_id *commit_oid)
 	struct bloom_filter *filter;
 	setup_git_directory();
 	c = lookup_commit(the_repository, commit_oid);
-	filter = get_bloom_filter(the_repository, c);
+	filter = get_bloom_filter(the_repository, c, 1);
 	print_bloom_filter(filter);
 }
 
-- 
gitgitgadget

