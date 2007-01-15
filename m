From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] some doc updates
Date: Sun, 14 Jan 2007 22:44:18 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701142210520.2577@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:47:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VWG-0000gD-5x
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:21:16 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V8t-0003eK-DW
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbXAODoW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 22:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbXAODoW
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 22:44:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:45358 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbXAODoV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 22:44:21 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JBW00AYL51UIJY0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 14 Jan 2007 22:44:20 -0500 (EST)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36849>

1) talk about "git merge" instead of "git pull ."

2) suggest "git repo-config" instead of directly editing config files

3) echo "URL: blah" > .git/remotes/foo is obsolete and should be
   "git repo-config remote.foo.url blah"

4) support for partial URL prefix has been removed (see commit
   ea560e6d64374ec1f6c163c276319a3da21a1345) so drop mention of it.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 0cd33fb..51dd6c6 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -1129,46 +1129,26 @@ juggle multiple lines of development simultaneously. Of
 course, you will pay the price of more disk usage to hold
 multiple working trees, but disk space is cheap these days.
 
-[NOTE]
-You could even pull from your own repository by
-giving '.' as <remote-repository> parameter to `git pull`.  This
-is useful when you want to merge a local branch (or more, if you
-are making an Octopus) into the current branch.
-
 It is likely that you will be pulling from the same remote
 repository from time to time. As a short hand, you can store
-the remote repository URL in a file under .git/remotes/
-directory, like this:
-
-------------------------------------------------
-$ mkdir -p .git/remotes/
-$ cat >.git/remotes/linus <<\EOF
-URL: http://www.kernel.org/pub/scm/git/git.git/
-EOF
-------------------------------------------------
-
-and use the filename to `git pull` instead of the full URL.
-The URL specified in such file can even be a prefix
-of a full URL, like this:
+the remote repository URL in the local repository's config file
+like this:
 
 ------------------------------------------------
-$ cat >.git/remotes/jgarzik <<\EOF
-URL: http://www.kernel.org/pub/scm/linux/git/jgarzik/
-EOF
+$ git repo-config remote.linus.url http://www.kernel.org/pub/scm/git/git.git/
 ------------------------------------------------
 
+and use the "linus" keyword with `git pull` instead of the full URL.
 
 Examples.
 
 . `git pull linus`
 . `git pull linus tag v0.99.1`
-. `git pull jgarzik/netdev-2.6.git/ e100`
 
 the above are equivalent to:
 
 . `git pull http://www.kernel.org/pub/scm/git/git.git/ HEAD`
 . `git pull http://www.kernel.org/pub/scm/git/git.git/ tag v0.99.1`
-. `git pull http://www.kernel.org/pub/.../jgarzik/netdev-2.6.git e100`
 
 
 How does the merge work?
@@ -1546,7 +1526,8 @@ on that project and has an own "public repository" goes like this:
 
 1. Prepare your work repository, by `git clone` the public
    repository of the "project lead". The URL used for the
-   initial cloning is stored in `.git/remotes/origin`.
+   initial cloning is stored in the remote.origin.url
+   configuration variable.
 
 2. Prepare a public repository accessible to others, just like
    the "project lead" person does.
@@ -1586,14 +1567,15 @@ like this:
 1. Prepare your work repository, by `git clone` the public
    repository of the "project lead" (or a "subsystem
    maintainer", if you work on a subsystem). The URL used for
-   the initial cloning is stored in `.git/remotes/origin`.
+   the initial cloning is stored in the remote.origin.url
+   configuration variable.
 
 2. Do your work in your repository on 'master' branch.
 
 3. Run `git fetch origin` from the public repository of your
    upstream every once in a while. This does only the first
    half of `git pull` but does not merge. The head of the
-   public repository is stored in `.git/refs/heads/origin`.
+   public repository is stored in `.git/refs/remotes/origin/master`.
 
 4. Use `git cherry origin` to see which ones of your patches
    were accepted, and/or use `git rebase origin` to port your
@@ -1681,11 +1663,11 @@ $ git reset --hard master~2
 
 You can make sure 'git show-branch' matches the state before
 those two 'git merge' you just did.  Then, instead of running
-two 'git merge' commands in a row, you would pull these two
+two 'git merge' commands in a row, you would merge these two
 branch heads (this is known as 'making an Octopus'):
 
 ------------
-$ git pull . commit-fix diff-fix
+$ git merge commit-fix diff-fix
 $ git show-branch
 ! [commit-fix] Fix commit message normalization.
  ! [diff-fix] Fix rename detection.
@@ -1701,7 +1683,7 @@ $ git show-branch
 
 Note that you should not do Octopus because you can.  An octopus
 is a valid thing to do and often makes it easier to view the
-commit history if you are pulling more than two independent
+commit history if you are merging more than two independent
 changes at the same time.  However, if you have merge conflicts
 with any of the branches you are merging in and need to hand
 resolve, that is an indication that the development happened in
diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index 4e83994..ca36a76 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -148,8 +148,7 @@ modification will be caught if you do `git commit -a` later.
 <8> redo the commit undone in the previous step, using the message
 you originally wrote.
 <9> switch to the master branch.
-<10> merge a topic branch into your master branch.  You can also use
-`git pull . alsa-audio`, i.e. pull from the local repository.
+<10> merge a topic branch into your master branch.
 <11> review commit logs; other forms to limit output can be
 combined and include `\--max-count=10` (show 10 commits),
 `\--until=2005-12-10`, etc.
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 13be992..a90b764 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -52,7 +52,8 @@ git pull origin next::
 
 git pull . fixes enhancements::
 	Bundle local branch `fixes` and `enhancements` on top of
-	the current branch, making an Octopus merge.
+	the current branch, making an Octopus merge.  This `git pull .`
+	syntax is equivalent to `git merge`.
 
 git pull -s ours . obsolete::
 	Merge local branch `obsolete` into the current branch,
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index b57a72b..08a0557 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -81,7 +81,7 @@ One way to do it is to pull master into the topic branch:
 
 ------------
 	$ git checkout topic
-	$ git pull . master
+	$ git merge master
 
               o---*---o---+ topic
              /           /
@@ -103,10 +103,10 @@ in which case the final commit graph would look like this:
 
 ------------
 	$ git checkout topic
-	$ git pull . master
+	$ git merge master
 	$ ... work on both topic and master branches
 	$ git checkout master
-	$ git pull . topic
+	$ git merge topic
 
               o---*---o---+---o---o topic
              /           /         \
@@ -126,11 +126,11 @@ top of the tip before the test merge:
 
 ------------
 	$ git checkout topic
-	$ git pull . master
+	$ git merge master
 	$ git reset --hard HEAD^ ;# rewind the test merge
 	$ ... work on both topic and master branches
 	$ git checkout master
-	$ git pull . topic
+	$ git merge topic
 
               o---*---o-------o---o topic
              /                     \
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index d2bf0b9..8325c5e 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -11,15 +11,13 @@ diff" with:
 $ man git-diff
 ------------------------------------------------
 
-It is a good idea to introduce yourself to git before doing any
-operation.  The easiest way to do so is:
+It is a good idea to introduce yourself to git with your name and
+public email address before doing any operation.  The easiest
+way to do so is:
 
 ------------------------------------------------
-$ cat >~/.gitconfig <<\EOF
-[user]
-	name = Your Name Comes Here
-	email = you@yourdomain.example.com
-EOF
+$ git repo-config --global user.name "Your Name Comes Here"
+$ git repo-config --global user.email you@yourdomain.example.com
 ------------------------------------------------
 
 
@@ -211,7 +209,7 @@ at this point the two branches have diverged, with different changes
 made in each.  To merge the changes made in experimental into master, run
 
 ------------------------------------------------
-$ git pull . experimental
+$ git merge experimental
 ------------------------------------------------
 
 If the changes don't conflict, you're done.  If there are conflicts,
@@ -316,14 +314,14 @@ shows a list of all the changes that Bob made since he branched from
 Alice's master branch.
 
 After examining those changes, and possibly fixing things, Alice
-could pull the changes into her master branch:
+could merge the changes into her master branch:
 
 -------------------------------------
 $ git checkout master
-$ git pull . bob-incoming
+$ git merge bob-incoming
 -------------------------------------
 
-The last command is a pull from the "bob-incoming" branch in Alice's
+The last command is a merge from the "bob-incoming" branch in Alice's
 own repository.
 
 Alice could also perform both steps at once with:
