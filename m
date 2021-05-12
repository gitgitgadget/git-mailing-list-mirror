Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0D7C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82FE46161F
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhELCM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 22:12:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52458 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229920AbhELCM5 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 May 2021 22:12:57 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C076260B17;
        Wed, 12 May 2021 02:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620785510;
        bh=7y8LF+lUbk/ViIDGL2RfKYdEqHF/2oLb7KyBEtmPYms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=dTRXy4ixJ/U308Frm9aLzN4Gz4FNh1mt+//GFoYNfNmywd6ywMLbxYMCKjCcQS6jy
         rf3lOh0cfz5jb5ofu8bcYBjtXQDcXu5hl3WaEAWz11+Z/diuFOlgBHXsUg+vEV7FTK
         ROTV1juj+QvlCxsDfsEEp85YRGXGxkVqBdkKTGMvk/2+Ehrg2KIT2Jd5Gf+xSzcTWp
         fsysABHM7vBdhhsYwU1a4LiwgAozNgWf83IxxRCybn/V+cBONM2UHmRYOtZbXipvYT
         qDqOdfa+BdUwQVCjbi0CL5H3gRS2vQXa9Cpr5qkGyEd42/zkYsUn7k5kTP0E09xWcY
         6Vs73fFV+SV4q6gEzDfxSQRMBapepMT70dzOEv7ZbpgCqYKK9+0EMjpF8+pGHPICwd
         +vv5PRKqJ/cvqDmJyFPmDMvhnLEgBHgp1G+t5/XJma9edfGD7DdXK2cDuLfSlCJIY8
         JVwjzYGPVo49ptC/8dOCBKZbfZhlTVgqvMOWZbptt/QdMB7B3hl
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 2/2] doc: remove GNU_ROFF option
Date:   Wed, 12 May 2021 02:11:38 +0000
Message-Id: <20210512021138.63598-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d
In-Reply-To: <20210512021138.63598-1-sandals@crustytoothpaste.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210512021138.63598-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By default, groff converts apostrophes in troff source to Unicode
apostrophes.  This is helpful and desirable when being used as a
typesetter, since it makes the output much cleaner and more readable,
but it is a problem in manual pages, since apostrophes are often used
around shell commands and these should remain in their ASCII form for
compatibility with the shell.

Fortunately, the DocBook stylesheets contain a workaround for this case:
they detect the special .g number register, which is set only when using
groff, and they define a special macro for apostrophes based on whether
or not it is set and use that macro to write out the proper character.
As a result, the DocBook stylesheets handle all cases correctly
automatically, whether the user is using groff or not, unlike our
GNU_ROFF code.

Additionally, this functionality was implemented in 2010.  Since nobody
is shipping security support for an operating system that old anymore,
we can just safely assume that the user has upgraded their system in the
past decade and remove the GNU_ROFF option and its corresponding
stylesheet altogether.
---
 Documentation/Makefile               |  8 --------
 Documentation/manpage-quote-apos.xsl | 16 ----------------
 2 files changed, 24 deletions(-)
 delete mode 100644 Documentation/manpage-quote-apos.xsl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 536d9a5f3d..f3816772cf 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -177,14 +177,6 @@ MAN_BASE_URL = file://$(htmldir)/
 endif
 XMLTO_EXTRA += -m manpage-base-url.xsl
 
-# If your target system uses GNU groff, it may try to render
-# apostrophes as a "pretty" apostrophe using unicode.  This breaks
-# cut&paste, so you should set GNU_ROFF to force them to be ASCII
-# apostrophes.  Unfortunately does not work with non-GNU roff.
-ifdef GNU_ROFF
-XMLTO_EXTRA += -m manpage-quote-apos.xsl
-endif
-
 ifdef USE_ASCIIDOCTOR
 ASCIIDOC = asciidoctor
 ASCIIDOC_CONF =
diff --git a/Documentation/manpage-quote-apos.xsl b/Documentation/manpage-quote-apos.xsl
deleted file mode 100644
index aeb8839f33..0000000000
--- a/Documentation/manpage-quote-apos.xsl
+++ /dev/null
@@ -1,16 +0,0 @@
-<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
-		version="1.0">
-
-<!-- work around newer groff/man setups using a prettier apostrophe
-     that unfortunately does not quote anything when cut&pasting
-     examples to the shell -->
-<xsl:template name="escape.apostrophe">
-  <xsl:param name="content"/>
-  <xsl:call-template name="string.subst">
-    <xsl:with-param name="string" select="$content"/>
-    <xsl:with-param name="target">'</xsl:with-param>
-    <xsl:with-param name="replacement">\(aq</xsl:with-param>
-  </xsl:call-template>
-</xsl:template>
-
-</xsl:stylesheet>
