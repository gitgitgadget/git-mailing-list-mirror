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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EC6C48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F24B61057
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhFQK0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbhFQKZq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:46 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2509C06175F
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ji1so2838679ejc.4
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mlEQsBswfm9PJHjnBmRO4pSRm8aTdjk9znLndlRKjsk=;
        b=so6CgctMgHqUPyMdd/Ie9q9BXYFzvFb5JIRJOTpWN++QNnRmdc5Lv1gy7XKiRTN6N/
         dfEleZTcCuXPVgmGfp5vlb9XrrcdAQPmdcYEK1yJUAhtQZChCXXTvSr2iAky/VKExvl/
         T7YWLui6ts9qsboZebBOuHAPO/u/VUWjyEZDxHXaq8yiqMvxQY4hcuKDYJpg+Ip4QRKz
         ej34h5DS39Wr+JNa9yxlhyG2n+H8MhFs9SHKISSWpI7qJuaYja/OY80p3rZdFAi7Mou4
         X79RHULjhPmhlnBa6BpB7zBynQQArSvwP/rSLBCBLsWkWnYz3NCtehI2g87S9NmPcmhC
         RBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mlEQsBswfm9PJHjnBmRO4pSRm8aTdjk9znLndlRKjsk=;
        b=QM65sfxuxAKhcsHAegORREjkEik2krANSr+bBCFxHJ7+lZhjiQAcnWyNw0Fq4SYpGs
         F+MtAeiDQuRqT7Yfhei5GwA0I0aKJSv9ePQXqE8iHMU/CvK0Hrp4Av3DxLuDVsZ9bDOC
         kvmtNcbRsN8cMLXn9uL2cJUlTsppTPUd0YTkxT8NGNVcN74JJbScXJ7/mRAt9yMafd4e
         G9Td8ESd5AywDahD2wPql5jL7RfLPeXPVWKoBGsFEf+qDlm1pHMGu4+CzQWRURvt4L6X
         Gnp52/SoRZhnMrDPDQlKxyDC86wUsJHuWOJaR/UtORxuseJ4Xz8p+JMZhYXgEDTZmm7K
         OTEA==
X-Gm-Message-State: AOAM533ZO9JtUIVaqJwBaos2wA0T4/SySy+S2SGxZclmkC0mxGTU1Qzq
        DSGqWdxa90tgWEdAHOXjpct/0Fuaj+r1yw==
X-Google-Smtp-Source: ABdhPJwRuIpLoVJoCzOUIQbZlsV2QIh6R3KmeLUEcYDeprmf/jW3rCTrwLPMXZGOioXvV+eMu4zyGg==
X-Received: by 2002:a17:906:c211:: with SMTP id d17mr4436797ejz.247.1623925410404;
        Thu, 17 Jun 2021 03:23:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:30 -0700 (PDT)
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
Subject: [PATCH 25/27] post-update: use hook.h library
Date:   Thu, 17 Jun 2021 12:22:59 +0200
Message-Id: <patch-25.27-0bdc4878ac-20210617T101217Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
References: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com> <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 378f8f6b5d..b2ccdb66da 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1657,33 +1657,21 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 static void run_update_post_hook(struct command *commands)
 {
 	struct command *cmd;
-	struct child_process proc = CHILD_PROCESS_INIT;
-	const char *hook;
-
-	hook = find_hook("post-update");
-	if (!hook)
-		return;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (cmd->error_string || cmd->did_not_exist)
 			continue;
-		if (!proc.args.nr)
-			strvec_push(&proc.args, hook);
-		strvec_push(&proc.args, cmd->ref_name);
+		strvec_push(&opt.args, cmd->ref_name);
 	}
-	if (!proc.args.nr)
+	if (!opt.args.nr)
 		return;
 
-	proc.no_stdin = 1;
-	proc.stdout_to_stderr = 1;
-	proc.err = use_sideband ? -1 : 0;
-	proc.trace2_hook_name = "post-update";
+	if (use_sideband)
+		opt.consume_sideband = hook_output_to_sideband;
 
-	if (!start_command(&proc)) {
-		if (use_sideband)
-			copy_to_sideband(proc.err, -1, NULL);
-		finish_command(&proc);
-	}
+	run_hooks("post-update", &opt);
+	run_hooks_opt_clear(&opt);
 }
 
 static void check_aliased_update_internal(struct command *cmd,
-- 
2.32.0.576.g59759b6ca7d

