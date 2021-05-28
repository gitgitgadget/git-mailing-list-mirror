Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2097CC47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06673611C9
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbhE1MNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbhE1MNX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:13:23 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFCBC061760
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:47 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r10so3046106wrj.11
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fMxzbAjD2oqFrcGDtoYjkHgDGiS+DZ0Z8CPr+qlbeUA=;
        b=U/irqKXN/UVDRgcdZscjQjo2kBey53NsOhYF7uXzufyYmvct1NpPD78otDpH9SdZN1
         Buh4oAniJr3jTh71ZLOVxuOxJvdQ0qDBgq7lK1aB4o3yJ1kJEzRrVzt6yEs2p6Lug8in
         vGXUN79GA2MnvKREiDoiO0Mgjg6lWYW7fzij4V8CfO5YRrVLasd91M333l4sImEt59tz
         CYi1ri78+EoaCTD19arLd56tI3tFZ6g5t6QRDSeclEXFgo7bhTx72TgFC9S7VKnNJBAu
         wcguFpe7xMtTz2bFfpYCjzW8NNdcB5A3n9HcqEQcR/ll7MmTeY7oEY8K6NygAjoGWzjo
         zuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fMxzbAjD2oqFrcGDtoYjkHgDGiS+DZ0Z8CPr+qlbeUA=;
        b=rUal3sXpF8XxDLhUywMdoBpjULtoUHOpvAIPT2az77sYTdU/QILwtpoZVwchpYPxaX
         8p4eCLCyihjl4m0OjGJGIktkvPh22ShOq9/mnHd9LU0CywMbloTLjEqUdkjVkis71Mtf
         Ia3RRXblNqc1kPNRtiCBbCg8rhXvAZ2kN80Fmw+TNqRWkl3r0cim0dnT76jbgz6dZ74J
         4VDhKOu4OuJxkL976FO1XBXO/sRSc92N49EgzHsiZkpo9ySlHpJfpp5etWvpIW55LSlD
         Uef8x4IiQxZ1FamFLnR62S5s0OZ7qQX0ysxUCSCoierTYzB92lf+ztGW36b0My7UlUj1
         TRcQ==
X-Gm-Message-State: AOAM530dMyu8LfmBkl8elnB4uvnBipa/2DU3eJNpyWTf92/SJP7VQ3b3
        0ROTS+A/N4HDvPFV3r9kmwPskKmHaiZIYQ==
X-Google-Smtp-Source: ABdhPJx5+A6zhtg+QtXNqtKojNJQKKj+0UH2FQ9kHcjI/V0bQDmkSNWGrmYwt2C7WckhALQMIT7EXg==
X-Received: by 2002:a5d:66cc:: with SMTP id k12mr2805026wrw.185.1622203905937;
        Fri, 28 May 2021 05:11:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:11:45 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/31] gc: use hook library for pre-auto-gc hook
Date:   Fri, 28 May 2021 14:11:08 +0200
Message-Id: <patch-06.31-b186fde43e1-20210528T110515Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.460.g26a014da44c
In-Reply-To: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com> <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Using the hook.h library instead of the run-command.h library to run
pre-auto-gc means that those hooks can be set up in config files, as
well as in the hookdir. pre-auto-gc is called only from builtin/gc.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index f05d2f0a1ac..a12641a691d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -32,6 +32,7 @@
 #include "remote.h"
 #include "object-store.h"
 #include "exec-cmd.h"
+#include "hook.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -348,6 +349,8 @@ static void add_repack_incremental_option(void)
 
 static int need_to_gc(void)
 {
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
+
 	/*
 	 * Setting gc.auto to 0 or negative can disable the
 	 * automatic gc.
@@ -394,8 +397,11 @@ static int need_to_gc(void)
 	else
 		return 0;
 
-	if (run_hook_le(NULL, "pre-auto-gc", NULL))
+	if (run_hooks("pre-auto-gc", &hook_opt)) {
+		run_hooks_opt_clear(&hook_opt);
 		return 0;
+	}
+	run_hooks_opt_clear(&hook_opt);
 	return 1;
 }
 
-- 
2.32.0.rc1.458.gd885d4f985c

