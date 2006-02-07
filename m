From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH 1/3] Docs: split up pull-fetch-param.txt
Date: Tue, 7 Feb 2006 03:22:44 +0000 (UTC)
Message-ID: <1139282428.ec02f402.0@fieldses.org>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 04:22:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6JR3-000744-Vt
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 04:22:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWBGDW1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 22:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbWBGDW0
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 22:22:26 -0500
Received: from mail.fieldses.org ([66.93.2.214]:8839 "EHLO puzzle.fieldses.org")
	by vger.kernel.org with ESMTP id S932447AbWBGDWY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2006 22:22:24 -0500
Received: from bfields by puzzle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1F6JPk-0004Jj-OP; Mon, 06 Feb 2006 22:21:12 -0500
To: Junio C Hamano <junkio@cox.net>
Date: Sun Feb 5 17:43:47 2006 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15680>

The push and pull man pages include a bunch of shared text from
pull-fetch-param.txt.  This simplifies maintenance somewhat, but
there's actually quite a bit of text that applies only to one or the
other.

So, separate out the push- and pull/fetch-specific text into
pull-fetch-param.txt and git-push.txt, then include the largest chunk
of common stuff (the description of protocols and url's) from
urls.txt.  That cuts some irrelevant stuff from the man pages without
making us duplicate too much.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

---

 Documentation/git-push.txt         |   27 +++++++++++
 Documentation/pull-fetch-param.txt |   86 +++---------------------------------
 Documentation/urls.txt             |   62 ++++++++++++++++++++++++++
 3 files changed, 94 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/urls.txt

be7ed0ba1dc97ad215f0785095930902597ca886
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index a0ef61d..7e9452e 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -23,7 +23,32 @@ documentation for gitlink:git-receive-pa
 
 OPTIONS
 -------
-include::pull-fetch-param.txt[]
+<repository>::
+	The "remote" repository that is destination of a push operation.
+include::urls.txt[]
+
+<refspec>::
+	The canonical format of a <refspec> parameter is
+	`+?<src>:<dst>`; that is, an optional plus `+`, followed
+	by the source ref, followed by a colon `:`, followed by
+	the destination ref.
++
+The <src> side can be an
+arbitrary "SHA1 expression" that can be used as an
+argument to `git-cat-file -t`.  E.g. `master~4` (push
+four parents before the current master head).
++
+The local ref that matches <src> is used
+to fast forward the remote ref that matches <dst>.  If
+the optional plus `+` is used, the remote ref is updated
+even if it does not result in a fast forward update.
++
+Some short-cut notations are also supported.
++
+* `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
+* A parameter <ref> without a colon is equivalent to
+  <ref>`:`<ref>, hence updates <ref> in the destination from <ref>
+  in the source.
 
 \--all::
 	Instead of naming each ref to push, specifies all refs
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 4524fee..9011ffb 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -1,68 +1,7 @@
 <repository>::
 	The "remote" repository that is the source of a fetch
-	or pull operation, or the destination of a push operation.
-	One of the following notations can be used
-	to name the remote repository:
-+
-===============================================================
-- rsync://host.xz/path/to/repo.git/
-- http://host.xz/path/to/repo.git/
-- https://host.xz/path/to/repo.git/
-- git://host.xz/path/to/repo.git/
-- git://host.xz/~user/path/to/repo.git/
-- ssh://host.xz/path/to/repo.git/
-- ssh://host.xz/~user/path/to/repo.git/
-- ssh://host.xz/~/path/to/repo.git
-===============================================================
-+
-SSH Is the default transport protocol and also supports an
-scp-like syntax.  Both syntaxes support username expansion,
-as does the native git protocol. The following three are
-identical to the last three above, respectively:
-+
-===============================================================
-- host.xz:/path/to/repo.git/
-- host.xz:~user/path/to/repo.git/
-- host.xz:path/to/repo.git
-===============================================================
-+
-To sync with a local directory, use:
-+
-===============================================================
-- /path/to/repo.git/
-===============================================================
-+
-In addition to the above, as a short-hand, the name of a
-file in `$GIT_DIR/remotes` directory can be given; the
-named file should be in the following format:
-+
-	URL: one of the above URL format
-	Push: <refspec>
-	Pull: <refspec>
-+
-When such a short-hand is specified in place of
-<repository> without <refspec> parameters on the command
-line, <refspec> specified on `Push:` lines or `Pull:`
-lines are used for `git-push` and `git-fetch`/`git-pull`,
-respectively.  Multiple `Push:` and and `Pull:` lines may
-be specified for additional branch mappings.
-+
-The name of a file in `$GIT_DIR/branches` directory can be
-specified as an older notation short-hand; the named
-file should contain a single line, a URL in one of the
-above formats, optionally followed by a hash `#` and the
-name of remote head (URL fragment notation).
-`$GIT_DIR/branches/<remote>` file that stores a <url>
-without the fragment is equivalent to have this in the
-corresponding file in the `$GIT_DIR/remotes/` directory.
-+
-	URL: <url>
-	Pull: refs/heads/master:<remote>
-+
-while having `<url>#<head>` is equivalent to
-+
-	URL: <url>
-	Pull: refs/heads/<head>:<remote>
+	or pull operation.
+include::urls.txt[]
 
 <refspec>::
 	The canonical format of a <refspec> parameter is
@@ -70,17 +9,7 @@ while having `<url>#<head>` is equivalen
 	by the source ref, followed by a colon `:`, followed by
 	the destination ref.
 +
-When used in `git-push`, the <src> side can be an
-arbitrary "SHA1 expression" that can be used as an
-argument to `git-cat-file -t`.  E.g. `master~4` (push
-four parents before the current master head).
-+
-For `git-push`, the local ref that matches <src> is used
-to fast forward the remote ref that matches <dst>.  If
-the optional plus `+` is used, the remote ref is updated
-even if it does not result in a fast forward update.
-+
-For `git-fetch` and `git-pull`, the remote ref that matches <src>
+The remote ref that matches <src>
 is fetched, and if <dst> is not empty string, the local
 ref that matches it is fast forwarded using <src>.
 Again, if the optional plus `+` is used, the local ref
@@ -135,10 +64,7 @@ is often useful.
 Some short-cut notations are also supported.
 +
 * `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`; 
-  used with pull or fetch, it requests fetching everything up to
-  the given tag.
+  it requests fetching everything up to the given tag.
 * A parameter <ref> without a colon is equivalent to
-  <ref>: when pulling/fetching, and <ref>`:`<ref> when
-  pushing.  That is, do not store it locally if
-  fetching, and update the same name if pushing.
-
+  <ref>: when pulling/fetching, so it merges <ref> into the current
+  branch without storing the remote branch anywhere locally
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
new file mode 100644
index 0000000..e027c71
--- /dev/null
+++ b/Documentation/urls.txt
@@ -0,0 +1,62 @@
+One of the following notations can be used
+to name the remote repository:
++
+===============================================================
+- rsync://host.xz/path/to/repo.git/
+- http://host.xz/path/to/repo.git/
+- https://host.xz/path/to/repo.git/
+- git://host.xz/path/to/repo.git/
+- git://host.xz/~user/path/to/repo.git/
+- ssh://host.xz/path/to/repo.git/
+- ssh://host.xz/~user/path/to/repo.git/
+- ssh://host.xz/~/path/to/repo.git
+===============================================================
++
+SSH Is the default transport protocol and also supports an
+scp-like syntax.  Both syntaxes support username expansion,
+as does the native git protocol. The following three are
+identical to the last three above, respectively:
++
+===============================================================
+- host.xz:/path/to/repo.git/
+- host.xz:~user/path/to/repo.git/
+- host.xz:path/to/repo.git
+===============================================================
++
+To sync with a local directory, use:
++
+===============================================================
+- /path/to/repo.git/
+===============================================================
++
+In addition to the above, as a short-hand, the name of a
+file in `$GIT_DIR/remotes` directory can be given; the
+named file should be in the following format:
++
+	URL: one of the above URL format
+	Push: <refspec>
+	Pull: <refspec>
++
+When such a short-hand is specified in place of
+<repository> without <refspec> parameters on the command
+line, <refspec> specified on `Push:` lines or `Pull:`
+lines are used for `git-push` and `git-fetch`/`git-pull`,
+respectively.  Multiple `Push:` and and `Pull:` lines may
+be specified for additional branch mappings.
++
+The name of a file in `$GIT_DIR/branches` directory can be
+specified as an older notation short-hand; the named
+file should contain a single line, a URL in one of the
+above formats, optionally followed by a hash `#` and the
+name of remote head (URL fragment notation).
+`$GIT_DIR/branches/<remote>` file that stores a <url>
+without the fragment is equivalent to have this in the
+corresponding file in the `$GIT_DIR/remotes/` directory.
++
+	URL: <url>
+	Pull: refs/heads/master:<remote>
++
+while having `<url>#<head>` is equivalent to
++
+	URL: <url>
+	Pull: refs/heads/<head>:<remote>
-- 
0.99.8b.g3480-dirty
