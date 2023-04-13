Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0D3C77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjDML6M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjDML6C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:58:02 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09A7A5CA
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:57:57 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-183f4efa98aso23612931fac.2
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681387076; x=1683979076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXYPzqdVsRWbI3oRWnuN8D8jacrKJeOkaBJFBo6eV20=;
        b=Y5wC4x1VanLUzoymK7jnqVBgU/ATCEHooZ/P6yBuaB9qH7fWrp0qbEMP86ODaWicRJ
         TtQaUQ2opu2g6xK9x+9oKTXfJOzpn7+V4to4yKW1qQ9xx+QPUwDyKtbgxfMgTga+Ffuf
         BXG0aZKb4p8EFF6uXkMQ+Xca0nRTeOpAsxysjhPeeF6tBOQSpZcRA15D8zrOX893u9gi
         ZMbsCJuwKCpmiaRfaQX/v0A32UU4s9EE9nvAcFTtjnuOLoPaG7CHIqcmXCQJ8Wmvag0V
         e9RI9DTYVyvYrkl4GpgWrEWqqqUzbKvgRUmnND45k1dEfmLMetMlmMiujuPy2yVTdGER
         GQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681387076; x=1683979076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXYPzqdVsRWbI3oRWnuN8D8jacrKJeOkaBJFBo6eV20=;
        b=VJl9kIM6QPZcJtrQCKpsq8oKiGmYL9UBNgihg+5+r8C08+p0sDM8Lpk3HXek3cnu+d
         v5ro0/aGu9nRf4y5bDEgZDEKnLidh/qWc1LJ7Fpea8N7PXETyfBV8FPBiBAkXAmzKXoP
         cxxLIF7o04Nu/IxocI/9Mb2l1V7WweTyQZ90E6ZqU7v9KyIIN/RgruhAZcP1VZ3uPv5W
         d7Dtuks0KaXsF4UQUiAFqwPq3jUIVUuijxx8Gd5n9VFi8dt9yNLZRJ6gVK1hnJ7/Lz1T
         MfEjTBl8nx+j69pDliDcNmIi/kzD1U6QACKL0FbXtKc/HcV5M079bO6Iu69I8Xk6sPMG
         MB7A==
X-Gm-Message-State: AAQBX9fVHJeKOnyBRpmv1ZyQjjFLk30U/EG7a/1GxJfw3gJYHa3evv8f
        oLWc4bPLDwhSTap+x5To3DR62QYcWPk=
X-Google-Smtp-Source: AKy350ZfI51de/otlWJJ/DQz6G4oHAkBdJNJ6wYvR7f3PnCeD9jx6tk6XSj8Sbcgb+lvbYmo5Cd19w==
X-Received: by 2002:a05:6870:2196:b0:177:81bb:1b1b with SMTP id l22-20020a056870219600b0017781bb1b1bmr1473756oae.40.1681387076543;
        Thu, 13 Apr 2023 04:57:56 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id n3-20020a056870034300b0017f84f81f3csm597062oaf.52.2023.04.13.04.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 04:57:56 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Johnsen <chris_johnsen@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 07/12] doc: get rid of xmlto dependency
Date:   Thu, 13 Apr 2023 05:57:40 -0600
Message-Id: <20230413115745.116063-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230413115745.116063-1-felipe.contreras@gmail.com>
References: <20230413115745.116063-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't use any of its functionality, so all it's doing for us is
generate a stylesheet, which we are doing by ourselves now.

Use `xsltproc` directly.

This gets rid of some annoying warnings because my system doesn't use
debian's libpaper:

  (null): unknown option '-n'
  (null): unknown option '-mh'
  (null): unknown option '-mw'

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile | 6 ++----
 t/t0600-doc-tools.sh   | 4 +---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 96d3f52c60..3e2cbef306 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -155,7 +155,6 @@ ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
 ASCIIDOC_DEPS = asciidoc.conf GIT-ASCIIDOCFLAGS
 TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
 TXT_TO_XML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_DOCBOOK)
-XMLTO = xmlto
 XMLTO_EXTRA =
 INSTALL ?= install
 RM ?= rm -f
@@ -184,7 +183,7 @@ endif
 ifndef MAN_BASE_URL
 MAN_BASE_URL = file://$(htmldir)/
 endif
-XMLTO_EXTRA += --stringparam man.base.url.for.relative.links='$(MAN_BASE_URL)'
+XMLTO_EXTRA += --stringparam man.base.url.for.relative.links '$(MAN_BASE_URL)'
 
 ifdef USE_ASCIIDOCTOR
 ASCIIDOC = asciidoctor
@@ -196,7 +195,6 @@ ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
 ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
 ASCIIDOC_DEPS = asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 DBLATEX_COMMON =
-XMLTO_EXTRA += --skip-validation
 endif
 
 SHELL_PATH ?= $(SHELL)
@@ -334,7 +332,7 @@ $(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -o $@ $<
 
 manpage-prereqs := manpage.xsl $(wildcard manpage*.xsl)
-manpage-cmd = $(QUIET_XMLTO)$(XMLTO) -x manpage.xsl $(XMLTO_EXTRA) man $<
+manpage-cmd = $(QUIET_XMLTO)xsltproc --nonet $(XMLTO_EXTRA) -o $@ manpage.xsl $<
 
 manpage.xsl: gen-stylesheet
 	./gen-stylesheet >"$@"
diff --git a/t/t0600-doc-tools.sh b/t/t0600-doc-tools.sh
index a003686c2f..0af431941d 100755
--- a/t/t0600-doc-tools.sh
+++ b/t/t0600-doc-tools.sh
@@ -57,9 +57,7 @@ EOF
 "$doc_dir"/gen-stylesheet >"$doc_dir"/manpage.xsl
 
 xmltoman() {
-	base="$1"
-	shift
-	xmlto --skip-validation -x "$doc_dir"/manpage.xsl man "$base.xml"
+	xsltproc --nonet -o "$1.1" "$doc_dir/manpage.xsl" "$1.xml"
 }
 
 build_asciidoc_py() {
-- 
2.40.0+fc1

