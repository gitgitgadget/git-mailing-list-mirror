Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46E9C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 09:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA23A60FEF
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 09:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhDZJFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 05:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbhDZJFg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 05:05:36 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C874C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 02:04:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id t4so6682ejo.0
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 02:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=PbkycNUPx2oaG4Sd57dI7ud19q5DKdWp8mW1DzbrLuM=;
        b=LXm46WlWDt8gbMzRYnJ1GlaZ0Gp/tTL6r6fJ3oELjqyifQDHtka9NrrfPZsjgexHzh
         +suSVYFVKbivBCNo8d07gkZW7cCd8XZ+Z0E9tCfoaFd9cu8lRs2Cg/FrPXDuD9DOXZH3
         ls1JY6skjRuCdqzy//F6ydroUY52UKSbFSIToG+yj7KzS19ghJXpkSsnR13xn7chPIjp
         RFk7gzdq8/XaSFHw1FOIpn/LTAJhaqdeIrlE+oVSVCdIdagaHhWR0jaS+KPDwB2G1Bxs
         E+coAZH4rLmA78OmiZvlNIMnvOYsn8vsA3p+PaBu0aPYetq2UuGQzZVIlqPQC07NEgiY
         nMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=PbkycNUPx2oaG4Sd57dI7ud19q5DKdWp8mW1DzbrLuM=;
        b=FNB0ZZfsrnDaB/2/9sqZsgQd9NakRpnOoMbFWJk/LpjPGoZtUL/WoFcAFnrNLjl9iI
         kuKscVLzAuZQySidFRdaxigl1sH6DjRyRsy+fVTjVIQ0gs85vUyCAOhnKFHvMZspPUaK
         i0ZBX+bB4CLBjjMGjvjQyGdu1DtN/FhSK/UlexQ1cO0TP800MbYw+tQHIGdbqcRlTyyL
         ZKaAa1ECOhE6koAX13LP0p/opT6puY+Viiql9w1jzKd7UOKT+e7cmL8TuFlcmZ3OxYSx
         CV2pFNUUOX+X8Q1UQSxJfQljwlnmHrT7AvlFz5rcuytF4634IfQxB2lGoK+mhZiCU/ii
         X1HA==
X-Gm-Message-State: AOAM532JOdIKF8N4DedrXQ2V+jh68J2VoP4NES1+AUc4DO3W46Yn1ge+
        sAVQ4PKMzF4pfJtNHXFIcKvOW7wJJ+zBFg==
X-Google-Smtp-Source: ABdhPJyzDIQZjtaUclD4XL0TWgy4QR8QyMdtoumy1EwMw1f/iMBq8a1RXm1mVE+gI+ZqHdxM1NTlrg==
X-Received: by 2002:a17:906:3c1b:: with SMTP id h27mr18110244ejg.182.1619427892615;
        Mon, 26 Apr 2021 02:04:52 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w13sm13361070edc.81.2021.04.26.02.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 02:04:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Yuri <yuri@rawbw.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [feature suggestion] Improve stash descriptions
Date:   Mon, 26 Apr 2021 11:00:57 +0200
References: <ff84d047-c0ae-86d1-c210-b2b777fd8184@rawbw.com>
 <YIWkHBfb4g68Oxr3@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YIWkHBfb4g68Oxr3@camp.crustytoothpaste.net>
Message-ID: <87r1ix4dsc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 25 2021, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2021-04-23 at 21:16:38, Yuri wrote:
>> My current stash looks like this:
>>=20
>> $ git stash list
>> stash@{0}: WIP on main: 12c63aaa3b13 www/yt-dlp: Update 2021.04.11 ->
>> 2021.04.22 Reported by: portscout
>> stash@{1}: WIP on main: 140f08246898 devel/py-PeachPy: Update g20180225 =
->
>> 0.0.1
>> stash@{2}: WIP on main: d42e82e4a336 security/hs-cryptol: Update 2.10.0 =
->
>> 2.11.0
>> stash@{3}: WIP on main: 62851ab415cd dns/subfinder: Update 2.4.6 -> 2.4.7
>> stash@{4}: WIP on main: 4eec712dfdae math/gretl: Correct PKGNAME to be
>> 2021a, not 2021.a to reflect how Gretl is versioned.
>> stash@{5}: WIP on main: 725e4e9a07f0 devel/py-fypp: Update 3.0 -> 3.1
>> stash@{6}: WIP on main: 200eb286c368 misc/py-orange3-educational: Update
>> 0.1.8 -> 0.4.0
>> stash@{7}: WIP on main: 364ab57861e2 misc/urh: Update 2.9.1 -> 2.9.2
>> stash@{8}: WIP on main: 52c6d02708d0 science/py-nilearn: Update 0.7.0 ->
>> 0.7.1
>> stash@{9}: WIP on main: a9d5d9e05bbf New port: biology/seqkit:
>> Cross-platform and ultrafast toolkit for FASTA/Q file manipulation
>> stash@{10}: WIP on main: ffa307fb4dc3 games/iqpuzzle: Update 1.2.2 -> 1.=
2.3
>> stash@{11}: WIP on main: 195f2e27fd72 math/py-libpoly: Update 0.1.8 -> 0=
.1.9
>> stash@{12}: WIP on main: 4c2cc95952a6 graphics/mesa-devel: update to
>> 21.0.b.4390
>> stash@{13}: WIP on main: 4c2cc95952a6 graphics/mesa-devel: update to
>> 21.0.b.4390
>> stash@{14}: On main: audio/tuxguitar -- .
>> stash@{15}: On main: math/[py-]python-igraph
>>=20
>> None of the above descriptions are relevant to actual items, for example:
>>=20
>> $ git stash show stash@{2}
>> =C2=A0devel/google-perftools/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0devel/google-perftools/distinfo=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++---
>> =C2=A0devel/google-perftools/files/patch-Makefile.am=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
>> =C2=A0devel/google-perftools/files/patch-src_stacktrace.cc | 11 ++++++++=
+++
>> =C2=A0devel/google-perftools/pkg-plist=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 12 ++++++------
>> =C2=A05 files changed, 23 insertions(+), 12 deletions(-)
>>=20
>> - description mentions cryptol but actual items are related to perftools.
>
> Right.  The format here is "WIP on BRANCH: REVISION DESCRIPTION", where
> REVISION and DESCRIPTION correspond to the latest commit on the branch.
>
> I agree that in many situations this is an unhelpful message, which is
> why git stash push takes a --message argument so you can specify a
> different message.  That, of course, does require that you use it, and
> I will admit that even I don't always do that, sometimes much to the
> dismay of later me.
>
>> In case all changes are grouped in one ditectory, like in my case, git
>> should append this directory name to description:
>>=20
>> > stash@{2}: WIP on main: d42e82e4a336 security/hs-cryptol: Update 2.10.=
0 ->
>> 2.11.0, all changes are in devel/google-perftools
>>=20
>>=20
>> In many cases it is possible to do so.
>>=20
>> In case many directories are affected it could say "changes are in
>> path1/dir1, path2/dir2, etc."
>
> This is unfortunately not going to be very efficient to compute in
> certain cases, such as with large working trees where there are many
> changes.  So while it would improve the automated stash message, it
> might also make stashing much slower on large repositories.

Just to add to this, there's already:

    git stash list [--stat|--numstat|--shortstat]

It seems to me that what's being requested here is not so much a
stash-specific feature, but some abbreviated "human readable" stat
format that could be used with any log-like command.
