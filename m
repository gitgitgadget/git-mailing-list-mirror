Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF09FC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 12:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbhKWNAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 08:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbhKWNAS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 08:00:18 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64071C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 04:57:10 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v1so58068157edx.2
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 04:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=wQDEZ15t3ylwGYSoqUbR3w8ZOgY/pOqCK8CCUlgwgO4=;
        b=bAyIFv4oVTFJFyz/U/oNAGi1d8b1dAZyvRxODZx9GKAt/xPJqXD2+TkpAK5MH3VuYo
         70BB5bvPuOhYyLFO9/vxNQPUOAmDISeky6ISbTHDvKkG5mki5mGkU1rV8ufhxjeB2S1S
         2RcT1/21aFyi24ptbn+bpgB6zUwz3JvL6d+az9YfZj1lnAPDGaXJ0MELT6yYIvetvOR4
         k46Vq0p+PQiF9Ba4LsKHq0uNqHIsQDmXiLHjGeX6YQyq0fcpkrx/H9Mc7ZIBVB0rpA4C
         14mkk+96cdRANOv0CSw0kGscchu8Fvy3N9gBEVNQYrOaDu4nwM6oL0k3aXhqequtVR6R
         fVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=wQDEZ15t3ylwGYSoqUbR3w8ZOgY/pOqCK8CCUlgwgO4=;
        b=6yJjigu57B6Pd/6/wtAwCAsFVatneVN8GSs/qcvwDzUVE2z1Oem7s/GlPN8mLVz5s9
         imstfmrI3BWqVxaoY8w4kjG0lQbXsD/ZpnrG6F/JvND7U4QPp+3LEj8HRoIRanD5Uxmm
         Zkvx/YNJgSh8qXRNUmHFGom+fGedpyl2HDFnt36rwH/wWtfQ5QumWKXMsukXEqTjb2Jq
         ekaGVgLMPkWodW7mkfY2gX4UdKDi2kzU+evNEnoWkb6lVi9K2QVwKl5uPsIyVUyv5oF/
         QWi4D65gdgeAuha8r7cJwikIEb+gS/PSH6S9ZUqTTi+IOmU56dvN2wiEH/OR8rw2swYO
         c8Fw==
X-Gm-Message-State: AOAM532iCdcIreJpVgad8I8M7iBTxiT4OxwkxvLKqiPUiHWckPiPEI7v
        /2FQa2iqnYn3HSNACJlxhgk=
X-Google-Smtp-Source: ABdhPJw3weabVVBVSHV7er2S83jzMsMTeIwibC3DFTDT4BU4H1aOuajsbgSKSNtlbTEli+LdW3HR/g==
X-Received: by 2002:a05:6402:d73:: with SMTP id ec51mr9143894edb.175.1637672228764;
        Tue, 23 Nov 2021 04:57:08 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id yd20sm5146229ejb.47.2021.11.23.04.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 04:57:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpVMB-001Mza-3n;
        Tue, 23 Nov 2021 13:57:07 +0100
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
Date:   Tue, 23 Nov 2021 13:45:15 +0100
References: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
        <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
        <CABPp-BG=fcKq2Ng2gan3HbBGcT7WCMhtZCP6m2xjA5BSuTekOg@mail.gmail.com>
        <nycvar.QRO.7.76.6.2111221317390.63@tvgsbejvaqbjf.bet>
        <211122.865yskyw25.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2111222304070.63@tvgsbejvaqbjf.bet>
        <211123.86y25fwxup.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2111231249080.63@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <nycvar.QRO.7.76.6.2111231249080.63@tvgsbejvaqbjf.bet>
Message-ID: <211123.86ee77uj18.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 23 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Tue, 23 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> [...]
>>     $ make clean; make -C contrib/scalar test
>>     [...]
>>         CC hook.o
>>         CC version.o
>>         CC help.o
>>         AR libgit.a
>>     make[1]: Leaving directory '/home/avar/g/git'
>>         SUBDIR ../..
>>     make[1]: Entering directory '/home/avar/g/git'
>>         * new link flags
>>         CC contrib/scalar/scalar.o
>>         LINK contrib/scalar/scalar
>>     make[1]: Leaving directory '/home/avar/g/git'
>>     make -C t
>>     make[1]: Entering directory '/home/avar/g/git/contrib/scalar/t'
>>     *** prove ***
>>     error: GIT-BUILD-OPTIONS missing (has Git been built?).
>>     t9099-scalar.sh .. Dubious, test returned 1 (wstat 256, 0x100)
>>     No subtests run
>
> That's cute. You seem to have missed that this is `contrib/`? The
> assumption of pretty much _everything_ in there is that Git was already
> built.
>
> Try this at home: `make clean && make -C contrib/subtree/ test`
>
> Yep. It "fails" in the same way. "has Git been built?".
>
> So if that was all the evidence in favor of that misinformation "Scalar's
> build is broken! Broken, broken, BROKEN!", I think we can now let it rest.
> At last.

No, it doesn't fail in the same way. Really, it seems like you're either
not fully reading through E-Mails before replying, or entirely
misunderstanding what I'm saying. I highlighted the difference in
"[...]that's not broken because[...]" below the context you're quoting.

I'm specifically pointing out the difference between how these act:

    make clean; make -C contrib/subtree/ test
    make clean; make -C t

Which fail right away without trying to build anything, and how your:

    make clean; make -C contrib/scalar test

Won't fail right away, but get most of the way towards building what it
needs at the top-level.

So yes, I fully agree with your contrib/subtree example, but it's making
my argument for me.

As I pointed out in the just-sent [1] the main issue is that your latest
iteration added "make -C contrib/subtree/ test" in the wrong place, and
we thus ended up running those tests in places we didn't intend. The
main conflict is that semantic conflict.

But that failure also highlighted that contrib/scalar/Makefile will run
a build of the top-level C code, only to error out with
"GIT-BUILD-OPTIONS".

That specifically is what I consider broken. It should either actually
work and properly build its dependency, or not even try.

Either one would be fine in this context, it's the in-between that's
clearly (to me at least) broken. Working software should either attempt
a task and succeed, or not attempt the task at all.

1. https://lore.kernel.org/git/211123.86ilwjujmd.gmgdl@evledraar.gmail.com/

