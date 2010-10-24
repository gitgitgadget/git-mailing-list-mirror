From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 17/18] t1510: setup case #14
Date: Sun, 24 Oct 2010 19:11:49 +0700
Message-ID: <1287922310-14678-18-git-send-email-pclouds@gmail.com>
References: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 14:14:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9zSa-0000OZ-Ks
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 14:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654Ab0JXMNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 08:13:50 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60699 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab0JXMNt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 08:13:49 -0400
Received: by pwj8 with SMTP id 8so245789pwj.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 05:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=0BZlvZD+VByGCUjAwbYl4sp+48DYUfnipsw4bT0yXCY=;
        b=SDCjzY5YRtc0JpjS8Pk7kmJiELt431aE9PjJtgKsEJgEnd7paQTDDLsbccI/gEYLk9
         Y08FQvR5omwgnEUHfxiW+6Ba+j/bUUBR+G4YO//sycj/fiUjT8e7junMz7+ve3EMs97B
         hgjuie91LxPexzccmCGDi6JPnj508vP33cXow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Yx5s8zEOJ6flkdgQCoZM36k1yHz6vk9QVhXq3SFP21HDktkiSbH+PvHeH4CHlAYCaq
         rmCedVTtcg3514tBuOYEpMmfwqx/TALnFJmEABlWahJzStQM4HIuAb4uZEtRbZTYzTjP
         oGhICZyvHbaDPb4xHLrUniIUBhW9wlvLNKNYg=
Received: by 10.143.45.11 with SMTP id x11mr4399762wfj.79.1287922429529;
        Sun, 24 Oct 2010 05:13:49 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id x18sm9131100wfa.23.2010.10.24.05.13.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 05:13:48 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 24 Oct 2010 19:13:44 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159873>

---
 t/t1510-repo-setup.sh |  279 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 279 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 2a69a78..5c1b96e 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1945,4 +1945,283 @@ EOF
 	test_repo 13
 '
 
+#
+# case #14
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# same as case #6 except that git_dir is set by .git file
+
+test_expect_success '#14: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 14 14/sub 14/sub/sub 14.wt 14.wt/sub 14/wt 14/wt/sub &&
+	cd 14 &&
+	git init &&
+	mv .git ../14.git &&
+	echo gitdir: ../14.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#14: GIT_DIR(rel), GIT_WORK_TREE at root' '
+	cat >14/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/14
+$TRASH_DIRECTORY/14
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree "$TRASH_DIRECTORY/14" &&
+	GIT_DIR=.git test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR(rel), GIT_WORK_TREE(rel) at root' '
+	cat >14/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/14
+$TRASH_DIRECTORY/14
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree .. &&
+	GIT_DIR=.git test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR, GIT_WORK_TREE at root' '
+	cat >14/expected <<EOF &&
+$TRASH_DIRECTORY/14/.git
+$TRASH_DIRECTORY/14
+$TRASH_DIRECTORY/14
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree "$TRASH_DIRECTORY/14" &&
+	GIT_DIR="$TRASH_DIRECTORY/14/.git" test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR, GIT_WORK_TREE(rel) at root' '
+	cat >14/expected <<EOF &&
+$TRASH_DIRECTORY/14/.git
+$TRASH_DIRECTORY/14
+$TRASH_DIRECTORY/14
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree .. &&
+	GIT_DIR="$TRASH_DIRECTORY/14/.git" test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR(rel), GIT_WORKTREE in subdir' '
+	cat >14/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/14/.git
+$TRASH_DIRECTORY/14
+$TRASH_DIRECTORY/14
+sub/sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree "$TRASH_DIRECTORY/14" &&
+	GIT_DIR=../../.git test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR(rel), GIT_WORKTREE(rel) in subdir' '
+	cat >14/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/14/.git
+$TRASH_DIRECTORY/14
+$TRASH_DIRECTORY/14
+sub/sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree .. &&
+	GIT_DIR=../../.git test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR, GIT_WORKTREE in subdir' '
+	cat >14/sub/expected <<EOF &&
+$TRASH_DIRECTORY/14/.git
+$TRASH_DIRECTORY/14
+$TRASH_DIRECTORY/14
+sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree "$TRASH_DIRECTORY/14" &&
+	GIT_DIR="$TRASH_DIRECTORY/14/.git" test_repo 14/sub
+'
+
+test_expect_failure '#14: GIT_DIR, GIT_WORKTREE(rel) in subdir' '
+	cat >14/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/14/.git
+$TRASH_DIRECTORY/14
+$TRASH_DIRECTORY/14
+sub/sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree .. &&
+	GIT_DIR="$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR(rel), GIT_WORK_TREE=wt at root' '
+	cat >14/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/14/wt
+$TRASH_DIRECTORY/14
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree "$TRASH_DIRECTORY/14/wt" &&
+	GIT_DIR=.git test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR(rel), GIT_WORK_TREE=wt(rel) at root' '
+	cat >14/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/14/wt
+$TRASH_DIRECTORY/14
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree ../wt &&
+	GIT_DIR=.git test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR, GIT_WORK_TREE=wt(rel) at root' '
+	cat >14/expected <<EOF &&
+$TRASH_DIRECTORY/14/.git
+$TRASH_DIRECTORY/14/wt
+$TRASH_DIRECTORY/14
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree ../wt &&
+	GIT_DIR="$TRASH_DIRECTORY/14/.git" test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR, GIT_WORK_TREE=wt at root' '
+	cat >14/expected <<EOF &&
+$TRASH_DIRECTORY/14/.git
+$TRASH_DIRECTORY/14/wt
+$TRASH_DIRECTORY/14
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree "$TRASH_DIRECTORY/14/wt" &&
+	GIT_DIR="$TRASH_DIRECTORY/14/.git" test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR(rel), GIT_WORK_TREE=wt in subdir' '
+	cat >14/sub/sub/expected <<EOF &&
+../../.git
+$TRASH_DIRECTORY/14/wt
+$TRASH_DIRECTORY/14/sub/sub
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree "$TRASH_DIRECTORY/14/wt" &&
+	GIT_DIR=../../.git test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR(rel), GIT_WORK_TREE=wt(rel) in subdir' '
+	cat >14/sub/sub/expected <<EOF &&
+../../.git
+$TRASH_DIRECTORY/14/wt
+$TRASH_DIRECTORY/14/sub/sub
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree ../wt &&
+	GIT_DIR=../../.git test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR, GIT_WORK_TREE=wt(rel) in subdir' '
+	cat >14/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/14/.git
+$TRASH_DIRECTORY/14/wt
+$TRASH_DIRECTORY/14/sub/sub
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree ../wt &&
+	GIT_DIR="$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR, GIT_WORK_TREE=wt in subdir' '
+	cat >14/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/14/.git
+$TRASH_DIRECTORY/14/wt
+$TRASH_DIRECTORY/14/sub/sub
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree "$TRASH_DIRECTORY/14/wt" &&
+	GIT_DIR="$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR(rel), GIT_WORK_TREE=.. at root' '
+	cat >14/expected <<EOF &&
+14/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+14/
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree "$TRASH_DIRECTORY" &&
+	GIT_DIR=.git test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR(rel), GIT_WORK_TREE=..(rel) at root' '
+	cat >14/expected <<EOF &&
+14/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+14/
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree ../../ &&
+	GIT_DIR=.git test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR, GIT_WORK_TREE=..(rel) at root' '
+	cat >14/expected <<EOF &&
+$TRASH_DIRECTORY/14/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+14/
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree ../../ &&
+	GIT_DIR="$TRASH_DIRECTORY/14/.git" test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR, GIT_WORK_TREE=.. at root' '
+	cat >14/expected <<EOF &&
+$TRASH_DIRECTORY/14/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+14/
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree "$TRASH_DIRECTORY" &&
+	GIT_DIR="$TRASH_DIRECTORY/14/.git" test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR(rel), GIT_WORK_TREE=.. in subdir' '
+	cat >14/sub/sub/expected <<EOF &&
+14/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+14/sub/sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree "$TRASH_DIRECTORY" &&
+	GIT_DIR=../../.git test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR(rel), GIT_WORK_TREE=..(rel) in subdir' '
+	cat >14/sub/sub/expected <<EOF &&
+14/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+14/sub/sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree ../.. &&
+	GIT_DIR=../../.git test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR, GIT_WORK_TREE=..(rel) in subdir' '
+	cat >14/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/14/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+14/sub/sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree ../.. &&
+	GIT_DIR="$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR, GIT_WORK_TREE=.. in subdir' '
+	cat >14/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/14/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+14/sub/sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/14.git/config" core.worktree "$TRASH_DIRECTORY" &&
+	GIT_DIR="$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
+'
+
 test_done
-- 
1.7.0.2.445.gcbdb3
