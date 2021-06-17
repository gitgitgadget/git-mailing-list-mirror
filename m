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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA060C48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD4261057
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhFQKZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbhFQKZi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:38 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00EAC0613A4
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:20 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id nd37so9013016ejc.3
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Wvheu7R7cHGNLPnvKAA3iJwQQQ144pCjkwvtfW4N7Y=;
        b=JD75JJUjIWibMxWC2mB7diwdvWCMRdpII130KScs3ffkkOVKj098Kcw5qjG6wK1DvF
         3Ggm30jz2H9tAnlGMaQJi1O38dlvanNfBE4RTq/Bj2C21JtwE9wpiouraGqhAJCU0zzK
         FHqNE5O5cJIaeORvE1nRhPfg9aIGZFZGJhHqr8GexPqK3bEcZanj/IRng6FcF62wc8Qx
         Vc1TiBw7EX0oMmNi5mMUafZUuI6bF6s81xsu1Xtn/gVovsXKGSkEpAS3ZPEl9z0mfJSg
         8rD4iBWgjef+McOqJ/+xoCIf3dXl07DPR+UU3hC7nALdXgPCgTKPVUYl0sdVtx+CRSKT
         1XfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Wvheu7R7cHGNLPnvKAA3iJwQQQ144pCjkwvtfW4N7Y=;
        b=bmQqOnKoX1TPYUhZo9pnrdZ9iLkEkO+FTfODOI6Ax9U/tDdngyvhiqGAGEDDH7VPu5
         DtyuHCypNxxqBLSQ71eR0hzcPIsCLflnX3wveVPIcsPFyHe3suBc3m4cu74KdBVmbnz5
         S/SuW/lcGdiRy53AKqSwktSI0A/aKc9HTN0ZO1KjNWjWLq0+G5CxWu7NCYcM3r1eGJjl
         DeDMKox8r71vGuZuzRZTNqy5+ZyiXdiWPDi3oyNo9eKrUESL69ouUxGvXYL/wZ/lB+hj
         sR/paW5rsURwJ/JubBOQ/nE5RYEIha3TlrFq56tGm3RJFoA0ldmhf6S1f8tAX0zNGGh/
         7hwQ==
X-Gm-Message-State: AOAM533lY0fU1jDXr+V4FcLhtM06eYKPB3mOxcwEIOppbicznZomDm1g
        o3/efQcO+qeJu2wz3roxRbYGAOHrr7PcOQ==
X-Google-Smtp-Source: ABdhPJztzgdqGzl4jomSCPLkYDeZy/ATnIUNfipXFBtAN8OuROeAmfwpvQkK1EkfDuTD5ldNC/EQHQ==
X-Received: by 2002:a17:906:b141:: with SMTP id bt1mr4476786ejb.498.1623925398942;
        Thu, 17 Jun 2021 03:23:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:18 -0700 (PDT)
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
Subject: [PATCH 12/27] receive-pack: convert push-to-checkout hook to hook.h
Date:   Thu, 17 Jun 2021 12:22:46 +0200
Message-Id: <patch-12.27-e4ef3f4548-20210617T101217Z-avarab@gmail.com>
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

By using hook.h instead of run-command.h to invoke push-to-checkout,
hooks can now be specified in the config as well as in the hookdir.
push-to-checkout is not called anywhere but in builtin/receive-pack.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1e0e04c62f..5248228ebf 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1436,12 +1436,18 @@ static const char *push_to_checkout(unsigned char *hash,
 				    struct strvec *env,
 				    const char *work_tree)
 {
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+
 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
-	if (run_hook_le(env->v, push_to_checkout_hook,
-			hash_to_hex(hash), NULL))
+	strvec_pushv(&opt.env, env->v);
+	strvec_push(&opt.args, hash_to_hex(hash));
+	if (run_hooks(push_to_checkout_hook, &opt)) {
+		run_hooks_opt_clear(&opt);
 		return "push-to-checkout hook declined";
-	else
+	} else {
+		run_hooks_opt_clear(&opt);
 		return NULL;
+	}
 }
 
 static const char *update_worktree(unsigned char *sha1, const struct worktree *worktree)
@@ -1465,7 +1471,7 @@ static const char *update_worktree(unsigned char *sha1, const struct worktree *w
 
 	strvec_pushf(&env, "GIT_DIR=%s", absolute_path(git_dir));
 
-	if (!find_hook(push_to_checkout_hook))
+	if (!hook_exists(push_to_checkout_hook))
 		retval = push_to_deploy(sha1, &env, work_tree);
 	else
 		retval = push_to_checkout(sha1, &env, work_tree);
-- 
2.32.0.576.g59759b6ca7d

