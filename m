Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCF7C636CA
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F09A61159
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbhGQPov (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 11:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbhGQPot (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 11:44:49 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEAFC061764
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:41:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f9so15601052wrq.11
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Bu1IrFBWIYKDh8eiAos2GhYRtXhHrFLYtKO7mu5ln8g=;
        b=S5E/Zu4cWi5zUdKESzAQeCSmU2zMjJ2Wo55IOHAgcwOVZkobb1yW9w0hL5QP2CazJx
         Ljjy2MUH4MH/fWtff7AaSOfaDI/O6f/WavLDbmlN9cCoUWC26rTvdwW4zdhxgwaE8nEs
         JMuOD493lyH4dVAerPuWjBaV5GCCIs8Pv9i11UWiUCctN35JZN92BviLUUS9b2xdkaLC
         RqUCpptiApj4wjUYoFKQerd8IxSsH3mkGpXEspRKCtMNFEA1s+4YuT8Runj9IMykCoSM
         0hO43OcVj1Ie2vsY8oGZKfsUqVHAGLS/xlpsCcKpm52tvQN4RRO8lXpzICB0t/oTUT9o
         qrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Bu1IrFBWIYKDh8eiAos2GhYRtXhHrFLYtKO7mu5ln8g=;
        b=Am9VWvWdT2NQxAL87BMtt7xglnnJSIeTRhA7xNSalsoZ+r6eRU9Xnx1lNw9zxYLn3V
         q/6/bweVmH7jrDQMWcEWfM4+9RueW8SNYuXP/XYoPL5p6Sq3wOT7IYFBLrPkiDYPAFJs
         +RI+Q19rSpX5+d/Zb90ygz9zlcmtrTPAguhTCEyvM0NE1NcPhUoQEq2HB2oCO73DKKYR
         YpRgGkQxwkeHF8V87J3/UE20yoIS4mjXaR9pdA2E+KO6tmpynvvfmbS0AfyexxGhu7LS
         ix81zKEN8HPbdAyIJAiJ5yRNin2ud/OMzys9MbsFWa8LLbKDF7uWtKo0fKW0WJwTdCG9
         PTEQ==
X-Gm-Message-State: AOAM533x5yUfUfUBMvjHNu6OuAjuHMI17O2E25rg6dJdk+uIdxhDFEuc
        55t5cuwfx2S3SbItFKM7OTqUj1+EOEY=
X-Google-Smtp-Source: ABdhPJxAXM6/458aRwv27m1Nc+NxEhSEsnHrqa8rxVZKH3YdDVcBD2MJ5llfYlXUgi5ja23TFg3KJw==
X-Received: by 2002:adf:eed0:: with SMTP id a16mr18753246wrp.324.1626536509994;
        Sat, 17 Jul 2021 08:41:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b12sm14195719wro.1.2021.07.17.08.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 08:41:49 -0700 (PDT)
Message-Id: <6cb771297f5f7d5bb0c6734bcb3fe6d3b8bb4c88.1626536508.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Jul 2021 15:41:39 +0000
Subject: [PATCH 1/9] t7601: add relative precedence tests for merge and rebase
 flags/options
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
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The interaction of rebase and merge flags and options was not well
tested.  Add several tests to check for correct behavior from the
following rules:
    * --ff-only takes precedence over --[no-]rebase
      * Corollary: pull.ff=only overrides pull.rebase
    * --rebase[=!false] takes precedence over --no-ff and --ff
      * Corollary: pull.rebase=!false overrides pull.ff=!only
    * command line flags take precedence over config, except:
      * --no-rebase heeds pull.ff=!only
      * pull.rebase=!false takes precedence over --no-ff and --ff

For more details behind these rules and a larger table of individual
cases, refer to https://lore.kernel.org/git/xmqqwnpqot4m.fsf@gitster.g/
and the links found therein.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7601-merge-pull-config.sh | 154 +++++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 52e8ccc933a..b24c98cc1b6 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -143,6 +143,160 @@ test_expect_success 'pull.rebase not set and --ff-only given (not-fast-forward)'
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
+test_does_rebase() {
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
+test_does_merge_noff() {
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
+test_does_merge_ff() {
+	git reset --hard c0 &&
+	git "$@" . c1 &&
+	# Check that we actually did a merge
+	git rev-list --count HEAD >actual &&
+	git rev-list --merges --count HEAD >>actual &&
+	test_write_lines 2 0 >expect &&
+	test_cmp expect actual &&
+	rm actual expect
+}
+
+test_does_need_full_merge() {
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
+test_attempts_fast_forward() {
+	git reset --hard c2 &&
+	test_must_fail git "$@" . c1 2>err &&
+	test_i18ngrep "Not possible to fast-forward, aborting" err
+}
+
+#
+# Rule 1: --ff-only takes precedence over --[no-]rebase
+# (Corollary: pull.ff=only overrides pull.rebase)
+#
+test_expect_failure '--ff-only takes precedence over --rebase' '
+	test_attempts_fast_forward pull --rebase --ff-only
+'
+
+test_expect_failure '--ff-only takes precedence over --rebase even if first' '
+	test_attempts_fast_forward pull --ff-only --rebase
+'
+
+test_expect_success '--ff-only takes precedence over --no-rebase' '
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
+# Rule 2: --rebase=[!false] takes precedence over --no-ff and --ff
+# (Corollary: pull.rebase=!false overrides pull.ff=!only)
+test_expect_success '--rebase takes precedence over --no-ff' '
+	test_does_rebase pull --rebase --no-ff
+'
+
+test_expect_success '--rebase takes precedence over --ff' '
+	test_does_rebase pull --rebase --ff
+'
+
+test_expect_success 'pull.rebase=true takes precedence over pull.ff=false' '
+	test_does_rebase -c pull.rebase=true -c pull.ff=false pull
+'
+
+test_expect_success 'pull.rebase=true takes precedence over pull.ff=true' '
+	test_does_rebase -c pull.rebase=true -c pull.ff=true pull
+'
+
+# Rule 3: command line flags take precedence over config
+test_expect_failure '--ff-only takes precedence over pull.rebase=true' '
+	test_attempts_fast_forward -c pull.rebase=true pull --ff-only
+'
+
+test_expect_success '--ff-only takes precedence over pull.rebase=false' '
+	test_attempts_fast_forward -c pull.rebase=false pull --ff-only
+'
+
+test_expect_failure '--no-rebase overrides pull.ff=only' '
+	test_does_need_full_merge -c pull.ff=only pull --no-rebase
+'
+
+test_expect_success '--rebase takes precedence over pull.ff=only' '
+	test_does_rebase -c pull.ff=only pull --rebase
+'
+
+test_expect_success '--rebase takes precedence over pull.ff=true' '
+	test_does_rebase -c pull.ff=true pull --rebase
+'
+
+test_expect_success '--rebase takes precedence over pull.ff=false' '
+	test_does_rebase -c pull.ff=false pull --rebase
+'
+
+test_expect_success '--rebase takes precedence over pull.ff unset' '
+	test_does_rebase pull --rebase
+'
+
+# Rule 4: --no-rebase heeds pull.ff=!only or explict --ff or --no-ff
+
+test_expect_success '--no-rebase works with --no-ff' '
+	test_does_merge_noff pull --no-rebase --no-ff
+'
+
+test_expect_success '--no-rebase works with --ff' '
+	test_does_merge_ff pull --no-rebase --ff
+'
+
+test_expect_success '--no-rebase does ff if pull.ff unset' '
+	test_does_merge_ff pull --no-rebase
+'
+
+test_expect_success '--no-rebase heeds pull.ff=true' '
+	test_does_merge_ff -c pull.ff=true pull --no-rebase
+'
+
+test_expect_success '--no-rebase heeds pull.ff=false' '
+	test_does_merge_noff -c pull.ff=false pull --no-rebase
+'
+
+# Rule 5: pull.rebase=!false takes precedence over --no-ff and --ff
+test_expect_success 'pull.rebase=true takes precedence over --no-ff' '
+	test_does_rebase -c pull.rebase=true pull --no-ff
+'
+
+test_expect_success 'pull.rebase=true takes precedence over --ff' '
+	test_does_rebase -c pull.rebase=true pull --ff
+'
+
+# End of precedence rules
+
 test_expect_success 'merge c1 with c2' '
 	git reset --hard c1 &&
 	test -f c0.c &&
-- 
gitgitgadget

