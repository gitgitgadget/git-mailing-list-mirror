From: Andrew Ruder <andy@aeruder.net>
Subject: [PATCH] Add urls.txt to git-clone man page
Date: Wed, 4 Jul 2007 17:21:36 -0500
Message-ID: <20070704222136.GA13317@bowser.ruder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jul 05 00:21:44 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6DEF-00041Z-VD
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 00:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756981AbXGDWVk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 18:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756839AbXGDWVj
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 18:21:39 -0400
Received: from aeruder.net ([208.78.97.67]:47419 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756371AbXGDWVi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 18:21:38 -0400
Received: from aeruder (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id 23C9B22055C;
	Wed,  4 Jul 2007 22:21:38 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51645>

Since git-clone is one of the many commands taking
URLs to remote repositories as an argument, it should include
the URL-types list from urls.txt.

Split up urls.txt into urls.txt and urls-remotes.txt.  The latter
should be used by anything besides git-clone where a discussion of
using .git/config and .git/remotes/ to name URLs just doesn't make
as much sense.

Signed-off-by: Andrew Ruder <andy@aeruder.net>
---
 Documentation/git-clone.txt    |    7 +++-
 Documentation/git-fetch.txt    |    2 +-
 Documentation/git-pull.txt     |    2 +-
 Documentation/git-push.txt     |    2 +-
 Documentation/urls-remotes.txt |   55 ++++++++++++++++++++++++++++++++++++++++
 Documentation/urls.txt         |   54 ---------------------------------------
 6 files changed, 63 insertions(+), 59 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 4a5bab5..2f39864 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -106,8 +106,9 @@ OPTIONS
 	as patches.
 
 <repository>::
-	The (possibly remote) repository to clone from.  It can
-	be any URL git-fetch supports.
+	The (possibly remote) repository to clone from.  See the
+	<<URLS,URLS>> section below for more information on specifying
+	repositories.
 
 <directory>::
 	The name of a new directory to clone into.  The "humanish"
@@ -116,6 +117,8 @@ OPTIONS
 	for "host.xz:foo/.git").  Cloning into an existing directory
 	is not allowed.
 
+include::urls.txt[]
+
 Examples
 --------
 
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 5fbeab7..9003473 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -35,7 +35,7 @@ include::fetch-options.txt[]
 
 include::pull-fetch-param.txt[]
 
-include::urls.txt[]
+include::urls-remotes.txt[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 84693f8..e1eb2c1 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -29,7 +29,7 @@ include::fetch-options.txt[]
 
 include::pull-fetch-param.txt[]
 
-include::urls.txt[]
+include::urls-remotes.txt[]
 
 include::merge-strategies.txt[]
 
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 665f6dc..74a0da1 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -95,7 +95,7 @@ the remote repository.
 -v::
 	Run verbosely.
 
-include::urls.txt[]
+include::urls-remotes.txt[]
 
 
 Examples
diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.txt
new file mode 100644
index 0000000..5dd1f83
--- /dev/null
+++ b/Documentation/urls-remotes.txt
@@ -0,0 +1,55 @@
+include::urls.txt[]
+
+REMOTES
+-------
+
+In addition to the above, as a short-hand, the name of a
+file in `$GIT_DIR/remotes` directory can be given; the
+named file should be in the following format:
+
+------------
+	URL: one of the above URL format
+	Push: <refspec>
+	Pull: <refspec>
+
+------------
+
+Then such a short-hand is specified in place of
+<repository> without <refspec> parameters on the command
+line, <refspec> specified on `Push:` lines or `Pull:`
+lines are used for `git-push` and `git-fetch`/`git-pull`,
+respectively.  Multiple `Push:` and `Pull:` lines may
+be specified for additional branch mappings.
+
+Or, equivalently, in the `$GIT_DIR/config` (note the use
+of `fetch` instead of `Pull:`):
+
+------------
+	[remote "<remote>"]
+		url = <url>
+		push = <refspec>
+		fetch = <refspec>
+
+------------
+
+The name of a file in `$GIT_DIR/branches` directory can be
+specified as an older notation short-hand; the named
+file should contain a single line, a URL in one of the
+above formats, optionally followed by a hash `#` and the
+name of remote head (URL fragment notation).
+`$GIT_DIR/branches/<remote>` file that stores a <url>
+without the fragment is equivalent to have this in the
+corresponding file in the `$GIT_DIR/remotes/` directory.
+
+------------
+	URL: <url>
+	Pull: refs/heads/master:<remote>
+
+------------
+
+while having `<url>#<head>` is equivalent to
+
+------------
+	URL: <url>
+	Pull: refs/heads/<head>:<remote>
+------------
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 745f967..781df41 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -32,57 +32,3 @@ To sync with a local directory, use:
 ===============================================================
 - /path/to/repo.git/
 ===============================================================
-
-REMOTES
--------
-
-In addition to the above, as a short-hand, the name of a
-file in `$GIT_DIR/remotes` directory can be given; the
-named file should be in the following format:
-
-------------
-	URL: one of the above URL format
-	Push: <refspec>
-	Pull: <refspec>
-
-------------
-
-Then such a short-hand is specified in place of
-<repository> without <refspec> parameters on the command
-line, <refspec> specified on `Push:` lines or `Pull:`
-lines are used for `git-push` and `git-fetch`/`git-pull`,
-respectively.  Multiple `Push:` and `Pull:` lines may
-be specified for additional branch mappings.
-
-Or, equivalently, in the `$GIT_DIR/config` (note the use
-of `fetch` instead of `Pull:`):
-
-------------
-	[remote "<remote>"]
-		url = <url>
-		push = <refspec>
-		fetch = <refspec>
-
-------------
-
-The name of a file in `$GIT_DIR/branches` directory can be
-specified as an older notation short-hand; the named
-file should contain a single line, a URL in one of the
-above formats, optionally followed by a hash `#` and the
-name of remote head (URL fragment notation).
-`$GIT_DIR/branches/<remote>` file that stores a <url>
-without the fragment is equivalent to have this in the
-corresponding file in the `$GIT_DIR/remotes/` directory.
-
-------------
-	URL: <url>
-	Pull: refs/heads/master:<remote>
-
-------------
-
-while having `<url>#<head>` is equivalent to
-
-------------
-	URL: <url>
-	Pull: refs/heads/<head>:<remote>
-------------
-- 
1.5.3.rc0.13.gc37c
