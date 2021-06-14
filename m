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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504FDC2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B94C61465
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhFNKkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:40:33 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:39727 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbhFNKhN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:37:13 -0400
Received: by mail-wm1-f41.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso12674284wmh.4
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WR7PwsMwRCfbNoF+4AXiGruf8+rvLuVkrOyBQKA1lGU=;
        b=WK3vSBTN1f127u0sgXVQoSjTx/zrVmEsPidoxv2UgxUW2mX45KsQO5U8lJZKnRB62V
         Kq6lK9yZVc4Ax0eciy2rnDQvH1y4K/TyEqETx7o9Z/dJJrbqp3gmLY4H0bd7rwNPudow
         JPVZbfa5BkclZuW/fzRUGlz9fJ61Glgv1bmCnXr5QT8DEqlpRAKDUkF9kn7xOk5SKdHe
         eJg1IzRLZn0DPwPx7k9cEs/rf3tjR+X0TyrrrZcKtr+cDvSc2+oUr+FBfUPtnhI1iNHT
         2lRTKeIY7y1X6Bgt33xLRl/uCvxpM2I0Osk0ulXzFKLVtc8pnXKe6bxRuGcakAmZ/hSr
         sR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WR7PwsMwRCfbNoF+4AXiGruf8+rvLuVkrOyBQKA1lGU=;
        b=iHXIm2cIOTBx5aTh4kZrWEa5Vpz+qjXt7qX5jbXs8CNyxrn+3g3CAdgTvs76gztfto
         i+GWcXsecStiL0b4aTNXQJres6nWvE5Nj9oXkO09oMl2z8FG8uqQLK0yv2QQ0TEFEfUf
         SgVWRl/5Ji2wnL51Cy+6c9807FyB8FOyX40c0vG9b8NMgARVw/4h1u58Z/ZS3AwxGkfl
         u+60um/lwzqLZTfogXHyGb9iUEC2I+egmit9fPYz4ol7PSPlarJydFfYqaLahGLGqZKd
         ZUNCtlbHe56kjZUCA8h4Mg9ZgH6uuquxn+VdD2Z+8ZzFOPa0LJ6AkkKXvbsvYyYwnYNt
         n1UA==
X-Gm-Message-State: AOAM5302Z1U0UV+gcAraFTzf7al7wEAvZ1eUUqPTnt5obmtC/OjnXbiB
        iu1WOZ9VXtfsaPqZ0BLnwHdvwY43mWsigg==
X-Google-Smtp-Source: ABdhPJw+sSxuRuyUxwgB6UTeEPaDKdWJGw35YmNNU292tQpBT94fqqRXpC/PUElBKnKOzqlf9wbtUw==
X-Received: by 2002:a05:600c:c9:: with SMTP id u9mr15332697wmm.156.1623666836393;
        Mon, 14 Jun 2021 03:33:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:33:56 -0700 (PDT)
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
Subject: [PATCH v2 14/30] receive-pack: convert push-to-checkout hook to hook.h
Date:   Mon, 14 Jun 2021 12:33:03 +0200
Message-Id: <patch-14.30-ec4ad437f86-20210614T101920Z-avarab@gmail.com>
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

By using hook.h instead of run-command.h to invoke push-to-checkout,
hooks can now be specified in the config as well as in the hookdir.
push-to-checkout is not called anywhere but in builtin/receive-pack.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1e0e04c62fc..5248228ebfe 100644
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
2.32.0.rc3.434.gd8aed1f08a7

