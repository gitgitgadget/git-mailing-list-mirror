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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273E2C432BE
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 108E460BD3
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240212AbhHCTkB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240216AbhHCTjq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:46 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028C0C0617B9
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:32 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id x17so6860837wmc.5
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pTUqsOmWrxDA46ORPGY23DfKfx3BNCou62QzFUhxel4=;
        b=OUly5AMcEe1FRsI3US8AsFionTGBuV6vIWPTzybOv3NSfyqKKOxSPdPUJrXNbsKwa+
         pMx+J1kQVVgFUrFAV53BEY1xdAUxG9U/xnbSHMD8/4VtVJZ0JyLlNY6mxXqwYueWTj1S
         uPDlcZObbDuglWDKCFJGiNVLVxoYwJybylSnijNowj/W3Jpk16aSl6FKtQzV62wZfEUM
         jnqWA1n/suiYGJV7x1nCPq4xHXdyoqIOxqf7+72qnXIb+FDAe28qZHtogIyBHgwu1P+q
         WwQH2C57HKFsH5IAQovhyrE8n+CSsbIrVcud+t6PIjD/ewAAHl3UrDdhBUBNF0aB33nW
         pGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pTUqsOmWrxDA46ORPGY23DfKfx3BNCou62QzFUhxel4=;
        b=BG1TiUgZFCt+oCFPi/nM3NTDKLyjqEnRzoVn4x4uqgZU7A3rnYfyd/oarbpvhi8quA
         BmuMNpbU/hvqq8RkxW8xwAw40a8u7W0yI6PT8NTb3TqkSy8Z8OKXJguOlP+qBXuh2bTl
         H2EcowRMm2IoiP+ouUPsgEp5osM17d3UznKGfT19QtKbD6+ehcGp8iODMLQ3zxbafBEn
         Y4D9NFwUhLiYG9aKF84AFCIK1bASwZfF/Lo6vM2jLNBsJH/8QFoKd/Qo2eOzwCEtt7dT
         LxxKMKJPYso2KDGjeKh2icVOY1HXKMitS9sittPOCya6MOPVEbFhN3JK2TCPFA0hU0H8
         rZBw==
X-Gm-Message-State: AOAM532dRpQf2M+7tOBQO3emEyjfNFDmw9CN3piZYXlSX4S8axNyO1Y5
        oWmBjZLmMTabmT9x+wpUSU25eiTLdQaVHQ==
X-Google-Smtp-Source: ABdhPJyLigKCgbxjiNav6U29HEIqIqK1DZV2ds2bj1lWNCIUTl1HX3HA+UEPb0cxGZOx6tS6/CPiJg==
X-Received: by 2002:a05:600c:4fc4:: with SMTP id o4mr5075730wmq.109.1628019570381;
        Tue, 03 Aug 2021 12:39:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:29 -0700 (PDT)
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
Subject: [PATCH v4 20/36] run-command: remove old run_hook_{le,ve}() hook API
Date:   Tue,  3 Aug 2021 21:38:46 +0200
Message-Id: <patch-v4-20.36-070433deba5-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
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
index b4341ba1c7b..1399243de8a 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1320,38 +1320,6 @@ int async_with_fork(void)
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
index 7a867d41217..cfb6887e4ae 100644
--- a/run-command.h
+++ b/run-command.h
@@ -204,22 +204,6 @@ int finish_command_in_signal(struct child_process *);
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
2.33.0.rc0.595.ge31e012651d

