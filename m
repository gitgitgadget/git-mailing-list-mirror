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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B65C43461
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A58F61419
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbhELXYb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349236AbhELWbA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 18:31:00 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA506C06135C
        for <git@vger.kernel.org>; Wed, 12 May 2021 15:28:33 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so965169otc.12
        for <git@vger.kernel.org>; Wed, 12 May 2021 15:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nqw2y/pqNvSLw3F8UEyGa8EcMg68LKfAI9NUur5dpcg=;
        b=WKNlfzqybgmIzsO8ijop1uphKUbJafqQFTd2jeBVf1C6x56sc3lEv97DaU5po9J5SC
         nP/2feQ4wsW+giT5KHI+dObnOlCVFwTZdmQJYGa9CWHSTXarc6wf8Sab/8h3dWJTRgoH
         Pc6OJuQCLtT7u4SgX/xc++esF44vj+c79C8/y9VSZ5udZGYMfx7KXwlwzx+VLJh+8Trx
         ScVqTLsnRBQ38MCSHqSolf081xAHUY6XQaaeQ/+mOEnsCkYhutMyRDw/FrMQacalOJW8
         thM6VBV5wl4VdYV0BBu6fnSgf6L6HoMu0bDNvjsYlhePKXzoZe9uPnxMxrxx+24HGyV/
         Ni5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nqw2y/pqNvSLw3F8UEyGa8EcMg68LKfAI9NUur5dpcg=;
        b=kDqJvC1xapIO/a5dtL/zA5G2rUfJDVOpHNA6j0xs6NnMzaR3wYkMGVwXE0bZftoRb2
         rNOWFepJgVa0CYSEq4xXGp1+7bUaJPQy1Ed44aDW0UExkpFiT0nMsWsXU+mF3E+P7QN1
         FkAkJkwz6JeEV2QmFJSSTMrJ1UX71aWaO/hBHrfkW5LVpxfou3T2Nkde93NmfuMvMhxh
         3lwbaNhY/xJHuXQR/d4maK7wPV9FJdcSjvdP75whdcjWX567ca9HEfpL8BF5+0frI5Mu
         RMnn0RNAhYFvMctHGOfFOGqSJkM+uzfHgIxcVQjDroFikugkQ2y/OO05CrWy4nqk3kqB
         mwPQ==
X-Gm-Message-State: AOAM531pEK+uW1gkMInubdW/QyMgSYLPUpYvUcz2y9NQZKl5NTSEyYiM
        e72Pcqrvgn6SJHuEcmhvjsRFhzNi+ZHBew==
X-Google-Smtp-Source: ABdhPJzZjDTbjref70GyZAfRhTBhQHfmSEveb4fkISmd8OSNAMd7k5XEysbnViSpfCVSjKTyGGOmRg==
X-Received: by 2002:a9d:68d8:: with SMTP id i24mr31488120oto.347.1620858512973;
        Wed, 12 May 2021 15:28:32 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id c18sm266919otm.1.2021.05.12.15.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 15:28:32 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 8/8] doc: join xml and man rules
Date:   Wed, 12 May 2021 17:28:03 -0500
Message-Id: <20210512222803.508446-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512222803.508446-1-felipe.contreras@gmail.com>
References: <20210512222803.508446-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Will be useful later with asciidoctor that can do both at the same time.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ba0c947d0d..d5ea05295d 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -367,11 +367,9 @@ $(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
 manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
 
-%.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
-	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
-
-%.xml : %.txt $(ASCIIDOC_DEPS)
-	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@ $<
+%.1 %.5 %.7 : %.txt $(ASCIIDOC_DEPS) manpage-base-url.xsl $(wildcard manpage*.xsl)
+	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $*.xml $< && \
+	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $*.xml
 
 user-manual.xml: user-manual.txt user-manual.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d book -o $@ $<
-- 
2.31.1

