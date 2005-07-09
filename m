From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 3/3] add -N option to cg-init (resent again)
Date: Sat, 9 Jul 2005 06:43:42 -0400
Message-ID: <20050709104331.26765.35929.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050709104316.26765.86980.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 09 12:44:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrCoE-0005q7-Qp
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 12:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVGIKnm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jul 2005 06:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVGIKnm
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jul 2005 06:43:42 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:26298 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261608AbVGIKnm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2005 06:43:42 -0400
Received: (qmail 24714 invoked from network); 9 Jul 2005 10:43:41 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=6teuQ3xiuWnNTudZ0awYg2TnEc80674iYLWRQtF4tymM0toX2mgon64kVWrqhA4inPaiTEkco10siqmcyk8ndtb3Es8U5AAzBiB8+SOkXkGvgLtLJowRIxLfU5lQXcGt7rIgFNo/oQfGSSyJj2T3U0NsVN4GQbrkbO4uIr+sWWM=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp106.mail.sc5.yahoo.com with SMTP; 9 Jul 2005 10:43:38 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050709104316.26765.86980.sendpatchset@bryan-larsens-ibook-g4.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

(resending cogito patches)

add the -N option to cg-init

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 cg-init |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/cg-init b/cg-init
--- a/cg-init
+++ b/cg-init
@@ -10,13 +10,29 @@
 #
 # If `cg-init` is run in a non-empty directory files in the top and
 # sub directory will automatically be added.
+#
+# OPTIONS
+# -------
+# -N::
+#   Only update the cache: do not copy the data into the object database.
+#
 
-USAGE="cg-init"
+USAGE="cg-init [-N]"
 _git_repo_unneeded=1
 
 . ${COGITO_LIB}cg-Xlib
 
-uri=$1
+
+infoonly=
+while optparse; do
+	if optparse -N; then
+		infoonly=-N
+	else
+		optfail
+	fi
+done
+
+uri=$ARGV
 
 [ -e $_git ] && die "$_git already exists"
 
@@ -38,7 +54,7 @@ if [ "$uri" ]; then
 	echo "Cloned (origin $uri available as branch \"origin\")"
 else
 	git-read-tree # Seed the dircache
-	find * \( -type f -o -type l \) -print0 | xargs -0r cg-add
+	find * \( -type f -o -type l \) -print0 | xargs -0r cg-add ${infoonly}
 	cg-commit -C -m"Initial commit" -E
 fi
 
