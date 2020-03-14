Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403C9C0044D
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 02:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F343820575
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 02:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/411pAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgCOC0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:26:31 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39810 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgCOC0a (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Mar 2020 22:26:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id d1so4261452edu.6
        for <git@vger.kernel.org>; Sat, 14 Mar 2020 19:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BmKV7oFN4iQWK0H2ANuyeOer2R1yN9d+6RLRtDWCvTg=;
        b=k/411pALeQgydbym+Obv+1NPBdrudyc6sD2AIyEIvFDcccyXTxyyNatZ4oU7+F6gLf
         f4b/ryqx3JqgAHwiYRCNQRK4if2OKEqdC0yhc2XRZ+i3vvmUZO7mmiIBH+7+raAiKWQn
         6oTotUZoIYzuuNI7Yv83/6Uk5V7R0iq13DUrgEbylFfJ1sy1HB9a6DXTlHYrFDKsPjAK
         +7TqQzMNdesJpClGRmBr81qdaQBEvvPK647VvOrXUN/jzCemyeIZOpYhuCKC8VQkpE7S
         YHXK8UcVJJwO7x5G9ArEaJYmYAyRi2fwQCk7V4Q2HjxLdcqkogtmIQWaJAaI83F3ndzB
         ja0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BmKV7oFN4iQWK0H2ANuyeOer2R1yN9d+6RLRtDWCvTg=;
        b=onpym3vWJBW0ecn1u+Rcy1W/ycWtIzxQAreWtbptD4zywF/ViNeGxypQ1O1tSt8lb6
         EoYMcvd8HUDKRKlwT3hrxDJRZnW5flq4eq10VOmDC9syLGwz+ZWM4pSRobQbWF9YwhrH
         H5tmU3ITIW5m8c4RfTX9YMkeQvOgYHLGc7loE+Ia/v+pgFur3cH8pbm68MdJXohFjFd3
         f2QIPN8SjAUJogmjclQo8ytBZlDm+nWYkSqxCBHdDv6kfF/xEFSYEYocpF2BDjAr0Adl
         f3ULTx3e5sZY2/kk+mGT4s2s6daWaamDolFx2noc6uq/YVNUmsZcRU/XhMorHxCzd8be
         Q1mg==
X-Gm-Message-State: ANhLgQ2Y7meIPNbq5zx7zL/J/s5KoKMpDoCEvoX64D+zQjoSTUNGaXTP
        0I9P2lX43R8EZDnbaC3+M2/sU1mQ
X-Google-Smtp-Source: ADFU+vu7v7GJy0yfYRyWybVj9xTqgfep8YGxMhmirfLjO0UsnNEJ/Si/jha2FSKxYbXxDGqC09jakg==
X-Received: by 2002:a17:906:c358:: with SMTP id ci24mr14227992ejb.128.1584169895625;
        Sat, 14 Mar 2020 00:11:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d9sm1459315ejc.79.2020.03.14.00.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 00:11:35 -0700 (PDT)
Message-Id: <9ab9a9d60371d0a54b2a8fc10512ad6d8daaad43.1584169893.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 14 Mar 2020 07:11:27 +0000
Subject: [PATCH 1/7] unpack-trees: fix minor typo in comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 1ecdab33040..0d0eec0221e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1618,7 +1618,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 		/*
 		 * Sparse checkout loop #2: set NEW_SKIP_WORKTREE on entries not in loop #1
-		 * If the will have NEW_SKIP_WORKTREE, also set CE_SKIP_WORKTREE
+		 * If they will have NEW_SKIP_WORKTREE, also set CE_SKIP_WORKTREE
 		 * so apply_sparse_checkout() won't attempt to remove it from worktree
 		 */
 		mark_new_skip_worktree(o->pl, &o->result,
-- 
gitgitgadget

