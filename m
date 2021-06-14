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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33304C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 144B361476
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbhFNKlH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbhFNKii (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:38:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70099C061226
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:34:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q5so14003573wrm.1
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Csbtn5cRttyubGogbl9HJqZG9OFQrrDlf8OCzLI6sJM=;
        b=B8QT0LXiH+E1zBU6V+iu6Lbqg9LUnCGjQSC/h+4ixHce3XxlxfmKeGC9ofV984O2tP
         FDitflKk46FsYEY7yF8l6JdT9Oq5Q/eQpXZr1ssmCZseb4MbnLadxSDyVlDwUYsFFFD8
         0rCo+AWK9a2FfNG3fcSc4OzrhD522DdQYvFvord9rpF7P8p74I9+58KadI+gkqGwf22r
         1BSRpBiCHSsL4gWYwhPrjkZ3rIbXSWxxI1spk9ELvVCtfqtqiV1OveWk+CD+TPxAy8rm
         fjt0PRiv8vzFMqYRulQgXivrwyLGg4c1TD7nclLB2j2k+ZwySqZK+aejmtAraH5My44n
         oEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Csbtn5cRttyubGogbl9HJqZG9OFQrrDlf8OCzLI6sJM=;
        b=qWj4gOF4VmBTfONSywk53fb1XYGO3VOABqgLgogJ7Rzw7sNRmuEIeQ408eAMbffN9c
         jEsHUu7Fo3C84H76bZNxLL2KAPjUL9mLuFvTRbn7eyherqPPcBkhgwbnZ7V04kFhXs+r
         UDSbPVHyOiq6nrebXK4J4HgX7Xdz/4vkMfNzVOvk4bmzSdB+/YWCWtuzUg5FI0tZQ3Xy
         T9q9vs3oB3U/Q4BLJ/Gy28k5vZaOysjaUeN54+kKOYerPCyhqEhqzOHJYbwWVbuyO0cn
         usSZwxbBtz00XU+12SGxblIuytL9kMjdyYoVz/b6QuPyzo7I05dyMhbVxOXMonRr9lAf
         2H8g==
X-Gm-Message-State: AOAM530JYgSz9XzzyyCtq8Z2lI36MgHkId+Y5aldPMvdCg68PclCvzGJ
        7sKJwXvm4r1b6BSBMwq0kq6oj5UC2Kzbkg==
X-Google-Smtp-Source: ABdhPJxRdWI8bBkiT0Gmabl4kHDKJbdQ7TVlz0yaTBVtMP6TMoTz7nfEtV93BpkKyMPpLXwVhx5O0g==
X-Received: by 2002:adf:fe8c:: with SMTP id l12mr18086642wrr.26.1623666847860;
        Mon, 14 Jun 2021 03:34:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:34:07 -0700 (PDT)
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
Subject: [PATCH v2 27/30] post-update: use hook.h library
Date:   Mon, 14 Jun 2021 12:33:16 +0200
Message-Id: <patch-27.30-ecaedd13b89-20210614T101920Z-avarab@gmail.com>
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

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 378f8f6b5d1..b2ccdb66daa 100644
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
2.32.0.rc3.434.gd8aed1f08a7

