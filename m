Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AD1C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC91B60EBB
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhKATCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhKATAl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:00:41 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B91BC06122D
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 11:56:41 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso126803wmd.3
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 11:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNL/Bo613nEHIkrJAY2T19zCcFNTguABxLUWg1g5Ktc=;
        b=TgKPcckwMLwGSmHxRHS8xgSUDGb+mgG3gq3LaDFhmh+hv/R09HFQ/SafOeYdt9lMJH
         bvyTw2VjNHRlWLcSOSYbhfwzeMoTDnwxgx9pmq3jqTXwGtZOCZav0wJCfiL3bxTsb15x
         vKldoW5dAuITAo1cMWlXUsY2cH5r6QCTEb71YIEZc/ZWTQDc/YnNM6O67RbbjF277qWi
         i/tD5rN5kcu8iVUeCmqk8BKGirnsWgUKe3zMaAkxBaZtScIV265JsyJu2W9/D+a2saqN
         bI/8W9pKRtH+hn5J6UprMsqmwG0ZhkTQNxJteVLQD5HeKmrj0zclmIoVQPa/BqVOjbb1
         bLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNL/Bo613nEHIkrJAY2T19zCcFNTguABxLUWg1g5Ktc=;
        b=46X46+1md2Kqi9CDrYBD3WsuRopUTvTsbcd+EaTqUSJB/V3ADIs0h4n9jLnVQ3LBwX
         PBRG2srjE6RzkE5pteBaCZLymf8ihR6OtHjkFeJGfdFlZkwHqFyU5o97TT1RsJcHLhyj
         cXzkJ5p5ByKOzJHAlYlQ1vWndKHZWbSVauPRwfPIwNMPLGPT0pR42S3Q3B54usA0s+28
         bDSTKmbCksxlu0NCY9NcchtU7dPHN0uKBbTON2LhK7fUX6y2JT6kScmdbTzKQRp03UEr
         DqYReoNSoIb7mOhwrWQBmVyjvG6ipjlNIDnH5FcU1d4rd99X8orovHPyQuSJf47+m886
         6Gbg==
X-Gm-Message-State: AOAM531x6oUyHaxaS92VnpIplkGWdTEEbUOh/sG7fwrNC3YDvhDMwuFS
        v3t3QsJTTyr0YLyskp0zY3vKAGlbTOB0dZH+
X-Google-Smtp-Source: ABdhPJyZ5pnfRlBEj3EPWHyFrxgw+RCY1jtjfnbKBR3VYF+2uidPK51ciQywzPVmBguZCoimtXMz8w==
X-Received: by 2002:a1c:43c2:: with SMTP id q185mr910122wma.30.1635792999369;
        Mon, 01 Nov 2021 11:56:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14sm314185wmq.4.2021.11.01.11.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 11:56:38 -0700 (PDT)
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
Subject: [PATCH v4 17/17] run-command: remove old run_hook_{le,ve}() hook API
Date:   Mon,  1 Nov 2021 19:56:22 +0100
Message-Id: <patch-v4-17.17-9ef574fa30c-20211101T184938Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
References: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
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
2.33.1.1570.g069344fdd45

