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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C94FC64E8A
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D1F2087C
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLsj9Z4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgKYD36 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 22:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgKYD36 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 22:29:58 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB05C0613D4
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:29:58 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id i13so163963oou.11
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XYCIFpTK1U85eu6FQaisrF9syunRmjF4tcFbFgkHA1c=;
        b=jLsj9Z4qDXX0pzI23Rv6YtZGheVetB4Lj8Y1B4xbLfJpINj4FXyF7vHxHAdWAOTsuh
         YY/3EYsdRe81BfOk0eDhlKA04KvzjaIxfr4BG5z6/szWxP35h0VtV7v8x6Om8i3sNAy4
         fVG/FunbAxiLNh50WfkZ9BfgxbtsQTRgUorvlnWhMgu544WqjcJy2nFO0KFZH6bBDAV8
         tY0S9p2By/+nu4W8CcZm5Mq0PTx2XEp/wdX/5sCTK2BHzLqm2In1DSTeEDMT9eJQT32Q
         w4EtEx+jw27nCYFKFQ6Vx5SPrI4AFzoQuvBrM8U/tOb5jpUMWoUuFyIJYcUeTASzj6rz
         ipxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XYCIFpTK1U85eu6FQaisrF9syunRmjF4tcFbFgkHA1c=;
        b=FTm9prdTmlcrK/9JM+Uxgf8u0AeJQp/6h055KCX6CwIGLAufI1DKeNddOhoAaFqarI
         QhztrwvSY0j0itgL7aTU6qXnG6VzIrCVGREq9QPiNzZFZkog2foPTRYxH5CXRKDRgq/P
         8E8l8rM3xq/1NVT6yu3aM4j0FN/syJUNT5oHLq1kogmAhFVDZFq9kfNBiwkBp0xpYxFE
         3JG4gBXiI0wJGrjU40AseXtTTTerXHKq/52PpwNG4w9POXjews4TL8Xv6rXZJ/Tb6NIe
         j7ESeu54LO0p8uxc9buUPD9K8I/3UfYipWun2ut8ZYIxIP8Ee1hnn0c6G4DB90WhFm99
         x+kw==
X-Gm-Message-State: AOAM5333595OHMXneSSny4WVPeJl2sPl/rLBZ8b44vpTygy9foduu39+
        5kxP/bUWpWkj0M6BCyA1AtasqoeGoS6aHg==
X-Google-Smtp-Source: ABdhPJz7dxWbkVGV0/dyurRby1NfmMMgZzIa/Rm496KDF6A+Pv0DCinPIpqozuZVA+OlKlafhsEjzA==
X-Received: by 2002:a4a:338d:: with SMTP id q135mr1281575ooq.21.1606274997282;
        Tue, 24 Nov 2020 19:29:57 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id m2sm583987ots.11.2020.11.24.19.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 19:29:56 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        Philip Oakley <philipoakley@iee.email>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v8 10/10] pull: improve default warning
Date:   Tue, 24 Nov 2020 21:29:38 -0600
Message-Id: <20201125032938.786393-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125032938.786393-1-felipe.contreras@gmail.com>
References: <20201125032938.786393-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also, use pull.mode to determine when to show it, and --ff/--no-ff
shouldn't squelch the warning.

Also, improve the documentation so "git pull --help" actually does
explain what's going on.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt   | 17 +++++++++++++++
 builtin/pull.c               | 34 +++++++++++++++---------------
 t/t5520-pull.sh              | 14 +++++++++++++
 t/t7601-merge-pull-config.sh | 40 +++++++-----------------------------
 4 files changed, 55 insertions(+), 50 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 5c3fb67c01..ad33d2472c 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -38,6 +38,20 @@ as set by linkgit:git-branch[1] `--track`.
 Assume the following history exists and the current branch is
 "`master`":
 
+------------
+	  A---B---C master on origin
+	 /
+    D---E master
+------------
+
+Then `git pull` will merge in a fast-foward way up to the new master.
+
+------------
+    D---E---A---B---C master, origin/master
+------------
+
+However, a non-fast-foward case looks very different.
+
 ------------
 	  A---B---C master on origin
 	 /
@@ -46,6 +60,9 @@ Assume the following history exists and the current branch is
 	origin/master in your repository
 ------------
 
+By default `git pull` will warn about these situations, however, most likely
+you would want to force a merge, which you can do with `git pull --no-rebase`.
+
 Then "`git pull`" will fetch and replay the changes from the remote
 `master` branch since it diverged from the local `master` (i.e., `E`)
 until its current commit (`C`) on top of `master` and record the
diff --git a/builtin/pull.c b/builtin/pull.c
index 3aa7f56142..8e577b6322 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1060,25 +1060,25 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (!opt_rebase && !can_ff && opt_verbosity >= 0 && !opt_ff) {
-		warning(_("Pulling without specifying how to reconcile divergent branches is\n"
-			"discouraged. You can squelch this message by running one of the following\n"
-			"commands sometime before your next pull:\n"
-			"\n"
-			"  git config pull.mode merge    # (the default strategy)\n"
-			"  git config pull.mode rebase\n"
-			"  git config pull.mode ff-only  # fast-forward only\n"
-			"\n"
-			"You can replace \"git config\" with \"git config --global\" to set a default\n"
-			"preference for all repositories. You can also pass --rebase, --no-rebase,\n"
-			"or --ff-only on the command line to override the configured default per\n"
-			"invocation.\n"));
+	if (!can_ff) {
+		if (mode == PULL_MODE_FF_ONLY)
+			die(_("The pull was not fast-forward, please either merge or rebase.\n"
+				"If unsure, run 'git pull --no-rebase'."));
+		else if (!mode && opt_verbosity >= 0) {
+			warning(_("The pull was not fast-forward, in the future you will have to choose a merge, or a rebase.\n"
+				"To squelch this message and maintain the current behavior, use:\n"
+				"\n"
+				"  git config --global pull.mode merge\n"
+				"\n"
+				"To squelch this message and adopt the new behavior now, use:\n"
+				"\n"
+				"  git config --global push.mode ff-only\n"
+				"\n"
+				"Falling back to old style for now (merge).\n"
+				"Read 'git pull --help' for more information."));
+		}
 	}
 
-	if (mode == PULL_MODE_FF_ONLY && !can_ff)
-		die(_("The pull was not fast-forward, please either merge or rebase.\n"
-			"If unsure, run 'git pull --no-rebase'."));
-
 	if (opt_rebase >= REBASE_TRUE) {
 		int ret = 0;
 		if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index ba78c16d73..29d44d000e 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -897,4 +897,18 @@ test_expect_success 'git pull non-fast-forward with merge (ff-only)' '
 	git pull --no-rebase
 '
 
+test_expect_success 'git pull non-fast-forward (default)' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	git checkout -b other master^ &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	git pull 2> error &&
+	cat error &&
+	grep -q "The pull was not fast-forward" error &&
+	grep -q "in the future you will have to choose" error
+'
+
 test_done
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 4a36ad30e2..8a93b37d87 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -30,71 +30,45 @@ test_expect_success 'setup' '
 test_expect_success 'pull.rebase not set' '
 	git reset --hard c2 &&
 	git pull . c1 2>err &&
-	test_i18ngrep "Pulling without specifying how to reconcile" err
+	test_i18ngrep "choose a merge, or a rebase" err
 '
 
 test_expect_success 'pull.rebase not set (fast-forward)' '
 	git reset --hard c0 &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "choose a merge, or a rebase" err
 '
 
 test_expect_success 'pull.mode set' '
 	git reset --hard c2 &&
 	test_config pull.mode merge &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
-'
-
-test_expect_success 'pull.rebase not set and pull.ff=true' '
-	git reset --hard c2 &&
-	test_config pull.ff true &&
-	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
-'
-
-test_expect_success 'pull.rebase not set and pull.ff=false' '
-	git reset --hard c2 &&
-	test_config pull.ff false &&
-	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "choose a merge, or a rebase" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=only' '
 	git reset --hard c2 &&
 	test_config pull.ff only &&
 	test_must_fail git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "choose a merge, or a rebase" err
 '
 
 test_expect_success 'pull.rebase not set and --rebase given' '
 	git reset --hard c2 &&
 	git pull --rebase . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "choose a merge, or a rebase" err
 '
 
 test_expect_success 'pull.rebase not set and --no-rebase given' '
 	git reset --hard c2 &&
 	git pull --no-rebase . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
-'
-
-test_expect_success 'pull.rebase not set and --ff given' '
-	git reset --hard c2 &&
-	git pull --ff . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
-'
-
-test_expect_success 'pull.rebase not set and --no-ff given' '
-	git reset --hard c2 &&
-	git pull --no-ff . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "choose a merge, or a rebase" err
 '
 
 test_expect_success 'pull.rebase not set and --ff-only given' '
 	git reset --hard c2 &&
 	test_must_fail git pull --ff-only . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "choose a merge, or a rebase" err
 '
 
 test_expect_success 'merge c1 with c2' '
-- 
2.29.2

