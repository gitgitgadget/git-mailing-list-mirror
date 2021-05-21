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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C921FC04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB3D561176
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhEUWbS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhEUWbO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:31:14 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51586C0613ED
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:29:50 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so8246683otk.5
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S6mtXCFHlTXtJXXDRP/2nisWYEopAtKyVCxF0YkA9ss=;
        b=bsY0gNdzY6nyDDluSOWRLQVdxxkuFpUxZocYmU2bpDgWqbJWPQTTPIHUyAlqt1aqMv
         aayIYRtuwFL0Vifrs6VIXpQDGs30H1sHAlxBn7sq45n3aJDcX2+APuN+wDisFO7/pfc5
         piNAz1lxK4x5HgE++Qpk5x5OR2eaMzG1lSLOe4dCDgs3CgFXBDUpLxUYDNS9tnJitvAf
         E+9e8bFc5ttMI4+uWalKr6IMwTV0trIDO/eUTsVxwpEjQWcVILoYjDqTvDuf8ACTaWZ2
         hkx3o65R6cvKpBf36HSIngRv8phNZzRfxP3EJMZEoq/0e+Dun2H4UPiZIm4gr9Fod7Uz
         gqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S6mtXCFHlTXtJXXDRP/2nisWYEopAtKyVCxF0YkA9ss=;
        b=gkDwrHqPhdkRkCohWg5tOBmPEjdZXMoEofcg21XLR32lzPEYoCbVbsHv0LfBhMod7+
         L9HWCqhDYaOyzbD5CHiGbkhrjVUDHSUjobxvJmZAQG2C/BompbU57Vkf7SAYCiG89KGr
         RYtLyNaGhGaf7na/UmlMeoLNTS//eKoqW0JFZokuIrf9te1byT3ouMTFh45go3JIYu89
         dZLZWjohlVClGboU5Nw94rzBBplJJJfcgXtGR2VHtPtfWlajLdi+WdyV54yy3LztI1BP
         OFn3HvdwB0cdrCxwisS1oIAEtgTCRW85IiHA4xd0LDmVm0cqntWI46n241k42DNSY2UN
         7sAg==
X-Gm-Message-State: AOAM532QY30j0rKOfqo7CYGJkuhUpkeYRh8VIBx5TYOCwXC4hpa4jz5P
        hUAdyPob+Ztbz4V0mpF8TqaElW037aHbag==
X-Google-Smtp-Source: ABdhPJwati36NyAv6jMPFlOmqBfmb6T4mPo4ydvKiG+TZOX9GMVD6PPxTqlYpXWe5QSQy8rCYQWLOg==
X-Received: by 2002:a9d:4a8a:: with SMTP id i10mr10096275otf.282.1621636189413;
        Fri, 21 May 2021 15:29:49 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id q63sm1408644oic.15.2021.05.21.15.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:29:49 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 4/5] doc: simplify Makefile using .DELETE_ON_ERROR
Date:   Fri, 21 May 2021 17:29:40 -0500
Message-Id: <20210521222941.525901-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521222941.525901-1-felipe.contreras@gmail.com>
References: <20210521222941.525901-1-felipe.contreras@gmail.com>
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
 Documentation/Makefile | 47 +++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 73b88c3aad..eaff97dcb8 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -296,8 +296,7 @@ docdep_prereqs = \
 	cmd-list.made $(cmds_txt)
 
 doc.dep : $(docdep_prereqs) $(DOC_DEP_TXT) build-docdep.perl
-	$(QUIET_GEN)$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
-	mv $@+ $@
+	$(QUIET_GEN)$(PERL_PATH) ./build-docdep.perl >$@ $(QUIET_STDERR)
 
 ifneq ($(MAKECMDGOALS),clean)
 -include doc.dep
@@ -355,12 +354,10 @@ clean:
 	$(RM) GIT-ASCIIDOCFLAGS
 
 $(MAN_HTML): %.html : %.txt $(ASCIIDOC_DEPS)
-	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -d manpage -o $@+ $< && \
-	mv $@+ $@
+	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -d manpage -o $@ $<
 
 $(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
-	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -o $@+ $< && \
-	mv $@+ $@
+	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -o $@ $<
 
 manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
@@ -369,12 +366,10 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
 %.xml : %.txt $(ASCIIDOC_DEPS)
-	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@+ $< && \
-	mv $@+ $@
+	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@ $<
 
 user-manual.xml: user-manual.txt user-manual.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
-	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d book -o $@+ $< && \
-	mv $@+ $@
+	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d book -o $@ $<
 
 technical/api-index.txt: technical/api-index-skel.txt \
 	technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
@@ -395,41 +390,35 @@ XSLTOPTS += --stringparam html.stylesheet docbook-xsl.css
 XSLTOPTS += --param generate.consistent.ids 1
 
 user-manual.html: user-manual.xml $(XSLT)
-	$(QUIET_XSLTPROC)xsltproc $(XSLTOPTS) -o $@+ $(XSLT) $< && \
-	mv $@+ $@
+	$(QUIET_XSLTPROC)xsltproc $(XSLTOPTS) -o $@ $(XSLT) $<
 
 git.info: user-manual.texi
 	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split -o $@ user-manual.texi
 
 user-manual.texi: user-manual.xml
-	$(QUIET_DB2TEXI)$(DOCBOOK2X_TEXI) user-manual.xml --encoding=UTF-8 --to-stdout >$@++ && \
-	$(PERL_PATH) fix-texi.perl <$@++ >$@+ && \
-	rm $@++ && \
-	mv $@+ $@
+	$(QUIET_DB2TEXI)$(DOCBOOK2X_TEXI) user-manual.xml --encoding=UTF-8 --to-stdout >$@+ && \
+	$(PERL_PATH) fix-texi.perl <$@+ >$@ && \
+	rm $@+
 
 user-manual.pdf: user-manual.xml
-	$(QUIET_DBLATEX)$(DBLATEX) -o $@+ $(DBLATEX_COMMON) $< && \
-	mv $@+ $@
+	$(QUIET_DBLATEX)$(DBLATEX) -o $@ $(DBLATEX_COMMON) $<
 
 gitman.texi: $(MAN_XML) cat-texi.perl texi.xsl
 	$(QUIET_DB2TEXI) \
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
-	$(QUIET_DB2TEXI)$(DOCBOOK2X_TEXI) --to-stdout $*.xml >$@+ && \
-	mv $@+ $@
+	$(QUIET_DB2TEXI)$(DOCBOOK2X_TEXI) --to-stdout $*.xml >$@
 
 howto-index.txt: howto-index.sh $(HOWTO_TXT)
-	$(QUIET_GEN)'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(HOWTO_TXT)) >$@+ && \
-	mv $@+ $@
+	$(QUIET_GEN)'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(HOWTO_TXT)) >$@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
@@ -440,8 +429,7 @@ howto/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %.txt,%.html,$(HOWTO_TXT)): %.html : %.txt GIT-ASCIIDOCFLAGS
 	$(QUIET_ASCIIDOC) \
 	sed -e '1,/^$$/d' $< | \
-	$(TXT_TO_HTML) - >$@+ && \
-	mv $@+ $@
+	$(TXT_TO_HTML) - >$@
 
 install-webdoc : html
 	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(WEBDOC_DEST)
@@ -482,4 +470,7 @@ doc-l10n install-l10n::
 	$(MAKE) -C po $@
 endif
 
+# Delete the target file on error
+.DELETE_ON_ERROR:
+
 .PHONY: FORCE
-- 
2.32.0.rc0

