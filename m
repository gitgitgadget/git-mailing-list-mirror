Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06342C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 13:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB7920714
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 13:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhEV7CEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgC2NS2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 09:18:28 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39835 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgC2NS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 09:18:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id i20so14957939ljn.6
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3CH15yvnSSZIOsRgxEsX4ZsBiR+Z3VZFmB48WORv7E=;
        b=JhEV7CEnzA26ACDaan0OCokIVHF6ncLC/I1EXOvXaQbQwwWX4XTxgNrgKjBMHKkXev
         ktP9CPS0sFObdz2VGVCGRgArphbMEy3nFzB2Pkbw0OqRtRc0T6G/YOXv7iT0C5oCQtN2
         dUiXx2jpSPvBkVd55pjlRvbAwrf4nBB7qylxcFx4st0+DtZQLjSE7/1Ko3pQR6t49Wds
         hfM3seFBmIWB/YlDC3Rkt+uO4DK7CKxiS1bLSNeALkqFOgwpeSy4UmSO0gGWTa/6shbf
         qu5HWTKi9/aNvY/ySe8NNjZ+Lz5u0Xg3XhTYZqiKnDwUQNDedgvGo9A9Uak73LeTfiYA
         Puvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3CH15yvnSSZIOsRgxEsX4ZsBiR+Z3VZFmB48WORv7E=;
        b=SsaaIklQFXJNteutC6r5X4YMyEcAyvviTkQ8UwGOq9chD7bYmYiifhZGCEugtYy/vv
         qiDLZF+pa6kSIBzps8c6sEtLd6Dz+MwnVoQPbNQvbAqKHtGWEp9dAedU9G36dsdMymYi
         +46a8rNsK6znAZ1q2gN1c+n+54eqV2BtdWWcBX1+r/47GXl5p6sT3hl8CVb8cacs+0p7
         xHT8BT1ByF8EDfd3fJKJbrMF50ZrIGy6HboI7s3jX5tOZBnL3MwZZnCPnuLIFqvnKD7v
         CawyWhLkV+I3eAHfoGxifBURaCAqNvaCXHd60tv3bXl2U2VPCU98AYoyRaodqD+wWUFu
         1Qhw==
X-Gm-Message-State: AGi0PuY+nljij0/LhYHOH2FaL0dN42cRyEXCnWBvbE7dahNMA//srk/d
        cwvGAtxEv2rWotrrZGDRyHppgPsO
X-Google-Smtp-Source: APiQypJ3Bmp79o+SnjbMpzXNOxpOII9kg8lB0jcGDJINDV/G+wqjVXMIqgLzEQ5DuKdX5wgNbQOTfA==
X-Received: by 2002:a2e:b801:: with SMTP id u1mr4570883ljo.84.1585487906523;
        Sun, 29 Mar 2020 06:18:26 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id d16sm1247742lfm.91.2020.03.29.06.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 06:18:25 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 1/6] Doc: drop support for docbook-xsl before 1.71.1
Date:   Sun, 29 Mar 2020 15:18:05 +0200
Message-Id: <6f697a8310f4f66ca50326486fab46b72a08d263.1585486103.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1585486103.git.martin.agren@gmail.com>
References: <cover.1585486103.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drop the DOCBOOK_SUPPRESS_SP mechanism, which needs to be used with
docbook-xsl versions 1.69.1 through 1.71.0.

We probably broke this for Asciidoctor builds in f6461b82b9
("Documentation: fix build with Asciidoctor 2", 2019-09-15). That is, we
should/could fix this similar to 55aca515eb ("manpage-bold-literal.xsl:
match for namespaced "d:literal" in template", 2019-10-31). But rather
than digging out such an old version of docbook-xsl to test that, let's
just use this as an excuse for dropping this decade-old workaround.

DOCBOOK_SUPPRESS_SP was not needed with docbook-xsl 1.69.0 and older.
Maybe such old versions still work fine on our docs, or maybe not. Let's
just refer to everything before 1.71.1 as "not supported". The next
commit will increase the required/assumed version further.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/Makefile                |  7 +------
 Documentation/manpage-suppress-sp.xsl | 21 ---------------------
 INSTALL                               |  1 +
 3 files changed, 2 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/manpage-suppress-sp.xsl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 8fe829cc1b..c7b805d1ee 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -151,9 +151,7 @@ endif
 
 #
 # For docbook-xsl ...
-#	-1.68.1,	no extra settings are needed?
-#	1.69.0,		set ASCIIDOC_ROFF?
-#	1.69.1-1.71.0,	set DOCBOOK_SUPPRESS_SP?
+#	-1.71.0,	not supported
 #	1.71.1,		set ASCIIDOC_ROFF?
 #	1.72.0,		set DOCBOOK_XSL_172.
 #	1.73.0-,	no extra settings are needed
@@ -172,9 +170,6 @@ endif
 ifndef NO_MAN_BOLD_LITERAL
 XMLTO_EXTRA += -m manpage-bold-literal.xsl
 endif
-ifdef DOCBOOK_SUPPRESS_SP
-XMLTO_EXTRA += -m manpage-suppress-sp.xsl
-endif
 
 # Newer DocBook stylesheet emits warning cruft in the output when
 # this is not set, and if set it shows an absolute link.  Older
diff --git a/Documentation/manpage-suppress-sp.xsl b/Documentation/manpage-suppress-sp.xsl
deleted file mode 100644
index a63c7632a8..0000000000
--- a/Documentation/manpage-suppress-sp.xsl
+++ /dev/null
@@ -1,21 +0,0 @@
-<!-- manpage-suppress-sp.xsl:
-     special settings for manpages rendered from asciidoc+docbook
-     handles erroneous, inline .sp in manpage output of some
-     versions of docbook-xsl -->
-<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
-		version="1.0">
-
-<!-- attempt to work around spurious .sp at the tail of the line
-     that some versions of docbook stylesheets seem to add -->
-<xsl:template match="simpara">
-  <xsl:variable name="content">
-    <xsl:apply-templates/>
-  </xsl:variable>
-  <xsl:value-of select="normalize-space($content)"/>
-  <xsl:if test="not(ancestor::authorblurb) and
-                not(ancestor::personblurb)">
-    <xsl:text>&#10;&#10;</xsl:text>
-  </xsl:if>
-</xsl:template>
-
-</xsl:stylesheet>
diff --git a/INSTALL b/INSTALL
index 22c364f34f..7647ce1320 100644
--- a/INSTALL
+++ b/INSTALL
@@ -206,6 +206,7 @@ Issues of note:
    clone two separate git-htmldocs and git-manpages repositories next
    to the clone of git itself.
 
+   The minimum supported version of docbook-xsl is 1.71.1.
    It has been reported that docbook-xsl version 1.72 and 1.73 are
    buggy; 1.72 misformats manual pages for callouts, and 1.73 needs
    the patch in contrib/patches/docbook-xsl-manpages-charmap.patch
-- 
2.26.0

