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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABBDC433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23CD861468
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244043AbhDWVfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 17:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbhDWVfI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 17:35:08 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E27C061756
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 14:34:29 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u187so7236821wmb.0
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 14:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wFfpok35DynSJzLw2iHIzdshoI7yibKc8zfxCLq0Mn8=;
        b=a3arl8e4gwZWtFR/D9sPebc5HEpiWeVeBENuq2ciId1z0OO1rfC6H7Ok3k51JXK4PC
         AVel0cBgulAmsHnzIEy16EJsNdl1leM3XU+Y45uw+qoFPcxxltOL5QOkeKlWI0iDB8zf
         maJOxuhFu8QX3NNelwL8KvO9CBLN5Jue/TrlEuZsnmecAF7Wwh9NzwUGk1bAdPd8/ApB
         nVNIap+eavrtlZ+MWTDWqeQ+zfNsBCPiyp69eAzS8VoRUKabkMkGaHF3tcogmbsinYg0
         50j4OwpCrqnM8/C3CTlJvnyQ6+05D6sNFiWuMn2oWEUU/kROnsP8oGUKDywfwQ6ZUeNY
         WLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wFfpok35DynSJzLw2iHIzdshoI7yibKc8zfxCLq0Mn8=;
        b=cYDqBI0sWgZPODAwUMICELCyXFR6tSYyQ5BLz6V2HCEjYDf+r+K7s4xPV4ZJzsnAG4
         bR1pjs2dCpBF9pu+OAImf6Nr85TJPfRcEPd9KLO0+a/xpCv+dp2yDkQpWGw4WZg4dA+k
         j8i0E1X9ZnHAHTE1QZgjzhgMuABplKeMCZlDSVAZZKmZp0Da6GXcq9v5FTu94s7KSN/U
         NQlttgS5KgnnkS5pQMixtCCZmKa11WeRklnDgXTAjemA8OEegUFD8S93tO1/17ndT35W
         kn7R6BElThkom22ou3oVui4csnbX3/RM7DVL//8xSGufOOAbOAIJxu6waMQlS0Z474r4
         k3xQ==
X-Gm-Message-State: AOAM531HDdm2tR2d7Sb6rvl8CjPvnwHsW0SyD/beItNndim1C36z4Vjj
        EiUDsl6aR99lx4c4Yx5gjh+Fpvk8btQ=
X-Google-Smtp-Source: ABdhPJy7hha6oKmOx9QpRGkbUG4//OCjrciLvfyF1mX+C/ISuZRtqnltKjnrRCpkKhpAsldIpQPJtA==
X-Received: by 2002:a1c:f407:: with SMTP id z7mr6123063wma.20.1619213668165;
        Fri, 23 Apr 2021 14:34:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q18sm10438123wrs.25.2021.04.23.14.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 14:34:27 -0700 (PDT)
Message-Id: <19344394379dd1ac84f21ae5d72747af5e554668.1619213665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
        <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Apr 2021 21:34:19 +0000
Subject: [PATCH v2 2/8] unpack-trees: preserve cache_bottom
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The cache_bottom member of 'struct unpack_trees_options' is used to
track the range of index entries corresponding to a node of the cache
tree. While recursing with traverse_by_cache_tree(), this value is
preserved on the call stack using a local and then restored as that
method returns.

The mark_ce_used() method normally modifies the cache_bottom member when
it refers to the marked cache entry. However, sparse directory entries
are stored as nodes in the cache-tree data structure as of 2de37c53
(cache-tree: integrate with sparse directory entries, 2021-03-30). Thus,
the cache_bottom will be modified as the cache-tree walk advances. Do
not update it as well within mark_ce_used().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index dddf106d5bd4..1067db19c9d2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -586,6 +586,13 @@ static void mark_ce_used(struct cache_entry *ce, struct unpack_trees_options *o)
 {
 	ce->ce_flags |= CE_UNPACKED;
 
+	/*
+	 * If this is a sparse directory, don't advance cache_bottom.
+	 * That will be advanced later using the cache-tree data.
+	 */
+	if (S_ISSPARSEDIR(ce->ce_mode))
+		return;
+
 	if (o->cache_bottom < o->src_index->cache_nr &&
 	    o->src_index->cache[o->cache_bottom] == ce) {
 		int bottom = o->cache_bottom;
-- 
gitgitgadget

