From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 2/3] Refactor git-branch
Date: Sun, 22 Oct 2006 13:30:25 +0200
Message-ID: <11615166272930-git-send-email-hjemli@gmail.com>
References: <1161516626749-git-send-email-hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 22 13:30:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbbXF-0005Lw-UK
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 13:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWJVLaa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 07:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWJVLaa
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 07:30:30 -0400
Received: from mail47.e.nsc.no ([193.213.115.47]:39925 "EHLO mail47.e.nsc.no")
	by vger.kernel.org with ESMTP id S932392AbWJVLa1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 07:30:27 -0400
Received: from localhost.localdomain (ti231210a080-7372.bb.online.no [80.213.28.208])
	by mail47.nsc.no (8.13.8/8.13.5) with ESMTP id k9MBUPPo003655
	for <git@vger.kernel.org>; Sun, 22 Oct 2006 13:30:26 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.3.1.g1688
In-Reply-To: <1161516626749-git-send-email-hjemli@gmail.com>
Message-Id: <00a2e5d38382cea6ff991f60c42923092e1d4dfc.1161516129.git.hjemli@gmail.com>
In-Reply-To: <5245bfe3982f5c23841229af9f548f982b9c60c3.1161516129.git.hjemli@gmail.com>
References: <5245bfe3982f5c23841229af9f548f982b9c60c3.1161516129.git.hjemli@gmail.com>
Date: Sun, 22 Oct 2006 13:04:06 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This moves the code used to display local branches into a
separate function.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 git-branch.sh |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/git-branch.sh b/git-branch.sh
index b80bcda..1f628a4 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -54,6 +54,21 @@ ls_remote_branches () {
     sort
 }
 
+ls_local_branches () {
+	git-rev-parse --symbolic --branches |
+	sort |
+	while read ref
+	do
+		if test "$headref" = "$ref"
+		then
+			pfx='*'
+		else
+			pfx=' '
+		fi
+		echo "$pfx $ref"
+	done
+}
+
 force=
 create_log=
 while case "$#,$1" in 0,*) break ;; *,-*) ;; *) break ;; esac
@@ -86,18 +101,7 @@ done
 
 case "$#" in
 0)
-	git-rev-parse --symbolic --branches |
-	sort |
-	while read ref
-	do
-		if test "$headref" = "$ref"
-		then
-			pfx='*'
-		else
-			pfx=' '
-		fi
-		echo "$pfx $ref"
-	done
+	ls_local_branches
 	exit 0 ;;
 1)
 	head=HEAD ;;
-- 
1.4.3.1.g1688
