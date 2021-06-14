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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870E5C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F8676144D
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhFNKiu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbhFNKgX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:36:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E16C0619FB
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:33:50 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l2so14015825wrw.6
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0HrAaJ6IS93jhZY5XTLzxNtXyu5QKUvm92WhBzzxi/8=;
        b=AKJgtUZGGyF3GYI4hRR+vcjbCQojzSyU2Abe1bK1dtCyPCY9EJdAZlkV44e8u+hq0r
         uchUL2dXErbVB28WYU75tWg8cgphBwojS50AkCvHdf4IQUI5GuQ5gQLI80bblYeP+jky
         iA0ZCCKP1yjB3Mq5bNNiUfVWe7gCm1myMahxyfGaZeBrvd0gcgFDF1XYXtImaYxKcW0x
         Fazk5ljauTi1TvM0jmIr8bS+K4sQiikFjxrYZFE1Kz7HKmtwBIlXaVecWOH2KNc2LY+W
         uDCC7kzwjLuukteoQXDyLVVoGw5QqEJHOSX3A0HaeH3OWiDATdLJwqVY1rYNvc+NBd27
         F0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0HrAaJ6IS93jhZY5XTLzxNtXyu5QKUvm92WhBzzxi/8=;
        b=ahNTx7hCFERLZlcoU/Gn40lGoft/D/yqOPSHwc5XHdmpPUDzVU6Mns4fGChgjyfvF3
         FcaiXzVcwbQe7qGX3PKY77SuKHLR7LY7FKzqvkPIdRMK+aFPGdUwLvRsb97ijB8GU4SM
         xCIMHFWtc9qtF+7P0ObqYInxl6y8JGOSghoT+NV26kZ9hhwd7r3ONnu7Fom2odTi93f0
         nT8y2Pn2a5I/xuQu967lRWJOsorD5ahHv8VB09pQPf17KVBHG/uTKvP36tmllOXR3HsL
         p0lnlFS1BpkK7ipIdjLm+GBLghzodEIiTSLlqi0LWLw55GD5836amffPpez5nvd/FnAF
         GzRA==
X-Gm-Message-State: AOAM530lC6Fnv1A7NVwxcOiLMxBf3XAlxsGZDhkxlBDIUKCdE1zNaB84
        sWv9oNh/GmE+XVWQU3xbXr9BVd6Rem3kJg==
X-Google-Smtp-Source: ABdhPJzVsq1IRWBosCJ+awThxbVFi8gMFygTt1uvvN21Eoio0ZgnKvA87DzJoLsA+ZeKkg//vbScgw==
X-Received: by 2002:adf:f942:: with SMTP id q2mr17484533wrr.427.1623666828874;
        Mon, 14 Jun 2021 03:33:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:33:48 -0700 (PDT)
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
Subject: [PATCH v2 05/30] rebase: teach pre-rebase to use hook.h
Date:   Mon, 14 Jun 2021 12:32:54 +0200
Message-Id: <patch-05.30-51e6e72f239-20210614T101920Z-avarab@gmail.com>
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
2.32.0.rc3.434.gd8aed1f08a7

