Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29DAC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 21:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91F2561279
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 21:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbhFRVyr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 17:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhFRVyr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 17:54:47 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32979C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 14:52:36 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so11143611oti.2
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 14:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=41PFC+E+zjNBS+Do6S+0t/hh5Tk45gkn4+l2AHlLcmU=;
        b=WK8rVRXNoHTd8gTjZkchBwb827ccj4Gu13W9InEKeTZRSsrqCiEcXhKuoE2iYkcj+5
         o/jzc8FpbmDnnbI+XXyZPvr0koYAoNtaqkZrLRD8TZ2+hIJLgmku4ns4NkUD9PskxFVy
         fmjTt8vtZOSKSIlmpPn+qNw0Le0o4olwcbxeHZTQ6UUcBRbmtYL3E3foq9BgmOvFGnPg
         7HAoIc6l/rB7zjFEgf6NoI3KyRRL7Cl8E0l4530VRluKgsS1LPJWDF0IXUYsSHV7nIrl
         lh1sXKHehayXOW7czPlewWkw7CmdaU2nRgYa510gJxHaeUiq2/STKbwF7iCrzfXq6jD0
         f/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=41PFC+E+zjNBS+Do6S+0t/hh5Tk45gkn4+l2AHlLcmU=;
        b=Ww0VyBz0nk1cSs5NOJ12gekIs2M7LQrhUBNDdq/M9CdIvrIjIgfZnAtnZ8aM8L1xs4
         VlSFqzAyAjweQapjhS86KKmoCHrTyVLVwlB9HMOpynNK7eaHkv07Q1DMiCd+Byom/uQ4
         CSYnudiiNO995owzstjBe1kcJw1gOD9LSt8vujkNVDuMqdVN31V2LORbTUZKMSAEf3tD
         nbaGV/enlHvS6knqv63UFqhSE9ImUPvrIPfv1IqRDic+dRIV/Z9LD63zWTIB4nCkMZXz
         2jk2bYuuRp/1V91lSGzLGDLnel5YrSpCnw/DNDq2EJqBMCt4rabU3lIXTDgm+GLfjcY2
         BXrw==
X-Gm-Message-State: AOAM5312088SxGcgmerrwn+Lt7x5EhgvPFN1gfp+kpjL3g0qVSH5yYrh
        ir5IwI9+zPdODPLWfw41ny9XhbDckNE/UA==
X-Google-Smtp-Source: ABdhPJwjVGS7NPXGyiXCIDDpIQY/KVHLdeWL3XOm1BP/cAOTSPQ7xEU1gzSB9YTBNsJb2fBkZBVB1A==
X-Received: by 2002:a9d:1c9f:: with SMTP id l31mr10822843ota.244.1624053155341;
        Fri, 18 Jun 2021 14:52:35 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id x31sm2247383ota.24.2021.06.18.14.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 14:52:35 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 1/4] doc: remove GNU troff workaround
Date:   Fri, 18 Jun 2021 16:52:28 -0500
Message-Id: <20210618215231.796592-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618215231.796592-1-felipe.contreras@gmail.com>
References: <20210618215231.796592-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 2007 the docbook project made the mistake of converting ' to \' for
man pages [1]. It's a problem because groff interprets \' as acute
accent which is rendered as ' in ASCII, but as ´ in utf-8.

This started a cascade of bug reports in git [2], debian [3], Arch Linux
[4], docbook itself [5], and probably many others.

A solution was to use the correct groff character: \(aq, which is always
rendered as ', but the problem is that such character doesn't work in
other troff programs.

A portable solution required the use of a conditional character that is
\(aq in groff, but ' in all others:

  .ie \n(.g .ds Aq \(aq
  .el .ds Aq '

The proper solution took time to be implemented in docbook, but in 2010
they did it [6]. So the docbook man page stylesheets were broken from
1.73 to 1.76.

Unfortunately by that point many workarounds already existed. In the
case of git GNU_ROFF was introduced, and in the case of Arch Linux
a mappig from \' to ' was added to groff's man.local. Other
distributions might have done the same, or similar workarounds.

Since 2010 there is not need for this workaround, which is fixed
elsewhere not just in docbook, but other layers as well.

Let's remove it.

Also, it's GNU troff, not GNU roff.

[1] https://github.com/docbook/xslt10-stylesheets/commit/ea2a0bac56c56eec1892ac3d9254dca89f7c5746
[2] https://lore.kernel.org/git/20091012102926.GA3937@debian.b2j/
[3] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=507673#65
[4] https://bugs.archlinux.org/task/9643
[5] https://sourceforge.net/p/docbook/bugs/1022/
[6] https://github.com/docbook/xslt10-stylesheets/commit/fb553434265906ed81edc6d5f533d0b08d200046

Inspired-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile               |  8 --------
 Documentation/manpage-quote-apos.xsl | 16 ----------------
 Makefile                             |  4 ----
 3 files changed, 28 deletions(-)
 delete mode 100644 Documentation/manpage-quote-apos.xsl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f5605b7767..bf1f66b3eb 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -178,14 +178,6 @@ MAN_BASE_URL = file://$(htmldir)/
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
index c3565fc0f8..7588c43f05 100644
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

