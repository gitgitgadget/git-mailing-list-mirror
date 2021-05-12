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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F512C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5DD5613FB
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbhELXYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349219AbhELWa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 18:30:56 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38DBC061357
        for <git@vger.kernel.org>; Wed, 12 May 2021 15:28:27 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id u16so23630787oiu.7
        for <git@vger.kernel.org>; Wed, 12 May 2021 15:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w5yCjefqlW2W/Uce4VfyAcpbxBUdAvp/O6mcRa7cNvQ=;
        b=dsIRmSsLm00jW3rQfeOWSv916GN5nO3eQ6T8otku21Q5vYskSt7zwb4Ak1uztFHMNV
         Xu+5/5pP+3xzZ8IAuP5+mmam7VRj0qRbQkmpYf6sJj1up51ZFd3Imcepl1Q2Xdu3mSmD
         JHDz3G7uFnJ5f4Wde4iHEEW+fYsD43ovc0bCCagCjp+ULTOHVklmaRIJrlzdrqIMtn3T
         wnx7kZQGB2ZsYYoECGeHOzVTCQ0Hy1X72dsTEBSW/EXvSOt8YgcIe1gQVZqiVB69AbWq
         BsaFg6tIy3Llt29kOe2QKd/EQYOQxEJqGgFzF7xFYoBd2ktk7VV5aFUsXrpvKJ76/LL6
         7Aug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w5yCjefqlW2W/Uce4VfyAcpbxBUdAvp/O6mcRa7cNvQ=;
        b=rUQSzH8IECGT0JLt5i9dj9fcj5KjEB0s9+3uxhnyHi8TmvSnvELjk8+2HkBX+gl0dL
         2sbgNe+Gxg2KHlcp5B2dme/rb36Mk7ZVjaMaZ/lLnpHaLRCBBTZdYwIh9KUlcaUiI4D9
         LkCCh9JvYpKxsrCqczRuP+NeQ04GFQlk93pFcWJpEHeZgnD1lEPAwcgx18mVKt1o61HH
         P2YPwUpKzPfoss2NvCDSO7W85C1EIDhBzmUGpZ5glMhi1HgGMre89UBUOJJIx3Z9jGqR
         q+9BGnp5huINKZcZ+Gq/4xF7FmXTGlBainrI1Fghr1RbOD5H9OefQeSvHbgfhZmrcoAN
         Jq1A==
X-Gm-Message-State: AOAM533SeDSCGejOLopnvoxHoMUR/lFkHwA179TL6bmES57KUyKbSYh3
        Ed5cvPhIiQ1GDIerpqZ5mpp0QFsA+7WsZg==
X-Google-Smtp-Source: ABdhPJzipU2aYy8zLl1JHLwWxix29Qwr4k2MUI3XXWyDjS+c22T4ftRzNo0aDZ3HcKvm3DTCDFQgCw==
X-Received: by 2002:aca:3986:: with SMTP id g128mr23211393oia.126.1620858506459;
        Wed, 12 May 2021 15:28:26 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id i2sm242886oto.66.2021.05.12.15.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 15:28:26 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/8] doc: simplify the handling of interruptions
Date:   Wed, 12 May 2021 17:27:59 -0500
Message-Id: <20210512222803.508446-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512222803.508446-1-felipe.contreras@gmail.com>
References: <20210512222803.508446-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to have an intermediary file.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoc-helper.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/asciidoc-helper.sh b/Documentation/asciidoc-helper.sh
index ae16cf9288..8dbe4fc372 100755
--- a/Documentation/asciidoc-helper.sh
+++ b/Documentation/asciidoc-helper.sh
@@ -13,6 +13,5 @@ while [ $# -gt 1 ]; do
 	shift
 done
 
-rm -f "$out+" "$out" &&
-"${args[@]}" -o "$out+" "$1" &&
-mv "$out+" "$out"
+"${args[@]}" -o "$out" "$1" ||
+{ rm -f "$out"; false; }
-- 
2.31.1

