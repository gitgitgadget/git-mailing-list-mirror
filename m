Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F096DC433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D34B16115A
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhJSXYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhJSXX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 19:23:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B743C061776
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id y74-20020a1c7d4d000000b00322f53b9bbfso6278590wmc.3
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bKrItP0zbojqN3+1uTVCHuuxgw4usBahZeVWsTUgJak=;
        b=FHZ+kE5KzJGoxC9frQH3pOJwgaul5XqyqJ6w2Fkf34ZJvem50mk+5+yawNDiAnEV/C
         KiZGGp1tqAIiBBJTRMI3SDAobSy8oPvXZNBZl9EDozdeZq0J4mCv6hGzzrHjGsOBSrNI
         InNT3SpGaEBBVX2eOMnVECbKPgIe2qoNYmdO1cemKqBmUUmfeKIOu0nqevmgKhwk6UsN
         KPvGXPuL8IYL7A2lLKteE8BLnl2ZGPK8tP/H67sMx2iSSfHZal8RMLLN3NJ9d8hylZzJ
         VD1222Uq5+SlTazOfL/T5l1lzmFqoaDVfLF5umeQh+0PIGELnKUGraFwYa5Oi7azWQkK
         dmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bKrItP0zbojqN3+1uTVCHuuxgw4usBahZeVWsTUgJak=;
        b=na3VI4fntMf+clNALYfMZr51o4AwDk14dQAl+l4ZEK7CvrABSNl+Z+WUNfL9c2xVBC
         jgC4uUmaLxrLz4ob+kn+Cf50gAdhRTzJM8aiMUvwpmMO0MrvPXLwedi3fpecoGSsOV9e
         dAVejx0xlfTlgiTcAe0NCR+Y0gk4a8t+wL1ErWk5g68BXMPGMCobY1LvzDjjxg9vV38w
         0HZCm0qXSxdsXficNjcWWVVomzNUf3OaZEZvgrryV/nBUyQmIOB2ggLsY885foUkMAID
         2Eu7SQurDiShb/vs1nbmBXr5mAnH+VGSih2I100yFXNprH8u6bGMKNDOkZdMun2j71ea
         0ykw==
X-Gm-Message-State: AOAM532GF7VvmHIeKBj4Ds6f8ufROr9cZ6XJyuSBSrJFLHrq7Dg1oba6
        HpDS6uFAkHMinyejhkPzcrwXjaiBOhtiWQ==
X-Google-Smtp-Source: ABdhPJwRopp8a2zew/CeaO6BXoaGI6MFepjjT6lEZgA4leagPEmpyTxNWX4pEZZBwQyhswfycMqB8w==
X-Received: by 2002:adf:a2d7:: with SMTP id t23mr48972349wra.156.1634685702894;
        Tue, 19 Oct 2021 16:21:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g25sm304644wrc.88.2021.10.19.16.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 16:21:42 -0700 (PDT)
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
Subject: [PATCH v3 11/13] read-cache: convert post-index-change to use hook.h
Date:   Wed, 20 Oct 2021 01:20:49 +0200
Message-Id: <patch-v3-11.13-39069a9c3ff-20211019T231647Z-avarab@gmail.com>
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

Move the post-index-change hook away from run-command.h to and over to
the new hook.h library.

This removes the last direct user of "run_hook_ve()" outside of
run-command.c ("run_hook_le()" still uses it). So we can make the
function static now. A subsequent commit will remove this code
entirely when "run_hook_le()" itself goes away.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 read-cache.c  | 11 ++++++++---
 run-command.c |  2 +-
 run-command.h |  1 -
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 8a50ff66b30..6674df28ab3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -28,6 +28,7 @@
 #include "sparse-index.h"
 #include "csum-file.h"
 #include "promisor-remote.h"
+#include "hook.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -3101,6 +3102,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 {
 	int ret;
 	int was_full = !istate->sparse_index;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
 
 	ret = convert_to_sparse(istate, 0);
 
@@ -3129,9 +3131,12 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
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
index 7ef5cc712a9..d92e670c8ed 100644
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
index 49878262584..3fa7454cf8a 100644
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
2.33.1.1338.g20da966911a

