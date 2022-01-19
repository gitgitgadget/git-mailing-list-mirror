Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497E9C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 00:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350544AbiASAxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 19:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbiASAxX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 19:53:23 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A449C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 16:53:22 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m11so3091919edi.13
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 16:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Tnmwc10FweO+NetNn/clI8dk8uS1/+FDCJgAslfNAlc=;
        b=mBX+jYeMpmoaiCLSqst3ryOb+wI68KoIjhRZWtn1EXAPd4vrDecssl1aWkuK2IXeDM
         nEgUXmZulu2NUdyz1eNqxkcAT3hKyxP8vkjQgyFrOdG5xXZb2hLoOK5EDEFgM7Qj7BYP
         x/lXvC+gM63BWeH9bIaodAKgIII0xco+vZU1XbXoZxCGY5tAj8VWnDwNPLRE3PmynDa5
         kHGAKlHSowcKc2kF98OfEbGoidpIgzhsjmhCjenuJq9bDuRqyhIphRsAbgAx0HrUW644
         WDMve/63j/Fjq9vevUb3k0M4WaCZpzkJCn0n49aY/EIxN2qrzYPLWM5gTovWb+XjDhD4
         Wvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Tnmwc10FweO+NetNn/clI8dk8uS1/+FDCJgAslfNAlc=;
        b=RkxYNHPMPt8o6/sMjVSgSn8AkWac55p8Iu/Jj5VdkFaULcwiAM5DZpdgk2jeA5RoiO
         jGBt4enlxsSSgiO8IWG8sclDC41sjKLPKkPC/5pjW66fpAwZ/011IaIjUhWXz+XNsdGi
         YBGmLYtN80qay3gblwJ5O30xhfYilskeY3IYDgz4cociza4ycxm8oVIaOw9qn7HYRiym
         a5+fvfWIx6Ix56hvYhvatTCuY3O8mZ1148zS6TgKPW+hVyynEsF4t2+xbUVayZ/UmKxZ
         u3DJlJI/XnW5iFEu/7KEz7CHXfqtiW23vgq0GcMxXQ6/oPd3IG/ovaxWfzgXR2unX/KV
         ic2A==
X-Gm-Message-State: AOAM530nykoICc8k544qfdM9Y7h4ePG4ID6/QgvLQZWQs/69PEaKIEv3
        m+CgClMmSsNjGU4PDTk7qTw=
X-Google-Smtp-Source: ABdhPJweVO/BR8WUgcN8fZbRVmqPn7w8VXTYXqrzkj2wAISSPXZZmrtkxwCtr+7sUK1ELXuSXe/qww==
X-Received: by 2002:a17:906:e18:: with SMTP id l24mr3639733eji.514.1642553601060;
        Tue, 18 Jan 2022 16:53:21 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d17sm5747219ejd.217.2022.01.18.16.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 16:53:20 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n9zDz-001hM8-WB;
        Wed, 19 Jan 2022 01:53:20 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: v2.35.0 DEVELOPER=1 regression
Date:   Wed, 19 Jan 2022 01:29:47 +0100
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
        <xmqqlf0w5bbc.fsf@gitster.g>
        <YbAVOtYXA1Hf9EtJ@coredump.intra.peff.net>
        <xmqq4k7j68eg.fsf@gitster.g>
        <YbEMnksMEuAz3Nt0@coredump.intra.peff.net>
        <211209.867dcekm9h.gmgdl@evledraar.gmail.com>
        <YbMWNZCpy578Qu+l@coredump.intra.peff.net>
        <220113.86tue7vr6d.gmgdl@evledraar.gmail.com>
        <YeDUA6NhHuCUkqXf@camp.crustytoothpaste.net>
        <xmqqilumayfh.fsf@gitster.g> <xmqqzgny7xo7.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2201181308540.2121@tvgsbejvaqbjf.bet>
        <220118.86iluhoyio.gmgdl@evledraar.gmail.com>
        <xmqqh7a0ssuh.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqh7a0ssuh.fsf@gitster.g>
Message-ID: <220119.86o848o8ao.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 18 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I'd like to have it too, but for context needing to add NO_UNCOMPRESS2=
=3DY
>> (which Junio's punted on for the final[2]) is a much more widespread
>> issue of needing new post-install build tweaking than this issue that
>> only affects developer builds on FreeBSD.
>
> I hate it when people misrepresent what I said, even in an attempt
> to spite me.

Let's assume some mutual good faith here. I'm just trying to help debug
last-minute issues in this release to help get it out the door.

If I've misrepresented your views that's clearly true if you're the one
claiming it, but it's not intentional.

I was trying to read the tea leaves here in terms of helping patch
triage along. My assessment of that NO_UNCOMPRESS2=3DY issue from the
boxes I've tested on is that it's a much more widespread problem new in
this release (this is purely from testing on the GCC farm, however
representative that is). It'll impact multiple OS's, linux distros &
versions.

Whereas the C11 warning is "just" recent FreeBSD && DEVELOPER=3D1.

So I assumed if you weren't interested in the former before the final
you probably wouldn't be in the latter, but wanted to provide a more
narrow fix in case you were.

> For the "check ZLIB_VERSION_NUM" topic, I gave you
> specific things that needs to be different from the version posted
> with reasons, fully expecting that a better version of the patch to
> materialize soon (knowing how proliferate you can be when you want
> to) to give us enough time to assess the potential damage.

I can re-roll it sooner than later if you'd like, but figured per your
"I like the basic idea of the patch, but I am afraid that it is way too
late in the cycle"[1] that the resulting on-list distraction wouldn't be
worth it at this point, if it wasn't being considered for being applied
in the release window.

Aside from "I can re-roll it". I also think that the point of making
that change mostly (but not entirely) disappears if it isn't included in
v2.35.0.

I.e. the point of doing it is to avoid the one-time pain of anyone
building new releases of git on $OLD_OS/$OLD_DISTRO not having to run
into the compilation error that's fixed with NO_UNCOMPRESS2=3DY.

So if we put out a release without it anyone who's compiling git
releases will need to adjust their build system for that anyway (or
they're using autoconf, where it'll Just Work).

If we then get this into v2.36.0 there'll be someone somewhere that
benefits, but I'd think the ship has sailed for most of those who'd
avoid the needless flag twiddling (git-packagers@ et al).

So I don't know if it's even worth it to pursue that patch in that
case...

> I wouldn't call that "punted".

I don't think I've used or heard that word outside of this ML. FWIW I'm
using it in the sense of "kicking the can down the road" or "deferred
it".

Maybe that's incorrect, and I certainly stand corrected if I implied
something that wasn't true about our views by using that word.

> For this one, config.mak.dev patch WOULD only affect developer
> builds, which is a much better solution than overriding what their
> system headers want to do and force compiling with C99 mode.  With
> the status quo with today's code, with or without the patch Dscho
> wants in this thread, means ANYBODY will be stopped when they
> attempt to build with -std=3Dgnu99 on FreeBSD, which is a GOOD thing.
>
> The reason why it is a much better solution to PUNT on using C99
> mode on FreeBSD is because this episode makes it very clear that
> nobody tested building anything that use basename(), dirname(),
> etc. with C99 mode on the platform.  I do not trust such a build,
> even if we could work around the system header breakage.

Aside from anything else I think you're assuming a lot about warning
hygiene in a typical C project. Git's use of even optional -Werror is
fairly unusual.

If you Google search that error you'll find numerous past reports of it,
it just hasn't been solved.

I also think we discussed around the -std=3Dgnu99 change that the "C99
mode" in compilers we tested isn't impacting generated code (although of
course it will if it's conditional on __STDC_VERSION___). Otherwise the
generated objects are the same, it's just what warnings/errors you get
that changes.

In this case the fallback case already existed without my __generic
hack, so forcing that codepath for libgen.h isn't new.

> This time we got lucky and wereq stopped by a compilation error, but
> I have a strong suspicion that C99-only mode of compiler on this
> platform is not as well battle tested as their standard mode of
> compilation that allows C11.  I simply do not think we want to waste
> developer's time with C99-only mode on this platform which may end
> up debugging the platform and not our program.  Next bug that will
> hit us may not be so friendly to clearly break compilation.
> Instead, the symptom may be a subtle runtime breakage that wastes
> people's time.

I'd share that opinion if this was aCC on HP/UX or xlc on AIX or
whatever. But in this case it's just vanilla clang, not some scary
platform-specific compiler. Its "C99-only mode" isn't anything different
on FreeBSD than Linux.

We're just talking about one specific and avoidable warning in
/usr/include/libgen.h on that OS, once we're past that its "C99-mode"
works just fine.

> After developers who work on FreeBSD (not Git developers who uses
> FreeBSD) ships an updated system headers so that more programs, not
> just us, are built and testsd with C99-only mode, perhaps it becomes
> usable as a platform to catch use of language features beyond C99,
> like everybody else.  But with such a clearly broken system headers,
> I do not think today's FreeBSD is ready for that.  I do trust their
> default settings that allows C11, a lot more than C99-only
> compilation with the "their libgen is broken, so here is a user side
> workaround" patch.

Fair enough. I'm happy for us to get past this one way or the other,
whether it's with your patch or mine.

I took your previous reservations about my suggestions to just do this
C99 checking in CI-only to mean that you'd like to keep -std=3Dgnu99 on
DEVELOPER=3D1 if at all possible, which my approach does.

1. https://lore.kernel.org/git/xmqq7dayw732.fsf@gitster.g/
