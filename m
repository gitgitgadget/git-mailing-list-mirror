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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8447C43460
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF50F60238
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243730AbhDLVIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240417AbhDLVIn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:43 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4F4C06138D
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a4so14339462wrr.2
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dTUCQB3WXCizXGIVy+rJNkDOcat4/a7nb8eHNj32aL4=;
        b=htx0UHiDbUIVFDR1ZNEbu+/FN2fIEzzvnlpkt93rlVZH6fJ9A18CmgT7e8gjjhk1oe
         4xej07ZWgn3YFU6jNPkDrG7+5YMmiDSSvo2ZfnUbhnY7HxCsFjc0noK10MFENPZGJbco
         6b8Jp+O4CWuLYU+Z1ZSQkEbEqHa475woU2Y1fiwGRitNjWFFLDVyliuzHoRav2tpnfZi
         QcVxAo74hB81J9Ryu2aRCJjXziFWp4k4qxT1pYihKrbgWxqx2c/yNgfw60qr2eOa1KwS
         HPCVCcZknTUbDKdx2YinxqmK9j3gJHh54FlReO09v+9uZeEcrjuSTT71kpE5M3dvDQRi
         NudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dTUCQB3WXCizXGIVy+rJNkDOcat4/a7nb8eHNj32aL4=;
        b=RcDK8Sio3mdCabjpkxgCnB3l3kvQ2ZQOUho+2+Wf3qpFnlLi16UOVp4mXUgjDMusKA
         4rxAe1emY1k7NEGqInq9IPcgcBmbBGyGOl7/s08QA0pPuITsynzRuKDXXZQFiV5OfUrJ
         0aaj2rQMgZb2i8GZObOKZ1cR+bV0YPzBz9oUibJ9kbKNiHbvTV6mVbftwyxka0iPF5x6
         dk/ruVDzbvlciguIBS4Fjo3dWUJVM2jJlcVMkgMAoPPtQ9bv4ZcYFAXu2MZgAWNCbfaX
         aJAQaXUzmbzWD9uR5XAzLbtznynHBHoKwwu1XO0Sf/zkhjv2W0zeHjIBxymB8iAg3F/c
         vbyA==
X-Gm-Message-State: AOAM531A6bcIi9gBJr6+OerIqzQqnm84P1ZA9CqLsg+duy1FKu1y5d5B
        nMltQhhKfE/S8XcxDwbzSRAgylDVCS0=
X-Google-Smtp-Source: ABdhPJyZ3vsLayjcqyu1dtElpV4KOPJQtzEBop9tgMx7bt0Mzt6a6kXOLWSiedoEaasjj3LA8RcIHA==
X-Received: by 2002:adf:fa11:: with SMTP id m17mr33363294wrr.287.1618261702589;
        Mon, 12 Apr 2021 14:08:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s9sm494277wmh.31.2021.04.12.14.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:22 -0700 (PDT)
Message-Id: <b59c9f482828c54cfa8ccc2022cb72b60833daf5.1618261698.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:07:56 +0000
Subject: [PATCH v3 05/26] add: ensure full index
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
 builtin/add.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/add.c b/builtin/add.c
index ea762a41e3a2..afccf2fd5543 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -141,6 +141,8 @@ static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
 {
 	int i, retval = 0;
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 
-- 
gitgitgadget

