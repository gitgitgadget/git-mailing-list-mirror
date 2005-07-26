From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] Add git-request-pull-script, a short script that generates a summary of pending changes
Date: Tue, 26 Jul 2005 03:30:36 -0400
Message-ID: <20050726073036.GJ6098@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jul 26 09:31:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxJu4-00018G-9z
	for gcvg-git@gmane.org; Tue, 26 Jul 2005 09:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVGZHao (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jul 2005 03:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVGZHao
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jul 2005 03:30:44 -0400
Received: from mail.autoweb.net ([198.172.237.26]:48014 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261830AbVGZHah (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2005 03:30:37 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DxJtd-00012n-7M; Tue, 26 Jul 2005 03:30:37 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DxK2R-0006Ay-00; Tue, 26 Jul 2005 03:39:43 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DxJtc-0004rF-LZ; Tue, 26 Jul 2005 03:30:36 -0400
To: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


A short message requesting a pull from the repository is also included.

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---

 Makefile                |    3 ++-
 git-request-pull-script |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletions(-)
 create mode 100755 git-request-pull-script

834527420cf55d1a11a77372704229e2701108a4
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -37,7 +37,8 @@ SCRIPTS=git git-apply-patch-script git-m
 	gitk git-cherry git-rebase-script git-relink-script git-repack-script \
 	git-format-patch-script git-sh-setup-script git-push-script \
 	git-branch-script git-parse-remote git-verify-tag-script \
-	git-ls-remote-script git-clone-dumb-http git-rename-script
+	git-ls-remote-script git-clone-dumb-http git-rename-script \
+	git-request-pull-script
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
diff --git a/git-request-pull-script b/git-request-pull-script
new file mode 100755
--- /dev/null
+++ b/git-request-pull-script
@@ -0,0 +1,36 @@
+#!/bin/sh -e
+# Copyright 2005, Ryan Anderson <ryan@michonline.com>
+#
+# This file is licensed under the GPL v2, or a later version
+# at the discretion of Linus Torvalds.
+
+usage()
+{
+	echo "$0 <commit> <filename> <url>"
+	echo "  Summarizes the changes since <commit>, stores them in <filename>"
+	echo "  and includes <url> in the message generated."
+	exit 1
+}
+
+
+revision=$1
+filename=$2
+url=$3
+
+[ "$revision" ] || usage
+[ "$filename" ] || usage
+[ "$url" ] || usage
+
+baserev=`git-rev-parse $revision`
+
+(
+	echo "The git repository at:" 
+	echo "    $url"
+	echo "contains the following changes since commit $baserev"
+	echo ""
+	git log $revision.. | git-shortlog ;
+	git diff $revision.. | diffstat ;
+) | tee $filename
+
+echo "The above message is also stored in $filename"
+
-- 

Ryan Anderson
  sometimes Pug Majere
