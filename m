Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87AAC433EF
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 03:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbhKTDKT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 22:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbhKTDKT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 22:10:19 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40776C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 19:07:16 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id e3so50492017edu.4
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 19:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=mx3dOiHi5qYA/7lcIzyWk/ewzGmgd1WGfJVBeiO0eKU=;
        b=ljJVwjN9ZLcZrolccKfbcOJXNP8zKRAvWInACHBqyfv3O2ZGqW6Imn/RJIU+Vpoy2h
         MWVQNJvr9MdaDYQU/iTNmWy+wn2MchtbZv/wSsV6HYJa6jyvXm/MIby5JcR9MfG1Nsox
         Vn+EXMtUN0WmKpOtNGzQ7BMwQpPCER9Hfho4DQp0CVbU7i8LIg2WuFiwcKQk0NkTMK8I
         MVX8Rm3IKL2cUf4viR50mgvl23F0Xq9+BErfL5qwuDKZ8Nzv3cv5rlgTUJ08UG4AKMd0
         +p5Vn0NzyyF4/XmItmSDFuTi6HvVHYi1Sqel0CfhALWn1cjH8CJ+tQZvs7Ch44sSnNnN
         qRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=mx3dOiHi5qYA/7lcIzyWk/ewzGmgd1WGfJVBeiO0eKU=;
        b=twpy+NuqmpMxMKe/cLVLcJXFRbaQOeepAj0EYEUYFuY2GfiL+cIDjbDw7L+xc4c/R3
         Tr34hXDX6Q90ZNzjmy+GlelXgm3kxm4JnSxX5rfBr/R56DfGEpChO0xr6EsAYpa1XHl2
         49/0rTBxyVUapsDVy/U+OdbRvaCqjUJE3dc+r6u0Z0jQ1PUmW06+tXBmHlHXKddB8SsY
         cL6HAjgx/g6rgifUybC3ShgiDkAxZCHcA4kRsfK9YnqZOXLN0kCIwdiPqv21ftMLc9PX
         bMNA2Mc5cMPl7A6iz14CCro0fF24l4qkxdXIZljQChJ/7Jkp79JpGvJ6ySWG9jWsy0CZ
         PQPQ==
X-Gm-Message-State: AOAM531UEXFR5Y6lrpkJLR2TVkDhEUES42IZ8OOckYkB7V3mTry5mXnk
        OKoGyjlPpD/GjXipATqHIZM=
X-Google-Smtp-Source: ABdhPJzR8apgcSNxrF4X8EG+c5JaaG6TNYXwWJMBzzJ2hVxDW69BXYuxojNEVpiM/eHhmThl7lkvQg==
X-Received: by 2002:a17:907:160c:: with SMTP id hb12mr14379144ejc.460.1637377634593;
        Fri, 19 Nov 2021 19:07:14 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e1sm703484edc.27.2021.11.19.19.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 19:07:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1moGif-000sLz-7z;
        Sat, 20 Nov 2021 04:07:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 1/2] CI: use shorter names that fit in UX tooltips
Date:   Sat, 20 Nov 2021 03:51:55 +0100
References: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com>
        <patch-1.2-26f80c87c8d-20211119T135343Z-avarab@gmail.com>
        <b9da6658-2b00-cc13-e1ae-124d8222dab8@github.com>
        <211119.86czmv3mow.gmgdl@evledraar.gmail.com>
        <8efbd4bd-09bc-eabd-37ea-53501f75f8a6@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <8efbd4bd-09bc-eabd-37ea-53501f75f8a6@github.com>
Message-ID: <211120.86r1bb1q5a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 19 2021, Victoria Dye wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Fri, Nov 19 2021, Victoria Dye wrote:
>>=20
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> Change the names used for the GitHub CI workflows to be short enough
>>>> to (mostly) fit in the pop-up tool-tips that GitHub shows in the
>>>> commit view. I.e. when mouse-clicking on the passing or failing
>>>> check-mark next to the commit subject.
>>>>
>>>> That description is truncated to 24 characters, with the 3 at the end
>>>> being placed by "...".
>>>>
>>>> E.g. the full job name (visible at [1]):
>>>>
>>>>     "regular (linux-gcc-default, gcc, ubuntu-latest)"
>>>>
>>>> Will, when shown in the tool-tip be truncated to:
>>>>
>>>>     "CI/PR / regular (linu..."
>>>>
>>>> There's then a further limit in the expanded view where the job names
>>>> are observably truncated to 44 characters (including "..."). I.e.:
>>>>
>>>>     "regular (linux-gcc-default, gcc, ubuntu-l..."
>>>>
>>>
>>> Tooltips like the ones you've pointed out here appear intended to be an=
 "at
>>> a glance" view of the jobs (mostly for showing pass/fail/skip status) -=
 each
>>> job in the tooltip has a "Details" link that takes you to the job summa=
ry
>>> and logs. In the current state, although the names of the are truncated=
 in
>>> the tooltip, the information is still easily accessible in the full wor=
kflow
>>> details (one click away). For example, the details for the "linux-leaks=
" job
>>> [1] tell me the image, compiler, and job name right at the top of the p=
age.
>>>
>>> [1] https://github.com/git/git/runs/4214606314?check_suite_focus=3Dtrue
>>>
>>>> With this change we shorten both the job names, and change the
>>>> top-level "name" from "CI/PR" to "CI", since it will be used as a
>>>> prefix in the tooltips. We also remove redundant or superfluous
>>>> information from the name, e.g. "ubuntu-latest" isn't really needed
>>>> for "linux-leaks", it'll suffice to say linux. For discovering what
>>>> image runs that specifically we can consult main.yml itself.
>>>>
>>>
>>> By optimizing for the tooltip, this patch shortens names to the point t=
hat
>>> they're more difficult to interpret (w32 vs. w32/VS) and/or removes val=
uable
>>> context about platform/image/etc. When a user *does* want more informat=
ion
>>> on the job, they now have to:=20
>>>
>>> 1) know that the "CI/PR" job definition is in ".github/workflows/main.y=
ml"
>>> 2) parse through the file to find the job they want
>>> 3) correlate that back to the job in the workflow details they're
>>>    investigating.=20
>>>
>>> That's a strictly worse experience for an extremely common use-case. Wh=
at
>>> use-case is this patch attempting to improve?
>>=20
>> That I can click on the button that your co-workers implemented and see
>> the relevant information about the job :)
>>=20
>
> I'm sure you meant this in good faith, but I don't see how where I work is
> relevant. GitHub is a tool you can use to develop Git, and I'm reviewing
> because this patch would affect how I work on Git.

Yes, sorry. That came off as quite snarky, it was just meant as a lame
joke.

>> Given that it's truncated we need to pick and choose what we display if
>> we're not going to force the user to have to go to the full view every
>> time.
>>=20
>
> This is what I wanted to dig into by asking for a use-case. Which users do
> you expect are using this tooltip view so heavily that what's displayed
> there justifies this change? If you're one of those users, then waiting f=
or
> more feedback on this patch will hopefully provide a better idea of what =
the
> "average" user finds helpful.

Will improve the description etc. in a re-roll.

>> I'll change s/w32/win/ etc, and there's room to move stuff around here,
>> but I think it's fine to just not display that it's e.g. "ubuntu" or
>> "fedora" at all. That's almost never been relevant.
>>=20
>> If we were trying to do the opposite and lengthen the names to shove
>> every bit of useful information in there at a glance I can think of 5-10
>> things we'd put there before "fedora". libc/version, compiler/version,
>> kernel/version etc.
>>=20
>
> I'm sure there's plenty of information that would be helpful to have ther=
e;
> however, that's not really a justification for removing some of what we
> already have.

I'll retain more information in an incoming re-roll.

>> Whether it's a recent Gentoo or Ubuntu is something that's OK to omit.
>>=20
>> But maybe I'm wrong, are there cases you can think of where we really
>> need "ubuntu" or "fedora" etc.?
>>=20
>
> Yes, absolutely - knowing that `fedora-latest` was the image used in the
> failing builds for v2.34.0-rc1 led to learning that the image was updated
> the day before the build failed, which was instrumental in quickly
> identifying the root cause of the bug [1]. In that case, I got the
> information to start debugging from the web UI, *not* from digging into
> `main.yml`.=20
>
> In general, easily finding what image a CI job was built on can help with
> investigating bugs that arise from environmental differences. It's a minor
> quality-of-life improvement, but it's no less significant than the benefit
> you're suggesting this patch provides.
>
> [1] https://lore.kernel.org/git/pull.1072.git.1635990465854.gitgitgadget@=
gmail.com/

I thought that case was a good example of us creating a problem for
ourselves that we didn't need to have. as I noted downthread in:
https://lore.kernel.org/git/211104.86v918i78r.gmgdl@evledraar.gmail.com/

I.e. the "fedora" part didn't actually matter, it just so happened that
fedora had a relatively recent glibc/gcc, and when it was updated from
under us CI runs all over the place started failing.

Which is an issue that's entirely avoidable by pinning the dependency,
and not using *-latest.

In general I really don't see why who deploys software anywhere thinks
using this pattern of fluid dependencies is worth the hassle. It's
rather trivial to just run a cron script that bumps your dependencies,
commits and pushes.

It's not at all trivial to take software that downloads whatever
someone's random website has available at the moment and try to figure
out what state it was in last week, month or year when the state of that
third party website wasn't what it was today.

Anyway, I take your general point that these image names (or a derived
name) may be useful to someone somewhere.

I just thought this example was a bad one, because the only reason the
image name or update would have been unclear to anyone (as it was to me
when my CI started breaking due to this) is because we're using this
anti-pattern.
