Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2610EC54E4A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F231620708
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD40MJMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgEGNRv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 09:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgEGNRs (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 09:17:48 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681AFC05BD09
        for <git@vger.kernel.org>; Thu,  7 May 2020 06:17:47 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h9so6373419wrt.0
        for <git@vger.kernel.org>; Thu, 07 May 2020 06:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pDfgA3QsHCBOCopOt25hTXa0JXEJs5+1SFn2nKXdcE0=;
        b=dD40MJMnfEbbRTTEWOs2cAVJ8ff5mHC2FAVq85/RATiSp4lxDR0YuJQWpsvQQSB+sW
         YAjvh8G8q1yKkbDuK2ikeBg7NLp0HP+ePkPF2XZ1PA97zL8fqRec2JVufUx5+h9nxy+U
         8Xqu9TkzOUcILkQEiYcbVuB0TcZL4A5sgjrU4PztautR6u98rX+JWT8QsPae+c96Qd4X
         4YOmhlc8GgHhyfECZM7sNZsC0AA7ENZeVrJi/gnznZHpoPJParMDGhJWbfEG/S18tP+r
         wwDwlzjOo+AY9UMt/u+4J9dgdAkxZde7mOaLwayOV8bzBxHUPJyZSxBd9QTjyhItdiwd
         aFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pDfgA3QsHCBOCopOt25hTXa0JXEJs5+1SFn2nKXdcE0=;
        b=RXUaDd5vi89f4QR2aTZGt3pgPAADklpZ2G621Brb6bCQPGF27BN/y1uC7HD6SPInX/
         c2SWENXCq/B9WfF0m0oJRIJVGbK94vKpi1X2BMvqzYHKIQbdT0qrTNjuDzm0egujpuHg
         N3e0FBraZClU1F4dsc8xn9IjO+jB6xPkWfhJm/K+BfF9x/IrEKJXFcccflwtE4sUQYKX
         XXjCN/lQD/AHzsbl8Roi/hDoCiGx0JRoIFXXTvvxvbN/b6J9cVz6mHmYwxLSsnidRH5R
         WssSjQ+rdJ7/lPzDA8F3WEywx8O1jXdzmKC+bJBrPcYnkj1jvzmJrwdOHfEVOx2/3pLu
         YA7g==
X-Gm-Message-State: AGi0Pua7fF19MVP9OYlua4bDcIrY42sxhyGkDCuSXPo6IoCIppDVGC7Q
        qRPj/RFuTFOH3RaaRTRrFfHVzlaJ
X-Google-Smtp-Source: APiQypJu3BSHcXtvQe+HcCOVvmGpeGmgDQWaKaZQekhKQPg2jzjJezdBfw5DhI0YTN+imgHJuWjcew==
X-Received: by 2002:adf:80a3:: with SMTP id 32mr15106951wrl.199.1588857466079;
        Thu, 07 May 2020 06:17:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c16sm5144608wrv.62.2020.05.07.06.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 06:17:45 -0700 (PDT)
Message-Id: <444a6b5f894f28e96f713e5caccba18e1ea3b3eb.1588857462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.627.git.1588857462.gitgitgadget@gmail.com>
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 May 2020 13:17:35 +0000
Subject: [PATCH 03/10] sparse-checkout: move code from unpack-trees.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmaill.com, peff@peff.net, me@ttaylorr.com,
        jrnieder@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

There is no need to have two ways to load the sparse-checkout patterns,
especially duplicating the info/sparse-checkout filename. Move this code
out of unpack-trees.c and into sparse-checkout.c.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-checkout.c | 12 ++++++++++++
 sparse-checkout.h |  1 +
 unpack-trees.c    |  7 ++-----
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/sparse-checkout.c b/sparse-checkout.c
index 5ada307b42c..875b620568d 100644
--- a/sparse-checkout.c
+++ b/sparse-checkout.c
@@ -33,6 +33,18 @@ void write_patterns_to_file(FILE *fp, struct pattern_list *pl)
 	}
 }
 
+int populate_sparse_checkout_patterns(struct pattern_list *pl)
+{
+	int result;
+	char *sparse = get_sparse_checkout_filename();
+
+	pl->use_cone_patterns = core_sparse_checkout_cone;
+	result = add_patterns_from_file_to_list(sparse, "", 0, pl, NULL);
+	free(sparse);
+
+	return result;
+}
+
 int update_working_directory(struct pattern_list *pl)
 {
 	enum update_sparsity_result result;
diff --git a/sparse-checkout.h b/sparse-checkout.h
index 4148832760d..e0c840f07f9 100644
--- a/sparse-checkout.h
+++ b/sparse-checkout.h
@@ -7,6 +7,7 @@
 struct pattern_list;
 
 char *get_sparse_checkout_filename(void);
+int populate_sparse_checkout_patterns(struct pattern_list *pl);
 void write_patterns_to_file(FILE *fp, struct pattern_list *pl);
 int update_working_directory(struct pattern_list *pl);
 int write_patterns_and_update(struct pattern_list *pl);
diff --git a/unpack-trees.c b/unpack-trees.c
index 4f880f2da90..6f9bdeb57a0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -16,6 +16,7 @@
 #include "fsmonitor.h"
 #include "object-store.h"
 #include "promisor-remote.h"
+#include "sparse-checkout.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -1550,14 +1551,10 @@ static void mark_new_skip_worktree(struct pattern_list *pl,
 static void populate_from_existing_patterns(struct unpack_trees_options *o,
 					    struct pattern_list *pl)
 {
-	char *sparse = git_pathdup("info/sparse-checkout");
-
-	pl->use_cone_patterns = core_sparse_checkout_cone;
-	if (add_patterns_from_file_to_list(sparse, "", 0, pl, NULL) < 0)
+	if (populate_sparse_checkout_patterns(pl) < 0)
 		o->skip_sparse_checkout = 1;
 	else
 		o->pl = pl;
-	free(sparse);
 }
 
 
-- 
gitgitgadget

