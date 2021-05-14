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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40626C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1524D6144C
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbhENMQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 08:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbhENMP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 08:15:56 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280B1C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:44 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id v22so23384782oic.2
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=otm/PrI+MiTE4j38696D4wY8wq/7XarYa+F8PkJSIps=;
        b=TBHLVCGd3snNxmyxktfDaleFa6cU0aa3rd6he7VU2I4Nru8lriLEUEo8xgfWU1x8EZ
         iTzbZm0zHW+I3/Vj3LS55DACDoVAjRy8gIGFdcX82IYVeBHw5HSEBoqM1iBuTDG/TEQy
         6/194/Vt20Y7gHOiiGVB+7Sjo+3ePWoynlVXZM9+rBeSwvaIWK8FaMZpCzlARvigTSbQ
         JXsdV6rolBR6IcaHENFGemh1VfwsXIyQB4wC6TzIcm2ZNcRlqGTpxY7t0wfEflO2/sgC
         z07tgsxpQnMvoKqm85eNm5aUPVQbEaePUbEgScfZpPb5raoTfjlGDaYhP//vSqdp7WRJ
         vclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=otm/PrI+MiTE4j38696D4wY8wq/7XarYa+F8PkJSIps=;
        b=K1nbrJcS0Tg8QBzf7fjsouSouHJmJ9SPvtw48ckgKcRJYOPo/enwJ0YEvrm6cYfaFT
         g4j26TIDHfrwy+XuN3PKQp8JoFhJpBlTfGEmF5IJT0SMHvKjgRqtjixAPNQiSgsAjYPi
         H0rM9pGQ/CQn68owoT8fZRDBf7vZYI6fXJtdYqN8eta8oA6bhHOoEt6/ODBC6l5wF98N
         9/D9+1i2uizumDLucMN8+QOXEHCMmI5/w9g9w7NUg0xTgpK0wlssqCZADWTw/Z4K1QdN
         ovpBucNTZjaoDo+62QrOU3h3qTmRSrZHOaI/vo3EwRciNAZMyagwFRgNZCb2B9gTrGEz
         h80A==
X-Gm-Message-State: AOAM530+lzJzPBIJ87AYUzc2SGtEMuG/FcXgpvUDpaEaSsXnJVQvsgwA
        pvTA1IxAwH0ornlgiidT/8Ybm9EJKPM+aA==
X-Google-Smtp-Source: ABdhPJxCvSfyBoPXiXIpE3Tj+Zdu7qeyNl3R8XRhOJFRGv0a2hS+2nlI0+o8FqVMg4YQ3USPcydadQ==
X-Received: by 2002:aca:4ec4:: with SMTP id c187mr32495557oib.34.1620994483371;
        Fri, 14 May 2021 05:14:43 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id h9sm1288489otn.56.2021.05.14.05.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:14:43 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 04/11] doc: use asciidoctor to build man pages directly
Date:   Fri, 14 May 2021 07:14:28 -0500
Message-Id: <20210514121435.504423-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210514121435.504423-1-felipe.contreras@gmail.com>
References: <20210514121435.504423-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to use xmlto to build the man pages when modern
asciidoctor can do it by itself.

This new mode will be active only when USE_ASCIIDOCTOR is set.

Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 981e322f18..ce9cea0817 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -198,6 +198,7 @@ ASCIIDOC_DEPS = asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 DBLATEX_COMMON =
 XMLTO_EXTRA += --skip-validation
 XMLTO_EXTRA += -x manpage.xsl
+TXT_TO_MAN = $(ASCIIDOC_COMMON) -b manpage
 endif
 
 SHELL_PATH ?= $(SHELL)
@@ -362,8 +363,13 @@ $(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
 manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
 
+ifdef TXT_TO_MAN
+%.1 %.5 %.7 : %.txt $(ASCIIDOC_DEPS)
+	$(QUIET_ASCIIDOC)$(TXT_TO_MAN) -o $@ $<
+else
 %.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
 	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
+endif
 
 %.xml : %.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@ $<
-- 
2.31.1

