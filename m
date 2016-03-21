From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v10 2/2] pull --rebase: add --[no-]autostash flag
Date: Mon, 21 Mar 2016 23:48:03 +0530
Message-ID: <1458584283-23816-3-git-send-email-mehul.jain2029@gmail.com>
References: <1458584283-23816-1-git-send-email-mehul.jain2029@gmail.com>
Cc: gitster@pobox.com, Matthieu.Moy@grenoble-inp.fr,
	pyokagan@gmail.com, sunshine@sunshineco.com,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 19:19:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai4Q9-0006d6-TS
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 19:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757064AbcCUSTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 14:19:13 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34690 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754735AbcCUSTM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 14:19:12 -0400
Received: by mail-pf0-f194.google.com with SMTP id n5so31358146pfn.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 11:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+gJX6PBkdFw0O78IO0o6hcY0gqyJm9WhBU8hr39lwZY=;
        b=mLRLui9SPl4FfVYNnygvT+XuEcEG/dSpP/lTOHz/jYPb6RqI0OME97CAykZYkR81Pu
         88IE+flbcOsnM4OKxrwGKdTHC6piHBPorQEgxE0EARLMMMhXUiMolmLsFmwbN8/7/SON
         W4Vi8ogDJwIAQaRj1xw+/InusIeZ+O7y5PB10l8h8z5sCjCy7qou0aFz68KZPx+JKRGd
         eiJMaVZTPr66cyN0WvtA23gSrsj037y080p2o2Fjzn900cjRVQ+t6F4T6sAQ/lwtPGnw
         y37E/+Wrn+PFGCHsDP4q8Knz/TutNQqa4WbUVUUxJHKeiKzAMGxtqF0+bp/1YKo34Vw0
         WnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+gJX6PBkdFw0O78IO0o6hcY0gqyJm9WhBU8hr39lwZY=;
        b=hIpIoRaGZpXGTUYFJqZ1lIGDxoe/MfvB/EXwvNrxdiNHDvpdjf2BJpL/eCAUZCHgNS
         8tiEVKl65/5D2BeAlDfD0ZEnErNODoBcofWQlMMzwHQyxHC1n+uBIJZOxElp7OX18WEk
         g2n2IH4Dm9kskhyL2c5yF/UPcVEGdFTYqoKKD3wVwuJNvJJPYNR/qUHn6OrCN4ksRe+z
         gbX4OrOn40nNFf29IOMsbjyTRZZdKzLEs+veoO1u6CLmB4fMAy6N0H7EX9UEUXuoim8s
         +cpalK8Fn9QKh4GVJxCHx+ocrq6A/Dhs9AI9K2LrslYrzvUI/+XgeLoglczTzKA1J5Aq
         W5Xg==
X-Gm-Message-State: AD7BkJKqnDcHfGhWFMK7jI30TSSLD96pkWg0weVp6XFLQH5gqHwBo6raZ6bDz4XI2oV5XA==
X-Received: by 10.98.71.86 with SMTP id u83mr15209350pfa.156.1458584352246;
        Mon, 21 Mar 2016 11:19:12 -0700 (PDT)
Received: from localhost.localdomain ([1.39.36.202])
        by smtp.gmail.com with ESMTPSA id ud8sm42378768pac.11.2016.03.21.11.19.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Mar 2016 11:19:11 -0700 (PDT)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1458584283-23816-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289436>

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
 Documentation/git-pull.txt |  9 ++++++
 builtin/pull.c             | 12 ++++++++
 t/t5520-pull.sh            | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index a62a2a6..3914507 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -128,6 +128,15 @@ unless you have read linkgit:git-rebase[1] carefully.
 --no-rebase::
 	Override earlier --rebase.
 
+--autostash::
+--no-autostash::
+	Before starting rebase, stash local modifications away (see
+	linkgit:git-stash.txt[1]) if needed, and apply the stash when
+	done. `--no-autostash` is useful to override the `rebase.autoStash`
+	configuration variable (see linkgit:git-config[1]).
++
+This option is only valid when "--rebase" is used.
+
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/pull.c b/builtin/pull.c
index c21897d..d98f481 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -86,6 +86,7 @@ static char *opt_commit;
 static char *opt_edit;
 static char *opt_ff;
 static char *opt_verify_signatures;
+static int opt_autostash = -1;
 static int config_autostash;
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
@@ -802,6 +805,10 @@ static int run_rebase(const unsigned char *curr_head,
 	argv_array_pushv(&args, opt_strategy_opts.argv);
 	if (opt_gpg_sign)
 		argv_array_push(&args, opt_gpg_sign);
+	if (opt_autostash == 0)
+		argv_array_push(&args, "--no-autostash");
+	else if (opt_autostash == 1)
+		argv_array_push(&args, "--autostash");
 
 	argv_array_push(&args, "--onto");
 	argv_array_push(&args, sha1_to_hex(merge_head));
@@ -847,8 +854,13 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_sha1("HEAD", orig_head))
 		hashclr(orig_head);
 
+	if (!opt_rebase && opt_autostash != -1)
+		die(_("--[no-]autostash option is only valid with --rebase."));
+
 	if (opt_rebase) {
 		int autostash = config_autostash;
+		if (opt_autostash != -1)
+			autostash = opt_autostash;
 
 		if (is_null_sha1(orig_head) && !is_cache_unborn())
 			die(_("Updating an unborn branch with changes added to the index."));
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index c952d5e..745e59e 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -256,6 +256,76 @@ test_expect_success 'pull --rebase succeeds with dirty working directory and reb
 	test "$(cat file)" = "modified again"
 '
 
+test_expect_success 'pull --rebase --autostash & rebase.autostash=true' '
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
+test_expect_success 'pull --rebase --autostash & rebase.autoStash=false' '
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
+test_expect_success 'pull --rebase: --autostash & rebase.autoStash unset' '
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	git pull --rebase --autostash . copy &&
+	test_cmp_rev HEAD^ copy &&
+	test "$(cat new_file)" = dirty &&
+	test "$(cat file)" = "modified again"
+'
+
+test_expect_success 'pull --rebase --no-autostash & rebase.autostash=true' '
+	test_config rebase.autostash true &&
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	test_must_fail git pull --rebase --no-autostash . copy 2>err &&
+	test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
+'
+
+test_expect_success 'pull --rebase --no-autostash & rebase.autostash=false' '
+	test_config rebase.autostash false &&
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	test_must_fail git pull --rebase --no-autostash . copy 2>err &&
+	test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
+'
+
+test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	test_must_fail git pull --rebase --no-autostash . copy 2>err &&
+	test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
+'
+
+test_expect_success 'pull --autostash (without --rebase) should error out' '
+	test_must_fail git pull --autostash . copy 2>actual &&
+	echo "fatal: --[no-]autostash option is only valid with --rebase." >expect &&
+	test_i18ncmp actual expect
+'
+
+test_expect_success 'pull --no-autostash (without --rebase) should error out' '
+	test_must_fail git pull --no-autostash . copy 2>actual &&
+	echo "fatal: --[no-]autostash option is only valid with --rebase." >expect &&
+	test_i18ncmp actual expect
+'
+
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
 	test_config pull.rebase true &&
-- 
2.7.1.340.g69eb491.dirty
