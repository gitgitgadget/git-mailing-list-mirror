Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7626C77B77
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 12:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjDNMTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjDNMTH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 08:19:07 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC4BAF0F
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:18:58 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id l13-20020a0568302b0d00b006a416ec44ccso4553802otv.2
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681474738; x=1684066738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTAA+7jqrJLO/wanC1ao9XXl8TbjsexwwaouOz/Yq2E=;
        b=slL4g13W2dSh5Ffj40+4HvR1T2oTJFBCSuguc4Haso93Ogc2wWJkR8PECdTx+lvF70
         kSEFKMgGnYiQffin6uxleeUAGpEho3xYgFEsVSqSXAXR0iSxReYyFKt43CRGA9guqVhJ
         QpkhnEAQbj9J61+w8LVqvK9trpPIGY/ywD7SU43piE+5qgjmts3J5V5YVM0C2j6lzpBh
         FPmhU6jBHppAx9wL6T9NdZXR3wjapdPreeYKOBYgCehCL9TcG3U60BuHgPslaTaMaoMH
         U39ioPt10/IR1nJ6+sgLLOps+WbVv+hdk6C/7qM4wJ+jZbVvr+eYb/siyKG2bdzfqAl+
         Op1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474738; x=1684066738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTAA+7jqrJLO/wanC1ao9XXl8TbjsexwwaouOz/Yq2E=;
        b=fUEYz47c7Jdl0jC8H2qy4LmDZW4obDEnKGG3NiXDVQ2R+sq6l4AgNO7oCKd5xVuZub
         KCVWH+Zo+XFNUUKQ7Qli+g/L/S5JO+YNBGJ6WmCYetvjf9TFN4rERF299+vfFPHmdggz
         GOcbrZy/fplOEeSaW7g1f9fpog2sWEItXeY7jQ/MCe6PXgccp+2aKbHWp6uxiKrS3X0g
         jQF8xBRgQyj5TM5+Z4jQ2Lc6GKgI88BB2xZUnCAuIRZhnBQamh2EROPJrYK3rCQUldnS
         97E87d+d6/NowCnSA7/LPJ5ez6At/Gfy+BTWfoX1z0WT65AMZDlG65NBABvOjU0NAgS2
         jigQ==
X-Gm-Message-State: AAQBX9cv2+tkb4VkRPdRdO7rrrolnaG0HbyEEtKqqeSqyWGfVEOAW+Ob
        8x3AiVyg1iHp+X0H0pALT1DQ4t6pUGU=
X-Google-Smtp-Source: AKy350baQMkWZRyYnegJ2gwTtp5fWEOlgNPNO1osYqvW6nLJKqxoGzkSZDf9kGOOA9eJbjr70wsOOA==
X-Received: by 2002:a9d:68cd:0:b0:690:bf1e:9eef with SMTP id i13-20020a9d68cd000000b00690bf1e9eefmr2873413oto.21.1681474737903;
        Fri, 14 Apr 2023 05:18:57 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id z18-20020a9d62d2000000b0069df7242a08sm1664988otk.26.2023.04.14.05.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:18:57 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 09/18] version-gen: move describe fix into function
Date:   Fri, 14 Apr 2023 06:18:32 -0600
Message-Id: <20230414121841.373980-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230414121841.373980-1-felipe.contreras@gmail.com>
References: <20230414121841.373980-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 9be9e14204..b7d2b8758e 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -5,6 +5,7 @@ DEF_VER=v2.40.GIT
 
 describe () {
 	VN=$(git describe --match "v[0-9]*" --dirty 2>/dev/null) || return 1
+	VN=$(echo "$VN" | sed -e 's/-/./g')
 }
 
 # First see if there is a version file (included in release tarballs),
@@ -12,9 +13,8 @@ describe () {
 if test -f version
 then
 	VN=$(cat version)
-elif describe
-then
-	VN=$(echo "$VN" | sed -e 's/-/./g')
+else
+	describe
 fi
 
 : "${VN:=$DEF_VER}"
-- 
2.40.0+fc1

