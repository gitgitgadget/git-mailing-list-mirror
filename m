Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F169EC07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC622613AE
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhGEMfe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhGEMfd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:33 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5217C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:56 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u11so20612266oiv.1
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H/6WM4+ZiIqjZbE6bRQGmxLuso3TtwryNg+BP6KbkpQ=;
        b=Fyhe9gPXlhUysnGmX6E3K3nKmF6hHfzFLdOpHwzoGBPm3jBpzhp86qu5AVysapH6P6
         8nKN1ObuH93M/WYEXK3dypSRvaDTVO6LuFV3NJDLv2iCLrICWLZGDK3hkv8z5jr+q1mI
         LJKXFpMcr+aW9Kk+9QliWUJMXT+rotTXE3g8ZQwqV0AyNWtiQZ3nlY5j7038OI5gKwYx
         K6+ydTsWUiIpgXImtM9WPkKr7TD7x1uUsiNkmlNH6pjGWNzHU8ngS4VyXqvxFE7wnETm
         YB/xvQwjB3/DWIwdqAlxp6jYs7CqNFxgoEasA+PqfUuhoXxH3HzJb1kAnDW4ygjozNoa
         JkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/6WM4+ZiIqjZbE6bRQGmxLuso3TtwryNg+BP6KbkpQ=;
        b=qlV3nFNipPWVnu5MS43JkZStyffpIIXg8k+GAD8ZBj1IGtcZ7HBzwZ1FrE+LmsKSeP
         6Wf2F0Zun6/2uWi/pKqN8IpGSQVdQWmRT01/m3nWt+t5Qb/8q64Z+YNcvF14P5vTVpzx
         0UQIydMyC2VqY591+CJvOCmGVrchGReaYXDLlgcRHFpbPnRdwZ5I7QfcCewgVhgfazsJ
         aJLOGjPUC2ZPF3AQHAnqCh9pUn4exZIA5mYVPsNo4URhYekuAx2jl9Vc0OuC5wgaWIeo
         3S+RYpTcxHjMEMdO+/oTGerK/bk1RD8s2EKf9FjYFKdaC8B4NivSeEPmpyaCrCvue1YF
         rOtA==
X-Gm-Message-State: AOAM531pnwawBMMIuyAtXN0GLwMxU/DhwdEchVzyyDKhh2zi7YNSAcqE
        mA1kTP5jP0MOCT4+RZ0dZgYR2slT97wefg==
X-Google-Smtp-Source: ABdhPJy1eHspga8TX/JXr7Ydi5bNiDptU1ALDsfrqOdQDDPkxKE5VqZLnGF4diu+gTREFuqHdrlLdg==
X-Received: by 2002:a54:4398:: with SMTP id u24mr9948351oiv.81.1625488375987;
        Mon, 05 Jul 2021 05:32:55 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id c4sm2618352ots.15.2021.07.05.05.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:55 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 26/35] pull: add pull.mode
Date:   Mon,  5 Jul 2021 07:32:00 -0500
Message-Id: <20210705123209.1808663-27-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The evolution of pull options has somewhat served most users, however,
they have been found lacking for a very needed trio: merge / rebase /
fast-forward-only.

To avoid some of the problems of git pull Linus Torvalds suggested a
configuration pull.merge [1], however, instead of having pull.merge and
pull.rebase, we can have pull.mode which works for both.

Additionally this would allow us to have a saner per-branch
configuration: branch.<name>.pullMode.

This patch adds a pull.mode option with two possible values (for now);
merge and rebase. If set, it overrides what the user has specified in
pull.rebase, and it's updated with either --merge, or --rebase.

[1] https://lore.kernel.org/git/CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com/

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/pull.txt |  5 +++
 builtin/pull.c                | 68 ++++++++++++++++++++++++++++++++---
 rebase.c                      | 10 ++++++
 rebase.h                      |  9 +++++
 t/t5520-pull.sh               | 42 ++++++++++++++++++++++
 t/t7601-merge-pull-config.sh  | 14 ++++++++
 6 files changed, 143 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/pull.txt b/Documentation/config/pull.txt
index 5404830609..646431a02d 100644
--- a/Documentation/config/pull.txt
+++ b/Documentation/config/pull.txt
@@ -29,6 +29,11 @@ mode.
 it unless you understand the implications (see linkgit:git-rebase[1]
 for details).
 
+pull.mode::
+	When "git pull" is run, this determines if it would either merge or
+	rebase the fetched branch. The possible values are 'merge',
+	and 'rebase'.
+
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
 	at once.
diff --git a/builtin/pull.c b/builtin/pull.c
index 2c2f0822d5..124575c32c 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -27,6 +27,8 @@
 #include "commit-reach.h"
 #include "sequencer.h"
 
+static enum pull_mode_type mode;
+
 /**
  * Parses the value of --rebase. If value is a false value, returns
  * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value is
@@ -49,6 +51,14 @@ static enum rebase_type parse_config_rebase(const char *key, const char *value,
 	return REBASE_INVALID;
 }
 
+static enum pull_mode_type parse_config_pull_mode(const char *key, const char *value)
+{
+	enum pull_mode_type v = pull_mode_parse_value(value);
+	if (v == PULL_MODE_INVALID)
+		die(_("Invalid value for %s: %s"), key, value);
+	return v;
+}
+
 /**
  * Callback for --rebase, which parses arg with parse_config_rebase().
  */
@@ -60,9 +70,21 @@ static int parse_opt_rebase(const struct option *opt, const char *arg, int unset
 		*value = parse_config_rebase("--rebase", arg, 0);
 	else
 		*value = unset ? REBASE_FALSE : REBASE_TRUE;
+
+	if (*value > 0)
+		mode = *value >= REBASE_TRUE ? PULL_MODE_REBASE : PULL_MODE_MERGE;
+
 	return *value == REBASE_INVALID ? -1 : 0;
 }
 
+static int parse_opt_merge(const struct option *opt, const char *arg, int unset)
+{
+	enum rebase_type *value = opt->value;
+	mode = PULL_MODE_MERGE;
+	*value = REBASE_FALSE;
+	return 0;
+}
+
 static const char * const pull_usage[] = {
 	N_("git pull [<options>] [<repository> [<refspec>...]]"),
 	NULL
@@ -129,8 +151,9 @@ static struct option pull_options[] = {
 		"(false|true|merges|preserve|interactive)",
 		N_("incorporate changes by rebasing rather than merging"),
 		PARSE_OPT_OPTARG, parse_opt_rebase),
-	OPT_SET_INT('m', "merge", &opt_rebase,
-		N_("incorporate changes by merging"), REBASE_FALSE),
+	OPT_CALLBACK_F('m', "merge", &opt_rebase, NULL,
+		N_("incorporate changes by merging"),
+		PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_merge),
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
@@ -349,6 +372,16 @@ static enum rebase_type config_get_rebase(void)
 	return REBASE_DEFAULT;
 }
 
+static enum pull_mode_type config_get_pull_mode(const char *repo)
+{
+	const char *value;
+
+	if (!git_config_get_value("pull.mode", &value))
+		return parse_config_pull_mode("pull.mode", value);
+
+	return PULL_MODE_DEFAULT;
+}
+
 /**
  * Read config variables.
  */
@@ -931,9 +964,9 @@ static void show_advice_pull_non_ff(void)
 		 "discouraged. You can squelch this message by running one of the following\n"
 		 "commands sometime before your next pull:\n"
 		 "\n"
-		 "  git config pull.rebase false  # merge (the default strategy)\n"
-		 "  git config pull.rebase true   # rebase\n"
-		 "  git config pull.ff only       # fast-forward only\n"
+		 "  git config pull.mode merge  # the default strategy\n"
+		 "  git config pull.mode rebase\n"
+		 "  git config pull.ff only     # fast-forward only\n"
 		 "\n"
 		 "You can replace \"git config\" with \"git config --global\" to set a default\n"
 		 "preference for all repositories. You can also pass --rebase, --merge,\n"
@@ -968,6 +1001,31 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
+	/*
+	 * If the user has not specified --merge or --rebase, fetch pull.mode to override
+	 * pull.rename.
+	 */
+	if (!mode) {
+		mode = config_get_pull_mode(repo);
+
+		switch (mode) {
+		case PULL_MODE_MERGE:
+			opt_rebase = REBASE_FALSE;
+			break;
+		case PULL_MODE_REBASE:
+			/* Do not oeverride other rebase modes */
+			if (opt_rebase < REBASE_TRUE)
+				opt_rebase = REBASE_TRUE;
+			break;
+		case PULL_MODE_DEFAULT:
+			if (opt_rebase > 0)
+				mode = opt_rebase >= REBASE_TRUE ? PULL_MODE_REBASE : PULL_MODE_MERGE;
+			break;
+		default:
+			break;
+		}
+	}
+
 	if (read_cache_unmerged())
 		die_resolve_conflict("pull");
 
diff --git a/rebase.c b/rebase.c
index f8137d859b..bdfca49886 100644
--- a/rebase.c
+++ b/rebase.c
@@ -33,3 +33,13 @@ enum rebase_type rebase_parse_value(const char *value)
 
 	return REBASE_INVALID;
 }
+
+enum pull_mode_type pull_mode_parse_value(const char *value)
+{
+	if (!strcmp(value, "merge") || !strcmp(value, "m"))
+		return PULL_MODE_MERGE;
+	else if (!strcmp(value, "rebase") || !strcmp(value, "r"))
+		return PULL_MODE_REBASE;
+
+	return PULL_MODE_INVALID;
+}
diff --git a/rebase.h b/rebase.h
index 34d4acfd74..5ab8f4ddd5 100644
--- a/rebase.h
+++ b/rebase.h
@@ -13,4 +13,13 @@ enum rebase_type {
 
 enum rebase_type rebase_parse_value(const char *value);
 
+enum pull_mode_type {
+	PULL_MODE_INVALID = -1,
+	PULL_MODE_DEFAULT = 0,
+	PULL_MODE_MERGE,
+	PULL_MODE_REBASE
+};
+
+enum pull_mode_type pull_mode_parse_value(const char *value);
+
 #endif /* REBASE */
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index e2c0c51022..663c15fcd7 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -452,6 +452,16 @@ test_expect_success 'pull.rebase' '
 	test_cmp expect actual
 '
 
+test_expect_success 'pull.mode rebase' '
+	git reset --hard before-rebase &&
+	test_config pull.mode rebase &&
+	git pull . copy &&
+	test_cmp_rev HEAD^ copy &&
+	echo new >expect &&
+	git show HEAD:file2 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'pull --autostash & pull.rebase=true' '
 	test_config pull.rebase true &&
 	test_pull_autostash 1 --autostash
@@ -526,6 +536,17 @@ test_expect_success 'pull.rebase=false create a new merge commit' '
 	test_cmp expect actual
 '
 
+test_expect_success 'pull.mode=merge create a new merge commit' '
+	git reset --hard before-preserve-rebase &&
+	test_config pull.mode merge &&
+	git pull . copy &&
+	test_cmp_rev HEAD^1 before-preserve-rebase &&
+	test_cmp_rev HEAD^2 copy &&
+	echo file3 >expect &&
+	git show HEAD:file3.t >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'pull.rebase=true flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase true &&
@@ -555,6 +576,16 @@ test_expect_success REBASE_P \
 	test_cmp_rev HEAD^2 keep-merge
 '
 
+test_expect_success REBASE_P \
+	'pull.rebase=preserve rebases and merges keep-merge with pull.mode' '
+	git reset --hard before-preserve-rebase &&
+	test_config pull.mode rebase &&
+	test_config pull.rebase preserve &&
+	git pull . copy &&
+	test_cmp_rev HEAD^^ copy &&
+	test_cmp_rev HEAD^2 keep-merge
+'
+
 test_expect_success 'pull.rebase=interactive' '
 	write_script "$TRASH_DIRECTORY/fake-editor" <<-\EOF &&
 	echo I was here >fake.out &&
@@ -596,6 +627,17 @@ test_expect_success '--rebase=false create a new merge commit' '
 	test_cmp expect actual
 '
 
+test_expect_success '--rebase=false create a new merge commit with pull.mode' '
+	git reset --hard before-preserve-rebase &&
+	test_config pull.mode rebase &&
+	git pull --rebase=false . copy &&
+	test_cmp_rev HEAD^1 before-preserve-rebase &&
+	test_cmp_rev HEAD^2 copy &&
+	echo file3 >expect &&
+	git show HEAD:file3.t >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--rebase=true rebases and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase preserve &&
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 7c4607191a..47fd2e2d05 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -33,6 +33,13 @@ test_expect_success 'pull.rebase not set' '
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
+test_expect_success 'pull.mode set' '
+	git reset --hard c0 &&
+	test_config pull.mode merge &&
+	git pull . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
 test_expect_success 'pull.rebase not set and pull.ff=true' '
 	git reset --hard c0 &&
 	test_config pull.ff true &&
@@ -92,6 +99,13 @@ test_expect_success 'pull.rebase not set (not-fast-forward)' '
 	test_i18ngrep "Pulling without specifying how to reconcile" decoded
 '
 
+test_expect_success 'pull.mode set' '
+	git reset --hard c2 &&
+	test_config pull.mode merge &&
+	git pull . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
 test_expect_success 'pull.rebase not set and pull.ff=true (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff true &&
-- 
2.32.0.36.g70aac2b1aa

