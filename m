Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805F2C433B4
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6638C600D1
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhDYORR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 10:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbhDYORK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 10:17:10 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B44C061760
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:29 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k128so28537748wmk.4
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S6z0G57DdP3GQ5/enY3+6YG3xUz1kWofC9ozxQR0rBI=;
        b=ZX1p/kI/rrHCUOniYZ/vvV9iHU5XE3nWHPjbcnsIviGvgA0LiK7Qpb2lHsutT4Mvc7
         6ZAVxYD9xe+2hdH0M5RqV9AEcqP23eEM5wYZ6+DXGmrbiAVPerDpfKGQswTIJA//Vlf9
         KKaXOzuBMXvwyr8/cIiNantVkdg2ZiYRsRIqhtovEm7s2p/OHY25W3qBEY3GaBxmGNAy
         GLDSbOuspKUGFzwfzlYbsMljZRLPcjx5IshQXT2nrmjXle692GZbDvstiZmM0pW2gIQg
         Xk6DWCR9WTBJ6XQ8a8evGrQjQXiWZfKqUXEtzR24aBVm2qgfbn74lGzmQ2uvZ1jnF8aX
         YMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S6z0G57DdP3GQ5/enY3+6YG3xUz1kWofC9ozxQR0rBI=;
        b=tsuP/r/dotUy9wdh24fhfHcdMrGYtaYr5+/c/2AfY4Sm0pzUoRbrCfjdEqIGsfFuWX
         +0LmsGq4ikc271573KbFYVTwPwFw29sgqfvQDIK92pFPypY4UnwiHoxkNEpD0ldXbKOZ
         TavvshrdVGaZDYe5x1ki+RGIwarPgSGfWbtbb0KwSQkLI2e+Tq/pRFKrsZceEJfukRxw
         QoK9PsrGe/zhv4XC2nhrrzijtLZ/bboqqztVi2217Y09jCcIhcb+vKL1xe9eh+1MPfh1
         b2ffdMj/uoYKE5ToRL3G3xV904HisnongrfMVry+WgC8f5eOCB0OOQhvJsOkDNoJL8g5
         Aq2A==
X-Gm-Message-State: AOAM533vr+4z1tHVfujcYy+1wE6NO0gQVEUDT1j7YcIgK+PTKwnCz1s0
        NErzwR4pVtGPWQU/wYkqZPRn6+Yr57U=
X-Google-Smtp-Source: ABdhPJwj55LznK4l5LixC2Eyyo66rtV4Ur3oMdT+trrTuTYCQkP+sa2OwI5bTzhEkbmXr7JgPT3J/A==
X-Received: by 2002:a1c:1d91:: with SMTP id d139mr6511868wmd.101.1619360188326;
        Sun, 25 Apr 2021 07:16:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14sm12522683wmq.4.2021.04.25.07.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 07:16:28 -0700 (PDT)
Message-Id: <703cd9656bf8827565469c71a6bcca58f1a5647a.1619360180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
        <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 25 Apr 2021 14:16:19 +0000
Subject: [PATCH v2 12/12] builtin/rm: avoid leaking pathspec and seen
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

parse_pathspec() populates pathspec, hence we need to clear it once it's
no longer needed. seen is xcalloc'd within the same function and
likewise needs to be freed once its no longer needed.

cmd_rm() has multiple early returns, therefore we need to clear or free
as soon as this data is no longer needed, as opposed to doing a cleanup
at the end.

LSAN output from t0020:

Direct leak of 112 byte(s) in 1 object(s) allocated from:
    #0 0x49a85d in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
    #1 0x9ac0a4 in do_xmalloc wrapper.c:41:8
    #2 0x9ac07a in xmalloc wrapper.c:62:9
    #3 0x873277 in parse_pathspec pathspec.c:582:2
    #4 0x646ffa in cmd_rm builtin/rm.c:266:2
    #5 0x4cd91d in run_builtin git.c:467:11
    #6 0x4cb5f3 in handle_builtin git.c:719:3
    #7 0x4ccf47 in run_argv git.c:808:4
    #8 0x4caf49 in cmd_main git.c:939:19
    #9 0x69dc0e in main common-main.c:52:11
    #10 0x7f948825b349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Indirect leak of 65 byte(s) in 1 object(s) allocated from:
    #0 0x49ab79 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0x9ac2a6 in xrealloc wrapper.c:126:8
    #2 0x93b14d in strbuf_grow strbuf.c:98:2
    #3 0x93ccf6 in strbuf_vaddf strbuf.c:392:3
    #4 0x93f726 in xstrvfmt strbuf.c:979:2
    #5 0x93f8b3 in xstrfmt strbuf.c:989:8
    #6 0x92ad8a in prefix_path_gently setup.c:115:15
    #7 0x873a8d in init_pathspec_item pathspec.c:439:11
    #8 0x87334f in parse_pathspec pathspec.c:589:3
    #9 0x646ffa in cmd_rm builtin/rm.c:266:2
    #10 0x4cd91d in run_builtin git.c:467:11
    #11 0x4cb5f3 in handle_builtin git.c:719:3
    #12 0x4ccf47 in run_argv git.c:808:4
    #13 0x4caf49 in cmd_main git.c:939:19
    #14 0x69dc0e in main common-main.c:52:11
    #15 0x7f948825b349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Indirect leak of 15 byte(s) in 1 object(s) allocated from:
    #0 0x486834 in strdup ../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
    #1 0x9ac048 in xstrdup wrapper.c:29:14
    #2 0x873ba2 in init_pathspec_item pathspec.c:468:20
    #3 0x87334f in parse_pathspec pathspec.c:589:3
    #4 0x646ffa in cmd_rm builtin/rm.c:266:2
    #5 0x4cd91d in run_builtin git.c:467:11
    #6 0x4cb5f3 in handle_builtin git.c:719:3
    #7 0x4ccf47 in run_argv git.c:808:4
    #8 0x4caf49 in cmd_main git.c:939:19
    #9 0x69dc0e in main common-main.c:52:11
    #10 0x7f948825b349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Direct leak of 1 byte(s) in 1 object(s) allocated from:
    #0 0x49a9d2 in calloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3
    #1 0x9ac392 in xcalloc wrapper.c:140:8
    #2 0x647108 in cmd_rm builtin/rm.c:294:9
    #3 0x4cd91d in run_builtin git.c:467:11
    #4 0x4cb5f3 in handle_builtin git.c:719:3
    #5 0x4ccf47 in run_argv git.c:808:4
    #6 0x4caf49 in cmd_main git.c:939:19
    #7 0x69dbfe in main common-main.c:52:11
    #8 0x7f4fac1b0349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 builtin/rm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/rm.c b/builtin/rm.c
index 4858631e0f02..2927678d37b6 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -327,6 +327,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		if (!seen_any)
 			exit(0);
 	}
+	clear_pathspec(&pathspec);
+	free(seen);
 
 	if (!index_only)
 		submodules_absorb_gitdir_if_needed();
-- 
gitgitgadget
