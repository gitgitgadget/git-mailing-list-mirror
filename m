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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0584BC48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEDC561166
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhFQKZa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhFQKZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:27 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B941C061760
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:13 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z12so3300238edc.1
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rFIzz+YV9rwqDHJ90Swqsb73lFK2nN/fXrEnUPBnKyg=;
        b=uqE+cVBkqGxMTCPFbaht4lD7cfdW95lyYFnK05ldiBolyJYpY6P32R2O8NnZZ3MNWU
         WnBBtVL8AsBJ/75AnO3P48sGEL/3qWIyqyPn052viWWAjEQa172njhZjKN2UUbID4QrA
         8TyLm0yygiIni8cbqYYroCf65mfyRm8CD93s/aZ74k8XLpnBDX7j1vpRXsG1+biejynQ
         5rSDoboJ1NBSazz/zNqD1BlU5Nf+fxA0SQGykydfH0G+J/lzVC8/UaO650yfKR5qKelo
         EAVEjLTVnthiAHYcJeP48VYmvy4Ji63USRaMV7gpvHnrMaksxONkcJwcPiueM33lKt6+
         c2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rFIzz+YV9rwqDHJ90Swqsb73lFK2nN/fXrEnUPBnKyg=;
        b=ROWNxaTvoCY+LmB0q+CLToFXFVm7CDJ4dprMurmGzS5e3QrilyEgiLOPCtqfxZhF85
         fT1aFQHW4NeKFbZ1I0enQ97yEvf8QkzzNBZ4lhhHqcmJH5Atl6LUk8mBoBdXs+NRUl99
         rMNGPtp5iWj0guG+Oxrcs3Uog6e/0Ovfb/AEGQUCnltMxrnZTRbydvVEiUlnzELfxzXX
         ohHv1NIyJb4EpcgXew+6o9kzwwlJN7u6jfmGzqpqvQPuNwmw19KSARAwiYsQRfleNqlv
         XGjrwKPKcWYhxsMccrelBwUrbzLhXGCXs7WwdViVjTQGEX8usLuxpRYSN4U+3TwnXngg
         tQvg==
X-Gm-Message-State: AOAM532JJwJUwJH0cBIb0kvPyIghb+uwxrE7zqpatNBtrajiIJeeDftO
        cpeiCCUVyoADF13uyLupsLPzz4S9SBXvyA==
X-Google-Smtp-Source: ABdhPJzgm3vQbrxEovXpwGXXRUCRk+5dU+Z7nFiyec2dG15K4kxuGsGM8/PZN0eLlT7TaQgbXscOZA==
X-Received: by 2002:a05:6402:c92:: with SMTP id cm18mr5495223edb.29.1623925392054;
        Thu, 17 Jun 2021 03:23:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:11 -0700 (PDT)
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
Subject: [PATCH 04/27] am: convert applypatch hooks to use config
Date:   Thu, 17 Jun 2021 12:22:38 +0200
Message-Id: <patch-04.27-1d08726930-20210617T101217Z-avarab@gmail.com>
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

Teach pre-applypatch, post-applypatch, and applypatch-msg to use the
hook.h library instead of the run-command.h library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1c8a548903..9e9c1b5e9f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -445,9 +445,12 @@ static void am_destroy(const struct am_state *state)
 static int run_applypatch_msg_hook(struct am_state *state)
 {
 	int ret;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 
 	assert(state->msg);
-	ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
+	strvec_push(&opt.args, am_path(state, "final-commit"));
+	ret = run_hooks("applypatch-msg", &opt);
+	run_hooks_opt_clear(&opt);
 
 	if (!ret) {
 		FREE_AND_NULL(state->msg);
@@ -1607,9 +1610,13 @@ static void do_commit(const struct am_state *state)
 	struct commit_list *parents = NULL;
 	const char *reflog_msg, *author, *committer = NULL;
 	struct strbuf sb = STRBUF_INIT;
+	struct run_hooks_opt hook_opt_pre = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt hook_opt_post = RUN_HOOKS_OPT_INIT;
 
-	if (run_hook_le(NULL, "pre-applypatch", NULL))
+	if (run_hooks("pre-applypatch", &hook_opt_pre)) {
+		run_hooks_opt_clear(&hook_opt_pre);
 		exit(1);
+	}
 
 	if (write_cache_as_tree(&tree, 0, NULL))
 		die(_("git write-tree failed to write a tree"));
@@ -1660,8 +1667,10 @@ static void do_commit(const struct am_state *state)
 		fclose(fp);
 	}
 
-	run_hook_le(NULL, "post-applypatch", NULL);
+	run_hooks("post-applypatch", &hook_opt_post);
 
+	run_hooks_opt_clear(&hook_opt_pre);
+	run_hooks_opt_clear(&hook_opt_post);
 	strbuf_release(&sb);
 }
 
-- 
2.32.0.576.g59759b6ca7d

