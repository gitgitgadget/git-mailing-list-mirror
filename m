Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A9BC43457
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 20:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C1722277
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 20:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVKuNaL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390973AbgJIUx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 16:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389356AbgJIUx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 16:53:56 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60286C0613D2
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 13:53:56 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h5so1561636wrv.7
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 13:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dZLIP6xGo63Xo8OA4xHvE/Nxj3Ho23BLjGD1w4jBW7I=;
        b=IVKuNaL81B4Am4RlH8LmzxNbbfU89DqPR2ra6UDcKmSBiJBFIAlWYG/4/aFLjPi1Ft
         0ZtePK+zlNi4/vSoNIG/oW7Whe0SSM/xGytQPK38SJQiDolR1ufUKLeQ6gm9b3gJSSBS
         MIV9Y+ioA7rkfO4npC9pw+dQHMBphVd5XTS6GLk6gIUZc8BrZOTG11IoQoDHk+ggiTpH
         Uwvjn+3zZcr6hzsXk3ZKpQhq/CdatIFNdigsc41ptgzl8otBwYpprJzSOlD2ZkeMSUcb
         QA+XMqJ/lAJUbShN2VaPoazbHmqAmwnbe5O4/y77lV5TBBMRILL0kHvRXN2vRaLe6l9W
         cUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dZLIP6xGo63Xo8OA4xHvE/Nxj3Ho23BLjGD1w4jBW7I=;
        b=O2OJTsfEOt41Oyc0202D6FJSbFmsJW0o2dSyiSKHEZgjMvJvpLhQrW9uDCLQpPdW0P
         2ht++3Drg0ModHT90lCAwRgJBPVVEByYeTsusl1hu50D7NWmCupa0cq0/Bc+OnRBrezm
         iFjZ57fuZDjL9pu18l+37RaL6PlThAOTSBKA+UjduRS7OelnEc4l7We6IhVg+82LhAZF
         BQzPwX977smN70vswNgBYbtQst2SuxvRubhbeDHRhMbpQPbz8MzcUeOimy285H8R/InA
         lo7hBV8es3oSpNfWTvGnwq31tITmwaON8/Md/eHpsf3U05hGzLkefsaBbQaodHm1BSF0
         jPhg==
X-Gm-Message-State: AOAM5313GzVLzUpDUzJmbN1plRW0hoUndXSnCX7zwAEuhxASSV/KeIjc
        sM9+Pb3XkGHVOzVJzSAzakHNPZ1/J64=
X-Google-Smtp-Source: ABdhPJzdsh3jqhE7u3+CQKk15/Byvl/Kf8eNdEssTZKxm8VAAl9w+XLusm1yiRCYefaukOh/fn6byw==
X-Received: by 2002:adf:c3c2:: with SMTP id d2mr17455670wrg.191.1602276834781;
        Fri, 09 Oct 2020 13:53:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k8sm12838399wrl.42.2020.10.09.13.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 13:53:54 -0700 (PDT)
Message-Id: <9279aea3ef7aa98996e182c0d1bf41cc179b8146.1602276832.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.747.v4.git.1602276832.gitgitgadget@gmail.com>
References: <pull.747.v3.git.1602169479482.gitgitgadget@gmail.com>
        <pull.747.v4.git.1602276832.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Oct 2020 20:53:51 +0000
Subject: [PATCH v4 1/2] commit-graph: ignore duplicates when merging layers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Thomas reported [1] that a "git fetch" command was failing with an error
saying "unexpected duplicate commit id". The root cause is that they had
fetch.writeCommitGraph enabled which generates commit-graph chains, and
this instance was merging two layers that both contained the same commit
ID.

[1] https://lore.kernel.org/git/55f8f00c-a61c-67d4-889e-a9501c596c39@virtuell-zuhause.de/

The initial assumption is that Git would not write a commit ID into a
commit-graph layer if it already exists in a lower commit-graph layer.
Somehow, this specific case did get into that situation, leading to this
error.

While unexpected, this isn't actually invalid (as long as the two layers
agree on the metadata for the commit). When we parse a commit that does
not have a graph_pos in the commit_graph_data_slab, we use binary search
in the commit-graph layers to find the commit and set graph_pos. That
position is never used again in this case. However, when we parse a
commit from the commit-graph file, we load its parents from the
commit-graph and assign graph_pos at that point. If those parents were
already parsed from the commit-graph, then nothing needs to be done.
Otherwise, this graph_pos is a valid position in the commit-graph so we
can parse the parents, when necessary.

Thus, this die() is too aggressive. The easiest thing to do would be to
ignore the duplicates.

If we only ignore the duplicates, then we will produce a commit-graph
that has identical commit IDs listed in adjacent positions. This excess
data will never be removed from the commit-graph, which could cascade
into significantly bloated file sizes.

Thankfully, we can collapse the list to erase the duplicate commit
pointers. This allows us to get the end result we want without extra
memory costs and minimal CPU time.

The root cause is due to disabling core.commitGraph, which prevents
parsing commits from the lower layers during a 'git commit-graph write
--split' command. Since we use the 'graph_pos' value to determine
whether a commit is in a lower layer, we never discover that those
commits are already in the commit-graph chain and add them to the top
layer. This layer is then merged down, creating duplicates.

The test added in t5324-split-commit-graph.sh fails without this change.
However, we still have not completely removed the need for this
duplicate check. That will come in a follow-up change.

Reported-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Helped-by: Taylor Blau <me@ttaylorr.com>
Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c                | 16 +++++++++++++---
 t/t5324-split-commit-graph.sh | 12 ++++++++++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index cb042bdba8..0280dcb2ce 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2008,7 +2008,7 @@ static int commit_compare(const void *_a, const void *_b)
 
 static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
 {
-	uint32_t i;
+	uint32_t i, dedup_i = 0;
 
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
@@ -2023,17 +2023,27 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
 
 		if (i && oideq(&ctx->commits.list[i - 1]->object.oid,
 			  &ctx->commits.list[i]->object.oid)) {
-			die(_("unexpected duplicate commit id %s"),
-			    oid_to_hex(&ctx->commits.list[i]->object.oid));
+			/*
+			 * Silently ignore duplicates. These were likely
+			 * created due to a commit appearing in multiple
+			 * layers of the chain, which is unexpected but
+			 * not invalid. We should make sure there is a
+			 * unique copy in the new layer.
+			 */
 		} else {
 			unsigned int num_parents;
 
+			ctx->commits.list[dedup_i] = ctx->commits.list[i];
+			dedup_i++;
+
 			num_parents = commit_list_count(ctx->commits.list[i]->parents);
 			if (num_parents > 2)
 				ctx->num_extra_edges += num_parents - 1;
 		}
 	}
 
+	ctx->commits.nr = dedup_i;
+
 	stop_progress(&ctx->progress);
 }
 
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index c334ee9155..a314ce0368 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -440,4 +440,16 @@ test_expect_success '--split=replace with partial Bloom data' '
 	verify_chain_files_exist $graphdir
 '
 
+test_expect_success 'prevent regression for duplicate commits across layers' '
+	git init dup &&
+	git -C dup config core.commitGraph false &&
+	git -C dup commit --allow-empty -m one &&
+	git -C dup commit-graph write --split=no-merge --reachable &&
+	git -C dup commit --allow-empty -m two &&
+	git -C dup commit-graph write --split=no-merge --reachable &&
+	git -C dup commit --allow-empty -m three &&
+	git -C dup commit-graph write --split --reachable &&
+	git -C dup commit-graph verify
+'
+
 test_done
-- 
gitgitgadget

