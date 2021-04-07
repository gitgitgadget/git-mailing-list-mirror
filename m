Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40011C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 06:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ECD0610C8
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 06:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345953AbhDGGzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhDGGzB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 02:55:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151B3C06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 23:54:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so568780wmj.2
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 23:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qas+Qo6Ci+nPlqBVtP5SqEXWBYq6Y1HhCWeRB+lxoCk=;
        b=h7/MgnU/qoMU/BPA3v4Hn3Nis57kUWQMT1zH0Ny2X9Ta9bCjnp1/XiP3pWI9F73jYl
         4iJ4KwGanVpaG5z+29Nc6MKAF+TZ8Ul5aVxCoxKVQqGsA+kYDI6/ptzb/78Xt6D2Ca9R
         4g3PfCt4me48NoIcLYBB9dNoQcE8XuG21uC6nB3uR3AsvUIfH2Ll53BYjf6K1caau03W
         1SqdsKLFJo7Y0nFkyTe7HISyma2E+Usts9tGswURQND8gmFsZJGqDUQRL6B3yq2ip+C1
         BKua/5WYZVf4KU0yDhhqW5UpVICH3rYYm6wMokZ/hTVVamJARsoFEDVuXw0vLx2e7Awt
         skzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qas+Qo6Ci+nPlqBVtP5SqEXWBYq6Y1HhCWeRB+lxoCk=;
        b=EPr70iwZT8vIEmu0GjiBoo+DVbge+433sg7Tr5N+yfKvlm/B7I5Pl0lVeh0ewspPpx
         cj9YBV4Fn23gsroBHERKGgWgDDfOc/barGDdt4C6rtgroqCYCZxrl3HVUmiWugYCLEJa
         zzkWmEway+9Y3Vip28nrSnne++oDcJuwz+JgDWigNboq8j9SXx4hrz7m3xf4OAUx1UiW
         4NkPzUbhnRhC7FqfWsjro5NzOMkK7AjD7VSH2Uy0dbn5ULQ2Ex5pVCpPdZhvE3lY/ty0
         U1z/PP+hi7wet1lErqqVLKH2fruxW+wSqQoJ4y1bNuJnA9N/MplziDGnavuHo4vbwITo
         syig==
X-Gm-Message-State: AOAM532Ldcde6NFXPFFF8wZEGEJ40Cfte0S+pm6d0jHhZG3y9pHwcCKG
        xd3lglzwMu8bkidnEMPsn9ismtJ3Pj0=
X-Google-Smtp-Source: ABdhPJyl72QMUkuaebVLsxSUkhHihC4iorDEHQlZUHzcMAQvCZ3U+CvoO5JwMLtNrmkLt4osCZjwfg==
X-Received: by 2002:a05:600c:614:: with SMTP id o20mr1541855wmm.66.1617778490878;
        Tue, 06 Apr 2021 23:54:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u19sm6214036wml.28.2021.04.06.23.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:54:50 -0700 (PDT)
Message-Id: <pull.915.v4.git.1617778489719.gitgitgadget@gmail.com>
In-Reply-To: <pull.915.v3.git.1617465421353.gitgitgadget@gmail.com>
References: <pull.915.v3.git.1617465421353.gitgitgadget@gmail.com>
From:   "Chinmoy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Apr 2021 06:54:49 +0000
Subject: [PATCH v4] cache-tree.c: remove implicit dependency on the_repository
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Chinmoy <chinmoy12c@gmail.com>,
        Chinmoy Chakraborty <chinmoy12c@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chinmoy Chakraborty <chinmoy12c@gmail.com>

This kills the_repository dependency in cache_tree_update()
and prime_cache_tree().

Signed-off-by: Chinmoy Chakraborty <chinmoy12c@gmail.com>
---
    Replace the_repository with r
    
    There are multiple files that try to reference the repository and
    the_index directly. To follow a more object-oriented convention these
    references should be replaced with r and index and passed through
    functions.
    
    Signed-off-by: Chinmoy Chakraborty chinmoy12c@gmail.com
    
    
    Related issue
    =============
    
    #379
    
    cc: Derrick Stolee stolee@gmail.com
    
    
    Changes since v3
    ================
    
     * Used istate->repo instead of the_repository to prevent making changes
       in callers of the function.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-915%2Fchinmoy12c%2Fissue_379-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-915/chinmoy12c/issue_379-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/915

Range-diff vs v3:

 1:  2a4fad2781e3 < -:  ------------ cache-tree.c: remove implicit dependency on the_repository
 -:  ------------ > 1:  25f09954b9df cache-tree.c: remove implicit dependency on the_repository


 cache-tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index add1f0771317..4928a9f0f13b 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -446,10 +446,10 @@ int cache_tree_update(struct index_state *istate, int flags)
 		istate->cache_tree = cache_tree();
 
 	trace_performance_enter();
-	trace2_region_enter("cache_tree", "update", the_repository);
+	trace2_region_enter("cache_tree", "update", istate->repo);
 	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
 		       "", 0, &skip, flags);
-	trace2_region_leave("cache_tree", "update", the_repository);
+	trace2_region_leave("cache_tree", "update", istate->repo);
 	trace_performance_leave("cache_tree_update");
 	if (i < 0)
 		return i;
@@ -746,13 +746,13 @@ void prime_cache_tree(struct repository *r,
 		      struct index_state *istate,
 		      struct tree *tree)
 {
-	trace2_region_enter("cache-tree", "prime_cache_tree", the_repository);
+	trace2_region_enter("cache-tree", "prime_cache_tree", r);
 	cache_tree_free(&istate->cache_tree);
 	istate->cache_tree = cache_tree();
 
 	prime_cache_tree_rec(r, istate->cache_tree, tree);
 	istate->cache_changed |= CACHE_TREE_CHANGED;
-	trace2_region_leave("cache-tree", "prime_cache_tree", the_repository);
+	trace2_region_leave("cache-tree", "prime_cache_tree", r);
 }
 
 /*

base-commit: 2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48
-- 
gitgitgadget
