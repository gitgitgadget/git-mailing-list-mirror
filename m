Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BA4C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 08:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 691E46103A
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 08:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbhHLIr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 04:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbhHLIr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 04:47:57 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13714C0613D3
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 01:47:33 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g12-20020a17090a7d0cb0290178f80de3d8so9492299pjl.2
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 01:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c7gFr1wBtsiwSolqA/Au3OUK1bTO+DF8458pp6GUtx0=;
        b=o/BYO4jqoN5Mp1h9SYBzcksKtIlDOBfSzg1X7Vh8B/3PPstW+VzfsDGjwHG2oW1km7
         jN7d74IJoZJWQcn6OwISYMUBgjlcq2qMX9EZAzggswrLOW+YLtG79kX1pZ1fm3+U4d3F
         ij/6LOwlXbtWsDz4c3fO3D8SB2NMiMZ6FMvp2a3IXIuzFDvLJ8889M2+CimpjUfFjupx
         ECHEDhQ3z9hFvLqdG96ide4vU3dep6uQ0aNoXSbpRKtM/tbnMsJ2OnMmDV2ZM/zXuTdb
         imClzDXuwjK45ifjitMhZQF5et5XZ6ybrSCumUarRYMvvQNVojavb0Bgd7VCGO5+iVpq
         qhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c7gFr1wBtsiwSolqA/Au3OUK1bTO+DF8458pp6GUtx0=;
        b=kThEzPEYqi30ngtX9/g1aiZhVWYTX3A+A2TcToMxMSVz4Ho4n4Sl2EygpZOD3zzEjo
         9NForcHuEVi3Rf/kPRfayRbKJvkHYMPhlmRY4ge1rQhbbULV3kBHbe9eS24dssQSTwOy
         xc7lCgUQ88pbxdWlQj3wn7fZkdM2G575Zs2uEc71eYlt3QNDcy+2+chYcXyvDIPQO680
         2GL+RLb6gK5aE9HP4aaEDgGCTn+wd4IwxKgw9hD5N5u0Swt0l+gcseRsWxvuQfJzyqLO
         OUQ4Q3n/WD2vGyNDrGLlgPBl53h/amUbPsoLOtCFTUBxKlfg5g2h55QP0tPTgXbHIUaO
         pEFw==
X-Gm-Message-State: AOAM532z853g1Vrsxnt6AbgYpD2W43nlg9Pd+8kJGMmDBlzPGa3usJ4n
        m35nO8EGIY4eqHs3FIHapiK+vMNIo6wsH5bmCQU=
X-Google-Smtp-Source: ABdhPJxOr1e0WIXSJkq6ylFW72Gf8G4jdCjHCaCu12The9pn3TfUVRV/5qjHNwSxzk1fAjxCqyplag==
X-Received: by 2002:a17:902:cec2:b029:12c:bef0:ec4b with SMTP id d2-20020a170902cec2b029012cbef0ec4bmr2683972plg.74.1628758052579;
        Thu, 12 Aug 2021 01:47:32 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.159])
        by smtp.gmail.com with ESMTPSA id m18sm2108695pjq.32.2021.08.12.01.47.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Aug 2021 01:47:32 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net
Subject: [PATCH v2 1/1] list-objects.c: rename "traverse_trees_and_blobs" to "traverse_non_commits"
Date:   Thu, 12 Aug 2021 16:47:18 +0800
Message-Id: <2d19f0901ccb5ff27842b876cbe1085757a4aacc.1628757762.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.32.0.1.g4c9ac18d93.dirty
In-Reply-To: <cover.1628757762.git.dyroneteng@gmail.com>
References: <cover.1628670288.git.dyroneteng@gmail.com> <cover.1628757762.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Function `traverse_trees_and_blobs` not only works on trees and blobs,
but also on tags, the function name is somewhat misleading. This commit
rename it to `traverse_non_commits`.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 list-objects.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 7f404677d5..edaf1f5d64 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -334,7 +334,7 @@ static void add_pending_tree(struct rev_info *revs, struct tree *tree)
 	add_pending_object(revs, &tree->object, "");
 }
 
-static void traverse_trees_and_blobs(struct traversal_context *ctx,
+static void traverse_non_commits(struct traversal_context *ctx,
 				     struct strbuf *base)
 {
 	int i;
@@ -407,9 +407,9 @@ static void do_traverse(struct traversal_context *ctx)
 			 * needs a reallocation for each commit. Can we pass the
 			 * tree directory without allocation churn?
 			 */
-			traverse_trees_and_blobs(ctx, &csp);
+			traverse_non_commits(ctx, &csp);
 	}
-	traverse_trees_and_blobs(ctx, &csp);
+	traverse_non_commits(ctx, &csp);
 	strbuf_release(&csp);
 }
 
-- 
2.32.0.1.g4c9ac18d93.dirty

