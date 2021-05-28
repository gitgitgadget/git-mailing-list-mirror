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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0C6C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FBE4611C9
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbhE1MOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236476AbhE1MNg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:13:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E49C061342
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:55 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso4428969wmh.4
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p99YD4HVnPDTIi0NUGecUgtJQt+1orFFGAjsrdLOZ2A=;
        b=RtLjtAQp9BVLaTqgVy8lXXgo6qVR456wTRzKWPEqD8FvA+lk/BEpbOBzviSG1vNmfc
         LTqx8V5blbYOU6kUi2Jc78w07IjQ5pDaUJN0K7HHsS4jbqIYd4ax9lFelLEXB1kP9Utw
         /PExTsErmT69X0PnA1zVVbHbiWFbj4n1+cMp0Dx/y/388v/pwOzIHRYCqHn/FamZjNVM
         wjwfJVZzu1UEv+3utqXmoly/NLG9xEC6PdtK9LKoylTkilYyOv4S7143v+suXcm9euhb
         NZShoE+Ht5vtudylZmYlUrjSl/jhDt76u23IRlF5qN9V/GyWF0UFuCZ/QoNGd+sXt+89
         Rhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p99YD4HVnPDTIi0NUGecUgtJQt+1orFFGAjsrdLOZ2A=;
        b=qKA6EoShh9DipTO01NBuDQ8YoxJe6sFc1CNiuK/ouf5qd/X0+UKovXi4CeKznt9RT3
         +t98QxPphwERjQBHSBljZyZlSFIEo/Q3tGJ6uMS6FIheEO/iOOSRoD7VyqdVqNsiTACe
         NFrRTQR0vdMMi/M+oqiaYpycGES+Fml1M+nnYSvJFPLHVD90MVcqxIAl4y9A6a19RAq5
         eWRl3slsUimKUjjbjU2O8GANsREIVxkW1p6KLg8nLH1nv9DGthrWG8OQhCmp2cyl+h0H
         sn69XKDS95Sgd6hmd2KxXf5MhaG13r6o14Igl9vh8hWnHp9QtcqbdP6sh7kE8WfviaW3
         roFw==
X-Gm-Message-State: AOAM5300zz4sFh+QbWbB4xqCHm4S+UyoJswH0LlLfSaHJD+MnzC4FEVV
        U0Ns9F/oOSjDvVjWLRNYpUlOnf8yci6u7Q==
X-Google-Smtp-Source: ABdhPJyJ/tnDf/W8MZLFGkYNR2FHUaWaEB1Neg44gCYmDMHuGYkLgOFwNsWOn1wRsg4rP+I2fJNV6Q==
X-Received: by 2002:a7b:cc10:: with SMTP id f16mr8429644wmh.24.1622203914208;
        Fri, 28 May 2021 05:11:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:11:53 -0700 (PDT)
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
Subject: [PATCH 15/31] read-cache: convert post-index-change hook to use config
Date:   Fri, 28 May 2021 14:11:17 +0200
Message-Id: <patch-15.31-6482a3e4cb8-20210528T110515Z-avarab@gmail.com>
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

By using hook.h instead of run-command.h to run, post-index-change hooks
can now be specified in the config in addition to the hookdir.
post-index-change is not run anywhere besides in read-cache.c.

This removes the last direct user of run_hook_ve(), so we can make the
function static now. It'll be removed entirely soon.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 read-cache.c  | 11 ++++++++---
 run-command.c |  2 +-
 run-command.h |  1 -
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 775e970402c..a17bc30f870 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3132,6 +3132,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 {
 	int ret;
 	int was_full = !istate->sparse_index;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
 
 	ret = convert_to_sparse(istate);
 
@@ -3160,9 +3161,13 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	else
 		ret = close_lock_file_gently(lock);
 
-	run_hook_le(NULL, "post-index-change",
-			istate->updated_workdir ? "1" : "0",
-			istate->updated_skipworktree ? "1" : "0", NULL);
+	strvec_pushl(&hook_opt.args,
+		     istate->updated_workdir ? "1" : "0",
+		     istate->updated_skipworktree ? "1" : "0",
+		     NULL);
+	run_hooks("post-index-change", &hook_opt);
+	run_hooks_opt_clear(&hook_opt);
+
 	istate->updated_workdir = 0;
 	istate->updated_skipworktree = 0;
 
diff --git a/run-command.c b/run-command.c
index 82fdf296569..eecdef5a0c8 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1321,7 +1321,7 @@ int async_with_fork(void)
 #endif
 }
 
-int run_hook_ve(const char *const *env, const char *name, va_list args)
+static int run_hook_ve(const char *const *env, const char *name, va_list args)
 {
 	struct child_process hook = CHILD_PROCESS_INIT;
 	const char *p;
diff --git a/run-command.h b/run-command.h
index b58531a7eb3..24ab5d63c4c 100644
--- a/run-command.h
+++ b/run-command.h
@@ -216,7 +216,6 @@ int run_command(struct child_process *);
  */
 LAST_ARG_MUST_BE_NULL
 int run_hook_le(const char *const *env, const char *name, ...);
-int run_hook_ve(const char *const *env, const char *name, va_list args);
 
 /*
  * Trigger an auto-gc
-- 
2.32.0.rc1.458.gd885d4f985c

