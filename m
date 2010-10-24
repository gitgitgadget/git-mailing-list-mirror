From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 03/18] t1510: setup case #0
Date: Sun, 24 Oct 2010 19:11:35 +0700
Message-ID: <1287922310-14678-4-git-send-email-pclouds@gmail.com>
References: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 14:12:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9zR7-0008WA-8z
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 14:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571Ab0JXMMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 08:12:17 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47687 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab0JXMMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 08:12:16 -0400
Received: by mail-pv0-f174.google.com with SMTP id 32so423714pvb.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 05:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=TfUU84ICowcsZlFwzTramINAp7Tgn+XXJsUSF5+Wy9E=;
        b=PetlTArwBX/otoVF16IbjaeoAPuOtC99isSmLqF1oVkUmwv24W9T1rkcc5PG4x1oKs
         n9yj4Pf4yEzpZ8/zB/6gZdqfsdDSW2MHur40NSy5elT3IOLN/3EPPdHf+PV/TwIrnEPa
         EKuhjjWz7nZ8SnoRJB9mg7Sfnj9ziDJ8Pv90I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pFiwbNMvpmtUCpwb9IcrMJ4faRfz6HMV7ErQfz0QhCWVrfAKySg8AMNA2K5gl6Med1
         f3ab1phliGHt4CDLB1aePqy5/Tq55pM1YHFH+cXyqqhYUyasD7BKXeDdl7ZTVSmerjwH
         IXdzxitlMLiTzip5a+iPpOqAN9UmGrcx/pRKM=
Received: by 10.142.172.10 with SMTP id u10mr4319239wfe.232.1287922336095;
        Sun, 24 Oct 2010 05:12:16 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id p8sm9123103wff.16.2010.10.24.05.12.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 05:12:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 24 Oct 2010 19:12:11 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159860>

---
 t/t1510-repo-setup.sh |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index d618787..88edf4d 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -53,4 +53,48 @@ test_repo() {
 # Bit 4 = bare repo
 # Case# = encoding of the above 5 bits
 
+#
+# Case #0
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+#  - worktree is .git's parent directory
+#  - cwd is at worktree root dir
+#  - prefix is calculated
+#  - git_dir is set to ".git"
+#  - cwd can't be outside worktree
+
+test_expect_success '#0: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 0 0/sub &&
+	cd 0 && git init && cd ..
+'
+
+test_expect_success '#0: at root' '
+	cat >0/expected <<EOF && test_repo 0
+.git
+$TRASH_DIRECTORY/0
+$TRASH_DIRECTORY/0
+EOF
+'
+
+test_expect_success '#0: in subdir' '
+	cat >0/sub/expected <<EOF && test_repo 0/sub
+.git
+$TRASH_DIRECTORY/0
+$TRASH_DIRECTORY/0
+sub/
+EOF
+'
+
 test_done
-- 
1.7.0.2.445.gcbdb3
