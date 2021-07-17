Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AF6C636CB
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 771816115C
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbhGQPo5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 11:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbhGQPow (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 11:44:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AA0C061766
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:41:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v5so15655003wrt.3
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B3nermyozy4HDsTP/jJeyO4D9u7bViI0FyP3u3Sl+ac=;
        b=YuxmoTrRXIbaS39XQ6fv6LNJJuP56/L7+pd+6k/V/q2LwKKkjKWmrnqZrLwK5w4fkk
         pFYWqWkWg3O2PMxzockgqdOIp4yU+pEMdpXMXf6zzzN4BRrIrBkjBMAwo9ypNNW0jHjS
         /f7puYoEyFd7KTRa/TNLMQKqWgy6yPpNnvdWZ2EGY4dpyl+LG2ltzGm8L502ycl2AxEY
         0cxFvsiZGhvaJ7Zv328q3kTonRiPOURC8zw+kd8Ykvrhuia126Dz+yu9wS0RcCFbQj3z
         XBjFS9QQPXR6FAia1bSg9WxYLsdu0wp4gR0EHZfbmVGkMlwUOKO8uILZ+EbofCSBU90h
         tzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B3nermyozy4HDsTP/jJeyO4D9u7bViI0FyP3u3Sl+ac=;
        b=lD9oSJyJy5PDusSayHpYu3xkY1s0++ZSDL4Ce4XKitQ9jGxSkSCDKAboPkPrYeFQro
         1/HF6/vdM7EYM7R3gMhBGehMobsiF1/56VZEKG28HpMzTXupsrUfYqC2FPSjBoekuj9n
         ygj+KiKBbTszJsU9xo+R5PWirYnZlgiE1rMEue44hpuoDRRH2LYFUfbcNoPVBHQgKipR
         CiiDP3MB67AZ68f+TEpOQoDGFZRFSwSsuTxu8p4eJmMd7wEHTViY1EClFC8IFveF9nvA
         cFY9xx45DNXQdK8EHg21RqR2BPBxOr8DDEXv0t/WsNm3uE2qvbkmmVh2IPCHoFsDL/7h
         /NMg==
X-Gm-Message-State: AOAM532fiLVgvZa7e7IlpWqRWxqoWqMXD0pn6BW77jrQUXQU0VUHuAWl
        vXTWfxLe8G084nk3E+4ZQlB6lrxL4HM=
X-Google-Smtp-Source: ABdhPJyTDO9vUIhU+E+jXhm5exIyIb6KvO+U6dRgT60AaqTqN3eVzG0yR21TPw4oQgG9Q+xBSEu+tg==
X-Received: by 2002:a5d:420b:: with SMTP id n11mr19457350wrq.395.1626536513332;
        Sat, 17 Jul 2021 08:41:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m32sm13988502wms.23.2021.07.17.08.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 08:41:53 -0700 (PDT)
Message-Id: <b379fea097d65a28f1791f7f2f9432b6689a977f.1626536508.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Jul 2021 15:41:44 +0000
Subject: [PATCH 6/9] pull: make --rebase and --no-rebase override pull.ff=only
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Fix the last few precedence tests failing in t7601 by now implementing
the logic to have --[no-]rebase override a pull.ff=only config setting.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/pull.c               | 5 ++++-
 t/t7601-merge-pull-config.sh | 4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 5ba376a7487..7e7c90f6a10 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -966,8 +966,11 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
-	if (!opt_ff)
+	if (!opt_ff) {
 		opt_ff = xstrdup_or_null(config_get_ff());
+		if (opt_rebase >= 0 && opt_ff && !strcmp(opt_ff, "--ff-only"))
+			opt_ff = "--ff";
+	}
 
 	if (opt_rebase < 0)
 		opt_rebase = config_get_rebase(&rebase_unspecified);
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 23a1fbc17b3..12787d07289 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -244,11 +244,11 @@ test_expect_success '--ff-only takes precedence over pull.rebase=false' '
 	test_attempts_fast_forward -c pull.rebase=false pull --ff-only
 '
 
-test_expect_failure '--no-rebase overrides pull.ff=only' '
+test_expect_success '--no-rebase overrides pull.ff=only' '
 	test_does_need_full_merge -c pull.ff=only pull --no-rebase
 '
 
-test_expect_failure '--rebase takes precedence over pull.ff=only' '
+test_expect_success '--rebase takes precedence over pull.ff=only' '
 	test_does_rebase -c pull.ff=only pull --rebase
 '
 
-- 
gitgitgadget

