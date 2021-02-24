Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92200C433E6
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B02364F0D
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbhBXT6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbhBXTyf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:54:35 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B7CC061A28
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:21 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id n4so3060590wrx.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qx7MgCeeFbGnardhIUUvIZHDrxcn4oD0CO88xRoqRvQ=;
        b=bVqYvkYdTIj83no1BE61TKxpFECKCbwxryQQZscUORu0IvPcbj11GK5M2lYBQXHpXe
         Ofxw40Gh3qiJsKAipA2DwQsB0s63JhQ7AwXBXDJq/M25gUfMuUJW3Qun6OrfIhDlSBk9
         a/7q6CAHJJ6QDPsyoSY4fXZx0nAJtoWxBq7uGBi/VQusa0o1MYEXUO6iN8IyilWlVVRh
         QrN6PnOqvQy72XiWVlZZLS0n3UzNdeEssX50jJNqaNyLsBehcrD+yXqPLTOWlO1RME7D
         +W90A97Ed4l7qFfM6ieDTmKZBEpc9BSZ0y9X16GVXXtndMR9qYJFZYOW9Z8YdH4HwEJV
         yTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qx7MgCeeFbGnardhIUUvIZHDrxcn4oD0CO88xRoqRvQ=;
        b=RNvwR2PC7MRVVldKux8ZSJht6IeHljLpjaDOAsQfChzCr6z7rApRyArhH7ibuJsdAC
         j68hC/tEvLImoP1XrXsE3lMo4KLarEJAA4hloY143FrWZCED1vkaH5uKHL4Pxo+vsiC1
         InD6lPSRV/VQ+e1jWAGJWSUKgk29WRNFwpBdu4p300Z9Cx5EXi7aRX1MF225YY4PCYpr
         5qJq7HXhaORPfIyw4sfTBIFL0gev7Zzsoa9a32fp2fRsoJYAk3jpHZAjRvPC/EkJAuNF
         zyrc110d2KKouW0G/LUJ4i/epRp4KEH6DLuOP16+duORcd9lsdOq1hT0W6R33TWt6kvM
         6BGQ==
X-Gm-Message-State: AOAM5316QdO6Jd14wMfxPmlF+CZPedjg1O+os+tg9l1vRUsihOKBxqK2
        vsr5WFzK+C16BLDozz6xjCRYtvf6+SRV1g==
X-Google-Smtp-Source: ABdhPJyZD9mQp2QdTvXY1k6QcfEE4PnIK03NmsoTFnzjzmaA7ArZOOHJWyqyShFvOOOf8sZhRQxIUQ==
X-Received: by 2002:a5d:4050:: with SMTP id w16mr9968157wrp.21.1614196339817;
        Wed, 24 Feb 2021 11:52:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 32/35] userdiff golang: add a rule to match "package"
Date:   Wed, 24 Feb 2021 20:51:26 +0100
Message-Id: <20210224195129.4004-33-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the "golang" built-in pattern to match "package" lines, as
they weren't matched before changing e.g. the imports would commonly
result in an empty hunk header, now we'll instead show the package
name.

I used https://blog.golang.org/package-names as a guide here, but
e.g. "foo_bar" is still valid syntax, so let's let it pass but veer on
the side of not having false positives.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018/golang | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 userdiff.c     |  2 ++
 2 files changed, 51 insertions(+)

diff --git a/t/t4018/golang b/t/t4018/golang
index 252b6049da4..38f254cd269 100644
--- a/t/t4018/golang
+++ b/t/t4018/golang
@@ -1,3 +1,52 @@
+t4018 description: package
+t4018 header: package main
+package main
+
+import "fmt"
+// ChangeMe
+
+t4018 description: package regex is selective -- ALLCAPS
+t4018 header: package main
+package ALLCAPS
+
+import "fmt"
+// ChangeMe
+
+t4018 description: package regex is selective -- CamelCase
+t4018 header: package main
+package CamelCase
+
+import "fmt"
+// ChangeMe
+
+t4018 description: package regex is selective -- 123
+t4018 header: package main
+package 123
+
+import "fmt"
+// ChangeMe
+
+t4018 description: package regex is not overly selective -- x509
+t4018 header: package x509
+package x509
+
+import "fmt"
+// ChangeMe
+
+t4018 description: package regex is not overly selective -- underbars
+t4018 header: package not_conventional
+package not_conventional
+
+import "fmt"
+// ChangeMe
+
+t4018 description: package regex is not overly selective -- camelCase
+t4018 header: package camelCase
+package camelCase
+
+import "fmt"
+// ChangeMe
+
 t4018 description: complex function
 t4018 header: func (t *Test) RIGHT(a Type) (Type, error) {
 type Test struct {
diff --git a/userdiff.c b/userdiff.c
index 704af241e44..bbbbfa33e0a 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -128,6 +128,8 @@ IPATTERN("fountain",
 	 /* -- */
 	 "[^ \t-]+"),
 PATTERNS("golang",
+	 /* Packages */
+	 "^(package[ \t][a-z][A-Za-z0-9_]+)[ \t]*\n"
 	 /* Functions */
 	 "^(func[ \t].*)\n"
 	 /* Structs and interfaces */
-- 
2.30.0.284.gd98b1dd5eaa7

