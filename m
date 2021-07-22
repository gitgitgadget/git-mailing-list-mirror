Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA44DC6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 05:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92FCB60FF2
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 05:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhGVEYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 00:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhGVEYS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 00:24:18 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9350C061757
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 22:04:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id f9so4444840wrq.11
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 22:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KxJkBheq548xtQ4rZAGg4aLZc02uro/12/govHV5GFw=;
        b=uuuOf7M9ccT0cnASGd9s7xV5ZEp8WMoBS/7CEaM5m+RQaLs4eWO+XkUzPgUzZE/gfH
         0VhU0/1LMfZ4baZDNxB1oZE1n58Szn5orMnLSwbm1PFEpeYY8FQgwN8lBjjQbpvU+H+C
         XtglD1HTKZNZrr45rwLC56LdIpiil3+N+HeX1uoAnLbENd4jZXsuLwpDpFUsrtC86C2u
         HhOwlXr+Or1egoOf8e0w53et4PQv98cTZs0Xw5w53a7IDJAcO+WduIaFJIinGyXo1uzE
         J4X9heYPIrVgi//0vnYGEJ3fsDcjxuuS5c3DLm6MGxgCXlXxdqY0hMUWmRE2xOvEdn5V
         W0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KxJkBheq548xtQ4rZAGg4aLZc02uro/12/govHV5GFw=;
        b=m3Vb1BJPfSA1DR4IRgbIpuUMU852qgUlHGpA4A1t8qpxXvvJJBrB+/kNC3zUr3XKeL
         HYhgIz32GEGKMxOyJNOqRFrW46jhVNy36oLphqgczyKOnix5DfVbVqP0CTjvXcaXrYJy
         WBbaYyyu4BZfpzerea+OsWVd1wTMAIObYCkbgvq5mr8WlBWBpxP652+GJlaTU+8mIXox
         DZES+YkSkfvlMCaZzW8CcmK4MMKLxk/cYppwLlXKn/QYgQkJvg2M63uN0NqGhvE6rkUo
         xJ6ldNlR2id5SYzMFpDqB1wBrdRcb9ZvfAF9IYIH81hT2AdCkXhXPJgrkYiU9zLm1R88
         eqgQ==
X-Gm-Message-State: AOAM533hiyuM2ffmldVBtQJTOOcETC8dOMteWcRfE+3foZ+Ah4KfC/W0
        q+Wf9Axr4Adc6Q/psAiDtBd5RXpEu3E=
X-Google-Smtp-Source: ABdhPJy5xvRGn60WWlIrTznoruv1Gxh2hM4hofdPyU6iRUD6ML4fLXz+/zfoSPfNXdVqaTJknXBa6A==
X-Received: by 2002:adf:ea08:: with SMTP id q8mr45934025wrm.297.1626930292402;
        Wed, 21 Jul 2021 22:04:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e8sm7399117wrc.6.2021.07.21.22.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 22:04:52 -0700 (PDT)
Message-Id: <175609272110e4f8d71dce3e6c4e6ca010a8f366.1626930290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v3.git.git.1626930290.gitgitgadget@gmail.com>
References: <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
        <pull.1049.v3.git.git.1626930290.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Jul 2021 05:04:43 +0000
Subject: [PATCH v3 1/8] t7601: test interaction of merge/rebase/fast-forward
 flags and options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The interaction of rebase and merge flags and options was not well
tested.  Add several tests to check for correct behavior from the
following rules:
    * --ff-only vs. --[no-]rebase
      (and the related pull.ff=only vs. pull.rebase)
    * --rebase[=!false] vs. --no-ff and --ff
      (and the related pull.rebase=!false overrides pull.ff=!only)
    * command line flags take precedence over config, except:
      * --no-rebase heeds pull.ff=!only
      * pull.rebase=!false vs --no-ff and --ff

For more details behind these rules and a larger table of individual
cases, refer to https://lore.kernel.org/git/xmqqwnpqot4m.fsf@gitster.g/
and the links found therein.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7601-merge-pull-config.sh | 182 +++++++++++++++++++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 52e8ccc933a..a44e6e69f2b 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -143,6 +143,188 @@ test_expect_success 'pull.rebase not set and --ff-only given (not-fast-forward)'
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
+test_does_rebase () {
+	git reset --hard c2 &&
+	git "$@" . c1 &&
+	# Check that we actually did a rebase
+	git rev-list --count HEAD >actual &&
+	git rev-list --merges --count HEAD >>actual &&
+	test_write_lines 3 0 >expect &&
+	test_cmp expect actual &&
+	rm actual expect
+}
+
+# Prefers merge over fast-forward
+test_does_merge_when_ff_possible () {
+	git reset --hard c0 &&
+	git "$@" . c1 &&
+	# Check that we actually did a merge
+	git rev-list --count HEAD >actual &&
+	git rev-list --merges --count HEAD >>actual &&
+	test_write_lines 3 1 >expect &&
+	test_cmp expect actual &&
+	rm actual expect
+}
+
+# Prefers fast-forward over merge or rebase
+test_does_fast_forward () {
+	git reset --hard c0 &&
+	git "$@" . c1 &&
+
+	# Check that we did not get any merges
+	git rev-list --count HEAD >actual &&
+	git rev-list --merges --count HEAD >>actual &&
+	test_write_lines 2 0 >expect &&
+	test_cmp expect actual &&
+
+	# Check that we ended up at c1
+	git rev-parse HEAD >actual &&
+	git rev-parse c1^{commit} >expect &&
+	test_cmp actual expect &&
+
+	# Remove temporary files
+	rm actual expect
+}
+
+# Doesn't fail when fast-forward not possible; does a merge
+test_falls_back_to_full_merge () {
+	git reset --hard c2 &&
+	git "$@" . c1 &&
+	# Check that we actually did a merge
+	git rev-list --count HEAD >actual &&
+	git rev-list --merges --count HEAD >>actual &&
+	test_write_lines 4 1 >expect &&
+	test_cmp expect actual &&
+	rm actual expect
+}
+
+# Attempts fast forward, which is impossible, and bails
+test_attempts_fast_forward () {
+	git reset --hard c2 &&
+	test_must_fail git "$@" . c1 2>err &&
+	test_i18ngrep "Not possible to fast-forward, aborting" err
+}
+
+#
+# Group 1: Interaction of --ff-only with --[no-]rebase
+# (And related interaction of pull.ff=only with pull.rebase)
+#
+test_expect_failure '--ff-only overrides --rebase' '
+	test_attempts_fast_forward pull --rebase --ff-only
+'
+
+test_expect_failure '--ff-only overrides --rebase even if first' '
+	test_attempts_fast_forward pull --ff-only --rebase
+'
+
+test_expect_success '--ff-only overrides --no-rebase' '
+	test_attempts_fast_forward pull --ff-only --no-rebase
+'
+
+test_expect_failure 'pull.ff=only overrides pull.rebase=true' '
+	test_attempts_fast_forward -c pull.ff=only -c pull.rebase=true pull
+'
+
+test_expect_success 'pull.ff=only overrides pull.rebase=false' '
+	test_attempts_fast_forward -c pull.ff=only -c pull.rebase=false pull
+'
+
+# Group 2: --rebase=[!false] overrides --no-ff and --ff
+# (And related interaction of pull.rebase=!false and pull.ff=!only)
+test_expect_success '--rebase overrides --no-ff' '
+	test_does_rebase pull --rebase --no-ff
+'
+
+test_expect_success '--rebase overrides --ff' '
+	test_does_rebase pull --rebase --ff
+'
+
+test_expect_success '--rebase fast-forwards when possible' '
+	test_does_fast_forward pull --rebase --ff
+'
+
+test_expect_success 'pull.rebase=true overrides pull.ff=false' '
+	test_does_rebase -c pull.rebase=true -c pull.ff=false pull
+'
+
+test_expect_success 'pull.rebase=true overrides pull.ff=true' '
+	test_does_rebase -c pull.rebase=true -c pull.ff=true pull
+'
+
+# Group 3: command line flags take precedence over config
+test_expect_failure '--ff-only takes precedence over pull.rebase=true' '
+	test_attempts_fast_forward -c pull.rebase=true pull --ff-only
+'
+
+test_expect_success '--ff-only takes precedence over pull.rebase=false' '
+	test_attempts_fast_forward -c pull.rebase=false pull --ff-only
+'
+
+test_expect_failure '--no-rebase takes precedence over pull.ff=only' '
+	test_falls_back_to_full_merge -c pull.ff=only pull --no-rebase
+'
+
+test_expect_success '--rebase takes precedence over pull.ff=only' '
+	test_does_rebase -c pull.ff=only pull --rebase
+'
+
+test_expect_success '--rebase overrides pull.ff=true' '
+	test_does_rebase -c pull.ff=true pull --rebase
+'
+
+test_expect_success '--rebase overrides pull.ff=false' '
+	test_does_rebase -c pull.ff=false pull --rebase
+'
+
+test_expect_success '--rebase overrides pull.ff unset' '
+	test_does_rebase pull --rebase
+'
+
+# Group 4: --no-rebase heeds pull.ff=!only or explict --ff or --no-ff
+
+test_expect_success '--no-rebase works with --no-ff' '
+	test_does_merge_when_ff_possible pull --no-rebase --no-ff
+'
+
+test_expect_success '--no-rebase works with --ff' '
+	test_does_fast_forward pull --no-rebase --ff
+'
+
+test_expect_success '--no-rebase does ff if pull.ff unset' '
+	test_does_fast_forward pull --no-rebase
+'
+
+test_expect_success '--no-rebase heeds pull.ff=true' '
+	test_does_fast_forward -c pull.ff=true pull --no-rebase
+'
+
+test_expect_success '--no-rebase heeds pull.ff=false' '
+	test_does_merge_when_ff_possible -c pull.ff=false pull --no-rebase
+'
+
+# Group 5: pull.rebase=!false in combination with --no-ff or --ff
+test_expect_success 'pull.rebase=true and --no-ff' '
+	test_does_rebase -c pull.rebase=true pull --no-ff
+'
+
+test_expect_success 'pull.rebase=true and --ff' '
+	test_does_rebase -c pull.rebase=true pull --ff
+'
+
+test_expect_success 'pull.rebase=false and --no-ff' '
+	test_does_merge_when_ff_possible -c pull.rebase=false pull --no-ff
+'
+
+test_expect_success 'pull.rebase=false and --ff, ff possible' '
+	test_does_fast_forward -c pull.rebase=false pull --ff
+'
+
+test_expect_success 'pull.rebase=false and --ff, ff not possible' '
+	test_falls_back_to_full_merge -c pull.rebase=false pull --ff
+'
+
+# End of groupings for conflicting merge vs. rebase flags/options
+
 test_expect_success 'merge c1 with c2' '
 	git reset --hard c1 &&
 	test -f c0.c &&
-- 
gitgitgadget

