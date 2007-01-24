From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH] Documentation: --amend cannot be combined with -c/-C/-F.
Date: Wed, 24 Jan 2007 20:54:46 +0100
Message-ID: <20070124195446.GA13817@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 24 21:06:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9oCs-0005C8-4Q
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 20:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbXAXTyu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 14:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751649AbXAXTyu
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 14:54:50 -0500
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:46927 "HELO bohr.gbar.dtu.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751363AbXAXTyt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 14:54:49 -0500
Received: (qmail 14140 invoked by uid 5842); 24 Jan 2007 20:54:46 +0100
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37669>

We used to get the following confusing error message:

% git commit --amend -a -m foo
Option -m cannot be combined with -c/-C/-F

This is because --amend cannot be combined with -c/-C/-F, which makes
sense, because they try to handle the same log message in different ways.
So update the documentation to reflect this.

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>
---

This problem was reported by tko on #git.  What do you think?
It is not a "complete" fix, since --reuse, and --reedit have the same
problem, but they are not even mentioned in the man page of git-commit. 

 Documentation/git-commit.txt |    4 ++--
 git-commit.sh                |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 532703a..2187eee 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -8,8 +8,8 @@ git-commit - Record changes to the repository
 SYNOPSIS
 --------
 [verse]
-'git-commit' [-a] [-s] [-v] [(-c | -C) <commit> | -F <file> | -m <msg>]
-	   [--no-verify] [--amend] [-e] [--author <author>]
+'git-commit' [-a] [-s] [-v] [(-c | -C) <commit> | -F <file> | -m <msg> |
+	    --amend] [--no-verify] [-e] [--author <author>]
 	   [--] [[-i | -o ]<file>...]
 
 DESCRIPTION
diff --git a/git-commit.sh b/git-commit.sh
index 6f4dcdb..830ba76 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Linus Torvalds
 # Copyright (c) 2006 Junio C Hamano
 
-USAGE='[-a] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit>] [-u] [--amend] [-e] [--author <author>] [[-i | -o] <path>...]'
+USAGE='[-a] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [[-i | -o] <path>...]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 require_work_tree
@@ -284,9 +284,9 @@ esac
 
 case "$log_given" in
 tt*)
-	die "Only one of -c/-C/-F can be used." ;;
+	die "Only one of -c/-C/-F/--a can be used." ;;
 *tm*|*mt*)
-	die "Option -m cannot be combined with -c/-C/-F." ;;
+	die "Option -m cannot be combined with -c/-C/-F/--a." ;;
 esac
 
 case "$#,$also,$only,$amend" in
-- 
1.5.0.rc2.gc9a89-dirty
