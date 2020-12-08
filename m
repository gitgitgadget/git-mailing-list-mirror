Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCB4C1B0D9
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B22FE23B55
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbgLHWE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730715AbgLHWEw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:04:52 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187AAC0613D6
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 14:04:03 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id d8so245103otq.6
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 14:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=41w+8dMxR92mbEFLoU66S+t8xwPreIFljCrA8SXjhWo=;
        b=P3D79hlhKv8xjGZb3FYa+9U/TgbMdaBTjQ+/Niesc0D1PGGjL8tWWyJuY7TQIiw8px
         SHkBx2XVhKYUYVTMFc9e8IN4kLGWYYMH5yLoRe0fj0JnczRLveUiCFdiUgI07OYIgCzk
         3mJg4cKvpw4POBLCtTxgRY3MaevG3PLMWAeMpCrVDR1nlyn3gJ/WZmVgyMcfbWKZ7z3J
         D16se0UxFDkP4RlzZ8fOjcm3px6aekC7ZYV3IAfKt1w8vU1T9CEhREo6y4Vl0eLm3MSs
         RowqhjQ8oU3hK8v2AL3MGCN1YQGsxqtTmfG2esUwp2z5C3YTBTF7lbJ80dUe4UkZzud3
         BXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=41w+8dMxR92mbEFLoU66S+t8xwPreIFljCrA8SXjhWo=;
        b=GfqOdoD7tYN2w0Z7opcRGOLQBPFFCvfRb+L88ehQEgdrhEAuOF9I3Y8LTYsurC1CUc
         kR62ND/eWZ1g7CCaLjkcW047II1EdeZxE3C+ybRVjFC9Ndv4HxbZ3/Fw94Qc+brnlNxi
         WPH+6BAsbhlAjxCEtO8b0oLVjBADxGBcg27NMnqTo95IR/bLwSc3NOpO1F1OM1TSwj70
         uGPnXCbStz29+SkRWpjMjoff1tBDUWnjnIXk49DsbxvRjlvdW/X1RuazikTiJGpu6rew
         zLzNoPzZK4yBSO2dh2dAgWa7q78qwcWO14xVmve2nssx5VMwr56yxXC5j1WAcaQcEz/R
         cO+A==
X-Gm-Message-State: AOAM533zGKfVDYcGiCgk0Ooo9QBrV7uCcuO5rDdp5c20GP0wiwnYUM85
        a3TCV9pYxGu/wgoLVoTMEwWbKOaMDQjYhCfT
X-Google-Smtp-Source: ABdhPJxb1dZc0fFA2bPa/3yOYyMXhd1SNx6Fa7gFu57C5JtYqnchgRSUoU5WVvh8t+9zZKCEvVl4lg==
X-Received: by 2002:a9d:774a:: with SMTP id t10mr150037otl.190.1607465042212;
        Tue, 08 Dec 2020 14:04:02 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id z10sm69578oom.3.2020.12.08.14.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:04:01 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:03:59 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v4 11/24] pack-bitmap-write: pass ownership of intermediate
 bitmaps
Message-ID: <f87c11700b1cada168a50864f14eb8d33b193443.1607464775.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607464775.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607464775.git.me@ttaylorr.com>
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

