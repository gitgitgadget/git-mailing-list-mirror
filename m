Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3CAC32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 12:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbiHWMvu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 08:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348407AbiHWMvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 08:51:16 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC00119446
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 02:57:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bj12so9311846ejb.13
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 02:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=MlFpwxxjHRLxXzOJpcdZBVusIVNWLuR9CIh+aBaYEzY=;
        b=P8VeGKmAK5l50YBJW8ydLgR8TsWS2oPi3a4ufQCr8hT6PdjiNmSgH6Ryf+02OAzt2U
         daVzqk/FbfMmaiWuta9zCCScjGpfWc4BSXCyLXO47k9qHTmLRY/Gp7sDjRTFKbaLXZMB
         z8FRQz63CHJdwgp4PtTNz8p0czXILigWijRgpz6INF36y/fQLci/1aodIlCo2x+0/IYo
         FrPEyKG35pBTAMcQCOb7YeDGiN4mCgDzWcTYVOxDFgrNuijtbv4GpwJlrVCNhMKxysXo
         wwE9+xlTgYrNGdrzop1pE/FW3m5apcjjJylxx7FNEypqc837L4G+VSCN2yMhmrvNwl+I
         nxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MlFpwxxjHRLxXzOJpcdZBVusIVNWLuR9CIh+aBaYEzY=;
        b=xBlFJuMzHmXip7n2MCrlPEEuCUCYu0UU+EMUjfwa+u1KlafZh/+9MEwhzTYQusm7Ey
         KED2HJEdhyv4iFaJ0DRU5i03F6ky3CO7oxAoNZd34DWbXHEmNVf1VRJNac8U2mez7SvD
         6yie/RT3vdhuxBjqTvnuGCl//qkLiOpo4jB3BCQoFYUXWj4c4JG1xJQQ8kREikg+vYiX
         K+ng4gBMWXyhkSFn55xun6ruE/jOf5ItFr8MkEWDU5byKcESVQfEzTL0n33pP47GuRtu
         R3LeZ1MP5X3lEK5TKcg28y2ptzMIWoEP0VmoWggxCs3gvRV8kuwN6T3t4bd6FBmCCT4o
         Mk3w==
X-Gm-Message-State: ACgBeo1fRRRg/KFCqW8ATaiuHgWtkzzQ7oTgs8pmWToQfwwj4WuaD5EC
        ZDSdNDXoH+sA4vOXFHxnbL7PVOlzmIs=
X-Google-Smtp-Source: AA6agR6os9S+kxaBwPgUDSaCRNvcPJxTUUxJZTsIWts5mI2Ubit8S2AGcE6LRmvNOJmJNzlkfn99CA==
X-Received: by 2002:a17:907:97d3:b0:73d:8b9b:a6c1 with SMTP id js19-20020a17090797d300b0073d8b9ba6c1mr4373137ejc.71.1661248656618;
        Tue, 23 Aug 2022 02:57:36 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id e12-20020a056402330c00b00445f2dc2901sm1169794eda.21.2022.08.23.02.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 02:57:36 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2] promisor-remote: fix xcalloc() argument order
Date:   Tue, 23 Aug 2022 11:57:33 +0200
Message-Id: <20220823095733.58685-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.2.880.g3b8fb2ce68
In-Reply-To: <20220822213408.662482-1-szeder.dev@gmail.com>
References: <20220822213408.662482-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass the number of elements first and their size second, as expected
by xcalloc().

Patch generated with:

  make SPATCH_FLAGS=--recursive-includes contrib/coccinelle/xcalloc.cocci.patch

Our default SPATCH_FLAGS ('--all-includes') doesn't catch this
transformation by default, unless used in combination with a large-ish
SPATCH_BATCH_SIZE which happens to put 'promisor-remote.c' with a file
that includes 'repository.h' directly in the same batch.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 promisor-remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 5b33f88bca..68f46f5ec7 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -146,7 +146,7 @@ static void promisor_remote_init(struct repository *r)
 	if (r->promisor_remote_config)
 		return;
 	config = r->promisor_remote_config =
-		xcalloc(sizeof(*r->promisor_remote_config), 1);
+		xcalloc(1, sizeof(*r->promisor_remote_config));
 	config->promisors_tail = &config->promisors;
 
 	repo_config(r, promisor_remote_config, config);
-- 
2.37.2.880.g3b8fb2ce68

