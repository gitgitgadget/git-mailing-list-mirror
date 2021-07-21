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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6FAC636C8
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 01:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1160B610F7
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 01:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhGUBC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 21:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhGUBB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 21:01:59 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A7AC061762
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 18:42:28 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y21-20020a7bc1950000b02902161fccabf1so2520673wmi.2
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 18:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KxJkBheq548xtQ4rZAGg4aLZc02uro/12/govHV5GFw=;
        b=fdUbF//thlGBdleQ02M/nxTjJMek1cPFRZCUlenXsOS+j/182B3oRND5OTbGW3UPPn
         tq0rjVOuaygoq4bknio/v49vT4wFTNr3QJSGs5UvpKmxKe2eWhKOZNpDXngr9Wa/gZP0
         Hybu9a18MyuQtRhCDhMiwjCJ5eKLdlEVHdGw4mcQN+gcdL5Lf5N0OzugRjQ2nErkAEOt
         juhknVRifVrOuxXIFFlsJYN3BQmNLuiCPa1R5CWOgeX4IMcXGWIfCcaLYnrpFMml9FdR
         F1cOA2JXYAcuPS7lHHOut1z3v2f1RjfbsJ7t27NeLjDX6GsApSZtZndRnfftlRlbzblf
         Qy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KxJkBheq548xtQ4rZAGg4aLZc02uro/12/govHV5GFw=;
        b=pM3SlaKBM0CpBnFTYvhBnEF2+tHo0FrYvmW7qSGgWCZvHbz7CyBqoCoyuFlZpaVZu7
         pUiuteYnzBnnrqx/GXmTA8tUXe8MZ/Zu2SO5oROymgxHlXuykG9rUzE/UrP5Mzy65Wtj
         b/SF6gpitxFFcie0reAC8Jj1Puve7iWFAVeb3/DkPcNyBdG+Iln4JUnz45UbTnbsicX+
         OD+1PrS2jn+XTAo1dshi6HQOeVNgkwaF1vfYSYLyqCFOOUiYUVK/pED+tYLX1DRXfIk1
         6BDtc/nnXX53EmZCgVZLaR6vEhvEhNUJUiO9J2NOHG8Y1ZSJB5yBiCskK0Mrv7sNy01H
         9Sbg==
X-Gm-Message-State: AOAM532uxNecW0mZQoUAQ3GkV4WbLVkAjBYDt54ES597o1LtW+ZzyQnR
        oWLXxoHadYk7qG+jqT2XNSxZYuTGrUQ=
X-Google-Smtp-Source: ABdhPJwz5JQjwyPkYWqvLVjd73QvlTk8sbVGaHWtmf5GP1jyki1ZvKav080k85+TTMbrMVV1QGb1Dg==
X-Received: by 2002:a05:600c:1d04:: with SMTP id l4mr1347955wms.130.1626831746857;
        Tue, 20 Jul 2021 18:42:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm29680762wrr.27.2021.07.20.18.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 18:42:26 -0700 (PDT)
Message-Id: <175609272110e4f8d71dce3e6c4e6ca010a8f366.1626831744.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
        <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jul 2021 01:42:17 +0000
Subject: [PATCH v2 1/8] t7601: test interaction of merge/rebase/fast-forward
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

