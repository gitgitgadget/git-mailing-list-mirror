Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4794AC433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BA5F6115A
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhJSXYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhJSXYA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 19:24:00 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF1BC06161C
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p21so14962202wmq.1
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d0G66Uzp3mHCuMdixa/D6kvWiz/NaCj53nVaYvW3At4=;
        b=pKk4hLLQGWFC+d4Ddq3jbsrn7RRHRyGML1kx7xLvgu9qiYBhFcaDQuPHQ5F0boJBCF
         tHxscKopFXYfrz0DNnehTT/53au9ox23DHB4pheR1bE95LkU9+RvY9EgVoYeB1mRIis8
         +MEDdKrQ4NQE6+n5PjmBBELIwkpSZP8W5s022jOG6xY3GZviq1dQCxPmcU8wkKzG3ucq
         Nf/CBEsDilXlSSrA0arELQ3t4TvAVRZozAQEBnBe7LFnu9dMrlQzRmLoKa+fKObQIBTO
         OJ0Ti1w4BYK1zYonT3aM6q9mG1WBtS8Bop9hGF+SNcaNfIJ5v1NrZU82XbnLtVQ0o4eH
         jWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d0G66Uzp3mHCuMdixa/D6kvWiz/NaCj53nVaYvW3At4=;
        b=gnG8dANqCrZRAcMXDZYa8yFGU8YMQnzsV/LokPGI8i1myCvhkmEjdUlci5bhVnaizd
         t6xLzwErBOCnRNoGbB0E3fdUFUWmUavWCf3/ULXHSNDbf1z7qlFYaGA+jf238vwe0nPQ
         htEdJnQ9c3QPrWtYLubB+dP4fjoyT3wDiM8T7shNi9/wfew/cL4wp57QW7wlYYkDQBt6
         3WV/SBvAhDCx8KpGAgS+XkW+MxfmTPBa+qfozYib/U9dA4Kk5ckvx5D9QE9HPEQU2yDT
         JLIRB6nFuJlRGGIPd5CJqJpMufIuiclzL4tb8oAbmf2WBNi7r+fPJaFJDZy3xFDn3+Fm
         0w+Q==
X-Gm-Message-State: AOAM531tsWTTiscnTk2kB8yQYhlB0+AKczKKwex4HFfGmi0SXI9sxmc7
        3eKwdZzEvk7kTrKoBclBcBsEOut9sCRb6g==
X-Google-Smtp-Source: ABdhPJySez+f25+CqjqaYeD0W6WsVhjwlMNUf1Dy7fMfUGCn5xeR33YKCOdL3PMqkmWjR93RUKos4Q==
X-Received: by 2002:a05:6000:154b:: with SMTP id 11mr46778211wry.422.1634685704844;
        Tue, 19 Oct 2021 16:21:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g25sm304644wrc.88.2021.10.19.16.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 16:21:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 13/13] run-command: remove old run_hook_{le,ve}() hook API
Date:   Wed, 20 Oct 2021 01:20:51 +0200
Message-Id: <patch-v3-13.13-1bc080d3611-20211019T231647Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
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
index d92e670c8ed..8a21ff525f3 100644
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
index 3fa7454cf8a..59e1fbff64c 100644
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
2.33.1.1338.g20da966911a

