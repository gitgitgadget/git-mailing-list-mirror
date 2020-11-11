Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D214C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B08032087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="fQC8SDZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgKKTnw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgKKTnv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:43:51 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D121EC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:43:50 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id v11so2158395qtq.12
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ytlKQFGGG+ravvYTA3kptUK39TXZJYYvtg8yhG9mjuU=;
        b=fQC8SDZu8/hvxm3SeKYojJ5YCXDONdfFLvkUHasfuqeIo32ik9aH7O8jWs5GGKq1oY
         Kq84yOjlyT5OOZMuGenpISr0TaMGayAJUREgUcL98oeUMrZdqqpwPcW6R8Y77hY8eUej
         pQm/XAsALJ+4eYRMTTZys3s4FCR9MKqTEiFT0xPGfM9iKIR0fuT/kbmdbtojrxj/Zk2/
         /YpYNfyWRQGb9o7YZLuoOkUYPxiBEgSnrQCnt/l7xtV75j6v99QkM8x0vANlLRLNCB5R
         N8+f4LG9Mn7H6Z/v1b4ZH1AzHcbDdxcOh80dD1BzpgZxcNH4Gk7RGWFc9JvTiziuWezR
         P/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ytlKQFGGG+ravvYTA3kptUK39TXZJYYvtg8yhG9mjuU=;
        b=Ykg78UqZZd0ZctrntFawgZsyZEouHUZwE800DJfkxuFUq33vQ0g9H5h+fK4Ac3ElP8
         TBUb0VauKVx941lm4cHzC7yxXcjb6djJTwzE6WwoSl0Uh3CjzwvPSCo+5qLV091na6rn
         e3fZ7g/70MGNtJqbHRkOvudwK3me85WD4yopkV8D/lXj3KhCcZjKGA2l1GTzd25BluMq
         XjhbLs3TF/0Eqwj9JQ/5IdIfC9eJ0S7Anjc0rp4rjSPT4779jD2eXWZJwAl+Tpggf9m9
         l2RXjx3h3pE9viE/YqIxPXHBbVaex2lu/530Ia7xruVJQJtXL5mRWT6fzmHBSMYf7IlQ
         ShUg==
X-Gm-Message-State: AOAM533FM43IM1QBwtM85n3Uk70kCV7kGzXQayV/Pau1MScxK0ctdO+F
        u9zLYlnTaLYEHmHBNVtIIYPmWI460o4MlJF0
X-Google-Smtp-Source: ABdhPJycwbGNuPiUbuPGkzIq+uLHZzSNmOyE0wGmuTGekQ84voXJDeO7efCJzAoGOAEWRYTvr6/nKw==
X-Received: by 2002:ac8:7688:: with SMTP id g8mr18154824qtr.270.1605123829771;
        Wed, 11 Nov 2020 11:43:49 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7ccc:9a51:1ad:2057])
        by smtp.gmail.com with ESMTPSA id m2sm3005356qtu.62.2020.11.11.11.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:43:49 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:43:47 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 16/23] pack-bitmap-write: rename children to reverse_edges
Message-ID: <ac92e76a98591e6131a8e7a1b2f2e2bbf6d92564.1605123653.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605123652.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The bitmap_builder_init() method walks the reachable commits in
topological order and constructs a "reverse graph" along the way. At the
moment, this reverse graph contains an edge from commit A to commit B if
and only if A is a parent of B. Thus, the name "children" is appropriate
for for this reverse graph.

In the next change, we will repurpose the reverse graph to not be
directly-adjacent commits in the commit-graph, but instead a more
abstract relationship. The previous changes have already incorporated
the necessary updates to fill_bitmap_commit() that allow these edges to
not be immediate children.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 361f3305a2..369c76a87c 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -179,7 +179,7 @@ static void compute_xor_offsets(void)
 }
 
 struct bb_commit {
-	struct commit_list *children;
+	struct commit_list *reverse_edges;
 	struct bitmap *bitmap;
 	unsigned selected:1;
 	unsigned idx; /* within selected array */
@@ -228,7 +228,7 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 
 		for (p = commit->parents; p; p = p->next) {
 			struct bb_commit *ent = bb_data_at(&bb->data, p->item);
-			commit_list_insert(commit, &ent->children);
+			commit_list_insert(commit, &ent->reverse_edges);
 		}
 	}
 }
@@ -358,7 +358,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 			display_progress(writer.progress, nr_stored);
 		}
 
-		while ((child = pop_commit(&ent->children))) {
+		while ((child = pop_commit(&ent->reverse_edges))) {
 			struct bb_commit *child_ent =
 				bb_data_at(&bb.data, child);
 
-- 
2.29.2.156.gc03786897f

