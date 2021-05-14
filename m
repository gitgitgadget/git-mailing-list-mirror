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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F81C43460
	for <git@archiver.kernel.org>; Fri, 14 May 2021 11:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8131B6145B
	for <git@archiver.kernel.org>; Fri, 14 May 2021 11:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhENL5s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 07:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbhENL5q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 07:57:46 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68645C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 04:56:35 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id d21so28191888oic.11
        for <git@vger.kernel.org>; Fri, 14 May 2021 04:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vM2nExltCWHwJPmH7xMl/ZfvBQfSvcO2uafEBnoTvk4=;
        b=NvJ2+9WFCFSt9oPtdq6bX52qZpB6Hbiw9aQ5gdeSC58UJW1adMwEn+iK8z85ZcnQXg
         EIe9MYlc/DPwCl4mB24OxDaMB75+M6NAt0SMzXVY/hunxMlaho03TulCrzlV0OIy+Dbu
         L9k9Lusm9gXsNH8EsKplbuXBoZ36Hfxy/jb+WOkOhaWEhSzwWN7wyZ1In+tGv4UnCfCN
         cQ22F6ToUYjIUodRS6Rj4uyn1+kdUqOCTNpEiUjEypbuActUABGKk7Q/zPzQ0rjb7zZP
         AmtEKjV5q5gcI0WGQXnpk83kGM7Nspg9PIx46Wa/1tDhof8SrJwXKLaUL/aWenAam/ab
         8r3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vM2nExltCWHwJPmH7xMl/ZfvBQfSvcO2uafEBnoTvk4=;
        b=fsrTRA9QgjMEh64JVadjXYexmtdhlqro8kch9dzm0Y6Ui0Gn5zMv9HKBYIfhMexw/R
         cM3aLSRkWsfmN8shzUxSVaR6JTzhUus/z6tZObsuvfzmvEMeekd5fRpN8+FLnncAutI2
         PFiCvaqqkormuJ1e/+KDnLeSF6LU0P1yxPBvkyUaxVlLInXrazoldrqBXGowZhAnfQ7A
         6OWanjXcqnDQbWB+m8YlKFwxo70Deqojv80CasATg/l2fsbpNqcSb8ZQEUC/5q36ymQz
         LqWsk3GqgMSQuZ8whtZje9wtLngJeYW4oQe27BOk95m0maVrXP4QC8umMvk22KeXugvy
         kB9w==
X-Gm-Message-State: AOAM533fQQ5um2xTOaWcyShFFVk8aLzICInP59uCbqHTp36CgiOLb9LK
        wdCs8fxz7yFggBnUb40pIM4O7CHoOk4NFQ==
X-Google-Smtp-Source: ABdhPJw+eHxInavleCl3TaYABT+E3vDt+oS2KGNZb4L5zZAYkOCPhBs7LidTgiujQgWSNUUX8vGh6A==
X-Received: by 2002:a05:6808:90d:: with SMTP id w13mr19109304oih.71.1620993394642;
        Fri, 14 May 2021 04:56:34 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id i18sm1251122oot.48.2021.05.14.04.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 04:56:34 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/5] doc: refactor common asciidoc dependencies
Date:   Fri, 14 May 2021 06:56:27 -0500
Message-Id: <20210514115631.503276-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210514115631.503276-1-felipe.contreras@gmail.com>
References: <20210514115631.503276-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2aae4c9cbb..46d9b98dac 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -139,6 +139,7 @@ ASCIIDOC_CONF = -f asciidoc.conf
 ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
 		-amanversion=$(GIT_VERSION) \
 		-amanmanual='Git Manual' -amansource='Git'
+ASCIIDOC_DEPS = asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
 TXT_TO_XML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_DOCBOOK)
 MANPAGE_XSL = manpage-normal.xsl
@@ -354,12 +355,12 @@ clean:
 	$(RM) manpage-base-url.xsl
 	$(RM) GIT-ASCIIDOCFLAGS
 
-$(MAN_HTML): %.html : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
+$(MAN_HTML): %.html : %.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(TXT_TO_HTML) -d manpage -o $@+ $< && \
 	mv $@+ $@
 
-$(OBSOLETE_HTML): %.html : %.txto asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
+$(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(TXT_TO_HTML) -o $@+ $< && \
 	mv $@+ $@
@@ -371,7 +372,7 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_XMLTO)$(RM) $@ && \
 	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
-%.xml : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
+%.xml : %.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(TXT_TO_XML) -d manpage -o $@+ $< && \
 	mv $@+ $@
-- 
2.31.1

