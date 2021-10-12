Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F10C433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D44A606A5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbhJLVYG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 17:24:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60108 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234043AbhJLVYF (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Oct 2021 17:24:05 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 268B860734;
        Tue, 12 Oct 2021 21:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634073723;
        bh=27abjLOsb/sG15CzZFG3LMoehEIvHk+QtILG9Vs6qnQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=yhw9wA974nu9KceqNvfZ3VKYGvw5Ku3ukzCgZ8uWo01u897jEWsqNR5cWFW6wxVVt
         f6V18cFEh0FpO9yxl/nw5ymniI2NhjAHgibS+Y9yT1oRB0N3+lLCvJCJt2n0/VufK8
         7nkxejLpD1TwT5XN/q/XL8J911PkAgylX4eUUWvUWL2QvTQ2Ms+/FXLd+UNiHJiL6z
         p/Ar0Xk71wxm9CsTz10QJefCP9aLkdAbHBKFQdZZJv35Sh2uTEagI/VW7dERM0L/IM
         ARSxDGuCpK4ixX5yszyjMgyeF2o7K2eqB5O0qB25AKRLZsNLUKpEGi3Vd9VFznMaln
         ZdKNWvIp0MklmJ3XwHbHh6RatgmyEUOqktdbxd4NeVWyBXA5r6Oj8eWuNFx53Oo+HE
         DzL9B4cRth76lfNt40Gi9V+dR7KmvwrC4+y6gI8UoekO0ElIINJxXTwyiJsNsymX37
         YZmQYO7sFFH1qgxfArg2VL8kcmNvwTAE/nEkAbrXldfIAZ1U7em
Date:   Tue, 12 Oct 2021 21:21:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Alex Waite <alex@waite.eu>,
        git@vger.kernel.org
Subject: Re: [BUG] credential wildcard does not match hostnames containing an
 underscore
Message-ID: <YWX8d/VTrkOz5tga@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Alex Waite <alex@waite.eu>, git@vger.kernel.org
References: <28ff3572-1819-4e27-a46d-358eddd46e45@www.fastmail.com>
 <xmqqk0ii3zl6.fsf@gitster.g>
 <YWXzGeiUSMeq5Key@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rKQmXSuyofJK1RzR"
Content-Disposition: inline
In-Reply-To: <YWXzGeiUSMeq5Key@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rKQmXSuyofJK1RzR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-12 at 20:42:01, Jeff King wrote:
> On Tue, Oct 12, 2021 at 10:47:01AM -0700, Junio C Hamano wrote:
>=20
> > "Alex Waite" <alex@waite.eu> writes:
> >=20
> > >   This works for all tested subdomains /except/ for those which conta=
in an
> > >   underscore.
> > >
> > >   authenticates without prompting:
> > >     git clone https://testA.example.com
> > >     git clone https://test-b.example.com
> > >
> > >   prompts for authentication:
> > >     git clone https://test_c.example.com
> >=20
> > Hmph, given that hostnames cannot have '_' (cf. RFC1123 2.1 "Host
> > Names and Numbers", for example), the third URL seems invalid.  Is
> > this even a bug?
>=20
> That may be so for hostnames in general, but URLs seem to allow it. RFC
> 3986 says:
>=20
>       host        =3D IP-literal / IPv4address / reg-name
>       reg-name    =3D *( unreserved / pct-encoded / sub-delims )
>       unreserved  =3D ALPHA / DIGIT / "-" / "." / "_" / "~"

That's what the schema says.  The text says this:

  A host identified by a registered name is a sequence of characters
  usually intended for lookup within a locally defined host or service
  name registry, though the URI's scheme-specific semantics may require
  that a specific registry (or fixed name table) be used instead.  The
  most common name registry mechanism is the Domain Name System (DNS).
  A registered name intended for lookup in the DNS uses the syntax
  defined in Section 3.5 of [RFC1034] and Section 2.1 of [RFC1123].

Those RFCs disallow the underscore.

If we plan to allow names that are not registered in the DNS, we should
clearly specify what those are and document how they work in conjunction
with libcurl (which presumably does a DNS lookup on them).  It's my
guess that there are going to be system resolvers which are not going to
accept this syntax in getaddrinfo and as a result, we're going to have
various breakage across systems if we try to accept this.

I'm happy to put in a change to reject these hostnames altogether, but I
won't get to it before Friday.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--rKQmXSuyofJK1RzR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYWX8dgAKCRB8DEliiIei
gTnnAQCToCPMWV3vJ7PXalto8qUjgpcEdBfTFvWk7ktMv1+TKwEA8TJe778ftHzR
dKQD1wllOxpXs2yqVIlW7/le0EkYBgs=
=YmaD
-----END PGP SIGNATURE-----

--rKQmXSuyofJK1RzR--
