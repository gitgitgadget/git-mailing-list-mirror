From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH] git-rebase: support --whitespace=<option>
Date: Fri,  7 Sep 2007 10:20:50 -0400
Message-ID: <11891748512757-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Sep 07 16:21:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITehg-0001JH-D3
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 16:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965385AbXIGOUy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 10:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965379AbXIGOUy
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 10:20:54 -0400
Received: from mail.fieldses.org ([66.93.2.214]:57910 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965328AbXIGOUx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 10:20:53 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1ITehX-0006ir-R6; Fri, 07 Sep 2007 10:20:51 -0400
X-Mailer: git-send-email 1.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58040>

Pass --whitespace=<option> to git-apply.  Since git-apply and git-am
expect this, I'm always surprised when I try to give it to git-rebase
and it doesn't work.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/git-rebase.txt |    9 +++++++--
 git-rebase.sh                |    5 ++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 61b1810..0858fa8 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -8,8 +8,9 @@ git-rebase - Forward-port local commits to the updated upstream head
 SYNOPSIS
 --------
 [verse]
-'git-rebase' [-i | --interactive] [-v | --verbose] [-m | --merge] [-C<n>]
-	[-p | --preserve-merges] [--onto <newbase>] <upstream> [<branch>]
+'git-rebase' [-i | --interactive] [-v | --verbose] [-m | --merge]
+	[-C<n>] [ --whitespace=<option>] [-p | --preserve-merges]
+	[--onto <newbase>] <upstream> [<branch>]
 'git-rebase' --continue | --skip | --abort
 
 DESCRIPTION
@@ -209,6 +210,10 @@ OPTIONS
 	context exist they all must match.  By default no context is
 	ever ignored.
 
+--whitespace=<nowarn|warn|error|error-all|strip>::
+	This flag is passed to the `git-apply` program
+	(see gitlink:git-apply[1]) that applies the patch.
+
 -i, \--interactive::
 	Make a list of the commits which are about to be rebased.  Let the
 	user edit that list before rebasing.  This mode can also be used to
diff --git a/git-rebase.sh b/git-rebase.sh
index 3bd66b0..52c686f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -216,8 +216,11 @@ do
 	-v|--verbose)
 		verbose=t
 		;;
+	--whitespace=*)
+		git_am_opt="$git_am_opt $1"
+		;;
 	-C*)
-		git_am_opt=$1
+		git_am_opt="$git_am_opt $1"
 		shift
 		;;
 	-*)
-- 
1.5.3
