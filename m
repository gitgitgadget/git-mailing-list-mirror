Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE46FC197BF
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A14FC23A04
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgLHAFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbgLHAFp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:05:45 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4ACC061794
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:05:04 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id p126so17537472oif.7
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=41w+8dMxR92mbEFLoU66S+t8xwPreIFljCrA8SXjhWo=;
        b=RZzr4HlnTWlNIgRSiAEI3rJ0MOjL9hOqxt7nGGlBf8hthTg8MDLaj77WUG5hg9s5qm
         xN8wRgCX199OpsYbTTkogssGNY1V4mHIqLs6+Tt6SD4NJg1CSHEkZ6gaJkJ9sXVClIyx
         Fjubv+CrZtA9JYHdcsJEJAG7DLez6cxwULn53gzpqmsXnjpuDdnwhv+59okbBrh7lBpm
         o8Q6XAyB1MC22luYPmhrM8kkhPJojvwiZnIqqG6l1/HxvxWgShC9FQsYgkhL6qdmDQAd
         DidNNaKIiaQl4guSnb7yDQbywhiqry8r+vmm3pOq8HSKKPx+ZKDswFNUldyCgk6xE/vF
         NExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=41w+8dMxR92mbEFLoU66S+t8xwPreIFljCrA8SXjhWo=;
        b=JHgNud6U2HoB9CUOYCkf8lwAxX2igouRG9ucbGSDW5p1ok+k8xqRd5BCLQAciy0HN2
         Kc0PeKNRsES/doHwV/yED0NoSHwoWxNvcWRagORMWpi8Wu3/twfOROc/eculcunlIVM+
         4mu6bfg0NvXrimAEIH7h5F/3sd1ThiCH/wEl2RXy3dGgv1O2j0a8xlOIrQHLddkCB2rm
         TOLA8NRpr7XLIdU0lAiuQyvr6Osso6uqX4USzWmn3+Fqopq71sem+mbDI16k4k1Cb2zi
         03fJ8VlM4icPrfFNash/9TCCIO/NtexSbBAheNzsXLAnkN1eJs+/h5C3jMCCxpcqByAU
         VXNQ==
X-Gm-Message-State: AOAM530ECLZFzONlzCLkqpztgF0J0Lh69F+JL7fQZ8m0ENhSfX56lzzQ
        RDupP8Ezqv1rpCR4sCv2Bwx43wuk1ckniFCV
X-Google-Smtp-Source: ABdhPJxgC/wlxXXYrv8mYxYL4AKa1QBm00ZjRMDFfowV2zg2c7tl+tFoW8X0dDf9dHPPA60IwyB5Fg==
X-Received: by 2002:aca:ed86:: with SMTP id l128mr988464oih.0.1607385903372;
        Mon, 07 Dec 2020 16:05:03 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id s189sm3318569oia.7.2020.12.07.16.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:05:02 -0800 (PST)
Date:   Mon, 7 Dec 2020 19:05:00 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v3 11/24] pack-bitmap-write: pass ownership of intermediate
 bitmaps
Message-ID: <64598024ecfe60428df800caabb4e2c6efc0f905.1607385833.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607385833.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607385833.git.me@ttaylorr.com>
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
index bcd059ccd9..1eb9615df8 100644
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
2.29.2.533.g07db1f5344

