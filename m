From: David Greaves <david@dgreaves.com>
Subject: [PATCH 4/5] Docs - tag object, git- prefix and s/changeset/commit/g
Date: Sun, 22 May 2005 18:44:17 +0100
Message-ID: <E1DZuUr-0008Jm-8p@ash.dgreaves.com>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 22 19:50:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZuYy-0004Hl-6x
	for gcvg-git@gmane.org; Sun, 22 May 2005 19:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVEVRtr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 13:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVEVRti
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 13:49:38 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:39910 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261437AbVEVRo3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2005 13:44:29 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id EFBAAE6DAB; Sun, 22 May 2005 18:43:42 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 12606-02; Sun, 22 May 2005 18:43:42 +0100 (BST)
Received: from oak.dgreaves.com (modem-1750.lemur.dialup.pol.co.uk [217.135.134.214])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 5C463E6DB3; Sun, 22 May 2005 18:43:36 +0100 (BST)
Received: from [10.0.0.90] (helo=ash.dgreaves.com)
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DZuUv-00016N-Om; Sun, 22 May 2005 18:44:21 +0100
Received: from david by ash.dgreaves.com with local (Exim 4.50)
	id 1DZuUr-0008Jm-8p; Sun, 22 May 2005 18:44:17 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add docs for tag type
Rename commands to have git- prefix
Rename changeset to commit throughout

Signed-off-by: David Greaves <david@dgreaves.com>

---
commit 702d4ba4f44643b77f3eadbec62b0dd0c22053fd
tree d25a34a8599fec7c11f9ba515b8338cad5837292
parent e6d7c5341942fdd07d966efe36fde653167e84f0
author David Greaves <david@dgreaves.com> Sun, 22 May 2005 18:36:10 +0100
committer David Greaves <david@dgreaves.com> Sun, 22 May 2005 18:36:10 +0100

 README |  163 ++++++++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 91 insertions(+), 72 deletions(-)

Index: README
===================================================================
--- 03ae742170ebaef9040fa8234e1d6752bad140ab/README  (mode:100644)
+++ d25a34a8599fec7c11f9ba515b8338cad5837292/README  (mode:100644)
@@ -31,9 +31,9 @@
 
 All objects have a statically determined "type" aka "tag", which is
 determined at object creation time, and which identifies the format of
-the object (i.e. how it is used, and how it can refer to other objects). 
-There are currently three different object types: "blob", "tree" and
-"commit". 
+the object (i.e. how it is used, and how it can refer to other
+objects).  There are currently four different object types: "blob",
+"tree", "commit" and "tag".
 
 A "blob" object cannot refer to any other object, and is, like the tag
 implies, a pure storage object containing some user data.  It is used to
@@ -44,7 +44,7 @@
 directory structure. In addition, a tree object can refer to other tree
 objects, thus creating a directory hierarchy. 
 
-Finally, a "commit" object ties such directory hierarchies together into
+A "commit" object ties such directory hierarchies together into
 a DAG of revisions - each "commit" is associated with exactly one tree
 (the directory hierarchy at the time of the commit). In addition, a
 "commit" refers to one or more "parent" commit objects that describe the
@@ -79,9 +79,9 @@
 
 The structured objects can further have their structure and
 connectivity to other objects verified. This is generally done with
-the "fsck-cache" program, which generates a full dependency graph of
-all objects, and verifies their internal consistency (in addition to
-just verifying their superficial consistency through the hash).
+the "git-fsck-cache" program, which generates a full dependency graph
+of all objects, and verifies their internal consistency (in addition
+to just verifying their superficial consistency through the hash).
 
 The object types in some more detail:
 
@@ -102,6 +102,9 @@
 directory tree, and renaming a file does not change the object that
 file is associated with in any way.
 
+A blob is created with link:git-write-blob.html[git-write-blob] and
+it's data can be accessed by link:git-cat-file.html[git-cat-file]
+
 Tree Object
 ~~~~~~~~~~~
 The next hierarchical object type is the "tree" object.  A tree object
@@ -138,65 +141,79 @@
 noticing that the blob stayed the same.  However, renames with data
 changes need a smarter "diff" implementation.
 
+A tree is created with link:git-write-tree.html[git-write-tree] and
+it's data can be accessed by link:git-ls-tree.html[git-ls-tree]
 
-Changeset Object
-~~~~~~~~~~~~~~~~
-The "changeset" object is an object that introduces the notion of
+Commit Object
+~~~~~~~~~~~~~
+The "commit" object is an object that introduces the notion of
 history into the picture.  In contrast to the other objects, it
 doesn't just describe the physical state of a tree, it describes how
 we got there, and why.
 
-A "changeset" is defined by the tree-object that it results in, the
-parent changesets (zero, one or more) that led up to that point, and a
-comment on what happened.  Again, a changeset is not trusted per se:
+A "commit" is defined by the tree-object that it results in, the
+parent commits (zero, one or more) that led up to that point, and a
+comment on what happened.  Again, a commit is not trusted per se:
 the contents are well-defined and "safe" due to the cryptographically
 strong signatures at all levels, but there is no reason to believe
 that the tree is "good" or that the merge information makes sense.
 The parents do not have to actually have any relationship with the
 result, for example.
 
-Note on changesets: unlike real SCM's, changesets do not contain
-rename information or file mode change information.  All of that is
+Note on commits: unlike real SCM's, commits do not contain
+rename information or file mode chane information.  All of that is
 implicit in the trees involved (the result tree, and the result trees
 of the parents), and describing that makes no sense in this idiotic
 file manager.
 
-Trust Object
-~~~~~~~~~~~~
-The notion of "trust" is really outside the scope of "git", but it's
-worth noting a few things.  First off, since everything is hashed with
-SHA1, you _can_ trust that an object is intact and has not been messed
-with by external sources.  So the name of an object uniquely
-identifies a known state - just not a state that you may want to
-trust.
+A commit is created with link:git-commit-tree.html[git-commit-tree] and
+it's data can be accessed by link:git-cat-file.html[git-cat-file]
+
+Trust
+~~~~~
+An aside on the notion of "trust". Trust is really outside the scope
+of "git", but it's worth noting a few things.  First off, since
+everything is hashed with SHA1, you _can_ trust that an object is
+intact and has not been messed with by external sources.  So the name
+of an object uniquely identifies a known state - just not a state that
+you may want to trust.
 
-Furthermore, since the SHA1 signature of a changeset refers to the
+Furthermore, since the SHA1 signature of a commit refers to the
 SHA1 signatures of the tree it is associated with and the signatures
-of the parent, a single named changeset specifies uniquely a whole set
+of the parent, a single named commit specifies uniquely a whole set
 of history, with full contents.  You can't later fake any step of the
-way once you have the name of a changeset.
+way once you have the name of a commit.
 
 So to introduce some real trust in the system, the only thing you need
 to do is to digitally sign just _one_ special note, which includes the
-name of a top-level changeset.  Your digital signature shows others
-that you trust that changeset, and the immutability of the history of
-changesets tells others that they can trust the whole history.
+name of a top-level commit.  Your digital signature shows others
+that you trust that commit, and the immutability of the history of
+commits tells others that they can trust the whole history.
 
 In other words, you can easily validate a whole archive by just
 sending out a single email that tells the people the name (SHA1 hash)
-of the top changeset, and digitally sign that email using something
+of the top commit, and digitally sign that email using something
 like GPG/PGP.
 
-In particular, you can also have a separate archive of "trust points"
-or tags, which document your (and other peoples) trust.  You may, of
-course, archive these "certificates of trust" using "git" itself, but
-it's not something "git" does for you.
-
-Another way of saying the last point: "git" itself only handles
-content integrity, the trust has to come from outside.
-
+To assist in this, git also provides the tag object...
 
+Tag Object
+~~~~~~~~~~
+Git provides the "tag" object to simplify creating, managing and
+exchanging symbolic and signed tokens.  The "tag" object at its
+simplest simply symbolically identifies another object by containing
+the sha1, type and symbolic name.
+
+However it can optionally contain additional signature information
+(which git doesn't care about as long as there's less than 8k of
+it). This can then be verified externally to git.
+
+Note that despite the tag features, "git" itself only handles content
+integrity; the trust framework (and signature provision and
+verification) has to come from outside.
 
+A tag is created with link:git-mktag.html[git-mktag] and
+it's data can be accessed by link:git-cat-file.html[git-cat-file]
 
 The "index" aka "Current Directory Cache"
 -----------------------------------------
@@ -263,11 +280,11 @@
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 You update the index with information from the working directory with
-the "update-cache" command.  You generally update the index
-information by just specifying the filename you want to update, like
-so:
+the link:git-update-cache.html[git-update-cache] command.  You
+generally update the index information by just specifying the filename
+you want to update, like so:
 
-		update-cache filename
+	git-update-cache filename
 
 but to avoid common mistakes with filename globbing etc, the command
 will not normally add totally new entries or remove old entries,
@@ -284,7 +301,7 @@
 considering a removed file to be a valid thing, and if the file really
 does not exist any more, it will update the index accordingly.
 
-As a special case, you can also do "update-cache --refresh", which
+As a special case, you can also do "git-update-cache --refresh", which
 will refresh the "stat" information of each index to match the current
 stat information. It will _not_ update the object status itself, and
 it will only update the fields that are used to quickly test whether
@@ -295,7 +312,7 @@
 
 You write your current index file to a "tree" object with the program
 
-		write-tree
+	git-write-tree
 
 that doesn't come with any options - it will just write out the
 current index into the set of tree objects that describe that state,
@@ -311,7 +328,7 @@
 unsaved state that you might want to restore later!) your current
 index.  Normal operation is just
 
-		read-tree <sha1 of tree>
+		git-read-tree <sha1 of tree>
 
 and your index file will now be equivalent to the tree that you saved
 earlier. However, that is only your _index_ file: your working
@@ -324,20 +341,19 @@
 files. This is not a very common operation, since normally you'd just
 keep your files updated, and rather than write to your working
 directory, you'd tell the index files about the changes in your
-working directory (i.e. "update-cache").
+working directory (i.e. "git-update-cache").
 
 However, if you decide to jump to a new version, or check out somebody
 else's version, or just restore a previous tree, you'd populate your
 index file with read-tree, and then you need to check out the result
 with
-
-		checkout-cache filename
+		git-checkout-cache filename
 
 or, if you want to check out all of the index, use "-a".
 
-NOTE! checkout-cache normally refuses to overwrite old files, so if
-you have an old version of the tree already checked out, you will need
-to use the "-f" flag (_before_ the "-a" flag or the filename) to
+NOTE! git-checkout-cache normally refuses to overwrite old files, so
+if you have an old version of the tree already checked out, you will
+need to use the "-f" flag (_before_ the "-a" flag or the filename) to
 _force_ the checkout.
 
 
@@ -346,10 +362,10 @@
 
 5) Tying it all together
 ~~~~~~~~~~~~~~~~~~~~~~~~
-
-To commit a tree you have instantiated with "write-tree", you'd create
-a "commit" object that refers to that tree and the history behind it -
-most notably the "parent" commits that preceded it in history.
+To commit a tree you have instantiated with "git-write-tree", you'd
+create a "commit" object that refers to that tree and the history
+behind it - most notably the "parent" commits that preceded it in
+history.
 
 Normally a "commit" has one parent: the previous state of the tree
 before a certain change was made. However, sometimes it can have two
@@ -364,15 +380,15 @@
 You create a commit object by giving it the tree that describes the
 state at the time of the commit, and a list of parents:
 
-		commit-tree <tree> -p <parent> [-p <parent2> ..]
+	git-commit-tree <tree> -p <parent> [-p <parent2> ..]
 
 and then giving the reason for the commit on stdin (either through
 redirection from a pipe or file, or by just typing it at the tty).
 
-commit-tree will return the name of the object that represents that
-commit, and you should save it away for later use. Normally, you'd
-commit a new "HEAD" state, and while git doesn't care where you save
-the note about that state, in practice we tend to just write the
+git-commit-tree will return the name of the object that represents
+that commit, and you should save it away for later use. Normally,
+you'd commit a new "HEAD" state, and while git doesn't care where you
+save the note about that state, in practice we tend to just write the
 result to the file ".git/HEAD", so that we can always see what the
 last committed state was.
 
@@ -381,25 +397,27 @@
 
 You can examine the data represented in the object database and the
 index with various helper tools. For every object, you can use
-"cat-file" to examine details about the object:
+link:git-cat-file.html[git-cat-file] to examine details about the
+object:
 
-		cat-file -t <objectname>
+		git-cat-file -t <objectname>
 
 shows the type of the object, and once you have the type (which is
 usually implicit in where you find the object), you can use
 
-		cat-file blob|tree|commit <objectname>
+		git-cat-file blob|tree|commit <objectname>
 
 to show its contents. NOTE! Trees have binary content, and as a result
-there is a special helper for showing that content, called "ls-tree",
-which turns the binary content into a more easily readable form.
+there is a special helper for showing that content, called
+"git-ls-tree", which turns the binary content into a more easily
+readable form.
 
 It's especially instructive to look at "commit" objects, since those
 tend to be small and fairly self-explanatory. In particular, if you
 follow the convention of having the top commit name in ".git/HEAD",
 you can do
 
-		cat-file commit $(cat .git/HEAD)
+		git-cat-file commit $(cat .git/HEAD)
 
 to see what the top commit was.
 
@@ -420,13 +438,13 @@
 To get the "base" for the merge, you first look up the common parent
 of two commits with
 
-		merge-base <commit1> <commit2>
+		git-merge-base <commit1> <commit2>
 
 which will return you the commit they are both based on.  You should
 now look up the "tree" objects of those commits, which you can easily
 do with (for example)
 
-		cat-file commit <commitname> | head -1
+		git-cat-file commit <commitname> | head -1
 
 since the tree object information is always the first line in a commit
 object.
@@ -441,15 +459,16 @@
 
 To do the merge, do
 
-		read-tree -m <origtree> <target1tree> <target2tree>
+		git-read-tree -m <origtree> <target1tree> <target2tree>
 
 which will do all trivial merge operations for you directly in the
-index file, and you can just write the result out with "write-tree".
+index file, and you can just write the result out with
+"git-write-tree".
 
 NOTE! Because the merge is done in the index file, and not in your
 working directory, your working directory will no longer match your
-index. You can use "checkout-cache -f -a" to make the effect of the
-merge be seen in your working directory.
+index. You can use "git-checkout-cache -f -a" to make the effect of
+the merge be seen in your working directory.
 
 NOTE2! Sadly, many merges aren't trivial. If there are files that have
 been added.moved or removed, or if both branches have modified the
