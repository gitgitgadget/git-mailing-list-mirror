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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52711C11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C26061CEB
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhF2CHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhF2CH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:07:27 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC1EC061787
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:04:59 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l21-20020a05600c1d15b02901e7513b02dbso717023wms.2
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=20VyvcZukH9mBP0oxKGuPMDI0uq7we8hBvlg4nNNWng=;
        b=IVqWWAb94YqqSCtCiNGXU0WBuF/FbUrGohhlzceUEUIrwPCSb0JWyS4Lpmqt4P9JuI
         qCPEw5qVK73VK4mk9JRgHr6ACfZlCC4oHfbtSLqprFnxoxRCgFBGoS78OZjCHJPth/p0
         sC4e01X4XGZpGMXju4g2K6G1mcklgiIcS+dyhbjVE9+Q7dqgrZTA054vDSxGkGA2Rin0
         CXnLkfHlgzUoGDbxQzfcD3grg456RVQQNw0V8Wzj5NJkpCgo0XwLexwz5+Fs5Ek6JpwN
         jOxC26L4oR3em/z05TQItsSrhAjGQ1E6gcEm9R6x6ZSa2R+QFW6aUmIh+nRP+2XwziGp
         W4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=20VyvcZukH9mBP0oxKGuPMDI0uq7we8hBvlg4nNNWng=;
        b=CVMOfrH4RgCUWdwjKU9u3CYgnznjlIaYH9qSCA0hU4PNX4tjiYhr3fxr0n9jUmsFfh
         BU0G1DKvTpPzBV+1r3BSGOhYN3oPNejAk2JVzFBcY4yvK7UNublWQDmEddQb55yG2TNF
         g55pg4TRJFjKU/6mPW2TODB3e+mcRApNtl8iLZW5KsgeE2q4PoI8VxvCwL2eNvMw+gOS
         exANDh5haYHuU0UTvxEsGuHRQTe14eM8tU6siGEieraX1X9whYKBtJ7qQKzmZf169S+O
         NkzCRx+VH6iDURpKlvpFe39ay9pI4//q9GVMCkcZGt0H00TcSOz+T1dNoxnNNMl/trr+
         oIIw==
X-Gm-Message-State: AOAM532yQXMaLPvTdXxCc9AAsrfQk1X0dadeQfWbAubmeKjjhzuqIqu7
        VoX+tys1Bdz+eXeq1a3pLOe9ymbJhHw=
X-Google-Smtp-Source: ABdhPJz+3ovP30d7fgXA74dwIPy8JzPwRbWcaFAMp1XQYZ96NWh9Ho2EUvBt4Q4Iu/jHj9whlX1XKw==
X-Received: by 2002:a7b:ce8e:: with SMTP id q14mr29276003wmj.33.1624932298411;
        Mon, 28 Jun 2021 19:04:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s5sm16734389wrn.38.2021.06.28.19.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 19:04:58 -0700 (PDT)
Message-Id: <a8dda933567788c6fbe53ff97bbf65851a10bcc6.1624932293.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
        <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 02:04:43 +0000
Subject: [PATCH v7 06/16] unpack-trees: preserve cache_bottom
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

