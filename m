Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925E5C43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 15:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiF2PZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 11:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbiF2PZj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 11:25:39 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9C6313BA
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 08:25:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f190so9295109wma.5
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 08:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=a/d2InWv2NPZ7x3u8jE5llcJzGx7skjNDBhdYNizyEI=;
        b=Q5+mH07h/LCegNSQsBvno18dTwJIHr2JZNxULGVnjgIxQB76u5kNVdCK61q8IAOSwt
         OCtBdNglIHCrAc+CiYPVT7s+4/pkyTDwXrh1FD8oPGGrzKy6KiuJvO89Dgc0j/QqH1jt
         JhqlXmrx5au+Qc8qrR9YgH4dCO0zjowCLa7Tw4zgjCSbfMqacX4Akx+5ncaMt1vFsssy
         YJs3wvbzGReuWzMNWgBe10C6swxkskZR4yHvmpgIpBEKYqnKakQ2dBQU2xWD53mwqLxI
         eBTG3vEy2jkVRnuaSjRBrPhKsjR7mkp5sLzxE42NEFenfWV8Df3f2SEXDNDavKFMd/I/
         n5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=a/d2InWv2NPZ7x3u8jE5llcJzGx7skjNDBhdYNizyEI=;
        b=AT5coidlw1sfJOyMqVNhBG2WEdeThc1dBDSRUSvq6L3ANiD41z4A4ser3m7yt4SKuc
         9Owg6oB5PYMC9JTVIGuldb1KV/y0XtK6+sUcTCVZXO7TQPTeRkql7FleD4TlC4TRSbdc
         xcIh9BYHvBnwsnfqjh1k9GXEQLPC+RL75UHbAl/hJQTsN4XsKwiqZuiUxyubbtpgnNBP
         rUz8KQdbKFK3JpUckM+0i1XLjP+O98IKke7tRTWWQj/rw03ThcJUHtS3UkdX6TvZXYBQ
         VQkBOw2dQNyQPu95uB0kfIhBzmJIDpkG/2cxVdjd3hgzv1QhGrNpQtLab39V7ROaaMhb
         fa1Q==
X-Gm-Message-State: AJIora/nX1SNRqk+/4D4Y5D7oswr6ekTHbAJNxnwb6uNUx9rqlELCmF8
        wIrAqndEY6wAxU16hz7dgddPcirlVbjsUQ==
X-Google-Smtp-Source: AGRyM1trr3g2bEAiyTOJ64ULHAXzITWJjXtMQ92BRoWpaBQVLQ3faD3R1/1wVE0IfNWVFg1wRhIxnQ==
X-Received: by 2002:a7b:cb82:0:b0:39e:f9cf:12b7 with SMTP id m2-20020a7bcb82000000b0039ef9cf12b7mr6355344wmi.135.1656516335588;
        Wed, 29 Jun 2022 08:25:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h3-20020adfe983000000b0021b97ffa2a9sm17571788wrm.46.2022.06.29.08.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 08:25:35 -0700 (PDT)
Message-Id: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Jun 2022 15:25:31 +0000
Subject: [PATCH 0/3] xdiff: introduce memory allocation macros
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series introduces macros for allocating and growing arrays in
xdiff. The macros are similar to ALLOC_ARRAY()/ALLOC_GROW() from the rest of
the code base but return an error on failure to allow libgit2 to handle
memory allocation failures gracefully rather than dying. The macros
introduce overflow checks but these checks are currently redundant as we
limit the maximum file size passed to xdiff and these checks alone are
insufficient to safely remove the size limit. The aim of this series is to
make the xdiff code more readable, there should be no change in behavior (as
such I'm open to the argument that these are just churn and should be
dropped).

Phillip Wood (3):
  xdiff: introduce XDL_ALLOC_ARRAY()
  xdiff: introduce XDL_CALLOC_ARRAY()
  xdiff: introduce XDL_ALLOC_GROW()

 xdiff/xdiffi.c     |  2 +-
 xdiff/xhistogram.c | 19 ++++++-------------
 xdiff/xmacros.h    | 21 +++++++++++++++++++++
 xdiff/xpatience.c  |  9 +++------
 xdiff/xprepare.c   | 41 ++++++++++++-----------------------------
 xdiff/xutils.c     | 17 +++++++++++++++++
 xdiff/xutils.h     |  3 ++-
 7 files changed, 62 insertions(+), 50 deletions(-)


base-commit: e4a4b31577c7419497ac30cebe30d755b97752c5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1272%2Fphillipwood%2Fwip%2Fxdiff-memory-allocation-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1272/phillipwood/wip/xdiff-memory-allocation-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1272
-- 
gitgitgadget
