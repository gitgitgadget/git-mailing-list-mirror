Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446C1C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 02:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 278F260462
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 02:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhH3Cto (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 22:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbhH3Ctn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 22:49:43 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189B6C061575
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 19:48:51 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b200so17985125iof.13
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 19:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ua9w8+9Sh+2M04FWli0im9eNwYoDwXTzhybatdVG2Bc=;
        b=G44uSDKXmu7P7l6WiRgAVMPXOgznGifA1U4WBDoc36lZcKOIplblefBaegLWEaaj3Y
         N5p/6gluUd/8aiwggxr65JWPfM9+DF0AtJWimAtDlzCjV4sUx8Q3W13grInFRjkQmIut
         DaWj1sHFm26bAkHlGr3AHFkdV50fgecp21Tsh2pdzf3Gl47pgeFqGYhgI5rvipSCpz3U
         GDZxOVXm9+C8DhhkG8+WGoTGKnZves/KOWSz51KZEcEPya53r9L238lJNMXgwSAWHbMU
         NVPhrm1YqSSeUiSrrr9BKnxVZ4Huz0RTvsC//mFUlGHhQc30XcCsFaR1ElFDr2PPwLHT
         4MNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ua9w8+9Sh+2M04FWli0im9eNwYoDwXTzhybatdVG2Bc=;
        b=nr1/KOvEn++cO6wRqbn4lVz8ns/av+fXH5R/LKfBCGqtp7Y8Sbw7nuQxkzTJp+mfku
         FEFpJG/2FObSA+GZMWlkEt8osyk5WGDGrxtdU3JcfKhFmiSrx3GtX/XvetJqPUm/nFQ9
         KXMfdeU277RyZp9uBKKnLulnJcnGczk2SCafbosKEpBJb8X5cbsj/2l70+nb7qPruojH
         42BSUbCeXF6mlqCVlJ1JJ7xZZev5/VYpFqsu219ZQdDtYH71MHH+Jt8DtlBTzVFB7rnB
         3oAPPxbW06uk00OynmxKtHIFIVJjD0q0QR5H/GHBSLqpry5PEwQz9HJVNhU7lP/lAZ6g
         kfsw==
X-Gm-Message-State: AOAM5331Cumu+A/CbnTOfwY5k74reQ2BcPvc/kDO0fcd52bnctDZ5oGr
        XV5441Dq7wEG7HrW+NXGCN6DtTsnIzQJV/w/
X-Google-Smtp-Source: ABdhPJzG4hwvfo0pVxq6QVUwCBlxMHZwXdq47BhxmdcCrfsh18PifHw97o1QCo3HrREtkZfrhrTn3g==
X-Received: by 2002:a02:9082:: with SMTP id x2mr18444310jaf.44.1630291730323;
        Sun, 29 Aug 2021 19:48:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l19sm7731571ilk.26.2021.08.29.19.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 19:48:49 -0700 (PDT)
Date:   Sun, 29 Aug 2021 22:48:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 0/3] pack-objects: simplify add_objects_in_unpacked_packs()
Message-ID: <cover.1630291682.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This short series is extracted from mine and Peff's work on cruft packs. These
three patches focus on cleaning up add_objects_in_unpacked_packs(), which is
used to implement `git repack -k`.

The pay-off for this clean-up is significant, though: we net -50 lines of code,
and the result is much more readable, at least in my opinion.

The changes are described in detail in the patch messages, but essentially we
are replacing a loop over get_all_packs() with for_each_packed_object() after
adding a couple of new flags necessary to make the switch. And once we are done
with that, the third patch removes a bit from the object flag allocation table.

Thanks in advance for your review.

Taylor Blau (3):
  object-store.h: teach for_each_packed_object to ignore kept packs
  builtin/pack-objects.c: simplify add_objects_in_unpacked_packs()
  builtin/pack-objects.c: remove duplicate hash lookup

 builtin/pack-objects.c | 85 ++++++------------------------------------
 object-store.h         |  6 +++
 object.h               |  1 -
 packfile.c             |  6 +++
 4 files changed, 24 insertions(+), 74 deletions(-)

-- 
2.33.0.96.g73915697e6
