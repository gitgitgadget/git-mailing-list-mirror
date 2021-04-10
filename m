Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D513C433ED
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 12:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CFD7601FD
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 12:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbhDJMa2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 08:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbhDJMa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 08:30:28 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692A6C061762
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 05:30:13 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h10so9538790edt.13
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 05:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=tuo04ZnR5xs43WX2tQ4zgLm/JlgvDCRDlDqxB1EWJBA=;
        b=UuJ/trYpUmDogxA3gFZyfhHajzTavsa2tZ0o2Feyd874UJi1+fZF0GsE/FnPQYm8ur
         CXF5N46IaDOzFnXyUW2c/j2w2829/l3QvAVJnBecanO5bhBaiYsj3Mu/KIU/IY4tNkCo
         4J+Qd3A69/0J4c3Jt5rMTOHnoS1fdFaHuGEbYmtNw4h9jxzpyv4wQHuXJE7JCuNlWCUi
         L7rDwii5DtSWcsFA4cTPv01+uSBXsSVsF6uEdzBJWM1vPjJBzjO9vWw+gevzU027sOqH
         l4Ho7l7mKfdJcigfjUwueLrKEMiZ7C9UsOIExhZDzscw+mLxYIZGt6gKbjZOvC7zFVQv
         vTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=tuo04ZnR5xs43WX2tQ4zgLm/JlgvDCRDlDqxB1EWJBA=;
        b=gKW5h3ud2pxE1+hTYmnIt67/4h1ByMBQJGLflJxXS9YDrmLjulAgDnJ9BY8YgiWOIq
         cPRtEjDabK69pZAuZgRDY+9Jc8D+PLK4gd0Yh0wyxJjGdQqzZ+f5+T0Rb+bk/5SHhs8x
         w1gD+S6MKigZVUPyx+VxGo8GzU7hDoKBgvZUR74dtql20rxEW085wT5IgniAOzeohytG
         v/uaMgBlf/zIQdSQACBXCzqjOf6BRlBM101uEpmwjt1cFuSDS5NMoZlrcI9fHkvoK8e6
         TMS4zAqnbCVzBGoEor1bcVy0o0Pc5G8YwE6a/jcXyjwzODJolh7Vw3mKzg6bajj4uxHZ
         7jKw==
X-Gm-Message-State: AOAM531nT5iWIGZ4SDMPVOyU2a4a2nvpC7hjScY352nG0SPW91IUUU+c
        M6Hg8q59rOIRdAh1W5LR4U6J6UgTrI6dtA==
X-Google-Smtp-Source: ABdhPJyNim6BsoiueDBHUdxPELpjdWD3qskkQz1Q/mzLnG41dHJqfGBjWEEzZtnNMiE57IIpU/drTw==
X-Received: by 2002:a05:6402:4d1:: with SMTP id n17mr21188834edw.118.1618057812060;
        Sat, 10 Apr 2021 05:30:12 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id la16sm2587507ejb.40.2021.04.10.05.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 05:30:11 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Chris Torek" <chris.torek@gmail.com>
Subject: Re: [PATCH v4 05/10] userdiff: add and use for_each_userdiff_driver()
References: <20210224195129.4004-1-avarab@gmail.com>
        <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
        <patch-05.11-64ea5e8443f-20210324T014604Z-avarab@gmail.com>
        <YFuPMMMYicFK6A/S@coredump.intra.peff.net>
        <87im5gp2ze.fsf@evledraar.gmail.com>
        <YFvaYokQJpvwSzJ6@coredump.intra.peff.net>
        <87czvoowg2.fsf@evledraar.gmail.com>
        <YF1UuNBrAWvHSCp1@coredump.intra.peff.net>
        <87czv3gs3q.fsf@evledraar.gmail.com>
        <YHC1CZoOBJFwQIx8@coredump.intra.peff.net>
        <xmqq5z0vm6e2.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqq5z0vm6e2.fsf@gitster.g>
Date:   Sat, 10 Apr 2021 14:30:10 +0200
Message-ID: <871rbigw4t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 10 2021, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>>> That plan involves an "git rm -r compat/regex" and a compat/pcre
>>> instead, I have some long-left-over patches for that.
>>
>> OK. I was more worried about platforms where it was cumbersome to
>> install pcre. If we are shipping it as a vendored library, then at least
>> the dependency management is on us, and not the user. I do worry a
>> little about running into complications with building or debugging it.
>
> Please don't.  I prefer not shipping compat/pcre ourselves; having
> to worry about version skew and picking up upstream security fixes
> in time, etc. for an external library that is well maintained is not
> what we need.

I'm not submitting patches for this now, I personally don't care much if
PCRE became a required dep (as in you need the library) and we didn't
ship it.

I just assumed if I'd propose that that we'd want "make" to work on more
bare-bones systems, since we e.g. carry a copy of
sha1collisiondetection/ partially to facilitate that.

But FWIW, and to the extent I've got time etc. my rough plan for this
larger PCRE conpsiary was:

 1. Get the current pickaxe-prep-for-PCRE patches to land.

 2. I've got patches on top of that which move over to PCRE, so as with
    the existing grep.c code we could drop kwset entirely (declare that
    if you need optimized fast search, you can install PCRE).

 3. git rm kwset.[ch]

 4. Migrate more things to some light wrapper "do a regex match" API
    (just small modifications to grep.c) that'll optimistically be able
    to do BRE/ERE/PCRE matches. If you've got PCRE then PCRE can handle
    them all (it's got a RX dialecttranslation interface).

 5. All our regcomp/regexec should be gone in favor if this simple
    replacement API.

Which is where this "PCRE everywhere" would come in, at this point we'll
be carrying a compat/regex/ which we could just as well replace with a
compat/pcre/.

The reason it would matter to have a hard prereq on PCRE is because it
would simplify and speed up a lot of code in various places to be able
to make an assumption that it's there. E.g. for things that do "match a
line" like pickaxe we could do clever anchoring and match the whole diff
at once, and also things like streaming the diff out as we consume it
into PCRE's stream matching API.

We also have a lot of things purely on the C level that would be
simpler, e.g. (just one thing I remember) grep.c has 40 lines of code to
emulate \b<word>\b, but we could ... just use \b.

To Jeff's comment upthread:

> And while it may build portably everywhere, that may involve extra
> work and not integrate with our build knobs (e.g., it looks like it
> uses autoconf)

I already did that work in an old WIP branch I have. I haven't run it
again so maybe this summary is inaccurate, but here's the commit:
https://github.com/avar/git/commit/79256ee4a1

So basically it won't build with autoconf or whatever, just with our own
build system after we'd wget the relevant PCREv2 source files into
compat/pcre/.

The only things PCRE really needed autoconf or its own build system for
was to define 20-ish macros which are either options we can switch, or
(looking at this now) 4x probes like "HAVE_STDINT_H" which we could add
to compat.mak.uname and friends.

If we wanted it to Just Work we could run that script and "git commit"
it, or just leave it at a make warning saying "you don't have PCRE,
either install it using your pkg system, or run this handy shellscript".

But yeah, if Junio's paranoid about the security aspect we could skip
that "./get-pcre.sh && git commit" step.

I'm getting some deja-vu writing this next part, I'm pretty sure I've
written some version of the same E-Mail before, in any case:

 A. This wouldn't be anything new. We have some old bitrotting copy of
    GNU awk's copy of glibc's regex engine in compat/regex. It's trivial
    to e.g. get it to exhaust all memory on your system.

    Sure, PCRE could have bugs, but at least we *could* update it. As
    you may remember I abandoned my last attempt to update compat/regex/

 B. Even if you assume some bug like that, I think realistically no user
    anywhere would be vulnerable to a copy we'd ship in compat/pcre/,
    any vendor would ignore it and build the prereq themselves. It's
    purely a developer aid.

    Of course it could have some CVE, but it wouldn't be mean a git
    point release.

 C. Even if the regex engine has an CVE/RCE we have no feature anywhere
    to execute arbitrary user regexes, anyone who could inject one can
    already run arbitrary git commands.

 D. The *one* exception to C) is gitweb's not-on-by-default "grep the
    source tree" feature.

    So first its users would be better off than they are now now. You
    can trivially DoS any box that has it exposed, secondly the union of
    gitweb users + those that would turn that on + build their own git
    for running a public-facing site is probably 0 people these days.

 E. Even if you assume some combination of B..D isn't true I genuinely
    don't know why this concern of PCRE being a special
    security/vulnerability concern comes from, it seems to be brought up
    any time the topic is discussed.

    The implicit context is that we already process regexes using a
    plethora of engines, and are using anything from AIXs, SunOS's,
    Window's, OSX's, GNU libc's etc. regex engines to do so.

    I haven't seen anything to suggest that PCRE's security record is
    notably worse than even one of those pieces of software, and right
    now we're exposing any bugs in the union of all those engines.

    It's quite the opposite, unlike those engines PCRE actually gives
    you really good features to limit resource consumption and regex
    features in the event that you don't trust your regex or your
    input.

    I'd actually trust for things like processing a "git grep on the
    web" with appropriate resource constraints.

    The two solutions in that space are basically to use DFA engine as
    e.g. Google's re2 does. That means living with a severely restricted
    set of regex features, or to have bells and whistles as PCRE's NFA
    does, but one that has tweakable resource limits.
