Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E5DC433F5
	for <git@archiver.kernel.org>; Sat,  5 Feb 2022 12:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243979AbiBEMSo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Feb 2022 07:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbiBEMSo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Feb 2022 07:18:44 -0500
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [IPv6:2a01:e0c:1:1599::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48ADC061346
        for <git@vger.kernel.org>; Sat,  5 Feb 2022 04:18:42 -0800 (PST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:636f:39d5:1d6e:7381])
        (Authenticated sender: jn.avila@free.fr)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id BE90313F861;
        Sat,  5 Feb 2022 13:18:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1644063520;
        bh=cyL2PdAuH6EXuDte9KGM/E53uC5MLMUqJ2taE136Hvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DDgRj13pkjbcs7wvgfz4noAToxEQVfs/ON2c1F2QiYUR4VeqAxrTb7G0xLOGQWyf6
         vmuMsVIprtGIOj2QeN4qzVNiei1jOCieGB/mXf1uwnXN8Sh+pBTtRiQBAnE2P5a2aR
         DmYvRQoU5yPUga4qoRti4C9wFVPYcV3iv9Z72mu2H3hgLiIm0PJb+r5wBbbfAvi7KV
         ut+jaiYifH3x4WDwRrYfuwLjhqphJr4ZVPkublyai2HZx1GnDjgtKko4Sc1Pi5TEDM
         Tg6JsCrjbRZ9VrGPP9XxQrcZYDWpXH8nqXbfWOWe3FCTyuGQEusn4J4L1515Pctdjz
         CyL7zSonasgOQ==
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: ja/i18n-common-messages
Date:   Sat, 05 Feb 2022 13:18:37 +0100
Message-ID: <7408402.9NgVXbFLuH@cayenne>
In-Reply-To: <xmqq5ypuo9it.fsf@gitster.g>
References: <xmqqr18jnr2t.fsf@gitster.g> <220204.86iltu3jbm.gmgdl@evledraar.gmail.com> <xmqq5ypuo9it.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, 4 February 2022 17:56:42 CET Junio C Hamano wrote:
> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>=20
> > On Thu, Feb 03 2022, Junio C Hamano wrote:
> >
> >> * ja/i18n-common-messages (2022-01-31) 5 commits
> >>  - i18n: fix some misformated placeholders in command synopsis
> >>  - i18n: remove from i18n strings that do not hold translatable parts
> >>  - i18n: factorize "invalid value" messages
> >>  - SQUASH???
> >>  - i18n: factorize more 'incompatible options' messages
> >>
> >>  Unify more messages to help l10n.
> >>
> >>  Will merge to 'next' after squashing the fix-up in.
> >>  source: <pull.1123.v4.git.1643666870.gitgitgadget@gmail.com>
> >
> > I had a comment on the API direction in parse-options.c, which I think
> > should be done differently, but I also think it would be fine to just
> > change it up later:
> >
> > https://lore.kernel.org/git/220201.86a6fa9tmr.gmgdl@evledraar.gmail.com/
> >
> > I replied to v2 instead of v4 due to some (now fixed) mail delays at the
> > time, but that comment still applies to the latest version.
>=20
> I do not think the change at the parse-options level would mix well
> with what this topic wants to do.  Large parts of the code this
> series touches will have to be rewritten once again.
>=20
> It will open us to new complaints we would not hear with this series
> from users who first say "git cmd -a -b -c", get stopped with "a and
> b are incompatible", then say "git cmd -a -c", get stopped again
> with "a and c are incompatible", and utter "well you could have told
> me upfront that these three are not to be used together" in
> frustration.
>=20

Bad news: this implementation is already crippled. For instance, calling `g=
it=20
commit --fixup -m -c` would first bring up:
"options '-c' and '--fixup' cannot be used together"
Then remove --fixup and you get
"options '-m' and '-c' cannot be used together"

This is because (according to the code, I don't know if it's really what's=
=20
wanted) the real logic is=20
Exclusive ("-C", "-c", "-F", Or("--fixup", "-m"))

This is a lot more complex than what can be achieved with simple tests.=20
Designing a generic facility for this is quite an endeavour and the message=
s=20
to guide the user precisely may need to be built with sentence lego, defeat=
ing=20
the initial purpose of this series about localization.

> I do not mind waiting for a few days to see what Jean-No=EBl would
> say, but my take on this is that between starting from the current
> code base and from the state after applying this series, there will
> not be much difference in amount of the effort necessary to extend
> CMDMODE to mark and detect combinations of incompatible options at
> parse-options level. So I am inclined to merge this series down.
>=20

After this series,=20
 * the messages are more precise, except in few edge cases
 * they can be localized and we can get new messages for free
 * the code is marginally easier to read

While reformatting the code, a striking observation was that now that the=20
option strings are extracted from the localizable parts, they are repeated =
all=20
around the code, and this begs for another factorization, to make it dry.

A new proposed framework would enhance greatly this third point, and I'm al=
l=20
for it to happen, as long as it does not regress on the first two points. I=
n=20
the mean time, this patch is the best I can propose.




