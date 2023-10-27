Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD43E53B7
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 11:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FX4yN4/l"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9942BAC
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 04:45:30 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id DEC255B09A
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 11:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1698407129;
	bh=wcttFuozrQSJ97PJkoDBAisa6D3eb4URU4Pf94t//5Y=;
	h=Date:From:To:Subject:Content-Type:Content-Disposition:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=FX4yN4/lXsoKfSA3Q6qWNVVuBv9ZN8qXu3umfUP7Dkd4x9y+rCdf9TZU1m+GRfjEi
	 dxnLmYZbUSTjQvodbGzR9fdKNDULIYbgY/Fb/kFjxvSeGleDPa60jEYxiR/ZwdvaGB
	 OZeI6fcKVngEhm5/LyD4uaJ+XQotnAnBAd+ZctBYTkBhhbXGUqAly/9qPnAhJGvWmf
	 bpgnRNAF1mGPs08VuJ2R1urTt5YdIWgO16XbIv2/1RatoewKIevTtNObEUrG+gOCiS
	 H6cmeXd8ijQRZg1Z3DERWSHCO7EHEadXNKJRafXdb8t0kMerC629VI8YU+eMGUaMg0
	 xunOldgEVuQogwMROgQAPpVgxLSOOkDumf0S8bKGfIPdEgDRrRh19P5woETRA/oDP2
	 YKCfqy7af15YcHKM5IdfnLym2J3x3sC7CRsKY3hkq/nyYcMtmGdj/BxLjhl0u1j/eW
	 /RPUKlrEW6zjos0zRleRWZE4xPCVusR+JFqj0ND9WkNfVzP2xnF
Date: Fri, 27 Oct 2023 11:45:28 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: git@vger.kernel.org
Subject: Constant recompilation when GENERATE_COMPILATION_DATABASE is set
Message-ID: <ZTui2NcJ3Ax_PIGO@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UVNBg7Upk7W8iEsu"
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Level: *


--UVNBg7Upk7W8iEsu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I typically use clangd with Git for the nice language server protocol
(LSP) support.  I noticed that when GENERATE_COMPILATION_DATABASE is set
(which is used so clangd can find the proper flags), `make` rebuilds all
of the files every time, even if I do it back to back.  This persists
even after a `git clean -dxf`.

Obviously, this is not great, since it means the turnaround time to
compile changes is slower.  Unfortunately, I'm not a huge expert in make
and I'm unsure what the right solution is here.  I'd appreciate anyone's
thoughts on how to improve this.

This is on a Debian sid (unstable) amd64 system with the following
configuration.  The version of clang in use is Debian's 16.0.6.

----
NO_OPENSSL=3D1
DC_SHA1=3D1
NETTLE_SHA256=3D1
DEVELOPER=3D1
NO_SVN_TESTS=3D1
NO_PYTHON=3D1
USE_ASCIIDOCTOR=3D1
USE_ASCIIDOCTOR_MANPAGE=3D1
CC=3Dclang
GENERATE_COMPILATION_DATABASE=3Dyes
CSPRNG_METHOD=3Dgetrandom getentropy
----
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--UVNBg7Upk7W8iEsu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZTui2AAKCRB8DEliiIei
gXatAQDwn8XMTXoGs1IcZvnRAXb0LNfjq34E2IXYEhqllWuYSgD+M06pe8CdTUoh
AHrkkzX1WzBEgid4/5oWrM5Zj+I2BgE=
=vlHf
-----END PGP SIGNATURE-----

--UVNBg7Upk7W8iEsu--
