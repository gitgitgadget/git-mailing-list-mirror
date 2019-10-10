Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 185641F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 08:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389831AbfJJIte (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 04:49:34 -0400
Received: from smtp.soverin.net ([159.69.232.138]:36201 "EHLO smtp.soverin.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389821AbfJJItb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 04:49:31 -0400
Received: from soverin.net by soverin.net
From:   Toon Claes <toon@iotcl.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Zeger-Jan van de Weg <git@zjvandeweg.nl>
Subject: Re: [PATCH 1/1] commit: add support to provide --coauthor
References: <20191008074935.10972-1-toon@iotcl.com>
        <20191009014039.GA10802@szeder.dev>
        <xmqqr23mlkxo.fsf@gitster-ct.c.googlers.com>
        <20191009203105.GA7007@sigill.intra.peff.net>
Date:   Thu, 10 Oct 2019 10:49:23 +0200
In-Reply-To: <20191009203105.GA7007@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 9 Oct 2019 16:31:06 -0400")
Message-ID: <87sgo1q92k.fsf@iotcl.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.101.4 at c03mi01
X-Virus-Status: Clean
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> writes:=20
=20
> Yeah, I'd agree that we should start first with a generic=20
> trailer line.

IIUC you are suggesting something like this?

  git commit --trailer=3D"Co-authored-by: <coauthor>"

I really want to consider this, but I do not understand how that=20
improves the user experience compared to adding that trailer=20
manually when typing the commit message in your $EDITOR?

> There might be some advantage to building trailer-specific=20
> intelligence on top of that (for instance, it would be nice for=20
> coauthor trailers to expand names the way --author does). But=20
> that can come after, and might not even be in the form of=20
> specific command-line options. E.g., if the coauthor trailer=20
> could be marked in config as "this is an ident", then we we=20
> would know to expand it. And the same could apply to acked,=20
> reported, etc.

Wouldn't making it a generic --trailer option make this more=20
complex? I can image users might even want to use the --trailer=20
argument to indicate which issue the commit closes:

  git commit --trailer=3D"Closes: $BUGNUMBER"

So, how can we make the config understand it has to expand=20
Co-authored-by and not Closes?

Maybe, because I was looking at=20
https://git.wiki.kernel.org/index.php/CommitMessageConventions#Trailers,
it will probably be safe to expand a name when a '-by' suffix is=20
used.

With this pattern in place there is a slight improvement compared=20
to typing the trailer in your $EDITOR, because the user can pass=20
=2D-trailer=3D"Anything-by: name" and the trailer is expanded to=20
`Anything-by: name <name@example.com>".

But I'd like to note another thing, and let me circle back to=20
SZEDER G=C3=A1bor's reply:

> I wonder how we are supposed to use this trailer in the Git=20
> project, in particular in combination with Signed-off-by.=20
> Should all (co)authors sign off as well?  Or will Co-authored-by=20
> imply Signed-off-by?

For this purpose I think it's useful git understands what=20
"Co-authored-by" means, so when you run:=20

  git commit -s --coauthor=3D<coauthor>

The following trailer will be added:

  Co-authored-by: <coauthor>
  Signed-off-by: <author>
  Signed-off-by: <coauthor>

So I'm still pro of adding a --co-author option, but I do=20
understand the concerns to avoid adding an option for all the=20
possible trailers found in the link above.

=2D-=20
Toon

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqpqkV/lEuXKD1KF3MRQ6gtMrOJcFAl2e8JMACgkQMRQ6gtMr
OJf5Tg//ZVf+68+w/FGOo2Kw5bxEEpddWSoJexleRXus7+Kyo/IoudqSK0b9Dghi
wipOulOeKv/8zfxGroXFiQb/BKL6U5yR/MDKE7ykwzo58Nxa02Y41i2U1qwVlkDa
uqAg/8Z6vbQCxWwul8eGBkHmzoVK4F3n2LB3xhaOavgeABdy4pxtvXAHGyBVNZBk
hdF+AvOas2xSGWnnvDpy2dFdBz2pUrta5FxKk0Hdge7S0GcL41MPaKiT4xfnzcco
Ti43GDLE6byWhfLsM/28tMSbUrvVCYqlNLMRt3Tv6zP1+/Dh8RbGh2iwuB7sJTvX
uSoKMZ7DVNoqt/93Np6vg8w1Nty7lHW6k6ia9hwDurgcbdyGE4JrtTi3M77F7Nvz
KBiQwtYWAnkY4/7i8E2Rq55n9f3i1dQWoN7VxHPgd2AbIq6M9H9W1kz+2Tj/U1Tm
Z+ZpWHcs/XWc28VfnKUlS5aitobY7pkQOubPHAViWwIZ/5ukwHHbCNolqtfa1VMS
8ZPsbGdBnYllAyOkge22k2JoR/+stdXiQforhrcx6xwa9PnLdEtX4RTKqqmxgCmB
oQc/L/Hg+d5H3OiO4eawUbqpghMYe5M0J/5G58thB9/WjUQe7p1WWkFtMKiRcI9q
CKVFy8P/Gi6XblFsjbecKE9Yk896S8HxGr7kMSVFCOAJMvdRfrQ=
=I0o/
-----END PGP SIGNATURE-----
--=-=-=--
