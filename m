From: Jon Loeliger <jdl@freescale.com>
Subject: [PATCH] Added documentation for few missing options.
Date: Mon, 05 Dec 2005 23:13:03 -0600
Message-ID: <E1EjV8R-00014y-Sg@jdl.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 06:13:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjV8g-0006C1-8U
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 06:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVLFFNP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 00:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVLFFNP
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 00:13:15 -0500
Received: from jdl.com ([66.118.10.122]:14821 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S932071AbVLFFNO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 00:13:14 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EjV8R-00014y-Sg
	for git@vger.kernel.org; Mon, 05 Dec 2005 23:13:06 -0600
To: git@vger.kernel.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13252>


More $ shell prompts in examples.
Minor English grammar improvements.
Added a few "See Also"s.
Use back-ticks on more command examples.

Signed-off-by: Jon Loeliger <jdl@freescale.com>

---

 Documentation/git-checkout-index.txt |   78 +++++++++++++++++++++-------------
 Documentation/git-init-db.txt        |   27 ++++++++++--
 Documentation/git-prune-packed.txt   |   11 +++--
 Documentation/git-read-tree.txt      |   74 ++++++++++++++++++--------------
 Documentation/git-update-index.txt   |   20 +++++++--
 Documentation/git-write-tree.txt     |   14 +++---
 6 files changed, 142 insertions(+), 82 deletions(-)

applies-to: 0e248e1eed0d5aedd0054cf273df03460047ebc9
4baf91676c2462796137e93917c75f2e14ebb877
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index 5bff486..97eef22 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -45,53 +45,71 @@ OPTIONS
 
 The order of the flags used to matter, but not anymore.
 
-Just doing "git-checkout-index" does nothing. You probably meant
-"git-checkout-index -a". And if you want to force it, you want
-"git-checkout-index -f -a".
+Just doing `git-checkout-index` does nothing. You probably meant
+`git-checkout-index -a`. And if you want to force it, you want
+`git-checkout-index -f -a`.
 
 Intuitiveness is not the goal here. Repeatability is. The reason for
-the "no arguments means no work" thing is that from scripts you are
-supposed to be able to do things like:
+the "no arguments means no work" behavior is that from scripts you are
+supposed to be able to do:
 
-	find . -name '*.h' -print0 | xargs -0 git-checkout-index -f --
+----------------
+$ find . -name '*.h' -print0 | xargs -0 git-checkout-index -f --
+----------------
 
 which will force all existing `*.h` files to be replaced with their
 cached copies. If an empty command line implied "all", then this would
 force-refresh everything in the index, which was not the point.
 
-To update and refresh only the files already checked out:
-
-        git-checkout-index -n -f -a && git-update-index --ignore-missing --refresh
-
-Oh, and the "--" is just a good idea when you know the rest will be
-filenames. Just so that you wouldn't have a filename of "-a" causing
-problems (not possible in the above example, but get used to it in
-scripting!).
-
-The prefix ability basically makes it trivial to use
-git-checkout-index as an "export as tree" function. Just read the
-desired tree into the index, and do a
-
-        git-checkout-index --prefix=git-export-dir/ -a
-
-and git-checkout-index will "export" the index into the specified
+The `--` is just a good idea when you know the rest will be filenames;
+it will prevent problems with a filename of, for example,  `-a`.
+Using `--` is probably a good policy in scripts.
+
+
+EXAMPLES
+--------
+To update and refresh only the files already checked out::
++
+----------------
+$ git-checkout-index -n -f -a && git-update-index --ignore-missing --refresh
+----------------
+
+Using `git-checkout-index` to "export an entire tree"::
+	The prefix ability basically makes it trivial to use
+	`git-checkout-index` as an "export as tree" function.
+	Just read the desired tree into the index, and do:
++
+----------------
+$ git-checkout-index --prefix=git-export-dir/ -a
+----------------
++
+`git-checkout-index` will "export" the index into the specified
 directory.
++
+The final "/" is important. The exported name is literally just
+prefixed with the specified string.  Contrast this with the
+following example.
+
+Export files with a prefix::
++
+----------------
+$ git-checkout-index --prefix=.merged- Makefile
+----------------
++
+This will check out the currently cached copy of `Makefile`
+into the file `.merged-Makefile`.
 
-NOTE The final "/" is important. The exported name is literally just
-prefixed with the specified string, so you can also do something like
-
-    git-checkout-index --prefix=.merged- Makefile
-
-to check out the currently cached copy of `Makefile` into the file
-`.merged-Makefile`
 
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
 
+
 Documentation
 --------------
-Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+Documentation by David Greaves,
+Junio C Hamano and the git-list <git@vger.kernel.org>.
+
 
 GIT
 ---
diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index ef1826a..4486f0c 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -8,7 +8,14 @@ git-init-db - Creates an empty git repos
 
 SYNOPSIS
 --------
-'git-init-db'
+'git-init-db' [--template=<template_directory>]
+
+
+OPTIONS
+-------
+--template=<template_directory>::
+	Provide the directory in from which templates will be used.
+
 
 DESCRIPTION
 -----------
@@ -16,14 +23,26 @@ This simply creates an empty git reposit
 and `.git/object/??/`, `.git/refs/heads` and `.git/refs/tags` directories,
 and links `.git/HEAD` symbolically to `.git/refs/heads/master`.
 
-If the 'GIT_DIR' environment variable is set then it specifies a path
+If the `$GIT_DIR` environment variable is set then it specifies a path
 to use instead of `./.git` for the base of the repository.
 
-If the object storage directory is specified via the 'GIT_OBJECT_DIRECTORY'
+If the object storage directory is specified via the `$GIT_OBJECT_DIRECTORY`
 environment variable then the sha1 directories are created underneath -
 otherwise the default `$GIT_DIR/objects` directory is used.
 
-"git-init-db" won't hurt an existing repository.
+`git-init-db` won't hurt an existing repository.
+
+
+EXAMPLES
+--------
+
+Start a new git repository for an existing code base::
++
+----------------
+$ cd /path/to/my/codebase
+$ git-init-db
+----------------
+
 
 
 Author
diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-prune-packed.txt
index 8d96a91..37c53a9 100644
--- a/Documentation/git-prune-packed.txt
+++ b/Documentation/git-prune-packed.txt
@@ -9,19 +9,22 @@ residing in a pack file.
 
 SYNOPSIS
 --------
-'git-prune-packed'
+'git-prune-packed' [-n]
+
 
 DESCRIPTION
 -----------
-This program search the GIT_OBJECT_DIR for all objects that currently exist in
-a pack file as well as the independent object directories.
+This program search the `$GIT_OBJECT_DIR` for all objects that currently
+exist in a pack file as well as the independent object directories.
 
 All such extra objects are removed.
 
 A pack is a collection of objects, individually compressed, with delta
 compression applied, stored in a single file, with an associated index file.
 
-Packs are used to reduce the load on mirror systems, backup engines, disk storage, etc.
+Packs are used to reduce the load on mirror systems, backup engines,
+disk storage, etc.
+
 
 OPTIONS
 -------
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 6e92e4a..4377362 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -15,15 +15,15 @@ DESCRIPTION
 -----------
 Reads the tree information given by <tree-ish> into the index,
 but does not actually *update* any of the files it "caches". (see:
-git-checkout-index)
+gitlink:git-checkout-index[1])
 
 Optionally, it can merge a tree into the index, perform a
-fast-forward (i.e. 2-way) merge, or a 3-way merge, with the -m
-flag.  When used with -m, the -u flag causes it to also update
+fast-forward (i.e. 2-way) merge, or a 3-way merge, with the `-m`
+flag.  When used with `-m`, the `-u` flag causes it to also update
 the files in the work tree with the result of the merge.
 
-Trivial merges are done by "git-read-tree" itself.  Only conflicting paths
-will be in unmerged state when "git-read-tree" returns.
+Trivial merges are done by `git-read-tree` itself.  Only conflicting paths
+will be in unmerged state when `git-read-tree` returns.
 
 OPTIONS
 -------
@@ -56,7 +56,7 @@ OPTIONS
 
 Merging
 -------
-If '-m' is specified, "git-read-tree" can perform 3 kinds of
+If `-m` is specified, `git-read-tree` can perform 3 kinds of
 merge, a single tree merge if only 1 tree is given, a
 fast-forward merge with 2 trees, or a 3-way merge if 3 trees are
 provided.
@@ -65,23 +65,23 @@ provided.
 Single Tree Merge
 ~~~~~~~~~~~~~~~~~
 If only 1 tree is specified, git-read-tree operates as if the user did not
-specify '-m', except that if the original index has an entry for a
+specify `-m`, except that if the original index has an entry for a
 given pathname, and the contents of the path matches with the tree
 being read, the stat info from the index is used. (In other words, the
 index's stat()s take precedence over the merged tree's).
 
-That means that if you do a "git-read-tree -m <newtree>" followed by a
-"git-checkout-index -f -u -a", the "git-checkout-index" only checks out
+That means that if you do a `git-read-tree -m <newtree>` followed by a
+`git-checkout-index -f -u -a`, the `git-checkout-index` only checks out
 the stuff that really changed.
 
-This is used to avoid unnecessary false hits when "git-diff-files" is
-run after git-read-tree.
+This is used to avoid unnecessary false hits when `git-diff-files` is
+run after `git-read-tree`.
 
 
 Two Tree Merge
 ~~~~~~~~~~~~~~
 
-Typically, this is invoked as "git-read-tree -m $H $M", where $H
+Typically, this is invoked as `git-read-tree -m $H $M`, where $H
 is the head commit of the current repository, and $M is the head
 of a foreign tree, which is simply ahead of $H (i.e. we are in a
 fast forward situation).
@@ -94,7 +94,7 @@ the following:
 
      2. The user wants to fast-forward to $M.
 
-In this case, the "git-read-tree -m $H $M" command makes sure
+In this case, the `git-read-tree -m $H $M` command makes sure
 that no local change is lost as the result of this "merge".
 Here are the "carry forward" rules:
 
@@ -141,13 +141,13 @@ operating under the -u flag.
 
 When this form of git-read-tree returns successfully, you can
 see what "local changes" you made are carried forward by running
-"git-diff-index --cached $M".  Note that this does not
-necessarily match "git-diff-index --cached $H" would have
+`git-diff-index --cached $M`.  Note that this does not
+necessarily match `git-diff-index --cached $H` would have
 produced before such a two tree merge.  This is because of cases
 18 and 19 --- if you already had the changes in $M (e.g. maybe
-you picked it up via e-mail in a patch form), "git-diff-index
---cached $H" would have told you about the change before this
-merge, but it would not show in "git-diff-index --cached $M"
+you picked it up via e-mail in a patch form), `git-diff-index
+--cached $H` would have told you about the change before this
+merge, but it would not show in `git-diff-index --cached $M`
 output after two-tree merge.
 
 
@@ -156,18 +156,20 @@ output after two-tree merge.
 Each "index" entry has two bits worth of "stage" state. stage 0 is the
 normal one, and is the only one you'd see in any kind of normal use.
 
-However, when you do "git-read-tree" with three trees, the "stage"
+However, when you do `git-read-tree` with three trees, the "stage"
 starts out at 1.
 
 This means that you can do
 
-	git-read-tree -m <tree1> <tree2> <tree3>
+----------------
+$ git-read-tree -m <tree1> <tree2> <tree3>
+----------------
 
 and you will end up with an index with all of the <tree1> entries in
 "stage1", all of the <tree2> entries in "stage2" and all of the
 <tree3> entries in "stage3".
 
-Furthermore, "git-read-tree" has special-case logic that says: if you see
+Furthermore, `git-read-tree` has special-case logic that says: if you see
 a file that matches in all respects in the following states, it
 "collapses" back to "stage0":
 
@@ -180,7 +182,7 @@ a file that matches in all respects in t
    - stage 1 and stage 3 are the same and stage 2 is different take
      stage 2 (some work has been done on stage 2)
 
-The "git-write-tree" command refuses to write a nonsensical tree, and it
+The `git-write-tree` command refuses to write a nonsensical tree, and it
 will complain about unmerged entries if it sees a single entry that is not
 stage 0.
 
@@ -220,8 +222,8 @@ populated.  Here is an outline of how th
     matching "stage1" entry if it exists too.  .. all the normal
     trivial rules ..
 
-You would normally use "git-merge-index" with supplied
-"git-merge-one-file" to do this last step.  The script
+You would normally use `git-merge-index` with supplied
+`git-merge-one-file` to do this last step.  The script
 does not touch the files in the work tree, and the entire merge
 happens in the index file.  In other words, there is no need to
 worry about what is in the working directory, since it is never
@@ -239,27 +241,33 @@ This is done to prevent you from losing 
 changes.  To illustrate, suppose you start from what has been
 commited last to your repository:
 
-    $ JC=`git-rev-parse --verify "HEAD^0"`
-    $ git-checkout-index -f -u -a $JC
+----------------
+$ JC=`git-rev-parse --verify "HEAD^0"`
+$ git-checkout-index -f -u -a $JC
+----------------
 
 You do random edits, without running git-update-index.  And then
 you notice that the tip of your "upstream" tree has advanced
 since you pulled from him:
 
-    $ git-fetch rsync://.... linus
-    $ LT=`cat .git/MERGE_HEAD`
+----------------
+$ git-fetch rsync://.... linus
+$ LT=`cat .git/MERGE_HEAD`
+----------------
 
 Your work tree is still based on your HEAD ($JC), but you have
 some edits since.  Three-way merge makes sure that you have not
 added or modified index entries since $JC, and if you haven't,
 then does the right thing.  So with the following sequence:
 
-    $ git-read-tree -m -u `git-merge-base $JC $LT` $JC $LT
-    $ git-merge-index git-merge-one-file -a
-    $ echo "Merge with Linus" | \
-      git-commit-tree `git-write-tree` -p $JC -p $LT
+----------------
+$ git-read-tree -m -u `git-merge-base $JC $LT` $JC $LT
+$ git-merge-index git-merge-one-file -a
+$ echo "Merge with Linus" | \
+  git-commit-tree `git-write-tree` -p $JC -p $LT
+----------------
 
-what you would commit is a pure merge between $JC and LT without
+what you would commit is a pure merge between $JC and $LT without
 your work-in-progress changes, and your work tree would be
 updated to the result of the merge.
 
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index fdcb8be..e4678cd 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -123,7 +123,9 @@ merging.
 
 To pretend you have a file with mode and sha1 at path, say:
 
-   $ git-update-index --cacheinfo mode sha1 path
+----------------
+$ git-update-index --cacheinfo mode sha1 path
+----------------
 
 '--info-only' is used to register files without placing them in the object
 database.  This is useful for status-only repositories.
@@ -138,7 +140,9 @@ Examples
 --------
 To update and refresh only the files already checked out:
 
-   git-checkout-index -n -f -a && git-update-index --ignore-missing --refresh
+----------------
+$ git-checkout-index -n -f -a && git-update-index --ignore-missing --refresh
+----------------
 
 
 Configuration
@@ -146,12 +150,18 @@ Configuration
 
 The command honors `core.filemode` configuration variable.  If
 your repository is on an filesystem whose executable bits are
-unreliable, this should be set to 'false'.  This causes the
-command to ignore differences in file modes recorded in the
-index and the file mode on the filesystem if they differ only on
+unreliable, this should be set to 'false' (see gitlink:git-repo-config[1]).
+This causes the command to ignore differences in file modes recorded
+in the index and the file mode on the filesystem if they differ only on
 executable bit.   On such an unfortunate filesystem, you may
 need to use `git-update-index --chmod=`.
 
+
+See Also
+--------
+gitlink:git-repo-config[1]
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
diff --git a/Documentation/git-write-tree.txt b/Documentation/git-write-tree.txt
index abee05f..77e12cb 100644
--- a/Documentation/git-write-tree.txt
+++ b/Documentation/git-write-tree.txt
@@ -14,19 +14,21 @@ DESCRIPTION
 -----------
 Creates a tree object using the current index.
 
-The index must be merged.
+The index must be in a fully merged state.
 
-Conceptually, "git-write-tree" sync()s the current index contents
+Conceptually, `git-write-tree` sync()s the current index contents
 into a set of tree files.
 In order to have that match what is actually in your directory right
-now, you need to have done a "git-update-index" phase before you did the
-"git-write-tree".
+now, you need to have done a `git-update-index` phase before you did the
+`git-write-tree`.
+
 
 OPTIONS
 -------
 --missing-ok::
-	Normally "git-write-tree" ensures that the objects referenced by the
-	directory exist in the object database.  This option disables this check.
+	Normally `git-write-tree` ensures that the objects referenced by the
+	directory exist in the object database.  This option disables this
+	check.
 
 Author
 ------
---
0.99.9j
