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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00D9C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 20:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9707C60C3F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 20:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhHLUYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 16:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhHLUYS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 16:24:18 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA4EC061756
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 13:23:53 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d2so6347390qto.6
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 13:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XBhX61FMtNAZVlLBgwgXQ6qj1DO4Cso5/F/ktXnnkeM=;
        b=Tk/cYo2ckL8an4LtWSg1jMzrIx2J2K82Tjnz9qf4tjZWJLDzKwaOAlDjFJ2F4eQEWH
         pBTs4Y44erVJJwPck4TUy26u26tK71E93DKyognP+8L3JYgylqe17OSFHJ4InEnBSqes
         m00L1iLKtP6TKVmfLhqkTj7UTLsTxaaffprDI5kG0DkW8bBL4Twil1+388abwNdKkhpg
         4Dlpo66uNIfVLZO567l+YxQKeYPP3qyEM28GPvbX4PBO5BFeg1AKyWNiYSxYhWdekH3I
         pTKJ0rJ7ru0SH4pkHdGEXbqohQ7L0sYFyzgfYIDK9vIaUH+YiPSDdpf2Atj8NldxfMhV
         m+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XBhX61FMtNAZVlLBgwgXQ6qj1DO4Cso5/F/ktXnnkeM=;
        b=F618maBOyuCmHSvQHGZHJJ/GFmEAoDGYz1RH5xk894OtAuhCPXPiKtrJpNkib5MUiN
         CHf0CEOxQ9/R2VQbZam5m/JesnM8ZwNLkrkLWK9fjgUbqxefcpTbfAYDMPrV/axQTGa/
         WEtV7t74xskPe48Ehzlbxq6oPmGgM1IpTP4t85eRB0k7wZiz9Q8WyLz731W/Q5JHUnAc
         n+PNNmCtXUXohSsz+tl8QrzypoaJ5yNhxHZZU6a0j4TgA5Y/fkkZmiOHH5G1/CH/MnrF
         pfMl6cnr/wqwYbJF2iqycfyIXApT/P8dw0ebZFhTmFqcLBz/+yQEeNKlBT7f7MSfPbHw
         dmjw==
X-Gm-Message-State: AOAM53234VQTxRG+fniJxUUXOGonvquGi/ztL+7kASdXDXQdGMXpU2yy
        AIF67wQZpltYrVfi6hSSrodW6ocNdA0=
X-Google-Smtp-Source: ABdhPJwjzevEORqju5QUgathknikq9vIom7UFZOZwo/D8cL88fKpE4nMdF5XhSOqSUlrLdi582Ns8Q==
X-Received: by 2002:a05:622a:14ca:: with SMTP id u10mr5636322qtx.338.1628799831863;
        Thu, 12 Aug 2021 13:23:51 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id v34sm1181236qtc.4.2021.08.12.13.23.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Aug 2021 13:23:51 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     emaste@FreeBSD.org,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] ci: update freebsd 12 cirrus job
Date:   Thu, 12 Aug 2021 13:22:00 -0700
Message-Id: <20210812202200.82465-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.379.g2890ef5eb6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

make sure it uses a supported OS branch and uses all the resources
that can be allocated efficiently.

while only 1GB of memory is needed, 2GB is the minimum for a 2 CPU
machine (the default), but by increasing parallelism wall time has
been reduced by 35%.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 .cirrus.yml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index c2f5fe385a..e114ffee1a 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -2,8 +2,15 @@ env:
   CIRRUS_CLONE_DEPTH: 1
 
 freebsd_12_task:
+  env:
+    GIT_PROVE_OPTS: "--timer --jobs 10"
+    GIT_TEST_OPTS: "--no-chain-lint --no-bin-wrappers"
+    MAKEFLAGS: "-j4"
+    DEFAULT_TEST_TARGET: prove
+    DEVELOPER: 1
   freebsd_instance:
-    image: freebsd-12-1-release-amd64
+    image_family: freebsd-12-2
+    memory: 2G
   install_script:
     pkg install -y gettext gmake perl5
   create_user_script:
-- 
2.33.0.rc1.379.g2890ef5eb6

