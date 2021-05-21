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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097F6C433B4
	for <git@archiver.kernel.org>; Fri, 21 May 2021 12:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E450B6008E
	for <git@archiver.kernel.org>; Fri, 21 May 2021 12:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhEUMBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 08:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhEUMBN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 08:01:13 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12995C06138B
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:47 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so7266750wmk.1
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wFfpok35DynSJzLw2iHIzdshoI7yibKc8zfxCLq0Mn8=;
        b=rUZgyKv1hTYqhO/kr37dPT82t4cqf7+tjhUP5h9R/MRV8loSdAjfliC2i+rc6ay0dR
         R5Oij6suEGsQ4gziHnHbfgjtPiHtcO3/FOXPkN/WtAvxzTqr+C/rCm8t80rHk60kK+Vx
         MjCIN5y1XwbO6MDb+P7EiYJcJWFlq8wnPuTCUYg8LwsAiWC+FW4mF66PeUqPcqRNkx8s
         Pu/OJf+jKtwtgTnns0vP3QHr4Itfgi94QxIZ2C8mxSOj6q/KvdWsn3vXrpmSG7dsMDzl
         /ywwugr8XhAVhMbnncDjIZffaKe01o3ejPWHsEIRMGGN6F8YphMvM6lPASboBbGSUwZb
         Thww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wFfpok35DynSJzLw2iHIzdshoI7yibKc8zfxCLq0Mn8=;
        b=Z5pVbik4U7N64g+I3zLj68vahhfyOAX3kgWS9m1wsAVEZENXn9fKKZpLOzBQcJmSYi
         gNxfGekcRD8IngCUhwRsNKWbJrvS4u9uToOIFSUqUznnTdsr8r+1A0QuNBdT3Gew14At
         pgq+VURASsWruIFXPC5Xxm8bKu3jO1/03T6/KU2YWxi/J/Q57FHF0YTpAIQPfkvgBRtr
         oW3LAy4UhXOa6IqWe4r9YBuJbz2WZ6zwdAQ5cW2aSqm18UXjJPhrH0vtc5006YE7OBuH
         3MKXTkgf2SKdcTffiXMh9RFO7kbmXVUjgo2j8WxlvO6cQErYsHBHA9CLlQZKWzOuarPN
         c3lw==
X-Gm-Message-State: AOAM533gpIkmQ/D7mYVFR7C+4NNTc0HIzbwPRUn09jDN6qlN14zMYxtT
        glUKBTNT3okO+LpKuMe7gJolE2s6q1E=
X-Google-Smtp-Source: ABdhPJxuYtCsDYXc20vCsg4iEUWEgWPNlXq2FI8OZg9qHbgdn6agkCXKS9NQe0I96bS+hocAucuBOw==
X-Received: by 2002:a05:600c:4fd0:: with SMTP id o16mr8839071wmq.137.1621598386503;
        Fri, 21 May 2021 04:59:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm1962371wrt.24.2021.05.21.04.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 04:59:46 -0700 (PDT)
Message-Id: <07a45b661c4a6ecd63ede19c9e058a8879069742.1621598382.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
References: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
        <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 May 2021 11:59:34 +0000
Subject: [PATCH v4 05/12] unpack-trees: preserve cache_bottom
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

