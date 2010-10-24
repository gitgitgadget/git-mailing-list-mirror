From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 11/18] t1510: setup case #8
Date: Sun, 24 Oct 2010 19:11:43 +0700
Message-ID: <1287922310-14678-12-git-send-email-pclouds@gmail.com>
References: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 14:13:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9zRy-0000GE-TP
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 14:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630Ab0JXMNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 08:13:11 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:49923 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab0JXMNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 08:13:09 -0400
Received: by pxi15 with SMTP id 15so334432pxi.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 05:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=YlBoEh8rChJrAhkE0B8wktP0YbeWGZ5nMtKTg8neq3s=;
        b=JbjY1cGBLk3XDKiP0BacpIneCz0xXJbDXCtsDgnF87HqWwzdAxg3bxpImHmK6Cihia
         S8K864Lw0EadEO+k68sz3GKzlnZLIVxuM+W1oij/gIN9TubgAgha3VpnXKoF9xUuWOGN
         6XpWP10Sh7NJUxtxOlpqa3LpOtA1KUkPLhHM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CFRqi11MzpDVZg38UKzvTD36czPZJJbQbSUKy8oRpugEAHpQgQPNw8HcsLhpVtSz0u
         9Jqe5t7xq/K9RwzUzORZNtoLRmkuDT2J6bWYoQFbztvFCO4LstZ/y9mujGfTHYQlxXx1
         WKKu+FhDDc33Quw8zwA9fy+TJwwrWhBieGMDA=
Received: by 10.142.231.6 with SMTP id d6mr3908964wfh.346.1287922389264;
        Sun, 24 Oct 2010 05:13:09 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id e14sm9125186wfg.8.2010.10.24.05.13.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 05:13:08 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 24 Oct 2010 19:13:04 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159867>

---
 t/t1510-repo-setup.sh |   52 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 2f36bfe..c77c245 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1263,4 +1263,56 @@ EOF
 	GIT_DIR="$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE="$TRASH_DIRECTORY" test_repo 7/sub/sub
 '
 
+#
+# case #8
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# same as case #1 except that git_dir is set by .git file
+#
+#  - worktree is at .git file's parent directory
+#  - cwd is at worktree root
+#  - prefix is calculated
+#  - git_dir is set to where .git points to
+#  - cwd can't be outside worktree
+
+test_expect_success '#8: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 8 8/sub &&
+	cd 8 &&
+	git init &&
+	mv .git ../8.git &&
+	echo gitdir: ../8.git >.git &&
+	cd ..
+'
+
+test_expect_success '#8: at root' '
+	cat >8/expected <<EOF &&
+$TRASH_DIRECTORY/8.git
+$TRASH_DIRECTORY/8
+$TRASH_DIRECTORY/8
+EOF
+	test_repo 8
+'
+
+test_expect_success '#8: in subdir' '
+	cat >8/sub/expected <<EOF &&
+$TRASH_DIRECTORY/8.git
+$TRASH_DIRECTORY/8
+$TRASH_DIRECTORY/8
+sub/
+EOF
+	test_repo 8/sub
+'
+
 test_done
-- 
1.7.0.2.445.gcbdb3
