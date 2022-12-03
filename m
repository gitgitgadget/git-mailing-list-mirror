Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7928CC4321E
	for <git@archiver.kernel.org>; Sat,  3 Dec 2022 02:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbiLCCJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 21:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbiLCCJm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 21:09:42 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9789F7F884
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 18:09:40 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ha10so15462898ejb.3
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 18:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K4ITLrp0ZnE9VTiUDqDmuqdPoXn9KOe4OCwaW0ZdV0A=;
        b=MAuOos1umVUYXipPcy2mLJ+mjvYaefiS/TJzmLwTnQt+/B6aeYxe5d96Y8nWyGLJgh
         xMuVgjU61vTEEzZInbP7oPtM4LMNNnVTXDPiQR3sZoiVYscRDGPP9FT9CQrS3I6AB4jM
         VJTD2T1D3QPZdEkY/LKVh7LRMfoOcyfMuzEmSLVR2vls8IpUKZf5JjA9FvG+2MICj4gq
         DZjtZuGRLbKBD6ZXji8GNIZLvm+xyK6Jo+U8fvU5ZQ6+5pQLfFItR1UcQblYIPXEoKtz
         MZussF8r6df+ccuentM2xn8Lk3fnwceYhsgCBWpvPHoISaN054tz/zsrCDsLE4UwBd/n
         r6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K4ITLrp0ZnE9VTiUDqDmuqdPoXn9KOe4OCwaW0ZdV0A=;
        b=ObowhHvg9IpaGY+W9ZeixtCvwZwLxZRaO72flVs5gZtMgErNlTlBSMGPpppqPudiPi
         ZHlRyGMnI90qs/kWg4xSARddGaZgOeSoJP8utB+LUXgA1Lreqplr//MDTkIsv90GPWg/
         lEjAv8x5xIGCARe1GOe24T4bD2Js6g2enzRhM8i04guGAhugkh6bu/mrdwiz0U0GLXRF
         V8EIQ/2PFGRxgnotNSOmGiyRcj6HKFer3yLqWXa7Tel30RrCMzqCrgglmGZIKHT8q94z
         0Y2juoH66uDAO02kLPFNJRY59kP3WSIxPyBYA7siXOL6gEb6I9XsudeqE5RXGyVknc7g
         hH4Q==
X-Gm-Message-State: ANoB5pmmdbZyCdHzpGt5XslOwvqmnG5TwOjrHScder/onmb1KZIPyF7N
        yxP6nrFRS6XnxpP6gDOelx4=
X-Google-Smtp-Source: AA0mqf48qqqbGU641d21dSmY/X7RjbCN9zQ0GUmX17ADa90SWlhZe6FPRDSmYwMhMXSdaQeWWpr1pw==
X-Received: by 2002:a17:906:2cd3:b0:7bf:b675:ffdd with SMTP id r19-20020a1709062cd300b007bfb675ffddmr22614696ejr.610.1670033378879;
        Fri, 02 Dec 2022 18:09:38 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id d18-20020a05640208d200b0046150ee13besm3512766edz.65.2022.12.02.18.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:09:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p1HyC-0032DN-2I;
        Sat, 03 Dec 2022 03:09:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] test-lib.sh: discover "git" in subdirs of
 "contrib/buildsystems/out"
Date:   Sat, 03 Dec 2022 02:41:04 +0100
References: <663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk>
        <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
        <xmqq5yeuspam.fsf@gitster.g>
        <87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk>
        <221202.86sfhxg2ng.gmgdl@evledraar.gmail.com>
        <Y4qF3iHW2s+I0yNe@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y4qF3iHW2s+I0yNe@coredump.intra.peff.net>
Message-ID: <221203.86pmd1dyqn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 02 2022, Jeff King wrote:

> On Fri, Dec 02, 2022 at 05:40:34PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > [1] While our CI helps the MSVC job runs CMake manually, performs an
>> > in-tree build and does not use ctest. In contrast a user running the=20
>> > MSVC GUI does not run CMake themselves, ends up with an out-of-tree
>> > build and runs the tests with ctest.
>>=20
>> I don't run Windows by choice, and I'm not interested in running a
>> propriterary IDE (VS) either.
>>=20
>> The main reason I'm working on this series is that while we as a project
>> are happy to support proprietary OS's, it hasn't been a requirement for
>> participation that you need to buy a copy of Windows, OSX, AIX, HP/UX or
>> whatever to submit patches.
>>=20
>> Of course we have platform-specific code. but this CMake component is
>> unique in how invasive it is.
>>=20
>> It's easy to e.g. stay away from the OSX-specific code in
>> compat/fsmonitor/*darwin*.[ch], or generally speaking the
>> Windows-specific C code.
>>=20
>> But for CMake it's become a hard requirenment for many changes, even
>> though it's a contrib/ component.
>
> I have similar feelings to you here. Back when cmake support was
> introduced, I explicitly wanted it to be something for people who cared
> about it, but that wouldn't bother people who didn't use it:
>
>   https://lore.kernel.org/git/20200427200852.GC1728884@coredump.intra.pef=
f.net/
>
> I stand by that sentiment, but it seems to have crept up as a required
> thing to deal with, and that is mostly because of CI. Using cmake in CI
> is good for telling developers when a change they make has broken cmake.
> But it also makes cmake their problem, and not the folks interested in
> cmake.

That's a bit of a pain, but I don't think the main problem is its
integration with CI. It's that there doesn't really seem to be an
interest in its active maintenance & review from its supposed main
target audience.

Case in point this "ab/cmake-nix-and-ci" topic: It's been queued for
around 2 months now.

I don't use Windows or VS. I'd just like it not to take half may day to
throw things at Windows CI whenever some obscure aspect of cmake breaks.

The only person who's been showing it any notable review interest
(Phillip) apparently hasn't used Windows actively since the mid-90's :)

Which is a very different situation than if it were still something that
broke CI, but there was someone (or more than one person) active on list
willing to test patches to get it working, was familiar with the cmake
language & could help write the cmake version of Makefile changes when
those were needed etc.

> Now maybe attitudes have changed, and I am out of date, and cmake
> support is considered mature and really important (or maybe nobody even
> agreed with me back then ;) ). But if not, should we consider softening
> the CI output so that cmake failures aren't "real" failures? That seems
> drastic and mean, and I don't like it. But it's the root of the issue,
> IMHO.

Yeah, maybe. Maybe if we broke it we'd get people showing up to maintain
it again :)

I do think the series I've got here is the most practical way forward at
this point (any outstanding issues aside). I.e. it's usually fairly
easy-ish to amend the cmake recipe.

It's just been taking *ages* because it's been a dumpste fire outside
of Windows, so if you don't have that OS available to you you need to
wait for the CI. Being able to run it in seconds on *nix really helps..

> As a side note, this isn't the only such instance of this problem. Two
> other things to think about:
>
>   - You mentioned darwin fsmonitor code. And it's true that you can
>     largely ignore it if you don't touch it. But every once in a while
>     you get bit by it (e.g., enabling a new compiler warning which
>     triggers in code you don't compile on your platform, and now you
>     have to guess-and-check the fix with CI). This sucks, but is kind of
>     inevitable on a cross-platform system. I think the issue with cmake
>     is that because it's basically duplicating/wrapping the Makefile, it
>     _feels_ unnecessary to people on platforms with working make, and
>     triggers more frequently (because changes to the rest of the build
>     system may break cmake in subtle ways).

Yeah, we'll always have some cross-platform pain.

But e.g. "chmod +x" just works in the Makefile, including when we run it
on Windows. And I've run it on Windows CI. But just upthread of here
Phillip is reporting that it doesn't work from the context of the CMake
recipe.

I've been throwing some things at Windows CI, but I'm pretty stumped as
to what that might be.

Some warning on Mac OS X is trivial by comparison :)

>   - I'd actually put the leak-checking CI in the same boat. It's a good
>     goal, and one I hope we work towards. But it feels like the current
>     state is not very mature, and people often end up wrestling with CI
>     to deal with failures that they didn't even introduce (e.g., adding
>     a new test that happens to run a Git program that has an existing
>     leak, and now you are on the hook for figuring out why the existing
>     "passes leaks" annotation is wrong).
>
>     My original hope is that we would introduce leak-checking tooling
>     that people interested in leaks could use, and other people could
>     ignore until we reached a leak-free state. Because it's in CI it
>     means that people get notified of new leaks in code they write
>     (which is good, and helps people interested in leaks), but it also
>     means they have to deal with the immature state.
>
> I'm not necessarily proposing to drop the leaks CI job here. I'm mostly
> philosophizing about the greater problem. In the early days of Git, the
> cross-platform testing philosophy was: somebody who cares will test on
> that platform and write a patch. If they don't, how important could it
> be? With CI that happens automatically and it becomes everybody's
> problem, which is a blessing and a curse.

That's a definitely a bit of an irresistible digression :)

First, I think we can agree that however frustrating that's been (and
sorry!) it would be a lot worse if my average response time to the leak
testing breaking something was measured in months :)

I do think that whatever issues we've had with it (and in retrospect I'd
do some of it differently) that it's a lot more mature these days than
you might remember.

I've been making an effort to specifically address the sorts of leaks
that would cause that sort of pain, e.g. adding an unsespecting "git
log" to an existing test file and the like.

I have a report I generate [1] of the outstanding leaks, sorted by
de-duping stack traces, and an estimate of how many tests would start
passing if a combination of leaks were solved[1].

On the one hand it's ~60k lines of scary stack traces, but on the other
hand it used to be easily 3-4x that (I can't recall the exact size
offhand).

But more importantly while we do have some widespread leaks still, it
used to be the case that e.g. some leaks would show up in 50-100 test
files.

Now the #1 leak by number of times it's seen in test files happens in
just 12 filess, and there's a very long tail of leaks that only happen
in one test somewhere. I.e. are specific to their own area.

Just anecdotally I think it's had sort of the opposite problem recently,
that it's getting good enough to start flagging about new leaks that
really are specific to newly queued topics. E.g. [2] and [3] are two
recent examples.

But in both cases there seems to have been an understandable assumption
that it was probably just "linux-leaks" being noisy, due to the job
crying wolf in the past.

1. https://vm.nix.is/~avar/noindex/2022-12-03-git-leak-report.txt
2. https://lore.kernel.org/git/221108.864jv9sc9r.gmgdl@evledraar.gmail.com/
3. https://lore.kernel.org/git/2488058d-dc59-e8c1-0611-fbcaeb083d73@web.de/
