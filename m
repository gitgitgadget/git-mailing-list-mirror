Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C2EC433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 22:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiBQWwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 17:52:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiBQWwk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 17:52:40 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C89F68E7
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 14:52:22 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id a19so11296100qvm.4
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 14:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HN1xUZ8ExDJ8QnNO8Umnyv0LpAc3hjJNWzOp/MF6GzI=;
        b=W9YuqtqzV+xwTw9vUHF4nL8JrG9KAHPtyDSeY9ACsFO7mP1yX/n/361mUYD3nTWNnH
         HgUTTyX6t3RpR432PcWJ1SBlKW6dPboGSAXoSZaYPU9BXPU1xPBni/MF/VXNpm10eXdz
         mkuaPLcF1VWGRp8nkX00EQoo+o7d2RssxFXkFMgxpY4rjfvxlspySovPWF0AevLJUL8D
         IXF/Z8Xj17DiiVALpPcvM14If8N/SNzm+Tu7k84ROSycrIggPDgyJZkTd/NWqhGy8kt8
         6vTw4URryU5kwS+X1SQVY46f1e0WcaQJrNghcljy6Y9KpFZCj93yK+P7z8i8bkiynwUz
         nBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HN1xUZ8ExDJ8QnNO8Umnyv0LpAc3hjJNWzOp/MF6GzI=;
        b=tmMRq/Mw+7RBaYmM0ifcoG0i0tk6RV0DqOYukrDDrho9tGAkAvRLv8jjeIysnDknoL
         NaZX6bSPJAAfwa1P5PyxfCLweo2Lcj5u8ZNPBb3yXqbIjg9QgL5gbBmz71MosIqWIw4e
         dAYdrN5ge//YxIVCby349pkCxXoK4HrVLGWWd8C1sNhiyR4uutdtMR2+2yBHr70gIt7w
         yX4IfxLt4WTn+WDG80pXYFqUqDQJJtsZ26ez5OLmgBjt1Bnndr1/qMWN6LUoM4a9SlAV
         jdTpcULjnXWwuzwYjJtiCXFtM8LDA1EeP8fVC2m2MB3EeLCdYmuJmXxFDr0fKDWb28B1
         WboA==
X-Gm-Message-State: AOAM530hF0aeiigBu8XAKIeB8ypTYpJnKD0DedMgWueCQSLPp8KVKjmC
        /ibCI81O8OsvmrIRLSh5ebetLcPU/3zoQ3AU
X-Google-Smtp-Source: ABdhPJy506hWCxJr9jkyV/kFCHwE3uc86WOR7dZMu/HmPhGa0n51HlUnZ4WO2kxHxkn/1rsE9WxRoQ==
X-Received: by 2002:a05:622a:54e:b0:2d1:83db:25e1 with SMTP id m14-20020a05622a054e00b002d183db25e1mr4346355qtx.110.1645138341612;
        Thu, 17 Feb 2022 14:52:21 -0800 (PST)
Received: from edef91d97c94 ([50.234.189.46])
        by smtp.gmail.com with ESMTPSA id t15sm16374392qkp.48.2022.02.17.14.52.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Feb 2022 14:52:20 -0800 (PST)
Date:   Thu, 17 Feb 2022 22:52:18 +0000
From:   Edward Thomson <ethomson@edwardthomson.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v2 0/1] xdiff: provide indirection to git functions
Message-ID: <20220217225218.GA7@edef91d97c94>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello (again) from libgit2; this is a v2 of changes to xdiff to allow
us to work together more easily.  As discussed in the previous patch
(https://lore.kernel.org/git/20220209012951.GA7@abe733c6e288/) this
adds a simple abstraction layer in `git-xdiff.h`.

Other xdiff users, like libgit2, can specify their own compatibility
functions in this header file.

Cheers-
-ed

Edward Thomson (1):
  xdiff: provide indirection to git functions

 xdiff/git-xdiff.h | 16 ++++++++++++++++
 xdiff/xdiff.h     |  8 +++-----
 xdiff/xdiffi.c    | 20 ++++++++++----------
 xdiff/xinclude.h  |  2 +-
 xdiff/xmerge.c    |  4 ++--
 5 files changed, 32 insertions(+), 18 deletions(-)
 create mode 100644 xdiff/git-xdiff.h

--
2.35.1
