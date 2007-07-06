From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Deprecate git-cherry
Date: Fri, 6 Jul 2007 17:29:57 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707061722020.4093@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 06 18:37:12 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6qnv-0004Mt-Sx
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 18:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbXGFQhJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 12:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754124AbXGFQhJ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 12:37:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:46004 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753291AbXGFQhG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 12:37:06 -0400
Received: (qmail invoked by alias); 06 Jul 2007 16:37:04 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp052) with SMTP; 06 Jul 2007 18:37:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+uXNMsT1+urLNsN1G4sqdg3KHWcwVnfwp+VYpI9a
	ZnBvWdPmx5ogE+
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51774>


A cleaner alternative was introduced in v1.5.2~185^2~1, which not only
allows you to list the commits, but to inspect them, too:

	git log --cherry-pick <upstream>...[<head>]

There is a functional difference, though: git cherry shows both 
directions, <upstream>...<head> and <head>...<upstream>, and prefixes
the commits with '+' and '-', respectively.

'git rev-list --cherry-pick <upstream>...[<head>]' only shows one 
direction, and does not prefix the commits.

However, in practice you are usually only interested in one direction 
anyway (as seen in the cvsexportcommit example).

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	It might make sense to also allow "--cherry", since it is shorter 
	to type ;-)

 Documentation/core-tutorial.txt       |    4 ++--
 Documentation/git-cherry.txt          |    6 ++++++
 Documentation/git-cvsexportcommit.txt |    2 +-
 t/t3401-rebase-partial.sh             |    2 +-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 4fb6f41..accd0dc 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -1571,8 +1571,8 @@ like this:
    half of `git pull` but does not merge. The head of the
    public repository is stored in `.git/refs/remotes/origin/master`.
 
-4. Use `git cherry origin` to see which ones of your patches
-   were accepted, and/or use `git rebase origin` to port your
+4. Use `git log --cherry-pick origin...` to see which ones of your
+   patches were accepted, and/or use `git rebase origin` to port your
    unmerged changes forward to the updated upstream.
 
 5. Use `git format-patch origin` to prepare patches for e-mail
diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index e694382..16e170f 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -11,6 +11,12 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
+THIS COMMAND IS DEPRECATED:
+Use 'git rev-list --cherry-pick upstream...head' instead.  This will
+display the commits that would have been prefixed with '+' by
+'git cherry upstream..head'.  If you need the commits prefixed with '-',
+use 'git rev-list --cherry-pick head...upstream' instead.
+
 The changeset (or "diff") of each commit between the fork-point and <head>
 is compared against each commit between the fork-point and <upstream>.
 
diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index 6c423e3..3055764 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -81,7 +81,7 @@ Merge pending patches into CVS automatically -- only if you really know what you
 ------------
 $ export GIT_DIR=~/project/.git
 $ cd ~/project_cvs_checkout
-$ git-cherry cvshead myhead | sed -n 's/^+ //p' | xargs -l1 git-cvsexportcommit -c -p -v
+$ git rev-list --cherry-pick cvshead...myhead  | xargs -l1 git-cvsexportcommit -c -p -v
 ------------
 
 Author
diff --git a/t/t3401-rebase-partial.sh b/t/t3401-rebase-partial.sh
index 4934a4e..6902737 100755
--- a/t/t3401-rebase-partial.sh
+++ b/t/t3401-rebase-partial.sh
@@ -43,7 +43,7 @@ test_expect_success \
 '
 
 test_debug \
-    'git cherry master &&
+    'git log --cherry-pick master... &&
      git format-patch -k --stdout --full-index master >/dev/null &&
      gitk --all & sleep 1
 '
