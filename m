Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AEDB1F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 21:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbdAUV75 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 16:59:57 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:38740 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751446AbdAUV7k (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Jan 2017 16:59:40 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 79B1D280B2;
        Sat, 21 Jan 2017 21:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1485035966;
        bh=LNeRLQ7F5roJ8STQf1nr97hyKZOGNATbN+dS38B4biQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0WcWrMlIN80Y4xz+DmuOBzmFcB4xrfK0zaDveCSG6qt9pSELRlD/ugkB1ToN29nW3
         s/hWzxJnNW2+KvSdRYrn1neKGykdfCepzR5Oz6U69TxbaPWR9u/h1MkwTbshUj+bTb
         JWVked+QFi5Azz/P94PwY0gpLCRuy2O09v/o1BjlejIFxEL45aIuJanRCFnSR2UUog
         Jnw3FvpHxvQG2bApV+HB3zvKRoW0GmRiUczecxVLvjIkDLZsYqALs1Uv0Pj11aIZkb
         be9DOBUqls/Xsxa0QASCLPY4f5aO07X3HHznCQFWDpY5X+uWRtXdyJTX4BrcjsFIP2
         KvTICc4nhnYeFgpHG5pmmlkxXOu/1/qf9KriGAaOrnqlgwROD5itkIaYidSS08FCeR
         yVS4YZ9FnfDewE43Je4iQqXit2tY+BKA4khKoTXMsjssYOfdNb5ZsRWdxfurIuvG3y
         ZwlhujnlpBpWdEGEanLcPk3uor/Mo5HNhhKQnphFpLpTYrnvDLT
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH 6/7] Documentation: move dblatex arguments into variable
Date:   Sat, 21 Jan 2017 21:59:11 +0000
Message-Id: <20170121215912.246691-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170121215912.246691-1-sandals@crustytoothpaste.net>
References: <20170121215912.246691-1-sandals@crustytoothpaste.net>
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
index 76be7017c..0f4db48eb 100644
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
+	$(DBLATEX) $-o $@+ (DBLATEX_COMMON) $< && \
 	mv $@+ $@
 
 gitman.texi: $(MAN_XML) cat-texi.perl texi.xsl
