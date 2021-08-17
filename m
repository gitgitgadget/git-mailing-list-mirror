Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC3BC4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 21:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B28360F11
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 21:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbhHQVhd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 17:37:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:55245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231630AbhHQVh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 17:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629236212;
        bh=xHSGRPkUaylFvoajk3ltZdT8Z7IB2lgLttuQOmWspm0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FK9QKy6D5aAHdas+he/GdCbv2q1HyEO5nlX1idDiE8kBhy3YEiBDprDZdCKL3ZiBA
         CqPQbTNxOCoZ8lcwy4BBnraJymDdx+K/TmhFVGCWEmatITGiiMO0o3Yjs4PQMZXPk9
         NoNjfKPytIygZIu/nNyteO9Bv/WG2UKTC5slgYXs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.229]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGz1V-1mLJPr0sYV-00E1cW; Tue, 17
 Aug 2021 23:36:52 +0200
Date:   Tue, 17 Aug 2021 23:36:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Miriam R." <mirucam@gmail.com>
cc:     git <git@vger.kernel.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 5/6] bisect--helper: reimplement `bisect_run` shell
 function in C
In-Reply-To: <CAN7CjDDEv6vGPKZo3sxz8bgfN2Nzqh0HChR-tGrjDGbkhKZo=A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108172332050.55@tvgsbejvaqbjf.bet>
References: <20210817081458.53136-1-mirucam@gmail.com> <20210817081458.53136-6-mirucam@gmail.com> <nycvar.QRO.7.76.6.2108171332370.55@tvgsbejvaqbjf.bet> <CAN7CjDDEv6vGPKZo3sxz8bgfN2Nzqh0HChR-tGrjDGbkhKZo=A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1345588739-1629236210=:55"
X-Provags-ID: V03:K1:SIER+SngnO2Mz2wTwGlEbRIdyfQ2KAMiJr0GMX/eOnagtScAfpQ
 hA1HdNQ1JKfK6wYrJqob1I0EZV9NAyxnKAgTz+fTzU7g2C00v1yV/ereU3BN+CqSQv+21v6
 djSS9wODEdK1uFiA2oGmzjFo9taWwtAvUOo2sLo+JdMjl0z2Vu3tHQ/cwtnIK4FvZgjWtaa
 S1Dr1OT2sxLV4vI9MZ+BA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MJkdPKu8iMY=:901/tY6NDUB/gvg5uvsKMB
 0RkNdSdbn3VWV9m5mUnL9bCi1bhmi7aU2c/P8G8juPGV5XPkSvvYCji1rJFmWIPbO1b+cr8bL
 lp1WXmS9hF6scQJlsp7Yq1s/mUgONPxbiVK0qCbCbfJIUOkXU0DGms6c4w7I8aZoxKt60T7Kf
 +oML0IKLpVhWVCZAZqYg4urzzm6jA9MeO46mSoet5rmToz02Y5cu3z/ycTtINZ6uYzpabWC7s
 QIE9tszEL0II5qDjK7Fq3Z9j67hpdEG1de7J9cOHW3tlqp8EhZ/iRkBapm5goTjOOs4DKrGyY
 EilT2BXL4FjzYjmKd+/sxrsFFd3HyEA4OS9Nn1yLcQSCrHlhf8LOOfPruLr1FxeXEC/EZt6bu
 LBILfLLm3HeJf3rjVbAbAAqfedPWIZoZnu/8zlTpL/8v6O09uwcD0Z/kHLCafA7dwQnxguCm1
 JPASJK8puAK9F7uzz43fz/gmJWUrX0KelpeFKlwCeX1s+hFHf4M3Dr9uR4HKWXVxalyqakYE/
 L/9bM0aBuaVoRcaxvfJQfuIlPst9VmH9X/rtUnKw66mp4qLODB5NIjaOpHFRjwnL/NkNTKqIc
 m/DmeKoxmHTZSiMO68cBtGieUXvzvTg0+9s/dlNuQHTcpGGj9yQ5VPxNvL7isu7LVdXaeGa62
 6nLMMXYYF7Hb05h2uuRX5y75EKyxORXzeUYK7b+IsXhXVloFMHbEkC/eVZtiPuYoJFy0deMY5
 lz3FfLn0wYLvyXa2rXrcOtRPp63RAi+4Ip/iPCeiMfDGwoARiOgT4Lmz1Bkr+aigWD5YIKJaC
 LHgqs7N12tx0gJUejuZLwQcn3hWus2YONuKQJshvTM22N0ZjXBkbq9XXBEDhZOIe1Bk8U0bWA
 X7KjhV8b/MsEcohy9ii0nvECKNwqkp/WGGHRsDdF1gjzarXAy+Tlc7dWJ4ydJPhyFegaCL42c
 zynhFgQbH7pf2fqrHXMCMwWjyEu+VhmOECvB3iVf2Ej4ELRvs0T6ziRK3vQMm9QkuJzqgdwhw
 xseg+5RnE0YcSob24/suxwkRp49RDFqOaWSxPkflOnhC8NRRlqCpqy84UEfopMCYCiRUtBORX
 lt7nW7yf4ardTD+P4XqJVWK2affzPzCWfRooRfelIgLHvLmzzPKteFKWw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1345588739-1629236210=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Miriam,

On Tue, 17 Aug 2021, Miriam R. wrote:

> El mar, 17 ago 2021 a las 13:42, Johannes Schindelin
> (<Johannes.Schindelin@gmx.de>) escribi=C3=B3:
> >
> > On Tue, 17 Aug 2021, Miriam Rubio wrote:
> >
> > > From: Tanushree Tumane <tanushreetumane@gmail.com>
> > >
> > > [...]
> > > +
> > > +             if (res =3D=3D 125)
> > > +                     strvec_push(&args, "skip");
> > > +             else if (res > 0)
> > > +                     strvec_push(&args, terms->term_bad);
> > > +             else
> > > +                     strvec_push(&args, terms->term_good);
> > > +
> > > +             res =3D bisect_state(terms, args.v, args.nr);
> >
> > Since `args.nr` will always be 1, it would probably be better to use
> > something like this:
> >
> >                 const char *new_state;
> >
> >                 [...]
> >                 if (res =3D=3D 125)
> >                         new_state =3D "skip";
> >                 else
> >                         new_state =3D res > 0 ?
> >                                 terms->term_bad : terms->term_good;
> >
> >                 res =3D bisect_state(terms, &new_state, 1);
> >
>
> Yes, indeed. I will change it.
>
> > Also: I think at this stage, an equivalent to `cat
> > "$GIT_DIR/BISECT_RUN"` is missing.
>
> In the previous patch series (v3), I implemented the equivalent to the
> cat command but I understood reviewers wanted to print the output to the
> user, so I reverted my changes for this version.
> https://lore.kernel.org/git/20210411095538.34129-4-mirucam@gmail.com/

I am a bit confused: doesn't `bisect_state()` write to the `BISECT_RUN`
file? If so, I think we do need to show the contents by opening the file
and piping it to `stdout`.

FWIW I read
https://lore.kernel.org/git/CAP8UFD3X24F3qgefHpi00PM-KUk+vcqxwy2Dbngbyj7ci=
avCVQ@mail.gmail.com/
to mean the same thing, although I have to admit that I am not 100%
certain.

Just to make sure: with this patch, at the end of a `git bisect` run, the
user is shown the commit message of the first bad commit?

Ciao,
Dscho

--8323328-1345588739-1629236210=:55--
