From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 5/5] t7409: do not use export X=Y
Date: Fri, 26 Apr 2013 11:18:28 +0200
Message-ID: <201304261118.28538.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 11:18:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVene-0000ip-3O
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 11:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759001Ab3DZJSe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Apr 2013 05:18:34 -0400
Received: from mout.web.de ([212.227.15.4]:58345 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758893Ab3DZJSd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Apr 2013 05:18:33 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0M9oW8-1UKhUm1hdI-00B1M9 for <git@vger.kernel.org>; Fri,
 26 Apr 2013 11:18:32 +0200
X-Provags-ID: V02:K0:ShMvTOr8vHZh1bPPc401PhQMXMLKRptLFvsfYDx1WPB
 aUq+qG00nX1jIjji5wXg+/APTgoCoBH9sltrfbKmMnpovBydMn
 J3YnCYCzD0ncMXgIIPlmmj3XwOXsbyFUF0tebmK5c4QWtDL8pK
 OgUBnuohBETwY2ar7TgVSKN9H33QpJHDnaegSAHnVtrcLBh7U4
 fKGHp+u2MAxD5GroBbh/w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222521>

The shell syntax "export X=3DY A=3DB" is not understood by all shells.
Split the non portable line into separate lines like this:
A=3DB
X=3DY
export A X

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t7409-submodule-detached-worktree.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/t/t7409-submodule-detached-worktree.sh b/t/t7409-submodule=
-detached-worktree.sh
index 2fec13d..c207171 100755
--- a/t/t7409-submodule-detached-worktree.sh
+++ b/t/t7409-submodule-detached-worktree.sh
@@ -23,7 +23,9 @@ test_expect_success 'submodule on detached working tr=
ee' '
 	mkdir home &&
 	(
 		cd home &&
-		export GIT_WORK_TREE=3D"$(pwd)" GIT_DIR=3D"$(pwd)/.dotfiles" &&
+		GIT_WORK_TREE=3D"$(pwd)" &&
+		GIT_DIR=3D"$(pwd)/.dotfiles" &&
+		export GIT_WORK_TREE GIT_DIR &&
 		git clone --bare ../remote .dotfiles &&
 		git submodule add ../bundle1 .vim/bundle/sogood &&
 		test_commit "sogood" &&
@@ -39,7 +41,9 @@ test_expect_success 'submodule on detached working tr=
ee' '
 	(
 		cd home2 &&
 		git clone --bare ../remote .dotfiles &&
-		export GIT_WORK_TREE=3D"$(pwd)" GIT_DIR=3D"$(pwd)/.dotfiles" &&
+		GIT_WORK_TREE=3D"$(pwd)" &&
+		GIT_DIR=3D"$(pwd)/.dotfiles" &&
+		export GIT_WORK_TREE GIT_DIR &&
 		git checkout master &&
 		git submodule update --init &&
 		(
@@ -55,7 +59,8 @@ test_expect_success 'submodule on detached working po=
inted by core.worktree' '
 	mkdir home3 &&
 	(
 		cd home3 &&
-		export GIT_DIR=3D"$(pwd)/.dotfiles" &&
+		GIT_DIR=3D"$(pwd)/.dotfiles" &&
+		export GIT_DIR &&
 		git clone --bare ../remote "$GIT_DIR" &&
 		git config core.bare false &&
 		git config core.worktree .. &&
@@ -66,7 +71,8 @@ test_expect_success 'submodule on detached working po=
inted by core.worktree' '
 	) &&
 	(
 		cd home &&
-		export GIT_DIR=3D"$(pwd)/.dotfiles" &&
+		GIT_DIR=3D"$(pwd)/.dotfiles" &&
+		export GIT_DIR &&
 		git config core.bare false &&
 		git config core.worktree .. &&
 		git pull &&
--=20
1.8.2.1.614.g66d7af5
