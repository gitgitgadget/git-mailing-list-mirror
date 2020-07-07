Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D26C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 23:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B8602073B
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 23:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="G7gJbdoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgGGXyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 19:54:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40326 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727945AbgGGXyo (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Jul 2020 19:54:44 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 679796047A;
        Tue,  7 Jul 2020 23:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594166083;
        bh=48GesxwqJUiF6rB92Th11vEvjMI+VDJ6Bd2NW0lw3/I=;
        h=Date:From:To:Cc:Subject:Content-Type:Content-Disposition:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=G7gJbdoT0xlm7kHCE2Uz1jCxKrlI9/uyjdaN0Bs6PkFNaDF5vbEtGkvKxfCdaW0+w
         b/gsiWdkjcJ22kKmRXCdQs6mdDghFu4NchU0s9rGC4loOchY/X6ULVX8emQIfO92r0
         7Lzv8qnjRfE6ameK/u/Nt8FDp9EscYk8bSN270waRRpssshQsN2Vatzh9SWSrSPAKg
         TowYrQkP+HXe1tdZUmHImzAXPr5EZa3lzjeVU1JP6FU3Ruip79JXNm0Y6xTwXIsUat
         AaYdrvScQMybMg6mabJXv6Rh2Mhf3Ua7jSUe8kCum6w0Daobp7TJXcGCv5fUOw4oiL
         UhST0fLzc7QYmmxWzIan3TGT0EZyASV8eKhvrU1bjo1HOwcQXYXryS6C6qbdhg8bKA
         Kw3eQPxCGh96l27/oHWNkE1wVTh5URzIjvYc4sM5CmX8X5/+k4O018apPzzqlZB9DU
         l3fD8p50u/OM5d0rQY4qbUeSMpRZWEw6BGFAcQ3MfIWIhIkQXvz
Date:   Tue, 7 Jul 2020 23:54:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>
Subject: t4068 test failure with -fsanitize=address
Message-ID: <20200707235436.GH9782@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tT3UgwmDxwvOMqfu"
Content-Disposition: inline
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tT3UgwmDxwvOMqfu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I was kicking off a build on a cloud instance for the final series of my
SHA-256 work and I noticed that t4068 fails with -fsanitize=3Daddress
using Debian's GCC 9.3.0-14 (the version in unstable).  It has failed
since the test was introduced and currently fails on the latest HEAD.

I haven't had time to look at it, but I thought I'd pass the information
on so we can get it fixed before the release.  I'll take a look if
nobody else gets to it first, but it may be a few days.

Reproduction steps:

  printf 'DEVELOPER=3D1\nDC_SHA1=3D1\nBLK_SHA256=3D1\nSANITIZE=3Daddress\n'=
 >config.mak
  make -j6 all && (cd t && ./t4068-*.sh --verbose)

Output with --verbose:

expecting success of 4068.4 'diff with no merge bases':
        test_must_fail git diff br2...br3 >tmp 2>err &&
        test_i18ngrep "fatal: br2...br3: no merge base" err

test_must_fail: died by signal 6: git diff br2...br3
not ok 4 - diff with no merge bases
#
#               test_must_fail git diff br2...br3 >tmp 2>err &&
#               test_i18ngrep "fatal: br2...br3: no merge base" err
#
--=20
brian m. carlson: Houston, Texas, US

--tT3UgwmDxwvOMqfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXwULOwAKCRB8DEliiIei
gel/AP9OwSHeS7c7wxlvLJ1FrorUFwJkwGwHyaKBjbAznVPeswD9HY38BL6BUKQ7
g74FYA2sEnLLfxv+fay+ZXxeK310PgA=
=D9GF
-----END PGP SIGNATURE-----

--tT3UgwmDxwvOMqfu--
