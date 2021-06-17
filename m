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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC57C49361
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0754861057
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbhFQK0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbhFQKZk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:40 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9A7C06121D
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id my49so8940498ejc.7
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lofb6OkhsrELY81zghL1eWlAZIqumh/y2CEHnNKEPr8=;
        b=aTICkkyWfG+T0zcB0ULZLkAAlSIMXcaSq70vlbCPjorqmvSY+mZJ1VQTkdrjJUvmd5
         SGdSGGIh7LRp5TwTeTjqZcMtaDQxJqCrzqlYgxh/0SRs2gUkesbM+Kn5Gw6AAG8HSsBA
         lA0xctsj9+efXoxnIwPZBXN6kEP2AxXpxY1YNzuEZ3AseSTbBJiSrzqFnucrGDqa0HMr
         YcGnjiYDjnCWF2kTnvBjhNxL8IBu2UoyE0bJ2g6msBev8UGLnIRe0L1OQI7nj/zsrxoh
         AM+kG+KaLEZjVMkGlEPi8Pa5g1j0m4QV2/YC7FBsGgB0TF4TVYFGXVDpfQUjNPhnS//c
         ifIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lofb6OkhsrELY81zghL1eWlAZIqumh/y2CEHnNKEPr8=;
        b=lzDJ3RHBMQzmN0yfz1YlPu5LaDszIVhX728LA8hlMKos38L6SdDZRaqCOdhbJ5BSif
         1954lWMUfw1ldksGkUvXwMLUkMlgqR/6Sxg4CDSd81H1hQm0gT0QBFxoHKqpn8dfXGFA
         SYyuvhIsno2wOd4E7rz3Z17+R9kqLpV2dbsCRYLw4TbySWeKN70f5EpaPdT8ee9bjQW0
         /o7JdE/nAUtorfRMfjNs8aTCXN3egNZ2qYM5o6rDg0iRI+YSjBEJ6ZFiQf7dHQ4g/HA0
         M8axis5mj/aRcRqqimEBCf2UoQVugvilEit4zs/vCvDV0he5CP26EBe9QeTwbFYPzscI
         iBCg==
X-Gm-Message-State: AOAM5319Ix5aiQlblCc7VULZKpIKc7DkszX58mMdNwKDO0iTjEHM5YiP
        uQBwHbZYnU5gDJysNQb9K81xvNYsEQqYeg==
X-Google-Smtp-Source: ABdhPJz4oe/yF4R22Uc6JaftEoV/XIm2EorP8Eu/HXFIUdwBo1yHW6wWVYY78+AibXw6VFq45kv+qA==
X-Received: by 2002:a17:906:2bd0:: with SMTP id n16mr4495627ejg.110.1623925402299;
        Thu, 17 Jun 2021 03:23:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:21 -0700 (PDT)
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
Subject: [PATCH 16/27] am: convert 'post-rewrite' hook to hook.h
Date:   Thu, 17 Jun 2021 12:22:50 +0200
Message-Id: <patch-16.27-4035069a98-20210617T101217Z-avarab@gmail.com>
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

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 9e9c1b5e9f..6e4f9c8036 100644
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
2.32.0.576.g59759b6ca7d

