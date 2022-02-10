Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537DBC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244333AbiBJQxT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:53:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244866AbiBJQxL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:53:11 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3B5D4
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:53:11 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so9139310pja.3
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=etofKodDojo5k56w9YVj46WrHjH+bCKqyIY88Q0Que8=;
        b=jd5BmsjmmeTC+lODDLP/wkBCAQcrK2R8+I6TXyECL1vwtkZrYmUac1XnMDm2PWfCDL
         p5beoPl0+VhdjS8lGSE/b0heJGx1reDR2MOkinO6Ydz3vGhcJFqqx2iJQtg76bqbhHOR
         r81Jp2RS9qOwholyqlIa+WV6JUqt+FeLv8f+cOmBBdUt4g5wllvmTubLeAgLkuRMu3Li
         lUv3PxHOr6HZM5pliE8+EZ8uTtLfJogv6j35Xxx9qfNkbXGboh5/XMp8F9+SQhHVnlic
         HZjz7VbFVISk7am12BbJoPcN8XtsPeekKpB9PSybBQRKkwcJWYGOcH18jp9FPthJm4rn
         OycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=etofKodDojo5k56w9YVj46WrHjH+bCKqyIY88Q0Que8=;
        b=PLYddSvJwkGiCghoCAHjkzUVpgm+dYRJOHwMdBl+LoAvsfRAvgffYy2jJm7t3kLdPH
         hZo/61r8QpdcJa4DThuUyY3dMEPHkE79OIao5kVx0jpXwLpvipvxThz8bVad6L4PZ3aA
         NyQst5kyaQiDgL/HF08nQeqcz7IBba9IeatXBPYPvmhr6Y3T4/AkF+82lQFlfNtmFcEc
         Ze7e4Ehanu96YsptahFpTFdaj9G0CWXKayxOaYmpTTIycwRQ2XFimHEaN3nHRx+s1BRc
         uTFIvNaIP6oB4ILtP+sJ9JYaTcAZbA1eg342c/PM4cUDi/qj08LAcVyVxX33tAmq2Trv
         g13A==
X-Gm-Message-State: AOAM5303yIBPzlxuyGhrQANWvUHQM62EfHYosuFZ2CAcN7PbtznJcAXm
        1t0nQDO4Moqx7gU7THMAH4Py0B5JpZw=
X-Google-Smtp-Source: ABdhPJxk2uQxHXZW0Nu+x/A+aexWgPyby4KOj5s7NYeKkIrRaWpJOGBQyI/LclmJa/R9pPAw10JfDA==
X-Received: by 2002:a17:902:a512:: with SMTP id s18mr8072990plq.51.1644511991032;
        Thu, 10 Feb 2022 08:53:11 -0800 (PST)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id c17sm25614840pfv.68.2022.02.10.08.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 08:53:10 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, paulus@ozlabs.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2 4/4] gitk: pass --no-graph to `git log`
Date:   Thu, 10 Feb 2022 09:52:09 -0700
Message-Id: <20220210165209.310930-4-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.32.0.2645.gc109162a1f
In-Reply-To: <20220210165209.310930-1-alexhenrie24@gmail.com>
References: <20220210165209.310930-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
v2: use --no-graph instead of log.graph=false
---
 gitk-git/gitk | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 23d9dd1fe0..24099ce0b8 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -411,8 +411,8 @@ proc start_rev_list {view} {
     }
 
     if {[catch {
-        set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
-                        --parents --boundary $args "--" $files] r]
+        set fd [open [concat | git log --no-color --no-graph -z --pretty=raw \
+                        $show_notes --parents --boundary $args "--" $files] r]
     } err]} {
         error_popup "[mc "Error executing git log:"] $err"
         return 0
@@ -559,8 +559,9 @@ proc updatecommits {} {
         set args $vorigargs($view)
     }
     if {[catch {
-        set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
-                        --parents --boundary $args "--" $vfilelimit($view)] r]
+        set fd [open [concat | git log --no-color --no-graph -z --pretty=raw
+                        $show_notes --parents --boundary $args "--"
+                        $vfilelimit($view)] r]
     } err]} {
         error_popup "[mc "Error executing git log:"] $err"
         return
-- 
2.32.0.2645.gc109162a1f

