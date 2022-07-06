Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623FFC433EF
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 10:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiGFKjX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 06:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiGFKjV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 06:39:21 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF17167E5
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 03:39:21 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 2D8395A1A8;
        Wed,  6 Jul 2022 10:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1657103960;
        bh=Nyk3Ygic4KkYxldlyEHXserQA7JzKLHhKEckRSrPI9U=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=iKcLRN7q1YjvtTor4XARLsJdgL7TXAz9qotsyH0zcJ8x6eZ1huvxGCyBPl13jGks8
         jOMoCge40j4GKMOVEGhg+SZgF2F1TYOJLL1scw9i1vNX4HIfb1lC4+cENiyrzegh1Q
         95wexuSfxOs7HmNtedTZzCf7/mNFqqinmCwsNoNBLaK9UmEXPS6DVuSbm8K42OV4Aq
         hHjnwCaM4ue8WrIpUKskdA0UNNpYPC2Ncgl+C3bQ1UyHhr/YM3BjsBx8TvWpIVzJTN
         mW1f8ai3kyqRJ/64F2yvEPJLQ+i5XpxwLOZPF2a/x+QyX2zo5tnE06n6NVrrsfwg3G
         +mrbSADVQhbnKLlXSlxqoEp9ZfhNb/RvCCp7DEwfv48JCuTJJQm2QVxLj8UR6HvOpC
         2NfcK8RrpaqZmP6ZOG7EHQJmfrOEl80cUO7MYoauhawVuDZp1jGKx36leyVCpJ4zpL
         5d4MltRSQkY6vyUI//X+b0lXKFRQtOvtyQwnGOt3drOPg/T7Czg
Date:   Wed, 6 Jul 2022 10:39:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] sha256: add support for Nettle
Message-ID: <YsVmVsn65/NUKeXz@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
References: <20220705230518.713218-1-sandals@crustytoothpaste.net>
 <220706.86fsjeaalo.gmgdl@evledraar.gmail.com>
 <YsVUhjrxPGdZuVWN@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v3U1KBRC2gN64Ezq"
Content-Disposition: inline
In-Reply-To: <YsVUhjrxPGdZuVWN@coredump.intra.peff.net>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--v3U1KBRC2gN64Ezq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-07-06 at 09:23:18, Jeff King wrote:
> On Wed, Jul 06, 2022 at 10:45:06AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>=20
> > Would it be viable / at all sane to embed the part of the library we
> > need in our sources, similar to what we do for sha1dc? Or perhaps it's
> > not worth it at all...
>=20
> I doubt it's worth it. It's a big library with tons of algorithms, most
> of which we won't need. And the implementation has lots of asm and
> platform-specific knobs. I wouldn't want to try extracting any of that
> from their autoconf file, nor putting (more) autoconf inside our
> repository.

Yeah, it requires doing a CPUID check on different platforms to
determine which CPU to use at runtime.  Depending on platform, CPUID
isn't always available, and sometimes you end up needing to use a
different method, which we wouldn't want to port here.

If we just want a basic option, we have that in the block SHA-256
algorithm, which is probably no better or worse than Nettle's
implementation.

> For sha1dc, I think including a vendored copy was important for us
> making it the default, and we wanted to do that for the security
> implications. A 12% speedup is OK to leave on the able for the default
> build, and people can easily link against the system libnettle if they
> care enough. And other linkable implementations are in the same boat;
> openssl is even faster than libnettle on my machine.

Right.  I'm not surprised that OpenSSL is faster here, and that's
expected, since OpenSSL tends to outperform other libraries.  Even with
SHA-NI extensions, it's slightly faster still (1.415 s vs. 1.529 s for a
2 GB file), but I'm sure with a small amount of tuning Nettle could
catch up, because it's essentially the same instructions.

For block SHA-256, the time taken for the same file is 7.296 seconds, so
the performance improvement is substantial if you have the extensions
(and maybe even if you don't since both Nettle and OpenSSL have SIMD
implementations as well). That's why I wanted to send this patch: I'd
like to see if Debian can link against libnettle in the future,
especially since it's already in at least some binaries due to GnuTLS.

For SHA-1 DC, we definitely want it to be the default for security, so
vendoring a copy matters.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--v3U1KBRC2gN64Ezq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYsVmVgAKCRB8DEliiIei
gT7nAQClE7s0f4aBe3axjIXTaLhyF6pMioz3fVdKB9vu9G7SzQEA58iNAhBN+tf4
a1uQn1F3yIlPPRFN7BkgjcsHrUWxHQc=
=CaYK
-----END PGP SIGNATURE-----

--v3U1KBRC2gN64Ezq--
