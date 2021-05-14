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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D35C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 11:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B2E161406
	for <git@archiver.kernel.org>; Fri, 14 May 2021 11:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbhENL56 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 07:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbhENL5x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 07:57:53 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3041C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 04:56:40 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id x15so14459167oic.13
        for <git@vger.kernel.org>; Fri, 14 May 2021 04:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zOzyT6er0Jctzqpnov4b9afyc2jWpUib2d/MkYbNbeQ=;
        b=XEIlCSxKZNWOzkh+HDr5Yb9GYusySA6R41ILKWUEO8sTg0NZy1FdBdbA+kGeHH9202
         7t6I7241zhAaSgoqJpL2kAH4xOrE6wHFFamEqRkSQwNARN3o0ZpN+KTd1EPVxSb+dl2a
         XPtR21UohU3tQGj1y2mc8iezeOLfouFTyVnfzQ3h0Z84/3iwB3eqdwblJCTe1yRq12gg
         LxeipAWU0q8XIyPD0JzaHepXK2aOZu76LYFrAJcf1rPYvm+9Oi4yu+Gf/tRr2c+uls9M
         QEsN/LDbYsdZeUtWh7mHWJc1/sO8wTtK9KgEqdmsuNrpopSA0Tb4k7JBWRGB/i43yerW
         83ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zOzyT6er0Jctzqpnov4b9afyc2jWpUib2d/MkYbNbeQ=;
        b=amBIShwMmNRFJQn5KOXVgD2igvoOtaragKZFCBUS7+15GR+CnEdV3dNoV2keipJF5+
         mHRqYXzj/XkVwfgH5KZ3pnHO/K/WGmZhyeTKo+rVhf6kG+Q1BVCzjBa4Y5VZjeqlvHhg
         Mof8UZutklhZRtq+Xeqae5ItmDZCICLqi4437wk9qQvOU7B3SsDHhZHpnm9pYvIPhSMB
         M2UrDC8VAf0lLi/lRmHquvGYCE1mT8VkBwyNFRqdYBbPyiYYh+ZKOEjIpuYEPmH6409e
         lNbB+IdhBMry1dvkMsWX6EK1xtmeI/2btbKwW3O4xzvqfBzBq7KdqKIsR17lkYNPDCkb
         dpfg==
X-Gm-Message-State: AOAM533+mpFB7IvLSlVV67sGUlav5SnD+GjONI6JdQEYONGlcP/rvod9
        AT83xfprv4ZqQqe29qNwRzi5ObW8C5i/UA==
X-Google-Smtp-Source: ABdhPJwHQ4zHpkmFbmT6zILqGQq6+tPQwAkKHUHYrWMqAma4W5cGQObNXgQUBsYJ39lMlTbIxMsucg==
X-Received: by 2002:a05:6808:3a3:: with SMTP id n3mr30406770oie.157.1620993399827;
        Fri, 14 May 2021 04:56:39 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id y14sm981759otq.4.2021.05.14.04.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 04:56:39 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/5] doc: simplify Makefile using .DELETE_ON_ERROR
Date:   Fri, 14 May 2021 06:56:30 -0500
Message-Id: <20210514115631.503276-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210514115631.503276-1-felipe.contreras@gmail.com>
References: <20210514115631.503276-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently GNU make already removes files when catching an interruption
signal, however, in order to deal with other kinds of errors a
workaround is in place to store target output to a temporary file, and
only move it to its right place on success.

By enabling the built-in .DELETE_ON_ERROR we let make do this task, so
we don't have to.

This way the rules can be simplified a lot.

Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile | 61 +++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 40 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index aae8803e4c..eaff97dcb8 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -296,9 +296,7 @@ docdep_prereqs = \
 	cmd-list.made $(cmds_txt)
 
 doc.dep : $(docdep_prereqs) $(DOC_DEP_TXT) build-docdep.perl
-	$(QUIET_GEN)$(RM) $@+ $@ && \
-	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
-	mv $@+ $@
+	$(QUIET_GEN)$(PERL_PATH) ./build-docdep.perl >$@ $(QUIET_STDERR)
 
 ifneq ($(MAKECMDGOALS),clean)
 -include doc.dep
@@ -356,14 +354,10 @@ clean:
 	$(RM) GIT-ASCIIDOCFLAGS
 
 $(MAN_HTML): %.html : %.txt $(ASCIIDOC_DEPS)
-	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(TXT_TO_HTML) -d manpage -o $@+ $< && \
-	mv $@+ $@
+	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -d manpage -o $@ $<
 
 $(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
-	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(TXT_TO_HTML) -o $@+ $< && \
-	mv $@+ $@
+	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -o $@ $<
 
 manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
@@ -372,14 +366,10 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
 %.xml : %.txt $(ASCIIDOC_DEPS)
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
@@ -400,46 +390,35 @@ XSLTOPTS += --stringparam html.stylesheet docbook-xsl.css
 XSLTOPTS += --param generate.consistent.ids 1
 
 user-manual.html: user-manual.xml $(XSLT)
-	$(QUIET_XSLTPROC)$(RM) $@+ $@ && \
-	xsltproc $(XSLTOPTS) -o $@+ $(XSLT) $< && \
-	mv $@+ $@
+	$(QUIET_XSLTPROC)xsltproc $(XSLTOPTS) -o $@ $(XSLT) $<
 
 git.info: user-manual.texi
 	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split -o $@ user-manual.texi
 
 user-manual.texi: user-manual.xml
-	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
-	$(DOCBOOK2X_TEXI) user-manual.xml --encoding=UTF-8 --to-stdout >$@++ && \
-	$(PERL_PATH) fix-texi.perl <$@++ >$@+ && \
-	rm $@++ && \
-	mv $@+ $@
+	$(QUIET_DB2TEXI)$(DOCBOOK2X_TEXI) user-manual.xml --encoding=UTF-8 --to-stdout >$@+ && \
+	$(PERL_PATH) fix-texi.perl <$@+ >$@ && \
+	rm $@+
 
 user-manual.pdf: user-manual.xml
-	$(QUIET_DBLATEX)$(RM) $@+ $@ && \
-	$(DBLATEX) -o $@+ $(DBLATEX_COMMON) $< && \
-	mv $@+ $@
+	$(QUIET_DBLATEX)$(DBLATEX) -o $@ $(DBLATEX_COMMON) $<
 
 gitman.texi: $(MAN_XML) cat-texi.perl texi.xsl
-	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
+	$(QUIET_DB2TEXI) \
 	($(foreach xml,$(sort $(MAN_XML)),xsltproc -o $(xml)+ texi.xsl $(xml) && \
 		$(DOCBOOK2X_TEXI) --encoding=UTF-8 --to-stdout $(xml)+ && \
-		rm $(xml)+ &&) true) > $@++ && \
-	$(PERL_PATH) cat-texi.perl $@ <$@++ >$@+ && \
-	rm $@++ && \
-	mv $@+ $@
+		rm $(xml)+ &&) true) > $@+ && \
+	$(PERL_PATH) cat-texi.perl $@ <$@+ >$@ && \
+	rm $@+
 
 gitman.info: gitman.texi
 	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split --no-validate $*.texi
 
 $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
-	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
-	$(DOCBOOK2X_TEXI) --to-stdout $*.xml >$@+ && \
-	mv $@+ $@
+	$(QUIET_DB2TEXI)$(DOCBOOK2X_TEXI) --to-stdout $*.xml >$@
 
 howto-index.txt: howto-index.sh $(HOWTO_TXT)
-	$(QUIET_GEN)$(RM) $@+ $@ && \
-	'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(HOWTO_TXT)) >$@+ && \
-	mv $@+ $@
+	$(QUIET_GEN)'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(HOWTO_TXT)) >$@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
@@ -448,10 +427,9 @@ WEBDOC_DEST = /pub/software/scm/git/docs
 
 howto/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %.txt,%.html,$(HOWTO_TXT)): %.html : %.txt GIT-ASCIIDOCFLAGS
-	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
+	$(QUIET_ASCIIDOC) \
 	sed -e '1,/^$$/d' $< | \
-	$(TXT_TO_HTML) - >$@+ && \
-	mv $@+ $@
+	$(TXT_TO_HTML) - >$@
 
 install-webdoc : html
 	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(WEBDOC_DEST)
@@ -492,4 +470,7 @@ doc-l10n install-l10n::
 	$(MAKE) -C po $@
 endif
 
+# Delete the target file on error
+.DELETE_ON_ERROR:
+
 .PHONY: FORCE
-- 
2.31.1

