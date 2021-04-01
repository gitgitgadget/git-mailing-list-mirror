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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7474AC433ED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F955610CD
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhDABuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbhDABuS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:50:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C79C061762
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:18 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so2019061wmd.4
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hhLYYq4GDu3XvoSbcr7sJoPjWfM0oLCRJFTPz+pdmsw=;
        b=QpV5QV25g58QUP/MAYM0mY0gTg4s9x9928neRIwYNhc0KGC1a2NoLCAQaNF3mFBhDZ
         +whNEq4AuyAP9yADrXeovr9hA1ccc+AhexbRVIgQXWy0DA086slXP50w6OIgurt2Jmo3
         nl2MYqb0XsB4zP1E/rvLOfqPV1nuivjzKGuTkaqBensFVjcXbPYxOh738J59q0BZ6mGD
         gDu8H+ZbdICUzwVyYBUQLDWxLH38NQf2N1iHZp83ImYqEIqSvyFY0s6f9QuibiAPbOGh
         CAfYlw5s//9AOBb7Jv2xYYQaC1bxZPPwnEIvIbmI4VVjhH6T8s7isGAR4+KEg6p5IXrs
         bU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hhLYYq4GDu3XvoSbcr7sJoPjWfM0oLCRJFTPz+pdmsw=;
        b=gCscttpS6kzb6DKq+49MieHNYGRwUwwlbI1qEpeUI0hLmypLYaMdkMBjtzgs1JhpF4
         dneo8V854dsN2PE/eDpNu4oUynb6ZRNlDd4nSO3I3kGuIy63OYE9jNQHGxDHq6iAkz0n
         5KvcYkQoT6ZJrHL0uRS98TBdTjoFapub82DAfBjMkxFNacWzhHwt5KYXRAZkGs6kntX5
         vrStXcYijA1PRTzpVR++kSRJCzZa9mMPihlOpbc2WE52Hk6k83TzVVxyc0CO1MVDauoF
         vTmB0thwVrC1g8UVAJoHyljOs6njTDK4g3QQHZHxzj3Yjf41QMmKEbHHxSl6WxCBXMsc
         njdQ==
X-Gm-Message-State: AOAM5334uiC50F23qZnNSic3XCAKi8FHjRkwR0RNXi2Zd4BTMMApzi1d
        bpocvFIAMRBlI9G5VOSI7LJ5juVju2Y=
X-Google-Smtp-Source: ABdhPJz4099SZwDfJe1eiJE0xRHXZDGbvISvOr/Qma19i0mE/fEgcGOO35hSDYA4Jtpl+uo7U+1gkw==
X-Received: by 2002:a05:600c:2312:: with SMTP id 18mr5526393wmo.8.1617241817188;
        Wed, 31 Mar 2021 18:50:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v18sm7854442wrf.41.2021.03.31.18.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:50:16 -0700 (PDT)
Message-Id: <3144114d1a75a8515fc35ea9625a7d088652b178.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 01:50:00 +0000
Subject: [PATCH v2 23/25] revision: ensure full index
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

Before iterating over all index entries, ensure that a sparse index is
expanded to a full index to avoid unexpected behavior. This case could
be integrated later by ensuring that we walk the tree in the
sparse-directory entry, but the current behavior is only expecting
blobs. Save this integration for later when it can be properly tested.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 revision.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/revision.c b/revision.c
index b78733f5089b..b72e0ac1bdca 100644
--- a/revision.c
+++ b/revision.c
@@ -1680,6 +1680,8 @@ static void do_add_index_objects_to_pending(struct rev_info *revs,
 {
 	int i;
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		struct blob *blob;
-- 
gitgitgadget

