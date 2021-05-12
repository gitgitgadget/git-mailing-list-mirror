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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B35C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88383613F7
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbhELXYz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349231AbhELWbA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 18:31:00 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E10AC061359
        for <git@vger.kernel.org>; Wed, 12 May 2021 15:28:30 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so22101814otp.11
        for <git@vger.kernel.org>; Wed, 12 May 2021 15:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JxnRqq8v5j8Tz2qY3lw6NlZB75V+PHc0wJz/O5JYQ/8=;
        b=KivIM+Z4FPMlfyATCpOCWisuZLxnLTnRpo7SAOTX83zSXl8+SlcBE6F006h6BHN768
         ThoV2/zr42dQXqIi+olWEfiLhdMTqu3JEwbNSevlB/Jzrkl1qWt4if3i5wUzWvKs+fWH
         6+ZzRHLguvaKaG55FTMDJH8uvK4/d2dDKeTzAvvmfMj78bQnwg/OGLuV2AIu7qJODwBs
         x1N2jWUJEMblb0saNi5afSINv1glrdjGgwfqdBYx1idXY4ZaBw8mjHaIDajHjTPdrDt8
         GaFU5qUJ0gW9voJ/sYJGFGg+fZWH470Cfq3nw3oZbKZoorji/Zrrp67ZdoBOPAHrTJ71
         KtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JxnRqq8v5j8Tz2qY3lw6NlZB75V+PHc0wJz/O5JYQ/8=;
        b=FIMM98PT2UeRy5X/4m2IJyo2hpbQzkQpytn8TJ3JU+qsP2rAGMWr8fvI71f4ZmMFEK
         DomA2pM1R+JBlRX91q7Og1bnMqo5N/8kJzKYlbft+eGhdJuyMcAI/O3SAXNdM3fYZ4rL
         OfKD4tfPSEhYXJhlXCooE5J+Uo3U6mPrh0UMIqqUHn4vzKD0+7i/WcErMyHmSy1xIjuT
         nPwI+Bwn4G8gxynpIU2bBGNNlG/z7eXm+Pd6LK6olMxV3gDBCraHXe8iLojhFX9iEA3E
         lXgjdnXFUluB8RwVgr+i/x1xgGQqz+fMzQuHg33rmKH4vqvS3rs6Gq35jsdd9E7TqCrD
         EEPA==
X-Gm-Message-State: AOAM531+Vr9J1q8ZkrnXq+s9nfIMvkCQLo4E+7Peqt67invVVLdarCYG
        1slSoby3HmA6KAEjwHrNyJUrhIrSmztVbg==
X-Google-Smtp-Source: ABdhPJxUym3GwVYD26p1RtM3mRmQ4BiKFjalScgD+6P00sftBzMvcyzJfWAAGQrWS0EnOrcHTk4UTg==
X-Received: by 2002:a9d:7a99:: with SMTP id l25mr256053otn.97.1620858509749;
        Wed, 12 May 2021 15:28:29 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id t39sm299652ooi.42.2021.05.12.15.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 15:28:29 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 6/8] doc: refactor common dependencies
Date:   Wed, 12 May 2021 17:28:01 -0500
Message-Id: <20210512222803.508446-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512222803.508446-1-felipe.contreras@gmail.com>
References: <20210512222803.508446-1-felipe.contreras@gmail.com>
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
index d02bd848e8..f846bb91ee 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -140,6 +140,7 @@ ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
 		-amanversion=$(GIT_VERSION) \
 		-amanmanual='Git Manual' -amansource='Git'
 ASCIIDOC_BASE = '$(SHELL_PATH_SQ)' ./asciidoc-helper.sh $(ASCIIDOC_COMMON)
+ASCIIDOC_DEPS = asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 TXT_TO_HTML = $(ASCIIDOC_BASE) -b $(ASCIIDOC_HTML)
 TXT_TO_XML = $(ASCIIDOC_BASE) -b $(ASCIIDOC_DOCBOOK)
 MANPAGE_XSL = manpage-normal.xsl
@@ -356,10 +357,10 @@ clean:
 	$(RM) manpage-base-url.xsl
 	$(RM) GIT-ASCIIDOCFLAGS
 
-$(MAN_HTML): %.html : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
+$(MAN_HTML): %.html : %.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -d manpage -o $@ $<
 
-$(OBSOLETE_HTML): %.html : %.txto asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
+$(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -o $@ $<
 
 manpage-base-url.xsl: manpage-base-url.xsl.in
@@ -368,7 +369,7 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 %.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
 	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
-%.xml : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
+%.xml : %.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@ $<
 
 user-manual.xml: user-manual.txt user-manual.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
-- 
2.31.1

