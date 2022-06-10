Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EF1C43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 12:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343655AbiFJM7X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 08:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242506AbiFJM7T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 08:59:19 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6402EE100
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 05:59:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i64so241835pfc.8
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 05:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=2pgx5STRXeO/V9DZlG4VYYwrSgfv2iPni05lvgoGN1A=;
        b=a1EI6QJoL30+xGcmL2y3nNfvEx1Lxqm4rrRNPIkQAwqZVCqgZ9y/txmFjvxgPYK2DW
         mLzZdkn8ZevVDS9c0n25V4HMdMPo6z/nQJWPP9GKKFQMQv/i2DEQe4DC6mfly/k5Uo7x
         ue52aZo4Jz301kBSwS/3RCX4diN0Ox6OnBt13VGJVGoAzvEkAQaIio6QIPKnxyGQtaFo
         AUTIDERALbR6VPiT9cu7Ekrg419n7bM437yT/MbDGXot4HfsrnXWTFs7cW0O0jeA84UX
         8S9++iNpewsm45Rj5EOZQg/11YdJGe8+6K7vAnvCNBdMocUEI7zU6RgmDFQs1v2Rr3Cd
         MZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2pgx5STRXeO/V9DZlG4VYYwrSgfv2iPni05lvgoGN1A=;
        b=TpnZ2uueZjuW8zUdRM3PYI8TU4T2hVX7ui4+VbCsXcDG3JrFqUq384CAlzI4o2l0A5
         yKGdRPZZL9BfUhnZftvjXtlMqsbWmJ1ouKKYETz7Yq5H0RZ8mBsxQgIXtznII786QkAV
         nbXPFu0SltOP3tc1yTqLRu/BzGUi8y1FLoHeZlJ63yiHPFp3FeNpZTQxiQvxSUqhAjW1
         2gxCaJ4i5nhmt/DMn77pvCTy8i96e0U7nMLf/Ve4aj7Xuu36LnSWnS2yOhHXXUvCq3n1
         4efo+H8uPGI65oiCvvG54K1QaRKAO1fX4C/+a+tcQaEYO5QnnfWZD/+2bm3IjegoJ4Je
         CN8Q==
X-Gm-Message-State: AOAM533H0XwkxwCjrNI+GQXxcWXfxbIYtuW5MrZgaVesDYw3dilvtWf1
        grPjP51BJvNY9x8eE28l7bp0qv7zjD2ZMEOI3cT2LP0ki7QcAQ==
X-Google-Smtp-Source: ABdhPJzIfCeKLuGOC1KRYwqb2In42Y1HJdQyYni1Ya8a8U+0tM/IbwEsf8qM8a1wvZJvjEPvLzVW47smWiP3jg3cju0=
X-Received: by 2002:a65:6954:0:b0:3ff:b00a:8a53 with SMTP id
 w20-20020a656954000000b003ffb00a8a53mr8550511pgq.451.1654865957502; Fri, 10
 Jun 2022 05:59:17 -0700 (PDT)
MIME-Version: 1.0
From:   Pavel Rappo <pavel.rappo@gmail.com>
Date:   Fri, 10 Jun 2022 13:59:03 +0100
Message-ID: <CAChcVumTgNqRTt=EtThXiw9ga=W9WC-uS0XOkz7T+TbtGKeU+w@mail.gmail.com>
Subject: Should `git remote show` display excluded branches as to-be-fetched?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a console session:

  % git config --get-all remote.jdk19.fetch
  +refs/heads/*:refs/remotes/jdk19/*
  ^refs/heads/pr/*

  % git remote show jdk19

  * remote jdk19
    Fetch URL: git@github.com:openjdk/jdk19.git
    Push  URL: git@github.com:openjdk/jdk19.git
    HEAD branch: master
    Remote branches:
      master tracked
      pr/1   new (next fetch will store in remotes/jdk19)
      pr/2   new (next fetch will store in remotes/jdk19)
      pr/3   new (next fetch will store in remotes/jdk19)
    Local ref configured for 'git push':
      master pushes to master (fast-forwardable)

I would naively expect the pr/1, pr/2, and pr/3 branches to be either:

- not displayed, or better
- displayed with a hint that they won't be fetched (since they match a
_negative_ refspec, which is the second line in the `git config`
output above)

Thanks,
-Pavel
