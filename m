Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3CF020A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 16:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbeLNQtF (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 11:49:05 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:54358 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729612AbeLNQtF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 11:49:05 -0500
Received: from pomiot (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id E1F9D335C5D;
        Fri, 14 Dec 2018 16:49:02 +0000 (UTC)
Message-ID: <1544806139.7371.1.camel@gentoo.org>
Subject: Re: [PATCH 0/4] Expose gpgsig in pretty-print
From:   =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To:     John Passaro <john.a.passaro@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Alexey Shumkin <alex.crezoff@gmail.com>,
        Jeff King <peff@peff.net>
Date:   Fri, 14 Dec 2018 17:48:59 +0100
In-Reply-To: <CAJdN7KjExd6T+H4-wEupO2dg_mMWzeA22oYaskkfhz+GuFbfRQ@mail.gmail.com>
References: <20181213212256.48122-1-john.a.passaro@gmail.com>
         <1544760713.970.1.camel@gentoo.org>
         <CAJdN7KjExd6T+H4-wEupO2dg_mMWzeA22oYaskkfhz+GuFbfRQ@mail.gmail.com>
Organization: Gentoo
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-MI/XRT9s0W5dvSHipSQ1"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-MI/XRT9s0W5dvSHipSQ1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-12-14 at 11:07 -0500, John Passaro wrote:
> On Thu, Dec 13, 2018 at 11:12 PM Micha=C5=82 G=C3=B3rny <mgorny@gentoo.or=
g> wrote:
> >=20
> > On Thu, 2018-12-13 at 16:22 -0500, John Passaro wrote:
> > > Currently, users who do not have GPG installed have no way to discern
> > > signed from unsigned commits without examining raw commit data. I
> > > propose two new pretty-print placeholders to expose this information:
> > >=20
> > > %GR: full ("R"aw) contents of gpgsig header
> > > %G+: Y/N if the commit has nonempty gpgsig header or not
> > >=20
> > > The second is of course much more likely to be used, but having expos=
ed
> > > the one, exposing the other too adds almost no complexity.
> > >=20
> > > I'm open to suggestion on the names of these placeholders.
> > >=20
> > > This commit is based on master but e5a329a279 ("run-command: report e=
xec
> > > failure" 2018-12-11) is required for the tests to pass.
> > >=20
> > > One note is that this change touches areas of the pretty-format
> > > documentation that are radically revamped in aw/pretty-trailers: see
> > > 42617752d4 ("doc: group pretty-format.txt placeholders descriptions"
> > > 2018-12-08). I have another version of this branch based on that bran=
ch
> > > as well, so you can use that in case conflicts with aw/pretty-trailer=
s
> > > arise.
> > >=20
> > > See:
> > > - https://github.com/jpassaro/git/tree/jp/pretty-expose-gpgsig
> > > - https://github.com/jpassaro/git/tree/jp/pretty-expose-gpgsig--based=
-on-aw-pretty-trailers
> > >=20
> > > John Passaro (4):
> > >   pretty: expose raw commit signature
> > >   t/t7510-signed-commit.sh: test new placeholders
> > >   doc, tests: pretty behavior when gpg missing
> > >   docs/pretty-formats: add explanation + copy edits
> > >=20
> > >  Documentation/pretty-formats.txt |  21 ++++--
> > >  pretty.c                         |  36 ++++++++-
> > >  t/t7510-signed-commit.sh         | 125 +++++++++++++++++++++++++++++=
--
> > >  3 files changed, 167 insertions(+), 15 deletions(-)
> > >=20
> > >=20
> > > base-commit: 5d826e972970a784bd7a7bdf587512510097b8c7
> > > prerequisite-patch-id: aedfe228fd293714d9cd0392ac22ff1cba7365db
> >=20
> > Just a suggestion: since the raw signature is not very useful without
> > the commit data to check it against, and the commit data is non-trivial
> > to construct (requires mangling raw data anyway), maybe you could eithe=
r
> > add another placeholder to get the data for signature verification, or
> > (alternatively or simultaneously) add a placeholder that prints both
> > data and signature in the OpenPGP message format (i.e. something you ca=
n
> > pass straight to 'gpg --verify').
> >=20
>=20
> That's a great idea!
>=20
> Then I might rename the other new placeholders too:
>=20
> %Gs: signed commit signature (blank when unsigned)
> %Gp: signed commit payload (i.e. in practice minus the gpgsig header;
> also blank when unsigned as well)
> %Gq: query/question whether is signed commit ("Y"/"N")
>=20
> Thus establishing %G<lowercase> as the gpg-related placeholders that
> do not actually require gpg.
>=20
> And add a test that %Gp%n%Gs or the like passes gpg --verify.
>=20
> I'll put in a v2 later today or tomorrow. Thank you for the feedback!
>=20

Technically speaking, '%Gp%n%Gs' sounds a bit odd, given that
the payload needs to be preceded by the PGP message header but instead
of footer it has the signature's header.  Also note that some lines in
the payload may need to be escaped.

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--=-MI/XRT9s0W5dvSHipSQ1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEXr8g+Zb7PCLMb8pAur8dX/jIEQoFAlwT3vtfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDVF
QkYyMEY5OTZGQjNDMjJDQzZGQ0E0MEJBQkYxRDVGRjhDODExMEEACgkQur8dX/jI
EQrhLBAAg1z5179Jp3vJ/B5ldtvyxvAE16UxjwtJqff84BWA79gqzdFAaEHaA9jR
zpQ6odNt+WOR9Rl+WZqkgCTgPmSF38Bj6tNqyr3MqrMPhc9YIPcs2ibcnTCwJsKW
ds5iuHaOxYgfVlKBmIXil2VoE/ccWB/LMg0vvT8OLIpzhgbyyGguQ87rAXWlxwis
x3d1thTVl8BTnZxB/jNzG0M4+1eCPWD9E9psHebUpydmTPVkD1dbYTXWLUecvIn9
7vD/vkhYE3CZ70qTb7asV8sCrMdCvxRtF8BR72WAnH61s5TMAEk05hM4wXVQkwgf
lrnGCphrj9TBUbVLnIocwhu6+AkJyqqnd9KyvPJgx1p9O+kg8BeT9cCEIWW/Qxvf
iOgv6avvpU/0KS1fSivO2Cbv43sCRhSgXz2xu4Xh1ggEIvHuy2dEQJq8qvd4DjmD
GwbmPY+AF1mDLucPXzh2GsFCO9ZBsdlfD/xgBZ+GWDyXsvGGmZuRQKngz12NCmY3
vSrNJRjr66y/nao6RwC2fHA5PRvxWHa0trwHA7ysx7jkLX/Rw0tET+rEL08z8YfX
kFEk8yNzhLmJwSdVDQN2YxCQzT7MSYG4vkgPQfIPLodb2fAqQDjTtsyxSsiStUwn
jmm5K5sDP9A6OBr32EDNjIdGm0bxbGwBpevdyFD3jhs5X7EPY+s=
=d64r
-----END PGP SIGNATURE-----

--=-MI/XRT9s0W5dvSHipSQ1--

