Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367E4C2BA19
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 00:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C1220768
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 00:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="jBOIvAz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDJA4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 20:56:09 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51754 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726574AbgDJA4J (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Apr 2020 20:56:09 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DE5976042C;
        Fri, 10 Apr 2020 00:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1586480168;
        bh=tzIeLiMgKGtHcm7/O0CR+r/JEGW/p3Z6KbKBaas68xU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=jBOIvAz9j9/jx3tqcZvG4XVBUEF6tShSb/XTXpgTSR0xvHazgnvUwlXyMwI4y1uuw
         X1Zkrh2T6FjnRWKB/pPDvIHDS7bc2Vdba0i81Gdm9RioEIQctzyIfxszyRNywxaV2K
         fZf/zzPSl7CNGTSJbL2XPMB96gnZMVzYRvHnfS8OnE03RMDc8mVQnoXuFhy+oIp303
         tKXjoO2yRPU7m6C7JLDyt5xvDDJ2qtxlkpiHihnYz6JwyrW/kYNw4Eey8gqYd62djd
         7QAyqvNnT7cSL2uLTouywMrzeqfX37NNZZP0RrJr2l1Gk2JC4ZuTyN92qjYUZ1zf6G
         R8pZh6PYr5Qiv0Q1wJTTdQpkubCgwT5osqeOF5J7ucZTduICnUfB4EHpxbuRmykP44
         /KjiiWsra0IyXPKDogTq+01bjwQtZeezP6delpYM8O1Rvzk9ejmVnOtapkNuXmet1D
         ao4Zoh9MfB0IO1/hZfluyoHRUKNePrE59lzGKs4/BYVMKumeoj1
Date:   Fri, 10 Apr 2020 00:56:03 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin/receive-pack: use constant-time comparison for
 HMAC value
Message-ID: <20200410005603.GC6639@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
References: <20200409233730.680612-1-sandals@crustytoothpaste.net>
 <xmqqr1wwkxqe.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline
In-Reply-To: <xmqqr1wwkxqe.fsf@gitster.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.5.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-10 at 00:09:29, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > When we're comparing a push cert nonce, we currently do so using strcmp.
> > Most implementations of strcmp short-circuit and exit as soon as they
> > know whether two values are equal.  This, however, is a problem when
> > we're comparing the output of HMAC, as it leaks information in the time
> > taken about how much of the two values match if they do indeed differ.
> >
> > In our case, the nonce is used to prevent replay attacks against our
> > server via the embedded timestamp and replay attacks using requests from
> > a different server via the HMAC.  Push certs, which contain the nonces,
> > are signed, so an attacker cannot tamper with the nonces without
> > breaking validation of the signature.  They can, of course, create their
> > own signatures with invalid nonces, but they can also create their own
> > signatures with valid nonces, so there's nothing to be gained.  Thus,
> > there is no security problem.
> >
> > Even though it doesn't appear that there are any negative consequences
> > from the current technique, for safety and to encourage good practices,
> > let's use a constant time comparison function for nonce verification.
> > POSIX does not provide one, but they are easy to write.
>=20
> Devil's advocate mode on.
>=20
> If the HMAC plus digital signature are the real security, even
> though writing this patch may be a nice mental exercise, is there a
> merit in deliberately adding more code and making the code
> immesurably slower by applying it?
>=20
> You just established in the previous paragraph that "for safety" is
> a red herring.

Here's the thing: I'm pretty sure there's not a security issue, but I'm
not a cryptologist and can't speak for certain.  We didn't think TLS had
all of the issues it did, until we determined that it did.  If someone
who is a cryptologist comes up with an attack scenario we hadn't
considered, we're covered.

Also, if we ever use this HMAC implementation for something else in the
future, that use might be vulnerable.  So it makes sense to always use a
constant time comparison for HMAC so it looks wrong not to.  I think
it's a good idea to make people feel icky about doing things like
non-constant HMAC comparisons or using MD5 even in the rare case where
it doesn't matter because almost all of the time, it does.

If we were using a language like C++ or Rust that returned a typed value
for our results, we'd get this behavior for free, and we wouldn't know
or care about the extremely minor performance impact.  The cost of using
a constant time comparison instead of an optimized strcmp is going to be
a handful of cycles and be dwarfed by the fact that we're forking and
execing a process (and moreover, probably a shell) to verify the push
cert.

So I think this is valuable, although I understand if you don't want to
take it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXo/EIwAKCRB8DEliiIei
gWAHAQCS2EkSfxJXXM3EJdR0MjDrh1PqlMywscJa90qsC+/f0wEAg5oOyq17yCvJ
WIqBFzaopKUu5JQdw+dsNHN3TEtPcAE=
=omUl
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
