From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Documentation: send/receive.
Date: Thu, 14 Jul 2005 00:10:05 -0700
Message-ID: <7vzmspj22a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 09:10:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsxrN-0004HT-NZ
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 09:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262935AbVGNHKJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 03:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262936AbVGNHKJ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 03:10:09 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:21893 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262935AbVGNHKH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 03:10:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050714071006.JPIV7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 14 Jul 2005 03:10:06 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds documentation for 'smarter push' family of commands.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/git-receive-pack.txt |   41 ++++++++++++++++++++++++++++++++
 Documentation/git-send-pack.txt    |   46 ++++++++++++++++++++++++++++++++++++
 send-pack.c                        |    3 ++
 3 files changed, 89 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/git-receive-pack.txt
 create mode 100644 Documentation/git-send-pack.txt

1cf367fc165560b68a51b6ce4cc91d809cf09c99
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-receive-pack.txt
@@ -0,0 +1,41 @@
+git-receive-pack(1)
+===================
+v0.1, July 2005
+
+NAME
+----
+git-receive-pack - Receive what is pushed into it
+
+
+SYNOPSIS
+--------
+'git-receive-pack' <directory>
+
+DESCRIPTION
+-----------
+Invoked by 'git-send-pack' and updates the repository with the
+information fed from the remote end.
+
+This command is usually not invoked directly by the end user.
+The UI for the protocol is on the 'git-send-pack' side, and the
+program pair is meant to be used to push updates to remote
+repository.  For pull operations, see 'git-fetch-pack' and
+'git-clone-pack'.
+
+
+OPTIONS
+-------
+<directory>::
+	The repository to sync into.
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by Junio C Hamano.
+
+GIT
+---
+Part of the link:git.html[git] suite
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-send-pack.txt
@@ -0,0 +1,46 @@
+git-send-pack(1)
+================
+v0.1, July 2005
+
+NAME
+----
+git-send-pack - Push missing objects packed.
+
+
+SYNOPSIS
+--------
+'git-send-pack' [--exec=<git-receive-pack>] [<host>:]<directory> [<head>...]
+
+DESCRIPTION
+-----------
+Invokes 'git-receive-pack' on a possibly remote repository, and
+updates it from the current repository, sending named heads.
+
+
+OPTIONS
+-------
+--exec=<git-receive-pack>::
+	Path to the 'git-receive-pack' program on the remote
+	end.  Sometimes useful when pushing to a remote
+	repository over ssh, and you do not have the program in
+	a directory on the default $PATH.
+
+<host>::
+	A remote host to house the repository.  When this
+	part is specified, 'git-receive-pack' is invoked via
+	ssh.
+
+<directory>::
+	The repository to update.
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by Junio C Hamano.
+
+GIT
+---
+Part of the link:git.html[git] suite
diff --git a/send-pack.c b/send-pack.c
--- a/send-pack.c
+++ b/send-pack.c
@@ -2,7 +2,8 @@
 #include "refs.h"
 #include "pkt-line.h"
 
-static const char send_pack_usage[] = "git-send-pack [--exec=other] destination [heads]*";
+static const char send_pack_usage[] =
+"git-send-pack [--exec=git-receive-pack] [host:]directory [heads]*";
 static const char *exec = "git-receive-pack";
 
 struct ref {
