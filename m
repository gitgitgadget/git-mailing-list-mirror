Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1454C433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 16:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65DDA23A9A
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 16:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbhAVQz3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 11:55:29 -0500
Received: from mout.gmx.net ([212.227.17.20]:59025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729350AbhAVQOc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 11:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611331967;
        bh=vS51pObbCLKiD5wqpVeAt59asGiLYvdI1KCdJQih2g0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WwhiPMnut1JL8MVEkmcTOyFo1aLifX2j3kGSQX5Fy2jL2yuvi29xUnDI8C/Ey5hJm
         qOFAvUM32PdHWQqjGst1lB/qB2Dw+qb5O+zfESuIW5WswzESJrGQlvLyiugEAVEiOL
         3GpLqyA09dOjHGzxFdZcOFdwejRyTDY2blEtUilI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.115.203] ([89.1.213.153]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3KPq-1m1n8H1uGg-010Hd4; Fri, 22
 Jan 2021 17:12:47 +0100
Date:   Fri, 22 Jan 2021 17:12:49 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH 2/3] range-diff: handle commit ranges other than A..B
In-Reply-To: <CAPig+cTMqy=57hGksH6GaCB7i=eJHTCWVzwED=PPZF1hNp_1nQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2101221711140.52@tvgsbejvaqbjf.bet>
References: <pull.841.git.1611267638.gitgitgadget@gmail.com> <88c15617b4ba8ae3211b1a01861eb4165f3eda38.1611267638.git.gitgitgadget@gmail.com> <CAPig+cTMqy=57hGksH6GaCB7i=eJHTCWVzwED=PPZF1hNp_1nQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nbb/BDRBBAyALpLw9u39Vrmcb4yb7kkOqGzrpEe8/gEbNFSWebE
 E971dULKZoF5PhoUMzNUd1jihf5JU5YbyfaRcFG4UwkYBibYq7MPBY0A7bH9//Uul2Qg5BC
 CU6LDodbpA+F47w9e2YmCRPcX8q1wrfhtLhczAW/3FoJwSCvhydWnhnikQLPqXhaFOZuBgy
 KudYirlzlrrpF/hYRSCBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kg1SzlCFB2U=:6GTmP75BxRP5pDEel8q9M8
 BPwu9z7Qi/Tj8THZ7ARF8Kc0tkGZUDdS8YVjvsw6Q+9ChCHIQ7htnV/QXhYkGAMIHO0qC7hyK
 jxr0id4xm2LtI8gZwsoIZ+fU06YGyXLmRfOs2MmcmJ0aoQJ2pok/pRmhVUsXIE91s3uA9pzD7
 ZVXLqZjsUw7E+5ixfotliB0rVXi8rLEvlPFgVGCcTECn7SFHi6TL34WZ5PesPEYVCTPfnjpsS
 S7+zFtlIw/MXfZB96YB+Aotm64o/WDltKfVejEHA0rqCb2RtkFPJ8F7g1RD1nnfJrAIfUy9lO
 rAZvCE5Gza0WJIrOoGz+Z4eb+Jr6DLwdHceZcUyALOp73WN8kOiv4UMECcX7sL+pcUk3SaVFj
 4mqm7DY4re/K+q7RQ6KazPGTUg0ShxYgssicP6RQSM5nrf8a6HDQjWsHOwxV2L6m+LohPZCjy
 mKTBHQxdU36KemXtJyvAfzzGDd413tYFLmjaoDWEPJtrNnEBgQuWyXVDH/jOAnHSb/1cURSyM
 tY8LBUc9khpNVIYHq4sohrJWSdpa0C3fzOZfayLlMAdLngMpQLVFZYrQKmn4Zg8W5Rf2ucFrQ
 A2gqeeVsWziehSsL14n0bhc4I6Fb7EVepxEYTp/wgByeNBrpnC2uaj4su+2S1d1GotjXURkY1
 C/eIP8ErueYkeg/6fBDUqv4ztpcwXt4UtA0EiUg4tMzqUFB2+Dr8aundUaPS1lgWP+Y3g/i9O
 u1AAQKejUYdqiDy/Oqzn1j+ZPej47r3TvM8C7zfK0PNbkhECpIswGJjb696abrgN/sytU4nst
 B8y7NvOJ2g4pVXOAe2/as+gpfDleA5ppaSlPNoxH4v6saVD4hiW7S0AIzNiLrL1L4jbhZS7Mm
 E476ZMQBCk84KqQ78K/SgHygfF/ZQY0/7FAOPKclo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Thu, 21 Jan 2021, Eric Sunshine wrote:

> On Thu, Jan 21, 2021 at 5:22 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > In the `SPECIFYING RANGES` section of gitrevisions[7], two ways are
> > described to specify commit ranges that `range-diff` does not yet
> > accept: "<commit>^!" and "<commit>^-<n>".
> >
> > Let's accept them.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> > @@ -13,7 +13,26 @@ NULL
> >  static int is_range(const char *range)
> >  {
> > +       if (strstr(range, ".."))
> > +               return 1;
> > +
> > +       i =3D strlen(range);
> > +       c =3D i ? range[--i] : 0;
> > +       if (c =3D=3D '!')
> > +               i--; /* might be ...^! or ...^@ */
> > +       else if (isdigit(c)) {
> > +               /* handle ...^-<n> */
> > +               while (i > 2 && isdigit(range[--i]))
> > +                       ; /* keep trimming trailing digits */
> > +               if (i < 2 || range[i--] !=3D '-')
> > +                       return 0;
> > +       } else
> > +               return 0;
> > +
> > +       return i > 0 && range[i] =3D=3D '^';
> >  }
>
> Is this something that the --range-diff option of git-format-patch
> will want to do, as well?

Thank you for pointing that out. I should have checked via `git grep
'strstr.*"\.\."'` myself. There are two more instances, one in
`rev-parse.c` and the other in `revision.c`, but both are necessary as-are
because their return value is actually used to further disect a `..`-style
commit range.

Thanks,
Dscho

> At present, builtin/log.c:infer_range_diff_ranges() detects a range only
> by checking for "..", much like this function did before this patch. If
> so, perhaps this function can be part of the public range-diff API (or,
> indeed, part of some other more general API if it's not really specific
> to range-diff).
