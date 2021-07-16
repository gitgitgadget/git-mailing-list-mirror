Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7274C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 19:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A681B613D4
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 19:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhGPTEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 15:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhGPTEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 15:04:25 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D472C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 12:01:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id l26so14237548eda.10
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 12:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gLrVkwI5jOatZMO893fwHIoZIxbabpo/t90yyB3U/+o=;
        b=Uv3jQDF/cxoRur42fK6ln3r8qEQkdgnS1UOOLoEQkboZOPgDzA0VgtrDn+DJS00BXV
         HXUhsyovR3PLop5MzGXrkPJEAHix80eUREX9Hy5Gv6oSLgZiBJ96a8dOdM0TzgyvnBM9
         DfCNI+0b5+UkIQ+P0V9se226iPbmAyMb9wRJKxiuR0CV+gsb/CfiUGKuPKne64aVh2fC
         F5OONIJ9MePs2jXFTC+DkpmkRQ14F2NRkZlTfOavn7e0r0GafJKFPsdYqGD6o5zSSvL9
         5BU8RLpVH0w+2Nqd1RqV16dUKX+xU7woHty509cdpdRTCp7CAD6DBwICWSbt52X7m72C
         L/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gLrVkwI5jOatZMO893fwHIoZIxbabpo/t90yyB3U/+o=;
        b=KAwY1h1z38UNSwWx9v7RpcqvHNBjF/6w4u1VItibK9YXNDHOJ9GfRELLjleCu6E6hA
         XeubjcPam9i2Kq6bpi39HEZ29IeM4YbTXv3mtUq0yRnxOPUgM/kBpEc+QXVUnAyb9YxX
         HYI+7XfUORxMO2iVgG9R1fyw4cshD1FrV2/M1Ptvxj3Z1JRGtKJJBiX7Mpzyg760nIZA
         d62j42iPi5cPZxSGoXUUiEtJpFlSD1infiOEGdyxHh7taoGgT3CQ/uH2bGy6uLkRYes1
         rELrMu7u4tecKfMOpxHJR4JZ07ZD7lZgq4toRjpeesKdk78mwKaUnYLH/R4kWrWctDnE
         2/tA==
X-Gm-Message-State: AOAM532B3U9xLbCIuTcDHXKMIfPMguHOdHjuISbF+c0iKRBB9eyUzulk
        9QUy0VeoRjQoPrydv5pfVRg=
X-Google-Smtp-Source: ABdhPJzdFdqbK6m5XcF/Upg0TtHTdMUaQrEK6tPaVZfV6dE+hBCGLdQSTfszoNtcLzUW182Kyn0JiA==
X-Received: by 2002:a05:6402:605:: with SMTP id n5mr16621310edv.89.1626462088742;
        Fri, 16 Jul 2021 12:01:28 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b12sm4144252edu.30.2021.07.16.12.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 12:01:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/4] tests: add a test mode for SANITIZE=leak, run it
 in CI
Date:   Fri, 16 Jul 2021 20:56:04 +0200
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
 <patch-1.4-0795436a24-20210714T172251Z-avarab@gmail.com>
 <YPCjTpumyh1P/DQj@coredump.intra.peff.net>
 <877dhqxqbt.fsf@evledraar.gmail.com>
 <YPHLUsXsWO+JYS5X@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YPHLUsXsWO+JYS5X@coredump.intra.peff.net>
Message-ID: <87v95aw0a6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 16 2021, Jeff King wrote:

> On Fri, Jul 16, 2021 at 04:46:12PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > and so on. That requires two new features in test-lib.sh:
>> >
>> >   - making a GIT_TEST_RUN variable that is the opposite of GIT_TEST_SK=
IP
>> >     (instead of just the command-line --run).
>> >
>> >   - adding GIT_TEST_{RUN,SKIP}_FROM variables to read the values from a
>> >     file rather than the environment (I suppose the caller could just
>> >     stuff the contents into the variable, but I expect that test-lib.sh
>> >     may want to pare down the entries that do not even apply to the
>> >     current script for the sake of efficiency in checking each test).
>> >
>> > That infrastructure would then be applicable to other cases, too. Or
>> > even just useful for using another list (or no list at all) when you
>> > are looking at whether other tests are leak-free or not.
>>=20
>> I've included a mechanism for whitelisting specific globs, the idea was
>> not to have that be too detailed, but we'd e.g. get to the point of t00*
>> or whatever passing.
>>=20
>> Anything that's a lot more granular than that is doing to suck,
>> e.g. exposing teh GIT_TEST_SKIP and --run features. of specific test
>> numbers, now you need to count your tests if you add one in the middle
>> of one of those, and more likely you won't test under the mode and just
>> see it in CI.
>
> I think you can do the same level of skipping with GIT_TEST_SKIP,
> though. My argument was just that adding a new mechanism does not make
> sense when we already have one. I.e., running:
>
>   GIT_SKIP_TESTS=3D'
>     t[123456789]*
>     t0[^0]*
>     t00[^016]*
>     t000[469]
>     t001[2459]
>     t006[0248]
>   ' make SANITIZE=3Dleak test
>
> works already to do the same thing. The only thing we might want is a
> nicer syntax (e.g., to allow positive and negative patterns, or to read
> from a file). But that would benefit all users of GIT_SKIP_TESTS, not
> just people interested in leaks.

A glob in this series is t13*config*, you can't do that with
GIT_SKIP_TESTS because it only includes the numeric part of the test,
i.e. t1300, not t1300-config, or t1306-xdg-files.

But sure, it could happen via some other mechanism than the exact one I
picked, or we could add GIT_SKIP_TESTS2 or whatever.

I would like to be able to compile with it and run "make test" without a
wall of failures by default, i.e. we should be able to tell regressions
from known-OK to get anywhere with it, but that's orthagonal to the
exact mechanism.

>> It also means everything works by default, you get an appropriate notice
>> from prove(1), and even if you run one test manually it'll skip, but
>> emit a message saying you can set the env var to force its run.
>
> With GIT_SKIP_TESTS you obviously don't get a message saying "try
> skipping this test" when it fails. :) But IMHO that is not that big a
> deal. You'll get a test failure with good LSan output. If you are
> working on expanding leak-checker coverage, you already know about your
> options for skipping. If you're adding a new test that leaks, you might
> consider fixing the leak (though not always, if it's far from code
> you're touching).

I do think it makes sense as a test mode test-lib.sh is aware of,
e.g. on obvious next step is to not fail everything right away, but just
let the test run and log all failures to a file, then e.g. fail one test
at the end, or if we're running in that mode collate all the callstacks
and emit a summary for the whole test run.

But yes, the message it emits now isn't such a big deal.
