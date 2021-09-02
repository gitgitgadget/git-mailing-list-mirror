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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77447C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A083610D0
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345015AbhIBNNI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345038AbhIBNMx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:12:53 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5149BC061757
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:11:55 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id g138so1245294wmg.4
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vqudbvsIDF4vFKwNIJw+taDNmKQyPMXTCSUvyhpQYrU=;
        b=hhNXrM/48OMKRrxWhFjtkI/dVXX0vK4giucjtDwzhN2PBOkWi0TQ7AYUF2GoaZ8QHS
         sYGxrqypnfifrNBwIDmXB7c9U2ukEi6VUe/dYWSd0zN/dqWbRUZtCpNX5yKRnY2HrK/T
         El7zU3W+UeeagyKUVY4KMwJanF1R/Ln58MuaV8x8az5JzZrUamRPO+iRPhntkJtvcbjS
         43SCZ9y2GGLeUHIj/IWugqdDEHHrl4Z6gQBoz0FP5P5ErbgkD8vofuwU3Y+b4UusOG34
         DiDRIiuwH/e/6mWUy1HfjiZImFysDIsV5FqPkQXWW7AsuledVDZYbTYMPtWVo+LwTArb
         t3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vqudbvsIDF4vFKwNIJw+taDNmKQyPMXTCSUvyhpQYrU=;
        b=ZY6fdPTNeWJsqfoEkFqHvoZiodg7eKWXtuu9iZdhvW/CSq7kn4/FjzANXr6/KFfbJ3
         7ij1f7Y3URKbFxOczDMBQxkFNOmnlfgKH3xEtkZ8EYTomedZffvg1njcY0bQL0Fxqh2e
         Kyk8cF2jkv4N3dqRnMeINTDXa5Aw1agPIBRajCNwpjAU2i1uhwxdgrKvM4S35Cjd9kpD
         a+Hr6Uzl/SKMdCSCYcBFuttYyQ7IsODaO8u9f90EsoQrsi91yJ3AAqiiZzOEhmuWTW6J
         1aVkabHEu8OepVFbpO+h12ZulEHrohhSbeb3Ep21JU4UfaCr9IzHJ5AAuRX21hMKiRMe
         yefw==
X-Gm-Message-State: AOAM533r+lXk89kP20lFVkDVLx9gIv5APCuxvKtGHPImuAHDl9uA4Twh
        OiaiVeOpoYMIkRs8pmG4wCh+oPF+4tfzEg==
X-Google-Smtp-Source: ABdhPJxMqgCxodeT1BfUvpxYprZeJDgTNGz2fQfzuBPaMFNlGA7nm3T3dB/XKPQVUbFGZeBlRnY7kQ==
X-Received: by 2002:a05:600c:298:: with SMTP id 24mr3029232wmk.172.1630588313661;
        Thu, 02 Sep 2021 06:11:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:11:53 -0700 (PDT)
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
Subject: [PATCH v5 11/36] am: convert applypatch to use hook.h
Date:   Thu,  2 Sep 2021 15:11:11 +0200
Message-Id: <patch-v5-11.36-ea3af2ccc4d-20210902T125110Z-avarab@gmail.com>
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

Teach pre-applypatch, post-applypatch, and applypatch-msg to use the
hook.h library instead of the run-command.h library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index c603f3cebdf..e444b18b64a 100644
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
2.33.0.816.g1ba32acadee

