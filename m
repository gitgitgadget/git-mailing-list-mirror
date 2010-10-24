From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 10/18] t1510: setup case #7
Date: Sun, 24 Oct 2010 19:11:42 +0700
Message-ID: <1287922310-14678-11-git-send-email-pclouds@gmail.com>
References: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 14:13:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9zRn-0000DT-P6
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 14:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620Ab0JXMNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 08:13:05 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55620 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab0JXMND (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 08:13:03 -0400
Received: by pvb32 with SMTP id 32so423774pvb.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 05:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=SEfXn0zHUhxsQnm9A6bjmY5x7Tg508pRKHH5Yq+9e8Y=;
        b=RBLiP4CquGB4Svm4NUsK6pxLD8Ve+JBj4G3SbjUzWllXIsdwKx9RhvrSkEgbu7iZQU
         xGNPu/TOVg84Gtjm29+Xw8dYGWTKZPYdmdt18snGiemYEIb/upNRVgPojhdhc/IKHCUI
         vOmelgyLS8PUGR6uVG5R3neKOcbj6ki6iXYDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=a+HhpKVUUlPgUnZnQcdJ7G0fCBKbWBfOnVPoLwCpkI1s2s4JsDYVvuzopz3qe4qCp1
         4K8g3jKvvT8+HSa1di6GFeZdsRk2T1tUBWim7U4kMTRDwBnVEoU/dBD7QIMJky2G9D8M
         1Y6FkzGlU5A3E0oeBL43Hcp3oJblMVtuCZQYc=
Received: by 10.142.216.6 with SMTP id o6mr3972770wfg.236.1287922382871;
        Sun, 24 Oct 2010 05:13:02 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id w42sm9128153wfh.3.2010.10.24.05.12.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 05:13:02 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 24 Oct 2010 19:12:58 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159865>

---
 t/t1510-repo-setup.sh |  261 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 261 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 7e902b0..2f36bfe 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1002,4 +1002,265 @@ EOF
 	GIT_DIR="$TRASH_DIRECTORY/6/.git" test_repo 6/sub/sub
 '
 
+#
+# case #7
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# core.worktree is overridden by GIT_WORK_TREE, so this is the same as
+# case #3.
+#
+#  - worktree is at $GIT_WORK_TREE
+#  - cwd is at worktree root
+#  - prefix is calculated
+#  - git_dir is at $GIT_DIR
+#  - cwd can be outside worktree
+
+test_expect_success '#7: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 7 7/sub 7/sub/sub 7.wt 7.wt/sub 7/wt 7/wt/sub &&
+	cd 7 &&
+	git init &&
+	git config core.worktree non-existent &&
+	cd ..
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE at root' '
+	cat >7/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/7
+$TRASH_DIRECTORY/7
+EOF
+	GIT_DIR=.git GIT_WORK_TREE="$TRASH_DIRECTORY/7" test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE(rel) at root' '
+	cat >7/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/7
+$TRASH_DIRECTORY/7
+EOF
+	GIT_DIR=.git GIT_WORK_TREE=. test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE at root' '
+	cat >7/expected <<EOF &&
+$TRASH_DIRECTORY/7/.git
+$TRASH_DIRECTORY/7
+$TRASH_DIRECTORY/7
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE="$TRASH_DIRECTORY/7" test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE(rel) at root' '
+	cat >7/expected <<EOF &&
+$TRASH_DIRECTORY/7/.git
+$TRASH_DIRECTORY/7
+$TRASH_DIRECTORY/7
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=. test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORKTREE in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/7/.git
+$TRASH_DIRECTORY/7
+$TRASH_DIRECTORY/7
+sub/sub/
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE="$TRASH_DIRECTORY/7" test_repo 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORKTREE(rel) in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/7/.git
+$TRASH_DIRECTORY/7
+$TRASH_DIRECTORY/7
+sub/sub/
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE=../.. test_repo 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORKTREE in subdir' '
+	cat >7/sub/expected <<EOF &&
+$TRASH_DIRECTORY/7/.git
+$TRASH_DIRECTORY/7
+$TRASH_DIRECTORY/7
+sub/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE="$TRASH_DIRECTORY/7" test_repo 7/sub
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORKTREE(rel) in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/7/.git
+$TRASH_DIRECTORY/7
+$TRASH_DIRECTORY/7
+sub/sub/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=../.. test_repo 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=wt at root' '
+	cat >7/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/7/wt
+$TRASH_DIRECTORY/7
+EOF
+	GIT_DIR=.git GIT_WORK_TREE="$TRASH_DIRECTORY/7/wt" test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=wt(rel) at root' '
+	cat >7/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/7/wt
+$TRASH_DIRECTORY/7
+EOF
+	GIT_DIR=.git GIT_WORK_TREE=wt test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=wt(rel) at root' '
+	cat >7/expected <<EOF &&
+$TRASH_DIRECTORY/7/.git
+$TRASH_DIRECTORY/7/wt
+$TRASH_DIRECTORY/7
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=wt test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=wt at root' '
+	cat >7/expected <<EOF &&
+$TRASH_DIRECTORY/7/.git
+$TRASH_DIRECTORY/7/wt
+$TRASH_DIRECTORY/7
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE="$TRASH_DIRECTORY/7/wt" test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=wt in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+../../.git
+$TRASH_DIRECTORY/7/wt
+$TRASH_DIRECTORY/7/sub/sub
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE="$TRASH_DIRECTORY/7/wt" test_repo 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=wt(rel) in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+../../.git
+$TRASH_DIRECTORY/7/wt
+$TRASH_DIRECTORY/7/sub/sub
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE=../../wt test_repo 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=wt(rel) in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/7/.git
+$TRASH_DIRECTORY/7/wt
+$TRASH_DIRECTORY/7/sub/sub
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=../../wt test_repo 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=wt in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/7/.git
+$TRASH_DIRECTORY/7/wt
+$TRASH_DIRECTORY/7/sub/sub
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE="$TRASH_DIRECTORY/7/wt" test_repo 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=.. at root' '
+	cat >7/expected <<EOF &&
+$TRASH_DIRECTORY/7/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+7/
+EOF
+	GIT_DIR=.git GIT_WORK_TREE="$TRASH_DIRECTORY" test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=..(rel) at root' '
+	cat >7/expected <<EOF &&
+$TRASH_DIRECTORY/7/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+7/
+EOF
+	GIT_DIR=.git GIT_WORK_TREE=.. test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=..(rel) at root' '
+	cat >7/expected <<EOF &&
+$TRASH_DIRECTORY/7/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+7/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=.. test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=.. at root' '
+	cat >7/expected <<EOF &&
+$TRASH_DIRECTORY/7/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+7/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE="$TRASH_DIRECTORY" test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=.. in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/7/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+7/sub/sub/
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE="$TRASH_DIRECTORY" test_repo 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=..(rel) in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/7/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+7/sub/sub/
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE=../../.. test_repo 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=..(rel) in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/7/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+7/sub/sub/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=../../../ test_repo 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=.. in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/7/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+7/sub/sub/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE="$TRASH_DIRECTORY" test_repo 7/sub/sub
+'
+
 test_done
-- 
1.7.0.2.445.gcbdb3
