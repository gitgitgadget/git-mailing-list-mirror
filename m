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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD205C432BE
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99BF161051
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhHJTup (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 15:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbhHJTul (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 15:50:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E451BC0613D3
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 12:50:18 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h13so27837444wrp.1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 12:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oc2wvXngXb26lsP7r8c0mk+JZ8u847riiXPKJWHBYNk=;
        b=B4Lb46ahWBFeNrq2OngRNM8QHMngLZ1ijZlbyPMemBEJOah3m/QHcmGN0tLrRfvQqC
         I0/kI0bHp0njGtEPW7k9VcS26MeIE0QnSBvzEm55Mu84BkMYFiM8CZgqGqX90+1GOUaQ
         0hfbSujkdDb0ysk9ZtmD1hWQiC1+KUril93lEQjb94fL5DHH6rQcWqEmGOU/wSP9rXEt
         GE02hxfOqhBAmDNvcMQ6T1TbS8lr3tugtPiEakafeHz30gGb+cVEi2PzqPS3vNouL1DA
         iZrZxbRiCOv2vzKkDb6nhK8lR1YmGSgRnET4G3T5qjA6f1nk/rP+/aXXzMADk23Gn9Hv
         NiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oc2wvXngXb26lsP7r8c0mk+JZ8u847riiXPKJWHBYNk=;
        b=h6f/lGJ5YFaS6UDuy+hydSXskR8phKExEsXf5ZOcx4cpnTazEU5sRhSaLHNRb3jrSc
         oYrTxUtwAR79ZnwKG7lFCWCOy6z93T2w0i2mfvgnN4+kX5/mtPZj1w8z7OcywvAT/OpG
         SuNw/ncTs3NOWuvXWCF0RLRr9u1zFw67hvDC2U5+AMiH6pVT6srEgBuZ0/o9475N/34i
         vn5PYxiXd8C7qhFz0KoNc4NtZNGBjFy01EH0R/aBQcKAqGuY0751pA7kQF2T1zlK+jFG
         brvI1GKPJ+OISKOcqk2X7xPBVQPhjmy3BA4zl/hZ/1EhSSiwyBYfE3tEOuXqoDX34l6K
         n0QQ==
X-Gm-Message-State: AOAM530402RkPWZ59x+ADngz5sbFz/4S1hE0TBUsDd3rot0FzFfY/4Qo
        OorFPhWCDIjTxULmN3Be2LGESNfK18s=
X-Google-Smtp-Source: ABdhPJywFUwpEg6Dj6ETEi8DRowCpF4yvX53pT7Mrxyq7wfpll+lNPGgPTDrUOtuEGH5v6flx9yANg==
X-Received: by 2002:a5d:5106:: with SMTP id s6mr32735894wrt.359.1628625017644;
        Tue, 10 Aug 2021 12:50:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17sm24887110wrt.47.2021.08.10.12.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 12:50:17 -0700 (PDT)
Message-Id: <10bcadb284e49419f9b4baf75e05f719ec395d98.1628625013.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
References: <pull.1009.git.1627579637.gitgitgadget@gmail.com>
        <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Aug 2021 19:50:09 +0000
Subject: [PATCH v2 4/8] unpack-trees: fix nested sparse-dir search
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

The iterated search in find_cache_entry() was recently modified to
include a loop that searches backwards for a sparse directory entry that
matches the given traverse_info and name_entry. However, the string
comparison failed to actually concatenate those two strings, so this
failed to find a sparse directory when it was not a top-level directory.

This caused some errors in rare cases where a 'git checkout' spanned a
diff that modified files within the sparse directory entry, but we could
not correctly find the entry.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 5786645f315..df1f4437723 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1255,9 +1255,10 @@ static int sparse_dir_matches_path(const struct cache_entry *ce,
 static struct cache_entry *find_cache_entry(struct traverse_info *info,
 					    const struct name_entry *p)
 {
-	struct cache_entry *ce;
+	struct cache_entry *ce = NULL;
 	int pos = find_cache_pos(info, p->path, p->pathlen);
 	struct unpack_trees_options *o = info->data;
+	struct strbuf full_path = STRBUF_INIT;
 
 	if (0 <= pos)
 		return o->src_index->cache[pos];
@@ -1273,6 +1274,10 @@ static struct cache_entry *find_cache_entry(struct traverse_info *info,
 	if (pos < 0 || pos >= o->src_index->cache_nr)
 		return NULL;
 
+	strbuf_addstr(&full_path, info->traverse_path);
+	strbuf_add(&full_path, p->path, p->pathlen);
+	strbuf_addch(&full_path, '/');
+
 	/*
 	 * Due to lexicographic sorting and sparse directory
 	 * entries ending with a trailing slash, our path as a
@@ -1283,17 +1288,20 @@ static struct cache_entry *find_cache_entry(struct traverse_info *info,
 	while (pos >= 0) {
 		ce = o->src_index->cache[pos];
 
-		if (strncmp(ce->name, p->path, p->pathlen))
-			return NULL;
+		if (strncmp(ce->name, full_path.buf, full_path.len)) {
+			ce = NULL;
+			break;
+		}
 
 		if (S_ISSPARSEDIR(ce->ce_mode) &&
 		    sparse_dir_matches_path(ce, info, p))
-			return ce;
+			break;
 
 		pos--;
 	}
 
-	return NULL;
+	strbuf_release(&full_path);
+	return ce;
 }
 
 static void debug_path(struct traverse_info *info)
-- 
gitgitgadget

