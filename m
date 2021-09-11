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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9AEC433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 09:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF3E1610F8
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 09:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbhIKJfn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 05:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbhIKJfl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 05:35:41 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A509DC061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 02:34:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n7-20020a05600c3b8700b002f8ca941d89so2998156wms.2
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 02:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZCyNg1e+cRlEflagvnBmtZzEiwVterMMa/xg9C3+kyw=;
        b=nK9jzyzMvqHoyFDNWOAbCOklXMtzLinZDNqfM/9hwoAav0da3UDoLpdzCTg4VzG9Bb
         3PdkJJ9bA7jcELYIqziduF/AHHNbhO0h918hkSm/30zSmK1SgNwjpbYZuO8aGurOAWv8
         AUmybxUum7Wbc08bhD54v10Yxix3r1y1ah6CtSIVJPyvL4+c8VhrOIHLTW6Br5LYlUuh
         8QlnRpixLF9VH5dUto0K5zZ5hYIp2yvD11t7lPkwjjop42X0K0jzht6Nkuiw9wEOfPgr
         OWf3DAlw4gHJr23DyEZvucu2fgXIPAOPG81ukcyS7rb9eH6kypo7mc587dti7MI6pM9D
         3tBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZCyNg1e+cRlEflagvnBmtZzEiwVterMMa/xg9C3+kyw=;
        b=06uOUJVymZIrW4T3oN61DeFNpyyPTDYkLSglvdm674S2lsEnEOhRPnVWocrXMyNw5t
         hER44a7PmeySdo8zo42N17LEmNxJpmM9Xera5qJp4+1Sy2SXMeJay91c2wMC+6zn2dsR
         pLiG7pcYLjZFX6L4K5YGI7jTBBsi//Wg9M5hRQIg2osL/oMasH7u6NLVoWEqF1lu177f
         zYzny79tPc1uEPHgOsoKI4CdllZzuK2pP+Qmk+jVEqn65SA4x3L4yce3p49MwCjqz6Bp
         eylRxPJZOkQBHksQghOSUrWc6KQjK7x2i3gStNURYgcxmYKO/H94OMitGCN/9FTGwGmK
         Ze6A==
X-Gm-Message-State: AOAM533WwaHAg9LxmG5HfuSDiCcvJYdLiPVLkOylRyPztlvJNqvQfBAb
        I1NDFmEoLskBiO5B2BesXNWSCvLdePgYiA==
X-Google-Smtp-Source: ABdhPJzo/mnlS9tdVTs3X1yTalw6Wzzl4jxqIaOLZNyuzTNGWg7X+T8ZZ58xJBrPRsT84KZRzj0Hpg==
X-Received: by 2002:a1c:2057:: with SMTP id g84mr1991652wmg.140.1631352867021;
        Sat, 11 Sep 2021 02:34:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s10sm1161753wrg.42.2021.09.11.02.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 02:34:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/9] INSTALL: reword and copy-edit the "libcurl" section
Date:   Sat, 11 Sep 2021 11:34:16 +0200
Message-Id: <patch-v3-2.9-3b0119958a3-20210911T092751Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.984.gea2c3555113
In-Reply-To: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the "libcurl" section shorter and more to the point, this is
mostly based on suggestions from [1].

1. https://lore.kernel.org/git/YTtxcBdF2VQdWp5C@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 INSTALL | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/INSTALL b/INSTALL
index 5b8bd5ccce1..d593f628749 100644
--- a/INSTALL
+++ b/INSTALL
@@ -138,11 +138,11 @@ Issues of note:
 	  BLK_SHA1.  Also included is a version optimized for PowerPC
 	  (PPC_SHA1).
 
-	- "libcurl" library is used by git-http-fetch, git-fetch, and, if
-	  the curl version >= 7.34.0, for git-imap-send. If you do not
-	  use http:// or https:// repositories, and do not want to put
-	  patches into an IMAP mailbox, you do not have to have them
-	  (use NO_CURL).
+	- "libcurl" library is used for fetching and pushing
+	  repositories over http:// or https://, as well as by
+	  git-imap-send if the curl version is >= 7.34.0. If you do
+	  not need that functionality, use NO_CURL to build without
+	  it.
 
 	- "expat" library; git-http-push uses it for remote lock
 	  management over DAV.  Similar to "curl" above, this is optional
-- 
2.33.0.984.gea2c3555113

