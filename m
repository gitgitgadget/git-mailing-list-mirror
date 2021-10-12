Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA513C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B76BE60EB6
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbhJLNda (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236896AbhJLNdX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:33:23 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0565BC061745
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:22 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g8so81218708edt.7
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=etAb3RTVGQOQ1l0KO7fd+/AN9YDkbZqth6qtUGTjzqs=;
        b=Jo9ynXedetBULxbbWo/bBX7bJJkcsGkQljjLfk4cZRaQHMaBY4y/WhNvt91rGA4ymZ
         a1z72yWw4mXzZJb8aFQqNHGRBr1Vy29/AYFuyfaFTtG4l3XZ74dXWnXYwSrIRNXi8EkE
         I20q8QkXYACxC4xPYtX2po7bcztA5SDuYxv7VAh93C13MU7vw6avdD1V1gl4xMA1imMh
         YOxh6AXovoGxc+MfSzepu/kzwBEfHiUlw0PorxzEDVUBsLUg0CgIXcxBiUQHYDAyuFQN
         gVIos5iQgkSWEXhDlVIU4YPXIfgSViuIpaGbeMcdt0cskJEon9twzLXdizUqml7q9tLr
         tpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=etAb3RTVGQOQ1l0KO7fd+/AN9YDkbZqth6qtUGTjzqs=;
        b=eMuWojeMwnFzkwObXIHnmaVSkLG3uFiHaigZyLxCCVpoP38ctzfUK3X4OnLDgvrqT7
         RIp2d7qWHqB+cMPmkv/mriWEQgWJ/5Lrs+0vc2tLPcl1XFQvsSQr8mWse8gWR6alXhNl
         E1ssUxo3faYMylBoDFk8lrl9eXJUeUDuoDOVkmvmrVP5XZJKn43Z8sWtJf0MmSOj6xeS
         9kc9FBYhSD6qbt98mI9bjPyOR1q7/4RnkOX6jwC5YvDMoIpR5rzwfzoKY9LaaNC3Riww
         n3h6zabnG4w9sEF4NKzE0BYvUOpk/T2I1yuW+WqlCrQdo3zYs8dcuB3TU1jY0++ph090
         gr4A==
X-Gm-Message-State: AOAM532amx72zEPpzFZ45JYFgck+Xm5lV+I9YJJo2LrXompjHwU1WewK
        YTqIj2XD9e+ddYqlxRu26j0FdInpyQzVHw==
X-Google-Smtp-Source: ABdhPJyu3SVMwQUdLXTGUowTot1/GXyxX9QszyuvUeqZRrHxLbWEKbxTdpTVFunZRlIDNSLckzWlmQ==
X-Received: by 2002:a17:906:912:: with SMTP id i18mr32483159ejd.131.1634045477566;
        Tue, 12 Oct 2021 06:31:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bi23sm2016405ejb.122.2021.10.12.06.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:31:16 -0700 (PDT)
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
Subject: [PATCH 13/13] run-command: remove old run_hook_{le,ve}() hook API
Date:   Tue, 12 Oct 2021 15:30:38 +0200
Message-Id: <patch-13.13-fe8996dda3e-20211012T131934Z-avarab@gmail.com>
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

The new hook.h library has replaced all run-command.h hook-related
functionality. So let's delete this dead code.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 32 --------------------------------
 run-command.h | 16 ----------------
 2 files changed, 48 deletions(-)

diff --git a/run-command.c b/run-command.c
index 7a05aa73e3d..e39ce17d009 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1323,38 +1323,6 @@ int async_with_fork(void)
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
index f06b39c50ee..6d6c50fe0a9 100644
--- a/run-command.h
+++ b/run-command.h
@@ -224,22 +224,6 @@ int finish_command_in_signal(struct child_process *);
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
2.33.0.1567.g7b23ce7ed9e

