Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136D9C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 07:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66C060FC0
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 07:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239236AbhI1HaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 03:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239083AbhI1HaY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 03:30:24 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3351EC061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 00:28:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ba1so21570338edb.4
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 00:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=2oAzjBtU8tDhW0pdEe4oG9wzWj2JhEqxJCtaweFJDrY=;
        b=Bm17rNIGQyP4yBGnv5WTjX1XLo5ewWccPd+JyXtoxUSXNUlDIvDSr2VkWpCAWSuc1c
         JmIhvJdHozjdtH+W0U3Eo2aw+A+MPNRX9ilb79XrSOFI8aI9/XtD9FNu49DDlK+faLiY
         DpJ8TRaTxVkwZhjtHc23pnm+ws45zTXFR2AYe1fTSmRK7BIQXlR72tucdWez8VLaxlI+
         02y8FBW4o+WYnIwo5ThrS7aWw37o+Zn4HjzKM1eLWBmaYbEghvqSLtIQ4ZTzwEwbYaYo
         64RMzPoYR/67EKFgNhwwePn9S4hW203DILTdIfxELKVwKo2di7/08VqOyaXqscMQgosB
         CEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=2oAzjBtU8tDhW0pdEe4oG9wzWj2JhEqxJCtaweFJDrY=;
        b=FkDfS9gw2gHvDMnoD8FCTtn/bo9wNQ0R9cbbheVKaIQ9xcfNH4F/rTBUX2gLwNZwiw
         p8p76TflzVThqLUsx+0u4M807ps1kiCn/ILL9pD2aDQ/3xiapjDOEtYUUuAQL2t9vRwX
         SsW4v30i4wm1dwH0RelmhEfPsUzUzOK2zw3Anjf8mutgUiAXTTjRRuFiG8pqGmTXQPZl
         sl2mdfFhUDBeLkTKFmmmArkUX92CLIGObNpghV89c4a1tOhg/NpzzHQgaSjHwp624SdP
         UOzdCewc/5ESrbSSdo0OKh21e/Jr1V5beWJL+YvjIzNubm01YHoDJCKqYpm6XXFdlvle
         EHqw==
X-Gm-Message-State: AOAM533NR8BF5TMG0TdhI6BLPc2M8XBLzV+PpaNqp+Rupcqm5fSA87ma
        4Bh9RAmsKVC1TpmTz2kLIESVibkQmJdiAA==
X-Google-Smtp-Source: ABdhPJxbYvFt0XloipPx1CSITBnXnT9ZkeGfgvlOD69S5SGe5ldm05kl/Cf6VsUi7sKF5QYl0ScfqQ==
X-Received: by 2002:a17:906:fa8a:: with SMTP id lt10mr5012118ejb.320.1632814123468;
        Tue, 28 Sep 2021 00:28:43 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bj21sm9853523ejb.42.2021.09.28.00.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 00:28:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 04/15] scalar: 'register' sets recommended config and
 starts maintenance
Date:   Tue, 28 Sep 2021 09:27:02 +0200
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
 <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
 <bbbc4c3339043bcd718dd2defcbaaaac2092227a.1631630356.git.gitgitgadget@gmail.com>
 <CABPp-BG_wupp1o5bBSYOJSvF3eJjf=TbX0RBHqqKuD+3F8s6hw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CABPp-BG_wupp1o5bBSYOJSvF3eJjf=TbX0RBHqqKuD+3F8s6hw@mail.gmail.com>
Message-ID: <87zgrxxiol.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 27 2021, Elijah Newren wrote:

> On Tue, Sep 14, 2021 at 7:39 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> ...
>> +               { "pack.useBitmaps", "false" },
>
> I don't understand anything bitmap related, but I thought they were
> performance related, so I'm surprised by this one.  Is there a reason
> for this one?  (Is it handled by maintenance instead?)

I don't know why Derrick did this, but there's still AFAIK cases where
bitmaps are worse than not in the context of a client (the scalar
use-case), see the rabbit hole starting at:
https://lore.kernel.org/git/878s6nfq54.fsf@evledraar.gmail.com/
