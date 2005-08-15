From: Amos Waterland <apw@rossby.metr.ou.edu>
Subject: [PATCH] Add git-branches-script
Date: Mon, 15 Aug 2005 15:44:30 -0500
Message-ID: <20050815204430.GA77829@rossby.metr.ou.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 22:48:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4lrV-0004sV-14
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 22:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbVHOUrK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 16:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbVHOUrK
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 16:47:10 -0400
Received: from rossby.metr.ou.edu ([129.15.192.80]:62989 "EHLO
	rossby.metr.ou.edu") by vger.kernel.org with ESMTP id S964950AbVHOUrJ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 16:47:09 -0400
Received: from rossby.metr.ou.edu (localhost.metr.ou.edu [127.0.0.1])
	by rossby.metr.ou.edu (8.12.9p2/8.12.9) with ESMTP id j7FKiU5L077956;
	Mon, 15 Aug 2005 15:44:30 -0500 (CDT)
	(envelope-from apw@rossby.metr.ou.edu)
Received: (from apw@localhost)
	by rossby.metr.ou.edu (8.12.9p2/8.12.9/Submit) id j7FKiUPf077955;
	Mon, 15 Aug 2005 15:44:30 -0500 (CDT)
	(envelope-from apw)
To: junkio@cox.net
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-yoursite-MailScanner-SpamCheck: not spam, SpamAssassin (score=0,
	required 6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

For people whose workflow involves switching back and forth between a
lot of branches, it can be really helpful to be able to quickly tell
which branch you are on and which ones are available.  This patch
introduces a small script that when invoked as `git branches' prints a
list of available branches with a star in front of the one you are on:

 $ cd linux-2.6/
 $ git checkout -b ppc64-cleanups
 $ git checkout -b ppc64-new-devel
 $ git checkout -b ppc64-all-merge
 $ git branches
   master
 * ppc64-all-merge
   ppc64-cleanups
   ppc64-new-devel

Signed-off-by: Amos Waterland <apw@rossby.metr.ou.edu>

---

 git-branches-script |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)
 create mode 100755 git-branches-script

12ab86f36137c4ffd1fb9b878479b9befe4cf2d4
diff --git a/git-branches-script b/git-branches-script
new file mode 100755
--- /dev/null
+++ b/git-branches-script
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+. git-sh-setup-script || die "Not a git archive"
+
+current=$(basename $(readlink $GIT_DIR/HEAD))
+
+cd $GIT_DIR/refs/heads &&
+ls | sed -e "s/^/  /" -e "s/  $current/* $current/"
