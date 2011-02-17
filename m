From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v3 3/4] commit.c: replace some literal strings with constants
Date: Wed, 16 Feb 2011 23:18:44 -0500
Message-ID: <1297916325-89688-4-git-send-email-jaysoffian@gmail.com>
References: <1297916325-89688-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 05:19:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpvL9-0007tY-OM
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 05:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253Ab1BQETO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 23:19:14 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63926 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091Ab1BQETI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 23:19:08 -0500
Received: by qwa26 with SMTP id 26so2060939qwa.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 20:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=8L/f/4S0YTShM6v27O3x+lCo5P3q4OuIyH/oNdjF99I=;
        b=TRZ7f59BVdirwQcfE8Wa8HIkJYuqQYS+APu5Ez7IVnwfwiTaDq4uMf193qw8lSicvI
         7pbt1TPbRABTLxJic4ecKIYrkVLrsn6iO3wWu5rbFXXg/qoxlpHUN+CxYrjklAeSF1VP
         wtKOFM07cGgTPWDVG24mr/GqOHrRimceO8NAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EnWwu6Z3kMNjbJT3uFjQwltHkaI6zLqTlXxlSSw+5GSCgAq0HpxWOvJOB6LQ7Oh6+l
         UZZI7gnj7RwJZdGJ7eu9R4/r8dQl1PkrBEeTfKdJKCLAccL4SvUBo0lmynyXcswpBcJY
         +zFIf/0Ai891ZUWs3x3jCSiSCFARSFdW3wWzQ=
Received: by 10.224.11.84 with SMTP id s20mr1862387qas.265.1297916348206;
        Wed, 16 Feb 2011 20:19:08 -0800 (PST)
Received: from localhost (cpe-071-077-014-091.nc.res.rr.com [71.77.14.91])
        by mx.google.com with ESMTPS id p13sm415282qcu.5.2011.02.16.20.19.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 20:19:07 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.30.g7fe09
In-Reply-To: <1297916325-89688-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167034>

A typo in any of these would be bad, so let's use
constants for them

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
I converted these per
http://article.gmane.org/gmane.comp.version-control.git/167015

Maybe this should be the last patch in the series; it's questionable to
me whether it's even worth doing.

 builtin/commit.c |   48 +++++++++++++++++++++++++++---------------------
 1 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0def540..5b32743 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -54,10 +54,16 @@ static const char empty_amend_advice[] =
 "it empty. You can repeat your command with --allow-empty, or you can\n"
 "remove the commit entirely with \"git reset HEAD^\".\n";
 
+static const char commit_editmsg[] = "COMMIT_EDITMSG";
+static const char cherry_pick_head[] = "CHERRY_PICK_HEAD";
+static const char merge_head[] = "MERGE_HEAD";
+static const char merge_msg[] = "MERGE_MSG";
+static const char merge_mode[] = "MERGE_MODE";
+static const char squash_msg[] = "SQUASH_MSG";
+
 static unsigned char head_sha1[20];
 
 static char *use_message_buffer;
-static const char commit_editmsg[] = "COMMIT_EDITMSG";
 static struct lock_file index_lock; /* real index */
 static struct lock_file false_lock; /* used only for partial commits */
 static enum {
@@ -626,13 +632,13 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		format_commit_message(commit, "fixup! %s\n\n",
 				      &sb, &ctx);
 		hook_arg1 = "message";
-	} else if (!stat(git_path("MERGE_MSG"), &statbuf)) {
-		if (strbuf_read_file(&sb, git_path("MERGE_MSG"), 0) < 0)
-			die_errno("could not read MERGE_MSG");
+	} else if (!stat(git_path(merge_msg), &statbuf)) {
+		if (strbuf_read_file(&sb, git_path(merge_msg), 0) < 0)
+			die_errno("could not read %s", merge_msg);
 		hook_arg1 = "merge";
-	} else if (!stat(git_path("SQUASH_MSG"), &statbuf)) {
-		if (strbuf_read_file(&sb, git_path("SQUASH_MSG"), 0) < 0)
-			die_errno("could not read SQUASH_MSG");
+	} else if (!stat(git_path(squash_msg), &statbuf)) {
+		if (strbuf_read_file(&sb, git_path(squash_msg), 0) < 0)
+			die_errno("could not read %s", squash_msg);
 		hook_arg1 = "squash";
 	} else if (template_file && !stat(template_file, &statbuf)) {
 		if (strbuf_read_file(&sb, template_file, 0) < 0)
@@ -702,7 +708,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				"#	%s\n"
 				"# and try again.\n"
 				"#\n",
-				git_path("MERGE_HEAD"));
+				git_path(merge_head));
 
 		fprintf(fp,
 			"\n"
@@ -1117,7 +1123,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	wt_status_prepare(&s);
 	gitmodules_config();
 	git_config(git_status_config, &s);
-	in_merge = file_exists(git_path("MERGE_HEAD"));
+	in_merge = file_exists(git_path(merge_head));
 	argc = parse_options(argc, argv, prefix,
 			     builtin_status_options,
 			     builtin_status_usage, 0);
@@ -1302,7 +1308,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	wt_status_prepare(&s);
 	git_config(git_commit_config, &s);
-	in_merge = file_exists(git_path("MERGE_HEAD"));
+	in_merge = file_exists(git_path(merge_head));
 	s.in_merge = in_merge;
 
 	if (s.use_color == -1)
@@ -1347,21 +1353,21 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		if (!reflog_msg)
 			reflog_msg = "commit (merge)";
 		pptr = &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
-		fp = fopen(git_path("MERGE_HEAD"), "r");
+		fp = fopen(git_path(merge_head), "r");
 		if (fp == NULL)
 			die_errno("could not open '%s' for reading",
-				  git_path("MERGE_HEAD"));
+				  git_path(merge_head));
 		while (strbuf_getline(&m, fp, '\n') != EOF) {
 			unsigned char sha1[20];
 			if (get_sha1_hex(m.buf, sha1) < 0)
-				die("Corrupt MERGE_HEAD file (%s)", m.buf);
+				die("Corrupt %s file (%s)", merge_head, m.buf);
 			pptr = &commit_list_insert(lookup_commit(sha1), pptr)->next;
 		}
 		fclose(fp);
 		strbuf_release(&m);
-		if (!stat(git_path("MERGE_MODE"), &statbuf)) {
-			if (strbuf_read_file(&sb, git_path("MERGE_MODE"), 0) < 0)
-				die_errno("could not read MERGE_MODE");
+		if (!stat(git_path(merge_mode), &statbuf)) {
+			if (strbuf_read_file(&sb, git_path(merge_mode), 0) < 0)
+				die_errno("could not read %s", merge_mode);
 			if (!strcmp(sb.buf, "no-ff"))
 				allow_fast_forward = 0;
 		}
@@ -1424,11 +1430,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		die("cannot update HEAD ref");
 	}
 
-	unlink(git_path("CHERRY_PICK_HEAD"));
-	unlink(git_path("MERGE_HEAD"));
-	unlink(git_path("MERGE_MSG"));
-	unlink(git_path("MERGE_MODE"));
-	unlink(git_path("SQUASH_MSG"));
+	unlink(git_path(cherry_pick_head));
+	unlink(git_path(merge_head));
+	unlink(git_path(merge_msg));
+	unlink(git_path(merge_mode));
+	unlink(git_path(squash_msg));
 
 	if (commit_index_files())
 		die ("Repository has been updated, but unable to write\n"
-- 
1.7.4.1.30.g7fe09
