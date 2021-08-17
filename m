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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B86CC4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8006560F35
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237615AbhHQNYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 09:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240037AbhHQNYM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 09:24:12 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13B5C0612A7
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:23:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u15so13714855wmj.1
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xF4Ml5ovwsHr66snlzRz3TrGLFSkIqW9omB3/KckS/A=;
        b=jYs+B8Xe1Jxbqdg3XrUT5zU/FPyyCtYH1lZzQgFmsgpf2as34Hta6UrbwrqvigoQoM
         iWWte59tAxBIQIpbEBJx2BQoOak/QYU7VY1j4d3l+NTrjS6QXczwZT1Itxs6Kp3i+Wlm
         ggMlWovPwNZZIh4JGZRfFEZStvnPeql6FnDkPE758qwGfXPDn7YFAJTtq/ePyarmP5Mt
         4IhvPyAm+WUDaAlQqqrRErwFA4mHl9F+S+yc29+vXrlbH2IcaUC3yC3sGHqA+fK5gZTo
         nHnZnIiLjdCZj9C2tLFUUWlE6ASS4JsDXe0ov7umXdeID/RZhOeKth1P3Tj9MwqN/sxm
         F/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xF4Ml5ovwsHr66snlzRz3TrGLFSkIqW9omB3/KckS/A=;
        b=ghYYj4y6UgOGHFIRjXqbCxFbj7EqGWWxd+Z0il+Ubexr7+MUSndJ7zhDuxEfGsB8gg
         J7KOGsKVOSDQfzqCKhgm/eFFaJFmrZJSgdMEQ3zXrSC4bnPMNaoAqHvgbxUoX/pjObHT
         TOWbS6RMEIhoR/g1CZMpYbHlTOGV/SE/KVcM+BKmMabmn7bR2omr4uZIJR0UjyUU88jU
         4kvK3/Gt5W5Ym6svtYVl1MNzfMryT9B7z7XY1frmE0+zJgKNb3SqqMXQWcTwwigBB5Yq
         H9zS/kzugJO4l8noPAGgcSd+7gHLSoE94Hz/Icr3TwA+2KIObCgydELVaK8zY90jZKwY
         ohGw==
X-Gm-Message-State: AOAM530hf4YxZevG922qiFGwlbcbIt2d1RVhrFowCn3j5Qs3ve1jUY+L
        tLbZeS9p4Sf7aTyW4557r3tdz/G8Kpg=
X-Google-Smtp-Source: ABdhPJyapc0PAj/l6eHgdWbwKypms3GfUJYO0mA9onwFJ8F1Jzio3s1/LeQg9/5Z9sXfToX54Q1DxQ==
X-Received: by 2002:a1c:ed10:: with SMTP id l16mr3293424wmh.8.1629206606649;
        Tue, 17 Aug 2021 06:23:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k17sm2454998wmj.0.2021.08.17.06.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 06:23:26 -0700 (PDT)
Message-Id: <fb3ff9108bf832d258155d3c6ee95c8546f21ba5.1629206603.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
        <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 13:23:16 +0000
Subject: [PATCH v3 2/8] sparse-index: silently return when not using cone-mode
 patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

While the sparse-index is only enabled when core.sparseCheckoutCone is
also enabled, it is possible for the user to modify the sparse-checkout
file manually in a way that does not match cone-mode patterns. In this
case, we should refuse to convert an index into a sparse index, since
the sparse_checkout_patterns will not be initialized with recursive and
parent path hashsets.

Also silently return if there are no cache entries, which is a simple
case: there are no paths to make sparse!

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index c6b4feec413..bc5900eae35 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -130,7 +130,8 @@ static int index_has_unmerged_entries(struct index_state *istate)
 int convert_to_sparse(struct index_state *istate)
 {
 	int test_env;
-	if (istate->split_index || istate->sparse_index ||
+
+	if (istate->split_index || istate->sparse_index || !istate->cache_nr ||
 	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
 
@@ -158,10 +159,16 @@ int convert_to_sparse(struct index_state *istate)
 			return 0;
 	}
 
-	if (!istate->sparse_checkout_patterns->use_cone_patterns) {
-		warning(_("attempting to use sparse-index without cone mode"));
-		return -1;
-	}
+	/*
+	 * We need cone-mode patterns to use sparse-index. If a user edits
+	 * their sparse-checkout file manually, then we can detect during
+	 * parsing that they are not actually using cone-mode patterns and
+	 * hence we need to abort this conversion _without error_. Warnings
+	 * already exist in the pattern parsing to inform the user of their
+	 * bad patterns.
+	 */
+	if (!istate->sparse_checkout_patterns->use_cone_patterns)
+		return 0;
 
 	/*
 	 * NEEDSWORK: If we have unmerged entries, then stay full.
-- 
gitgitgadget

