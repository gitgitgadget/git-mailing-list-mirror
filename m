From: Yann Droneaud <yann@droneaud.fr>
Subject: =?UTF-8?q?=5BPATCH=203/4=5D=20test=3A=20use=20test=5Futf8=20and=20GIT=5FLC=5FUTF8=20where=20an=20en=5FUS=2EUTF-8=20locale=20is=20required?=
Date: Thu,  6 Jan 2011 15:22:16 +0100
Message-ID: <97423472c08cd83373c769bf1cafdb9b85db37e3.1294312018.git.yann@droneaud.fr>
References: <1274193685-5468-1-git-send-email-yann@droneaud.fr> <4BF2BABC.2010405@drmicha.warpmail.net> <1274202486.4228.22.camel@localhost> <1274720888.4838.13.camel@localhost> <cover.1294312018.git.yann@droneaud.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Droneaud <yann@droneaud.fr>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 06 15:31:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaqsG-0001zi-Ea
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 15:31:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab1AFOb0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jan 2011 09:31:26 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:38626 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292Ab1AFOb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 09:31:26 -0500
Received: from deela.quest-ce.net ([80.12.81.242])
	by mwinf5d25 with ME
	id sEPS1f00A5DhHAg03EPSuw; Thu, 06 Jan 2011 15:23:26 +0100
Received: from deela.quest-ce.net (localhost.localdomain [127.0.0.1])
	by deela.quest-ce.net (8.14.4/8.14.4) with ESMTP id p06EN6tE031817;
	Thu, 6 Jan 2011 15:23:19 +0100
Received: (from ydroneaud@localhost)
	by deela.quest-ce.net (8.14.4/8.14.4/Submit) id p06EN6GU031816;
	Thu, 6 Jan 2011 15:23:06 +0100
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <cover.1294312018.git.yann@droneaud.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164634>

Signed-off-by: Yann Droneaud <yann@droneaud.fr>
---
 t/t9100-git-svn-basic.sh               |   25 ++++++++----------------=
-
 t/t9129-git-svn-i18n-commitencoding.sh |   13 +++----------
 2 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index b041516..fcdffef 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -4,20 +4,14 @@
 #
=20
 test_description=3D'git svn basic tests'
-GIT_SVN_LC_ALL=3D${LC_ALL:-$LANG}
=20
 . ./lib-git-svn.sh
=20
 say 'define NO_SVN_TESTS to skip git svn tests'
=20
-case "$GIT_SVN_LC_ALL" in
-*.UTF-8)
-	test_set_prereq UTF8
-	;;
-*)
-	say "# UTF-8 locale not set, some tests skipped ($GIT_SVN_LC_ALL)"
-	;;
-esac
+if ! test_utf8 ; then
+	say "# UTF-8 locale not set, some tests skipped"
+fi
=20
 test_expect_success \
     'initialize git svn' '
@@ -172,15 +166,12 @@ test_expect_success "$name" '
 	test ! -h "$SVN_TREE"/exec-2.sh &&
 	test_cmp help "$SVN_TREE"/exec-2.sh'
=20
-name=3D"commit with UTF-8 message: locale: $GIT_SVN_LC_ALL"
-LC_ALL=3D"$GIT_SVN_LC_ALL"
-export LC_ALL
+name=3D"commit with UTF-8 message: locale: $GIT_LC_UTF8"
 test_expect_success UTF8 "$name" "
-	echo '# hello' >> exec-2.sh &&
-	git update-index exec-2.sh &&
-	git commit -m '=C3=A9=C3=AF=E2=88=8F' &&
-	git svn set-tree HEAD"
-unset LC_ALL
+	LC_ALL=3D$GIT_LC_UTF8 echo '# hello' >> exec-2.sh &&
+	LC_ALL=3D$GIT_LC_UTF8 git update-index exec-2.sh &&
+	LC_ALL=3D$GIT_LC_UTF8 git commit -m '=C3=A9=C3=AF=E2=88=8F' &&
+	LC_ALL=3D$GIT_LC_UTF8 git svn set-tree HEAD"
=20
 name=3D'test fetch functionality (svn =3D> git) with alternate GIT_SVN=
_ID'
 GIT_SVN_ID=3Dalt
diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i=
18n-commitencoding.sh
index 8cfdfe7..f3bbde4 100755
--- a/t/t9129-git-svn-i18n-commitencoding.sh
+++ b/t/t9129-git-svn-i18n-commitencoding.sh
@@ -14,22 +14,15 @@ compare_git_head_with () {
 	test_cmp current "$1"
 }
=20
-a_utf8_locale=3D$(locale -a | sed -n '/\.[uU][tT][fF]-*8$/{
-	p
-	q
-}')
-
-if test -n "$a_utf8_locale"
-then
-	test_set_prereq UTF8
-else
+if ! test_utf8 ; then
 	say "# UTF-8 locale not available, some tests are skipped"
 fi
=20
 compare_svn_head_with () {
 	# extract just the log message and strip out committer info.
 	# don't use --limit here since svn 1.1.x doesn't have it,
-	LC_ALL=3D"$a_utf8_locale" svn log `git svn info --url` | perl -w -e '
+	LC_ALL=3D$GIT_LC_UTF8 svn log `git svn info --url` | \
+	    LC_ALL=3D$GIT_LC_UTF8 perl -w -e '
 		use bytes;
 		$/ =3D ("-"x72) . "\n";
 		my @x =3D <STDIN>;
--=20
1.7.3.4
