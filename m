Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9842C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D8560FA0
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239779AbhIMLjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 07:39:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:52781 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239904AbhIMLjT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 07:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631533070;
        bh=Wcumie09TanHnQHIpYHGRpdQg7BOH11cglZs6Kuxdhg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ckfjMAZ81b305uXuH5JvhkTXfSgxSReXo+ZBBi96t4wpPQuaVD9sZvLlSfWS1nOTC
         8TRWNk1fZaygSovduHEZhdYjUSPgOos77hfhnPWnX7P6v1LYdrxghJo+oCon86WOp8
         JDnJyRRDmIH8hDjaUGGIlEYDeN6jUKqfytbfRfAk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.116.95] ([89.1.214.165]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5vW-1mczqY2YWO-00M0GG; Mon, 13
 Sep 2021 13:37:50 +0200
Date:   Mon, 13 Sep 2021 13:37:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] merge-recursive: use fspathcmp() in path_hashmap_cmp()
In-Reply-To: <8bd13e99-208b-4c22-90e6-28227593e9c4@web.de>
Message-ID: <nycvar.QRO.7.76.6.2109131335260.55@tvgsbejvaqbjf.bet>
References: <512abaef-d71c-9308-6a62-f37b4de69e60@web.de> <YSvsQcGNpCMZwS8o@nand.local> <xmqqeeaa6fey.fsf@gitster.g> <8d2e0876-9441-9665-ebb1-8cb28902014b@web.de> <YS1EVq2Gz+sPhw3c@coredump.intra.peff.net> <8bd13e99-208b-4c22-90e6-28227593e9c4@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1316402531-1631533070=:55"
X-Provags-ID: V03:K1:OCXDDWRrADAq1J+e/146TMl26XEzOokvfsyqxCFixLqdF/jxG80
 B5dudYhDJI1KTZxMo6loMKGwZeKXzlw6+sbeSy/r3aLSZpx+6zbMVF63rgoNRVoEc6tgZ9b
 SGWN6WT55N39wScOW+yW0Vh+2LpPj1dz3/zXM9m1Qt/DuvTpkQ1IcyxUzg+2f9a/Jjmxj9e
 vbBDkKkYKseR8ShmxdFAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6NaMyW+PmT8=:C2XXgmb3gZ3gl6KXFr0Emr
 0VEbKYa8HrPEFZPxw/NIKDS74lHCAs3ztybOh7/5LKMXJe3Lr1qSDf9a2EWOB1/Fyf2UrMGGl
 3BJF106mVvMP7DlDnXbqTTy9HOABrNQbMOCLi0Tnf//qU7q9yN6JA5UQiczzlTUB6QTDCfJvQ
 V9ZaKdqAWq5kIVr6d5yeZQ+EsjWbwPbqwSlSa+ltlcpODRaJL6LW0j99Djs4+2/j8jTzLGz0o
 cSu54zyNv5wMGqZpBa/K0BtrN99wO5R9/33MrBuhFU73hyfZoRbHbQbor7X0AqNUADvQnWEvG
 4B/LGQhlCUurenVQp3EKmDlgeF2wM2OJDhpXa1B/65W/qSmjUPgMe42G7/Nci3WnlQWsD36pu
 hzccKxQb1Cj3zKwiZvlVekYO/C6H/SQ0iBMQGEclsHEyy7WWw8Z/YcgUd0ljkr5FalL7bL74T
 Q636LMo41pWPErd9ZB7csyNfxNYIrQd9H+rTC0+1yOZliwCCxjHM8GsjZOyPP8YlIVd8UKdXL
 shdSCi9P9cDWbNdXQv+utleZFi/9KuyNl4IMeQU+se2kfkIUuoWv2amXFzlmdEe2uRFWSHvLX
 6rJ4vZnglRhSf8qRKLfaq7W6prAOJUAejYvFDSV1Z0py27Sb0ctvwNPrn8772X8dzudaCHF9e
 QvlDtXLxfRvfkajMW50MnDJbkH095uzi7LcOmzxwLSDOWxhcqY2H/4qd4HFhjMYX0otMXTUcF
 w8qrImCrIAbXwlkf3ccKoMvCFqD7tRASA9bniDvLkVBcL7BQeu8ludoBTg9b2qfpXCzgDn6Gy
 kpkiN8LX+70mF7Ycc95/cZqmaPbnNezCWKCbS2K7+/PrtqfH3DjTz2EifTMcQvcokEDs3wuBg
 C9g3TASxqwu8qu+iuvDuX3apV0EoR4ycmNCUkUtel6+M40bUmgwf3U49XpD9i/K7xOH8nCbdX
 Q1F7TVMaVLQXxNTELhTk8Y/wGv/fuT9QApWixMYWDU43o0pVtWTDbJST+H/dfxTRgDTybKLsO
 5Egc/10Pu5ZpTUZTjwJM1lf5UUYWN5Rszz4IPYdu21AZKIAREel4WJWGzxFK3S5cgf6mprxyO
 Tb+JGgcau5K7pE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1316402531-1631533070=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Sat, 11 Sep 2021, Ren=C3=A9 Scharfe wrote:

> Am 30.08.21 um 22:49 schrieb Jeff King:
> > On Mon, Aug 30, 2021 at 08:22:25PM +0200, Ren=C3=A9 Scharfe wrote:
> >
> >>> It however may not be a bad idea to catch these code paths where a
> >>> local variable masks 'ignore_case' (and possibly other globals) and
> >>> rename these local ones to avoid a mistake like this.
> >>
> >> The name itself is OK, I think, but using it at global scope is
> >> confusing.  -Wshadow can help find such cases, but not this one, as
> >> test-hashmap.c doesn't include the global declaration.  Moving the
> >> global into a struct to provide a poor man's namespace would fix this
> >> for all namesakes, assisted by the compiler.  We'd then access it as
> >> the_config.ignore_case or even the_config.core.ignore_case.
> >>
> >> Moving all config-related variables would be quite noisy, I guess,
> >> and probably conflict with lots of in-flight patches, but might be
> >> worth it.
> >
> > Really most of these ought to be in the repository struct anyway, I
> > would think. The value of ignore_case comes from core.ignorecase, whic=
h
> > is going to be repository-specific. We are probably doing the wrong
> > thing already by looking at the parent core.ignorecase value when
> > operating in an in-process submodule, but nobody noticed because it's
> > quite unlikely for a submodule to have a different setting than the
> > parent.
>
> Good point.  So fspathcmp() and friends would need a repo parameter. :-|

Yes, we will eventually have to pass `struct repository *r` into a _lot_
of call chains. It'll be a disruptive change, yet if the submodule folks
truly want to aim for in-process recursive treatment of submodules, there
is no alternative.

FWIW on Windows there are other potentially repository-specific settings
that are relevant in similar situations. For example, there is
`core.symlinks`.

Ciao,
Dscho

--8323328-1316402531-1631533070=:55--
