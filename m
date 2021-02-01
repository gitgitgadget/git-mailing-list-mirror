Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF66C433E6
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48C9764EA2
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhBARQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 12:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbhBARP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 12:15:59 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D769CC06178A
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 09:15:18 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v15so17476029wrx.4
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 09:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eyNZXSqDn2Bp9zHj7N/Pnedr4Sz3TiBbmMc7XJKdqSo=;
        b=PI8DgN4Ham44R0UtHGMKNznYtv1mNbESWjYwuqzT7wQt6x9CU0tZwc0YKpAglKAKH5
         l5djG1uKv4uqdUZYzVGAjBHxjTiFSfSUBCOwz4JLtm9RCAUxKqDj1+nemrv+qFLeoSn0
         w+HXAFEu+JXlDJJlM+xk+BvpuY2VV+HzyUbeUle9juVzxJBuRd32Lewx7EcWzpgFQFSM
         RX/yVkW2jSVC/p86e5NJG7OBrQZLd/ZHBSd5ThhXYt+lvf7S5G8OPtl+OwUKt+J90B0R
         nY2Ab+ZRfh49Fimz/6PT0Mgq8ha6kpKufVDDj9SqpaA+at11gh8jOvFcBpX8/xkJmPfn
         r+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eyNZXSqDn2Bp9zHj7N/Pnedr4Sz3TiBbmMc7XJKdqSo=;
        b=UzqQT1ZBJjNWQ1+3QCDFCPK6Y0yWFV3eq28XqG42iwDiYXWWzyMMzvm3KWVOoHQ4sT
         f6/4ZOQw835cB6s//R74V7CVzImDLvl8lFGR7ZzPDRqEilmYU359Z84bKmdUzS0FKJR6
         vTP0KjW49RBFaMqxdY0u2g+Nq0M0rN3BmVbx65OTuEp7n6LPq+7pfg7H8Gb+Mi1y8Xte
         ClEZhBeFUjQjWNrDv/T/cicJd+G3PHyR+8if6QD/NMzaaxIgiN2wJKJVYLzVQgcGxn/0
         XBzdhqb4xWD33R27PQKCqZeKhKSU5DtxNVm2fsBvU/U/f511juXMFrKsgSa3JSD/jV5p
         WGXg==
X-Gm-Message-State: AOAM5307MrLNw8TY6lRs+1T1l0s3/frcHZsKa1Rf2nDJUq9dIgb2uzaR
        H9eC8EsX1bxR4HOiGbjCA9is1Ledgng=
X-Google-Smtp-Source: ABdhPJzyWc60mh+r4ceRmIvTFWJjIB3+Ztizicv0xhGhPI8STF8CmpOR3siZmUddHRvCPbBjnWniZQ==
X-Received: by 2002:adf:f452:: with SMTP id f18mr18821493wrp.11.1612199717421;
        Mon, 01 Feb 2021 09:15:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k6sm28635109wro.27.2021.02.01.09.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 09:15:16 -0800 (PST)
Message-Id: <dddeec30ebfc6d8403cc10395a9d0c331d1f7ad3.1612199707.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.850.git.1612199707.gitgitgadget@gmail.com>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 17:15:07 +0000
Subject: [PATCH 5/5] commit-graph: prepare commit graph
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, gister@pobox.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before checking if the repository has a commit-graph loaded, be sure
to run prepare_commit_graph(). This is necessary because without this
instance we would not initialize the topo_levels slab for each of the
struct commit_graphs in the chain before we start to parse the
commits. This leads to possibly recomputing the topological levels for
commits in lower layers even when we are adding a small number of
commits on top.

By properly initializing the topo_slab, we fix the previously broken
case of a split commit graph where a base layer has the
generation_data_overflow chunk.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 10 ++--------
 t/t5318-commit-graph.sh |  2 +-
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 08148dd17f1..858fa5594e3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2309,6 +2309,7 @@ int write_commit_graph(struct object_directory *odb,
 	init_topo_level_slab(&topo_levels);
 	ctx->topo_levels = &topo_levels;
 
+	prepare_commit_graph(ctx->r);
 	if (ctx->r->objects->commit_graph) {
 		struct commit_graph *g = ctx->r->objects->commit_graph;
 
@@ -2322,7 +2323,6 @@ int write_commit_graph(struct object_directory *odb,
 		ctx->changed_paths = 1;
 	if (!(flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {
 		struct commit_graph *g;
-		prepare_commit_graph_one(ctx->r, ctx->odb);
 
 		g = ctx->r->objects->commit_graph;
 
@@ -2334,10 +2334,7 @@ int write_commit_graph(struct object_directory *odb,
 	}
 
 	if (ctx->split) {
-		struct commit_graph *g;
-		prepare_commit_graph(ctx->r);
-
-		g = ctx->r->objects->commit_graph;
+		struct commit_graph *g = ctx->r->objects->commit_graph;
 
 		while (g) {
 			ctx->num_commit_graphs_before++;
@@ -2361,9 +2358,6 @@ int write_commit_graph(struct object_directory *odb,
 
 	ctx->approx_nr_objects = approximate_object_count();
 
-	if (ctx->append)
-		prepare_commit_graph_one(ctx->r, ctx->odb);
-
 	if (ctx->append && ctx->r->objects->commit_graph) {
 		struct commit_graph *g = ctx->r->objects->commit_graph;
 		for (i = 0; i < g->num_commits; i++) {
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 2cf29f425a0..5b15f1aa0f6 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -446,7 +446,7 @@ test_expect_success 'warn on improper hash version' '
 	)
 '
 
-test_expect_failure 'lower layers have overflow chunk' '
+test_expect_success 'lower layers have overflow chunk' '
 	cd "$TRASH_DIRECTORY/full" &&
 	UNIX_EPOCH_ZERO="@0 +0000" &&
 	FUTURE_DATE="@2147483646 +0000" &&
-- 
gitgitgadget
