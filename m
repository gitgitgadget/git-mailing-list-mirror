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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18001C433E6
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA58164E9C
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhBBDDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 22:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhBBDCi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 22:02:38 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB2AC0617A7
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 19:01:32 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 190so1072372wmz.0
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 19:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9X82xTzD0DtAhscl1U1xIpgUzeNPjHgAUzvkhzk+efk=;
        b=PtTWF+fTGo1685zTiTvZPzoV8Vqb6HaANil+fjUn9khSA1sITtfCneeGfXkrjiQ5ag
         FpIjBAQWpna2XS/RA49m9SO0akM5u9EZjAgCPZ+wbNwJAn/gzj36R6jLhmEJiXe0qZgp
         BRR8DsIz63EcxJ0PqpIzO6dGyNFq3auh2UwgTqAvdJsvrCEz92iBP7HRJU2TmfrZiL6F
         X7OKfuDPjlYZvPXGmdB2xHKA+iHtIgheR3j6i83hRKcYSprt/Zgm1G8WdnQqPFsrEl2q
         0Bn53pl2V4Gr5szJVWWa9mqTa3y4n73bkIiDmBv4w/GuN8jM8fc4nBvLSXnMjRBJfd3w
         SHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9X82xTzD0DtAhscl1U1xIpgUzeNPjHgAUzvkhzk+efk=;
        b=P7uLp5js8L4kKz3+Q+TL3dv+eN735eImMZEgnWvvL3tnIhilgpspoLoMasSfDmFprR
         PVFE8+PlJ21qT4OX1Qc8ZBQC/0xgJsxiQj5hjAUAnhgisLQBCxT4JudVlx3OjCmflGS8
         c8evj/pnimr04BDmVLLfeWeaZA2j5XkrLIe8Vzf1E2JhBBWIrtHs/KgXLkMyHzQbnOqm
         gHSZWZp4ICdWsbPOGO76NLcDfAe6c5mqaa8OKnYDVE/AilxihxiO/9eh9nS2EHUV4bIl
         6N1wo4nzPrVOGsGxMO1EERT7gLcbyz+ARWzhuYjYzbGT2joWH648UJZZyNoEjHtxu50D
         QP3A==
X-Gm-Message-State: AOAM530IB7p8dEETHyskRSLDoxPXButZxr1B5R1KMLALdqbbdHY+fjQH
        gV7jgv9EtljHEZU+uJLtJOSYH5U6wIM=
X-Google-Smtp-Source: ABdhPJxZ/MJ4FBtqCsIZTtvOPh209mjDLZinGwHPbg/eIaLd0FHaBcsdDqNuVcI29D1vKVeoEcNc/A==
X-Received: by 2002:a1c:2d8a:: with SMTP id t132mr1444153wmt.119.1612234890669;
        Mon, 01 Feb 2021 19:01:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q18sm29252036wrr.55.2021.02.01.19.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 19:01:30 -0800 (PST)
Message-Id: <38086c85b529f033d243746984227faf87e363d9.1612234883.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
        <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Feb 2021 03:01:23 +0000
Subject: [PATCH v2 6/6] commit-graph: prepare commit graph
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, gitster@pobox.com,
        abhishekkumar8222@gmail.com, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <ttaylorr@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before checking if the repository has a commit-graph loaded, be sure
to run prepare_commit_graph(). This is necessary because otherwise
the topo_levels slab is not initialized. As we compute topo_levels for
the new commits, we iterate further into the lower layers since the
first visit to each commit looks as though the topo_level is not
populated.

By properly initializing the topo_slab, we fix the previously broken
case of a split commit graph where a base layer has the
generation_data_overflow chunk.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 10 ++--------
 t/t5318-commit-graph.sh |  2 +-
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index ee8d5a0cdb4..94d3ab4a04f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2348,6 +2348,7 @@ int write_commit_graph(struct object_directory *odb,
 	init_topo_level_slab(&topo_levels);
 	ctx->topo_levels = &topo_levels;
 
+	prepare_commit_graph(ctx->r);
 	if (ctx->r->objects->commit_graph) {
 		struct commit_graph *g = ctx->r->objects->commit_graph;
 
@@ -2361,7 +2362,6 @@ int write_commit_graph(struct object_directory *odb,
 		ctx->changed_paths = 1;
 	if (!(flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {
 		struct commit_graph *g;
-		prepare_commit_graph_one(ctx->r, ctx->odb);
 
 		g = ctx->r->objects->commit_graph;
 
@@ -2373,10 +2373,7 @@ int write_commit_graph(struct object_directory *odb,
 	}
 
 	if (ctx->split) {
-		struct commit_graph *g;
-		prepare_commit_graph(ctx->r);
-
-		g = ctx->r->objects->commit_graph;
+		struct commit_graph *g = ctx->r->objects->commit_graph;
 
 		while (g) {
 			ctx->num_commit_graphs_before++;
@@ -2400,9 +2397,6 @@ int write_commit_graph(struct object_directory *odb,
 
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
