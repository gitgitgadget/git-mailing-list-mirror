From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 2/3] parse-options: bring PARSE_OPT_NONEG to git-rev-parse --parseopt.
Date: Sun, 02 Mar 2008 11:35:15 +0100
Message-ID: <20080302103515.GA21078@artemis.madism.org>
References: <20080302082138.GB5407@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="liOOAslEiF7prFVr";
	protocol="application/pgp-signature"; micalg=SHA1
To: Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 11:36:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVlY4-0003a5-Sv
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 11:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbYCBKfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 05:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbYCBKfU
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 05:35:20 -0500
Received: from pan.madism.org ([88.191.52.104]:51145 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751914AbYCBKfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 05:35:16 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id D7EF13108A;
	Sun,  2 Mar 2008 11:35:15 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 141E83D604F; Sun,  2 Mar 2008 11:35:15 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20080302082138.GB5407@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75769>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  While we're at it, this one could probably be squashed on top of the
  previous one.

 Documentation/git-rev-parse.txt |    8 +++++---
 builtin-rev-parse.c             |    5 ++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.=
txt
index e961c20..6513c2e 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -325,7 +325,7 @@ The lines after the separator describe the options.
 Each line of options has this format:
=20
 ------------
-<opt_spec><flags>? SP+ help LF
+<opt_spec><flags>* SP+ help LF
 ------------
=20
 `<opt_spec>`::
@@ -335,8 +335,8 @@ Each line of options has this format:
 	`<opt_spec>`.
=20
 `<flags>`::
-	`<flags>` are any suite of `*`, `=3D` or `?`.
-	* Use `=3D` if the option take an argument.
+	`<flags>` are of `*`, `=3D`, `?` or `!`.
+	* Use `=3D` if the option takes an argument.
=20
 	* Use `?` to mean that the option is optional (though its use is discoura=
ged).
=20
@@ -344,6 +344,8 @@ Each line of options has this format:
 	  generated for the `-h` argument. It's shown for `--help-all` as
 	  documented in linkgit:gitcli[5].
=20
+	* Use `!` to not make the corresponding negated long option available.
+
 The remainder of the line, after stripping the spaces, is used
 as the help associated to the option.
=20
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index d1ea73a..0351d54 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -324,7 +324,7 @@ static int cmd_parseopt(int argc, const char **argv, co=
nst char *prefix)
 		o->value =3D &parsed;
 		o->flags =3D PARSE_OPT_NOARG;
 		o->callback =3D &parseopt_dump;
-		while (s > sb.buf && strchr("*=3D?", s[-1])) {
+		while (s > sb.buf && strchr("*=3D?!", s[-1])) {
 			switch (*--s) {
 			case '=3D':
 				o->flags &=3D ~PARSE_OPT_NOARG;
@@ -333,6 +333,9 @@ static int cmd_parseopt(int argc, const char **argv, co=
nst char *prefix)
 				o->flags &=3D ~PARSE_OPT_NOARG;
 				o->flags |=3D PARSE_OPT_OPTARG;
 				break;
+			case '!':
+				o->flags |=3D PARSE_OPT_NONEG;
+				break;
 			case '*':
 				o->flags |=3D PARSE_OPT_HIDDEN;
 				break;
--=20
1.5.4.3.471.ga96e8.dirty


--liOOAslEiF7prFVr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHyoLjvGr7W6HudhwRAjg3AKCpQeQ6UaclVl0TD1Ts87HLozd6OQCgqEdt
BfHCV/i00pXqK2C47yWugPE=
=jOuk
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
