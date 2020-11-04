Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99D6C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 01:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8524B223EA
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 01:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7BeUp7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbgKDBJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 20:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729144AbgKDBJg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 20:09:36 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D75C040203
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 17:09:36 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w65so15910525pfd.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 17:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YACmgmRxBGBnGnasXJxedtzIEWJwMVzobcXYqQ83U/U=;
        b=M7BeUp7XVpRtimL066nWA7NQdRAgVigCFhVN0WANTHF8Fbxmo+aGrrSWF/vEsdQg+0
         yhCdFgYIUl9vs2WP9809AVxugmdNQuUdfT9QMkaGkCIK++2nrMSp31KF9myjD6uz3NHP
         h3TJHLMXnk6T1sQGmSAeMd/KElFCs7tVTL0eqJ8OtWeGFdQbJI3cd86MIw46jrg6kHfR
         zXl+5hfIn7LNZ5SobFHPfYvJYkl1TOjbdrZOz8zzWesuByRO5+LpCwxliVHhE5yjNLWd
         PLT1z3wdoTbhCdj5Opc9zZBCBdhTzyPNAr/VHHZT96V6KRf3Ob6Mp1Jmg159ICWahnhg
         DT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YACmgmRxBGBnGnasXJxedtzIEWJwMVzobcXYqQ83U/U=;
        b=oZd3UahkqDEtBl0an2DfrbcVJ5yVTmHDy/FkYffzD6gdTkVEAuYcmUZdVn8W54RyO7
         X8vpaoYbh8/J/i5tRXQ1Wvm4qfgXGaS8/7gg+bUH1nawzChUKM9GamSrh+m/jsqKRW3G
         dX41JhxmhktdqDmt8h0KI35mSCtbLFYwR9cyUgOrOmANNjDJxbCquXIPayIGPzq21WHn
         6NHYhFqpDKVo/yvBm75ul08lPOw6YQ+16l80o7tG00o3E6KlNXWAdLmlgoe0lREavgGg
         /wDaBHwbr9k+6H3bLUU5yyVhRZg0+//BC3lYXUoG3c9A6otVmTKBgVs/1y2cf7Y4MKoL
         Pq/Q==
X-Gm-Message-State: AOAM531nJjnaq5MzWL3wXu0d2D/1Br2BRhvVJpdWj/p/hN8ONqjuNyp0
        nIBR4pbZvq1sDpkZTh1CZy7sToCX9/A=
X-Google-Smtp-Source: ABdhPJxk1ubJPHXCmluiEO3XyN7SdAqsiuHeJsowOMuGUJs9B/EXMUjvZysAJBNqfdM9x7pD1Guf8g==
X-Received: by 2002:a17:90a:648:: with SMTP id q8mr2014792pje.176.1604452175661;
        Tue, 03 Nov 2020 17:09:35 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id e3sm166573pgm.93.2020.11.03.17.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 17:09:34 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH] gitk: replace tabs with spaces (again)
Date:   Tue,  3 Nov 2020 17:09:27 -0800
Message-Id: <4c58637d96fe22747cd301e0f2e34d8c8b8f1f93.1604452145.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.29.2.286.g8a58376a31
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In e244588eb6 (gitk: replace tabs with spaces, 2020-09-10), tabs were
replaced with spaces so that indents consistently use spaces. However,
in 6cd80496e9 (gitk: Resize panes correctly when reducing window size,
2020-10-03), some tabs were erroneously reintroduced.

Convert these tabs back into spaces.

This was done mechanically by running:

	$ expand -i gitk >gitk.new
	$ mv gitk.new gitk
	$ chmod +x gitk

This patch should be empty with `--ignore-all-space`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 gitk | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/gitk b/gitk
index 23d9dd1fe0..c31a8b4e2f 100755
--- a/gitk
+++ b/gitk
@@ -2955,9 +2955,9 @@ proc savestuff {w} {
 proc resizeclistpanes {win w} {
     global oldwidth oldsash use_ttk
     if {[info exists oldwidth($win)]} {
-	if {[info exists oldsash($win)]} {
-	    set s0 [lindex $oldsash($win) 0]
-	    set s1 [lindex $oldsash($win) 1]
+        if {[info exists oldsash($win)]} {
+            set s0 [lindex $oldsash($win) 0]
+            set s1 [lindex $oldsash($win) 1]
         } elseif {$use_ttk} {
             set s0 [$win sashpos 0]
             set s1 [$win sashpos 1]
@@ -2992,7 +2992,7 @@ proc resizeclistpanes {win w} {
             $win sash place 0 $sash0 [lindex $s0 1]
             $win sash place 1 $sash1 [lindex $s1 1]
         }
-	set oldsash($win) [list $sash0 $sash1]
+        set oldsash($win) [list $sash0 $sash1]
     }
     set oldwidth($win) $w
 }
@@ -3000,8 +3000,8 @@ proc resizeclistpanes {win w} {
 proc resizecdetpanes {win w} {
     global oldwidth oldsash use_ttk
     if {[info exists oldwidth($win)]} {
-	if {[info exists oldsash($win)]} {
-	    set s0 $oldsash($win)
+        if {[info exists oldsash($win)]} {
+            set s0 $oldsash($win)
         } elseif {$use_ttk} {
             set s0 [$win sashpos 0]
         } else {
@@ -3024,7 +3024,7 @@ proc resizecdetpanes {win w} {
         } else {
             $win sash place 0 $sash0 [lindex $s0 1]
         }
-	set oldsash($win) $sash0
+        set oldsash($win) $sash0
     }
     set oldwidth($win) $w
 }
-- 
2.29.2.286.g8a58376a31

