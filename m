From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: git diff <file> HEAD^:<file> error message
Date: Wed, 11 Jan 2012 12:18:31 +0100
Message-ID: <20120111111831.GB15232@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 12:18:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkwCW-0003Y9-7a
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 12:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326Ab2AKLSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 06:18:35 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:42313 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756590Ab2AKLSe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 06:18:34 -0500
Received: from beez.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 2E0BA461C3
	for <git@vger.kernel.org>; Wed, 11 Jan 2012 12:18:21 +0100 (CET)
Received: (nullmailer pid 10480 invoked by uid 1000);
	Wed, 11 Jan 2012 11:18:31 -0000
Mail-Followup-To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188355>


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I was trying to figure out why running

   git diff HEAD^:RelNotes RelNotes

gives the expected output (on maint it tells me that the stable
version changed from 1.7.8.3 to 1.7.8.4) but swapping the arguments
doesn't.

   git diff RelNotes HEAD^:RelNotes

doesn't show the opposite patch but tells me that RelNotes doesn't
exist in HEAD^ which is clearly a lie (it sounds like it's a
misunderstanding on git's part, but it's certainly not the truth). In
both cases, verify_filename gets called and tries to stat both
HEAD^:RelNotes and RelNotes. In the "bad" (latter) case, after it
fails to find a file named "HEAD^:RelNotes" it ends up calling
diagnose_invalid_sha1_path which is not correct according to the
command just before the function

    /* Must be called only when object_name:filename doesn't exist. */

It looks like get_sha1_with_context_1 gets confused because we pass it
a filename which looks like object_name:filename even though we
earlier parsed it simply as a filename which happens to have a colon
inside it.

Another issue is that I'm not sure that the error message should even
get shown. The documentation tells me that I should be able to compare
two random blobs, though this mode doesn't seem to work if the first
argument is a file. I realise that a file isn't a blob, but since
specifying the arguments the other way around (blob, file) does work,
it looks to me like it should as well.

   cmn

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPDXAHAAoJEHKRP1jG7ZzTZ+MIAJk/7ooinoWVPslkPFeT/igw
erM5jiaik/QkSGedv0jH4z8Xn24ddRKgHqwhpzZD4xgkgRfXB1LiQkW/amCRUSbM
xk0Vx7rt1G9BagwcoUE0wHyxuVJ4wy4AQb+LhLTOWH4IUFJ6Rnr3zcDbe74wk0Bd
3MzoCYunTDJOoGM1Sfz6t8RjDsd99NgTeqGJ5RWCm6CNyUAiMuu2pMvbR1PQdLZ/
WW84Xh7P5jYLBbgVKbXgvjPwz7KRD/N68+DdT5szXC9c3UGYLP/K/y6DkTLmLzVd
/8pDaNcgSEZMuKSClynfcPhqudbqF+tkE++DF/4/cAWoUwLcWmvtkdPDsZbCkCA=
=uMpr
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
