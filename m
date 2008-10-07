From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] git-push.txt: Describe --repo option in more detail
Date: Tue, 07 Oct 2008 16:26:20 +0200
Message-ID: <48EB718C.9060402@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 16:28:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnDXF-00064L-JO
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 16:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbYJGO01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 10:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbYJGO01
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 10:26:27 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:53662 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbYJGO00 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 10:26:26 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KnDW0-0007Bq-Vn; Tue, 07 Oct 2008 16:26:21 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B55DC54D; Tue,  7 Oct 2008 16:26:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97708>

From: Johannes Sixt <johannes.sixt@telecom.at>

The --repo option was described in a way that the reader would have to
assume that it is the same as the <repository> parameter. But it actually
servers a purpose, which is now written down.

Furthermore, the --mirror option was missing from the synopsis.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 I do not have the toolchain to format the documentation, so please take
 this with a grain of salt.

 -- Hannes

 Documentation/git-push.txt |   24 +++++++++++++++++++-----
 builtin-push.c             |    2 +-
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 45c9643..6150b1b 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,8 +9,8 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git push' [--all] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>]
-	   [--repo=all] [-f | --force] [-v | --verbose]
+'git push' [--all | --mirror] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>]
+	   [--repo=<repository>] [-f | --force] [-v | --verbose]
 	   [<repository> <refspec>...]

 DESCRIPTION
@@ -101,9 +101,23 @@ nor in any Push line of the corresponding remotes file---see below).
 	This flag disables the check.  This can cause the
 	remote repository to lose commits; use it with care.

---repo=<repo>::
-	When no repository is specified the command defaults to
-	"origin"; this overrides it.
+--repo=<repository>::
+	This option is only relevant if no <repository> argument is
+	passed in the invocation. In this case, 'git-push' derives the
+	remote name from the current branch: If it tracks a remote
+	branch, then that remote repository is pushed to. Otherwise,
+	the name "origin" is used. For this latter case, this option
+	can be used to override the name "origin". In other words,
+	the difference between these two commands
++
+--------------------------
+git push public         #1
+git push --repo=public  #2
+--------------------------
++
+is that #1 always pushes to "public" whereas #2 pushes to "public"
+only if the current branch does not track a remote branch. This is
+useful if you write an alias or script around 'git-push'.

 --thin::
 --no-thin::
diff --git a/builtin-push.c b/builtin-push.c
index cc6666f..122fdcf 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -10,7 +10,7 @@
 #include "parse-options.h"

 static const char * const push_usage[] = {
-	"git push [--all | --mirror] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]",
+	"git push [--all | --mirror] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [<repository> <refspec>...]",
 	NULL,
 };

-- 
1.6.0.2.651.gd07df
