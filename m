Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620BDC5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02AEF207F7
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="krWJMXj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgKKTnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgKKTnX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:43:23 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275A8C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:43:23 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id p12so2178076qtp.7
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x3WnFG+yS//yZUuDHlkQGLxSM+69kgHjwyV+D6gY31Q=;
        b=krWJMXj1+1hKgTBKiGeW8Cg6wcWIk5YJqL4n1wpjAkST+LBj8snRwrxzpj8MJXxHQ/
         ycTtE+eGonAMCUmBN5D5bUh4w0A47BAb8k34PoIDrTDymmC/rnNb1jq2D/PhY1Q19bVy
         Vh2XMRbPid5h4j2Osp+OsvG3udFGz18HwBhlB5w2LTBIJrxThNKMbUP5M5C6qI1/2rIl
         qdJrGgbsX+d9ACegCB2mWHJ4OM1k+vFmYZCBhlbC0BFCNgIO4ulkRkUMZiwcBPZrQyxL
         J+/f86+JY/xNLuNqx+K1iBckC3PdKrcYa0mzjlxP3qQkSBNgGZ2mla5YkeTBW58R3KGp
         tfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x3WnFG+yS//yZUuDHlkQGLxSM+69kgHjwyV+D6gY31Q=;
        b=dMjLFtltEqpuME9vXWX94oNZYzrF9lyBq5buOgz7dJ49d16zBOqyiEDIz2l7sNFxM+
         G61G69ckURYk4oFzVDPiEkEdeAW3NV2CEK/8iQIJS0zt3A8B22/L1ZtHgkwpVXdkff5X
         3CWB5OmyQrq8fuzA75x9akNc1YUAGj1oZNWlZdsRU1xzCPl1r+mQ1wTI7P3PVANzQkIg
         TKZEvteVWJamJwJKD99+NDeclZZwtpB+o92N5yD4+snjB6S/sZUJVAMjypLyRmRf6UQ3
         OhCEfgxsGuzhZbla03TmGM2kfKNsLc7kvnYMDbNo58VmPsva1wtk1Q0wqEsaYxX6Sm6A
         qC0A==
X-Gm-Message-State: AOAM530SWGMh/IeM304nhcGZNBrhdBh6sRX+YIOaPKRV58d2TEeA+S2M
        u2JGLaZ9UIn6jCS37dZBej37IKz9K7aR6zDj
X-Google-Smtp-Source: ABdhPJxnW1btbRO4kZQiSEKzyIcXL8GQP5LuSJ11gRQN3L4yYHrSnSqRswqtm1ijD5TZWZqHk28hrA==
X-Received: by 2002:ac8:70cd:: with SMTP id g13mr24365421qtp.345.1605123802084;
        Wed, 11 Nov 2020 11:43:22 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7ccc:9a51:1ad:2057])
        by smtp.gmail.com with ESMTPSA id h125sm3192809qkc.36.2020.11.11.11.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:43:21 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:43:18 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 11/23] pack-bitmap-write: pass ownership of intermediate
 bitmaps
Message-ID: <8328d8cc9930ca10d939e4b35abe1c4987aba115.1605123652.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605123652.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Our algorithm to generate reachability bitmaps walks through the commit
graph from the bottom up, passing bitmap data from each commit to its
descendants. For a linear stretch of history like:

  A -- B -- C

our sequence of steps is:

  - compute the bitmap for A by walking its trees, etc

  - duplicate A's bitmap as a starting point for B; we can now free A's
    bitmap, since we only needed it as an intermediate result

  - OR in any extra objects that B can reach into its bitmap

  - duplicate B's bitmap as a starting point for C; likewise, free B's
    bitmap

  - OR in objects for C, and so on...

Rather than duplicating bitmaps and immediately freeing the original, we
can just pass ownership from commit to commit. Note that this doesn't
always work:

  - the recipient may be a merge which already has an intermediate
    bitmap from its other ancestor. In that case we have to OR our
    result into it. Note that the first ancestor to reach the merge does
    get to pass ownership, though.

  - we may have multiple children; we can only pass ownership to one of
    them

However, it happens often enough and copying bitmaps is expensive enough
that this provides a noticeable speedup. On a clone of linux.git, this
reduces the time to generate bitmaps from 205s to 70s. This is about the
same amount of time it took to generate bitmaps using our old "many
traversals" algorithm (the previous commit measures the identical
scenario as taking 63s). It unfortunately provides only a very modest
reduction in the peak memory usage, though.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index f2f0b6b2c2..d2d46ff5f4 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -333,6 +333,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 		struct commit *commit = bb.commits[i-1];
 		struct bb_commit *ent = bb_data_at(&bb.data, commit);
 		struct commit *child;
+		int reused = 0;
 
 		fill_bitmap_commit(ent, commit);
 
@@ -348,10 +349,15 @@ void bitmap_writer_build(struct packing_data *to_pack)
 
 			if (child_ent->bitmap)
 				bitmap_or(child_ent->bitmap, ent->bitmap);
-			else
+			else if (reused)
 				child_ent->bitmap = bitmap_dup(ent->bitmap);
+			else {
+				child_ent->bitmap = ent->bitmap;
+				reused = 1;
+			}
 		}
-		bitmap_free(ent->bitmap);
+		if (!reused)
+			bitmap_free(ent->bitmap);
 		ent->bitmap = NULL;
 	}
 	bitmap_builder_clear(&bb);
-- 
2.29.2.156.gc03786897f

