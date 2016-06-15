From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] sanitize content of README file
Date: Wed, 17 Jan 2007 13:04:39 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701171255150.2577@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 19:04:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7F9S-0003nZ-Ca
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 19:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbXAQSEo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 13:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbXAQSEo
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 13:04:44 -0500
Received: from relais.videotron.ca ([24.201.245.36]:45959 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932587AbXAQSEm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 13:04:42 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JC000F63Y7RZZ00@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 17 Jan 2007 13:04:41 -0500 (EST)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37021>

Current README content is way too esoteric for someone looking at GIT 
for the first time. Instead it should provide a quick summary of what 
GIT is with a few pointers to other resources.

The bulk of the previous README content is moved to 
Documentation/core-intro.txt.

Signed-of-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/README b/Documentation/core-intro.txt
similarity index 99%
copy from README
copy to Documentation/core-intro.txt
index cee7e43..2bad1a7 100644
--- a/README
+++ b/Documentation/core-intro.txt
@@ -3,6 +3,7 @@
 	GIT - the stupid content tracker
 
 ////////////////////////////////////////////////////////////////
+
 "git" can mean anything, depending on your mood.
 
  - random three-letter combination that is pronounceable, and not
@@ -14,9 +15,9 @@
    works for you. Angels sing, and a light suddenly fills the room. 
  - "goddamn idiotic truckload of sh*t": when it breaks
 
-This is a stupid (but extremely fast) directory content manager.  It
-doesn't do a whole lot, but what it 'does' do is track directory
-contents efficiently. 
+This is a (not so) stupid but extremely fast directory content manager.
+It doesn't do a whole lot at its core, but what it 'does' do is track 
+directory contents efficiently. 
 
 There are two object abstractions: the "object database", and the
 "current directory cache" aka "index".
diff --git a/README b/README
index cee7e43..a49b182 100644
--- a/README
+++ b/README
@@ -3,6 +3,7 @@
 	GIT - the stupid content tracker
 
 ////////////////////////////////////////////////////////////////
+
 "git" can mean anything, depending on your mood.
 
  - random three-letter combination that is pronounceable, and not
@@ -14,576 +15,26 @@
    works for you. Angels sing, and a light suddenly fills the room. 
  - "goddamn idiotic truckload of sh*t": when it breaks
 
-This is a stupid (but extremely fast) directory content manager.  It
-doesn't do a whole lot, but what it 'does' do is track directory
-contents efficiently. 
-
-There are two object abstractions: the "object database", and the
-"current directory cache" aka "index".
-
-The Object Database
-~~~~~~~~~~~~~~~~~~~
-The object database is literally just a content-addressable collection
-of objects.  All objects are named by their content, which is
-approximated by the SHA1 hash of the object itself.  Objects may refer
-to other objects (by referencing their SHA1 hash), and so you can
-build up a hierarchy of objects.
-
-All objects have a statically determined "type" aka "tag", which is
-determined at object creation time, and which identifies the format of
-the object (i.e. how it is used, and how it can refer to other
-objects).  There are currently four different object types: "blob",
-"tree", "commit" and "tag".
-
-A "blob" object cannot refer to any other object, and is, like the type
-implies, a pure storage object containing some user data.  It is used to
-actually store the file data, i.e. a blob object is associated with some
-particular version of some file. 
-
-A "tree" object is an object that ties one or more "blob" objects into a
-directory structure. In addition, a tree object can refer to other tree
-objects, thus creating a directory hierarchy. 
-
-A "commit" object ties such directory hierarchies together into
-a DAG of revisions - each "commit" is associated with exactly one tree
-(the directory hierarchy at the time of the commit). In addition, a
-"commit" refers to one or more "parent" commit objects that describe the
-history of how we arrived at that directory hierarchy.
-
-As a special case, a commit object with no parents is called the "root"
-object, and is the point of an initial project commit.  Each project
-must have at least one root, and while you can tie several different
-root objects together into one project by creating a commit object which
-has two or more separate roots as its ultimate parents, that's probably
-just going to confuse people.  So aim for the notion of "one root object
-per project", even if git itself does not enforce that. 
-
-A "tag" object symbolically identifies and can be used to sign other
-objects. It contains the identifier and type of another object, a
-symbolic name (of course!) and, optionally, a signature.
-
-Regardless of object type, all objects share the following
-characteristics: they are all deflated with zlib, and have a header
-that not only specifies their type, but also provides size information
-about the data in the object.  It's worth noting that the SHA1 hash
-that is used to name the object is the hash of the original data
-plus this header, so `sha1sum` 'file' does not match the object name
-for 'file'.
-(Historical note: in the dawn of the age of git the hash
-was the sha1 of the 'compressed' object.)
-
-As a result, the general consistency of an object can always be tested
-independently of the contents or the type of the object: all objects can
-be validated by verifying that (a) their hashes match the content of the
-file and (b) the object successfully inflates to a stream of bytes that
-forms a sequence of <ascii type without space> + <space> + <ascii decimal
-size> + <byte\0> + <binary object data>. 
-
-The structured objects can further have their structure and
-connectivity to other objects verified. This is generally done with
-the `git-fsck-objects` program, which generates a full dependency graph
-of all objects, and verifies their internal consistency (in addition
-to just verifying their superficial consistency through the hash).
-
-The object types in some more detail:
-
-Blob Object
-~~~~~~~~~~~
-A "blob" object is nothing but a binary blob of data, and doesn't
-refer to anything else.  There is no signature or any other
-verification of the data, so while the object is consistent (it 'is'
-indexed by its sha1 hash, so the data itself is certainly correct), it
-has absolutely no other attributes.  No name associations, no
-permissions.  It is purely a blob of data (i.e. normally "file
-contents").
-
-In particular, since the blob is entirely defined by its data, if two
-files in a directory tree (or in multiple different versions of the
-repository) have the same contents, they will share the same blob
-object. The object is totally independent of its location in the
-directory tree, and renaming a file does not change the object that
-file is associated with in any way.
-
-A blob is typically created when gitlink:git-update-index[1]
-is run, and its data can be accessed by gitlink:git-cat-file[1].
-
-Tree Object
-~~~~~~~~~~~
-The next hierarchical object type is the "tree" object.  A tree object
-is a list of mode/name/blob data, sorted by name.  Alternatively, the
-mode data may specify a directory mode, in which case instead of
-naming a blob, that name is associated with another TREE object.
-
-Like the "blob" object, a tree object is uniquely determined by the
-set contents, and so two separate but identical trees will always
-share the exact same object. This is true at all levels, i.e. it's
-true for a "leaf" tree (which does not refer to any other trees, only
-blobs) as well as for a whole subdirectory.
-
-For that reason a "tree" object is just a pure data abstraction: it
-has no history, no signatures, no verification of validity, except
-that since the contents are again protected by the hash itself, we can
-trust that the tree is immutable and its contents never change.
-
-So you can trust the contents of a tree to be valid, the same way you
-can trust the contents of a blob, but you don't know where those
-contents 'came' from.
-
-Side note on trees: since a "tree" object is a sorted list of
-"filename+content", you can create a diff between two trees without
-actually having to unpack two trees.  Just ignore all common parts,
-and your diff will look right.  In other words, you can effectively
-(and efficiently) tell the difference between any two random trees by
-O(n) where "n" is the size of the difference, rather than the size of
-the tree.
-
-Side note 2 on trees: since the name of a "blob" depends entirely and
-exclusively on its contents (i.e. there are no names or permissions
-involved), you can see trivial renames or permission changes by
-noticing that the blob stayed the same.  However, renames with data
-changes need a smarter "diff" implementation.
-
-A tree is created with gitlink:git-write-tree[1] and
-its data can be accessed by gitlink:git-ls-tree[1].
-Two trees can be compared with gitlink:git-diff-tree[1].
-
-Commit Object
-~~~~~~~~~~~~~
-The "commit" object is an object that introduces the notion of
-history into the picture.  In contrast to the other objects, it
-doesn't just describe the physical state of a tree, it describes how
-we got there, and why.
-
-A "commit" is defined by the tree-object that it results in, the
-parent commits (zero, one or more) that led up to that point, and a
-comment on what happened.  Again, a commit is not trusted per se:
-the contents are well-defined and "safe" due to the cryptographically
-strong signatures at all levels, but there is no reason to believe
-that the tree is "good" or that the merge information makes sense.
-The parents do not have to actually have any relationship with the
-result, for example.
-
-Note on commits: unlike real SCM's, commits do not contain
-rename information or file mode change information.  All of that is
-implicit in the trees involved (the result tree, and the result trees
-of the parents), and describing that makes no sense in this idiotic
-file manager.
-
-A commit is created with gitlink:git-commit-tree[1] and
-its data can be accessed by gitlink:git-cat-file[1].
-
-Trust
-~~~~~
-An aside on the notion of "trust". Trust is really outside the scope
-of "git", but it's worth noting a few things.  First off, since
-everything is hashed with SHA1, you 'can' trust that an object is
-intact and has not been messed with by external sources.  So the name
-of an object uniquely identifies a known state - just not a state that
-you may want to trust.
-
-Furthermore, since the SHA1 signature of a commit refers to the
-SHA1 signatures of the tree it is associated with and the signatures
-of the parent, a single named commit specifies uniquely a whole set
-of history, with full contents.  You can't later fake any step of the
-way once you have the name of a commit.
-
-So to introduce some real trust in the system, the only thing you need
-to do is to digitally sign just 'one' special note, which includes the
-name of a top-level commit.  Your digital signature shows others
-that you trust that commit, and the immutability of the history of
-commits tells others that they can trust the whole history.
-
-In other words, you can easily validate a whole archive by just
-sending out a single email that tells the people the name (SHA1 hash)
-of the top commit, and digitally sign that email using something
-like GPG/PGP.
-
-To assist in this, git also provides the tag object...
-
-Tag Object
-~~~~~~~~~~
-Git provides the "tag" object to simplify creating, managing and
-exchanging symbolic and signed tokens.  The "tag" object at its
-simplest simply symbolically identifies another object by containing
-the sha1, type and symbolic name.
-
-However it can optionally contain additional signature information
-(which git doesn't care about as long as there's less than 8k of
-it). This can then be verified externally to git.
-
-Note that despite the tag features, "git" itself only handles content
-integrity; the trust framework (and signature provision and
-verification) has to come from outside.
-
-A tag is created with gitlink:git-mktag[1],
-its data can be accessed by gitlink:git-cat-file[1],
-and the signature can be verified by
-gitlink:git-verify-tag[1].
-
-
-The "index" aka "Current Directory Cache"
------------------------------------------
-The index is a simple binary file, which contains an efficient
-representation of a virtual directory content at some random time.  It
-does so by a simple array that associates a set of names, dates,
-permissions and content (aka "blob") objects together.  The cache is
-always kept ordered by name, and names are unique (with a few very
-specific rules) at any point in time, but the cache has no long-term
-meaning, and can be partially updated at any time.
-
-In particular, the index certainly does not need to be consistent with
-the current directory contents (in fact, most operations will depend on
-different ways to make the index 'not' be consistent with the directory
-hierarchy), but it has three very important attributes:
-
-'(a) it can re-generate the full state it caches (not just the
-directory structure: it contains pointers to the "blob" objects so
-that it can regenerate the data too)'
-
-As a special case, there is a clear and unambiguous one-way mapping
-from a current directory cache to a "tree object", which can be
-efficiently created from just the current directory cache without
-actually looking at any other data.  So a directory cache at any one
-time uniquely specifies one and only one "tree" object (but has
-additional data to make it easy to match up that tree object with what
-has happened in the directory)
-
-'(b) it has efficient methods for finding inconsistencies between that
-cached state ("tree object waiting to be instantiated") and the
-current state.'
-
-'(c) it can additionally efficiently represent information about merge
-conflicts between different tree objects, allowing each pathname to be
-associated with sufficient information about the trees involved that
-you can create a three-way merge between them.'
-
-Those are the three ONLY things that the directory cache does.  It's a
-cache, and the normal operation is to re-generate it completely from a
-known tree object, or update/compare it with a live tree that is being
-developed.  If you blow the directory cache away entirely, you generally
-haven't lost any information as long as you have the name of the tree
-that it described. 
-
-At the same time, the index is at the same time also the
-staging area for creating new trees, and creating a new tree always
-involves a controlled modification of the index file.  In particular,
-the index file can have the representation of an intermediate tree that
-has not yet been instantiated.  So the index can be thought of as a
-write-back cache, which can contain dirty information that has not yet
-been written back to the backing store.
-
-
-
-The Workflow
-------------
-Generally, all "git" operations work on the index file. Some operations
-work *purely* on the index file (showing the current state of the
-index), but most operations move data to and from the index file. Either
-from the database or from the working directory. Thus there are four
-main combinations: 
-
-1) working directory -> index
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-You update the index with information from the working directory with
-the gitlink:git-update-index[1] command.  You
-generally update the index information by just specifying the filename
-you want to update, like so:
-
-	git-update-index filename
-
-but to avoid common mistakes with filename globbing etc, the command
-will not normally add totally new entries or remove old entries,
-i.e. it will normally just update existing cache entries.
-
-To tell git that yes, you really do realize that certain files no
-longer exist, or that new files should be added, you
-should use the `--remove` and `--add` flags respectively.
-
-NOTE! A `--remove` flag does 'not' mean that subsequent filenames will
-necessarily be removed: if the files still exist in your directory
-structure, the index will be updated with their new status, not
-removed. The only thing `--remove` means is that update-cache will be
-considering a removed file to be a valid thing, and if the file really
-does not exist any more, it will update the index accordingly.
-
-As a special case, you can also do `git-update-index --refresh`, which
-will refresh the "stat" information of each index to match the current
-stat information. It will 'not' update the object status itself, and
-it will only update the fields that are used to quickly test whether
-an object still matches its old backing store object.
-
-2) index -> object database
-~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-You write your current index file to a "tree" object with the program
-
-	git-write-tree
-
-that doesn't come with any options - it will just write out the
-current index into the set of tree objects that describe that state,
-and it will return the name of the resulting top-level tree. You can
-use that tree to re-generate the index at any time by going in the
-other direction:
-
-3) object database -> index
-~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-You read a "tree" file from the object database, and use that to
-populate (and overwrite - don't do this if your index contains any
-unsaved state that you might want to restore later!) your current
-index.  Normal operation is just
-
-		git-read-tree <sha1 of tree>
-
-and your index file will now be equivalent to the tree that you saved
-earlier. However, that is only your 'index' file: your working
-directory contents have not been modified.
-
-4) index -> working directory
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-You update your working directory from the index by "checking out"
-files. This is not a very common operation, since normally you'd just
-keep your files updated, and rather than write to your working
-directory, you'd tell the index files about the changes in your
-working directory (i.e. `git-update-index`).
-
-However, if you decide to jump to a new version, or check out somebody
-else's version, or just restore a previous tree, you'd populate your
-index file with read-tree, and then you need to check out the result
-with
-
-		git-checkout-index filename
-
-or, if you want to check out all of the index, use `-a`.
-
-NOTE! git-checkout-index normally refuses to overwrite old files, so
-if you have an old version of the tree already checked out, you will
-need to use the "-f" flag ('before' the "-a" flag or the filename) to
-'force' the checkout.
-
-
-Finally, there are a few odds and ends which are not purely moving
-from one representation to the other:
-
-5) Tying it all together
-~~~~~~~~~~~~~~~~~~~~~~~~
-To commit a tree you have instantiated with "git-write-tree", you'd
-create a "commit" object that refers to that tree and the history
-behind it - most notably the "parent" commits that preceded it in
-history.
-
-Normally a "commit" has one parent: the previous state of the tree
-before a certain change was made. However, sometimes it can have two
-or more parent commits, in which case we call it a "merge", due to the
-fact that such a commit brings together ("merges") two or more
-previous states represented by other commits.
-
-In other words, while a "tree" represents a particular directory state
-of a working directory, a "commit" represents that state in "time",
-and explains how we got there.
-
-You create a commit object by giving it the tree that describes the
-state at the time of the commit, and a list of parents:
-
-	git-commit-tree <tree> -p <parent> [-p <parent2> ..]
-
-and then giving the reason for the commit on stdin (either through
-redirection from a pipe or file, or by just typing it at the tty).
-
-git-commit-tree will return the name of the object that represents
-that commit, and you should save it away for later use. Normally,
-you'd commit a new `HEAD` state, and while git doesn't care where you
-save the note about that state, in practice we tend to just write the
-result to the file pointed at by `.git/HEAD`, so that we can always see
-what the last committed state was.
-
-Here is an ASCII art by Jon Loeliger that illustrates how
-various pieces fit together.
-
-------------
-
-                     commit-tree
-                      commit obj
-                       +----+
-                       |    |
-                       |    |
-                       V    V
-                    +-----------+
-                    | Object DB |
-                    |  Backing  |
-                    |   Store   |
-                    +-----------+
-                       ^
-           write-tree  |     |
-             tree obj  |     |
-                       |     |  read-tree
-                       |     |  tree obj
-                             V
-                    +-----------+
-                    |   Index   |
-                    |  "cache"  |
-                    +-----------+
-         update-index  ^
-             blob obj  |     |
-                       |     |
-    checkout-index -u  |     |  checkout-index
-             stat      |     |  blob obj
-                             V
-                    +-----------+
-                    |  Working  |
-                    | Directory |
-                    +-----------+
-
-------------
-
-
-6) Examining the data
-~~~~~~~~~~~~~~~~~~~~~
-
-You can examine the data represented in the object database and the
-index with various helper tools. For every object, you can use
-gitlink:git-cat-file[1] to examine details about the
-object:
-
-		git-cat-file -t <objectname>
-
-shows the type of the object, and once you have the type (which is
-usually implicit in where you find the object), you can use
-
-		git-cat-file blob|tree|commit|tag <objectname>
-
-to show its contents. NOTE! Trees have binary content, and as a result
-there is a special helper for showing that content, called
-`git-ls-tree`, which turns the binary content into a more easily
-readable form.
-
-It's especially instructive to look at "commit" objects, since those
-tend to be small and fairly self-explanatory. In particular, if you
-follow the convention of having the top commit name in `.git/HEAD`,
-you can do
-
-		git-cat-file commit HEAD
-
-to see what the top commit was.
-
-7) Merging multiple trees
-~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Git helps you do a three-way merge, which you can expand to n-way by
-repeating the merge procedure arbitrary times until you finally
-"commit" the state.  The normal situation is that you'd only do one
-three-way merge (two parents), and commit it, but if you like to, you
-can do multiple parents in one go.
-
-To do a three-way merge, you need the two sets of "commit" objects
-that you want to merge, use those to find the closest common parent (a
-third "commit" object), and then use those commit objects to find the
-state of the directory ("tree" object) at these points.
-
-To get the "base" for the merge, you first look up the common parent
-of two commits with
-
-		git-merge-base <commit1> <commit2>
-
-which will return you the commit they are both based on.  You should
-now look up the "tree" objects of those commits, which you can easily
-do with (for example)
-
-		git-cat-file commit <commitname> | head -1
-
-since the tree object information is always the first line in a commit
-object.
-
-Once you know the three trees you are going to merge (the one
-"original" tree, aka the common case, and the two "result" trees, aka
-the branches you want to merge), you do a "merge" read into the
-index. This will complain if it has to throw away your old index contents, so you should
-make sure that you've committed those - in fact you would normally
-always do a merge against your last commit (which should thus match
-what you have in your current index anyway).
-
-To do the merge, do
-
-		git-read-tree -m -u <origtree> <yourtree> <targettree>
-
-which will do all trivial merge operations for you directly in the
-index file, and you can just write the result out with
-`git-write-tree`.
-
-Historical note.  We did not have `-u` facility when this
-section was first written, so we used to warn that
-the merge is done in the index file, not in your
-working tree, and your working tree will not match your
-index after this step.
-This is no longer true.  The above command, thanks to `-u`
-option, updates your working tree with the merge results for
-paths that have been trivially merged.
-
-
-8) Merging multiple trees, continued
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Sadly, many merges aren't trivial. If there are files that have
-been added.moved or removed, or if both branches have modified the
-same file, you will be left with an index tree that contains "merge
-entries" in it. Such an index tree can 'NOT' be written out to a tree
-object, and you will have to resolve any such merge clashes using
-other tools before you can write out the result.
-
-You can examine such index state with `git-ls-files --unmerged`
-command.  An example:
-
-------------------------------------------------
-$ git-read-tree -m $orig HEAD $target
-$ git-ls-files --unmerged
-100644 263414f423d0e4d70dae8fe53fa34614ff3e2860 1	hello.c
-100644 06fa6a24256dc7e560efa5687fa84b51f0263c3a 2	hello.c
-100644 cc44c73eb783565da5831b4d820c962954019b69 3	hello.c
-------------------------------------------------
-
-Each line of the `git-ls-files --unmerged` output begins with
-the blob mode bits, blob SHA1, 'stage number', and the
-filename.  The 'stage number' is git's way to say which tree it
-came from: stage 1 corresponds to `$orig` tree, stage 2 `HEAD`
-tree, and stage3 `$target` tree.
-
-Earlier we said that trivial merges are done inside
-`git-read-tree -m`.  For example, if the file did not change
-from `$orig` to `HEAD` nor `$target`, or if the file changed
-from `$orig` to `HEAD` and `$orig` to `$target` the same way,
-obviously the final outcome is what is in `HEAD`.  What the
-above example shows is that file `hello.c` was changed from
-`$orig` to `HEAD` and `$orig` to `$target` in a different way.
-You could resolve this by running your favorite 3-way merge
-program, e.g.  `diff3` or `merge`, on the blob objects from
-these three stages yourself, like this:
-
-------------------------------------------------
-$ git-cat-file blob 263414f... >hello.c~1
-$ git-cat-file blob 06fa6a2... >hello.c~2
-$ git-cat-file blob cc44c73... >hello.c~3
-$ merge hello.c~2 hello.c~1 hello.c~3
-------------------------------------------------
-
-This would leave the merge result in `hello.c~2` file, along
-with conflict markers if there are conflicts.  After verifying
-the merge result makes sense, you can tell git what the final
-merge result for this file is by:
-
-	mv -f hello.c~2 hello.c
-	git-update-index hello.c
-
-When a path is in unmerged state, running `git-update-index` for
-that path tells git to mark the path resolved.
-
-The above is the description of a git merge at the lowest level,
-to help you understand what conceptually happens under the hood.
-In practice, nobody, not even git itself, uses three `git-cat-file`
-for this.  There is `git-merge-index` program that extracts the
-stages to temporary files and calls a "merge" script on it:
-
-	git-merge-index git-merge-one-file hello.c
-
-and that is what higher level `git resolve` is implemented with.
+Git is a fast, scalable, distributed revision control system with an
+unusually rich command set that provides both high-level operations
+and full access to internals.
+
+Git is an Open Source project covered by the GNU General Public License.
+It was originally written by Linus Torvalds with help of a group of
+hackers around the net. It is currently maintained by Junio C Hamano.
+
+Please read the file INSTALL for installation instructions.
+See Documentation/tutorial.txt to get started, then see
+Documentation/everyday.txt for a useful minimum set of commands,
+and "man git-commandname" for documentation of each command.
+CVS users may also want to read Documentation/cvs-migration.txt.
+
+Many Git online resources are accessible from http://git.or.cz/
+including full documentation and Git related tools.
+
+The user discussion and development of Git take place on the Git
+mailing list -- everyone is welcome to post bug reports, feature
+requests, comments and patches to git@vger.kernel.org. To subscribe
+to the list, send an email with just "subscribe git" in the body to
+majordomo@vger.kernel.org. The mailing list archives are available at
+http://marc.theaimsgroup.com/?l=git and other archival sites.
