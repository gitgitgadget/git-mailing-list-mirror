Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E01C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB9B9221F8
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGJTE1UK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgKQQMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 11:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgKQQMh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 11:12:37 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE7EC0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:36 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id d142so3784564wmd.4
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bqnnc6DRfudaGIlMY9/t4Ry607yj07KWLabzb+YCGvU=;
        b=YGJTE1UKSpPa/GxB+KxtdsZlxSbh48zGJm97tMikIGA8cevCRb/iIurDitivlDg/gJ
         54rIVlZvKfIPoUGSzfPo8c8er8Qj+sdgkD29U5QqdjlTTuBbQgIocldvwCFvy0eWAusU
         zhFHuacbmGYqmfQ9e0JgJ+eVqPZaiV+pcyRyr8BgWWhLiN4w/4KsXnv+lLbSO4arpnM0
         4G+UypBOiju1KqFM/P+9M88bxuF08E4DLPT+c2OX8AZ367VR0+GvtwwnyF85YpowqP6v
         2g1rn2tJJaMlAhfkK5OoCnDIib/eqYADs2K+IDOpZHuboe3YGyGhvwKT+GkPLAk2/rsQ
         x2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bqnnc6DRfudaGIlMY9/t4Ry607yj07KWLabzb+YCGvU=;
        b=IqkUCgemJgAXHNPlZXtHfAOEp1G9oBc13XfvK4y+QH085qxFAjStGPlr2Zmq40Ztp7
         t3BpRT78MEauSvr9axl/3wFAnRPHXSFeyyex9AZaNJ4KsFvfItLV0iuf64Apg9g+BrGB
         Ka2ge1HfICzzKo4t2MBagcTIguGIICYxylS22ZxV+HYztid73rZGU8AUCReVGQ7DH8vJ
         ciFvxSn1+OB0rcYSjEKJPH+Wx0CiSDfk5Txrea7OVXtXe16tEe+qLbDsCY1F2Vy2zp4K
         Vg1af/4tGPokjouASSRVo4LdwdXHmvlbek1pp5L6qYkx9HF32rQByRD0ybJjZWXNdNz0
         oLng==
X-Gm-Message-State: AOAM532ps6uGHTdvNnKsezkY/8ltjfoVfHA0kMVY4eAxJnjXEbtvPCfV
        c2w23nQ7/yhsYlpxtrTUEApdtp8E/LQ=
X-Google-Smtp-Source: ABdhPJzbkmjNVXj37rMH/hNEVTKov6/TpsMb/QzfggII9hCUH71l7fZpAJr1BNvJ8f6dsvPdGrUSiQ==
X-Received: by 2002:a1c:35c2:: with SMTP id c185mr422351wma.74.1605629555407;
        Tue, 17 Nov 2020 08:12:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j15sm30074621wrm.62.2020.11.17.08.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 08:12:34 -0800 (PST)
Message-Id: <041ad86e3342b6cc037ee14a3baa4ff15ec41a8c.1605629548.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Nov 2020 16:12:05 +0000
Subject: [PATCH v2 05/27] t3416: preemptively adjust alignment in a comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We are about to adjust t3416 for the new default branch name `main`.
This name is two characters shorter and therefore needs two spaces more
padding to align correctly.

Adjusting the alignment before the big search-and-replace makes it
easier to verify that the final result does not leave any misaligned
lines behind.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3416-rebase-onto-threedots.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index 9c2548423b..1f37adf56b 100755
--- a/t/t3416-rebase-onto-threedots.sh
+++ b/t/t3416-rebase-onto-threedots.sh
@@ -12,7 +12,7 @@ test_description='git rebase --onto A...B'
 #
 #	    F---G topic                             G'
 #	   /                                       /
-# A---B---C---D---E master      -->       A---B---C---D---E
+# A---B---C---D---E master        -->       A---B---C---D---E
 #      \   \ /
 #	\   x
 #	 \ / \
-- 
gitgitgadget

