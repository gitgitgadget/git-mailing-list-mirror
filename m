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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EDBC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 088C46108E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345252AbhIBNOZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345249AbhIBNNy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:13:54 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32167C061153
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:12:23 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u16so2867459wrn.5
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f3Aptx88VzJU4nhBaEFhaOt5AUMCXSA+aMK+eoCZ5wk=;
        b=EdDEM0/iOWHhKWh54jSGDqILXdakbA/aC/Afe0t/P2ozTmpiBcPKefosjixCx6np3Z
         rGiD71FRJ7u7KTKK+z2jWNWMDnpDEiMM7smdKPVW9TtWKTLXsKa74qNn8FYvj4cFC+90
         fFsItZs3yfSUPubXAmYfw7qunDenJYToxd/lDk1M1yovYVDqstRxO44PcN33s9N2jgpg
         e5P3w432Owb+jKYr74rMXxKW6M1QMUdrPWZJRkyQPazg3b66R/rFQzMuMn3jEofcdZTV
         2CoHcf/qQDVV7/GuCmK1WHz11zCHNB2iDrHczBW1zrf2BnEc9Clo/wDTPDji6WDYJQbu
         8Dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f3Aptx88VzJU4nhBaEFhaOt5AUMCXSA+aMK+eoCZ5wk=;
        b=SYfanAop2zCQ6n6g8/bq5UDBm8LJu6PfKk3UQOr++oZxyhUcVjM9Zdmz+oKsCEBYRh
         zzo8WeYMNyT/o0PfTGJWUW1wIBjGNyfLOsCwT+5Ae1fXmOVXGoWUHHJJBhz9VwN8ybxV
         Vl0neUt5iayuyCHpF4bpjwoOtdSlh4yrXbNf+qnfC5RI0dYPLuIfQDOQnqqkV/c4wiKh
         IAaGYVaS1PNJIkIb1JKNUzB7gOR/er8p9rQEZhhrDS3hgbSL6Xq1mf96DWh4Nm97g91t
         1zvRSeFTy6MZCXjuZdevhNX9odaePukNOaQMcLZWJSUHBIyZkowjpO7nCPvIeyCmwNr9
         QK9Q==
X-Gm-Message-State: AOAM533Yhd5rCx/yv8gBTcmc13bYl3nohHHOist6qMpX7QQlwUnRWZlh
        T+yVQ+fUCFPdFRarAV24/nLgiayUTb8LOw==
X-Google-Smtp-Source: ABdhPJzf+rK0axWycxdM2SBvwMwuDIAw23LmtMRc+kIpjTFXmicXQo9/kFT1kz2pKDnXJPlTj1GtmA==
X-Received: by 2002:adf:c18b:: with SMTP id x11mr3774666wre.204.1630588341532;
        Thu, 02 Sep 2021 06:12:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:12:20 -0700 (PDT)
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
Subject: [PATCH v5 34/36] post-update: use hook.h library
Date:   Thu,  2 Sep 2021 15:11:34 +0200
Message-Id: <patch-v5-34.36-a20ad847c14-20210902T125111Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
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
 builtin/receive-pack.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 31ce4ece4e7..26e302aab85 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1650,33 +1650,20 @@ static const char *update(struct command *cmd, struct shallow_info *si)
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
+	run_hooks_oneshot("post-update", &opt);
 }
 
 static void check_aliased_update_internal(struct command *cmd,
-- 
2.33.0.816.g1ba32acadee

