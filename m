From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v6 2/2] pull --rebase: add --[no-]autostash flag
Date: Tue,  8 Mar 2016 23:49:08 +0530
Message-ID: <1457461148-8109-2-git-send-email-mehul.jain2029@gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
 <1457461148-8109-1-git-send-email-mehul.jain2029@gmail.com>
Cc: Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com,
	pyokagan@gmail.com, sunshine@sunshineco.com,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 19:20:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adMEn-0003fF-SW
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 19:20:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbcCHSUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 13:20:01 -0500
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36792 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbcCHST7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 13:19:59 -0500
Received: by mail-pa0-f66.google.com with SMTP id 1so1639803pal.3
        for <git@vger.kernel.org>; Tue, 08 Mar 2016 10:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U+8vg6dzjEKtmUXTvPq74FcR0sq2NVi3lPjzU1rYAUY=;
        b=m6rNY+FqS6eMhjjTfwJYZ6vO3NHZ0yFGfCi1CzHOKHaYsyCmk7UJgMpk4uABpUcv0J
         lsuBDsE4I1bY00wPli7Rji36++ltmC+c5OfZO2tLhLXlr5P+XJYEnMaQMPmWuUeD4VUR
         TOa0nUtzdC7FyWMdBrd1Pj1y1HdfYJSebFpGnA5jZUgVp69e0jp7jkfKrBfg00vnwsUd
         TF7GhUIGHS0p/NnBwdpTlPe3AM8ptOVdQGG9bpoWZz8g1FoNCorSrqHaa0MkCkOTvWF1
         AVkIkcIB1hhjM8meOat/fGWQoBaQ7MU7QNc+sfHUVOEOlf8xYi2+kmwnIuQFEKT5laz3
         kKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U+8vg6dzjEKtmUXTvPq74FcR0sq2NVi3lPjzU1rYAUY=;
        b=hotOY/Nd7OB1LeMqXCeCYDEVgSizXlN331Oj9UGF5gmgIJqODg/DE1Ptt0DcjPthPI
         e6I4XVlRqzieF/IgDVadju/UlWJ1uwMTb8TVWK6YTJbAZH7hbBBzzkLUGvOrjCXuwtBd
         2RVBA3lT2Z08ZmKdSyG2XvqGX9wDqh/DDqn+pO6k5e18b4DYmLuG4lvq5Y4k8yPcH0m7
         4ra715o6NKt5Q0Qg6XKI4sbnPWq3/2p1P3FDEMql4m6mGLb/VsPIpTdlGpxoGhWQyCpq
         pv21ZLGRbHy2iBtCMMUm1X/jKp983FlZNn8rZQAEIaftF5BDSfJPxxsDDrZ9by1QOgmR
         ClLA==
X-Gm-Message-State: AD7BkJKTxnvkj9AvX1N/mrN8KVwW91wRMK4rv+giQIAT8pAi9qulSkQ0fm2IKls6wDqZXg==
X-Received: by 10.66.158.232 with SMTP id wx8mr44411207pab.159.1457461199203;
        Tue, 08 Mar 2016 10:19:59 -0800 (PST)
Received: from localhost.localdomain ([1.39.39.116])
        by smtp.gmail.com with ESMTPSA id y27sm6510684pfi.82.2016.03.08.10.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Mar 2016 10:19:58 -0800 (PST)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1457461148-8109-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288446>

If rebase.autoStash configuration variable is set, there is no way to
override it for "git pull --rebase" from the command line.

Teach "git pull --rebase" the --[no-]autostash command line flag which
overrides the current value of rebase.autoStash, if set. As "git rebase"
understands the --[no-]autostash option, it's just a matter of passing
the option to underlying "git rebase" when "git pull --rebase" is called.

Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Paul Tan <pyokagan@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
Previous patches: $gname287709

Changes:
	- Slight change is documentation.

 Documentation/git-pull.txt |  9 +++++++++
 builtin/pull.c             | 16 ++++++++++++++--
 t/t5520-pull.sh            | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index a62a2a6..da89be6 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -128,6 +128,15 @@ unless you have read linkgit:git-rebase[1] carefully.
 --no-rebase::
 	Override earlier --rebase.
 
+--autostash::
+--no-autostash::
+	Before starting rebase, stash local modifications away (see
+	linkgit:git-stash.txt[1]) if needed, and apply the stash when
+	done (this option is only valid when "--rebase" is used).
++
+'--no-autostash' is useful to override the 'rebase.autoStash'
+configuration variable (see linkgit:git-config[1]).
+
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/pull.c b/builtin/pull.c
index 8a318e9..a01058a 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -86,6 +86,7 @@ static char *opt_commit;
 static char *opt_edit;
 static char *opt_ff;
 static char *opt_verify_signatures;
+static int opt_autostash = -1;
 static int config_autostash = -1;
 static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
 static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
@@ -150,6 +151,8 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
 		N_("verify that the named commit has a valid GPG signature"),
 		PARSE_OPT_NOARG),
+	OPT_BOOL(0, "autostash", &opt_autostash,
+		N_("automatically stash/stash pop before and after rebase")),
 	OPT_PASSTHRU_ARGV('s', "strategy", &opt_strategies, N_("strategy"),
 		N_("merge strategy to use"),
 		0),
@@ -801,6 +804,10 @@ static int run_rebase(const unsigned char *curr_head,
 	argv_array_pushv(&args, opt_strategy_opts.argv);
 	if (opt_gpg_sign)
 		argv_array_push(&args, opt_gpg_sign);
+	if (opt_autostash == 1)
+		argv_array_push(&args, "--autostash");
+	else if (opt_autostash == 0)
+		argv_array_push(&args, "--no-autostash");
 
 	argv_array_push(&args, "--onto");
 	argv_array_push(&args, sha1_to_hex(merge_head));
@@ -851,12 +858,17 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		if (is_null_sha1(orig_head) && !is_cache_unborn())
 			die(_("Updating an unborn branch with changes added to the index."));
 
-		if (config_autostash != 1)
+		if (opt_autostash == -1)
+			opt_autostash = config_autostash;
+
+		if (opt_autostash != 1)
 			die_on_unclean_work_tree(prefix);
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
 			hashclr(rebase_fork_point);
-	}
+	} else
+		if (opt_autostash != -1)
+			 die(_("--[no-]autostash option is only valid with --rebase."));
 
 	if (run_fetch(repo, refspecs))
 		return 1;
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index c952d5e..85d9bea 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -255,6 +255,45 @@ test_expect_success 'pull --rebase succeeds with dirty working directory and reb
 	test "$(cat new_file)" = dirty &&
 	test "$(cat file)" = "modified again"
 '
+test_expect_success 'pull --rebase: --autostash overrides rebase.autostash' '
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
+test_expect_success 'pull --rebase --autostash works with rebase.autostash set true' '
+	test_config rebase.autostash true &&
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	git pull --rebase --autostash . copy &&
+	test_cmp_rev HEAD^ copy &&
+	test "$(cat new_file)" = dirty &&
+	test "$(cat file)" = "modified again"
+'
+
+test_expect_success 'pull --rebase: --no-autostash overrides rebase.autostash' '
+	test_config rebase.autostash true &&
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	test_must_fail git pull --rebase --no-autostash . copy 2>err &&
+	test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
+'
+
+test_expect_success 'pull --rebase --no-autostash works with rebase.autostash set false' '
+	test_config rebase.autostash false &&
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	test_must_fail git pull --rebase --no-autostash . copy 2>err &&
+	test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
+'
 
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
-- 
2.7.1.340.g69eb491.dirty
