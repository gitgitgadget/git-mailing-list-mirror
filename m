Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89A6C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6C661442
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbhFNKif (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbhFNKg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:36:26 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA0DC061147
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:33:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c9so13967612wrt.5
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WxJtRfYKBIfljHxwAjBgXgZ9c9/ivqgRseAI29LMbt8=;
        b=Djeg0B1w5c/udnh+5GBTXI2H+GNK61nq5HM82xYQ1HAHIwmKQ9YL+OW78Q9/75NhvP
         BN56sHnQVX1gmshTwL7vIuYhw3iuQFYRT00qZiKlyP2Snfec4ssN6jREsQ2o5/2fmGPG
         XSz/+w1K3i9knmPs4Xj6u0/UM0UT1FDBvy971n+/RVzeuyVVQd1WC5NrhF6xTDLEzrTe
         yuL8m6peBhEoeU/gyKa9qJIFMSHT7eLnuyF0ZIz2Pbc062CRZoiM1/vRYFxCrhdWpxZQ
         Zdm3IYhiBcAtBs+zNv/piTF7DmGmxf4VpU4GFgJCN4lcGMs7/PNS/aMAjGe1AQDqCNzK
         822g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WxJtRfYKBIfljHxwAjBgXgZ9c9/ivqgRseAI29LMbt8=;
        b=sjUX30fTikwiSmEDs6qcpEshCPf0zoB0fYKpkXbktPTN6XbT4tCejlRak886tM3Xff
         jbNNFhWsoDL0LfpQSZg5Hkg/96+5yHlDGMtVVsgBGSN8I03nuUJFDrMumMczWybyn3TW
         /e53Q3CqN/ejjTDPPV9T5GmgEc2R5gDdCrQvlOC/Rqc+r9RXediSDvrkEOjNOOkfQDsQ
         Ljs9qYJZCAxDnnm9gyKm3/KLpKRd36X8t7Dx3/O3OJLp6sOxhfAAI/I9R02qUMuaQIow
         qaAraJPAr1rvmIyYL1ifwgGxPfcNl18h9Bx2EEW75w25W+oABd/JcA7qP9/VV/BYoXGL
         lL8w==
X-Gm-Message-State: AOAM5332kFYyIlIcbKnkkE46mkQTUI7tfu4NyaD8DHXnH3Z0DyQCdLOf
        XPsOXZKBGYDesvIrbGFr47kMxLHnH3grNA==
X-Google-Smtp-Source: ABdhPJxXxLBk+nl6Q59i5JD9/2w6Rn7r81Xwe48pxtUVocRNidNbfZkTaeC4po9ENDrWWvsRo0QFYg==
X-Received: by 2002:adf:d209:: with SMTP id j9mr17646804wrh.328.1623666835580;
        Mon, 14 Jun 2021 03:33:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:33:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/30] read-cache: convert post-index-change hook to use config
Date:   Mon, 14 Jun 2021 12:33:02 +0200
Message-Id: <patch-13.30-0300607a9b4-20210614T101920Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com> <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

By using hook.h instead of run-command.h to run, post-index-change hooks
can now be specified in the config in addition to the hookdir.
post-index-change is not run anywhere besides in read-cache.c.

This removes the last direct user of run_hook_ve(), so we can make the
function static now. It'll be removed entirely soon.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 read-cache.c  | 11 ++++++++---
 run-command.c |  2 +-
 run-command.h |  1 -
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index af5b97104cf..f801313cc95 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3063,6 +3063,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 {
 	int ret;
 	int was_full = !istate->sparse_index;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
 
 	ret = convert_to_sparse(istate);
 
@@ -3091,9 +3092,13 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	else
 		ret = close_lock_file_gently(lock);
 
-	run_hook_le(NULL, "post-index-change",
-			istate->updated_workdir ? "1" : "0",
-			istate->updated_skipworktree ? "1" : "0", NULL);
+	strvec_pushl(&hook_opt.args,
+		     istate->updated_workdir ? "1" : "0",
+		     istate->updated_skipworktree ? "1" : "0",
+		     NULL);
+	run_hooks("post-index-change", &hook_opt);
+	run_hooks_opt_clear(&hook_opt);
+
 	istate->updated_workdir = 0;
 	istate->updated_skipworktree = 0;
 
diff --git a/run-command.c b/run-command.c
index 82fdf296569..eecdef5a0c8 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1321,7 +1321,7 @@ int async_with_fork(void)
 #endif
 }
 
-int run_hook_ve(const char *const *env, const char *name, va_list args)
+static int run_hook_ve(const char *const *env, const char *name, va_list args)
 {
 	struct child_process hook = CHILD_PROCESS_INIT;
 	const char *p;
diff --git a/run-command.h b/run-command.h
index b58531a7eb3..24ab5d63c4c 100644
--- a/run-command.h
+++ b/run-command.h
@@ -216,7 +216,6 @@ int run_command(struct child_process *);
  */
 LAST_ARG_MUST_BE_NULL
 int run_hook_le(const char *const *env, const char *name, ...);
-int run_hook_ve(const char *const *env, const char *name, va_list args);
 
 /*
  * Trigger an auto-gc
-- 
2.32.0.rc3.434.gd8aed1f08a7

