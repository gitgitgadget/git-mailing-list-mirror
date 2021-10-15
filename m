Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1316C433FE
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B43246108B
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbhJOJqA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 05:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbhJOJp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 05:45:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAF0C061760
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g25so25350204wrb.2
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OvPBil8rpCYTzcmSwx2Nk1O4dHhQOasxzBzDg9hjSx4=;
        b=cF3Z+6mil0Q/6Ks7KuMY5lUjImxDdFOrFufsAlxdvhOTowlIfv/d1O/7aHuMSosRu9
         EuuVj7xSKHqen95wV8H9R8qewuFopGvej9NHfTkI4mUNHhAbya3FicqXSZ2m5VLHmZkA
         n6A/czjiU7JMiJb263NtZ9JINYeW65/JPlMYdgPHEqKHbdlksbHpCWkD2ozpHiTRS7LP
         Cfdzggmu2sL8KxmmAi0DV9Lw5iGttxoegn+cRgeiGDnlfs9esXg1huNKLUbqZfDrOWKG
         Y2qvScLVXHDZ7FdlMp6adWG8M773KW2hrrc2bu8/h3goILY1QBsjzvyuLvQMXRr/34HU
         ZhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OvPBil8rpCYTzcmSwx2Nk1O4dHhQOasxzBzDg9hjSx4=;
        b=e4WurMOX2+QeVhZ/L22VQq3tvbt8impAPQK+GV5i4B72syb8BSCWmu8RN8P5HtsBk/
         IIwE6JtJEWxoO+QLnLXHJh/wFARjIsiExttfg0p8zV6Kmuv78r/R6axf0YSFYPA238kl
         ONqDAxLZIggW+1G/6lazgS9M8ehkdvFMZdFVl4KdXeeKALpyNAWnCWa40yjmmL6FMStI
         w2Dti76I6DHoEmHAmD1MB2uPJPRfWfsPxWl7Klew3/6DRbegX/IZU0XShX8TRVAEtQkh
         LWhTPPy/XdVH0bCzfQyjS+Hbh1AWkbRTu8JNsxzYfpZlxTVpns0ikMiGrWY3YrxarepM
         UPdw==
X-Gm-Message-State: AOAM532VhdskVdc2/Xf7QV8VmvX4ZZaufHtpwEVs7hVcnH9zDQVWjSFC
        YuWKw06zXNIfl+f0QLj3rit5yIS1FV/3pQ==
X-Google-Smtp-Source: ABdhPJxZsxg5QTzkhTZa+TkkfFdpgn9LkgZ+8QBmpx3slCIRTyFzaHsygPo8D58RSK0yf1R1hl+WNA==
X-Received: by 2002:adf:979a:: with SMTP id s26mr13108278wrb.2.1634291029026;
        Fri, 15 Oct 2021 02:43:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r4sm5963648wrz.58.2021.10.15.02.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 02:43:48 -0700 (PDT)
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
Subject: [PATCH v2 04/13] am: convert applypatch to use hook.h
Date:   Fri, 15 Oct 2021 11:43:32 +0200
Message-Id: <patch-v2-04.13-0e34eb54054-20211015T093918Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
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

