From: Luke Dashjr <luke-jr+git@utopios.org>
Subject: [PATCH 1/5] port --ignore-unmatch to "git add"
Date: Wed, 12 Aug 2009 22:20:20 -0500
Message-ID: <1250133624-2272-1-git-send-email-luke-jr+git@utopios.org>
References: <200908121726.52121.luke-jr@utopios.org>
Cc: Luke Dashjr <luke-jr+git@utopios.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 05:20:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbQrx-0007Ge-JE
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 05:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbZHMDUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 23:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752309AbZHMDUi
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 23:20:38 -0400
Received: from unused ([66.216.20.21]:45437 "EHLO zinan.dashjr.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752200AbZHMDUi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 23:20:38 -0400
Received: from tsuruki (ip70-187-26-118.om.om.cox.net [70.187.26.118])
	by zinan.dashjr.org (Postfix) with SMTP id 1123CB9DB7C;
	Thu, 13 Aug 2009 03:20:38 +0000 (UTC)
Received: by tsuruki (sSMTP sendmail emulation); Wed, 12 Aug 2009 22:20:37 -0500
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <200908121726.52121.luke-jr@utopios.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125768>

"git rm" has a --ignore-unmatch option that is also applicable to "git add"
and may be useful for persons wanting to ignore unmatched arguments, but not
all errors.

Signed-off-by: Luke Dashjr <luke-jr+git@utopios.org>
---
 builtin-add.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 581a2a1..0597fb9 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -19,6 +19,7 @@ static const char * const builtin_add_usage[] = {
 };
 static int patch_interactive, add_interactive, edit_interactive;
 static int take_worktree_changes;
+static int ignore_unmatch = 0;
 
 static void fill_pathspec_matches(const char **pathspec, char *seen, int specs)
 {
@@ -63,7 +64,7 @@ static void prune_directory(struct dir_struct *dir, const char **pathspec, int p
 	fill_pathspec_matches(pathspec, seen, specs);
 
 	for (i = 0; i < specs; i++) {
-		if (!seen[i] && pathspec[i][0] && !file_exists(pathspec[i]))
+		if (!seen[i] && pathspec[i][0] && !file_exists(pathspec[i]) && !ignore_unmatch)
 			die("pathspec '%s' did not match any files",
 					pathspec[i]);
 	}
@@ -108,7 +109,7 @@ static void refresh(int verbose, const char **pathspec)
 	refresh_index(&the_index, verbose ? REFRESH_SAY_CHANGED : REFRESH_QUIET,
 		      pathspec, seen);
 	for (i = 0; i < specs; i++) {
-		if (!seen[i])
+		if (!seen[i] && !ignore_unmatch)
 			die("pathspec '%s' did not match any files", pathspec[i]);
 	}
         free(seen);
@@ -226,6 +227,8 @@ static struct option builtin_add_options[] = {
 	OPT_BOOLEAN('A', "all", &addremove, "add all, noticing removal of tracked files"),
 	OPT_BOOLEAN( 0 , "refresh", &refresh_only, "don't add, only refresh the index"),
 	OPT_BOOLEAN( 0 , "ignore-errors", &ignore_add_errors, "just skip files which cannot be added because of errors"),
+	OPT_BOOLEAN( 0 , "ignore-unmatch", &ignore_unmatch,
+				"exit with a zero status even if nothing matched"),
 	OPT_END(),
 };
 
-- 
1.6.3.3
