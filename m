Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE604C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C7922D00
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Ulj8/hI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgHERGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgHERC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:02:57 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E33C0617A4
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 10:02:57 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id h7so42308276qkk.7
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 10:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tDKkQ0gKoAGETClPbYVVJ/6NtRbQ+kiQAIhvnw3+RoE=;
        b=Ulj8/hI6v3JUvOwkSrzOmyUs9DECG47/q9NyozE9RvnMdlsiccAupH2/q0Ouo1XQ8N
         7MwR43iNRdZY7QdMsKxLtxKSm6iws3ayO9cth43yD6uT9Ma4J+z2h4H8g4jQ3UXZrDi2
         ah6jhUFMdDrP508lh0ZUObWCoEohPHUZz1NBCLI0i5dVhbkmq2kFIxkMzs9TAxiSU6U+
         AfBwRZMROWc7ZvPAGVQ9gMGzOl1wdq8oVzQGxOn5moq3wYDJRiG7n10GDH1MXmp4WyoA
         f+p9WdnwZmXXhJtX+5wccGMcpRKaJnX8t7X0AFjD1WnyO1NUVo4nft3lXMTS3jZmmRAr
         ZjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tDKkQ0gKoAGETClPbYVVJ/6NtRbQ+kiQAIhvnw3+RoE=;
        b=qDS1kw+nzqo/O8TWkLjwFoptt3Bv4AMu/zgtpfcuN0HWIlSAafhZ+jjl6RcQS6+ZEj
         UvUO1zNz4SJe5pyMbM6sy8l9G+rfJcvLSIiMJFsirHnTmlwhrhFnQGb7/NoLh+I6YR9S
         CrGvuyPTPS6SOhq2mUBt0bI6JAP1vIMohpNQQMOFrPxNaDYw7GPrPS1oMrQbrFaBzZzI
         M1NGeEEDNaJa50+rdebIgbmdJQLzAvTIxiLWcM2Ir22t3zrZjMog4CSQodZkwvs4YPV2
         ikHUeGxupo5TaTNr5t9/bfxiNixGY+2JDXq1n/WCWFMbZF5QAWH9Bd0h646bDp6vti0s
         j1Ig==
X-Gm-Message-State: AOAM532lfI0pnd1ZxE6j8siWOdsd97qXBARAw9xYTvLJ+8fQcTaNSD2m
        4IbmBZYjX+3O7C2ftTod8HIBojh6G+fBMA==
X-Google-Smtp-Source: ABdhPJwXUT51hSNFJilyqy7iR+ZItA3q2aWqteHdo90zInufXTvtGrRF99uyz58UYk0qDGmW//jc0A==
X-Received: by 2002:ae9:ef43:: with SMTP id d64mr4569801qkg.326.1596646976211;
        Wed, 05 Aug 2020 10:02:56 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id x12sm2734660qta.67.2020.08.05.10.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 10:02:55 -0700 (PDT)
Date:   Wed, 5 Aug 2020 13:02:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com
Subject: [PATCH v2 11/14] csum-file.h: introduce 'hashwrite_be64()'
Message-ID: <c42d678714c16271fc02bc4e80c7c5a942930322.1596646576.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1596646576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596646576.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A small handful of writers who wish to encode 64-bit values in network
order have worked around the lack of such a helper by calling the 32-bit
variant twice.

The subsequent commit will add another caller who wants to write a
64-bit value. To ease their (and the existing caller's) pain, introduce
a helper to do just that, and convert existing call-sites.

Suggested-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 8 ++------
 csum-file.h    | 6 ++++++
 midx.c         | 3 +--
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 0d70545149..8964453433 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1784,12 +1784,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 	chunk_offset = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
 	for (i = 0; i <= num_chunks; i++) {
-		uint32_t chunk_write[3];
-
-		chunk_write[0] = htonl(chunks[i].id);
-		chunk_write[1] = htonl(chunk_offset >> 32);
-		chunk_write[2] = htonl(chunk_offset & 0xffffffff);
-		hashwrite(f, chunk_write, 12);
+		hashwrite_be32(f, chunks[i].id);
+		hashwrite_be64(f, chunk_offset);
 
 		chunk_offset += chunks[i].size;
 	}
diff --git a/csum-file.h b/csum-file.h
index f9cbd317fb..b026ec7766 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -62,4 +62,10 @@ static inline void hashwrite_be32(struct hashfile *f, uint32_t data)
 	hashwrite(f, &data, sizeof(data));
 }
 
+static inline void hashwrite_be64(struct hashfile *f, uint64_t data)
+{
+	hashwrite_be32(f, data >> 32);
+	hashwrite_be32(f, data & 0xffffffffUL);
+}
+
 #endif
diff --git a/midx.c b/midx.c
index 6d1584ca51..8b33149ce4 100644
--- a/midx.c
+++ b/midx.c
@@ -775,8 +775,7 @@ static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_large_off
 		if (!(offset >> 31))
 			continue;
 
-		hashwrite_be32(f, offset >> 32);
-		hashwrite_be32(f, offset & 0xffffffffUL);
+		hashwrite_be64(f, offset);
 		written += 2 * sizeof(uint32_t);
 
 		nr_large_offset--;
-- 
2.28.0.rc1.13.ge78abce653

