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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C016EC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A272A61139
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346778AbhIHBnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 21:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346638AbhIHBnp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 21:43:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53E6C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 18:42:37 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x6so692613wrv.13
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 18:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NRMabsLggRiXlRQv0kIMAy+bZxcG89mSHktSlIoVFk4=;
        b=XUHXOJstN4jJINHPfUF74W92rpoAE9et4X0GxfSzWDE5NYvYLl0qLDpBWx5b8ECOUa
         bEC+MhAxPtYis7/0QbCWwxJbllV3YF8RB028q7niyDsr4hKdxR5mhBJiVDtkDkDAytsS
         9eqQc7PpO/92wqnzCsGwI94meTlw7JarrSv5TD1O/n4ob3RcWJj3Rj2DeO5Vkqt/ILgF
         AzT1feCUH+hdtyGlGCnC22r3+QZDaMFNPvW8zptYnXgjF8EqNCDPUArmSwZgOFIQRltd
         mX7XzAl7nxEqZYp+g7YO2tOX2M445NaQ3Jgck8LnVq7xrmnR9FyyNaefBh2QnD+56KVn
         Yviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NRMabsLggRiXlRQv0kIMAy+bZxcG89mSHktSlIoVFk4=;
        b=QlmPQKN4557F/Hd5K9kVnZcCH5bbmFNY+vd7cLhSN+epR9T3BKMSeCAS5lj1ZWFQI3
         s8LPBPubeeNfEx1fJ0xngQ10+H6RAikiyoSE/VJ/D3H3K7ZZSQ9qsBG0GSfTfDDaWpH9
         Y5q2i+3BuL5jOyKG+Uzed1vgaCeKAxihQfviIxRjl0JoIlBBpR4fH68nVVGQpNaKygCs
         8DKD2lOOU5wVpOVYrVVlbbGVuK2tOpAUH4ZhU9LGc3tu/xjUVCKuzajGF6ojVmsD6hN/
         HvusHKAeYFwsTuDaYUbG17HB6rv+qFSTlrK2IV+yY63zG/USzEm1oaytDjW6OzihrByT
         jPSg==
X-Gm-Message-State: AOAM530NoZZLHhgz6jUKPMptavZHp44zFYn+IYXR9DTsLn0PCOrPuoVW
        hgOCIhIr2RfHbQQdxI2pE3MeLLu3qpc=
X-Google-Smtp-Source: ABdhPJy3qjSaO9d+TJZ7+SPj6bxOFzL4W3Sl76o3LAkGJZWxzGD7x62PFtwZbwNBdB3uKD6Al1uu8g==
X-Received: by 2002:a05:6000:92:: with SMTP id m18mr1081361wrx.293.1631065356526;
        Tue, 07 Sep 2021 18:42:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s12sm583855wru.41.2021.09.07.18.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 18:42:36 -0700 (PDT)
Message-Id: <8660877ba7a06971bb5c443bbc1e07825e950a60.1631065353.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v5.git.1631065353.gitgitgadget@gmail.com>
References: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
        <pull.1009.v5.git.1631065353.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 01:42:26 +0000
Subject: [PATCH v5 2/9] sparse-index: silently return when not using cone-mode
 patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

While the sparse-index is only enabled when core.sparseCheckoutCone is
also enabled, it is possible for the user to modify the sparse-checkout
file manually in a way that does not match cone-mode patterns. In this
case, we should refuse to convert an index into a sparse index, since
the sparse_checkout_patterns will not be initialized with recursive and
parent path hashsets.

Also silently return if there are no cache entries, which is a simple
case: there are no paths to make sparse!

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index c6b4feec413..cd6e0d5f408 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -130,7 +130,7 @@ static int index_has_unmerged_entries(struct index_state *istate)
 int convert_to_sparse(struct index_state *istate)
 {
 	int test_env;
-	if (istate->split_index || istate->sparse_index ||
+	if (istate->split_index || istate->sparse_index || !istate->cache_nr ||
 	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
 
@@ -158,10 +158,16 @@ int convert_to_sparse(struct index_state *istate)
 			return 0;
 	}
 
-	if (!istate->sparse_checkout_patterns->use_cone_patterns) {
-		warning(_("attempting to use sparse-index without cone mode"));
-		return -1;
-	}
+	/*
+	 * We need cone-mode patterns to use sparse-index. If a user edits
+	 * their sparse-checkout file manually, then we can detect during
+	 * parsing that they are not actually using cone-mode patterns and
+	 * hence we need to abort this conversion _without error_. Warnings
+	 * already exist in the pattern parsing to inform the user of their
+	 * bad patterns.
+	 */
+	if (!istate->sparse_checkout_patterns->use_cone_patterns)
+		return 0;
 
 	/*
 	 * NEEDSWORK: If we have unmerged entries, then stay full.
-- 
gitgitgadget

