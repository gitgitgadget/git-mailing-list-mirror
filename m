From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] guard config parser from value=NULL
Date: Sat,  9 Feb 2008 18:05:24 +0100
Message-ID: <12025767241532-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 18:06:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNt9M-00027k-Nl
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 18:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbYBIRF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 12:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753372AbYBIRF0
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 12:05:26 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:41578 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbYBIRFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 12:05:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 3057D680BEAA;
	Sat,  9 Feb 2008 18:05:24 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IkPNJyyV-WCG; Sat,  9 Feb 2008 18:05:24 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 10DF2680BB31; Sat,  9 Feb 2008 18:05:24 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73244>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 config.c |   10 +++++-----
 setup.c  |    2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/config.c b/config.c
index 658a11c..b2ea263 100644
--- a/config.c
+++ b/config.c
@@ -416,7 +416,7 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
-	if (!strcmp(var, "user.name")) {
+	if (value && !strcmp(var, "user.name")) {
 		strlcpy(git_default_name, value, sizeof(git_default_name));
 		return 0;
 	}
@@ -426,12 +426,12 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
-	if (!strcmp(var, "i18n.commitencoding")) {
+	if (value && !strcmp(var, "i18n.commitencoding")) {
 		git_commit_encoding = xstrdup(value);
 		return 0;
 	}
 
-	if (!strcmp(var, "i18n.logoutputencoding")) {
+	if (value && !strcmp(var, "i18n.logoutputencoding")) {
 		git_log_output_encoding = xstrdup(value);
 		return 0;
 	}
@@ -442,12 +442,12 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
-	if (!strcmp(var, "core.pager")) {
+	if (value && !strcmp(var, "core.pager")) {
 		pager_program = xstrdup(value);
 		return 0;
 	}
 
-	if (!strcmp(var, "core.editor")) {
+	if (value && !strcmp(var, "core.editor")) {
 		editor_program = xstrdup(value);
 		return 0;
 	}
diff --git a/setup.c b/setup.c
index 23c9a11..8d792dc 100644
--- a/setup.c
+++ b/setup.c
@@ -445,7 +445,7 @@ int check_repository_format_version(const char *var, const char *value)
 		is_bare_repository_cfg = git_config_bool(var, value);
 		if (is_bare_repository_cfg == 1)
 			inside_work_tree = -1;
-	} else if (strcmp(var, "core.worktree") == 0) {
+	} else if (value && strcmp(var, "core.worktree") == 0) {
 		if (git_work_tree_cfg)
 			free(git_work_tree_cfg);
 		git_work_tree_cfg = xstrdup(value);
-- 
1.5.4.gbd71f
