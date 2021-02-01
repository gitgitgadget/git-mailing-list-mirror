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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1108CC433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B771464EAC
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhBARPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 12:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhBARPw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 12:15:52 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2550C06174A
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 09:15:11 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a1so17456410wrq.6
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 09:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=juCAe5atgoTFygs1wNmd/FGDKpeIjGfc51PxxQjB/ho=;
        b=qkSz8i8116W3fK2B3ZcfQdg3NKJHj2fy2+aOHQnXXlZM+KHhtWfD59bbmm5smjsWzX
         hrT4VQABxSDYVhUZ+YkAx2TufGqejq9R3tbCNdKgWyEVRvsBKem3t7AIYBp5T8DGWdoX
         1IZRCcSnLczYFAYDfvEXbQ9wSq2Fy50Kc0vJhQ89nD/6Y72rGWlH9xgT4Ba4RRx45gCj
         eDoxfyLniZPF2t+DjSNdoFuga4fLQ2YDNbSoFIoGss3Cpfoa/Lm5FAuYmZFzKpzh0HbS
         3P0qp/dH+lfXPWaD1b2q3AWZZgA3H3/xCYC70uB/WSVoc3B4yv00Oc0HHVV6UeNbqU//
         agbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=juCAe5atgoTFygs1wNmd/FGDKpeIjGfc51PxxQjB/ho=;
        b=izksorTCH2XXfqTXQ4oAUcRkNmtwOnGwQmn088b+YojlM2+dtHtVYPvrYoK/6Ipj4T
         CxdtKvQE3Fc9PCezGUmiFDcS1JaWD1CckoUsjhygkDzkqYW5w+JCfy8EKhuY0j54IVkw
         B1pbhS7sg7PIq54milG28P0GRM16i5bmUwA5zLMKLtOPbzAEXYM2Gc56PPjaaGL9y9tZ
         PWwCuA77HrjDrW9uDABhi+V5s7FWFedzCAsJ18zgbl6dsTRc6jAHutdqSoGpDzkEcScr
         UcvuVqLjR/IfMy0bUlUjxU04FQK+Zqo8HNUZH3JTCNGQxAOpA5xbo5IdLMRXjZT3JREB
         G/Ug==
X-Gm-Message-State: AOAM530KKpdr5mXW7M2HKGuXcMA4Rq5Rf3gmnev4FlzZTfdJP0jIlRc3
        fSlkR6t/xEjqJUHgoW70gzIrFdOYi20=
X-Google-Smtp-Source: ABdhPJzDYIAyuaRZVHLqm81KfnMr4OWpWMqqLeFXwjvrjg+6LRHyAQ30T4iD+Wy25PQNM6jL+W3WJg==
X-Received: by 2002:a5d:51cf:: with SMTP id n15mr18738843wrv.303.1612199710304;
        Mon, 01 Feb 2021 09:15:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r16sm6490239wrt.68.2021.02.01.09.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 09:15:09 -0800 (PST)
Message-Id: <9c605c99f66cae3c66bcdd4cbeefbfa1ec2be192.1612199707.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.850.git.1612199707.gitgitgadget@gmail.com>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 17:15:03 +0000
Subject: [PATCH 1/5] commit-graph: use repo_parse_commit
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

