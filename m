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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B58C47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F79601FD
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbhE1MNi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236305AbhE1MNY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:13:24 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DDDC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:48 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o127so1990020wmo.4
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pFyNt4mCuC/3gswFUmq2Sq7Y3wIuCybTNd41AG0A2DM=;
        b=kaZIOT4uHifskW4yVxe7BUpPph87FxKw/2fFwTWDQbVn5MFyzWKxyLzhllp/iccuaF
         4+ASIs+gjJomRShSHxaO3TUbOFMc3BnGS+kF8jDJHp6iQURfgkEAq5V0gVmhFR4Br49f
         gcc02dcxVt3R/qzKLu7xeTWkSp9QYykw5e6fxpdB4x7P56hpTQ0iPZ2Jun/hs7XEpMta
         i1+j1EfVLzbjRV7oZ1X0Um9qTkjXgTALFf7QlxegLm4u9OhYRjeNIGKag9jL6DS2h+cO
         KdzGDOXHFAY5kA2e/37VASgGy20mYrrh28AMRBVM6NQ4UNd1Gxh7VCEQd+NodAfL6Eu3
         9VSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pFyNt4mCuC/3gswFUmq2Sq7Y3wIuCybTNd41AG0A2DM=;
        b=Vjw1B2HzhtbEt9CtBosYtw008K+Am+N80KYgskTE2wHh7oTqt/qm2BFItuzcCOMhkf
         igiM2XuGuA1uw95c4PNYa+0A/6itJ+E+niuZve5LxtluZGSE71bXL57LaNxQmEh6tHLe
         XOXVpx4h6zpPe/cE3jAfZCMBEDFWbrlep6N4p0ZVBJu7nHUVSxze9NKllwGAmfEjjf/L
         OdVzGAfTdkjlF0ZHkKzMTA0QBAVvueq5ab6kb3vsRn9jGZWGnWNIs7pe3ArEdaTuLf2M
         H6JmwfUOJ36DuN4zGSTLHy9L4/Kv4oq+5E08d0B9pHLNUwzZzO1V8ZvUXk5NthRtrTrN
         Z8Og==
X-Gm-Message-State: AOAM5303ttjqYf/w9TQHOEfr9u1ReJi4jHYd+Z0s1Gd5cGCiai0iElOw
        nQvoTgIEgdeetg2HWv5P8PhReKT2xL76Yw==
X-Google-Smtp-Source: ABdhPJwoaGTrwRvhuV3Kis9y0rX0AuOixq2nZ9CQM5RhRNPOUY9ggkKbYkWJ9WQXQPAai8BNgaVoEw==
X-Received: by 2002:a7b:ca58:: with SMTP id m24mr13235396wml.151.1622203906769;
        Fri, 28 May 2021 05:11:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:11:46 -0700 (PDT)
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
Subject: [PATCH 07/31] rebase: teach pre-rebase to use hook.h
Date:   Fri, 28 May 2021 14:11:09 +0200
Message-Id: <patch-07.31-528402fac69-20210528T110515Z-avarab@gmail.com>
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

Move the pre-rebase hook away from run-command.h to and over to the
new hook.h library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 12f093121d9..2081f6fa8db 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -28,6 +28,7 @@
 #include "sequencer.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "hook.h"
 
 #define DEFAULT_REFLOG_ACTION "rebase"
 
@@ -1313,6 +1314,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	char *squash_onto_name = NULL;
 	int reschedule_failed_exec = -1;
 	int allow_preemptive_ff = 1;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -2022,10 +2024,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	/* If a hook exists, give it a chance to interrupt*/
+	strvec_pushl(&hook_opt.args, options.upstream_arg, argc ? argv[0] : NULL, NULL);
 	if (!ok_to_skip_pre_rebase &&
-	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
-			argc ? argv[0] : NULL, NULL))
+	    run_hooks("pre-rebase", &hook_opt)) {
+		run_hooks_opt_clear(&hook_opt);
 		die(_("The pre-rebase hook refused to rebase."));
+	}
+	run_hooks_opt_clear(&hook_opt);
 
 	if (options.flags & REBASE_DIFFSTAT) {
 		struct diff_options opts;
-- 
2.32.0.rc1.458.gd885d4f985c

