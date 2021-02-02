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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3959EC433E6
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECFB664E9A
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhBBDC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 22:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhBBDCY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 22:02:24 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B816DC06178A
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 19:01:27 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id y187so1007716wmd.3
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 19:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=juCAe5atgoTFygs1wNmd/FGDKpeIjGfc51PxxQjB/ho=;
        b=TQ8lES/4YqltBEiemAyM3zSyLPdbQ5yIBjU2P+kjZtFeIzOzEVxrYKWIEEA35lUlSN
         4p3UbB1t5ovYjkvgpoFMpklQZ+kmxLjRregsLGrDtC+OmECtAB0jhLC9kkvGTOtYiBt5
         icizNNTwLtAJDWtvQxUYWMSdkdruBZiyB7W9hg6lLu7RDRUSwqXtooKJaBgaNBvCvTKF
         zcPuElXgF6cKkWyzZcO9238/LRh4q9T13DObVXzxG+RUlUkRnSXqCi7z/y8fe3HfKhQn
         uiSxkg6DBTG6ZDXuWDPdsKWJX3r/livzAzZzzoI9YByCdisoCylw4TwCrjoSeBNasbMe
         +QWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=juCAe5atgoTFygs1wNmd/FGDKpeIjGfc51PxxQjB/ho=;
        b=nRf25o77J0ug82raICsCm18BPv7g41zXWrthkbm7vRnVFXLqTluY4ygH+njXmPJ6aJ
         bwU9RA+ccFuNqdTCBTVLfGeII5IcbvrMCqVqCJSBEuH2XagLSDVdj/EBcX6+EWNGO0Ad
         15p4vTkwhmBFqfSQkfO88mfWOgOOmXoZ4BhkGezydMeneerDgZcE4y11EKxbruC4n5pW
         brStJRckryb4D/0KSc+5o1SRkPJ3oruoI61ZpN6u3TirLaCVVFyWTcxU9JzhsBHR/lsg
         neEuB73llVkhBAHIfjY+LQ5UftV8WP77ltHDVv0f9O+wMJqrg/lm3DXlnLFVUfo9baFN
         aqzA==
X-Gm-Message-State: AOAM531lWft7dA3r7J/XOxXXVPH4LmTB/sZLceAJIRoASslWAlMFNYzZ
        S0y0BFKG3rhoVeJ7DnzbHKout8xJ6ZI=
X-Google-Smtp-Source: ABdhPJyabaQDYmGSww9efXrXawOwuIZtB50D/ikojO/N/o+bRREx+/aeJ+xfNNmcSFXuu3w2jHoW1A==
X-Received: by 2002:a1c:8109:: with SMTP id c9mr1468092wmd.137.1612234885875;
        Mon, 01 Feb 2021 19:01:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m24sm68478wmi.24.2021.02.01.19.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 19:01:25 -0800 (PST)
Message-Id: <9c605c99f66cae3c66bcdd4cbeefbfa1ec2be192.1612234883.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
        <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Feb 2021 03:01:18 +0000
Subject: [PATCH v2 1/6] commit-graph: use repo_parse_commit
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

The write_commit_graph_context has a repository pointer, so use it.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 10 +++++-----
 commit.h       |  5 +++--
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f3bde2ad95a..03e5a987968 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1098,7 +1098,7 @@ static int write_graph_chunk_data(struct hashfile *f,
 		uint32_t packedDate[2];
 		display_progress(ctx->progress, ++ctx->progress_cnt);
 
-		if (parse_commit_no_graph(*list))
+		if (repo_parse_commit_no_graph(ctx->r, *list))
 			die(_("unable to parse commit %s"),
 				oid_to_hex(&(*list)->object.oid));
 		tree = get_commit_tree_oid(*list);
@@ -1411,11 +1411,11 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 		if (!commit)
 			continue;
 		if (ctx->split) {
-			if ((!parse_commit(commit) &&
+			if ((!repo_parse_commit(ctx->r, commit) &&
 			     commit_graph_position(commit) == COMMIT_NOT_FROM_GRAPH) ||
 			    flags == COMMIT_GRAPH_SPLIT_REPLACE)
 				add_missing_parents(ctx, commit);
-		} else if (!parse_commit_no_graph(commit))
+		} else if (!repo_parse_commit_no_graph(ctx->r, commit))
 			add_missing_parents(ctx, commit);
 	}
 	stop_progress(&ctx->progress);
@@ -1710,9 +1710,9 @@ static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 			continue;
 
 		if (ctx->split && flags == COMMIT_GRAPH_SPLIT_REPLACE)
-			parse_commit(ctx->commits.list[ctx->commits.nr]);
+			repo_parse_commit(ctx->r, ctx->commits.list[ctx->commits.nr]);
 		else
-			parse_commit_no_graph(ctx->commits.list[ctx->commits.nr]);
+			repo_parse_commit_no_graph(ctx->r, ctx->commits.list[ctx->commits.nr]);
 
 		num_parents = commit_list_count(ctx->commits.list[ctx->commits.nr]->parents);
 		if (num_parents > 2)
diff --git a/commit.h b/commit.h
index 251d877fcf6..b05ab558ce2 100644
--- a/commit.h
+++ b/commit.h
@@ -89,9 +89,10 @@ static inline int repo_parse_commit(struct repository *r, struct commit *item)
 	return repo_parse_commit_gently(r, item, 0);
 }
 
-static inline int parse_commit_no_graph(struct commit *commit)
+static inline int repo_parse_commit_no_graph(struct repository *r,
+					     struct commit *commit)
 {
-	return repo_parse_commit_internal(the_repository, commit, 0, 0);
+	return repo_parse_commit_internal(r, commit, 0, 0);
 }
 
 #ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
-- 
gitgitgadget

