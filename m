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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA4BC11F67
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5D1F613C3
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239427AbhGNNPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 09:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239409AbhGNNPj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 09:15:39 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D52C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:47 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d12so3121478wre.13
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+JojcSX7peEex/WmJGEY4wC333AFwsaBpcjYH7F0zGA=;
        b=LdEAaxCJOzBYw0ZmRkHzgT8Ye8GA+7nmmCByS9dj9A1EbqXdDBn7Dpr+/2CnlExON2
         AZyw/8OmykVJ3EjXBrLO6viy2DTIcZg4Xk2pGuJPjiiTcJworRUM+Lxb9kdDAbqO+JAe
         Lxxa2mPshuJVkYLyCUhFAni0TBWgu3D06tX64nMXPNait05CyTxH+xuW9ui4UCut36TM
         RFes3HK51nv43Xp6ZtjNn/dvg0EaMk3sWVZCANiTfd2d88q+ff17ri3+iAjlAbrodxwB
         qZEZkVMgjV/PpPf+2ppLzL6kEJy5u0Wh6UVRXAx1tMahEH7eI8wRXa6MqWVP/Z3I1oRk
         kZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+JojcSX7peEex/WmJGEY4wC333AFwsaBpcjYH7F0zGA=;
        b=c7wBy94wQWpE7f7VdDOe9Jh4tuc/ibVfueDX2IUuKf45hnC/K0HLzYxDQPQ4R5Rgus
         c3qW/faW+gLG3sZxBJx7bPOB8qDlc3aEzD6EufYoWasgmZCkjTGImo1/sE0n6AhK7liW
         BXMC25r8279bfze5Q/StqhLiwzNYZQwZd7LR5KCqFaaxssePnvfTCKlCM42eSJ/PxaCh
         H/85in/9mHug728rs5tbkqo3QsJBMaligFKJYzYyW1HRVhfYBep3ntnh24F/hdgDwiVe
         xQN8xT69c9EaQJEe/aKTKMrze3LkbTLoaWAu/UGROykjWK8W7GdeiRa1qvp9k/IP2k8u
         WiEg==
X-Gm-Message-State: AOAM531ynwvmgkfDZ0ZnspDiQiH3h0GZ1WXzvL+MIiyYzzFfpL3DVZm0
        gAoUZnH8v2/gpkeOFrAGrvHyqCYR5Uc=
X-Google-Smtp-Source: ABdhPJwkrncH2wl0AORw/uHWj8g8sV8KdoTZLLFge95nGQBJwVnsZSplD9s/HmBeIYCcZ+KazB7ZAw==
X-Received: by 2002:adf:e3c1:: with SMTP id k1mr12643799wrm.78.1626268366591;
        Wed, 14 Jul 2021 06:12:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w15sm5831385wmi.3.2021.07.14.06.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 06:12:46 -0700 (PDT)
Message-Id: <18cb1f6ea9b145e7ab664c1f9de5886ffba732a2.1626268360.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
References: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
        <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 13:12:30 +0000
Subject: [PATCH v9 06/16] unpack-trees: preserve cache_bottom
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de, Bagas Sanjaya <bagasdotme@gmail.com>,
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

Reviewed-by: Elijah Newren <newren@gmail.com>
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

