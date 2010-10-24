From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 05/18] t1510: setup case #2
Date: Sun, 24 Oct 2010 19:11:37 +0700
Message-ID: <1287922310-14678-6-git-send-email-pclouds@gmail.com>
References: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 14:12:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9zRT-00009U-V5
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 14:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585Ab0JXMMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 08:12:30 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50622 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab0JXMM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 08:12:29 -0400
Received: by pzk3 with SMTP id 3so478452pzk.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 05:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=ebQgtEBC38Rr9YLhpx2Zl39s4bH2rEfFyfeNyam6qiI=;
        b=uYCcUc8lKHC/GWXpcrMWp3osY1uHSijGaPPqHUVbKyNRuhcy7d2AFzNn+P7h0g8aht
         eZjJ0G5FisshyfZELoUdeTg+LLFJUnfMpvXY3Gr1kwdBMblM2sZ9yKY4kjhveJefAHkm
         tt0IehFHD0Ik0KFPMRox1I3P2BMssT0sQgmvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LUgcmnupLsXJDhrhWE8zyn/Ht6UDxGwNA1IDZx3TkG/AZ7NXMTvv3wNfl3lFFloNJ6
         uMLVmH4AIyBEi5qGTWG8sqJ0WhEOwA5qjZJ2inhwapzH5qf3DpXD15VyJcgEck2Tr/kw
         1IsEGjL4xZsPDk4AU8rWIGyuxFeTEtOTYlkCo=
Received: by 10.142.218.15 with SMTP id q15mr3902900wfg.405.1287922349044;
        Sun, 24 Oct 2010 05:12:29 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id w14sm9108094wfd.6.2010.10.24.05.12.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 05:12:28 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 24 Oct 2010 19:12:24 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159861>

---
 t/t1510-repo-setup.sh |   63 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index d450b4a..20ad6d4 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -139,4 +139,67 @@ EOF
 	GIT_WORK_TREE=non-existent test_repo 1/sub
 '
 
+#
+# case #2
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+#  - worktree is at original cwd
+#  - cwd is unchanged
+#  - prefix is NULL
+#  - git_dir is set to $GIT_DIR
+#  - cwd can't be outside worktree
+
+test_expect_success '#2: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 2 2/sub &&
+	cd 2 && git init && cd ..
+'
+
+test_expect_success '#2: at root' '
+	cat >2/expected <<EOF &&
+$TRASH_DIRECTORY/2/.git
+$TRASH_DIRECTORY/2
+$TRASH_DIRECTORY/2
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/2/.git" test_repo 2
+'
+
+test_expect_success '#2: in subdir' '
+	cat >2/sub/expected <<EOF &&
+$TRASH_DIRECTORY/2/.git
+$TRASH_DIRECTORY/2/sub
+$TRASH_DIRECTORY/2/sub
+EOF
+	GIT_DIR="$TRASH_DIRECTORY/2/.git" test_repo 2/sub
+'
+
+test_expect_success '#2: relative GIT_DIR at root' '
+	cat >2/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/2
+$TRASH_DIRECTORY/2
+EOF
+	GIT_DIR=.git test_repo 2
+'
+
+test_expect_success '#2: relative GIT_DIR in subdir' '
+	cat >2/sub/expected <<EOF &&
+../.git
+$TRASH_DIRECTORY/2/sub
+$TRASH_DIRECTORY/2/sub
+EOF
+	GIT_DIR=../.git test_repo 2/sub
+'
+
 test_done
-- 
1.7.0.2.445.gcbdb3
