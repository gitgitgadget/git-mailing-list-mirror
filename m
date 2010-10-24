From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 12/18] t1510: setup case #9
Date: Sun, 24 Oct 2010 19:11:44 +0700
Message-ID: <1287922310-14678-13-git-send-email-pclouds@gmail.com>
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
	id 1P9zRz-0000GE-Dl
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 14:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634Ab0JXMNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 08:13:17 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:49923 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab0JXMNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 08:13:16 -0400
Received: by mail-px0-f174.google.com with SMTP id 15so334432pxi.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 05:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=bj+0dg+AQthGof3hY/cX/TI7DwKfaruYFP513ATQMiI=;
        b=H1v5Truhxshs8+br3/VLzCGCVrN/sUcSMGCAu9IgDTzSuvqDrE8Bs52JSCfCb9Gxin
         dKQ+wgIBxaSnOudv7QCs/yPxBrJ8GsBFh1U4dlqNI+Go2ykyfCy9kcV5LRw8RK9HuPNS
         DvGzipHf6hhxL9/RaBVFo2YsGufFwSx7FEDK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XZ40dwbQQn+w5y4fHyLykPehImX4f+Xwsa666QDuWXeTA42R8GlP5TF4jUMQWT0hCo
         VJ3LjMn/zDO/JQ3YKP8+Hg7sntu7Ek/gWdws5qt/hUPZBi6S8q93TqEMYach2Mr9BDly
         SQkNnW3HVlzArVQDfeUWP6miTVurHx3CkYJmM=
Received: by 10.142.12.9 with SMTP id 9mr3754217wfl.251.1287922395747;
        Sun, 24 Oct 2010 05:13:15 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id q13sm9126197wfc.5.2010.10.24.05.13.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 05:13:14 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 24 Oct 2010 19:13:11 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159868>

---
 t/t1510-repo-setup.sh |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index c77c245..c516155 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1315,4 +1315,52 @@ EOF
 	test_repo 8/sub
 '
 
+#
+# case #9
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# same as case #1 except that git_dir is set by .git file
+
+test_expect_success '#9: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 9 9/sub 9.wt 9.wt/sub 9/wt 9/wt/sub &&
+	cd 9 &&
+	git init &&
+	mv .git ../9.git &&
+	echo gitdir: ../9.git >.git &&
+	cd ..
+'
+
+# FIXME: check for warning that GIT_WORK_TREE is ignored
+test_expect_failure '#9: at root' '
+	cat >9/expected <<EOF &&
+$TRASH_DIRECTORY/9.git
+$TRASH_DIRECTORY/9
+$TRASH_DIRECTORY/9
+EOF
+	GIT_WORK_TREE=non-existent test_repo 9
+'
+
+# FIXME: check for warning that GIT_WORK_TREE is ignored
+test_expect_failure '#9: in subdir' '
+	cat >9/sub/expected <<EOF &&
+$TRASH_DIRECTORY/9.git
+$TRASH_DIRECTORY/9
+$TRASH_DIRECTORY/9
+sub/
+EOF
+	GIT_WORK_TREE=non-existent test_repo 9/sub
+'
+
 test_done
-- 
1.7.0.2.445.gcbdb3
