From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: [PATCH] git-diff-*: Allow "--name-only -z" as alias for "--name-only-z"
Date: Thu, 14 Jul 2005 23:51:26 +0200
Message-ID: <20050714215126.GY9915@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NYEXl3WhqsXurSTm"
X-From: git-owner@vger.kernel.org Thu Jul 14 23:55:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtBev-0008MA-18
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 23:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVGNVx5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 17:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVGNVxp
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 17:53:45 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:54167 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261535AbVGNVwk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 17:52:40 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DtBc8-0007PJ-Ae; Thu, 14 Jul 2005 23:51:48 +0200
Received: (nullmailer pid 1348 invoked by uid 501);
	Thu, 14 Jul 2005 21:51:27 -0000
To: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	junkio@cox.net
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--NYEXl3WhqsXurSTm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:

> +		else if (!strcmp(arg, "--name-only-z"))
> +			diff_output_format =3D DIFF_FORMAT_NAME_Z;

Speaking as a user, I would get rather frustrated when I try to do that
and it doesn't work... so the attached patch allows that usage.
Please apply.

---
diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -222,11 +222,17 @@ int main(int argc, const char **argv)
 			continue;
 		}
 		if (!strcmp(arg, "-z")) {
-			diff_output_format =3D DIFF_FORMAT_MACHINE;
+			if (diff_output_format =3D=3D DIFF_FORMAT_NAME)
+				diff_output_format =3D DIFF_FORMAT_NAME_Z;
+			else
+				diff_output_format =3D DIFF_FORMAT_MACHINE;
 			continue;
 		}
 		if (!strcmp(arg, "--name-only")) {
-			diff_output_format =3D DIFF_FORMAT_NAME;
+			if (diff_output_format =3D=3D DIFF_FORMAT_MACHINE)
+				diff_output_format =3D DIFF_FORMAT_NAME_Z;
+			else
+				diff_output_format =3D DIFF_FORMAT_NAME;
 			continue;
 		}
 		if (!strcmp(arg, "--name-only-z")) {
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -55,11 +55,17 @@ int main(int argc, const char **argv)
 			; /* no-op */
 		else if (!strcmp(argv[1], "-s"))
 			; /* no-op */
-		else if (!strcmp(argv[1], "-z"))
-			diff_output_format =3D DIFF_FORMAT_MACHINE;
-		else if (!strcmp(argv[1], "--name-only"))
-			diff_output_format =3D DIFF_FORMAT_NAME;
-		else if (!strcmp(argv[1], "--name-only-z"))
+		else if (!strcmp(argv[1], "-z")) {
+			if (diff_output_format =3D=3D DIFF_FORMAT_NAME)
+				diff_output_format =3D DIFF_FORMAT_NAME_Z;
+			else
+				diff_output_format =3D DIFF_FORMAT_MACHINE;
+		} else if (!strcmp(argv[1], "--name-only")) {
+			if (diff_output_format =3D=3D DIFF_FORMAT_MACHINE)
+				diff_output_format =3D DIFF_FORMAT_NAME_Z;
+			else
+				diff_output_format =3D DIFF_FORMAT_NAME;
+		} else if (!strcmp(argv[1], "--name-only-z"))
 			diff_output_format =3D DIFF_FORMAT_NAME_Z;
 		else if (!strcmp(argv[1], "-R"))
 			diff_setup_opt |=3D DIFF_SETUP_REVERSE;
diff --git a/diff-stages.c b/diff-stages.c
--- a/diff-stages.c
+++ b/diff-stages.c
@@ -86,11 +86,17 @@ int main(int ac, const char **av)
 		}
 		else if (!strcmp(arg, "--find-copies-harder"))
 			find_copies_harder =3D 1;
-		else if (!strcmp(arg, "-z"))
-			diff_output_format =3D DIFF_FORMAT_MACHINE;
-		else if (!strcmp(arg, "--name-only"))
-			diff_output_format =3D DIFF_FORMAT_NAME;
-		else if (!strcmp(arg, "--name-only-z"))
+		else if (!strcmp(arg, "-z")) {
+			if (diff_output_format =3D=3D DIFF_FORMAT_NAME)
+				diff_output_format =3D DIFF_FORMAT_NAME_Z;
+			else
+				diff_output_format =3D DIFF_FORMAT_MACHINE;
+		} else if (!strcmp(arg, "--name-only")) {
+			if (diff_output_format =3D=3D DIFF_FORMAT_MACHINE)
+				diff_output_format =3D DIFF_FORMAT_NAME_Z;
+			else
+				diff_output_format =3D DIFF_FORMAT_NAME;
+		} else if (!strcmp(arg, "--name-only-z"))
 			diff_output_format =3D DIFF_FORMAT_NAME_Z;
 		else if (!strcmp(arg, "-R"))
 			diff_setup_opt |=3D DIFF_SETUP_REVERSE;
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -483,7 +483,10 @@ int main(int argc, const char **argv)
 			continue;
 		}
 		if (!strcmp(arg, "--name-only")) {
-			diff_output_format =3D DIFF_FORMAT_NAME;
+			if (diff_output_format =3D=3D DIFF_FORMAT_MACHINE)
+				diff_output_format =3D DIFF_FORMAT_NAME_Z;
+			else
+				diff_output_format =3D DIFF_FORMAT_NAME;
 			continue;
 		}
 		if (!strcmp(arg, "--name-only-z")) {
@@ -491,7 +494,10 @@ int main(int argc, const char **argv)
 			continue;
 		}
 		if (!strcmp(arg, "-z")) {
-			diff_output_format =3D DIFF_FORMAT_MACHINE;
+			if (diff_output_format =3D=3D DIFF_FORMAT_NAME)
+				diff_output_format =3D DIFF_FORMAT_NAME_Z;
+			else
+				diff_output_format =3D DIFF_FORMAT_MACHINE;
 			continue;
 		}
 		if (!strcmp(arg, "-m")) {

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
When The Religious Right Takes Over, We'll All Live In Iran

--NYEXl3WhqsXurSTm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC1t5e8+hUANcKr/kRAvWHAKCibxe7vTXc68Fb19xHsL8ib0cufQCfRZvN
YApvMfJltwFpoFkQSTFk3iA=
=D0Dh
-----END PGP SIGNATURE-----

--NYEXl3WhqsXurSTm--
