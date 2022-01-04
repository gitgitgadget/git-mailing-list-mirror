Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586C5C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 22:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbiADW4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 17:56:36 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:59472 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbiADW4g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 17:56:36 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 52EB55B214;
        Tue,  4 Jan 2022 22:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1641336995;
        bh=e0JsZ1qtoYd/k8kzX4npJOF2Cra1NwdXi35w0YNUd0U=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=UsoMlXBNjTFKiYOrZ9re3Pc675jTck1llIsQ1Zv5SHSYtDgkNp/rtWu6X9g4/6lBK
         DQXMHWRhoe4P+RGHKwm+edt/NmlaCi1GpUQOayQ9ynAHjRpRPkWXAoVXdHBqBKB+Nq
         K6GNZQUdZ20iLcFMSXljeJKAQpM95xiwgJLtyXlVmwfgvBnqpLQwEhXyD/coycbmeo
         Y5x/8AvtDgtFA2/xx1ZhLxjpEDcSxBU01bksGIueD+1lWumu/7ConHzzjqE1O8oKyS
         2nXHYSqyBsX9Nx+0bsKK52wM+DAeR4/XlG1eDFbN/y6E2dVaxNARLfb24F96YuvCAM
         a5gm4m2Yh0Hzx1QgqI+O07+zhZTYsOlTt1+lyEBlEIIr3RMU8CNPc1wmq0q3u+4YlO
         giCh2uCcc+AmUwAqVh89yHrYCKnnVwmEk+h8SwxCBXxbASZQtRX7o7yyvV39Lh/o93
         ImsnY6hiR3v09La+E3fgqIcJX5CX4ARQ6SqNc+K732HS1cSW8Us
Date:   Tue, 4 Jan 2022 22:56:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Subject: Re: [PATCH v2 1/2] wrapper: add a helper to generate numbers from a
 CSPRNG
Message-ID: <YdTQodIhZ9273nJE@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        rsbecker@nexbridge.com, Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
References: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
 <20220104015555.3387101-2-sandals@crustytoothpaste.net>
 <xmqqsfu3b4gw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ux3zbFoWHeov5sj4"
Content-Disposition: inline
In-Reply-To: <xmqqsfu3b4gw.fsf@gitster.g>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ux3zbFoWHeov5sj4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-04 at 21:01:19, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > +ifeq ($(strip $(CSPRNG_METHOD)),arc4random)
> > +	BASIC_CFLAGS +=3D -DHAVE_ARC4RANDOM
> > +endif
> > +
> > +ifeq ($(strip $(CSPRNG_METHOD)),arc4random-libbsd)
> > +	BASIC_CFLAGS +=3D -DHAVE_ARC4RANDOM_LIBBSD
> > +	EXTLIBS +=3D -lbsd
> > +endif
> > +
> > +ifeq ($(strip $(CSPRNG_METHOD)),getrandom)
> > +	BASIC_CFLAGS +=3D -DHAVE_GETRANDOM
> > +endif
> > +
> > +ifeq ($(strip $(CSPRNG_METHOD)),getentropy)
> > +	BASIC_CFLAGS +=3D -DHAVE_GETENTROPY
> > +endif
> > +
> > +ifeq ($(strip $(CSPRNG_METHOD)),rtlgenrandom)
> > +	BASIC_CFLAGS +=3D -DHAVE_RTLGENRANDOM
> > +endif
> > +
> > +ifeq ($(strip $(CSPRNG_METHOD)),openssl)
> > +	BASIC_CFLAGS +=3D -DHAVE_OPENSSL_CSPRNG
> > +endif
>=20
> Use of $(strip ($VAR)) looks a bit different from what everybody
> else does with ifeq in this Makefile.  Was there a particular reason
> to use it that I am missing?

As far as I'm aware, ifeq includes whitespace in its comparisons (at
least, I was led to believe that by the documentation for GNU make).
However, in many places, we insert leading spaces before the variable
name.  Some testing shows that GNU make strips those off, although my
earlier testing led me to believe otherwise.

So I'll change this in v3.

> When we see something unrecognized in CSPRNG_METHOD, we do not touch
> BASIC_CFLAGS (or EXTLIBS) here.  I wonder how easy a clue we would
> have to decide that we need to fall back to urandom.  IOW, I would
> have expected a if/else if/... cascade that has "no we do not have
> anything else and need to fall back to urandom" at the end.

I tried to avoid the if/else if cascade for the same reasons that we do
in config.mak.uname, which is that it gets pretty hard to reason about
after you have more than just a few items.

> > diff --git a/t/helper/test-csprng.c b/t/helper/test-csprng.c
> > new file mode 100644
> > index 0000000000..65d14973c5
> > --- /dev/null
> > +++ b/t/helper/test-csprng.c
> > @@ -0,0 +1,29 @@
> > +#include "test-tool.h"
> > +#include "git-compat-util.h"
> > +
> > +
> > +int cmd__csprng(int argc, const char **argv)
> > +{
> > +	unsigned long count;
> > +	unsigned char buf[1024];
> > +
> > +	if (argc > 2) {
> > +		fprintf(stderr, "usage: %s [<size>]\n", argv[0]);
> > +		return 2;
> > +	}
> > +
> > +	count =3D (argc =3D=3D 2) ? strtoul(argv[1], NULL, 0) : -1L;
> > +
> > +	while (count) {
> > +		unsigned long chunk =3D count < sizeof(buf) ? count : sizeof(buf);
>=20
> "chunk" should be of type "size_t", no?

Yes, it should.  Will fix in v3.

> > diff --git a/wrapper.c b/wrapper.c
> > index 36e12119d7..1052356703 100644
> > --- a/wrapper.c
> > +++ b/wrapper.c
> > @@ -702,3 +702,69 @@ int open_nofollow(const char *path, int flags)
> >  	return open(path, flags);
> >  #endif
> >  }
> > +
> > +int csprng_bytes(void *buf, size_t len)
> > +{
> > +#if defined(HAVE_ARC4RANDOM) || defined(HAVE_ARC4RANDOM_LIBBSD)
>=20
> Shouldn't HAVE_ARC4RANDOM mean "we have arc4random_buf() function
> available; please use that.", i.e. wouldn't this give us cleaner
> result in the change to the Makefile?
>=20
>  ifeq ($(strip $(CSPRNG_METHOD)),arc4random)
>  	BASIC_CFLAGS +=3D -DHAVE_ARC4RANDOM
>  endif
> =20
>  ifeq ($(strip $(CSPRNG_METHOD)),arc4random-libbsd)
> -	BASIC_CFLAGS +=3D -DHAVE_ARC4RANDOM_LIBBSD
> +	BASIC_CFLAGS +=3D -DHAVE_ARC4RANDOM
>  	EXTLIBS +=3D -lbsd
>  endif
>=20
> To put it differently, C source, via BASIC_CFLAGS, would not have to
> care where the function definition comes from.  It is linker's job
> to care and we are already telling it via EXTLIBS, so I am not sure
> the value of having HAVE_ARC4RANDOM_LIBBSD as a separate symbol.

There's an important additional difference here.  On real BSD systems,
the prototypes for this family of functions live in <stdlib.h>.
Obviously, on Linux with libbsd, that's not the case.  So, in
git-compat-util.h, we need to include <bsd/stdlib.h> to get the
prototype, and that's done only if HAVE_ARC4RANDOM_LIBBSD is set, since
on a real BSD system, that header isn't present.

If you'd prefer, I can set both flags here, one which controls the
function use and one which controls the #define, or I can leave it as it
is.

> OK, I earlier worried about the lack of explicit "we are using
> urandom" at the Makefile level, but as long as this will remain the
> only place that needs to care about the fallback, the above is
> perfectly fine.

Yes, I tried very hard to make this the only place the default mattered.

And, for the record, I think /dev/urandom is the sensible default here,
because I know it exists on some of the proprietary Unix systems, like
Solaris, where I believe it originated, and QNX, as well as Linux and
the BSDs.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--ux3zbFoWHeov5sj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYdTQnwAKCRB8DEliiIei
gSysAQDGR6qYbfCLEFe3jsCPIJ7eazpNNN50aXfCSW1PZCju9gD9Gf5UhOw/RLUU
eWh4jIF9/keh3q0cUsCSQJj63+oX6gE=
=rPPs
-----END PGP SIGNATURE-----

--ux3zbFoWHeov5sj4--
