Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477B6C4332F
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D2FA6108B
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbhJOJqC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 05:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbhJOJp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 05:45:56 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AE6C061755
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:50 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r7so25482748wrc.10
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DnL413pS/95T9SEnvgWCIASSFCqFwSCcqU7owSVXIOY=;
        b=N345xo7AVkhwARDgrzo3oVLM6H3EgnOPDz8huQlHN9w2a6RYA6WdqsdpL1KJRx1chO
         rRtNm9sMqbvf/4pv8J0wvcu1o2JMpN4LJbFcdqTlmmql9NCkCj+ouv268hICx2rD19pN
         DqWi2iAUEZSuD+AMcnV52xDPmQRu0cfvQx98Tbv86tFcd5mF2Bnh4WfZYG0/b5OXB0Nf
         L1troKVMDETRuMsPe6RkSmvf9zumf+TT3fxPH1rGNvUXytbhSYCjnYwCCGW22MuUsZAK
         iTLHa7+c0P7xTy8FdGKV+MEPJQk5n0paorZxPPUFmaamCU34NPuWLFoObHQqd7yxnlTD
         WTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DnL413pS/95T9SEnvgWCIASSFCqFwSCcqU7owSVXIOY=;
        b=DMqSe7UhFrwqs6SzZrUFOcvi7SSUgP0NHXfwWHZD0zQkpB0G3wrn1ckVjRR4zAT5Tg
         bA/RM1MxgGgh+VtrE8X6E/HsjcrI4i9I7onvknE1M/KE/o/ovvZjqEwR8TOo/4uDLdJO
         OgYWhQ0QFF/tNHEJ8Ydv6gxxAbmmlclOroldzGVCJbCDByLp1ItSd72clJbD20TtRc50
         2pfTf+8LIsKtTRu2eP98pYzvLYnyY/XXvbsAdzZgQyd0apsnwKuZHIlkF7+ZWa4EPMM6
         CRsxhqX2GBye0AE5zW7aHtxRNGZmNF8Eg3UWZfv5csCAiBJMeViRC5tXV35om2br0wmv
         uA4w==
X-Gm-Message-State: AOAM531623u9GqXnLNXsrSI4LoCFWtb61za/dPAwCy/f6Dte8adLO5Y9
        au6Cko7huYjMpOLjxLFT4j9cuQdlsH8NpQ==
X-Google-Smtp-Source: ABdhPJzSGDsz3T8JFTHOFrCXFWeZNkFXQG7v8GaOjRBIQw/uqcSJ2NfYA/xIPssydLUyC3BCcOvmVw==
X-Received: by 2002:a5d:64ed:: with SMTP id g13mr13072445wri.193.1634291028243;
        Fri, 15 Oct 2021 02:43:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r4sm5963648wrz.58.2021.10.15.02.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 02:43:47 -0700 (PDT)
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
Subject: [PATCH v2 03/13] rebase: convert pre-rebase to use hook.h
Date:   Fri, 15 Oct 2021 11:43:31 +0200
Message-Id: <patch-v2-03.13-6227a1e644d-20211015T093918Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
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
 builtin/rebase.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 8c6393f6d78..9a44939d662 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -28,6 +28,7 @@
 #include "sequencer.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "hook.h"
 
 #define DEFAULT_REFLOG_ACTION "rebase"
 
@@ -1305,6 +1306,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	char *squash_onto_name = NULL;
 	int reschedule_failed_exec = -1;
 	int allow_preemptive_ff = 1;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -2021,9 +2023,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	/* If a hook exists, give it a chance to interrupt*/
+	strvec_push(&hook_opt.args, options.upstream_arg);
+	if (argc)
+		strvec_push(&hook_opt.args, argv[0]);
 	if (!ok_to_skip_pre_rebase &&
-	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
-			argc ? argv[0] : NULL, NULL))
+	    run_hooks_oneshot("pre-rebase", &hook_opt))
 		die(_("The pre-rebase hook refused to rebase."));
 
 	if (options.flags & REBASE_DIFFSTAT) {
-- 
2.33.1.1338.g20da966911a

