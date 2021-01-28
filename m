Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18598C433E9
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 18:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF88E64E1D
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 18:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhA1SZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhA1SX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 13:23:58 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBCDC061756
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 10:23:18 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id y187so5345639wmd.3
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 10:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LLykIru/QHUyAoJe4V03xUcU5oj8tv6/f+KIzyMrEZo=;
        b=UwZNs3v77tI5b2BsX0XWmynPESwmWju+7LGD/Xb5de/CZUYENFBVTcLD/P3jvSDHkz
         walSZ9x+ASojz5Rc1uCOrnMjDwlJnOux2nRSDXAZYcTD/OU3AQvtJwjaMGV/rEhZ5XHR
         Y6eOF40emCH17ch8KgrD9lRwR6+WIZp9TANpXd+iBbinUd5HT1Ot8BJ46gQKo5GxFB3n
         vLyXNvOV38D3j5iIEdKxPkxoSi2IEUZB18grsGPTECO8MeAD9evFG/On3+XqKnO3Zryi
         T7+BpKJj2nFwKHgXmUeK/kK38RCOhpJX8mm68Tc0ZEBucvJZ2bCwgoqhgrRLAoJy+gdQ
         cMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LLykIru/QHUyAoJe4V03xUcU5oj8tv6/f+KIzyMrEZo=;
        b=GyrJStJgacF/I0HCqhtfxFlAuwl44e986WyVYtuQOzM+BO6Jv63ic1A2S+f5aum3l9
         /87/tupo56K+O4a1OXDjeE4ww2i1BWnAUhLNDxL2k+KYvwCKwR6/1ulnvHPqgZQ7Z5Tj
         +XbXUjpeA1gfbofzKkWtz5dM9uboLpzugfH4qafLc03QEOX0HaBWcixCuW2/kFXAUT5E
         OY79bn89wFLoQqBlWsdcXL6l4FokZAAQQ0/r+pa9ZDOrYLHhBVLXweR5sT37ccKgB4KR
         GKnn+/iX9J7CGDcayhwlEsgVbWIbA+kZA4JFyk3/KTe9j7e7mArb2vaHzO9/oyXZstVv
         HqHw==
X-Gm-Message-State: AOAM531YjOW513FmgqljQ5PAwsJr+QV8yDeE0I9aZkwYBvP7Zho0sB8t
        l++7z1icIIDkmtcHMai6VfIWcrJfE1pXHA==
X-Google-Smtp-Source: ABdhPJzqlJsqEpUjXqg8kXaGs9N517e1HS+OA3izjW0jy7SP+Yqcfr7YudyhdAkyje3Y6IjBnCNGGA==
X-Received: by 2002:a1c:ba83:: with SMTP id k125mr501252wmf.5.1611858196506;
        Thu, 28 Jan 2021 10:23:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o14sm7647357wri.48.2021.01.28.10.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:23:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/6] Makefile: guard against TEST_OBJS in the environment
Date:   Thu, 28 Jan 2021 19:23:06 +0100
Message-Id: <20210128182310.26787-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <YBCGtd9if0qtuQxx@coredump.intra.peff.net>
References: <YBCGtd9if0qtuQxx@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add TEST_OBJS to the list of other *_OBJS variables we reset. We had
already established this pattern when TEST_OBJS was introduced in
daa99a91729 (Makefile: make sure test helpers are rebuilt when headers
change, 2010-01-26), but it wasn't added to the list in that commit
along with the rest.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 65e600713c1..63fa5c30b45 100644
--- a/Makefile
+++ b/Makefile
@@ -591,6 +591,7 @@ SCRIPT_PYTHON =
 SCRIPT_SH =
 SCRIPT_LIB =
 TEST_BUILTINS_OBJS =
+TEST_OBJS = 
 TEST_PROGRAMS_NEED_X =
 THIRD_PARTY_SOURCES =
 
-- 
2.29.2.222.g5d2a92d10f8

