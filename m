Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEF2C433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 23:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50BED64DD6
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 23:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhBJXDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 18:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhBJXDE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 18:03:04 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DA1C06174A
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 15:02:23 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id l14so1743234qvp.2
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 15:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=H5scUO0k+LPO9DWCXH8G56TO/jvRwq+3OPzIjdyazbQ=;
        b=qMgQxuLHYpWWN3o5p+QnFAmC18XRlzrdz29O2qeGdZYw/Dj45lmY87GjRkkzY/t8wt
         uRQICl4M/TBR1gv3r0kGnsdZ0Lco3f8aPtctF5XKngFc0+ScrA+gakH6UHtknnvpAd9e
         OyGd3ugHyYnDWwREL4/+PcVmhCDQo6L6jlVIgI5/2AZRgdVVgABrS1miKBOvYy8Ce0yN
         GhjGSzMu01TA80cNCi5HKIMvCc07V87quoZyb5XnByq33zh551Znwu8l8/hMjDLjwokS
         Pv8gJ0UCIKXk31UYLpTY+u6DZFlid3ysyubiV89q1VwnxCIC35vQ9LROLTP7pY3QEGz8
         hu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=H5scUO0k+LPO9DWCXH8G56TO/jvRwq+3OPzIjdyazbQ=;
        b=lvQ/kER40TXrJhgPj3CUGshEWDiZ3pJOjFk3Uwqj+WEiFgTTkr3rHtLJ4XMaWZFTxP
         vRmTy327NHYXDlUMlonS7ltWJEKaZz4IxClGparhYjK7EyCsOj7Dr9yF186uqzk149s1
         8RKJWMvYTYBDRwaY0SpTGTrPalFDQH4uEFPWs6GDiV2p2AZePWPDp6XVgxMqKaSragsg
         Ywv/SS1pPPQQpp77lhh2v/D6vkSXeE8U5lbxRhQ5ZdKOnPWy77VCJjcXOfiVZcVczXYU
         Nwx7vdJKdQqbVGd/Y2gG5PpRTvne43AIzXPBb5Pk28h2rQXfJrYmdu0zsauJAlCo52ix
         ZUPg==
X-Gm-Message-State: AOAM533ZF1ypE5Sce+9DoKNTUHtPXvJtAGnTCgqsqtbHwkN2K974bOJg
        9bvW4DQtXewSkHqTcRzrxXmFkW4SV+Is/VOX
X-Google-Smtp-Source: ABdhPJwHt2M917pGd5d2Smb9qNSsioJsrEM4tJ99Y8x7/y+kLd+k74mAY+SYQ57DCiMqjlg3Ep/BDw==
X-Received: by 2002:ad4:5445:: with SMTP id h5mr5067236qvt.22.1612998142075;
        Wed, 10 Feb 2021 15:02:22 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:2c3d:3179:bfad:c65])
        by smtp.gmail.com with ESMTPSA id 196sm2482586qkn.64.2021.02.10.15.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:02:21 -0800 (PST)
Date:   Wed, 10 Feb 2021 18:02:18 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 0/9] midx: implement a multi-pack reverse index
Message-ID: <cover.1612998106.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series describes and implements a reverse index for the multi-pack index,
based on a "pseudo-pack" which can be uniquely described by the multi-pack
index.

The details of the pseudo-pack, and multi-pack reverse index are laid out in
detail in the sixth patch.

This is in support of multi-pack reachability bitmaps, which contain objects
from the multi-pack index. Likewise, an object's bit position in a multi-pack
reachability bitmap is determined by its position with that multi-pack index's
pseudo pack.

In this series, there are no users of the multi-pack index, so this series is
mainly about laying the groundwork for implementing multi-pack bitmaps. This
series is the final prerequisite needed before we can implement multi-pack
bitmaps, which will come in the next series[1].

Since tb/pack-revindex-on-disk is queued to be merged to 'master', but hasn't
yet been merged, this series is based on that branch.

Thanks in advance for your review of this series, and all of the many other
series in support of multi-pack bitmaps.

[1]: If you're curious, you can find the patches in the tb/multi-pack-bitmaps
branch of my fork at https://github.com/ttaylorr/git.

Taylor Blau (9):
  t/helper/test-read-midx.c: add '--show-objects'
  midx: allow marking a pack as preferred
  midx: don't free midx_name early
  midx: keep track of the checksum
  midx: make some functions non-static
  Documentation/technical: describe multi-pack reverse indexes
  pack-revindex: read multi-pack reverse indexes
  pack-write.c: extract 'write_rev_file_order'
  pack-revindex: write multi-pack reverse indexes

 Documentation/git-multi-pack-index.txt       |  11 +-
 Documentation/technical/multi-pack-index.txt |   5 +-
 Documentation/technical/pack-format.txt      |  83 +++++++
 builtin/multi-pack-index.c                   |  10 +-
 builtin/repack.c                             |   2 +-
 midx.c                                       | 239 ++++++++++++++++++-
 midx.h                                       |  11 +-
 pack-revindex.c                              | 112 +++++++++
 pack-revindex.h                              |  46 ++++
 pack-write.c                                 |  39 ++-
 pack.h                                       |   1 +
 packfile.c                                   |   3 +
 t/helper/test-read-midx.c                    |  24 +-
 t/t5319-multi-pack-index.sh                  |  39 +++
 14 files changed, 591 insertions(+), 34 deletions(-)

-- 
2.30.0.667.g81c0cbc6fd
