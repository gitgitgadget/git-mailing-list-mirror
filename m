From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH] user-manual: fix origin/linus confusion in topic-branches example
Date: Mon, 14 May 2007 13:11:10 -0400
Message-ID: <20070514171110.GB23090@fieldses.org>
References: <617E1C2C70743745A92448908E030B2A01749B36@scsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Luck, Tony" <tony.luck@intel.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 19:11:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hne5D-0007o5-SH
	for gcvg-git@gmane.org; Mon, 14 May 2007 19:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756622AbXENRLO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 13:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755591AbXENRLO
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 13:11:14 -0400
Received: from mail.fieldses.org ([66.93.2.214]:52544 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755492AbXENRLN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 13:11:13 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1Hne4k-0006mh-Lj; Mon, 14 May 2007 13:11:10 -0400
Content-Disposition: inline
In-Reply-To: <617E1C2C70743745A92448908E030B2A01749B36@scsmsx411.amr.corp.intel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47273>

Tony Luck points out that I missed a few places when I tried to convert
from using a "linus" branch to using the more standard "origin" remote
setup.

This is my quick fix.  I haven't yet tested the scripts.  (And the
modifications aren't *completely* trivial, so it would probably be a
good idea.)

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

On Mon, May 14, 2007 at 09:30:47AM -0700, Luck, Tony wrote:
> There are a few places where the text still references my "linus"
> branch ... you fixed up the start of the document to switch this
> over to the more standard "origin".

Hm.  I should actually test those scripts and maybe take a harder look
at them to decide whether they could be simplified or replaced with any
new git functionality.

Anyway, thanks for the proofreading!  (And for putting that together in
the first place.  People seem to find this sort of example really
helpful.)

--b.

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 5fb86f2..6324a09 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1895,9 +1895,9 @@ public trees using gitlink:git-remote[1] to set up a "remote" and
 git-fetch[1] to keep them up-to-date; see <<repositories-and-branches>>.
 
 Now create the branches in which you are going to work; these start out
-at the current tip of the linus branch, and should be set up (using the
---track option to gitlink:git-branch[1]) to merge changes in from linus
-by default.
+at the current tip of origin/master branch, and should be set up (using
+the --track option to gitlink:git-branch[1]) to merge changes in from
+Linus by default.
 
 -------------------------------------------------
 $ git branch --track test origin/master
@@ -1953,8 +1953,8 @@ $ git push mytree release
 
 Now to apply some patches from the community.  Think of a short
 snappy name for a branch to hold this patch (or related group of
-patches), and create a new branch from the current tip of the
-linus branch:
+patches), and create a new branch from the current tip of Linus's
+branch:
 
 -------------------------------------------------
 $ git checkout -b speed-up-spinlocks origin
@@ -2012,13 +2012,13 @@ $ git log release..branchname
 (If this branch has not yet been merged you will see some log entries.
 If it has been merged, then there will be no output.)
 
-Once a patch completes the great cycle (moving from test to release, then
-pulled by Linus, and finally coming back into your local "linus" branch)
-the branch for this change is no longer needed.  You detect this when the
-output from:
+Once a patch completes the great cycle (moving from test to release,
+then pulled by Linus, and finally coming back into your local
+"origin/master" branch) the branch for this change is no longer needed.
+You detect this when the output from:
 
 -------------------------------------------------
-$ git log linus..branchname
+$ git log origin..branchname
 -------------------------------------------------
 
 is empty.  At this point the branch can be deleted:
@@ -2050,16 +2050,16 @@ Here are some of the scripts that simplify all this even further.
 -------------------------------------------------
 ==== update script ====
 # Update a branch in my GIT tree.  If the branch to be updated
-# is "linus", then pull from kernel.org.  Otherwise merge local
-# linus branch into test|release branch
+# is origin, then pull from kernel.org.  Otherwise merge
+# origin/master branch into test|release branch
 
 case "$1" in
 test|release)
 	git checkout $1 && git pull . origin
 	;;
-linus)
+origin)
 	before=$(cat .git/refs/heads/origin/master)
-	git fetch linus
+	git fetch origin
 	after=$(cat .git/refs/heads/origin/master)
 	if [ $before != $after ]
 	then
@@ -2067,7 +2067,7 @@ linus)
 	fi
 	;;
 *)
-	echo "Usage: $0 linus|test|release" 1>&2
+	echo "Usage: $0 origin|test|release" 1>&2
 	exit 1
 	;;
 esac
@@ -2122,14 +2122,14 @@ fi
 
 for branch in `ls .git/refs/heads`
 do
-	if [ $branch = linus -o $branch = test -o $branch = release ]
+	if [ $branch = test -o $branch = release ]
 	then
 		continue
 	fi
 
 	echo -n $gb ======= $branch ====== $restore " "
 	status=
-	for ref in test release linus
+	for ref in test release origin/master
 	do
 		if [ `git rev-list $ref..$branch | wc -c` -gt 0 ]
 		then
-- 
1.5.1.4.19.g69e2
