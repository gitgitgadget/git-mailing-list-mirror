Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98297C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 02:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C03961059
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 02:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241003AbhIACGt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 22:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhIACGt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 22:06:49 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28504C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 19:05:53 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z1so2100044ioh.7
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 19:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=XnJYc9A7kujWoCARuwlYtyyFpdZ5lQWTG8N/4KCm0/U=;
        b=QvC9sTVoXKfvKIsKAsNjlt+2mKDohAS3rIutmidEEsT9a9Cp4sVDWmPZAo7EfS5lt8
         oGCIDRVbGiT65VLPOk4OlCqRBdBZhwOP0ZqhNi2A/PxMKL0b0Yct48Gi1ZeEcLES2j30
         3fUcjysGNw5ZOSfBsO0KvonqoDtneTn3DGSo5QiqLh2fLiVIzoLiBcujTQS+U6BxQIo/
         WMYVMBdyjvUDG0SV7fh1ovN814xSq1mJVXybQxwDVgrBg8ffnOhkTswxQ2Jxo04wJ8UL
         /n9f0QR8RaulKniwqj3iHESHujvGF59a/xZmgF5DjT5grTG6oXbrreE5uoPiudDxncKi
         leXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=XnJYc9A7kujWoCARuwlYtyyFpdZ5lQWTG8N/4KCm0/U=;
        b=hzWToBCfSrOoOmyu9ANalKBCtKFUql4lVZWJ3Z+z0/UajPKnkhPwELL04h6qlVys2d
         fvR2ZyS2zHmv9T4v4D3SgBkOjsPHv79jaVJeEuFiKcYax6po8fBkmyygSUndV9ScUmAB
         vz6FrpK4yfB+xtWOKW5gSYtlo5ZmSZFWsLdRKDeuaOKJzgMmnMGYikz1a+Bmgx56td9s
         RW+eFJM+8RQy4mL9i2HjWi3nbsLp2PXMa5E/2sb/qF06LRg3PQ671NlVJ2HWhW9X1lv3
         mm4L7pQCN3fat9DitCpZts9NtBUkl1eCXV3ppLlUcVpKS5pqve+caof3x+qogmcIcCrW
         Cndw==
X-Gm-Message-State: AOAM533E9a759oxqUsMDGNdKAWZ70dD/bSYHsoSBpp8OlmfYVhSs8wIN
        OqrMmjv+GpMqgGSfyWO3zLwyEShbsx/+rGmU
X-Google-Smtp-Source: ABdhPJy/JmDoAzPRsOfYa26dkQ4xspI74XThPiL2EEm/eg8ChLvThxmajM2DBiK8WGgolip4QWUCIw==
X-Received: by 2002:a02:a1c3:: with SMTP id o3mr5648523jah.59.1630461952424;
        Tue, 31 Aug 2021 19:05:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a17sm11273572ilp.75.2021.08.31.19.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 19:05:52 -0700 (PDT)
Date:   Tue, 31 Aug 2021 22:05:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 0/2] pack-write,repack: prevent opening packs too early
Message-ID: <cover.1630461918.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This pair of patches fixes a race where the .idx is moved into place
before the .rev file, allowing the pack to be in a state where it
appears a .rev file wasn't generated.

This can cause Git to inadvertently take the slow "generate the
reverse index on-the-fly", which does not impact correctness, but is
unnecessarily slow when compared to reading the .rev file.

The race is fixed by moving the .idx into place only after all other
pack-related files have already been written. The first patch fixes
the direct `pack-objects` case, and the second patch fixes `repack`
(which also renames pack files around).

Thanks in advance for your review.

Taylor Blau (2):
  pack-write.c: rename `.idx` file into place last
  builtin/repack.c: move `.idx` files into place last

 builtin/repack.c |  2 +-
 pack-write.c     | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.33.0.96.g73915697e6
