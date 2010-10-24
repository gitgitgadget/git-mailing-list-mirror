From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 07/18] t1510: setup case #4
Date: Sun, 24 Oct 2010 19:11:39 +0700
Message-ID: <1287922310-14678-8-git-send-email-pclouds@gmail.com>
References: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 14:12:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9zRV-00009U-0X
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 14:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598Ab0JXMMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 08:12:43 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53526 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab0JXMMm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 08:12:42 -0400
Received: by mail-pw0-f46.google.com with SMTP id 8so245656pwj.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 05:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=dBwYPIl/hQq2SMmJ1lR+FZjCR6GFuWZwZDXO/60Ljf0=;
        b=ktyu9E/icR7+a71iLg6CYWH9IWjm5fbce14wQ+e2Ns7Od5FFWeZHa2x8VGMfQlFfHH
         USJupIbtZ6+WAYNlE0UCqE46xoGRfNCECaGOdDHn1dBpET0QvS58wWCJsO5WC/LVNcds
         omGUbejoV7LCvrNzt9lctnFBCMeAtgRZ5Vv08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FbArJiRicxmxK34NEcCaI0CB7AMUGNzHc/JSrmrhhpegUlTLwNndJyxvmxdn3PecXy
         3xmWpHq53gR9JfYQNQYbVTxxzBWXdAwn97+61iz/5Tgq6MFeFDSDQ3HqOTzIqTkcImfZ
         B34WXTSVCHT6nYvPNGJ4C7YVoe7LuGWD5ds34=
Received: by 10.142.134.17 with SMTP id h17mr4262614wfd.124.1287922362458;
        Sun, 24 Oct 2010 05:12:42 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id p8sm9125089wff.4.2010.10.24.05.12.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 05:12:41 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 24 Oct 2010 19:12:38 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159863>

---
 t/t1510-repo-setup.sh |  131 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 131 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 508b7e2..ee2b02a 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -457,4 +457,135 @@ EOF
 	GIT_DIR="$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE="$TRASH_DIRECTORY" test_repo 3/sub/sub
 '
 
+#
+# case #4
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+#  - worktree is at core.worktree
+#  - cwd is at worktree root
+#  - prefix is calculated
+#  - git_dir is discovered
+#  - cwd can be outside worktree
+
+test_expect_success '#4: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 4 4/sub 4/sub/sub 4.wt 4.wt/sub 4/wt 4/wt/sub &&
+	cd 4 && git init && cd ..
+'
+
+test_expect_success '#4: core.worktree(rel), at root' '
+	cat >4/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/4
+$TRASH_DIRECTORY/4
+EOF
+	git config --file="$TRASH_DIRECTORY/4/.git/config" core.worktree .. &&
+	test_repo 4
+'
+
+test_expect_success '#4: core.worktree, at root' '
+	cat >4/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/4
+$TRASH_DIRECTORY/4
+EOF
+	git config --file="$TRASH_DIRECTORY/4/.git/config" core.worktree "$TRASH_DIRECTORY/4" &&
+	test_repo 4
+'
+
+test_expect_failure '#4: core.worktree(rel), in subdir' '
+	cat >4/sub/sub/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/4
+$TRASH_DIRECTORY/4
+sub/sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/4/.git/config" core.worktree .. &&
+	test_repo 4/sub/sub
+'
+
+test_expect_success '#4: core.worktree, in subdir' '
+	cat >4/sub/sub/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/4
+$TRASH_DIRECTORY/4
+sub/sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/4/.git/config" core.worktree "$TRASH_DIRECTORY/4" &&
+	test_repo 4/sub/sub
+'
+
+test_expect_success '#4: core.worktree=wt(rel), at root' '
+	cat >4/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/4/wt
+$TRASH_DIRECTORY/4
+EOF
+	git config --file="$TRASH_DIRECTORY/4/.git/config" core.worktree ../wt &&
+	test_repo 4
+'
+
+test_expect_success '#4: core.worktree=wt, at root' '
+	cat >4/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/4/wt
+$TRASH_DIRECTORY/4
+EOF
+	git config --file="$TRASH_DIRECTORY/4/.git/config" core.worktree "$TRASH_DIRECTORY/4/wt" &&
+	test_repo 4
+'
+
+test_expect_failure '#4: core.worktree=wt(rel), in subdir' '
+	cat >4/sub/sub/expected <<EOF &&
+../../.git
+$TRASH_DIRECTORY/4/wt
+$TRASH_DIRECTORY/4/sub/sub
+EOF
+	git config --file="$TRASH_DIRECTORY/4/.git/config" core.worktree ../wt &&
+	test_repo 4/sub/sub
+'
+
+test_expect_failure '#4: core.worktree=wt, in subdir' '
+	cat >4/sub/sub/expected <<EOF &&
+../../.git
+$TRASH_DIRECTORY/4/wt
+$TRASH_DIRECTORY/4/sub/sub
+EOF
+	git config --file="$TRASH_DIRECTORY/4/.git/config" core.worktree "$TRASH_DIRECTORY/4/wt" &&
+	test_repo 4/sub/sub
+'
+
+test_expect_failure '#4: core.worktree=..(rel), at root' '
+	cat >4/expected <<EOF &&
+4/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+4/
+EOF
+	git config --file="$TRASH_DIRECTORY/4/.git/config" core.worktree ../.. &&
+	test_repo 4
+'
+
+test_expect_failure '#4: core.worktree=.., at root' '
+	cat >4/expected <<EOF &&
+4/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+4/
+EOF
+	git config --file="$TRASH_DIRECTORY/4/.git/config" core.worktree "$TRASH_DIRECTORY/4" &&
+	test_repo 4
+'
+
 test_done
-- 
1.7.0.2.445.gcbdb3
