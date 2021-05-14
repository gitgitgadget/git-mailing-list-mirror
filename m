Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019F3C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 00:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF7E613BC
	for <git@archiver.kernel.org>; Fri, 14 May 2021 00:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhENAcX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 20:32:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47188 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229956AbhENAcX (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 May 2021 20:32:23 -0400
Received: from camp.crustytoothpaste.net (unknown [138.237.15.37])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 27BDA6043F;
        Fri, 14 May 2021 00:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620952272;
        bh=FSPQH4KUfRjp4jgSMH5hsHix5VHPgme0IyJxoSR/Wpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=dPx4eL4MwPM+bvgb8q3FJWzAWx5moO074AIN9D/usyt4Aa7UwAb0dtB8CU4ext2Lp
         JHrlBbbzBV4+gam5svgUOuI2j/Essjd3HBmGXBTsEn4emvym0KFKFupQyNT5WLweha
         ndD6Pe4tFqgKi02E9CMYkZ18jQLEdLlfxFrhbCGycsVPdTduCTGDmF23DCAmwelMf1
         595N7z+3QuXxkbWPrQa1DFZS8vdZYK27eS/jYYoPPF6f81zYhkobXESK3850BZmOuK
         Lnd8mo5M9e8uPvkBfpTNvSjBuDVPgdxcPdzTc/26Cl2POCdantVg2CcQB4W2u9ycLt
         YwwiqDc13Ud1yYq7/uHC2eP5tJPZN4U+PC/jxcQ6edLmmzQ+lyl0jjBS9/j5DL7olG
         /xTgNUiGaUZBWjFJJ3rEIusjSrK9tdweouwg9Krd2W/zgmZYoDvwbeC433wznv6pYb
         PTb+iva75OLJIGUiNZYauRRNhTThCtul0zDSIIChu3RzawHgjHT
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 0/2] Asciidoctor native manpage builds
Date:   Fri, 14 May 2021 00:31:02 +0000
Message-Id: <20210514003104.94644-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d
In-Reply-To: <609b2828309fc_678ff2082@natae.notmuch>
References: <609b2828309fc_678ff2082@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series introduces native support for building manual pages with
Asciidoctor, which is faster and somewhat easier than building with the
DocBook toolchain.

The first patch in the series is based on one by Felipe Contreras but
differs from his in that we default to the old behavior, in addition to
some additional functionality and a more verbose commit message.

The second patch drops support for GNU_ROFF, which is now supported in a
more robust way by both the Asciidoctor and DocBook toolchains.

Changes from v1:
* Rephrase commit messages and Makefile text for both patches to clarify
  and avoid ambiguity.
* Avoid using XML-style escapes in man pages, which are not XML- or
  HTML-based.
* Clarify that USE_ASCIIDOCTOR_MANPAGE requires USE_ASCIIDOCTOR to be
  functional.
* Escape linkgit macro output to avoid backslashes being needlessly
  converted.
* Remove leftover reference to GNU_ROFF.

brian m. carlson (2):
  doc: add an option to have Asciidoctor build man pages directly
  doc: remove GNU_ROFF option

 Documentation/Makefile                  | 25 +++++++++++++++----------
 Documentation/asciidoctor-extensions.rb |  2 ++
 Documentation/manpage-quote-apos.xsl    | 16 ----------------
 Makefile                                |  8 ++++----
 4 files changed, 21 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/manpage-quote-apos.xsl

Diff-intervalle contre v1 :
1:  9ba34d9ec9 ! 1:  0d5f8f1b80 doc: add an option to have Asciidoctor build man pages directly
    @@
      ## Metadata ##
    -Author: Felipe Contreras <felipe.contreras@gmail.com>
    +Author: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## Commit message ##
         doc: add an option to have Asciidoctor build man pages directly
    @@ Commit message
         by the GNU_ROFF option.  This option for the DocBook toolchain, as well
         as newer versions of Asciidoctor, makes groff output an ASCII apostrophe
         instead of a Unicode apostrophe in text, so as to make copy and pasting
    -    commands easier.  These newer versions of Asciidoctor detect groff and
    -    do the right thing in all cases, so the GNU_ROFF option is obsolete in
    -    this case.
    +    commands easier.  These newer versions of Asciidoctor (1.5.3 and above)
    +    detect groff and do the right thing in all cases, so the GNU_ROFF option
    +    is obsolete in this case.
     
         We also need to update the code that tells Asciidoctor how to format our
         linkgit macros so that it can output proper code for man pages.  Be
         careful to reset the font to the previous after the change.  In order to
         do so, we must reset to the previous after each font change so the
         previous state at the end is the state before our inserted text, since
    -    troff only remembers one previous font.
    +    troff only remembers one previous font.  We insert \e before each
    +    font-change backslash so Asciidoctor doesn't convert them into \*(rs,
    +    the reverse solidus character, and instead leaves them as we wanted
    +    them.
    +
    +    Additionally, we don't want to use XML-style escapes for the litdd and
    +    plus macros, so let's only use the XML-style escapes in HTML and XML and
    +    use something different for our man pages.
     
         Because Asciidoctor versions before 2.0 had a few problems with man page
         output, let's default this to off for now, since some common distros are
    @@ Commit message
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## Documentation/Makefile ##
    -@@ Documentation/Makefile: ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
    +@@ Documentation/Makefile: ASCIIDOC_HTML = xhtml5
    + ASCIIDOC_DOCBOOK = docbook5
    + ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
    + ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
    +-ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
    ++TXT_TO_HTML += -alitdd='&\#x2d;&\#x2d;'
    ++TXT_TO_XML  += -alitdd='&\#x2d;&\#x2d;'
      DBLATEX_COMMON =
      XMLTO_EXTRA += --skip-validation
      XMLTO_EXTRA += -x manpage.xsl
     +ifdef USE_ASCIIDOCTOR_MANPAGE
     +TXT_TO_MAN = $(ASCIIDOC_COMMON) -b manpage
    ++TXT_TO_MAN += -aplus='+'
    ++TXT_TO_MAN += -alitdd='\--'
     +endif
      endif
      
      SHELL_PATH ?= $(SHELL)
    +@@ Documentation/Makefile: mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
    + 		show_tool_names can_merge "* " || :' >mergetools-merge.txt && \
    + 	date >$@
    + 
    +-TRACK_ASCIIDOCFLAGS = $(subst ','\'',$(ASCIIDOC_COMMON):$(ASCIIDOC_HTML):$(ASCIIDOC_DOCBOOK))
    ++TRACK_ASCIIDOCFLAGS = $(subst ','\'',$(ASCIIDOC_COMMON):$(ASCIIDOC_HTML):$(ASCIIDOC_DOCBOOK):$(USE_ASCIIDOCTOR_MANPAGE))
    + 
    + GIT-ASCIIDOCFLAGS: FORCE
    + 	@FLAGS='$(TRACK_ASCIIDOCFLAGS)'; \
     @@ Documentation/Makefile: $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf asciidoctor-extensions.rb GIT-AS
      manpage-base-url.xsl: manpage-base-url.xsl.in
      	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
    @@ Documentation/asciidoctor-extensions.rb: module Git
              elsif parent.document.basebackend? 'html'
                %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
     +        elsif parent.document.basebackend? 'manpage'
    -+          %(\\fB#{target}\\fP\\fR(#{attrs[1]})\\fP)
    ++          %(\e\\fB#{target}\e\\fP\e\\fR(#{attrs[1]})\e\\fP)
              elsif parent.document.basebackend? 'docbook'
                "<citerefentry>\n" \
                  "<refentrytitle>#{target}</refentrytitle>" \
    @@ Makefile: all::
      # documentation.
      #
     +# Define USE_ASCIIDOCTOR_MANPAGE to use Asciidoctor's manual page backend
    -+# instead of building manual pages from DocBook.
    ++# instead of building manual pages from DocBook (using xmlto).  Has no effect
    ++# unless USE_ASCIIDOCTOR is set.
     +#
      # Define ASCIIDOCTOR_EXTENSIONS_LAB to point to the location of the Asciidoctor
      # Extensions Lab if you have it available.
2:  c0a21dd700 ! 2:  b12a068f5b doc: remove GNU_ROFF option
    @@ Commit message
         GNU_ROFF code.
     
         Additionally, this functionality was implemented in 2010.  Since nobody
    -    is shipping security support for an operating system that old anymore,
    -    we can just safely assume that the user has upgraded their system in the
    -    past decade and remove the GNU_ROFF option and its corresponding
    -    stylesheet altogether.
    +    is shipping a mainstream Linux distribution with security support that
    +    old anymore, we can just safely assume that the user has upgraded their
    +    system in the past decade and remove the GNU_ROFF option and its
    +    corresponding stylesheet altogether.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
    @@ Documentation/manpage-quote-apos.xsl (deleted)
     -</xsl:template>
     -
     -</xsl:stylesheet>
    +
    + ## Makefile ##
    +@@ Makefile: all::
    + # Define NO_ST_BLOCKS_IN_STRUCT_STAT if your platform does not have st_blocks
    + # field that counts the on-disk footprint in 512-byte blocks.
    + #
    +-# Define GNU_ROFF if your target system uses GNU groff.  This forces
    +-# apostrophes to be ASCII so that cut&pasting examples to the shell
    +-# will work.
    +-#
    + # Define USE_ASCIIDOCTOR to use Asciidoctor instead of AsciiDoc to build the
    + # documentation.
    + #
