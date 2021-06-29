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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31766C11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A48C61CCE
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhF2Bya (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhF2ByQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:54:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2F6C061766
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u8so10383296wrq.8
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=20VyvcZukH9mBP0oxKGuPMDI0uq7we8hBvlg4nNNWng=;
        b=d0NbtkvqLn+4u8ddmOxSg/RcpqPdfdf4sGL4n6jTkn9hu+ficL5vTxGg1yNwRAo6xd
         IB6jskBmPWKGWj0ESoaWuHkcZAZQmY41O1sqgi1P2pWae2oltbN8bi4I22fq7pMB8N9a
         oj9N3m7nSgvpAtA0LlUkX72EqfPvTm7K9ifJIJbjQnBwMxeMb1Nw6UkFqZAQJITH/lcX
         K9VteRjmW9tiFT32ruLf3FVKR7E7Gg1RP5rccMutE24YDVdc6D9pDj+2ARlR73fM80zn
         NgH6N7lQzwy23heqP2BkrtMJgXqMIzQkdGS1zfITPlC1NWGq+n4DI+txkb+aYkprcJbB
         W6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=20VyvcZukH9mBP0oxKGuPMDI0uq7we8hBvlg4nNNWng=;
        b=Ctl8XDQ9wcKlBlQHTb4Ep0YS1P+zESDpb+bdK26Q8vMR5/Gr88GEmJm5NCtV6gBpNt
         lQwbf0+0hZsk3Tlg4y21ffHv+IhBHvA3FXcdJ5jqGAvGEshQwAGz/gOyk+DtSNH7KBWR
         kJVYelk0EluUQjVK/cGLXJVz7l+EcqGwmxNkStLcb2108VHQMIIkFNsRwLXC7fCQ/jIg
         ReXUe5CZV2AQWLMzkZ9rtZkBATgs53SBx6RJd8P+GCF0T5BnASf1TkJD2p/qVvthxe5b
         kxXRtUx6cOgMoSXN5W4CkJ87U34GYg0mVC8MNZBd32GXVNdAvgrerm0CyWbyyHmv+pWz
         FjLg==
X-Gm-Message-State: AOAM530Lpslxz66V4txX02UmmFmxcHp+uY2eWCuH2J7Y3+JilGRejO3Z
        d8fLwlXYdrZdzk4ZBqbCUW6lXucw7lE=
X-Google-Smtp-Source: ABdhPJz0it1XoUXp2Uewtvakthi0WvZ/EFYl8YcsV1S/25q/BHCsuuYbH+d1vTqAefvuYUZolRrffA==
X-Received: by 2002:adf:e38c:: with SMTP id e12mr31034469wrm.404.1624931507488;
        Mon, 28 Jun 2021 18:51:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h46sm18152705wrh.44.2021.06.28.18.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 18:51:47 -0700 (PDT)
Message-Id: <587333f7c618f8eb65f7a25d1a4ab02f9ace92fd.1624931502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
References: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
        <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 01:51:34 +0000
Subject: [PATCH v6 06/14] unpack-trees: preserve cache_bottom
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

