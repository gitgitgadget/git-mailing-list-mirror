From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 13/18] t1510: setup case #10
Date: Sun, 24 Oct 2010 19:11:45 +0700
Message-ID: <1287922310-14678-14-git-send-email-pclouds@gmail.com>
References: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 14:13:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9zS9-0000I7-Uz
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 14:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641Ab0JXMNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 08:13:23 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50622 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab0JXMNW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 08:13:22 -0400
Received: by mail-pz0-f46.google.com with SMTP id 3so478452pzk.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 05:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=ysLbp3LY8qZed9V+HCq8v20ZiR5kXMzoG/KllkvWaWM=;
        b=FY4IXThVmAohUSqaxw5EdpVsld8+pvq01TUCMKFFtj093DuMvgF7HYXI/I/3VAIDou
         OMVvhJs3N1nlH9FMRTxpD4gLkb3zhpAkHX+qo7allBrVYGFeUGsYPma6DEG3tWTJGZhU
         tFi8RBUYvRwSLlRwDTw/ANqSmryxCgB74akp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=s8hWIVdfaMMaO84k72yJD7Dygk8Eop9FH7JDkBsBWLHgo3UJ7XUCCIid/C/IoU0hMW
         6lRikr4XKfLEQf/Tz3qGrHFbxEa543B25ZfbsKT3KUv3iQsxiOyJsFKU5G148RsSyclC
         KWXvsIysaDhmOCnkEAmDQbgyaO9PEbQPSwH4s=
Received: by 10.142.180.4 with SMTP id c4mr4407169wff.146.1287922402519;
        Sun, 24 Oct 2010 05:13:22 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id x35sm9130618wfd.1.2010.10.24.05.13.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 05:13:21 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 24 Oct 2010 19:13:18 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159869>

---
 t/t1510-repo-setup.sh |   63 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index c516155..31bacd7 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1363,4 +1363,67 @@ EOF
 	GIT_WORK_TREE=non-existent test_repo 9/sub
 '
 
+#
+# case #10
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is not set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# same as case #2 except that git_dir is set by .git file
+
+test_expect_success '#10: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 10 10/sub &&
+	cd 10 &&
+	git init &&
+	mv .git ../10.git &&
+	echo gitdir: ../10.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#10: at root' '
+	cat >10/expected <<EOF &&
+$TRASH_DIRECTORY/10.git
+$TRASH_DIRECTORY/10
+$TRASH_DIRECTORY/10
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/10/.git" test_repo 10
+'
+
+test_expect_failure '#10: in subdir' '
+	cat >10/sub/expected <<EOF &&
+$TRASH_DIRECTORY/10.git
+$TRASH_DIRECTORY/10/sub
+$TRASH_DIRECTORY/10/sub
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/10/.git" test_repo 10/sub
+'
+
+test_expect_failure '#10: relative GIT_DIR at root' '
+	cat >10/expected <<EOF &&
+$TRASH_DIRECTORY/10.git
+$TRASH_DIRECTORY/10
+$TRASH_DIRECTORY/10
+EOF
+	GIT_DIR=.git test_repo 10
+'
+
+test_expect_failure '#10: relative GIT_DIR in subdir' '
+	cat >10/sub/expected <<EOF &&
+$TRASH_DIRECTORY/10.git
+$TRASH_DIRECTORY/10/sub
+$TRASH_DIRECTORY/10/sub
+EOF
+	GIT_DIR=../.git test_repo 10/sub
+'
+
 test_done
-- 
1.7.0.2.445.gcbdb3
