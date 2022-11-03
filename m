Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07722C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 16:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiKCQw4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiKCQwz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 12:52:55 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695A192
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 09:52:54 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id 13so6965175ejn.3
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 09:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RjtbTwo5Vy1bYwO9f65PqUHyxV2c7MYaDLuLMgj8pY=;
        b=tpQpRCFcoRrHazA/LYBOQxTo12/bgFjb1p/cWM1YZN2pQcaUN0AFRts6KJ6QBoL+3e
         iv1NQi08Flb3qeTG370oTwt2eZygg17DumQdApZiBFKIQVTySKwR6rPUR5srwKyFKYqM
         dAgol/BFuSa/0yiGlc4cFaNsOyB5vNu0xREm9UIqaledj/MsC0SSDDkZKXCEWBwB5Fha
         OwLhioKkYjWKW53cDpE9qLC2P/zM6lVjeEast3KYFzElEiSZfGEBsGPdVQ+c9ToSjaQv
         +KZJDmPERJURFuoR2ZJVuyxTwZMZcXq6lnqUhhyRsWyXj5NBuzZY1jbCrsaw5EPZRybZ
         U3lA==
X-Gm-Message-State: ACrzQf3mgkXHDc0moF405fsVxCKc965WWLwLlR1VxDpHsPjcyGPkNNQx
        kjmQns9ya8wPOnfKxaokWkqovSwP9XjN5ZsY2aU=
X-Google-Smtp-Source: AMsMyM7lBjOgU5yWJT9tAACXctX7ITfW3WUjF3ibzeR9oRxd2OgM3Gp+wqhs/X/oStqD0E60ByARJWjNJOOxuwXfXpo=
X-Received: by 2002:a17:906:5daa:b0:78e:2bc7:f1a3 with SMTP id
 n10-20020a1709065daa00b0078e2bc7f1a3mr28595612ejv.256.1667494372844; Thu, 03
 Nov 2022 09:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAFzd1+5F4zqQ1CNeY2xaaf0r__JmE4ECiBt5h5OdiJHbaE78VA@mail.gmail.com>
 <16a8a331-f012-7dae-de1e-f03da95ecb6e@dunelm.org.uk> <CAFzd1+58MCXC9XZ+R7QFUdtw99KV2mHUHGgQUYvoa0USuYSLog@mail.gmail.com>
In-Reply-To: <CAFzd1+58MCXC9XZ+R7QFUdtw99KV2mHUHGgQUYvoa0USuYSLog@mail.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Thu, 3 Nov 2022 17:52:15 +0100
Message-ID: <CA+JQ7M-nmQAdOGERCFbhd6v4o-mxg7T5JeKAC=pAGs1SqAzC=Q@mail.gmail.com>
Subject: Re: rebase -i --update-refs can lead to deletion of branches
To:     "herr.kaste" <herr.kaste@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 3, 2022 at 4:34 PM herr.kaste <herr.kaste@gmail.com> wrote:
>
> I have the following reproduction
>
> ```
> git init &&
> git commit --allow-empty -m "Init" &&
> git commit --allow-empty -m "A" &&
> git checkout -b feature &&
> git commit --allow-empty -m "B" &&
> git commit --allow-empty -m "C" &&
> GIT_SEQUENCE_EDITOR="sed -i -e '/^update-ref/d'" git rebase
> --update-refs master^ --interactive
> ```

Some minor changes
Better explicitly name the branch master
  git init -b master &&

also
  GIT_SEQUENCE_EDITOR="sed -i -e '/^u/d'" git rebase --update-refs
master^ --interactive
in case of short-form interactive rebase

But yes, it deletes the master branch
