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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C658BC4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB5C660F39
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbhHQNYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 09:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240039AbhHQNYM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 09:24:12 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6844C0612A8
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:23:28 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so2163304wma.0
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1hHIMQenL0YY07ojegpV/bWS0DueNnK3juz9ucy/bVk=;
        b=P+abpnWKku679HQ5SfgX4RpqPkw1GE+reMiOw6BcdsOWF0OBx+xiufwJi0OaqxSlY8
         d7rnGYZ03ONXW13/6jIgaWbK/gPZOGqCzkn4SRpnFsrzwCVoDe/amrGV2Pf5Dzm75YG+
         dEjrFMMSRBtZzceDobChwtOioLZOYWE32cp6HIFZl+4N86yLbFtT7SFjr2SeewcA36S7
         7K1aqit5hs8mHd6yea+b3TxW1oDxjv076H996+n4vrslr6b/ntgywZVyyN4SFwz2qlko
         KdRrvAFdWtnGN0ulGE52gl5+bTIrQsVKNKjhzAIlmxBTUlSjkAjbkY/m/Hk580ZNf1UF
         Wvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1hHIMQenL0YY07ojegpV/bWS0DueNnK3juz9ucy/bVk=;
        b=oueHFDtHpbA6zsigu6oaBdjsXEh/uuJYzS/NfVmdJhCxkZYTDfix0WgWlKZ19Vu/cJ
         iV3EG4aMs8tfOJmf72mHcOLlh4teVA/HtPPm0IMGjv/t2TSvV7m2/IShVqK2AIcT8B0e
         mJKd/q2o0WCae9r+Fnmbgrhd75pENFxWz25FnHBadnzl1YivgF1lpfOHM+Kduu+Kc4qg
         NPpWml4JHEElEOYlXt+dIPLW/kuPF/ynT9eDOl/euKe6iZSJUw9RNK+9qb3n8nXymvSn
         pLt/3gDOhMMDoKUMbBaotIIE6FxkzErEHedRk1uJxLOVkdLOqoH6K+i0ppaRk9HNhwGM
         0J9Q==
X-Gm-Message-State: AOAM530MUgBi08RLwFQD0/8uo4q97kgQrosCtJ4VC+iRJ5cHWQt0VMxd
        nb0i9O41kUh8KcGNOIhmyTLqYjM6Sjc=
X-Google-Smtp-Source: ABdhPJzqRDKsrlYSwG+cePCYy838jXSpj5O72mQ0oH1dMfqDVWP/9fH+LOGyUX2Wu5YZwttJTiA+Vw==
X-Received: by 2002:a1c:9dd0:: with SMTP id g199mr3377146wme.12.1629206607553;
        Tue, 17 Aug 2021 06:23:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k14sm2461875wri.46.2021.08.17.06.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 06:23:26 -0700 (PDT)
Message-Id: <371985352680a767dfacb5477aa77e92e04008ee.1629206603.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
        <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 13:23:17 +0000
Subject: [PATCH v3 3/8] sparse-index: silently return when cache tree fails
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If cache_tree_update() returns a non-zero value, then it could not
create the cache tree. This is likely due to a path having a merge
conflict. Since we are already returning early, let's return silently to
avoid making it seem like we failed to write the index at all.

If we remove our dependence on the cache tree within
convert_to_sparse(), then we could still recover from this scenario and
have a sparse index.

When constructing the cache-tree extension in convert_to_sparse(), it is
possible that we construct a tree object that is new to the object
database. Without the WRITE_TREE_MISSING_OK flag, this results in an
error that halts our conversion to a sparse index. Add this flag to
remove this limitation.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index bc5900eae35..b6e90417556 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -179,10 +179,15 @@ int convert_to_sparse(struct index_state *istate)
 
 	/* Clear and recompute the cache-tree */
 	cache_tree_free(&istate->cache_tree);
-	if (cache_tree_update(istate, 0)) {
-		warning(_("unable to update cache-tree, staying full"));
-		return -1;
-	}
+	/*
+	 * Silently return if there is a problem with the cache tree update,
+	 * which might just be due to a conflict state in some entry.
+	 *
+	 * This might create new tree objects, so be sure to use
+	 * WRITE_TREE_MISSING_OK.
+	 */
+	if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
+		return 0;
 
 	remove_fsmonitor(istate);
 
-- 
gitgitgadget

