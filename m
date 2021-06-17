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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F47C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 669B961263
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhFQKZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbhFQKZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:28 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8653C06175F
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:12 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id d7so3339178edx.0
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ikPP/KaiGSCEe/M5dnOvxYdnI0jeLBzD0GOE9+f1t7o=;
        b=IUlHzvzMCqN8q2rlvaZhkNEqBXa4wirlABu3RlpmHMElp8Gr8yoO8B1R8NXq3KWlNB
         13yEIFNMEp6Entzf+6K5JcbFdJuk52GKDTf5jx8IHWkNQ1WxRXvc+VXt7vlRt60MLH7T
         7Qx1yO/d7mNosT5w8r1JP1uTwm2Jnjk7gqCXm62yQqz74p7Pzb71Hvgri2w10qMKpUQZ
         bOn0RxKvFDjZX/8SZabGB09V6dHXSZQwlK6aUDxHHs3IlfdWKu1w0vNn5/3PyGlyiLd1
         cjPrfI5YIVc1rnG56/KVkGaQgoDy0+CKZq88uljRzRXTsP+aKG9uJSxeHDl8qUCaRWtG
         G1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikPP/KaiGSCEe/M5dnOvxYdnI0jeLBzD0GOE9+f1t7o=;
        b=I/lmFMACupYwNWiwSmZMwVEX4XFyQCqqg0VP65bnfWm3p6fmhNC0Iuyz4010zVahTP
         /YbhanMZ2XW03pZLyUdfEE4s4N1KEGRKsVTeZjN86lK0LvG1Z6hGKCXpUJFXyb5THvRG
         ag8MVrQp5klqaQEzsQCfZB2ZowwTd0qG8dOPGE+DT6RZjVB6JVMcK8QSX7ezLkGcLZyf
         K94uFXPIN1fiT+fDmwj8x6Bp1pKX/vzuHJkgicUJvUtvg4x4ST5z//ZJrmVyTdG9UzJ8
         icrZMS11KZBofZnqw73VNBFKnMYL+yravxZI9X7jWjhJZeKaFADyN5SpOmdBTfMLK2vj
         IoXA==
X-Gm-Message-State: AOAM532pAKu08mzTI5bjsyevEWVPl2d6mYLK61fVZ7tjmdeMntpDWhXb
        MGBU69xIlgy2u66PR5fmKLqZER34PNrQwA==
X-Google-Smtp-Source: ABdhPJzVzYnfk7bIfpuxHpjGE3a2S6JhoylR5+50RIkEPNOKIzq5ubPGOgZzpA4uiCEPdk3xqNDQZQ==
X-Received: by 2002:aa7:d713:: with SMTP id t19mr5381060edq.144.1623925391235;
        Thu, 17 Jun 2021 03:23:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:10 -0700 (PDT)
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
Subject: [PATCH 03/27] rebase: teach pre-rebase to use hook.h
Date:   Thu, 17 Jun 2021 12:22:37 +0200
Message-Id: <patch-03.27-e9a1e7cf61-20210617T101217Z-avarab@gmail.com>
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

Move the pre-rebase hook away from run-command.h to and over to the
new hook.h library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 12f093121d..2081f6fa8d 100644
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
2.32.0.576.g59759b6ca7d

