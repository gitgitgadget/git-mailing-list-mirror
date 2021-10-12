Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45314C433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AF3860F23
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbhJLNd1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbhJLNdW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:33:22 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79789C061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:20 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z20so81083207edc.13
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lKDeerjw7gH8UCoPGHuOtep1D7ZSA4jINp4kuhDSpd0=;
        b=BKvp2lYft+Nh7klqd2w31dSp5fIH+pCQsInGODtQaU1ULvCyLeCQCO41Ud2W37s90A
         dfCkN4MSlLovOfjCZM0k0NWdyesX6lLd5+cvXxLUBRdOCKGFVCw44PVl0ZkhSwVn4SaJ
         WKRwFiBmT+EmwEa32YgInu6tVadZQy4mrBLIH5JvxYLNA3DyqlshIfxEW+uALI87dBDh
         C1YGuiENhV+4K+fHZ4TCd4Wd1Aq0h40vN15ZwYC6q+9GGTkZR+wKC+xLt0hXPpsE/Yo+
         Gm94UNE63F3hv+Xs7u8ciFUsBesunxE8hp2eRA0Cc6KsuYYFIxH3zP3orU6woVVKASyg
         STsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lKDeerjw7gH8UCoPGHuOtep1D7ZSA4jINp4kuhDSpd0=;
        b=8HQKPJE9X1g2LEUCv8zqRxvGUzh/Qtw22a10qOY7g3SsiIP8IF2Oa0lSTsyKbtbFeh
         NWu4DRdSNQpuBMioW5FNWDQZ2IaClP2m2DaxCMHOidGiqKBDJfZzAIJVPSzHrKO//azJ
         5nQ5Lrp0ymN7fiQHLJuaLDsCvcDYVLWW7qEeU2LzU80uqtgf+UQkyiZyzobfyVP6XntW
         zfxTDmuKy1zGEOz5arBRek0hih3lszXDqMwQls3vVzsYzrB+1vN1p3P1crdd+HeF+DQR
         uS/HPtpTqSpLhrCpX+NzmI1/gg8S4a1KLO8qpd+fW5uKt8pp8pyA6G5vIF5iPc04k+ER
         q6kQ==
X-Gm-Message-State: AOAM533POyeAxXs6i8LqQZtMhzAq9IkNNSX1gWNy69IkMIWbTWYYuDHd
        G8Ca2RIMx2dLmVPYSaMHYmTn7bPyDT9M+w==
X-Google-Smtp-Source: ABdhPJw2Q9RE6ME2uAOIjZMqiBA7HhyfIai1F5w4C+Ib8U71++aBfrMAVKXuucoqztp/Oa+xuJuOug==
X-Received: by 2002:a50:be82:: with SMTP id b2mr49858576edk.56.1634045475778;
        Tue, 12 Oct 2021 06:31:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bi23sm2016405ejb.122.2021.10.12.06.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:31:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/13] read-cache: convert post-index-change to use hook.h
Date:   Tue, 12 Oct 2021 15:30:36 +0200
Message-Id: <patch-11.13-e762fce32af-20211012T131934Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the post-index-change hook away from run-command.h to and over to
the new hook.h library.

This removes the last direct user of "run_hook_ve()" outside of
run-command.c ("run_hook_le()" still uses it). So we can make the
function static now. A subsequent commit will remove this code
entirely when "run_hook_le()" itself goes away.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 read-cache.c  | 10 +++++++---
 run-command.c |  2 +-
 run-command.h |  1 -
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 9773118d078..84cc3d88196 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3087,6 +3087,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 {
 	int ret;
 	int was_full = !istate->sparse_index;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
 
 	ret = convert_to_sparse(istate, 0);
 
@@ -3115,9 +3116,12 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	else
 		ret = close_lock_file_gently(lock);
 
-	run_hook_le(NULL, "post-index-change",
-			istate->updated_workdir ? "1" : "0",
-			istate->updated_skipworktree ? "1" : "0", NULL);
+	strvec_pushl(&hook_opt.args,
+		     istate->updated_workdir ? "1" : "0",
+		     istate->updated_skipworktree ? "1" : "0",
+		     NULL);
+	run_hooks_oneshot("post-index-change", &hook_opt);
+
 	istate->updated_workdir = 0;
 	istate->updated_skipworktree = 0;
 
diff --git a/run-command.c b/run-command.c
index e4862b8f46d..7a05aa73e3d 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1323,7 +1323,7 @@ int async_with_fork(void)
 #endif
 }
 
-int run_hook_ve(const char *const *env, const char *name, va_list args)
+static int run_hook_ve(const char *const *env, const char *name, va_list args)
 {
 	struct child_process hook = CHILD_PROCESS_INIT;
 	const char *p;
diff --git a/run-command.h b/run-command.h
index 5e544acf4bc..f06b39c50ee 100644
--- a/run-command.h
+++ b/run-command.h
@@ -239,7 +239,6 @@ int run_command(struct child_process *);
  */
 LAST_ARG_MUST_BE_NULL
 int run_hook_le(const char *const *env, const char *name, ...);
-int run_hook_ve(const char *const *env, const char *name, va_list args);
 
 /*
  * Trigger an auto-gc
-- 
2.33.0.1567.g7b23ce7ed9e

