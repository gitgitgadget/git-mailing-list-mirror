Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE89C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3704461176
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhEUWbH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhEUWbH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:31:07 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBC4C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:29:43 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso19459750ote.1
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VAg1tdInp5r42EUdJDZQw8HpFRKwcaUjKn5e95Mio/8=;
        b=On6L2d9Lc2uYz0cXxksyO4rAO7KNdFcHga+YfYqNyWMcU6khrn6iQpPj2W8tR0vC78
         mL4gQy+lRh5GZGsBUp5NxgaSsTV91OGZiECCP5f1/OhtihypRV79pOlGd+7OJwhz70V6
         XQVPRcBDXKuSxK7f83Vcj7pDh5v3x7BAr9fdNB/XdMFZ+zQlBh3R8rnwMHnQaLrmCsbT
         Y26yV8nbUulIBTmRx8WpG4pnEghqSADjiU95qaw/7OCTfPFv9Q9JouEWx/kXjZpGESTE
         /DP5KkR+q7j7q3fuqmkTiqNLkmZv2ym5QYPtycnUS1I6puTaZWsSbiH6YyYmEv/S1ayz
         tE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VAg1tdInp5r42EUdJDZQw8HpFRKwcaUjKn5e95Mio/8=;
        b=Yk0FfPbGESNU7UCtwG7bGwZEhl8ZrY6MC4vTm9P3Vnbx+Rh7uRcmVnuaOftKBFZDSW
         Xq5cXr/dXYH0CEYG1OR2XG6LqYewcr955HDseHFl0+oD0esb01M+L+MSerYBDk6AdsTL
         nT5J26L2U0/PCDjaApUPpFBfDnokJi1cRJK7L2gxm9kB6TuINtLkOZ3tuf9ayj3bE8aF
         ZMPSvByZ7kCgf99uSDXHxArC0/KThe/JQlA7MBGeFI7CekbFbgPHvgDTyS0zsDYhhYPR
         ThPMYYdcFAD4Ty1mB1oYj+pzkG1Iiu97HXLwniKIGOHbQRmSQqTh418i3mMnXA/gcNgf
         r3Tg==
X-Gm-Message-State: AOAM532AwkZ5LEtOhEPSZG1GL3OexodNAEL7I/X0+60EFEfblMi4mYF9
        QlWvYXiL4crlyJB9Lh9dgSihYjKFjeNkPg==
X-Google-Smtp-Source: ABdhPJwbwh1+rrCJYk0No5255Vg+bo9vhPf8LldkAX4FG1MhCnpoeZuBtgpLlU7yhE0GUvMuZmYVAA==
X-Received: by 2002:a9d:3674:: with SMTP id w107mr10100929otb.150.1621636182744;
        Fri, 21 May 2021 15:29:42 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id 34sm1553644otf.38.2021.05.21.15.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:29:42 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/5] doc: asciidoc cleanups
Date:   Fri, 21 May 2021 17:29:36 -0500
Message-Id: <20210521222941.525901-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is an attempt to cleanup the Makefile of the documentation.

Since v2 only certain $(RM) commands are moved from one patch to another.

Felipe Contreras (5):
  doc: refactor common asciidoc dependencies
  doc: improve asciidoc dependencies
  doc: remove unnecessary rm instances
  doc: simplify Makefile using .DELETE_ON_ERROR
  doc: avoid using rm directly

 Documentation/Makefile | 77 ++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 48 deletions(-)

Range-diff against v2:
1:  55b188c8ad = 1:  cbcaefed3e doc: refactor common asciidoc dependencies
2:  e69d0a5b89 = 2:  1c8b0b9123 doc: improve asciidoc dependencies
3:  4f18675ce9 < -:  ---------- doc: remove unnecessary rm instances
-:  ---------- > 3:  3da461a55d doc: remove unnecessary rm instances
4:  935675e070 ! 4:  a8c4c4ae26 doc: simplify Makefile using .DELETE_ON_ERROR
    @@ Documentation/Makefile: docdep_prereqs = \
      	cmd-list.made $(cmds_txt)
      
      doc.dep : $(docdep_prereqs) $(DOC_DEP_TXT) build-docdep.perl
    --	$(QUIET_GEN)$(RM) $@+ $@ && \
    --	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
    +-	$(QUIET_GEN)$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
     -	mv $@+ $@
     +	$(QUIET_GEN)$(PERL_PATH) ./build-docdep.perl >$@ $(QUIET_STDERR)
      
    @@ Documentation/Makefile: clean:
      	$(RM) GIT-ASCIIDOCFLAGS
      
      $(MAN_HTML): %.html : %.txt $(ASCIIDOC_DEPS)
    --	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
    --	$(TXT_TO_HTML) -d manpage -o $@+ $< && \
    +-	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -d manpage -o $@+ $< && \
     -	mv $@+ $@
     +	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -d manpage -o $@ $<
      
      $(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
    --	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
    --	$(TXT_TO_HTML) -o $@+ $< && \
    +-	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -o $@+ $< && \
     -	mv $@+ $@
     +	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -o $@ $<
      
    @@ Documentation/Makefile: manpage-base-url.xsl: manpage-base-url.xsl.in
      	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
      
      %.xml : %.txt $(ASCIIDOC_DEPS)
    --	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
    --	$(TXT_TO_XML) -d manpage -o $@+ $< && \
    +-	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@+ $< && \
     -	mv $@+ $@
     +	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@ $<
      
      user-manual.xml: user-manual.txt user-manual.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
    --	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
    --	$(TXT_TO_XML) -d book -o $@+ $< && \
    +-	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d book -o $@+ $< && \
     -	mv $@+ $@
     +	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d book -o $@ $<
      
    @@ Documentation/Makefile: XSLTOPTS += --stringparam html.stylesheet docbook-xsl.cs
      XSLTOPTS += --param generate.consistent.ids 1
      
      user-manual.html: user-manual.xml $(XSLT)
    --	$(QUIET_XSLTPROC)$(RM) $@+ $@ && \
    --	xsltproc $(XSLTOPTS) -o $@+ $(XSLT) $< && \
    +-	$(QUIET_XSLTPROC)xsltproc $(XSLTOPTS) -o $@+ $(XSLT) $< && \
     -	mv $@+ $@
     +	$(QUIET_XSLTPROC)xsltproc $(XSLTOPTS) -o $@ $(XSLT) $<
      
    @@ Documentation/Makefile: XSLTOPTS += --stringparam html.stylesheet docbook-xsl.cs
      	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split -o $@ user-manual.texi
      
      user-manual.texi: user-manual.xml
    --	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
    --	$(DOCBOOK2X_TEXI) user-manual.xml --encoding=UTF-8 --to-stdout >$@++ && \
    +-	$(QUIET_DB2TEXI)$(DOCBOOK2X_TEXI) user-manual.xml --encoding=UTF-8 --to-stdout >$@++ && \
     -	$(PERL_PATH) fix-texi.perl <$@++ >$@+ && \
     -	rm $@++ && \
     -	mv $@+ $@
    @@ Documentation/Makefile: XSLTOPTS += --stringparam html.stylesheet docbook-xsl.cs
     +	rm $@+
      
      user-manual.pdf: user-manual.xml
    --	$(QUIET_DBLATEX)$(RM) $@+ $@ && \
    --	$(DBLATEX) -o $@+ $(DBLATEX_COMMON) $< && \
    +-	$(QUIET_DBLATEX)$(DBLATEX) -o $@+ $(DBLATEX_COMMON) $< && \
     -	mv $@+ $@
     +	$(QUIET_DBLATEX)$(DBLATEX) -o $@ $(DBLATEX_COMMON) $<
      
      gitman.texi: $(MAN_XML) cat-texi.perl texi.xsl
    --	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
    -+	$(QUIET_DB2TEXI) \
    + 	$(QUIET_DB2TEXI) \
      	($(foreach xml,$(sort $(MAN_XML)),xsltproc -o $(xml)+ texi.xsl $(xml) && \
      		$(DOCBOOK2X_TEXI) --encoding=UTF-8 --to-stdout $(xml)+ && \
     -		rm $(xml)+ &&) true) > $@++ && \
    @@ Documentation/Makefile: XSLTOPTS += --stringparam html.stylesheet docbook-xsl.cs
      	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split --no-validate $*.texi
      
      $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
    --	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
    --	$(DOCBOOK2X_TEXI) --to-stdout $*.xml >$@+ && \
    +-	$(QUIET_DB2TEXI)$(DOCBOOK2X_TEXI) --to-stdout $*.xml >$@+ && \
     -	mv $@+ $@
     +	$(QUIET_DB2TEXI)$(DOCBOOK2X_TEXI) --to-stdout $*.xml >$@
      
      howto-index.txt: howto-index.sh $(HOWTO_TXT)
    --	$(QUIET_GEN)$(RM) $@+ $@ && \
    --	'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(HOWTO_TXT)) >$@+ && \
    +-	$(QUIET_GEN)'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(HOWTO_TXT)) >$@+ && \
     -	mv $@+ $@
     +	$(QUIET_GEN)'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(HOWTO_TXT)) >$@
      
      $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
      	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
    -@@ Documentation/Makefile: WEBDOC_DEST = /pub/software/scm/git/docs
    - 
    - howto/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
    +@@ Documentation/Makefile: howto/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
      $(patsubst %.txt,%.html,$(HOWTO_TXT)): %.html : %.txt GIT-ASCIIDOCFLAGS
    --	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
    -+	$(QUIET_ASCIIDOC) \
    + 	$(QUIET_ASCIIDOC) \
      	sed -e '1,/^$$/d' $< | \
     -	$(TXT_TO_HTML) - >$@+ && \
     -	mv $@+ $@
5:  b621f3b8e9 = 5:  2c330987b5 doc: avoid using rm directly
-- 
2.32.0.rc0

