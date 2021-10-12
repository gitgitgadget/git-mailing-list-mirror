Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD6CC433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF576610CB
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbhJLV7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 17:59:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60154 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232260AbhJLV7v (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Oct 2021 17:59:51 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B936260734;
        Tue, 12 Oct 2021 21:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634075868;
        bh=Lo+u/Yzesqi4N1ca+JwZnsh+b7zpgNO/ShCWc+9RgSE=;
        h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
         In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=eL1dkS2AaYr1C4F23xRE7eLzVd25YULoNb1UN+aAl9xb4rlswOvaLKcjbqU7dXEa7
         hirdCcgG51wug+JzW7up5aEoIEBgATV8hXGxtklR1/4M7Lmc7SKT647612gBEyIvZz
         exvaK7WG54KQbaYXl/D/5haB++nQV5kkK75cMybTFzPD5ZN2xHZShhNwKxsU99z+mm
         BKomUwTrehv6NXzAu4fT1Oten+AR5dDa2bxZhiveZywc7QkCtrd7qNczs7y7TtEB2C
         aMCtXMyYIS9nTHL/AobC3E0JYYBZIbPufS8laOuL09sWHxTEDUbwk17ymjufax1UA7
         e1O43/Kpgve9bDbdx26XMaILdnESY39ELyQco2QDNhFSAFP1NUyoSvMC6CWXVlzK5E
         5b8gqYmOfbAcftHvjedGZUJpk7PLS4Bq4T9LG2Kl4o9t8eQuf//xIw8KdZfvHO0hm5
         ThR0EBOLziLqFpVJL8uS0uRe3KKylUg8ADm7zxQxMl7LgO2kMVd
Date:   Tue, 12 Oct 2021 21:57:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Alex Waite <alex@waite.eu>, git@vger.kernel.org
Subject: Re: [BUG] credential wildcard does not match hostnames containing an
 underscore
Message-ID: <YWYE2LZp/EfoBpN/@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Alex Waite <alex@waite.eu>, git@vger.kernel.org
References: <28ff3572-1819-4e27-a46d-358eddd46e45@www.fastmail.com>
 <xmqqk0ii3zl6.fsf@gitster.g>
 <YWXzGeiUSMeq5Key@coredump.intra.peff.net>
 <YWX8d/VTrkOz5tga@camp.crustytoothpaste.net>
 <YWX+6OgzN4CDzomO@coredump.intra.peff.net>
 <YWYCh3+37d27QNjW@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YV4+AtG6fO8Szbwy"
Content-Disposition: inline
In-Reply-To: <YWYCh3+37d27QNjW@camp.crustytoothpaste.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YV4+AtG6fO8Szbwy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-12 at 21:48:33, brian m. carlson wrote:
> On 2021-10-12 at 21:32:24, Jeff King wrote:
> > On Tue, Oct 12, 2021 at 09:21:59PM +0000, brian m. carlson wrote:
> > > I'm happy to put in a change to reject these hostnames altogether, bu=
t I
> > > won't get to it before Friday.
> >=20
> > IMHO _that_ is the thing that will produce breakage. People who are not
> > using URL-specific config but are happily using foo_bar.example.com will
> > now get a failure for something that used to work.
>=20
> There's a well-known bug on Tumblr, where it allocated hostnames for
> users that happened to start or end with a dash, which is not allowed.
> This worked great on Windows systems, which don't care, but every Unix
> system was broken.
>=20
> When we decide to allow this particular case, we end up with the problem
> that people won't see consistent behavior across systems and tools.  It
> may be that libgit2 rejects this, or Git LFS, or some other tool in the
> ecosystem, and then we'll have people complaining that "Well, Git
> accepts it, so why don't you?" which I am not eager to see.  I, for
> example, have absolutely zero control over the URL parsing library
> that's used in Git LFS, and the Go team has demonstrated that they don't
> care one bit about supporting Git-related tooling.  That doesn't even
> include a variety of proprietary Unix systems that might have different
> rules or resolvers.
>=20
> I am also not eager to see additional bug reports for this case that
> will need to be fixed under the precedent that we accepted a patch to
> fix it before.  If there's a concern that rejecting these hostnames
> altogether would break existing users, then we can just do nothing, and
> tell users that their syntax is not valid and they need to fix their
> hostnames.  This rule has been documented since before ISO standardized
> C, so it shouldn't be new to anyone deploying systems or DNS.

I also just checked, and RFC 5280 specifies the rules for RFC 1123
regarding host names in certificates.  So even if we did accept this, no
publicly trusted CA could issue a certificate for such a domain, because
to do so would be misissuance.  So this at best could help people who
are either using plain HTTP or an internal CA using broken tools,
neither of which I think argue in favor of supporting this.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--YV4+AtG6fO8Szbwy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYWYE2AAKCRB8DEliiIei
gSF5AP9muc+Jv6b7NOctYidy2aZEjGjT5h9qR3qz9QBB6gInWQEA0SFBy+LZAnnW
gOtJ40mwQAAbjLBYQ+bzZN26ZBYOEwc=
=x6dM
-----END PGP SIGNATURE-----

--YV4+AtG6fO8Szbwy--
