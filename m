Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB1AC352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 11:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiLFLN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 06:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiLFLNy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 06:13:54 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7145F60
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 03:13:50 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id m19so19744507edj.8
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 03:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Lh/3hQ39Sq7DUKkeoFTUB6M4hQqP2uwqEMxELWDyoc=;
        b=Yjnrhnb+KC6BG64XqaYScERQVVfNr3XD7+1tucEgV4mIcEjSyFdeTXpN2Eya+NKMWo
         87loRB49qSWiHyp6aOpM+hNRrJZrF7H6P1mzCKbDCUizLuR90nZIhV6WWw1N/Nsu4nL9
         OR/Nr1aoFjHaQpcVV1GaxByWNDdkwqsQiXuudtvgSllY67IMRGF/eRTJVxccXGoE6iRe
         TYPj62YqXm1kxR8aouuGesoDFJbO0r0gME1X6dcyVtE5jzBrHhvkWASbU6j2wGs+1xUd
         zmt4IOBlnm3P83YhSV1NotODDn/a06xd0JyX1MV6RN9wa7ArVXUyq9Tezl8WRTHfDt/x
         N4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Lh/3hQ39Sq7DUKkeoFTUB6M4hQqP2uwqEMxELWDyoc=;
        b=nSEKHQDcRKWZTo8c7yDr2YAhX4sbKp8KzWVJPkVi98ZwX43hrOJBPR13wa9Ssu8k4b
         FB+0PAwR1t8qEEtUTD/EEJcbHSn7kvbXAPbqhFqQbLi6YxUPFe4dYvXCdMxui/+CCSo9
         YvqYvLumzOB2J6joTjBPqeygJ8mUV/AiFEgC8lnBmWxo3/6kGOdlELTLmyigV98dZfLX
         TSfZEixlxjdYXqEG1Fn+ppDoiQpEI8PgZ4nSJS0hEWS8rc7EShSOHZLbc72oKAc9a4jM
         dv1PrggUDOXfKIBQtr1X2lNkjivwFgU/0vU8Ub6hEBTX3dKk1I+oJx+70QEoX8ldYi8E
         L2lg==
X-Gm-Message-State: ANoB5pnMT2GSRxzHiioQ8v64ErxgS1qP/lJ5SP+4WvJeS+2cPXUonJ34
        LrTnp+wEQTmbkjLBhj0mCxE=
X-Google-Smtp-Source: AA0mqf7lfbBEv8w5l6klZCHTKmx4EUOyw49iOqOwx/S3cFA2wbBbQiLuRuKSdoMN6clBGv/A+F7Wpg==
X-Received: by 2002:a50:fe86:0:b0:462:a00e:1dab with SMTP id d6-20020a50fe86000000b00462a00e1dabmr76428680edt.135.1670325228865;
        Tue, 06 Dec 2022 03:13:48 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id p21-20020aa7cc95000000b0045b910b0542sm854098edt.15.2022.12.06.03.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 03:13:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2VtT-003pPa-1G;
        Tue, 06 Dec 2022 12:13:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] test-lib.sh: discover "git" in subdirs of
 "contrib/buildsystems/out"
Date:   Tue, 06 Dec 2022 11:57:37 +0100
References: <663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk>
        <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
        <xmqq5yeuspam.fsf@gitster.g>
        <87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk>
        <221202.86sfhxg2ng.gmgdl@evledraar.gmail.com>
        <Y4qF3iHW2s+I0yNe@coredump.intra.peff.net>
        <221203.86pmd1dyqn.gmgdl@evledraar.gmail.com>
        <Y45/8WnuUnP9gOMo@nand.local>
        <Y46clyoKk9KzFiqj@coredump.intra.peff.net>
        <221206.86zgc1cnc3.gmgdl@evledraar.gmail.com>
        <Y46jT0i/7DhxHzfS@coredump.intra.peff.net>
        <221206.86mt81claa.gmgdl@evledraar.gmail.com>
        <xmqqilipnq8j.fsf@gitster.g>
        <30360f4c-91a5-177b-133f-eb7036ed676a@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <30360f4c-91a5-177b-133f-eb7036ed676a@dunelm.org.uk>
Message-ID: <221206.865yeodbtg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 06 2022, Phillip Wood wrote:

> On 06/12/2022 03:52, Junio C Hamano wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>=20
>>> Just to add my own digression: I asked in some past thread (which I'm
>>> too lazy to dig up) why it was the cmake file couldn't just dispatch to
>>> "make" for most things.
>
> Because make is not installed by default on Windows. Our CI job uses
> msbuild (whatever that is) and when I was playing with Visual Studio=20
> last week it was using ninja.
>
>>> I.e. it needs to at some level be aware of what it's building for the
>>> IDE integration, but for say making a "grep.o" there's no reason it
>>> couldn't be running:
>>>
>>> 	make grep.o
>>>
>>> Instead of:
>>>
>>>          cc <args> -o grep grep.c [...]
>>>
>>> which requires duplicating much of the Makefile logic (possibly with
>>> some Makefile shim to not consider any dependencies in that case).
>> That leads to a question at the other extreme.  Why does any logic
>> in CMakeLists.txt even have to exist at all?  Whenever it is asked
>> to make foo, it can be running "make foo" instead of having its own
>> logic at all.  ;-)
>
> Yes, if make was available then we wouldn't need to use CMake.

I think Junio and I are talking about something slightly different. Yes
"make" isn't available by default. Getting it requires installing a
larger SDK.

But if you look at the history of contrib/vscode/README.md in our tree
you'll see that we used to support this "Visual Studio Solution" for
years via GNU make, it probably still works.

The change in 4c2c38e800f (ci: modification of main.yml to use cmake for
vs-build job, 2020-06-26) shows when the CI was switched over to using
cmake instead.

The code to support that is still in-tree as the "vcxproj" target in
"config.mak.uname", which calls out to the ~1k lines of Perl code in
contrib/buildsystems/Generators/*.

I'm not suggesting we go back to that. The question is whether the
trade-off of supporting an entirely separate build system without a GNU
make dependency was worth it.

On the one hand those developing on Windows don't need to install it as
a package, on the other hand we end up spending more developer time in
writing duplicate build logic.

The advantage of cmake is that it knows how to generate all that
VS-integration XML etc., so as soon as it knows how to build Git you get
that for free.

But I think you can get that while not having a "real" cmake recipe, but
just a thin shim for calling out to the Makefile.

Is such a thing a hack? Yes. Is it silly to e.g. build with "ninja" and
really have it just shell out to "make"? Yes.

But it might still be worth it if we judge that the goal of getting that
VS integration is sufficient. And that we're not willing to absorb the
cost of maintaining two distinct build recipes in perpetuity.
