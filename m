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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46F0C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF68861037
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240253AbhHCTkG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240199AbhHCTj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:56 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DA2C0617BE
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b13so15628296wrs.3
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M1F5FeHgKcOYOv+fSyUIj7dfbmV5mI1nL97uF2SfCIs=;
        b=hMmaEyTEHGVJIjkCNxhY5DmjZtO/pEusU5xbYD+/M7Wrlkaj2U3Gfp3TR9HZChB/fC
         N58JCRahxgJ3PqUW6HNTiib2LhttOnPlFC+p+l66CDXWZJTrvqAD9+rABFnU4qA+2e8a
         eRkvrbV9JaiFcme43yoHowz4FU/FIs4xWE5txzYNBWG0m3rzssl5MGoqZt7d+Nb6cjXe
         ow0Lc13ZYsfEHMMj2cMKbnA/I1J2pbKys95Wv/BqYzs0ZDi6dHtjJQpIojnNXq1VB+0x
         6m+3CzIFmd+ghGFnESqDBdw4h201AEEH6RxT0Ngahh0VGFYzWNRX9TzphCTig5KklHEF
         Xgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M1F5FeHgKcOYOv+fSyUIj7dfbmV5mI1nL97uF2SfCIs=;
        b=rI1vUbALs1l+P9X1PWU7Gir3/jDW5GYyGR9xoAjHio/dQ5rAh/IVCELVZHqDEFNNcn
         EGIor4uSvsA9icNYtMHcxLwntMYLKyPzyZMAiiuAZqonH64bOiYb9NFotr5WmNdqyQjy
         lbaeYdSB9GT4K5ySq1fy56BHph1tEIcyx07j4VKQL39o6VVump6vzmRpQ6j7YPVrMavo
         Oijvlq5gNnjZ9+hDrnod88MRjmc/ZRj6kNvbTvZAq8ne+4M2h2v1nd4rqmWSdy370LFD
         bE+CYEdDQ8q8F5fBVDXlcwwgyUBx+Xy6zEB2RUHs61nssHt8GV495DMzfoH+CoRxIq+/
         E1iA==
X-Gm-Message-State: AOAM532TqR4KdoMdf4Nar8DLFXWQX9vhRD8tuVldWuOa/6t0bGjjtqNV
        XgD3KHVvW98jk4T3pcBbClWvrSFv0KvL5Q==
X-Google-Smtp-Source: ABdhPJxDhXKbERfzVhw9x6SDf8z4Pkw3GwRiRsL3Z71srJZLboos3Wq2UpoPKjByRpbweh/b1td5HQ==
X-Received: by 2002:a5d:49c1:: with SMTP id t1mr22261791wrs.141.1628019573034;
        Tue, 03 Aug 2021 12:39:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:32 -0700 (PDT)
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
Subject: [PATCH v4 23/36] am: convert 'post-rewrite' hook to hook.h
Date:   Tue,  3 Aug 2021 21:38:49 +0200
Message-Id: <patch-v4-23.36-7d1925cca48-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
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
2.33.0.rc0.595.ge31e012651d

