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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D8EC48BC2
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA4461042
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhFURBm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbhFURBF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:01:05 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEFAC0A8876
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:52 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id s17so11741482oij.11
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fvtFQaw+ScZVTsyWtHUjq0DT9jI61mpCfMRbeEEjrNc=;
        b=Fe4TYAKBL9uIGo1vHdmCRz8sdJgq9AGAgWg2m6RcXIF9iBiqMZxt1J9FqTZiKLE4Z7
         9QvBXC5uwO2C3VNAivQY0gQRHlb+8fVTLZEAFpixdnmHTePqrAAsTYCPfPQo8lph/TnN
         VnnEhOI5BduB/Qap+OnA8zSV0cOncL0TM3MCZQMdfQPlV/1UQwlijNZY+6pK7OYl6GH9
         2G7lvHdAlVF0zk08ON53bJ6ZOw5V35Acy9+EAWh02h8JRvXB0cy3jo00rViN7jJZjn4A
         TGFaqoQ5+ks/MSM1aSZlujnHCb+M0sVDarZpY45wRyKU2nn8ekzoonsRpOycIPXKx7cm
         T4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fvtFQaw+ScZVTsyWtHUjq0DT9jI61mpCfMRbeEEjrNc=;
        b=jpuCVDmxvSVbtHrg9wCV+OLbHkAFUAmxQZFHX5ZaBypDkhD/+ni+j9DtcliE03eoBX
         Dae3hu6w6+8baOqpdK4Xkt982dV+3tv8+BC2HjQKSkqayC9QR27RWj2BeVLF6sTjK5on
         iUGx3Vx9N3rQotOtaQgsmfIG2fgI2RNVtcjS4T5avOZCjX3atRzH7C8FiVGiuIdLuL0K
         3SqLJ7DdQpteC6YwjE5oDx0es2H850+GyjiWm8CYwg9KvoXCB7IlvUtQoVUneNnfhu9u
         6GhR+Y/8a0VCaAoPWbs49dJTUkkIjLgv+hVvZ3P4kQjP/ZI222cTnMpb7u4d5JGcSkA9
         Ip3Q==
X-Gm-Message-State: AOAM530tqNk7zXd3zZmir74pizqdkViu7ll0szfVtC48t+ZiVeCzCuoS
        Wk57BWKL66WPeQiTF6UpFP0alXSntJs2Kw==
X-Google-Smtp-Source: ABdhPJxD031LAvQ4hTtPDY9gKrYwXZp0/b/ixFRWaMkyW25639uQ2qXpVHCkwNYQmGb4UPhFCJh+kA==
X-Received: by 2002:aca:f5d6:: with SMTP id t205mr17886485oih.58.1624293111419;
        Mon, 21 Jun 2021 09:31:51 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id b22sm3724016oov.31.2021.06.21.09.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:31:50 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 15/23] doc: use asciidoctor to build man pages directly
Date:   Mon, 21 Jun 2021 11:31:02 -0500
Message-Id: <20210621163110.1074145-16-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
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
Suggestions-by: Jeff King <peff@peff.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile | 10 +++++++++-
 Makefile               |  4 ++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b68ab57239..e6af1848cc 100644
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
 
+ifdef TXT_TO_MAN
+%.1 %.5 %.7 : %.txt $(ASCIIDOC_DEPS)
+	$(QUIET_ASCIIDOC)$(TXT_TO_MAN) -o $@ $<
+else
 %.1 %.5 %.7 : %.xml $(wildcard manpage*.xsl)
 	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
+endif
 
 %.xml : %.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@ $<
diff --git a/Makefile b/Makefile
index 7588c43f05..ab3fa362b7 100644
--- a/Makefile
+++ b/Makefile
@@ -281,6 +281,10 @@ all::
 # Define USE_ASCIIDOCTOR to use Asciidoctor instead of AsciiDoc to build the
 # documentation.
 #
+# Define USE_ASCIIDOCTOR_MANPAGE to use Asciidoctor's manual page backend
+# instead of building manual pages from DocBook (using xmlto). Has no effect
+# unless USE_ASCIIDOCTOR is set.
+#
 # Define ASCIIDOCTOR_EXTENSIONS_LAB to point to the location of the Asciidoctor
 # Extensions Lab if you have it available.
 #
-- 
2.32.0

