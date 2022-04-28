Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E59C433F5
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 03:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242288AbiD1DjJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 23:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbiD1DjH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 23:39:07 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12CE7245E
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 20:35:53 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-e922e68b0fso4043960fac.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 20:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6MKNL41/sgQmQ2iQhtvCX3QWhSNN+zZLYy2v/N1temw=;
        b=cobY3S6t8XEo3vwyPk27tt6eMEn2Wh8AXGEFACHMoyQrSXUtZ9YU9YMYAlxQoxOf8Z
         qHXSpg9vQ2NP3YLMutDEU5xmsfMV1s7p/ZmfMbNQVTAPDy42Lt4OB6QJQ8W21HCw1SBu
         kaP7rRC1EQsqAWR05l7GTNoXD+pl2lw/s1+kl1pxmaOYFAPQ7CkGYy1gn9h5yuP+stcZ
         glMzFSTOx0G0QfMwpV3DKp22stkb23n1iyWElyRNQ/oDeiVXLoZ9jRSUpn5jwMS+4acB
         +6dxvtfND2WEkNyACO6cxoWTX99gz1UvN8+3rx77j5oYfW7OStytbPimEUfZaYiVyGMN
         Bctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6MKNL41/sgQmQ2iQhtvCX3QWhSNN+zZLYy2v/N1temw=;
        b=ZsypTCHz2XtZDm+WXQ9Xxj4NNIDYqekdBw1oKA8MxOmI+oY01QT9i1o0jfVUcyP8Vt
         5UND7A0xmbtwSLOljaSmp4XZXzgqS0hk7jvC0x5HK0X3Q/OMQqugqbbez+9TcxYSkS/v
         Lqm7fVVucXgGb4ACceTsLL9MFyxjrHgo80Cho4MOaTHy1Q2ZtAy8y7s5wjW46mYL7omE
         QzrgyZM/sqYQoMCzTcui7S2MeB83OZYcGkCh7cVuLtI27ULs67GM5v91+ZEB8Fow7LzV
         HEPCVQV7jp/wq1ln05nHCaggEUgYRdzlv7YZMc8/JLAzSVWbjpQrrepqTDZPRVazID3S
         B4wA==
X-Gm-Message-State: AOAM531HxOXTS55XdRw1TghKT8hsvd8X+qKil0wvBO2J0pqUvhmxL69m
        fGbezAvCzZkqTPOkxWuQPnvPJxaB7qA=
X-Google-Smtp-Source: ABdhPJzctsvyk7iPIvkSSOXsH4pwMQqEWelap3s1eSNuGSKUB8BCaJv/lPTRIdTq5ZpYt9pSfKcbgQ==
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id v29-20020a056870311d00b000de9b6c362bmr16457905oaa.200.1651116953016;
        Wed, 27 Apr 2022 20:35:53 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id x21-20020a4a6215000000b0033993dc1d65sm7432217ooc.8.2022.04.27.20.35.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Apr 2022 20:35:52 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 1/2] Documentation: explain how safe.directory works when running under sudo
Date:   Wed, 27 Apr 2022 20:35:43 -0700
Message-Id: <20220428033544.68188-2-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.266.g59f845bde02
In-Reply-To: <20220428033544.68188-1-carenas@gmail.com>
References: <20220427222649.63516-1-carenas@gmail.com>
 <20220428033544.68188-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a previous patch, the behaviour of git was changed so it will be able
to find the "effective uid" that is required when git was invoked with
sudo to root, for example:

  $ sudo make install

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Documentation/config/safe.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.txt
index 6d764fe0ccf..67f8ef5d766 100644
--- a/Documentation/config/safe.txt
+++ b/Documentation/config/safe.txt
@@ -26,3 +26,11 @@ directory was listed in the `safe.directory` list. If `safe.directory=*`
 is set in system config and you want to re-enable this protection, then
 initialize your list with an empty value before listing the repositories
 that you deem safe.
++
+When git tries to check for ownership of git repositories it will obviously
+use the user that is being used to run git itself, but if git is running
+as root, it will first check if it might had been started through `sudo`,
+and if that is the case, will use the user id that invoked sudo instead.
+If that is not what you would prefer and want git to instead only trust
+repositories that are owned by root, then you should remove the `SUDO_UID`
+variable from root's environment.
-- 
2.36.0.266.g59f845bde02

