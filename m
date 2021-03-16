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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678C8C4332D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 338C264FAE
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhCPVSE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbhCPVR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06297C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id p19so315058wmq.1
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CVINyJ9pTo7o7JiYpdL2MVHsor9qjFpOoMICoKE7ACo=;
        b=PE+8QztU7n2RioKfuLEfGpx62UoHCzCbf+g61pGFDn1+jJcAChuJsZfdwTlmmZ9c7J
         FNYPClVVo7rTryGQQY1vMZe18Wt48DhkkTKve1uVXqgCGSOFjrr/+kd+xbQWx/46pdxZ
         u9jnmk7P2BEa7JAfwPkmHMGAf3a+qo1pxXewNLnh+5EhlfgByXKDVjV5iG0MRZBEZTer
         tZbwgYSutmmVhAPIDQCFKcVeLO++0zVv/TOfzPAfxBN0EhcZwHTkq51oiS8bgLUjKwC2
         xygU8SdoDm5CaTitEVscTXBwG55gmRwE+lnynDh8YBDs+miPvXCvFAzJVGAXUQp+Jvj4
         0fFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CVINyJ9pTo7o7JiYpdL2MVHsor9qjFpOoMICoKE7ACo=;
        b=Wqh4s+r5tAoIuW7BzPP9sBZ8VoRZ8e6TJOnUOZ45Asg+DzaqZLlqBMqGrMSiot5+Hv
         PNOTRLNzLv+RjGPonmlmcm+/wm2A79cTakhTHIssHHTu70Gvvglt0RR+r+5XroKX6qGX
         VJqBE9wZwe2UarBKwv1IAcm0Iet94icEuaOVESj/vVr8daqdRptAnAvLi+3N5M7ZPdKc
         kC4+HIVqxSA1d7mHoTv+e6hbtyD2Q0/ANtIx4t4ZyvmVomLZQRe2a9X/lI6OVlR6fSmn
         SwmL0pKqh9Cl93fMEUoTEnxQoG7ig0bIkttQYnjX9hY1k8LGXudB0hI1a+bFrUDF5kRa
         livA==
X-Gm-Message-State: AOAM531z4WGk9oMrtYoT3FEXssZj04FhZ4Q/SB5wIhF0rFCThd8+3qUn
        rn9EiKq6A9QVVN+kB9EEhapmXh6TjpI=
X-Google-Smtp-Source: ABdhPJwtzi8Cr8mwPjrz6mMkzj73gg7+YvFe/jjEPj+zsjEiPQKz2wfXIZXKVMH1jCk2Ae8zr9s01Q==
X-Received: by 2002:a05:600c:4305:: with SMTP id p5mr675820wme.58.1615929446710;
        Tue, 16 Mar 2021 14:17:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d204sm518027wmc.17.2021.03.16.14.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:26 -0700 (PDT)
Message-Id: <d6816560b32f020d6c38f5e9ad36be532685279c.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:17:02 +0000
Subject: [PATCH 14/27] rm: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
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
 builtin/rm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/rm.c b/builtin/rm.c
index 4858631e0f02..99125ccb8424 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -293,6 +293,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	seen = xcalloc(pathspec.nr, 1);
 
+	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 		if (!ce_path_match(&the_index, ce, &pathspec, seen))
-- 
gitgitgadget

