Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B60F91F463
	for <e@80x24.org>; Sun, 15 Sep 2019 15:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbfIOPPX (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Sep 2019 11:15:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58718 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726268AbfIOPPX (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Sep 2019 11:15:23 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:4d4d:a9ce:2c0a:3d66])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1B4E36074C;
        Sun, 15 Sep 2019 15:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1568560521;
        bh=clA4zoGcmH6zrDUTGVnZfJBGPyTHTTa3oZWS3Raklcw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=X19eIWn+fue01H+pn/BgbTiaB/agNmhoM90eYjtT4fO9s8VEi0eB2YDyic1K0C/1b
         TaflF5yTjHaORuevjAUP6OVer2uehcHVVx5iXw/jvtv/sZOtFUF3h2VG3l6BlbH8Bn
         Z4YqDnVl3mYTEsKRVyIMLUSRJK50wfDLX4fHBn+cWuD2xrdGcBaHbYSxHlTA61nfAg
         CEkH+NVRwNULPwOc/aKL5otwIssNChUu9lWNK7Fw9XF/xcke7m0eK0cHudzwZCUy0R
         QbkR5mi49B6Yg3Z9N0DlswYaQbTKtpyu30apQfkbdun/qSA7g/4YmPF47U0xXOb8Ld
         c18MRy4NGydxmKnv4wlqMT+KmAc6IdDFePFx0KQPLsxtMIj2b8oPlVHVsuvrxsB+rB
         05pUE1iSset1c2G6TKcU/ooT55UImfUTDlaAN03dy43jhrK8eRJJjntPDA5Fu1qDtE
         NvuDFJXK6mWSnsCqYZblpsc6FeVFwa0x/RHbOLSLINLO3yRlILM
Date:   Sun, 15 Sep 2019 15:15:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] sha1-name: check for overflow of N in "foo^N" and
 "foo~N"
Message-ID: <20190915151513.GU11334@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <c43610f2-a51f-7333-a200-a76930a0b705@web.de>
 <2be6e3ee-209e-9cd1-eb43-284f9a8462b3@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cqG5pBpskktEuCrX"
Content-Disposition: inline
In-Reply-To: <2be6e3ee-209e-9cd1-eb43-284f9a8462b3@web.de>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cqG5pBpskktEuCrX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-15 at 12:10:28, Ren=C3=A9 Scharfe wrote:
> Reject values that don't fit into an int, as get_parent() and
> get_nth_ancestor() cannot handle them.  That's better than potentially
> returning a random object.
>=20
> If this restriction turns out to be too tight then we can switch to a
> wider data type, but we'd still have to check for overflow.

Certainly we want Git to perform as well as possible on large
repositories, but I doubt if it will scale to more than 2 billion
revisions, even with significant effort.  I think this restriction
should be fine.

> diff --git a/sha1-name.c b/sha1-name.c
> index c665e3f96d..7a047e9e2b 100644
> --- a/sha1-name.c
> +++ b/sha1-name.c
> @@ -1160,13 +1160,22 @@ static enum get_oid_result get_oid_1(struct repos=
itory *r,
>  	}
>=20
>  	if (has_suffix) {
> -		int num =3D 0;
> +		unsigned int num =3D 0;
>  		int len1 =3D cp - name;
>  		cp++;
> -		while (cp < name + len)
> -			num =3D num * 10 + *cp++ - '0';
> +		while (cp < name + len) {
> +			unsigned int digit =3D *cp++ - '0';
> +			if (unsigned_mult_overflows(num, 10))
> +				return MISSING_OBJECT;
> +			num *=3D 10;
> +			if (unsigned_add_overflows(num, digit))
> +				return MISSING_OBJECT;

I was worried whether these functions only handled size_t or if they
also handle unsigned int, but I checked and they seem to be fine for any
unsigned type.

> +			num +=3D digit;
> +		}
>  		if (!num && len1 =3D=3D len - 1)
>  			num =3D 1;
> +		else if (num > INT_MAX)
> +			return MISSING_OBJECT;
>  		if (has_suffix =3D=3D '^')
>  			return get_parent(r, name, len1, oid, num);
>  		/* else if (has_suffix =3D=3D '~') -- goes without saying */

This approach seems reasonable.  I must admit some curiosity as to how
you discovered this issue, though.  Did you have a cat assisting you in
typing revisions?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--cqG5pBpskktEuCrX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1+VYEACgkQv1NdgR9S
9otTxRAAya4M/FQdat8zHcSYmLWGFvtAhJMccFwGhzRURsUW5J2k6gEgmXutT3fS
Cjaw5PigvGEAQJng3mKXIu8fsd0Li2McOMAWXinL7YHcjuJledwxUXHbrxUMKEYU
P9n1OHp2ISpguEw9b11dgVyARdpDVw2etx1ysIA6onSUYYTWLnYrNo5O79Q7BHsC
2WZqSrTzdFjhuhig19Fh+OfYvvsMPi15mj51C6qE2MsALpDXtpnPJ7TWU2T0OJUO
uWJg240VU06x+3AldkJXFUmSq905RXzKvpPd7o6tz5QsuhMZ9hivdkpdRUyooXaQ
1hdCEbXpf5+J18smk2V3O/Xu1i4edl49g5REwdUSYHeeWvhu2fenr6+oAYa8C5vC
3oqIDqwyumG+dv7ufAhlYIY/TYU+Mcehw8u1RSISbFiEyKC9gqVpi1Brfs5vpCms
h1IE3h26jiCWNnpd+erOJyoergySlmVMAOhIZsCsm/2rIEoksr9sjz3Vd1j0UuIn
JBX3G0JqJD5oTDM1TZNosnt3XqvsvRqFOj9CENZC8FisZck7Fg/o4ZvNpFlayui2
2PcFhQpJtfDmrq0V5/usQygYReEihVMrt1e5h1WZiy8WqiwHJgKtZNH9xVMlYqrO
7l6H6HgEdavsG0FFvwEoXGWHxGtQfbXJI5E6brwPaH0v2WPatuQ=
=jTup
-----END PGP SIGNATURE-----

--cqG5pBpskktEuCrX--
