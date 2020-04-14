Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9ADC2BBFD
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 04:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4818206E9
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 04:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="w9vNubAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405069AbgDNEER (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 00:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405066AbgDNEEP (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 00:04:15 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1465DC0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 21:04:15 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v2so4186323plp.9
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 21:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ar0e0n4L/LwFcRhj8LwES+O7fGOMSRI95yDZn/Cd+Os=;
        b=w9vNubAW+BoiAtG2/qjdMemnX8xfcPfrnJ0PLFEA60/fjzBnxQ1qHpaItq+PFPF7nC
         HeuvXi2TizmZNTz8TthCrnncbXuwxUfJacwFX062aZ7VcRgFYdXy1O5cxDFfpNDCZvdN
         z144IX1QQj1e9JX7x0Y9D9+TNgLFedakK9pCWz6wbPjQ5hUNczLzQoE5amdksT/XfG9o
         FlKXsEX4I6rsrtmrBbC4/zP9MpQj+4eERb63INd0t2wt4+vN6lW5cdPa8qgVsEcFAoLK
         gGbL2oQI/ysfo5eAAcFjTLrJY2o5m6wb9Z4LHzGl0ETEAnNiJqsnzeezAlxq3GAfOBql
         dF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ar0e0n4L/LwFcRhj8LwES+O7fGOMSRI95yDZn/Cd+Os=;
        b=QLCNTtCxJ6EcSXUZZ+AKU9miePRVq9DKMFUDJqbHveM5MB389ilxRUxTctPm5ronSL
         c+yvvJyocjbwO1ihwo38Nx6lAOxo5ynbBVcVoqa/5oJ1z9oBYfWNUM46kGxhNsfj7/b7
         9/NS9zH+koCzTiCNf/8by3fstCAEqdUjzDVonjs9bKjZXKOuyvo5IP0x48VsmqEIO6Tk
         ggJbzN+cnZFLHkpk5/S/K5xGJ+7D2LeARz9t0NuacWWsZUQN0SxYIfB7IGpydoQbGebB
         gm77TQSNx5RQ+Rq41DyKlOpQYMCo+is0/WQVpQlm8WP6re2o27iHGlCsI2gp+B3KPxq8
         6TDg==
X-Gm-Message-State: AGi0PuaxtbjSo/2abXwNccrZFztwd6MOtpWixG2U9dccKPRSHrx/fFJA
        3Zhm/f9G5K1GhXm14pBEqNS1sAmUnXRcLX3a
X-Google-Smtp-Source: APiQypLRh5PE5JBPpcJDCuec9F7g60w0xyT0NMABNk68955N4yauB3DBqhih41L5ZyQsoHIEMJMWtw==
X-Received: by 2002:a17:902:eb13:: with SMTP id l19mr20397898plb.156.1586837054180;
        Mon, 13 Apr 2020 21:04:14 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id x26sm1485094pfo.218.2020.04.13.21.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 21:04:13 -0700 (PDT)
Date:   Mon, 13 Apr 2020 22:04:12 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Subject: [PATCH 3/7] builtin/commit-graph.c: introduce split strategy
 'no-merge'
Message-ID: <2741858596ce9cd48aa0e3d126310435166d37ab.1586836700.git.me@ttaylorr.com>
References: <cover.1586836700.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1586836700.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous commit, we laid the groundwork for supporting different
splitting strategies. In this commit, we introduce the first splitting
strategy: 'no-merge'.

Passing '--split=no-merge' is useful for callers which wish to write a
new incremental commit-graph, but do not want to spend effort condensing
the incremental chain [1]. Previously, this was possible by passing
'--size-multiple=0', but this no longer the case following 63020f175f
(commit-graph: prefer default size_mult when given zero, 2020-01-02).

When '--split=no-merge' is given, the commit-graph machinery will never
condense an existing chain, and it will always write a new incremental.

[1]: This might occur when, for example, a server administrator running
some program after each push may want to ensure that each job runs
proportional in time to the size of the push, and does not "jump" when
the commit-graph machinery decides to trigger a merge.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-commit-graph.txt |  5 +++++
 builtin/commit-graph.c             |  7 ++++++-
 commit-graph.c                     | 19 ++++++++++++-------
 commit-graph.h                     |  3 ++-
 t/t5324-split-commit-graph.sh      | 11 +++++++++++
 5 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 10d757c5cc..a4c4a641e5 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -63,6 +63,11 @@ chain of multiple commit-graph files stored in
 strategy and other splitting options. The new commits not already in the
 commit-graph are added in a new "tip" file. This file is merged with the
 existing file if the following merge conditions are met:
+* If `--split=no-merge` is specified, a merge is never performed, and
+the remaining options are ignored. A bare `--split` defers to the
+remaining options. (Note that merging a chain of commit graphs replaces
+the existing chain with a length-1 chain where the first and only
+incremental holds the entire graph).
 +
 * If `--size-multiple=<X>` is not specified, let `X` equal 2. If the new
 tip file would have `N` commits and the previous tip has `M` commits and
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 342094fc77..42182ed71c 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -121,11 +121,16 @@ static struct split_commit_graph_opts split_opts;
 static int write_option_parse_split(const struct option *opt, const char *arg,
 				    int unset)
 {
+	enum commit_graph_split_flags *flags = opt->value;
+
 	opts.split = 1;
 	if (!arg)
 		return 0;
 
-	die(_("unrecognized --split argument, %s"), arg);
+	if (!strcmp(arg, "no-merge"))
+		*flags = COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED;
+	else
+		die(_("unrecognized --split argument, %s"), arg);
 
 	return 0;
 }
diff --git a/commit-graph.c b/commit-graph.c
index f013a84e29..af3fe20bb5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1529,6 +1529,7 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 {
 	struct commit_graph *g;
 	uint32_t num_commits;
+	enum commit_graph_split_flags flags = COMMIT_GRAPH_SPLIT_UNSPECIFIED;
 	uint32_t i;
 
 	int max_commits = 0;
@@ -1539,21 +1540,25 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 
 		if (ctx->split_opts->size_multiple)
 			size_mult = ctx->split_opts->size_multiple;
+
+		flags = ctx->split_opts->flags;
 	}
 
 	g = ctx->r->objects->commit_graph;
 	num_commits = ctx->commits.nr;
 	ctx->num_commit_graphs_after = ctx->num_commit_graphs_before + 1;
 
-	while (g && (g->num_commits <= size_mult * num_commits ||
-		    (max_commits && num_commits > max_commits))) {
-		if (g->odb != ctx->odb)
-			break;
+	if (flags != COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED) {
+		while (g && (g->num_commits <= size_mult * num_commits ||
+			    (max_commits && num_commits > max_commits))) {
+			if (g->odb != ctx->odb)
+				break;
 
-		num_commits += g->num_commits;
-		g = g->base_graph;
+			num_commits += g->num_commits;
+			g = g->base_graph;
 
-		ctx->num_commit_graphs_after--;
+			ctx->num_commit_graphs_after--;
+		}
 	}
 
 	ctx->new_base_graph = g;
diff --git a/commit-graph.h b/commit-graph.h
index e799008ff4..8752afb88d 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -83,7 +83,8 @@ enum commit_graph_write_flags {
 };
 
 enum commit_graph_split_flags {
-	COMMIT_GRAPH_SPLIT_UNSPECIFIED = 0
+	COMMIT_GRAPH_SPLIT_UNSPECIFIED      = 0,
+	COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED = 1
 };
 
 struct split_commit_graph_opts {
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 53b2e6b455..1438d63f24 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -351,4 +351,15 @@ test_expect_success 'split across alternate where alternate is not split' '
 	test_cmp commit-graph .git/objects/info/commit-graph
 '
 
+test_expect_success '--split=no-merge always writes an incremental' '
+	test_when_finished rm -rf a b &&
+	rm -rf $graphdir $infodir/commit-graph &&
+	git reset --hard commits/2 &&
+	git rev-list HEAD~1 >a &&
+	git rev-list HEAD >b &&
+	git commit-graph write --split --stdin-commits <a &&
+	git commit-graph write --split=no-merge --stdin-commits <b &&
+	test_line_count = 2 $graphdir/commit-graph-chain
+'
+
 test_done
-- 
2.26.0.106.g9fadedd637

