From: Dieter Plaetinck <dieter@plaetinck.be>
Subject: [PATCH] git-add: allow --ignore-missing always, not just in dry run
Date: Wed, 18 Jan 2012 22:52:24 +0100
Message-ID: <1326923544-8287-1-git-send-email-dieter@plaetinck.be>
Cc: Dieter Plaetinck <dieter@plaetinck.be>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 23:15:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rndmo-0000ug-P2
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 23:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636Ab2ARWPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 17:15:11 -0500
Received: from smtp01.priorweb.be ([62.182.61.111]:59244 "EHLO
	smtp.priorweb.be" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753355Ab2ARWPK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 17:15:10 -0500
X-Greylist: delayed 1295 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Jan 2012 17:15:10 EST
Received: from [178.79.146.162] (port=50044 helo=localhost)
	by smtp.priorweb.be with esmtp (Exim 4.72)
	(envelope-from <dieter@plaetinck.be>)
	id 1RndRi-0005e0-H7; Wed, 18 Jan 2012 22:53:30 +0100
X-Mailer: git-send-email 1.7.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188767>

There is no need to restrict use of --ignore-missing to dry runs,
it can be useful to ignore missing files during normal operation as
well.

Signed-off-by: Dieter Plaetinck <dieter@plaetinck.be>
---
 Documentation/git-add.txt |    9 +++++----
 builtin/add.c             |    4 +---
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 9c1d395..c6fae9f 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -138,10 +138,11 @@ subdirectories.
 	true to make this the default behaviour.
 
 --ignore-missing::
-	This option can only be used together with --dry-run. By using
-	this option the user can check if any of the given files would
-	be ignored, no matter if they are already present in the work
-	tree or not.
+	If some files could not be added because they are missing,
+	do not raise any error but continue adding the others.
+	By using this option with --dry-run the user can check if
+	any of the given files would be ignored,
+	no matter if they are already present in the work tree or not.
 
 \--::
 	This option can be used to separate command-line options from
diff --git a/builtin/add.c b/builtin/add.c
index 1c42900..e702714 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -326,7 +326,7 @@ static struct option builtin_add_options[] = {
 	OPT_BOOLEAN('A', "all", &addremove, "add changes from all tracked and untracked files"),
 	OPT_BOOLEAN( 0 , "refresh", &refresh_only, "don't add, only refresh the index"),
 	OPT_BOOLEAN( 0 , "ignore-errors", &ignore_add_errors, "just skip files which cannot be added because of errors"),
-	OPT_BOOLEAN( 0 , "ignore-missing", &ignore_missing, "check if - even missing - files are ignored in dry run"),
+	OPT_BOOLEAN( 0 , "ignore-missing", &ignore_missing, "just skip files which do not exist"),
 	OPT_END(),
 };
 
@@ -388,8 +388,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (addremove && take_worktree_changes)
 		die(_("-A and -u are mutually incompatible"));
-	if (!show_only && ignore_missing)
-		die(_("Option --ignore-missing can only be used together with --dry-run"));
 	if ((addremove || take_worktree_changes) && !argc) {
 		static const char *here[2] = { ".", NULL };
 		argc = 1;
-- 
1.7.8.3
