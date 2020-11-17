Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D749CC63697
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 761D624181
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Vdto+aVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgKQVrY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgKQVrY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:47:24 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D16C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:47:24 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id 3so17133883qtx.3
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SB/Np43TUqBuwpOVIoYb4n+uOEF85GV7A6IjS9o8uW4=;
        b=Vdto+aVJ1rS1aN5mXd6Xl78tyGWUvUpTsHxJ9BaolvsM74xo9DjpfRG2ECxQ7i0KhI
         vKNxWfcVU0ETU3v9CkjW9/gKIVzDyBx/MTS1IcfuDFhuihPzAs6E52q/gX1gNiAvWvp6
         cGwyYYDoeCg4lSEAvOSCn1DupWeEsi+rAzFZNAE0j1aGnOF88Fy3lNCvkQWpxrFCPs1a
         +YhvCT8ULWSD456owJRE0G5Ux3/LLoMQTbTxwgzATcshOGFlLg8bb3W8oa06dPeIL2or
         +PWoS/D8C/IhlTI/0mEE/gy5YIfVJRNX5oK6NnlYooi+mPqwjS3g72eXunvGLbtH6Z6p
         Bt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SB/Np43TUqBuwpOVIoYb4n+uOEF85GV7A6IjS9o8uW4=;
        b=sbzRF3+nBZfS4PZDOVs2ywcLNoqhV4SIhluww/JkBk1EihOCjMx5gv3kyVQnh4Hul1
         DKtr8g3siLnaGYEZ1h/nT62fXhYkpPIhnxDjccarC4sGKs2uI2mr2Wx6SzO5torpZaPs
         y0xo1/dlUPdSuqPja2W+WeVLMhqj3y+vHP1Tny5UE0IqlcwO/pFn7Fgpa/rknzCz/ob0
         ERnbgTsJLDpRAIWU+lSU0FpAHewckuI6PfyK8b/rdUj2tbyJczd/I+eiWheSm25Y1xII
         bjRq7j17YYR2bbeBvVLg2cqvUVqT5opeu6zkYHEr6CcK4UR4KIf2TGGLzqJu3OyxbQ5c
         LmTA==
X-Gm-Message-State: AOAM533TxlIIPlzW93qLujwDICs40jxwJyaMzMFvc7W4LQHCYg8Zntsm
        UX6bAszyLHSHIcDvhEz8frQo79uFnctuQFhp
X-Google-Smtp-Source: ABdhPJxBMGZQCL5PHvvaPHcxNioLtKURi3BtythbxUp0S9ligH3gLBLUYg5PpEilX9YMUiaviXuUJQ==
X-Received: by 2002:ac8:7b47:: with SMTP id m7mr1768617qtu.171.1605649642932;
        Tue, 17 Nov 2020 13:47:22 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe5:c4d6:f587:dc1f])
        by smtp.gmail.com with ESMTPSA id g70sm14727155qke.8.2020.11.17.13.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:47:22 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:47:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v2 11/24] pack-bitmap-write: pass ownership of intermediate
 bitmaps
Message-ID: <466dd3036a8ca7dc9718a53f17cf87e0eb22c066.1605649533.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605649533.git.me@ttaylorr.com>
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
2.29.2.312.gabc4d358d8

