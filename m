From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [RFC/PATCH] Make git-{pull,rebase} no-tracking message friendlier
Date: Thu, 23 Feb 2012 17:05:15 +0100
Message-ID: <1330013115-26355-1-git-send-email-cmn@elego.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 17:05:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0bAa-0008V8-Hg
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 17:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157Ab2BWQFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 11:05:19 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:59647 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753112Ab2BWQFS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 11:05:18 -0500
Received: from beez.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 1C9C646082
	for <git@vger.kernel.org>; Thu, 23 Feb 2012 17:05:13 +0100 (CET)
Received: (nullmailer pid 26390 invoked by uid 1000);
	Thu, 23 Feb 2012 16:05:15 -0000
X-Mailer: git-send-email 1.7.8.352.g876a6f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191377>

The current message is too long and at too low a level for anybody to
understand it if they don't know about the configuration format
already.

Reformat it to show the commands a user would be expected to use,
instead of the contents of the configuration file.
---

As annoying as it is when people simply paste the output of 'git pull'
and ask "what does it mean" without even reading it, I have to admit
that as a new user, I'd also be scared off by this message. Using
git-remote and git-branch should make it less scary and more relatable
for the user. I'm not aware of a way to set branch.$branch.rebase with
porcelain, so I put in a config command there. Better
solutions/wordings welcome; I'd really like to get rid of the old
message.

 git-parse-remote.sh |   23 ++++++++---------------
 1 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index b24119d..96e76a9 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -65,26 +65,19 @@ Please specify which branch you want to $op_type $op_prep on the command
 line and try again (e.g. '$example').
 See git-${cmd}(1) for details."
 	else
-		echo "You asked me to $cmd without telling me which branch you
-want to $op_type $op_prep, and 'branch.${branch_name#refs/heads/}.merge' in
-your configuration file does not tell me, either. Please
-specify which branch you want to use on the command line and
+		echo "You asked me to $cmd without telling me which branch you want to
+$op_type $op_prep, and there is no tracking information for the current branch.
+Please specify which branch you want to use on the command line and
 try again (e.g. '$example').
 See git-${cmd}(1) for details.
 
 If you often $op_type $op_prep the same branch, you may want to
-use something like the following in your configuration file:
-    [branch \"${branch_name#refs/heads/}\"]
-    remote = <nickname>
-    merge = <remote-ref>"
-		test rebase = "$op_type" &&
-		echo "    rebase = true"
-		echo "
-    [remote \"<nickname>\"]
-    url = <url>
-    fetch = <refspec>
+run something like:
 
-See git-config(1) for details."
+    git remote add <remote> <url>
+    git branch --set-upstream ${branch_name#refs/heads/} <remote>/<remote-branch>"
+		test rebase = "$op_type" &&
+		echo "    git config branch.${branch_name#refs/heads/}.rebase true"
 	fi
 	exit 1
 }
-- 
1.7.8.352.g876a6f
