Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044A0EB64DD
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 23:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjGLXir (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjGLXid (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 19:38:33 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9CF2689
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:38:12 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-c1aad78d5b2so2017785276.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689205092; x=1691797092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+BuDXyj4t6pxRONY6+ks8ATUP26JKbQh8TuvcfpQStc=;
        b=uG6vKNPufbxPtM4H/e3Smq/yc97tdcdb2f2xYEfu3Ck2UAtRN9uDr6Bn1mGbtCg5Pt
         7phE0OkTRoDwItDK0c/l8CM8sLb2dW+VQJ21+DwDkXnu/oMkQXp7jiSrFBrAj5wibljd
         m7ZQDF650hbWWVQME470XzQKSBgvwzwjMeaF4bRUz3a8OXN0k9dDkCr/Yc7tS1aWyTfV
         F06oK6dwJdQ1ztel9v+sLDZOT4wxYwqyTtjva/tyG6XPM4ZtXLVQeAlIT5mnGa3GImeg
         f74fbtqxbT4KEj7QJD+05uHEU1rGsJ1ynl2rC+8y2qvNidiVPezoWDi7ZlobhEE5kRFf
         TNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205092; x=1691797092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BuDXyj4t6pxRONY6+ks8ATUP26JKbQh8TuvcfpQStc=;
        b=GXokgPiNpOoURVx0LmZgVMT9xcZrhR0O6NHYynnZQwrvejR+VITrrCq1K/tszFVNzy
         WWKaf4XdDuQKxAcG6OReP6XIowqsH4eZsz83mmQP2T3p50xW++mCLUjBT27oz83s0pdR
         piD60WsPqGLO9kPmfFMr4jdeNMIn4zYcvzHqcOyJV1xEfdgGx3fF3/pygB5tqHQOG6l9
         ulRiE12qEQJnXh+39qMpadtLDLAVD5qwrHG5pvHtzV2KZqh3PWUD0H7KoOIeXBheqfiX
         p86dwVoe7nbZIA//A0CAeE3Izh0v1LSJODsYcpcGlIh7l114W4iSHmX/2NtN8Dai3MF2
         V6Iw==
X-Gm-Message-State: ABy/qLY84c3cUN1/hILS4C2w0n3ZuKc5+lxWdfgh4Q5sMg6INUJddQ5x
        oArBRHwrdyc55AYU1tsnU3n+yNGXz2hUqGEO+m/X4g==
X-Google-Smtp-Source: APBJJlG2mySgSdZeeDOLKMJtY/7MOjNVCQDN6r9dl+pl3ww4ope1FNxHwy9fyYkGw8UPo43efL+3Cw==
X-Received: by 2002:a25:d68e:0:b0:bc3:7ee1:8d4e with SMTP id n136-20020a25d68e000000b00bc37ee18d4emr226440ybg.24.1689205091976;
        Wed, 12 Jul 2023 16:38:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o13-20020a256b4d000000b00ca483619498sm526264ybm.6.2023.07.12.16.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:38:11 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:38:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 17/20] commit-graph.c: prevent overflow in
 `split_graph_merge_strategy()`
Message-ID: <8d43e3bab557a85f5c22abb750ebbe9885444690.1689205042.git.me@ttaylorr.com>
References: <cover.1689205042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689205042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as previous commits, ensure that we don't overflow
when choosing how to split and merge different layers of the
commit-graph.

In particular, avoid a potential overflow between `size_mult` and
`num_commits`, as well as a potential overflow between the number of
commits currently in the merged graph, and the number of commits in the
graph about to be merged.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 35f700273b..8010e0763e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2111,11 +2111,16 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 
 	if (flags != COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED &&
 	    flags != COMMIT_GRAPH_SPLIT_REPLACE) {
-		while (g && (g->num_commits <= size_mult * num_commits ||
+		while (g && (g->num_commits <= st_mult(size_mult, num_commits) ||
 			    (max_commits && num_commits > max_commits))) {
 			if (g->odb != ctx->odb)
 				break;
 
+			if (unsigned_add_overflows(num_commits, g->num_commits))
+				die(_("cannot merge graphs with %"PRIuMAX", "
+				      "%"PRIuMAX" commits"),
+				    (uintmax_t)num_commits,
+				    (uintmax_t)g->num_commits);
 			num_commits += g->num_commits;
 			g = g->base_graph;
 
-- 
2.41.0.347.g7b976b8871f

