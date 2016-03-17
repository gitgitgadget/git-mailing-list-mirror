From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v9 2/2] pull --rebase: add --[no-]autostash flag
Date: Thu, 17 Mar 2016 22:19:30 +0530
Message-ID: <1458233370-8343-2-git-send-email-mehul.jain2029@gmail.com>
References: <1458233370-8343-1-git-send-email-mehul.jain2029@gmail.com>
Cc: gitster@pobox.com, Matthieu.Moy@grenoble-inp.fr,
	pyokagan@gmail.com, sunshine@sunshineco.com,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 17:53:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agbAX-00027J-6x
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 17:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031571AbcCQQwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 12:52:46 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35914 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031264AbcCQQwo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 12:52:44 -0400
Received: by mail-pf0-f195.google.com with SMTP id q129so12115165pfb.3
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 09:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/bZzb+QdFOO95NH5qMiasOLC+DtJV9EBMGBFGdFUxBo=;
        b=Az4QhEHB2O/+SqY+O6UHDVq/eBp6evK9AhJhLu8Gde9xD+xXIKGoS2YztnSjEZOTQt
         WzX0VWYBgzn3F62qnaXMqAd1LRYyCt6OoOxia4HyPLIlfD1BYkb1RSN5eDVgx+96jAwp
         87cQfLoZ4XGf0v4jK2UZFszYP1nUoysBkuNjG66TmG9g5XcczLxkn8Hh4ufDATC+UDg+
         9GD39n/zDaUp/TvPIm0u+7aBWGrmyejZ3JGCY8u9HDNuCFn001KT0tOolSN2aQ/8APoi
         qpu5Za/BzUsWfUiuloKsQx9iwGRIMjbKdOYVYtiPXZ5Pl6yWVB7Bdf4U0KeTraQJ2WD5
         Zvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/bZzb+QdFOO95NH5qMiasOLC+DtJV9EBMGBFGdFUxBo=;
        b=mPtTSxH8uZgmi3K1ebmW5YHRH+gapJ9nEtkt2Lk5DRdrnvh/ZtXY/YdgNXVrPjaA2K
         e1uTbMNGWQHJ9neFz+5y7wwISypVhOxf949YKomQrDApG/03HQGimPlIog53cHia5p+8
         NEeW6PNL8IBRCGTgx24CUIhZvD5EiUP/MIUiXf+FT6XYWFsc/buxk3l5QeBSIz/eIvkr
         /JUVS98ixdYG3ReS5FqwmDGPCxcFgmSu36WqtcKR2YVlRSUifMMgG475DnKfbJQOeY+5
         xBnynCFOITv8rHyuSAWLRSqpkjXR6BsyUrccfrCBVlbDqA3dwSofjToI5Z59bS5bdBN4
         Ak0w==
X-Gm-Message-State: AD7BkJJBbfnxHkWUX29d2XCisIC98oMwVENCZIikAes3n+YrouCG92IOSozVTJ5yPwNRtg==
X-Received: by 10.66.193.202 with SMTP id hq10mr16102375pac.6.1458233563299;
        Thu, 17 Mar 2016 09:52:43 -0700 (PDT)
Received: from localhost.localdomain ([1.39.37.204])
        by smtp.gmail.com with ESMTPSA id q2sm14600258pfq.88.2016.03.17.09.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Mar 2016 09:52:42 -0700 (PDT)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1458233370-8343-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289128>

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
previous patches: http://thread.gmane.org/gmane.comp.version-control.git/287709

Changes:
	* Modified documentation
	* "git pull --[no-]autostash" case is handled bit early then before

 Documentation/git-pull.txt |  9 +++++++++
 builtin/pull.c             | 12 +++++++++++-
 t/t5520-pull.sh            | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)

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
index 72f4475..671179b 100644
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
@@ -801,6 +804,7 @@ static int run_rebase(const unsigned char *curr_head,
 	argv_array_pushv(&args, opt_strategy_opts.argv);
 	if (opt_gpg_sign)
 		argv_array_push(&args, opt_gpg_sign);
+	argv_array_push(&args, opt_autostash ? "--autostash" : "--no-autostash");
 
 	argv_array_push(&args, "--onto");
 	argv_array_push(&args, sha1_to_hex(merge_head));
@@ -846,11 +850,17 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_sha1("HEAD", orig_head))
 		hashclr(orig_head);
 
+	if (!opt_rebase && opt_autostash != -1)
+		die(_("--[no-]autostash option is only valid with --rebase."));
+
 	if (opt_rebase) {
 		if (is_null_sha1(orig_head) && !is_cache_unborn())
 			die(_("Updating an unborn branch with changes added to the index."));
 
-		if (!config_autostash)
+		if (opt_autostash == -1)
+			opt_autostash = config_autostash;
+
+		if (!opt_autostash)
 			die_on_unclean_work_tree(prefix);
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
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
