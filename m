Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FF7C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 16:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjDXQuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjDXQuu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 12:50:50 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9C96E98
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:47 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6a5f21a231eso3307619a34.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682355046; x=1684947046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcvgWFXKvgw9IRDZJw9QoZqVIf+9jTj1q270nYCiN5E=;
        b=lpuP7VA7zFrGm2TwDj19Bm9X0sUMfzCH6dOBaCRyUKvIJaqDAw1TnCj/AXMFNePtD9
         xOrluVmglUOPWyjujYnIr3S/Y89MjUUSHXgBxKqa+9xkwnnZ8ZgBu+NAqgVUGmu4oR6q
         AjBRyE0zeDQjXeFS11o1LD4lkscoUigA8CbrhPjopGgxpW8i5COiTQopKsbWGgUw7vbG
         ggxlaWGlQ7oszhC66WNUoOkfoLvb7sgRC5pGeN2gij6scw9mSeTlZY119vmRfext0/qR
         ud6adXR9C/3xzvQg3OqUcDxkR1SrHB65Wq2bxAahKHcPETL6AKZwoumUZscUWmfYh9UZ
         7Bxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355046; x=1684947046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcvgWFXKvgw9IRDZJw9QoZqVIf+9jTj1q270nYCiN5E=;
        b=iobmwqFxnFbA/E8f0SJGJlPb/PFytF8qeBOBv6qgpJgIc72yfx0xvY54i+doNwHdkV
         PlATBsn5EPsYDx67N8IF8cdEYV9L9dknW82Rsy4RyvT/eFLRf9yZAzTzV3QEshRLvr28
         GNItuqlQ40purZbDnw8vxCgR6L7SPaeJMHsk65F5LG9J6I47lhejQi6cGbK1iff+9vRv
         QDJR4JKbarjwRhOX3AH/GRcNZLgiahcyKlMyvzvhqvkL8BGC6zvx10p3Ze9QrfMTy9Dp
         RJtkIproSv7RXftDzd5NvkOBJFdYwt4/Vv+2KnZpgmcEZisYUdeZuyLsuscbcjrIUwrO
         epHQ==
X-Gm-Message-State: AAQBX9ce//WY9rfuXTyp3jdsygnpHVPWlSNRXSd0lDpDcRftgK0Nl0G4
        dmfHgmF+h5PmKvsv27LjeluvjuSTwHw=
X-Google-Smtp-Source: AKy350Yf8qMGlNarxVevKXKQ8CDQOqg5fdIq5Kcq1qAI2Y+i3+INVIZl96TpEhSYR4K0JDboNEpuaw==
X-Received: by 2002:a9d:5c08:0:b0:6a3:4e22:2bd with SMTP id o8-20020a9d5c08000000b006a34e2202bdmr7017438otk.5.1682355046583;
        Mon, 24 Apr 2023 09:50:46 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id n20-20020a9d64d4000000b006a5fae26f18sm4745677otl.39.2023.04.24.09.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:50:46 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 03/15] version-gen: refactor default version
Date:   Mon, 24 Apr 2023 10:50:29 -0600
Message-Id: <20230424165041.25180-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230424165041.25180-1-felipe.contreras@gmail.com>
References: <20230424165041.25180-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not clear how `cat version` might fail, but either way if VN is
empty (or unset), assign the default value.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 6dd7683ee7..0d00fa3d9a 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -25,14 +25,14 @@ describe () {
 # then try `git describe`, then default.
 if test -f version
 then
-	VN=$(cat version) || VN="$DEF_VER"
+	VN=$(cat version)
 elif test -d "${GIT_DIR:-.git}" -o -f .git && describe
 then
 	VN=$(echo "$VN" | sed -e 's/-/./g')
-else
-	VN="$DEF_VER"
 fi
 
+: "${VN:=$DEF_VER}"
+
 VN=$(expr "$VN" : 'v*\(.*\)')
 
 if test -r $GVF
-- 
2.40.0+fc1

