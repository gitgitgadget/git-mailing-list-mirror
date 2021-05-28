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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66DAC4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A35E7611C9
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbhE1MO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbhE1MNh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:13:37 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D657C06134A
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:59 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h3so1990185wmq.3
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qerW7OjwcsQDxH4kajgV+Dx56Zalu/ZtqD0N2463G60=;
        b=s2K8gQWdWqfR2ZoSmTCWGFv2enNNRW9c6TIdiLExTDK+qO13OtgJ7CZNsNVFlfptYO
         GZuaadpD1gMooieD/FtXRG/KzMI3O4FT63okNQfKt2D4B+TPbqCfXr2UK9LG+AsGF/oa
         Du0I0AI8lhO+29uNYoC/gkbJk7K3AiKTthFvAu/D8wQ5Bfa+BA6SvD75jhCcbCRvpKi3
         u9L+fKAV4P6xDHeVhjlZ3zfkAZbSXxoMFcepVm5NJcIJw4K3yFzlISylNJC6mQRv6BFb
         bzslM1i7hADP2AvHhtTmUh1eQ22G+rGJmWjaquUxwFHc+v9rq+S7xdzwWNe1cneP4ZQn
         ddvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qerW7OjwcsQDxH4kajgV+Dx56Zalu/ZtqD0N2463G60=;
        b=ExwAhJPrLl1HK1lRQEP/iaZOCP78HdR4ZHjeKPNu1Ln0ND+zP5CAXbHNEaKZL1dtaU
         uRQZecUkoDWhJ+DmqdlCaJrKyD8Z2CKC4O7jU7ZqWvCnJaAMtDepwrpQw7nqontvqNe7
         kIrVAmpgKu+4TsVgauUxBRt+OZnKyjq0FeESVptMQiDdODVpne6O8s6jKn9tBw4UMFYW
         dl5mvzGHx7iVcyWHPclMUb/grL+rr1c1LEVNLyU3uhzxYIUvsrsllnRM3kgsEBYvad0+
         juSu5pE31Ebtl/cH6utp4GSqnoh++flQ05Xj2hv527d/ku5hGz92UPQCnLS3pJutXtXj
         u9Jw==
X-Gm-Message-State: AOAM532K8FV45Mm8g7p1tlwS3piKh0g80gHuFI0vzWzN/g8680rIhuMu
        bXfU5YBnCXm7Q/ELl9vGbRz6wA3ARftg+g==
X-Google-Smtp-Source: ABdhPJxQng2yf/uUwluIU6GinguMRjQ9+fxkYgSV9dwGYwEl8ZgayKtVd0lN7tnC6gdcrqSfNbSkpg==
X-Received: by 2002:a7b:c152:: with SMTP id z18mr8232853wmi.136.1622203917832;
        Fri, 28 May 2021 05:11:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:11:57 -0700 (PDT)
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
Subject: [PATCH 19/31] am: convert 'post-rewrite' hook to hook.h
Date:   Fri, 28 May 2021 14:11:21 +0200
Message-Id: <patch-19.31-986bfd89a54-20210528T110515Z-avarab@gmail.com>
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

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 9e9c1b5e9f2..6e4f9c80360 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -467,23 +467,15 @@ static int run_applypatch_msg_hook(struct am_state *state)
  */
 static int run_post_rewrite_hook(const struct am_state *state)
 {
-	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *hook = find_hook("post-rewrite");
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	int ret;
 
-	if (!hook)
-		return 0;
-
-	strvec_push(&cp.args, hook);
-	strvec_push(&cp.args, "rebase");
-
-	cp.in = xopen(am_path(state, "rewritten"), O_RDONLY);
-	cp.stdout_to_stderr = 1;
-	cp.trace2_hook_name = "post-rewrite";
+	strvec_push(&opt.args, "rebase");
+	opt.path_to_stdin = am_path(state, "rewritten");
 
-	ret = run_command(&cp);
+	ret = run_hooks("post-rewrite", &opt);
 
-	close(cp.in);
+	run_hooks_opt_clear(&opt);
 	return ret;
 }
 
-- 
2.32.0.rc1.458.gd885d4f985c

