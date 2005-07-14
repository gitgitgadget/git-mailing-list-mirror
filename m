From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] apply: match documentation, usage string and code.
Date: Wed, 13 Jul 2005 20:28:55 -0700
Message-ID: <7vy88ajcaw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 05:29:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsuPH-0008MT-Gq
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 05:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbVGND26 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 23:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbVGND26
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 23:28:58 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:12537 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262873AbVGND25 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 23:28:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050714032855.YUUW22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 13 Jul 2005 23:28:55 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The more recent --apply option was not described.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/git-apply.txt |   28 ++++++++++++++++------------
 apply.c                     |    4 +++-
 2 files changed, 19 insertions(+), 13 deletions(-)

ace792c165ec274a18cedbdc78affea4d87d6c76
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -9,8 +9,7 @@ git-apply - Apply patch on a GIT index f
 
 SYNOPSIS
 --------
-'git-apply' [--no-merge] [--stat] [--summary] [--check]
-[--index] [--show-files] [-] [<file>...]
+'git-apply' [--no-merge] [--stat] [--summary] [--check] [--index] [--show-files] [--apply] [<patch>...]
 
 DESCRIPTION
 -----------
@@ -19,31 +18,29 @@ and a work tree.
 
 OPTIONS
 -------
-<file>...::
-	The files to read patch from.
-
--::
-	Instead of reading from a file, read from standard input.
+<patch>...::
+	The files to read patch from.  '-' can be used to read
+	from the standard input.
 
 --no-merge::
 	The default mode of operation is the merge behaviour
-	which is not quite implemented yet.  This flag
-	explicitly tells the program not to use the merge
-	behaviour.
+	which is not implemented yet.  This flag explicitly
+	tells the program not to use the merge behaviour.
 
 --stat::
 	Instead of applying the patch, output diffstat for the
-	input.
+	input.  Turns off "apply".
 
 --summary::
 	Instead of applying the patch, output a condensed
 	summary of information obtained from git diff extended
 	headers, such as creations, renames and mode changes.
+	Turns off "apply".
 
 --check::
 	Instead of applying the patch, see if the patch is
 	applicable to the current work tree and/or the index
-	file and detects errors.
+	file and detects errors.  Turns off "apply".
 
 --index::
 	When --check is in effect, or when applying the patch
@@ -57,6 +54,13 @@ OPTIONS
 --show-files::
 	Show summary of files that are affected by the patch.
 
+--apply::
+	If you use any of the options marked ``Turns off
+	"apply"'' above, git-apply reads and outputs the
+	information you asked without actually applying the
+	patch.  Give this flag after those flags to also apply
+	the patch.
+
 
 Author
 ------
diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -32,7 +32,8 @@ static int summary = 0;
 static int check = 0;
 static int apply = 1;
 static int show_files = 0;
-static const char apply_usage[] = "git-apply [--stat] [--summary] [--check] [--show-files] <patch>";
+static const char apply_usage[] =
+"git-apply [--no-merge] [--stat] [--summary] [--check] [--index] [--apply] [--show-files] <patch>...";
 
 /*
  * For "diff-stat" like behaviour, we keep track of the biggest change
@@ -1424,6 +1425,7 @@ int main(int argc, char **argv)
 			read_stdin = 0;
 			continue;
 		}
+		/* NEEDSWORK: this does not do anything at this moment. */
 		if (!strcmp(arg, "--no-merge")) {
 			merge_patch = 0;
 			continue;
