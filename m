Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909FEC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 22:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A35361057
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 22:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhKPWot (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 17:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhKPWos (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 17:44:48 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FC1C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 14:41:51 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D536B5B463;
        Tue, 16 Nov 2021 22:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1637102509;
        bh=PWVBuRxvDt8O3tROf6pgviVOZQxgihVijwk/7TmBfTQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qnJh458kK/GcLKOm491A66uQ2+X+dPj6vqZYq0f2ffOb/57bYCegcZ87WOOKGye59
         3rn9WPe3ldlZFD92uoBj8f9OHKRh5jS4aFq5tP2qsoHWzr3pDFVvKs/aozGP5Hk2fi
         PyRbPh4EbvQnqboWb9OsJtZh8NTtiPA2L2ox4zivra7lqWfdE5/7ufWLm+SFeTFPxb
         46H3cHUqDM7u/eqKQH/x5s889va7U2mhls8BrE/NRZqseb810QxmzVcT2ExhSpI94s
         n9joqkb1PpDke85gkwI+CK1lLpDxMaOD4sMMQ15Lr0uJz80ccRirUYJ/vnU9k4h2u6
         DIZnTQDY8ikvWv5K8dmwYUy+oKLaoxWmSADHOVl+DX57m4VJTWiqgjVv6dq8Pq1XM0
         6ngsmcpRncAyyj6mnuaQ8mm6GFcjm37FJdjiUDUuq9EvEcwb0QI8hDb5ZBmg/yQ1Qp
         Ea9VZNfTC/Go9NgcGeeVUXlMs4Tmq/dUpSpthdIImiccPG81VMb
Date:   Tue, 16 Nov 2021 22:41:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     rsbecker@nexbridge.com
Cc:     'Jeff King' <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] wrapper: add a helper to generate numbers from a
 CSPRNG
Message-ID: <YZQzqjWMzaWVkkfP@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        rsbecker@nexbridge.com, 'Jeff King' <peff@peff.net>,
        git@vger.kernel.org
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
 <20211116033542.3247094-2-sandals@crustytoothpaste.net>
 <YZPOzqU0UQDVA57R@coredump.intra.peff.net>
 <009d01d7db03$354ecae0$9fec60a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EVGppbvsL/4MtImh"
Content-Disposition: inline
In-Reply-To: <009d01d7db03$354ecae0$9fec60a0$@nexbridge.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EVGppbvsL/4MtImh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-11-16 at 16:01:20, rsbecker@nexbridge.com wrote:
> On November 16, 2021 10:31 AM, Jeff King wrote:
> > On Tue, Nov 16, 2021 at 03:35:41AM +0000, brian m. carlson wrote:
> >=20
> > > The order of options is also important here.  On systems with
> > > arc4random, which is most of the BSDs, we use that, since, except on
> > > MirBSD, it uses ChaCha20, which is extremely fast, and sits entirely
> > > in userspace, avoiding a system call.  We then prefer getrandom over
> > > getentropy, because the former has been available longer on Linux, and
> > > finally, if none of those are available, we use /dev/urandom, because
> > > most Unix-like operating systems provide that API.  We prefer options
> > > that don't involve device files when possible because those work in
> > > some restricted environments where device files may not be available.
> >=20
> > I wonder if we'll need a low-quality fallback for older systems which d=
on't
> > even have /dev/urandom. Because it's going to be used in such a core pa=
rt of
> > the system (tempfiles), this basically becomes a hard requirement for u=
sing
> > Git at all.
> >=20
> > I can't say I'm excited in general to be introducing a dependency like =
this, just
> > because of the portability headaches. But it may be the least bad thing
> > (especially if we can fall back to the existing behavior).
> > One alternative would be to build on top of the system mkstemp(), which
> > makes it libc's problem. I'm not sure if we'd run into problems there, =
though.
>=20
> None of /dev/urandom, /dev/random, or mkstemp are available on some
> platforms, including NonStop. This is not a good dependency to add.
> One variant PRNGD is used in ia64 OpenSSL, while the CPU random
> generator in hardware is used on x86. I cannot get behind this at all.
> Libc is also not used in or available to our port. I am very worried
> about this direction.

I'm really not excited about a fallback here, and I specifically did not
include one for that reason.  I'm happy to add an appropriate dependency
on an OpenSSL or libgcrypt PRNG if you're linking against that already
(e.g., for libcurl) or support for libbsd's arc4random or getentropy if
that will work on your system.  For example, how are you dealing with
TLS connections over HTTPS?  That library will almost certainly provide
the required primitives in a straightforward and portable way.

I do fundamentally believe every operating system and language
environment need to provide a readily available CSPRNG in 2021,
especially because in the vast majority of cases, hash tables must be
randomized to avoid hash DoS attacks on untrusted input.  I'm planning
to look into our hash tables in the future to see if they are vulnerable
to that kind of attack, and if so, we'll need to have a CSPRNG for basic
security reasons, and platforms that can't provide one would be subject
to a CVE.

If we really can't find a solution, I won't object to a patch on top
that adds an insecure fallback, but I don't want to put my name or
sign-off on such a patch because I think it's a mistake.  But I think we
almost certainly can, though.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--EVGppbvsL/4MtImh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYZQzqQAKCRB8DEliiIei
gb3KAQD126uDC1N6Am7Lz/rvv7WCrKGFR56hUnp/9HmykiNgOQEAwDvMOg2QXBcg
saYlBIYOSa8O/Wbid/erPRyduqlX/A4=
=noD4
-----END PGP SIGNATURE-----

--EVGppbvsL/4MtImh--
