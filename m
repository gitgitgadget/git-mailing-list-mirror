From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 14/18] t1510: setup case #11
Date: Sun, 24 Oct 2010 19:11:46 +0700
Message-ID: <1287922310-14678-15-git-send-email-pclouds@gmail.com>
References: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 14:13:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9zSA-0000I7-Fb
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 14:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646Ab0JXMNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 08:13:30 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55620 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab0JXMN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 08:13:29 -0400
Received: by mail-pv0-f174.google.com with SMTP id 32so423774pvb.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 05:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=9S3ro+gFp4yzt+4OKW88f2C2ND8DcRIBx3iisPudhLM=;
        b=Tk+jqRCxYQW44VvP4WsnxfWii0i0mXjiYqp83cf6RMFL3D18JbKB56EZFKgvF9jDAO
         ZtVUhy2RXAhN8R6HuiInXtYXG/au1MLt5sIlrn8ZSbsqAK+eAPg9jvy1l5Ex4XPkhNtT
         Zbo8KAxQlYzf6m6Up05Vm1aNANuGjJMRWN0kc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=R33DX8O0yvzSccD4DBhtojcziu+kaVBYBXkGlnrYQwYxh/0rA/qegJi+w3wFvqrDud
         WVsoJcYAbIqVk1te+OaVGEciqxgQ4u0md3qVT9OMKq9FPo+etjJrOcq0jPfsWWRgzTOO
         Xn6IOFb1f4Ev5Z+6/bTTAepOQ8OS+VwF2CTcc=
Received: by 10.142.216.7 with SMTP id o7mr4613113wfg.55.1287922409326;
        Sun, 24 Oct 2010 05:13:29 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id x18sm9130487wfa.23.2010.10.24.05.13.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 05:13:28 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 24 Oct 2010 19:13:24 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159870>

---
 t/t1510-repo-setup.sh |  255 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 255 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 31bacd7..f8ab969 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1426,4 +1426,259 @@ EOF
 	GIT_DIR=../.git test_repo 10/sub
 '
 
+#
+# case #11
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is set
+#  - core.worktree is not set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# same as case #3 except that git_dir is set by .git file
+
+test_expect_success '#11: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 11 11/sub 11/sub/sub 11.wt 11.wt/sub 11/wt 11/wt/sub &&
+	cd 11 &&
+	git init &&
+	mv .git ../11.git &&
+	echo gitdir: ../11.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE at root' '
+	cat >11/expected <<EOF &&
+$TRASH_DIRECTORY/11.git
+$TRASH_DIRECTORY/11
+$TRASH_DIRECTORY/11
+EOF
+	GIT_DIR=.git GIT_WORK_TREE="$TRASH_DIRECTORY/11" test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE(rel) at root' '
+	cat >11/expected <<EOF &&
+$TRASH_DIRECTORY/11.git
+$TRASH_DIRECTORY/11
+$TRASH_DIRECTORY/11
+EOF
+	GIT_DIR=.git GIT_WORK_TREE=. test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE at root' '
+	cat >11/expected <<EOF &&
+$TRASH_DIRECTORY/11.git
+$TRASH_DIRECTORY/11
+$TRASH_DIRECTORY/11
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE="$TRASH_DIRECTORY/11" test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE(rel) at root' '
+	cat >11/expected <<EOF &&
+$TRASH_DIRECTORY/11.git
+$TRASH_DIRECTORY/11
+$TRASH_DIRECTORY/11
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=. test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORKTREE in subdir' '
+	cat >11/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/11.git
+$TRASH_DIRECTORY/11
+$TRASH_DIRECTORY/11
+sub/sub/
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE="$TRASH_DIRECTORY/11" test_repo 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORKTREE(rel) in subdir' '
+	cat >11/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/11.git
+$TRASH_DIRECTORY/11
+$TRASH_DIRECTORY/11
+sub/sub/
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE=../.. test_repo 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORKTREE in subdir' '
+	cat >11/sub/expected <<EOF &&
+$TRASH_DIRECTORY/11.git
+$TRASH_DIRECTORY/11
+$TRASH_DIRECTORY/11
+sub/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE="$TRASH_DIRECTORY/11" test_repo 11/sub
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORKTREE(rel) in subdir' '
+	cat >11/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/11.git
+$TRASH_DIRECTORY/11
+$TRASH_DIRECTORY/11
+sub/sub/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=../.. test_repo 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=wt at root' '
+	cat >11/expected <<EOF &&
+$TRASH_DIRECTORY/11.git
+$TRASH_DIRECTORY/11/wt
+$TRASH_DIRECTORY/11
+EOF
+	GIT_DIR=.git GIT_WORK_TREE="$TRASH_DIRECTORY/11/wt" test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=wt(rel) at root' '
+	cat >11/expected <<EOF &&
+$TRASH_DIRECTORY/11.git
+$TRASH_DIRECTORY/11/wt
+$TRASH_DIRECTORY/11
+EOF
+	GIT_DIR=.git GIT_WORK_TREE=wt test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=wt(rel) at root' '
+	cat >11/expected <<EOF &&
+$TRASH_DIRECTORY/11.git
+$TRASH_DIRECTORY/11/wt
+$TRASH_DIRECTORY/11
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=wt test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=wt at root' '
+	cat >11/expected <<EOF &&
+$TRASH_DIRECTORY/11.git
+$TRASH_DIRECTORY/11/wt
+$TRASH_DIRECTORY/11
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE="$TRASH_DIRECTORY/11/wt" test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=wt in subdir' '
+	cat >11/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/11.git
+$TRASH_DIRECTORY/11/wt
+$TRASH_DIRECTORY/11/sub/sub
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE="$TRASH_DIRECTORY/11/wt" test_repo 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=wt(rel) in subdir' '
+	cat >11/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/11.git
+$TRASH_DIRECTORY/11/wt
+$TRASH_DIRECTORY/11/sub/sub
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE=../../wt test_repo 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=wt(rel) in subdir' '
+	cat >11/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/11.git
+$TRASH_DIRECTORY/11/wt
+$TRASH_DIRECTORY/11/sub/sub
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=../../wt test_repo 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=wt in subdir' '
+	cat >11/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/11.git
+$TRASH_DIRECTORY/11/wt
+$TRASH_DIRECTORY/11/sub/sub
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE="$TRASH_DIRECTORY/11/wt" test_repo 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=.. at root' '
+	cat >11/expected <<EOF &&
+$TRASH_DIRECTORY/11.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+11/
+EOF
+	GIT_DIR=.git GIT_WORK_TREE="$TRASH_DIRECTORY" test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=..(rel) at root' '
+	cat >11/expected <<EOF &&
+$TRASH_DIRECTORY/11.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+11/
+EOF
+	GIT_DIR=.git GIT_WORK_TREE=.. test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=..(rel) at root' '
+	cat >11/expected <<EOF &&
+$TRASH_DIRECTORY/11/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+11/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=.. test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=.. at root' '
+	cat >11/expected <<EOF &&
+$TRASH_DIRECTORY/11.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+11/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE="$TRASH_DIRECTORY" test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=.. in subdir' '
+	cat >11/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/11.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+11/sub/sub/
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE="$TRASH_DIRECTORY" test_repo 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=..(rel) in subdir' '
+	cat >11/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/11.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+11/sub/sub/
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE=../../.. test_repo 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=..(rel) in subdir' '
+	cat >11/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/11.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+11/sub/sub/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=../../../ test_repo 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=.. in subdir' '
+	cat >11/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/11.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+11/sub/sub/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE="$TRASH_DIRECTORY" test_repo 11/sub/sub
+'
+
 test_done
-- 
1.7.0.2.445.gcbdb3
