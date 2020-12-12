Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF89C433FE
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 16:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 724482246B
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 16:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389990AbgLLQxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Dec 2020 11:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407684AbgLLQwu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Dec 2020 11:52:50 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BAFC0613CF
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 08:52:10 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id 15so13853967oix.8
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 08:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b6Ap0YjXsXzFU0VSslnPCMMNFK02x2q09zlAS9Ycmts=;
        b=CyZhjC9q2jx7PdyAGh6mkUhJ6gmZ82uVpY+RnQuV+3wHJRPuhwC3D0SdCCgxSAdcyC
         Cm38snb5w1xf9AnNszADgnWD2hK9qphLwMxEg5ycU0gYCq+25xwMNVqvtfFwE+EFuoLt
         4rJNF/9v8XsVyGD4HRnxp/jB82fTpu6+iNGB728WoljyAGufkwIKufvSoTaRtatrJr1W
         6qt1ObioABIiODX4XaAfa8nGFBAsuZmNMYiPX0O2VXxK2PVW2iBXdH0DgomDfjWemJWY
         tvAai1uecbXHgYlmbpyCaFnJiRwvmvUPsvvRhjLG8F4uBTO7A3r5hGTQ3HnyybFo4anq
         8XrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b6Ap0YjXsXzFU0VSslnPCMMNFK02x2q09zlAS9Ycmts=;
        b=j8vXn+1cpcFLBddCIdrnxedSuQi04yZU5AhR1HHADDmTfxedtEh53p4JwZLHCx3bHq
         MZ27OLoVGWa3rABt35LSkmUKMBEEgfl4zYseDfco4oPfecdH+VaKnGPsARtDnK3C3m2p
         9pKhkc1CurbqpsbpxXZqfw4FO0dxZNfv5zBxzFhpLg7qxWt81Rb69zt2oiDSi2mdy14g
         e4pZQQ935YUCImfmhCRWlYUef09cP19VUfyTrxd55JbtWJJISebUm0hliMKL56KcuYFR
         jRc1O6iBnaiQYSA+m5unrFzh0y28sI3Fk2GShy7eFb5viGfp5QDZyEj3YAclq8yQ0IwH
         aBhw==
X-Gm-Message-State: AOAM530CtOkWXR/BebSNhB7whXtGdeTIgLx9WKIOM1fJC+a6GEaIA1rg
        jz2sByiloRvszyKw6w0W8BiOomH1rNnL8A==
X-Google-Smtp-Source: ABdhPJyDbqvl+fWLnCLza0kqBsAlK9t5AUmJ5Jr8U30soLtzr0l1K4MkmPaRu+HaZmute6wbQFe2fQ==
X-Received: by 2002:a54:4d96:: with SMTP id y22mr12952880oix.141.1607791929897;
        Sat, 12 Dec 2020 08:52:09 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id l134sm2072770oig.25.2020.12.12.08.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 08:52:09 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 0/3] pull: stop warning on every pull
Date:   Sat, 12 Dec 2020 10:52:05 -0600
Message-Id: <20201212165208.780798-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The future of having a sensible "git pull" default is uncertain (it's
very likely that nothing will change), in the meantime there's no reason
to keep annoying our users unnecessarily.

This patch is doing one thing, and one thing only: stops warning the
users on every single pull (warns only if they are not-fast-forward).

Changes since v4:

 1. Improved some commit messages
 2. In patch 3 current the tests are kept as is, per Junio's request
    (IMO they are no-ops)

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 6b4adab8b1..52e8ccc933 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -28,66 +28,116 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'pull.rebase not set' '
-	git reset --hard c2 &&
-	git -c color.advice=always pull . c1 2>err &&
-	test_decode_color <err >decoded &&
-	test_i18ngrep "<YELLOW>hint: " decoded &&
-	test_i18ngrep "Pulling without specifying how to reconcile" decoded
+	git reset --hard c0 &&
+	git pull . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
 
+test_expect_success 'pull.rebase not set and pull.ff=true' '
+	git reset --hard c0 &&
+	test_config pull.ff true &&
+	git pull . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-test_expect_success 'pull.rebase not set (fast-forward)' '
+test_expect_success 'pull.rebase not set and pull.ff=false' '
 	git reset --hard c0 &&
+	test_config pull.ff false &&
 	git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-test_expect_success 'pull.rebase not set and pull.ff=true' '
+test_expect_success 'pull.rebase not set and pull.ff=only' '
+	git reset --hard c0 &&
+	test_config pull.ff only &&
+	git pull . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and --rebase given' '
+	git reset --hard c0 &&
+	git pull --rebase . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and --no-rebase given' '
+	git reset --hard c0 &&
+	git pull --no-rebase . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and --ff given' '
+	git reset --hard c0 &&
+	git pull --ff . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and --no-ff given' '
+	git reset --hard c0 &&
+	git pull --no-ff . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and --ff-only given' '
+	git reset --hard c0 &&
+	git pull --ff-only . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set (not-fast-forward)' '
+	git reset --hard c2 &&
+	git -c color.advice=always pull . c1 2>err &&
+	test_decode_color <err >decoded &&
+	test_i18ngrep "<YELLOW>hint: " decoded &&
+	test_i18ngrep "Pulling without specifying how to reconcile" decoded
+'
+
+test_expect_success 'pull.rebase not set and pull.ff=true (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff true &&
 	git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-test_expect_success 'pull.rebase not set and pull.ff=false' '
+test_expect_success 'pull.rebase not set and pull.ff=false (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff false &&
 	git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-test_expect_success 'pull.rebase not set and pull.ff=only' '
+test_expect_success 'pull.rebase not set and pull.ff=only (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff only &&
 	test_must_fail git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-test_expect_success 'pull.rebase not set and --rebase given' '
+test_expect_success 'pull.rebase not set and --rebase given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --rebase . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-test_expect_success 'pull.rebase not set and --no-rebase given' '
+test_expect_success 'pull.rebase not set and --no-rebase given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --no-rebase . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-test_expect_success 'pull.rebase not set and --ff given' '
+test_expect_success 'pull.rebase not set and --ff given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --ff . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-test_expect_success 'pull.rebase not set and --no-ff given' '
+test_expect_success 'pull.rebase not set and --no-ff given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --no-ff . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-test_expect_success 'pull.rebase not set and --ff-only given' '
+test_expect_success 'pull.rebase not set and --ff-only given (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_must_fail git pull --ff-only . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err


Felipe Contreras (3):
  pull: refactor fast-forward check
  pull: move default warning
  pull: display default warning only when non-ff

 builtin/pull.c               | 61 +++++++++++++++++++--------------
 t/t7601-merge-pull-config.sh | 66 +++++++++++++++++++++++++++++++++---
 2 files changed, 97 insertions(+), 30 deletions(-)

-- 
2.29.2

