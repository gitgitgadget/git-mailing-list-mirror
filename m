Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2D2C63697
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8688241A7
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="PxNOC8Lj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgKQVrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgKQVrv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:47:51 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABD5C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:47:51 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id f93so17081415qtb.10
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gpM7ZEJoHWnszhfZZzvCrqIDHE5CA/aVMdvCvRpJSxg=;
        b=PxNOC8Lj19iqo/vV/tSDGbdU/s1q8f4zsEYBSvXRCIAcknXLinW3oObFtTuCA+CYzD
         F4cisGiExAiorhZkcnq37DxBnD4VeLZCW3iOaYT2XHJyBaO1lU8WH3uK4BxAvQumEogD
         erLd+DFdWs6fy1BVhWEE6HPkaOoS0xHjtdZUNmRcbI9Mt7SGdJQ23TlbS9MPE1jSofW7
         RA9aikrox3b67b2h36WYHcuL+rzLyz852nuf6HZIniCCV31OR6aw8FXQd9KO2w+K68ua
         zcExelouD3oID+IplicaHiKzo5S7KfWubbXFGU9bLhU5BROtgtnxTwfGER8zkAv/nVT5
         UiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gpM7ZEJoHWnszhfZZzvCrqIDHE5CA/aVMdvCvRpJSxg=;
        b=JWC3+4pyrhBM+aMaLudgRZJ4ciOZQTMdquoA0HJKB7KJAerTs7HSbbAmJJDx0E1jy+
         oBtMnTKQN94lQ0gzMxTvnmJA7LHtPWVjG3H8p5mevwIt5Eunj6g/e97Wa2MnM1AG46lY
         HK62wrjRs66V35RcUyrGYGXqbJPvA2eFHek1oJwfJchhhLTi/LGJQP9RzHjTfyY4l169
         stILQX2+6YcxBoeTYSZ5aB7Ok+akXfCho7YZLd4T941Jvw4176+GKew2ax72L1nWzXae
         YS5WYKgW2fBqrk8o7p+e8SR9ZzBnpiODCDyXVKhu7PUIm4v7RgfvHgEwZrSKORzUX/dn
         MlGw==
X-Gm-Message-State: AOAM532kTBvBYzIwa9dkp3B+7tohsyAJLrEriMgXvxqkWhrakZ9rCKKF
        DGrP4DWk/Y6t+L74jkAJCN+MVJnzY1uQKqsp
X-Google-Smtp-Source: ABdhPJyMM9xCLe4RblfG0uGweEvsovUBQUKtFBxyQ4dEOmxGWMg/jQ9/vQLlpTvnnWoHZBFhXf0I0Q==
X-Received: by 2002:ac8:7619:: with SMTP id t25mr1835803qtq.244.1605649670365;
        Tue, 17 Nov 2020 13:47:50 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe5:c4d6:f587:dc1f])
        by smtp.gmail.com with ESMTPSA id c14sm15257405qko.29.2020.11.17.13.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:47:49 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:47:47 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v2 16/24] pack-bitmap-write: rename children to reverse_edges
Message-ID: <60a46091bb4661946985f66ec10062739770696a.1605649533.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605649533.git.me@ttaylorr.com>
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
2.29.2.312.gabc4d358d8

