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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861DBC433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 689DA61131
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244271AbhIIOUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348612AbhIIOTx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 10:19:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853F1C10DC48
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 05:42:15 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v10so2380816wrd.4
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 05:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cgYfONj+HBmQH587+jI3XQjsFeFBrsmXwTixygeOUVg=;
        b=fBcNeZj6JGngpNji52r7FVPD4YyS2zTBQE1aVq6LBzlEenwzcrW1q7oJTNN+khw/49
         Ct0ODDIko2MmYqG7U/mYBp1VNTH/xziWZFl9HLffG3rCEunNsossk94A2Hfzmxd6Xq2/
         k7IpQWjILgv9471E+E8320rQ9HAujX2tIraN3axkniZhTgR/2HlLKOKcbpH2+SwwltIP
         DB8fg38b2g0j9IEFgkMkOSNtlwW/bneRrKg2dKx47QgCqgZNbZan8EGXDaoBqzWqz/HC
         C/ZRoDU2PFksCJH18m1WptnqMSWBHB6Z6DJvYrO9fVc0YYG91qxu7yDxy43w33b6M2Lj
         pwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cgYfONj+HBmQH587+jI3XQjsFeFBrsmXwTixygeOUVg=;
        b=v6BRWguJ8cRWMVPXdRaAin0eQ6uC+QlcwLt/SNmFvCI4YPciR+rp4XmyTQgV/L/tQI
         aNVN2txQ12Aj0njQd4ezZhbp4XK93WgyF2P5DaxIDOr60j+fpED4GAJXAaPqs+/IRu4l
         SPM5UMXApz4UVa55HHA1mPoo69+l37yMQcEvm8ft7BwkZrr85lGantiRarezNXAsZZiV
         KRnaM+G+4ddvyKGdZc16DlwAyhkK30xCmP/fRta++hljHLX4MJeTjp+cO4QsPYkNZ9kq
         dlu3nS74oDqbxZXpyH8nkfGKm+0Ss3N8T1N31sBoNUp+21aCCv6JPOoAxotPa3QsYK5X
         QMKw==
X-Gm-Message-State: AOAM532G8G+o6v6ssIXEqsfTVkyFaCpmvu+hBgaMz4ctiS6zV01DOG79
        kR9GbeHuIO9Knc4XWk8e1PW7toy1GrvAwA==
X-Google-Smtp-Source: ABdhPJxO0zflogSeMRYYnfmNwzx3ZqisrCfxd4GirB23jRul/vBTzVUDnOEVgFSvtBNS/M6aC3tehg==
X-Received: by 2002:a5d:58e9:: with SMTP id f9mr3268646wrd.154.1631191333876;
        Thu, 09 Sep 2021 05:42:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j25sm1742081wrc.12.2021.09.09.05.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 05:42:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v4 5/5] hook: allow out-of-repo 'git hook' invocations
Date:   Thu,  9 Sep 2021 14:42:03 +0200
Message-Id: <patch-v4-5.5-5d5e9726fd8-20210909T122802Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.867.g88ec4638586
In-Reply-To: <cover-v4-0.5-00000000000-20210909T122802Z-avarab@gmail.com>
References: <20210819033450.3382652-1-emilyshaffer@google.com> <cover-v4-0.5-00000000000-20210909T122802Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Since hooks can now be supplied via the config, and a config can be
present without a gitdir via the global and system configs, we can start
to allow 'git hook run' to occur without a gitdir. This enables us to do
things like run sendemail-validate hooks when running 'git send-email'
from a nongit directory.

It still doesn't make sense to look for hooks in the hookdir in nongit
repos, though, as there is no hookdir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 git.c           |  2 +-
 hook.c          |  2 +-
 t/t1800-hook.sh | 20 +++++++++++++++-----
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/git.c b/git.c
index 540909c391f..39988ee3b02 100644
--- a/git.c
+++ b/git.c
@@ -538,7 +538,7 @@ static struct cmd_struct commands[] = {
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
-	{ "hook", cmd_hook, RUN_SETUP },
+	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "init", cmd_init_db },
 	{ "init-db", cmd_init_db },
diff --git a/hook.c b/hook.c
index b825fa7c7ae..dc3033cb4c7 100644
--- a/hook.c
+++ b/hook.c
@@ -181,7 +181,7 @@ struct list_head *list_hooks(const char *hookname)
 
 	/* Add the hook from the hookdir. The placeholder makes it easier to
 	 * allocate work in pick_next_hook. */
-	if (find_hook(hookname))
+	if (have_git_dir() && find_hook(hookname))
 		append_or_move_hook(hook_head, NULL);
 
 	return hook_head;
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 68e7ff7de7e..6b6ba30e88e 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -128,15 +128,25 @@ test_expect_success 'git hook list: existing hook' '
 	test_cmp expect actual
 '
 
-test_expect_success 'git hook run -- out-of-repo runs excluded' '
-	write_script .git/hooks/test-hook <<-EOF &&
-	echo Test hook
-	EOF
+test_expect_success 'git hook run: out-of-repo runs execute global hooks' '
+	test_config_global hook.global-hook.event test-hook --add &&
+	test_config_global hook.global-hook.command "echo no repo no problems" --add &&
+
+	echo "global-hook" >expect &&
+	nongit git hook list test-hook >actual &&
+	test_cmp expect actual &&
+
+	echo "no repo no problems" >expect &&
 
-	nongit test_must_fail git hook run test-hook
+	nongit git hook run test-hook 2>actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
+	write_script .git/hooks/test-hook <<-EOF &&
+	echo Test hook
+	EOF
+
 	mkdir my-hooks &&
 	write_script my-hooks/test-hook <<-\EOF &&
 	echo Hook ran $1 >>actual
-- 
2.33.0.867.g88ec4638586

