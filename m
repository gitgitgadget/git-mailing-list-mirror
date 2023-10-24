Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DFF2745C
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F303E9
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 06:00:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qvH1Z-0000VO-5j; Tue, 24 Oct 2023 15:00:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qvH1X-003wyi-No; Tue, 24 Oct 2023 15:00:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qvH1X-005G70-EY; Tue, 24 Oct 2023 15:00:43 +0200
Date: Tue, 24 Oct 2023 15:00:37 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michael Strawbridge <michael.strawbridge@amd.com>
Cc: git@vger.kernel.org, Luben Tuikov <luben.tuikov@amd.com>,
	entwicklung@pengutronix.de
Subject: Re: Regression: git send-email fails with "Use of uninitialized
 value $address" + "unable to extract a valid address"
Message-ID: <20231024130037.sbevzk2x7oclj7d7@pengutronix.de>
References: <20231013141437.ywrhw65xdapmev7d@pengutronix.de>
 <20231020100442.an47wwsti2d4zeyx@pengutronix.de>
 <68d7e5c3-6b4a-4d0d-9885-f3d4e2199f26@amd.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6jyhgfocsyzwfvng"
Content-Disposition: inline
In-Reply-To: <68d7e5c3-6b4a-4d0d-9885-f3d4e2199f26@amd.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org


--6jyhgfocsyzwfvng
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Oct 20, 2023 at 05:06:36PM -0400, Michael Strawbridge wrote:
> On 10/20/23 06:04, Uwe Kleine-K=C3=B6nig wrote:
> > hello,
> >=20
> > On Fri, Oct 13, 2023 at 04:14:37PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> >> Hello,
> >>
> >> 	$ git send-email --to 'A B <a@b.org>, C D <c@d.org>' lala.patch
> >> 	Use of uninitialized value $address in sprintf at /usr/lib/git-core/g=
it-send-email line 1172.
> >> 	error: unable to extract a valid address from:
> >>
> >> This happens for me with git 2.42.0 and also on master (59167d7d09fd, =
"The seventeenth batch").
> >>
> >> Bisection points at
> >>
> >> 	a8022c5f7b67 ("send-email: expose header information to git-send-emai=
l's sendemail-validate hook")
> >>
> >> I didn't try to understand that change and fix the problem.
> >=20
> > Another (similar?) problem with non-ascii-chars:
> >=20
> > 	$ git send-email --to 'Will Deacon <will@kernel.org>' --to 'Krzysztof =
Wilczy=C5=84ski <kw@linux.com>' --to 'Lorenzo Pieralisi <lpieralisi@kernel.=
org>' --cc 'Rob Herring <robh@kernel.org>' --to 'Bjorn Helgaas <bhelgaas@go=
ogle.com>' --cc 'linux-pci@vger.kernel.org' --cc kernel@pengutronix.de -1 -=
-base=3D@~
> > 	Use of uninitialized value $address in sprintf at /home/uwe/gsrc/git/g=
it-send-email line 1162.
> > 	error: unable to extract a valid address from:
> >=20
> > Bisection points to the same commit, when dropping =C5=84 in Krzysztof's
> > name, it works fine.
> >=20
> This is interesting.  Thanks for reporting it.  If you are able, could yo=
u please try the patches found in the below threads:
> - https://public-inbox.org/git/20230918212004.GC2163162@coredump.intra.pe=
ff.net/T/#mae64003cbb72f015bf5c0c04216524fcb6bb8d09

On main (2e8e77cbac8a) this one is already applied, with that the error
message reduces to:

	$ git send-email --to 'Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.=
de>' -1
	error: unable to extract a valid address from: Uwe Kleine-K=C3=B6nig <u.kl=
eine-koenig@pengutronix.de>

> - https://public-inbox.org/git/f5c6a72b-f888-4d43-8be8-3ce2c878c669@gmail=
=2Ecom/T/#mca12dc95ccfd3ce2b94e7752ebaae9891201084f

This one doesn't help either. With it applied on top of main I get the
sams result as on vanilla main.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6jyhgfocsyzwfvng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmU3v/EACgkQj4D7WH0S
/k6a0Af/Vx8fOxVczF4yfjPUh9smhkEGMOgp43gWrhsk0OAtOJfF8fLcjXIFV/2z
Vc8h2V99NnQADj0PI4g7US9DWT4ftKM1TI8zbqDUViffNX0nNyTYHE/XRi2HFuh6
BUNp7inhiYXcmM5/R0bw86RWsLUdQx6QBhrtKaMGFqxXLOVdNHAisy/1wAB+F5PB
wjCWSbNxldLWh+ZD3fj9Lx5qyAtPPAglhoex7LVZdKtdPdyIy8Fs0qDhC5TQp1Tn
UWE5Xst2t2hVkx68sbRgSpdXcxOY/lVDDqSgWrXBgM0OC1UG+LDnLrpW/TOzfYsp
jGVzmOAXgBO+AF5s+DRVI1JXJrNG7w==
=Ribv
-----END PGP SIGNATURE-----

--6jyhgfocsyzwfvng--
