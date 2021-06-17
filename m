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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56DBC49EA2
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7522C61245
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhFQKZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhFQKZi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:38 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823B8C061283
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:21 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gb32so794306ejc.2
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wkoP/cJDwE1I+78BvbNe+HvpElmd1BUlc71OLYDtOds=;
        b=JiOSEYNJrtO3GFI9zwWm76Ozkq3VRaf3CV0OvQJOxaFFw1MAI7eAnjaOtvrvpYdUAi
         w32Tvjjg05Ai/HORmEO0M1Gok1Z/7mogWb1+s1Q66xstW96oR5b7yBxd51+AfEDhK5qs
         OXdDUFGEkpUNK+wyc9y+dXrX18gVllYxRkoWiTIachKlf0sljP5WE7i86OsczHGssHfu
         nw4QpQ0Fgk/mox2OV4tv9MTE6mvWhg7PVTgk61D3T4WbJ7S1FwKvfV4E30TJR3F+ZYmU
         mUx97BGm+ImbdadvUPMsPxOeWCGE2axlKOtPlLd60c1AAKT+nzoa2jiqi970VrRKFn6U
         V+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wkoP/cJDwE1I+78BvbNe+HvpElmd1BUlc71OLYDtOds=;
        b=VkaLPRvnVhrwYgyYC8VRoh1YcZjMWEClYH2FazZrVXXeaRhZiC7CKzdJl9TFTmluly
         52880h1Q/OklMu0y/VjRmgqb9eAUV7KmaHukehySPifOQapBB9MQbULlJOOgz9+l8k0X
         01IpiGPPPhytpiKcOvMpLWNBrWXc4v7kn2k2sAhRo54twEMu1QwJiNd7t2c0+3qlGPXG
         RQbf14Yd4eF9J/GEsT/KPq4YrJrcrvaT8jDpsF4STxILQGuZu9RkEtBJqzBAHa7I4lWn
         JbZOeFqyxF3FWcdVAB8pcc38SGtmQkcDqgkChPRsRGM5zFjfmFoKVPKbB5doYvKbOhKq
         srNg==
X-Gm-Message-State: AOAM5302+B0DQXOJpTJ+u5p+bELi5YIP6MA3PgYJqjFLX7yMaymCJAwU
        cgDbUTV4PxLTftvy+SMaBD91AktY+sHoXw==
X-Google-Smtp-Source: ABdhPJxM1W8eSskBMC2CO9E+p9GfiQTos5zwkydBY9p4WoZQQm6XhgGBI6C7CQPn+BOCA6iFscABQg==
X-Received: by 2002:a17:907:c02:: with SMTP id ga2mr4407593ejc.215.1623925399852;
        Thu, 17 Jun 2021 03:23:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:19 -0700 (PDT)
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
Subject: [PATCH 13/27] run-command: remove old run_hook_{le,ve}() hook API
Date:   Thu, 17 Jun 2021 12:22:47 +0200
Message-Id: <patch-13.27-e3dda367ec-20210617T101217Z-avarab@gmail.com>
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

The new hook.h library has replaced all run-command.h hook-related
functionality. So let's delete this dead code.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 32 --------------------------------
 run-command.h | 16 ----------------
 2 files changed, 48 deletions(-)

diff --git a/run-command.c b/run-command.c
index eecdef5a0c..95c950a4a2 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1321,38 +1321,6 @@ int async_with_fork(void)
 #endif
 }
 
-static int run_hook_ve(const char *const *env, const char *name, va_list args)
-{
-	struct child_process hook = CHILD_PROCESS_INIT;
-	const char *p;
-
-	p = find_hook(name);
-	if (!p)
-		return 0;
-
-	strvec_push(&hook.args, p);
-	while ((p = va_arg(args, const char *)))
-		strvec_push(&hook.args, p);
-	hook.env = env;
-	hook.no_stdin = 1;
-	hook.stdout_to_stderr = 1;
-	hook.trace2_hook_name = name;
-
-	return run_command(&hook);
-}
-
-int run_hook_le(const char *const *env, const char *name, ...)
-{
-	va_list args;
-	int ret;
-
-	va_start(args, name);
-	ret = run_hook_ve(env, name, args);
-	va_end(args);
-
-	return ret;
-}
-
 struct io_pump {
 	/* initialized by caller */
 	int fd;
diff --git a/run-command.h b/run-command.h
index 24ab5d63c4..748d4fc2a7 100644
--- a/run-command.h
+++ b/run-command.h
@@ -201,22 +201,6 @@ int finish_command_in_signal(struct child_process *);
  */
 int run_command(struct child_process *);
 
-/**
- * Run a hook.
- * The first argument is a pathname to an index file, or NULL
- * if the hook uses the default index file or no index is needed.
- * The second argument is the name of the hook.
- * The further arguments correspond to the hook arguments.
- * The last argument has to be NULL to terminate the arguments list.
- * If the hook does not exist or is not executable, the return
- * value will be zero.
- * If it is executable, the hook will be executed and the exit
- * status of the hook is returned.
- * On execution, .stdout_to_stderr and .no_stdin will be set.
- */
-LAST_ARG_MUST_BE_NULL
-int run_hook_le(const char *const *env, const char *name, ...);
-
 /*
  * Trigger an auto-gc
  */
-- 
2.32.0.576.g59759b6ca7d

