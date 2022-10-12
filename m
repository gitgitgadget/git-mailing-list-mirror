Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB959C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 22:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiJLWFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 18:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJLWEa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 18:04:30 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA3F139568
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 15:02:00 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id r142so10434436iod.11
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 15:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rf4GiHqvJ7NfeILaEa63RnOcL/50pM6Dth49LXa/i8s=;
        b=Mgrhhlg1hMHHU/6U9O/aw0q5iCxNAQIUMsNDgiXJOyIVSJA9L0NW7CQm7JyMeJlIWt
         PP2Lt/OGVe9gVcIKrmV/pCAMvUS0S8PJUn7a6KW1FCrHzr7Jy/mc+0palsx1ZqeuQaqU
         tQy7W3FVehPgaf4XD+vsAA4Cdglebo2Y3bg2f1rvVkAroGa1ufWZ7OuA1KiOuZBmavcz
         5z9LeE/U52xI5BjAU1zDY6pUTqYBxrVlN9q+QHyoywgHORWGfLJT+TJii5ppnJ4Njbi3
         +YhoqkGMeHo4rnDkWiZkMS9SaWs8gInzwBodEf9XE5d+5QhessfV+EzP2ae6J2auFnmL
         9arQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rf4GiHqvJ7NfeILaEa63RnOcL/50pM6Dth49LXa/i8s=;
        b=yCX+vCFpb/u37YuX6SzwCrlRT65KWp0MbbhnO4FqyBhgcX6uxrG6+ECLZU0oUXWGcM
         NFi6jBLuz0vQbiZOGZkBk7IpId9NeDXzZG1yfxB6edjM5o3eF1jepCALiUiX2KNTsLnE
         bc/MzlU/TO8b6wnyWs1IXaJDAl/YYK5I2WVt0+RjWGQqDPRhYJqN3vOKMzXH5cKNb6SF
         GLWSOXwnSBQPlkgtf7GsuiJXQQxn8hyXz5EwO2fZKkD/nVdVZJKFLJeUhlFkbn4REWSm
         5QYfHppyQ31sJ9gVd0AaNYp+jr3//47UanXHnqEqBHFszkX1FsqxI0zH9apM9+BELRt+
         Dyfw==
X-Gm-Message-State: ACrzQf1zeCy+k9dVIkF1TrqrVi6bOowyzo9XCgPeMmE4+0SDdRZ7DwZg
        hYWBf+w/P/PKBppvZmzeFI+Y99hI6PesGXcD
X-Google-Smtp-Source: AMsMyM4YxtaOfSl3vUr7supNbSazbVbjpmICS9fMC/FFVdgxraqQurLX/eqvWaPR+eb/INBh1JgbfQ==
X-Received: by 2002:a05:6602:2e08:b0:6a1:30d1:7ca7 with SMTP id o8-20020a0566022e0800b006a130d17ca7mr15338237iow.45.1665612119353;
        Wed, 12 Oct 2022 15:01:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z11-20020a05663803ab00b0036335a126d6sm5883442jap.105.2022.10.12.15.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 15:01:58 -0700 (PDT)
Date:   Wed, 12 Oct 2022 18:01:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, derrickstolee@github.com, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH 4/4] pack-bitmap-write.c: instrument number of reused bitmaps
Message-ID: <dd5ceb1ec3c01e8a2af55130718fff0b5eaf2de0.1665612094.git.me@ttaylorr.com>
References: <cover.1665612094.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1665612094.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When debugging bitmap generation performance, it is useful to know how
many bitmaps were generated from scratch, and how many were the result
of permuting the bit-order of an existing bitmap.

Keep track of the latter, and emit the count as a trace2_data line to
aid in debugging.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index a213f5eddc..cfa67a510f 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -384,6 +384,8 @@ static int fill_bitmap_tree(struct bitmap *bitmap,
 	return 0;
 }
 
+static int reused_bitmaps_nr;
+
 static int fill_bitmap_commit(struct bb_commit *ent,
 			      struct commit *commit,
 			      struct prio_queue *queue,
@@ -409,8 +411,10 @@ static int fill_bitmap_commit(struct bb_commit *ent,
 			 * bitmap and add its bits to this one. No need to walk
 			 * parents or the tree for this commit.
 			 */
-			if (old && !rebuild_bitmap(mapping, old, ent->bitmap))
+			if (old && !rebuild_bitmap(mapping, old, ent->bitmap)) {
+				reused_bitmaps_nr++;
 				continue;
+			}
 		}
 
 		/*
@@ -526,6 +530,8 @@ int bitmap_writer_build(struct packing_data *to_pack)
 
 	trace2_region_leave("pack-bitmap-write", "building_bitmaps_total",
 			    the_repository);
+	trace2_data_intmax("pack-bitmap-write", the_repository,
+			   "building_bitmaps_reused", reused_bitmaps_nr);
 
 	stop_progress(&writer.progress);
 
-- 
2.38.0.16.g393fd4c6db
