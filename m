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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AACAC49361
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 20:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 513CA61284
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 20:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhFRUdQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 16:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhFRUdO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 16:33:14 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653C3C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 13:31:03 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id m137so11887239oig.6
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 13:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dhzsJpzf2MVeOFaXgmv0bV0xP862X5eYHOBB1JjtAOg=;
        b=uVEuDVyi7X10TYxvSV+BtVAAMDjN9ssnjDzRIWvCyFX70/ohbS2CxCe02zCSm/i6O5
         cUYfmGWgk2oz9j3QItUYGdnoWWyfsq9To7+nUTqTPHbRisivsICXVhK2PzpPNyGXNXdO
         ewkHWQPDyeyjpoPOv+zSHL7AU8yfnlYXOi+c7K/jSOzG9I6t9ufwnRehpDZLU1zibuQ2
         o5lPsDji5e6gnqd/cvY/tLdRhYI+rOrYmGiMCsyLGNJPX9cKSMugrA558/lwJLTEe9zw
         oygkq/ljjnkwt39A/W/HreW/2417I/gIMmRa9Q09zgo9geaF6fLcWs+YBtq9Qrnln++z
         qsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dhzsJpzf2MVeOFaXgmv0bV0xP862X5eYHOBB1JjtAOg=;
        b=LBr8mgUMtV2O89DR5O/Zbt4qL2lhL1PaH/oq7Z+38FDIBk884pDqJNhJ9dkiODnfi2
         de7lOWqeEydErmRQjB5TX4vIznK3cIBo69AvD+phDGvmjFC7d9hM89Ab9E67VGNvYyRf
         MPGmKavEfdejoFpMLkgHQ7s/ds+nZDkfaVzRAH2Cj92je8fFZs5cdgLQiAwQW8EHaysc
         4ZGEEBYs0o2h0OvqdR2qluy6e5LlEnl8rjH3behrr4eSo1pB39pPYiUAESo857R/LSIt
         sQCqZfvH5aZKNLmAkXz5cQaEqZNrfHnWuZLmbGQctjCOcru+nsYGbJFFBSbhbTKO2C8Z
         uowA==
X-Gm-Message-State: AOAM530BExAoKMcUhM91UQP7fkymQt6CGshbkiEwPJQ8iEhGQphNlWL3
        Dt/tQwu+73ZBAGqijHj6qIn2U0wRGcdDpg==
X-Google-Smtp-Source: ABdhPJzjDgP4RylV84d1Yk8n5qtSQcYtBFAJqFgM/2+E2i+7SDJNsJ0mRtZjq2mDht/rY9dPh3sYLg==
X-Received: by 2002:aca:dac5:: with SMTP id r188mr16251402oig.100.1624048261116;
        Fri, 18 Jun 2021 13:31:01 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id e19sm2021298oiw.24.2021.06.18.13.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 13:31:00 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/NOPATCHv3 1/4] doc: add an option to have Asciidoctor build man pages directly
Date:   Fri, 18 Jun 2021 15:30:54 -0500
Message-Id: <20210618203057.790320-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618203057.790320-1-felipe.contreras@gmail.com>
References: <20210618203057.790320-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Asciidoctor contains a converter to generate man pages.  In some
environments, where building only the manual pages and not the other
documentation is desired, installing a toolchain for building
DocBook-based manual pages may be burdensome, and using Asciidoctor
directly may be easier, so let's add an option to build manual pages
using Asciidoctor without the DocBook toolchain.

We generally require Asciidoctor 1.5, but versions before 1.5.3 didn't
contain proper handling of the apostrophe, which is controlled normally
by the GNU_ROFF option.  This option for the DocBook toolchain, as well
as newer versions of Asciidoctor, makes groff output an ASCII apostrophe
instead of a Unicode apostrophe in text, so as to make copy and pasting
commands easier.  These newer versions of Asciidoctor (1.5.3 and above)
detect groff and do the right thing in all cases, so the GNU_ROFF option
is obsolete in this case.

Because Asciidoctor versions before 2.0 had a few problems with man page
output, let's default this to off for now, since some common distros are
still on 1.5.  If users are using a more modern toolchain or don't care
about the rendering issues, they can enable the option.

Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Original-patch-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/Makefile | 12 +++++++++++-
 Makefile               |  4 ++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 81d1bf7a04..d3103c3dde 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -187,6 +187,9 @@ ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
 DBLATEX_COMMON =
 XMLTO_EXTRA += --skip-validation
 XMLTO_EXTRA += -x manpage.xsl
+ifdef USE_ASCIIDOCTOR_MANPAGE
+TXT_TO_MAN = $(ASCIIDOC_COMMON) -b manpage
+endif
 endif
 
 SHELL_PATH ?= $(SHELL)
@@ -325,7 +328,7 @@ mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
 		show_tool_names can_merge "* " || :' >mergetools-merge.txt && \
 	date >$@
 
-TRACK_ASCIIDOCFLAGS = $(subst ','\'',$(ASCIIDOC_COMMON):$(ASCIIDOC_HTML):$(ASCIIDOC_DOCBOOK))
+TRACK_ASCIIDOCFLAGS = $(subst ','\'',$(ASCIIDOC_COMMON):$(ASCIIDOC_HTML):$(ASCIIDOC_DOCBOOK):$(USE_ASCIIDOCTOR_MANPAGE))
 
 GIT-ASCIIDOCFLAGS: FORCE
 	@FLAGS='$(TRACK_ASCIIDOCFLAGS)'; \
@@ -358,9 +361,16 @@ $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf asciidoctor-extensions.rb GIT-AS
 manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
 
+ifdef TXT_TO_MAN
+%.1 %.5 %.7 : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
+	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
+	$(TXT_TO_MAN) -o $@+ $< && \
+	mv $@+ $@
+else
 %.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
 	$(QUIET_XMLTO)$(RM) $@ && \
 	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
+endif
 
 %.xml : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
diff --git a/Makefile b/Makefile
index f3dc217832..48547e2c3b 100644
--- a/Makefile
+++ b/Makefile
@@ -285,6 +285,10 @@ all::
 # Define USE_ASCIIDOCTOR to use Asciidoctor instead of AsciiDoc to build the
 # documentation.
 #
+# Define USE_ASCIIDOCTOR_MANPAGE to use Asciidoctor's manual page backend
+# instead of building manual pages from DocBook (using xmlto).  Has no effect
+# unless USE_ASCIIDOCTOR is set.
+#
 # Define ASCIIDOCTOR_EXTENSIONS_LAB to point to the location of the Asciidoctor
 # Extensions Lab if you have it available.
 #
-- 
2.32.0

