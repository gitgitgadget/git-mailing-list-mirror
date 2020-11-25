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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5798C6379D
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AAC920872
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLbRIDet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgKYD3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 22:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgKYD3u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 22:29:50 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DC3C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:29:49 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id k3so958716otp.12
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ezc2UR3JD/F3kAcBnenZQ+LV7lq4+/SBkm8KLvsJNBQ=;
        b=dLbRIDetm6VvePozfuFQtRCpZ94n8mqt+hyL6fL39To0PlAgD9WH3npk8nfsKs7V6f
         LSQZiysizo6PMItWVwtiF6TtzR/EeyTaGJNGdLOlTPeDUAz0MZvW6R2llCNujq5aCieL
         Xl2J3UXQrBnO16nvJemwZBFDNJt0RUURMeElr2iVVVccMnBaWCztOk+rhc/Ez9lXLwJf
         WPc2S+DjMGSGmDhaC6/c80o0gwVt2Ew/4jdjNsI4EsLHcCg8Rg1MR/luIb1SquU+I8XQ
         /529Y/yqARoLfvm2HdBnI+cNX38lZSGEsJ4TzlnNhIYhQGZwQCe6EsEbI8e9/lfx9dyk
         rdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ezc2UR3JD/F3kAcBnenZQ+LV7lq4+/SBkm8KLvsJNBQ=;
        b=WrDcUfy2+PwAFmBdlaL6+5ZZQ2yjGj+eH5tLlhY0TKn14sSaZy8JeczysVVdDi3p6A
         X8fqiFVt2IlKxITNYXZXKctBYxqoCE4/gNTvWMksTCnplfKNclGUVeopDc3zOyX/lgoS
         BfHf+SiLj6JWfKn5QFBUJ4cljLrZ03N25VDKzzAt4geeTa4hY8PXeXqHWVkNEVdd4m+2
         il5j5Ztt7jwdGooKgDuZ8CS33bUM3JmKIaJVy6kiav2721BrVCU+qzh3HCzXyFMNIlAW
         NoqehWYIQ9tqveGYVlc5rYVMwRiyGiPXdfGU/sncKCKgCOSxALBO4Ax7fGISD+FkWgrb
         88Aw==
X-Gm-Message-State: AOAM531MxeNiTxhP3kxiwIpxp+5s3lpEI3XjWtpPsHJrs3PmstMMpTBv
        NEN0mEGDAxDJqx8OxQfC2PaTsme+Fc12aQ==
X-Google-Smtp-Source: ABdhPJxDedi4eag0zYPeE2cJBj2T0h2dDlO/6xrHVGp5MSRpsP4ZyQNH/zWFjZBJ36A9YCjjoh6exg==
X-Received: by 2002:a9d:7188:: with SMTP id o8mr1437402otj.120.1606274989075;
        Tue, 24 Nov 2020 19:29:49 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id k20sm655175ooh.47.2020.11.24.19.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 19:29:48 -0800 (PST)
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
Subject: [PATCH v8 05/10] pull: display default warning only when non-ff
Date:   Tue, 24 Nov 2020 21:29:33 -0600
Message-Id: <20201125032938.786393-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125032938.786393-1-felipe.contreras@gmail.com>
References: <20201125032938.786393-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to display the annoying warning on every pull... only
the ones that are not fast-forward.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c               |  2 +-
 t/t7601-merge-pull-config.sh | 28 +++++++++++++++++-----------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 9a0f7937c2..479bdaf0ee 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1013,7 +1013,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (default_mode && opt_verbosity >= 0 && !opt_ff) {
+	if (default_mode && !can_ff && opt_verbosity >= 0 && !opt_ff) {
 		warning(_("Pulling without specifying how to reconcile divergent branches is\n"
 			"discouraged. You can squelch this message by running one of the following\n"
 			"commands sometime before your next pull:\n"
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index c5c4ea5fc0..02e2a9b2c6 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -28,59 +28,65 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'pull.rebase not set' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	git pull . c1 2>err &&
 	test_i18ngrep "Pulling without specifying how to reconcile" err
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

