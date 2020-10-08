Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B530C4363A
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 15:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9A620708
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 15:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeK7703U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbgJHPEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 11:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730685AbgJHPEo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 11:04:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ED8C061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 08:04:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so6989063wrx.7
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 08:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ztt5wnGLz1vFJFZbnZUPfP+QTr0XxJhBMhV50fj/N1o=;
        b=WeK7703UDMh5z17TchAuAWdG9sIMhwPCYsCaJ3FEDEk0YG0rVdOE49llOHTTw0uMeu
         oVU2MmDI7743XUfhzpIPV91duGd4EzS4fGt51Qxv1CoGSdsvAVPMoEJAuW/QzwsWFOE8
         SJQZMdsY+RDitx6y7WwqlimIvr/rxwjR/753ntDUHS17NrGlYRAFghMq7Hsu783UH/L0
         vvB3fwbKBdBdlZOc/Prrpp5mlnKCagoRfpzpwpSN9y5aiwufkWqN1delA18raGKZ0+vg
         eExVl/UZMzWNvu/dFbise1CLvCCpj62cxkDRYgk3KWfnYHgIHCjz4HbqHvTevcIH2UBF
         aMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ztt5wnGLz1vFJFZbnZUPfP+QTr0XxJhBMhV50fj/N1o=;
        b=IJl1h7/EORf0e1tkhgbRBucVbqW8G0fitvtij/FJCPGViqSFs+xf9DB+EZsk+QGeFe
         NzAtR2v4iNui4j9nOYT3lsAB4Tf10hqtNwBUEoISADvS/q6ZATKuJRiqTuDANxAVOU4K
         empfqwS7eyCyHXtSWgOggCcv71+is7VfQaiSC21sTwAsSJp01w/8bA2+haP5w2viqdRM
         U3b8vrqG1UkHwOm8iKYkVoatn+nb3TZZjcZNNWePiS4MVQsUs3n+aKqHNA4lN6AYwc7G
         PgSJ3blQDP8A4iUiWh9EiQxmdzuplBXb8ESgl2sHoFXX+zxbr/LtB/k2nwZl7VxQHYnN
         xGWA==
X-Gm-Message-State: AOAM532dMdMbnxV4FHz7HoyZNzjNZsMhzqSlGIlLFpl9bkz5njnhulV1
        8UIxj0efA/DEeIe+YDJy/yMiw7yb5X0=
X-Google-Smtp-Source: ABdhPJwmYd91zKUthMQirowyalhC0w7UCw9Zep/jPGwfPgrcoBd2WQJY6QFyAMhSeZmcUJHR6fP2JQ==
X-Received: by 2002:adf:dcc7:: with SMTP id x7mr10048375wrm.203.1602169481426;
        Thu, 08 Oct 2020 08:04:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x1sm217813wrl.41.2020.10.08.08.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 08:04:40 -0700 (PDT)
Message-Id: <pull.747.v3.git.1602169479482.gitgitgadget@gmail.com>
In-Reply-To: <pull.747.v2.git.1602169145625.gitgitgadget@gmail.com>
References: <pull.747.v2.git.1602169145625.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 08 Oct 2020 15:04:39 +0000
Subject: [PATCH v3] commit-graph: ignore duplicates when merging layers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
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

Since the root cause for producing commit-graph layers with these
duplicate commits is currently unknown, it is difficult to create a test
for this scenario. For now, we must rely on testing the example data
graciously provided in [1]. My local test successfully merged layers,
and 'git commit-graph verify' passed.

Reported-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Helped-by: Taylor Blau <me@ttaylorr.com>
Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    commit-graph: ignore duplicates when merging layers
    
    This wasn't quite as simple as what Peff had posted, since we really
    don't want to keep duplicate commits around in the new merged layer.
    
    I still don't have a grasp on how this happened in the first place, but
    will keep looking.
    
    Thanks, -Stolee
    
    APOLOGIES: v2 accidentally only changed the commit message, not the
    patch contents. Please ignore v2 and go straight to v3.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-747%2Fderrickstolee%2Fcommit-graph-dup-commits-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-747/derrickstolee/commit-graph-dup-commits-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/747

Range-diff vs v2:

 1:  85f4e578b8 ! 1:  9e760f07ac commit-graph: ignore duplicates when merging layers
     @@ Commit message
      
       ## commit-graph.c ##
      @@ commit-graph.c: static int commit_compare(const void *_a, const void *_b)
     + 
       static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
       {
     - 	uint32_t i;
     -+	struct packed_commit_list deduped_commits = { NULL, 0, 0 };
     +-	uint32_t i;
     ++	uint32_t i, dedup_i = 0;
       
       	if (ctx->report_progress)
       		ctx->progress = start_delayed_progress(
      @@ commit-graph.c: static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
     - 					ctx->commits.nr);
     - 
     - 	QSORT(ctx->commits.list, ctx->commits.nr, commit_compare);
     -+	deduped_commits.alloc = ctx->commits.nr;
     -+	ALLOC_ARRAY(deduped_commits.list, deduped_commits.alloc);
     - 
     - 	ctx->num_extra_edges = 0;
     - 	for (i = 0; i < ctx->commits.nr; i++) {
     -@@ commit-graph.c: static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
       
       		if (i && oideq(&ctx->commits.list[i - 1]->object.oid,
       			  &ctx->commits.list[i]->object.oid)) {
     @@ commit-graph.c: static void sort_and_scan_merged_commits(struct write_commit_gra
       		} else {
       			unsigned int num_parents;
       
     -+			deduped_commits.list[deduped_commits.nr] = ctx->commits.list[i];
     -+			deduped_commits.nr++;
     ++			ctx->commits.list[dedup_i] = ctx->commits.list[i];
     ++			dedup_i++;
      +
       			num_parents = commit_list_count(ctx->commits.list[i]->parents);
       			if (num_parents > 2)
     @@ commit-graph.c: static void sort_and_scan_merged_commits(struct write_commit_gra
       		}
       	}
       
     -+	free(ctx->commits.list);
     -+	ctx->commits.list = deduped_commits.list;
     -+	ctx->commits.nr = deduped_commits.nr;
     -+	ctx->commits.alloc = deduped_commits.alloc;
     ++	ctx->commits.nr = dedup_i;
      +
       	stop_progress(&ctx->progress);
       }


 commit-graph.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

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
 

base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
-- 
gitgitgadget
