Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23854C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F11B0206B7
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJf2A72K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbgFOK5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbgFOK5q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 06:57:46 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34515C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 03:57:45 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e12so11173201eds.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 03:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=lMbIcEtG/y0o/RKjCXwRna6GLoLNtpR3DRyn4sO43vc=;
        b=tJf2A72KZ0HiNmi/Kqb0Z49rM3phBLUD4263SSftSnBsOLb5l3fS07H/wLmSjWS0Pb
         G5RPpNRo/umadpujWF7Cvc7EiQJijQUV2AcVm8tovysuUvrMpnzgPuUs4WA2PWfoebHi
         pjo4yypYl4214tqEQAe6/0AEwokOFA1BC5vC2QQ3CG1xF7weEfyFCmlbmIEQpJEp8NWc
         dSCEWgiVT/d1k9dgs35UdWoGOHa+i1fjbnvr/OdObO0BVzpqNbH8GN0Db+Xt3z8HQslH
         eXdUsx3vrjaOIeEdQPwKG0nyBnU43c38xyjy7DhUzMYFG67fQ+mBz+K68IeqwRLHu0uf
         HrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lMbIcEtG/y0o/RKjCXwRna6GLoLNtpR3DRyn4sO43vc=;
        b=fe+5XM5SPg3O+SC70i/FRjPE4/q/jCHxwLVwHTD44X1P7PRQ/h7daujeYrGtdvqAtN
         UoThZ486WOKVKczZ0BxjIoAMVPijIN5EB0DZyxD55ARfFMwoqp7Vq5TQFbyx//Pg+nkg
         QCVO9+NHJr3Q7BS03QBIMXe9YGoEdAicZ4k6egX5ZqPxd0sJGqkz/dLOYARYbNqrPR6R
         GUGnxoyWTVbrj1T+UEdjIkmeT9lK2SsjPgeHh6zCJcEuHrciHrm63T45iKXdjw1lx2K6
         exJDJTcQlWOXmy6nxkNB6mJ50H5fLIXmsy1b6eK+k4Qq8qQdA5CK1ys52SIqzY+dqP91
         8gJg==
X-Gm-Message-State: AOAM532mLEnQwsma+OiVKsRPEOkzIyVMVkF7wF4bBx+b+RVyHXJXbE0A
        w7mHBBftJTu2AIHYTO+Mf+ec3XwC
X-Google-Smtp-Source: ABdhPJwb5eRBwNPvGEtSpTXBx2MsFYivm1A4l/ELS6D+SZGJYQQA+7oIT8P/LhxLmo3srFefhx7/hg==
X-Received: by 2002:a50:ee08:: with SMTP id g8mr22251732eds.267.1592218663762;
        Mon, 15 Jun 2020 03:57:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v29sm8152532edb.62.2020.06.15.03.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 03:57:43 -0700 (PDT)
Message-Id: <pull.658.git.1592218662.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 10:57:37 +0000
Subject: [PATCH 0/5] [GSoC][RFC] print commits using ref-filter's logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a step toward reusing ref-filter formatting logic in pretty to have
one unified interface to extract all needed data from the object and to
print it properly. 

In the process, I made few modifications. Although it doesn't impact the
current flow of git log unless log.usereffilter is set true.

Thanks, Hariom

Hariom Verma (5):
  builtin/log: new config log.useRefFilter
  revision: add `use_ref_filter` in struct rev_info
  pretty: introduce `get_user_format()`
  ref_format: add option to skip `\n` at eol
  pretty-lib: print commits using ref-filters logic

 Documentation/config/log.txt |  4 ++
 Makefile                     |  1 +
 builtin/log.c                |  8 ++++
 log-tree.c                   |  7 ++-
 pretty-lib.c                 | 84 ++++++++++++++++++++++++++++++++++++
 pretty-lib.h                 | 21 +++++++++
 pretty.c                     |  5 +++
 pretty.h                     |  3 ++
 ref-filter.c                 |  3 +-
 ref-filter.h                 |  4 +-
 revision.h                   |  3 +-
 11 files changed, 139 insertions(+), 4 deletions(-)
 create mode 100644 pretty-lib.c
 create mode 100644 pretty-lib.h


base-commit: eebb51ba8cab97c0b3f3f18eaab7796803b8494b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-658%2Fharry-hov%2Flog-ref-filter-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-658/harry-hov/log-ref-filter-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/658
-- 
gitgitgadget
