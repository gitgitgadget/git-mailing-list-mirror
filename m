Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846B3C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiCUXKl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbiCUXIO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:08:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0924D279
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v130-20020a1cac88000000b00389d0a5c511so407734wme.5
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HWFQNaLQ1qGE9NzpNiAvS9tCCHxkA3GqlMctd4rLrSA=;
        b=RYilpVycFOjK8Yh46GZ+k9WLM1+IfXHyD4UWxkSsDzHfCtwudRpssnJd2UaAPdloRX
         lhsrE/jwzX+MIAKuj4DqJsaHJOFDwqLCD6BTkthOvGoT7dh6vInAQx5eFFvDviBFJtar
         hrE2VgylIfZkMLTRm+fLR5rAUtEduEq8nh2XCM5Jo5k7asmScfb+RmvHAIJgLOArKRy4
         m6lWyLhflrsXF7XoAEMl543VjXDYw+XFEuyl543xbxenme+Tw9kF+vY34TFskG33NcCQ
         UqUFOjy/dRugeQPiO/Mo0GLMZkPweWwoFpR8a+mV93ix+So+N7gJA61GfqMuoxPPzwg9
         HcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HWFQNaLQ1qGE9NzpNiAvS9tCCHxkA3GqlMctd4rLrSA=;
        b=Rn1VHcutX+i/zN7U59h5h0LT8c/A2EY2uT1s8bddvAkB3U6f5xFrOgDdYbeOAbnAZO
         HNdWXUGhjpefAadWcrx0SersRyHKHyTsrFaVm2Tav/UNjWDWlmh0FlpEmNG49XtG/Z4D
         1M53tCST9kT55lyTA/dSqQOp6mLK6UZGo08azDZwIkIZIrA9Mubl0IrSyE2Duw1UAXNS
         xgcnLlaGJjaM22m+XIq2Gb0eBtPcsVwKslH9obAbr8e4kChd3vQc3ifKaogJJfFDDdGY
         7Rufxj9I4MF6KTG8HR9HdecrvTt0m/UOtA6h1MtfXitXFQNSXYMFcHQvY0OTyG1UNBkC
         f03A==
X-Gm-Message-State: AOAM531KGO7xhv1LVxAuQflkFtJik/RuYiPVXgn8FAu37/zItFuKBcfK
        o6bpMVBWsmkypLO9FMr3oTKi6BsldfA=
X-Google-Smtp-Source: ABdhPJyJ4vmdpoReMwk1sqx8N+a0Yn8sl5xuAQchzsRHA9FKIwvrv1Y5q8Q1mzwGQUw8ddMSetb9zQ==
X-Received: by 2002:a05:600c:4f82:b0:38c:9185:1ecd with SMTP id n2-20020a05600c4f8200b0038c91851ecdmr1127121wmq.130.1647903379961;
        Mon, 21 Mar 2022 15:56:19 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:56:19 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 41/41] exit.cocci: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:23 +0000
Message-Id: <20220321225523.724509-42-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321225523.724509-1-gitter.spiros@gmail.com>
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C standard specifies two constants, EXIT_SUCCESS and  EXIT_FAILURE, that may
be  passed  to exit() to indicate successful or unsuccessful termination,
respectively. The value of status in exit(status) may be EXIT_SUCCESS,
EXIT_FAILURE, or any other value, though only the least significant 8 bits (that
is, status & 0377) shall be available to a waiting parent proces. So exit(-1)
return 255.

Add a coccinelle semantic patch for using the C standard EXIT_SUCCESS and
EXIT_FAILURE to indicate the program exit status instead of "0" or "1",
respectively. In <stdlib.h> EXIT_FAILURE has the value "1": use EXIT_FAILURE
even if the program uses exit(-1), ie 255, for consistency.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 contrib/coccinelle/exit.cocci | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 contrib/coccinelle/exit.cocci

diff --git a/contrib/coccinelle/exit.cocci b/contrib/coccinelle/exit.cocci
new file mode 100644
index 0000000000..ea5c243061
--- /dev/null
+++ b/contrib/coccinelle/exit.cocci
@@ -0,0 +1,24 @@
+@@
+@@
+- exit(0);
++ exit(EXIT_SUCCESS);
+@@
+@@
+- _exit(0);
++ _exit(EXIT_SUCCESS);
+@@
+@@
+- exit(1);
++ exit(EXIT_FAILURE);
+@@
+@@
+- _exit(1);
++ _exit(EXIT_FAILURE);
+@@
+@@
+- exit(-1);
++ exit(EXIT_FAILURE);
+@@
+@@
+- _exit(-1);
++ _exit(EXIT_FAILURE);
-- 
2.35.1

