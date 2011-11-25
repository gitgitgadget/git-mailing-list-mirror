From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Infinite loop in cascade_filter_fn()
Date: Fri, 25 Nov 2011 15:31:31 +0100
Message-ID: <20111125143131.GA10417@beez.lab.cmartin.tk>
References: <Pine.GSO.4.63.1111231801580.5099@shipon.roxen.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Cc: Git Mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Henrik =?iso-8859-1?Q?Grubbstr=F6m?= <grubba@grubba.org>
X-From: git-owner@vger.kernel.org Fri Nov 25 15:32:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTwp4-0007hX-MW
	for gcvg-git-2@lo.gmane.org; Fri, 25 Nov 2011 15:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755778Ab1KYOcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Nov 2011 09:32:09 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:47928 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755445Ab1KYOcI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2011 09:32:08 -0500
Received: from beez.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id B76844619B;
	Fri, 25 Nov 2011 15:31:26 +0100 (CET)
Received: (nullmailer pid 23134 invoked by uid 1000);
	Fri, 25 Nov 2011 14:31:31 -0000
Mail-Followup-To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Henrik =?iso-8859-1?Q?Grubbstr=F6m?= <grubba@grubba.org>,
	Git Mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.63.1111231801580.5099@shipon.roxen.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185930>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2011 at 06:40:47PM +0100, Henrik Grubbstr=F6m wrote:
> Hi.
>=20
> My git repository walker just got bitten by what seems to be a
> reasonably new bug in convert.c:cascade_filter_fn() (git 1.7.8.rc3
> (gentoo)).

It looks like it's a bug between cascade_filter_fn and the actual
filter function lf_to_crlf_filter_fn that gets triggered when the
output buffer is too small. In this particular case, *isize_p=3D378 and
*osize_p=3D1 which causes cascade_filter_fn to feed the filter data
which it can't process because it doesn't have anywhere to put it.

I think that the function assumes that the output buffer is always
large enough, but there are many indirections, so it might be an
off-by-one.

>=20
> How to reproduce:
>=20
>   git clone git@github.com:pikelang/Pike.git
>=20
>   git checkout -f 0e2080f838c6f0bc7d670ac7549676a353451dca^
>=20
>   git checkout -f 0e2080f838c6f0bc7d670ac7549676a353451dca
>=20
> The first two commands complete as expected, while the last hangs forever.
> Performing the same with git 1.7.6.4 works as expected.
>=20
> The problematic file seems to be
> /src/modules/_Crypto/rijndael_ecb_vt.txt which has the attributes:
> text ident eol=3Dcrlf
>=20
> Thanks,
>=20
> --
> Henrik Grubbstr=F6m					grubba@grubba.org
> Roxen Internet Software AB				grubba@roxen.com


--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOz6bDAAoJEHKRP1jG7ZzTTbUIAKXsyh1tEtaPvrFeEbXx94rY
hYKvlQA7d8Fq8KPsva0hjdOSJMLSBSs/e2upd1SP5BsZWl4+OQLeUfMjuJ5DVmqC
yoAUnU3Z+hOO6Xo3IOcsdkZD0kuVYyqsRsBT6f/gTotAO6+BIhn6YRM6Qm34MUh8
iFQu/DkVXpVfpSCkJ7++98zreMu0DWcN86z1gUtWtYQPnynXH1RjrJFOT0l3Klz5
znGsCCZUCe6j0pP7vgA+P4fkAyJJ9VZj2HXlC3qTIQK0zr9+4Ea+nF21nHzvG3gv
+hgUcIYwf8TXx91cNXlDj4s13NK0rPJP7JOXGs/rWv12rFHp5K+iNZwkMyq7aiQ=
=oE8k
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
