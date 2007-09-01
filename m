From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Improve the first rebase illustration with command example
Date: Sat, 01 Sep 2007 13:58:28 +0300
Organization: Private
Message-ID: <bqcmsld7.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 01 12:55:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRQd3-0006lu-Av
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 12:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240AbXIAKyx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 06:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753231AbXIAKyx
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 06:54:53 -0400
Received: from main.gmane.org ([80.91.229.2]:40060 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753218AbXIAKyw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 06:54:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IRQci-00013Z-Gi
	for git@vger.kernel.org; Sat, 01 Sep 2007 12:54:40 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Sep 2007 12:54:40 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Sep 2007 12:54:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:rMJoc3Ys/sqm8pqLpR/1KJvjEGg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57268>

The case where rebasing need arises was not previously explained. The
first illustration was broadened to contain complete set of commands
and explanatory commentary how to synchronize current branch development
with new upstream changes.

The patch does not do justice, because the overall structure of the
manual was changes as well. Changes:

- Take out the examples from DESCRIPTION and move them after the
  OPTIONS, under new heading EXAMPLES.
- Number the examples 1, 2, 3 and make each one separate topic
- Broaden the example 1 illustration with commands.

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-rebase.txt |  212 +++++++++++++++++++++++++-----------------
 1 files changed, 125 insertions(+), 87 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index a1b6dce..71c2266 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -36,21 +36,130 @@ that caused the merge failure with `git rebase --skip`.  To restore the
 original <branch> and remove the .dotest working files, use the command
 `git rebase --abort` instead.
 
-Assume the following history exists and the current branch is "topic":
+In case of conflict, git-rebase will stop at the first problematic commit
+and leave conflict markers in the tree.  You can use git diff to locate
+the markers (<<<<<<) and make edits to resolve the conflict.  For each
+file you edit, you need to tell git that the conflict has been resolved,
+typically this would be done with
+
+
+    git add <filename>
+
+
+After resolving the conflict manually and updating the index with the
+desired resolution, you can continue the rebasing process with
+
+
+    git rebase --continue
+
+
+Alternatively, you can undo the git-rebase with
+
+
+    git rebase --abort
+
+OPTIONS
+-------
+<newbase>::
+	Starting point at which to create the new commits. If the
+	--onto option is not specified, the starting point is
+	<upstream>.  May be any valid commit, and not just an
+	existing branch name.
+
+<upstream>::
+	Upstream branch to compare against.  May be any valid commit,
+	not just an existing branch name.
+
+<branch>::
+	Working branch; defaults to HEAD.
+
+--continue::
+	Restart the rebasing process after having resolved a merge conflict.
+
+--abort::
+	Restore the original branch and abort the rebase operation.
+
+--skip::
+	Restart the rebasing process by skipping the current patch.
+
+--merge::
+	Use merging strategies to rebase.  When the recursive (default) merge
+	strategy is used, this allows rebase to be aware of renames on the
+	upstream side.
+
+-s <strategy>, \--strategy=<strategy>::
+	Use the given merge strategy; can be supplied more than
+	once to specify them in the order they should be tried.
+	If there is no `-s` option, a built-in list of strategies
+	is used instead (`git-merge-recursive` when merging a single
+	head, `git-merge-octopus` otherwise).  This implies --merge.
+
+-v, \--verbose::
+	Display a diffstat of what changed upstream since the last rebase.
+
+-C<n>::
+	Ensure at least <n> lines of surrounding context match before
+	and after each change.  When fewer lines of surrounding
+	context exist they all must match.  By default no context is
+	ever ignored.
+
+-i, \--interactive::
+	Make a list of the commits which are about to be rebased.  Let the
+	user edit that list before rebasing.
+
+-p, \--preserve-merges::
+	Instead of ignoring merges, try to recreate them.  This option
+	only works in interactive mode.
+
+include::merge-strategies.txt[]
+
+EXAMPLES
+--------
+
+EXAMPLE 1
+~~~~~~~~~
+
+Suppose you're tracking upstream development and developing a serarate
+feature that is not yet ready. You branched when upsream's HEAD was at
+E. You have progressed by 2 commits to (A,B) and working towards
+finishing commit C*. As the work is taken some time, you decide to
+update the upstream code in order to make sure you don't diverge too
+far.
+
+However, your work is unfinished and you cannot commit C* yet. We'll
+use gitlink:git-stash[1] here to assist the workflow:
 
 ------------
-          A---B---C topic
-         /
-    D---E---F---G master
+1. git stash               # Save state of branch: the incomplete C*
+2. git checkout master     # switch to master, where upstream code is
+3. git pull                # update master to: D-E + F-G (new changes)
+4. git checkout topic      # return to previous branch
+5. git rebase master       # change branch from D-E-A-B to D-E-F-G-A-B
+6. git stash apply         # Bring back previously saved state C*
+
+                 A---B---C* [1]          [4,5] A---B [6] ---C*
+                /                       /
+    master D---E ........... [2,3] F---G
 ------------
 
-From this point, the result of either of the following commands:
+The command at phase 5 `git-rebase master topic` is just a short-hand
+of `git checkout topic` followed by `git rebase master`. In the end of
+phase 6, te next commit would make working branch into
+A--B--C--X--Y--D--E--F:
 
+Note, that If D and E does not have any interaction with what A-B-C
+are attempting, there is no reason to rebase, but some people prefer
+it because rebasing tends to keep the history clearer.
 
-    git-rebase master
-    git-rebase master topic
+So, this tree
 
-would be:
+------------
+          A---B---C topic
+         /
+    D---E---F---G master
+------------
+
+was effectively converted into:
 
 ------------
                   A'--B'--C' topic
@@ -58,8 +167,8 @@ would be:
     D---E---F---G master
 ------------
 
-The latter form is just a short-hand of `git checkout topic`
-followed by `git rebase master`.
+EXAMPLE 2
+~~~~~~~~~
 
 Here is how you would transplant a topic branch based on one
 branch to another, to pretend that you forked the topic branch
@@ -94,6 +203,9 @@ We can get this using the following command:
     git-rebase --onto master next topic
 
 
+EXAMPLE 2
+~~~~~~~~~
+
 Another example of --onto option is to rebase part of a
 branch.  If we have the following situation:
 
@@ -121,6 +233,9 @@ would result in:
 
 This is useful when topicB does not depend on topicA.
 
+EXAMPLE 4
+~~~~~~~~~
+
 A range of commits could also be removed with rebase.  If we have
 the following situation:
 
@@ -142,83 +257,6 @@ This is useful if F and G were flawed in some way, or should not be
 part of topicA.  Note that the argument to --onto and the <upstream>
 parameter can be any valid commit-ish.
 
-In case of conflict, git-rebase will stop at the first problematic commit
-and leave conflict markers in the tree.  You can use git diff to locate
-the markers (<<<<<<) and make edits to resolve the conflict.  For each
-file you edit, you need to tell git that the conflict has been resolved,
-typically this would be done with
-
-
-    git add <filename>
-
-
-After resolving the conflict manually and updating the index with the
-desired resolution, you can continue the rebasing process with
-
-
-    git rebase --continue
-
-
-Alternatively, you can undo the git-rebase with
-
-
-    git rebase --abort
-
-OPTIONS
--------
-<newbase>::
-	Starting point at which to create the new commits. If the
-	--onto option is not specified, the starting point is
-	<upstream>.  May be any valid commit, and not just an
-	existing branch name.
-
-<upstream>::
-	Upstream branch to compare against.  May be any valid commit,
-	not just an existing branch name.
-
-<branch>::
-	Working branch; defaults to HEAD.
-
---continue::
-	Restart the rebasing process after having resolved a merge conflict.
-
---abort::
-	Restore the original branch and abort the rebase operation.
-
---skip::
-	Restart the rebasing process by skipping the current patch.
-
---merge::
-	Use merging strategies to rebase.  When the recursive (default) merge
-	strategy is used, this allows rebase to be aware of renames on the
-	upstream side.
-
--s <strategy>, \--strategy=<strategy>::
-	Use the given merge strategy; can be supplied more than
-	once to specify them in the order they should be tried.
-	If there is no `-s` option, a built-in list of strategies
-	is used instead (`git-merge-recursive` when merging a single
-	head, `git-merge-octopus` otherwise).  This implies --merge.
-
--v, \--verbose::
-	Display a diffstat of what changed upstream since the last rebase.
-
--C<n>::
-	Ensure at least <n> lines of surrounding context match before
-	and after each change.  When fewer lines of surrounding
-	context exist they all must match.  By default no context is
-	ever ignored.
-
--i, \--interactive::
-	Make a list of the commits which are about to be rebased.  Let the
-	user edit that list before rebasing.
-
--p, \--preserve-merges::
-	Instead of ignoring merges, try to recreate them.  This option
-	only works in interactive mode.
-
-include::merge-strategies.txt[]
-
 NOTES
 -----
 When you rebase a branch, you are changing its history in a way that
-- 
1.5.3.rc5

    Available from git repository http://cante.net/~jaalto/git/git
    Branch: Dcumentation/git-rebase.txt+assume-the-following-history+example

-- 
Welcome to FOSS revolution: we fix and modify until it shines
