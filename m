Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD4DC433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B0020716
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="dNmEWDJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgICWqt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbgICWqr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 18:46:47 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A03AC061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 15:46:47 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w186so4732422qkd.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 15:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FMxZe3e6Xgq5gCG5T0iRw0yuB/plFuoFTEvtL6UqiRs=;
        b=dNmEWDJRt+oZGIptzW8MMB1SJInTeUhby5hpxBuThCh2S7ueHLEENesL/yatIcBxAf
         cvvJaKi70ZpPlPLBAP6a2YKzuXncj8nSvDrj1+6Gys8piRsh8NXllc68KuXCVHZXgsrE
         yxg5AR2ez0U5Fpe4ZPLc2UcUBWGUU7BtAKw5V9oNeyLgc2Q4Z2+Dwf5eqJ6vTF7gCZaU
         2/FT/3ZmJ2ZERJS3nISamYGaV2IGl2vXvd9rj6JgFEUFyKcdtLX11G4Bex4KrZPlGfgu
         ArieNPj0gS/Y/qCH8Oaoux4vDeHiUrRwXA6m2dPOzvPtANKHLW+vfwxw5wn9GZVrzBoV
         +HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FMxZe3e6Xgq5gCG5T0iRw0yuB/plFuoFTEvtL6UqiRs=;
        b=jen0hYkCo4joEdA8Z+OCKtLZ9w4ZuwmZEc6mnNznmv3m2oXFDM8y64Fhawm71TZA+0
         NpYFpDTqbK+ZCIY0pQmHvXUvmAz2IM5TE2IaDMJwTu3/aiSBh3vLg7vsd9bwTf4B2xQH
         3TxkIuucZNKTrYzCKsek5qoittPFnda8BdgR/l6UJ2JVisPRWq150KoIgI2oWljp4inQ
         prAukho1PVpm46pob0tzYrwekLUOxOKXZpt5xeYeQw5fXGd3pP4c7Rpfrzj6JmdYhjXr
         RZYqiYvaUkTw4dr1qBq2p5M7zxOfuoUOyPB2slI7tuGGTL6iOU1PZp8VxnLXVj7HgK7O
         EbVw==
X-Gm-Message-State: AOAM5332AYR6VXBqbwdDlp8eczBoxTGfifuYd8z/RE8r4uRpK8WNRr+N
        h2LXbwzA0FjZzmDJH4PpwFh05S61txFaDzob
X-Google-Smtp-Source: ABdhPJzJxeINYchx9gRhjfqExBrNVFmaZBqPX7S3FYhtstd1DRLrY6blHJOKOPsO99aN32ZacL7btA==
X-Received: by 2002:a37:8047:: with SMTP id b68mr5069769qkd.299.1599173205981;
        Thu, 03 Sep 2020 15:46:45 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a97c:6dae:76a4:c715])
        by smtp.gmail.com with ESMTPSA id v39sm3186013qtv.47.2020.09.03.15.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:46:45 -0700 (PDT)
Date:   Thu, 3 Sep 2020 18:46:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v4 10/14] commit-graph.c: sort index into commits list
Message-ID: <08b5f185f615de5d43e2397ae58730e82b18b7dd.1599172908.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1599172907.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1599172907.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For locality, 'compute_bloom_filters()' sorts the commits for which it
wants to compute Bloom filters in a preferred order (cf., 3d11275505
(commit-graph: examine commits by generation number, 2020-03-30) for
details).

A future patch will want to recover the new graph position of each
commit. Since the 'packed_commit_list' already stores a double-pointer,
avoid a 'COPY_ARRAY' and instead keep track of an index into the
original list. (Use an integer index instead of a memory address, since
this involves a needlessly confusing triple-pointer).

Alter the two sorting routines 'commit_pos_cmp' and 'commit_gen_cmp' to
take into account the packed_commit_list they are sorting with respect
to. Since 'compute_bloom_filters()' is the only caller for each of those
comparison functions, no other call-sites need updating.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 7ba9ae26e1..35535f4192 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -79,10 +79,18 @@ static void set_commit_pos(struct repository *r, const struct object_id *oid)
 	*commit_pos_at(&commit_pos, commit) = max_pos++;
 }
 
-static int commit_pos_cmp(const void *va, const void *vb)
+struct packed_commit_list {
+	struct commit **list;
+	int nr;
+	int alloc;
+};
+
+static int commit_pos_cmp(const void *va, const void *vb, void *ctx)
 {
-	const struct commit *a = *(const struct commit **)va;
-	const struct commit *b = *(const struct commit **)vb;
+	struct packed_commit_list *commits = ctx;
+
+	const struct commit *a = commits->list[*(int *)va];
+	const struct commit *b = commits->list[*(int *)vb];
 	return commit_pos_at(&commit_pos, a) -
 	       commit_pos_at(&commit_pos, b);
 }
@@ -139,10 +147,12 @@ static struct commit_graph_data *commit_graph_data_at(const struct commit *c)
 	return data;
 }
 
-static int commit_gen_cmp(const void *va, const void *vb)
+static int commit_gen_cmp(const void *va, const void *vb, void *ctx)
 {
-	const struct commit *a = *(const struct commit **)va;
-	const struct commit *b = *(const struct commit **)vb;
+	struct packed_commit_list *commits = ctx;
+
+	const struct commit *a = commits->list[*(int *)va];
+	const struct commit *b = commits->list[*(int *)vb];
 
 	uint32_t generation_a = commit_graph_generation(a);
 	uint32_t generation_b = commit_graph_generation(b);
@@ -929,11 +939,6 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
 	return get_commit_tree_in_graph_one(r, r->objects->commit_graph, c);
 }
 
-struct packed_commit_list {
-	struct commit **list;
-	int nr;
-	int alloc;
-};
 
 struct packed_oid_list {
 	struct object_id *list;
@@ -1415,7 +1420,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 {
 	int i;
 	struct progress *progress = NULL;
-	struct commit **sorted_commits;
+	int *sorted_commits;
 
 	init_bloom_filters();
 
@@ -1425,16 +1430,16 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 			ctx->commits.nr);
 
 	ALLOC_ARRAY(sorted_commits, ctx->commits.nr);
-	COPY_ARRAY(sorted_commits, ctx->commits.list, ctx->commits.nr);
-
-	if (ctx->order_by_pack)
-		QSORT(sorted_commits, ctx->commits.nr, commit_pos_cmp);
-	else
-		QSORT(sorted_commits, ctx->commits.nr, commit_gen_cmp);
+	for (i = 0; i < ctx->commits.nr; i++)
+		sorted_commits[i] = i;
+	QSORT_S(sorted_commits, ctx->commits.nr,
+		ctx->order_by_pack ? commit_pos_cmp : commit_gen_cmp,
+		&ctx->commits);
 
 	for (i = 0; i < ctx->commits.nr; i++) {
 		int computed = 0;
-		struct commit *c = sorted_commits[i];
+		int pos = sorted_commits[i];
+		struct commit *c = ctx->commits.list[pos];
 		struct bloom_filter *filter = get_or_compute_bloom_filter(
 			ctx->r,
 			c,
-- 
2.27.0.2918.gc99a27ff8f

