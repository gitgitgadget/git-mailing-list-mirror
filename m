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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB327C4320A
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 01:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C37AB61374
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 01:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhHPBQe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Aug 2021 21:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhHPBQc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Aug 2021 21:16:32 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DD1C0613A4
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 18:16:01 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id t190so4136931qke.7
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 18:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GlDE6aJXrv19nlX2nFouM+FEeuVPJZsEMVFiYfEil5s=;
        b=KR4lGtGPRZFdhYhEVgfPClBZ6Zcttm+GtKAg/R3TKE5F6yCEdZxaXoGRdjxnbew51x
         ozJ5En0ppluP9IpGUj4XdJ2XgwDYoe0CDTY/L4a/G/YaWXbfwmxEBw/ihcoTFX6z5qoC
         4phODp1zPzImpycBOgoXV5tT32+m8pvKjmw7SUcg0ZtQeyBKdA4ZTdhwFXvtCFX1dMWS
         8Lb90IXzyD0T0nzdwNeqDJRL/TduMKA0jGtPchtSfn3YYVUZwAmJUlQGUZcYOzf0HbwF
         M3rDozXCkwrL5QAy6Om0SMfoCkgZfCFsQ67RiA9+gXt3HYaKKDNTSFt+3cSp70LHk5PJ
         jRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GlDE6aJXrv19nlX2nFouM+FEeuVPJZsEMVFiYfEil5s=;
        b=POtSTYIRcfzNWE28MQcdGabi38Od0Bnj8lsWjSwz8J6PrRbPj2cnlnWaZ3ufF8BzHH
         bTkUg8ed0/+tZ3la2l0SbDwijk9v4Lk0lScRv/oBiW8m7r05BSPyAU62eloJMQbyPeL9
         WlQ75iqOhpaPriKUu28O2QiE5yh/k35LOFNcs8duepmtlqNnHdqa8J1uByADrAKN2f5L
         86FxPnlUKqGxKbZL8y5lI0OQCPm8A+APNnq18w5tFgIRODN9XVW8Jm5EYKnp24VJ2Gxb
         1ZTbLrZ2XqhbJM7DL/i8IgGJ/OnLcstM5veFdzO6t4UF13kRma4HWDCBKmbeG9aYy7y/
         PdFQ==
X-Gm-Message-State: AOAM53166Xr2gd+JzLXmL4cbvYdYjUzc20l2P/+fNioOxt1uZiXKohZ5
        WI7WNLi9+JxewhZhU2EQ0C8s4v5sFaU=
X-Google-Smtp-Source: ABdhPJy6jax7RVwIKy8Z+tKcZEqJHkpgD64PzU6++fpzhZ4D6Ovjq7924ypO+D4R71J7ma2Hq1PPWg==
X-Received: by 2002:a05:620a:19a9:: with SMTP id bm41mr13661994qkb.399.1629076560001;
        Sun, 15 Aug 2021 18:16:00 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id f2sm4121181qth.11.2021.08.15.18.15.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Aug 2021 18:15:59 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 5/7] fixup! Provide zlib's uncompress2 from compat/zlib-compat.c
Date:   Sun, 15 Aug 2021 18:15:36 -0700
Message-Id: <20210816011538.34199-6-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc2.476.g1b09a32a73
In-Reply-To: <20210816011538.34199-1-carenas@gmail.com>
References: <20210802190054.58282-1-carenas@gmail.com>
 <20210816011538.34199-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

the code imported from zlib 1.2.11 uses an optional feature from 1.2.5.2
that could cause compilation errors with older versions.

make sure it is defined and disabled in those cases to avoid
building failures.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 compat/zlib-uncompress2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/compat/zlib-uncompress2.c b/compat/zlib-uncompress2.c
index 23b72b49c4..f49f680567 100644
--- a/compat/zlib-uncompress2.c
+++ b/compat/zlib-uncompress2.c
@@ -14,6 +14,9 @@
  */
 
 #include <zlib.h>
+#ifndef z_const
+#define z_const
+#endif
 
 /* clang-format off */
 
-- 
2.33.0.rc2.476.g1b09a32a73

