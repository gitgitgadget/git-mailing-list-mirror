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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CD7C432BE
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB92660EE8
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240281AbhHCTkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240248AbhHCTkB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:40:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD08C0613D5
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b13so15628614wrs.3
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t4H3xaN0d4Gpz07+4ueidJHFlNnY5PP6O7RkIfFF49Q=;
        b=XhUnoKzw61+SQWBLGVE/VgSb4l6M8iMSC/r9HU/O/jKDB6kHdQOLA+CxwGj5tb/wQ8
         htKFzWY3Ksgrfhsvlp2lHijk153N8co11pc+HZoZc1J/ORr20JFg37hKBjYQHKP1Cc7a
         Y+CIc0GA5/MOYNcFQaRyqCxljbqvuKDHhO7rLVoKGfz50j6PaKqAcriThYtAolG9LC3P
         BtFQm29OhyL4l5GCcm3MlcwYzMdYv3kdkCfPh5NC9+H7m9nFkOZAmiw5CEFTBOrJoZaf
         dSlzzwwB5MosrlSxulhawZHOYjqu8tD+JD+39jWozU7cd1m8WL2yH6M7fgAnju60nX0F
         NVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t4H3xaN0d4Gpz07+4ueidJHFlNnY5PP6O7RkIfFF49Q=;
        b=sm0VYuGxN8MjDQSn6YjvM51Hdhuv/CIjtL926gyyqN9mk0MA0UtbN0OG/1TJJTtYwS
         sGDDONJnU7p978VQ+sL/kXlTQmfIUBfXrZv5b21MLKD0WQpnLYXfeipMJcgRji1azpdj
         ma7f9M7vzRH1sQffMB/Ns9GrsyitoePE+5MXVkc0yCJSh/Yl/FpxE0AWg5f5k8k7nKFn
         nDDlvVaPSC/bF/bp3TQjUxcHaxhvtP27yJ70zMlyD8e+WgmCAd5iC+X37TwO8U1xUfaj
         5v5F0ujJWC6tAoVBMWs/iJgSb2iWbvpf+khF7S0zpq9QbOUlaseW4KvzTC9RoE5oHFxV
         o1tg==
X-Gm-Message-State: AOAM532+sTW5Alr/PVUP/czCn/62s0g//m0ODzKm5IRrL4eR7iCVE9Ak
        Ew8EexdfS+OsLzpY9OcVxlGify9BEYcolQ==
X-Google-Smtp-Source: ABdhPJySi+895Gmm5Gl1ApK0lcfGZ9Pzy65wydHaX/zwEMv325VxIR8rolN+EeRAc2zcZB3Ifr80NA==
X-Received: by 2002:adf:d225:: with SMTP id k5mr24529431wrh.10.1628019582894;
        Tue, 03 Aug 2021 12:39:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:42 -0700 (PDT)
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
Subject: [PATCH v4 34/36] post-update: use hook.h library
Date:   Tue,  3 Aug 2021 21:39:00 +0200
Message-Id: <patch-v4-34.36-f352a485e59-20210803T191505Z-avarab@gmail.com>
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
2.33.0.rc0.595.ge31e012651d

