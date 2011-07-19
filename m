From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: How to limit bandwidth used by git over SSH ?
Date: Tue, 19 Jul 2011 10:42:20 +0200
Message-ID: <1311064940.3945.11.camel@bee.lab.cmartin.tk>
References: <4E22B7F7.4020701@seichter.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-4gtvd1HXXNLTzTVm79ZI"
Cc: git@vger.kernel.org
To: Ralph Seichter <git-ml@seichter.de>
X-From: git-owner@vger.kernel.org Tue Jul 19 10:42:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qj5t6-0002fu-B5
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 10:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543Ab1GSImj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 04:42:39 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:50423 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752431Ab1GSImi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 04:42:38 -0400
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 1C3C0461FF;
	Tue, 19 Jul 2011 10:42:35 +0200 (CEST)
In-Reply-To: <4E22B7F7.4020701@seichter.de>
X-Mailer: Evolution 2.32.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177443>


--=-4gtvd1HXXNLTzTVm79ZI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2011-07-17 at 12:22 +0200, Ralph Seichter wrote:
> Hello list,
>=20
> I'm not really sure if this is a git or SSH issue, but I haven't figured
> out a solution yet. To transfer my data between two machines, I use
>=20
>   git-push ssh://machineB.tld/foo/proj.git master
>=20
> from machineA. Unfortunately, the machines are connected by a very low-
> bandwidth connection, which is completely choked by git-push. From what
> I've read so far, I guess this is the result of SSH setting TOS to
> "minimize delay", which prevents almost all other traffic during the
> push operation. Not good.

A bit OT, but the situation where a link is chocked by a slow uplink
getting filled is most likely due to buffer bloat on your modem/router
which confuses TCP's congestion detection by buffering your packets too
aggressively. But that's neither here nor there, I just wanted to point
out it's not all ssh or git's fault.

>=20
> I haven't yet found a way of telling git (or SSH) to use no more than a
> given maximum bandwidth, like I could do with "scp -l {limit}". Did I
> miss something in the documentation?

But coming back to SSH, scp knows it's going to do a file transfer, but
git uses the ssh client to do a "normal" connection to a remote machine,
to ssh, it's no different from a user typing really fast, which is
probably why it's not supported out of the box.

There is a tool called trickle which takes over the network functions
and can be used to limit upload and download speeds, so using it like

    trickle -u 20 git push ssh://machineB.tld/foo/proj.git master

should do the trick.

Cheers,
   cmn


--=-4gtvd1HXXNLTzTVm79ZI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOJUNnAAoJEHKRP1jG7ZzTZ5EH/1FNA15ImCFAzz60IW/OA+Sv
qZQk+JE+ACQzV3MFUzn72gMy8J0BpebiTDtZsBqmagdYoiBuAXyupRgW5x2jH9s1
MFTvNP1t495n9kTkYtOkHxha2ESjt3CEvjuiGR3wY0fPCeJGRKmEcAndIVqoVGu2
cTcu+W+4IZvl+N5Wb5rdWzB2PAWSQoMawgwWkBq9D7btjFricpXbHMKfOEsxvmlD
v7BivMq/KQzygexSbidpgmOeckA1iRn/gr8QGHR7sijQXhY2BS80dFPJX8VT18pU
+xbezJyXiqNoz2Ol7NADQpieBl8I9K3AHOQAQO5To98E38sgm9+20wLaBHiKmEQ=
=Acjy
-----END PGP SIGNATURE-----

--=-4gtvd1HXXNLTzTVm79ZI--
