From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 09/18] t1510: setup case #6
Date: Sun, 24 Oct 2010 19:11:41 +0700
Message-ID: <1287922310-14678-10-git-send-email-pclouds@gmail.com>
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
	id 1P9zRn-0000DT-1v
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 14:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616Ab0JXMM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 08:12:56 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50622 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab0JXMM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 08:12:56 -0400
Received: by mail-pz0-f46.google.com with SMTP id 3so478452pzk.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 05:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=yQ6osL9jRRI3j4IHTM+MRw1vF1pQVtNGylrT5xnwF6U=;
        b=ORUZB5DeLMxt69cxLN0cQ1z93iJdJx0tU9vzZ6Wy+MXa4r1ZTU1fBy1AoisBpMm1b0
         zYGdFidWW3KuDMR55C7UdLT5KKqCc1bshoxQE4MxtFt6kpdTk6v423rWJIiMIQO8uIet
         nLIhqWl7HL/mVkxaiE9hlPCPgGBAqH18X3P/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FK4N5PHdAEZ8WrPCwD04UUsAsww3R3bjSHXXz105oO4Xu0QrLKNCN3CWZz+AmbuCyT
         /EQCGvzMCCO/FGVkPP+gOjkxN5wpG7A2xWLLr9CBMUbm0NHewuKSKL38aM75wGJd0yxR
         JQL4GA0oTMwpuX/axqVIrdi5G4VBozXqD8jks=
Received: by 10.142.212.11 with SMTP id k11mr4574649wfg.8.1287922375725;
        Sun, 24 Oct 2010 05:12:55 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id x18sm9129443wfa.23.2010.10.24.05.12.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 05:12:54 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 24 Oct 2010 19:12:51 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159866>

---
 t/t1510-repo-setup.sh |  279 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 279 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 87db2c6..7e902b0 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -723,4 +723,283 @@ EOF
 	test_repo 5
 '
 
+#
+# case #6
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+#  - worktree is at core.worktree
+#  - cwd is at worktree root
+#  - prefix is calculated
+#  - git_dir is at $GIT_DIR
+#  - cwd can be outside worktree
+
+test_expect_success '#6: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 6 6/sub 6/sub/sub 6.wt 6.wt/sub 6/wt 6/wt/sub &&
+	cd 6 && git init && cd ..
+'
+
+test_expect_success '#6: GIT_DIR(rel), GIT_WORK_TREE at root' '
+	cat >6/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/6
+$TRASH_DIRECTORY/6
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree "$TRASH_DIRECTORY/6" &&
+	GIT_DIR=.git test_repo 6
+'
+
+test_expect_success '#6: GIT_DIR(rel), GIT_WORK_TREE(rel) at root' '
+	cat >6/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/6
+$TRASH_DIRECTORY/6
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree .. &&
+	GIT_DIR=.git test_repo 6
+'
+
+test_expect_success '#6: GIT_DIR, GIT_WORK_TREE at root' '
+	cat >6/expected <<EOF &&
+$TRASH_DIRECTORY/6/.git
+$TRASH_DIRECTORY/6
+$TRASH_DIRECTORY/6
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree "$TRASH_DIRECTORY/6" &&
+	GIT_DIR="$TRASH_DIRECTORY/6/.git" test_repo 6
+'
+
+test_expect_success '#6: GIT_DIR, GIT_WORK_TREE(rel) at root' '
+	cat >6/expected <<EOF &&
+$TRASH_DIRECTORY/6/.git
+$TRASH_DIRECTORY/6
+$TRASH_DIRECTORY/6
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree .. &&
+	GIT_DIR="$TRASH_DIRECTORY/6/.git" test_repo 6
+'
+
+test_expect_failure '#6: GIT_DIR(rel), GIT_WORKTREE in subdir' '
+	cat >6/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/6/.git
+$TRASH_DIRECTORY/6
+$TRASH_DIRECTORY/6
+sub/sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree "$TRASH_DIRECTORY/6" &&
+	GIT_DIR=../../.git test_repo 6/sub/sub
+'
+
+test_expect_failure '#6: GIT_DIR(rel), GIT_WORKTREE(rel) in subdir' '
+	cat >6/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/6/.git
+$TRASH_DIRECTORY/6
+$TRASH_DIRECTORY/6
+sub/sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree .. &&
+	GIT_DIR=../../.git test_repo 6/sub/sub
+'
+
+test_expect_success '#6: GIT_DIR, GIT_WORKTREE in subdir' '
+	cat >6/sub/expected <<EOF &&
+$TRASH_DIRECTORY/6/.git
+$TRASH_DIRECTORY/6
+$TRASH_DIRECTORY/6
+sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree "$TRASH_DIRECTORY/6" &&
+	GIT_DIR="$TRASH_DIRECTORY/6/.git" test_repo 6/sub
+'
+
+test_expect_success '#6: GIT_DIR, GIT_WORKTREE(rel) in subdir' '
+	cat >6/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/6/.git
+$TRASH_DIRECTORY/6
+$TRASH_DIRECTORY/6
+sub/sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree .. &&
+	GIT_DIR="$TRASH_DIRECTORY/6/.git" test_repo 6/sub/sub
+'
+
+test_expect_success '#6: GIT_DIR(rel), GIT_WORK_TREE=wt at root' '
+	cat >6/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/6/wt
+$TRASH_DIRECTORY/6
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree "$TRASH_DIRECTORY/6/wt" &&
+	GIT_DIR=.git test_repo 6
+'
+
+test_expect_success '#6: GIT_DIR(rel), GIT_WORK_TREE=wt(rel) at root' '
+	cat >6/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/6/wt
+$TRASH_DIRECTORY/6
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree ../wt &&
+	GIT_DIR=.git test_repo 6
+'
+
+test_expect_success '#6: GIT_DIR, GIT_WORK_TREE=wt(rel) at root' '
+	cat >6/expected <<EOF &&
+$TRASH_DIRECTORY/6/.git
+$TRASH_DIRECTORY/6/wt
+$TRASH_DIRECTORY/6
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree ../wt &&
+	GIT_DIR="$TRASH_DIRECTORY/6/.git" test_repo 6
+'
+
+test_expect_success '#6: GIT_DIR, GIT_WORK_TREE=wt at root' '
+	cat >6/expected <<EOF &&
+$TRASH_DIRECTORY/6/.git
+$TRASH_DIRECTORY/6/wt
+$TRASH_DIRECTORY/6
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree "$TRASH_DIRECTORY/6/wt" &&
+	GIT_DIR="$TRASH_DIRECTORY/6/.git" test_repo 6
+'
+
+test_expect_success '#6: GIT_DIR(rel), GIT_WORK_TREE=wt in subdir' '
+	cat >6/sub/sub/expected <<EOF &&
+../../.git
+$TRASH_DIRECTORY/6/wt
+$TRASH_DIRECTORY/6/sub/sub
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree "$TRASH_DIRECTORY/6/wt" &&
+	GIT_DIR=../../.git test_repo 6/sub/sub
+'
+
+test_expect_success '#6: GIT_DIR(rel), GIT_WORK_TREE=wt(rel) in subdir' '
+	cat >6/sub/sub/expected <<EOF &&
+../../.git
+$TRASH_DIRECTORY/6/wt
+$TRASH_DIRECTORY/6/sub/sub
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree ../wt &&
+	GIT_DIR=../../.git test_repo 6/sub/sub
+'
+
+test_expect_success '#6: GIT_DIR, GIT_WORK_TREE=wt(rel) in subdir' '
+	cat >6/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/6/.git
+$TRASH_DIRECTORY/6/wt
+$TRASH_DIRECTORY/6/sub/sub
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree ../wt &&
+	GIT_DIR="$TRASH_DIRECTORY/6/.git" test_repo 6/sub/sub
+'
+
+test_expect_success '#6: GIT_DIR, GIT_WORK_TREE=wt in subdir' '
+	cat >6/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/6/.git
+$TRASH_DIRECTORY/6/wt
+$TRASH_DIRECTORY/6/sub/sub
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree "$TRASH_DIRECTORY/6/wt" &&
+	GIT_DIR="$TRASH_DIRECTORY/6/.git" test_repo 6/sub/sub
+'
+
+test_expect_failure '#6: GIT_DIR(rel), GIT_WORK_TREE=.. at root' '
+	cat >6/expected <<EOF &&
+6/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+6/
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree "$TRASH_DIRECTORY" &&
+	GIT_DIR=.git test_repo 6
+'
+
+test_expect_failure '#6: GIT_DIR(rel), GIT_WORK_TREE=..(rel) at root' '
+	cat >6/expected <<EOF &&
+6/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+6/
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree ../../ &&
+	GIT_DIR=.git test_repo 6
+'
+
+test_expect_success '#6: GIT_DIR, GIT_WORK_TREE=..(rel) at root' '
+	cat >6/expected <<EOF &&
+$TRASH_DIRECTORY/6/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+6/
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree ../../ &&
+	GIT_DIR="$TRASH_DIRECTORY/6/.git" test_repo 6
+'
+
+test_expect_success '#6: GIT_DIR, GIT_WORK_TREE=.. at root' '
+	cat >6/expected <<EOF &&
+$TRASH_DIRECTORY/6/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+6/
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree "$TRASH_DIRECTORY" &&
+	GIT_DIR="$TRASH_DIRECTORY/6/.git" test_repo 6
+'
+
+test_expect_failure '#6: GIT_DIR(rel), GIT_WORK_TREE=.. in subdir' '
+	cat >6/sub/sub/expected <<EOF &&
+6/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+6/sub/sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree "$TRASH_DIRECTORY" &&
+	GIT_DIR=../../.git test_repo 6/sub/sub
+'
+
+test_expect_failure '#6: GIT_DIR(rel), GIT_WORK_TREE=..(rel) in subdir' '
+	cat >6/sub/sub/expected <<EOF &&
+6/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+6/sub/sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree ../.. &&
+	GIT_DIR=../../.git test_repo 6/sub/sub
+'
+
+test_expect_success '#6: GIT_DIR, GIT_WORK_TREE=..(rel) in subdir' '
+	cat >6/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/6/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+6/sub/sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree ../.. &&
+	GIT_DIR="$TRASH_DIRECTORY/6/.git" test_repo 6/sub/sub
+'
+
+test_expect_success '#6: GIT_DIR, GIT_WORK_TREE=.. in subdir' '
+	cat >6/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/6/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+6/sub/sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/6/.git/config" core.worktree "$TRASH_DIRECTORY" &&
+	GIT_DIR="$TRASH_DIRECTORY/6/.git" test_repo 6/sub/sub
+'
+
 test_done
-- 
1.7.0.2.445.gcbdb3
