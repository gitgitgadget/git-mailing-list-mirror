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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCF7C4332B
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A352D233FC
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbhAGQdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 11:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbhAGQdf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 11:33:35 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B9DC0612FA
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 08:32:19 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 190so5712204wmz.0
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 08:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1cXbZJPHh6PbIf9iSugyF98nzI72FppH2Gn56ddappw=;
        b=IarpQOBlNs+ZA/I8l2LL5wnq8KdrM5bbgmbZQRRNLRCqdCXhTwlUOC4zeMjes7hRGG
         dA7M0SGhlnpBjNKjkgteUfQOJ9ZmHSIOuhwMEBDkQm3trsMDyad38cMYV65KyXGY6N22
         FaON3nDAovbPtXu2MRJB/r4CQ3TyBvOifIaC55QM1gOVmcd0fj3tjG3M3+y2qlUYxW7A
         +prxs1cbSw6lvXZlLwqPcr+x8tdbrtbkE3rj9QSwFOE3vrTfEKC3GghCgPXcPCfmoR7r
         XG+kYYskhxaMqNFtv+jVlZuB6LmZ5TR98zUAvNO8BkxwHh2Al5GBZbFCSAkZGOtAseGT
         9n6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1cXbZJPHh6PbIf9iSugyF98nzI72FppH2Gn56ddappw=;
        b=HQlmsnAsEP98MklEHfqvyOHhPaxAIx/q/0jelae/DDJGUoYGCh3joI1hL8M+Dbcjrd
         wdkUHIwQdrNcBWpEob0bDtv6fwnwyWv0QU2MKym1sMjQP3DR11DZbrdnn/NCFn+8uEs2
         xts7naLQWPbOxFBWoc1Kudw5F/sYAsnmERvy7Eld/iC5stlLFlCGTv2+W1X6dY96E7TE
         1uL+ANvYAjNTjEf+VJq7QD1JOE3f1iY4T70UotdGqkE2QCJW6oEb4Yw9PUJXgr7amE3/
         /X9xbTKt/J/U/kcF7u4tsz31tzM/k9+sQgTtjCB2iuI0NCaxsksMVq/sik8tJPOUZUPe
         Y2aw==
X-Gm-Message-State: AOAM532pSxga0CnObE0COra+2fKbTyKUHcwwxTbIHiZ+feB3/wAAtHWO
        E9Kg+CpKd2z0tgjqfFeq/QoNcUMKYA4=
X-Google-Smtp-Source: ABdhPJxgywc3OJbsJkkbDU96CJ0xc06K4sM5MaxiGFk8ZTAyvbUbnkR69CIPwT+rnUrL4KSFMV4hWg==
X-Received: by 2002:a1c:a706:: with SMTP id q6mr8729482wme.7.1610037138112;
        Thu, 07 Jan 2021 08:32:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h16sm8630574wrq.29.2021.01.07.08.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 08:32:17 -0800 (PST)
Message-Id: <2b2e70bb77c8dafbf2cfedd9e68f834f02deb4a2.1610037132.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.v3.git.1610037131.gitgitgadget@gmail.com>
References: <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
        <pull.829.v3.git.1610037131.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 16:32:06 +0000
Subject: [PATCH v3 05/10] cache-tree: trace regions for prime_cache_tree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
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
index 45fb57b17f3..7da59b2aa07 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -744,10 +744,13 @@ void prime_cache_tree(struct repository *r,
 		      struct index_state *istate,
 		      struct tree *tree)
 {
+	trace2_region_enter("cache-tree", "prime_cache_tree", the_repository);
 	cache_tree_free(&istate->cache_tree);
 	istate->cache_tree = cache_tree();
+
 	prime_cache_tree_rec(r, istate->cache_tree, tree);
 	istate->cache_changed |= CACHE_TREE_CHANGED;
+	trace2_region_leave("cache-tree", "prime_cache_tree", the_repository);
 }
 
 /*
-- 
gitgitgadget

