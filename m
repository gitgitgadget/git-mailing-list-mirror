Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1215A1F89C
	for <e@80x24.org>; Sun, 22 Jan 2017 02:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750889AbdAVCmV (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 21:42:21 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:39238 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750917AbdAVCmK (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Jan 2017 21:42:10 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 91DBF280B2;
        Sun, 22 Jan 2017 02:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1485052926;
        bh=pMcPeZasLJQm3MW0JG3SThwWdBwwowNxcHBIo8kRxho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vIl2Gan0WZcIuUrHQ76ctKQ/rKBGAURBLZrlK++6LsW9nm5zTJ5kDVzQ74xE+6Bo5
         uwRu1W9H+7GfZ/9LwnEqpyIXpeTJ80HdUWwQGsObK2Gf4H/c6/HUr1snx59fn9yD+k
         Gj0U8w1+0nXkLa1ll3fLAdVnXbwFgUm0rwqMdXRDfpUvrqf49nug0HYhdR2Tc1nSma
         0sFiq4JriDccu+OuVI5clzaHHUNCPFOVMQuzDCFDgs3VepLbtD6LJtZzjmbWaRKKBK
         bp2SZX66Ov8GITITmUGp5sniu7hTKo8bD9TNfoZfA2EeluqYXwMvLnce4ThizK5DGu
         Kw8K3DiPjwsRGIwTqGewbtRMmc18ZrHrcRliWTcSc1zrtTcWA1dxzNQAJQaedWkT0c
         ZzFiQ9KocGNuis0MM2gyOHaNBnSKp5U7Qm9KnrdfL1v2kuGpYzLsX/wQUw63DJMynL
         1Wnwtcih8XoLbeNDK3bqPozuDzRJO89o0nUaPc3QodSFPeFRGv0
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 6/7] Documentation: move dblatex arguments into variable
Date:   Sun, 22 Jan 2017 02:41:55 +0000
Message-Id: <20170122024156.284180-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170122024156.284180-1-sandals@crustytoothpaste.net>
References: <20170122024156.284180-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our dblatex invocation uses several style components from the AsciiDoc
distribution, but those components are not available when building with
Asciidoctor.  Move the command line arguments into a variable so it can
be overridden by the user or makefile configuration options.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 76be7017c..d95002e62 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -120,6 +120,7 @@ INSTALL_INFO = install-info
 DOCBOOK2X_TEXI = docbook2x-texi
 DBLATEX = dblatex
 ASCIIDOC_DBLATEX_DIR = /etc/asciidoc/dblatex
+DBLATEX_COMMON = -p $(ASCIIDOC_DBLATEX_DIR)/asciidoc-dblatex.xsl -s $(ASCIIDOC_DBLATEX_DIR)/asciidoc-dblatex.sty
 ifndef PERL_PATH
 	PERL_PATH = /usr/bin/perl
 endif
@@ -368,7 +369,7 @@ user-manual.texi: user-manual.xml
 
 user-manual.pdf: user-manual.xml
 	$(QUIET_DBLATEX)$(RM) $@+ $@ && \
-	$(DBLATEX) -o $@+ -p $(ASCIIDOC_DBLATEX_DIR)/asciidoc-dblatex.xsl -s $(ASCIIDOC_DBLATEX_DIR)/asciidoc-dblatex.sty $< && \
+	$(DBLATEX) -o $@+ $(DBLATEX_COMMON) $< && \
 	mv $@+ $@
 
 gitman.texi: $(MAN_XML) cat-texi.perl texi.xsl
