Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DFAC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 091C2613DA
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhELXXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349212AbhELWas (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 18:30:48 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E040C061344
        for <git@vger.kernel.org>; Wed, 12 May 2021 15:28:24 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id u16so23630671oiu.7
        for <git@vger.kernel.org>; Wed, 12 May 2021 15:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IQUbAJpIfKCqyhmMMkSofwbkE4A7fU4XRzVJLwEwgdA=;
        b=cOnrEtd9cE989Q5GDsQVadUjNPuRkGuUiPXQn8pTuQjqvUpC3+/nyBk04P0yOE8h/c
         8Fv8EgJyxNOVBqEdxHH81FTC/bz6oPRTNinZlv6UdpySRKpS8oLpUfrrIJHP1DTlzU01
         ttVPg4BIexaamgdsMJeHeVlhqBxOWqaqFHQb52u71229sjAl+LQ8GKjQdlLAcugqJWYD
         U8mlVklRxd3M09RDKMCZFwr3clYzi8+t3YEBsMu8u73e4ReaQSefPOMGHMrYlU50gHQ8
         utHyEBWE/8ghnUTPwgUu0k5GUbcIaG+ud3fESyIAiIq5zLknWaqiz6cCnmNjp26NNnVy
         8/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IQUbAJpIfKCqyhmMMkSofwbkE4A7fU4XRzVJLwEwgdA=;
        b=iM50z/0SieE6shThDmiu1cNFy8cNsB7zzforlGFEZMS0stWORCGp95S20/IA40PlIn
         F9+ATfAyiHqOyCQBZXtPRmzTa2hviQa4C5rLLiCkjwf8s61PSA/pQ3+z+ufPv8LfrrNw
         rtMoXWfLMtNlcbp2UK3YG+D4aS4o/ZiXWiirgmaOGMjSaiwWNJLqyl9icc7FMGV0z/mb
         DdtSmFcHFdE4pnyFzM3/M00d92J0VAL9kMtpKA6YSxg08/AaerYNuiYXEWVp6vCw/jAy
         l41ax9Hy5qXn89ErB5qkStSCsJu9OGOvnJhDsxahIW61pVU8HlkmmLnunUdXjGCf8AD7
         Y3pQ==
X-Gm-Message-State: AOAM530l0Ef1SW4lKXHo6YlkE/pdL49x5NzwpsUr/T0YsX7oPHsSYjYr
        ZMnl9D/nhZJiVuVw9aVsUUPW/X3gfcEjZw==
X-Google-Smtp-Source: ABdhPJz9VaLRFwZ4E+BnBA8+c3Kt629jzO96VgwUj/A9EejS0xxgfw4zEhqiDI8qQcxxGant80JZoA==
X-Received: by 2002:a05:6808:8c4:: with SMTP id k4mr28120593oij.40.1620858503423;
        Wed, 12 May 2021 15:28:23 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id f13sm275237ote.46.2021.05.12.15.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 15:28:23 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/8] doc: add an asciidoc helper
Date:   Wed, 12 May 2021 17:27:57 -0500
Message-Id: <20210512222803.508446-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512222803.508446-1-felipe.contreras@gmail.com>
References: <20210512222803.508446-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The hacks to deal with interrupted builds is scattered throughout the
Makefile, but not everywhere (it's not done for techical/ and articles).

It originally comes from f9dae0d3e6 (Documentation/Makefile: fix
interrupted builds of user-manual.xml, 2010-04-21), however, that
description is not correct.

asciidoc does actually remove the output file in case of an exception,
but there was a bug that handled keyboard interruptions through a
different path, and thus in that particular case the file is not
removed[1].

We shouldn't overly complicate the Makefile due to bugs in asciidoc.

In order to keep the Makefile clean this commit creates an asciidoc
wrapper that does the job of tracking the intermediary output.

Once asciidoc is fixed this helper can be safely removed and there would
be minimal changes elsewhere.

It's written for bash, but could easily be modified for something more
portable.

[1] https://github.com/asciidoc-py/asciidoc-py/pull/195

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile           | 27 +++++++++------------------
 Documentation/asciidoc-helper.sh | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+), 18 deletions(-)
 create mode 100755 Documentation/asciidoc-helper.sh

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3d282a2797..5c2a3df24a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -139,8 +139,9 @@ ASCIIDOC_CONF = -f asciidoc.conf
 ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
 		-amanversion=$(GIT_VERSION) \
 		-amanmanual='Git Manual' -amansource='Git'
-TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
-TXT_TO_XML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_DOCBOOK)
+ASCIIDOC_BASE = '$(SHELL_PATH_SQ)' ./asciidoc-helper.sh $(ASCIIDOC_COMMON)
+TXT_TO_HTML = $(ASCIIDOC_BASE) -b $(ASCIIDOC_HTML)
+TXT_TO_XML = $(ASCIIDOC_BASE) -b $(ASCIIDOC_DOCBOOK)
 MANPAGE_XSL = manpage-normal.xsl
 XMLTO = xmlto
 XMLTO_EXTRA =
@@ -355,14 +356,10 @@ clean:
 	$(RM) GIT-ASCIIDOCFLAGS
 
 $(MAN_HTML): %.html : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
-	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(TXT_TO_HTML) -d manpage -o $@+ $< && \
-	mv $@+ $@
+	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -d manpage -o $@ $<
 
 $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
-	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(TXT_TO_HTML) -o $@+ $< && \
-	mv $@+ $@
+	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -o $@ $<
 
 manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
@@ -372,14 +369,10 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
 %.xml : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
-	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(TXT_TO_XML) -d manpage -o $@+ $< && \
-	mv $@+ $@
+	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@ $<
 
 user-manual.xml: user-manual.txt user-manual.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
-	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(TXT_TO_XML) -d book -o $@+ $< && \
-	mv $@+ $@
+	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d book -o $@ $<
 
 technical/api-index.txt: technical/api-index-skel.txt \
 	technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
@@ -448,10 +441,8 @@ WEBDOC_DEST = /pub/software/scm/git/docs
 
 howto/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %.txt,%.html,$(HOWTO_TXT)): %.html : %.txt GIT-ASCIIDOCFLAGS
-	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	sed -e '1,/^$$/d' $< | \
-	$(TXT_TO_HTML) -o $@+ - && \
-	mv $@+ $@
+	$(QUIET_ASCIIDOC)sed -e '1,/^$$/d' $< | \
+	$(TXT_TO_HTML) -o $@ -
 
 install-webdoc : html
 	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(WEBDOC_DEST)
diff --git a/Documentation/asciidoc-helper.sh b/Documentation/asciidoc-helper.sh
new file mode 100755
index 0000000000..ae16cf9288
--- /dev/null
+++ b/Documentation/asciidoc-helper.sh
@@ -0,0 +1,18 @@
+#!/bin/bash
+
+# This helper is a workaround for an interruption bug in asciidoc:
+# https://github.com/asciidoc-py/asciidoc-py/pull/195
+
+args=()
+
+while [ $# -gt 1 ]; do
+	case $1 in
+	-o) shift; out="$1" ;;
+	*) args+=("$1")
+	esac
+	shift
+done
+
+rm -f "$out+" "$out" &&
+"${args[@]}" -o "$out+" "$1" &&
+mv "$out+" "$out"
-- 
2.31.1

