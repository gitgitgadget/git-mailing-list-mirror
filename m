From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 16/18] t1510: setup case #13
Date: Sun, 24 Oct 2010 19:11:48 +0700
Message-ID: <1287922310-14678-17-git-send-email-pclouds@gmail.com>
References: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 14:13:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9zSM-0000LF-P1
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 14:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651Ab0JXMNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 08:13:43 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55620 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab0JXMNm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 08:13:42 -0400
Received: by mail-pv0-f174.google.com with SMTP id 32so423774pvb.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 05:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=f4S/B4vTlJXzVZbyr1v407daRft2vPqIavVeaIF9goE=;
        b=QYq0E+nnqckWyY0EaARcLSZ67j4jZgQjmnBLFpbBgonbuUKxk8X59J1KWP3R6fHN7E
         oPfU9JKiCWY5LODAiS9v9ZaZlc+nxLOjkxMXuxtgFfi9PSuDcaCnKuHoKFkyeadFMNf7
         dL7WnbGHT3HzHPaBMVnf9OFBfiDJkSPJOnhBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uW41I/aix48Xc3PJBcuP2HcqwUIayzJNY1nIxZV3LtCM0f5KBx2FFSBwUfHW3c5VVs
         0Q/KhWSrc8fLUhLxnYIwIWAu8+Xkze1iT5RMBXUjo2pZjvXHMPGWDHW8DZsTAKvxfdBX
         YD6Flge+lfczwwSDYdsGl7qwigxlGVoQ86gIE=
Received: by 10.142.162.21 with SMTP id k21mr3997689wfe.412.1287922422398;
        Sun, 24 Oct 2010 05:13:42 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id x35sm9126323wfd.13.2010.10.24.05.13.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 05:13:41 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 24 Oct 2010 19:13:37 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159872>

---
 t/t1510-repo-setup.sh |  132 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 132 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 1516ff6..2a69a78 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1813,4 +1813,136 @@ EOF
 	test_repo 12
 '
 
+#
+# case #13
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# same as case #5 except that git_dir is set by .git file
+
+test_expect_success '#13: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 13 13/sub 13/sub/sub 13.wt 13.wt/sub 13/wt 13/wt/sub &&
+	cd 13 &&
+	git init &&
+	mv .git ../13.git &&
+	echo gitdir: ../13.git >.git &&
+	cd .. &&
+	export GIT_WORK_TREE=non-existent
+'
+
+test_expect_failure '#13: core.worktree(rel), at root' '
+	cat >13/expected <<EOF &&
+$TRASH_DIRECTORY/13.git
+$TRASH_DIRECTORY/13
+$TRASH_DIRECTORY/13
+EOF
+	git config --file="$TRASH_DIRECTORY/13.git/config" core.worktree .. &&
+	test_repo 13
+'
+
+test_expect_failure '#13: core.worktree, at root' '
+	cat >13/expected <<EOF &&
+$TRASH_DIRECTORY/13.git
+$TRASH_DIRECTORY/13
+$TRASH_DIRECTORY/13
+EOF
+	git config --file="$TRASH_DIRECTORY/13.git/config" core.worktree "$TRASH_DIRECTORY/13" &&
+	test_repo 13
+'
+
+test_expect_failure '#13: core.worktree(rel), in subdir' '
+	cat >13/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/13.git
+$TRASH_DIRECTORY/13
+$TRASH_DIRECTORY/13
+sub/sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/13.git/config" core.worktree .. &&
+	test_repo 13/sub/sub
+'
+
+test_expect_failure '#13: core.worktree, in subdir' '
+	cat >13/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/13.git
+$TRASH_DIRECTORY/13
+$TRASH_DIRECTORY/13
+sub/sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/13.git/config" core.worktree "$TRASH_DIRECTORY/13" &&
+	test_repo 13/sub/sub
+'
+
+test_expect_failure '#13: core.worktree=wt(rel), at root' '
+	cat >13/expected <<EOF &&
+$TRASH_DIRECTORY/13.git
+$TRASH_DIRECTORY/13/wt
+$TRASH_DIRECTORY/13
+EOF
+	git config --file="$TRASH_DIRECTORY/13.git/config" core.worktree ../wt &&
+	test_repo 13
+'
+
+test_expect_failure '#13: core.worktree=wt, at root' '
+	cat >13/expected <<EOF &&
+$TRASH_DIRECTORY/13.git
+$TRASH_DIRECTORY/13/wt
+$TRASH_DIRECTORY/13
+EOF
+	git config --file="$TRASH_DIRECTORY/13.git/config" core.worktree "$TRASH_DIRECTORY/13/wt" &&
+	test_repo 13
+'
+
+test_expect_failure '#13: core.worktree=wt(rel), in subdir' '
+	cat >13/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/13.git
+$TRASH_DIRECTORY/13/wt
+$TRASH_DIRECTORY/13/sub/sub
+EOF
+	git config --file="$TRASH_DIRECTORY/13.git/config" core.worktree ../wt &&
+	test_repo 13/sub/sub
+'
+
+test_expect_failure '#13: core.worktree=wt, in subdir' '
+	cat >13/sub/sub/expected <<EOF &&
+$TRASH_DIRECTORY/13.git
+$TRASH_DIRECTORY/13/wt
+$TRASH_DIRECTORY/13/sub/sub
+EOF
+	git config --file="$TRASH_DIRECTORY/13.git/config" core.worktree "$TRASH_DIRECTORY/13/wt" &&
+	test_repo 13/sub/sub
+'
+
+test_expect_failure '#13: core.worktree=..(rel), at root' '
+	cat >13/expected <<EOF &&
+$TRASH_DIRECTORY/13.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+13/
+EOF
+	git config --file="$TRASH_DIRECTORY/13.git/config" core.worktree ../.. &&
+	test_repo 13
+'
+
+test_expect_failure '#13: core.worktree=.., at root' '
+	cat >13/expected <<EOF &&
+$TRASH_DIRECTORY/13.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+13/
+EOF
+	git config --file="$TRASH_DIRECTORY/13.git/config" core.worktree "$TRASH_DIRECTORY/13" &&
+	test_repo 13
+'
+
 test_done
-- 
1.7.0.2.445.gcbdb3
