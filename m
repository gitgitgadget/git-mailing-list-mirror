Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487C0C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 22:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F7196113A
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 22:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbhIHWSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 18:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbhIHWSb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 18:18:31 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D45CC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 15:17:23 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id a22so5308664iok.12
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 15:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1VxA8eA24M/VaCbj2GyZd23biCP9gqVmYOjFWdRdvVM=;
        b=mz+EHinvHbYG/amcEeJlHbYWsthhj4FLLbI1UMBET8LdQHtrU2iMlH2YNF253jOdKO
         xmaX7HzmdmOmaFZLRitvR1JXYbEKaGbDYcrN8YVSO0OVRr1L8zTs2NK7o+9PXCzAZPmB
         yvJwpeWqXQlxjBGN4fJmBldx97qP5PhjwIme+FEMby1ciIQjFozzqpiU9m7RLemfF7gG
         bKJ+MvHBk2pH1onKNYcAVoErSSqOMVD9seScCtz4G0/cvBvYu8z0jhEFPs+9+z5z7Y02
         yQArCsJ9rdYpJ8kz+VrrGw+tsVVkMs5oMgly/BQAsn+0+51Q2/5mAc4TSJuP8SCfnaA3
         XSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1VxA8eA24M/VaCbj2GyZd23biCP9gqVmYOjFWdRdvVM=;
        b=ACWRSfBcY9dWVXWBrtdYv8uboFD2mW4Ugcl6tIiT1egACmcvYImuXoCF4+rJEZXY1a
         qgWY30SaRGDVROSzixjeWfFOmp1lMMj8G96t/MoYphhAYYQsaYmLcBXAY/gY45AQe6/T
         Vsl0qpG/jJLL+qeBW+R7Xl4eqyVxv8noUP6O/APG3BuwLpgpqlQOKne3SGnKDspzLwBJ
         yRYi4EMokKqtAQdmZxJRvWRMkiTitRn95JdruNon5WprKs/TDhe+Y9KiJ1CvpDTxxrj0
         aceJy7vq7RxGbj0BE46DFvWwCpn04r2gF996eBZEN0cBM/D75ASm+nmyFZI4hTbDlpwS
         H6PQ==
X-Gm-Message-State: AOAM5323DsjbDXLgDXBeRaErN8Z3vQSfxCl1GGjXZVdy28WEAhV3SakR
        QPv2uecqUNSibmv1nxIcVoxumcAIQP+Lo2NJ
X-Google-Smtp-Source: ABdhPJxvXHikYWfgnoZ+tuFN0ydTSP25iFYU3rLFFxgKkpcvO7yGOKkstEZ1AEOW2+XF1O84I5rfGQ==
X-Received: by 2002:a02:5442:: with SMTP id t63mr570430jaa.7.1631139442836;
        Wed, 08 Sep 2021 15:17:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f13sm203346ilk.45.2021.09.08.15.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 15:17:22 -0700 (PDT)
Date:   Wed, 8 Sep 2021 18:17:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v2 2/3] builtin/repack.c: move `.idx` files into place last
Message-ID: <925f9ada2adf4712f273140ce4da0ce49e5e6c06.1631139433.git.me@ttaylorr.com>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631139433.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631139433.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as the previous patch, fix the identical problem
from `git repack` (which invokes `pack-objects` with a temporary
location for output, and then moves the files into their final locations
itself).

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

