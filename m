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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D221C4708D
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C1A611BD
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbhE1MPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236475AbhE1MOE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:14:04 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166A8C061357
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:12:08 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r10so3047049wrj.11
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DlAKzSA3B2Kp+0xcCtyzX097Eqwt1MMmLewOTJgUuPA=;
        b=UZOtuW/0dzUniH6qUzE8aqVsCgBmnRnCE+4F+aDw6cpdNcrVFOOlufx+oDhlZzy/2N
         4Y7Lov0VfGTmtutisTLhK5cVENd7kmrHHERBGCfrgTRMRhVmAkIRld31schQuzX+wmj1
         y+9DSW/F+pEr4HP+c+Qb2nh/Hm5+WeY3wLbD+wLuWiBmp2EgMUNMfOmCiXG6GK9VvCbB
         qDYs91VHKtJESMDNz6NqMm613w/LbaPT/bD7+sQkGXERZ6YuG3/esspmBTpZixbSXTS5
         91J+cJ3A9UtsMoKxPozsl7To1GHSuqYjKA2K3YdSE+ImWJH9A2zBmsykM2EaYsbl/sAS
         xJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DlAKzSA3B2Kp+0xcCtyzX097Eqwt1MMmLewOTJgUuPA=;
        b=przbxfkiye28KzYePt36UbjWa5IBxVNIP8V/2PtOmdiHzk8gze6qQtl1c2hcrYWMVF
         bmyrGdv4RCAPll6Y8aBw5GxGvSJxzoFMTRSw0aEOkPVed4lZuxjfzaGEsSciA6t8NhyR
         //Dk7EsDkLn5ooTAgQJ6XN+5kf7Z/cIwvoqAYMJqMsCx3VzywNZrqnwRVQR16W+aLe4p
         w0lJyQ6A0xUvKnKpiaUB+wtZVOqqXnuNYD5u+h/V6OMpzkHlUvxUojUpbkPJvo6zIw0V
         1Qd3RiX7z8POx6y9dCH/2716FNP6KiMAPBWKS/QG6CQdNPeurXxM+3bNGhiSUe62mhfW
         vgvA==
X-Gm-Message-State: AOAM531+d+Zr5zksBF2ZyA6Um9hlEYzNfHZyw26C1wo5vpKdHT4zpm+M
        4kpRiWTciACWRgKL46nP4hASshMOOwtPMQ==
X-Google-Smtp-Source: ABdhPJxfifGkZkgIfteRPgkbTPi1ldzYKCvhTngqG1eKGfRoduGswmjxxxog4VNJRqGNGGz87HJheA==
X-Received: by 2002:a5d:66cc:: with SMTP id k12mr2806812wrw.185.1622203926463;
        Fri, 28 May 2021 05:12:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:12:05 -0700 (PDT)
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
Subject: [PATCH 28/31] post-update: use hook.h library
Date:   Fri, 28 May 2021 14:11:30 +0200
Message-Id: <patch-28.31-3519068a634-20210528T110515Z-avarab@gmail.com>
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

By using run_hooks() instead of run_hook_le(), 'post-update' hooks can
be specified in the config as well as the hookdir.

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
2.32.0.rc1.458.gd885d4f985c

