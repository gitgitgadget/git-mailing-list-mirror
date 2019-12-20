Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7257CC2D0C8
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A15218AC
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU+Y0WKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfLTWFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:05:33 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40711 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfLTWFa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 17:05:30 -0500
Received: by mail-ed1-f65.google.com with SMTP id b8so9837374edx.7
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 14:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ytFH1tokHe1sswnBkZvQhsRyP6lKPRoIEjFKXG4uLOM=;
        b=BU+Y0WKk6MaXgqGL5JGdP91wiCfnZiCY/tfLZHuF5MniakyP+Zz0V9Kayw5woCJnmp
         QF9Kdq0hJdG56tYDhBEeA26gCpvH2hkSeHJfBZk04pS/iCuJCzpuce3/nHLu8gl+kUem
         7dscI7BmQyZN5HpcZDAF8yPNDEFc9C5wadyGAUCDcdxtuIsKhvHO16Dv29GYfbIg5TUD
         xoUczEHlIVXpaHO+P/uOOHIU9TTnf0lH6DdWm9g6+vcz2a10IFFmIpzxbLGIy7AAUH/6
         p2vcqK9o2BW6KMM9ssvyuCSs5s2MWJkTkEL0u+wnPF9myVi8Qximgv5Y+YEPMAH41lc3
         otqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ytFH1tokHe1sswnBkZvQhsRyP6lKPRoIEjFKXG4uLOM=;
        b=i8UOvIigOe0sAu5v6Ar1R6s2dPNHnQDFx9DB0ZXfkklyGFhPJg7wryLPJfVfRfLjkb
         DzeGAA2xt1B8TuFGe/jU1WezY057ThDyLT3Cx6Em3VsyKtZ6kNkVlf/d0zgS3XANQGFv
         pVsePZJiTv1m0v73i2JGOO09q6L/q3giV5miIL7dwd2Yd68fzKF4IeV6Jh742J82VQs0
         Zh/mgJtlk51OzIUluD05nQ3BT76g99EkTGNuIaqmr4kY0no3oaxQo4PAreYMvNd05DUZ
         sLeaKqOeSOD1LcQtmc29yzThj4Q/7Q49W7Qx9WYXX3wFOIBr7WzGBxyxX5IREVa/bRh8
         1/mw==
X-Gm-Message-State: APjAAAWGS3E2zPdIfiFMxMB5FmSJ+7nky3O+P7SA39/ii89Br2zPayVb
        ppD2kmdHoQ+zc56Y1gfP/diqK9fO
X-Google-Smtp-Source: APXvYqwRpz+AxM2EaEs7x9air5WLry7jlhWsb8bQKoScNhd5bOygY2CnGhLDHDWQr8BtxsAkkojTAg==
X-Received: by 2002:a17:906:8590:: with SMTP id v16mr1961924ejx.202.1576879528168;
        Fri, 20 Dec 2019 14:05:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k15sm1240785ejc.35.2019.12.20.14.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 14:05:27 -0800 (PST)
Message-Id: <1e2acb37ad710cb0d1c09ed163fdd4473a27335c.1576879520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.git.1576879520.gitgitgadget@gmail.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 22:05:18 +0000
Subject: [PATCH 7/9] commit-graph: reuse existing bloom filters during write.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

Read previously computed bloom filters from the commit-graph file if possible
to avoid recomputing during commit-graph write.

Reading from the commit-graph is based on the format in which bloom filters are
written in the commit graph file. See method `fill_filter_from_graph` in bloom.c

For reading the bloom filter for commit at lexicographic position i:
1. Read BIDX[i] which essentially gives us the starting index in BDAT for filter
   of commit i+1 (called the next_index in the code)

2. For i>0, read BIDX[i-1] which will give us the starting index in BDAT for
   filter of commit i (called the prev_index in the code)
   For i = 0, prev_index will be 0. The first lexicographic commit's filter will
   start at BDAT.

3. The length of the filter will be next_index - prev_index, because BIDX[i]
   gives the cumulative 8-byte words including the ith commit's filter.

We toggle whether bloom filters should be recomputed based on the compute_if_null
flag.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 bloom.c        | 40 ++++++++++++++++++++++++++++++++++++++--
 bloom.h        |  3 ++-
 commit-graph.c |  6 +++---
 3 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/bloom.c b/bloom.c
index 08328cc381..86b1005802 100644
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
@@ -119,13 +121,35 @@ static void add_key_to_filter(struct bloom_key *key,
 	}
 }
 
+static void fill_filter_from_graph(struct commit_graph *g,
+				   struct bloom_filter *filter,
+				   struct commit *c)
+{
+	uint32_t lex_pos, prev_index, next_index;
+
+	while (c->graph_pos < g->num_commits_in_base)
+		g = g->base_graph;
+
+	lex_pos = c->graph_pos - g->num_commits_in_base;
+
+	next_index = get_be32(g->chunk_bloom_indexes + 4 * lex_pos);
+	if (lex_pos)
+		prev_index = get_be32(g->chunk_bloom_indexes + 4 * (lex_pos - 1));
+	else
+		prev_index = 0;
+
+	filter->len = next_index - prev_index;
+	filter->data = (uint64_t *)(g->chunk_bloom_data + 8 * prev_index + 12);
+}
+
 void load_bloom_filters(void)
 {
 	init_bloom_filter_slab(&bloom_filters);
 }
 
 struct bloom_filter *get_bloom_filter(struct repository *r,
-				      struct commit *c)
+				      struct commit *c,
+				      int compute_if_null)
 {
 	struct bloom_filter *filter;
 	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
@@ -134,6 +158,18 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	const char *revs_argv[] = {NULL, "HEAD", NULL};
 
 	filter = bloom_filter_slab_at(&bloom_filters, c);
+
+	if (!filter->data) {
+		load_commit_graph_info(r, c);
+		if (c->graph_pos != COMMIT_NOT_FROM_GRAPH && r->objects->commit_graph->chunk_bloom_indexes) {
+			fill_filter_from_graph(r->objects->commit_graph, filter, c);
+			return filter;
+		}
+	}
+
+	if (filter->data || !compute_if_null)
+			return filter;
+
 	init_revisions(&revs, NULL);
 	revs.diffopt.flags.recursive = 1;
 
@@ -198,4 +234,4 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	DIFF_QUEUE_CLEAR(&diff_queued_diff);
 
 	return filter;
-}
\ No newline at end of file
+}
diff --git a/bloom.h b/bloom.h
index ba8ae70b67..101d689bbd 100644
--- a/bloom.h
+++ b/bloom.h
@@ -36,7 +36,8 @@ struct bloom_key {
 void load_bloom_filters(void);
 
 struct bloom_filter *get_bloom_filter(struct repository *r,
-				      struct commit *c);
+				      struct commit *c,
+				      int compute_if_null);
 
 void fill_bloom_key(const char *data,
 		    int len,
diff --git a/commit-graph.c b/commit-graph.c
index def2ade166..0580ce75d5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1032,7 +1032,7 @@ static void write_graph_chunk_bloom_indexes(struct hashfile *f,
 	uint32_t cur_pos = 0;
 
 	while (list < last) {
-		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
 		cur_pos += filter->len;
 		hashwrite_be32(f, cur_pos);
 		list++;
@@ -1051,7 +1051,7 @@ static void write_graph_chunk_bloom_data(struct hashfile *f,
 	hashwrite_be32(f, settings->bits_per_entry);
 
 	while (first < last) {
-		struct bloom_filter *filter = get_bloom_filter(ctx->r, *first);
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, *first, 0);
 		hashwrite(f, filter->data, filter->len * sizeof(uint64_t));
 		first++;
 	}
@@ -1218,7 +1218,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = ctx->commits.list[i];
-		struct bloom_filter *filter = get_bloom_filter(ctx->r, c);
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, c, 1);
 		ctx->total_bloom_filter_size += sizeof(uint64_t) * filter->len;
 		display_progress(progress, i + 1);
 	}
-- 
gitgitgadget

