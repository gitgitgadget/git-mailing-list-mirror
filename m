Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567B0C433FE
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 437E2610A2
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbhJLVul (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 17:50:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60134 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234087AbhJLVuk (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Oct 2021 17:50:40 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1182B60423;
        Tue, 12 Oct 2021 21:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634075317;
        bh=c6HPWoIf6zFpSOqNp9up7Mu58Fw45JuhBgaPJpwUlqc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fxSy4TUSgyLlvnTlX7sZKYNXT8El0LvktM/vEwi9lUiMZUWItE9oaPnrvzLIGiRnc
         CTk8nWM3rRbxF3Jd9LlBxmJvLIxd4pt6d+ot9EsTqNNHmk0lOTQhJZGMVS6Hry/YzH
         Mfx21VAsx7NzNFUfMgB4j5uAlWIVBRUI9+Ok826WBfEPd0NtpPEjM20+kCLqgJptCB
         o/bEcI0Rs1gmxN/n8Im//phYuCCEzLBKE9084JqM1871ShvH8CNCMrhYOfXWPzmFH7
         ASnngcjRyAMm4jZq4GGjFwfmzQe76lL8hWn/E8jk3V0noK8R7A8Sc9u90tttPhfStE
         JTxJIBHIhIz6kCJvggEUgX0dleM8F4xZV9K9HF52PoQaj6hIkuzJ4XySfuVhMXm/mE
         O+//S8/F1YfZUgA1zWafydzHZtejs7imtVHjib9bv1eS5IJ01DQSM6lAmG2yIL8hU0
         7NMV6/rrXQdfIJCi+xDF5mA8TOnSqfSSbqVL6iz+vfgz+Blekwy
Date:   Tue, 12 Oct 2021 21:48:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Alex Waite <alex@waite.eu>,
        git@vger.kernel.org
Subject: Re: [BUG] credential wildcard does not match hostnames containing an
 underscore
Message-ID: <YWYCh3+37d27QNjW@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Alex Waite <alex@waite.eu>, git@vger.kernel.org
References: <28ff3572-1819-4e27-a46d-358eddd46e45@www.fastmail.com>
 <xmqqk0ii3zl6.fsf@gitster.g>
 <YWXzGeiUSMeq5Key@coredump.intra.peff.net>
 <YWX8d/VTrkOz5tga@camp.crustytoothpaste.net>
 <YWX+6OgzN4CDzomO@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="be5tm9LRozVNIWTG"
Content-Disposition: inline
In-Reply-To: <YWX+6OgzN4CDzomO@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--be5tm9LRozVNIWTG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-12 at 21:32:24, Jeff King wrote:
> On Tue, Oct 12, 2021 at 09:21:59PM +0000, brian m. carlson wrote:
> > I'm happy to put in a change to reject these hostnames altogether, but I
> > won't get to it before Friday.
>=20
> IMHO _that_ is the thing that will produce breakage. People who are not
> using URL-specific config but are happily using foo_bar.example.com will
> now get a failure for something that used to work.

There's a well-known bug on Tumblr, where it allocated hostnames for
users that happened to start or end with a dash, which is not allowed.
This worked great on Windows systems, which don't care, but every Unix
system was broken.

When we decide to allow this particular case, we end up with the problem
that people won't see consistent behavior across systems and tools.  It
may be that libgit2 rejects this, or Git LFS, or some other tool in the
ecosystem, and then we'll have people complaining that "Well, Git
accepts it, so why don't you?" which I am not eager to see.  I, for
example, have absolutely zero control over the URL parsing library
that's used in Git LFS, and the Go team has demonstrated that they don't
care one bit about supporting Git-related tooling.  That doesn't even
include a variety of proprietary Unix systems that might have different
rules or resolvers.

I am also not eager to see additional bug reports for this case that
will need to be fixed under the precedent that we accepted a patch to
fix it before.  If there's a concern that rejecting these hostnames
altogether would break existing users, then we can just do nothing, and
tell users that their syntax is not valid and they need to fix their
hostnames.  This rule has been documented since before ISO standardized
C, so it shouldn't be new to anyone deploying systems or DNS.

So I'm fine with doing nothing, or rejecting these hostnames, but not
allowing more lenient syntax, because it will probably be broken
somewhere and we (or someone else in the ecosystem) will have to deal
with it again down the line.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--be5tm9LRozVNIWTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYWYCsQAKCRB8DEliiIei
ga4eAP4mHlwRvV1tsZ0XKwcvYHiq1/PKDtX00FzjncrAgMqPywD+IfX/d/SAhCbg
85MEG4tQ1ROIdP9ey8S5a5Z+wd1YuwM=
=G5Xn
-----END PGP SIGNATURE-----

--be5tm9LRozVNIWTG--
