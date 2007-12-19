From: Luciano Rocha <luciano@eurotux.com>
Subject: [PATCH] builtin-tag.c: allow arguments in $EDITOR
Date: Wed, 19 Dec 2007 23:23:26 +0000
Message-ID: <20071219232326.GA4135@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 20 00:24:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J58Gc-0002pu-MM
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 00:23:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbXLSXXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 18:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753488AbXLSXXf
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 18:23:35 -0500
Received: from os.eurotux.com ([216.75.63.6]:33239 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132AbXLSXXe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 18:23:34 -0500
Received: (qmail 26104 invoked from network); 19 Dec 2007 23:23:32 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 19 Dec 2007 23:23:32 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68955>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The previous sh version of git-commit evaluated the value of the defined
editor, thus allowing arguments.

Make the builtin version work the same, by adding an explicit check for
arguments in the editor command, and extract them to an additional argument.

Signed-off-by: Luciano Rocha <luciano@eurotux.com>
---
 builtin-tag.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

I personally use EDITOR=3D"gvim -f", thus this patch.

Created on top of ce85b053d827e2f7c2ee2683cc09393e4768cc22,=20
git-describe is now: v1.5.4-rc0-75-g5f791e5

diff --git a/builtin-tag.c b/builtin-tag.c
index 274901a..57dcfe0 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -46,7 +46,18 @@ void launch_editor(const char *path, struct strbuf *buff=
er, const char *const *e
 	if (!editor)
 		editor =3D "vi";
=20
-	if (strcmp(editor, ":")) {
+	if (strstr(editor, " -")) {
+		char *editor_cmd =3D xstrdup(editor);
+		char *editor_sep =3D strstr(editor_cmd, " -");
+		const char *args[] =3D { editor_cmd, editor_sep + 1,
+			path, NULL };
+
+		*editor_sep =3D '\0';
+
+		if (run_command_v_opt_cd_env(args, 0, NULL, env))
+			die("There was a problem with the editor %s.",
+					editor_cmd);
+	} else if (strcmp(editor, ":")) {
 		const char *args[] =3D { editor, path, NULL };
=20
 		if (run_command_v_opt_cd_env(args, 0, NULL, env))
--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHaafuinSul6a7oB8RAqdOAJ9qdPe371R2ij81+o8J+xdexRjEJACfeR1T
IwNENSR6RW7ntfGYpD1sMh4=
=W6Ze
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
