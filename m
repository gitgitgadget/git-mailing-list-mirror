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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF99C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D115160BD3
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240220AbhHCTjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240190AbhHCTjg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:36 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32628C061798
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:22 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l11-20020a7bcf0b0000b0290253545c2997so81552wmg.4
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BkBFiW6mSuq3FMAcykrlw52LcUdZ2+9qWA8uQ4ChYP4=;
        b=eNUfh42pzi1vXDX2wWB2yCuo2kSBtK99hADtZDM84GgUky4+CIe65ciWX+P8tiCdOz
         kIK1sRdVF2mRqSBA3WGC0lkiumYv2lTsDLevpYSBLduhJLAdNZkRRZlbgg7A4m81xgZS
         YoiYjw9lI0dWPmRw2g+/DTjKDWDdhuIDk6T9i92pD6hs6gRkOkwS+ckbASkRce6EQXnl
         jkP3xe3YoNl1KBVfhAvygvQ/yBBO8WIOZ3fC8uND0zGxJiiQt0Dr8pWkzuhwUpK9fbno
         wiTic8cbYCLnSaFVOVrq2vTo7oH6QATgTy2QdYfMc+MSyHrluiO7pzLOJSVRhrWEVj/d
         JHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BkBFiW6mSuq3FMAcykrlw52LcUdZ2+9qWA8uQ4ChYP4=;
        b=Ce4P5smokaBnKu44o4W29TYMVWCSaINF9BfyvbXIrJFmfYFhmbm9arTgQ9WNufthlV
         RTa4ukSma4OHGCZ96OmCykpxGDHF0ZFnoTEtq2sMLUCfyRH2RLDxaY8lL18E6D8M//CH
         XzUeEfBSmmE0oUh14e+gYhLYGxPXlyooBZ+ILY9fWaX5RPyP7OllABMTGg84Pc9KXfDf
         9zZRWwgLKWst6yV3iw6BTo+5CVKL7ylRtOBrEyk4ewxmdS7/BFuXfJH34TBYiVuRR2gy
         DLxS8xy+4APycaPbkU9vGhurn8mMLtvh3AQ47qFVtzHOpJzg4/HP1zRrqlmeZDdZdtNi
         HXdA==
X-Gm-Message-State: AOAM532qclaoTXVgKSpGuZkfKmyq8RLki+Us8AlZdDEeV29wOjbENnI0
        uGWo8rzOfwBK0/h2OU0E/fgYstYZNYn9lQ==
X-Google-Smtp-Source: ABdhPJwMAxSgxMdb15EXrquxELLr+5zDNW7e3ihrpjJOkPfWCyRN0cBJjmcUJcMOEpj9VTQWFDpfpA==
X-Received: by 2002:a05:600c:4f49:: with SMTP id m9mr3440385wmq.82.1628019560512;
        Tue, 03 Aug 2021 12:39:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:20 -0700 (PDT)
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
Subject: [PATCH v4 10/36] rebase: convert pre-rebase to use hook.h
Date:   Tue,  3 Aug 2021 21:38:36 +0200
Message-Id: <patch-v4-10.36-3ee55d2c10f-20210803T191505Z-avarab@gmail.com>
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

Move the pre-rebase hook away from run-command.h to and over to the
new hook.h library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 12f093121d9..e7c668c99b1 100644
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
@@ -2022,9 +2024,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	/* If a hook exists, give it a chance to interrupt*/
+	strvec_pushl(&hook_opt.args, options.upstream_arg, argc ? argv[0] : NULL, NULL);
 	if (!ok_to_skip_pre_rebase &&
-	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
-			argc ? argv[0] : NULL, NULL))
+	    run_hooks_oneshot("pre-rebase", &hook_opt))
 		die(_("The pre-rebase hook refused to rebase."));
 
 	if (options.flags & REBASE_DIFFSTAT) {
-- 
2.33.0.rc0.595.ge31e012651d

