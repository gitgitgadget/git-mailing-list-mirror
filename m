Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DA6C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C36B20708
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjQf+YYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgEGNSA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 09:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726843AbgEGNRu (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 09:17:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C464BC05BD0A
        for <git@vger.kernel.org>; Thu,  7 May 2020 06:17:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z8so6375080wrw.3
        for <git@vger.kernel.org>; Thu, 07 May 2020 06:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IPf8rjZxrrHEPWul7GBKVWG0iLlgOhqVnBivx2n2ugU=;
        b=SjQf+YYHhbpdslSPBZnS3/lZ4Be5pE/+q1+g01w9VOYQVCKsv4LbEL/UD6ukRyqHFa
         58wmlzGF7YSKSRNAOHvGOTK+KPpwyGmW19J7xDjKuz+nPvJqHB6AHILMHX+ewK9CAiID
         a1e8m/L5rOfWAmSiHgYZRe4ExZcaHSSci4LZ6edd02bJTamfbqxQkbck5CmISHGnkSu2
         VrlvvYjul8pHYRSi31FUipRdnXSU6/AYTCfQxOR+X4p36chqeC6j/FjnBN+v+eLbtEnf
         dOjiFpL2Jn7JwD5VHwvB3STthE1VoV68iqSpvtym4Kl5cdVvP9n9y+bl+79vvo2/8Xmg
         0pCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IPf8rjZxrrHEPWul7GBKVWG0iLlgOhqVnBivx2n2ugU=;
        b=oMWbe2hsibSgBAJTDuA2h3J0bfK2QKVSGKDjiI8Y0BCED0azQUo7n3smW1JaUEchtl
         rI2MkW3i78JxFcUZ7fOC8JOpFDXmttnsFTNQV4S8AV1E+aiYy0s2POsG2xXjfZ3E9V7a
         YxYxI8fnVCKGWLpCyuXztil9uDzxQRGWVGqhpN6Ld8hKr4kriskbsq9oWrdtLMtjAb50
         OUvqr8/BCWvk8OmPczfYSwI4GEaTACent3xR4c3j6WvIlPY8H6EZbks9hCi3YsMLG8gr
         yg1goGyRVoH+uUioVMK/QF/0N0YNwtwbBuTBW+0DiPvVnJkfWmf8GnQsRSwcH+950ugz
         qP8Q==
X-Gm-Message-State: AGi0Pua7ongMUCP1mH6O43M9L820UU98ouifbxUQuE4usmw7IK0Q6E1m
        LJLkgFL4Ww1ZSLMbEwTeW+oSGg3f
X-Google-Smtp-Source: APiQypIVcFqtsARLiBBbHu0VVMsL/7jjo1s/zm55D/wO1DPhRbDQwBDmFeabg7p6zDjHqrZldOHaPA==
X-Received: by 2002:a5d:4704:: with SMTP id y4mr16172777wrq.96.1588857468362;
        Thu, 07 May 2020 06:17:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6sm7825533wrt.3.2020.05.07.06.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 06:17:47 -0700 (PDT)
Message-Id: <fcf948bda7aebcc5f88c17f5b308b2ce0cc285f5.1588857462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.627.git.1588857462.gitgitgadget@gmail.com>
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 May 2020 13:17:38 +0000
Subject: [PATCH 06/10] sparse-checkout: use oidset to prevent repeat blobs
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

As we parse the in-tree config files that store the sparse.dir values
used to create an in-tree sparse-checkout definition, we can easily
avoid parsing the same file multiple times by using an oidset on those
blobs. We only parse if the oid is new to the oidset.

This is unlikely to have a major performance benefit right now, but will
be extremely important when we introduce the sparse.inherit options to
link multiple files in a directed graph. This oidset will prevent
infinite loops when cycles exist in that digraph, or exponential blowups
even in the case of a directed acyclic graph.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-checkout.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/sparse-checkout.c b/sparse-checkout.c
index 6c58fda9722..d01f4d7b525 100644
--- a/sparse-checkout.c
+++ b/sparse-checkout.c
@@ -9,6 +9,7 @@
 #include "string-list.h"
 #include "unpack-trees.h"
 #include "object-store.h"
+#include "oidset.h"
 
 char *get_sparse_checkout_filename(void)
 {
@@ -77,9 +78,12 @@ int load_in_tree_pattern_list(struct repository *r,
 			      struct string_list *sl,
 			      struct pattern_list *pl)
 {
+	int result = 0;
 	struct index_state *istate = r->index;
 	struct string_list_item *item;
 	struct strbuf path = STRBUF_INIT;
+	struct oidset set;
+	oidset_init(&set, 16);
 
 	pl->use_cone_patterns = 1;
 
@@ -96,24 +100,34 @@ int load_in_tree_pattern_list(struct repository *r,
 		 * Use -1 return to ensure populate_from_existing_patterns()
 		 * skips the sparse-checkout updates.
 		 */
-		if (pos < 0)
-			return -1;
+		if (pos < 0) {
+			result = -1;
+			goto cleanup;
+		}
 
 		oid = &istate->cache[pos]->oid;
+
+		if (oidset_contains(&set, oid))
+			continue;
+
+		oidset_insert(&set, oid);
+
 		type = oid_object_info(r, oid, NULL);
 
 		if (type != OBJ_BLOB) {
 			warning(_("expected a file at '%s'; not updating sparse-checkout"),
 				oid_to_hex(oid));
-			return 1;
+			result = 1;
+			goto cleanup;
 		}
 
 		load_in_tree_from_blob(pl, oid);
 	}
 
+cleanup:
 	strbuf_release(&path);
-
-	return 0;
+	oidset_clear(&set);
+	return result;
 }
 
 int populate_sparse_checkout_patterns(struct pattern_list *pl)
-- 
gitgitgadget

