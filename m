Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0B7C0007A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE540207AD
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501859AbgLCQRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgLCQRm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:17:42 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21604C061A55
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 08:17:02 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id x22so3226859wmc.5
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 08:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3vtm1X9i88mWmQCcuhGCoP18qF+vmfT+1M4unInmIAg=;
        b=gm94LPVWzvjqA5bN3/3ui2DJbRFSurKHUjEOvgUalfXGZHkWJw3hKBIlxPkk66WpGf
         RMyFV2pWjdMLBraMNTZzz0nE5vGZqQGJ6dJaAxbcKGicrWTtt5LMfJ9u4wSRRNy7blxe
         XtQG/Py4lLFSwhYBEH3fxeEC8RcOlkhHXwWTTfLuCzQDirIjc5dYdGJHUwjB3F6rLnVS
         MMITBaYvGnYgk5+rhDhJkYmnIAr6N679oYzLP/Il5IWe5+taduGS6Zu5OFa71CRvrHo2
         bLowkQnZOP+wqCcPvC9v4pIvJjwILdsWloZg3o6dh4KAcxP8ykiudPQihLgyFqPfItk3
         6cMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3vtm1X9i88mWmQCcuhGCoP18qF+vmfT+1M4unInmIAg=;
        b=mtaBIK8XsiMdbAcNVQ+FwJVB2PbLdfDXjizs2qVGL+uzEjlLQX2jCYEo15EnmlUYkj
         ObM1XKfoKh9ITl5U71/wjzWkPQqNMeqbtWS2xKXrw65/BlWdr6scx1wIxPZ4KV6cuMrg
         xc0RpKFErlj5kPAu9mMZnFWeioyG/xUmAcL9mOdzHfQDCygeDBv3dJ1NxLPU4ezNBpTp
         idGUJ5VslBy+189efZlglmE6bSLvi8nCcxFSyaPgYRKuXXWe6ghmq7Q2OVeU5sD6WvuU
         LWt5grBWleI4Ovyar9EkJ3sh7y6bu3sOu33E8KljQ78q11eq3rvx+cy2myKmr1W9X9xA
         ZHbQ==
X-Gm-Message-State: AOAM533aP4Kk9Hspujoowq8PnK4EtuavlPzI6UgzJan++PIKxab/tZRb
        LhrYG7W3VlRYQee9mlVf9zlKii5Ky5A=
X-Google-Smtp-Source: ABdhPJwV1UeyEBfydFYjFq1QwY9Yo65xTs8nA3+OhdLoh3fKFXaD2/GKPKTmg5jxWNOT8tIhMOPCQA==
X-Received: by 2002:a7b:cb8f:: with SMTP id m15mr4104406wmi.95.1607012220674;
        Thu, 03 Dec 2020 08:17:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 138sm2268194wma.41.2020.12.03.08.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 08:17:00 -0800 (PST)
Message-Id: <f75c34375acb254de90044dc6dcd7ab04f92c72a.1607012215.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.git.1607012215.gitgitgadget@gmail.com>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 16:16:43 +0000
Subject: [PATCH 04/15] midx: use context in write_midx_pack_names()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In an effort to align the write_midx_internal() to use the chunk-format
API, start converting chunk writing methods to match chunk_write_fn. The
first case is to convert write_midx_pack_names() to take "void *data".
We already have the necessary data in "struct write_midx_context", so
this conversion is rather mechanical.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/midx.c b/midx.c
index ded4d394bb..6ab655ddda 100644
--- a/midx.c
+++ b/midx.c
@@ -643,27 +643,26 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 	return deduplicated_entries;
 }
 
-static size_t write_midx_pack_names(struct hashfile *f,
-				    struct pack_info *info,
-				    uint32_t num_packs)
+static size_t write_midx_pack_names(struct hashfile *f, void *data)
 {
+	struct write_midx_context *ctx = (struct write_midx_context *)data;
 	uint32_t i;
 	unsigned char padding[MIDX_CHUNK_ALIGNMENT];
 	size_t written = 0;
 
-	for (i = 0; i < num_packs; i++) {
+	for (i = 0; i < ctx->nr; i++) {
 		size_t writelen;
 
-		if (info[i].expired)
+		if (ctx->info[i].expired)
 			continue;
 
-		if (i && strcmp(info[i].pack_name, info[i - 1].pack_name) <= 0)
+		if (i && strcmp(ctx->info[i].pack_name, ctx->info[i - 1].pack_name) <= 0)
 			BUG("incorrect pack-file order: %s before %s",
-			    info[i - 1].pack_name,
-			    info[i].pack_name);
+			    ctx->info[i - 1].pack_name,
+			    ctx->info[i].pack_name);
 
-		writelen = strlen(info[i].pack_name) + 1;
-		hashwrite(f, info[i].pack_name, writelen);
+		writelen = strlen(ctx->info[i].pack_name) + 1;
+		hashwrite(f, ctx->info[i].pack_name, writelen);
 		written += writelen;
 	}
 
@@ -990,7 +989,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 		switch (chunk_ids[i]) {
 			case MIDX_CHUNKID_PACKNAMES:
-				written += write_midx_pack_names(f, ctx.info, ctx.nr);
+				written += write_midx_pack_names(f, &ctx);
 				break;
 
 			case MIDX_CHUNKID_OIDFANOUT:
-- 
gitgitgadget

