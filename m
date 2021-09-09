Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6F2C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 03:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC03061167
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 03:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350195AbhIID0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 23:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350167AbhIID0V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 23:26:21 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5957CC0613A3
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 20:25:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z4so363436wrr.6
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 20:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7nqV9WfFtPETODmBhucsE1hvbSzAfz7L/410X/EGp9c=;
        b=S1nTrpNQUJvWnkBXv6l3W4e97FP6qbReSl5DcEeRRShgPpmDzbXtdu5NQnuOlLF76v
         KC0hmDCTuNuDpquAMkrintsVc36xLSeqB+xaroUtqeY9/x1Ngh3CZmD2TVh+U0Qzb1Nh
         yQIXRl/60JNiIYlxMkSGdbUr8lhKLITTTQkwMEp8Y/38hJEn55jsGeUWg6Ze4Gm+JEWx
         CyCp/UC77hyOlc3sE2BipOSEw/FtmNX+MS5cKCriMO9gfj0yXdggP7F7Fad08OQzyTyG
         o1q/nr7XppVG0OHCKtEe7RlaC9WPo5yujboNJvm36KX+60hYGYuIkeGquaZsvyrpy6tU
         itFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7nqV9WfFtPETODmBhucsE1hvbSzAfz7L/410X/EGp9c=;
        b=YrNYd0qVfWK3oGrYjFd463g+afaejuq7k/xVFoDnpNUm/IqI2lJryOOgEl2UOGZW/N
         qbvVUaP8gzjbfFROPXyqcWxksCg0F0Dlugq6oZsPZnDwg2obvwLG/1NTy8CuxhuJY5r4
         QBdHaTC5oNAusu8KDmZInzo2Kw3CO1RZD+GU4UZaTY2UccqU9OTO/o494ykA2BwmKad8
         vPkSm8iY8pow9zf+MpfrG2j6uOAzkUYrhEiRwyT0DVGuldcszAFzwKsTFczIseZa3209
         AjXqp3/o0A29CYnJLMziWLBri9o1lJmORQ4R1Awk1zQPdsDbnFKLogqGvUVfDiiqm5Ri
         u2bA==
X-Gm-Message-State: AOAM532KYlTFtd2fM5+vwv78a7aU/l1B9dgiOsXmJ1D0i+TiYmvFNafw
        aTC9UTYkm2dcfD4Rf0flB0jNQg/r56YuowJ2
X-Google-Smtp-Source: ABdhPJxkSbBA4KlXBa9kA01wDeGxdrjef1H0GkofpO76b2/VVMffbp8kAK3h6XSH1DI25bLGeUElEA==
X-Received: by 2002:adf:b785:: with SMTP id s5mr822221wre.30.1631157905693;
        Wed, 08 Sep 2021 20:25:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i5sm395027wrc.86.2021.09.08.20.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 20:25:05 -0700 (PDT)
Date:   Wed, 8 Sep 2021 23:25:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com
Subject: [PATCH 5/9] builtin/repack.c: move `.idx` files into place last
Message-ID: <3b10a97ec0e7c9e672904e6415909a1b8cea872e.1631157880.git.me@ttaylorr.com>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631157880.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1631157880.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as the previous patch, fix the identical problem
from `git repack` (which invokes `pack-objects` with a temporary
location for output, and then moves the files into their final locations
itself).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 5f9bc74adc..c3e4771609 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -208,10 +208,10 @@ static struct {
 	unsigned optional:1;
 } exts[] = {
 	{".pack"},
-	{".idx"},
 	{".rev", 1},
 	{".bitmap", 1},
 	{".promisor", 1},
+	{".idx"},
 };
 
 static unsigned populate_pack_exts(char *name)
-- 
2.33.0.96.g73915697e6

