Return-Path: <SRS0=iV/m=CA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB632C433DF
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 01:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A629C2072D
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 01:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="jj+8RXGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgHVBQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 21:16:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45046 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726663AbgHVBQt (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 21 Aug 2020 21:16:49 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1C75F60450;
        Sat, 22 Aug 2020 01:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1598058975;
        bh=AkqAJNGWwCQVSzNI+KgENa/4akNL/g5myzhC1+CaDjA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=jj+8RXGXpLdghgNb5TK7X3nsP0UMccaHg0bXSwPdf50OR42/I9SAq0lm8Mmho1qEr
         I6Z7vs5Kg8Zw1IwIo+RpSn0OzwASfMYRxv16+ua/tzKd97Iv0K+mByesJjUWxhVatx
         nPwa/boQjnpfwAr1I/KXhpYVYYh5J5nBbCZBBdILp9RXTuTsOv+NlUMciqgl1qp1rt
         wEVX7F9cSYNwsUqKwMNa7fpv6h+GCfLgvqpEdm1HtHbZOfmKQ9J0Sss7i8GL5FhLtL
         P4yzQ2MN4dh69Wf4+OW3ABKed2c84TbrpN/QiUwSIHpWZi9BWtmH0yxtVPYtADlkbF
         33HDIaSz8ie/uZiRCIkBoi5fFcyReZBhq25NwKOeF4VqB9uOUNh3UodhqXjgU5RY/S
         l/uGhdo/aZSScQzXwSPy5eBhOx5xqQz48sh8M2OJNU+59zNyxO/H8jm2OR+dEcpp52
         yxBancFPYveiV8iJnRJjcbF0cAnoyCLW+8Epa9pgLzR2lUWWVXB
Date:   Sat, 22 Aug 2020 01:16:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] index-pack: adjust default threading cap
Message-ID: <20200822011607.GX8085@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20200821175153.GA3263018@coredump.intra.peff.net>
 <20200821175800.GC3263141@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="95puKF9o0QNvO5PE"
Content-Disposition: inline
In-Reply-To: <20200821175800.GC3263141@coredump.intra.peff.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--95puKF9o0QNvO5PE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-21 at 17:58:00, Jeff King wrote:
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index f865666db9..9721bf1ffe 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1798,9 +1798,22 @@ int cmd_index_pack(int argc, const char **argv, co=
nst char *prefix)
> =20
>  	if (HAVE_THREADS && !nr_threads) {
>  		nr_threads =3D online_cpus();
> -		/* An experiment showed that more threads does not mean faster */
> -		if (nr_threads > 3)
> -			nr_threads =3D 3;
> +		/*
> +		 * Experiments show that going above 20 threads doesn't help,
> +		 * no matter how many cores you have. Below that, we tend to
> +		 * max at half the number of online_cpus(), presumably because
> +		 * half of those are hyperthreads rather than full cores. We'll
> +		 * never reduce the level below "3", though, to match a
> +		 * historical value that nobody complained about.
> +		 */
> +		if (nr_threads < 4)
> +			; /* too few cores to consider capping */
> +		else if (nr_threads < 6)
> +			nr_threads =3D 3; /* historic cap */
> +		else if (nr_threads < 40)
> +			nr_threads /=3D 2;

I was going to ask if we could make the halving conditional on x86_64,
but it turns out POWER and UltraSPARC also have SMT, so that doesn't
make sense.  I expect that most users who have more than 6 "cores" are
going to be on one of those systems or possibly ARM64, and since the
performance penalty of using half as many cores isn't that significant,
I'm not sure it's worth worrying about further.  This will be an
improvement regardless.

Which is just a long way of saying, this patch seems fine to me.
--=20
brian m. carlson: Houston, Texas, US

--95puKF9o0QNvO5PE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX0Bx1QAKCRB8DEliiIei
gRYuAP4r85iMuljKL9nbLFSl77WglQFytWn2cWYYpwBdR2kZmwD+Jkw2bphlwTY1
hDhcdIieAvaqpP5wDsbU7vp82sYTFgQ=
=MdUJ
-----END PGP SIGNATURE-----

--95puKF9o0QNvO5PE--
