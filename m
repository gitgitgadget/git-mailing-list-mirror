Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B502C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 23:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhKVX5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 18:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhKVX5R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 18:57:17 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600EAC061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 15:54:09 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r25so47199797edq.7
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 15:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=q3SByp0gjGfA3jdn4O+Nbr3plxhWW9Ef8Zgxpz/pKKw=;
        b=Wty8U8NJbKY/JT6onxZw8SBCwg9O4jUjmX4ABPGTGCGvhiD7MDZtwbaL/n69CHfRT2
         tW2NOQN9DPv8LsV9Az9zFEKbyX1wfMoUNA4ejLaAbMGyB2eLiX8QlqJxrbnOTqXx/QKE
         +iYJANhUqk9Mkz79hDxj/UrNm+VftLkowqoeWUs1l4gN9UFiWqGkgAfdE6q0gYhHUNb9
         Gc5Pu89dgkHwBraCRxsH651iu/Jtl0mXEmXDptJEbdMoh0fPq/OE02I5hlj/1iAfobG2
         Do3jFREmNYAbzGPIeBNiHUHRuF3Fs5MEsiS2Qe2gP6a9dTzpBfpATASwR5pPObtfrdj2
         NUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=q3SByp0gjGfA3jdn4O+Nbr3plxhWW9Ef8Zgxpz/pKKw=;
        b=PkUYOqY8LtqPnkAIcqkc+AOHDjd3mYxS/Ab03aBJdlWlNVz2Wf3x6e5u0EFlTc6Gug
         E6CTNIu9xTfEjiP59TawsqUkQgOGkiqIXen1VJfvcv3A1MFFa8iRyWiHsuNUaD+5KrPx
         7muZgH8Ywt1F5Gpqa0c+XJNnkvguWxtwL/+6nArOdfZhH+fWLr5gfWob99tPsOhO8x6g
         u2h6knUV4y8PlqhaC6J0elYiL1bywf2GOld/aPu5A6n+a5N++m5uHHrLcE8sy4Qk9ySy
         EWReffYiFrQHDlEyxQyUo9Vyy8iXBaoVzJMaF2CQb2YvYdMb9oWGxhDqkf8n/CctUDvc
         4Zbw==
X-Gm-Message-State: AOAM531xqU5ZZsAsx+PNKWmO2jt47pwM/PfsSY8zqgk8B+74vz7ho/bC
        h70b4svBV7uTXwNA/lRKbUE=
X-Google-Smtp-Source: ABdhPJzjyQhsQXTRTs82rAYVMVN3JAQzpKQNVDcNuoj2VLxE4ouGPzPwCy0+KtxDpiYh+UF3EJ06dA==
X-Received: by 2002:a17:906:579a:: with SMTP id k26mr1765868ejq.250.1637625247811;
        Mon, 22 Nov 2021 15:54:07 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f16sm5107351edd.37.2021.11.22.15.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 15:54:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpJ8Q-001E6u-JY;
        Tue, 23 Nov 2021 00:54:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v8 00/17] Upstreaming the Scalar command
Date:   Tue, 23 Nov 2021 00:29:13 +0100
References: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
        <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
        <CABPp-BG=fcKq2Ng2gan3HbBGcT7WCMhtZCP6m2xjA5BSuTekOg@mail.gmail.com>
        <nycvar.QRO.7.76.6.2111221317390.63@tvgsbejvaqbjf.bet>
        <211122.865yskyw25.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2111222304070.63@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <nycvar.QRO.7.76.6.2111222304070.63@tvgsbejvaqbjf.bet>
Message-ID: <211123.86y25fwxup.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Johannes Schindelin wrote:

> On Mon, 22 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Mon, Nov 22 2021, Johannes Schindelin wrote:
>>
>> > On Sat, 20 Nov 2021, Elijah Newren wrote:
>> >
>> >> On Fri, Nov 19, 2021 at 3:03 PM Johannes Schindelin via GitGitGadget
>> >> <gitgitgadget@gmail.com> wrote:
>> >> >
>> >> > tl;dr: This series contributes the core part of the Scalar command =
to
>> >> > the Git project. This command provides an opinionated way to create
>> >> > and configure Git repositories with a focus on very large
>> >> > repositories.
>> >>
>> >> I thought after
>> >> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2110062241150.395@tvgsb=
ejvaqbjf.bet/
>> >> that you'd update merge.renames to true on what is now patch 7.  Did
>> >> you end up changing your mind, or was this overlooked?
>> >
>> > Oops! Thank you so much for the reminder.
>> >
>> > Will fix. I do not plan on sending out a new iteration for a few more =
days
>> > because I do not want to send lots of patches to the list right now,
>> > reviewer bandwidth seems to be stretched quite a bit already.
>>
>> Bandwidth which is further stretched by continuing to send updates to
>> this topic while ignoring outstanding feedback.
>
> The feedback you are referring to is probably the repeated demand to
> integrate Scalar deeply into Git's build process.
>
> As I have tired of replying, it is not the time for that yet.
>
> Repeating that demand does not make it more sensible, nor does it
> magically make it the right time.

I'm not repeating that demand. I clearly also think the approach you're
insisting picking isn't a good one, but let's leave that aside.

What I'm referring to with "I've also been pointing out" in the context
you elided is that if you:

 1. Check out your topic
 2. Apply my proposed patch on top (a newer version than on-list is
    in avar/scalar-move-build-from-contrib-2 in my GH fork)
 3. Push both to CI
 4. Diff the two logs of the runs (or just manually click through
    and inspect them)

You'd have seen before sending your version of the CI integration that
the difference in behavior that started with your version of the topic
was particular to the contrib/scalar/ integration, but not the top-level
Makefile integration. I.e. adding the scalar tests to the previously
build-only jobs.

I've been noting that as clearly as I'm able to in numerous past
exchanges. You've either ignored those reports, or like here,
selectivtely replied only to parts of what I've told you.

I.e. something like "I'm not going 100% for the approach you
suggest". Sure, I'm not saying you have to. But I also noted that the
patch with that suggested approach can be considered a bug report
against your series.

The reason that patch isn't split into two things, one fixing all the
issues I noticed, and another implementing some "alternate build"
approach is that I found that to be impossible to do.

Those issues are all particular to emergent effects of the build
integration you're choosing to go with.

E.g. in the case of "seen" being broken the CI simply runs "make test"
as it did before, and scalar integrates into that, and you can run that
target without having built anything already.

> Nor is it credible to call the build "broken" when it does what it is
> supposed to do, thank you very much.

Here's specific commands showing that it's broken.

On your version (I've got v7 locally, but the same is true of v8):

    $ make clean; make -C contrib/scalar test
    [...]
        CC hook.o
        CC version.o
        CC help.o
        AR libgit.a
    make[1]: Leaving directory '/home/avar/g/git'
        SUBDIR ../..
    make[1]: Entering directory '/home/avar/g/git'
        * new link flags
        CC contrib/scalar/scalar.o
        LINK contrib/scalar/scalar
    make[1]: Leaving directory '/home/avar/g/git'
    make -C t
    make[1]: Entering directory '/home/avar/g/git/contrib/scalar/t'
    *** prove ***
    error: GIT-BUILD-OPTIONS missing (has Git been built?).
    t9099-scalar.sh .. Dubious, test returned 1 (wstat 256, 0x100)
    No subtests run=20
=20=20=20=20
    Test Summary Report
    -------------------
    t9099-scalar.sh (Wstat: 256 Tests: 0 Failed: 0)
      Non-zero exit status: 1
      Parse errors: No plan found in TAP output

On the patch I proposed to apply on top:

    $ make clean; make test T=3Dt9099-scalar.sh
    [...]
        CC t/helper/test-xml-encode.o
        GEN bin-wrappers/git
        GEN bin-wrappers/git-receive-pack
        GEN bin-wrappers/git-shell
        GEN bin-wrappers/git-upload-archive
        GEN bin-wrappers/git-upload-pack
        GEN bin-wrappers/scalar
        GEN bin-wrappers/git-cvsserver
        GEN bin-wrappers/test-fake-ssh
        GEN bin-wrappers/test-tool
        LINK t/helper/test-fake-ssh
        LINK t/helper/test-tool
    make -C t/ all
    make[1]: Entering directory '/home/avar/g/git/t'
    rm -f -r 'test-results'
    *** prove ***
    t9099-scalar.sh .. ok=20=20=20
    All tests successful.

You might correctly note that this doesn't work either on that version
(or for any other existing test in t/):

    $ make clean >/dev/null; make -C t T=3Dt9099-scalar.sh=20
    GIT_VERSION =3D 2.34.GIT-dev
    make: Entering directory '/home/avar/g/git/t'
    rm -f -r 'test-results'
    *** prove ***
    error: GIT-BUILD-OPTIONS missing (has Git been built?).
    t9099-scalar.sh .. Dubious, test returned 1 (wstat 256, 0x100)
    No subtests run=20
=20=20=20=20
    Test Summary Report
    -------------------
    t9099-scalar.sh (Wstat: 256 Tests: 0 Failed: 0)
      Non-zero exit status: 1
      Parse errors: No plan found in TAP output

Which is true, but that's not broken because it's not attempting to
build the top-level via some incomplete integration, but your version
is.
