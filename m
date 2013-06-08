From: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Subject: [PATCH 2/2] rm: introduce advice.rmHints to shorten messages
Date: Sat,  8 Jun 2013 10:33:54 +0200
Message-ID: <1370680434-2709-2-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
References: <1370680434-2709-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?UTF-8?q?Mathieu=20Li=C3=A9nard--Mayor?= 
	<Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 08 10:34:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlEbs-0006Sa-HZ
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 10:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654Ab3FHIen convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 04:34:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35202 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421Ab3FHIel (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 04:34:41 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r588YP4A023199
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 8 Jun 2013 10:34:25 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r588YQ6p008940;
	Sat, 8 Jun 2013 10:34:26 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r588YQmi003718;
	Sat, 8 Jun 2013 10:34:26 +0200
Received: (from lienardm@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id r588YQq6003717;
	Sat, 8 Jun 2013 10:34:26 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1370680434-2709-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 08 Jun 2013 10:34:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r588YP4A023199
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: mathieu.lienard--mayor@ensimag.imag.fr
MailScanner-NULL-Check: 1371285267.08931@zKFxcg7MuedOf6gjw8axNw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226789>

=46rom: Mathieu Li=C3=A9nard--Mayor <Mathieu.Lienard--Mayor@ensimag.ima=
g.fr>

Similarly to advice.*, advice.rmHints has been added
to the config variables. By default, it is set to false, in order to
keep the messages the same as before. When set to true,  advice
are no longer included in the error messages.

As an example, the message:
	error: 'foo.txt' has changes staged in the index
	(use --cached to keep the file, or -f to force removal)

would look like, with advice.rmHints=3Dtrue:
	error: 'foo.txt' has changes staged in the index

Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.i=
mag.fr>
Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.garcia-Garcia@ensim=
ag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
 Documentation/config.txt |    3 +++
 advice.c                 |    2 ++
 advice.h                 |    1 +
 builtin/rm.c             |   38 ++++++++++++++++++++++++++------------
 t/t3600-rm.sh            |   32 ++++++++++++++++++++++++++++++++
 5 files changed, 64 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6e53fc5..eb04479 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -199,6 +199,9 @@ advice.*::
 	amWorkDir::
 		Advice that shows the location of the patch file when
 		linkgit:git-am[1] fails to apply it.
+	rmHints::
+		In case of failure in the output of linkgit:git-rm[1],
+		show directions on how to proceed from the current state.
 --
=20
 core.fileMode::
diff --git a/advice.c b/advice.c
index a8deee6..a4c169c 100644
--- a/advice.c
+++ b/advice.c
@@ -14,6 +14,7 @@ int advice_resolve_conflict =3D 1;
 int advice_implicit_identity =3D 1;
 int advice_detached_head =3D 1;
 int advice_set_upstream_failure =3D 1;
+int advice_rm_hints =3D 1;
=20
 static struct {
 	const char *name;
@@ -33,6 +34,7 @@ static struct {
 	{ "implicitidentity", &advice_implicit_identity },
 	{ "detachedhead", &advice_detached_head },
 	{ "setupstreamfailure", &advice_set_upstream_failure },
+	{ "rmhints", &advice_rm_hints },
=20
 	/* make this an alias for backward compatibility */
 	{ "pushnonfastforward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index 94caa32..36104c4 100644
--- a/advice.h
+++ b/advice.h
@@ -17,6 +17,7 @@ extern int advice_resolve_conflict;
 extern int advice_implicit_identity;
 extern int advice_detached_head;
 extern int advice_set_upstream_failure;
+extern int advice_rm_hints;
=20
 int git_default_advice_config(const char *var, const char *value);
 void advise(const char *advice, ...);
diff --git a/builtin/rm.c b/builtin/rm.c
index 5b2abd2..38ceb73 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -62,9 +62,11 @@ static int check_submodules_use_gitfiles(void)
=20
 		if (!submodule_uses_gitfile(name))
 			errs =3D error(_("submodule '%s' (or one of its nested "
-				     "submodules) uses a .git directory\n"
-				     "(use 'rm -rf' if you really want to remove "
-				     "it including all of its history)"), name);
+				       "submodules) uses a .git directory%s"), name,
+				       advice_rm_hints
+				       ? "\n(use 'rm -rf' if you really want to remove "
+				       "it including all of its history)"
+				       : "");
 	}
=20
 	return errs;
@@ -200,21 +202,33 @@ static int check_local_mod(unsigned char *head, i=
nt index_only)
=20
 	if (files_staged.len)
 		errs =3D error(_("the following files have staged content "
-			       "different from both the\nfileand the HEAD:%s\n"
-			       "(use -f to force removal)"), files_staged.buf);
+			       "different from both the\nfile and the HEAD:%s%s"
+			       ), files_staged.buf,
+			       advice_rm_hints
+			       ? "\n(use -f to force removal)"
+			       : "");
 	if (files_cached.len)
 		errs =3D error(_("the following files have changes staged "
-			       "in the index:%s\n(use --cached to keep the file, "
-			       "or -f to force removal)"), files_cached.buf);
+			       "in the index:%s%s"), files_cached.buf,
+			       advice_rm_hints
+			       ? "\n(use --cached to keep the file, "
+			       "or -f to force removal)"
+			       : "");
 	if (files_submodule.len)
 		errs =3D error(_("the following submodules (or one of its nested "
-			       "submodule) use a .git directory:%s\n"
-			       "(use 'rm -rf' if you really want to remove "
-			       "it including all of its history)"), files_submodule.buf);
+			       "submodule) use a .git directory:%s%s"),
+			       files_submodule.buf,
+			       advice_rm_hints
+			       ? "\n(use 'rm -rf' if you really want to remove "
+			       "it including all of its history)"
+			       : "");
 	if (files_local.len)
 		errs =3D error(_("the following files have local modifications:"
-			       "%s\n(use --cached to keep the file, or -f to "
-			       "force removal)"), files_local.buf);
+			       "%s%s"), files_local.buf,
+			       advice_rm_hints
+			       ? "\n(use --cached to keep the file, or -f to "
+			       "force removal)"
+			       : "");
=20
 	return errs;
 }
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index e0f3166..ab10cc6 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -707,6 +707,19 @@ EOF
 	test_cmp expect actual
 '
=20
+test_expect_success 'rm files with different staged content without hi=
nts' '
+	cat >expect << EOF &&
+error: the following files have staged content different from both the
+file and the HEAD:
+	bar.txt
+	foo.txt
+EOF
+	echo content2 >foo.txt &&
+	echo content2 >bar.txt &&
+	test_must_fail git -c advice.rmhints=3Dfalse rm foo.txt bar.txt 2>act=
ual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'rm file with local modification' '
 	cat >expect << EOF &&
 error: the following files have local modifications:
@@ -719,6 +732,16 @@ EOF
 	test_cmp expect actual
 '
=20
+test_expect_success 'rm file with local modification without hints' '
+	cat >expect << EOF &&
+error: the following files have local modifications:
+	bar.txt
+EOF
+	echo content4 >bar.txt &&
+	test_must_fail git -c advice.rmhints=3Dfalse rm bar.txt 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'rm file with changes in the index' '
 	cat >expect << EOF &&
 error: the following files have changes staged in the index:
@@ -732,4 +755,13 @@ EOF
 	test_cmp expect actual
 '
=20
+test_expect_success 'rm file with changes in the index without hints' =
'
+	cat >expect << EOF &&
+error: the following files have changes staged in the index:
+	foo.txt
+EOF
+	test_must_fail git -c advice.rmhints=3Dfalse rm foo.txt 2>actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
1.7.8
