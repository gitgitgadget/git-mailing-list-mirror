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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C90FC4167B
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 16:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F164F22573
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 16:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395451AbgLLQxM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Dec 2020 11:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407688AbgLLQwz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Dec 2020 11:52:55 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFE9C061793
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 08:52:15 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id f132so13835805oib.12
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 08:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=40X1+/4spqJl0f48MlFog+hwA1kTXQHXTIpadIA0VPI=;
        b=NbMjC1ujT1MDKnc2Iuk+ZzEqNVTDzFleaFLCFxrXAGxRboqns+47xcXRSTGzOgG279
         0hT5XZZ2115xL6M6yxvEm03QwuXahlLgndfDzgEORv1j2o9/u6ciaFUqfTWAe5UpsJ5A
         E9OV1ot7/bEFoak/JUTM2QYSdEQh3alsjyEZEzvgDD467X1/FOeYRLnN/KPrW6xqJIhX
         7OcxKd70wxDiPWkeA51vyCwbXSfQmw8j0XuqqGVNrEzarv/qktJ+U2dp86VjskgOewNV
         QRN+9LbFiiikFkH2Ei85hY5w6Fpb4rdN2WStG4RVpGna/h9dWayjsEwvA0YXr8/0/lDZ
         eE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=40X1+/4spqJl0f48MlFog+hwA1kTXQHXTIpadIA0VPI=;
        b=DZ9ZF2J2rVSraG/KnEE6hRcMhCLOtKkapPzH5aRtOSS7AtJ7hX2pCmmGi4ZSjKrKk7
         oJ49+W9GpZH+UxtRViy6AEqCStAntqgjR8FW5Nh3RaFUO7nnqOF4MpdDpO4f/V66kfxC
         BhJfhk1KtyASsJi1ba3NahZZNAfkmM2YbNye5jCihfMRDvdYrAD3FaWFwrxV/mW6+4c6
         /xaAyyKTIuu8958y6MUM3axLX6lJaA/UDXS6OziH5YbFGUItj6CZFklHEU0wCi8zDmY4
         Awv32Irp1AIRnD+7hPMb7TlEhU4aeLNYOsX+S6z6UG8W+MkJ/PZbbiE3j55TKBcPDn5k
         u3NQ==
X-Gm-Message-State: AOAM5315Or4fnu3zZsoedCz1IiTRbSvrFlbjK0GqTpnwNlDSLOxFuzZE
        U9ix5t9dWMkXVIXqWIAjVNjLdslSKVWD/Q==
X-Google-Smtp-Source: ABdhPJxnuI4QbM7XbgtgSgsTpkY3f3nYmcn+rG8wznM6I32jp3H3H7mT25hIM08qiN3toQ6ToP4oaw==
X-Received: by 2002:aca:dc54:: with SMTP id t81mr13152278oig.101.1607791934753;
        Sat, 12 Dec 2020 08:52:14 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id p8sm2746755oig.22.2020.12.12.08.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 08:52:14 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 3/3] pull: display default warning only when non-ff
Date:   Sat, 12 Dec 2020 10:52:08 -0600
Message-Id: <20201212165208.780798-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201212165208.780798-1-felipe.contreras@gmail.com>
References: <20201212165208.780798-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to display the annoying warning on every pull... only
the ones that are not fast-forward.

The current warning tests still pass, but not because of the arguments
or the configuration, but because they are all fast-forward.

We need to test non-fast-forward situations now.

Suggestions-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c               |  7 ++--
 t/t7601-merge-pull-config.sh | 66 +++++++++++++++++++++++++++++++++---
 2 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index ff8e3ce137..9a7caf3a3e 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -934,6 +934,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct object_id orig_head, curr_head;
 	struct object_id rebase_fork_point;
 	int autostash;
+	int can_ff;
 
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
@@ -1029,7 +1030,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (opt_rebase && merge_heads.nr > 1)
 		die(_("Cannot rebase onto multiple branches."));
 
-	if (default_mode && opt_verbosity >= 0 && !opt_ff) {
+	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
+
+	if (default_mode && !can_ff && opt_verbosity >= 0 && !opt_ff) {
 		advise(_("Pulling without specifying how to reconcile divergent branches is\n"
 			 "discouraged. You can squelch this message by running one of the following\n"
 			 "commands sometime before your next pull:\n"
@@ -1058,7 +1061,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		    submodule_touches_in_range(the_repository, &upstream, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
 		if (!autostash) {
-			if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
+			if (can_ff) {
 				/* we can fast-forward this without invoking rebase */
 				opt_ff = "--ff-only";
 				ran_ff = 1;
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 6774e9d86f..52e8ccc933 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -29,11 +29,8 @@ test_expect_success 'setup' '
 
 test_expect_success 'pull.rebase not set' '
 	git reset --hard c0 &&
-	git -c color.advice=always pull . c1 2>err &&
-	test_decode_color <err >decoded &&
-	test_i18ngrep "<YELLOW>hint: " decoded &&
-	test_i18ngrep "Pulling without specifying how to reconcile" decoded
-
+	git pull . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=true' '
@@ -87,6 +84,65 @@ test_expect_success 'pull.rebase not set and --ff-only given' '
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
+test_expect_success 'pull.rebase not set (not-fast-forward)' '
+	git reset --hard c2 &&
+	git -c color.advice=always pull . c1 2>err &&
+	test_decode_color <err >decoded &&
+	test_i18ngrep "<YELLOW>hint: " decoded &&
+	test_i18ngrep "Pulling without specifying how to reconcile" decoded
+'
+
+test_expect_success 'pull.rebase not set and pull.ff=true (not-fast-forward)' '
+	git reset --hard c2 &&
+	test_config pull.ff true &&
+	git pull . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and pull.ff=false (not-fast-forward)' '
+	git reset --hard c2 &&
+	test_config pull.ff false &&
+	git pull . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and pull.ff=only (not-fast-forward)' '
+	git reset --hard c2 &&
+	test_config pull.ff only &&
+	test_must_fail git pull . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and --rebase given (not-fast-forward)' '
+	git reset --hard c2 &&
+	git pull --rebase . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and --no-rebase given (not-fast-forward)' '
+	git reset --hard c2 &&
+	git pull --no-rebase . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and --ff given (not-fast-forward)' '
+	git reset --hard c2 &&
+	git pull --ff . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and --no-ff given (not-fast-forward)' '
+	git reset --hard c2 &&
+	git pull --no-ff . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and --ff-only given (not-fast-forward)' '
+	git reset --hard c2 &&
+	test_must_fail git pull --ff-only . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
 test_expect_success 'merge c1 with c2' '
 	git reset --hard c1 &&
 	test -f c0.c &&
-- 
2.29.2

