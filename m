From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 4/4] Add doc for 'branch'.
Date: Sat, 07 Apr 2007 23:37:08 +0200
Message-ID: <20070407213708.13698.28332.stgit@gandelf.nowhere.earth>
References: <20070407213557.13698.21486.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 23:49:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaIbC-0002yb-8f
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 23:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966359AbXDGVh0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 17:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966358AbXDGVh0
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 17:37:26 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:51834 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966359AbXDGVhY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 17:37:24 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id AB8375C3C8;
	Sat,  7 Apr 2007 23:37:23 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 8B7DE1F096;
	Sat,  7 Apr 2007 23:37:08 +0200 (CEST)
In-Reply-To: <20070407213557.13698.21486.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43982>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 Documentation/stg-branch.txt |  127 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 127 insertions(+), 0 deletions(-)

diff --git a/Documentation/stg-branch.txt b/Documentation/stg-branch.txt
new file mode 100644
index 0000000..53f333b
--- /dev/null
+++ b/Documentation/stg-branch.txt
@@ -0,0 +1,127 @@
+stg-branch(1)
+=============
+Yann Dirson <ydirson@altern.org>
+v0.12.1, April 2007
+
+NAME
+----
+stg-branch - stgdesc:branch[]
+
+SYNOPSIS
+--------
+stg branch
+
+stg branch <branch>
+
+stg branch --list
+
+stg branch --create <newstack> [<commit-id>]
+
+stg branch --clone [<newstack>]
+
+stg branch --rename <oldname> <newname>
+
+stg branch --protect [<branch>]
+
+stg branch --unprotect [<branch>]
+
+stg branch --delete [--force] <branch>
+
+stg branch --convert
+
+DESCRIPTION
+-----------
+
+Assorted operations on branches.
+
+no command, no argument::
+	Display the name of the current branch.
+
+no command, one argument::
+	Switch to the named <branch>.
+
+--list::
+-l::
+	Display the list of branches in the current repository,
+	suffixed by the branch description if any, and optionally
+	prefixed by the letter flags 's' if the branch is an StGIT
+	stack, and 'p' if the StGIT stack is protected.  The current
+	branch is shown with a leading ">" character.
+
+--create::
+-c::
+	Create a new StGIT stack based at the specified commit, or at
+	the current HEAD if not specified.  The repository HEAD is
+	switched to the new stack.
++
+StGIT will try to detect the branch off which the new stack is forked,
+as well as the remote repository from which that parent branch is
+taken (if any), so running stgdesc:pull[] will effectively pull new
+commits from the correct branch.  It will warn if it cannot guess the
+parent branch (eg. if you do not specify a branch name as
+<commit-id>).
+
+--clone::
+	Clone the current stack, under the name <newstack> if
+	specified, or using the current stack's name suffixed by a
+	timestamp.
++
+The description of the new stack is set to tell it is a clone of the
+current stack.  The parent information of the new stack is copied from
+the current stack.
++
+Cloning a GIT branch that is not an StGIT stack is similar to creating
+a new stack off the current branch.
+
+--rename::
+-r::
+	Rename the stack named <oldname> to <newname>.
+
+--protect::
+-p::
+	Protect the named stack or the current one, preventing
+	further StGIT operations from modifying this stack.
+
+--unprotect::
+-u::
+	Remove a "protected" flag previously set with '--protect'.
+
+--delete::
+	Delete the named <branch>.  If there are any patches left in
+	the series, StGIT will refuse to delete it, unless '--force'
+	is specified.
++
+A protected branch cannot be deleted, it must be unprotected first
+(see above).
++
+When the current branch is deleted, the repository HEAD is switched to
+the "master" branch if it exists.
++
+Branch "master" is treated specially (see bug #8732), in that only the
+StGIT metadata are removed, the GIT branch itself is not destroyed.
+
+--convert::
+	Switch current stack between old and new format.
+
+OPTIONS
+-------
+
+--force::
+	Force a delete when the series is not empty.
+
+FILES
+-----
+
+	$GIT_DIR/patches/<branch>/description
+	$GIT_DIR/patches/<branch>/protected
+
+GIT CONFIGURATION VARIABLES
+---------------------------
+
+	branch.<branchname>.remote
+	branch.<branchname>.merge
+	branch.<branchname>.stgit.parentbranch
+
+StGIT
+-----
+Part of the StGIT suite - see gitlink:stg[1].
