From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v2 1/2] pull --rebase: add --[no-]autostash flag
Date: Sat, 27 Feb 2016 23:11:41 +0530
Message-ID: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
Cc: pyokagan@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 18:42:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZisl-0005Q5-8X
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 18:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992528AbcB0RmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 12:42:13 -0500
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35719 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756340AbcB0RmM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 12:42:12 -0500
Received: by mail-pa0-f65.google.com with SMTP id fl4so6157438pad.2
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 09:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3Bve5bLuSwY/jaMQg2c3oWrUWm6zmXTJ/BGQOR2nhvE=;
        b=pC+V3J8y2XEyLY/rclulk3ATAFqwWd3D9YDXGet/hL6cwK46rBQw159EoWIF/aj128
         lrJkJ8+xjjkl0tc+08TZ8AtVKTwdIQlAqOxDHANUuF5rY1ZIjGl6bpYSKHXToDDskRlv
         S0tlxzCi1hvp8eju6EmzyFvTlH7xxLb9WT4KVM9gwcn1b+jr4lRLzKAPa8bvc2MJUloH
         MdQmafO1i2qaWL5GnMiUWIfytSF5+RyetDTMWDU7TsUYMe6wbR6Kc6OkALfPZ19FMyv2
         0QtKp+o3wfE1mLiP/hzjd0a4EIghcjQFlgGgE7MahKLhOHCNJZxkX87hssUtHqprVhSt
         g1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3Bve5bLuSwY/jaMQg2c3oWrUWm6zmXTJ/BGQOR2nhvE=;
        b=Fs2qxvswvGXKhxdIj0U7mRtGd5mB2eVo6bBqzsVniwj02euFYQoo7MIWt0OV2K6F1a
         zTsE/izBPVEQbcojrs3msbk2rZTsTsavN00/cwI/5hczrtzQ992tSmAyzxNzxF08uLla
         0qIDJqrPH7g5DXQyLmOXiX8UncTkWcfvW++mTqCMlLrzxBmTUgz/1bWGOzeH+pMoKl7Z
         4NOJ4WySNelegjrRT5LYgn2O0D1GHjcTNlzsrJZMldT0rEJC2EvcMxvKFEg4/IfKF3uH
         f0gGJ6c89figtExLDmhAapS1cjQrG6Bpa6wuGqhoTmqdOQQ8vqVsMJuiOUrb80sphuqy
         Jciw==
X-Gm-Message-State: AD7BkJIlAVZZCVa/Mu4iSK43HCrJ5H4XNSTvstcPB6DqTjJ7/Dj4NvJZsJz7ceG9hQm2mA==
X-Received: by 10.66.124.201 with SMTP id mk9mr10786663pab.152.1456594932040;
        Sat, 27 Feb 2016 09:42:12 -0800 (PST)
Received: from localhost.localdomain ([1.39.36.221])
        by smtp.gmail.com with ESMTPSA id i23sm27358456pfj.68.2016.02.27.09.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Feb 2016 09:42:11 -0800 (PST)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287709>

git pull --rebase understands --[no-]autostash flag.

This flag overrides config variable "rebase.autoStash" 
if set (default is false).

When calling "git pull --rebase" with "--autostash",
pull passes the "--autostash" option to rebase, 
which then runs rebase on a dirty worktree.

With "--no-autostash" option, the command will die
if the worktree is dirty, before calling rebase.

Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---

Thanks to Paul and Matthieu for comments on previous round.
Changes:
 	- --autostash flag added
	- OPT_COLOR_FLAG replaced by OPT_BOOL
	- Default value of opt_rebase changed
	- Few changes in code
	- Commit message improvements
	- Documentation added
	- Few tests removed as suggested by Paul
	- Added test for --autostash flag
All tests passed: https://travis-ci.org/mehul2029/git 

 builtin/pull.c          | 13 ++++++++-----
 t/t5520-pull.sh         | 19 +++++++++++++++++++
 t/t5521-pull-options.sh | 16 ++++++++++++++++
 3 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 10eff03..60b320e 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -85,6 +85,7 @@ static char *opt_squash;
 static char *opt_commit;
 static char *opt_edit;
 static char *opt_ff;
+static int opt_autostash = 0;
 static char *opt_verify_signatures;
 static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
 static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
@@ -146,6 +147,8 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
 		N_("abort if fast-forward is not possible"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
+	OPT_BOOL(0,"autostash",&opt_autostash,
+		N_("automatically stash/stash pop before and after rebase")),
 	OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
 		N_("verify that the named commit has a valid GPG signature"),
 		PARSE_OPT_NOARG),
@@ -789,7 +792,8 @@ static int run_rebase(const unsigned char *curr_head,
 	argv_array_pushv(&args, opt_strategy_opts.argv);
 	if (opt_gpg_sign)
 		argv_array_push(&args, opt_gpg_sign);
-
+	if(opt_autostash)
+		argv_array_push(&args,"--autostash");
 	argv_array_push(&args, "--onto");
 	argv_array_push(&args, sha1_to_hex(merge_head));
 
@@ -813,6 +817,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
 
+	git_config_get_bool("rebase.autostash",&opt_autostash);
+
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
 
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
@@ -835,13 +841,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		hashclr(orig_head);
 
 	if (opt_rebase) {
-		int autostash = 0;
-
 		if (is_null_sha1(orig_head) && !is_cache_unborn())
 			die(_("Updating an unborn branch with changes added to the index."));
 
-		git_config_get_bool("rebase.autostash", &autostash);
-		if (!autostash)
+		if (!opt_autostash)
 			die_on_unclean_work_tree(prefix);
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index c952d5e..d80b6cc 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -245,6 +245,25 @@ test_expect_success '--rebase fails with multiple branches' '
 	test modified = "$(git show HEAD:file)"
 '
 
+test_expect_success 'pull --rebase --no-autostash fails with dirty working directory and rebase.autstash set false' '
+	test_config rebase.autostash true &&
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	test_must_fail git pull --rebase --no-autostash . copy
+'
+
+test_expect_success 'pull --rebase --autostash succeeds with dirty working directory and rebase.autstash set false' '
+	test_config rebase.autostash false &&
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	git pull --rebase --autostash . copy &&
+	test_cmp_rev HEAD^ copy &&
+	test "$(cat new_file)" = dirty &&
+	test "$(cat file)" = "modified again"
+'
+
 test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
 	test_config rebase.autostash true &&
 	git reset --hard before-rebase &&
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 18372ca..3930e45 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -62,6 +62,22 @@ test_expect_success 'git pull -v --rebase' '
 	test_must_be_empty out)
 '
 
+test_expect_success 'git pull --rebase --autostash' '
+	mkdir clonedrbas &&
+	(cd clonedrbas  && git init &&
+	git pull --rebase --autostash "../parent" >out 2>err &&
+	test -s err &&
+	test_must_be_empty out)
+'
+
+test_expect_success 'git pull --rebase --no-autostash' '
+	mkdir clonedrbnas &&
+	(cd clonedrbnas  && git init &&
+	git pull --rebase --no-autostash "../parent" >out 2>err &&
+	test -s err &&
+	test_must_be_empty out)
+'
+
 test_expect_success 'git pull -v -q' '
 	mkdir clonedvq &&
 	(cd clonedvq && git init &&
-- 
2.7.1.340.g69eb491.dirty
