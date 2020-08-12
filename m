Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EEDC433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E8720838
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZXM6Hto"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgHLT2H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgHLT2G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 15:28:06 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DFDC061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 12:28:06 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s15so1545628pgc.8
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 12:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qZ5o/8amuzEkI1Dpols2p18x4/Z9qXPbUQGVNkP9FGA=;
        b=kZXM6HtoVOLrkKJbFWbiw/4WmfMa8PIgv07vKw358cSkbi+11FVdvNxPbnq8Vn7fdY
         bYCEc7Hhwgnf6klULeBusV+KaYWEEJsVkBfuAioICOraCvHcCzbsPhcdbeeU38IlihCl
         4+EqdgS6yuZJEprSPjdFlG6bsLlv/DernhSLn4vpQJn8TIZW6k4X7F6PfCb0ilZK1hEP
         Dm9E5DrCeN9xnEQ1FjnDWqCe6MScFbkxShwzNv0LjkCKuDHBTOMqjQ7DKKNWULueTFgo
         SeUKRnyReNqd4dZKc1bu4nwjU0Huy8FTt78+mKD1NwgTBY1gx4ajGNcv95gWITKNphOK
         hR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qZ5o/8amuzEkI1Dpols2p18x4/Z9qXPbUQGVNkP9FGA=;
        b=YGp3igIO0wAhBhGTLgPR2C2vAUAKI+4iNCbKL6WDCS+Yl7P26KeQsXK55svPw1nDOQ
         0LVLam7aXs2bep3S0BDcgRR5Cuofb60Fn4Mk06qE2fTliOPPocz7dmF8MOmIUmzL5/Po
         lu1iJzBS3f7Z/0mT8ZbsE4QPWTYbx1OTKkRtaSj3epM64TzH5vhylsJ4ZLG8d3byPXJ5
         /yrbvY8Fv9PDQUwwPM3zuc2XqqPIC7feYx4WHYO02w8XjROMw7D39kXmZEW3oq/hc8j+
         Y92pI85sp2nBEu80aEJRgIU5CNuWr2bhthNLuiZXu+Ago01KzSI+4HbW6zE3yO5Kb0uP
         0Xtg==
X-Gm-Message-State: AOAM531hM98kMVQqbCX19x0M4pAgCFYN1ZGSWPYZlXocbjE5Fphto8M1
        LoJkZxs4zFOE5lW30tzBxyc=
X-Google-Smtp-Source: ABdhPJxtnmfK0tIRnfizogx8QVjGhJZo3J3UKsjPcOrfe4OK7b8HcInRTWSBfhLp3e3MOJh8A0IAOg==
X-Received: by 2002:a62:7b43:: with SMTP id w64mr952870pfc.282.1597260486368;
        Wed, 12 Aug 2020 12:28:06 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.132])
        by smtp.gmail.com with ESMTPSA id f3sm3463334pfj.206.2020.08.12.12.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 12:28:05 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     shouryashukla.oo@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 4/4] t7401: add a NEEDSWORK
Date:   Thu, 13 Aug 2020 00:57:37 +0530
Message-Id: <20200812192737.13971-5-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812192737.13971-1-shouryashukla.oo@gmail.com>
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
 <20200812192737.13971-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a NEEDSWORK regarding the outdated syntax and working of the test,
which may need to be improved to obtain better and desired results.

While at it, change the word 'test' to 'test script' in the test
description to avoid ambiguity.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t7401-submodule-summary.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index dd0e88fc6a..8f5e4515d3 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -5,8 +5,11 @@
 
 test_description='Summary support for submodules
 
-This test tries to verify the sanity of summary subcommand of git submodule.
+This test script tries to verify the sanity of summary subcommand of git submodule.
 '
+# NEEDSWORK: This test script is old fashioned and may need a big cleanup since
+# there are lots of commands taking place outside of 'test_expect_success'
+# block, which is no longer in good-style.
 
 . ./test-lib.sh
 
-- 
2.28.0

