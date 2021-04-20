Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F640C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A2AA613C0
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhDTMZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhDTMZt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:25:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B19C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:25:17 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id x12so37206167ejc.1
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=DWz91iqKZYTIe0t7wF68ibfTVWXn7IRABZj6sopuE3w=;
        b=Vd/GMe4hhA89Im2IHzPu7PQw9hcTj/Aza3qKDvjtIRsALVnlf0R7R093UXbDNF8SJL
         U6TNJfMPOJ5c3i2b6l9Siknl/MgPRY699w+nrcftPoWZsQ2hLKjBpayQdOT4gG43tCwp
         h0wv98bXimLkIRbQAIi5uONbaXNapdnBiqxlfBUHp8He4fGTczqbP5qDT0wSFgPni5uO
         B2KQs1XrlW27j82Uy1fQpLSIgCm8dolxSqG9Tt0CYdo1Gk0AQ5F3KZmGCILf7cooOGXC
         dAnhPY6TBjsANhkAgtAOgbXV/vghRkDqe6Th8XfkTQrtKlGZs1L9vjeMNff3mkgJhcTX
         HDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=DWz91iqKZYTIe0t7wF68ibfTVWXn7IRABZj6sopuE3w=;
        b=gwhZ69YuoLEmX0rb5bqzqFYItPYvF5CCJBSWQ95LZq/h7MXO+9nO58kIHU+dxdaE86
         StuiKWccZu2/mkC9xeHlJ7AGkg+lrLzCSKAR3EYXOgiaZiP+TvKOwlaQ5xdS6HtdRl1n
         WFKU6JpBPu062pumpw5iKaPms5rmBhjoGJtGeH0Bdde472KxgDbPa91g9+hyqZdnYaHJ
         CMO90SCUCtG2BVGw1EdYUlQUtZQLaMjwdX+Al02zBmriFrGPg4xjRqa7lKdBQGWaimqp
         XpDMmwtpj1YAIf2CiXDBM0yXVZWI2LpV+iw/qEXfTPNQZ+vYxa1r1KH3Eh2I0DJK4lcm
         lAcw==
X-Gm-Message-State: AOAM533rfjEyEQPzHUvmfy/v2Bx90VOyw/a29kKjJ856OL9EhbbAFvfX
        iKKRxr/16fk8elOmgGYmd8I=
X-Google-Smtp-Source: ABdhPJwEb6kr3i/OQOA4Wo5UFQKIKKAcu7KOr1FHxk1YOBEwiX5Rb5WefqfQAjJ9FRRJ1Yq1gCZjag==
X-Received: by 2002:a17:906:a20b:: with SMTP id r11mr7514841ejy.323.1618921515945;
        Tue, 20 Apr 2021 05:25:15 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id y25sm10402481ejb.34.2021.04.20.05.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:25:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBD?= =?utf-8?B?w7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 2/3] Revert and amend "test-lib-functions: assert
 correct parameter count"
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
 <cover-0.3-00000000000-20210417T125539Z-avarab@gmail.com>
 <patch-2.3-6f9e09a2017-20210417T125540Z-avarab@gmail.com>
 <CAPig+cSR_y4uqPnYt+P4EFxPrhN8LHDjLX=_5uJFWYbL1skixA@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAPig+cSR_y4uqPnYt+P4EFxPrhN8LHDjLX=_5uJFWYbL1skixA@mail.gmail.com>
Date:   Tue, 20 Apr 2021 14:25:14 +0200
Message-ID: <87pmyp2led.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 18 2021, Eric Sunshine wrote:

> On Sat, Apr 17, 2021 at 8:58 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> [...]
>> The goal here is to get rid of the verbosity of having e.g. a "test 2
>> -ne 2" line for every "test_cmp". We use "$@" as an argument to "test"
>> to intentionally feed the "test" operator too many arguments if the
>> functions are called with too many arguments, thus piggy-backing on it
>> to check the number of arguments we get.
>
> My one concern about this change is that it enters the realm of
> "huh?". Although it's dead-simple to understand what this code is
> doing:
>
>     test "$#" -ne 1 && BUG "1 param"
>     if ! test -f "$1"
>
> the replacement code:
>
>     if ! test -f "$@"
>
> can easily lead to head-scratching, wondering why the author chose to
> use "$@" rather than the more obvious "$1". This sort of unusual local
> idiom might normally deserve an in-code comment explaining why the
> more obvious code is not employed. However, adding a comment at each
> site would be overkill, so it might be the sort of thing to explain in
> documentation somewhere ("In order to make -x output less noisy,
> employ "$@" rather than explicitly checking function arguments when
> writing new test functions...".) Otherwise, the reader is forced to
> consult the commit message.
>
> Not a major objection; just voicing the bit of unease I feel about it.

I'm including a well-placed comment in the re-roll of this. FWIW this
would be much easier to follow with my rejected split-up of
test-lib-functions.sh, then we could group these functions into one
file:
https://lore.kernel.org/git/20210209214159.22815-13-avarab@gmail.com/

>> This does not to the "right" thing in cases like:
>
> Channeling Dscho's inner Eric Sunshine[1]: s/to/do/

Sunshine recursion error? :)

> [1]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.2103222235150.50@tvgsb=
ejvaqbjf.bet/

