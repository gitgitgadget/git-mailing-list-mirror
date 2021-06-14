Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03346C48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E04CB6140F
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbhFNKkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:40:46 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:35433 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbhFNKhR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:37:17 -0400
Received: by mail-wr1-f53.google.com with SMTP id m18so13982870wrv.2
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJLZb8O9lw3uH9CyeykuLkCsjf6FqX8V3WkuSOlv+sQ=;
        b=pQEx2dWFVLp0VCREwrWNlnobMEKQISpGKpw6esWa23mHTaY8EERt0j0+DuOqJNFl5W
         xZCl8UMlJ7cNljTY8QOuY1quxdjDn7hv2NkMFdB9QiXsQ/UWOxL/SLQBpmI6+J9s1Gu1
         hG/5mLGfzNYHVO4MRiBQGhIHFVj6V/Nm6LKPJvXo6Nz//B2/4lwK2pdwtoxQMEIosqNT
         fjdS163hTkZV3odCtWatjtqdeckJqtrK0VxEvpLfVZNQ0zbOqkJ//HJdXTJiLKnKFXaa
         UpPXfuLrm8PK/DCdRjhr3MqXstKoeYAqbV0hdZ9qE4xsHErPbkepJt9GzHegbSC3GGMs
         VkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJLZb8O9lw3uH9CyeykuLkCsjf6FqX8V3WkuSOlv+sQ=;
        b=oTQl2dHioklctSdDBVBTZybkNRnwHNCcAoDySEO3zCWOcFX+3230EhzeRQXe7jl3MN
         IvBsmfuSvt0uzDeehpGi3VIoUQ9nnzWWNAJ0XvyMVC3n7W2dhvM/zcPJ2e1Mw8QLrzQb
         w0y+RWQN64KmFSfxdjs5blROel1KkUE1OLIhVch6Ja44KIlDuxrMDS56z9i7V/3Sj4go
         EWZhwjawoKo9oTKF+JFjVujUnuG+E24WJuIneO5Hm+RM7eY4WYU9z0oPBebbKpu6od+J
         435/GCXCMC4I1xvhg6/ekw3NDTfp1tLH7MfQnty6HY1kZJX010GwExmue2Lhcf1CH0Ht
         X/4g==
X-Gm-Message-State: AOAM533/X6RckZRDFQeitnwXsQlU/gSbPjsvB21X4K2ENdMiJFfUc1oN
        fTmqCKH1TUGAa7yHiktZokqO0rXBI1roFA==
X-Google-Smtp-Source: ABdhPJyTKeW4w5fcyvHhCa/vgHnFycvd0XoYmWdIHfd0Pto6GNvL4Nxqa24V7OFZLnMeZB8KLiPmHA==
X-Received: by 2002:a5d:6b0e:: with SMTP id v14mr17833543wrw.297.1623666839506;
        Mon, 14 Jun 2021 03:33:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:33:59 -0700 (PDT)
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
Subject: [PATCH v2 18/30] am: convert 'post-rewrite' hook to hook.h
Date:   Mon, 14 Jun 2021 12:33:07 +0200
Message-Id: <patch-18.30-febf05ef232-20210614T101920Z-avarab@gmail.com>
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
2.32.0.rc3.434.gd8aed1f08a7

