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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8EFC4320A
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 08:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F0A560C3F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 08:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbhHLIrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 04:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbhHLIrv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 04:47:51 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8495AC061765
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 01:47:26 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso9587154pjy.5
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 01:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Lj+MQIFJML91SIisnXDwaKaY8AWVFPmearbdQ6wBNk=;
        b=s6fuFZ6flap6Phe5EOIC/U5LUKtwEsKSgSI5qg2OPlkThAcY8EGSzbATiOnfvnvvFe
         X+bW5FRZtUtXoYpnmYglf5lbpnoctoUEoeDQHnjlXOCcfi+/2pBVhQuoZbpzLY8m4DUU
         M/OhPeNQteqiEpb4wBFuALOBvS3bqToK0pS3sN54Zo5JJg3tZZT9qn2ql96hodUcpRZ4
         iE9L3wKEVPMSSkXe3NGJaTRzkLj1cxRMfu1xP6m0a4diFgAOr7OVSpHCtbLxoExtbzeU
         rG+p3QB/u7UlznS6wsDq0oXi/JdahSZrUAWrb2xzNtNP2wChvLND6bHd047Ge1FTTxnp
         6sVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Lj+MQIFJML91SIisnXDwaKaY8AWVFPmearbdQ6wBNk=;
        b=kaAOM1EN0UYnyTPcNi1gCM4kq+26rLe7w/HD5AU8yUVYd1+cLyS3pUFYaxM7FKt4Gq
         nC1ewj5KbL6HfRKf4gEml3C3PTxtEY/v8A2tKoF9qs7HsOClBnJXJkJFvAKo+a/v7kyU
         ERUvYJSp6i1u1wX4snu6n9jiQnTPPi3zU9VSnnhNXFXD3qXQ71vB6qoxvxO7/HD1OIN+
         PzGGKMwOxJ8IJWEqW5n/HF95ya7H58ODJwjVDuxF/+MUnIs06MNeY+HuE4cD3TgM7Bps
         n+lZayJuzMvUUp5Tr9psviWlWyJan4B1Po12its0WLiNNZNF3AwiM2DzPp5gMXX7OSec
         eqeQ==
X-Gm-Message-State: AOAM53221FZJgBupSsIgbMU33SmQP3NlpoH76PrQmw9tmGJ0AehIM2Xh
        zFoNqHQ/gM/BhRmhF53bhqI=
X-Google-Smtp-Source: ABdhPJxcFjuJ4kRKYKhVCXhFbi9byWlL4bHiUUz09g4MhLIGIq+pAVrG+ahfFS/g4KjfTjnsuAuGOA==
X-Received: by 2002:a17:90b:30d0:: with SMTP id hi16mr1402475pjb.154.1628758045949;
        Thu, 12 Aug 2021 01:47:25 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.159])
        by smtp.gmail.com with ESMTPSA id m18sm2108695pjq.32.2021.08.12.01.47.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Aug 2021 01:47:25 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net
Subject: [PATCH v2 0/1] list-objects.c: rename "traverse_trees_and_blobs" to "traverse_non_commits"
Date:   Thu, 12 Aug 2021 16:47:17 +0800
Message-Id: <cover.1628757762.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.32.0.1.g4c9ac18d93.dirty
In-Reply-To: <cover.1628670288.git.dyroneteng@gmail.com>
References: <cover.1628670288.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long (1):
  list-objects.c: rename "traverse_trees_and_blobs" to
    "traverse_non_commits"

 list-objects.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Range-diff against v1:
1:  b6f3b15253 ! 1:  2d19f0901c list-objects.c: traverse_trees_and_blobs: rename and tree-wide
    @@ Metadata
     Author: Teng Long <dyroneteng@gmail.com>
     
      ## Commit message ##
    -    list-objects.c: traverse_trees_and_blobs: rename and tree-wide
    +    list-objects.c: rename "traverse_trees_and_blobs" to "traverse_non_commits"
     
         Function `traverse_trees_and_blobs` not only works on trees and blobs,
         but also on tags, the function name is somewhat misleading. This commit
    -    rename it to `traverse_trees_and_blobs_and_tags`.
    +    rename it to `traverse_non_commits`.
     
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
    @@ list-objects.c: static void add_pending_tree(struct rev_info *revs, struct tree
      }
      
     -static void traverse_trees_and_blobs(struct traversal_context *ctx,
    -+static void traverse_trees_and_blobs_and_tags(struct traversal_context *ctx,
    ++static void traverse_non_commits(struct traversal_context *ctx,
      				     struct strbuf *base)
      {
      	int i;
    @@ list-objects.c: static void do_traverse(struct traversal_context *ctx)
      			 * tree directory without allocation churn?
      			 */
     -			traverse_trees_and_blobs(ctx, &csp);
    -+			traverse_trees_and_blobs_and_tags(ctx, &csp);
    ++			traverse_non_commits(ctx, &csp);
      	}
     -	traverse_trees_and_blobs(ctx, &csp);
    -+	traverse_trees_and_blobs_and_tags(ctx, &csp);
    ++	traverse_non_commits(ctx, &csp);
      	strbuf_release(&csp);
      }
      
-- 
2.32.0.1.g4c9ac18d93.dirty

