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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66BBC433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B77B23358
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404083AbhATQzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404073AbhATQzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 11:55:25 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC00CC0613D6
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:54:06 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id b5so1012669wrr.10
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3LC/1eestJjR+EOcwKHsjfdOZknum6kvDyZ7fg9I1AA=;
        b=IylzHAtr/pdLB2jWyg0Lz2dNVhgjiVyl0JbBlBFs5+CKDmkDkyhG4pJwRRdnn4QwOZ
         wFoMOZX0tRTRAHoLtc1npqNp244BdHtaeJYfk9Gd4eaiOfO0O4unGSa7Fn4Ik/8Rm3JN
         4iGJgUcwJaNdvk3J2JImcFIFWCBGuIpwD2Ozx+kNr2reb4KGs+6Z4Nv6lGSd4p0ez+/0
         S0KWVGk24TUZhm8Tzezg8stLKNE9rtuRskbzCWncVKZxsImyWLKtwqvU6flngicLKtDn
         xHcNLn4BwI3wFTh+LAjpbsbS4wmHDUy6aN1oZov5boZiETti0MgryHRXuCs7CSSEa8zc
         qMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3LC/1eestJjR+EOcwKHsjfdOZknum6kvDyZ7fg9I1AA=;
        b=AcfDS0annJSqHLLa3BtrEXoDBpqnHxZGfHx2oV3IsgJGXuhP2h4hM3b7RyxqS17jQl
         usKtivgqWh+YtWvSmdA77rj51hOjEOUe54temgzB6j+HnoE6/n+F85yKXOVwP2LXqFix
         v8CKz8T9BOI4LSOI2coLCNLEwOAays99Zu15ttWO9KMTrN6J/CU5UqahiZyksFtOwkZq
         svIMrDCCaxQclTU5eyy553rLCwxHO3yrMtCMA/7hE7te/2vWOMQ3GEBwmBXoOFiBiimy
         zaFrL7zdY5RmTBuvzwR4IpGvEPy393Qs7EgHw2WjEYkIgWIy/a2abmvbTZjgMHaU20dJ
         zdlA==
X-Gm-Message-State: AOAM530ic2WpBU8FmhAsSx3fZj6xaV2/AWMAxscVTjM2YnDnCn9I121K
        VqH/mKsne8JBMbnA0aneoDhME249ECs=
X-Google-Smtp-Source: ABdhPJwstZI5GEu8ezfU3HGGAhGmQOKbbWRg9YPzlwTey3YQJPxapk6hJ2HiKK3o/73LLAI/3yRzjg==
X-Received: by 2002:adf:e704:: with SMTP id c4mr10245022wrm.355.1611161645440;
        Wed, 20 Jan 2021 08:54:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s4sm5053881wrt.85.2021.01.20.08.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:54:04 -0800 (PST)
Message-Id: <3ba4b35f09cf3dc313787cdec6856286fe97d8a8.1611161639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.git.1611161639.gitgitgadget@gmail.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jan 2021 16:53:55 +0000
Subject: [PATCH 5/9] name-hash: use trace2 regions for init
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

The lazy_init_name_hash() populates a hashset with all filenames and
another with all directories represented in the index. This is run only
if we need to use the hashsets to check for existence or case-folding
renames.

Place trace2 regions where there is already a performance trace.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 name-hash.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/name-hash.c b/name-hash.c
index 5d3c7b12c18..4e03fac9bb1 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -7,6 +7,7 @@
  */
 #include "cache.h"
 #include "thread-utils.h"
+#include "trace2.h"
 
 struct dir_entry {
 	struct hashmap_entry ent;
@@ -577,6 +578,7 @@ static void lazy_init_name_hash(struct index_state *istate)
 	if (istate->name_hash_initialized)
 		return;
 	trace_performance_enter();
+	trace2_region_enter("index", "name-hash-init", istate->repo);
 	hashmap_init(&istate->name_hash, cache_entry_cmp, NULL, istate->cache_nr);
 	hashmap_init(&istate->dir_hash, dir_entry_cmp, NULL, istate->cache_nr);
 
@@ -597,6 +599,7 @@ static void lazy_init_name_hash(struct index_state *istate)
 	}
 
 	istate->name_hash_initialized = 1;
+	trace2_region_leave("index", "name-hash-init", istate->repo);
 	trace_performance_leave("initialize name hash");
 }
 
-- 
gitgitgadget

