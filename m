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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA8AC43462
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 825CD6135C
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243872AbhDLVJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243376AbhDLVIv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:51 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4C2C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:32 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so161377wmq.1
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Cwy0/DFLfwxmnrNn1jvtNHYmLs4yYZjayHJKnh4xlfU=;
        b=rUlJ0gxXlwjIvOdvZ/jffbzyFvsjzgKORI7B77n7I0Yh4aqhZVwdy4rDAISUJYZ7t2
         L0KD9YCy+YhoeqDHabfQcaLrigcIw7Z6JHVPkIMQM1f4eXhlJOz+G79RBUSqSWgbnVk2
         DWbc9C8e1wFnHTN31JeyW/V/pfDBkAyBiD2Q5Hr7Lab1iJczg7Q5yW3P1cpoJ2LIU/71
         rnvPlCAh5LGveYX8SUzfstOxH3gEsjDP3soS6gmOBs0NHydqTturWRRECoxYEnvIvobw
         OrK2o0W9xvyDnj1e8efghi1NicKLNRZwB5Q+Um0X0kcYSt3yrziMOeLNTFWA24k0Z+VU
         YYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Cwy0/DFLfwxmnrNn1jvtNHYmLs4yYZjayHJKnh4xlfU=;
        b=RjJVXeBUl1Y/y90EM/MhGoDS5qWZQ/Z5AdOOfAP6bL0OK/yTUrBczx40ySgstemIfv
         MUTtz0gjy7XZaOd8+02jkGUhy8m36d4oVEk70eIB1b6nSIhTgoFZzW46g2zuF0+mYduL
         Yj7MksfJ6+RxiN+QMQXX64MLiQZip9sZHxiDyOSVbnoAeCsa/m1ASBgkP0a1+JKUHgvp
         1bKH1Y5OH9kH6ogU68LMmPjiNEurA2d1JlgMrmK8ZRzCKuvXZrG8JcV14kAnwlDGihwQ
         qQnamEBGjkjKIpyMnOrbQ5dDxpjHRf7s6oOa/0YeWJKFYpzXW/wWK0ZsL+2qQDOZF+7C
         Rkbg==
X-Gm-Message-State: AOAM533D3Ck+QDvM8nu9Zfb04v4wohJTFruM3/NjpIHjHAHiTvEmRurh
        ENkqYlhfcCJ0IsQYOIuvgkpnz5sGA2M=
X-Google-Smtp-Source: ABdhPJy05qVgQayUBvQ/snjURD2xF4P6DKIBpiu6AsY+S7no5xz5M/DS5/+OBKE/QbwwLr9Xf/ATQw==
X-Received: by 2002:a1c:9dd1:: with SMTP id g200mr922483wme.60.1618261711357;
        Mon, 12 Apr 2021 14:08:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14sm18289883wrm.77.2021.04.12.14.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:31 -0700 (PDT)
Message-Id: <3673db5172352152fcaa29feafae432530f36b36.1618261698.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:08:10 +0000
Subject: [PATCH v3 19/26] merge-recursive: ensure full index
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

Before iterating over all cache entries, ensure that a sparse index is
expanded to a full index to avoid unexpected behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 merge-recursive.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index b8de7a704eae..91d8597728c1 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -522,6 +522,8 @@ static struct string_list *get_unmerged(struct index_state *istate)
 
 	unmerged->strdup_strings = 1;
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct string_list_item *item;
 		struct stage_data *e;
-- 
gitgitgadget

