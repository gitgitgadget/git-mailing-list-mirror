Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D504C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 22:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4322061157
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 22:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbhINWHk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 18:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbhINWHi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 18:07:38 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DFBC0613E3
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 15:06:15 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b7so776428iob.4
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 15:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ghVbd1GBYARFJUxpuM6vPGFayOKq7w19PilPKv0KbVM=;
        b=pzZcc+yywbzNtq1oUeuUHmBxv1NfucUEr3yGrFdaa79WztnjfX6aUSc0U0pl/dcoCM
         vBKntqFRywnTSBwMUv1IVCJdJMoONW6ZWi8PiHVT4udsZh3DYgM4Pa8Jm70LGzWIGvaS
         RLpvqFiM12sKFYLEalp7vwj+xaM47m9XUKL/+b/0awUJjD6GF6rmUhaZMK6qLjlWgEJD
         6nBSwA3gCknJW5nHn3lqs37h2IB8rIWWVCNxQnHd5a1RwmZmA4Y37y6fpiOjXtbwCI3t
         uzTTprcY2LqDVtPdT3NORP44LPbuyzdvIN2cSI5KlVORzQhJpX8TsdD/PIkHJ+QN6yvx
         dv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ghVbd1GBYARFJUxpuM6vPGFayOKq7w19PilPKv0KbVM=;
        b=Vmndy4uRKVfA/39WlE+FBygltp60ZTtRTtSy+VMnNFxrgKHgYcY8cfdcrHcxp5MQAZ
         kBufNgBdSYHl3GrJT4Xj12R92pGM1qX3asL9+ECpkseUmgdnliY1DeXB56SSMBXYcaQy
         iJ2fyem1yAjWe90g3XbaJz57wjUkQ6dLl7eb0Tl6Fyb8oaA/M0ufrZNFoSqwkkNAuk0b
         CmEDmULmHkyeNduf0dlPoBfhqtDp7egUn7mnuuFQDC71yKaip/hSsg0I9ID5PMoqhAq2
         jlfAg86RPlUQXqvnsmAoTOjAFkKvy26LQHVBbfOrfpI5deZcEi0vSs58F/0zMnv2sTCX
         P/1w==
X-Gm-Message-State: AOAM530vaIJIzyBTwtXxpvYE+9reizSWMovwzv1iBk3BydqKhl3pRaMG
        oHHXhF+AhUXP2ugAIsNweA7q8gww1x3FVUo+
X-Google-Smtp-Source: ABdhPJyGnuWloC9gWOweQ3runa4j9T9Nk+Lb+N+Rqt0sljpiJ6dxa1XwkXZ1PsjGVI9pDWW15VmyOA==
X-Received: by 2002:a5d:9c89:: with SMTP id p9mr15398843iop.13.1631657174824;
        Tue, 14 Sep 2021 15:06:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x8sm7524944ilc.40.2021.09.14.15.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 15:06:14 -0700 (PDT)
Date:   Tue, 14 Sep 2021 18:06:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v2 6/7] p5326: generate pack bitmaps before writing the MIDX
 bitmap
Message-ID: <040bb40548017bae807c1d349fa078c21ac46725.1631657157.git.me@ttaylorr.com>
References: <cover.1631049462.git.me@ttaylorr.com>
 <cover.1631657157.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631657157.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To help test the performance of permuting the contents of the hash-cache
when generating a MIDX bitmap, we need a bitmap which has its hash-cache
populated.

And since multi-pack bitmaps don't add *new* values to the hash-cache,
we have to rely on a single-pack bitmap to generate those values for us.

Therefore, generate a pack bitmap before the MIDX one in order to ensure
that the MIDX bitmap has entries in its hash-cache.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/p5326-multi-pack-bitmaps.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/p5326-multi-pack-bitmaps.sh b/t/perf/p5326-multi-pack-bitmaps.sh
index a9c5499537..38557859b7 100755
--- a/t/perf/p5326-multi-pack-bitmaps.sh
+++ b/t/perf/p5326-multi-pack-bitmaps.sh
@@ -13,7 +13,7 @@ test_expect_success 'create tags' '
 '
 
 test_perf 'setup multi-pack index' '
-	git repack -ad &&
+	git repack -adb &&
 	git multi-pack-index write --bitmap
 '
 
-- 
2.33.0.96.g73915697e6

