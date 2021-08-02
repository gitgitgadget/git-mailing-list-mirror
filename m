Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB29C432BE
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 19:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C609610FF
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 19:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhHBTBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 15:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhHBTBp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 15:01:45 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F7BC06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 12:01:34 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id s11so9384947qvz.7
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 12:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aE+J6qWLnxO1x5bHSMmdBpA6gMUIZ7Head26KyK6tFU=;
        b=RwqA3yn61b3kbQUXrSM/IIp4o1bOPRAxt6ufosbqXFsVx6b7S2kQgM/CITu1ruSYZK
         4wEpEenzFmGoFXjmejK5B09+06w6aXTLu90uSEvT40OMnttIlX5HniHPAXi79eGJla6A
         ZXnqH18pPCEBAAe9TcGWgmn5Q1fyeL/GlFrme4/khAD53SMnT0vXcEfBBLPYX96C6bRd
         dCu6xZeqU+SUVvz1T0tC1/JzabMqu9t6JrQ0OWFmD5gBOUd+w5Bjgs6bA/g+O693erY9
         NNTvNVpM0/qBnyXkFasN4P+QVo1SQbKV/9NUb/phg+0FLw9KGxyy/aIKUf7l4Y1EpxRz
         FDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aE+J6qWLnxO1x5bHSMmdBpA6gMUIZ7Head26KyK6tFU=;
        b=tDh0A2LwGzFgfUARIk5gUk7r3a9a04x8bEpVTFOGgxKCcubk66dJLC/id1MFn1Qw28
         ruqZuteKmiqfvJG+0GlJNyE4mgps+6BQ6Ot1f6diC17Tj1DJwr7tGP/SII+yFWyfCZY8
         XBEKoaFJciDh/6z+zD7QeZ2Z/SQxDxcJ+DMYFv68JaqRxuszaUnLkQp/Ad/kFvN/TxL1
         KEBw9je0ceyil9lDdj3RQBIcX7617+acPRt3ZaodFW6VDIl4iiXkRTpqth4MUQvKXVFB
         edOlVtOnIhOJ+O+L7/Wh+c7uX/xOvw4zwq5rke4z0gkI0GdWvPlSBpQr6TZltp9Lf+it
         jPAA==
X-Gm-Message-State: AOAM531HPwaXYD7152lGL04yH5TmJEfEHKpgfyHI4f8Qc74Qim9JW0MN
        TG4C1WC2f6jGasqytrba98Y2UbE3K6c=
X-Google-Smtp-Source: ABdhPJwcNN7DbqKrOA9/YR4VQ4cb6eZmFk0AdP2QfdoYzvuLRsJXUOStYxzwrGLvXKqIMm89G6UiKQ==
X-Received: by 2002:a0c:e6a4:: with SMTP id j4mr17811304qvn.16.1627930893508;
        Mon, 02 Aug 2021 12:01:33 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id b21sm4949885qtb.58.2021.08.02.12.01.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Aug 2021 12:01:33 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 2/3] reftable: clarify zlib version dependency
Date:   Mon,  2 Aug 2021 12:00:53 -0700
Message-Id: <20210802190054.58282-3-carenas@gmail.com>
X-Mailer: git-send-email 2.32.0.826.g286871f41a
In-Reply-To: <20210802190054.58282-1-carenas@gmail.com>
References: <20210802190054.58282-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

3541411189 (reftable: reading/writing blocks, 2021-07-20) add a comment
explaining that a newer zlib version is required but being a little vague
about the specifics

make sure the zlib version is mentioned to aid on deciding to enable or
not the NO_UNCOMPRESS2 compatibility layer

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
Squashing this as part of a reroll of hn/reftable might be preferable

 reftable/block.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/reftable/block.c b/reftable/block.c
index 92f8e5abfa..eb5268dd3a 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -16,7 +16,9 @@ license that can be found in the LICENSE file or at
 #include <zlib.h>
 
 #ifdef NO_UNCOMPRESS2
-/* This is uncompress2, which is only available in zlib as of 2017.
+/*
+ * This is uncompress2, which is only available in zlib >= 1.2.9
+ * (released as of early 2017)
  */
 int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
 		uLong *sourceLen);
-- 
2.32.0.826.g286871f41a

