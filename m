From: Chirayu Desai <chirayudesai1@gmail.com>
Subject: [PATCH/GSoC] pull: implement --[no-]autostash for usage when rebasing
Date: Sat, 19 Mar 2016 19:27:42 +0530
Message-ID: <1458395862-5113-1-git-send-email-chirayudesai1@gmail.com>
Cc: Chirayu Desai <chirayudesai1@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 19 14:59:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahHPB-0000t9-FZ
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 14:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbcCSN6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 09:58:05 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36859 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbcCSN6D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 09:58:03 -0400
Received: by mail-pf0-f196.google.com with SMTP id q129so21988424pfb.3
        for <git@vger.kernel.org>; Sat, 19 Mar 2016 06:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=6kVnHKrlCFU8rTIYT01xbAcahpCUYPjafJ5o8BpIfeY=;
        b=W1Uolz3cBcxFvAXV7HZIIqFJLb5KWaaefCV1j0zA0TvwCGYYWKa+B6XGyXKV5507B9
         xP1smY6vP4LOmmnru798QDSh5o4XmEZbzV3WctKifjFSica29Y6du81nmQXd4ptXfd27
         TfaLEFjE5ZPvXFrwjW4coBqdEGs+AxGhEXLNhFi35fuPp4GJO3Bgoq3YcnDuMUH84xN+
         eL5ArOq9PVAucOn2jxna53J8kMYgC70p+sLgAFTlg1AlW22LShyRmLmzG69nQEp3Cu4y
         9u6ifmAqg1jGlurggm3qZENDL3FPxAnIKXM1dqLDhFq6EV3Rrpl/srKinL4CTuM/Ffko
         ogMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6kVnHKrlCFU8rTIYT01xbAcahpCUYPjafJ5o8BpIfeY=;
        b=G+ZFRzYXE1ONYjlz5YkqKZvoTEseHA9J953Be1o0qrJfnUOV2u51uhgvU5eNy5ewxp
         RuN6vT5jJtBsXex9jTCioxXJllkDGD/x+dX/krThaI0efpAw9HFp+O3Wv66adPU0mcQ2
         4PIPWAQAKlR9cW8f4fZbL4+V7VwhJBXCl25Hs4rm8ulz8fU6vPSIkhWDSWz4WzLe5Oyn
         pFMN7YkjZMhzLfoRpckMWDfzAFI36HrWd9hTy0dQs+qQIEuv3/fMO1FAJDJoDf4beSxG
         Cek4zUovZEI9DZ1UZnDi0356n/WZAIbyE1Tx9+RZ2zIM8SpvMl9JpW4S+2qYnRKOjRBJ
         amPw==
X-Gm-Message-State: AD7BkJLY8J7Hf2Wq1804Vpy00v8jqtVd2gGWxKoBTIXHNfOTqECS084O9Y8xvNa6xamd1A==
X-Received: by 10.98.8.196 with SMTP id 65mr31222541pfi.53.1458395882083;
        Sat, 19 Mar 2016 06:58:02 -0700 (PDT)
Received: from localhost.localdomain ([122.170.90.32])
        by smtp.gmail.com with ESMTPSA id b11sm283967pfj.4.2016.03.19.06.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 19 Mar 2016 06:58:00 -0700 (PDT)
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289306>

Since 53c76dc0 pull understands the "rebase.autoStash" configuration
option, which was added to rebase in 58794775

This allows usage of the same option when running 'git pull --rebase',
passing it on to 'git rebase'

Signed-off-by: Chirayu Desai <chirayudesai1@gmail.com>
---
 Documentation/git-pull.txt |  7 +++++++
 builtin/pull.c             | 10 ++++++++++
 t/t5544-pull-autostash.sh  | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)
 create mode 100755 t/t5544-pull-autostash.sh

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index a62a2a615d..24db186c50 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -128,6 +128,13 @@ unless you have read linkgit:git-rebase[1] carefully.
 --no-rebase::
 	Override earlier --rebase.
 
+--[no-]autostash::
+	Automatically create a temporary stash before the operation
+	begins, and apply it after the operation ends.  This means
+	that you can run pull & rebase on a dirty worktree.  However,
+	use with care: the final stash application after a successful
+	rebase might result in non-trivial conflicts.
+
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/pull.c b/builtin/pull.c
index 10eff03967..c22ce737ce 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -89,6 +89,7 @@ static char *opt_verify_signatures;
 static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
 static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
 static char *opt_gpg_sign;
+static char *opt_autostash;
 
 /* Options passed to git-fetch */
 static char *opt_all;
@@ -159,6 +160,8 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU('S', "gpg-sign", &opt_gpg_sign, N_("key-id"),
 		N_("GPG sign commit"),
 		PARSE_OPT_OPTARG),
+	OPT_PASSTHRU(0, "autostash", &opt_autostash, NULL,
+		N_("automatically stash before pull, and apply it after rebase"), PARSE_OPT_NOARG),
 
 	/* Options passed to git-fetch */
 	OPT_GROUP(N_("Options related to fetching")),
@@ -798,6 +801,9 @@ static int run_rebase(const unsigned char *curr_head,
 	else
 		argv_array_push(&args, sha1_to_hex(merge_head));
 
+	if (opt_autostash)
+		argv_array_push(&args, opt_autostash);
+
 	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
 	argv_array_clear(&args);
 	return ret;
@@ -841,6 +847,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			die(_("Updating an unborn branch with changes added to the index."));
 
 		git_config_get_bool("rebase.autostash", &autostash);
+		if (!strcmp(opt_autostash, "--autostash"))
+			autostash = 1;
+		if (!strcmp(opt_autostash, "--no-autostash"))
+			autostash = 0;
 		if (!autostash)
 			die_on_unclean_work_tree(prefix);
 
diff --git a/t/t5544-pull-autostash.sh b/t/t5544-pull-autostash.sh
new file mode 100755
index 0000000000..7f8309ef43
--- /dev/null
+++ b/t/t5544-pull-autostash.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='git pull --[no-]autostash tests'
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo file >file &&
+	git add file &&
+	git commit -a -m original &&
+	git checkout -b test master &&
+	echo modified file >file &&
+	git commit -m file file
+'
+
+test_expect_success 'pull --rebase --autostash succeeds with dirty working directory' '
+	git checkout -b test1 master &&
+	git reset --hard master &&
+	git log -1 &&
+	echo dirty >new_file &&
+	git add new_file &&
+	git pull --rebase --autostash . test &&
+	test "$(cat new_file)" = dirty &&
+	test "$(cat file)" = "modified file"
+'
+
+test_expect_success 'pull --rebase --no-autostash fails with dirty working directory' '
+	git checkout -b test2 master &&
+	git reset --hard master &&
+	git log -1 &&
+	echo dirty >new_file &&
+	git add new_file &&
+	test_must_fail git pull --rebase --no-autostash . test &&
+	test "$(cat new_file)" = dirty &&
+	test "$(cat file)" = "file"
+'
+
+test_done
\ No newline at end of file
-- 
2.7.4
