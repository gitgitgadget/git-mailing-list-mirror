Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C95C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 11:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbhKWLtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbhKWLtn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 06:49:43 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AE5C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:34 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso1975218wml.1
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=frEk3qpS9FC+yX72+I6birfDNCIdPpN/tyFL8oNp9RA=;
        b=Bb+UskuypgcVR0A0mIrjaKv8GEG5xriNoJ9eQXaPxyOh+4cInRmOy3ZLLpfzZrSAK4
         YJ7kofm44x6kB+WHLkKsbf5UaAyySjedifj5h29fBp2N/A54nsi9NLHYIHCNl7uoNVRX
         OKPh/Sv+sw1313ueoZIx4T4RlrKQwBhkkxV9KM4zaRELINMRotGPbRF+3CEuzOaBysiw
         GrKWW1fhFe9Cov+NznQrUPDO4Joj1B1+q9IKTkBcHBJ0a/Fmj0Ku8SVRFyMgRBV4GzpX
         ayniRgFkNe2wbruyE1uv0izNV06qrWRTG2szS8StcaoYDXbWBAvbxmGUPPQeDMlxZm43
         ztBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=frEk3qpS9FC+yX72+I6birfDNCIdPpN/tyFL8oNp9RA=;
        b=jU33GuyYuOtlt8DHlix6yFWctmOwnQdTwGNgqNCaLTpRZ6Fz+MIwU2bay7YU42QOk1
         Vs+PcJeJKsrd9XlfUEvurwrLVDR7DL0W9eR1El12dRad2y6cdnS7Aidp2jojev4y2Vb4
         9qIQ4WdnCWzRPAyRjfH323NZnYPEq3Kq5pNWyetMj3w1K+QZ2ddeq+LTRhPkdmTak750
         Z6IAYPztXphNHzo2gGL2xuBAM7q6a90XV3CXdrg19Mc6bmhjqSu+N60FDHKqegf++OSS
         ZEeirIV4u1FPJqszLEZCqSZhxrKXNFNcYHFcN4uk231hoEpf7XoRfEIyMt8hoMeJx7/F
         E3RQ==
X-Gm-Message-State: AOAM532MhLfliiqXqSKF/hbHkf+pSypxcak5Ajl4uRHX5i5OqDRIaCrd
        Lhl8mFvgxKKkezH3R9UYCaNmO3eoKFCyeg==
X-Google-Smtp-Source: ABdhPJwxW79SDMPlNbJuscTEyEKHr/CZFq0Hhg4Lo2kmwBkQzIS6Ff50GxUt4apaVkJZE91hNxL9wA==
X-Received: by 2002:a05:600c:350c:: with SMTP id h12mr2197878wmq.123.1637667993253;
        Tue, 23 Nov 2021 03:46:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm1723145wmq.27.2021.11.23.03.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:46:32 -0800 (PST)
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
Subject: [PATCH v5 14/17] commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
Date:   Tue, 23 Nov 2021 12:46:13 +0100
Message-Id: <patch-v5-14.17-9a5956cc028-20211123T114206Z-avarab@gmail.com>
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

Move these hooks hook away from run-command.h to and over to the new
hook.h library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index 551de4903c1..581d7dc216c 100644
--- a/commit.c
+++ b/commit.c
@@ -21,6 +21,7 @@
 #include "commit-reach.h"
 #include "run-command.h"
 #include "shallow.h"
+#include "hook.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -1700,22 +1701,22 @@ size_t ignore_non_trailer(const char *buf, size_t len)
 int run_commit_hook(int editor_is_used, const char *index_file,
 		    const char *name, ...)
 {
-	struct strvec hook_env = STRVEC_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	va_list args;
-	int ret;
+	const char *arg;
 
-	strvec_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
+	strvec_pushf(&opt.env, "GIT_INDEX_FILE=%s", index_file);
 
 	/*
 	 * Let the hook know that no editor will be launched.
 	 */
 	if (!editor_is_used)
-		strvec_push(&hook_env, "GIT_EDITOR=:");
+		strvec_push(&opt.env, "GIT_EDITOR=:");
 
 	va_start(args, name);
-	ret = run_hook_ve(hook_env.v, name, args);
+	while ((arg = va_arg(args, const char *)))
+		strvec_push(&opt.args, arg);
 	va_end(args);
-	strvec_clear(&hook_env);
 
-	return ret;
+	return run_hooks_opt(name, &opt);
 }
-- 
2.34.0.831.gd33babec0d1

