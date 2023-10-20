Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD7A15E81
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A3693
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 03:04:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qtmN1-00078y-A0; Fri, 20 Oct 2023 12:04:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qtmN0-00306P-QD; Fri, 20 Oct 2023 12:04:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qtmN0-002Ri7-HC; Fri, 20 Oct 2023 12:04:42 +0200
Date: Fri, 20 Oct 2023 12:04:42 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: git@vger.kernel.org
Cc: Luben Tuikov <luben.tuikov@amd.com>,
	Michael Strawbridge <michael.strawbridge@amd.com>,
	entwicklung@pengutronix.de
Subject: Re: Regression: git send-email fails with "Use of uninitialized
 value $address" + "unable to extract a valid address"
Message-ID: <20231020100442.an47wwsti2d4zeyx@pengutronix.de>
References: <20231013141437.ywrhw65xdapmev7d@pengutronix.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6r7ew5vpi5zczxeh"
Content-Disposition: inline
In-Reply-To: <20231013141437.ywrhw65xdapmev7d@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org


--6r7ew5vpi5zczxeh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello,

On Fri, Oct 13, 2023 at 04:14:37PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> 	$ git send-email --to 'A B <a@b.org>, C D <c@d.org>' lala.patch
> 	Use of uninitialized value $address in sprintf at /usr/lib/git-core/git-=
send-email line 1172.
> 	error: unable to extract a valid address from:
>=20
> This happens for me with git 2.42.0 and also on master (59167d7d09fd, "Th=
e seventeenth batch").
>=20
> Bisection points at
>=20
> 	a8022c5f7b67 ("send-email: expose header information to git-send-email's=
 sendemail-validate hook")
>=20
> I didn't try to understand that change and fix the problem.

Another (similar?) problem with non-ascii-chars:

	$ git send-email --to 'Will Deacon <will@kernel.org>' --to 'Krzysztof Wilc=
zy=C5=84ski <kw@linux.com>' --to 'Lorenzo Pieralisi <lpieralisi@kernel.org>=
' --cc 'Rob Herring <robh@kernel.org>' --to 'Bjorn Helgaas <bhelgaas@google=
=2Ecom>' --cc 'linux-pci@vger.kernel.org' --cc kernel@pengutronix.de -1 --b=
ase=3D@~
	Use of uninitialized value $address in sprintf at /home/uwe/gsrc/git/git-s=
end-email line 1162.
	error: unable to extract a valid address from:

Bisection points to the same commit, when dropping =C5=84 in Krzysztof's
name, it works fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6r7ew5vpi5zczxeh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUyULkACgkQj4D7WH0S
/k45ewf/WZPwwxcHfH4YONzeec9snuhtHHgtCqID/RTdAESB2yyEs2ctwayLq87Z
xeWPR7YXyCQvoY8YyzWSjtCXszbBntZgXv1Ymfpzt8C3md2TeAknn69pJj2oHAHY
/CMMbKnSsMnt5U/QCTDox/ozqQVumr6PJEQYyC0bR43i/VZm+alBnfF/Za93SsVS
EVg2ZpsHvXqtLUK2E1cam/EXiMj+sd69sWypIrW7jRsSWekoQU7NdGEoaTnlsS8/
E0z2AFzIiBkN8oaUFMFm4GZCFOf0En8yayiEyiEMKJ37f+ML24ymfBHhI2UVYY/M
M+7oTUASbkdSa7BZPAD29xbXamvYKw==
=jnBG
-----END PGP SIGNATURE-----

--6r7ew5vpi5zczxeh--
