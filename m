Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AA6EB64DA
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 00:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjGHAbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 20:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGHAbk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 20:31:40 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEEF1FEA
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 17:31:38 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-bff27026cb0so2778425276.1
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 17:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1688776298; x=1691368298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zH2yvQSzxwyyFNjBPhsGMWv6DNRIiMtluAGBG5t/Zzc=;
        b=sGk6vQEO+8NWST0YvPmiZRu3pf7GXZool1QuNrP/xh5SlRXC/HivrI919TrQRRNzN+
         BYfgpEfRJZpBunYeUiVeI1XkFjXO1Lmabvunc8N+wC64Kfane9SVZdjWJnZDRdKf9/0h
         baNT6mqQp83Ozb0rrRrvNcmuebM9LClrDC58uiM3sGFSeq5377dnpgbN1Wpj902+0I7U
         WUigbq93GNT7WDTk1nuUMxbS4/h+g8snvlnBzkuUeuKOaPL/3oXlST1hyqpXy5vS88o+
         nWce2mJhWV/Jq5zYS/L5L9pHULWx1gszWGMaFd7baoVguZRzQO0ez2w/ek+HbIWvXZGh
         Q9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688776298; x=1691368298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zH2yvQSzxwyyFNjBPhsGMWv6DNRIiMtluAGBG5t/Zzc=;
        b=cw0/H4hdKuXFkvC6m4qAWXIUwIbb/zCg7A3e0fSIsTq2vPDLXHCDI3DOV8+3E9pASe
         /86M2BrVsYnVI5Ab3CCrN+LiiSr4N+y8SmfDRAIyyZul2IgeWqkoIVhJO2aadXMlT1Ph
         2OOOmbaeHOUW9p2/FekoK4B3w2Y7e7LqjdEIbEAFxDtqpN7e0GhhUSxBPjO0KLHebIIC
         498irxvneGhNDwqsDdCBMXaQBb62z5ZCTT4xZRLnh40rN3gF1DL3T7lmd4NolSIHN71m
         n+ug3OY1b/73XPjNHLz/REnEJ/pgzBmZ0LE08XF4qi47sL3wgsAS+E8Btx2TSvu4uDxi
         PrBg==
X-Gm-Message-State: ABy/qLYnbn+tNfmQMsD0q851kYYec7aU6DV1PGvChu83//fn341o+fHw
        kFNpE4Y9G8bRrjw1IAqJbQaOq0NieTFNUp2kdJpPSA==
X-Google-Smtp-Source: APBJJlHfI86Y51jLLhBMvZWac7QKXYjzcxzBgewm2GkdGPkh0d6NjvJ9zjlGoqSdMZSl9GUXuEYhng==
X-Received: by 2002:a25:a245:0:b0:c5c:2fa:5e14 with SMTP id b63-20020a25a245000000b00c5c02fa5e14mr5816631ybi.8.1688776298022;
        Fri, 07 Jul 2023 17:31:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d23-20020a25e617000000b00bceb538a275sm1261785ybh.21.2023.07.07.17.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 17:31:37 -0700 (PDT)
Date:   Fri, 7 Jul 2023 20:31:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 3/6] commit-graph.c: extract `verify_one_commit_graph()`
Message-ID: <8fa8871063018946e47515898c57377825ec95a8.1688776280.git.me@ttaylorr.com>
References: <cover.1688776280.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1688776280.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the `verify_commit_graph()` function was extended to support
commit-graph chains via 3da4b609bb1 (commit-graph: verify chains with
--shallow mode, 2019-06-18), it did so by recursively calling itself on
each layer of the commit-graph chain.

In practice this poses no issues, since commit-graph chains do not loop,
and there are few enough of them that adding additional frames to the
stack is not a problem.

A future commit will consolidate the progress output from `git
commit-graph verify` when verifying chained commit-graphs to print a
single line instead of one progress meter per commit-graph layer.
Prepare for this by extracting a routine to verify a single layer of a
commit-graph.

Note that `verify_commit_graph()` is still recursive after this patch,
but this will change in the subsequent patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f70afccada4..3d7cc11927d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2542,18 +2542,14 @@ static int commit_graph_checksum_valid(struct commit_graph *g)
 	return hashfile_checksum_valid(g->data, g->data_len);
 }
 
-int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
+static int verify_one_commit_graph(struct repository *r,
+				   struct commit_graph *g,
+				   int flags)
 {
 	uint32_t i, cur_fanout_pos = 0;
 	struct object_id prev_oid, cur_oid;
 	int generation_zero = 0;
 	struct progress *progress = NULL;
-	int local_error = 0;
-
-	if (!g) {
-		graph_report("no commit-graph file loaded");
-		return 1;
-	}
 
 	verify_commit_graph_error = verify_commit_graph_lite(g);
 	if (verify_commit_graph_error)
@@ -2699,7 +2695,19 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 	}
 	stop_progress(&progress);
 
-	local_error = verify_commit_graph_error;
+	return verify_commit_graph_error;
+}
+
+int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
+{
+	int local_error = 0;
+
+	if (!g) {
+		graph_report("no commit-graph file loaded");
+		return 1;
+	}
+
+	local_error = verify_one_commit_graph(r, g, flags);
 
 	if (!(flags & COMMIT_GRAPH_VERIFY_SHALLOW) && g->base_graph)
 		local_error |= verify_commit_graph(r, g->base_graph, flags);
-- 
2.41.0.242.g6eec849fa5a

