Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CA0C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 02:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbiCHCVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 21:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236987AbiCHCVf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 21:21:35 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE2E31DDD
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 18:20:39 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 7B4FC5A3BB;
        Tue,  8 Mar 2022 02:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1646706038;
        bh=w5vH4pAqB5YTz8m9PCPB97xyD6QWTuTsquZmynIKlV4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TcM2YJNDsjLKbriPOGhOLCTQw52UYXQQ8S6fXE0UInSyFg3jTGhOKQqtY1tSjOyMO
         Q4ZffarqFaj237dF/htrZo2h6EEuPgQ/N63XzuT28KKgHpTZqMJEXc3cxUycmSH6BN
         LohAvlIrJEUY9DHvPcE8FHbnp1Sc2skGsOsISrDO5ttAiljInSCwp27LTEKhoedn3R
         ArmXAE+nEgUzRweCelOQ1kKXv3q1klh2GjfBy87ESaX2hYjLEoEo7yhIeEX4Fw7IIo
         REbH4oYgAVdWoEQLxue8uAaEtwK/ZXy4+8RUgDqou0GkFQw2BqY5y32gGzPstetsUu
         Xd8c0OUu+WakKf9DVlSAUNqd+CyV6ZqwHEHB2M9rrypbDtzw/yBsgWZHe6mzv+iH2U
         7a9eGCbDH5Pe7S+OKcGQoHXqHYaEnrdDU7rkMaRYP7g1tt2H0zAhjvhL2UWtqW8IUy
         HPvrmCmrgMcdMz/MP/37XzwWmkKYqgN5wljj9Rl6SyTrAgGBABu
Date:   Tue, 8 Mar 2022 02:20:37 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] block-sha1: remove use of assembly
Message-ID: <Yia9dQ32uYCCpIsm@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <20220307232552.2799122-1-sandals@crustytoothpaste.net>
 <YiaWGrBNuk1+j89z@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GHT9eApHSg3GkkC7"
Content-Disposition: inline
In-Reply-To: <YiaWGrBNuk1+j89z@nand.local>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GHT9eApHSg3GkkC7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-03-07 at 23:32:42, Taylor Blau wrote:
> On Mon, Mar 07, 2022 at 11:25:52PM +0000, brian m. carlson wrote:
> > In the block SHA-1 code, we have special assembly code for i386 and
> > amd64 to perform rotations with assembly.  This is supposed to help pick
> > the correct rotation operation depending on which rotation is smaller,
> > which can help some systems perform slightly better, since any circular
> > rotation can be specified as either a rotate left or a rotate right.
> > However, this isn't needed, so we should remove it.
>=20
> At -O1 or higher (at least on GCC) this optimization is indeed
> performed. Here's a Godbolt example that shows this:
>=20
>     https://godbolt.org/z/9zMP93hr1
>=20
> so I agree that this code isn't helping us at all. And in the
> meantime...

Thanks for providing a link.  I also did a similar test there with
slightly different code (and unfortunately closed the window before
saving the link) but it demonstrated the same thing: that the compiler
can optimize this case adequately.  My (substantially) past experience
with testing GCC in this case has shown the same thing.

> > The downside of using this code, however, is that it uses a GCC
> > extension, which makes the compiler complain when using -pedantic unless
> > it's prefixed with __extension__.  We could fix that, but since it's
> > not needed, let's just remove it.  We haven't noticed this because
> > almost everyone uses the SHA1DC code instead, but it still shows up for
> > some people.
>=20
> ...it makes it impossible to compile git if you have
> `BLK_SHA1=3DYesPlease` and `DEVELOPER=3D1` in your environment. So I am
> happy to see this go.
>=20
> On another note: missing Signed-off-by?

I'll send an otherwise unchanged v2 with that in a second.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--GHT9eApHSg3GkkC7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYia9dAAKCRB8DEliiIei
gYM8AQDe1BgItNM3zjV5ePtnXRb/tpyQes1gfzf4bizP9U/sVAEA20nYb9mXSedK
0WJ4GoMGrzb3Wvtf6z0tt99rtbXfFQs=
=blRF
-----END PGP SIGNATURE-----

--GHT9eApHSg3GkkC7--
