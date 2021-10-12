Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5601C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 09:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C7D60F21
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 09:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbhJLJ1L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 05:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbhJLJZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 05:25:16 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84019C061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 02:23:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id d9so54639810edh.5
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 02:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=WxMStbahbu7XzpKmwUPJIyTm8AEZHeKLMLiIbGRi1cI=;
        b=L6nl+sCmdhB4IlRDvGs20LY4eIjmvGGWocC6WY5yredXk0IyTh9DTznQYJmUuCgBQD
         39tlch9tto2Jp0ZbNSIfjF27VUoFu5t5K8mRRWPoK2L/HGWh1kpu1aguUY9464zlRVUy
         ngNEGfmBG4onGQdGyXQxb/IkO5iuNw8l5mMorSpayF7XunxwRQOGkBtwsRgXzN7tgJz5
         DJh9oryH4CHXCcj7d7aclxBWR+0jyUz/5/3M/OwHVihe7nibQ3tGncxJbiobQ4RKf35x
         wyATJIkc9opZanAvC+DHClnYztZ7acsCGPdlErARvfn1L2eqDeEa2c7KZFQ4xTXV6tne
         zycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=WxMStbahbu7XzpKmwUPJIyTm8AEZHeKLMLiIbGRi1cI=;
        b=KSccqPN1XfLmwrVNWmc/8fsXyeOvWd26l2MFchi5l8vRsTwcnQMO6rd3hEOg7GiysU
         W5uhyBoSB91HBwNdwQfHMRxB0uwnRyF/ET6YvmDxbgGDshAhQOHxod5n0DVIcyMrzrVM
         nllNCqgOq0/KXtMxB0n70uWCbZL2+iPXLvqBNwYSy9PFuAqv9hIsEaePFY/Q4lA5UYtp
         ygd3mEuYosYpq81jme2hAz4OUzv3J4327xI+ij/3BbxiRosOqWzWcsR8jAz7j5FdOHD1
         gJNqe0iBReLMys0JnFJZ532z6DxrlwNsb2GywtiS0QypTEf5oKliMGcG+hcKBsDeGQwC
         YUMw==
X-Gm-Message-State: AOAM530jJs+GunwcTEuXYtlhtI4K5ojpMRKpgFbKsr5WJW33UbAp6km9
        ozh18dI/ASmqMmNcI6MniG8=
X-Google-Smtp-Source: ABdhPJyAh8pbu2xfyucj4hXUxsFAfbBy8rRw68shirSwP699v9VGEmhuMVC3FGMZC2/C9KhrUiEH0Q==
X-Received: by 2002:a17:906:b247:: with SMTP id ce7mr31701048ejb.473.1634030592937;
        Tue, 12 Oct 2021 02:23:12 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o25sm603067edq.40.2021.10.12.02.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 02:23:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH RFC v1] stash: implement '--staged' option for 'push'
 and 'save'
Date:   Tue, 12 Oct 2021 11:18:38 +0200
References: <875yugcs3l.fsf@osv.gnss.ru> <87lf2zz59w.fsf@osv.gnss.ru>
 <CAPig+cQgZX5U0KThgSKjmgvOvEZWxPF_BovYYe=VfjDvUE5c9Q@mail.gmail.com>
 <87fst7z0oa.fsf@osv.gnss.ru>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <87fst7z0oa.fsf@osv.gnss.ru>
Message-ID: <87y26yk35r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 12 2021, Sergey Organov wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> /On Mon, Oct 11, 2021 at 4:17 PM Sergey Organov <sorganov@gmail.com> wrote:
>>> Stash only the changes that are staged.
>>>
>>> This mode allows to easily stash-out for later reuse some changes
>>> unrelated to the current work in progress.
>>>
>>> Unlike 'stash push --patch', --staged supports using of any tool to
>>> select the changes to stash-out, including, but not limited to 'git
>>> add --interactive'.
>>
>> s/using of any/use of any/
>> ...or...
>> s/using of any/using any/
>
> Will fix, thanks!
>
>>
>>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>>> ---
>>> diff --git a/builtin/stash.c b/builtin/stash.c
>>> @@ -1656,6 +1716,8 @@ static int save_stash(int argc, const char **argv, const char *prefix)
>>> +               OPT_BOOL('S', "staged", &only_staged,
>>> +                        N_("stash in patch mode")),
>>>                 OPT_BOOL('p', "patch", &patch_mode,
>>>                          N_("stash in patch mode")),
>>>                 OPT__QUIET(&quiet, N_("quiet mode")),
>>
>> Copy/paste error in new help/description string?
>
> Yep.
>
> Thanks,
>

I very much like this option, I've sometimes missed it in "git stash",
and was always going to dig into if there was some way to do it.

The one thing I'm a bit iffy on is if this is consistent with the
--staged options in other commands (with some taking --cached and/or
--staged), I think so, and this is a good name.

But is the -S option used as a shorthand for --staged somewhere else?
*Checks*, ah yes, for "git restore", then we use "stage" for
checkout-index/ls-files, the latter of which has a 's' (not
capital-letter 'S') shorthand.

I *think* that just -s/--stage would make more sense here, but I've only
looked at it briefly, but getting options consistent if possible is in
general quite nice for users, so we should think about it...
