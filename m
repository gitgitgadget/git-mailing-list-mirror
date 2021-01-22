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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A4CC433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 13:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60754206A4
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 13:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbhAVNIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 08:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbhAVNFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 08:05:16 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DEFC061794
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 05:04:07 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id c12so5012182wrc.7
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 05:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3LC/1eestJjR+EOcwKHsjfdOZknum6kvDyZ7fg9I1AA=;
        b=tyeQV6bHGmmjZIKVtirkUJiUWKnHekp8hWW48RIaM+z4wk3DazKa/gk5w7D82igmNV
         TSDMwvnWPE6dC6NEsd4K2ShE+eJzpoHL0kksCX14hjhxgH/6YXQ0cv690CY+7mk0UuE1
         WSY/jaJ6h46DHBvOeCzykvKtKv5VsSqYamw8sLsk24oqEd3YFb2qIQ73QMj8oc9eLhok
         ZFs28J53sPH+FgNN7thJwnOKbKBb65ynDepdZZz8TGUj68bTQir9XfRik0SbMQvF59hL
         lqtauVGYHh0v17+Kmoi0OTP1l14fuK79MBWlzKJOKmYxa2KjCvzbe2lwSOuxjVfON4ZF
         QjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3LC/1eestJjR+EOcwKHsjfdOZknum6kvDyZ7fg9I1AA=;
        b=eI83GB4IJJZwwRIkDkbkQIiswN+GhjPAX7uudRydY7zSZDK5Ur56pFn/aJUguRK1XQ
         mr77WcW39Wmg93t3U3EdsZyE+K+boIgR0T07HyV5W2J7iEMfuvjnsW0vBzQYvtITmOQ/
         MIA/49suurdmKSH1fvof+ZKhcJiF4DUqSJipjoH/zLpIfFxE0dnsLIQYKdFQMnnuPP/K
         q/IV/F1XADVhw0A/w2eFq11Q0HZI82aRppsBoGcKayXPt+cKScb4DJ7N5pvwZflYjJhf
         264S35CFFHEb82xy2prJsNT65H7lELrXsQQamkrUXdgRPRWj59LJAdveZI41QeOBm0yS
         kAqQ==
X-Gm-Message-State: AOAM532F8qZ8lbas4tnqG0zCVW5IsB4e19RO+f4+Egws3IYv4S3rPnZb
        uYjDlTJHOaqy4SEeekmCYGTFsN6myQM=
X-Google-Smtp-Source: ABdhPJyx9mqjErmWk0GaOz50XY3KQGJ7U79eeKNTqySDmioaSxniubLg5oTFzwCBMrsfoiG+7a4vZg==
X-Received: by 2002:adf:e84c:: with SMTP id d12mr4681430wrn.382.1611320645797;
        Fri, 22 Jan 2021 05:04:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm12467995wrn.83.2021.01.22.05.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 05:04:05 -0800 (PST)
Message-Id: <bc092f5c703fbaead337291cb6f731ec342a89f5.1611320639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
        <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Jan 2021 13:03:56 +0000
Subject: [PATCH v2 5/8] name-hash: use trace2 regions for init
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <stolee@gmail.com>,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
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

