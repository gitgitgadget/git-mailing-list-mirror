From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 5/5] builtin/commit.c: reduce scope of variables
Date: Wed, 29 Jan 2014 05:48:31 -0800
Message-ID: <1391003311-11126-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 29 14:48:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8VVQ-0006aU-Bw
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 14:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbaA2Nsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 08:48:36 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:61796 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbaA2Nsf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 08:48:35 -0500
Received: by mail-pa0-f48.google.com with SMTP id kx10so1779209pab.35
        for <git@vger.kernel.org>; Wed, 29 Jan 2014 05:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Kzx8tnCvjW4xeM3yYfzMV1v6m+2abpxiPpB2loQHYjg=;
        b=0MHfjNAyQmJWTjagpZSKivG5oPt9fZJI5SCg74fgY6rx759RKG7EfM2606C66IM3Mu
         gKqRhKGSpAa3IKAoDjHLssizVaSmCr2P08WJqIHFz+N7RHVZb+icjv7gG1pKurkRcqWo
         6zGZmRKLdbgZiwa5B8Jaa3EH5J3o6zSa1B+3UghBWt9Pie/NMkCDl9u1t8Vjnmvewocb
         hnc49JVzwju1MY6NoKax3ig7gPl8k811TQIVsfX4AMWglmkjEEB5xpiu3+2Y4KgY8bXD
         z12ZZ0HyZUf9aGi/HENjad68kh4dG/FfLF+yiGy82JmCc41tMnhGs6N8LAkO8crdonW4
         H9FQ==
X-Received: by 10.68.196.195 with SMTP id io3mr8250986pbc.6.1391003315373;
        Wed, 29 Jan 2014 05:48:35 -0800 (PST)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id xn12sm17231803pac.12.2014.01.29.05.48.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 Jan 2014 05:48:34 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241212>

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/commit.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 3767478..eea4421 100644
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
 
@@ -1576,6 +1576,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		}
 		fclose(fp);
 		strbuf_release(&m);
+		int allow_fast_forward = 1;
 		if (!stat(git_path("MERGE_MODE"), &statbuf)) {
 			if (strbuf_read_file(&sb, git_path("MERGE_MODE"), 0) < 0)
 				die_errno(_("could not read MERGE_MODE"));
-- 
1.7.10.4
