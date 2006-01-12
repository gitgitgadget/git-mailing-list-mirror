From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] show-branch: make the current branch stand out.
Date: Wed, 11 Jan 2006 16:05:59 -0800
Message-ID: <7vy81mia3c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 12 01:06:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewpz6-0002S8-60
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 01:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWALAGE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 19:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWALAGD
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 19:06:03 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:4253 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964835AbWALAGA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 19:06:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060112000603.EAAA25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 Jan 2006 19:06:03 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14533>

This changes the character used to mark the commits that is on the
branch from '+' to '*' for the current branch, to make it stand out.
When you have a handful branches with relatively long diversion, it
is easier to see which one is the current branch this way.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 * Currently in "pu".

 Documentation/git-show-branch.txt            |    6 ++-
 Documentation/howto/revert-branch-rebase.txt |   24 +++++++-------
 Documentation/tutorial.txt                   |   46 +++++++++++++-------------
 show-branch.c                                |    5 ++-
 t/t1200-tutorial.sh                          |    6 ++-
 5 files changed, 45 insertions(+), 42 deletions(-)

825abb210cb5fd776a120589a1da41f6a06db191
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 90e2a5c..a2b8eb9 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -103,7 +103,7 @@ and "mhf":
 
 ------------------------------------------------
 $ git show-branch master fixes mhf
-! [master] Add 'git show-branch'.
+* [master] Add 'git show-branch'.
  ! [fixes] Introduce "reset type" flag to "git reset"
   ! [mhf] Allow "+remote:local" refspec to cause --force when fetching.
 ---
@@ -117,13 +117,13 @@ $ git show-branch master fixes mhf
   + [mhf~6] Retire git-parse-remote.
   + [mhf~7] Multi-head fetch.
   + [mhf~8] Start adding the $GIT_DIR/remotes/ support.
-+++ [master] Add 'git show-branch'.
+*++ [master] Add 'git show-branch'.
 ------------------------------------------------
 
 These three branches all forked from a common commit, [master],
 whose commit message is "Add 'git show-branch'.  "fixes" branch
 adds one commit 'Introduce "reset type"'.  "mhf" branch has many
-other commits.
+other commits.  The current branch is "master".
 
 
 EXAMPLE
diff --git a/Documentation/howto/revert-branch-rebase.txt b/Documentation/howto/revert-branch-rebase.txt
index 5a7e0cf..a83ce1c 100644
--- a/Documentation/howto/revert-branch-rebase.txt
+++ b/Documentation/howto/revert-branch-rebase.txt
@@ -32,16 +32,16 @@ merge introduced 5 commits or so:
 
 ------------------------------------------------
 $ git show-branch --more=4 master master^2 | head
-! [master] Merge refs/heads/portable from http://www.cs.berkeley....
+* [master] Merge refs/heads/portable from http://www.cs.berkeley....
  ! [master^2] Replace C99 array initializers with code.
 --
-+  [master] Merge refs/heads/portable from http://www.cs.berkeley....
-++ [master^2] Replace C99 array initializers with code.
-++ [master^2~1] Replace unsetenv() and setenv() with older putenv().
-++ [master^2~2] Include sys/time.h in daemon.c.
-++ [master^2~3] Fix ?: statements.
-++ [master^2~4] Replace zero-length array decls with [].
-+  [master~1] tutorial note about git branch
+*  [master] Merge refs/heads/portable from http://www.cs.berkeley....
+*+ [master^2] Replace C99 array initializers with code.
+*+ [master^2~1] Replace unsetenv() and setenv() with older putenv().
+*+ [master^2~2] Include sys/time.h in daemon.c.
+*+ [master^2~3] Fix ?: statements.
+*+ [master^2~4] Replace zero-length array decls with [].
+*  [master~1] tutorial note about git branch
 ------------------------------------------------
 
 The '--more=4' above means "after we reach the merge base of refs,
@@ -193,8 +193,8 @@ $ git show-branch --more=1 master pu rc
  +  [pu~4] Document "git cherry-pick" and "git revert"
  +  [pu~5] Remove git-apply-patch-script.
  +  [pu~6] Redo "revert" using three-way merge machinery.
-  + [rc] Merge refs/heads/master from .
-+++ [master] Revert "Replace zero-length array decls with []."
-  + [rc~1] Merge refs/heads/master from .
-+++ [master~1] Merge refs/heads/portable from http://www.cs.berkeley....
+  * [rc] Merge refs/heads/master from .
+++* [master] Revert "Replace zero-length array decls with []."
+  * [rc~1] Merge refs/heads/master from .
+++* [master~1] Merge refs/heads/portable from http://www.cs.berkeley....
 ------------------------------------------------
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index edd91cb..43a1975 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -968,8 +968,8 @@ $ git show-branch master mybranch
 * [master] Merge work in mybranch
  ! [mybranch] Some work.
 --
-+  [master] Merge work in mybranch
-++ [mybranch] Some work.
+*  [master] Merge work in mybranch
+*+ [mybranch] Some work.
 ------------------------------------------------
 
 The first two lines indicate that it is showing the two branches
@@ -1024,7 +1024,7 @@ $ git show-branch master mybranch
 ! [master] Merge work in mybranch
  * [mybranch] Merge work in mybranch
 --
-++ [master] Merge work in mybranch
++* [master] Merge work in mybranch
 ------------------------------------------------
 
 
@@ -1199,9 +1199,9 @@ $ git show-branch --more=3 master mybran
 ! [master] Merge work in mybranch
  * [mybranch] Merge work in mybranch
 --
-++ [master] Merge work in mybranch
-++ [master^2] Some work.
-++ [master^] Some fun.
++* [master] Merge work in mybranch
++* [master^2] Some work.
++* [master^] Some fun.
 ------------
 
 Remember, before running `git merge`, our `master` head was at
@@ -1223,8 +1223,8 @@ $ git show-branch
  ! [mybranch] Some work.
 --
  + [mybranch] Some work.
-+  [master] Some fun.
-++ [mybranch^] New day.
+*  [master] Some fun.
+*+ [mybranch^] New day.
 ------------
 
 Now we are ready to experiment with the merge by hand.
@@ -1743,8 +1743,8 @@ $ git show-branch
  +  [diff-fix] Fix rename detection.
  +  [diff-fix~1] Better common substring algorithm.
 +   [commit-fix] Fix commit message normalization.
-  + [master] Release candidate #1
-+++ [diff-fix~2] Pretty-print messages.
+  * [master] Release candidate #1
+++* [diff-fix~2] Pretty-print messages.
 ------------
 
 Both fixes are tested well, and at this point, you want to merge
@@ -1764,13 +1764,13 @@ $ git show-branch
  ! [diff-fix] Fix rename detection.
   * [master] Merge fix in commit-fix
 ---
-  + [master] Merge fix in commit-fix
-+ + [commit-fix] Fix commit message normalization.
-  + [master~1] Merge fix in diff-fix
- ++ [diff-fix] Fix rename detection.
- ++ [diff-fix~1] Better common substring algorithm.
-  + [master~2] Release candidate #1
-+++ [master~3] Pretty-print messages.
+  * [master] Merge fix in commit-fix
++ * [commit-fix] Fix commit message normalization.
+  * [master~1] Merge fix in diff-fix
+ +* [diff-fix] Fix rename detection.
+ +* [diff-fix~1] Better common substring algorithm.
+  * [master~2] Release candidate #1
+++* [master~3] Pretty-print messages.
 ------------
 
 However, there is no particular reason to merge in one branch
@@ -1797,12 +1797,12 @@ $ git show-branch
  ! [diff-fix] Fix rename detection.
   * [master] Octopus merge of branches 'diff-fix' and 'commit-fix'
 ---
-  + [master] Octopus merge of branches 'diff-fix' and 'commit-fix'
-+ + [commit-fix] Fix commit message normalization.
- ++ [diff-fix] Fix rename detection.
- ++ [diff-fix~1] Better common substring algorithm.
-  + [master~1] Release candidate #1
-+++ [master~2] Pretty-print messages.
+  * [master] Octopus merge of branches 'diff-fix' and 'commit-fix'
++ * [commit-fix] Fix commit message normalization.
+ +* [diff-fix] Fix rename detection.
+ +* [diff-fix~1] Better common substring algorithm.
+  * [master~1] Release candidate #1
+++* [master~2] Pretty-print messages.
 ------------
 
 Note that you should not do Octopus because you can.  An octopus
diff --git a/show-branch.c b/show-branch.c
index f296a87..03324aa 100644
--- a/show-branch.c
+++ b/show-branch.c
@@ -545,6 +545,7 @@ int main(int ac, char **av)
 	int sha1_name = 0;
 	int shown_merge_point = 0;
 	int no_current_branch = 0;
+	int head_at = -1;
 
 	git_config(git_show_branch_config);
 	setup_git_directory();
@@ -696,6 +697,8 @@ int main(int ac, char **av)
 			}
 			/* header lines never need name */
 			show_one_commit(rev[i], 1);
+			if (is_head)
+				head_at = i;
 		}
 		if (0 <= extra) {
 			for (i = 0; i < num_rev; i++)
@@ -725,7 +728,7 @@ int main(int ac, char **av)
 		if (1 < num_rev) {
 			for (i = 0; i < num_rev; i++)
 				putchar((this_flag & (1u << (i + REV_SHIFT)))
-					? '+' : ' ');
+					? (i == head_at ? '*' : '+') : ' ');
 			putchar(' ');
 		}
 		show_one_commit(commit, no_name);
diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index d7562e9..7879b49 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -118,8 +118,8 @@ cat > show-branch.expect << EOF
 * [master] Merged "mybranch" changes.
  ! [mybranch] Some work.
 --
-+  [master] Merged "mybranch" changes.
-++ [mybranch] Some work.
+*  [master] Merged "mybranch" changes.
+*+ [mybranch] Some work.
 EOF
 
 git show-branch --topo-order master mybranch > show-branch.output
@@ -142,7 +142,7 @@ cat > show-branch2.expect << EOF
 ! [master] Merged "mybranch" changes.
  * [mybranch] Merged "mybranch" changes.
 --
-++ [master] Merged "mybranch" changes.
++* [master] Merged "mybranch" changes.
 EOF
 
 git show-branch --topo-order master mybranch > show-branch2.output
-- 
1.1.1-g8ecb
