Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F20C433FE
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242301AbhLVEAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238973AbhLVEAD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 23:00:03 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A46C06175B
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:00:01 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e5so2059200wrc.5
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FREPKRs4ZWNCdjOP6rplEQxzOfMcjra5hssbyxqAsho=;
        b=EQ9vK8Vnxw8P2ykkNCZ0O/n1Xo0MAFQZGac2uR616OoEOwfwDxMfYw0YtbKRkx6Psn
         0e0BdeMf8/Rge50NNcKg9vBMzmDgSyUi9ngWyFYKoYWN4c2nTRGoyOYpgPMf02ZzG/oG
         OVaA9QZhrCKB33xU7wsCxBI/YDKVuYzr+fchYtVFacIJJvvPA7tzDiOTyUdAhWLcfLAO
         rar6wnquw0VDQarc7LxvaULQO5g36iFT+fhifA2TQHQzptdJtG9YUGK51QGes3yhHWcD
         pGR5N9XSQJEN0hzcxRcT8A49MgXy4sC2xPwTK0/dKIBvUBSJgwPLKZyb3XwW23tNsT7m
         zowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FREPKRs4ZWNCdjOP6rplEQxzOfMcjra5hssbyxqAsho=;
        b=aVEwM+kk7bBUk51kt7jv8X6cvQglOe2JqCeMyaC4N7Z+DpTxeQO8u8a5M73eE2/Zup
         mRargBfJICUdtuNverdXpSCDE/9EWFlRJ3z9auzWF5S3lABor2xwAwmXIw5q3/NIcUkV
         I+gZG2Qp18EPM85yj+2Nx+3mqW0FNrH5a/o+dwPpeK/4Es+8rUi65SD5OSOCLs9Xho7R
         kf+xFHOetnG7BJNIIWjiWKUCVAyB5hYY5Qrd1u0Tc4tn39LcsJIq+d04HJX6zKnxO2pa
         TfaTmqH1pM70JWbs117y3HKNwvc/Imfq+5JS/5lFhK8qXkvhZsiLwzhE66qxxo4WCRe5
         d6tg==
X-Gm-Message-State: AOAM530aJJhfrBCFnLILulVfZgpEuu+2S8Uz2cXSACCjw0pQCOCSdQ6X
        ytFkpdLthIdbi9BgP00rGqAVNbSJAPVgxQ==
X-Google-Smtp-Source: ABdhPJzkhOWlxVA85w5fx+cgHWndVATjMZrYJ1hnjeeYCr88TrNTVNTUbEB8vQr2d5+1s0u7Xs5OxQ==
X-Received: by 2002:a5d:47cb:: with SMTP id o11mr701964wrc.686.1640145600242;
        Tue, 21 Dec 2021 20:00:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s8sm867300wra.9.2021.12.21.19.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:59:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 17/17] run-command: remove old run_hook_{le,ve}() hook API
Date:   Wed, 22 Dec 2021 04:59:43 +0100
Message-Id: <patch-v6-17.17-7b99a4b633c-20211222T035755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
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
 run-command.c | 33 ---------------------------------
 run-command.h | 16 ----------------
 2 files changed, 49 deletions(-)

diff --git a/run-command.c b/run-command.c
index ea09de040a7..f32e4fe1326 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1313,39 +1313,6 @@ int async_with_fork(void)
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
-	if (env)
-		strvec_pushv(&hook.env_array, (const char **)env);
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
index 88a398c300a..07bed6c31b4 100644
--- a/run-command.h
+++ b/run-command.h
@@ -220,22 +220,6 @@ int finish_command_in_signal(struct child_process *);
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
2.34.1.1146.gb52885e7c44

