Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CA5C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08EFB61076
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbhJLNdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbhJLNdD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:33:03 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0375BC061749
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y12so68335893eda.4
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rftZ8iNXSu0rSO57W0MaTcUuPpmjP12H7zzslixwEVA=;
        b=bHm9h4RqwMkm98FYLD9GmhI3xCxf0+iQEI8MZX+5Fmxgbg0SZuIpTgEDchkSTseKoT
         hUG1qbPJAQUHfEdTBkmlbgYrBoWxh6PwmWHqmfuTu5LBmIm0gOo6t6B8nsfQ8xaoOMSF
         qi3Bn2LIp2ioWuYZiTCFkmNSjaZ7GbF5a0dPGPbNpcYOpR6ew351ZtpZjKy8uRbuy8cC
         EGVar7k/mVTTL9++Uc9Ocgnnafw26lq9X443zmmp6UauWln1tg+hORzMZlNY2AwIdmJr
         3KgkYf4V8teC2EM8yDimTFLUWqxBxKJ731ACvznGyPZ28NTL/9rfNMtyV0DLzBTyHvjj
         M++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rftZ8iNXSu0rSO57W0MaTcUuPpmjP12H7zzslixwEVA=;
        b=x78a5yJQoG5ONFs/IPXPBUoKsKxBmMEdgCCMXpuMoKkzA/NNJbJFry1jL6fTJbBjxR
         H5ibKW0ND4ut/SyGA4ob5JnkAirbeGyreuvcpIGCkQ3W6iZjuG1Vazdr+swZJvzEUmQ5
         xkM7GHUTz4UsIBdKsVwVALM9+cJBn21GwYdTyxmab6ZTNlOdvJK7O4gTvg4L42Oz6pLr
         0b+CVixe2x9Lc8k1+UEMrrwdLq6rSPBmgpcVy+A60O4jxGrtf/SX2TqK433RLuDDcdMB
         O3XK9HS1kmfL6sO2fKyW5TTlzeqvGzc3z/Motc+cORBIV7PBHNYNnuXLFIX6ndQr+ieI
         Pf+w==
X-Gm-Message-State: AOAM5316o0RTjwpmUpdJCXtd/iym2YePmQgQtltaRsVzMKoVyS5X6hh+
        K6iKT2r7oLwSmz+AstByu/RmO3PkBjXlGg==
X-Google-Smtp-Source: ABdhPJyDY1pZE2E86AwzuiQ6rdSc9FRYk3+QH7tnFqYLAOOziHDHSYT5pM3KnlqsyCC4InRRsVzyNQ==
X-Received: by 2002:a50:be82:: with SMTP id b2mr49856735edk.56.1634045459703;
        Tue, 12 Oct 2021 06:30:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bi23sm2016405ejb.122.2021.10.12.06.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:30:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/13] am: convert applypatch to use hook.h
Date:   Tue, 12 Oct 2021 15:30:29 +0200
Message-Id: <patch-04.13-b1d529ca485-20211012T131934Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
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
 builtin/am.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 3527945a467..2cfe6451b6f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -446,9 +446,11 @@ static void am_destroy(const struct am_state *state)
 static int run_applypatch_msg_hook(struct am_state *state)
 {
 	int ret;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 
 	assert(state->msg);
-	ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
+	strvec_push(&opt.args, am_path(state, "final-commit"));
+	ret = run_hooks_oneshot("applypatch-msg", &opt);
 
 	if (!ret) {
 		FREE_AND_NULL(state->msg);
@@ -1609,7 +1611,7 @@ static void do_commit(const struct am_state *state)
 	const char *reflog_msg, *author, *committer = NULL;
 	struct strbuf sb = STRBUF_INIT;
 
-	if (run_hook_le(NULL, "pre-applypatch", NULL))
+	if (run_hooks_oneshot("pre-applypatch", NULL))
 		exit(1);
 
 	if (write_cache_as_tree(&tree, 0, NULL))
@@ -1661,7 +1663,7 @@ static void do_commit(const struct am_state *state)
 		fclose(fp);
 	}
 
-	run_hook_le(NULL, "post-applypatch", NULL);
+	run_hooks_oneshot("post-applypatch", NULL);
 
 	strbuf_release(&sb);
 }
-- 
2.33.0.1567.g7b23ce7ed9e

