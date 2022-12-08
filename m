Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDDAC4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 12:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiLHMSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 07:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLHMSa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 07:18:30 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928E521265
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 04:18:28 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id t17so3443278eju.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 04:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2jksoa14jY2qIYggJLORQN4ADa0ZRQjyKS40qV92SfU=;
        b=WfRfvjdLDR7eL2aYicbLO+gE/pck/qwEY5NMlXRyJ1I4M7ulHxm9bGBNLb3QlWBg2Z
         X5cuWeCpiiXa33mz4t00Ed1im0jM5VibyeTCq7A5hfwTPBEmwOnnG954gl3P2XGsh8Oq
         7IG/M7kz+uhgDT3PigKnhrXMgz9cmi8FybFc7Yu/tTfhDmxQIpnSS8DHIoibUrZeBSzE
         fjy11WbFCQMPqEIgixqb3KQqxgcFlSMoNHIo2rlOs3kBSbFblH6ehe441iJDJ/N4/WBR
         dqVbUDc9cZtcov5K9wQKFH/gCI+FflAbGjTtC/A83VldE4mC8ncdBFsflG2fCxJbfNzd
         UGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2jksoa14jY2qIYggJLORQN4ADa0ZRQjyKS40qV92SfU=;
        b=mrRT9B3k6g+MbbmWkDEwUAvR3NRoKl9iWxwUZib3BY8KCjGcUyMnrO897/GCO+eW9t
         dbxUgjSRTkAZltX9CmX4KNLx0Qtrc/a1zR5zmyTpU1Naxo0rAaTcLIpyMNpdVbabNlIR
         K2Usv3BxVFZApwh4pwJRJbuzQJJ2DWkGMXZOo2kZkm8WEx4tXzrhrRpsJWizOm1aSzEa
         Rc6wDpjH2dkxdTwyvFVOy7EJesgI7d+emyT/XAzgGAB4PhI+9vnQoElwAV06mNX2xmIb
         zC0CWn6IhnCNaMAFisdbHPCp+S31V72TIpOzB9lVV4n+orwmBEk2gLjO6esHSER5PiFA
         NAyQ==
X-Gm-Message-State: ANoB5pk1R2s5j7rxAvqQ20owtzCRXFijdHSWN87CD+r8Vml473rKbc+a
        y1BaDDm6nqlfTfXcEE2vrmY=
X-Google-Smtp-Source: AA0mqf5/p7fCwe9/VKI5Ubnmy6AVU1scec1EcALEz8GkkmaOL96E4gHw57hOEQIlm/DwyvrAtxmrGg==
X-Received: by 2002:a17:906:81d0:b0:7c1:22a6:818f with SMTP id e16-20020a17090681d000b007c122a6818fmr1638606ejx.25.1670501906846;
        Thu, 08 Dec 2022 04:18:26 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id gg9-20020a170906e28900b007c0d41736c0sm6500020ejb.39.2022.12.08.04.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 04:18:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p3Fr6-0052Wd-38;
        Thu, 08 Dec 2022 13:18:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Yuyi Wang <Strawberry_Str@hotmail.com>
Subject: Re: ab/cmake-nix-and-ci, was Re: [PATCH] test-lib.sh: discover
 "git" in subdirs of "contrib/buildsystems/out"
Date:   Thu, 08 Dec 2022 12:34:49 +0100
References: <663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk>
 <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
 <xmqq5yeuspam.fsf@gitster.g>
 <87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk>
 <221202.86sfhxg2ng.gmgdl@evledraar.gmail.com>
 <Y4qF3iHW2s+I0yNe@coredump.intra.peff.net>
 <221203.86pmd1dyqn.gmgdl@evledraar.gmail.com>
 <Y45/8WnuUnP9gOMo@nand.local> <Y46clyoKk9KzFiqj@coredump.intra.peff.net>
 <221206.86zgc1cnc3.gmgdl@evledraar.gmail.com>
 <Y46jT0i/7DhxHzfS@coredump.intra.peff.net>
 <221206.86mt81claa.gmgdl@evledraar.gmail.com> <xmqqilipnq8j.fsf@gitster.g>
 <30360f4c-91a5-177b-133f-eb7036ed676a@dunelm.org.uk>
 <221206.865yeodbtg.gmgdl@evledraar.gmail.com>
 <oq7p2776-po8p-r9s0-82o2-o77so874n419@tzk.qr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <oq7p2776-po8p-r9s0-82o2-o77so874n419@tzk.qr>
Message-ID: <221208.86wn726qcv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 08 2022, Johannes Schindelin wrote:

> Hi,
>
> On Tue, 6 Dec 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Tue, Dec 06 2022, Phillip Wood wrote:
>>
>> > On 06/12/2022 03:52, Junio C Hamano wrote:
>> >> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> >>
>> >>> Just to add my own digression: I asked in some past thread (which
>> >>> I'm too lazy to dig up) why it was the cmake file couldn't just
>> >>> dispatch to "make" for most things.
>> >
>> > Because make is not installed by default on Windows. Our CI job uses
>> > msbuild (whatever that is) and when I was playing with Visual Studio
>> > last week it was using ninja.
>> >
>> >>> I.e. it needs to at some level be aware of what it's building for the
>> >>> IDE integration, but for say making a "grep.o" there's no reason it
>> >>> couldn't be running:
>> >>>
>> >>> 	make grep.o
>> >>>
>> >>> Instead of:
>> >>>
>> >>>          cc <args> -o grep grep.c [...]
>> >>>
>> >>> which requires duplicating much of the Makefile logic (possibly with
>> >>> some Makefile shim to not consider any dependencies in that case).
>> >> That leads to a question at the other extreme.  Why does any logic
>> >> in CMakeLists.txt even have to exist at all?  Whenever it is asked
>> >> to make foo, it can be running "make foo" instead of having its own
>> >> logic at all.  ;-)
>> >
>> > Yes, if make was available then we wouldn't need to use CMake.
>>
>> I think Junio and I are talking about something slightly different. Yes
>> "make" isn't available by default. Getting it requires installing a
>> larger SDK.
>>
>> But if you look at the history of contrib/vscode/README.md in our tree
>> you'll see that we used to support this "Visual Studio Solution" for
>> years via GNU make, it probably still works.
>
> It probably doesn't. Last time I had to use it, during the embargoed
> v2.37.1 release process, it didn't. I had to add plenty of patches to make
> it work again:
> https://github.com/git-for-windows/git/compare/323a69709944%5E...323a6970=
9944%5E2
>
>> The change in 4c2c38e800f (ci: modification of main.yml to use cmake for
>> vs-build job, 2020-06-26) shows when the CI was switched over to using
>> cmake instead.
>>
>> The code to support that is still in-tree as the "vcxproj" target in
>> "config.mak.uname", which calls out to the ~1k lines of Perl code in
>> contrib/buildsystems/Generators/*.
>
> At some stage we can probably get rid of the `vcxproj` code. Before that,
> we can even get rid of the `vcproj` code that is bit-rotting in
> `contrib/buildsystems/`. But there seems no harm, and less maintenance
> burden, in keeping the `vcxproj`/`vcproj` parts where they are, as they
> are.
>
> Taking a step back, I see that we got far away from the topic that started
> this thread.
>
> So here's my take on `ab/cmake-nix-and-ci`: While that patch series'
> intention is apparently to make it easier to diagnose and fix CI problems,
> I only see that it adds new problems. It won't make it possible to
> diagnose most win+VS problems because they don't reproduce on Linux.

That would also be my take if that was the goal of the series. I agree
that would be pretty pointless. Why test win+VS-specific code on Linux?
That makes no sense.

But that's not the goal.

It's to make it easier to test the majority of the platform-agnostic
code in the cmake recipe. E.g. here's some past commits from myself,
Jeff King and Han-Wen (who I'm pretty sure doesn't use Windows) where
we've had to patch the cmake recipe in addition to the Makefile:
=09
	ef8a6c62687 (reftable: utility functions, 2021-10-07)
	cfe853e66be (hook-list.h: add a generated list of hooks, like config-list.=
h, 2021-09-26)
	d7a5649c82d (make git-bugreport a builtin, 2020-08-13)
	b5dd96b70ac (make credential helpers builtins, 2020-08-13)

Doing that currently requires bouncing things off the Windows CI. With
ab/cmake-nix-and-ci you can not only build (which currently works) but
run the full test against the cmake build on *nix in minutes. That's a
big improvement.

I think this also misrepresents the nature of the cmake recipe, and how
much of it is truly MSVC or VS-specific.  I count less than 20 lines in
a ~1.1k line recipe that are really "MSVC"-specific. I.e. guarded by
"if" branches checking "MSVC" and 'CMAKE_C_COMPILER_ID STREQUAL "MSVC"'.

The rest are general in nature. E.g. you can run the tests with "ctest"
from the VS GUI.

That's not because there's a VS-specific "hey Visual Studio, here's our
tests" part of the recipe. Rather there's a generic cross-platform
method of declaring how to run the tests, which cmake itself then knows
to pick up and generate a VS-specific asset with.

Whereas you seem to be suggesting that the recipe is so
Windows+VS-specific that testing it on other platforms isn't going to
tell you much. I don't think that's true.
=09
> But the patches already did introduce Windows-specific problems merely
> by trying to get the Linux side of CMake to work.

This seems like vague commentary on past bugs.

Do you have any specific concerns about things that are broken by the
current v6 iteration?

> And trying to keep CMake
> working both on Linux and on Windows would cause many more problems in the
> future. And we do not even need CMake support for Linux, `make` works well
> there already. It would increase the maintenance burden unnecessarily.

If you're going to argue that "we do not even need CMake support for
Linux" you're not making an argument against ab/cmake-nix-and-ci, but
against the status quo on "master".

It's already the case that it mostly "works" on Linux, that's been the
case since day 1. E.g. Yuyi's a561962479c (cmake: fix CMakeLists.txt on
Linux, 2022-05-24) earlier this year.

> I am therefore suggesting to drop `cmake-nix-and-ci` entirely.

I wouldn't mind if we declare that it should never work on Linux, and I
wouldn't mind if we drop ab/cmake-nix-and-ci entirely.

But only *if* the cmake recipe becomes purely a "lag-behind" alternative
build system that the Windows folks are responsible for updating, or to
submit follow-up patches for if it breaks.

That's not the status quo now, as e.g. Jeff King summarized nicely here:

	https://lore.kernel.org/git/Y4qF3iHW2s+I0yNe@coredump.intra.peff.net/

You don't seem to be suggesting a productive way forward with that.

I don't think dropping it, or even making the Windows cmake CI optional
would be a productive way forward, I think it would ultimately waste
more of your time, and that of other Windows developers.

But I don't see how that isn't the logical conclusion to not providing
specific feedback on this topic & finding a way forward with it.
