From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 08/18] t1510: setup case #5
Date: Sun, 24 Oct 2010 19:11:40 +0700
Message-ID: <1287922310-14678-9-git-send-email-pclouds@gmail.com>
References: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 14:12:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9zRV-00009U-I3
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 14:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605Ab0JXMMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 08:12:49 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53526 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab0JXMMt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 08:12:49 -0400
Received: by mail-pw0-f46.google.com with SMTP id 8so245656pwj.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 05:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=MB7k4SnQFBg5gzXs7g9m4MA0Oip8AeVkvDPAoxLmF9M=;
        b=dHmIpgcmcj3AJuXNarLDc5b7WzP1LnM6leQaXdSSO1nAeVYtZZsVAlTA+X7KsgoRPU
         oaPxyJ7ZUis8c630VFPqaCseCt3YmCJqfMIa3RDyrqzh1XPlw5TOJQDtIfydGgie8cNC
         OpLjE8OLntQwkez2mZkrYlHTj8POTudjxzpjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=M9JeNq1yyLYhsNw4XHnXrXruRrbKTqupdsCD3Ln+YnsY59PPOttg1owJiAssUaPgh3
         44kuaahFelsyxCdmWX70FN52HOEQ49zZu5m8lCOmhdvnDwu2pu9KHT3en9qRsaU76TTg
         4HnQU/aHN3P/FbLr2QMiBG0i1Y9uJqwdTGsr8=
Received: by 10.142.134.13 with SMTP id h13mr955680wfd.137.1287922368906;
        Sun, 24 Oct 2010 05:12:48 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id v19sm9129554wfh.0.2010.10.24.05.12.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 05:12:48 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 24 Oct 2010 19:12:44 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159864>

---
 t/t1510-repo-setup.sh |  135 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 135 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index ee2b02a..87db2c6 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -588,4 +588,139 @@ EOF
 	test_repo 4
 '
 
+#
+# case #5
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# GIT_WORK_TREE is only effective when GIT_DIR is
+# set, which is not the case. So it is the same as case #4.
+#
+#  - worktree is at core.worktree
+#  - cwd is at worktree root
+#  - prefix is calculated
+#  - git_dir is discovered
+#  - cwd can be outside worktree
+
+test_expect_success '#5: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 5 5/sub 5/sub/sub 5.wt 5.wt/sub 5/wt 5/wt/sub &&
+	cd 5 && git init && cd .. &&
+	export GIT_WORK_TREE=non-existent
+'
+
+test_expect_failure '#5: core.worktree(rel), at root' '
+	cat >5/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/5
+$TRASH_DIRECTORY/5
+EOF
+	git config --file="$TRASH_DIRECTORY/5/.git/config" core.worktree .. &&
+	test_repo 5
+'
+
+test_expect_failure '#5: core.worktree, at root' '
+	cat >5/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/5
+$TRASH_DIRECTORY/5
+EOF
+	git config --file="$TRASH_DIRECTORY/5/.git/config" core.worktree "$TRASH_DIRECTORY/5" &&
+	test_repo 5
+'
+
+test_expect_failure '#5: core.worktree(rel), in subdir' '
+	cat >5/sub/sub/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/5
+$TRASH_DIRECTORY/5
+sub/sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/5/.git/config" core.worktree .. &&
+	test_repo 5/sub/sub
+'
+
+test_expect_failure '#5: core.worktree, in subdir' '
+	cat >5/sub/sub/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/5
+$TRASH_DIRECTORY/5
+sub/sub/
+EOF
+	git config --file="$TRASH_DIRECTORY/5/.git/config" core.worktree "$TRASH_DIRECTORY/5" &&
+	test_repo 5/sub/sub
+'
+
+test_expect_failure '#5: core.worktree=wt(rel), at root' '
+	cat >5/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/5/wt
+$TRASH_DIRECTORY/5
+EOF
+	git config --file="$TRASH_DIRECTORY/5/.git/config" core.worktree ../wt &&
+	test_repo 5
+'
+
+test_expect_failure '#5: core.worktree=wt, at root' '
+	cat >5/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/5/wt
+$TRASH_DIRECTORY/5
+EOF
+	git config --file="$TRASH_DIRECTORY/5/.git/config" core.worktree "$TRASH_DIRECTORY/5/wt" &&
+	test_repo 5
+'
+
+test_expect_failure '#5: core.worktree=wt(rel), in subdir' '
+	cat >5/sub/sub/expected <<EOF &&
+../../.git
+$TRASH_DIRECTORY/5/wt
+$TRASH_DIRECTORY/5/sub/sub
+EOF
+	git config --file="$TRASH_DIRECTORY/5/.git/config" core.worktree ../wt &&
+	test_repo 5/sub/sub
+'
+
+test_expect_failure '#5: core.worktree=wt, in subdir' '
+	cat >5/sub/sub/expected <<EOF &&
+../../.git
+$TRASH_DIRECTORY/5/wt
+$TRASH_DIRECTORY/5/sub/sub
+EOF
+	git config --file="$TRASH_DIRECTORY/5/.git/config" core.worktree "$TRASH_DIRECTORY/5/wt" &&
+	test_repo 5/sub/sub
+'
+
+test_expect_failure '#5: core.worktree=..(rel), at root' '
+	cat >5/expected <<EOF &&
+5/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+5/
+EOF
+	git config --file="$TRASH_DIRECTORY/5/.git/config" core.worktree ../.. &&
+	test_repo 5
+'
+
+test_expect_failure '#5: core.worktree=.., at root' '
+	cat >5/expected <<EOF &&
+5/.git
+$TRASH_DIRECTORY
+$TRASH_DIRECTORY
+5/
+EOF
+	git config --file="$TRASH_DIRECTORY/5/.git/config" core.worktree "$TRASH_DIRECTORY/5" &&
+	test_repo 5
+'
+
 test_done
-- 
1.7.0.2.445.gcbdb3
