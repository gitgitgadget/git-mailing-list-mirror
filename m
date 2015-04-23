From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] connect: improve check for plink to reduce false
 positives
Date: Thu, 23 Apr 2015 23:14:04 +0000
Message-ID: <20150423231403.GC274681@vauxhall.crustytoothpaste.net>
References: <20150422232306.GA32705@peff.net>
 <1429747595-298095-1-git-send-email-sandals@crustytoothpaste.net>
 <1429747595-298095-2-git-send-email-sandals@crustytoothpaste.net>
 <b6b4da1f7735b834043375e3d8eaa331@www.dscho.org>
 <20150423155304.GA26018@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 24 01:14:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlQJz-0000Kk-HO
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 01:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758480AbbDWXOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 19:14:11 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:45863 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758472AbbDWXOJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2015 19:14:09 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:112:d5ce:1b0:b59a])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C62232808D;
	Thu, 23 Apr 2015 23:14:07 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Content-Disposition: inline
In-Reply-To: <20150423155304.GA26018@peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16.0-4-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267712>


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2015 at 11:53:04AM -0400, Jeff King wrote:
> On Thu, Apr 23, 2015 at 08:50:17AM +0200, Johannes Schindelin wrote:
>=20
> > > +				tortoiseplink =3D tplink =3D=3D ssh ||
> > > +					(tplink && is_dir_sep(tplink[-1]));
> >=20
> > Maybe have a helper function here? Something like
> > `basename_matches(const char *path, const char *basename, int
> > ignore_case)`? That would be easier to read (I have to admit that I
> > had to wrap my head around the logic to ensure that tplink[-1] is
> > valid; It is, but it requires more brain cycles to verify than I would
> > like).
>=20
> Yeah, I had a similar thought when reading the patch.

I was questioning whether a comment would have been helpful.  Apparently
the answer was yes.

> If I were writing from scratch, I would probably keep things as tight as
> possible, like:
>=20
>   const char *base =3D basename(ssh);
>   plink =3D !strcasecmp(base, "plink") ||
>           !strcasecmp(base, "plink.exe");
>   tplink =3D !strcasecmp(base, "tortoiseplink") ||
>            !strcasecmp(base, "tortoiseplink.exe"));
>=20
> but maybe that is too tight at this point in time; we don't really know
> what's out there and working (or maybe _we_ do, but _I_ do not :) ).
>=20
> At any rate, brian's patch only looks for a dir-separator anywhere, not
> the actual basename. So:
>=20
>   /path/to/plink/ssh
>=20
> would match, and I'm not sure if that's a good thing or not.

This is true.  In hindsight, I think it's probably better to be a bit
stricter, so I'll reroll to use the stricter format.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVOXy7AAoJEL9TXYEfUvaLDdcQALR9T3Oen3u3jGUfokSuDIEA
Z+eGOQzYCnHAXONmh9ULW9QVuflyXDyhYEutBwhYW/GYwxdcDVwCmqtFTJnmkkgK
BnvGp8ApdlKq/grhx0UfONH4tXWTMBh6VoMwYGpxbOe7VwSFvNtjm6/ZwIOE2leF
TyuLZX+0+4VJltdP7CvhScWpFm9QgxLsvS90ClpnFj3PDjtE+T+Fo75VBnHYM+A7
uECIw8O7Df5F7RRLrLCwQHm+ouDe3MSDgdVe7tC3j5rYa3cmXhkGIvn8Lym/+2ft
zCxrhc55ooJ9r3YU9jsnKuLKNSVowqBZsDVAVspkC5i/4cYrCS27lSyyBrxABPn0
pIFnSeUkCXPDYZMdghV7a7Fvsj4ItRIKMfgQubHEvoi9DSkHDXRxALsmYlc0VVZh
nE5gxiArj6xTySiLLMiE5rprNIjVGbJD+yZCoZlUEpqDW56GE5kIZviRaYz3Ds2H
QIKNizE24MmgO2fNBe9+WhOKiIeXcKw6z1nAFa/1R/qSF0M+3S3j7zt+5VmzoBrz
VMz1njZt7SpFqmrCHb/uXa5bZ4hssFDic/G8K55m0bNszKtBTPVxbHOByq1Jv0KP
qv3OiRky7Gd4A3555kDyoaaONS4IRupQ0hcehFrzDfsETpI/TgCHhfxaCVohPywq
VEElUvWLdsBHEZiGij7f
=rJQZ
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
