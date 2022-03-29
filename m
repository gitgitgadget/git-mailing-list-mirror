Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA57C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 21:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbiC2Vnm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 17:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbiC2Vnl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 17:43:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7FF33A04
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 14:41:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w21so22098789wra.2
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 14:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=2xpiptwmzojAVGUaiUw0ZTzSR3uqDG9Bv5FhHpC/jpw=;
        b=dCJ20XzIFFSHxhEhgCfERyqXEP1E8l8vrQ0D721n7oEWp3XEe6huqP4TV+pp4q+ezi
         Ll8Xr/CUpBG/7FtBA62J5S0aW+LX5ux7CzUHwnUQE5HeuHq43P98kUgTpnEg/IsAn8Jm
         Sa4mZuUwAF3TFmkgyk79hfK56JNE4DP0DRDnqc2GTfq7B95JUNxrYe1KaO+vW6+WieKp
         E7sEqpjvSS+DbGdVWJI1ep51hbsWYFrHNWhBlaXWs/LJVpr4D1MbBVUpbbPfsN0iYpYl
         ylwrbyd9DE7qovKDkikW2eUY7ZWde7mYV6aPaVUnTQChX2PFCn2xjVkn7xhuXTEPqu49
         qhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2xpiptwmzojAVGUaiUw0ZTzSR3uqDG9Bv5FhHpC/jpw=;
        b=5DbAjcGjpKu6Izd1RUxqi1sasGGO/Ieh8TZGb9+hzGyWB6lXGrO/HTAt/v9AlJiCIe
         qn0Cd6io8cPcVxcedzmUYvCdomeidIvFSxuN4Dy0k3pLhnOt878/05/JJjFNtkmw59AR
         FIegBg8ZGrgpAoIKL6vhP5Eg1xSL/YGPO8XuVTVp8gpDVibA0nG5ySiMxkOXzN3ZJFEA
         7WK4a3d4ye5nbVliylv8H3PVgbGdh0/Vz/XFvQv8jZudqDImLam3GFzPMZfFQncZ2we0
         cfMlP6CmHmc0eZpbHYfcKZE3OmTIQk+dMJHhdbwmORJ5SGhceTuV9u5O6lidHqNXiP6i
         KQJQ==
X-Gm-Message-State: AOAM530WUN3SAcZED76uzh8gIGq11cDxhoB+7Ogm3kU8bHCCQ2XqxexK
        aCviykZo5uGql3fUrH7ivQ2JqmUu2Ac=
X-Google-Smtp-Source: ABdhPJwSX+lGal74Hjzj/ba4M63Rq4rMNrLGI9lePU/qVvSlMwzBxcHn/LGiS+jcPEemigcCggJg+w==
X-Received: by 2002:a5d:65c5:0:b0:203:dcc9:546c with SMTP id e5-20020a5d65c5000000b00203dcc9546cmr33665386wrw.130.1648590114255;
        Tue, 29 Mar 2022 14:41:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037bb8df81a2sm3986907wmp.13.2022.03.29.14.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 14:41:53 -0700 (PDT)
Message-Id: <pull.1191.git.1648590113062.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 21:41:52 +0000
Subject: [PATCH] core.fsync: fix incorrect expression for default
 configuration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Commit b9f5d0358d2e882 introduced an incorrect value for
FSYNC_COMPONENTS_DEFAULT. We need an AND-NOT rather than
OR-NOT.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
    core.fsync: fix incorrect expression for default configuration
    
    Commit b9f5d0358d2e882 introduced an incorrect value for
    FSYNC_COMPONENTS_DEFAULT. We need an AND-NOT rather than OR-NOT.
    
    Signed-off-by: Neeraj Singh neerajsi@microsoft.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1191%2Fneerajsi-msft%2Fns%2Ffix-fsync-default-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1191/neerajsi-msft/ns/fix-fsync-default-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1191

 cache.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index ef7d34b7a09..ee9549c4601 100644
--- a/cache.h
+++ b/cache.h
@@ -1014,8 +1014,8 @@ enum fsync_component {
 #define FSYNC_COMPONENTS_DERIVED_METADATA (FSYNC_COMPONENT_PACK_METADATA | \
 					   FSYNC_COMPONENT_COMMIT_GRAPH)
 
-#define FSYNC_COMPONENTS_DEFAULT (FSYNC_COMPONENTS_OBJECTS | \
-				  FSYNC_COMPONENTS_DERIVED_METADATA | \
+#define FSYNC_COMPONENTS_DEFAULT ((FSYNC_COMPONENTS_OBJECTS | \
+				   FSYNC_COMPONENTS_DERIVED_METADATA) & \
 				  ~FSYNC_COMPONENT_LOOSE_OBJECT)
 
 #define FSYNC_COMPONENTS_COMMITTED (FSYNC_COMPONENTS_OBJECTS | \

base-commit: 1d4f13e63720fb8eae39afa215199f7d77662dba
-- 
gitgitgadget
