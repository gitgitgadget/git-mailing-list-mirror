From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] parse-opt: bring PARSE_OPT_HIDDEN to git-rev-parse --parseopt
Date: Sat, 23 Feb 2008 15:09:26 +0100
Message-ID: <20080223140926.GD10967@artemis.madism.org>
References: <20080221230101.27644.49229.stgit@gandelf.nowhere.earth> <20080222093558.GC29114@artemis.madism.org> <7vbq68ap1c.fsf@gitster.siamese.dyndns.org> <20080222181927.GA4555@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="rz+pwK2yUstbofK6";
	protocol="application/pgp-signature"; micalg=SHA1
To: Junio C Hamano <gitster@pobox.com>,
	Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 15:10:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSv4u-0005Xy-3b
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 15:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759462AbYBWOJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 09:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759734AbYBWOJc
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 09:09:32 -0500
Received: from pan.madism.org ([88.191.52.104]:47595 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759475AbYBWOJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 09:09:29 -0500
Received: from madism.org (ctse16.ulb.ac.be [164.15.3.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 41CE31EBEC;
	Sat, 23 Feb 2008 15:09:28 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 53495452016; Sat, 23 Feb 2008 15:09:26 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080222181927.GA4555@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74827>


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
    On ven, f=C3=A9v 22, 2008 at 06:19:28 +0000, Pierre Habouzit wrote:
    > On Fri, Feb 22, 2008 at 05:17:51PM +0000, Junio C Hamano wrote:
    > > I did not find accessible from the command line variant was the
    > > parse-opt-hidden feature, which was frustrating.
    >=20
    >   Well, it's probably doable using some more magic flags, I can hack
    > something if you need to, I'll try to work something out during FOSDE=
M's
    > talks :)

      Here it is =E2=80=A6
      I also made the parsing more extensible wrt new flags if needed.

      We should definitely write tests too.

 Documentation/git-rev-parse.txt |   15 ++++++++++-----
 builtin-rev-parse.c             |   25 ++++++++++++++-----------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.=
txt
index f02f6bb..e961c20 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -325,7 +325,7 @@ The lines after the separator describe the options.
 Each line of options has this format:
=20
 ------------
-<opt_spec><arg_spec>? SP+ help LF
+<opt_spec><flags>? SP+ help LF
 ------------
=20
 `<opt_spec>`::
@@ -334,10 +334,15 @@ Each line of options has this format:
 	is necessary. `h,help`, `dry-run` and `f` are all three correct
 	`<opt_spec>`.
=20
-`<arg_spec>`::
-	an `<arg_spec>` tells the option parser if the option has an argument
-	(`=3D`), an optional one (`?` though its use is discouraged) or none
-	(no `<arg_spec>` in that case).
+`<flags>`::
+	`<flags>` are any suite of `*`, `=3D` or `?`.
+	* Use `=3D` if the option take an argument.
+
+	* Use `?` to mean that the option is optional (though its use is discoura=
ged).
+
+	* Use `*` to mean that this option should not be listed in the usage
+	  generated for the `-h` argument. It's shown for `--help-all` as
+	  documented in linkgit:gitcli[5].
=20
 The remainder of the line, after stripping the spaces, is used
 as the help associated to the option.
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index b9af1a5..5ffc4e0 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -322,18 +322,21 @@ static int cmd_parseopt(int argc, const char **argv, =
const char *prefix)
 		o->type =3D OPTION_CALLBACK;
 		o->help =3D xstrdup(skipspaces(s));
 		o->value =3D &parsed;
+		o->flags =3D PARSE_OPT_NOARG;
 		o->callback =3D &parseopt_dump;
-		switch (s[-1]) {
-		case '=3D':
-			s--;
-			break;
-		case '?':
-			o->flags =3D PARSE_OPT_OPTARG;
-			s--;
-			break;
-		default:
-			o->flags =3D PARSE_OPT_NOARG;
-			break;
+		while (s > sb.buf && strchr("*=3D?", s[-1])) {
+			switch (*--s) {
+			case '=3D':
+				o->flags &=3D ~PARSE_OPT_NOARG;
+				break;
+			case '?':
+				o->flags &=3D ~PARSE_OPT_NOARG;
+				o->flags |=3D PARSE_OPT_OPTARG;
+				break;
+			case '*':
+				o->flags &=3D PARSE_OPT_HIDDEN;
+				break;
+			}
 		}
=20
 		if (s - sb.buf =3D=3D 1) /* short option only */
--=20
1.5.4.2.281.g28d0e


--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHwCkWvGr7W6HudhwRAv3fAJ45s1Bgjvid23zvJhwyZK2vz/6roQCbBMEp
nslHfR39ASh2E57DDq+pugw=
=vWhf
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
