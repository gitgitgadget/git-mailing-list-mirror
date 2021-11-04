Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5829C433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 10:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7A46113B
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 10:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhKDKGW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 06:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhKDKGV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 06:06:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED70EC061714
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 03:03:43 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id j21so19219738edt.11
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 03:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=l7qig1ERexqBGWAoZmnRROoJgF8WH52QS4HqWEx3e+c=;
        b=CwOjjuhMdXphGxmXzTIxFoKks6hlK0y4fiUKxJEr9XbJ4PWLcHBT51Ag0yFekrfNHE
         mNqHHmh4VkvR1K3gb7fgVQYWhcRX0MABlTZa+DMsMNSEVDP02+0Ttsf5b12W/O0NCmes
         2dsYHuPLHRzqVTSVEo93U/N/+NS1DC4eWOL8G9nTwMj03NRdmLB7Fn4IXNzewr0rbOTW
         vWxX3GBEgtWB6WE0aoNLcpuH22oCcsp2f3hhJhZv9dfmC/r0mD7lyu0/bTThk2VtIaMr
         9hSY7BODfO2KMcZ9sjJT1eMXYQUOP4YMUzKq7Gwwo6hZnCRv1S9JRzFaV9vbXCxL1nln
         nQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=l7qig1ERexqBGWAoZmnRROoJgF8WH52QS4HqWEx3e+c=;
        b=Vtabo9IyYueMb/8XKhei1WfXE7722hQLgcdlAGg25FQvQaTFPT7BSoYWmbEF1zqmd5
         erU2wa8NQ/PvJKyg0oFhfJKiL423hGSnRXD+diOWQOXhPtxdg0wx6i5sWDwQli8clPMN
         GWMKbsFSL8rcwiNCYlt7A1KT9kznf5GldZavL78jCxzQGpyqZLbmBPJGP2PzKNw8T6Im
         Ow+IbXNKBp/O9h7n7pL9SUHmextMr+ZhW6e7aGUsqS70mTq9BAEyV/Wj6i/ZEQ60b0IK
         mf8vWwwrtkSov+GfJPfa3nH0YKLwL66miRwtPwub0lA6/r8fKmq4yVMWk0HWj2y2lyPH
         3QlA==
X-Gm-Message-State: AOAM5331kxaq9avL0ZrxtHJbw2/tHyllJrFucXJQamdWKTkn8oSWs5eQ
        YuRR0FT1rSilLZA9J+1HC7g=
X-Google-Smtp-Source: ABdhPJyCK0lubIgGkBk8pEcX1Tjjd8WN9keYdqIeOdLF1o/BSXfbMaVeSpXCIHelnIjjuss+kSgdNg==
X-Received: by 2002:a05:6402:280d:: with SMTP id h13mr17984014ede.346.1636020222352;
        Thu, 04 Nov 2021 03:03:42 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x13sm2325207ejv.64.2021.11.04.03.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 03:03:41 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1miZau-00073Y-MP;
        Thu, 04 Nov 2021 11:03:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: replace most hardcoded object lists with
 $(wildcard)
Date:   Thu, 04 Nov 2021 10:46:28 +0100
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com>
 <YX5T+wt0hSkxkLHA@coredump.intra.peff.net>
 <211031.86a6ip47ib.gmgdl@evledraar.gmail.com>
 <YYJy4BuX6JI6p+aV@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2111040124430.56@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <nycvar.QRO.7.76.6.2111040124430.56@tvgsbejvaqbjf.bet>
Message-ID: <211104.86r1bwi6f7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 04 2021, Johannes Schindelin wrote:

> Hi Peff,
>
> On Wed, 3 Nov 2021, Jeff King wrote:
>
>> On Sun, Oct 31, 2021 at 02:00:42PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>
>> > I didn't notice before submitting this but this patch breaks the
>> > vs-build job, because the cmake build in "contrib" is screen-scraping
>> > the Makefile[1].
>> >
>> > What's the status of that code? It's rather tiresome to need to patch
>> > two independent and incompatible build systems every time there's some
>> > structural change in the Makefile.
>>
>> My opinion when we took in the cmake topic was that it would be OK for
>> people working on the main Makefile to break cmake. It's an add-on and
>> the people who care about cmake are the ones who will do the work to
>> track the Makefile.
>
> I do try to have a look at breakages in `seen` when I have the time, but
> lately I didn't. That's why you may have felt more of these CMake
> headaches.

It's not only things that make it into "seen", as most will test their
topic in GitHub CI before submission in their own repos.

>> But since there's a CI job that will nag you if it fails, that kind of
>> makes it everybody's problem in practice. That doesn't change my opinion
>> on how things _should_ work, but I have done small fixups as necessary
>> to stop the nagging.
>
> One very simple solution is to leave the Makefile alone unless it really,
> really needs to be changed. There are costs to refactoring, and quite
> honestly, it might be a good thing that something like a failing vs-build
> job discourages refactoring for refactoring's sake.

Sure, but that's the case with any critical component we're using. A
question of "is it worth leaving it alone" is distinct from "is it
painful to touch it because you need to implement a fix twice in two
incompatible languages?".

In this case I do think the change is justified. I've personally got a
few local topics that I keep having to (even with rerere) solve
conflicts for due to this list of files, and Junio deals with the same.

Ditto for some of the changes I've made recently to make things
non-.PHONY. That's resulted in major workflow improvements for me,

But in any case, the selling point of the original cmake integration was
not something to the effect of:

    "nobody should have to change this in anything but ever so this
    re-implementation is a one-off"

But rather something like:

    "This re-implementation is a one-off, but any updates to both should
    be trivial."

As someone who's had a couple of recent run-ins with cmake I can tell
you it's really not trivial at all.

So given that the selling point of the original change didn't turn out
as was expected I think it's fair to re-visit whether we'd like to take
this path going forward, or to choose another trade-off.

>> > I hadn't looked in any detail at that recipe before, but it the
>> > vs-build job has a hard dependency on GNU make anyway, since we use it
>> > for "make artifacts-tar".
>> >
>> > So whatever cmake special-sauce is happening there I don't see why
>> > vs-build couldn't call out "make" for most of the work it's doing,
>> > isn't it just some replacement for what the "vcxproj" target in
>> > config.mak.uname used to do?
>>
>> The big question for me is whether that really is a hard dependency.
>> Obviously "make artifacts-tar" is for the CI job, but is the cmake stuff
>> supposed to work for regular users without relying on having GNU make at
>> all? I have no clue.
>
> The entire point of the CMake configuration is to allow developers on
> Windows to use the tools they are used to, to build Git. And believe it or
> not, GNU make is not one of those tools! I know. Very hard to believe. :-)

I believe that, the question is why it isn't a better trade-off to just
ask those users to install that software. Our Windows CI is doing it
on-the-fly, so clearly it's not that hard to do it.

Note that I'm not saying that whatever integration those users get in VS
from the special-cause CMake integration should change. We're only
talking about it invoking "make" under the hood in a way that'll be
invisible to the user.

POSIX "sh" isn't native to Windows either, and that CMake file invokes
shellscripts we ship to e.g. build the generated headers, so this
workflow is clearly something that's OK for an end-user once the one-off
hassle of installing a package is over with.
