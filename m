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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80939C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5814D23A04
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgLHA2P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgLHA2P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:28:15 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2031C061257
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:27:02 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id h18so10375383otq.12
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=habUPnnnxlYAPznzCqdlYUCrF6OMdG/MNePaYSfpy2M=;
        b=ql1t08S9J8T5KPQF46jvNUWamAyfBJ9UKoSeZC9MKSi+6IkqqQncsF+M7g/hsgMJgc
         5g+wlN+KmmKr+K6rihnch+AvMRBqsc59SLzR92XtedMMk+RBBEy6PPDqPP72GAfGjq1Y
         BrfDpNIpCum/7B2kVUqlvmciNDHIG+oN8pKjbpTD6lTYvsQyu+1f2rM4FFAnaOUet43N
         1vy67QWfF7Fv/5h+EVXb9pL0TNlmWeA1FHqr5QIiI5kWqUC1YN2be0qLSVauN79Y7KYV
         qip/bPJh/SG+evh2ag3fRW0pdz/SVCASmxlil8tf3pXdATM6l2cPocP+JCKA6dPDKol7
         uSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=habUPnnnxlYAPznzCqdlYUCrF6OMdG/MNePaYSfpy2M=;
        b=teH07zhgdWsSGnbnPQ+ZRMTupbfOL8QYog9EoVkJV872f6Cd2iq3k+F1dWNA+u+oY7
         HdfSE2231Av+3rqNV39RtvsS4ERFCX4dSi3P+rDLcPBAXS6+ITn1/XqNQubiuJIhCnfs
         1nfGUHRuSoA27TOUQGvqHMyfKhmqqyrLzDmMECar7AJtc5KnOuy/MZGBa3R1fy+qcJa6
         F0c17k4jQwceyTSadPHwaGEO9IH+tHFuzVC+0jK5vcvug5Hv3DbW/wz36xB3qmg5HMIl
         vBhGPvM4CTCN02QTgAsOxg6AmducZhbzUo2qNrDMqB85eJ7YHabmDPQ0jaSqejXLjRKR
         vqVQ==
X-Gm-Message-State: AOAM533ojbMgchHtu+bZLmtDneHzBBwKke+CiAnE7kZd84FRxGMgXk99
        4csnkMpfcqNvAmTG03Ex90rf1WqQSVQZJ+43
X-Google-Smtp-Source: ABdhPJzrRX/VtZCX0Bqya2rfGKhTFHXBcTeKEpUY5mo/26LPWynX4SR8xqHQE49NHl7YlZAcCnyerA==
X-Received: by 2002:a9d:ec5:: with SMTP id 63mr1996858otj.181.1607387222080;
        Mon, 07 Dec 2020 16:27:02 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id z9sm1700631otj.67.2020.12.07.16.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:27:01 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 07/19] pull: display default warning only when non-ff
Date:   Mon,  7 Dec 2020 18:26:36 -0600
Message-Id: <20201208002648.1370414-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208002648.1370414-1-felipe.contreras@gmail.com>
References: <20201208002648.1370414-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to display the annoying warning on every pull... only
the ones that are not fast-forward.

This requires the tests to pick another base, so the merge is not
fast-forward. And in the cases where --ff-only is specified add
test_must_fail (since now they are non-fast-forward).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt   |  3 +++
 builtin/pull.c               |  2 +-
 t/t7601-merge-pull-config.sh | 28 +++++++++++++++++-----------
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index e1605a81b3..2fb184ab5f 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -60,6 +60,9 @@ However, a non-fast-forward case looks very different.
 	origin/master in your repository
 ------------
 
+By default `git pull` will warn about these situations, however, most likely
+you would want to force a merge, which you can do with `git pull --no-rebase`.
+
 Then "`git pull`" will fetch and replay the changes from the remote
 `master` branch since it diverged from the local `master` (i.e., `E`)
 until its current commit (`C`) on top of `master` and record the
diff --git a/builtin/pull.c b/builtin/pull.c
index 3b84ebf100..ab410d675f 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1031,7 +1031,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (default_mode && opt_verbosity >= 0 && !opt_ff) {
+	if (default_mode && !can_ff && opt_verbosity >= 0 && !opt_ff) {
 		advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
 			"you need to specify if you want a merge, or a rebase.\n"
 			"You can squelch this message by running one of the following commands:\n"
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 6774e9d86f..6b4adab8b1 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -28,7 +28,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'pull.rebase not set' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	git -c color.advice=always pull . c1 2>err &&
 	test_decode_color <err >decoded &&
 	test_i18ngrep "<YELLOW>hint: " decoded &&
@@ -36,54 +36,60 @@ test_expect_success 'pull.rebase not set' '
 
 '
 
-test_expect_success 'pull.rebase not set and pull.ff=true' '
+test_expect_success 'pull.rebase not set (fast-forward)' '
 	git reset --hard c0 &&
+	git pull . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and pull.ff=true' '
+	git reset --hard c2 &&
 	test_config pull.ff true &&
 	git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=false' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	test_config pull.ff false &&
 	git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=only' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	test_config pull.ff only &&
-	git pull . c1 2>err &&
+	test_must_fail git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --rebase given' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	git pull --rebase . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --no-rebase given' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	git pull --no-rebase . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --ff given' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	git pull --ff . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --no-ff given' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	git pull --no-ff . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --ff-only given' '
-	git reset --hard c0 &&
-	git pull --ff-only . c1 2>err &&
+	git reset --hard c2 &&
+	test_must_fail git pull --ff-only . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-- 
2.29.2

