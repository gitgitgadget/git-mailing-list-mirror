From: Jon Loeliger <jdl@freescale.com>
Subject: [PATCH] Added a few examples to git-pull man page.
Date: Fri, 04 Nov 2005 20:36:08 -0600
Message-ID: <E1EYDua-00017o-9d@jdl.com>
X-From: git-owner@vger.kernel.org Sat Nov 05 03:37:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYDuy-0005gP-Lv
	for gcvg-git@gmane.org; Sat, 05 Nov 2005 03:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbVKECgW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 21:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbVKECgW
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 21:36:22 -0500
Received: from colo.jdl.com ([66.118.10.122]:8372 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1751022AbVKECgT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2005 21:36:19 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EYDua-00017o-9d
	for git@vger.kernel.org; Fri, 04 Nov 2005 20:36:10 -0600
To: git@vger.kernel.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11174>

Added a few examples to git-pull man page.
Clarified and added notes for pull/push refspecs.
Converted to back-ticks for literal text examples.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

Hmmm.  Are back-ticks the standard for literal text examples?




 Documentation/git-pull.txt         |   55 ++++++++++++++++++++++++++--
 Documentation/pull-fetch-param.txt |   72 +++++++++++++++++++++++++-----------
 2 files changed, 101 insertions(+), 26 deletions(-)

applies-to: a469bc3e7efcb96db78bbffcdabcbea01bead34d
ca90ebc23d3e6fb73bc7da3e3d893adab8456722
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index cef4c0a..8f37d53 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -19,7 +19,7 @@ When only one ref is downloaded, runs 'g
 into the local HEAD.  Otherwise uses 'git octopus' to merge them
 into the local HEAD.
 
-Note that you can use '.' (current directory) as the
+Note that you can use `.` (current directory) as the
 <repository> to pull from the local repository -- this is useful
 when merging local branches into the current branch.
 
@@ -29,8 +29,57 @@ include::pull-fetch-param.txt[]
 
 -a, \--append::
 	Append ref names and object names of fetched refs to the
-	existing contents of $GIT_DIR/FETCH_HEAD.  Without this
-	option old data in $GIT_DIR/FETCH_HEAD will be overwritten.
+	existing contents of `$GIT_DIR/FETCH_HEAD`.  Without this
+	option old data in `$GIT_DIR/FETCH_HEAD` will be overwritten.
+
+Examples
+--------
+Command line pull of multiple branches from one repository::
++
+------------------------------------------------
+$ cat .git/remotes/origin
+URL: rsync://rsync.kernel.org/pub/scm/git/git.git
+Pull: master:origin
+
+$ git checkout master
+$ git fetch origin master:origin +pu:pu maint:maint
+$ git pull . origin
+------------------------------------------------
++
+Here, a typical `$GIT_DIR/remotes/origin` file from a
+`git-clone` operation is used in combination with
+command line options to `git-fetch` to first update
+multiple branches of the local repository and then
+to merge the remote `origin` branch into the local
+`master` branch.  The local `pu` branch is updated
+even if it does not result in a fast forward update.
+Here, the pull can obtain its objects from the local
+repository using `.`, as the previous `git-fetch` is
+known to have already obtained and made available
+all the necessary objects.
+
+
+Pull of multiple branches from one repository using `$GIT_DIR/remotes` file::
++
+------------------------------------------------
+$ cat .git/remotes/origin
+URL: rsync://rsync.kernel.org/pub/scm/git/git.git
+Pull: master:origin
+Pull: +pu:pu
+Pull: maint:maint
+
+$ git checkout master
+$ git pull origin
+------------------------------------------------
++
+Here, a typical `$GIT_DIR/remotes/origin` file from a
+`git-clone` operation has been hand-modified to include
+the branch-mapping of additional remote and local
+heads directly.  A single `git-pull` operation while
+in the `master` branch will fetch multiple heads and
+merge the remote `origin` head into the current,
+local `master` branch.
+
 
 Author
 ------
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index e8db9d7..2a71318 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -1,7 +1,8 @@
 <repository>::
-	The "remote" repository to pull from.  One of the
-	following notations can be used to name the repository
-	to pull from:
+	The "remote" repository that is the source of a fetch
+	or pull operation, or the destination of a push operation.
+	One of the following notations can be used
+	to name the remote repository:
 +
 ===============================================================
 - Rsync URL:		rsync://remote.machine/path/to/repo.git/
@@ -12,7 +13,7 @@
 ===============================================================
 +
 In addition to the above, as a short-hand, the name of a
-file in $GIT_DIR/remotes directory can be given; the
+file in `$GIT_DIR/remotes` directory can be given; the
 named file should be in the following format:
 +
 	URL: one of the above URL format
@@ -21,57 +22,82 @@ named file should be in the following fo
 +
 When such a short-hand is specified in place of
 <repository> without <refspec> parameters on the command
-line, <refspec>... specified on Push lines or Pull lines
-are used for "git push" and "git fetch/pull",
-respectively.
+line, <refspec>... specified on `Push:` lines or `Pull:`
+lines are used for `git-push` and `git-fetch`/`git-pull`,
+respectively.  Multiple `Push:` and and `Pull:` lines may
+be specified for additional branch mappings.
 +
-The name of a file in $GIT_DIR/branches directory can be
+The name of a file in `$GIT_DIR/branches` directory can be
 specified as an older notation short-hand; the named
 file should contain a single line, a URL in one of the
-above formats, optionally followed by a hash '#' and the
+above formats, optionally followed by a hash `#` and the
 name of remote head (URL fragment notation).
-$GIT_DIR/branches/<remote> file that stores a <url>
+`$GIT_DIR/branches/<remote>` file that stores a <url>
 without the fragment is equivalent to have this in the
-corresponding file in the $GIT_DIR/remotes/ directory
+corresponding file in the `$GIT_DIR/remotes/` directory.
 +
 	URL: <url>
 	Pull: refs/heads/master:<remote>
 +
-while having <url>#<head> is equivalent to
+while having `<url>#<head>` is equivalent to
 +
 	URL: <url>
 	Pull: refs/heads/<head>:<remote>
 
 <refspec>::
 	The canonical format of a <refspec> parameter is
-	'+?<src>:<dst>'; that is, an optional plus '+', followed
-	by the source ref, followed by a colon ':', followed by
+	`+?<src>:<dst>`; that is, an optional plus `+`, followed
+	by the source ref, followed by a colon `:`, followed by
 	the destination ref.
 +
-When used in "git push", the <src> side can be an
+When used in `git-push`, the <src> side can be an
 arbitrary "SHA1 expression" that can be used as an
-argument to "git-cat-file -t".  E.g. "master~4" (push
+argument to `git-cat-file -t`.  E.g. `master~4` (push
 four parents before the current master head).
 +
-For "git push", the local ref that matches <src> is used
+For `git-push`, the local ref that matches <src> is used
 to fast forward the remote ref that matches <dst>.  If
-the optional plus '+' is used, the remote ref is updated
+the optional plus `+` is used, the remote ref is updated
 even if it does not result in a fast forward update.
 +
-For "git fetch/pull", the remote ref that matches <src>
+For `git-fetch` and `git-pull`, the remote ref that matches <src>
 is fetched, and if <dst> is not empty string, the local
 ref that matches it is fast forwarded using <src>.
-Again, if the optional plus '+' is used, the local ref
+Again, if the optional plus `+` is used, the local ref
 is updated even if it does not result in a fast forward
 update.
 +
+[NOTE]
+If the remote branch from which you want to pull is
+modified in non-linear ways such as being rewound and
+rebased frequently, then a pull will attempt a merge with
+an older version of itself, likely conflict, and fail.
+It is under these conditions that you would want to use
+the `+` sign to indicate non-fast-forward updates will
+be needed.  There is currently no easy way to determine
+or declare that a branch will be made available in a
+repository with this behavior; the pulling user simply
+must know this is the expected usage pattern for a branch.
++
+[NOTE]
+You never do your own development on branches that appear
+on the right hand side of a <refspec> colon on `Pull:` lines;
+they are to be updated by `git-fetch`.  The corollary is that
+a local branch should be introduced and named on a <refspec>
+right-hand-side if you intend to do development derived from
+that branch.
+This leads to the common `Pull: master:origin` mapping of a
+remote `master` branch to a local `origin` branch, which
+is then merged to a local development branch, again typically
+named `master`.
++
 Some short-cut notations are also supported.
 +
-* For backward compatibility, "tag" is almost ignored;
+* For backward compatibility, `tag` is almost ignored;
   it just makes the following parameter <tag> to mean a
-  refspec "refs/tags/<tag>:refs/tags/<tag>".
+  refspec `refs/tags/<tag>:refs/tags/<tag>`.
 * A parameter <ref> without a colon is equivalent to
-  <ref>: when pulling/fetching, and <ref>:<ref> when
+  <ref>: when pulling/fetching, and <ref>`:`<ref> when
   pushing.  That is, do not store it locally if
   fetching, and update the same name if pushing.
 
---
0.99.9.GIT
