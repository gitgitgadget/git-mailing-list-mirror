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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCA6C43616
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7964361090
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbhDABuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhDABuK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:50:10 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA683C061762
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x13so174883wrs.9
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rzO06S1ief0qGjiR3z1dlgur8sjPW9z+JkmBA4FJEXI=;
        b=FkP2dQCFQxNP5RU7x5TH+yakq5+nQRO1K24j1RjBaijghGPUQlkXDrNW5VbxO3Ldza
         TQV49VhJPo3knJ0Cirfb9TptbP3Siajx1h55TfyeausVUH3TJrkzW8VLokW2YCIQDOcm
         a526mGubfuzGDAQ/7RqWYgFFlLfr4BqMIPi9n3VXsG7+vlXz2D5mhJU0dwwzsGnaiZSN
         ZgCCOhVI/akaz9XDDfT1yj+6coW5aM0T99BEbf67gR1WGtK4dQQ5Bce0mkdj0M9CR4Is
         AqLd+FE4eUE+h+44z+Sg8JG1PrtVLKXnoa6Bkmr9ULWSghlx8gmH40A7RpGyanBrVCmi
         4Q5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rzO06S1ief0qGjiR3z1dlgur8sjPW9z+JkmBA4FJEXI=;
        b=nMCNqaOAycI0lkAAkjhem/c8pKdc3s3TpX5Q1qIpyXB1HLJXMfsWqG263BV7VEpLRB
         UTeIEoX74xwXAU4bxttRdlQFRATfy90sCNdaBErii4iQJO82NLTPIsgEARNxgbD/2M0x
         Tyjc6nnWpeFMRFEDFm5AegPvjdhasm/ZG8gqnbRCPeD8ZmhkQs5rX/gx2ShQdhVcpZMG
         NLSSswoRlJs3i/HLi+votgJRXlV/wIQkLdKVBD26aE/bk3xyN1FMmmvJpHKLbdSdC3bS
         qnoe4hi84ki61JOAhnlhkEDXCVv4ERygKhr8f6MA6vi0rDgIFQfq/AraeJKX88lMKhLo
         A9yQ==
X-Gm-Message-State: AOAM531+/rlNVKhR4Hl29Mv+a1xjmlWjOgi8awdNv36vYiQTQ0OBN/eI
        OKZD9Bbe3lbHAMcCOMjoRiGlx7Xrv38=
X-Google-Smtp-Source: ABdhPJw0bbCxbiaefF9NyI0gGJSLJvCM0ItX9DXmcJbjt/56pNE510RaQ9OcJN0WWctBbmMe1e3gdQ==
X-Received: by 2002:adf:b355:: with SMTP id k21mr6725711wrd.156.1617241808608;
        Wed, 31 Mar 2021 18:50:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14sm6783151wru.64.2021.03.31.18.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:50:08 -0700 (PDT)
Message-Id: <fd04adbb3f79b3dc2e7f36fb4ddf852ba3165f5b.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 01:49:44 +0000
Subject: [PATCH v2 07/25] checkout: ensure full index
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

