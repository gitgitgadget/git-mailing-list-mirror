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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42917C43603
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B44F61078
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhDABuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbhDABuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:50:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC898C061761
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso2034644wmq.1
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dTUCQB3WXCizXGIVy+rJNkDOcat4/a7nb8eHNj32aL4=;
        b=MDw0DO+UxfNC7ypccxote0qn95kGrLcsEEI8f6TixkLyc5kj9PbnovwUNhCnLdLQ0f
         X0RBi3IiJ+K8gNsTOA3vrj9+5SkglbD8RvyVxO9C2b8LyjpJdb2lwx4DtFpChtjSwHms
         buJ8od/NuFG8DHKxHatLxr4MVNGt0QHrRAjKY/3hKCMZpT7GQIPFe49M8GLIWXdB89Dy
         nKlmaxCntDzjJPShgG3OZ8YR+w/3SYux02tKqVSg7qslnM+6BW5MH2jW0gPbaAAmodBi
         5IemE/G2m6elasys23XUxEXNACSaOcUpEQ/2hMWkuPMqUcyR41ppSN+IPTrlWNNhAEvZ
         IT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dTUCQB3WXCizXGIVy+rJNkDOcat4/a7nb8eHNj32aL4=;
        b=OlituhsR8REzS4O1RDnopT3aZ2ES4vvhGm41I4g4kDsmknwNmGmLRjc1PdjCz3A0HM
         f9itenfsNUF7o0V+E2G+F+Kw850aHWyEgA6FB7ez+Xtav5VxemFbkpFG9GkB/IODBJUK
         +ck9Yi9DdWBN/217xdzZGZVC/2zxOWwbBKfK9Gluy/AM8sDcWr9jx6x36WYlcYPsyEpo
         Z0y+B17vYq+vP+Nqpmzx/ccKm0BWoLr6cTsnr1kovtm6JiF3R/Hx/zQRHsWw56qIsHQJ
         3gJG9JV4OoJeNMAcaFgvTmRIpAcAmyO91mCaPvh4xdAFZjNeiWcJ76UKVUpxyWM/eXVP
         YRZQ==
X-Gm-Message-State: AOAM5320pgo4sO7GSL4z+303eACUW7hfKyV5DUeAWkmW0KtVPjgL5hjp
        TBUreoNpoiBoeXqLwHF/juzFHwWk2W0=
X-Google-Smtp-Source: ABdhPJzmcLXvPohfLnRJlR+t0wM7B3QX17IGdyGXer2SwyhzFbGap3RX8TFjZVNnnQ+kwpxiGBitIQ==
X-Received: by 2002:a1c:7415:: with SMTP id p21mr5621013wmc.187.1617241807566;
        Wed, 31 Mar 2021 18:50:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j14sm6902866wrw.69.2021.03.31.18.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:50:07 -0700 (PDT)
Message-Id: <4a5fc2eb5a9fab5276ae502a7fd6e35309d6f17b.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 01:49:42 +0000
Subject: [PATCH v2 05/25] add: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before iterating over all cache entries, ensure that a sparse index is
expanded to a full index to avoid unexpected behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/add.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/add.c b/builtin/add.c
index ea762a41e3a2..afccf2fd5543 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -141,6 +141,8 @@ static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
 {
 	int i, retval = 0;
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 
-- 
gitgitgadget

