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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4972C43462
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A00F9613FC
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbhELXZE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349244AbhELWbD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 18:31:03 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E61C06135B
        for <git@vger.kernel.org>; Wed, 12 May 2021 15:28:31 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id j17-20020a4ad6d10000b02901fef5280522so5302560oot.0
        for <git@vger.kernel.org>; Wed, 12 May 2021 15:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ym+MWgF924aCoZ51mW3fCtqE76Q4XN3TZOt/auLypzs=;
        b=C5nZE24d1kqyhttw1bU91Rz3hKWhxfGxLFdMrOyyIJCHmoq9EyIgplPV49ddYLUOzY
         ZeVa6xMp7AOhR7ImczB/UXKurL1NgIfoij9cVJM7pFwYBKQJ8Vm+Syn+AEO19+W6LNAi
         VPglRNT1ifo+FCfMLE0YL+D05hrBakJIpZ7jYdGV5UyRAS70G73O2b39smSikq2DY4j/
         UjoSaTW9SvU99sXc80tCKZXrmOenk8B2UKwVJ0JzF/r5oQL86Qe612ktpCkTNrXQjUTG
         saSNTiHfC2ZTV4ld0kgY8RVc7KOFZ8+bQtN1UB1Qn/qre1hJyPlADujtXt9WutM3PnZL
         X9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ym+MWgF924aCoZ51mW3fCtqE76Q4XN3TZOt/auLypzs=;
        b=ZrSCHBV6Q0r0U5Ac5WS9C7sTMD5EtXeLJrXjZ6buKWhPYRDHwoKBOSPnEJtH2zHhpW
         3/rF3XRgj7mNHzk2AJw/gENWJiiMtbmeDVWe2823DB2zxFcJA/z1kCQ7ZhbNs9mp6G1V
         TqIpx2mkbKVaOeZJt7xlL6Y+kqeskh5+3DboY3UG6x4N2hzOx9b/FlVxC+PtkVbYj0kj
         /vNq1hM+6rGgo4v0MNV2Q1AUyCfZpmtoqoetAhISfbxIJWgvJ2tcifnQksOiF4LqFLPU
         KJ+783CtxqfavIdi9/+QZE2+nmH+ui+FkwXEnd6y5UIEpHTkz+AD/d3SHmVWa82ZdORM
         A5/w==
X-Gm-Message-State: AOAM530HGUMoIiv+XwVT374Kw5tXk70eUp+QRDLcFsnCgayZQwKLGV/o
        PC0LRyLLkUarrGaPQe26F7w6oqZwUAGP3g==
X-Google-Smtp-Source: ABdhPJyBX7moUuAYD9UotojfHbnKbZkGrgzz8Xsz7rZUSspdf9n6E4O/yMLTd23XTyDxdENh8Iqjyg==
X-Received: by 2002:a4a:e715:: with SMTP id y21mr29587911oou.54.1620858511162;
        Wed, 12 May 2021 15:28:31 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id k16sm253666otp.19.2021.05.12.15.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 15:28:30 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 7/8] doc: improve asciidoc dependencies
Date:   Wed, 12 May 2021 17:28:02 -0500
Message-Id: <20210512222803.508446-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512222803.508446-1-felipe.contreras@gmail.com>
References: <20210512222803.508446-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

asciidoc needs asciidoc.conf, asciidoctor asciidoctor-extensions.rb.

Neither needs the other.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f846bb91ee..ba0c947d0d 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -140,7 +140,7 @@ ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
 		-amanversion=$(GIT_VERSION) \
 		-amanmanual='Git Manual' -amansource='Git'
 ASCIIDOC_BASE = '$(SHELL_PATH_SQ)' ./asciidoc-helper.sh $(ASCIIDOC_COMMON)
-ASCIIDOC_DEPS = asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
+ASCIIDOC_DEPS = asciidoc.conf GIT-ASCIIDOCFLAGS
 TXT_TO_HTML = $(ASCIIDOC_BASE) -b $(ASCIIDOC_HTML)
 TXT_TO_XML = $(ASCIIDOC_BASE) -b $(ASCIIDOC_DOCBOOK)
 MANPAGE_XSL = manpage-normal.xsl
@@ -196,6 +196,7 @@ ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
 ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
 ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
 ASCIIDOC_BASE = $(ASCIIDOC_COMMON)
+ASCIIDOC_DEPS = asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 DBLATEX_COMMON =
 XMLTO_EXTRA += --skip-validation
 XMLTO_EXTRA += -x manpage.xsl
-- 
2.31.1

