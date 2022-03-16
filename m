Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA72CC433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 19:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243030AbiCPUAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 16:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbiCPUAj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 16:00:39 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717B36A03B
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 12:59:24 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id bn33so4567544ljb.6
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 12:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JKvbIXV12uf/qJDU04gNLKb6MmP8Kmp3+kGg9oexd90=;
        b=FWPFeSqSlwC+vkllJQIieJpFKGfBRxiQScRquIhFwdz1zLP8b645gzHei0/hzrcxZ5
         QhosH9iKFuFmrj7bSy2TxywY3xxwLJoINiIJnai8TCftnGBBrBsRpXalIT9TRCdgC1XM
         dC7ywAV4OwzIP9R/vTZ2yqEg/7UCgw2/bxMplbmXfFSXzzKbIKoEoYyojgEzGE8tc5hq
         i15gsXCuJFwm5yQanAAe5eTkEGuaB68YBINPOmgbwMxDRWyE+/SDebduPJS3Lwa5+WZa
         OT3hqLwjcwlNJlKhWDFr1fURLuKfhEZyse1l/7WzrIno4sfM+LHaxZcqmbUyAWTEm81S
         qOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JKvbIXV12uf/qJDU04gNLKb6MmP8Kmp3+kGg9oexd90=;
        b=qaAsB9NSsi26icDwAg8q95LzWnPOoy6D4T88UmTQhqBMbeZOaryqDkwv6YvMlWWd/p
         CsXGC0v1B3nH0+jkTCeIex9k3cOq7+CcgPEIdlDdx7fKzYg1S2dNifxjtMnjOGkH8Twy
         7Rbp96UUAjUVd/2xKOm89QZj72mAzNb8ZlYrYkNJb3tyosGYZolmvDhTt2hvLRo4otWG
         HrbwXll3BKlRqH5WcQUYtgv5Fuj/p8x54BT2htQFPiRBGF+5OkzmZb/aD1k/LU3fZM9b
         EalaU6rSrO7WJBgn2XLWKyRC5YLSXRo5ke7JlugMlhteKwMBSMK93Ty3Ps1FgtvKqeL5
         RhUQ==
X-Gm-Message-State: AOAM530xB9pfNmj4k2KZwro7dnWLHsiMWEazL5rftB+CXKWy2Uwu316/
        C75TqNhf/yGe1/f/HMLGaFwyFUZ87qJzlmSAPZY=
X-Google-Smtp-Source: ABdhPJzoOb5auabQLjUSPXBVfb7tIF1id6wFVYi6+eU3aPiPafArCvAAw2XNj+Puv6jazmpfTpfaB6jct5o+z2CYLpw=
X-Received: by 2002:a05:651c:241:b0:23e:42c1:2e4 with SMTP id
 x1-20020a05651c024100b0023e42c102e4mr779733ljn.406.1647460762552; Wed, 16 Mar
 2022 12:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <d38f20b4430bada1d0dccc1e600e6f0b098f3767.1647379859.git.gitgitgadget@gmail.com>
 <65998787-15e4-fac4-1343-65df60e971d0@gmail.com>
In-Reply-To: <65998787-15e4-fac4-1343-65df60e971d0@gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 16 Mar 2022 12:59:11 -0700
Message-ID: <CANQDOdcEOb5zJDJ2GdzTPm_ULvhriX5d5p5go=PeQtHvB6mRPQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] core.fsyncmethod: batched disk flushes for loose-objects
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 16, 2022 at 4:50 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 16/03/22 04.30, Neeraj Singh via GitGitGadget wrote:
> > On a filesystem with a singular journal that is updated during name
> > operations (e.g. create, link, rename, etc), such as NTFS, HFS+, or XFS
> > we would expect the fsync to trigger a journal writeout so that this
> > sequence is enough to ensure that the user's data is durable by the time
> > the git command returns.
> >
>
> But what about ext4? Will fsync-ing trigger writing journal?
>

That's a good question. So I did an experiment on ext4 which gives me
some confidence:

Here's my ext4 configuration: /dev/sdc on / type ext4
(rw,relatime,discard,errors=remount-ro,data=ordered)

I added a new mode called core.fsyncMethod=batch-extra-fsync. This
issues an extra open,fsync,close during migration from the tmp-objdir
(which I confirmed is really happening using strace).  The added cost
of this extra operation is relatively small compared to
core.fsyncMethod=fsync.  That leads me to believe that (barring fs
bugs), ext4 thinks that the data is already sufficiently durable that
it doesn't need to issue an extra disk cache flush.  See
https://github.com/neerajsi-msft/git/commit/131466dd95165efc5c480d971c69ea1e9182657e
for the test code.  I don't particularly want to add this as a
built-in mode at this point since it will be somewhat hard to document
which mode a user should choose.

Thanks,
Neeraj
