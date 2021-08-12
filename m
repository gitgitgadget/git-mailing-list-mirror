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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EA5C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 08:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D60DB61058
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 08:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbhHLJAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 05:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbhHLJAG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 05:00:06 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985DAC061765
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 01:59:41 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so9644839pjl.4
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 01:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q0aNrijfj0MgMjfnzQsL1n+h386kQZlxx5F3DnLnE9g=;
        b=fLsXLU1KyMa6mRQheLC/5QFhG/rRwfaxcyrBwND1Vkewrt9NFKkyQdBhf+lxPioWK3
         8dA4hpPv1Ez7Brca2c6kqgdLH8s/sP5pgHmBijU198ccs18G8aC/Zr7JliTGeMFxQxmf
         QrK87xC1zaVkdEY3DwpqESeMVXLDBtER9FiBj7EC8c/O8ybTHMcWRJPbV4iXjJlqAptB
         j7RfjgkRMMeJlgj/CvQYsHNnTJLnd1WDPL5a/XgrrgTjQP6oB2pN3+q/+CoBIm+zbLag
         bS+s0QKfhbFojWoOpZmnFMZtIqKKQtpza3blN1EdyCbLmhEy37DgK6Ha1c//BIfCiWMA
         Ci6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q0aNrijfj0MgMjfnzQsL1n+h386kQZlxx5F3DnLnE9g=;
        b=iwgocICvQ+w66C0Bqa9gTWPqOPbROlykh954QIp/hwN9l1uquaD+q9I37LIKu2d0Ph
         wQOwY2tDSMD9KTxGHNciT6IN/TVghzHJKCRkx1NjiKnZOMLrchuTBYJE/F04nrwC5ELz
         FXTdKafsRFTMiwSX+OTwnJE1wvUTKcWJw5jDeNNQXzqyvvXm0rxdj+nzcTtzLKW5JoqE
         UV/p0315Ohh0lse5bE7uQajgkolUCPwQ6tKbC/tZ+ET4AUIINFxEnwFyLU6qAPrV3rfi
         biNor3u7PQr6qY0W6ZYy7+6m9k6gjJ00ZvIfKaAfk+r7arbLZNRW13L8cCZ/VPazLLmT
         7+vw==
X-Gm-Message-State: AOAM532+nosWCfS2u7vkN38mu0yRw97aVsE88IcsIwCJ4J6IbpWKhQqo
        8TaNM1NwCcNWjC+auZZpZMk=
X-Google-Smtp-Source: ABdhPJwuI8AjXTjJGcNzxNl3AH656UL2EGjSOj9I/z5unc4I4jOBby0A9qpqoRUies0o2wGHUfD0zQ==
X-Received: by 2002:a63:f749:: with SMTP id f9mr2979660pgk.77.1628758781175;
        Thu, 12 Aug 2021 01:59:41 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.159])
        by smtp.gmail.com with ESMTPSA id e35sm9892264pjk.28.2021.08.12.01.59.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Aug 2021 01:59:40 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net
Subject: [PATCH v3 1/1] list-objects.c: rename "traverse_trees_and_blobs" to "traverse_non_commits"
Date:   Thu, 12 Aug 2021 16:59:31 +0800
Message-Id: <8548aa8bb1ee89b9cce677c7fa35005fa15c5435.1628758416.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.32.0.1.g4c9ac18d93.dirty
In-Reply-To: <cover.1628758416.git.dyroneteng@gmail.com>
References: <cover.1628757762.git.dyroneteng@gmail.com> <cover.1628758416.git.dyroneteng@gmail.com>
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
 list-objects.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 7f404677d5..11d97ac380 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -334,8 +334,8 @@ static void add_pending_tree(struct rev_info *revs, struct tree *tree)
 	add_pending_object(revs, &tree->object, "");
 }
 
-static void traverse_trees_and_blobs(struct traversal_context *ctx,
-				     struct strbuf *base)
+static void traverse_non_commits(struct traversal_context *ctx,
+				 struct strbuf *base)
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

