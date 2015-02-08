From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] submodule: use worktree.path instead of core.worktree
Date: Sun,  8 Feb 2015 20:16:34 +0700
Message-ID: <1423401394-13675-4-git-send-email-pclouds@gmail.com>
References: <1423401394-13675-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Max Kirillov <max@max630.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 14:16:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKRjM-0002VR-BY
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 14:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192AbbBHNQw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 08:16:52 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:51634 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbbBHNQv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 08:16:51 -0500
Received: by mail-pa0-f47.google.com with SMTP id lj1so27701315pab.6
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 05:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=k+GYEoIja6XHzoN4q9/NNc4TAcNRSfJxf9z3FQuER34=;
        b=inemxqbiw+fcBozuh7eVC0DJyDp+4phxejCRUe2I0MWHuu5jZYW+VMsehU1BpObZbh
         T/XaBtUkGTycDUKNAyTXG54Vo9PhjTeaJmQRUgZ0YqPy654FoYJNzT/h7c3fpVfct1VS
         FY4RAWyCtoUzTKE8NGVitKa/KB8MUY/uF0l0/+H8RjnYCEy5IS7k0Ll+ta+7fReXK7XP
         e4XdsXc1dz/2iJSlih4j6SJ1FKV/a2IdY4T9ThlUBl8s2U3EMYTuK0VaH62XTunMMjgm
         CepxLSiSAqwty3lZMgFrkbNP4sgRMQruD8Ec97bHBiEmhwfPgPUJ76uuX8vAizY1T7o3
         xGbQ==
X-Received: by 10.70.42.47 with SMTP id k15mr20864502pdl.134.1423401410971;
        Sun, 08 Feb 2015 05:16:50 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id ex1sm13398212pbc.80.2015.02.08.05.16.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 05:16:50 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 20:16:56 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423401394-13675-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263513>

This opens a door of using submodule with multiple worktrees

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-submodule.sh                       | 2 +-
 submodule.c                            | 6 +++---
 t/lib-submodule-update.sh              | 8 ++++----
 t/t7400-submodule-basic.sh             | 4 ++--
 t/t7409-submodule-detached-worktree.sh | 6 +++---
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9245abf..6e9e1d1 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -309,7 +309,7 @@ module_clone()
 	printf '%s\n' "gitdir: $rel/$a" >"$sm_path/.git"
=20
 	rel=3D$(printf '%s\n' "$a" | sed -e 's|[^/][^/]*|..|g')
-	(clear_local_git_env; cd "$sm_path" && GIT_WORK_TREE=3D. git config c=
ore.worktree "$rel/$b")
+	(clear_local_git_env; cd "$sm_path" && GIT_WORK_TREE=3D. git config w=
orktree.path "$rel/$b")
 }
=20
 isnumber()
diff --git a/submodule.c b/submodule.c
index d37d400..f886fa6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1115,11 +1115,11 @@ void connect_work_tree_and_git_dir(const char *=
work_tree, const char *git_dir)
=20
 	/* Update core.worktree setting */
 	strbuf_reset(&file_name);
-	strbuf_addf(&file_name, "%s/config", git_dir);
-	if (git_config_set_in_file(file_name.buf, "core.worktree",
+	strbuf_addf(&file_name, "%s/config.worktree", git_dir);
+	if (git_config_set_in_file(file_name.buf, "worktree.path",
 				   relative_path(real_work_tree, git_dir,
 						 &rel_path)))
-		die(_("Could not set core.worktree in %s"),
+		die(_("Could not set worktree.path in %s"),
 		    file_name.buf);
=20
 	strbuf_release(&file_name);
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 79cdd34..ce140cf 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -105,7 +105,7 @@ replace_gitfile_with_git_dir () {
 		git_dir=3D"$(git rev-parse --git-dir)" &&
 		rm -f .git &&
 		cp -R "$git_dir" .git &&
-		GIT_WORK_TREE=3D. git config --unset core.worktree
+		GIT_WORK_TREE=3D. git config --unset worktree.path
 	)
 }
=20
@@ -120,16 +120,16 @@ test_git_directory_is_unchanged () {
 	(
 		cd ".git/modules/$1" &&
 		# does core.worktree point at the right place?
-		test "$(git config core.worktree)" =3D "../../../$1" &&
+		test "$(git config worktree.path)" =3D "../../../$1" &&
 		# remove it temporarily before comparing, as
 		# "$1/.git/config" lacks it...
-		git config --unset core.worktree
+		git config --unset worktree.path
 	) &&
 	diff -r ".git/modules/$1" "$1/.git" &&
 	(
 		# ... and then restore.
 		cd ".git/modules/$1" &&
-		git config core.worktree "../../../$1"
+		git config worktree.path "../../../$1"
 	)
 }
=20
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 7c88245..def28e6 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -93,7 +93,7 @@ test_expect_success 'submodule add' '
 		test_cmp expect submod/.git &&
 		(
 			cd submod &&
-			git config core.worktree >actual &&
+			git config worktree.path >actual &&
 			echo "../../../submod" >expect &&
 			test_cmp expect actual &&
 			rm -f actual expect
@@ -945,7 +945,7 @@ test_expect_success 'submodule deinit fails when su=
bmodule has a .git directory
 		cd init &&
 		rm .git &&
 		cp -R ../.git/modules/example .git &&
-		GIT_WORK_TREE=3D. git config --unset core.worktree
+		GIT_WORK_TREE=3D. git config --unset worktree.path
 	) &&
 	test_must_fail git submodule deinit init &&
 	test_must_fail git submodule deinit -f init &&
diff --git a/t/t7409-submodule-detached-worktree.sh b/t/t7409-submodule=
-detached-worktree.sh
index c207171..ba50d77 100755
--- a/t/t7409-submodule-detached-worktree.sh
+++ b/t/t7409-submodule-detached-worktree.sh
@@ -55,7 +55,7 @@ test_expect_success 'submodule on detached working tr=
ee' '
 	)
 '
=20
-test_expect_success 'submodule on detached working pointed by core.wor=
ktree' '
+test_expect_success 'submodule on detached working pointed by worktree=
=2Epath' '
 	mkdir home3 &&
 	(
 		cd home3 &&
@@ -63,7 +63,7 @@ test_expect_success 'submodule on detached working po=
inted by core.worktree' '
 		export GIT_DIR &&
 		git clone --bare ../remote "$GIT_DIR" &&
 		git config core.bare false &&
-		git config core.worktree .. &&
+		git config worktree.path .. &&
 		git checkout master &&
 		git submodule add ../bundle1 .vim/bundle/dupe &&
 		test_commit "dupe" &&
@@ -74,7 +74,7 @@ test_expect_success 'submodule on detached working po=
inted by core.worktree' '
 		GIT_DIR=3D"$(pwd)/.dotfiles" &&
 		export GIT_DIR &&
 		git config core.bare false &&
-		git config core.worktree .. &&
+		git config worktree.path .. &&
 		git pull &&
 		git submodule update --init &&
 		test -f .vim/bundle/dupe/shoot.t
--=20
2.3.0.rc1.137.g477eb31
