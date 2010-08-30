From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: =?UTF-8?q?=5BPATCH=201/3=20v2=5D=20tests=3A=20factor=20HOME=3D=24=28pwd=29=20in=20test-lib=2Esh?=
Date: Tue, 31 Aug 2010 01:15:21 +0200
Message-ID: <1283210123-19752-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqhbibbthi.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Aug 31 01:18:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqDcZ-0000yP-Ey
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 01:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946Ab0H3XSa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 19:18:30 -0400
Received: from imag.imag.fr ([129.88.30.1]:33495 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753437Ab0H3XSa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 19:18:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o7UNFXiW029783
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 31 Aug 2010 01:15:33 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OqDZd-000221-7Y; Tue, 31 Aug 2010 01:15:33 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OqDZd-0007gY-6V; Tue, 31 Aug 2010 01:15:33 +0200
X-Mailer: git-send-email 1.7.2.2.175.ga619d.dirty
In-Reply-To: <vpqhbibbthi.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 31 Aug 2010 01:15:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154871>

The same pattern is used in many tests, and makes it easy for new ones =
to
rely on $HOME being a trashable, clean, directory.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Just re-ordered the patch to make this one the first.

I took =C3=86var's suggestion of using $TRASH_DIRECTORY instead of $(pw=
d).

 t/lib-cvs.sh                    |    3 ---
 t/t0001-init.sh                 |    6 ------
 t/t0003-attributes.sh           |    1 -
 t/t5601-clone.sh                |    2 --
 t/t9130-git-svn-authors-file.sh |    2 --
 t/test-lib.sh                   |    3 +++
 6 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/t/lib-cvs.sh b/t/lib-cvs.sh
index 648d161..ad90364 100644
--- a/t/lib-cvs.sh
+++ b/t/lib-cvs.sh
@@ -3,9 +3,6 @@
 . ./test-lib.sh
=20
 unset CVS_SERVER
-# for clean cvsps cache
-HOME=3D$(pwd)
-export HOME
=20
 if ! type cvs >/dev/null 2>&1
 then
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 7c0a698..0543723 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -171,8 +171,6 @@ test_expect_success 'init with init.templatedir set=
' '
 	mkdir templatedir-source &&
 	echo Content >templatedir-source/file &&
 	(
-		HOME=3D"`pwd`" &&
-		export HOME &&
 		test_config=3D"${HOME}/.gitconfig" &&
 		git config -f "$test_config"  init.templatedir "${HOME}/templatedir-=
source" &&
 		mkdir templatedir-set &&
@@ -188,8 +186,6 @@ test_expect_success 'init with init.templatedir set=
' '
=20
 test_expect_success 'init --bare/--shared overrides system/global conf=
ig' '
 	(
-		HOME=3D"`pwd`" &&
-		export HOME &&
 		test_config=3D"$HOME"/.gitconfig &&
 		unset GIT_CONFIG_NOGLOBAL &&
 		git config -f "$test_config" core.bare false &&
@@ -205,8 +201,6 @@ test_expect_success 'init --bare/--shared overrides=
 system/global config' '
=20
 test_expect_success 'init honors global core.sharedRepository' '
 	(
-		HOME=3D"`pwd`" &&
-		export HOME &&
 		test_config=3D"$HOME"/.gitconfig &&
 		unset GIT_CONFIG_NOGLOBAL &&
 		git config -f "$test_config" core.sharedRepository 0666 &&
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index de38c7f..114967a 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -15,7 +15,6 @@ attr_check () {
=20
 }
=20
-
 test_expect_success 'setup' '
=20
 	mkdir -p a/b/d a/c &&
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 8abb71a..8617965 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -163,8 +163,6 @@ test_expect_success 'clone a void' '
=20
 test_expect_success 'clone respects global branch.autosetuprebase' '
 	(
-		HOME=3D$(pwd) &&
-		export HOME &&
 		test_config=3D"$HOME/.gitconfig" &&
 		unset GIT_CONFIG_NOGLOBAL &&
 		git config -f "$test_config" branch.autosetuprebase remote &&
diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-=
file.sh
index 3c4f319..ec0a106 100755
--- a/t/t9130-git-svn-authors-file.sh
+++ b/t/t9130-git-svn-authors-file.sh
@@ -95,8 +95,6 @@ test_expect_success 'fresh clone with svn.authors-fil=
e in config' '
 	(
 		rm -r "$GIT_DIR" &&
 		test x =3D x"$(git config svn.authorsfile)" &&
-		HOME=3D"`pwd`" &&
-		export HOME &&
 		test_config=3D"$HOME"/.gitconfig &&
 		unset GIT_CONFIG_NOGLOBAL &&
 		unset GIT_DIR &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3a3d4c4..8e90f43 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -861,6 +861,9 @@ test_create_repo "$test"
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$test" || exit 1
=20
+HOME=3D"$TRASH_DIRECTORY"
+export HOME
+
 this_test=3D${0##*/}
 this_test=3D${this_test%%-*}
 for skp in $GIT_SKIP_TESTS
--=20
1.7.2.2.175.ga619d.dirty
