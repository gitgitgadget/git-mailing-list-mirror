Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA84318C2E
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="tQeYvvAC"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E421B1
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 12:36:38 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 460635B09C;
	Fri, 27 Oct 2023 19:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1698435398;
	bh=WlZp0CfCKHfKr16wXgOof+IJL64umL6WxKolwyQhx9A=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=tQeYvvACtARtYDyV6L/ljou9Byg/pSNrG8Lq8MkKmJGtQiXKZ+bV2XyKcc9jTxNmn
	 en6wgnSEJE9iCICVeQy1sETfAPhFJM5Cp9pwizANNSoVo6yKER2liMJ/epjcnklx/z
	 GDOyL9hXgNjmkAKdZlMQEK/bk1+gon0SD+M2NKcsfcd8WOfDbv6MmwnnTktl6UTmWl
	 Gv2JVz3gecpOq0he0PgNSu1NrlmJ1X3jN4a+2am6mzLthTsGHQRZ4Sr6uYHgL95CaD
	 SDnjnPmXNKaOQ/FAd0AzeiURXrOcG9Qv3ECrc2SenKkOylsvd/KEEi9GUQ8Zho0QJe
	 EO/x7HQk1oZwq3gE8Cz4xBEvdq9HhSx91k2n55WDDbN6yYmoetiio6I+kohvphdzV0
	 TbImPvwRLGuFSHXUzHeCmx/iA8ZSS6rwvuPtO0XXlskNNuy4SQGje8HlLEu4XfBhk1
	 jAAucAoPQ1Z3TpjIMBOdh7aem8buuJV8vwwosiSXpwuqKG65fc4
Date: Fri, 27 Oct 2023 19:36:36 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Constant recompilation when GENERATE_COMPILATION_DATABASE is set
Message-ID: <ZTwRRHhHxGt1nwL9@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Philippe Blain <levraiphilippeblain@gmail.com>, git@vger.kernel.org
References: <ZTui2NcJ3Ax_PIGO@tapette.crustytoothpaste.net>
 <76c5f401-0b29-b19a-8424-5bca5df2252e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6q7Qma7OJIl0e705"
Content-Disposition: inline
In-Reply-To: <76c5f401-0b29-b19a-8424-5bca5df2252e@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--6q7Qma7OJIl0e705
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-10-27 at 15:41:23, Philippe Blain wrote:
> One way to fix this is to use the same trick that is used for the '.depen=
d' directories
> created to hold the Makefile dependencies:=20
>=20
> diff --git a/Makefile b/Makefile
> index 5776309365..f6f7255dd1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2701,7 +2701,7 @@ endif
>  compdb_dir =3D compile_commands
> =20
>  ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
> -missing_compdb_dir =3D $(compdb_dir)
> +missing_compdb_dir =3D $(filter-out $(wildcard $(compdb_dir)), $(compdb_=
dir))
>  $(missing_compdb_dir):
>  	@mkdir -p $@
> =20
> That is, we define missing_compdb_dir to 'compile_commands' only if the d=
irectory
> is not yet created.

I can confirm that this solves my problem very nicely.  Thanks for such
a fast response.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--6q7Qma7OJIl0e705
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZTwRRAAKCRB8DEliiIei
gQAPAPsEFpaI34xmIH09YI5qr9NS1N0kT/0w3HowkAVNZBzCEAEAzcJZ+I9iFg4M
s1Bcyy1vLIbWT1rAzTqFBx+cu/BvYwE=
=IMAg
-----END PGP SIGNATURE-----

--6q7Qma7OJIl0e705--
