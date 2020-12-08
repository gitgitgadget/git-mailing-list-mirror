Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451CCC4167B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 047DA23A1D
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgLHA2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbgLHA2a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:28:30 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B902FC0619D5
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:27:22 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id h18so10375928otq.12
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AFvRhfO7Js7M74kjQk4ZtlBYBpJXOoYG9/v9Opl3OuE=;
        b=EYdBJvWpXGzzDp1j9r8UqYVnLhQ1R2IiVBzAIBkklwq2W8K2QEv+Ji/4NyGQ9tvjuY
         Im+TWEQzQHxOvb0KDI15yUE2h5c/c89a9Mf5hVzx06tGeElV79FJJxg5c4UoAPGK9d/p
         5BRSdUZ5163tUNE32Y1BzaQTzI4EURVqf0gfDkreGtr4Hmn5bQ2fA4lYnvPo2G1EiZA7
         33zhc6TlqF/j4z7FIjgh6ra5FEa7laEyT4td3drRo7mYOBnTG2+7N8SvHMInZzocw8+z
         AnFeLed3BUlElYPZmq1/ySVvmYt/IoRGKj4um4emhHTU/r871bVL9I5svTXXNyZmLy7I
         jRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AFvRhfO7Js7M74kjQk4ZtlBYBpJXOoYG9/v9Opl3OuE=;
        b=mDkseL4iMKTKXQUHfVZYaS/1Y1iZNfrR5raWBAi/TGtSPP9e5mZhNmKV2/HGGrgo1l
         ONAg24IgIj7jXUSRMHl/IovwH+O7TnG9PMQ9us+4xxB9SZcVC7N1AtGESiNtp7d4V8uI
         h8v9sM8isL3jyihMBqKHMnvAShelFM7IwZTQOr9PWFH44YIhLlY5/ShvAz4ulhb7zARc
         BALTjQqlM/fTZeslGyhoGbEYGd9Up3nqlPwjbznTsC3qIYEKz34NQZNRi26Yp9HrsYwO
         sTmkx95oNHuKEWgGy5ibkQVHxc16arCpMAourCxMJJMzWeQQxvbgkRXTWmXOsSmeUs0/
         Cfgw==
X-Gm-Message-State: AOAM531uJ8J7LjYILuRIfhLnIxb8DMYLrXAsGbqUXRYdBxj0uBo6IRLR
        DTiWfOjc9QSlAPOfh3QOHS+aMFI8Le3d3+ih
X-Google-Smtp-Source: ABdhPJyjPuLvBtlKqRncNjfg4ceEqubzEbPID1t/fAfUEADpeGjh7NwepOg+V48kciW9yhu51QbkMQ==
X-Received: by 2002:a9d:3f49:: with SMTP id m67mr9100873otc.327.1607387241756;
        Mon, 07 Dec 2020 16:27:21 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id i43sm3038345ota.39.2020.12.07.16.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:27:21 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 19/19] future: pull: enable ff-only mode by default
Date:   Mon,  7 Dec 2020 18:26:48 -0600
Message-Id: <20201208002648.1370414-20-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208002648.1370414-1-felipe.contreras@gmail.com>
References: <20201208002648.1370414-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The user has been warned that this change was coming and should have
already configured his/her preference.

It's time to flip the switch and make ff-only the default.

There's no need for the annoying warning anymore.

TODO: Do we want to keep the "pull.mode=ff-only" tests and essentially run
them twice?

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt   |  4 +-
 builtin/pull.c               | 19 +---------
 t/t5520-pull.sh              | 28 +++++---------
 t/t7601-merge-pull-config.sh | 72 ------------------------------------
 4 files changed, 13 insertions(+), 110 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 21b50aff77..672371e989 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -60,8 +60,8 @@ However, a non-fast-forward case looks very different.
 	origin/master in your repository
 ------------
 
-By default `git pull` will warn about these situations, however, most likely
-you would want to force a merge, which you can do with `git pull --merge`.
+By default `git pull` will fail on these situations, you will have to
+specify whether you want `--merge` or `--rebase`.
 
 Then "`git pull`" will fetch and replay the changes from the remote
 `master` branch since it diverged from the local `master` (i.e., `E`)
diff --git a/builtin/pull.c b/builtin/pull.c
index 734a2c04b8..7ddc11a4bc 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -392,7 +392,7 @@ static enum pull_mode_type config_get_pull_mode(void)
 	if (!git_config_get_value("pull.mode", &value))
 		return parse_config_pull_mode("pull.mode", value);
 
-	return PULL_MODE_DEFAULT;
+	return PULL_MODE_FF_ONLY;
 }
 
 /**
@@ -1091,23 +1091,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (mode == PULL_MODE_FF_ONLY && !can_ff)
 		die(_("The pull was not fast-forward, please either merge or rebase.\n"));
 
-	if (!opt_rebase && !can_ff && opt_verbosity >= 0 && (!opt_ff || !strcmp(opt_ff, "--ff"))) {
-		advise(_("The pull was not fast-forward, in the future you will have to choose a merge, or a rebase.\n"
-			"\n"
-			"To quell this message you have two main options:\n"
-			"\n"
-			"1. Adopt the new behavior:\n"
-			"\n"
-			"  git config --global pull.mode ff-only\n"
-			"\n"
-			"2. Maintain the current behavior:\n"
-			"\n"
-			"  git config --global pull.mode merge\n"
-			"\n"
-			"For now we will fall back to the traditional behavior (merge).\n"
-			"Read \"git pull --help\" for more information."));
-	}
-
 	if (opt_rebase >= REBASE_TRUE) {
 		int ret = 0;
 
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index d4718dbc02..84685786da 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -879,39 +879,31 @@ setup_non_ff () {
 	setup_other master^
 }
 
-test_expect_success 'fast-forward (pull.mode=ff-only)' '
+test_expect_success 'fast-forward (default)' '
 	setup_ff &&
-	git -c pull.mode=ff-only pull
+	git pull
 '
 
-test_expect_success 'non-fast-forward (pull.mode=ff-only)' '
+test_expect_success 'non-fast-forward (default)' '
 	setup_non_ff &&
-	test_must_fail git -c pull.mode=ff-only pull
+	test_must_fail git pull
 '
 
-test_expect_success 'non-fast-forward with merge (pull.mode=ff-only)' '
+test_expect_success 'non-fast-forward with merge (default)' '
 	setup_non_ff &&
-	git -c pull.mode=ff-only pull --merge
+	git pull --merge
 '
 
-test_expect_success 'non-fast-forward with rebase (pull.mode=ff-only)' '
+test_expect_success 'non-fast-forward with rebase (default)' '
 	setup_non_ff &&
-	git -c pull.mode=ff-only pull --rebase
+	git pull --rebase
 '
 
-test_expect_success 'non-fast-forward error message (pull.mode=ff-only)' '
+test_expect_success 'non-fast-forward error message (default)' '
 	setup_non_ff &&
-	test_must_fail git -c pull.mode=ff-only pull 2> error &&
+	test_must_fail git pull 2> error &&
 	cat error &&
 	test_i18ngrep "The pull was not fast-forward" error
 '
 
-test_expect_success 'non-fast-forward warning (default)' '
-	setup_non_ff &&
-	git pull 2> error &&
-	cat error &&
-	test_i18ngrep "The pull was not fast-forward" error &&
-	test_i18ngrep "in the future you will have to choose" error
-'
-
 test_done
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 149fc2a009..c6c44ec570 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -27,78 +27,6 @@ test_expect_success 'setup' '
 	git tag c3
 '
 
-test_expect_success 'pull.rebase not set' '
-	git reset --hard c2 &&
-	git -c color.advice=always pull . c1 2>err &&
-	test_decode_color <err >decoded &&
-	test_i18ngrep "<YELLOW>hint: " decoded &&
-	test_i18ngrep "in the future you will have to choose" decoded
-'
-
-test_expect_success 'pull.rebase not set (fast-forward)' '
-	git reset --hard c0 &&
-	git pull . c1 2>err &&
-	test_i18ngrep ! "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.mode set' '
-	git reset --hard c2 &&
-	test_config pull.mode merge &&
-	git pull . c1 2>err &&
-	test_i18ngrep ! "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and pull.ff=true' '
-	git reset --hard c2 &&
-	test_config pull.ff true &&
-	git pull . c1 2>err &&
-	test_i18ngrep "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and pull.ff=false' '
-	git reset --hard c2 &&
-	test_config pull.ff false &&
-	git pull . c1 2>err &&
-	test_i18ngrep ! "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and pull.ff=only' '
-	git reset --hard c2 &&
-	test_config pull.ff only &&
-	test_must_fail git pull . c1 2>err &&
-	test_i18ngrep ! "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and --rebase given' '
-	git reset --hard c2 &&
-	git pull --rebase . c1 2>err &&
-	test_i18ngrep ! "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and --merge given' '
-	git reset --hard c2 &&
-	git pull --merge . c1 2>err &&
-	test_i18ngrep ! "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and --ff given' '
-	git reset --hard c2 &&
-	git pull --ff . c1 2>err &&
-	test_i18ngrep "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and --no-ff given' '
-	git reset --hard c2 &&
-	git pull --no-ff . c1 2>err &&
-	test_i18ngrep ! "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and --ff-only given' '
-	git reset --hard c2 &&
-	test_must_fail git pull --ff-only . c1 2>err &&
-	test_i18ngrep ! "in the future you will have to choose" err
-'
-
 test_expect_success 'merge c1 with c2' '
 	git reset --hard c1 &&
 	test -f c0.c &&
-- 
2.29.2

