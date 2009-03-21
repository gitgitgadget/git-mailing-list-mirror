From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 09/16] t9100, t9129: Use prerequisite tags for UTF-8 tests
Date: Sat, 21 Mar 2009 22:26:32 +0100
Message-ID: <ed170175a2efbe8ff7043d58cf5f7fd275cf9986.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 22:30:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll8lh-0004Ii-52
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 22:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346AbZCUV1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 17:27:25 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755160AbZCUV1T
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 17:27:19 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27944 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753039AbZCUV07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 17:26:59 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DBA6C2C4012;
	Sat, 21 Mar 2009 22:26:55 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 6D5225BC08;
	Sat, 21 Mar 2009 22:26:55 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114068>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t9100-git-svn-basic.sh               |   37 +++++++++++++-----------=
-------
 t/t9129-git-svn-i18n-commitencoding.sh |   22 ++++++++++--------
 2 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index bb921af..4eee2e9 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -6,19 +6,19 @@
 test_description=3D'git svn basic tests'
 GIT_SVN_LC_ALL=3D${LC_ALL:-$LANG}
=20
+. ./lib-git-svn.sh
+
+say 'define NO_SVN_TESTS to skip git svn tests'
+
 case "$GIT_SVN_LC_ALL" in
 *.UTF-8)
-	have_utf8=3Dt
+	test_set_prereq UTF8
 	;;
 *)
-	have_utf8=3D
+	say "UTF-8 locale not set, some tests skipped ($GIT_SVN_LC_ALL)"
 	;;
 esac
=20
-. ./lib-git-svn.sh
-
-say 'define NO_SVN_TESTS to skip git svn tests'
-
 test_expect_success \
     'initialize git svn' '
 	mkdir import &&
@@ -171,20 +171,15 @@ test_expect_success "$name" '
 	test ! -L "$SVN_TREE"/exec-2.sh &&
 	test_cmp help "$SVN_TREE"/exec-2.sh'
=20
-if test "$have_utf8" =3D t
-then
-	name=3D"commit with UTF-8 message: locale: $GIT_SVN_LC_ALL"
-	LC_ALL=3D"$GIT_SVN_LC_ALL"
-	export LC_ALL
-	test_expect_success "$name" "
-		echo '# hello' >> exec-2.sh &&
-		git update-index exec-2.sh &&
-		git commit -m '=C3=A9=C3=AF=E2=88=8F' &&
-		git svn set-tree HEAD"
-	unset LC_ALL
-else
-	say "UTF-8 locale not set, test skipped ($GIT_SVN_LC_ALL)"
-fi
+name=3D"commit with UTF-8 message: locale: $GIT_SVN_LC_ALL"
+LC_ALL=3D"$GIT_SVN_LC_ALL"
+export LC_ALL
+test_expect_success UTF8 "$name" "
+	echo '# hello' >> exec-2.sh &&
+	git update-index exec-2.sh &&
+	git commit -m '=C3=A9=C3=AF=E2=88=8F' &&
+	git svn set-tree HEAD"
+unset LC_ALL
=20
 name=3D'test fetch functionality (svn =3D> git) with alternate GIT_SVN=
_ID'
 GIT_SVN_ID=3Dalt
@@ -197,7 +192,7 @@ test_expect_success "$name" \
=20
 name=3D'check imported tree checksums expected tree checksums'
 rm -f expected
-if test "$have_utf8" =3D t
+if test_have_prereq UTF8
 then
 	echo tree bf522353586b1b883488f2bc73dab0d9f774b9a9 > expected
 fi
diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i=
18n-commitencoding.sh
index 9c7b1ad..3200ab3 100755
--- a/t/t9129-git-svn-i18n-commitencoding.sh
+++ b/t/t9129-git-svn-i18n-commitencoding.sh
@@ -70,24 +70,26 @@ do
 done
=20
 if locale -a |grep -q en_US.utf8; then
-	test_expect_success 'ISO-8859-1 should match UTF-8 in svn' '
+	test_set_prereq UTF8
+else
+	say "UTF-8 locale not available, test skipped"
+fi
+
+test_expect_success UTF8 'ISO-8859-1 should match UTF-8 in svn' '
 	(
 		cd ISO-8859-1 &&
 		compare_svn_head_with "$TEST_DIRECTORY"/t3900/1-UTF-8.txt
 	)
-	'
+'
=20
-	for H in EUCJP ISO-2022-JP
-	do
-		test_expect_success '$H should match UTF-8 in svn' '
+for H in EUCJP ISO-2022-JP
+do
+	test_expect_success UTF8 "$H should match UTF-8 in svn" '
 		(
 			cd $H &&
 			compare_svn_head_with "$TEST_DIRECTORY"/t3900/2-UTF-8.txt
 		)
-		'
-	done
-else
-	say "UTF-8 locale not available, test skipped"
-fi
+	'
+done
=20
 test_done
--=20
1.6.2.1.224.g2225f
