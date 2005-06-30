From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: [PATCH] cvsimport: Limit the log string to 32k
Date: Thu, 30 Jun 2005 18:38:50 +0200
Message-ID: <20050630163850.GU10850@kiste.smurf.noris.de>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630145528.GA18553@pc117b.liacs.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DCTaD1eAmswIDYF2"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 18:32:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do1y0-0001cC-7H
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 18:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbVF3QkF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 12:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbVF3QkF
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 12:40:05 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:37530 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S262930AbVF3Qj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 12:39:58 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1Do23u-0000TL-Ut; Thu, 30 Jun 2005 18:39:03 +0200
Received: (nullmailer pid 9777 invoked by uid 501);
	Thu, 30 Jun 2005 16:38:50 -0000
To: Sven Verdoolaege <skimo@liacs.nl>
Content-Disposition: inline
In-Reply-To: <20050630145528.GA18553@pc117b.liacs.nl>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--DCTaD1eAmswIDYF2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Teach the new cvsimport script to chop the log string's trailing whitespace.

Limit the log string to 32k, in order to be compatible with the old
cvs2git program.

Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>

---

diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -468,7 +468,12 @@ my $commit =3D sub {
 	}
 	$pw->writer();
 	$pr->reader();
-	print $pw $logmsg
+
+	# compatibility with git2cvs
+	substr($logmsg,32767) =3D "" if length($logmsg) > 32767;
+	$logmsg =3D~ s/[\s\n]+\z//;
+
+	print $pw "$logmsg\n"
 		or die "Error writing to git-commit-tree: $!\n";
 	$pw->close();
=20

--DCTaD1eAmswIDYF2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCxCAa8+hUANcKr/kRApb4AJ4+si+Z5zg2OdHmA8aK/8yVqo77AACcCU9u
u7f9l+jFaZilCg/2HCZU58E=
=mLXL
-----END PGP SIGNATURE-----

--DCTaD1eAmswIDYF2--
