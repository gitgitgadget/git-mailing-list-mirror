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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87013C4320A
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A8B661078
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhHJTuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 15:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhHJTum (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 15:50:42 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2430BC0613C1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 12:50:20 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f5so12056574wrm.13
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 12:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dgfH8FHC7lRtH5aYzMRWtNR/tzYMsPRc7peitaicWXk=;
        b=CB/XLEk9idwkqsql2iAFQr/B5Gkz4DD+PIGhRyei/FqZHwyLZ9Apj/4zB8mx+yFumF
         HpysIEygYESRNe6ldLxhyLlURYJye1khjN9uIsVozZzqLrqHWkWQR8svtD/S2xoiLIdd
         3zPhTTJyxHXu98zFQesfc719yfa1rbDLeGIeb6lxjuXsC9hSfAhKLVbXOBdKVUyVITfL
         B8MPrllBB/WvV4eXjhjcN1dH4IAj5ypxotIaiWpu2jWEGc2ghk82qqIYv5GVCchaYSMo
         jicdysfkdaIfMdyuY4renrN2j85qmYib9P2cpVBHk0IHlY6aN1LXwbMNlNx7/v0SSSkv
         GN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dgfH8FHC7lRtH5aYzMRWtNR/tzYMsPRc7peitaicWXk=;
        b=nbHKBnOAml3j0m10OegRkmKG/JS6dWCTJPXGwVZygGaiIqygkxNUp6DrbLZmKtbT1/
         4nmq5+J8PTL1yvuxEYblHv67cqzCd43l8ffDa/X6QNt693LVRwz1iCF8lPAO14P0hZHu
         Qoug+deeZmPnRNxM7f8Adhlo4Ks8+ZNp2r+ps0v2LKzE2pN2Gp1lPmR6smx5UzsL19lu
         AtCn75H9/eXoeXbPCVrknUyHzGIuxoGzC+RVWI5KRFAartQEQjvHOUsgdtGM5DZCeMEW
         6k+/Mo4v/Zo1bTAqjRaEEpCj/ul/Amiv4GluXFSDycBmFgDuyBUuqadE0bI16Zx9ztVR
         juQw==
X-Gm-Message-State: AOAM532dU35E+TXInIehqYYfpHT0hzmgnSLzfNSRC1HwOFaXBv9d8YmG
        4yc248lxO6Fg1dSfgyuztI+ldn06/PE=
X-Google-Smtp-Source: ABdhPJwsqIf/QLQCJbET2zEIMJeJRlDu601KyYfqjivBqHwcY2LIPcr/+pJOXSpnofzq9cQ0Lt4gJQ==
X-Received: by 2002:adf:e551:: with SMTP id z17mr15736086wrm.40.1628625018849;
        Tue, 10 Aug 2021 12:50:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8sm23873294wrx.46.2021.08.10.12.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 12:50:18 -0700 (PDT)
Message-Id: <5680df62e1cd56714d5b6a61081aed381749ac54.1628625014.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
References: <pull.1009.git.1627579637.gitgitgadget@gmail.com>
        <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Aug 2021 19:50:11 +0000
Subject: [PATCH v2 6/8] attr: be careful about sparse directories
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

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 attr.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/attr.c b/attr.c
index d029e681f28..a1009f78029 100644
--- a/attr.c
+++ b/attr.c
@@ -14,6 +14,7 @@
 #include "utf8.h"
 #include "quote.h"
 #include "thread-utils.h"
+#include "dir.h"
 
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
@@ -744,6 +745,19 @@ static struct attr_stack *read_attr_from_index(struct index_state *istate,
 	if (!istate)
 		return NULL;
 
+	/*
+	 * In the case of cone-mode sparse-checkout, getting the
+	 * .gitattributes file from a directory is meaningless: all
+	 * contained paths will be sparse if the .gitattributes is also
+	 * sparse. In the case of a sparse index, it is critical that we
+	 * don't go looking for one as it will expand the index.
+	 */
+	init_sparse_checkout_patterns(istate);
+	if (istate->sparse_checkout_patterns &&
+	    istate->sparse_checkout_patterns->use_cone_patterns &&
+	    path_in_sparse_checkout(path, istate) == NOT_MATCHED)
+		return NULL;
+
 	buf = read_blob_data_from_index(istate, path, NULL);
 	if (!buf)
 		return NULL;
-- 
gitgitgadget

