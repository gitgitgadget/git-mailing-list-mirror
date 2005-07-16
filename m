From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Documentation: describe short-hand used in fetch/pull.
Date: Sat, 16 Jul 2005 00:17:42 -0700
Message-ID: <7vacknnrs9.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vbr55kgq2.fsf@assigned-by-dhcp.cox.net>
	<7vzmsots7t.fsf@assigned-by-dhcp.cox.net>
	<7voe93rbmu.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507151529590.19183@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 16 09:18:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dtgvm-0007So-Cv
	for gcvg-git@gmane.org; Sat, 16 Jul 2005 09:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbVGPHRp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 03:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVGPHRp
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 03:17:45 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:50084 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S263354AbVGPHRo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2005 03:17:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050716071743.ULUD1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Jul 2005 03:17:43 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507151529590.19183@g5.osdl.org> (Linus Torvalds's message of "Fri, 15 Jul 2005 15:42:42 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Describe short-hand for remote repository used in fetch/pull.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/git-fetch-script.txt |   47 ++++++++++++++++++++++++++++++++++++
 Documentation/git-pull-script.txt  |   16 ++++++++----
 Documentation/git.txt              |    9 ++++++-
 Documentation/pull-fetch-param.txt |   36 ++++++++++++++++++++++++++++
 Documentation/tutorial.txt         |   28 +++++++++++++++++++++
 5 files changed, 130 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/git-fetch-script.txt
 create mode 100644 Documentation/pull-fetch-param.txt

d4d1afc8c8e8417b8a30ecfc8f5e32be2b47c956
diff --git a/Documentation/git-fetch-script.txt b/Documentation/git-fetch-script.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-fetch-script.txt
@@ -0,0 +1,47 @@
+git-fetch-script(1)
+===================
+v0.1, July 2005
+
+NAME
+----
+git-fetch-script - Download objects and a head from another repository.
+
+
+SYNOPSIS
+--------
+'git-fetch-script' <repository> [ <head> | tag <tag> ]
+
+
+DESCRIPTION
+-----------
+Fetches a named head or a tag from another repository, along
+with the objects necessary to complete that head or tag.  The
+head to pull defaults to HEAD if unspecified.  The head or tag
+fetched from the remote repository is stored in
+$GIT_DIR/FETCH_HEAD.
+
+When a <tag> is specified, the <tag> fetched from the remote is
+also copied to the local $GIT_DIR/tags/<tag> file.  When no
+<head> nor <tag> is specified, and <repository> was specified
+with the short-hand notation (i.e. naming a file under the
+$GIT_DIR/branches directory), the head fetched from the remote
+repository is also copied to the local $GIT_DIR/heads/<repository>
+file.
+
+
+OPTIONS
+-------
+include::pull-fetch-param.txt[]
+
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org> and Junio C Hamano <junkio@cox.net>
+
+Documentation
+--------------
+Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
diff --git a/Documentation/git-pull-script.txt b/Documentation/git-pull-script.txt
--- a/Documentation/git-pull-script.txt
+++ b/Documentation/git-pull-script.txt
@@ -4,22 +4,28 @@ v0.1, May 2005
 
 NAME
 ----
-git-pull-script - Script used by Linus to pull and merge a remote repository
+git-pull-script - Pull and merge from another repository.
 
 
 SYNOPSIS
 --------
-'git-pull-script'
+'git-pull-script' <repository> [ <head> | tag <tag> ]
+
 
 DESCRIPTION
 -----------
-This script is used by Linus to pull from a remote repository and perform
-a merge.
+Runs 'git-fetch-script' with the given parameters, then
+'git-resolve-script' to merge the local HEAD and FETCH_HEAD.
+
+
+OPTIONS
+-------
+include::pull-fetch-param.txt[]
 
 
 Author
 ------
-Written by Linus Torvalds <torvalds@osdl.org>
+Written by Linus Torvalds <torvalds@osdl.org> and Junio C Hamano <junkio@cox.net>
 
 Documentation
 --------------
diff --git a/Documentation/git.txt b/Documentation/git.txt
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -121,6 +121,9 @@ The interrogate commands may create file
 touch the working file set - but in general they don't
 
 
+Synching repositories
+~~~~~~~~~~~~~~~~~~~~~
+
 link:git-clone-script.html[git-clone-script]::
 	Clones a repository into the current repository (user interface)
 
@@ -128,10 +131,14 @@ link:git-clone-pack.html[git-clone-pack]
 	Clones a repository into the current repository (engine
 	for ssh and local transport)
 
-link:git-pull-script.html[git-pull-script]::
+link:git-fetch-script.html[git-pull-script]::
 	Pull from a repote repository via various protocols
 	(user interface).
 
+link:git-pull-script.html[git-pull-script]::
+	Fetch from and merge with a repote repository via
+	various protocols (user interface).
+
 link:git-http-pull.html[git-http-pull]::
 	Downloads a remote GIT repository via HTTP
 
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/pull-fetch-param.txt
@@ -0,0 +1,36 @@
+<repository>::
+	The "remote" repository to pull from.  One of the
+	following notations can be used to name the repository
+	to pull from:
+
+		Rsync URL
+			rsync://remote.machine/path/to/repo.git/
+
+		HTTP(s) URL
+			http://remote.machine/path/to/repo.git/
+
+		GIT URL
+			git://remote.machine/path/to/repo.git/
+			remote.machine:/path/to/repo.git/
+
+		Local directory
+			/path/to/repo.git/
+
+	In addition to that, as a short-hand, the name of a file
+	in $GIT_DIR/branches directory can be specified; the
+	named file should contain a single line, a URL in one of
+	the above formats, optionally followed by a hash '#' and
+	the name of remote head.
+
+<head>::
+	The remote head name to fetch from.  That is, make the
+	objects reachable from the commit recorded in
+	$GIT_DIR/refs/heads/<head> in the remote repository
+	available locally.
+
+tag <tag>::
+	The remote head tag to fetch from.  That is, make the
+	objects reachable from the commit recorded in
+	$GIT_DIR/refs/tags/<tag> in the remote repository
+	available locally.
+
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -810,6 +810,34 @@ pull from:
   course, you will pay the price of more disk usage to hold
   multiple working trees, but disk space is cheap these days.  ]
 
+It is likely that you will be pulling from the same remote
+repository from time to time.  As a short hand, you can store
+the remote repository URL in a file under .git/branches/
+directory, like this:
+
+	mkdir -p .git/branches
+	echo rsync://kernel.org/pub/scm/git/git.git/ \
+	    >.git/branches/linus
+
+and use the filenae to "git pull" instead of the full URL.
+The contents of a file under .git/branches can even be a prefix
+of a full URL, like this:
+
+	echo rsync://kernel.org/pub/.../jgarzik/
+	        >.git/branches/jgarzik
+
+Examples.
+
+	(1) git pull linus
+	(2) git pull linus tag v0.99.1
+	(3) git pull jgarzik/netdev-2.6.git/ e100
+
+the above are equivalent to:
+
+	(1) git pull rsync://kernel.org/pub/scm/git/git.git/ HEAD
+	(2) git pull rsync://kernel.org/pub/scm/git/git.git/ tag v0.99.1
+	(3) git pull rsync://kernel.org/pub/.../jgarzik/netdev-2.6.git e100
+
 
 	Publishing your work
 	--------------------
