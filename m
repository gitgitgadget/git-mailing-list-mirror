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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69563C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53B6E61444
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhFNKin (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbhFNKgY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:36:24 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542D3C0619FE
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:33:51 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so12472556wmq.5
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AkpgrQ+La2deYDtCTCnPIvK7pnSftp/7hwIbv7uDy/c=;
        b=aVwlWQtEL/ZADyYU+eYz0w50nMmZxEUnCtdcuTSeEoA9nBJqsk/brORHZPjq3Pkosz
         osIsiOzDwVr0TyEsiuWuUoO4a/EXoHWQcDDMkbhCznFfrgV6OZsftTPFj8CjFijmIIxJ
         fjevPITxfsmJhMutRetcyl9c6rkc5tNd4SHRE7bDX84d05PyBbfE6CDGjXzpVyg9BW5v
         HRQBi3Pm7FQIEO5JDTon49rjfBVysCiMbwz7CKjCboO0iIo4tN09i3VuUFt0YKXTp8X1
         hbEANvUOd0fa9s6KAWL2u2biar2PIh6RmDWS6MmtlXjx7bGc4X9J+wOpPmOBOc0mYQVr
         UtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AkpgrQ+La2deYDtCTCnPIvK7pnSftp/7hwIbv7uDy/c=;
        b=KSitWzoR08X/UeYog381GQMVpCbsTn/ETqnDA/uKACkcCFfitMd16xX/LCh09tR/LH
         R3LnrpmBhn6EC6tNDzVvoG9bdjcbzK+i1a8XAVXCsiZFFoamob4uR37Dxm21MG81mfVc
         8m6u5AprYAl4MsNk6iI/zM1RD9qAFxdBt02KtNk9cLTuQlcP2urYrU8HTXloBRw25Hrw
         3KAvHA3gedKdFPz9VnaT7qriaz8rNmGWdMTXZVZaMWGrKFBnh5jnIJ2zjnCbsMkvvbzL
         EjaNebu2OcRQuDkgAc6AT5T2nyTX9TmC4RikvxbGVsmF+xBLLX/1BqnZw082V9GECnOs
         2lKA==
X-Gm-Message-State: AOAM532Gb26rh3cjWFFv2Sy7lGGqafo+Ma8UIfgzG/ZIe+I1qDMrB/mx
        XUznmZjf6WViUlM5TGh6oOPGLVqHCdpmcQ==
X-Google-Smtp-Source: ABdhPJymWCVV7TYXqExqYToDfS1X/io/2q7oA22ctJufcCKpCIHmEPxfLGel0q2oDCxQAZy/doZ7AQ==
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr15743472wmg.22.1623666829719;
        Mon, 14 Jun 2021 03:33:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:33:49 -0700 (PDT)
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
Subject: [PATCH v2 06/30] am: convert applypatch hooks to use config
Date:   Mon, 14 Jun 2021 12:32:55 +0200
Message-Id: <patch-06.30-d2f3b26d464-20210614T101920Z-avarab@gmail.com>
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
2.32.0.rc3.434.gd8aed1f08a7

