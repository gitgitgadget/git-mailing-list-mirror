Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F96C433E1
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 09:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A4292082F
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 09:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQOKIsLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgFQJQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgFQJQY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 05:16:24 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D75C061573
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 02:16:24 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id m2so729492pjv.2
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 02:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WSarGbZhPLgwcPVKPXtGQ3pDmuwQ7O06TtHEYG7Keus=;
        b=WQOKIsLLdZU5HnSofd9CxhWdUDNIo8BZhW4bK37vR//rpTCinb15UEXidS1f/5A4FE
         HVpw4A6UvyPXKA+F9brSFJyAa7jjRur8+9UMXW+j5RckeLTpRS0o84ndRhzrslhlb9xo
         N0Xa+aYhJr9R2/WxQvJQuaWGG9OdLx4Kmea94rvh2VtrgcX1LH9zzLaI43TvUx9E+BUX
         joqtmtzt42al5kMU82zBLZJQNP/9o65WdfIBbNTuGS9wN5o+wtHqpe8iX7xAJQYm0dwG
         oNNBoQ9MjdRPiicPzPSGcAI+1g5hJBBNg83sZKgR73b3yUpvbk++6AHmUo0xmRK6TjWK
         Jb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSarGbZhPLgwcPVKPXtGQ3pDmuwQ7O06TtHEYG7Keus=;
        b=Vmb7GWYR+CVn6igsRGAKAouNhriRIMwr9KNWx3rezJz8KYCeFbXdfhrWpeI0t6M8JN
         iuyi4Y2kJ7kXkN0hFTfgSclFkteD8mSBqJ9WhMC1wzDGz+cCvEgXSIoI4LondKZxwsYC
         btF0FqOGiU8sN5wE8404wLe7UdjkyUyYN7Q0iV4+ktA/yjq1CXDIC0NnkyUUnCzIfpDM
         7oCavcOrZNrQ3AfpZa0OY3SgYQdjxYJIGzsohwOIQ3m2Vs9+3Fimzhz23+f0o5rf22OL
         Bce3k3taUVcjP7m7q36YsA3Czrh3vgNsZ9ze7+6/urJck0q24BUlduCsfHXIjl4GmYWE
         Xn/w==
X-Gm-Message-State: AOAM530fUmritK1Zk7tGDfMPXdj3GHV3VX2YsUkBX6PwphPjwadJcCEP
        OSuZjXZe9gYhbpJ2xVqHJIcF3nAT
X-Google-Smtp-Source: ABdhPJzI1MoqpN63n7z2hfYuQHbPArlqS+SvycvXFWjIfh0obGRLk96LHW8fc6vKqzbkiBrdNbwYZg==
X-Received: by 2002:a17:902:ab8e:: with SMTP id f14mr6035873plr.80.1592385383565;
        Wed, 17 Jun 2020 02:16:23 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:40b:ccca:8c2b:e6b:e670:4483])
        by smtp.gmail.com with ESMTPSA id r8sm17162110pgn.19.2020.06.17.02.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 02:16:22 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, stolee@gmail.com
Subject: [GSOC Patch v4 2/4] commit-graph: introduce commit_graph_data_slab
Date:   Wed, 17 Jun 2020 14:44:09 +0530
Message-Id: <20200617091411.14650-3-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617091411.14650-1-abhishekkumar8222@gmail.com>
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
 <20200617091411.14650-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The struct commit is used in many contexts. However, members
`generation` and `graph_pos` are only used for commit-graph related
operations and otherwise waste memory.

This wastage would have been more pronounced as we transition to
generation number v2, which uses 64-bit generation number instead of
current 32-bits.

As they are often accessed together, let's introduce struct
commit_graph_data and move them to a commit_graph_data slab.

While the overall test suite runs just as fast as master,
(series: 26m48s, master: 27m34s, faster by 2.87%), certain commands
like `git merge-base --is-ancestor` were slowed by 40% as discovered
by Szeder Gábor [1]. After minimizing commit-slab access, the slow down
persists but is closer to 20%.

Derrick Stolee believes the slow down is attributable to the underlying
algorithm rather than the slowness of commit-slab access [2] and we will
follow-up in a later series.

[1]: https://lore.kernel.org/git/20200607195347.GA8232@szeder.dev/
[2]: https://lore.kernel.org/git/13db757a-9412-7f1e-805c-8a028c4ab2b1@gmail.com/

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---

On linux.git with HEAD at 08bf1a27 (Merge tag 'powerpc-5.8-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux,
2020-06-13):

`git merge-base --is-ancestor HEAD~50000 HEAD`
Time (master):    0.787s
Time (series):    0.927s
Change:           17.79%    (slower)

Max RSS (master): 177694kb
Max RSS (series): 177707kb
Change:           0.01%     (more)

`git gc`
Time (master):    3m55s
Time (series):    3m38s
Change:           7.23%     (faster)

Max RSS (master): 4889868kb
Max RSS (series): 4911960kb
Change:           0.45%     (more)

Earlier implementation of commit_graph_data_at() was incorrect, as we
used to iterate from old slab count to new slab count - assuming all
intermediate slabs are allocated. This is incorrect as the slabs are
allocated only when there's a corresponding commit.

It now makes *two slab accesses* in the worst case, but it's okay since
the worst case occurs once nearly every (512kb / 8b) commits.

 commit-graph.c | 78 +++++++++++++++++++++++++++++++++++++++++++-------
 commit-graph.h | 10 +++++++
 2 files changed, 78 insertions(+), 10 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 2ff042fbf4..8ad7d202b2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -87,6 +87,58 @@ static int commit_pos_cmp(const void *va, const void *vb)
 	       commit_pos_at(&commit_pos, b);
 }
 
+define_commit_slab(commit_graph_data_slab, struct commit_graph_data);
+static struct commit_graph_data_slab commit_graph_data_slab =
+	COMMIT_SLAB_INIT(1, commit_graph_data_slab);
+
+uint32_t commit_graph_position(const struct commit *c)
+{
+	struct commit_graph_data *data =
+		commit_graph_data_slab_peek(&commit_graph_data_slab, c);
+
+	return data ? data->graph_pos : COMMIT_NOT_FROM_GRAPH;
+}
+
+uint32_t commit_graph_generation(const struct commit *c)
+{
+	struct commit_graph_data *data =
+		commit_graph_data_slab_peek(&commit_graph_data_slab, c);
+
+	if (!data)
+		return GENERATION_NUMBER_INFINITY;
+	else if (data->graph_pos == COMMIT_NOT_FROM_GRAPH)
+		return GENERATION_NUMBER_INFINITY;
+
+	return data->generation;
+}
+
+static struct commit_graph_data *commit_graph_data_at(const struct commit *c)
+{
+	unsigned int i, nth_slab;
+	struct commit_graph_data *data =
+		commit_graph_data_slab_peek(&commit_graph_data_slab, c);
+
+	if (data)
+		return data;
+
+	nth_slab = c->index / commit_graph_data_slab.slab_size;
+	data = commit_graph_data_slab_at(&commit_graph_data_slab, c);
+
+	/*
+	 * commit-slab initializes elements with zero, overwrite this with
+	 * COMMIT_NOT_FROM_GRAPH for graph_pos.
+	 *
+	 * We avoid initializing generation with checking if graph position
+	 * is not COMMIT_NOT_FROM_GRAPH.
+	 */
+	for (i = 0; i < commit_graph_data_slab.slab_size; i++) {
+		commit_graph_data_slab.slab[nth_slab][i].graph_pos =
+			COMMIT_NOT_FROM_GRAPH;
+	}
+
+	return data;
+}
+
 static int commit_gen_cmp(const void *va, const void *vb)
 {
 	const struct commit *a = *(const struct commit **)va;
@@ -1020,7 +1072,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 		else
 			packedDate[0] = 0;
 
-		packedDate[0] |= htonl((*list)->generation << 2);
+		packedDate[0] |= htonl(commit_graph_data_at(*list)->generation << 2);
 
 		packedDate[1] = htonl((*list)->date);
 		hashwrite(f, packedDate, 8);
@@ -1251,9 +1303,11 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 					_("Computing commit graph generation numbers"),
 					ctx->commits.nr);
 	for (i = 0; i < ctx->commits.nr; i++) {
+		uint32_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
+
 		display_progress(ctx->progress, i + 1);
-		if (ctx->commits.list[i]->generation != GENERATION_NUMBER_INFINITY &&
-		    ctx->commits.list[i]->generation != GENERATION_NUMBER_ZERO)
+		if (generation != GENERATION_NUMBER_INFINITY &&
+		    generation != GENERATION_NUMBER_ZERO)
 			continue;
 
 		commit_list_insert(ctx->commits.list[i], &list);
@@ -1264,22 +1318,26 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 			uint32_t max_generation = 0;
 
 			for (parent = current->parents; parent; parent = parent->next) {
-				if (parent->item->generation == GENERATION_NUMBER_INFINITY ||
-				    parent->item->generation == GENERATION_NUMBER_ZERO) {
+				generation = commit_graph_data_at(parent->item)->generation;
+
+				if (generation == GENERATION_NUMBER_INFINITY ||
+				    generation == GENERATION_NUMBER_ZERO) {
 					all_parents_computed = 0;
 					commit_list_insert(parent->item, &list);
 					break;
-				} else if (parent->item->generation > max_generation) {
-					max_generation = parent->item->generation;
+				} else if (generation > max_generation) {
+					max_generation = generation;
 				}
 			}
 
 			if (all_parents_computed) {
-				current->generation = max_generation + 1;
+				struct commit_graph_data *data = commit_graph_data_at(current);
+
+				data->generation = max_generation + 1;
 				pop_commit(&list);
 
-				if (current->generation > GENERATION_NUMBER_MAX)
-					current->generation = GENERATION_NUMBER_MAX;
+				if (data->generation > GENERATION_NUMBER_MAX)
+					data->generation = GENERATION_NUMBER_MAX;
 			}
 		}
 	}
diff --git a/commit-graph.h b/commit-graph.h
index 3ba0da1e5f..28f89cdf3e 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -135,4 +135,14 @@ void free_commit_graph(struct commit_graph *);
  */
 void disable_commit_graph(struct repository *r);
 
+struct commit_graph_data {
+	uint32_t graph_pos;
+	uint32_t generation;
+};
+
+/*
+ * Commits should be parsed before accessing generation, graph positions.
+ */
+uint32_t commit_graph_generation(const struct commit *);
+uint32_t commit_graph_position(const struct commit *);
 #endif
-- 
2.27.0

