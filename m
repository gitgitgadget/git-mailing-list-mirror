From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Documentation: update tutorial to talk about push.
Date: Fri, 15 Jul 2005 00:59:34 -0700
Message-ID: <7vzmsots7t.fsf@assigned-by-dhcp.cox.net>
References: <7vbr55kgq2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 15 09:59:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtL6j-0006JZ-46
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 09:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263234AbVGOH7h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jul 2005 03:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263236AbVGOH7h
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jul 2005 03:59:37 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:53931 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S263234AbVGOH7g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2005 03:59:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050715075934.DNTJ7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 15 Jul 2005 03:59:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vbr55kgq2.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu, 14 Jul 2005 00:08:05 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Talk about publishing to a public repository.  Also fixes a
couple of typos.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
*** To be consistent with the rest of the text, I said "I" push
*** to master.kernel.org, but obviously I am lying there ;-).  I
*** do not know if your changes enters the public repo starting
*** at master.kernel.org, nor you would particularly want to
*** publicize how it actually works in the documentation.  I
*** just tried giving readers realistic enough feel, but I
*** welcome editorial fixes.

 Documentation/tutorial.txt |   87 ++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 80 insertions(+), 7 deletions(-)

37a26024be1ec6b5ea04ecf109fd149fb6984fe8
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -480,9 +480,10 @@ This has two implications: 
    history outside of the project you created.
 
  - if you want to move or duplicate a git archive, you can do so. There
-   is no "git clone" command: if you want to create a copy of your
-   archive (with all the full history that went along with it), you can
-   do so with a regular "cp -a git-tutorial new-git-tutorial".
+   is "git clone" command, but if all you want to do is just to
+   create a copy of your archive (with all the full history that
+   went along with it), you can do so with a regular
+   "cp -a git-tutorial new-git-tutorial".
 
    Note that when you've moved or copied a git archive, your git index
    file (which caches various information, notably some of the "stat"
@@ -534,7 +535,7 @@ create your own copy of the git reposito
 
 	mkdir my-git
 	cd my-git
-	rsync -rL rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git/ .git
+	rsync -rL rsync://rsync.kernel.org/pub/scm/git/git.git/ my-git .git
 
 followed by 
 
@@ -549,14 +550,14 @@ those, you'd check them out with
 
 where the "-u" flag means that you want the checkout to keep the index
 up-to-date (so that you don't have to refresh it afterward), and the
-"-a" file means "check out all files" (if you have a stale copy or an
+"-a" flag means "check out all files" (if you have a stale copy or an
 older version of a checked out tree you may also need to add the "-f"
-file first, to tell git-checkout-cache to _force_ overwriting of any old
+flag first, to tell git-checkout-cache to _force_ overwriting of any old
 files). 
 
 Again, this can all be simplified with
 
-	git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git/ my-git
+	git clone rsync://rsync.kernel.org/pub/scm/git/git.git/ my-git
 	cd my-git
 	git checkout
 
@@ -770,3 +771,75 @@ point, just create a private tag for it,
 name for the state at that point.
 
 [ to be continued.. cvsimports, pushing and pulling ]
+
+
+	Publishing your work
+	--------------------
+
+We already talked about using somebody else's work from a remote
+repository, in the "merging external work" section.  It involved
+fetching the work from a remote repository; but how would _you_
+prepare a repository so that other people can fetch from it?
+
+Your real work happens in your working directory with your
+primary repository hanging under it as its ".git" subdirectory.
+You _could_ make it accessible remotely and ask people to pull
+from it, but in practice that is not the way things are usually
+done.  A recommended way is to have a public repository, make it
+reachable by other people, and when the changes you made in your
+primary working directory are in good shape, update the public
+repository with it.
+
+[ Side note: this public repository could further be mirrored,
+  and that is how kernel.org git repositories are done.  ]
+
+Publishing the changes from your private repository to your
+public repository requires you to have write privilege on the
+machine that hosts your public repository, and it is internally
+done via an SSH connection.
+
+First, you need to create an empty repository to push to on the
+machine that houses your public repository.  This needs to be
+done only once.
+
+Your private repository's GIT directory is usually .git, but
+often your public repository is named "<projectname>.git".
+Let's create such a public repository for project "my-git".
+After logging into the remote machine, create an empty
+directory:
+
+	mkdir my-git.git
+
+Then, initialize that directory with git-init-db, but this time,
+since it's name is not usual ".git", we do things a bit
+differently:
+
+	GIT_DIR=my-git.git git-init-db
+
+Make sure this directory is available for others you want your
+changes to be pulled by.  Also make sure that you have the
+'git-receive-pack' program on the $PATH.
+
+[ Side note: many installations of sshd does not invoke your
+  shell as the login shell when you directly run programs; what
+  this means is that if your login shell is bash, only .bashrc
+  is read bypassing .bash_profile.  As a workaround, make sure
+  .bashrc sets up $PATH so that 'git-receive-pack' program can
+  be run.  ]
+
+Your 'public repository' is ready to accept your changes.  Now,
+come back to the machine you have your private repository.  From
+there, run this command:
+
+	git push <public-host>:/path/to/my-git.git master
+
+This synchronizes your public repository to match the named
+branch head (i.e. refs/heads/master in this case) and objects
+reachable from them in your current repository.
+
+As a real example, this is how I update my public git
+repository.  Kernel.org mirror network takes care of the
+propagation to other publically visible machines:
+
+	git push master.kernel.org:/pub/scm/git/git.git/ 
+
