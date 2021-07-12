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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66408C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D03611C1
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbhGLR64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbhGLR6x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:58:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E701C0613F0
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:03 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i94so26781023wri.4
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=20VyvcZukH9mBP0oxKGuPMDI0uq7we8hBvlg4nNNWng=;
        b=Gz8C5Q4m8V7f/gp8EZKXlmGl1B/OFsGGHqsFIJZjibRmcgZbkVfVZa33BuMbnlU6x2
         h+igBPZJ90Ou+vJ/FgXN94rU6f0++DDzY796DMnhQxytuipOfZBDNdzjz75EcEa6uWv9
         7i15I6qKT8KjIus1n3xfHMKOIDOuwDrXKpq4+Vem5m4vsJTFjkYuPpyZ4V24C7F/xfrL
         qxK5jFKy/L+IUJkFro9XT4655rigwhP4EHO9Fnmcw6H2DUd1AhsCyrRi22RLwAfDqUbt
         7f77UOgDXLPIMMr7It2QVDzbq6MIimPyxV8TkVgqc02QOEl4IIjlrCApBbfSC+5zf2Se
         B4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=20VyvcZukH9mBP0oxKGuPMDI0uq7we8hBvlg4nNNWng=;
        b=e0ehmFKCO+BjaQZ66xsxI1PUZHHC2F3m6OfvODeL26nvdoAWfvSVP1fAlvM5hzktMy
         h4hvcOVO710pmzT755Pa9J+A7ReGfugJpW8Zd2j6YxBB4J52vzlnz2mpfTpuvxnCiyyb
         BDEg9cL5wpbht+BSoMwkBejH/5aaPcO6tBrAKt7yDCCCOCF3VxCVHUoC5glHDFUq1Mqe
         4ZZ2SbjhMurzCX5hDSh6R1fyN0Z7VGoVH/K6eREp27Y6qR3wTDQ0lJByUE73WKLNY1ko
         YH4g2EyD8hVpbRjD3fIFEqgxhZ9imwJdsxaqTWIVABb9AukXWn+kutlcCYV6qvPa2kIx
         S4yA==
X-Gm-Message-State: AOAM532ewZ2QKDx41uMKK9nEN2IU39CrQ6gRiqnx2aBfsFYXRo/2kuTm
        t64E2X7JKJ096lyjzmIBwzJ7BqRbNvo=
X-Google-Smtp-Source: ABdhPJzrRmZsLXXky7T3BCpCtyBHYuB38weq2T7phHJhlI/wv0jktC8S75DmuZQ+c2Wdt1RJYynxKQ==
X-Received: by 2002:a5d:4252:: with SMTP id s18mr266862wrr.88.1626112562094;
        Mon, 12 Jul 2021 10:56:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 129sm6341869wmz.26.2021.07.12.10.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:56:01 -0700 (PDT)
Message-Id: <b182b4566135c0cc9aa59f244d63d5e296d4297d.1626112556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
References: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
        <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 17:55:47 +0000
Subject: [PATCH v8 06/15] unpack-trees: preserve cache_bottom
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de,
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
index f88a69f8e71..87c1ed204c8 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -600,6 +600,13 @@ static void mark_ce_used(struct cache_entry *ce, struct unpack_trees_options *o)
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

