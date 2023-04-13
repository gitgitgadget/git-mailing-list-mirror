Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7958C77B6E
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjDML6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjDML6D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:58:03 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1D0A275
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:58:00 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id cg19-20020a056830631300b0069f922cd5ceso6957302otb.12
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681387079; x=1683979079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5hWuYiGKmRVn+GABFhx7MPl0aHsZWEx0YXjqctiLAo=;
        b=JMzpKrLIiL4p28lWMbpoHsP33dkUaZJ2rKLelY8yE0s5SFdMnMhm43mBGLdG/RiWkH
         OiVhnTKCgmsa2qA/qGv3rwaN6rEDMoptKfCb3a3/Kp+yT1umQP+0XzXC4RmVmo/E5gN0
         V/2c5GMnJGSVtX0VI0siWfZ+H8CZNgRHBxyUmcLXj2Jz0vMUMae52duRDuIYtFqzuHEL
         ZW0mw+YBEiRT6mdK5J5apZpe7wTPI1KxHCFjd6kSHErO0Q4RTRpimiNfrnx5Se4SYXtx
         jtngnyE2BzupA3bYjv9nWDs8KPXQ6eG/1tBFDseyn1NKuZ6hOh71YhsAYvcwQI0dHwHG
         QGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681387079; x=1683979079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5hWuYiGKmRVn+GABFhx7MPl0aHsZWEx0YXjqctiLAo=;
        b=XQXLuhCaMc0Ag02HIXOmRMg2jQrUBZ8niJ3XT4UheSR3YpYDMlBbX85FNRH75+Zi8T
         82GwkDOUF6701y8jLoS7fCAmVYCMAGH0sI4x/EbAlt5mzxjHqT1wixuN1GGQ8mxx7Hu5
         YK++tWVRzk0ricXVZbbZVOx03l+vBfUHxg2NUlZDVE1izZUuN895sbymjNSH9AdWojMi
         Y7x64mvxbsB6jN1Caalo5aptPTeGSCN5kCHQsbYLQakZkTebLmPp/FoEJl/vzI0x7Ov0
         vmHNXJAd3hn7GbTJmXXyZLbIjkoc+NsujW8JtsI6nCPtvCQCmaKdQ4sAjYRnxfGXoLjP
         ZPWA==
X-Gm-Message-State: AAQBX9e+5zIltWYUKU9anvv7N9w97uq30gsCwbFb6EsHD3mowT6IKTZO
        5Br2pAI5t6y3f2SjlGZ/71QascopEMg=
X-Google-Smtp-Source: AKy350b0H/swOYdbil6Rn4ZWsBInutp9N+8hK+HtYjvP7hcxpxmT3B0U4bm3JljDW+IVvYH1E70B8A==
X-Received: by 2002:a9d:730d:0:b0:6a4:2d0e:d9dc with SMTP id e13-20020a9d730d000000b006a42d0ed9dcmr852417otk.20.1681387079117;
        Thu, 13 Apr 2023 04:57:59 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id v16-20020a05683011d000b0069457b86060sm610185otq.47.2023.04.13.04.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 04:57:58 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Johnsen <chris_johnsen@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 09/12] doc: remove references to xmlto
Date:   Thu, 13 Apr 2023 05:57:42 -0600
Message-Id: <20230413115745.116063-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230413115745.116063-1-felipe.contreras@gmail.com>
References: <20230413115745.116063-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile           | 6 +++---
 Documentation/manpage-normal.xsl | 2 +-
 INSTALL                          | 4 ++--
 ci/install-dependencies.sh       | 2 +-
 shared.mak                       | 3 +--
 5 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3e2cbef306..a85f60f766 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -155,7 +155,7 @@ ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
 ASCIIDOC_DEPS = asciidoc.conf GIT-ASCIIDOCFLAGS
 TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
 TXT_TO_XML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_DOCBOOK)
-XMLTO_EXTRA =
+XSLTPROC_EXTRA =
 INSTALL ?= install
 RM ?= rm -f
 MAN_REPO = ../../git-manpages
@@ -183,7 +183,7 @@ endif
 ifndef MAN_BASE_URL
 MAN_BASE_URL = file://$(htmldir)/
 endif
-XMLTO_EXTRA += --stringparam man.base.url.for.relative.links '$(MAN_BASE_URL)'
+XSLTPROC_EXTRA += --stringparam man.base.url.for.relative.links '$(MAN_BASE_URL)'
 
 ifdef USE_ASCIIDOCTOR
 ASCIIDOC = asciidoctor
@@ -332,7 +332,7 @@ $(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -o $@ $<
 
 manpage-prereqs := manpage.xsl $(wildcard manpage*.xsl)
-manpage-cmd = $(QUIET_XMLTO)xsltproc --nonet $(XMLTO_EXTRA) -o $@ manpage.xsl $<
+manpage-cmd = $(QUIET_XSLTPROC)xsltproc --nonet $(XSLTPROC_EXTRA) -o $@ manpage.xsl $<
 
 manpage.xsl: gen-stylesheet
 	./gen-stylesheet >"$@"
diff --git a/Documentation/manpage-normal.xsl b/Documentation/manpage-normal.xsl
index a9c7ec69f4..3fb044a8a7 100644
--- a/Documentation/manpage-normal.xsl
+++ b/Documentation/manpage-normal.xsl
@@ -4,7 +4,7 @@
 		version="1.0">
 
 
-<!-- these params silence some output from xmlto -->
+<!-- these params silence some output from xsltproc -->
 <xsl:param name="man.output.quietly" select="1"/>
 <xsl:param name="refentry.meta.get.quietly" select="1"/>
 
diff --git a/INSTALL b/INSTALL
index 4b42288882..48c126b3be 100644
--- a/INSTALL
+++ b/INSTALL
@@ -176,13 +176,13 @@ Issues of note:
    the name is reserved for local settings.
 
  - To build and install documentation suite, you need to have
-   the asciidoc/xmlto toolchain.  Because not many people are
+   the asciidoc/xsltproc toolchain.  Because not many people are
    inclined to install the tools, the default build target
    ("make all") does _not_ build them.
 
    "make doc" builds documentation in man and html formats; there are
    also "make man", "make html" and "make info". Note that "make html"
-   requires asciidoc, but not xmlto. "make man" (and thus make doc)
+   requires asciidoc, but not xsltproc. "make man" (and thus make doc)
    requires both.
 
    "make install-doc" installs documentation in man format only; there
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 4f407530d3..fe72525f1f 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -69,7 +69,7 @@ sparse)
 	;;
 Documentation)
 	sudo apt-get -q update
-	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make
+	sudo apt-get -q -y install asciidoc xsltproc docbook-xsl-ns make
 
 	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
 	sudo gem install --version 1.5.8 asciidoctor
diff --git a/shared.mak b/shared.mak
index aeb80fc4d5..52fbc8ec6f 100644
--- a/shared.mak
+++ b/shared.mak
@@ -78,11 +78,10 @@ ifndef V
 
 ## Used in "Documentation/Makefile"
 	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
-	QUIET_XMLTO	= @echo '   ' XMLTO $@;
+	QUIET_XSLTPROC	= @echo '   ' XSLTPROC $@;
 	QUIET_DB2TEXI	= @echo '   ' DB2TEXI $@;
 	QUIET_MAKEINFO	= @echo '   ' MAKEINFO $@;
 	QUIET_DBLATEX	= @echo '   ' DBLATEX $@;
-	QUIET_XSLTPROC	= @echo '   ' XSLTPROC $@;
 	QUIET_GEN	= @echo '   ' GEN $@;
 	QUIET_STDERR	= 2> /dev/null
 
-- 
2.40.0+fc1

