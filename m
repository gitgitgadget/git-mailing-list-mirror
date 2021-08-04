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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFFDC432BE
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 01:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D758A60F8F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 01:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhHDBJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 21:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbhHDBJk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 21:09:40 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D5FC061764
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 18:09:27 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id x15-20020a05683000cfb02904d1f8b9db81so206909oto.12
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 18:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ACqwoYjIPKzMzRz2JQcMEADda9SuDp7dHh3a6fRWB1E=;
        b=rh8pjUGdTuX0SpsMu9M/ABvWxpwtIbjyYzLOhWI9X/yvu9UMa88+WiRPXGUA+5TJKm
         7VyKAXnjQ2E3trIxmpnlvMLdC+EvjmltXicZIubAIZa8A+32sUGMLjCZan6ovJ04+f5K
         amDtUCSb35go7EYSBt8Bvsxl6qGBYYS3UK+zr303wzdhzzBZ610z/cgc1mtZHZhqwMch
         fKUgoIOukcLv4BtHrbPel13MjiNCtW9b8DiDRRZditbcGQ+rGGe6J3D7J+WtqP3H5rGZ
         gAEGMJI3V+xglkKVzJbKymAbxon4R8P73B1vtFyLxfA/inSU4LSELnjwXnw6rcoI639N
         lfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ACqwoYjIPKzMzRz2JQcMEADda9SuDp7dHh3a6fRWB1E=;
        b=cTrOu/ZU79f6rX5v/YBYNYDo42A1epokjRn2PyIyF46Cd1GfJlMemLKgW+90N2Swy8
         wvmbGjqyaK7faCPc5VXxQpaoEUgSXxmdBIXvCsVJvTSymXS0+i5qbfBJ9JGr/3ig2PN9
         pyiVBV3LtR7RtmaFlCIX581BQJHeoTf7Hdvg8egqGS0dofMJYowE/2BZhtksY1WNRmrS
         28pP0KOFz8SR2BhhcUoM+3A0NQr7VPn5d5xZTl6Gp6uuXS6raOaWhcdMAd8VT0DBYaeJ
         sUH3d1saSdxhxO99XSj5HzsOp4pNPTZIEaThYUhzH4MvRtlOI3mlQVcvzf0SW3SiLzu7
         hWhQ==
X-Gm-Message-State: AOAM530bft0xW5mYThibbuppywlwBeDp/KTahoelRXqETKMp1pe98jpt
        N/xxmy1jj1ALktdYeiuWQr6fE5n12yU=
X-Google-Smtp-Source: ABdhPJzfsJNKrP6D8EIo7WicsBO7hELSmQ9NlLZ9I1irgfQIeDFnEd1LczHc8YsxQNHauJs2XFI52w==
X-Received: by 2002:a9d:5603:: with SMTP id e3mr17136766oti.178.1628039366715;
        Tue, 03 Aug 2021 18:09:26 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id c21sm179721oiw.16.2021.08.03.18.09.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Aug 2021 18:09:26 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org, paulus@samba.org
Cc:     pietzsch@mycroft.speedport.ip, sunshine@sunshineco.com,
        tair.sabirgaliev@bee.kz, lists@haller-berlin.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 2/3] gitk: avoid fatal error if `exec osascript` fails
Date:   Tue,  3 Aug 2021 18:08:59 -0700
Message-Id: <20210804010900.33133-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.433.g9a510e7e11
In-Reply-To: <20210804010900.33133-1-carenas@gmail.com>
References: <20210804010900.33133-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

starting with macOS 10.14 calling "System Events" requires an
"Automation" grant, that will result in a fatal error showing:

  Error in startup script: 66:111: execution error: Not authorized to send Apple events to System Events. (-1743)

instead of aborting catch the error and print a suitable warning.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 gitk | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/gitk b/gitk
index f68d983..b62c12f 100755
--- a/gitk
+++ b/gitk
@@ -12291,11 +12291,15 @@ if {[catch {package require Tk 8.4} err]} {
 # on macOS bring the current Wish process window to front if needed
 if {[tk windowingsystem] eq "aqua"} {
     if {$tcl_version < 8.6} {
-        exec osascript -e [format {
-            tell application "System Events"
-                set frontmost of processes whose unix id is %d to true
-            end tell
-        } [pid] ]
+        if {[catch {
+            exec osascript -e [format {
+                tell application "System Events"
+                    set frontmost of processes whose unix id is %d to true
+                end tell
+            } [pid] ]
+        } ]} {
+            puts stderr [mc "Warning: 'System Events' access denied"]
+        }
     }
 }
 
-- 
2.33.0.rc0.433.g9a510e7e11

