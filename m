From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] Add log.abbrev-commit config option
Date: Sat, 14 May 2011 13:22:38 -0400
Message-ID: <1305393758-95432-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <junio@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 19:23:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLIYO-0000nc-Hv
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 19:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684Ab1ENRWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 13:22:52 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55508 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab1ENRWr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 13:22:47 -0400
Received: by gxk21 with SMTP id 21so1173138gxk.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 10:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=jpS2AjO7nYygKJMziEwNTnEQfIJVdNcyR6HSshPoZn8=;
        b=SzCqVKaqOE/Z2SeKTcIoMfX/yf2XPzLUTqRdbJ4scbDoaxkPxNSEwAxaZUspaWLWHW
         Z5ltwffN8Beru8cy/VLkq3NtFRbhNHHliRI4QVO6NtaIiBRsZAmDEhcWurrkbbVmh3Eu
         HzhZ2pcGPNt945bwTWFXMtrkBrXyKvflAnWkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=E1zVyjfeg8FTFL3mIa5Uj+sj6yXVLyYobrcz/hWsnDHZdNJoVb7rF615SBYiebbjcr
         d5Ubq7T6+10WHWRvv7gq/5xCjb01NZ9HKV0emv0OVEHCLWHt8Jw6eCMNWukE2zPvORlw
         j2mNlRzAklyR2i1rAj0R7AESQ4QNHomNDo9gg=
Received: by 10.151.5.14 with SMTP id h14mr2257383ybi.182.1305393766662;
        Sat, 14 May 2011 10:22:46 -0700 (PDT)
Received: from localhost (cpe-071-077-014-091.nc.res.rr.com [71.77.14.91])
        by mx.google.com with ESMTPS id x14sm1773906ybg.29.2011.05.14.10.22.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 14 May 2011 10:22:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173594>

Add log.abbrev-commit (and log.abbrevCommit synonym) config option as
a convenience for users who often use --abbrev-commit with git log and
git show (but not git whatchanged, as its output is more likely to be
parsed even though it is not technically plumbing).

Allow the option to be overridden via --no-abbrev-commit.

(Also, a drive-by spelling correction in git log's short help.)

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 Documentation/config.txt  |    6 ++++++
 Documentation/git-log.txt |    3 +++
 builtin/log.c             |   17 +++++++++++++++--
 t/t4202-log.sh            |    8 ++++++++
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 285c7f73ca..85f00f6bb1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1314,6 +1314,12 @@ interactive.singlekey::
 	linkgit:git-checkout[1]. Note that this setting is silently
 	ignored if portable keystroke input is not available.
 
+log.abbrev-commit::
+log.abbrevCommit::
+	If true, act as if --abbrev-commit were specified on the command
+	line. May be overridden with --no-abbrev-commit. Note that this setting
+	is ignored by rev-list.
+
 log.date::
 	Set the default date-time mode for the 'log' command.
 	Setting a value for log.date is similar to using 'git log''s
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index de5c0d37a5..3061eec9b7 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -38,6 +38,9 @@ OPTIONS
 	Continue listing the history of a file beyond renames
 	(works only for a single file).
 
+--no-abbrev-commit::
+	Don't abbreviate commit name. Useful for overridding log.abbrevCommit.
+
 --no-decorate::
 --decorate[=short|full|no]::
 	Print out the ref names of any commits that are shown. If 'short' is
diff --git a/builtin/log.c b/builtin/log.c
index f6219909a7..cfac510b24 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -23,6 +23,7 @@
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
 
+static int default_abbrev_commit = 0;
 static int default_show_root = 1;
 static int decoration_style;
 static int decoration_given;
@@ -77,6 +78,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 		get_commit_format(fmt_pretty, rev);
 	rev->verbose_header = 1;
 	DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
+	rev->abbrev_commit = default_abbrev_commit;
 	rev->show_root_diff = default_show_root;
 	rev->subject_prefix = fmt_patch_subject_prefix;
 	DIFF_OPT_SET(&rev->diffopt, ALLOW_TEXTCONV);
@@ -89,11 +91,13 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
 	struct userformat_want w;
-	int quiet = 0, source = 0;
+	int quiet = 0, source = 0, no_abbrev_commit = 0;
 
 	const struct option builtin_log_options[] = {
-		OPT_BOOLEAN(0, "quiet", &quiet, "supress diff output"),
+		OPT_BOOLEAN(0, "quiet", &quiet, "suppress diff output"),
 		OPT_BOOLEAN(0, "source", &source, "show source"),
+		OPT_BOOLEAN(0, "no-abbrev-commit", &no_abbrev_commit,
+			    "don't abbreviate commit name"),
 		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, "decorate options",
 		  PARSE_OPT_OPTARG, decorate_callback},
 		OPT_END()
@@ -129,6 +133,9 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	if (source)
 		rev->show_source = 1;
 
+	if (no_abbrev_commit)
+		rev->abbrev_commit = 0;
+
 	/*
 	 * defeat log.decorate configuration interacting with --pretty=raw
 	 * from the command line.
@@ -323,6 +330,11 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		return git_config_string(&fmt_pretty, var, value);
 	if (!strcmp(var, "format.subjectprefix"))
 		return git_config_string(&fmt_patch_subject_prefix, var, value);
+	if (!strcasecmp(var, "log.abbrevcommit") ||
+	    !strcasecmp(var, "log.abbrev-commit")) {
+		default_abbrev_commit = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "log.date"))
 		return git_config_string(&default_date_mode, var, value);
 	if (!strcmp(var, "log.decorate")) {
@@ -347,6 +359,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	struct setup_revision_opt opt;
 
 	git_config(git_log_config, NULL);
+	default_abbrev_commit = 0;
 
 	if (diff_use_color_default == -1)
 		diff_use_color_default = git_use_color_default;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 2fcc31a6f3..83c6576feb 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -450,6 +450,14 @@ test_expect_success 'log.decorate configuration' '
 
 '
 
+test_expect_success 'log.abbrev-commit configuration' '
+	test_might_fail git config --remove-section log &&
+	git log --abbrev-commit >expect &&
+	git config log.abbrev-commit true &&
+	git log >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'show added path under "--follow -M"' '
 	# This tests for a regression introduced in v1.7.2-rc0~103^2~2
 	test_create_repo regression &&
-- 
1.7.5
