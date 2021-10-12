Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2238AC433FE
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 11:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B63961076
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 11:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbhJLLWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 07:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhJLLWI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 07:22:08 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB71AC061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 04:20:06 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p16so15637831lfa.2
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 04:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lWJ0bYpkBfLTxBzDg/JVF+Szg5n+ahSF+kW6wt5yB1c=;
        b=YmOwvaIkKvDjLrTKLY9aYYfNEMcx1yjKGMAPjxGkuWLiHXu9LkVMEHC56PuwF6uBBp
         Sq8VVC9fDl2ZJXklng0FXxEwmOOz/gzcWzKMqML2dYkUVV9BbtSAMweF7ThInoUPcfjo
         PLo6owT14GeVNEiDbnoZzskgWvdTNphO9fHR+m73SxMq9Y9Mx2lE8AhwcbtdVtCK9NZL
         mztpPfr87ziIyijcNE56HETeiobh3sLh1wJsR/MeR89asJL50/9nOZIV/JuZDnHj63cl
         spDs+E+/+wMB85WB4DVh1FTTYPeYmirrfr0yVe25QZkLxpaa9ciXromNQot0p3aH5Uo+
         c92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=lWJ0bYpkBfLTxBzDg/JVF+Szg5n+ahSF+kW6wt5yB1c=;
        b=pBRf87JvM8tvPD92rYxsYmlKG9GS0kQ0OHJR0JN/dWU1WyPfWtuQQ3Hp+6ZjM+0ZR2
         h4YpB5lzZEXnU2o1qq5SGzraU3eIP734Y0Lwuf6qq0dVykzZoUv0bBkomLVbQk1hoG0o
         xhzptHij6pfYIRjelwYot2nms9xcVM1+wIHFoHUNkAVdY04plALmHEBUh27VrpnZ/xaJ
         60sUdu2K3phBRfS0qxHoAkrTicsE5vcHmMlMIaoe5S51uQK7t2BUJ2+VZ2ZQ+iHn4Rrd
         dZ5ZAIlKSI2ZNnvoV7i6n7Mg9j6X0YV0Y8zrAURUxtAZ0xD2DiaNU/kHcl29u7bSVJ7c
         6uqg==
X-Gm-Message-State: AOAM5308aUxjDWM3JcKaZMVJq1SbHMr1hGMEuIw1UMeKeJxemxzHMYF5
        gx3whELRSzPF+7JE2BV5Piw=
X-Google-Smtp-Source: ABdhPJwR04oplYYCwclZ+ijkTp3pUQZ2NOoXrPeQx1MvZd1y/rs3lhUp9MbmvMmrWMbGPbZEnk3viw==
X-Received: by 2002:a2e:88ca:: with SMTP id a10mr9052097ljk.37.1634037605237;
        Tue, 12 Oct 2021 04:20:05 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b9sm1003683lfe.85.2021.10.12.04.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 04:20:04 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH RFC v1] stash: implement '--staged' option for 'push'
 and 'save'
References: <875yugcs3l.fsf@osv.gnss.ru> <87lf2zz59w.fsf@osv.gnss.ru>
        <CAPig+cQgZX5U0KThgSKjmgvOvEZWxPF_BovYYe=VfjDvUE5c9Q@mail.gmail.com>
        <87fst7z0oa.fsf@osv.gnss.ru> <87y26yk35r.fsf@evledraar.gmail.com>
Date:   Tue, 12 Oct 2021 14:20:02 +0300
In-Reply-To: <87y26yk35r.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 12 Oct 2021 11:18:38 +0200")
Message-ID: <8735p67an1.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Tue, Oct 12 2021, Sergey Organov wrote:
>
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>> /On Mon, Oct 11, 2021 at 4:17 PM Sergey Organov <sorganov@gmail.com> wrote:
>>>> Stash only the changes that are staged.
>>>>
>>>> This mode allows to easily stash-out for later reuse some changes
>>>> unrelated to the current work in progress.
>>>>
>>>> Unlike 'stash push --patch', --staged supports using of any tool to
>>>> select the changes to stash-out, including, but not limited to 'git
>>>> add --interactive'.
>>>
>>> s/using of any/use of any/
>>> ...or...
>>> s/using of any/using any/
>>
>> Will fix, thanks!
>>
>>>
>>>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>>>> ---
>>>> diff --git a/builtin/stash.c b/builtin/stash.c
>>>> @@ -1656,6 +1716,8 @@ static int save_stash(int argc, const char **argv, const char *prefix)
>>>> +               OPT_BOOL('S', "staged", &only_staged,
>>>> +                        N_("stash in patch mode")),
>>>>                 OPT_BOOL('p', "patch", &patch_mode,
>>>>                          N_("stash in patch mode")),
>>>>                 OPT__QUIET(&quiet, N_("quiet mode")),
>>>
>>> Copy/paste error in new help/description string?
>>
>> Yep.
>>
>> Thanks,
>>
>
> I very much like this option, I've sometimes missed it in "git stash",
> and was always going to dig into if there was some way to do it.
>
> The one thing I'm a bit iffy on is if this is consistent with the
> --staged options in other commands (with some taking --cached and/or
> --staged), I think so, and this is a good name.
>
> But is the -S option used as a shorthand for --staged somewhere else?
> *Checks*, ah yes, for "git restore", then we use "stage" for
> checkout-index/ls-files, the latter of which has a 's' (not
> capital-letter 'S') shorthand.
>
> I *think* that just -s/--stage would make more sense here, but I've only
> looked at it briefly, but getting options consistent if possible is in
> general quite nice for users, so we should think about it...

I grepped the Documentation/ and found -S,--staged in the
"git-restore.txt":

-S::
--staged::
        Specify the restore location.

, so I used the same shorthand, even though I personally would use -s as
well.

In addition, the problem with -s is that it's used in a lot of places
for entirely unrelated option(s).

Thanks,
-- Sergey Organov
