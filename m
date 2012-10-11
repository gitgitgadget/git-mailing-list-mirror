From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash prompt: fix tests when run with a symlink --root
Date: Fri, 12 Oct 2012 00:38:03 +0200
Message-ID: <1349995083-11765-1-git-send-email-szeder@ira.uka.de>
References: <CACBZZX6Cu_4X=AywsDMebdoFYdEN1Gmp439aEAcehHBuMhziTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 00:38:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMROg-0006fq-Ip
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 00:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759483Ab2JKWiU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Oct 2012 18:38:20 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:62732 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550Ab2JKWiT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 18:38:19 -0400
Received: from localhost6.localdomain6 (p5B1306CC.dip0.t-ipconnect.de [91.19.6.204])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0MAAX7-1TFaqQ34g5-00Bpiy; Fri, 12 Oct 2012 00:38:12 +0200
X-Mailer: git-send-email 1.8.0.rc0.83.gc8e1777
In-Reply-To: <CACBZZX6Cu_4X=AywsDMebdoFYdEN1Gmp439aEAcehHBuMhziTw@mail.gmail.com>
X-Provags-ID: V02:K0:yUWMx3bK0xwhy2sGK1039z8hJWdu66j8eVFn6SxtJfR
 F2OXQlxWOKv8eL7uIfls+rDiMdaddZ/7yPqICxnJU0n3y9BduR
 1+qqGYdxt24cUY2s8yCVXN5i9v+HBul1jShH5yshlukevREmeY
 Y769CVHJfSOXYhDUrW0RiXJ4AMfqj2804Yll0fsAeowFtfajwg
 tGNzq38x9WrAyLeQ7edyXvHzNOWwdsCqLA59n/uDUueBrhvBi5
 NLYB9UexCcemf8l0f+H8V/OCpJfD125AMzHivKaTU5x/i6xY58
 OsYxlfFVCKOWx380QjO+1fBypwVwAkQr7joxkiDzrCTu2Tihmu
 E+/ywATDigk+Y2fMyGGIiTMG3XupY8T9vcfqDHEXEu6/zhnPFc
 a+z8n5add/3Cw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207517>

Some __gitdir() tests fail when they're run with a --root directory
which is a symlink, because they use $TRASH_DIRECTORY to construct the
expected absolute paths.  Use the path got from 'pwd -P' instead
throughout the test script.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9903-bash-prompt.sh | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index f17c1f8b..7a7b198f 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -11,6 +11,8 @@ test_description=3D'test git-specific bash prompt fun=
ctions'
=20
 actual=3D"$TRASH_DIRECTORY/actual"
=20
+TRASH_ROOT=3D"$(pwd -P)"
+
 test_expect_success 'setup for prompt tests' '
 	mkdir -p subdir/subsubdir &&
 	git init otherrepo &&
@@ -32,9 +34,9 @@ test_expect_success 'setup for prompt tests' '
 '
=20
 test_expect_success 'gitdir - from command line (through $__git_dir)' =
'
-	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	echo "$TRASH_ROOT/otherrepo/.git" > expected &&
 	(
-		__git_dir=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
+		__git_dir=3D"$TRASH_ROOT/otherrepo/.git" &&
 		__gitdir > "$actual"
 	) &&
 	test_cmp expected "$actual"
@@ -59,7 +61,7 @@ test_expect_success 'gitdir - .git directory in cwd' =
'
 '
=20
 test_expect_success 'gitdir - .git directory in parent' '
-	echo "$TRASH_DIRECTORY/.git" > expected &&
+	echo "$TRASH_ROOT/.git" > expected &&
 	(
 		cd subdir/subsubdir &&
 		__gitdir > "$actual"
@@ -77,7 +79,7 @@ test_expect_success 'gitdir - cwd is a .git directory=
' '
 '
=20
 test_expect_success 'gitdir - parent is a .git directory' '
-	echo "$TRASH_DIRECTORY/.git" > expected &&
+	echo "$TRASH_ROOT/.git" > expected &&
 	(
 		cd .git/refs/heads &&
 		__gitdir > "$actual"
@@ -86,9 +88,9 @@ test_expect_success 'gitdir - parent is a .git direct=
ory' '
 '
=20
 test_expect_success 'gitdir - $GIT_DIR set while .git directory in cwd=
' '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	echo "$TRASH_ROOT/otherrepo/.git" > expected &&
 	(
-		GIT_DIR=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
+		GIT_DIR=3D"$TRASH_ROOT/otherrepo/.git" &&
 		export GIT_DIR &&
 		__gitdir > "$actual"
 	) &&
@@ -96,9 +98,9 @@ test_expect_success 'gitdir - $GIT_DIR set while .git=
 directory in cwd' '
 '
=20
 test_expect_success 'gitdir - $GIT_DIR set while .git directory in par=
ent' '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	echo "$TRASH_ROOT/otherrepo/.git" > expected &&
 	(
-		GIT_DIR=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
+		GIT_DIR=3D"$TRASH_ROOT/otherrepo/.git" &&
 		export GIT_DIR &&
 		cd subdir &&
 		__gitdir > "$actual"
@@ -108,15 +110,15 @@ test_expect_success 'gitdir - $GIT_DIR set while =
=2Egit directory in parent' '
=20
 test_expect_success 'gitdir - non-existing $GIT_DIR' '
 	(
-		GIT_DIR=3D"$TRASH_DIRECTORY/non-existing" &&
+		GIT_DIR=3D"$TRASH_ROOT/non-existing" &&
 		export GIT_DIR &&
 		test_must_fail __gitdir
 	)
 '
=20
 test_expect_success 'gitdir - gitfile in cwd' '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
-	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" > subdir/.git &&
+	echo "$TRASH_ROOT/otherrepo/.git" > expected &&
+	echo "gitdir: $TRASH_ROOT/otherrepo/.git" > subdir/.git &&
 	test_when_finished "rm -f subdir/.git" &&
 	(
 		cd subdir &&
@@ -126,8 +128,8 @@ test_expect_success 'gitdir - gitfile in cwd' '
 '
=20
 test_expect_success 'gitdir - gitfile in parent' '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
-	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" > subdir/.git &&
+	echo "$TRASH_ROOT/otherrepo/.git" > expected &&
+	echo "gitdir: $TRASH_ROOT/otherrepo/.git" > subdir/.git &&
 	test_when_finished "rm -f subdir/.git" &&
 	(
 		cd subdir/subsubdir &&
@@ -137,7 +139,7 @@ test_expect_success 'gitdir - gitfile in parent' '
 '
=20
 test_expect_success SYMLINKS 'gitdir - resulting path avoids symlinks'=
 '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	echo "$TRASH_ROOT/otherrepo/.git" > expected &&
 	mkdir otherrepo/dir &&
 	test_when_finished "rm -rf otherrepo/dir" &&
 	ln -s otherrepo/dir link &&
@@ -152,7 +154,7 @@ test_expect_success SYMLINKS 'gitdir - resulting pa=
th avoids symlinks' '
 test_expect_success 'gitdir - not a git repository' '
 	(
 		cd subdir/subsubdir &&
-		GIT_CEILING_DIRECTORIES=3D"$TRASH_DIRECTORY" &&
+		GIT_CEILING_DIRECTORIES=3D"$TRASH_ROOT" &&
 		export GIT_CEILING_DIRECTORIES &&
 		test_must_fail __gitdir
 	)
@@ -250,7 +252,7 @@ echo "edit $(git log -1 --format=3D"%h")" > "$1"
 EOF
 	test_when_finished "rm -f fake_editor.sh" &&
 	chmod a+x fake_editor.sh &&
-	test_set_editor "$TRASH_DIRECTORY/fake_editor.sh" &&
+	test_set_editor "$TRASH_ROOT/fake_editor.sh" &&
 	git checkout b1 &&
 	test_when_finished "git checkout master" &&
 	git rebase -i HEAD^ &&
--=20
1.8.0.rc0.83.gc8e1777
