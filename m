From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH] user-manual: reorganize public git repo discussion
Date: Thu, 17 May 2007 23:39:16 -0400
Message-ID: <20070518033916.GC30144@fieldses.org>
References: <20070518033746.GB30144@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 18 05:39:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HotJQ-0002bY-K9
	for gcvg-git@gmane.org; Fri, 18 May 2007 05:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756076AbXERDjT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 23:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760686AbXERDjT
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 23:39:19 -0400
Received: from mail.fieldses.org ([66.93.2.214]:53674 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760357AbXERDjR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 23:39:17 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HotJE-0004bC-Jg; Thu, 17 May 2007 23:39:16 -0400
Content-Disposition: inline
In-Reply-To: <20070518033746.GB30144@fieldses.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47569>


Helping a couple people set up public repos recently, I wanted to point
them at this piece of the user manual, but found it wasn't as helpful as
it could be:

	- It starts with a big explanation of why you'd want a public
	  repository, not necessary in their case since they already knew
	  why they wanted that.  So, separate that out.
	- It skimps on some of the git-daemon details, and puts the http
	  export information first.  Fix that.

Also group all the public repo subsections into a single section, and do
some miscellaneous related editing.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   90 +++++++++++++++++++++++------------------
 1 files changed, 50 insertions(+), 40 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 735fea1..f4843f4 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1674,31 +1674,30 @@ The final result will be a series of commits, one for each patch in
 the original mailbox, with authorship and commit log message each
 taken from the message containing each patch.
 
-[[setting-up-a-public-repository]]
-Setting up a public repository
-------------------------------
+[[public-repositories]]
+Public git repositories
+-----------------------
 
-Another way to submit changes to a project is to simply tell the
-maintainer of that project to pull from your repository, exactly as
-you did in the section "<<getting-updates-with-git-pull, Getting
-updates with git pull>>".
+Another way to submit changes to a project is to tell the maintainer of
+that project to pull the changes from your repository using git-pull[1].
+In the section "<<getting-updates-with-git-pull, Getting updates with
+git pull>>" we described this as a way to get updates from the "main"
+repository, but it works just as well in the other direction.
 
-If you and maintainer both have accounts on the same machine, then
-then you can just pull changes from each other's repositories
-directly; note that all of the commands (gitlink:git-clone[1],
-git-fetch[1], git-pull[1], etc.) that accept a URL as an argument
-will also accept a local directory name; so, for example, you can
-use
+If you and the maintainer both have accounts on the same machine, then
+you can just pull changes from each other's repositories directly;
+commands that accepts repository URLs as arguments will also accept a
+local directory name:
 
 -------------------------------------------------
 $ git clone /path/to/repository
 $ git pull /path/to/other/repository
 -------------------------------------------------
 
-If this sort of setup is inconvenient or impossible, another (more
-common) option is to set up a public repository on a public server.
-This also allows you to cleanly separate private work in progress
-from publicly visible work.
+However, the more common way to do this is to maintain a separate public
+repository (usually on a different host) for others to pull changes
+from.  This is usually more convenient, and allows you to cleanly
+separate private work in progress from publicly visible work.
 
 You will continue to do your day-to-day work in your personal
 repository, but periodically "push" changes from your personal
@@ -1717,32 +1716,52 @@ like this:
         |               they push             V
   their public repo <------------------- their repo
 
-Now, assume your personal repository is in the directory ~/proj.  We
-first create a new clone of the repository:
+[[setting-up-a-public-repository]]
+Setting up a public repository
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Assume your personal repository is in the directory ~/proj.  We
+first create a new clone of the repository and tell git-daemon that it
+is meant to be public:
 
 -------------------------------------------------
 $ git clone --bare ~/proj proj.git
+$ touch proj.git/git-daemon-export-ok
 -------------------------------------------------
 
 The resulting directory proj.git contains a "bare" git repository--it is
-just the contents of the ".git" directory, without a checked-out copy of
-a working directory.
+just the contents of the ".git" directory, without any files checked out
+around it.
 
 Next, copy proj.git to the server where you plan to host the
 public repository.  You can use scp, rsync, or whatever is most
 convenient.
 
-If somebody else maintains the public server, they may already have
-set up a git service for you, and you may skip to the section
+[[exporting-via-git]]
+Exporting a git repository via the git protocol
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This is the preferred method.
+
+If someone else administers the server, they should tell you what
+directory to put the repository in, and what git:// url it will appear
+at.  You can then skip to the section
 "<<pushing-changes-to-a-public-repository,Pushing changes to a public
 repository>>", below.
 
-Otherwise, the following sections explain how to export your newly
-created public repository:
+Otherwise, all you need to do is start gitlink:git-daemon[1]; it will
+listen on port 9418.  By default, it will allow access to any directory
+that looks like a git directory and contains the magic file
+git-daemon-export-ok.  Passing some directory paths as git-daemon
+arguments will further restrict the exports to those paths.
+
+You can also run git-daemon as an inetd service; see the
+gitlink:git-daemon[1] man page for details.  (See especially the
+examples section.)
 
 [[exporting-via-http]]
 Exporting a git repository via http
------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The git protocol gives better performance and reliability, but on a
 host with a web server set up, http exports may be simpler to set up.
@@ -1774,20 +1793,11 @@ link:howto/setup-git-server-over-http.txt[setup-git-server-over-http]
 for a slightly more sophisticated setup using WebDAV which also
 allows pushing over http.)
 
-[[exporting-via-git]]
-Exporting a git repository via the git protocol
------------------------------------------------
-
-This is the preferred method.
-
-For now, we refer you to the gitlink:git-daemon[1] man page for
-instructions.  (See especially the examples section.)
-
 [[pushing-changes-to-a-public-repository]]
 Pushing changes to a public repository
---------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Note that the two techniques outline above (exporting via
+Note that the two techniques outlined above (exporting via
 <<exporting-via-http,http>> or <<exporting-via-git,git>>) allow other
 maintainers to fetch your latest changes, but they do not allow write
 access, which you will need to update the public repository with the
@@ -1839,7 +1849,7 @@ details.
 
 [[setting-up-a-shared-repository]]
 Setting up a shared repository
-------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Another way to collaborate is by using a model similar to that
 commonly used in CVS, where several developers with special rights
@@ -1848,8 +1858,8 @@ link:cvs-migration.txt[git for CVS users] for instructions on how to
 set this up.
 
 [[setting-up-gitweb]]
-Allow web browsing of a repository
-----------------------------------
+Allowing web browsing of a repository
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The gitweb cgi script provides users an easy way to browse your
 project's files and history without having to install git; see the file
-- 
1.5.1.4.19.g69e2
