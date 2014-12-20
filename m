From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] list-objects: mark fewer commits as edges for
 non-shallow clones
Date: Sat, 20 Dec 2014 19:28:20 +0000
Message-ID: <20141220192820.GA137570@vauxhall.crustytoothpaste.net>
References: <20141211030948.GA137226@vauxhall.crustytoothpaste.net>
 <1418269615-139571-1-git-send-email-sandals@crustytoothpaste.net>
 <xmqqvblidmp1.fsf@gitster.dls.corp.google.com>
 <xmqqr3w6dm2w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 20:28:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2Phg-0005PE-PF
	for gcvg-git-2@plane.gmane.org; Sat, 20 Dec 2014 20:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbaLTT23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2014 14:28:29 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55682 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751105AbaLTT22 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Dec 2014 14:28:28 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 44D0E2808F;
	Sat, 20 Dec 2014 19:28:26 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	pclouds@gmail.com
Content-Disposition: inline
In-Reply-To: <xmqqr3w6dm2w.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.18.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261604>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2014 at 11:26:47AM -0800, Junio C Hamano wrote:
> The right approach would be more like allocating one more bit in
> struct rev_info (call that edge_hint_aggressive), give a new option
> "--objects-edge-aggressive", and do something like
>=20
> 	if (thin) {
>         	use_internal_rev_list =3D 1;
> 		argv_array_push(&rp, is_repository_shallow()
>                 	? "--objects-edge-aggressive"
>                         : "--objects-edge");
> 	}
>=20
> in this codepath?  I'd actually suggest is_repository_shallow()
> detection to happen one level even higher (i.e. make decision at the
> caller of pack-objects) and decide to pass either "--thin" or
> "--thin-aggressive", so that we can make sure that the damage caused
> by fbd4a70 to be limited only to fetches into shallow repository
> with stronger confidence.

Sorry it's taken me so long to get back to this.  Real life keeps
getting in the way.

I think adding --objects-edge-aggressive is the best way forward here
and then applying the patch above.  If we add --thin-aggressive, we push
the problem to a higher level, which will require more code changes and
make the performance regression continue to affect external remote
helpers, which we don't want.  We know what the right decision is here,
so let's just do it.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUlc3UAAoJEL9TXYEfUvaLutsP/0v5oRgomdib0K2cWn7PDtbe
wztlUX0X473oW0VQGJbgXKM60BC8con0/uahJb99qgolzSn9umPeUbLLSadMCDWT
e3lHFen3D4SORhYJfYfrzWIsSdFCvE/5qSBJThan/dkhgjBsOZEfkv7NAEDh3vty
DmwNFFJazXLmbvVEtnIgsQyf1cVi4v0Ahp2fmQwCUm59ECIIL0AcJ4VUxbv50BV4
OlEexyjl0RxLUQooAIn7dmdS/tVr0UQXn+C4ohGbQbFyvUMoLIb4Tjj+XybnLE3T
YzWFN22l2tP3qb+9Yiyqch8JbHyPKQ8VYxBuOEvjYk0KbAQ6yMY+c2nj7f2SOnDt
FU4v8EGLmz0bRDxEV3IQcwoDkVQrAkOacep34R3Gx8W8B42eiKLujc8QPOGqmvj+
UJYZgBh8aXDTr7BxQGVQNpW7ZL6eJqoO6kPxlpNxqydEoyUwPw8fPL4XSWES/dQN
6OwPfuE5cXinLDQ2P7lG6gTrVhhyMm5Irg81ljj3e9zODEtUthfUcrsyqTb9L4JH
Elvft8jjNo9A3gt1XN9vOmWb9wCH+wmy/A41InNgCZAoOG1Dmtj6caHkkNzdsEaX
zzt3V4D4K5Y+vM9vYdKzhvVZMiWIgyFW7KtLkCf1XXtqChRDUpG+hdhU/VDnFatC
xZ7msMy2uf5VGB+FmY1t
=CE46
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
