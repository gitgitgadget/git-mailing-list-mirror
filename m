From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 15/18] t1510: setup case #12
Date: Sun, 24 Oct 2010 19:11:47 +0700
Message-ID: <1287922310-14678-16-git-send-email-pclouds@gmail.com>
References: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 14:13:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9zSM-0000LF-8R
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 14:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649Ab0JXMNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 08:13:36 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55620 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab0JXMNg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 08:13:36 -0400
Received: by mail-pv0-f174.google.com with SMTP id 32so423774pvb.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 05:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=ASRqBBCGCoAbWWFINnOuGiV1s88DixlGIT22z+tL3jY=;
        b=vKNKnLkZL3I4ITwa8988hCl44An/7xrTJ1AFIPgxT9vLnOzEHhU4iW4cgOIFkANeT2
         LRNuFG7RkV48Impc2S3bEtkUqW66mAUU6Nq+CQIJZREfeRmzMGGcy7Y0w3wjBtDbmm55
         hBljwH87g2RKdeqp/rs+jIR0S6E1NVJ47vY24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=O0gyDTiTiuBmE2pvE/L6j4EJPrAFnjgd4nSumULLWDu11+BR3W+5ZRJTmRCSxoU434
         KuFQKxiHonLHW3tRqT0t02QFLvPGuea5gw4eJeNtwmk9F8SQ7kzQqGDSUagyHU4VsJCw
         gvh2eFsqa5VGVXd0We41eslRMsxvrZ5Nku7Xo=
Received: by 10.142.49.12 with SMTP id w12mr4252901wfw.160.1287922415853;
        Sun, 24 Oct 2010 05:13:35 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id e14sm9127105wfg.20.2010.10.24.05.13.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 05:13:34 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 24 Oct 2010 19:13:31 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159871>

---
 t/t1510-repo-setup.sh |  132 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 132 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index f8ab969..1516ff6 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1681,4 +1681,136 @@ EOF
 	GIT_DIR="$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE="$TRASH_DIRECTORY" test_repo 11/sub/sub
 '
 
+#
+# case #12
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# same as case #4 except that git_dir is set by .git file
+
+
+test_expect_success '#12: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 12 12/sub 12/sub/sub 12.wt 12.wt/sub 12/wt 12/wt/sub &&
+	cd 12 &&
+	git init &&
+	mv .git ../12.git &&
+	echo gitdir: ../12.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#12: core.worktree(rel), at root' '
+	cat >12/expected <<EOF &&
+$TRASH_DIRECTORY/12.git
+$TRASH_DIRECTORY/12
+$TRASH_DIRECTORY/12
+EOF
+	git config --file="$TRASH_DIRECTORY/12.git/config" core.worktree .. &&
+	test_repo 12
+'
+
+test_expect_success '#12: core.worktree, at root' '
+	cat >12/expected <<EOF &&
+$TRASH_DIRECTORY/12.git
+$TRASH_DIRECTORY/12
+$TRASH_DIRECTORY/12
+EOF
+	git config --file="$TRASH_DIRECTORY/12.git/config" core.worktree "$TRASH_DIRECTORY/12" &&
+	test_repo 12
+'
+
+test_expect_failure '#12: core.worktree(rel), in subdir' '
+	cat >12/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/12.git
+$TRASH_DIRECTORY/12
+$TRASH_DIRECTORY/12
+sub/sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/12.git/config" core.worktree .. &&
+	test_repo 12/sub/sub
+'
+
+test_expect_success '#12: core.worktree, in subdir' '
+	cat >12/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/12.git
+$TRASH_DIRECTORY/12
+$TRASH_DIRECTORY/12
+sub/sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/12.git/config" core.worktree "$TRASH_DIRECTORY/12" &&
+	test_repo 12/sub/sub
+'
+
+test_expect_failure '#12: core.worktree=wt(rel), at root' '
+	cat >12/expected <<EOF &&
+$TRASH_DIRECTORY/12.git
+$TRASH_DIRECTORY/12/wt
+$TRASH_DIRECTORY/12
+EOF
+	git config --file="$TRASH_DIRECTORY/12.git/config" core.worktree ../wt &&
+	test_repo 12
+'
+
+test_expect_success '#12: core.worktree=wt, at root' '
+	cat >12/expected <<EOF &&
+$TRASH_DIRECTORY/12.git
+$TRASH_DIRECTORY/12/wt
+$TRASH_DIRECTORY/12
+EOF
+	git config --file="$TRASH_DIRECTORY/12.git/config" core.worktree "$TRASH_DIRECTORY/12/wt" &&
+	test_repo 12
+'
+
+test_expect_failure '#12: core.worktree=wt(rel), in subdir' '
+	cat >12/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/12.git
+$TRASH_DIRECTORY/12/wt
+$TRASH_DIRECTORY/12/sub/sub
+EOF
+	git config --file="$TRASH_DIRECTORY/12.git/config" core.worktree ../wt &&
+	test_repo 12/sub/sub
+'
+
+test_expect_success '#12: core.worktree=wt, in subdir' '
+	cat >12/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/12.git
+$TRASH_DIRECTORY/12/wt
+$TRASH_DIRECTORY/12/sub/sub
+EOF
+	git config --file="$TRASH_DIRECTORY/12.git/config" core.worktree "$TRASH_DIRECTORY/12/wt" &&
+	test_repo 12/sub/sub
+'
+
+test_expect_failure '#12: core.worktree=..(rel), at root' '
+	cat >12/expected <<EOF &&
+$TRASH_DIRECTORY/12.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+12/
+EOF
+	git config --file="$TRASH_DIRECTORY/12.git/config" core.worktree ../.. &&
+	test_repo 12
+'
+
+test_expect_failure '#12: core.worktree=.., at root' '
+	cat >12/expected <<EOF &&
+$TRASH_DIRECTORY/12.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+12/
+EOF
+	git config --file="$TRASH_DIRECTORY/12.git/config" core.worktree "$TRASH_DIRECTORY/12" &&
+	test_repo 12
+'
+
 test_done
-- 
1.7.0.2.445.gcbdb3
