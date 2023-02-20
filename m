Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5138C64EC4
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 03:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjBTDdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Feb 2023 22:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjBTDdE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2023 22:33:04 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54E1C165
        for <git@vger.kernel.org>; Sun, 19 Feb 2023 19:33:02 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id h14so54773plf.10
        for <git@vger.kernel.org>; Sun, 19 Feb 2023 19:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTdrOZ6kMinhfcBBxzk5BtXaaZA6L8UQF4gNqBrd9UQ=;
        b=X7n9z5Ru17qxv8QB+k85CVrtcB9ufCeW+fGhKES/Yt8U52Wfn/XuiTDmcwCNZgH4yY
         UWQXOGygTP7FW7gi4ZvvZardTS6Q9PIeAh6V6U4ITBwT7a4VtcRloztS1f9R3a7MAUEk
         t/IJuvb9EYpZy9datfTYihAHNSouZT1A1pFI69ASK0ncx7C/UjmakWQ14ytpoFcxmw6q
         0XGrwabJnsnD9rxXlPKgZVzNc0inTqedd3cYpP2pHS0MVP1lVR+ypEyCFGdiPS+cg8Vy
         UFyosMXn2YZjXbdIPY5NAp0rRnHEETmOICvXM/YQMDYRiEF5aUy+pXOly0g8gT+/krFl
         m17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTdrOZ6kMinhfcBBxzk5BtXaaZA6L8UQF4gNqBrd9UQ=;
        b=C49sKfstm8kU9KhNqkxkLFRZfenGKySUK6RhorRakzOHY2qGPBcmHCbxKhhG7h6sX5
         hXKCNVo1144j6MfQFVvfp3/6Jbga7wNLJxf1274s86Po7kqIRBnD1xTZ6mbcDgtY4/py
         cjrcAarHgl7COi/5aWxXFWBorPjhJAH7WxSfYvuXwp0gLZXLBhS55jyhC0x/OEIFYXF3
         rhY4VnWU3buTfzKrZnRXPHamWrtvbTS8GGw/oITz3+DqRpptYC3lipgwE2/z4iZG63Gw
         odvs6/tfWXRZ5Q2zp7PGdxrq/3KSsBZI7J67DSK57rgV8gkTaCIK/IWAXMOMb8HcOcoE
         iz3w==
X-Gm-Message-State: AO0yUKUKUL/hQxd1qUvztfdo70WGWYaAp/PjHYx+OEemKxjz2JxizOBY
        0GkoLwd4wPbGNaJzZy3TxaJqi1HPaZ8=
X-Google-Smtp-Source: AK7set9Acsr4G+r21Br5WIGO6hcxZX3iFRCjdlf9pBy9XN1bN1PSHPkaElC1HMMXb9eO5NXK0gcxnQ==
X-Received: by 2002:a05:6a21:338f:b0:c6:5d8b:494b with SMTP id yy15-20020a056a21338f00b000c65d8b494bmr9828152pzb.33.1676863981731;
        Sun, 19 Feb 2023 19:33:01 -0800 (PST)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d30400b0019462aa090bsm2160747plc.284.2023.02.19.19.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 19:33:01 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH 2/2] rebase: add a config option for --rebase-merges
Date:   Sun, 19 Feb 2023 20:32:24 -0700
Message-Id: <20230220033224.10400-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230220033224.10400-1-alexhenrie24@gmail.com>
References: <20230220033224.10400-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the same time, stop accepting --rebase-merges="" as a synonym of
--rebase-merges=no-rebase-cousins.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/config/rebase.txt |  3 ++
 builtin/rebase.c                | 50 ++++++++++++++-----
 t/t3430-rebase-merges.sh        | 87 +++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 13 deletions(-)

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
index f19bd0e040..d956ec4441 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -67,3 +67,6 @@ rebase.rescheduleFailedExec::
 
 rebase.forkPoint::
 	If set to false set `--no-fork-point` option by default.
+
+rebase.merges::
+	Default value of `--rebase-merges` option.
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 96c0474379..ab4c3b2870 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -771,6 +771,25 @@ static int run_specific_rebase(struct rebase_options *opts)
 	return status ? -1 : 0;
 }
 
+static void parse_merges_value(struct rebase_options *options, const char *value)
+{
+	if (value) {
+		if (!strcmp("drop", value)) {
+			options->rebase_merges = 0;
+			return;
+		}
+
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
@@ -815,6 +834,14 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
+	if (!strcmp(var, "rebase.merges")) {
+		const char *rebase_merges;
+		if (!git_config_string(&rebase_merges, var, value) &&
+		    rebase_merges && *rebase_merges)
+			parse_merges_value(opts, rebase_merges);
+		return 0;
+	}
+
 	if (!strcmp(var, "rebase.backend")) {
 		return git_config_string(&opts->default_backend, var, value);
 	}
@@ -980,6 +1007,13 @@ static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int parse_opt_merges(const struct option *opt, const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	parse_merges_value(opt->value, arg);
+	return 0;
+}
+
 static void NORETURN error_on_missing_default_upstream(void)
 {
 	struct branch *current_branch = branch_get(NULL);
@@ -1035,7 +1069,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct object_id branch_base;
 	int ignore_whitespace = 0;
 	const char *gpg_sign = NULL;
-	const char *rebase_merges = NULL;
 	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
 	struct object_id squash_onto;
 	char *squash_onto_name = NULL;
@@ -1137,10 +1170,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			   &options.allow_empty_message,
 			   N_("allow rebasing commits with empty messages"),
 			   PARSE_OPT_HIDDEN),
-		{OPTION_STRING, 'r', "rebase-merges", &rebase_merges,
-			N_("mode"),
+		OPT_CALLBACK_F('r', "rebase-merges", &options, N_("mode"),
 			N_("try to rebase merges instead of skipping them"),
-			PARSE_OPT_OPTARG, NULL, (intptr_t)""},
+			PARSE_OPT_OPTARG, parse_opt_merges),
 		OPT_BOOL(0, "fork-point", &options.fork_point,
 			 N_("use 'merge-base --fork-point' to refine upstream")),
 		OPT_STRING('s', "strategy", &options.strategy,
@@ -1436,16 +1468,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.exec.nr)
 		imply_merge(&options, "--exec");
 
-	if (rebase_merges && strcmp("drop", rebase_merges)) {
-		if (!*rebase_merges)
-			; /* default mode; do nothing */
-		else if (!strcmp("rebase-cousins", rebase_merges))
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
index 861c8405f2..9be07249cc 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -298,6 +298,92 @@ test_expect_success 'do not rebase cousins unless asked for' '
 	EOF
 '
 
+test_expect_success '--rebase-merges="" is invalid syntax' '
+	echo "fatal: Unknown mode: " >expect &&
+	! git rebase --rebase-merges="" HEAD^ 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase.merges="" is equivalent to not passing --rebase-merges' '
+	git config rebase.merges "" &&
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
+	git config rebase.merges rebase-cousins &&
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
+test_expect_success '--rebase-merges=drop overrides rebase.merges=no-rebase-cousins' '
+	git config rebase.merges no-rebase-cousins &&
+	git checkout -b override-config-no-rebase-cousins E &&
+	git rebase --rebase-merges=drop C &&
+	test_cmp_graph C.. <<-\EOF
+	* B
+	* D
+	o C
+	EOF
+'
+
+test_expect_success '--rebase-merges=no-rebase-cousins overrides rebase.merges=rebase-cousins' '
+	git config rebase.merges rebase-cousins &&
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
+test_expect_success '--rebase-merges overrides rebase.merges=drop' '
+	git config rebase.merges drop &&
+	git checkout -b override-config-merges-drop main &&
+	git rebase --rebase-merges HEAD^ &&
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
+test_expect_success '--rebase-merges does not override rebase.merges=rebase-cousins' '
+	git config rebase.merges rebase-cousins &&
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
@@ -408,6 +494,7 @@ test_expect_success 'a "merge" into a root commit is a fast-forward' '
 '
 
 test_expect_success 'A root commit can be a cousin, treat it that way' '
+	git config --unset rebase.merges &&
 	git checkout --orphan khnum &&
 	test_commit yama &&
 	git checkout -b asherah main &&
-- 
2.39.2

