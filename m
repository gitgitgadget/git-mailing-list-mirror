From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Document git-ssh-pull and git-ssh-push
Date: Mon, 6 Jun 2005 22:30:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506062221261.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 04:33:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfTtN-0005Wr-20
	for gcvg-git@gmane.org; Tue, 07 Jun 2005 04:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVFGCfw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 22:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVFGCdv
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 22:33:51 -0400
Received: from iabervon.org ([66.92.72.58]:63492 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261591AbVFGCb7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2005 22:31:59 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DfTrT-0004Zl-00; Mon, 6 Jun 2005 22:30:39 -0400
To: Linus Torvalds <torvalds@osdl.org>, Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This fixes the documentation for git-ssh-push, as called by users (if you
run git-ssh-pull or git-ssh-push on one machine, the other runs on the
other machine, and they transfer data in the specified direction).

This also adds documentation for the -w option and for using filenames for
the commit-id (which does what you'd want: uses the source side's value,
not the value already on the target, even if you're running it on the
target).

It also credits me with the programs and the documentation for
git-ssh-push.

Someone who knows asciidoc should make sure I didn't mess up the
formatting. I'm only sure of the ascii part.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Index: Documentation/git-ssh-pull.txt
===================================================================
--- 8ba05dbc5815b0bc731a93d8353d36ba633d14c4/Documentation/git-ssh-pull.txt  (mode:100644 sha1:a0dade00af24d136eba436987eef083cb7cbc75e)
+++ e5b8562b2821b0d4d4f5bccb2af256f437fa7b63/Documentation/git-ssh-pull.txt  (mode:100644 sha1:3397fba8382955f232356efa5e8c6ae13e992433)
@@ -10,15 +10,21 @@
 
 SYNOPSIS
 --------
-'git-ssh-pull' [-c] [-t] [-a] [-d] [-v] [--recover] commit-id url
+'git-ssh-pull' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] commit-id url
 
 DESCRIPTION
 -----------
-Pulls from a remote repository over ssh connection, invoking git-ssh-push
-on the other end.
+Pulls from a remote repository over ssh connection, invoking
+git-ssh-push on the other end. It functions identically to
+git-ssh-push, aside from which end you run it on.
+
 
 OPTIONS
 -------
+commit-id::
+        Either the hash or the filename under [URL]/refs/ to
+        pull.
+
 -c::
 	Get the commit objects.
 -t::
@@ -34,11 +40,14 @@
 	usual, to recover after earlier pull that was interrupted.
 -v::
 	Report what is downloaded.
+-w::
+        Writes the commit-id into the filename under $GIT_DIR/refs/ on
+        the local end after the transfer is complete.
 
 
 Author
 ------
-Written by Linus Torvalds <torvalds@osdl.org>
+Written by Daniel Barkalow <barkalow@iabervon.org>
 
 Documentation
 --------------
Index: Documentation/git-ssh-push.txt
===================================================================
--- 8ba05dbc5815b0bc731a93d8353d36ba633d14c4/Documentation/git-ssh-push.txt  (mode:100644 sha1:4fe850869722d9aa5aaa5f6bb7f66a92592419eb)
+++ e5b8562b2821b0d4d4f5bccb2af256f437fa7b63/Documentation/git-ssh-push.txt  (mode:100644 sha1:c55ce7dd6f7308f5057218a8ea412ac490844cb3)
@@ -1,28 +1,53 @@
 git-ssh-push(1)
 ===============
-v0.1, May 2005
+v0.1, Jun 2005
 
 NAME
 ----
-git-ssh-push - Helper "server-side" program used by git-ssh-pull
+git-ssh-push - Pushes to a remote repository over ssh connection
 
 
 SYNOPSIS
 --------
-'git-ssh-push'
+'git-ssh-push' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] commit-id url
 
 DESCRIPTION
 -----------
-Helper "server-side" program used by git-ssh-pull.
-
+Pushes from a remote repository over ssh connection, invoking
+git-ssh-pull on the other end. It functions identically to
+git-ssh-pull, aside from which end you run it on.
+
+OPTIONS
+-------
+commit-id::
+        Either the hash or the filename under $GIT_DIR/refs/ to push.
+
+-c::
+        Get the commit objects.
+-t::
+        Get tree associated with the requested commit object.
+-a::
+        Get all the objects.
+-d::
+        Do not check for delta base objects (use this option
+        only when you know the local repository is not
+        deltified).
+--recover::
+        Check dependency of deltified object more carefully than
+        usual, to recover after earlier push that was interrupted.
+-v::
+        Report what is uploaded.
+-w::
+        Writes the commit-id into the filename under [URL]/refs/ on
+        the remote end after the transfer is complete.
 
 Author
 ------
-Written by Linus Torvalds <torvalds@osdl.org>
+Written by Daniel Barkalow <barkalow@iabervon.org>
 
 Documentation
 --------------
-Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+Documentation by Daniel Barkalow
 
 GIT
 ---

