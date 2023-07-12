Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6E1EB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 23:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjGLXih (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjGLXiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 19:38:25 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9628E211C
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:38:07 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-579dd20b1c8so82789107b3.1
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689205086; x=1691797086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hpE5g+uWgax8IGRduDa+G9Yt6ihxoWIeZdKbkK0J6bs=;
        b=U+BsMjV75NkE87sQSMhD4kWSFyqTm8OBrOnPDQPp6dNAdW/i1VO1lCaCs7b8gotkg7
         0MjpaUFuxu/cy9yzW/S/JHVSGJj/miNYeYSrfz19P+D60V12B7N9oeeRKyK2G5iSQIfj
         1U4gEgUP/hgTSvLJ6Y0Ndr3YJyHj1wI72ko3PfIZ2zCeJzT8QyT1Ve1E9Gy6p6hX2WhF
         dyTQhh9inOrZQcYWT50mIcoxhI8PF2XMrxoENgUl5K7hd322xp1JjnuKNPaIxkNLc3kJ
         YeIKccESCkW/duRKq3qDFRh2YfJDw9ejMooO1gHdfrTiZaWVNefKUrPC6SR5BpltXpVP
         jPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205086; x=1691797086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpE5g+uWgax8IGRduDa+G9Yt6ihxoWIeZdKbkK0J6bs=;
        b=YQG079Fy2s3+4Sqh1OSTJXdjDDmBqhSNID3Nz7t2LQvQuREGXeWpkuqGDDy1vQqiVi
         6qwJrr9YkmJOKzRkN6SUQHRS7ClzJQbE8f4BnyZEGwHZlbHDJwV/J+unjJ7CVq6bwh+S
         aa2CWJlmsAUh3SRlMga3IrIBX58INwvYyCbZza8X9bQRVXnSCE4F59hHrxzLgMxKiLni
         qEQs31ThIWKsbDbbnckZRTmpCYcuDrOS6yiGJwai9xgQhAgaS7zIVwEwBOGdia1JwfCy
         tcUk2p5x4iXiK1Z9OczMP0DQNFNglBVDgzKZxveQUX3NZCRYL9bFdvHy640EQsU2ewkU
         tWIA==
X-Gm-Message-State: ABy/qLZvNRMt7wF/6cwWZtzCImYocpngm9SyEfOzCkMVP36EM13mwms0
        m0cqjfjxioWHF8rAb9AN/IAb5DTkZ3stgpnmn2VZOQ==
X-Google-Smtp-Source: APBJJlF11LEiLneWxCkpteWyIqOcqs4sAJxM2Q2W42f78cX30NMGZCNY3IIuG36JH6WPElII/7o9Ig==
X-Received: by 2002:a81:918a:0:b0:57a:5099:fd7a with SMTP id i132-20020a81918a000000b0057a5099fd7amr139098ywg.3.1689205086729;
        Wed, 12 Jul 2023 16:38:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x189-20020a81a0c6000000b0057399b3bd26sm1488909ywg.33.2023.07.12.16.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:38:06 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:38:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 15/20] commit-graph.c: prevent overflow in
 `fill_commit_in_graph()`
Message-ID: <d49bedb1be00b76629dbfb6494d4f8cd45af1d02.1689205042.git.me@ttaylorr.com>
References: <cover.1689205042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689205042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as previous commits, ensure that we don't overflow
when the lex_index of the commit we are trying to fill out exceeds
2^32-1/(g->hash_len+16).

The other hunk touched in this patch is not susceptible to overflow,
since an explicit cast is made to a 64-bit unsigned value. For clarity
and consistency with the rest of the commits in this series, avoid a
tricky to reason about cast, and use `st_mult()` directly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index ceaeb8b785..ca1d997516 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -837,7 +837,7 @@ static int fill_commit_in_graph(struct repository *r,
 	fill_commit_graph_info(item, g, pos);
 
 	lex_index = pos - g->num_commits_in_base;
-	commit_data = g->chunk_commit_data + (g->hash_len + 16) * lex_index;
+	commit_data = g->chunk_commit_data + st_mult(g->hash_len + 16, lex_index);
 
 	item->object.parsed = 1;
 
@@ -859,7 +859,7 @@ static int fill_commit_in_graph(struct repository *r,
 	}
 
 	parent_data_ptr = (uint32_t*)(g->chunk_extra_edges +
-			  4 * (uint64_t)(edge_value & GRAPH_EDGE_LAST_MASK));
+			  st_mult(4, edge_value & GRAPH_EDGE_LAST_MASK));
 	do {
 		edge_value = get_be32(parent_data_ptr);
 		pptr = insert_parent_or_die(r, g,
-- 
2.41.0.347.g7b976b8871f

