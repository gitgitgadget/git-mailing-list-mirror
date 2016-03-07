From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v5] pull --rebase: add --[no-]autostash flag
Date: Mon,  7 Mar 2016 18:07:25 +0530
Message-ID: <1457354245-26871-1-git-send-email-mehul.jain2029@gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
Cc: Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com,
	pyokagan@gmail.com, sunshine@sunshineco.com,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 13:37:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acuQ1-0005T9-1o
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 13:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbcCGMhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 07:37:45 -0500
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34303 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbcCGMho (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 07:37:44 -0500
Received: by mail-pa0-f65.google.com with SMTP id hj7so7710696pac.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2016 04:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TegLfSgE1CEiv4DAKKTRYSFydwjBE61bNFu2tukD2S8=;
        b=JrxcY75ueY6kdTn3D3KhFlPUiSp+lWXcYriMVE/uV2DZFqThfjkgJxNYEmwjoPVrEZ
         m5hRnlJbgbKwi1zLD6ExYSeck63XZaNnkd+NryPa4B8rMvui729SFAz1A994GWXm989Q
         oCoiVW3/pkv6mlpfeO+y4ZMxVMsUFQO0/pjhRA1ZKvbw2Zj9cbD8CfEqkIqX4kirY8xv
         JLxewov+r3FJwKPo/GYspJbmv1Q2x/ScOukqvtHILcF3nJcd0F9F+F1SoPyIy9ZwO7bD
         EG9DR6rLu4mjZMw/CDlw0hUU/qFooNmve0GuN26OU2hhclyp/3ksIwsz9Om5nKInxA4S
         fwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TegLfSgE1CEiv4DAKKTRYSFydwjBE61bNFu2tukD2S8=;
        b=Oliugd8toPfrP8xuqPM8lmHtxq4GvAiGGz/VZNxLjm5+JArDI1XG6eRhiF+ZmzuHSn
         Pb+pHvWaGg9QkTERK3lXrtrLPIk3EWwHZ8YYE7xfMUbac/VFcOp/0q8hxf6uBK/Jn/pk
         Zp/84zwt1bQ7i5becysz1YLz/9AAR+7Q3sfL7Cejdp9w0czuRZBMH14VAAfEOKJoeZUI
         kgu1Mczu3kvJdAH729GqUp4DArY+3GVZmV+Ybdk1SGQKRYMeiqhgz4z9f5Q/wubcXko7
         dixQdeXSZ/J1XkqUTunFdAjdiKf2+1bgaThxsPk/xJEDTvNfRhga0EHsPt0s5TRiFTbh
         DoHQ==
X-Gm-Message-State: AD7BkJLvtpsd736fWgy+37ja6wbwcaPwrGdtZfeObj5DmXui+QHG249GyQPv1/I8w9cDZA==
X-Received: by 10.66.140.39 with SMTP id rd7mr32864263pab.92.1457354263260;
        Mon, 07 Mar 2016 04:37:43 -0800 (PST)
Received: from localhost.localdomain ([1.39.39.200])
        by smtp.gmail.com with ESMTPSA id dw2sm24093999pab.14.2016.03.07.04.37.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Mar 2016 04:37:42 -0800 (PST)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288389>

If rebase.autoStash configuration variable is set, there is no way to
override it for "git pull --rebase" from the command line.

Teach "git pull --rebase" the --[no-]autostash command line flag which
overrides the current value of rebase.autoStash, if set. As "git rebase"
understands the --[no-]autostash option, it's just a matter of passing
the option to underlying "git rebase" when "git pull --rebase" is called.

Also introduce a callback function to read config variables.

Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Paul Tan <pyokagan@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
Previous patches: $gname287709

Changes: 
* Documentation modified
* Introduced a callback function to read config variables.
* Introduce two new tests
* Modified previous tests because:
	
	if worktree is dirty and --no-autostash is passed then git-pull
	should die before git-fetch is called, hence the error message 
	must be: 
	
	"Cannot pull with rebase: Your index contains uncommitted changes."

	Whereas if git-fetch is invoked and --no-autostash is passed to
	git-rebase then error message is:
	
	"Cannot rebase: Your index contains uncommitted changes."

	This test will prevent_future_changes by other people to break the
	code which may cause git-fetch being called even if worktree is dirty
	with --no-autostash option.

 Documentation/git-pull.txt |  9 +++++++++
 builtin/pull.c             | 34 ++++++++++++++++++++++++++++------
 t/t5520-pull.sh            | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index a62a2a6..393ac7d 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -128,6 +128,15 @@ unless you have read linkgit:git-rebase[1] carefully.
 --no-rebase::
 	Override earlier --rebase.
 
+--autostash::
+--no-autostash::
+	Before starting rebase, stash local modifications away (see
+	linkgit:git-stash.txt[1]) if needed, and apply the stash when
+	done (this option is only valid when '--rebase' is used).
++
+'--no-autostash' is useful to override the 'rebase.autoStash'
+configuration variable (see linkgit:git-config[1]).
+
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/pull.c b/builtin/pull.c
index 10eff03..b25c53d 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -85,6 +85,8 @@ static char *opt_squash;
 static char *opt_commit;
 static char *opt_edit;
 static char *opt_ff;
+static int opt_autostash = -1;
+static int config_autostash = -1;
 static char *opt_verify_signatures;
 static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
 static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
@@ -146,6 +148,8 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
 		N_("abort if fast-forward is not possible"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
+	OPT_BOOL(0, "autostash", &opt_autostash,
+		N_("automatically stash/stash pop before and after rebase")),
 	OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
 		N_("verify that the named commit has a valid GPG signature"),
 		PARSE_OPT_NOARG),
@@ -306,6 +310,18 @@ static enum rebase_type config_get_rebase(void)
 }
 
 /**
+ * Read config variables.
+ */
+static int git_pull_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var,"rebase.autostash")) {
+		config_autostash = git_config_bool(var,value);
+		return 0;
+	}
+	return git_default_config(var, value, cb);
+}
+
+/**
  * Returns 1 if there are unstaged changes, 0 otherwise.
  */
 static int has_unstaged_changes(const char *prefix)
@@ -789,6 +805,10 @@ static int run_rebase(const unsigned char *curr_head,
 	argv_array_pushv(&args, opt_strategy_opts.argv);
 	if (opt_gpg_sign)
 		argv_array_push(&args, opt_gpg_sign);
+	if (opt_autostash == 1)
+		argv_array_push(&args, "--autostash");
+	else if (opt_autostash == 0)
+		argv_array_push(&args, "--no-autostash");
 
 	argv_array_push(&args, "--onto");
 	argv_array_push(&args, sha1_to_hex(merge_head));
@@ -823,7 +843,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (opt_rebase < 0)
 		opt_rebase = config_get_rebase();
 
-	git_config(git_default_config, NULL);
+	git_config(git_pull_config, NULL);
 
 	if (read_cache_unmerged())
 		die_resolve_conflict("Pull");
@@ -835,18 +855,20 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		hashclr(orig_head);
 
 	if (opt_rebase) {
-		int autostash = 0;
-
 		if (is_null_sha1(orig_head) && !is_cache_unborn())
 			die(_("Updating an unborn branch with changes added to the index."));
 
-		git_config_get_bool("rebase.autostash", &autostash);
-		if (!autostash)
+		if (opt_autostash == -1)
+			opt_autostash = config_autostash;
+
+		if (opt_autostash == 0 || opt_autostash == -1)
 			die_on_unclean_work_tree(prefix);
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
 			hashclr(rebase_fork_point);
-	}
+	} else
+		if (opt_autostash != -1)
+			die(_("--[no-]autostash option is only valid with --rebase."));
 
 	if (run_fetch(repo, refspecs))
 		return 1;
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index c952d5e..cc6a481 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -256,6 +256,46 @@ test_expect_success 'pull --rebase succeeds with dirty working directory and reb
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
+
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
 	test_config pull.rebase true &&
-- 
2.7.1.340.g69eb491.dirty
