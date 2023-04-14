Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD230C77B72
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 12:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjDNMTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjDNMTC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 08:19:02 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E679BAD36
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:18:52 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id c17-20020a4aa4d1000000b005418821052aso3644765oom.6
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681474732; x=1684066732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUueyUODtySalWhFKFLZhvq4KkQvjtEEmGE0WXCL7KQ=;
        b=btDIBS+ZEthug9vhWe74DGi+iK8Cd+BvqsyxIRQVAZJ2VhRRElc84fpeTbXLDpSXs8
         nn8lYnYAvC2YC93Q3X/CmtcQkLDAdT8dT5u/U8KhYldoS4+6gB3KIpSMKmzXL3z7ROia
         FND6IeR0BE9nvCd0vxGN5P3qy7arA6V0rRYic+QbUUK5HftMEKjJJdcVWG5KAXwm9s6j
         KcLgFmmSFhAtUmWRyD/yUARvahStUnNy4n1/N0+xSpvE4DsckK2pNtDcuhn/65KYcmDq
         I+6xLms9XKHeIJcWAysafSjq9a9GwTZitCZp2QXQPWIsZO92NWlDyWcHQ062cBtrhMiG
         qp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474732; x=1684066732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUueyUODtySalWhFKFLZhvq4KkQvjtEEmGE0WXCL7KQ=;
        b=AY/SZRo+9iNXU/CybmN3quY1Lmj7n/sGrALNGd6XQpj/dXCrbREC5Ya92fjLYhzwJq
         JjmjOOOAAU4YCWX3WHvAXBErRhDvAUPTbe8DSOL+TElfxjfiDo16IXalCjvWnnB44FTF
         2vKZvWi3GpKa7d21n49uJfrY9I5AgkHwYD9jewlDHB3rMVtYr9VDbS+RdseZimVVk1fv
         sOIT26sinxA34EbPNuHT2/T56aFm1ySpe8XsgR0vKBi8bvpdXHNAGe3akVBmZgSBpG62
         ttZgtNfAP9wBIDpz32hFPUWT+UNsBri1bjHCOLL0tOZ/CFCleYsOs0Aw+nL07PBX54Lp
         ewKA==
X-Gm-Message-State: AAQBX9fm6qVCuAnrQokavifWWntvkOyvfm1y72esfZKxHdH8qp3X5fFa
        LLyGOBUJ0FbKwi7cC3j8/eb5DhFJqQ8=
X-Google-Smtp-Source: AKy350bqjT/C73LCBF+U5EMayWxuLv2zw8btuyYNlWDuxpWUPq4HKAw2jZGBlpDT9kJQVSaJVG9NbA==
X-Received: by 2002:a4a:3711:0:b0:525:58f7:cbef with SMTP id r17-20020a4a3711000000b0052558f7cbefmr2409266oor.2.1681474731917;
        Fri, 14 Apr 2023 05:18:51 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id r7-20020a4a83c7000000b0054156478f2esm1596952oog.44.2023.04.14.05.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:18:51 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 06/18] version-gen: remove redundant check
Date:   Fri, 14 Apr 2023 06:18:29 -0600
Message-Id: <20230414121841.373980-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230414121841.373980-1-felipe.contreras@gmail.com>
References: <20230414121841.373980-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we are not in a git repository `git describe` will fail anyway.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 34f561752b..cd94a7902e 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -26,7 +26,7 @@ describe () {
 if test -f version
 then
 	VN=$(cat version)
-elif test -d "${GIT_DIR:-.git}" -o -f .git && describe
+elif describe
 then
 	VN=$(echo "$VN" | sed -e 's/-/./g')
 fi
-- 
2.40.0+fc1

