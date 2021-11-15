Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69561C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 500356325E
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbhKPATe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 19:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356435AbhKPARc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 19:17:32 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCD4C0537AB
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:54:32 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id w1so78942848edd.10
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ZLKZTxAMmIdVZjHvYnSCSM9gsSGZ2fQWF0Ti4HSJ0K8=;
        b=F+bBhN3JKES80pYiE/pWyGcTMyUqnhF9o37jd3j9WFuK4umE3Q5E8eIj6nMoZMnmWy
         MKtythizv2t7gHhVY+xKmgijZuyWUcIvrkMgngTIc7gOmCi976zIhcU48KUE33MWHifT
         5sw03EVKdaj1ozpJo7KzEhLKvFJhOW632RU1sXuDAuznDZkLhEdakU/zKOi5c03Pj8/b
         hN6upJUMZfrmc9W+KuVg1NffnloIp92ke8Agez9pBUpImO8Bl7uzCpurf+VYzXYeznWY
         DClVbGKKvxqz2hFWP0gTQhgU+syyfUs7/eHZ/VC1JSJEN7g57H68QWH8VqDvLp3+W3Er
         XziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ZLKZTxAMmIdVZjHvYnSCSM9gsSGZ2fQWF0Ti4HSJ0K8=;
        b=vXGAJfA2yZfOhhf71wQnUJDwhs4g4RA+6T/4kiYN1ZSWbkS81ZvdlNCNLGqvG1ARby
         O3zwqUrEHdRQs0IL+hNmhswyyHyLfOHYFKUBdhKBdOWlcEUl71vQdPcugBnVjHsJHWwj
         vF2xJxcAFjfAWAE8IpCG9P3k1kGpkAWN0Z0mqJRKS1yZRNNeVVUDVasLtAb3g0Qyiehe
         YQDCVxRlS7XquyfVOUwUVxA9LAgiN4BkrCCsZoby9SJE64CwFtz4w0yTVEVwkoys2jlo
         lzOgLAVes7AfmeOdUi31/5gBaLH2SkS2+xab/47eizleMaUBCLgDpNXnJaNDe6LakrId
         6edQ==
X-Gm-Message-State: AOAM533qy3TRP5REaaJEADyl5lAAOkX9I0v7S5EOSqXA8vRk2UmNKxPN
        5PodzuR7RI1IB6bMbs0Mnco=
X-Google-Smtp-Source: ABdhPJwJ7Ih0j5MHHItmNLna0Iq1w9paSGWrB8k8rmv33zz7oh9+t6X8FDNB1QASjnWqvBPFugt5Tg==
X-Received: by 2002:a17:907:250f:: with SMTP id y15mr3462102ejl.0.1637016871394;
        Mon, 15 Nov 2021 14:54:31 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qb28sm7369422ejc.93.2021.11.15.14.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:54:31 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mmkru-001H63-Bu;
        Mon, 15 Nov 2021 23:54:30 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 8/8] hook-list.h: add a generated list of hooks, like
 config-list.h
Date:   Mon, 15 Nov 2021 23:49:31 +0100
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
 <patch-8.8-80aae4d5c13-20210923T095326Z-avarab@gmail.com>
 <20211115220455.xse7mhbwabrheej4@glandium.org>
 <211115.86k0h9qcf5.gmgdl@evledraar.gmail.com>
 <20211115224015.vzfevpvptysxzpaa@glandium.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211115224015.vzfevpvptysxzpaa@glandium.org>
Message-ID: <211115.86bl2lqbbt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 16 2021, Mike Hommey wrote:

> On Mon, Nov 15, 2021 at 11:26:36PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> On Tue, Nov 16 2021, Mike Hommey wrote:
>>=20
>> > On Thu, Sep 23, 2021 at 12:30:03PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >> -builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PRE=
FIX
>> >> +hook.sp hook.s hook.o: hook-list.h
>> >> +
>> >> +builtin/help.sp builtin/help.s builtin/help.o: config-list.h hook-li=
st.h GIT-PREFIX
>> >
>> > hook-list.h is only included from buitin/bugreport.c, so
>> > builtin/bugreport.o should be the one with the hook-list.h dependency,
>> > shouldn't it?
>>=20
>> Well spotted, yes. This is a mistake. I think from some earlier WIP
>> version of the series.
>>=20
>> In practice we don't really miss dependencies due to these sorts of
>> mistakes since we use the .depends files, i.e. GCC & Clang figure this
>> out for us:
>>=20
>>     $ grep hook-list .depend/* */.depend/*
>>     builtin/.depend/bugreport.o.d: compat/compiler.h git-compat-util.h h=
ook.h hook-list.h
>>     builtin/.depend/bugreport.o.d:hook-list.h:
>
> But aren't those .depends files are only created when compiling object
> files, such that builtin/.depend/bugreport.o.d wouldn't exist until
> bugreport.c is compiled, which would fail if hook-list.h wasn't created
> before that?

Fail how?

I don't think it could fail, because the purpose of these dependency
relationships is to avoid needless *re*builds. So if you're building for
the first time it doesn't matter, your compiler will find the relevant
things to include for you. It doesn't need what's in the Makefile to do
that.

See [1], what I said about LIB_H there applies more generally for the
.depends files.

It will only fail in the sense that it over-depends, i.e. if you do:

    git clean -dxf; make builtin/help.o

We'll generate the hook list, as opposed to for buildin/add.o or
whatever, but I'd say that generally doesn't matter all that much, what
matters is that we don't miss dependency relationships.

Anyway, I'll try to loop around to fixing this, just wanted to gather
some interest in the more general set of fixes I've got. I've got some
fixes queued up after that that fix/improve the *.sp and *.s parts of
the line you quoted (and other similar lines). I'd prefer just to fix
this along with those so the two don't textually conflict.

1. https://lore.kernel.org/git/211110.86h7cki0uo.gmgdl@evledraar.gmail.com/
