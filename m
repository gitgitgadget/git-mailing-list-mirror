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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512CCC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AD57610E5
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345006AbhIBNNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345140AbhIBNNh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:13:37 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81E6C061292
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:12:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m9so2881665wrb.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WbBEgRoVviqwmYntD7MhzCT8yKMCfzYqqmViRdFsBWk=;
        b=bUWlhnEuVYMtFxcBC1HRyxr04LKUtH7pGDA19XOq9cQ25idKZgQkgfJ/Hyv3bc1+cI
         3iiM/UFaYZgKjKmg1tq7QsEc0yipxuSymFWdD91aMJEDa1Hr34mxkCXVmfZ3B9v9D8qY
         OKSsAfNT+EvYI61dvKnGKfLXkYyZDtu9EhZ9H/ethvfJjqlOcJGNvJEMSJZlsDDuvK0o
         HqxB+iONdACaMeqQTvsPg9cEUngXeO/+HU8vrV8H3EA+3AB07Z4sVFlY2o3dC+0ZNbiQ
         STK1WezKwp5J5KbCEdRWOiG2GzFYF6r/pSKzNZvIixkW68+5+DIvZeeETDrOn3VFd/aT
         /N6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WbBEgRoVviqwmYntD7MhzCT8yKMCfzYqqmViRdFsBWk=;
        b=EgXhAUMhAo2cdRHV5eH8P7o3CKDboqryo5F6CGbB9I2ePWh1Zs29WLY2y8La57Ne/e
         f0nABxFZpe2qFzX2y+HJGvKf/RB4arJtvdWQbPUJZgLzn4TC60HBNnNbsgnfJb29BUHQ
         yWnEWYLdZhQzLgaujux7XF7I9wHouGIXlfuNolzjLbTl4MgOIejRqncL0C9kGhkMe+bz
         itRojCu8gC3v3tfwBEwVRYwJWe7EJHkfmk4rGBJeABran0QrtWXP4JQb+5aDy8DWBTyk
         l536pxRThT4ZZphsI5Rlkn4GJgzO1+BWOf9gI3fPYZ/aHRfIgNSJfby8TOcooVet6JQj
         GRAA==
X-Gm-Message-State: AOAM533pcib5/CY97RM+HwAh4ofvzfUVUTl6HrkK3p2B0EaciBGIgTfR
        /AuvVv/fHNhUIQC0kFk2JkIHBKcAT44qsA==
X-Google-Smtp-Source: ABdhPJzMeGgTvQU7mwdXCQSJEArhaLxhG0LM+lb7sdE55tb0pECM5HSwIwLiEW/MraesZS19aWku1g==
X-Received: by 2002:adf:c184:: with SMTP id x4mr3780159wre.266.1630588327480;
        Thu, 02 Sep 2021 06:12:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:12:06 -0700 (PDT)
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
Subject: [PATCH v5 23/36] am: convert 'post-rewrite' hook to hook.h
Date:   Thu,  2 Sep 2021 15:11:23 +0200
Message-Id: <patch-v5-23.36-f548e3d15e7-20210902T125110Z-avarab@gmail.com>
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

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index e444b18b64a..9e3d4d9ab44 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -467,24 +467,12 @@ static int run_applypatch_msg_hook(struct am_state *state)
  */
 static int run_post_rewrite_hook(const struct am_state *state)
 {
-	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *hook = find_hook("post-rewrite");
-	int ret;
-
-	if (!hook)
-		return 0;
-
-	strvec_push(&cp.args, hook);
-	strvec_push(&cp.args, "rebase");
-
-	cp.in = xopen(am_path(state, "rewritten"), O_RDONLY);
-	cp.stdout_to_stderr = 1;
-	cp.trace2_hook_name = "post-rewrite";
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 
-	ret = run_command(&cp);
+	strvec_push(&opt.args, "rebase");
+	opt.path_to_stdin = am_path(state, "rewritten");
 
-	close(cp.in);
-	return ret;
+	return run_hooks_oneshot("post-rewrite", &opt);
 }
 
 /**
-- 
2.33.0.816.g1ba32acadee

