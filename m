From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-commit: Now --only semantics is the default.
Date: Mon, 13 Feb 2006 23:53:12 -0800
Message-ID: <7v7j7ytlzr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Feb 14 08:53:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8v0B-0001U2-PX
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 08:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbWBNHxP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 02:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030487AbWBNHxP
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 02:53:15 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:65431 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030423AbWBNHxN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 02:53:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060214075030.VQEZ26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Feb 2006 02:50:30 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16131>

This changes the "git commit paths..." to default to --only
semantics from traditional --include semantics, as agreed on the
list.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This will be part of the post 1.2.0 "master" updates, towards
   1.3.0 development track.

 Documentation/git-commit.txt |   17 +++++++++++------
 git-commit.sh                |    9 +++------
 2 files changed, 14 insertions(+), 12 deletions(-)

4170a19587280eeb3663a47a6fd993910de78076
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 53b64fa..214ed23 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -8,8 +8,8 @@ git-commit - Record your changes
 SYNOPSIS
 --------
 [verse]
-'git-commit' [-a] [-i] [-s] [-v] [(-c | -C) <commit> | -F <file> | -m <msg>]
-	   [-e] [--author <author>] [--] <file>...
+'git-commit' [-a] [-s] [-v] [(-c | -C) <commit> | -F <file> | -m <msg>]
+	   [-e] [--author <author>] [--] [[-i | -o ]<file>...]
 
 DESCRIPTION
 -----------
@@ -73,15 +73,20 @@ OPTIONS
 	commit the whole index.  This is the traditional
 	behaviour.
 
---::
-	Do not interpret any more arguments as options.
-
-<file>...::
+-o|--only::
 	Commit only the files specified on the command line.
 	This format cannot be used during a merge, nor when the
 	index and the latest commit does not match on the
 	specified paths to avoid confusion.
 
+--::
+	Do not interpret any more arguments as options.
+
+<file>...::
+	Files to be committed.  The meaning of these is
+	different between `--include` and `--only`.  Without
+	either, it defaults `--only` semantics.
+
 If you make a commit and then found a mistake immediately after
 that, you can recover from it with gitlink:git-reset[1].
 
diff --git a/git-commit.sh b/git-commit.sh
index 59551d9..ab5e6bc 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Linus Torvalds
 # Copyright (c) 2006 Junio C Hamano
 
-USAGE='[-a] [-i] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit>] [-e] [--author <author>] [<path>...]'
+USAGE='[-a] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit>] [-e] [--author <author>] [[-i | -o] <path>...]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 
@@ -340,11 +340,8 @@ case "$#,$also$only" in
 0,)
   ;;
 *,)
-  echo >&2 "assuming --include paths..."
-  also=t
-  # Later when switch the defaults, we will replace them with these:
-  # echo >&2 "assuming --only paths..."
-  # also=
+  echo >&2 "assuming --only paths..."
+  also=
 
   # If we are going to launch an editor, the message won't be
   # shown without this...
-- 
1.2.0.g45dc
