Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD8E1173A
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 20:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5732210C3
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 13:43:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qvOFD-0001oP-NQ; Tue, 24 Oct 2023 22:43:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qvOFD-0041Xb-1u; Tue, 24 Oct 2023 22:43:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qvOFC-005Wvt-Ou; Tue, 24 Oct 2023 22:43:18 +0200
Date: Tue, 24 Oct 2023 22:43:18 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michael Strawbridge <michael.strawbridge@amd.com>
Cc: Luben Tuikov <luben.tuikov@amd.com>, git@vger.kernel.org,
	entwicklung@pengutronix.de
Subject: Re: Regression: git send-email fails with "Use of uninitialized
 value $address" + "unable to extract a valid address"
Message-ID: <20231024204318.gi6b4ygqbilm2yke@pengutronix.de>
References: <20231013141437.ywrhw65xdapmev7d@pengutronix.de>
 <20231020100442.an47wwsti2d4zeyx@pengutronix.de>
 <68d7e5c3-6b4a-4d0d-9885-f3d4e2199f26@amd.com>
 <20231024130037.sbevzk2x7oclj7d7@pengutronix.de>
 <89712aea-04fc-4775-afd4-afd3ca24ad01@amd.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m4vfhh7kkidpznpi"
Content-Disposition: inline
In-Reply-To: <89712aea-04fc-4775-afd4-afd3ca24ad01@amd.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org


--m4vfhh7kkidpznpi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Michael,

On Tue, Oct 24, 2023 at 03:00:38PM -0400, Michael Strawbridge wrote:
> On 10/24/23 09:00, Uwe Kleine-K=F6nig wrote:
> > On Fri, Oct 20, 2023 at 05:06:36PM -0400, Michael Strawbridge wrote:
> >> On 10/20/23 06:04, Uwe Kleine-K=F6nig wrote:
> >>> On Fri, Oct 13, 2023 at 04:14:37PM +0200, Uwe Kleine-K=F6nig wrote:
> >>>> 	$ git send-email --to 'A B <a@b.org>, C D <c@d.org>' lala.patch
> >>>> 	Use of uninitialized value $address in sprintf at /usr/lib/git-core=
/git-send-email line 1172.
> >>>> 	error: unable to extract a valid address from:
> >>>>
> >>>> This happens for me with git 2.42.0 and also on master (59167d7d09fd=
, "The seventeenth batch").
> Hm.  I tried reproing with master (59167d7d09fd, "The seventeenth batch")=
 but I don't seem to see an error:
> ```
> $ git send-email --to 'Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de=
>' -1 --smtp-server=3D"$(pwd)/fake.sendmail"
> [...]

I debugged a bit and if I do

	mv .git/hooks/sendemail-validate .git/hooks/sendemail-validate.bak

git send-email --to 'Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>'
starts to work for me, too.

I'd guess the content of my sendemail-validate script doesn't matter
much, but for the record, it's:

	#!/bin/sh
	# installed by patatt install-hook
	patatt sign --hook "${1}"

Does the problem reproduce on your end with a sendemail-validate script?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--m4vfhh7kkidpznpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmU4LGUACgkQj4D7WH0S
/k6miQf8CG+Q1gq7QPR5l78KRfSnBbv4mR+R1OPpv92E14dH6WIXGIErOekEb0rE
5lpMny3iy0b+glXVxYsd+/QyE86y7LyDZXflHDEdEPU3x6odXQmOoZbWdK7Rc0k/
z8f0AIVCfDnqZ5woJ5XMsnyQBhI3hbSICffsUUGMXIqz3De6uURbgmg5/1YrJcVW
LWq6vZdfo+3XTAzKQcrmnJUqJX7xB7lRBK9irY+t6s5GGdaMLwcrkGNnOngLHECh
zasGJDge/MC/9QMFag04CquSgaE/lkftSUOLo2Jo2ZWnBmAHf07P04QbkZh5YjAV
G/WYThbHu9R2YzeS1z20HkgA3+ZPxA==
=gmPm
-----END PGP SIGNATURE-----

--m4vfhh7kkidpznpi--
