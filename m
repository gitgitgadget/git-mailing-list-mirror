Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA59C4708D
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51A7C601FD
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbhE1MNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbhE1MNY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:13:24 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A039C06174A
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:49 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id h3so1989927wmq.3
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W/yKjUWk//XPaqhS8tyea275td1NnG52b4khH87gT0I=;
        b=ANN1NXpw9aupDbAHLJ/vApdZmaRDsQMnziHHTpUtkU3MrJ0HHscKR8coSzNIAh8Q/H
         SODR7S2jqskk7txnXpthbcpQW/GYUjh9wB2QrjoKkxck4kWQfAtakC0z0AYbLkKJdGcI
         5Seqboo+wBfEIGhpBn9xfdmeBah0kJZKtfWbIbfGHbYxGdNAfWitpadlXMN9QQaGKA6z
         qZ5q3awTP1IF7NKrty4naJBDcHwQoIJ/8s1AYvwYnBSY7VVITcWgSS2ixb25z1ai5W0N
         sMhqw9VD33ibmgnlhzZBKH/ZeORto3wpiH/x7KlCEG5J+D/c/WuwwvmGURxMsLEHSg8r
         2qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W/yKjUWk//XPaqhS8tyea275td1NnG52b4khH87gT0I=;
        b=iJbhBBxP5qEekN851NCJgrWAFefmoWvoB75jxyjEN4nWv9RGZ/T61XQYK4fHVu1Ckz
         Zo+LCO9LdvbQrDA7ZhEID1uSpGxwwtpltMtoQts8PF8b34+SYIR9RZQoqypm+1aXpqb6
         5ODbtEV33NBAo6EORr2X278E7t1yqPq+VQcQ5Skex4BjBLzvsTkOs7c/m5ZfB7yhLoEZ
         ChjGaGh7Onj8xgDI2qyBDiwqB6ngxx7deuV6gXGJGBeq91NquSplgtrcOv17uMZpHvVP
         SEEYxnaiTqksJu2ynafZusxl6pB+PKI1t6RvShXgb/IRke2UtPxINI5VdvVpJks6cERp
         EQyg==
X-Gm-Message-State: AOAM530EY0PpovKbWnI2x6qnxNNcT160y4Pgwu5NaWpU/d/Lb4osMJoF
        VScsxjs2jxA12+Bv7BxJXYyTHiyPP3rn2w==
X-Google-Smtp-Source: ABdhPJwmjGMayhEjde+/rhHwk2cu/+eJs0P5kZH+JpdbfhE2yrgIn+J9YR1lWgHj4VjLyK8D5voajg==
X-Received: by 2002:a05:600c:3043:: with SMTP id n3mr8257094wmh.98.1622203907831;
        Fri, 28 May 2021 05:11:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:11:47 -0700 (PDT)
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
Subject: [PATCH 08/31] am: convert applypatch hooks to use config
Date:   Fri, 28 May 2021 14:11:10 +0200
Message-Id: <patch-08.31-69842c74383-20210528T110515Z-avarab@gmail.com>
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

Teach pre-applypatch, post-applypatch, and applypatch-msg to use the
hook.h library instead of the run-command.h library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1c8a5489035..9e9c1b5e9f2 100644
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
2.32.0.rc1.458.gd885d4f985c

