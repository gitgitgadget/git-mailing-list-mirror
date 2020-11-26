Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C49C56202
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 19:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE0D6221E9
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 19:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCSEsVF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404537AbgKZTmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 14:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404516AbgKZTmh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 14:42:37 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B0AC0613D4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 11:42:36 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id f190so476987wme.1
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 11:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VIzGOPMShbfS/k5O8hAlnevrd9SAghFfOpKUtBgf8Cc=;
        b=GCSEsVF4Z/GiicYJGS3/XVjJ+vMO90+6wKAtSLJJWdCyK9QP7HVy5wrg3+a86dVfGS
         8pcHH2fzNQZzAtPtOLxqT1I2UYPrC8CcLuWiubOpOEX+E3vzkr5OqqQlXiYZRCFJXxiR
         A7ppKfFGE1Y+Z/n2ysJEczC0+VgboCC0ju9ryRVMKguABC/8dvl2IU5D8S9y0JsfNMrt
         78HrGhmWOw9gBaYdGfmfLwHmPMoWd0SVGkXwUXKMH3yNlb/dIWBEHSIlz/aC1/Frti3O
         l1RCilsDo7SDvEmoS04orPW5AygOVOfzsyWJFvfyjNb358Qcs+LF7thSrYcOOr6PgW5l
         mGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VIzGOPMShbfS/k5O8hAlnevrd9SAghFfOpKUtBgf8Cc=;
        b=F5MvIHdgBJD+iODsnrLrJ+Omlr4Zvk082Ho1ILQiI/zv+ywI9EkUXIS5U/yh56m+Ak
         aUtkpim2hiFklv0aPqZ+xQzaMjSSfctpnizAdmbA4JZOjx7XmyIdBZuBzA1+W0sHiP9/
         cNzd7271Z3RrGbg/V23ue3fifTpXUU0FO6bru0In7QnxEoe0z7yC8Eq5AIZklFZAYLMO
         4oQ9d20bCnyNo+9TA6FBUME06oHnqZkz77ooenGidPAZIb3GgpYTNp6Q+h4JPW5xFS1t
         0VcktfJzKMNpDu42iUnKwheENXsmfwHUZB+nWK2hafXsJVYPxX9yTBm3hsE3USjHci+n
         7RNA==
X-Gm-Message-State: AOAM530JhexqIEXOx5omUBqiEwQ2au8jyzsHf9+Kr6pyiCWP5mxnEGmi
        Muum9fTkdnIahGvrv/puH8uRrdngB14=
X-Google-Smtp-Source: ABdhPJzQMB+lLl4D9pdS8MRjvdAB5iWGUaKgNc0eudIEcUnv9Nx0RoprDNxd6514GxSIbtqTEi7r0g==
X-Received: by 2002:a1c:61c2:: with SMTP id v185mr5118633wmb.152.1606419755096;
        Thu, 26 Nov 2020 11:42:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w10sm10451691wra.34.2020.11.26.11.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 11:42:34 -0800 (PST)
Message-Id: <030998a732ac54f41473b07c7376ca46b817bf4e.1606419752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
        <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Nov 2020 19:42:16 +0000
Subject: [PATCH v3 01/16] move sleep_millisec to git-compat-util.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The sleep function is defined in wrapper.c, so it makes more sense to be a in
system compatibility header.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 cache.h           | 1 -
 git-compat-util.h | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index c0072d43b1..e986cf4ea9 100644
--- a/cache.h
+++ b/cache.h
@@ -1960,7 +1960,6 @@ int stat_validity_check(struct stat_validity *sv, const char *path);
 void stat_validity_update(struct stat_validity *sv, int fd);
 
 int versioncmp(const char *s1, const char *s2);
-void sleep_millisec(int millisec);
 
 /*
  * Create a directory and (if share is nonzero) adjust its permissions
diff --git a/git-compat-util.h b/git-compat-util.h
index adfea06897..7d509c5022 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1354,4 +1354,6 @@ static inline void *container_of_or_null_offset(void *ptr, size_t offset)
 	((uintptr_t)&(ptr)->member - (uintptr_t)(ptr))
 #endif /* !__GNUC__ */
 
+void sleep_millisec(int millisec);
+
 #endif
-- 
gitgitgadget

