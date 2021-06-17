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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC55C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3653F61245
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhFQK0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbhFQKZj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:39 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B557FC0613A2
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:19 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w21so3272467edv.3
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Mc0ML94HBE2oL0F6HPGqBHkkiAAZSTF7Onuu1wSZkQ=;
        b=N1gpR+hR5TPNpRGuyLrk3sOAiTbQAngpLyD0OKwIY9FkakuJzw+uSunTiRytvmaTdh
         ks/yXzc/rIaDNcEFinSo6jScan8RjBqefVNL92OKIN7US2/H4/j6tBR11WQaGSdNb8WC
         aLz7161fAuwLzW4KifB8SWE42RxKgZVR5TJnBHZsRg7sfc5pzy29DIes7tyKuL3pEAVe
         0mRbSGFTDLIMtsS8Gc65/Pev2fbELUG+41kZwMNnnGg38NBoInkoTMmI84C3iLvxrOZo
         J+rq4cEalRLpTV3zFafnw89eI5S/qcMzLdGkBS5mMuhexjKkZc2BrsYOK8vq0bI2CK78
         efeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Mc0ML94HBE2oL0F6HPGqBHkkiAAZSTF7Onuu1wSZkQ=;
        b=hjI34CdFOgrwJuatdbNyurVAunQDesRa1Ssn7gKHH3EkyoNkWUPqu9zcDgixPKhxED
         +8nRjlPYy35fe5dpuwWkdn2Iy8mJCEetbyJmiMNwwOh6X0LKa/2ALQetjE8qquq9VEWb
         1M97+HHprw+gvlDYnLkYPaOoCE7uxN9Xf3LYm0J8css2Ri3MysguF4rXUi3q8advGsBi
         7VmsYZJJLh9pwv7gGkaeMpcN3t5ZGuZZITL5m21YMxyRVktlhJTwbMVZuLk9+ePDPd58
         yo+IHiDdkEOxA91r3a4P0I7lTDs7op1EikSgkLitM9OP1XM+6RCxJeAuNn0kIB/cicCy
         sIMA==
X-Gm-Message-State: AOAM530vpKWRaCqh4S1B4sVPvCBA0Q0C1M1vSK5xCDbYP4GOHSafGdBa
        UQWSFS0RHBf/iLWndFFeMhcSXKebYihP1w==
X-Google-Smtp-Source: ABdhPJyMbkoU9L8gdwXtKdmjCB+AJXYQinBQ37vKUI031WSaptX4tAbCHxToKWV0vJF03auC85kQlA==
X-Received: by 2002:aa7:dc42:: with SMTP id g2mr5477828edu.362.1623925398098;
        Thu, 17 Jun 2021 03:23:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:17 -0700 (PDT)
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
Subject: [PATCH 11/27] read-cache: convert post-index-change hook to use config
Date:   Thu, 17 Jun 2021 12:22:45 +0200
Message-Id: <patch-11.27-6ed61071c5-20210617T101217Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
References: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com> <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
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
index af5b97104c..f801313cc9 100644
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
index 82fdf29656..eecdef5a0c 100644
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
index b58531a7eb..24ab5d63c4 100644
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
2.32.0.576.g59759b6ca7d

