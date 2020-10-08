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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2ECC4363A
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 14:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 299892076E
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 14:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3srN+FL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbgJHO7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 10:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730685AbgJHO7K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 10:59:10 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6065C061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 07:59:09 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d4so6767274wmd.5
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 07:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NhzQpBs+Sbxfg+qzvsocz9MxrxIRKTPCOp6satQTx0g=;
        b=C3srN+FLncsnUnSc6+g5YmyuW5IVr2BH8jPnG/jGbiqtbxKlBzPBSTINlsddTK+11X
         KOZ6iA6HVdKsJAAHqaxVlkCmbp53CQqe7ikCjgVG6WmRSPnFY9JQhwiVIPCeH+vVK1nH
         Xt7OGGvp62240X8EJNME/CNJOcTgLMsymkoudbjI5rc3NTj9p4/JyS/Vrgj+alZw/p1t
         3NBr0XmRrJgQh3WeICR1WTBYsj0Pw9kK3Vdqzp1THuOG6SY3Sj3R5DhMz3lqyuGP1eLi
         A5pmN1SRZYEZsyC8p3QrREnOcHYXjmIA7p/6W8rmDxI76juZyT7YNBacLf/JZ+JVXQKG
         be8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NhzQpBs+Sbxfg+qzvsocz9MxrxIRKTPCOp6satQTx0g=;
        b=Cn8VdcSRdAeifaWFQNHfjZjucXYX7tzWi4XgS/BzMsTqnLGCo2yWF7q8XbmefS8LQv
         3Y0Zptvgo3Q6IeN3nG/RE4CBWPud/Rng2zGEIyv8GAV7OML2c6Iix6bbIZu3WvH57Fvs
         89qyBeas38Rdx7DETrElBLBJH7lbGxbCkiGR9cFa2NBKZGoi2CjAKc+BYpaDYZqGT+ZI
         tHpp+6Ru2FBDaHGTsCybMSs8O+tilNWZ1aoOD04dktMc7TUrYlH2bjQ2zgW8OmDPuwAy
         3wIS+JeNV43e89HvUdZ221W5KAPDgAwg2wJ4pmN4w561UsjrCTKcqvNbmluAnxdNCSyh
         81MQ==
X-Gm-Message-State: AOAM530eNiZeEFcE7sexpkyjnzuvq0C8W50yQGiZmdeqS3ZX2j9tvsNm
        xA6OjE9wrgIheIdX/CY/Lx2E1LmTERw=
X-Google-Smtp-Source: ABdhPJwFxpZIY7sy3JPmvjfTzjN01Ym5bYY9S/wLjHdRBmY+oOcUQifrMOnLA5/HoCJovS/vHz2XEg==
X-Received: by 2002:a1c:6a09:: with SMTP id f9mr9091640wmc.24.1602169147975;
        Thu, 08 Oct 2020 07:59:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j9sm7512890wrp.59.2020.10.08.07.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 07:59:06 -0700 (PDT)
Message-Id: <pull.747.v2.git.1602169145625.gitgitgadget@gmail.com>
In-Reply-To: <pull.747.git.1602165413035.gitgitgadget@gmail.com>
References: <pull.747.git.1602165413035.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 08 Oct 2020 14:59:05 +0000
Subject: [PATCH v2] commit-graph: ignore duplicates when merging layers
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-747%2Fderrickstolee%2Fcommit-graph-dup-commits-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-747/derrickstolee/commit-graph-dup-commits-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/747

Range-diff vs v1:

 1:  b3342403f1 ! 1:  85f4e578b8 commit-graph: ignore duplicates when merging layers
     @@ Commit message
          Otherwise, this graph_pos is a valid position in the commit-graph so we
          can parse the parents, when necessary.
      
     -    Thus, this die() is too aggignoring the duplicates.
     +    Thus, this die() is too aggressive. The easiest thing to do would be to
     +    ignore the duplicates.
      
     -    This leads to some additional complication that we did no have before:
     -    if we only ignore the duplicates, then we will produce a commit-graph
     +    If we only ignore the duplicates, then we will produce a commit-graph
          that has identical commit IDs listed in adjacent positions. This excess
          data will never be removed from the commit-graph, which could cascade
          into significantly bloated file sizes.
      
     -    Begrudgingly, the best way to fix this is to copy the commit pointers
     -    into a new list that only contains de-duplicated commit IDs. This adds a
     -    slight memory overhead, but it is small compared to having all of these
     -    commits parsed in memory, so it should be an acceptable cost for
     -    avoiding these failures.
     +    Thankfully, we can collapse the list to erase the duplicate commit
     +    pointers. This allows us to get the end result we want without extra
     +    memory costs and minimal CPU time.
      
          Since the root cause for producing commit-graph layers with these
          duplicate commits is currently unknown, it is difficult to create a test
     @@ Commit message
          and 'git commit-graph verify' passed.
      
          Reported-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
     +    Helped-by: Taylor Blau <me@ttaylorr.com>
          Co-authored-by: Jeff King <peff@peff.net>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      


 commit-graph.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index cb042bdba8..29bac78dc3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2009,6 +2009,7 @@ static int commit_compare(const void *_a, const void *_b)
 static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
 {
 	uint32_t i;
+	struct packed_commit_list deduped_commits = { NULL, 0, 0 };
 
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
@@ -2016,6 +2017,8 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
 					ctx->commits.nr);
 
 	QSORT(ctx->commits.list, ctx->commits.nr, commit_compare);
+	deduped_commits.alloc = ctx->commits.nr;
+	ALLOC_ARRAY(deduped_commits.list, deduped_commits.alloc);
 
 	ctx->num_extra_edges = 0;
 	for (i = 0; i < ctx->commits.nr; i++) {
@@ -2023,17 +2026,30 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
 
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
 
+			deduped_commits.list[deduped_commits.nr] = ctx->commits.list[i];
+			deduped_commits.nr++;
+
 			num_parents = commit_list_count(ctx->commits.list[i]->parents);
 			if (num_parents > 2)
 				ctx->num_extra_edges += num_parents - 1;
 		}
 	}
 
+	free(ctx->commits.list);
+	ctx->commits.list = deduped_commits.list;
+	ctx->commits.nr = deduped_commits.nr;
+	ctx->commits.alloc = deduped_commits.alloc;
+
 	stop_progress(&ctx->progress);
 }
 

base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
-- 
gitgitgadget
