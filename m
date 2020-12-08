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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2622C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC8F223A04
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgLHA3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbgLHA27 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:28:59 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F97C0619D4
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:27:21 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id l207so14697294oib.4
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w+FpBGrJUGE/gqxlvUfo1tzXM7j/IGNmBxyZkunuGXA=;
        b=FeOwcNj9GQ4bcdPRq32RLaFFfgcIhzFEwP/e4bfeeci7bSX2N/QbAr8XzZALi4thhG
         lIKtHRc7rxL8ATy+JtAS2WVbq94vzwFeB36Ylv3tS6SQc/GQ7PvM646yutgfFLNFgZcs
         2ClXekkfIeUEn/EuD5eREHNfL1N9aor3btG1Cx4C9m2CiKBnrVQ6G6K49JeBlnWGv3On
         5n8itw2EpC6YdIz9zwfniyNpKsMjH4CyiznZAN/+Q1oXYHczfThxg1uf0I6OcZyUQicd
         MTvPqoEsl6wn2Z/UQZgbx7JsMTOg1YquES/ak5GuuK7FjFzVTGFXyU+WubvsRp02RSvT
         IB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+FpBGrJUGE/gqxlvUfo1tzXM7j/IGNmBxyZkunuGXA=;
        b=R/XAHJ65gVg/Mm4xz7jKNhjMZdUQxoTMgBL9m7wqlNcx+YnQbXmWvsOZUC/ASEY94r
         VC/sr2AqQkx7flWX/fi6rIzwEmYFISLZtvUa332JxKe5TLuEoHRibP4fmR5u/eAMDokT
         heSm5XEhN31tppvjIQyG9z5oZKLCpCkvfMwWulMPd7SRPhpT5RD3Tzufnt81HVNmaTcs
         90NCgm//byj2usDkw5O8Ddrztp7LgvzYlhVg63qfUpa5R2o/mAkJzp5yFT5H1Alf+zaB
         ZfcvTUdK+3zg0eZM0OAt9Xi7KpkkAI3mFAtJfEpZBNtLjwc0JIMiCWTyF1QRMz05nQbD
         LGVQ==
X-Gm-Message-State: AOAM531+BiQwPvY8JNENSH2wgMk//2PfwcIzrOzgwub1QuM6qJCMfDXq
        h8ZDDrK2sos0mAkvuaHihVX9vw02q87mTCCD
X-Google-Smtp-Source: ABdhPJzU38ob+hG1shH1wI3tiXRu2YavqnBCU1BZMfCMs7lh0pXLm0jcW0i8Cp0dnKkndFaHEoWKMA==
X-Received: by 2002:a05:6808:a0e:: with SMTP id n14mr999217oij.75.1607387240061;
        Mon, 07 Dec 2020 16:27:20 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id z3sm366911otq.22.2020.12.07.16.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:27:19 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 18/19] pull: advice of future changes
Date:   Mon,  7 Dec 2020 18:26:47 -0600
Message-Id: <20201208002648.1370414-19-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208002648.1370414-1-felipe.contreras@gmail.com>
References: <20201208002648.1370414-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we have "pull.mode=ff-only", we can make it the default any
time we want to.

For now, simply explain the upcoming changes in the default warning, and
mention how to turn on the future default mode.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c               | 20 +++++++++++---------
 t/t5520-pull.sh              |  8 ++++++++
 t/t7601-merge-pull-config.sh | 22 +++++++++++-----------
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 5a67667b79..734a2c04b8 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1092,17 +1092,19 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		die(_("The pull was not fast-forward, please either merge or rebase.\n"));
 
 	if (!opt_rebase && !can_ff && opt_verbosity >= 0 && (!opt_ff || !strcmp(opt_ff, "--ff"))) {
-		advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
-			"you need to specify if you want a merge, or a rebase.\n"
-			"You can squelch this message by running one of the following commands:\n"
+		advise(_("The pull was not fast-forward, in the future you will have to choose a merge, or a rebase.\n"
 			"\n"
-			"  git config pull.mode merge    # (the default strategy)\n"
-			"  git config pull.mode rebase\n"
-			"  git config pull.mode ff-only  # fast-forward only\n"
+			"To quell this message you have two main options:\n"
 			"\n"
-			"You can replace \"git config\" with \"git config --global\" to set a default\n"
-			"preference for all repositories.\n"
-			"If unsure, run \"git pull --merge\".\n"
+			"1. Adopt the new behavior:\n"
+			"\n"
+			"  git config --global pull.mode ff-only\n"
+			"\n"
+			"2. Maintain the current behavior:\n"
+			"\n"
+			"  git config --global pull.mode merge\n"
+			"\n"
+			"For now we will fall back to the traditional behavior (merge).\n"
 			"Read \"git pull --help\" for more information."));
 	}
 
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index b5b007b175..d4718dbc02 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -906,4 +906,12 @@ test_expect_success 'non-fast-forward error message (pull.mode=ff-only)' '
 	test_i18ngrep "The pull was not fast-forward" error
 '
 
+test_expect_success 'non-fast-forward warning (default)' '
+	setup_non_ff &&
+	git pull 2> error &&
+	cat error &&
+	test_i18ngrep "The pull was not fast-forward" error &&
+	test_i18ngrep "in the future you will have to choose" error
+'
+
 test_done
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 25ca239c17..149fc2a009 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -32,71 +32,71 @@ test_expect_success 'pull.rebase not set' '
 	git -c color.advice=always pull . c1 2>err &&
 	test_decode_color <err >decoded &&
 	test_i18ngrep "<YELLOW>hint: " decoded &&
-	test_i18ngrep "Pulling without specifying how to reconcile" decoded
+	test_i18ngrep "in the future you will have to choose" decoded
 '
 
 test_expect_success 'pull.rebase not set (fast-forward)' '
 	git reset --hard c0 &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.mode set' '
 	git reset --hard c2 &&
 	test_config pull.mode merge &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=true' '
 	git reset --hard c2 &&
 	test_config pull.ff true &&
 	git pull . c1 2>err &&
-	test_i18ngrep "Pulling without specifying how to reconcile" err
+	test_i18ngrep "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=false' '
 	git reset --hard c2 &&
 	test_config pull.ff false &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=only' '
 	git reset --hard c2 &&
 	test_config pull.ff only &&
 	test_must_fail git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and --rebase given' '
 	git reset --hard c2 &&
 	git pull --rebase . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and --merge given' '
 	git reset --hard c2 &&
 	git pull --merge . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and --ff given' '
 	git reset --hard c2 &&
 	git pull --ff . c1 2>err &&
-	test_i18ngrep "Pulling without specifying how to reconcile" err
+	test_i18ngrep "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and --no-ff given' '
 	git reset --hard c2 &&
 	git pull --no-ff . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and --ff-only given' '
 	git reset --hard c2 &&
 	test_must_fail git pull --ff-only . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "in the future you will have to choose" err
 '
 
 test_expect_success 'merge c1 with c2' '
-- 
2.29.2

