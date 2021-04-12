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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66467C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 470306135C
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243618AbhDLVIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240409AbhDLVIp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AD8C06138F
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:25 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p19so7601044wmq.1
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rzO06S1ief0qGjiR3z1dlgur8sjPW9z+JkmBA4FJEXI=;
        b=lrzu4D+jSHCaoUXJxcGmeaCdiAlT8ud+tuFP+GOJ6Bu0QsqkDbOGyT4RKn367/Tx2g
         lNEtrGolgDVZnRkteAK5LdFrNv0yvXx5jQfsv6VdQJouhUBUc2XbJqHBxu5P2SLCQn/P
         vOnfe+XNRN6ph8t3TS1AAzqYl6U4ANmQQ2BhkcrhWrz3QpxYY8WbEjs7VzXw97s0dVyS
         vihpyHZgaiLpLiQtbLKmSTR3ZCBbfzbGW+aoqE3JdiFfniuFfuprDUiR3Hl2R+T0Iv1e
         dpF9qe9v3CptMI+1Hd/fL+QQqe8q00p2/nwZXwroPiIdy99Hk4nazkCZml49lmM54Tak
         RKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rzO06S1ief0qGjiR3z1dlgur8sjPW9z+JkmBA4FJEXI=;
        b=Um53Mdr1zksSVBiRlSbWEUXn4fXe4qVktvdZDKv5y1y1ozLXUVh56YcCawoiLTdU3N
         njZWG0+LS7lFNg2dZx3KjvvFbtbT3ExPcOlIn4DnlpTD1sY+vD80ndfYPx2v1mSW/6ia
         5lYukbvKXmj0a5FExdVBlTg/lhLuqm+TNzyXu+AhO7I4zZwtJnPA2XTjjfU7w2bdyqM9
         l0SW2zR3GCtIwdXqJhai53HajRWND3k7wj1jUnwiUretO3NxzBAK8AdH7jO1vtZ/lC3c
         Dn+ozjMTgQsiMihjtj5CbL+oqzYPSalcsthILDKyx+U1WPYICAw2PXMbOXPD127fIYt8
         gchQ==
X-Gm-Message-State: AOAM533FIcYJIynSVk8hwSlJvSsraHf4PuCTUM2FKe7tZLU8TRCiSzHz
        2CkvBtNAp/iR8rY/HXxdmPIwkRJUpbo=
X-Google-Smtp-Source: ABdhPJygAzhy/7HYImYnOllwwRla6jajxPLDyBRFZqT0Fgyx74eLF0QM3yTVj4QdHP5jEadaMZmekw==
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr897128wmj.119.1618261703841;
        Mon, 12 Apr 2021 14:08:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m25sm473026wmi.33.2021.04.12.14.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:23 -0700 (PDT)
Message-Id: <e2ac527143ffbfc1b480778c2ced786021c97af4.1618261698.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:07:58 +0000
Subject: [PATCH v3 07/26] checkout: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before iterating over all cache entries in the checkout builtin, ensure
that we have a full index to avoid any unexpected behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/checkout.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0e6639052001..d0dbe63ea119 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -368,6 +368,9 @@ static int checkout_worktree(const struct checkout_opts *opts,
 			       NULL);
 
 	enable_delayed_checkout(&state);
+
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(&the_index);
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
@@ -512,6 +515,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 	 * Make sure all pathspecs participated in locating the paths
 	 * to be checked out.
 	 */
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(&the_index);
 	for (pos = 0; pos < active_nr; pos++)
 		if (opts->overlay_mode)
 			mark_ce_for_checkout_overlay(active_cache[pos],
-- 
gitgitgadget

