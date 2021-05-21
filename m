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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B35C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9DF4613AF
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhEUWbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhEUWbM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:31:12 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D9BC061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:29:48 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id s19so21073512oic.7
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=is0R4bXlC4saveY4qJsSXT8vZR9yttYUs3cwoxi8/XM=;
        b=isUg3wIq/5lhQwN09bTRRCg3LzHt32z4bdEtl7vHzIlvxkr+v3IViirIAdAPckKDBX
         0avqf3vWLQ66jvKEfiYBNgkkS21tiWWDii46fzNGvyyIY1ZxL9SgQleyGshbHha0m1Tl
         S32C4KQ7c8lFR5aQIYr/Jn0jNPKuC+iWpkNOL6fvYZ8i1YZc+P5zjnxDY13vSkBrRZJK
         ITF6W11CaxSMFEl1zimqU7wl+61iyWc+6pizEx47DePFlJYc1xZQAO75MEVAXyOVtExv
         52x+eUneeIRDDbtCKTdx1ylxLz6JThAUAzKot5bk+TqcqCremMr/yDspAwdMuHAdhwsA
         Q4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=is0R4bXlC4saveY4qJsSXT8vZR9yttYUs3cwoxi8/XM=;
        b=X5MnfGNedcz8Lqn3nMrClzFLUhniB2dugYAXtFCwWemzlY6mEch+DQYwiCEZX8d6z2
         LNLW8BdyVrsG2LEM8SZzfekiDuW5qPWSvyKdcn0cXszt3huXZk72eFvJ16tTv3MBmB7v
         4sSAPXVRCpP6G7LJTQodHsYLV6MD6jrE1Wxh9QsuKBnQ66qudnVO6wmZJiecmfqF84Iz
         6hnpAohs1qsL0Bz93ahs/9ndpqGAnNh86zME21PmewWT2NaPg1p+WkgWUjLnX5rG0bUr
         PpX45gscWlgk1+c69mDu53qZ8vHtW1JPAcspnwPPY7tpPueY/F5DYqczNbDgCw1jcSxm
         LnLw==
X-Gm-Message-State: AOAM532EzdRENZQ/KkkXZr7OgLeqoNqHn7qtNMNkPAHh4JaCeojqjsuS
        Cqn02AMAtFqz/M0sm1A5cIqwiP7Th5WhPQ==
X-Google-Smtp-Source: ABdhPJzPHkYEOe+KRVZRzfXXAv6NTIVnN//1+PPC0V6sDs0D2TxKDI3EShca2ZLimBoJ32/bG0TwDg==
X-Received: by 2002:a05:6808:5d8:: with SMTP id d24mr3712883oij.49.1621636187903;
        Fri, 21 May 2021 15:29:47 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id u6sm1578701otk.63.2021.05.21.15.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:29:47 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 3/5] doc: remove unnecessary rm instances
Date:   Fri, 21 May 2021 17:29:39 -0500
Message-Id: <20210521222941.525901-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521222941.525901-1-felipe.contreras@gmail.com>
References: <20210521222941.525901-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commits 50cff52f1a (When generating manpages, delete outdated targets
first., 2007-08-02) and f9286765b2 (Documentation/Makefile: remove
cmd-list.made before redirecting to it., 2007-08-06) created these rm
instances for a very rare corner-case: building as root by mistake.

It's odd to have workarounds here, but nowhere else in the Makefile--
which already fails in this stuation, starting from
Documentation/technical/.

We gain nothing but complexity, so let's remove them.

Comments-by: Jeff King <peff@peff.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 0f59cc0853..73b88c3aad 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -296,8 +296,7 @@ docdep_prereqs = \
 	cmd-list.made $(cmds_txt)
 
 doc.dep : $(docdep_prereqs) $(DOC_DEP_TXT) build-docdep.perl
-	$(QUIET_GEN)$(RM) $@+ $@ && \
-	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
+	$(QUIET_GEN)$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
 	mv $@+ $@
 
 ifneq ($(MAKECMDGOALS),clean)
@@ -318,8 +317,7 @@ cmds_txt = cmds-ancillaryinterrogators.txt \
 $(cmds_txt): cmd-list.made
 
 cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
-	$(QUIET_GEN)$(RM) $@ && \
-	$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(cmds_txt) $(QUIET_STDERR) && \
+	$(QUIET_GEN)$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(cmds_txt) $(QUIET_STDERR) && \
 	date >$@
 
 mergetools_txt = mergetools-diff.txt mergetools-merge.txt
@@ -327,7 +325,7 @@ mergetools_txt = mergetools-diff.txt mergetools-merge.txt
 $(mergetools_txt): mergetools-list.made
 
 mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
-	$(QUIET_GEN)$(RM) $@ && \
+	$(QUIET_GEN) \
 	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
 		. ../git-mergetool--lib.sh && \
 		show_tool_names can_diff "* " || :' >mergetools-diff.txt && \
@@ -357,30 +355,25 @@ clean:
 	$(RM) GIT-ASCIIDOCFLAGS
 
 $(MAN_HTML): %.html : %.txt $(ASCIIDOC_DEPS)
-	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(TXT_TO_HTML) -d manpage -o $@+ $< && \
+	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -d manpage -o $@+ $< && \
 	mv $@+ $@
 
 $(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
-	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(TXT_TO_HTML) -o $@+ $< && \
+	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -o $@+ $< && \
 	mv $@+ $@
 
 manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
 
 %.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
-	$(QUIET_XMLTO)$(RM) $@ && \
-	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
+	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
 %.xml : %.txt $(ASCIIDOC_DEPS)
-	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(TXT_TO_XML) -d manpage -o $@+ $< && \
+	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@+ $< && \
 	mv $@+ $@
 
 user-manual.xml: user-manual.txt user-manual.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
-	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(TXT_TO_XML) -d book -o $@+ $< && \
+	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d book -o $@+ $< && \
 	mv $@+ $@
 
 technical/api-index.txt: technical/api-index-skel.txt \
@@ -402,27 +395,24 @@ XSLTOPTS += --stringparam html.stylesheet docbook-xsl.css
 XSLTOPTS += --param generate.consistent.ids 1
 
 user-manual.html: user-manual.xml $(XSLT)
-	$(QUIET_XSLTPROC)$(RM) $@+ $@ && \
-	xsltproc $(XSLTOPTS) -o $@+ $(XSLT) $< && \
+	$(QUIET_XSLTPROC)xsltproc $(XSLTOPTS) -o $@+ $(XSLT) $< && \
 	mv $@+ $@
 
 git.info: user-manual.texi
 	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split -o $@ user-manual.texi
 
 user-manual.texi: user-manual.xml
-	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
-	$(DOCBOOK2X_TEXI) user-manual.xml --encoding=UTF-8 --to-stdout >$@++ && \
+	$(QUIET_DB2TEXI)$(DOCBOOK2X_TEXI) user-manual.xml --encoding=UTF-8 --to-stdout >$@++ && \
 	$(PERL_PATH) fix-texi.perl <$@++ >$@+ && \
 	rm $@++ && \
 	mv $@+ $@
 
 user-manual.pdf: user-manual.xml
-	$(QUIET_DBLATEX)$(RM) $@+ $@ && \
-	$(DBLATEX) -o $@+ $(DBLATEX_COMMON) $< && \
+	$(QUIET_DBLATEX)$(DBLATEX) -o $@+ $(DBLATEX_COMMON) $< && \
 	mv $@+ $@
 
 gitman.texi: $(MAN_XML) cat-texi.perl texi.xsl
-	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
+	$(QUIET_DB2TEXI) \
 	($(foreach xml,$(sort $(MAN_XML)),xsltproc -o $(xml)+ texi.xsl $(xml) && \
 		$(DOCBOOK2X_TEXI) --encoding=UTF-8 --to-stdout $(xml)+ && \
 		rm $(xml)+ &&) true) > $@++ && \
@@ -434,13 +424,11 @@ gitman.info: gitman.texi
 	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split --no-validate $*.texi
 
 $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
-	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
-	$(DOCBOOK2X_TEXI) --to-stdout $*.xml >$@+ && \
+	$(QUIET_DB2TEXI)$(DOCBOOK2X_TEXI) --to-stdout $*.xml >$@+ && \
 	mv $@+ $@
 
 howto-index.txt: howto-index.sh $(HOWTO_TXT)
-	$(QUIET_GEN)$(RM) $@+ $@ && \
-	'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(HOWTO_TXT)) >$@+ && \
+	$(QUIET_GEN)'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(HOWTO_TXT)) >$@+ && \
 	mv $@+ $@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
@@ -450,7 +438,7 @@ WEBDOC_DEST = /pub/software/scm/git/docs
 
 howto/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %.txt,%.html,$(HOWTO_TXT)): %.html : %.txt GIT-ASCIIDOCFLAGS
-	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
+	$(QUIET_ASCIIDOC) \
 	sed -e '1,/^$$/d' $< | \
 	$(TXT_TO_HTML) - >$@+ && \
 	mv $@+ $@
-- 
2.32.0.rc0

