From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 18/18] t1510: setup case #15
Date: Sun, 24 Oct 2010 19:11:50 +0700
Message-ID: <1287922310-14678-19-git-send-email-pclouds@gmail.com>
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
	id 1P9zSb-0000OZ-Bi
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 14:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660Ab0JXMN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 08:13:57 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55620 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab0JXMN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 08:13:56 -0400
Received: by mail-pv0-f174.google.com with SMTP id 32so423774pvb.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 05:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=4VlBN7/NBb8w7UCsDl0tymN3kHtcKtv4hHh0js5oQjk=;
        b=mRBGBDb3+5cu3WzVIc6ai5RxKbl4PxB4dcIqaHnLUYeBEnKOdw64/7qWEhRxhs27r3
         z4BYgVnY0xzO0BVvHK7xxagbXhT2Rov7JL+MDnVIcBVzNF1+Ki6tskExqGidsyA2v6Cm
         NX+li7Igi8W4+KzpdWJDgFqvTwJAaRGIoSdJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DhyLHnQTYUXP8+3CB6l7cKWl9zVp5jPNeKdlmddXEuf40BGC3+xp9RpFNRPHuKTF/K
         1beLFaRDDHWc5FV2oaAEI5o78n3iMW8adOq6UgoCsaRewJJ2YjdWHEYunHavxl+Ggs+h
         tTtIUodvoxokC1/R0Axh0PxwodLvlsZs+vzwc=
Received: by 10.142.133.21 with SMTP id g21mr4090838wfd.163.1287922436324;
        Sun, 24 Oct 2010 05:13:56 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id p8sm9126328wff.16.2010.10.24.05.13.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 05:13:55 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 24 Oct 2010 19:13:51 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159874>

---
 t/t1510-repo-setup.sh |  256 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 256 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 5c1b96e..f412890 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -2224,4 +2224,260 @@ EOF
 	GIT_DIR="$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
 '
 
+#
+# case #15
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# same as case #7 except that git_dir is set by .git file
+
+test_expect_success '#15: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 15 15/sub 15/sub/sub 15.wt 15.wt/sub 15/wt 15/wt/sub &&
+	cd 15 &&
+	git init &&
+	git config core.worktree non-existent &&
+	mv .git ../15.git &&
+	echo gitdir: ../15.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE at root' '
+	cat >15/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY/15
+$TRASH_DIRECTORY/15
+EOF
+	GIT_DIR=.git GIT_WORK_TREE="$TRASH_DIRECTORY/15" test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE(rel) at root' '
+	cat >15/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY/15
+$TRASH_DIRECTORY/15
+EOF
+	GIT_DIR=.git GIT_WORK_TREE=. test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE at root' '
+	cat >15/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY/15
+$TRASH_DIRECTORY/15
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE="$TRASH_DIRECTORY/15" test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE(rel) at root' '
+	cat >15/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY/15
+$TRASH_DIRECTORY/15
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=. test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORKTREE in subdir' '
+	cat >15/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY/15
+$TRASH_DIRECTORY/15
+sub/sub/
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE="$TRASH_DIRECTORY/15" test_repo 15/sub/sub
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORKTREE(rel) in subdir' '
+	cat >15/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY/15
+$TRASH_DIRECTORY/15
+sub/sub/
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE=../.. test_repo 15/sub/sub
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORKTREE in subdir' '
+	cat >15/sub/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY/15
+$TRASH_DIRECTORY/15
+sub/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE="$TRASH_DIRECTORY/15" test_repo 15/sub
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORKTREE(rel) in subdir' '
+	cat >15/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY/15
+$TRASH_DIRECTORY/15
+sub/sub/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=../.. test_repo 15/sub/sub
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=wt at root' '
+	cat >15/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY/15/wt
+$TRASH_DIRECTORY/15
+EOF
+	GIT_DIR=.git GIT_WORK_TREE="$TRASH_DIRECTORY/15/wt" test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=wt(rel) at root' '
+	cat >15/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY/15/wt
+$TRASH_DIRECTORY/15
+EOF
+	GIT_DIR=.git GIT_WORK_TREE=wt test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=wt(rel) at root' '
+	cat >15/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY/15/wt
+$TRASH_DIRECTORY/15
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=wt test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=wt at root' '
+	cat >15/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY/15/wt
+$TRASH_DIRECTORY/15
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE="$TRASH_DIRECTORY/15/wt" test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=wt in subdir' '
+	cat >15/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY/15/wt
+$TRASH_DIRECTORY/15/sub/sub
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE="$TRASH_DIRECTORY/15/wt" test_repo 15/sub/sub
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=wt(rel) in subdir' '
+	cat >15/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY/15/wt
+$TRASH_DIRECTORY/15/sub/sub
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE=../../wt test_repo 15/sub/sub
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=wt(rel) in subdir' '
+	cat >15/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY/15/wt
+$TRASH_DIRECTORY/15/sub/sub
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=../../wt test_repo 15/sub/sub
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=wt in subdir' '
+	cat >15/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY/15/wt
+$TRASH_DIRECTORY/15/sub/sub
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE="$TRASH_DIRECTORY/15/wt" test_repo 15/sub/sub
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=.. at root' '
+	cat >15/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+15/
+EOF
+	GIT_DIR=.git GIT_WORK_TREE="$TRASH_DIRECTORY" test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=..(rel) at root' '
+	cat >15/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+15/
+EOF
+	GIT_DIR=.git GIT_WORK_TREE=.. test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=..(rel) at root' '
+	cat >15/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+15/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=.. test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=.. at root' '
+	cat >15/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+15/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE="$TRASH_DIRECTORY" test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=.. in subdir' '
+	cat >15/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+15/sub/sub/
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE="$TRASH_DIRECTORY" test_repo 15/sub/sub
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=..(rel) in subdir' '
+	cat >15/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+15/sub/sub/
+EOF
+	GIT_DIR=../../.git GIT_WORK_TREE=../../.. test_repo 15/sub/sub
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=..(rel) in subdir' '
+	cat >15/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+15/sub/sub/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=../../../ test_repo 15/sub/sub
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=.. in subdir' '
+	cat >15/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/15.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+15/sub/sub/
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE="$TRASH_DIRECTORY" test_repo 15/sub/sub
+'
+
 test_done
-- 
1.7.0.2.445.gcbdb3
