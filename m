From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 30/40] Turn builtin_exec_path into a function.
Date: Wed, 27 Feb 2008 19:54:53 +0100
Message-ID: <1204138503-6126-31-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVY-00022R-5H
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 20:00:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756555AbYB0S4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755631AbYB0S4N
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:56:13 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40457 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755649AbYB0SzL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:11 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id E1CC097600;
	Wed, 27 Feb 2008 19:55:09 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75265>

builtin_exec_path returns the hard-coded installation path, which is used
as the ultimate fallback to look for git commands. Making it into a function
enables us in a follow-up patch to return a computed value instead of just
a constant string.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 exec_cmd.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 343545d..3f3fa79 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -4,9 +4,13 @@
 #define MAX_ARGS	32
 
 extern char **environ;
-static const char *builtin_exec_path = GIT_EXEC_PATH;
 static const char *argv_exec_path;
 
+static const char *builtin_exec_path(void)
+{
+	return GIT_EXEC_PATH;
+}
+
 void git_set_argv_exec_path(const char *exec_path)
 {
 	argv_exec_path = exec_path;
@@ -26,7 +30,7 @@ const char *git_exec_path(void)
 		return env;
 	}
 
-	return builtin_exec_path;
+	return builtin_exec_path();
 }
 
 static void add_path(struct strbuf *out, const char *path)
@@ -54,7 +58,7 @@ void setup_path(const char *cmd_path)
 
 	add_path(&new_path, argv_exec_path);
 	add_path(&new_path, getenv(EXEC_PATH_ENVIRONMENT));
-	add_path(&new_path, builtin_exec_path);
+	add_path(&new_path, builtin_exec_path());
 	add_path(&new_path, cmd_path);
 
 	if (old_path)
-- 
1.5.4.1.126.ge5a7d
