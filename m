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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5559DC48BE8
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4189061469
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhFNKkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbhFNKhK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:37:10 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A473BC061148
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:33:58 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso9097007wmc.1
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6fFontTwR5y5vMRitA8g33Aprg/qaLpm4iJrlCgRw50=;
        b=lQhrUzghLbrtFfkyvHTiS1U4cDdkddhZZUTpc6EKwalwTbj24+BoddtoQkb6B9g5iT
         kfyT5kcZ3MUHcSkw1jZXnx1u5y79nzUDSXwpCpToCJN1aT+E50QHHb/nVctKbfe6T33G
         gzAxrI9eAY71B2Y9xns455kh07KPha3T+DNquBwAwuBg0ZNox1jLV2Stlh5CAJkjtFs/
         k6cn8b1Uyl9yuz+OkX7eNToUQ/4+3kllZrhWYNBtCnykvCCd5QvBJEvhHZ4NwMQTfGSj
         kFD4In8N9poPIU6Rzn5FuSZMOim9MBsUN35qCU6h4pmeay6Qj8+aSmmlg4YtmaXNmjOT
         DzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6fFontTwR5y5vMRitA8g33Aprg/qaLpm4iJrlCgRw50=;
        b=jkJbjybDTcpbmPcVn8dkzVH4M3lkBgOafT0l1yJDpTmGGEWkVKdPFFKbQkKKZdzwNs
         ZCfWCzYtYC86NcPDJtiY50dNIXgGqBUNWyGivfZ3X4UEZf8nyAMvFu4+Cp9KPAYsMBEU
         gyhLgWPQjnN9hOthDCajQkX4tugTWfQsw96Ogk0MQE+1RnEYJUFTkD1F7dmncOtxS/zq
         i3TeFKB8VzsrCS98fpL6QJsrn4q7JrpkYvlO1WOleBcgbOIX/uLmujtI0vH7OQKI/3pN
         iU5tjfmbjdgRt3yCnV+M6vcH1PXc8NmflTp408TlSKQ8ZtVZLzI4m0pIDaUe2xbgFxTP
         yDVA==
X-Gm-Message-State: AOAM533rnXmHMOzLGncUGbLPv0s10WRvLQa9Ex+1/vhYCCzr3LW5w7Mj
        JXVC7ZwUbeehev2qn076GhDsn7oTfFc+rA==
X-Google-Smtp-Source: ABdhPJx586Edr6qShKck6HMbLCwEN103Rys2ItuQ7/R+KOYq5uJP4l26jh3kWfJmHTmxKYHOYEGPAQ==
X-Received: by 2002:a05:600c:21cf:: with SMTP id x15mr31494320wmj.174.1623666837096;
        Mon, 14 Jun 2021 03:33:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:33:56 -0700 (PDT)
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
Subject: [PATCH v2 15/30] run-command: remove old run_hook_{le,ve}() hook API
Date:   Mon, 14 Jun 2021 12:33:04 +0200
Message-Id: <patch-15.30-477eb2245c3-20210614T101920Z-avarab@gmail.com>
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

The new hook.h library has replaced all run-command.h hook-related
functionality. So let's delete this dead code.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 32 --------------------------------
 run-command.h | 16 ----------------
 2 files changed, 48 deletions(-)

diff --git a/run-command.c b/run-command.c
index eecdef5a0c8..95c950a4a2b 100644
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
index 24ab5d63c4c..748d4fc2a72 100644
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
2.32.0.rc3.434.gd8aed1f08a7

