From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 5/5] builtin/commit.c: reduce scope of variables
Date: Thu, 30 Jan 2014 07:15:56 -0800
Message-ID: <1391094956-5507-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 30 16:16:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8tLe-0002od-GY
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 16:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbaA3PQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 10:16:05 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:58932 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750AbaA3PQE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 10:16:04 -0500
Received: by mail-pb0-f45.google.com with SMTP id un15so3216014pbc.32
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 07:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=OE7csAr3SJZ/+l8A/rh6UePXnz/TKH+PCrSeB6047xk=;
        b=Io4WzrjKzY5LeFOLlWP/tv2M+WkARSOy5PxJShP8XyhMawvEFM1UgbvoBBeS2VS/Hs
         MKcmzlOzjLw7ci5tUiDXCzC63+cEMGYlj2ShHdlqPmQvLikok6S0OF56LJwQxv8M9eFd
         jU52ddDEpjQEGzAB3Ees7f8/zRfMcYTs9/JxSxwiTOqgOfpww5g7DSaMEYFyGWIkf40q
         hIEXKu6c7QlBs3iMI0GZefTuD1rRjp6VdOpwuJ537UxeReLI8On1e8pPvJP7NLA8SnFR
         m6YRAjkZgQaE1VI+pHafAB8lL9ggliJWamZrYiZTgzVy8fzB4QXiNlskQph0Cmrd5Dx6
         kOGQ==
X-Received: by 10.68.43.2 with SMTP id s2mr14954700pbl.60.1391094963293;
        Thu, 30 Jan 2014 07:16:03 -0800 (PST)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id z10sm44062207pas.6.2014.01.30.07.16.01
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 30 Jan 2014 07:16:02 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241271>

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
This a reroll of a previous patch. Corrected the declaration
after statement issue.


 builtin/commit.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 3767478..a684296 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -307,7 +307,6 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 	int fd;
 	struct string_list partial;
 	struct pathspec pathspec;
-	char *old_index_env = NULL;
 	int refresh_flags = REFRESH_QUIET;
 
 	if (is_status)
@@ -320,6 +319,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 		die(_("index file corrupt"));
 
 	if (interactive) {
+		char *old_index_env = NULL;
 		fd = hold_locked_index(&index_lock, 1);
 
 		refresh_cache_or_die(refresh_flags);
@@ -600,12 +600,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 {
 	struct stat statbuf;
 	struct strbuf committer_ident = STRBUF_INIT;
-	int commitable, saved_color_setting;
+	int commitable;
 	struct strbuf sb = STRBUF_INIT;
-	char *buffer;
 	const char *hook_arg1 = NULL;
 	const char *hook_arg2 = NULL;
-	int ident_shown = 0;
 	int clean_message_contents = (cleanup_mode != CLEANUP_NONE);
 	int old_display_comment_prefix;
 
@@ -649,6 +647,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				  logfile);
 		hook_arg1 = "message";
 	} else if (use_message) {
+		char *buffer;
 		buffer = strstr(use_message_buffer, "\n\n");
 		if (!use_editor && (!buffer || buffer[2] == '\0'))
 			die(_("commit has empty message"));
@@ -753,6 +752,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	/* This checks if committer ident is explicitly given */
 	strbuf_addstr(&committer_ident, git_committer_info(IDENT_STRICT));
 	if (use_editor && include_status) {
+		int ident_shown = 0;
+		int saved_color_setting;
 		char *ai_tmp, *ci_tmp;
 		if (whence != FROM_COMMIT)
 			status_printf_ln(s, GIT_COLOR_NORMAL,
@@ -1510,7 +1511,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	struct ref_lock *ref_lock;
 	struct commit_list *parents = NULL, **pptr = &parents;
 	struct stat statbuf;
-	int allow_fast_forward = 1;
 	struct commit *current_head = NULL;
 	struct commit_extra_header *extra = NULL;
 
@@ -1558,6 +1558,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	} else if (whence == FROM_MERGE) {
 		struct strbuf m = STRBUF_INIT;
 		FILE *fp;
+		int allow_fast_forward = 1;
 
 		if (!reflog_msg)
 			reflog_msg = "commit (merge)";
-- 
1.7.10.4
