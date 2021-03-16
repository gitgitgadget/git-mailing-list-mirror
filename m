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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EE2C433E9
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA20664F91
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhCPVR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbhCPVRY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:24 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53526C061762
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:24 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p19so314996wmq.1
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O6OCazjk/NCzMzL3BNHH4A8buwQiHk8IdpxHl+PrUc8=;
        b=BpPJ+v0FvIgfBMzHWChNT1N3qJjQQrn6M6QOq6bUNUEujK/dwsfpZbGjnczO149YML
         SdYz6wvUTiL36YY1E9APTNt0Te9yXV3hv9WS+Q6ugwawYd98Dee5FULM+kKcKFB600HP
         pKsUsVOftYAE3dZ9qvmhbF96QxvknLJGrkQrP1B4r2zfPJkeBtna4mtIXE5s0DZawdbg
         wpeQOfIiCX5GxfIWFxXEq2j8pHmpfqbJNDvjGN2CS5uXwbts715E73VRB3OrWdc/QeL+
         PCuQLOWYh/3xX1b5pB9ETaavojZhEliV9uJ/5oUddufF7m0l58/7rbpIibXRXgoSIuZv
         OS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O6OCazjk/NCzMzL3BNHH4A8buwQiHk8IdpxHl+PrUc8=;
        b=MuqbdZHcy0Un6iuhrJiHeD+Jh16tZzKccB8+A9Mn+oIzK1xVj502HZXdFsuXGKSief
         bOwntPG9mrWT4brZef/6KyQDcKeqW1BCRrmT4omuX4E1xgieoTw9TPLSrEghsZXzWE52
         ZCfvN7v+uxQq5X6u5qz2liH4yj77+RTK0egSveqgmcRwZN5DYCuscIAs6WQcagKYwBOZ
         GCtsOiwmS6iaYclzrk13+9Rq+3mmcr5Z0xANY/mHoqWLoj+KVVv9p6viXkIHMwT4j3dL
         s1uCn6jHSj34O8ORSOQ+mILsrj8uCd8tiPTWE+UVuCkgKnqrfcB82BpkYeTTlr8mveq3
         v2Pg==
X-Gm-Message-State: AOAM530vKmfC2oH5ur1Ju5BJiJJA3apmkH5VwMnyNJ+UJhfVHZl8D4eY
        WAIQYMcLhgy6A8q8YUaR9RpZPE41P/g=
X-Google-Smtp-Source: ABdhPJw6ikVCVfTlzO9Wvr7F831mcikW0JeeBKp1JYTVcUjshBowERCDmzwjRqZBP/X46Jyu1eDwqw==
X-Received: by 2002:a1c:f614:: with SMTP id w20mr681991wmc.70.1615929443159;
        Tue, 16 Mar 2021 14:17:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v2sm1032101wmj.1.2021.03.16.14.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:22 -0700 (PDT)
Message-Id: <a59e45c4ae8f8a1b99e6ddabaec438e281a44057.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:16:56 +0000
Subject: [PATCH 08/27] commit: ensure full index
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

These two loops iterate over all cache entries, so ensure that a sparse
index is expanded to a full index before we do so.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 739110c5a7f6..9ea9e7b53390 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -251,6 +251,7 @@ static int list_paths(struct string_list *list, const char *with_tree,
 		free(max_prefix);
 	}
 
+	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 		struct string_list_item *item;
@@ -931,6 +932,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (get_oid(parent, &oid)) {
 			int i, ita_nr = 0;
 
+			ensure_full_index(&the_index);
 			for (i = 0; i < active_nr; i++)
 				if (ce_intent_to_add(active_cache[i]))
 					ita_nr++;
-- 
gitgitgadget

