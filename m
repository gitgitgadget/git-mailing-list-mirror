From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] t: use sane_unset instead of unset
Date: Sun, 12 Feb 2012 01:05:12 +0000
Message-ID: <1329008712-11572-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 02:05:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwNsi-0006PJ-5C
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 02:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906Ab2BLBF1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 20:05:27 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:59243 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620Ab2BLBF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 20:05:27 -0500
Received: by eekc14 with SMTP id c14so1409791eek.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 17:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=SHhNrdO3aHfBWwnwoNMZvhwLTMuCfbiYarVo2wqLg1o=;
        b=Pn609Zkd1j76hur0bL6fcnBxQRnBViHn1ceIGVQ1m7JOz63QftnLWL6SLDionMLwlD
         vCmLiDrIaRGA2DJkKzn9z89CVUS4ErBxZ2eIr+TI4Y3xVbkgG7+2n+7FP7R5l5Ns9rIh
         IB89DNqcZ1sDQqdY/gq4Pyt4y5KFQIV61/gJQ=
Received: by 10.14.120.74 with SMTP id o50mr872743eeh.18.1329008725948;
        Sat, 11 Feb 2012 17:05:25 -0800 (PST)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id c16sm42156710eei.1.2012.02.11.17.05.25
        (version=SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 17:05:25 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190557>

Change several tests to use the sane_unset function introduced in
v1.7.3.1-35-g00648ba instead of the built-in unset function.

This fixes a failure I was having on t9130-git-svn-authors-file.sh on
Solaris, and prevents several other issues from occurring.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t4150-am.sh                    |    2 +-
 t/t5560-http-backend-noserver.sh |    6 +++---
 t/t6032-merge-large-rename.sh    |    2 +-
 t/t9130-git-svn-authors-file.sh  |    4 ++--
 t/t9200-git-cvsexportcommit.sh   |    2 +-
 t/t9808-git-p4-chdir.sh          |    4 ++--
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 8807b60..f1b60b8 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -136,7 +136,7 @@ test_expect_success setup '
 	git format-patch -M --stdout lorem^ >rename-add.patch &&
=20
 	# reset time
-	unset test_tick &&
+	sane_unset test_tick &&
 	test_tick
 '
=20
diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-no=
server.sh
index 0ad7ce0..ef98d95 100755
--- a/t/t5560-http-backend-noserver.sh
+++ b/t/t5560-http-backend-noserver.sh
@@ -17,7 +17,7 @@ run_backend() {
 GET() {
 	REQUEST_METHOD=3D"GET" && export REQUEST_METHOD &&
 	run_backend "/repo.git/$1" &&
-	unset REQUEST_METHOD &&
+	sane_unset REQUEST_METHOD &&
 	if ! grep "Status" act.out >act
 	then
 		printf "Status: 200 OK\r\n" >act
@@ -30,8 +30,8 @@ POST() {
 	REQUEST_METHOD=3D"POST" && export REQUEST_METHOD &&
 	CONTENT_TYPE=3D"application/x-$1-request" && export CONTENT_TYPE &&
 	run_backend "/repo.git/$1" "$2" &&
-	unset REQUEST_METHOD &&
-	unset CONTENT_TYPE &&
+	sane_unset REQUEST_METHOD &&
+	sane_unset CONTENT_TYPE &&
 	if ! grep "Status" act.out >act
 	then
 		printf "Status: 200 OK\r\n" >act
diff --git a/t/t6032-merge-large-rename.sh b/t/t6032-merge-large-rename=
=2Esh
index fdb6c25..94f010b 100755
--- a/t/t6032-merge-large-rename.sh
+++ b/t/t6032-merge-large-rename.sh
@@ -95,7 +95,7 @@ test_expect_success 'setup large simple rename' '
 '
=20
 test_expect_success 'massive simple rename does not spam added files' =
'
-	unset GIT_MERGE_VERBOSITY &&
+	sane_unset GIT_MERGE_VERBOSITY &&
 	git merge --no-stat simple-rename | grep -v Removing >output &&
 	test 5 -gt "$(wc -l < output)"
 '
diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-=
file.sh
index b324c49..c3443ce 100755
--- a/t/t9130-git-svn-authors-file.sh
+++ b/t/t9130-git-svn-authors-file.sh
@@ -96,8 +96,8 @@ test_expect_success 'fresh clone with svn.authors-fil=
e in config' '
 		rm -r "$GIT_DIR" &&
 		test x =3D x"$(git config svn.authorsfile)" &&
 		test_config=3D"$HOME"/.gitconfig &&
-		unset GIT_DIR &&
-		unset GIT_CONFIG &&
+		sane_unset GIT_DIR &&
+		sane_unset GIT_CONFIG &&
 		git config --global \
 		  svn.authorsfile "$HOME"/svn-authors &&
 		test x"$HOME"/svn-authors =3D x"$(git config svn.authorsfile)" &&
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcomm=
it.sh
index 518358a..b59be9a 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -321,7 +321,7 @@ test_expect_success 'use the same checkout for Git =
and CVS' '
=20
 	(mkdir shared &&
 	 cd shared &&
-	 unset GIT_DIR &&
+	 sane_unset GIT_DIR &&
 	 cvs co . &&
 	 git init &&
 	 git add " space" &&
diff --git a/t/t9808-git-p4-chdir.sh b/t/t9808-git-p4-chdir.sh
index eb8cc95..f002283 100755
--- a/t/t9808-git-p4-chdir.sh
+++ b/t/t9808-git-p4-chdir.sh
@@ -25,7 +25,7 @@ test_expect_success 'P4CONFIG and absolute dir clone'=
 '
 	test_when_finished cleanup_git &&
 	(
 		P4CONFIG=3Dp4config && export P4CONFIG &&
-		unset P4PORT P4CLIENT &&
+		sane_unset P4PORT P4CLIENT &&
 		"$GITP4" clone --verbose --dest=3D"$git" //depot
 	)
 '
@@ -37,7 +37,7 @@ test_expect_success 'P4CONFIG and relative dir clone'=
 '
 	test_when_finished cleanup_git &&
 	(
 		P4CONFIG=3Dp4config && export P4CONFIG &&
-		unset P4PORT P4CLIENT &&
+		sane_unset P4PORT P4CLIENT &&
 		"$GITP4" clone --verbose --dest=3D"git" //depot
 	)
 '
--=20
1.7.9
