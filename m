Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A253C64EC7
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 18:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBYSFB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 13:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjBYSE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 13:04:57 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D91136DD
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 10:04:55 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id l15so2748752pls.1
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 10:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MpaiMr9f2SINNyrRde8aDhAYCS6ntT6dc45Jqe4RLo=;
        b=dQNWFmRYBKhcKbdDwtRnKx5Tloz/D2IyKPc9D2m4cuif33+ccgJq6Yq1z59dqRabyH
         1m8veriubOt0/4S6YqrcnNtGMNpQMosfjLT/Cx2XebaRH1kMcKwWSmDC1YcC6qQvmYNe
         T3g4sEc0Dtf9WY3DgvXrWnPJuyngmJl+jE14l9IbBgVm/8BdkmzvXv+1XIjP3RF+J4G1
         n0nPfKES6d9jEWP+KWBqU35mPYf5odLvLvKEQLLp5FaG3+TvWSHEEZZDj1rd0ze1ux9P
         jlQy4D68FPowIsE1DtF7Nad9S0Zk/tH0dTbAFEALSUJfePxvzu7tEKMK+3TYTun8NSvE
         DuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MpaiMr9f2SINNyrRde8aDhAYCS6ntT6dc45Jqe4RLo=;
        b=AW2LMBuuSgZRJSSMWN1IE0sHzxUITBCVpGsiam8XwhorBJFGhXFVsDxvAvx6qaQWzG
         gU4acnEM/p4klN6td/D1E+2dEPTwJsCG+ErqLX3AKfg1tp/b1pYEz/cMTV4g3LdrbZg0
         atSBAx/fCaLrjtKBVs/JG4xGH9onaKegf5IGmF4T7hPDJ/yiVzds8n2DmzrkyYaDNKl1
         HNTWUXP7r+g6YJpmqsXpPELOzY2ITCCtdNLQd2q4KCcPHdR61zgn4CxaWa7nkaCbROgZ
         TH5Tr7uKRnUswVmdiYc3hyvXWBg6v71gTwBrFVg2YcW2r7WJgfFI3wNKB9MhQ0aMZ5o6
         BB+w==
X-Gm-Message-State: AO0yUKWaHtDdYHM61FxCQl4PATDuPjTTUYCwCsBxVEhGKGY2T4ZQ87i4
        b4PWW80rWeBxxkSPAldhFBLyOefRsko=
X-Google-Smtp-Source: AK7set+IOLeOwS8n9TL5pCCIeEYEp3veyegmd6Mzn3cTwFv70eR/OqvMYj+RQ45g0ydtwX7Ol14Vwg==
X-Received: by 2002:a05:6a20:1610:b0:c0:c429:cbbd with SMTP id l16-20020a056a20161000b000c0c429cbbdmr20264917pzj.6.1677348294342;
        Sat, 25 Feb 2023 10:04:54 -0800 (PST)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id x18-20020a62fb12000000b005cd17607358sm1473547pfm.87.2023.02.25.10.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 10:04:53 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v5 3/3] rebase: add a config option for --rebase-merges
Date:   Sat, 25 Feb 2023 11:03:25 -0700
Message-Id: <20230225180325.796624-4-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230225180325.796624-1-alexhenrie24@gmail.com>
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230225180325.796624-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The purpose of the new option is to accommodate users who would like
--rebase-merges to be on by default and to facilitate possibly turning
on --rebase-merges by default without configuration in a future version
of Git.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/config/rebase.txt        | 10 ++++
 Documentation/git-rebase.txt           |  3 +-
 builtin/rebase.c                       | 79 ++++++++++++++++++--------
 t/t3422-rebase-incompatible-options.sh | 12 ++++
 t/t3430-rebase-merges.sh               | 63 ++++++++++++++++++++
 5 files changed, 143 insertions(+), 24 deletions(-)

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
index f19bd0e040..308baa9dbb 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -67,3 +67,13 @@ rebase.rescheduleFailedExec::
 
 rebase.forkPoint::
 	If set to false set `--no-fork-point` option by default.
+
+rebase.merges::
+	Whether and how to set the `--rebase-merges` option by default. Can
+	be `rebase-cousins`, `no-rebase-cousins`, or a boolean. Setting to
+	true is equivalent to `--rebase-merges` without an argument, setting to
+	`rebase-cousins` or `no-rebase-cousins` is equivalent to
+	`--rebase-merges` with that value as its argument, and setting to false
+	is equivalent to `--no-rebase-merges`. Passing `--rebase-merges` on the
+	command line without an argument overrides a `rebase.merges=false`
+	configuration but does not override other values of `rebase.merge`.
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index c98784a0d2..b02f9cbb8c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -537,7 +537,8 @@ See also INCOMPATIBLE OPTIONS below.
 	by recreating the merge commits. Any resolved merge conflicts or
 	manual amendments in these merge commits will have to be
 	resolved/re-applied manually. `--no-rebase-merges` can be used to
-	countermand a previous `--rebase-merges`.
+	countermand both the `rebase.merges` config option and a previous
+	`--rebase-merges`.
 +
 By default, or when `no-rebase-cousins` was specified, commits which do not
 have `<upstream>` as direct ancestor will keep their original branch point,
diff --git a/builtin/rebase.c b/builtin/rebase.c
index ccc13200b5..ac096f27e1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -123,6 +123,7 @@ struct rebase_options {
 	int fork_point;
 	int update_refs;
 	int config_autosquash;
+	int config_rebase_merges;
 	int config_update_refs;
 };
 
@@ -140,6 +141,8 @@ struct rebase_options {
 		.allow_empty_message = 1,               \
 		.autosquash = -1,                       \
 		.config_autosquash = -1,                \
+		.rebase_merges = -1,                    \
+		.config_rebase_merges = -1,             \
 		.update_refs = -1,                      \
 		.config_update_refs = -1,               \
 	}
@@ -771,6 +774,16 @@ static int run_specific_rebase(struct rebase_options *opts)
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
@@ -800,6 +813,15 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
+	if (!strcmp(var, "rebase.merges")) {
+		opts->config_rebase_merges = git_parse_maybe_bool(value);
+		if (opts->config_rebase_merges < 0) {
+			opts->config_rebase_merges = 1;
+			parse_rebase_merges_value(opts, value);
+		}
+		return 0;
+	}
+
 	if (!strcmp(var, "rebase.updaterefs")) {
 		opts->config_update_refs = git_config_bool(var, value);
 		return 0;
@@ -980,6 +1002,27 @@ static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int parse_opt_rebase_merges(const struct option *opt, const char *arg, int unset)
+{
+	struct rebase_options *options = opt->value;
+
+	options->rebase_merges = !unset;
+
+	if (arg) {
+		if (!*arg) {
+			warning(_("--rebase-merges with an empty string "
+				  "argument is deprecated and will stop "
+				  "working in a future version of Git. Use "
+				  "--rebase-merges=no-rebase-cousins "
+				  "instead."));
+			arg = "no-rebase-cousins";
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
@@ -1035,7 +1078,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct object_id branch_base;
 	int ignore_whitespace = 0;
 	const char *gpg_sign = NULL;
-	const char *rebase_merges = NULL;
 	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
 	struct object_id squash_onto;
 	char *squash_onto_name = NULL;
@@ -1137,10 +1179,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
@@ -1436,21 +1477,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.exec.nr)
 		imply_merge(&options, "--exec");
 
-	if (rebase_merges) {
-		if (!*rebase_merges)
-			warning(_("--rebase-merges with an empty string "
-				  "argument is deprecated and will stop "
-				  "working in a future version of Git. Use "
-				  "--rebase-merges=no-rebase-cousins "
-				  "instead."));
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
@@ -1513,13 +1539,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				break;
 
 		if (i >= 0 || options.type == REBASE_APPLY) {
-			if (is_merge(&options))
-				die(_("apply options and merge options "
-					  "cannot be used together"));
-			else if (options.autosquash == -1 && options.config_autosquash == 1)
+			if (options.autosquash == -1 && options.config_autosquash == 1)
 				die(_("apply options are incompatible with rebase.autosquash.  Consider adding --no-autosquash"));
+			else if (options.rebase_merges == -1 && options.config_rebase_merges == 1)
+				die(_("apply options are incompatible with rebase.merges.  Consider adding --no-rebase-merges"));
 			else if (options.update_refs == -1 && options.config_update_refs == 1)
 				die(_("apply options are incompatible with rebase.updateRefs.  Consider adding --no-update-refs"));
+			else if (is_merge(&options))
+				die(_("apply options and merge options "
+					  "cannot be used together"));
 			else
 				options.type = REBASE_APPLY;
 		}
@@ -1530,6 +1558,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
index 4711b37a28..af93f13849 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -101,6 +101,12 @@ test_rebase_am_only () {
 		grep -e --no-autosquash err
 	"
 
+	test_expect_success "$opt incompatible with rebase.merges" "
+		git checkout B^0 &&
+		test_must_fail git -c rebase.merges=true rebase $opt A 2>err &&
+		grep -e --no-rebase-merges err
+	"
+
 	test_expect_success "$opt incompatible with rebase.updateRefs" "
 		git checkout B^0 &&
 		test_must_fail git -c rebase.updateRefs=true rebase $opt A 2>err &&
@@ -113,6 +119,12 @@ test_rebase_am_only () {
 		git -c rebase.autosquash=true rebase --no-autosquash $opt A
 	"
 
+	test_expect_success "$opt okay with overridden rebase.merges" "
+		test_when_finished \"git reset --hard B^0\" &&
+		git checkout B^0 &&
+		git -c rebase.merges=true rebase --no-rebase-merges $opt A
+	"
+
 	test_expect_success "$opt okay with overridden rebase.updateRefs" "
 		test_when_finished \"git reset --hard B^0\" &&
 		git checkout B^0 &&
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index f50fbf1390..a825a77fb4 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -283,6 +283,69 @@ test_expect_success '--rebase-merges="" is deprecated' '
 	grep deprecated actual
 '
 
+test_expect_success 'rebase.merges=rebase-cousins is equivalent to --rebase-merges=rebase-cousins' '
+	test_config rebase.merges rebase-cousins &&
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
+test_expect_success '--no-rebase-merges overrides rebase.merges=no-rebase-cousins' '
+	test_config rebase.merges no-rebase-cousins &&
+	git checkout -b override-config-no-rebase-cousins E &&
+	git rebase --no-rebase-merges C &&
+	test_cmp_graph C.. <<-\EOF
+	* B
+	* D
+	o C
+	EOF
+'
+
+test_expect_success '--rebase-merges=no-rebase-cousins overrides rebase.merges=rebase-cousins' '
+	test_config rebase.merges rebase-cousins &&
+	git checkout -b override-config-rebase-cousins main &&
+	git rebase --rebase-merges=no-rebase-cousins HEAD^ &&
+	test_cmp_graph HEAD^.. <<-\EOF
+	*   Merge the topic branch '\''onebranch'\''
+	|\
+	| * D
+	| * G
+	o | H
+	|/
+	o A
+	EOF
+'
+
+test_expect_success '--rebase-merges overrides rebase.merges=false' '
+	test_config rebase.merges false &&
+	git checkout -b override-config-merges-false E &&
+	before="$(git rev-parse --verify HEAD)" &&
+	test_tick &&
+	git rebase --rebase-merges C &&
+	test_cmp_rev HEAD $before
+'
+
+test_expect_success '--rebase-merges does not override rebase.merges=rebase-cousins' '
+	test_config rebase.merges rebase-cousins &&
+	git checkout -b no-override-config-rebase-cousins main &&
+	git rebase --rebase-merges HEAD^ &&
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
 test_expect_success 'refs/rewritten/* is worktree-local' '
 	git worktree add wt &&
 	cat >wt/script-from-scratch <<-\EOF &&
-- 
2.39.2

