Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4202C64EC4
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 05:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjBVFR4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 00:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjBVFRv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 00:17:51 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451DB1A6
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 21:17:48 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id e9so2505719plh.2
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 21:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zy3sW8uA3MhsUVOoY1u4ty1u+8drQDBuJdx6Efd8y38=;
        b=pj40V7S58SDICh79dgF/UfCByACSV7Hf5L0Ly0viUcGP21iXt36vWVmyG+gSBpAF6f
         kZefEPcrNB2PitQ3keA8DXzhCxMs8xZ+VOFQJotW0ySzlGOwzAXbnDG6jjHeuTDhVjVG
         fQ0spZxtfGr+X4V/27xeZGv6Jb8s5qvih8gXqnJd7HWWDXEYK0Xnz02w7Hq4/WYVyCRr
         DKqObNhERCeg9BQlKhTMkHJYnEXhoPVymewPIjex1TK1Ba4vKiwAlhhtXRChLVNQk+rf
         w9GaZlAonkjGdlc1VOpmoOSOr/IaNaRcyD/Ht6CFZedVFpLsFG/n4fnSZwLK+2rcrYVN
         ueeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zy3sW8uA3MhsUVOoY1u4ty1u+8drQDBuJdx6Efd8y38=;
        b=hRbqZJCccqppUcvUeM9hIf8ChUgtVT/PalDYSQRVILktWNzYy6reyBqJhSKCRysA8L
         TYS4b8MxWNJ7jdTbttQMXGpL033+4zgcGpXykYUgkeQ3iJZosFqJfFWWAE7hfQLydOJu
         F/GoRcHSTGtek/S0fBio0cYQXc+5sjGKjijjIDcpphNmVeRdlsoSCQfM8UOGj5F3epd6
         i1NyDOCgVNt3ALjUj3qM+Fnez+qAzOZcVCbu33vGYn0j+XBsvhHwKbuGQNJiAmsBqZBM
         29ioCsCTba8VkNjv4tsZm8lL6pR+kQp0RJO12Q0GiBvbs+KFujraDynwlru0b23SkXvN
         14bA==
X-Gm-Message-State: AO0yUKXz0eKyu3UUPqO1+NVWziInUrIBca5vs7wO5sfGKiQkWZuC1S4Q
        sKft9gSxN/eu31urV+rFJNFDO0Rgr1M=
X-Google-Smtp-Source: AK7set+m1leghxs8t+1rGlwhaVwnpaq94vOIU0TwOwXJSYmn55Q7e0Ea1GgqSeMYC8CtwEroHbcmnQ==
X-Received: by 2002:a17:902:e884:b0:198:dd3f:2847 with SMTP id w4-20020a170902e88400b00198dd3f2847mr10636614plg.21.1677043067328;
        Tue, 21 Feb 2023 21:17:47 -0800 (PST)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709029a0a00b0019abb539cddsm10720204plp.10.2023.02.21.21.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 21:17:46 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v3 3/3] rebase: add a config option for --rebase-merges
Date:   Tue, 21 Feb 2023 22:17:09 -0700
Message-Id: <20230222051709.464275-3-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230222051709.464275-1-alexhenrie24@gmail.com>
References: <20230222051709.464275-1-alexhenrie24@gmail.com>
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
 Documentation/config/rebase.txt | 10 ++++
 Documentation/git-rebase.txt    |  3 +-
 builtin/rebase.c                | 47 ++++++++++++----
 t/t3430-rebase-merges.sh        | 96 +++++++++++++++++++++++++++++++++
 4 files changed, 144 insertions(+), 12 deletions(-)

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
index b68fc2fbb7..45cf445d42 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -771,6 +771,20 @@ static int run_specific_rebase(struct rebase_options *opts)
 	return status ? -1 : 0;
 }
 
+static void parse_merges_value(struct rebase_options *options, const char *value)
+{
+	if (value) {
+		if (!strcmp("no-rebase-cousins", value))
+			options->rebase_cousins = 0;
+		else if (!strcmp("rebase-cousins", value))
+			options->rebase_cousins = 1;
+		else
+			die(_("Unknown mode: %s"), value);
+	}
+
+	options->rebase_merges = 1;
+}
+
 static int rebase_config(const char *var, const char *value, void *data)
 {
 	struct rebase_options *opts = data;
@@ -815,6 +829,13 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
+	if (!strcmp(var, "rebase.merges") && value && *value) {
+		opts->rebase_merges = git_parse_maybe_bool(value);
+		if (opts->rebase_merges < 0)
+			parse_merges_value(opts, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "rebase.backend")) {
 		return git_config_string(&opts->default_backend, var, value);
 	}
@@ -980,6 +1001,18 @@ static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int parse_opt_merges(const struct option *opt, const char *arg, int unset)
+{
+	struct rebase_options *options = opt->value;
+
+	if (unset)
+		options->rebase_merges = 0;
+	else
+		parse_merges_value(options, arg);
+
+	return 0;
+}
+
 static void NORETURN error_on_missing_default_upstream(void)
 {
 	struct branch *current_branch = branch_get(NULL);
@@ -1035,7 +1068,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct object_id branch_base;
 	int ignore_whitespace = 0;
 	const char *gpg_sign = NULL;
-	const char *rebase_merges = NULL;
 	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
 	struct object_id squash_onto;
 	char *squash_onto_name = NULL;
@@ -1137,10 +1169,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			   &options.allow_empty_message,
 			   N_("allow rebasing commits with empty messages"),
 			   PARSE_OPT_HIDDEN),
-		{OPTION_STRING, 'r', "rebase-merges", &rebase_merges,
-			N_("mode"),
+		OPT_CALLBACK_F('r', "rebase-merges", &options, N_("mode"),
 			N_("try to rebase merges instead of skipping them"),
-			PARSE_OPT_OPTARG, NULL, (intptr_t)"no-rebase-cousins"},
+			PARSE_OPT_OPTARG, parse_opt_merges),
 		OPT_BOOL(0, "fork-point", &options.fork_point,
 			 N_("use 'merge-base --fork-point' to refine upstream")),
 		OPT_STRING('s', "strategy", &options.strategy,
@@ -1436,14 +1467,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.exec.nr)
 		imply_merge(&options, "--exec");
 
-	if (rebase_merges) {
-		if (!strcmp("rebase-cousins", rebase_merges))
-			options.rebase_cousins = 1;
-		else if (strcmp("no-rebase-cousins", rebase_merges))
-			die(_("Unknown mode: %s"), rebase_merges);
-		options.rebase_merges = 1;
+	if (options.rebase_merges)
 		imply_merge(&options, "--rebase-merges");
-	}
 
 	if (options.type == REBASE_APPLY) {
 		if (ignore_whitespace)
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index b8ba323dbc..88d347cea5 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -299,6 +299,102 @@ test_expect_success '--rebase-merges="" is invalid syntax' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rebase.merges="" is equivalent to not passing --rebase-merges' '
+	test_config rebase.merges "" &&
+	git checkout -b config-merges-blank E &&
+	git rebase C &&
+	test_cmp_graph C.. <<-\EOF
+	* B
+	* D
+	o C
+	EOF
+'
+
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
+test_expect_success 'local rebase.merges=false overrides global rebase.merges=true' '
+	test_config_global rebase.merges true &&
+	test_config rebase.merges false &&
+	git checkout -b override-global-config E &&
+	git rebase C &&
+	test_cmp_graph C.. <<-\EOF
+	* B
+	* D
+	o C
+	EOF
+'
+
+test_expect_success 'local rebase.merges="" does not override global rebase.merges=true' '
+	test_config_global rebase.merges no-rebase-cousins &&
+	test_config rebase.merges "" &&
+	git checkout -b no-override-global-config E &&
+	before="$(git rev-parse --verify HEAD)" &&
+	test_tick &&
+	git rebase C &&
+	test_cmp_rev HEAD $before
+'
+
 test_expect_success 'refs/rewritten/* is worktree-local' '
 	git worktree add wt &&
 	cat >wt/script-from-scratch <<-\EOF &&
-- 
2.39.2

