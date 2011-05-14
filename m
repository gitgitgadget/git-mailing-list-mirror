From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v2] Add log.abbrevCommit config variable
Date: Sat, 14 May 2011 16:47:18 -0400
Message-ID: <1305406038-36435-1-git-send-email-jaysoffian@gmail.com>
References: <20110514190122.GA16851@elie>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <junio@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 22:47:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLLkK-0003Zp-VU
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 22:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758888Ab1ENUr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 16:47:28 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47094 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614Ab1ENUr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 16:47:27 -0400
Received: by gwaa18 with SMTP id a18so1201158gwa.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 13:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=rQBeQmJEwfxYcbjoLhqxRJZS5E2N93VYzHLBPzYDYxM=;
        b=aObSqqutsgpXlloUI71RtPtDpyfSAmA81gQVR31g4vgt2CYUJIgwz2nZBZLv3uS2BM
         FsYpuyM+hxz/30Fs0xrUTYxdI4K8Qx2/HH1iWFeSBja+KDfi2TbbyQCHfuewwCHo9Aga
         LeCtWPZJEY5DVpATQkS9HS9LEBWlgjU3+DAJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CuD/8rnsgt0hYhlDIMi9RCUDVeIdJSw+f0W2k5Td8jdiVfNI6IbE7pUlZO8a1VPHGg
         IHDDk6WuCF5JJ0/tSKx9gQSXBUzGAb/z/sTF5HkGzaIi2fXxAXd5u26G972O7ihoZXVs
         v9HruTfmGGx9wPZPuWSkF6oQIMBLguPfCPeTg=
Received: by 10.236.32.69 with SMTP id n45mr2813906yha.159.1305406046615;
        Sat, 14 May 2011 13:47:26 -0700 (PDT)
Received: from localhost (cpe-071-077-014-091.nc.res.rr.com [71.77.14.91])
        by mx.google.com with ESMTPS id h63sm1715297yhm.86.2011.05.14.13.47.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 14 May 2011 13:47:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.290.g2f216.dirty
In-Reply-To: <20110514190122.GA16851@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173605>

Add log.abbrevCommit config variable as a convenience for users who
often use --abbrev-commit with git log and friends. Allow the option
to be overridden with --no-abbrev-commit.

(Also, a drive-by spelling correction in git log's short help.)

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Addresses Jonathan's feedback.

> Just because I'm curious: what happens if you do
> 
>        git config log.abbrev-commit true
> 
> in test_create_repo in test-lib.sh?  (I.e., are there many tests that
> would be confused by this?)  Tests tend to be more picky than user
> scripts about the output of git but it might still be an ok way to
> get a vague sense of the impact.

As expected, it breaks all the tests which rely on the output of show,
whatchanged, and log not having abbreviated commit names. They could
all be adjusted to pass '--no-abbrev-commit', but I think that's
pointless churn.

 Documentation/config.txt         |    5 +++++
 Documentation/pretty-options.txt |    5 +++++
 builtin/log.c                    |    8 +++++++-
 revision.c                       |    2 ++
 t/t4202-log.sh                   |   12 ++++++++++++
 5 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 285c7f73ca..8a3a1d08f7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1314,6 +1314,11 @@ interactive.singlekey::
 	linkgit:git-checkout[1]. Note that this setting is silently
 	ignored if portable keystroke input is not available.
 
+log.abbrevCommit::
+	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
+	linkgit:git-whatchanged[1] assume `\--abbrev-commit`. You may
+	override this option with `\--no-abbrev-commit`.
+
 log.date::
 	Set the default date-time mode for the 'log' command.
 	Setting a value for log.date is similar to using 'git log''s
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index d5c977262a..2a3dc8664f 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -19,6 +19,11 @@ configuration (see linkgit:git-config[1]).
 This should make "--pretty=oneline" a whole lot more readable for
 people using 80-column terminals.
 
+--no-abbrev-commit::
+	Show the full 40-byte hexadecimal commit object name. This negates
+	`--abbrev-commit` and those options which imply it such as
+	"--oneline". It also overrides the 'log.abbrevCommit' variable.
+
 --oneline::
 	This is a shorthand for "--pretty=oneline --abbrev-commit"
 	used together.
diff --git a/builtin/log.c b/builtin/log.c
index f6219909a7..540d1a473a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -23,6 +23,7 @@
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
 
+static int default_abbrev_commit;
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
@@ -92,7 +94,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	int quiet = 0, source = 0;
 
 	const struct option builtin_log_options[] = {
-		OPT_BOOLEAN(0, "quiet", &quiet, "supress diff output"),
+		OPT_BOOLEAN(0, "quiet", &quiet, "suppress diff output"),
 		OPT_BOOLEAN(0, "source", &source, "show source"),
 		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, "decorate options",
 		  PARSE_OPT_OPTARG, decorate_callback},
@@ -323,6 +325,10 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		return git_config_string(&fmt_pretty, var, value);
 	if (!strcmp(var, "format.subjectprefix"))
 		return git_config_string(&fmt_patch_subject_prefix, var, value);
+	if (!strcmp(var, "log.abbrevcommit")) {
+		default_abbrev_commit = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "log.date"))
 		return git_config_string(&default_date_mode, var, value);
 	if (!strcmp(var, "log.decorate")) {
diff --git a/revision.c b/revision.c
index a7cf79bf2e..86028917e1 100644
--- a/revision.c
+++ b/revision.c
@@ -1429,6 +1429,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 			revs->abbrev = 40;
 	} else if (!strcmp(arg, "--abbrev-commit")) {
 		revs->abbrev_commit = 1;
+	} else if (!strcmp(arg, "--no-abbrev-commit")) {
+		revs->abbrev_commit = 0;
 	} else if (!strcmp(arg, "--full-diff")) {
 		revs->diff = 1;
 		revs->full_diff = 1;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 2fcc31a6f3..a53a86a989 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -450,6 +450,18 @@ test_expect_success 'log.decorate configuration' '
 
 '
 
+test_expect_success 'log.abbrev-commit configuration' '
+	test_might_fail git config --remove-section log &&
+	test_when_finished "git config --unset log.abbrevCommit" &&
+	git log >expect.full &&
+	git log --abbrev-commit >expect.abbrev &&
+	git config log.abbrevCommit true &&
+	git log >actual.abbrev &&
+	test_cmp expect.abbrev actual.abbrev &&
+	git log --no-abbrev-commit >actual.full &&
+	test_cmp expect.full actual.full
+'
+
 test_expect_success 'show added path under "--follow -M"' '
 	# This tests for a regression introduced in v1.7.2-rc0~103^2~2
 	test_create_repo regression &&
-- 
1.7.5.1.290.g2f216.dirty
