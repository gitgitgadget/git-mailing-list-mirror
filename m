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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DF7C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1BFA61444
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbhENSci (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 14:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbhENScb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 14:32:31 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECC8C06174A
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:19 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so214751wmn.2
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wFfpok35DynSJzLw2iHIzdshoI7yibKc8zfxCLq0Mn8=;
        b=iFlK0hB5qcmq25w1ecdyMbTFXPTdD3be4NsiXaAJ5jsj9tfSnkP4tXkVuXwtASaCYs
         IC8jC/1fHnDg4HZxa9Tn4rnziHQLYhq9ys2zjKpN1zOlnuIZOEs4L0XIfTViQR8gi65v
         av9E69PrrUSJgnXzhCmRfg6WSKLHL1YTyghNrfcyZCLzY31Az/IGfbzgAD7AwE6ohtos
         UKMD+ZhBAx0SaQ8mFligUMCTkC0XoHM7tYnAWqn+7K5NSfUy4itCs+3REAgucONVIZWH
         0rV6Izboc8C179FC6skqWO2zPMArJP0DWD+PqBCDr9ffP4LzXq5eBEtD3TgyqNWrZqJ4
         /R8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wFfpok35DynSJzLw2iHIzdshoI7yibKc8zfxCLq0Mn8=;
        b=le44p7g+l0tLnN84EDjERngS+m/zpCyovTmFSLDJQdm9qcGNPvjcYCM5Z56f3SAXkR
         z1WngUblRZF5q2EME6CnWqGya+Mrr5ZRlm82laZD1k/d0Yo/z1oZFk6c7nDlhGDqL3Ad
         NkP2fM9mfZxFl1tFAStaKE3qivjsvSRFJmta3I1IY4w1Z6hwtLqQCymOhmchAUUTKz4J
         PY+ZWPnEv8A96WzlQwm3kdQshyqfmkYOkpEmLQj8o6rsYUabjC8oA9yExthJjqnqlpMs
         LcjeQiM4PiFxvnV+gip7VlhDSuM1MqVioSN6Qln0Q00e4gdU2JXVYapBwx1XSBnkgQYk
         XdTA==
X-Gm-Message-State: AOAM531bfBCC0XKUuiecgeQqKpY56kVcFslUaOZQXrPVk9CcTARNHKiX
        il+gqab5I/G0psv0/UjGxfDP+JsbLTk=
X-Google-Smtp-Source: ABdhPJzSFOweu4X0DRneEM3cpPmTJC0Ti31ex93IWax0cxBYnMlDGl1/T7oKp/0VLNZ7DF2eGG0DLA==
X-Received: by 2002:a05:600c:4f4d:: with SMTP id m13mr51509375wmq.4.1621017078195;
        Fri, 14 May 2021 11:31:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9sm5877183wmb.35.2021.05.14.11.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 11:31:17 -0700 (PDT)
Message-Id: <07a45b661c4a6ecd63ede19c9e058a8879069742.1621017072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
        <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 May 2021 18:31:04 +0000
Subject: [PATCH v3 05/12] unpack-trees: preserve cache_bottom
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

