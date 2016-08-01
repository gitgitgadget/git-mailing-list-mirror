Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E4541F858
	for <e@80x24.org>; Mon,  1 Aug 2016 01:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbcHABnM (ORCPT <rfc822;e@80x24.org>);
	Sun, 31 Jul 2016 21:43:12 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:34336 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751377AbcHABnK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2016 21:43:10 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:395:747d:98e1:fc48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D213C280A6;
	Mon,  1 Aug 2016 01:43:08 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1470015788;
	bh=oo7dw6VjyDeTHv03HsOltys7MLlgmgaprZ+9s2WNnm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rFrBA1JXS1P5cHHQuwS0QclpHjtyAyOwn+ShwTOVYFFyHxVm/XvlQ5TeKyN+v5d9e
	 FaoCEsqiUX6XzfCvO8a4w+nI1I71oUAv/jhXh2uggxOj/O5VMzcgPHJVuYzcz1eXtj
	 f55KJYTPwk6PgVZmNcETGwRkCjNmcb69/cWgWuwWYVVE9LMe06x5lI0LsmjITVsG3M
	 JJ9kofygwmggnCRaLOjK7Z3Vud8lOT6qDFUKpcAfANiw6DCRufvFeqy7kmnxDEQ8UP
	 huJsgtMM2bIujZu1b/sDpUSPqyZoLMLzhSRU8DZ399uvWr/xM4BADeZk1hqrPCWBhu
	 6yYy+RxXjR6CEq3VxlwH8ph6hKiMm3yDPBTCJIVZXKjYVSzMry0vdjLC6aAfMwFmBR
	 LQj2ftNIX0ooFQbpQ5+qPRIziI9UwflaqnOgVGz7OD++j3zZCAKAEZePQ1xMUq+riG
	 34pZay10u8GHnZZEieFmx23w88ow9EitkuAiYLbnyS4KENvlV31
Date:	Mon, 1 Aug 2016 01:43:03 +0000
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	Eric Wong <e@80x24.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] pager: move pager-specific setup into the build
Message-ID: <20160801014303.x5j3dqumcmrkyc76@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>,
	git@vger.kernel.org
References: <20160801010557.22191-1-e@80x24.org>
 <20160801010557.22191-2-e@80x24.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s3z7h7zyi77hjfec"
Content-Disposition: inline
In-Reply-To: <20160801010557.22191-2-e@80x24.org>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-rc4-amd64)
User-Agent: Mutt/1.6.2-neo (2016-07-23)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--s3z7h7zyi77hjfec
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 01, 2016 at 01:05:56AM +0000, Eric Wong wrote:
> +static void setup_pager_env(struct argv_array *env)
> +{
> +	const char *pager_env =3D stringify(PAGER_ENV);
> +
> +	while (*pager_env) {
> +		struct strbuf buf =3D STRBUF_INIT;
> +		const char *cp =3D strchrnul(pager_env, '=3D');
> +
> +		if (!*cp)
> +			die("malformed build-time PAGER_ENV");
> +		strbuf_add(&buf, pager_env, cp - pager_env);
> +		cp =3D strchrnul(pager_env, ' ');
> +		if (!getenv(buf.buf)) {
> +			strbuf_reset(&buf);
> +			strbuf_add(&buf, pager_env, cp - pager_env);
> +			argv_array_push(env, strbuf_detach(&buf, NULL));
> +		}
> +		strbuf_reset(&buf);
> +		while (*cp && *cp =3D=3D ' ')
> +			cp++;
> +		pager_env =3D cp;
> +	}

So it looks like this function splits on spaces but doesn't provide any
escaping mechanism.  Is there any case in which we want to accept
environment variables containing whitespace?  I ask this as someone that
has EDITOR set to "gvim -f" on occasion and seeing how tools sometimes
handle that poorly.

Even without that, I think this series is probably an improvement over
the status quo.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--s3z7h7zyi77hjfec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.13 (GNU/Linux)

iQIcBAEBCgAGBQJXnqknAAoJEL9TXYEfUvaLeL8P/2rLVxp58irgeQEP1us8DFtN
fT7uQOlI/glVsw0LdnCPyc8H83eFHEzWCk9nxrcRJTlQUF+ux72+FAV0F+y9aDSc
/zBYWJurYKEu1LjR9DTVqB6klbTolIvNAbaWpOgd3vFqecxw4rxQI2NYSzf0IDYC
JgUvH3i2Cl59bG05m51bTe8CZuk/ivbDaE/Huldu6c9VGXJEEKWtkKPBuKSmaY13
NfuwMklIo1TSXy3BamDHq6olFSNkvmwphCqTVtGTIt08MHuWgfPhasAuubU1q9MF
h8ibWUJ+XkTi4T7kbBF4SHrHUPhhTSax8WiYO+xqVVZQm7tdSDttyqekGohxJIr4
A2AJLMazhlhUBpZvwj3c5NsTDiXMr/19IB2yFHU8CnqcUZQYm4JRcA5MK0Apm80H
KyjzQFAMG4f6wl/kdzgpNamSEK98j87Y1FtTfHQe9aGCLoU09Nf44ipYEucSi4iv
anrAaNNql2gcaYWo+A7SZIqukrGyO4bWX2jRao+n/2vfriZVKDujAi2Baa8VfiP3
AhB+/voA/7SyH+HMAusKJY0zAEbpWncm5eALLTof7yKShVd9p2w9Vuu9X18SQoHX
xYFYQcCfD6NUdS05ZSkN6KJGYObeZoNORPPDi8drxiNzjygiStAUHYQPx/yQNnB0
yJQFmDRNsPux33ocH9CW
=TODb
-----END PGP SIGNATURE-----

--s3z7h7zyi77hjfec--
