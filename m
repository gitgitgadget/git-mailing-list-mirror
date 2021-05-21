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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B139C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41451613DF
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhEUWq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhEUWqY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:46:24 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F2EC061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:45:00 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id s19so21103644oic.7
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4RIpdrU1N/77rHbTO+YiD6Wn20KglLZhdWjVGVvUy28=;
        b=sIh4zDZbiEMyhrd4JqFivmIWBsycDyG2CSqEsQOBfLSfU4rNQieg6NXQKtfec4xZg/
         J9gAzNDUwJKvAf1bJfcmZwFi+F9NUrJ2OnBEkDWfQ33njtfRUWwyzzVmBcuL7iE/dt4A
         dfFHFEC6crOtzejFZ9+FBNj4dTEu2DfiRrNAuuc8EVBOZXsWKTaSkuBv83dCw/O76u9r
         a707SfuxfSKcI5MgFAE0yE1/huH9kk+ngGuK0sV2RqBQWFPJRK+PhCBCko9tG3LWiEYP
         y6PU4PB3EcQGWoeL5MKHJMUMlE/NLb+WEAHDyflwkpVD26g8KCIR0vFEQ7vl4CsXMY1t
         EdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4RIpdrU1N/77rHbTO+YiD6Wn20KglLZhdWjVGVvUy28=;
        b=UjPfATkplQtiuPC6lw55Jy8fNywO/fxYpSVi7VK+siZcuGiP1I2ldYw/SBgcdnTTgI
         OU0c5CKpIMNSybGQFC0Auxy7mfokIreLQxpTGU68kmrlOinQEd+T2sWYmj1MZpsRajhJ
         RW2HwBVJ8BJKS/BSOYN+epFXFjtDdKbi/vZAAfLff6yVwf+FNb8WGDqv9XSP3rrXaLUX
         47K1oxfuI8Sv/+pIo1iXcG8lRZc7P+i/MQCx3+WVqtmqP3Pwkn8Kp/YVcFeqlUMvGIIv
         NPgPX6HBDfu41bRHB5sa9/r4pg3syb1VnIOjtRAJV3aoCfuTjxNzw80e77rXjoyEywRS
         C/JQ==
X-Gm-Message-State: AOAM5303LY4Iw87USLQQy/KZ2tWwfbB97DaGJ4UfaHiObfZPOX4vVJSk
        TLt+dT6WLpGj0Ym3hkSigmqx8xbFs/Mf2g==
X-Google-Smtp-Source: ABdhPJw/4aX4taKwwjsMxJh2cUObIRQGuhtImZMBf3lrCxcFqbU8+PKoGEblNksnoi10l1aRwyVI1A==
X-Received: by 2002:aca:da8b:: with SMTP id r133mr3729816oig.36.1621637100033;
        Fri, 21 May 2021 15:45:00 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id b81sm1374816oia.19.2021.05.21.15.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:44:59 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2 03/11] doc: use asciidoctor to build man pages directly
Date:   Fri, 21 May 2021 17:44:44 -0500
Message-Id: <20210521224452.530852-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521224452.530852-1-felipe.contreras@gmail.com>
References: <20210521224452.530852-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to use xmlto to build the man pages when modern
asciidoctor can do it by itself.

This new mode will be active only when both USE_ASCIIDOCTOR and
USE_ASCIIDOCTOR_MANPAGE are set.

Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b68ab57239..0c654f4ec9 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -189,6 +189,9 @@ ASCIIDOC_DEPS = asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 DBLATEX_COMMON =
 XMLTO_EXTRA += --skip-validation
 XMLTO_EXTRA += -x manpage.xsl
+ifdef USE_ASCIIDOCTOR_MANPAGE
+TXT_TO_MAN = $(ASCIIDOC_COMMON) -b manpage
+endif
 endif
 
 SHELL_PATH ?= $(SHELL)
@@ -324,7 +327,7 @@ mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
 		show_tool_names can_merge "* " || :' >mergetools-merge.txt && \
 	date >$@
 
-TRACK_ASCIIDOCFLAGS = $(subst ','\'',$(ASCIIDOC_COMMON):$(ASCIIDOC_HTML):$(ASCIIDOC_DOCBOOK))
+TRACK_ASCIIDOCFLAGS = $(subst ','\'',$(ASCIIDOC_COMMON):$(ASCIIDOC_HTML):$(ASCIIDOC_DOCBOOK):$(USE_ASCIIDOCTOR_MANPAGE))
 
 GIT-ASCIIDOCFLAGS: FORCE
 	@FLAGS='$(TRACK_ASCIIDOCFLAGS)'; \
@@ -349,8 +352,13 @@ $(MAN_HTML): %.html : %.txt $(ASCIIDOC_DEPS)
 $(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -o $@ $<
 
-%.1 %.5 %.7 : %.xml $(wildcard manpage*.xsl)
+ifdef TXT_TO_MAN
+%.1 %.5 %.7 : %.txt $(ASCIIDOC_DEPS)
+	$(QUIET_ASCIIDOC)$(TXT_TO_MAN) -o $@ $<
+else
+%.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
 	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
+endif
 
 %.xml : %.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@ $<
-- 
2.32.0.rc0

