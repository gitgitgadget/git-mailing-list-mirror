Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B329CC433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A23E611AE
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhJSXXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhJSXXs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 19:23:48 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B429BC061768
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:33 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id z77-20020a1c7e50000000b0030db7b70b6bso6312142wmc.1
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OvPBil8rpCYTzcmSwx2Nk1O4dHhQOasxzBzDg9hjSx4=;
        b=IO/SMeS+xBzHMJo4gnwu4xAvxjJ46dMn0PsbWIlpk6KqA3Jl59NvZRlcg74T88HP78
         Df+i1qvdBj8vvGQ8we/IL7McMIggILgMwRVbLo1wo244Sevh465iEWUeng7Xl2PFlyhV
         Kd6x3cVHABWQkv7oDy3Rlm6efdiFRVE5TUps/e0j+BFxvHI7k7ue9zJocie+9ZqWph8y
         jpbnGKuJMfCeLzQfhcMUSSGWSAcOIbBgbmm0TeOjCYzN+j2G6jR825Red12azvVt7C6C
         wt5cbqdYOjc9Pt0BCuzU18Xg1c3CUf1PFsi/rlxRHWZLlAe6CdpbucGdwxjBuBy3Aaoh
         XjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OvPBil8rpCYTzcmSwx2Nk1O4dHhQOasxzBzDg9hjSx4=;
        b=1cUAM5VpZQCjqJpzMpRYjrM5ynvYjZjibUekS6MSOIrFVLqu0RI1ljV7Txj1zZq0G/
         sWr96jdQTzx8Rkqe1/wEjKL9hDm+c7VJqIXEAHvPOTybmGKxs3fYfc/lSAxeX6yVIsxp
         Xwr8KL4zSUYD/Gk6R67qVdGjgn2cHTi39XtCWRQGw7TvXa3WTK1N+Yj1fQzVP1XjBaJC
         5rx0TDzaHWPfC4ylXCocHW+yiuxQgECfpmOeDPPoevIYazzzqhSOwirXefZP+OyY7d61
         ql/4V1TeB2+DStW+eO7Y5AozonUUWAR1pOo8qFWSj3Czt/KO713EQG9Sfda7inLQ1c72
         AXMA==
X-Gm-Message-State: AOAM532lIPKM975l3fi7q1ancKcFECpvQqwR0m1uG0Gf5UAe0qa5Puzf
        vDO5nuOfZz72y+J+zKwmdhE0x5RNC7oYdQ==
X-Google-Smtp-Source: ABdhPJyqjaEfOEtGtFYfCq76DeJ3mULSuh03NpNgsEmmNJ3aSyysjT8QB/wqlpTe8KfZma39ngn5bQ==
X-Received: by 2002:a05:600c:4f81:: with SMTP id n1mr9452365wmq.63.1634685692069;
        Tue, 19 Oct 2021 16:21:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g25sm304644wrc.88.2021.10.19.16.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 16:21:31 -0700 (PDT)
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
Subject: [PATCH v3 04/13] am: convert applypatch to use hook.h
Date:   Wed, 20 Oct 2021 01:20:42 +0200
Message-Id: <patch-v3-04.13-b26cef24f39-20211019T231647Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
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
index 8677ea2348a..5528f131a81 100644
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
2.33.1.1338.g20da966911a

