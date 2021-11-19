Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E1AC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB11661206
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhKSUmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 15:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhKSUmA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 15:42:00 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9207EC061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 12:38:58 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z5so47617365edd.3
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 12:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=V9VP2jHrEdXP26rSni8yoQqPIe71Yi7RVLAhdXm+LGE=;
        b=hoVa18tDYKkDELRWfrVswlShGOcb07imFME5cXVOLhEzZ2vLrRqOZoJnBikKvUFRD+
         tt/4l/khOBzrn+h1Fes96nuSajD0u+LExxVHvhQNVvioYbPbZpbWdrdFuFO37pZnE2PH
         xcpAZHxIbSSjsdBhGbhTY3CNv6BO1o+H6kH/Wd5ruaEcfHq9ZKVSYncb2/mLlZIZfnu9
         ESCZAOmb/LMEuBAANg/3UInjNDDN3jpo8crGgiXLkNOxFmxsm5EU1P7kBK4vw55cQVlq
         Yn9koQzpCx2Rg38fYwYBPGfisn4rY/2l/79u3N3UnB1dphVCqvmIdtQ1Li6LbKeV8Rtd
         VJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=V9VP2jHrEdXP26rSni8yoQqPIe71Yi7RVLAhdXm+LGE=;
        b=1JzZXXfaCwPuJ/8QWnRl96W116xLs7UXAyJ6JKD/bwoUEKfHF3WE1tDKM6xIeu/xxw
         JbPmqupc5sztU6pGeBnFPZs4xBfSYWUYOF0cGfKzNHbBt0uPLU0sApq08tg3EEsJELYt
         Ixz+rmafGZifq/rDyDA8nUjmRCf6koNn9/qDPHQj63KvUNZ8UNMgMSdkYNMLL9RJPikS
         Eph8PoP/bPb/d+z/0x1s30mRwtvG/AslTFg8ILArtQOAjTSVF9LaDvpGaIz5UrVW91oe
         uSFIfkogx7fKxV6+nzgusfzsTs7OA877hM+MbKgaILX3lwR9Ng/zaQ6QLstww/9Kcvft
         j09A==
X-Gm-Message-State: AOAM532j25zePhqsO4OVRo3ml2BRZ/FQCNIhT7ZbjhBLAvZIGnIcuEUc
        INw3MioQp86H7OwuXawck9s=
X-Google-Smtp-Source: ABdhPJzw0GTmCi8sEXa8cPiqTU0EbMilyUMnE9iRdzYQDmvv7XZmixf6M9R1cNnrzxIqZcWmvi7iBg==
X-Received: by 2002:a17:907:9612:: with SMTP id gb18mr11572695ejc.205.1637354337107;
        Fri, 19 Nov 2021 12:38:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qw27sm393995ejc.101.2021.11.19.12.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 12:38:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1moAet-000nks-MD;
        Fri, 19 Nov 2021 21:38:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 1/2] CI: use shorter names that fit in UX tooltips
Date:   Fri, 19 Nov 2021 21:33:40 +0100
References: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com>
 <patch-1.2-26f80c87c8d-20211119T135343Z-avarab@gmail.com>
 <b9da6658-2b00-cc13-e1ae-124d8222dab8@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <b9da6658-2b00-cc13-e1ae-124d8222dab8@github.com>
Message-ID: <211119.86czmv3mow.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 19 2021, Victoria Dye wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Change the names used for the GitHub CI workflows to be short enough
>> to (mostly) fit in the pop-up tool-tips that GitHub shows in the
>> commit view. I.e. when mouse-clicking on the passing or failing
>> check-mark next to the commit subject.
>>=20
>> That description is truncated to 24 characters, with the 3 at the end
>> being placed by "...".
>>=20
>> E.g. the full job name (visible at [1]):
>>=20
>>     "regular (linux-gcc-default, gcc, ubuntu-latest)"
>>=20
>> Will, when shown in the tool-tip be truncated to:
>>=20
>>     "CI/PR / regular (linu..."
>>=20
>> There's then a further limit in the expanded view where the job names
>> are observably truncated to 44 characters (including "..."). I.e.:
>>=20
>>     "regular (linux-gcc-default, gcc, ubuntu-l..."
>>=20
>
> Tooltips like the ones you've pointed out here appear intended to be an "=
at
> a glance" view of the jobs (mostly for showing pass/fail/skip status) - e=
ach
> job in the tooltip has a "Details" link that takes you to the job summary
> and logs. In the current state, although the names of the are truncated in
> the tooltip, the information is still easily accessible in the full workf=
low
> details (one click away). For example, the details for the "linux-leaks" =
job
> [1] tell me the image, compiler, and job name right at the top of the pag=
e.
>
> [1] https://github.com/git/git/runs/4214606314?check_suite_focus=3Dtrue
>
>> With this change we shorten both the job names, and change the
>> top-level "name" from "CI/PR" to "CI", since it will be used as a
>> prefix in the tooltips. We also remove redundant or superfluous
>> information from the name, e.g. "ubuntu-latest" isn't really needed
>> for "linux-leaks", it'll suffice to say linux. For discovering what
>> image runs that specifically we can consult main.yml itself.
>>=20
>
> By optimizing for the tooltip, this patch shortens names to the point that
> they're more difficult to interpret (w32 vs. w32/VS) and/or removes valua=
ble
> context about platform/image/etc. When a user *does* want more information
> on the job, they now have to:=20
>
> 1) know that the "CI/PR" job definition is in ".github/workflows/main.yml"
> 2) parse through the file to find the job they want
> 3) correlate that back to the job in the workflow details they're
>    investigating.=20
>
> That's a strictly worse experience for an extremely common use-case. What
> use-case is this patch attempting to improve?

That I can click on the button that your co-workers implemented and see
the relevant information about the job :)

Given that it's truncated we need to pick and choose what we display if
we're not going to force the user to have to go to the full view every
time.

I'll change s/w32/win/ etc, and there's room to move stuff around here,
but I think it's fine to just not display that it's e.g. "ubuntu" or
"fedora" at all. That's almost never been relevant.

If we were trying to do the opposite and lengthen the names to shove
every bit of useful information in there at a glance I can think of 5-10
things we'd put there before "fedora". libc/version, compiler/version,
kernel/version etc.

Whether it's a recent Gentoo or Ubuntu is something that's OK to omit.

But maybe I'm wrong, are there cases you can think of where we really
need "ubuntu" or "fedora" etc.?

>> The above "regular (linux-gcc-default, gcc, ubuntu-latest)" job name
>> then becomes a 1=3D1 match to the "$jobname" used in
>> "ci/run-build-and-tests.sh". A "( push" or " (pull_request" is then
>> added implicitly as before (from the top-level "on" parameter in
>> "main.yml"). In the tooltip we'll now show:
>>=20
>>     "CI / linux-leaks (pu..."
>>=20
>> We then have no truncation in the expanded view. See [2] for a
>> currently visible CI run using this commit, and [3] for the GitHub
>> workflow syntax involved being changed here.
>>=20
>
> If the only problem this patch really "solves" is making some job names f=
it
> a bit better into the tooltip and, I think the costs (namely the loss of
> accessible contextual info) outweigh any potential benefits you gain.=20

Yeah it's a trade-off for sure, but now you can't see some of the
relevant information at all in some views, so it's a gain for
accessibility too.
