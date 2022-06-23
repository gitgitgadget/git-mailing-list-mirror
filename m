Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAE1C433EF
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 00:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiFXAgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 20:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiFXAgO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 20:36:14 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F5A5DC25
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 17:36:12 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id t5so1559327eje.1
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 17:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=99yR2PgfXio4fPtUSFPDB8Q+KNPmBQiXaWvMnf2wtXs=;
        b=XyqenP8+mIvzyNQU0u6uiyUAtOpQZSndipfzhVVUIxqlSHCl8CoYGukwIfCrr0kI6W
         bvq336pxDRVuuvJzbg4xvtunGRQxNdLLgV5di4D95h0goxZFR6YF/ZaX1Dd7FYOnXjAx
         LQNRptCt3acxlpDDnS5O5aueEZ846ojcIDoQbeeqy230yQsc/JNLTaD1CD1INlc5IPak
         2YjnqgMHeH31xcO4IFPVtlTzlUmL5SVyug5PwI6EpL5z48o/D21QuP4KUr8q+a5Tqiy2
         InL6O7qZ9sV+Y8tQJ4FpQPyA3WA+s4vIoW1Mp2Kl4c349E182zWLYpvNf/+84KZpT/Ji
         sRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=99yR2PgfXio4fPtUSFPDB8Q+KNPmBQiXaWvMnf2wtXs=;
        b=ipFa52wKrwmi392ElMV4es9wiu3gpwhIQ/KXotezBPp3RAwN3hF5YJ6xHQyFzsxRwJ
         QE5AZXzV8dlbeBfcZXqWyKdgLbHplQr08h6nVL+AG0rlvumDeugwYyZHuVorWt49CvlU
         qqYTMwvmyEK+DBwNHIPN38LffQT4EC85UHLU6iyp/u8SnQ1eeiqDozWBZpm64rlpY3aI
         2otg1sUKx305IIPjE9YCNSFyVicx9YSqsx8S4EGb/sKz4kB0yqi4ltUCgSywGxEMzIyc
         NmfH3dv1PPEMXVsvAWDp42ZPLDJnDcIJpwLrMZ95Eg+uuAVVbhpwvl3q84vhpUOjT7/M
         A6Mg==
X-Gm-Message-State: AJIora8Xs10hi/XOcIOSF4L4GprapEWawzXHWLHBpZwRrG9lx+D56bIH
        5MYZG/R1/aR7dI6l+cm5xhw=
X-Google-Smtp-Source: AGRyM1vVHv2Grl7zo1ha+HC1aiTjkBTRhx7JzxjP+4J3IynPRd+gj3mfSLq9P8VLFD0MlGdocN3p0g==
X-Received: by 2002:a17:907:d19:b0:711:d10e:411 with SMTP id gn25-20020a1709070d1900b00711d10e0411mr10894920ejc.216.1656030970923;
        Thu, 23 Jun 2022 17:36:10 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id t18-20020a17090616d200b007262a09ad5fsm237060ejd.188.2022.06.23.17.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 17:36:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o4XIv-0017dU-BC;
        Fri, 24 Jun 2022 02:36:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] gitweb: fix "make" not including "gitweb"
 without NOOP run slowdowns
Date:   Fri, 24 Jun 2022 01:45:35 +0200
References: <220527.861qwf489s.gmgdl@evledraar.gmail.com>
        <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
        <xmqqa6ap8z55.fsf@gitster.g> <20220620083202.GB1689@szeder.dev>
        <YrFphmtLuHVkI7yr@coredump.intra.peff.net>
        <220622.86r13hkp2c.gmgdl@evledraar.gmail.com>
        <xmqq7d587lqx.fsf@gitster.g>
        <220623.865ykrll0j.gmgdl@evledraar.gmail.com>
        <xmqq7d57x8qo.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq7d57x8qo.fsf@gitster.g>
Message-ID: <220624.86bkuikidi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 23 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> We could easily add "cd .. && make gitweb" to gitweb/Makefile with
>>> the same "minor hassle" but that needs to be done just once, instead
>>> of having to be done once per packager, so I am not sure the above
>>> argues for a good tradeoff.
>>
>> True, but I think critically in this case we've never documented that
>> you should be running gitweb/Makefile directly. I.e. the gitweb/INSTALL
>> has always documented and assumed that you run these from the top-level.
>
> Well, I do not think Makefiles document much of their targets in
> general.  If its first/default target has a reasonable name, like
> "all", people expect "cd there && make all" would do the right
> thing.
>
> So I do not think "we never documented" is a good excuse.  What the
> current users have been doing and are expecting to keep working is
> what counts.  If they are used to see "cd gitweb && make" working,
> perhaps instead of giving an unfriendly $(error do not run) at the
> beginning of gitweb/Makefile that is designed to trigger only when
> they did that (instead of running 'make gitweb' from the top), it
> would be trivial to have the rule to "cd .. && $(MAKE) gitweb"
> there, no?

I can re-roll it with that change if you insist. It would close the door
on further unifying the two Makefiles in the future (well, we could keep
the wrapper in place).

I have a script I use to see how big the impact of this sort of thing
would be in practice, i.e. I download downstream package recipies, which
are found at (name, relative path & urls). I also manually get the AIX
package:
=09
	freebsd-ports   devel/git       https://github.com/freebsd/freebsd-ports.g=
it=20
	openbsd-ports   devel/git       https://github.com/openbsd/ports.git=20
	netbsd-pkgsrc   devel/git-base  https://github.com/NetBSD/pkgsrc.git=20
	dragonflybsd-dports     devel/git       https://github.com/DragonFlyBSD/DP=
orts.git=20
	fedora  .       https://src.fedoraproject.org/rpms/git=20
	debian  debian  https://repo.or.cz/git/debian.git=20
	gentoo  dev-vcs/git     https://github.com/gentoo/gentoo.git=20
	arch    git/trunk       https://github.com/archlinux/svntogit-packages.git=
=20
	nix     pkgs/applications/version-management/git-and-tools/git  https://gi=
thub.com/NixOS/nixpkgs.git=20
	alpine  main/git        https://github.com/alpinelinux/aports.git       ht=
tps://git.alpinelinux.org/aports=20
	git_osx_installer       .       https://github.com/timcharper/git_osx_inst=
aller.git=20
	homebrew-core   Formula/git.rb  https://github.com/Homebrew/homebrew-core.=
git=20
	macports-ports  devel/git       https://github.com/macports/macports-ports=
.git

Looking through all of those none of them do anything with
gitweb/Makefile. I.e. all "make gitweb" at the top-level, or simply rely
on "make install" to install it.

FreeBSD and NetBSD are monkeypatching our Makefile to emulate a "I don't
want gitweb please!", which they'll need to do before/after this series
(but we could helpfully provide them a config knob).

Anyway, if you want "make gitweb" and "make gitweb-install" in the
subdirectory to work I can patch it, but per the above I think it would
be useful to pretty much nobody.

I could use around the same amount of effort to give FreeBSD and NetBSD
a "don't install gitweb please" know instead, what do you think?:)
