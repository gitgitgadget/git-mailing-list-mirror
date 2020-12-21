Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E72C433E6
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 07:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6448022CAE
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 07:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgLUH4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 02:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgLUH4J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 02:56:09 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4603C061285
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 23:55:26 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 23so21397761lfg.10
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 23:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yJuGbNSuJlFbRVMwTEnmZfnkL/pNquEGXEnLAN6tAE0=;
        b=A2u2s7l2IwLZF/bVb3nS2CDPPwJfccCad7ghUB+DDRAsVeTqWIlMV8LTPmxllo2/NS
         ZLa3xCP8OSV6Xgfx5f3DGlHtLMqW2sQdKu721yD5Uawkh2IxUYnDFvkNo3oFjmelg11P
         S+7/9NAQ7HI73v7sGza6JPlm+zj5cn0vnfU5HuD8dSG9dBT/yubJqrATTlgcPEnebq7N
         ixTK7vF6nW2Tbc3V0Biqu6yz3kPFuABUL2FEQnFIoNxuFf28UDqkJLow/xpI8yOgl16P
         4v44MLhNqESOdKlM3WPBBY/SSENAtzKpLRBrMAJCwPPaVucDDb9uwCp/9ZhrsbFGwQYl
         sfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yJuGbNSuJlFbRVMwTEnmZfnkL/pNquEGXEnLAN6tAE0=;
        b=T8P9Q+XQjLVRvBblEXH4wIKwvojQVeQuG1vFToPRqfXn6mRgrzQ8TJOhDQDS3BU2HA
         NecDZ8AsfrNL3hg7vLTHGF0amVFwteeH/dhJW2txyQq284Rb3Y4Jd11WYTBhHYtZOP0p
         LF0o1fLMuKvcZBrJOPT/NJGHlC+deVWzzs7YuK1ip7hkpBiRJNtaSGDPnfZJTLF535J9
         G6DwuKQtY9Sr+BlA7nO/4hm9iixaYx1snOHuV9tzdAHq9aThWa+iJIWQUeof0YvHGgv+
         FqaszGlpsWS8DcfDHWPUJvigF6Rbutsc3F7ySnh4r/kfViTOoZFrll+nBMDSCkUrEScy
         e0aA==
X-Gm-Message-State: AOAM530O2ZrZzAWP+Xkt/jzPgYTPh4wgFO799LVE0E643OniwLgjPi86
        1zmfQw0PmOgZNV3/6JoCUnU=
X-Google-Smtp-Source: ABdhPJysDdwPiUib2TEtcEJHUfIx+EMHBntUd1x/X/F2gyXVMKtNmQB82v2kkvlZh0+Zxf+H4teR5A==
X-Received: by 2002:a2e:98e:: with SMTP id 136mr7025534ljj.16.1608537325344;
        Sun, 20 Dec 2020 23:55:25 -0800 (PST)
Received: from localhost.localdomain (78-66-223-148-no2204.tbcn.telia.com. [78.66.223.148])
        by smtp.gmail.com with ESMTPSA id t20sm855663ljk.58.2020.12.20.23.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 23:55:24 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Ross Light <ross@zombiezen.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 2/2] pack-format.txt: document lengths at start of delta data
Date:   Mon, 21 Dec 2020 08:54:59 +0100
Message-Id: <c515a44179576db202c8b6d2419459df0e67ec0a.1608537234.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0.rc1
In-Reply-To: <cover.1608537234.git.martin.agren@gmail.com>
References: <CAEs=z9Pajgjnq56+umA+g9-NFv-Rzo9m5sa-7cow_byckLiJ0A@mail.gmail.com> <cover.1608537234.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We document the delta data as a set of instructions, but forget to
document the two lengths that precede those instructions: the length of
the base object and the length of the object to be reconstructed. Fix
this omission.

Reported-by: Ross Light <ross@zombiezen.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/technical/pack-format.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 42198de74c..05889a2e43 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -82,7 +82,10 @@ Ref-delta can also refer to an object outside the pack (i.e. the
 so-called "thin pack"). When stored on disk however, the pack should
 be self contained to avoid cyclic dependency.
 
-The delta data is a sequence of instructions to reconstruct an object
+The delta data starts with the length of the base object and the
+length of the object to be reconstructed. These lengths are
+encoded as varints.  The remainder of
+the delta data is a sequence of instructions to reconstruct the object
 from the base object. If the base object is deltified, it must be
 converted to canonical form first. Each instruction appends more and
 more data to the target object until it's complete. There are two
-- 
2.30.0.rc1

