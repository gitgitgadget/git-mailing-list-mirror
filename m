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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2087C433E6
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FB522262
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgL3T2S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 14:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgL3T2R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 14:28:17 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB2BC06179E
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:27:00 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m5so18282119wrx.9
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fOGirnYlDnavvqoIa4Qn+d+wr7AfycoofAGcA7YjpCQ=;
        b=AnHsFSnh28VwI2avpubV5Lt5Wui0KPSC4rPAol7+UgUwZfIlVt8tj5UssY/h2tsL0B
         lBLHVghL2QITWxwwabSg+/BVa2Zqr7IL23YkdOOXUybnqyjmgJjtxsEeIIl8sxlI82Nj
         irs1j6ttpyj8h9LaceTpi0af4ScFYgnmNdLG/C4jI333RxLSbCl9N3JmP/x8lqgCflO8
         kNiNs8vmRN3R60Kp8p9+C7VUSdVVo2e5kftcXiTmYOtmXCOsX+bVli4kGxc4V9pgDeZK
         XE1LtVrhW2iKBRO0krqGJzdiF8Se3tCnZRiI7vYcyV0/BRyvNoeQgs4jZUM0f51Tb16D
         0dLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fOGirnYlDnavvqoIa4Qn+d+wr7AfycoofAGcA7YjpCQ=;
        b=TdKlcZrO/dHFUL2Nb4BE3JBjcQZ4RhnIEV/fDmKEqlDY4QxcKBbi/vnSpMqosYFwvF
         +oBSYTbq5/F1Fb3r4+rciHZwO1igk/XeUHedzO1bXly5PS24q5h3CNwjFd9bwP94+b25
         2gM2PVkQJtHiPLjVtcT8CSbGzV/5rpID/b/+2hBFoLUEXKzBYNJOdOO8/FkS1MOmuevm
         1VBQE+vnk++IYGB+RW6TlXsm0TPfXgQJ6QtJaUQzqrheJ/5PbehxoM865s64Jyu/dzTz
         EQh0wif6xjCqNNbMZEnWYseOlLKN7KMhBK8F1Eo+mAQo8x9LMX5jap/7dX2nBMrnUn33
         lXEA==
X-Gm-Message-State: AOAM530ujV+RSuW30eBmNrLpXXNYsAIg6xZ4IOR6Hh4tRMp2gVEXHFeg
        gogOGTXBnyQzl/UyL3LeSXrjjhb5TS0=
X-Google-Smtp-Source: ABdhPJzS7A5gJsZayzNGoCXwJNXdZ1oA9Djzxw06Ucmwd2pzNpP3RVK8KuJGDUHScRXoVZgoNtcyHQ==
X-Received: by 2002:a5d:4682:: with SMTP id u2mr61704873wrq.265.1609356418842;
        Wed, 30 Dec 2020 11:26:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15sm64346374wrq.1.2020.12.30.11.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 11:26:58 -0800 (PST)
Message-Id: <5d1c9c8a356b9003be21059c7ed6232732fd26c0.1609356414.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.git.1609356413.gitgitgadget@gmail.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Dec 2020 19:26:50 +0000
Subject: [PATCH 5/8] cache-tree: trace regions for prime_cache_tree
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

Commands such as "git reset --hard" rebuild the in-memory representation
of the cached tree index extension by parsing tree objects starting at a
known root tree. The performance of this operation can vary widely
depending on the width and depth of the repository's working directory
structure. Measure the time in this operation using trace2 regions in
prime_cache_tree().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache-tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cache-tree.c b/cache-tree.c
index 45fb57b17f3..f135bb77af5 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -746,7 +746,10 @@ void prime_cache_tree(struct repository *r,
 {
 	cache_tree_free(&istate->cache_tree);
 	istate->cache_tree = cache_tree();
+
+	trace2_region_enter("cache-tree", "prime_cache_tree", the_repository);
 	prime_cache_tree_rec(r, istate->cache_tree, tree);
+	trace2_region_leave("cache-tree", "prime_cache_tree", the_repository);
 	istate->cache_changed |= CACHE_TREE_CHANGED;
 }
 
-- 
gitgitgadget

