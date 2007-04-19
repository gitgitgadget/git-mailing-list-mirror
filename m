From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] user-manual.txt: Some doc updates
Date: Thu, 19 Apr 2007 17:49:40 +0200
Message-ID: <87hcrcjre3.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 19 17:49:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeYsT-0007ND-QA
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 17:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766822AbXDSPsu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 19 Apr 2007 11:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766823AbXDSPsu
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 11:48:50 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:49524 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1766822AbXDSPst (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 11:48:49 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l3JFmku31410
	for <git@vger.kernel.org>; Thu, 19 Apr 2007 17:48:46 +0200
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.95 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45025>


* use "git config" instead of directly editing config files

* git branch {,-a,-r} list local, all or remote branches

* git branch -d checkd for reachability from the current branch

* refs/remotes/${remote}/HEAD does not depend on the number of branches

* log family can use the --reverse flag

* explain "git diff HEAD", and its relation to "git commit -a"

* add a sentence about "git mergetool"

* set up a tracking branch with "git branch --track"

* replace origin/HEAD with just origin

* fix the call to "git clone" to create a bare repository

* replace proj-clone.git with just proj.git

* use "git --bare" when in a bare repository

* add a sentence about "git instaweb"

* another way to force the fast-forward check is with the -f flag,
  that can be used even for remotes in the config

* "git fetch example example/master" is not equivalent to the others

* the type of an object is not aka "tag"

* replace "root object" with "root commit"

* a commit is also defined with the author/commit date.

* replace "unlike real SCM's"  with "unlike some SCM's", git plumbing
  is not an SCM but git porcelain is

* the index does not always represent a directory at some random time

* the "common case" is in fact the "common tree"

* git-write-tree only success if the merge went well

* add and use the git's merge-file

* "git gc" is a porcelain command, so remove if from the plumbing chapt=
er,
  and it is already explained before

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---

 Hi *,

 I know they are a lot of * :-)

 There are some a bit controversial (real SCM, "git gc") but the major
 part I think they are not.

 Santi

 Documentation/user-manual.txt |  133 ++++++++++++++++++++++-----------=
-------
 1 files changed, 73 insertions(+), 60 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.=
txt
index 9c4c41d..70a18fb 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -54,7 +54,7 @@ Managing branches
 -----------------
=20
 -----------------------------------------------
-$ git branch	     # list all branches in this repo
+$ git branch	     # list all local branches in this repo
 $ git checkout test  # switch working directory to branch "test"
 $ git branch new     # create branch "new" starting at current HEAD
 $ git branch -d new  # delete branch "new"
@@ -153,11 +153,8 @@ Making changes
 Make sure git knows who to blame:
=20
 ------------------------------------------------
-$ cat >~/.gitconfig <<\EOF
-[user]
-	name =3D Your Name Comes Here
-	email =3D you@yourdomain.example.com
-EOF
+$ git config --global user.name "Your Name Comes Here"
+$ git config --global user.email you@yourdomain.example.com
 ------------------------------------------------
=20
 Select file contents to include in the next commit, then make the
@@ -470,6 +467,10 @@ Creating, deleting, and modifying branches is quic=
k and easy; here's
 a summary of the commands:
=20
 git branch::
+	list all local branches
+git branch -r::
+	list all remote branches
+git branch -a::
 	list all branches
 git branch <branch>::
 	create a new branch named <branch>, referencing the same
@@ -480,7 +481,7 @@ git branch <branch> <start-point>::
 	including using a branch name or a tag name
 git branch -d <branch>::
 	delete the branch <branch>; if the branch you are deleting
-	points to a commit which is not reachable from this branch,
+	points to a commit which is not reachable from the current branch,
 	this command will fail with a warning.
 git branch -D <branch>::
 	even if the branch points to a commit not reachable
@@ -586,13 +587,8 @@ shorthand:
 The full name is occasionally useful if, for example, there ever
 exists a tag and a branch with the same name.
=20
-As another useful shortcut, if the repository "origin" posesses only
-a single branch, you can refer to that branch as just "origin".
-
-More generally, if you have defined a remote repository named
-"example", you can refer to the branch in that repository as
-"example".  And for a repository with multiple branches, this will
-refer to the branch designated as the "HEAD" branch.
+As another useful shortcut, if the repository "origin" has a HEAD,
+you can refer to that as just "origin".
=20
 For the complete list of paths which git checks for references, and
 the order it uses to decide which to choose when there are multiple
@@ -812,9 +808,9 @@ $ git tag stable-1 1b2e1d63ff
 You can use stable-1 to refer to the commit 1b2e1d63ff.
=20
 This creates a "lightweight" tag.  If the tag is a tag you wish to
-share with others, and possibly sign cryptographically, then you
-should create a tag object instead; see the gitlink:git-tag[1] man
-page for details.
+share with others, with a tag message, and possibly sign
+cryptographically, then you should create a tag object instead;
+see the gitlink:git-tag[1] man page for details.
=20
 Browsing revisions
 ------------------
@@ -855,7 +851,8 @@ display options.
 Note that git log starts with the most recent commit and works
 backwards through the parents; however, since git history can contain
 multiple independent lines of development, the particular order that
-commits are listed in may be somewhat arbitrary.
+commits are listed in may be somewhat arbitrary. Use "--reverse" to ge=
t
+the commits in reverse order.
=20
 Generating diffs
 ----------------
@@ -1023,17 +1020,10 @@ Before creating any commits, you should introdu=
ce yourself to git.  The
 easiest way to do so is:
=20
 ------------------------------------------------
-$ cat >~/.gitconfig <<\EOF
-[user]
-	name =3D Your Name Comes Here
-	email =3D you@yourdomain.example.com
-EOF
+$ git config --global user.name "Your Name Comes Here"
+$ git config --global user.email you@yourdomain.example.com
 ------------------------------------------------
=20
-(See the "CONFIGURATION FILE" section of gitlink:git-config[1] for
-details on the configuration file.)
-
-
 Creating a new repository
 -------------------------
=20
@@ -1112,6 +1102,12 @@ $ git diff
=20
 shows the difference between the working tree and the index file.
=20
+-------------------------------------------------
+$ git diff HEAD
+-------------------------------------------------
+
+shows the difference between the working tree and HEAD.
+
 Note that "git add" always adds just the current contents of a file
 to the index; further changes to the same file will be ignored unless
 you run git-add on the file again.
@@ -1123,7 +1119,9 @@ $ git commit
 -------------------------------------------------
=20
 and git will prompt you for a commit message and then create the new
-commit.  Check to make sure it looks like what you expected with
+commit.  With "-v" it gives a preview of what is being committed.
+
+Check to make sure it looks like what you expected with
=20
 -------------------------------------------------
 $ git show
@@ -1147,6 +1145,8 @@ $ git diff --cached # difference between HEAD and=
 the index; what
 $ git diff	    # difference between the index file and your
 		    # working directory; changes that would not
 		    # be included if you ran "commit" now.
+$ git diff HEAD	    # difference between the working tree and HEAD;
+		    # what would be commited if you ran "commit -a".
 $ git status	    # a brief per-file summary of the above.
 -------------------------------------------------
=20
@@ -1192,8 +1192,6 @@ If you examine the resulting commit using gitk, y=
ou will see that it
 has two parents, one pointing to the top of the current branch, and
 one to the top of the other branch.
=20
-In more detail:
-
 [[resolving-a-merge]]
 Resolving a merge
 -----------------
@@ -1329,6 +1327,10 @@ $ gitk --merge
 These will display all commits which exist only on HEAD or on
 MERGE_HEAD, and which touch an unmerged file.
=20
+The gitlink:git-mergetool command lets you merge the unmerged files
+using external tools, such as kdiff3, xxdiff, meld, opendiff, emacs,
+or vimdiff.
+
 Each time you resolve the conflicts in a file and update the index:
=20
 -------------------------------------------------
@@ -1652,6 +1654,12 @@ $ git pull
 See the descriptions of the branch.<name>.remote and
 branch.<name>.merge options in gitlink:git-config[1] to learn
 how to control these defaults depending on the current branch.
+They can be set automatically if you create the branch using
+(see the gitlink:git-branch[1] man page for details):
+
+-------------------------------------------------
+$ git branch --track <branch> <start-point>
+-------------------------------------------------
=20
 In addition to saving you keystrokes, "git pull" also helps you by
 producing a default commit message documenting the branch and
@@ -1685,7 +1693,7 @@ $ git format-patch origin
 -------------------------------------------------
=20
 will produce a numbered series of files in the current directory, one
-for each patch in the current branch but not in origin/HEAD.
+for each patch in the current branch but not in origin.
=20
 You can then import these into your mail client and send them by
 hand.  However, if you have a lot to send at once, you may prefer to
@@ -1772,14 +1780,14 @@ Now, assume your personal repository is in the =
directory ~/proj.  We
 first create a new clone of the repository:
=20
 -------------------------------------------------
-$ git clone --bare proj-clone.git
+$ git clone --bare ~/proj proj.git
 -------------------------------------------------
=20
-The resulting directory proj-clone.git will contains a "bare" git
+The resulting directory proj.git will contains a "bare" git
 repository--it is just the contents of the ".git" directory, without
 a checked-out copy of a working directory.
=20
-Next, copy proj-clone.git to the server where you plan to host the
+Next, copy proj.git to the server where you plan to host the
 public repository.  You can use scp, rsync, or whatever is most
 convenient.
=20
@@ -1805,7 +1813,7 @@ adjustments to give web clients some extra inform=
ation they need:
 -------------------------------------------------
 $ mv proj.git /home/you/public_html/proj.git
 $ cd proj.git
-$ git update-server-info
+$ git --bare update-server-info
 $ chmod a+x hooks/post-update
 -------------------------------------------------
=20
@@ -1872,10 +1880,7 @@ As with git-fetch, you may also set up configura=
tion options to
 save typing; so, for example, after
=20
 -------------------------------------------------
-$ cat >.git/config <<EOF
-[remote "public-repo"]
-	url =3D ssh://yourserver.com/~you/proj.git
-EOF
+$ git config remote."public-repo".url ssh://yourserver.com/~you/proj.g=
it
 -------------------------------------------------
=20
 you should be able to perform the above push with just
@@ -1884,9 +1889,8 @@ you should be able to perform the above push with=
 just
 $ git push public-repo master
 -------------------------------------------------
=20
-See the explanations of the remote.<name>.url, branch.<name>.remote,
-and remote.<name>.push options in gitlink:git-config[1] for
-details.
+See the explanations of the remote.<name>.url and remote.<name>.push
+options in gitlink:git-config[1] for details.
=20
 Setting up a shared repository
 ------------------------------
@@ -1904,6 +1908,14 @@ The gitweb cgi script provides users an easy way=
 to browse your
 project's files and history without having to install git; see the fil=
e
 gitweb/INSTALL in the git source tree for instructions on setting it u=
p.
=20
+You can also instantly browse your working repository in gitweb using:
+
+-------------------------------------------------
+$ git instaweb
+-------------------------------------------------
+
+See gitlink:git-instaweb[1] for details.
+
 Examples
 --------
=20
@@ -2242,9 +2254,15 @@ descendant of the old head, you may force the up=
date with:
 $ git fetch git://example.com/proj.git +master:refs/remotes/example/ma=
ster
 -------------------------------------------------
=20
-Note the addition of the "+" sign.  Be aware that commits that the
-old version of example/master pointed at may be lost, as we saw in
-the previous section.
+Note the addition of the "+" sign, or add the "-f" flag to force all
+the fetched branches:
+
+-------------------------------------------------
+$ git fetch -f origin
+-------------------------------------------------
+
+Be aware that commits that the old version of example/master pointed
+at may be lost, as we saw in the previous section.
=20
 Configuring remote branches
 ---------------------------
@@ -2291,7 +2309,6 @@ then the following commands will all do the same =
thing:
 -------------------------------------------------
 $ git fetch git://example.com/proj.git master:ref/remotes/example/mast=
er
 $ git fetch example master:ref/remotes/example/master
-$ git fetch example example/master
 $ git fetch example
 -------------------------------------------------
=20
@@ -2328,7 +2345,7 @@ approximated by the SHA1 hash of the object itsel=
f.  Objects may refer
 to other objects (by referencing their SHA1 hash), and so you can
 build up a hierarchy of objects.
=20
-All objects have a statically determined "type" aka "tag", which is
+All objects have a statically determined "type", which is
 determined at object creation time, and which identifies the format of
 the object (i.e. how it is used, and how it can refer to other
 objects).  There are currently four different object types: "blob",
@@ -2351,7 +2368,7 @@ the time of the commit). In addition, a "commit" =
refers to one or more
 that directory hierarchy.
=20
 As a special case, a commit object with no parents is called the "root=
"
-object, and is the point of an initial project commit.  Each project
+commit, and is the point of an initial project commit.  Each project
 must have at least one root, and while you can tie several different
 root objects together into one project by creating a commit object whi=
ch
 has two or more separate roots as its ultimate parents, that's probabl=
y
@@ -2386,8 +2403,6 @@ the `git-fsck` program, which generates a full de=
pendency graph
 of all objects, and verifies their internal consistency (in addition
 to just verifying their superficial consistency through the hash).
=20
-The object types in some more detail:
-
 Blob Object
 -----------
=20
@@ -2459,7 +2474,8 @@ doesn't just describe the physical state of a tre=
e, it describes how
 we got there, and why.
=20
 A "commit" is defined by the tree-object that it results in, the
-parent commits (zero, one or more) that led up to that point, and a
+parent commits (zero, one or more) that led up to that point, the
+author, the date, the committer, the commit date and a
 comment on what happened.  Again, a commit is not trusted per se:
 the contents are well-defined and "safe" due to the cryptographically
 strong signatures at all levels, but there is no reason to believe
@@ -2467,7 +2483,7 @@ that the tree is "good" or that the merge informa=
tion makes sense.
 The parents do not have to actually have any relationship with the
 result, for example.
=20
-Note on commits: unlike real SCM's, commits do not contain
+Note on commits: unlike some SCM's, commits do not contain
 rename information or file mode change information.  All of that is
 implicit in the trees involved (the result tree, and the result trees
 of the parents), and describing that makes no sense in this idiotic
@@ -2531,7 +2547,7 @@ The "index" aka "Current Directory Cache"
 -----------------------------------------
=20
 The index is a simple binary file, which contains an efficient
-representation of a virtual directory content at some random time.  It
+representation of a virtual directory content.  It
 does so by a simple array that associates a set of names, dates,
 permissions and content (aka "blob") objects together.  The cache is
 always kept ordered by name, and names are unique (with a few very
@@ -2826,7 +2842,7 @@ since the tree object information is always the f=
irst line in a commit
 object.
=20
 Once you know the three trees you are going to merge (the one "origina=
l"
-tree, aka the common case, and the two "result" trees, aka the branche=
s
+tree, aka the common tree, and the two "result" trees, aka the branche=
s
 you want to merge), you do a "merge" read into the index. This will
 complain if it has to throw away your old index contents, so you shoul=
d
 make sure that you've committed those - in fact you would normally
@@ -2840,7 +2856,7 @@ $ git-read-tree -m -u <origtree> <yourtree> <targ=
ettree>
 -------------------------------------------------
=20
 which will do all trivial merge operations for you directly in the
-index file, and you can just write the result out with
+index file and, if all went well, you can just write the result out wi=
th
 `git-write-tree`.
=20
=20
@@ -2879,14 +2895,14 @@ obviously the final outcome is what is in `HEAD=
`.  What the
 above example shows is that file `hello.c` was changed from
 `$orig` to `HEAD` and `$orig` to `$target` in a different way.
 You could resolve this by running your favorite 3-way merge
-program, e.g.  `diff3` or `merge`, on the blob objects from
+program, e.g.  `diff3`, `merge` or git's merge-file, on the blob objec=
ts from
 these three stages yourself, like this:
=20
 ------------------------------------------------
 $ git-cat-file blob 263414f... >hello.c~1
 $ git-cat-file blob 06fa6a2... >hello.c~2
 $ git-cat-file blob cc44c73... >hello.c~3
-$ merge hello.c~2 hello.c~1 hello.c~3
+$ git merge-file merge hello.c~2 hello.c~1 hello.c~3
 ------------------------------------------------
=20
 This would leave the merge result in `hello.c~2` file, along
@@ -2971,9 +2987,6 @@ $ git count-objects
 Although the object files are gone, any commands that refer to those
 objects will work exactly as they did before.
=20
-The gitlink:git-gc[1] command performs packing, pruning, and more for
-you, so is normally the only high-level command you need.
-
 [[dangling-objects]]
 Dangling objects
 ----------------
--=20
1.5.1.1.925.ge85c
