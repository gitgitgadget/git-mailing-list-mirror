From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 06/18] t1510: setup case #3
Date: Sun, 24 Oct 2010 19:11:38 +0700
Message-ID: <1287922310-14678-7-git-send-email-pclouds@gmail.com>
References: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 14:12:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9zRU-00009U-FG
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 14:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594Ab0JXMMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 08:12:36 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53526 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab0JXMMg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 08:12:36 -0400
Received: by mail-pw0-f46.google.com with SMTP id 8so245656pwj.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 05:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=EAiM4KRBWUEryk6IYpt3PQA5Fg+U3NDKpUGWMFS7z28=;
        b=IRCC9Qwwl/eQXPEkTbz7dboc9HkiTG+b9DzwPhlXsPkqnNVju2q1dDhapznO/f9O7L
         IcuZi7nJMTpt7TJs+G0RnFgZYsyhbsmeQLM/sGtvrrUbtCdKk8a42qTsImclr9w9PwH0
         rWTszr1XtzW11fnMj6Yba5xc9roTb+DTWqfRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GDgGKAKZvnuak0xgp11UZ9auNVd4TdL+dseJzX5yBByVCv9/aNz4gmdUrEZqgOUvUU
         kxiFP+kF3DXhZOkD0RauvgFaGBXok6VUuRcW6cL6eHGRXAy9piYCgD/l3c1Zwk4vrugm
         dO/q30zhUiNPQooNjIO9Mwpggs1DdQC/zAMiw=
Received: by 10.142.216.11 with SMTP id o11mr4288792wfg.238.1287922355981;
        Sun, 24 Oct 2010 05:12:35 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id e36sm9121866wfj.14.2010.10.24.05.12.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 05:12:35 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 24 Oct 2010 19:12:31 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159862>

---
 t/t1510-repo-setup.sh |  255 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 255 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 20ad6d4..508b7e2 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -202,4 +202,259 @@ EOF
 	GIT_DIR=../.git test_repo 2/sub
 '
 
+#
+# case #3
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+#  - worktree is set to $GIT_WORK_TREE
+#  - cwd is at worktree root
+#  - prefix is calculated
+#  - git_dir is set to $GIT_DIR
+#  - cwd can be outside worktree
+
+test_expect_success '#3: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 3 3/sub 3/sub/sub 3.wt 3.wt/sub 3/wt 3/wt/sub &&
+	cd 3 && git init && cd ..
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE at root' '
+	cat >3/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/3
+$TRASH_DIRECTORY/3
+EOF
+	GIT_DIR=.git GIT_WORK_TREE="$TRASH_DIRECTORY/3" test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE(rel) at root' '
+	cat >3/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/3
+$TRASH_DIRECTORY/3
+EOF
+	GIT_DIR=.git GIT_WORK_TREE=. test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE at root' '
+	cat >3/expected <<EOF &&
+$TRASH_DIRECTORY/3/.git
+$TRASH_DIRECTORY/3
+$TRASH_DIRECTORY/3
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE="$TRASH_DIRECTORY/3" test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE(rel) at root' '
+	cat >3/expected <<EOF &&
+$TRASH_DIRECTORY/3/.git
+$TRASH_DIRECTORY/3
+$TRASH_DIRECTORY/3
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE=. test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORKTREE in subdir' '
+	cat >3/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/3/.git
+$TRASH_DIRECTORY/3
+$TRASH_DIRECTORY/3
+sub/sub/
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE="$TRASH_DIRECTORY/3" test_repo 3/sub/sub
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORKTREE(rel) in subdir' '
+	cat >3/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/3/.git
+$TRASH_DIRECTORY/3
+$TRASH_DIRECTORY/3
+sub/sub/
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE=../.. test_repo 3/sub/sub
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORKTREE in subdir' '
+	cat >3/sub/expected <<EOF &&
+$TRASH_DIRECTORY/3/.git
+$TRASH_DIRECTORY/3
+$TRASH_DIRECTORY/3
+sub/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE="$TRASH_DIRECTORY/3" test_repo 3/sub
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORKTREE(rel) in subdir' '
+	cat >3/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/3/.git
+$TRASH_DIRECTORY/3
+$TRASH_DIRECTORY/3
+sub/sub/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE=../.. test_repo 3/sub/sub
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=wt at root' '
+	cat >3/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/3/wt
+$TRASH_DIRECTORY/3
+EOF
+	GIT_DIR=.git GIT_WORK_TREE="$TRASH_DIRECTORY/3/wt" test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=wt(rel) at root' '
+	cat >3/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/3/wt
+$TRASH_DIRECTORY/3
+EOF
+	GIT_DIR=.git GIT_WORK_TREE=wt test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=wt(rel) at root' '
+	cat >3/expected <<EOF &&
+$TRASH_DIRECTORY/3/.git
+$TRASH_DIRECTORY/3/wt
+$TRASH_DIRECTORY/3
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE=wt test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=wt at root' '
+	cat >3/expected <<EOF &&
+$TRASH_DIRECTORY/3/.git
+$TRASH_DIRECTORY/3/wt
+$TRASH_DIRECTORY/3
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE="$TRASH_DIRECTORY/3/wt" test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=wt in subdir' '
+	cat >3/sub/sub/expected <<EOF &&
+../../.git
+$TRASH_DIRECTORY/3/wt
+$TRASH_DIRECTORY/3/sub/sub
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE="$TRASH_DIRECTORY/3/wt" test_repo 3/sub/sub
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=wt(rel) in subdir' '
+	cat >3/sub/sub/expected <<EOF &&
+../../.git
+$TRASH_DIRECTORY/3/wt
+$TRASH_DIRECTORY/3/sub/sub
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE=../../wt test_repo 3/sub/sub
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=wt(rel) in subdir' '
+	cat >3/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/3/.git
+$TRASH_DIRECTORY/3/wt
+$TRASH_DIRECTORY/3/sub/sub
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE=../../wt test_repo 3/sub/sub
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=wt in subdir' '
+	cat >3/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/3/.git
+$TRASH_DIRECTORY/3/wt
+$TRASH_DIRECTORY/3/sub/sub
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE="$TRASH_DIRECTORY/3/wt" test_repo 3/sub/sub
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=.. at root' '
+	cat >3/expected <<EOF &&
+$TRASH_DIRECTORY/3/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+3/
+EOF
+	GIT_DIR=.git GIT_WORK_TREE="$TRASH_DIRECTORY" test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=..(rel) at root' '
+	cat >3/expected <<EOF &&
+$TRASH_DIRECTORY/3/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+3/
+EOF
+	GIT_DIR=.git GIT_WORK_TREE=.. test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=..(rel) at root' '
+	cat >3/expected <<EOF &&
+$TRASH_DIRECTORY/3/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+3/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE=.. test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=.. at root' '
+	cat >3/expected <<EOF &&
+$TRASH_DIRECTORY/3/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+3/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE="$TRASH_DIRECTORY" test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=.. in subdir' '
+	cat >3/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/3/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+3/sub/sub/
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE="$TRASH_DIRECTORY" test_repo 3/sub/sub
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=..(rel) in subdir' '
+	cat >3/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/3/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+3/sub/sub/
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE=../../.. test_repo 3/sub/sub
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=..(rel) in subdir' '
+	cat >3/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/3/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+3/sub/sub/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE=../../../ test_repo 3/sub/sub
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=.. in subdir' '
+	cat >3/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/3/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+3/sub/sub/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE="$TRASH_DIRECTORY" test_repo 3/sub/sub
+'
+
 test_done
-- 
1.7.0.2.445.gcbdb3
