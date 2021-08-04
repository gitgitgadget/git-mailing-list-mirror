Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8254C432BE
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 01:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8228660F6F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 01:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhHDBJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 21:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbhHDBJj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 21:09:39 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DA3C06175F
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 18:09:26 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id o2-20020a9d22020000b0290462f0ab0800so211037ota.11
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 18:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dr3bNq/CnQfuWAjdfFrDIUABqAmSlccVitteYBKhb8E=;
        b=VipzIXYA3QHdQTlSoeG85Yb15XqJswKHZQCMNZKehfJZhBsrP0pbTIhBPcWhyaqtN7
         CLYR64YG3DApxb0RjwGSTVYNW3od5F19su2GpcAUr7mta7xFhFNQGaayZXD1jWNKYYVJ
         c/wM5YSzzCksMnIG8SlvchfHsZqUQMmF6RRGeShoMLcGiBhy/XB9+blFAr3hxUnHDRl1
         EXo2WKNiFF+CgvwEpZkvk16DrjQRZCvge+u97ha8L0S6wvLovv9Ykvfb+E8d8F73By5R
         OjnjcJwXjVcFrtdSDYWRjmqBJYWGrzCejiHG9/QkA/n53iZprKW57JFgQTax+lgG+lKk
         cr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dr3bNq/CnQfuWAjdfFrDIUABqAmSlccVitteYBKhb8E=;
        b=ZmlcdAjzVyntvJhzzgNlv9higjP+xm2Bln7LDoZIcFskh7xgytuaYu/5Vh0n/PSj8K
         S6oE+XrQRLWmvkQQuZsZwADtiAGiSSEbcWYRW8cnNtjKC8+SlLx9NSirAwO4/EXlVheV
         O/ZIlk83gtIzDomlNsva7KiPp/uwp6bH3szKgNXeGY+JeSsityfIPNfTRG3wAC7++Y6M
         U7n1250x6P3HwASBPj8Kqbncms8qh8rmTRXOv3wyDT7UFEMtKxUCsnsZEU/1HDiIAQvM
         N563sXBpm2O621tw5WudzPtSDRaXetE9TXvRQqGRoaDD3v50FN34d9ldHPDIzGnxcP3V
         BV+A==
X-Gm-Message-State: AOAM530/YppuiWZZY92Biv77h3Z/WBmVCvuwJWVQaDs6uoDCJY34mIUK
        y32lsepucVyYIjCP8d7ymIuao/DTIms=
X-Google-Smtp-Source: ABdhPJwu4IMWHhtPsHJJFCze1KR/jnR4FRKJ3R0rX6GNAjXiRGcV5n2ue/NsSx7NLfTU7cO6zH4JXQ==
X-Received: by 2002:a9d:3a08:: with SMTP id j8mr16989881otc.247.1628039365679;
        Tue, 03 Aug 2021 18:09:25 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id c21sm179721oiw.16.2021.08.03.18.09.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Aug 2021 18:09:25 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org, paulus@samba.org
Cc:     pietzsch@mycroft.speedport.ip, sunshine@sunshineco.com,
        tair.sabirgaliev@bee.kz, lists@haller-berlin.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 1/3] gitk: skip calling osascript to set frontmost for tk >= 8.6
Date:   Tue,  3 Aug 2021 18:08:58 -0700
Message-Id: <20210804010900.33133-2-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.433.g9a510e7e11
In-Reply-To: <20210804010900.33133-1-carenas@gmail.com>
References: <20210804010900.33133-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

76bf6ff (gitk: On OSX, bring the gitk window to front, 2013-04-24) adds
an osascript to set the gitk window to the front to workaround and
unfortunate default in older tk versions to add it to the back.

tk 8.6 or newer do not need that workaround so add a conditional check
to skip it and while at it update the comment with the new name for the
OS.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 gitk | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/gitk b/gitk
index 23d9dd1..f68d983 100755
--- a/gitk
+++ b/gitk
@@ -12288,13 +12288,15 @@ if {[catch {package require Tk 8.4} err]} {
     exit 1
 }
 
-# on OSX bring the current Wish process window to front
+# on macOS bring the current Wish process window to front if needed
 if {[tk windowingsystem] eq "aqua"} {
-    exec osascript -e [format {
-        tell application "System Events"
-            set frontmost of processes whose unix id is %d to true
-        end tell
-    } [pid] ]
+    if {$tcl_version < 8.6} {
+        exec osascript -e [format {
+            tell application "System Events"
+                set frontmost of processes whose unix id is %d to true
+            end tell
+        } [pid] ]
+    }
 }
 
 # Unset GIT_TRACE var if set
-- 
2.33.0.rc0.433.g9a510e7e11

