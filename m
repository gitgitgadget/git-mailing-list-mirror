Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50244C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 09:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1C42206C0
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 09:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bzzt-net.20150623.gappssmtp.com header.i=@bzzt-net.20150623.gappssmtp.com header.b="o3uJo4lP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgLAJvl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 04:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbgLAJvl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 04:51:41 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141F1C0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 01:51:01 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id 7so2886589ejm.0
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 01:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bzzt-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yTiuuJjMiWDyt99bozXSz9rlDe333hjWe9G7Z3VkWJ0=;
        b=o3uJo4lP2bvoV05SKRpMffkooeFJGM856gpclic7hWyTBAqHRdbpcy3tKe0a8o/C2B
         T6kvSa76fb/FN5s1Rmzv/AIq+VCCozsiqIhN8I8GIQHkyg2HS9e04QoLgiXOMXH2wD4U
         RF9Pg4q8sf4DgT5/bu1I8Q2U4h+6txtTjuen0ljM8yh5ppxQhLwu4dRobdCfpgCHeLfr
         2H3VV4LsimxT0mq73lxZpj9tsZnq4vaeNBRVKmeKXVr6g8SqwTo6z9HwznCLT7QEMELJ
         92U56dr/8YPib2nfJsV5zMeem2cpUaHyzAL0UQ9hh0XyTE6gic1k85YvxPRmzWoRZeBv
         qmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yTiuuJjMiWDyt99bozXSz9rlDe333hjWe9G7Z3VkWJ0=;
        b=Y6B3tv5Uu3f1IHDFxgT0MXiOwVkb3uRRMBeWGDFNmz6zx7wzQ5g5CFFEGRmWecxsvH
         a9iuTVaXzrcNAlDXLVXZImArCUXYqC36TBdzij7pvZsiMmL3uT+jXvrPQgURly2gbXM+
         8r9ZnwYNPraYcPaXo0QZ9Yt8MaNJOGDRmeRJV0RBf80wNSQrqeLaWq3JN5UvBFjimor/
         FMhYemC4wU/ywi9EOEZ8sHoNyXoi2pyXFusPzqzzdRwkUZhDYYhCCJlQhx8Rywws9a72
         LusCWW7ZHytJYNhzw7T/fJbgOhcoKM8rIQPJmqarOcf8/rPbv/lqKhSxeAeq6eaneojl
         p0Xw==
X-Gm-Message-State: AOAM532YAb7aTFGsV9a94rJwCNu8cIBYnYtE9un4kZCmWimnglClZNdm
        Mg9qf99FSs7kF3OX7eetkh49dRIv4r5gvw==
X-Google-Smtp-Source: ABdhPJzQ52TDkpdcAvWYnC1TeUV2eQP5B3RXTcGDSbHHKnc+MVmHZqMRkhNEAS8trRQzqGuOQodKMA==
X-Received: by 2002:a17:906:b79a:: with SMTP id dt26mr2068402ejb.337.1606816259312;
        Tue, 01 Dec 2020 01:50:59 -0800 (PST)
Received: from rigter.space.hack42.nl (cruquius.hack42.nl. [185.205.52.134])
        by smtp.gmail.com with ESMTPSA id dk14sm560264ejb.97.2020.12.01.01.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 01:50:58 -0800 (PST)
From:   Arnout Engelen <arnout@bzzt.net>
To:     git@vger.kernel.org
Cc:     Arnout Engelen <arnout@bzzt.net>
Subject: [PATCH] doc: make HTML manual reproducible
Date:   Tue,  1 Dec 2020 09:50:37 +0000
Message-Id: <20201201095037.20715-1-arnout@bzzt.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes sure the generated id's inside the html version of the
documentation use the same id's when the same version of the
manual is generated twice.

Signed-off-by: Arnout Engelen <arnout@bzzt.net>
---
 Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 80d1908a44..4d1fd5e31f 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -380,7 +380,7 @@ SubmittingPatches.txt: SubmittingPatches
 	$(QUIET_GEN) cp $< $@
 
 XSLT = docbook.xsl
-XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
+XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css --stringparam generate.consistent.ids 1
 
 user-manual.html: user-manual.xml $(XSLT)
 	$(QUIET_XSLTPROC)$(RM) $@+ $@ && \
-- 
2.29.2

