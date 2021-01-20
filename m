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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8185C433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 788BA23358
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbhATQzb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403947AbhATQyq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 11:54:46 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABF2C0613D3
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:54:05 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id y187so3442732wmd.3
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZV0JWSbubCzVhkJnD425A62mw4d+BJkeIo6hw/50c5A=;
        b=O52Nc/EIkPMykFCd587M7tRBn4T79aoOqEouo90H5JoRxnUAOB78TTl+1eWLxeSmIy
         pkFxU+xXQgl2F0lrVgtlhv/7hZnP1n5hAJ6a1G2M7xBOySc3vKlv6+0EpR7h71BFFV4e
         0QNARSf7d05ScfhG+tA2cfRStYpvZFAFfDUfSNsmJv6JMlUlSzdoO6UcPwlhv2Iy/VkF
         nn2XL1zTBRAeh79Q8pRzx+ch79mfBGaZJPS7CoI4X79PDExUtjBg05gr7uh9wdQSmkBC
         RyYeT0fluLIBYNi1eDrPjdUSHIbttX3A1+Ey62jR+ixnWN8STRs0DWBKcmLNXlBv6bXw
         c1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZV0JWSbubCzVhkJnD425A62mw4d+BJkeIo6hw/50c5A=;
        b=Rab8IXqiDtiY86Ta96Kj37m6PmFckwAXO6Fm2JiETU+fIhCSqX2z6QvvMvTvIwCdWf
         Clc/UxPCH0lKL9g7IkqoJAyXUcm1dKouJ/2tZnjGtRpYhKKYFevllqeJ0E4scLyogN69
         dLQT/29H40sX0A8BjX8FHeBXbwUIBlqAVQAuvA7s4vWIQzGEXz6c6RM7yCRGbp4Ie1Rz
         edIckHla0ggz5x1lSpjPT8S7Od0CWTKBf+RvUriwx38k4WYi+tzXbvMFItjAXSLSBBtd
         Fur3+fUqNqkM0jNfyeOgkjg/Jx9Nq/0biqxuWdO4W8UFU9STrCpiAjx0WRQHO7hdWq5t
         dDqA==
X-Gm-Message-State: AOAM531YvTMI9Y1UOJOtMtWUMoO/I8KD0geo25hBqYtYonV24/+WRBIp
        CkQ91x1gBKfOEdgRQLL1h0s8OiFzwdo=
X-Google-Smtp-Source: ABdhPJw0WvgE7uizpka5T/PtQtmHt2r+hC2Lh6DJCizpH8ZTvMABWaJz7aT8TKdXHDRWWRE57b4PFw==
X-Received: by 2002:a1c:e1d4:: with SMTP id y203mr3863893wmg.50.1611161644523;
        Wed, 20 Jan 2021 08:54:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7sm4495421wmb.47.2021.01.20.08.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:54:04 -0800 (PST)
Message-Id: <d4ff0468fc0e22fe3ef82f74603ac781fd7711e1.1611161639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.git.1611161639.gitgitgadget@gmail.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jan 2021 16:53:54 +0000
Subject: [PATCH 4/9] repository: add repo reference to index_state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

It will be helpful to add behavior to index opertations that might
trigger an object lookup. Since each index belongs to a specific
repository, add a 'repo' pointer to struct index_state that allows
access to this repository.

This will prevent future changes from needing to pass an additional
'struct repository *repo' parameter and instead rely only on the 'struct
index_state *istate' parameter.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache.h      | 1 +
 repository.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/cache.h b/cache.h
index 71097657489..f9c7a603841 100644
--- a/cache.h
+++ b/cache.h
@@ -328,6 +328,7 @@ struct index_state {
 	struct ewah_bitmap *fsmonitor_dirty;
 	struct mem_pool *ce_mem_pool;
 	struct progress *progress;
+	struct repository *repo;
 };
 
 /* Name hashing */
diff --git a/repository.c b/repository.c
index a4174ddb062..67a4c1da2d9 100644
--- a/repository.c
+++ b/repository.c
@@ -264,6 +264,10 @@ int repo_read_index(struct repository *repo)
 	if (!repo->index)
 		repo->index = xcalloc(1, sizeof(*repo->index));
 
+	/* Complete the double-reference */
+	if (!repo->index->repo)
+		repo->index->repo = repo;
+
 	return read_index_from(repo->index, repo->index_file, repo->gitdir);
 }
 
-- 
gitgitgadget

