Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE441C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 11:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbhKWLt6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbhKWLtp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 06:49:45 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F51C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:37 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t30so38387132wra.10
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=07AFTNsSr7V9ZQdk72NB0F2afEy2FZOFwDPFdsHg+G8=;
        b=mKoJ4LD496Vw4gEUwx4KeAT6oAkFyv8Mr8uFrtG8tafl16vi11UnlpHEmYbWdzJWhd
         44Rx0URTqhB2S8kSwMe4ay7my7V9w2P4r43FffEFrdCWMg47VYCh9P09KARCHpnO5l8W
         Mr8LbO0rm5J9Ps3heLoFXAA0N84HmR5QKcXATDvZEWzLKAFUFJ//mblhhiZxbLryyLmY
         2Sz/hNN+dKeA3IDQqXpvPM/Mfsgu/jb1iQ6LhukhrEnnulfoQsrA/62n11wRinrEOX7W
         r9WJXZE2zk89vEOQJe0LDN5WBRdU2dJfZQfzZXxH/o8PwtWf2mYB95QYpWOqq1RdqPym
         3JEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=07AFTNsSr7V9ZQdk72NB0F2afEy2FZOFwDPFdsHg+G8=;
        b=p9O2y+91itnrrQiFAiNQWLpffT7vUtapGmzkMq/28qVdtTBE//7ew1f6d54N49k1jp
         V6xEDayYBqtEJqD5BBDv/fElZWTd0d5T9f+YtqZAScjYtyZNfOIr86BojWP5auK9D6wm
         ZSACzNtH98NQD+PLPD0SMBbXdC7bDggHsTvICw/aMggGBbCR9mIUaVXU9+tbAVT88PKP
         XleT2AX4IUrVo264ZVK6NHbGw5rOv3oFmA/Aj2NtJfkEQZilQavfwOlyRSmf+1mImlOX
         ogY8+ylP+8TdyfP2J3sOvWBz87n8neKYLwtXI+tKJsYT+DwjSZOhJQ0FZxARKoohMqrq
         HNdw==
X-Gm-Message-State: AOAM533C8RPJGboJdvHLBIPrdGLUY2wP+Yrt4c807mAElAkzjQY8v0Dc
        9HEA/oDReaYcFS77jDb1a4eNTyLQBrYO7g==
X-Google-Smtp-Source: ABdhPJwnN628Rpu8cs+RlQsT90oJmyN6TQI3lcfqguC1j7iGGoP6SzGoA1pObgk+m+D10+czFo889g==
X-Received: by 2002:a5d:4989:: with SMTP id r9mr6675258wrq.14.1637667995838;
        Tue, 23 Nov 2021 03:46:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm1723145wmq.27.2021.11.23.03.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:46:35 -0800 (PST)
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
Subject: [PATCH v5 17/17] run-command: remove old run_hook_{le,ve}() hook API
Date:   Tue, 23 Nov 2021 12:46:16 +0100
Message-Id: <patch-v5-17.17-281d17b04db-20211123T114206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
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
index d7d64701ede..7ecff26c1dc 100644
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
2.34.0.831.gd33babec0d1

