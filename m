From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v4 2/7] i18n: unpack-trees: mark strings for translation
Date: Thu, 12 May 2016 19:59:23 +0000
Message-ID: <1463083168-29213-3-git-send-email-vascomalmeida@sapo.pt>
References: <1463083168-29213-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 22:00:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0wmh-0006J5-H6
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbcELUA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 16:00:27 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:58917 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750979AbcELUA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:00:26 -0400
Received: (qmail 11861 invoked from network); 12 May 2016 20:00:23 -0000
Received: (qmail 29983 invoked from network); 12 May 2016 20:00:23 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 12 May 2016 20:00:22 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1463083168-29213-1-git-send-email-vascomalmeida@sapo.pt>
In-Reply-To: <1461071964-323-1-git-send-email-vascomalmeida@sapo.pt>
References: <1461071964-323-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294444>

Mark strings seen by the user inside setup_unpack_trees_porcelain() and
display_error_msgs() functions for translation.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 unpack-trees.c | 74 ++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 20 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 11308e9..673a04e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -58,40 +58,74 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	int i;
 	const char **msgs = opts->msgs;
 	const char *msg;
-	const char *cmd2 = strcmp(cmd, "checkout") ? cmd : "switch branches";
 
-	if (advice_commit_before_merge)
-		msg = "Your local changes to the following files would be overwritten by %s:\n%%s"
-			"Please, commit your changes or stash them before you can %s.";
+	if (!strcmp(cmd, "checkout"))
+		msg = advice_commit_before_merge
+		      ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
+			  "Please, commit your changes or stash them before you can switch branches.")
+		      : _("Your local changes to the following files would be overwritten by checkout:\n%%s");
+	else if (!strcmp(cmd, "merge"))
+		msg = advice_commit_before_merge
+		      ? _("Your local changes to the following files would be overwritten by merge:\n%%s"
+			  "Please, commit your changes or stash them before you can merge.")
+		      : _("Your local changes to the following files would be overwritten by merge:\n%%s");
 	else
-		msg = "Your local changes to the following files would be overwritten by %s:\n%%s";
+		msg = advice_commit_before_merge
+		      ? _("Your local changes to the following files would be overwritten by %s:\n%%s"
+			  "Please, commit your changes or stash them before you can %s.")
+		      : _("Your local changes to the following files would be overwritten by %s:\n%%s");
 	msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOT_UPTODATE_FILE] =
-		xstrfmt(msg, cmd, cmd2);
+		xstrfmt(msg, cmd, cmd);
 
 	msgs[ERROR_NOT_UPTODATE_DIR] =
-		"Updating the following directories would lose untracked files in it:\n%s";
-
-	if (advice_commit_before_merge)
-		msg = "The following untracked working tree files would be %s by %s:\n%%s"
-			"Please move or remove them before you can %s.";
+		_("Updating the following directories would lose untracked files in it:\n%s");
+
+	if (!strcmp(cmd, "checkout"))
+		msg = advice_commit_before_merge
+		      ? _("The following untracked working tree files would be removed by checkout:\n%%s"
+			  "Please move or remove them before you can switch branches.")
+		      : _("The following untracked working tree files would be removed by checkout:\n%%s");
+	else if (!strcmp(cmd, "merge"))
+		msg = advice_commit_before_merge
+		      ? _("The following untracked working tree files would be removed by merge:\n%%s"
+			  "Please move or remove them before you can merge.")
+		      : _("The following untracked working tree files would be removed by merge:\n%%s");
 	else
-		msg = "The following untracked working tree files would be %s by %s:\n%%s";
-
-	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] = xstrfmt(msg, "removed", cmd, cmd2);
-	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] = xstrfmt(msg, "overwritten", cmd, cmd2);
+		msg = advice_commit_before_merge
+		      ? _("The following untracked working tree files would be removed by %s:\n%%s"
+			  "Please move or remove them before you can %s.")
+		      : _("The following untracked working tree files would be removed by %s:\n%%s");
+	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] = xstrfmt(msg, cmd, cmd);
+
+	if (!strcmp(cmd, "checkout"))
+		msg = advice_commit_before_merge
+		      ? _("The following untracked working tree files would be overwritten by checkout:\n%%s"
+			  "Please move or remove them before you can switch branches.")
+		      : _("The following untracked working tree files would be overwritten by checkout:\n%%s");
+	else if (!strcmp(cmd, "merge"))
+		msg = advice_commit_before_merge
+		      ? _("The following untracked working tree files would be overwritten by merge:\n%%s"
+			  "Please move or remove them before you can merge.")
+		      : _("The following untracked working tree files would be overwritten by merge:\n%%s");
+	else
+		msg = advice_commit_before_merge
+		      ? _("The following untracked working tree files would be overwritten by %s:\n%%s"
+			  "Please move or remove them before you can %s.")
+		      : _("The following untracked working tree files would be overwritten by %s:\n%%s");
+	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] = xstrfmt(msg, cmd, cmd);
 
 	/*
 	 * Special case: ERROR_BIND_OVERLAP refers to a pair of paths, we
 	 * cannot easily display it as a list.
 	 */
-	msgs[ERROR_BIND_OVERLAP] = "Entry '%s' overlaps with '%s'.  Cannot bind.";
+	msgs[ERROR_BIND_OVERLAP] = _("Entry '%s' overlaps with '%s'.  Cannot bind.");
 
 	msgs[ERROR_SPARSE_NOT_UPTODATE_FILE] =
-		"Cannot update sparse checkout: the following entries are not up-to-date:\n%s";
+		_("Cannot update sparse checkout: the following entries are not up-to-date:\n%s");
 	msgs[ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN] =
-		"The following Working tree files would be overwritten by sparse checkout update:\n%s";
+		_("The following Working tree files would be overwritten by sparse checkout update:\n%s");
 	msgs[ERROR_WOULD_LOSE_ORPHANED_REMOVED] =
-		"The following Working tree files would be removed by sparse checkout update:\n%s";
+		_("The following Working tree files would be removed by sparse checkout update:\n%s");
 
 	opts->show_all_errors = 1;
 	/* rejected paths may not have a static buffer */
@@ -168,7 +202,7 @@ static void display_error_msgs(struct unpack_trees_options *o)
 		string_list_clear(rejects, 0);
 	}
 	if (something_displayed)
-		fprintf(stderr, "Aborting\n");
+		fprintf(stderr, _("Aborting\n"));
 }
 
 /*
-- 
2.7.3
