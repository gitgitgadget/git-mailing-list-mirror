Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D6CC433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 18:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB66764F29
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 18:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhBYSUa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 13:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbhBYSU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 13:20:27 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BF4C06174A
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 10:19:46 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id 7so6209442wrz.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 10:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u1kdsosT9n6Lu0h/LPWhxFZy4wv+DQLiZ/jsLjy0kYg=;
        b=Vzmi6K7oWqE+1C6sOdxL93E0KPS7wH0XNNjIrIYvMi+bYBPwz/cH/11iQgYwluOKM6
         EbmF09TA8DmaoBXf3utVPIwu3SKEz8g9+Ye0njkZQf7+QM/fT20kzdyHmietTFLZFMFb
         icfkwcp0yW0zqLSzB4xFLRRuQP2g7kAElIjRj6ki+zkJhQZbTLUca9de/TmX6JgcGdY/
         OURBm1WaVGHiCebvdD/9w84tHyzyPyHrT1KRD3nOHXab4kju4yZHHo6msHNJQoksJ7nU
         QVO2Opjl6GKrZ7xry+gNhjQQ3tAlwwBgSAPzK4C7CRvnZFH8IZ3jY5U78pxcdTwImUlm
         rgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u1kdsosT9n6Lu0h/LPWhxFZy4wv+DQLiZ/jsLjy0kYg=;
        b=XsjvHreaD9dmjUmeDQf1/sZUO05XYbniW3M2oXaBrA8qJM3PA+qvSXPY2k6vP4NXWr
         EJ6HMwrTQkFrqrDbjILbh7f5Hni42wu2H6mbhQ6Wmg1JtJPy+Dm3ZAXr2STiwIyBA7y8
         RdZQVAqlSM6GYb1JVdRO7X5ThtC4S2csB14X2xxIxnJKGE0drhRleDDEPuMpvzoa1LEW
         1fE0znAkh8KBwxGrzj5qEScEU+uwFjQSf9+2AqoaUT9mOyLPAnyc9wKLg7mpoYQtQ4Ey
         AXtTGmgEZVPYF8YC9QGDczb7oyob4TD4OSxqbwbJ2VvisDcE3SwpW1fmeqddJduQOTUm
         lDyA==
X-Gm-Message-State: AOAM531GUZkurjG6gkxeKUN6G7XqtEeUjtOic2RbR9DVaA5SIPS+WkR3
        zNQc5P42mG24sMjH85eIMvHV2bbKtDk=
X-Google-Smtp-Source: ABdhPJwstX8nBvcsBLGO0rLSXExk6d0QI3Y8WpRDZJpOdWpGbOepdMTJaqHwhy21OsWuOwTmcytM4Q==
X-Received: by 2002:adf:f2c3:: with SMTP id d3mr4894560wrp.380.1614277185283;
        Thu, 25 Feb 2021 10:19:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r64sm8928812wma.33.2021.02.25.10.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 10:19:44 -0800 (PST)
Message-Id: <29b4ac5594dd039ee76f9f1b8630f13482aaa8f9.1614277183.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.886.git.1614277183.gitgitgadget@gmail.com>
References: <pull.886.git.1614277183.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Feb 2021 18:19:42 +0000
Subject: [PATCH 1/2] commit-graph: create local repository pointer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The write_commit_graph() method uses 'the_repository' in a few places. A
new need for a repository pointer is coming in the following change, so
group these instances into a local variable 'r' that could eventually
become part of the method signature, if so desired.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index b9efeddeab6c..8b07a9a0a6df 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2155,6 +2155,7 @@ int write_commit_graph(struct object_directory *odb,
 		       enum commit_graph_write_flags flags,
 		       const struct commit_graph_opts *opts)
 {
+	struct repository *r = the_repository;
 	struct write_commit_graph_context *ctx;
 	uint32_t i;
 	int res = 0;
@@ -2162,16 +2163,16 @@ int write_commit_graph(struct object_directory *odb,
 	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 	struct topo_level_slab topo_levels;
 
-	prepare_repo_settings(the_repository);
-	if (!the_repository->settings.core_commit_graph) {
+	prepare_repo_settings(r);
+	if (!r->settings.core_commit_graph) {
 		warning(_("attempting to write a commit-graph, but 'core.commitGraph' is disabled"));
 		return 0;
 	}
-	if (!commit_graph_compatible(the_repository))
+	if (!commit_graph_compatible(r))
 		return 0;
 
 	ctx = xcalloc(1, sizeof(struct write_commit_graph_context));
-	ctx->r = the_repository;
+	ctx->r = r;
 	ctx->odb = odb;
 	ctx->append = flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0;
 	ctx->report_progress = flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0;
-- 
gitgitgadget

