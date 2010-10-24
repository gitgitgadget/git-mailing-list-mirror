From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 04/18] t1510: setup case #1
Date: Sun, 24 Oct 2010 19:11:36 +0700
Message-ID: <1287922310-14678-5-git-send-email-pclouds@gmail.com>
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
	id 1P9zR7-0008WA-QU
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 14:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579Ab0JXMMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 08:12:23 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53526 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab0JXMMW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 08:12:22 -0400
Received: by mail-pw0-f46.google.com with SMTP id 8so245656pwj.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 05:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=HcR5iCCYtz1txEpSkOk4aNMrZGI7xhVKJLHWrtI55XE=;
        b=wMQTO1qpS+1QRrYpC3jj8MSSk5OU1ihnji3bGbgtGP7V363q4SVAEAiGTnPSoMMrTr
         anXralT/IUUJ+s6BLN/D94O6DeKE1keyxciiS33PR4BptqpgMcC3XWYCr+L01cY95iH3
         gy1tvhuVg0q0pacYJX892sqdFcmlHIsqrn/N0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ng8Vp98V/VfquvHHgGj0eS6nUkHkzyQSNKa11QKjT0fEjrc/RKpAkSTl5f74OoTvM4
         r6hxYeayaBA4opOlPKl+w6qxqLTBAU4Bmxvvs9zr6nJmoyOhUttOnpB5BB2TlOYE34E5
         jTIKN8XkEKrftcdg9J1VH4wgM8ejGPAZeZo3A=
Received: by 10.142.217.14 with SMTP id p14mr4361260wfg.334.1287922342612;
        Sun, 24 Oct 2010 05:12:22 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id w6sm4172387wfd.9.2010.10.24.05.12.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 05:12:21 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 24 Oct 2010 19:12:18 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159859>

---
 t/t1510-repo-setup.sh |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 88edf4d..d450b4a 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -97,4 +97,46 @@ sub/
 EOF
 '
 
+#
+# case #1
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output: same as case #0 (with warnings perhaps)
+
+test_expect_success '#1: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 1 1/sub 1.wt 1.wt/sub 1/wt 1/wt/sub &&
+	cd 1 && git init && cd ..
+'
+
+# FIXME: check for warning that GIT_WORK_TREE is ignored
+test_expect_failure '#1: at root' '
+	cat >1/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/1
+$TRASH_DIRECTORY/1
+EOF
+	GIT_WORK_TREE=non-existent test_repo 1
+'
+
+# FIXME: check for warning that GIT_WORK_TREE is ignored
+test_expect_failure '#1: in subdir' '
+	cat >1/sub/expected <<EOF &&
+.git
+$TRASH_DIRECTORY/1
+$TRASH_DIRECTORY/1
+sub/
+EOF
+	GIT_WORK_TREE=non-existent test_repo 1/sub
+'
+
 test_done
-- 
1.7.0.2.445.gcbdb3
