Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769ABC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8CF20748
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qA1H/dzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388060AbgAPUgo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:36:44 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39555 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388054AbgAPUgo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 15:36:44 -0500
Received: by mail-pg1-f193.google.com with SMTP id b137so10482518pga.6
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 12:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xbAEoprmoggkR26eAAqeoFeiqErsIATEpefJg0F+rhY=;
        b=qA1H/dznzxkCH57HA4IyA/gve5FmVnH3J+5m3jyxAZBi7RCg+yXxPeU3SvAHhSWFuY
         YWEL7qZ/MGaQRBBQqWGxPeHkcy5cbG9VyHHFAk5X8slafiZnfWK+nZto5jADz7pskYtr
         KoTOC7j6PjSk3AIYfTpL3Gczt/xQQfo6lviS2xAEM9cjUKfcpGaAXQYV7xyWtNa/9ZxU
         VToFW4O/Z60ltRKRwwXW4TN9YTwrNO/CnDcbgpie5t8QZXq7N7E2YKGp5V+lUApFkeS6
         57FP6vPzlR/JkfazeMw7QIgeHrgTayXh1wTT29Kv8rFJpp5P37g/GLZ8NAslJeWzso0N
         ujWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xbAEoprmoggkR26eAAqeoFeiqErsIATEpefJg0F+rhY=;
        b=icDJh1Zi/8BDvJFmi/xr4HYgrksUwRMCIkBKp5wcACHwlLz1C2krN3ChxSR9TetpLi
         WRTZuQo6dREatYQVDHUSUUqXyIdQdgjlv8R5Go9DMvVyp/ogrXhb/wv56VHwcbImeEd7
         mr4w9gh70jV2SyGbhmlg21zwekrt1N6+jDJFx9ky4EWZ+eE4EwgsQv2TyEGO769VlauM
         2JRyVphd2ymZuSuNhv58aQEcBwCERwB99juJdYiXhnLFV5rEVgoVqnNlMcgbQ5kO7UqW
         jFWmaRFp6nELhsrKf9BkRNSFl6Fw+PGzXMp8KocHj3uwOBPaD+9pMAYYVpFy35Q3vrUZ
         X4MQ==
X-Gm-Message-State: APjAAAWB19wGfnJKTG99+sUvE78rKYr/6utPOiDPMR9jQJg+Yk4ZeC7P
        /YF+z+GfgdfCMZw5K5LafydBVVsFRgsWsQ==
X-Google-Smtp-Source: APXvYqyfdG5ouSWuaQGdSRYsm2KSsdSUYOksr1/ZxaXIDIZXbyW8wNSqmVl/etBEo6CC3w1H0hsXHA==
X-Received: by 2002:a63:6507:: with SMTP id z7mr42657574pgb.322.1579207003059;
        Thu, 16 Jan 2020 12:36:43 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.173])
        by smtp.gmail.com with ESMTPSA id d4sm3481167pjg.19.2020.01.16.12.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 12:36:42 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH 3/3] t6025: use helpers to replace test -f <path>
Date:   Fri, 17 Jan 2020 02:06:22 +0530
Message-Id: <20200116203622.4694-4-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116203622.4694-1-shouryashukla.oo@gmail.com>
References: <20200116203622.4694-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Take advantage of helper function 'test_path_is_file()' to
replace 'test -f' since the function makes the code more
readable and gives better error messages.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t6025-merge-symlinks.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6025-merge-symlinks.sh b/t/t6025-merge-symlinks.sh
index 41bae56ea9..ebbbc03f1d 100755
--- a/t/t6025-merge-symlinks.sh
+++ b/t/t6025-merge-symlinks.sh
@@ -38,7 +38,7 @@ test_expect_success 'merge master into b-symlink, which has a different symbolic
 '
 
 test_expect_success 'the merge result must be a file' '
-	test -f symlink
+	test_path_is_file symlink
 '
 
 test_expect_success 'merge master into b-file, which has a file instead of a symbolic link' '
@@ -48,7 +48,7 @@ test_expect_success 'merge master into b-file, which has a file instead of a sym
 '
 
 test_expect_success 'the merge result must be a file' '
-	test -f symlink
+	test_path_is_file symlink
 '
 
 test_expect_success 'merge b-file, which has a file instead of a symbolic link, into master' '
@@ -58,7 +58,7 @@ test_expect_success 'merge b-file, which has a file instead of a symbolic link,
 '
 
 test_expect_success 'the merge result must be a file' '
-	test -f symlink
+	test_path_is_file symlink
 '
 
 test_done
-- 
2.20.1

