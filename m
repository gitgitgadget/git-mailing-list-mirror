Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4A0C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 06:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCTGAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 02:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCTGAM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 02:00:12 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739DD1CAFF
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 23:00:09 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id iw3so11330429plb.6
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 23:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679292008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07ldifHYPVkaWQtQFeZnG/t/tyD/rJuc3VqSBBl5sjo=;
        b=Xt2qSZ9TXyDS+WpjsK6pTR5HJCZw7qLDDC60ddTrq1ORMqSS1oLHudEToTJRNbJiGP
         1y4rMDRfcBYAssVZCRWWwgN3oNYmJ4Zp4RTSZPKGDYtZ5PNDNI+q43D1UH/eNg10dVrF
         qUmloAT+iI83e652DV5Db4OpNmr2s3l7tS2lrQdjLhDdzvHzDpneHMCJXbn9TIjtYVsJ
         XIUh2s35uN3mOhVbM3j25h3PElIk3zQsrm2yamw1givgXv3h+1wxgPsFqYVjI6GlC8at
         7jAh0I+EEuboEPPIbItBoylijvU1iN1cYFW8+T2NEao7WVO2zwd1EiORnJ2RsrjeAfi8
         YPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679292008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07ldifHYPVkaWQtQFeZnG/t/tyD/rJuc3VqSBBl5sjo=;
        b=T0kzsLREjHpPjH32RUTpNuh4z/qx78m8oU4tGYTbEpHNChO5pLqtazwvuo3hlnAmCT
         WVd7ZPvR6Wvk0PJn9qZp6uLnZBmY5lyUvxbu5c91TE8GSAV1fmD7HsFmA8Nwhk3cFBUs
         Xcx+RVB1VLG5FkZ4SSRyaCeHLWi1EeoD0CpuXwOUL0c/x2siaMm48Ckg+CWTZrksuHQB
         koSNTrGxsNwAKcCh2kP8d0V1ZDmnASGZa9oEiBl3+/uA79Kh4OtQUIcYa19QVgtxNRDM
         42t1ISfRLQscUgdyp3K2mTUKkP3bOHiULucRqZ7HPlqtKIjOYbGRxB+ScujEJWDu8iCi
         vswQ==
X-Gm-Message-State: AO0yUKVHN8L6r+DCinQ5fpVT/VJzrhLz9Uu07rL5LnmmBq5GSwPxTeRW
        zY37n21FZcvrLtUEZ2xT0NOyTX3XsOZmuQ==
X-Google-Smtp-Source: AK7set9dNHOmbQqNZFRkEwcm+2IlAwopwbU2OnHVjdtg31aBoWu3zHN5CPzmQQxXEMkJEA2fkZRxCw==
X-Received: by 2002:a17:90b:1a8a:b0:23f:4370:2c67 with SMTP id ng10-20020a17090b1a8a00b0023f43702c67mr13981359pjb.26.1679292008597;
        Sun, 19 Mar 2023 23:00:08 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id cc13-20020a17090af10d00b002353082958csm7814075pjb.10.2023.03.19.23.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 23:00:08 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        chooglen@google.com, calvinwan@google.com,
        jonathantanmy@google.com, felipe.contreras@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v8 3/3] rebase: add a config option for --rebase-merges
Date:   Sun, 19 Mar 2023 23:59:55 -0600
Message-Id: <20230320055955.461138-4-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230320055955.461138-1-alexhenrie24@gmail.com>
References: <20230312210456.92364-1-alexhenrie24@gmail.com>
 <20230320055955.461138-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The purpose of the new option is to accommodate users who would like
--rebase-merges to be on by default and to facilitate turning on
--rebase-merges by default without configuration in a future version of
Git.

Name the new option rebase.rebaseMerges, even though it is a little
redundant, for consistency with the name of the command line option and
to be clear when scrolling through values in the [rebase] section of
.gitconfig.

Support setting rebase.rebaseMerges to the nonspecific value "true" for
users who don't need to or don't want to learn about the difference
between rebase-cousins and no-rebase-cousins.

Make --rebase-merges without an argument on the command line override
any value of rebase.rebaseMerges in the configuration, for consistency
with other command line flags with optional arguments that have an
associated config option.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/config/rebase.txt        | 10 ++++
 Documentation/git-rebase.txt           |  3 +-
 builtin/rebase.c                       | 81 ++++++++++++++++++--------
 t/t3422-rebase-incompatible-options.sh | 17 ++++++
 t/t3430-rebase-merges.sh               | 34 +++++++++++
 5 files changed, 121 insertions(+), 24 deletions(-)

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
index f19bd0e040..afaf6dad99 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -67,3 +67,13 @@ rebase.rescheduleFailedExec::
 
 rebase.forkPoint::
 	If set to false set `--no-fork-point` option by default.
+
+rebase.rebaseMerges::
+	Whether and how to set the `--rebase-merges` option by default. Can
+	be `rebase-cousins`, `no-rebase-cousins`, or a boolean. Setting to
+	true or to `no-rebase-cousins` is equivalent to
+	`--rebase-merges=no-rebase-cousins`, setting to `rebase-cousins` is
+	equivalent to `--rebase-merges=rebase-cousins`, and setting to false is
+	equivalent to `--no-rebase-merges`. Passing `--rebase-merges` on the
+	command line, with or without an argument, overrides any
+	`rebase.rebaseMerges` configuration.
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 4e57a87624..e7b39ad244 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -537,7 +537,8 @@ See also INCOMPATIBLE OPTIONS below.
 	by recreating the merge commits. Any resolved merge conflicts or
 	manual amendments in these merge commits will have to be
 	resolved/re-applied manually. `--no-rebase-merges` can be used to
-	countermand a previous `--rebase-merges`.
+	countermand both the `rebase.rebaseMerges` config option and a previous
+	`--rebase-merges`.
 +
 When rebasing merges, there are two modes: `rebase-cousins` and
 `no-rebase-cousins`. If the mode is not specified, it defaults to
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 4b3f29a449..fd284e24ab 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -124,6 +124,7 @@ struct rebase_options {
 	int fork_point;
 	int update_refs;
 	int config_autosquash;
+	int config_rebase_merges;
 	int config_update_refs;
 };
 
@@ -141,6 +142,8 @@ struct rebase_options {
 		.allow_empty_message = 1,               \
 		.autosquash = -1,                       \
 		.config_autosquash = -1,                \
+		.rebase_merges = -1,                    \
+		.config_rebase_merges = -1,             \
 		.update_refs = -1,                      \
 		.config_update_refs = -1,               \
 	}
@@ -772,6 +775,16 @@ static int run_specific_rebase(struct rebase_options *opts)
 	return status ? -1 : 0;
 }
 
+static void parse_rebase_merges_value(struct rebase_options *options, const char *value)
+{
+	if (!strcmp("no-rebase-cousins", value))
+		options->rebase_cousins = 0;
+	else if (!strcmp("rebase-cousins", value))
+		options->rebase_cousins = 1;
+	else
+		die(_("Unknown rebase-merges mode: %s"), value);
+}
+
 static int rebase_config(const char *var, const char *value, void *data)
 {
 	struct rebase_options *opts = data;
@@ -801,6 +814,16 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
+	if (!strcmp(var, "rebase.rebasemerges")) {
+		opts->config_rebase_merges = git_parse_maybe_bool(value);
+		if (opts->config_rebase_merges < 0) {
+			opts->config_rebase_merges = 1;
+			parse_rebase_merges_value(opts, value);
+		} else
+			opts->rebase_cousins = 0;
+		return 0;
+	}
+
 	if (!strcmp(var, "rebase.updaterefs")) {
 		opts->config_update_refs = git_config_bool(var, value);
 		return 0;
@@ -981,6 +1004,28 @@ static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int parse_opt_rebase_merges(const struct option *opt, const char *arg, int unset)
+{
+	struct rebase_options *options = opt->value;
+
+	options->rebase_merges = !unset;
+	options->rebase_cousins = 0;
+
+	if (arg) {
+		if (!*arg) {
+			warning(_("--rebase-merges with an empty string "
+				  "argument is deprecated and will stop "
+				  "working in a future version of Git. Use "
+				  "--rebase-merges without an argument "
+				  "instead, which does the same thing."));
+			return 0;
+		}
+		parse_rebase_merges_value(options, arg);
+	}
+
+	return 0;
+}
+
 static void NORETURN error_on_missing_default_upstream(void)
 {
 	struct branch *current_branch = branch_get(NULL);
@@ -1036,7 +1081,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct object_id branch_base;
 	int ignore_whitespace = 0;
 	const char *gpg_sign = NULL;
-	const char *rebase_merges = NULL;
 	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
 	struct object_id squash_onto;
 	char *squash_onto_name = NULL;
@@ -1138,10 +1182,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			   &options.allow_empty_message,
 			   N_("allow rebasing commits with empty messages"),
 			   PARSE_OPT_HIDDEN),
-		{OPTION_STRING, 'r', "rebase-merges", &rebase_merges,
-			N_("mode"),
+		OPT_CALLBACK_F('r', "rebase-merges", &options, N_("mode"),
 			N_("try to rebase merges instead of skipping them"),
-			PARSE_OPT_OPTARG, NULL, (intptr_t)"no-rebase-cousins"},
+			PARSE_OPT_OPTARG, parse_opt_rebase_merges),
 		OPT_BOOL(0, "fork-point", &options.fork_point,
 			 N_("use 'merge-base --fork-point' to refine upstream")),
 		OPT_STRING('s', "strategy", &options.strategy,
@@ -1437,21 +1480,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.exec.nr)
 		imply_merge(&options, "--exec");
 
-	if (rebase_merges) {
-		if (!*rebase_merges)
-			warning(_("--rebase-merges with an empty string "
-				  "argument is deprecated and will stop "
-				  "working in a future version of Git. Use "
-				  "--rebase-merges without an argument "
-				  "instead, which does the same thing."));
-		else if (!strcmp("rebase-cousins", rebase_merges))
-			options.rebase_cousins = 1;
-		else if (strcmp("no-rebase-cousins", rebase_merges))
-			die(_("Unknown mode: %s"), rebase_merges);
-		options.rebase_merges = 1;
-		imply_merge(&options, "--rebase-merges");
-	}
-
 	if (options.type == REBASE_APPLY) {
 		if (ignore_whitespace)
 			strvec_push(&options.git_am_opts,
@@ -1514,13 +1542,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				break;
 
 		if (i >= 0 || options.type == REBASE_APPLY) {
-			if (is_merge(&options))
-				die(_("apply options and merge options "
-					  "cannot be used together"));
-			else if (options.autosquash == -1 && options.config_autosquash == 1)
+			if (options.autosquash == -1 && options.config_autosquash == 1)
 				die(_("apply options are incompatible with rebase.autoSquash.  Consider adding --no-autosquash"));
+			else if (options.rebase_merges == -1 && options.config_rebase_merges == 1)
+				die(_("apply options are incompatible with rebase.rebaseMerges.  Consider adding --no-rebase-merges"));
 			else if (options.update_refs == -1 && options.config_update_refs == 1)
 				die(_("apply options are incompatible with rebase.updateRefs.  Consider adding --no-update-refs"));
+			else if (is_merge(&options))
+				die(_("apply options and merge options "
+					  "cannot be used together"));
 			else
 				options.type = REBASE_APPLY;
 		}
@@ -1531,6 +1561,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	options.update_refs = (options.update_refs >= 0) ? options.update_refs :
 			     ((options.config_update_refs >= 0) ? options.config_update_refs : 0);
 
+	if (options.rebase_merges == 1)
+		imply_merge(&options, "--rebase-merges");
+	options.rebase_merges = (options.rebase_merges >= 0) ? options.rebase_merges :
+				((options.config_rebase_merges >= 0) ? options.config_rebase_merges : 0);
+
 	if (options.autosquash == 1)
 		imply_merge(&options, "--autosquash");
 	options.autosquash = (options.autosquash >= 0) ? options.autosquash :
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index 4711b37a28..2eba00bdf5 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -85,6 +85,11 @@ test_rebase_am_only () {
 		test_must_fail git rebase $opt --reapply-cherry-picks A
 	"
 
+	test_expect_success "$opt incompatible with --rebase-merges" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --rebase-merges A
+	"
+
 	test_expect_success "$opt incompatible with --update-refs" "
 		git checkout B^0 &&
 		test_must_fail git rebase $opt --update-refs A
@@ -101,6 +106,12 @@ test_rebase_am_only () {
 		grep -e --no-autosquash err
 	"
 
+	test_expect_success "$opt incompatible with rebase.rebaseMerges" "
+		git checkout B^0 &&
+		test_must_fail git -c rebase.rebaseMerges=true rebase $opt A 2>err &&
+		grep -e --no-rebase-merges err
+	"
+
 	test_expect_success "$opt incompatible with rebase.updateRefs" "
 		git checkout B^0 &&
 		test_must_fail git -c rebase.updateRefs=true rebase $opt A 2>err &&
@@ -113,6 +124,12 @@ test_rebase_am_only () {
 		git -c rebase.autosquash=true rebase --no-autosquash $opt A
 	"
 
+	test_expect_success "$opt okay with overridden rebase.rebaseMerges" "
+		test_when_finished \"git reset --hard B^0\" &&
+		git checkout B^0 &&
+		git -c rebase.rebaseMerges=true rebase --no-rebase-merges $opt A
+	"
+
 	test_expect_success "$opt okay with overridden rebase.updateRefs" "
 		test_when_finished \"git reset --hard B^0\" &&
 		git checkout B^0 &&
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index d46d9545f2..f03599c63b 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -278,6 +278,40 @@ test_expect_success 'do not rebase cousins unless asked for' '
 	EOF
 '
 
+test_expect_success 'rebase.rebaseMerges=rebase-cousins is equivalent to --rebase-merges=rebase-cousins' '
+	test_config rebase.rebaseMerges rebase-cousins &&
+	git checkout -b config-rebase-cousins main &&
+	git rebase HEAD^ &&
+	test_cmp_graph HEAD^.. <<-\EOF
+	*   Merge the topic branch '\''onebranch'\''
+	|\
+	| * D
+	| * G
+	|/
+	o H
+	EOF
+'
+
+test_expect_success '--no-rebase-merges overrides rebase.rebaseMerges=no-rebase-cousins' '
+	test_config rebase.rebaseMerges no-rebase-cousins &&
+	git checkout -b override-config-no-rebase-cousins E &&
+	git rebase --no-rebase-merges C &&
+	test_cmp_graph C.. <<-\EOF
+	* B
+	* D
+	o C
+	EOF
+'
+
+test_expect_success '--rebase-merges overrides rebase.rebaseMerges=rebase-cousins' '
+	test_config rebase.rebaseMerges rebase-cousins &&
+	git checkout -b override-config-rebase-cousins E &&
+	before="$(git rev-parse --verify HEAD)" &&
+	test_tick &&
+	git rebase --rebase-merges C &&
+	test_cmp_rev HEAD $before
+'
+
 test_expect_success 'refs/rewritten/* is worktree-local' '
 	git worktree add wt &&
 	cat >wt/script-from-scratch <<-\EOF &&
-- 
2.40.0

