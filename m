Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD64CC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 864A8207F7
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="If+bFuul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgKKTod (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbgKKTod (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:44:33 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BE2C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:44:32 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id n132so2939924qke.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QzJrkPUzW98AR8zeqXneGhd/FKkWTXJQDhZM9/p9aqI=;
        b=If+bFuul1fQz9BRBPMZmO6If5RWx8MGJN17zA6k8u+p2XNsXPszmz2sL5o7XnhLFFS
         2vc1Yhs4Qm/AOGN20uu1ysWRGxiUJdH2xBhnY00GbT5xTnD4wdqgiDTRdyJcJqHGviBX
         CV81+dgKdPlGRFSYDszyaOmszA79TU8XMQxYF8CLzWBxnfR/K4kiFO/tGscHfQSBTbUo
         eHRtmze+lxV11WCJhYK1nKxy3ajw9zjM4TodfArI/4ASUwaGi1tU5FWz0CiB8wCrGOp+
         lcojA6gy6XAQWqrZY2f7o/0J7ofDeKOun407vPSNyO24JhlTys8STgEMAuKaUcGzH2Lw
         cjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QzJrkPUzW98AR8zeqXneGhd/FKkWTXJQDhZM9/p9aqI=;
        b=SHLdnZHov1T65aGXAXW0Zly/E+vm7ZVDjk460LhQM3lu5L7PnjDPAVecMY038sTqn7
         GQxeNMeazRHNglLix1OSUCmjwD5l8PdeEK9ZZTdbpZVp4J1pmwE8qh35U6pZzRXU+d5D
         eIwMc8TGF9Czy2/ciTN9axHYqJDxDONL7avKukkKmeYFTmbz3GCk5FxwHF2l1adiJVFc
         9c8fEONcQi18woGu1XsciodeRk/6C5hY6mq9xJX7a+1NVjAZkciTc3vCUBnl0dwZxNpM
         40ZZjKebCRakUVEHpSvkhHKNOWhbV8nnypVewzpZmr7HI3WIvMgJn7BHfvX5ln5TzSsO
         od8w==
X-Gm-Message-State: AOAM531ujo22dfJcXqoKd1+LOKcTsZ7D6ttCrfvKdOqYE5QX/igYo4fA
        dYMTbhfGhv7jGXgCVkRIqlPnoaD/VU5RupL6
X-Google-Smtp-Source: ABdhPJwnCd3S53sYVmJx7Alj8mtadj8Jn4aFt4Kk3ULDp0+LQyq96Rqdm8kP9b0FgGjTRdJpEULnDg==
X-Received: by 2002:a37:a185:: with SMTP id k127mr8786667qke.413.1605123871567;
        Wed, 11 Nov 2020 11:44:31 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7ccc:9a51:1ad:2057])
        by smtp.gmail.com with ESMTPSA id g66sm3061069qkb.91.2020.11.11.11.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:44:30 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:44:28 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 23/23] pack-bitmap-write: better reuse bitmaps
Message-ID: <35beb4f098991bb3886bbaf74f9d2fc5561bca42.1605123653.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605123652.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If the old bitmap file contains a bitmap for a given commit, then that
commit does not need help from intermediate commits in its history to
compute its final bitmap. Eject that commit from the walk and insert it
as a maximal commit in the list of commits for computing bitmaps.

This helps the repeat bitmap computation task, even if the selected
commits shift drastically. This helps when a previously-bitmapped commit
exists in the first-parent history of a newly-selected commit. Since we
stop the walk at these commits and we use a first-parent walk, it is
harder to walk "around" these bitmapped commits. It's not impossible,
but we can greatly reduce the computation time for many selected
commits.

             |   runtime (sec)    |   peak heap (GB)   |
             |                    |                    |
             |   from  |   with   |   from  |   with   |
             | scratch | existing | scratch | existing |
  -----------+---------+----------+---------+-----------
  last patch | 100.641 |   35.560 |   2.152 |    2.224 |
  this patch |  99.720 |   11.696 |   2.152 |    2.217 |

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index b0493d971d..3ac90ae410 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -195,7 +195,8 @@ struct bitmap_builder {
 };
 
 static void bitmap_builder_init(struct bitmap_builder *bb,
-				struct bitmap_writer *writer)
+				struct bitmap_writer *writer,
+				struct bitmap_index *old_bitmap)
 {
 	struct rev_info revs;
 	struct commit *commit;
@@ -234,12 +235,26 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 
 		c_ent = bb_data_at(&bb->data, commit);
 
+		if (old_bitmap && bitmap_for_commit(old_bitmap, commit)) {
+			/*
+			 * This commit has an existing bitmap, so we can
+			 * get its bits immediately without an object
+			 * walk. There is no need to continue walking
+			 * beyond this commit.
+			 */
+			c_ent->maximal = 1;
+			p = NULL;
+		}
+
 		if (c_ent->maximal) {
 			num_maximal++;
 			ALLOC_GROW(bb->commits, bb->commits_nr + 1, bb->commits_alloc);
 			bb->commits[bb->commits_nr++] = commit;
 		}
 
+		if (!c_ent->commit_mask)
+			continue;
+
 		if (p) {
 			struct bb_commit *p_ent = bb_data_at(&bb->data, p->item);
 			int c_not_p, p_not_c;
@@ -422,7 +437,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 	else
 		mapping = NULL;
 
-	bitmap_builder_init(&bb, &writer);
+	bitmap_builder_init(&bb, &writer, old_bitmap);
 	for (i = bb.commits_nr; i > 0; i--) {
 		struct commit *commit = bb.commits[i-1];
 		struct bb_commit *ent = bb_data_at(&bb.data, commit);
-- 
2.29.2.156.gc03786897f
