Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C1FC43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 09:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbiFVJrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 05:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiFVJrL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 05:47:11 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A2A186C0
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 02:47:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id t5so488132eje.1
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 02:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=bX1X40WNUpWq7J23upRwMNO/TGRNA5dh2gZVbGQWx7c=;
        b=bTtb6M4cb4YO5fdyC4v8pYl0Qu4cNvwQ1GaG3ju8vT6vi/c0x1/VFPI0oUvfiNDeOP
         6Si7jkjZU0my5pz+jxem5MF1wKmZhDN1sTK1tTE6PrjAM9LEbFGFIsmcomfgNM3K8gUQ
         SWolJq5ywvzyehM7kcLXbjBL9tmbV6K2pjQpQ6bQDaWN5HLgg/WQgaQqEUdbVlCZoIqd
         i9DtDwN1R81RR2VHkTUzKWR0kbQOsdS3m7hYGnHudSgrYo1eOdPCU2OChWabKkpu6GDt
         RaoYBbIuK5b6Ni8lx8OFofymLbFPzTVTbdJB98IQK7wmOu8JaCcnMDLFL8ATUwOngae4
         PsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=bX1X40WNUpWq7J23upRwMNO/TGRNA5dh2gZVbGQWx7c=;
        b=DG1nTBzuY8OFxE1gqv1ATAI8WAGk3X7E3lAct3nwvcpkH9kJeWQivV+HzA20Pc3eO0
         pesvvudEkalcJGjn2ROtkVpCcNixDyEbfxBhDJB04m4YrzXyCGUOgYjU+9v629kUyQyX
         x8WXCN6PGiJd3RRcR/JuKAhxeYRLUnOkxKxgR7FfypESsLjURJzF7Ncnu8EG8N2MZg/I
         6KZoIaEtdseYmLA4AXcxIZxykafYkawLYNro/QvM9rN+XGtPTx1TC3tZCkBQ7RO2PsFV
         tTZ2tH1Fpxgkt2nvTc98Vy5pJWec5/O0Lc19f5R1DTutOaMQAhZcPRuNcZSRVliAiiGB
         725w==
X-Gm-Message-State: AJIora/ScE9u0B4Tbm1FjPJaT9bi5i/o0IcnxCWKaNHBQ6oOC5hZ3b0c
        r3PiIs+Y92NzXh33dJUeQzg=
X-Google-Smtp-Source: AGRyM1uD1xx2+hO+cnMnjUBeRN7Sya4quMql1CADuWFrsO73ZoSr3YffcPZxLT1ZzMBnRVRahyQOtA==
X-Received: by 2002:a17:907:161e:b0:722:dcf0:2a0 with SMTP id hb30-20020a170907161e00b00722dcf002a0mr2164424ejc.694.1655891229099;
        Wed, 22 Jun 2022 02:47:09 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b0070abf371274sm8894370ejg.136.2022.06.22.02.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 02:47:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o3wx1-000dou-N3;
        Wed, 22 Jun 2022 11:47:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] gitweb: fix "make" not including "gitweb"
 without NOOP run slowdowns
Date:   Wed, 22 Jun 2022 11:27:54 +0200
References: <220527.861qwf489s.gmgdl@evledraar.gmail.com>
        <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
        <xmqqa6ap8z55.fsf@gitster.g> <20220620083202.GB1689@szeder.dev>
        <YrFphmtLuHVkI7yr@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YrFphmtLuHVkI7yr@coredump.intra.peff.net>
Message-ID: <220622.86r13hkp2c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 21 2022, Jeff King wrote:

> On Mon, Jun 20, 2022 at 10:32:02AM +0200, SZEDER G=C3=A1bor wrote:
>
>> On Mon, Jun 06, 2022 at 10:44:54AM -0700, Junio C Hamano wrote:
>> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>> >=20
>> > > The $subject is a proposed re-roll of SZEDER's
>> > > https://lore.kernel.org/git/20220525205651.825669-1-szeder.dev@gmail=
.com;
>> > > As noted downthread of that fix having the Makefile invoke "make -C
>> > > gitweb" again would slow us down on NOOP runs by quite a bit.
>> >=20
>> > It would be nice to hear comments SZEDER and others, even if the
>> > comments are clear negative or positive.
>>=20
>> Well, my itch is scratched, so I'm fine with it :)
>>=20
>> I think Peff has a point by questioning whether we should build and
>> install gitweb by default...  I don't have an opinion about that, but
>> if we do want to build it by default, then IMO doing it in the main
>> Makefile is the way to go, so I think in that case this patch series
>> goes in the right direction.
>
> I hadn't realized the full situation when I was arguing earlier that "we
> have not been building it for several years". You raised the point that
> we do auto-build it in "make install", so it would be a change of
> behavior to stop doing so.
>
> I still find it hard to care too much about backwards compatibility for
> building gitweb (or really gitweb at all, for that matter). But my main
> complaint was foisting another recursive Makefile and its performance
> and troubles on developers at large, and I think =C3=86var's patches deal
> with it. So I'm OK with the direction.
>
> I admit I didn't look _too_ closely at them, but they overall seemed
> sensible to me. Two things I noted:
>
>   - I wondered if "make NO_PERL=3D1" would complain about "gitweb" being
>     in the default targets. It doesn't, but it does actually build
>     gitweb, which seems a little weird. I don't think we actually rely
>     on perl during the build (e.g., no "perl -c" checks or anything),
>     and the t950x tests seem to respect NO_PERL and avoid running the
>     generated file. So maybe it's OK?

I think it's arguably a bug, but as you note we build/test etc. without
errors, and I think it's restoring the state before e25c7cc146
(Makefile: drop dependency between git-instaweb and gitweb, 2015-05-29).

Arguably we should replace with a stub script like git-svn et al, and
arguably we should leave it, as you're more likely to e.g. run gitweb on
a webserver, so even if you build a "no perl" package, perhaps it's
convenient to have "gitweb" part of it, and then on that one box that
runs it you'll install perl...

>   - Speaking of backwards compatibility: after this series, "cd gitweb
>     && make" yields an error. It's got a nice message telling you what
>     to do, but it's likely breaking distro scripts. Again, I'm not sure
>     I care, but if the point of the exercise was to avoid breaking
>     things, well...

I think that's OK, having maintained those sorts of build scripts in a
past life.

I.e. when you upgrade the package it's a minor hassle, and the error
tells you exactly what to do, and the fix is a 2-3 lines in your recipe
at most.

I could make gitweb/Makefile "fake it", but as argued in the patches I
think this trade-off makes more sense. Having it run in some "dual mode"
would be a maintenance hassle.

Most of the reason for keeping gitweb/Makefile around (as opposed to the
top-level Makefile absorbing it) was to be able to emit that message to
be friendly to downstream packagers.
