Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F569C433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 16:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbiBIQYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 11:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236769AbiBIQYD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 11:24:03 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0A7C061355
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 08:24:06 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id om7so2562047pjb.5
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 08:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SS0ppGDfFOdC/Jsvq0hCSExqKKFnA9CkNszVxR/ngdQ=;
        b=d4KKH2YvODjnLfnvMGUcedACTfoDqoDuZ40AfC6lCX2deVgaQXneWm2DqQcX8J39F1
         MUHolXD+wMzNXKx4xPsV4r1ZcfyvvjpD+wbxEfL1z+ae+iADA6FTYQuQN12DuZucyU3X
         /qF+N9+RdQQWHkFBxnjb4GFnzxuC8gsnfjDU7RwOoQMwrEc7CMgFlT7dHBrfvvyK0Fv5
         IPZhSpzDSsljonzJGWaw8YhfD/7NsQDx7SKGYFbhX9UuiPwL/QW73Uolona3PJHuSe13
         gF9o8NclIcY5rN2xz6FnRhAH+BmvyKYaKnJhnMDynEqX7sZiuPE2yiqAVqdZn/6KauO4
         Hs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SS0ppGDfFOdC/Jsvq0hCSExqKKFnA9CkNszVxR/ngdQ=;
        b=SSPQIcvtBmEYhvVS3VpnHB+2nepj3bA1TGYOTx05nUypLPNJywHXI45E5d0qg5Hg6M
         7d1hMchtHiWGNI+spdiFPdN6z7Nq7pCmpE1Wo1QjxImUgZ+IJP3/OnmzAdmqtr2HXW8L
         BgDG4aBDCnzwSKnBcLm3+ZCYIDzGczg3ot54/Shz1wXdEYUtViQ/FAko50xa2CCbbEx5
         /P7XVt00XiihZ6GcE0mYrSzes4fiVkmjlFz3P+ti/HzA4mUgjhiEcAklnf5dtUw+s4+/
         c39DGpAi6h17P9uHjRXodRxQ0nsaZA9LLyaduy3zMg6Bb9I3elK1a7+CobFVvfZjLYKs
         LKPg==
X-Gm-Message-State: AOAM532wUQush96cVMxFd/7hl6+7kAlYxBPWZVNhGhNjlSDAx7LoiDtU
        qLxaK05mli4DIt/pEHpx2DybUVE8iHI=
X-Google-Smtp-Source: ABdhPJxxnXELdabkm1uE/r2jdtZmFSIoiSHDx9NvaYiD3nISc9LWez9GpSA7rOSt7sdYFpaw7YNmgw==
X-Received: by 2002:a17:90b:4a4b:: with SMTP id lb11mr3344696pjb.144.1644423846055;
        Wed, 09 Feb 2022 08:24:06 -0800 (PST)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id u12sm21504246pfk.220.2022.02.09.08.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:24:05 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, paulus@ozlabs.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH 3/3] gitk: set log.graph=false when running `git log`
Date:   Wed,  9 Feb 2022 09:23:49 -0700
Message-Id: <20220209162350.169971-3-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.32.0.2645.gc109162a1f
In-Reply-To: <20220209162350.169971-1-alexhenrie24@gmail.com>
References: <20220209162350.169971-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 gitk-git/gitk | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 23d9dd1fe0..1d8a5ff622 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -411,8 +411,9 @@ proc start_rev_list {view} {
     }
 
     if {[catch {
-        set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
-                        --parents --boundary $args "--" $files] r]
+        set fd [open [concat | git -c log.graph=false log --no-color -z \
+                        --pretty=raw $show_notes --parents --boundary $args \
+                        "--" $files] r]
     } err]} {
         error_popup "[mc "Error executing git log:"] $err"
         return 0
@@ -559,8 +560,9 @@ proc updatecommits {} {
         set args $vorigargs($view)
     }
     if {[catch {
-        set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
-                        --parents --boundary $args "--" $vfilelimit($view)] r]
+        set fd [open [concat | git -c log.graph=false log --no-color -z \
+                        --pretty=raw $show_notes --parents --boundary $args \
+                        "--" $vfilelimit($view)] r]
     } err]} {
         error_popup "[mc "Error executing git log:"] $err"
         return
-- 
2.32.0.2645.gc109162a1f

