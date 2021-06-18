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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFC6C48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 20:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A431613C2
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 20:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbhFRUdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 16:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbhFRUdR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 16:33:17 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC2CC06175F
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 13:31:06 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id k21-20020a4a2a150000b029024955603642so2756824oof.8
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 13:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vAuCKiY9Tdmxu6PI9f8mM1w1jAs4FdJcsuoP/22kCCg=;
        b=F3AqOx0sDj+49Yk/CHyYokzIi/kxXSiekkDaEg+Tsfq8iiuS7fuafXSR/6KqKaIlVq
         RkTGqS+O4+Buym1SmATIse7pWumd8PgW1gZNG5luI9zMJXf/R+huMaey1o4LTnnTH9H0
         CF1YVib5xxiz+eKkE/FXJVuu6ClyUxYpqwq7V98ojVfnQRiSjrgU5mmSReuxKRGH2ZD7
         5wGQUezbB9uS2jzjtN5DfCuDbJaEG1Dg+VagkiLDNQv4W4CEaLtU6S2Op3SmVqzWx4gR
         btJdzc0AuZeKDWBTYkbe9GsgG63yZ62heinLV0+Ydqj2b2T6v57kFTjiNwalAZUeuP1R
         VXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vAuCKiY9Tdmxu6PI9f8mM1w1jAs4FdJcsuoP/22kCCg=;
        b=VGuGPPNdsQyEz7PO9jC+T9t1VNRCDBN05jei+KrcDxHuLY000KZNBxfM7vUkcWEEVz
         S18TvJ+cKpIPrHeZTBtSALuvExWCXhA10wwuVa/M6HV2gdjkwJMn3sKTF60dGUWuIpVk
         lRjI/oQgixh70+bbE/jx4HTAG2ktAWsMlovkyDPJWCFWu0V6srjPknpqoW68eoXNabRn
         u5NqHfwdUCMZe7yeMFepOPn3v+OBeDkVRmmeJ7SiuCWbFmS8MXF1JMauPprJTMUNXUew
         9DUr2FWkvCmU6z4D82yXDApUF6uUnXclWTbng3BaxgFHv8cTqH+suCBMq8ZaRUrGwdjL
         H3Aw==
X-Gm-Message-State: AOAM5330fXNFtdUxA182dhVkLnvgo6/uOu0GU99N9yEJre+LkzMczUAA
        tf0sKe/wSwD6bK7WQ60Ko5KFlFqIECkEdg==
X-Google-Smtp-Source: ABdhPJzojFVmrCXXyb0UVzjVce33LFhxiZlf14ggdjCh7JOHdwE186gae+9QWv+z5hx0MRDCHvtrbQ==
X-Received: by 2002:a4a:6f0e:: with SMTP id h14mr10465908ooc.9.1624048266012;
        Fri, 18 Jun 2021 13:31:06 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id h2sm2041723oog.16.2021.06.18.13.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 13:31:05 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC/NOPATCHv3 4/4] doc: remove GNU_ROFF option
Date:   Fri, 18 Jun 2021 15:30:57 -0500
Message-Id: <20210618203057.790320-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618203057.790320-1-felipe.contreras@gmail.com>
References: <20210618203057.790320-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

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
is shipping a mainstream Linux distribution with security support that
old anymore, we can just safely assume that the user has upgraded their
system in the past decade and remove the GNU_ROFF option and its
corresponding stylesheet altogether.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/Makefile               |  8 --------
 Documentation/manpage-quote-apos.xsl | 16 ----------------
 Makefile                             |  4 ----
 3 files changed, 28 deletions(-)
 delete mode 100644 Documentation/manpage-quote-apos.xsl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 53ef100a7a..53a8fa9fd3 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -168,14 +168,6 @@ MAN_BASE_URL = file://$(htmldir)/
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
diff --git a/Makefile b/Makefile
index 48547e2c3b..98484ee88c 100644
--- a/Makefile
+++ b/Makefile
@@ -278,10 +278,6 @@ all::
 # Define NO_ST_BLOCKS_IN_STRUCT_STAT if your platform does not have st_blocks
 # field that counts the on-disk footprint in 512-byte blocks.
 #
-# Define GNU_ROFF if your target system uses GNU groff.  This forces
-# apostrophes to be ASCII so that cut&pasting examples to the shell
-# will work.
-#
 # Define USE_ASCIIDOCTOR to use Asciidoctor instead of AsciiDoc to build the
 # documentation.
 #
-- 
2.32.0

