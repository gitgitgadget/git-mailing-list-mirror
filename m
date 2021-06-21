Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515C1C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3004660200
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhFURA5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhFURAo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:00:44 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC104C061144
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:20 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id x196so20507770oif.10
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=41PFC+E+zjNBS+Do6S+0t/hh5Tk45gkn4+l2AHlLcmU=;
        b=qU2O1VNxwE2J5br/VocFJvOmlkpx+ntylXbqFiWVsRrqTM60bU+olEzA9o/ssr44ZL
         NNCGkFr7+Ek/zJcqAQ6Td/oZC36r0bbmZw9zMQ7lrHgtk2vyg3iTo7clTtVSJot7NQ+B
         5x06GRSTMeF0Jj38yl32K3G7wRUMlDL4shGnf243/BjjivW1zYgdxMxkbNZSp2a6xdXq
         NbWlXe3I4aw0YKkH6FUtxoHHB54MYfUv2mZ+xnVD0rNSEyJxko3IIkg2yB2nf0bGIqu4
         kfaNH5sE/XdV6kcbBuQRktrRI153jRES76CiJUA5ld02DX6r8tcapyt8XxvpJa+TDpAB
         +5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=41PFC+E+zjNBS+Do6S+0t/hh5Tk45gkn4+l2AHlLcmU=;
        b=i8NuWqcQB/zV172oG3AKB5nKT1doXPLKmSjy2Qls2lByLqggwxPF7kJff2wmUPi95L
         qYHzH/3HgunuetWBHMvD3enGKrkVfk8mQtAaeurwm4Yzqy9XtRhSiVeTHxvVLmiT452V
         8MGWhFSePD4EcPnYqMVqUZDvoSK592TAUO5gOxDhgryDK5gtqJ8Hjq0ZrATxeLLX1o5Q
         S1eVtYhsH7waHRbjLye6+DSXtlKhk1csZ6w6gveTMpnXTC76jJjBepfIZ8eGZQ8g1eZV
         jUg4mKoMtI81ykkCcb8FtfyDyQBsrtBSscGv4IanN7EVZQoltQBpkz/ks8pgS00+nAC2
         Xnag==
X-Gm-Message-State: AOAM533hqimt+tFOBNQIIklOUharCjP6y46ACOl2yXoizg5jiR90Huwd
        L5YGJX4/qMFldZmIFMNvAvEblgYVx+lupg==
X-Google-Smtp-Source: ABdhPJwqddrnWyNL3rJp7aLexQqYHesReceTWDN8p5DV4m17DR32IgxvUFRho06IpiS42jY1mMqKKA==
X-Received: by 2002:a05:6808:200d:: with SMTP id q13mr17921568oiw.24.1624293079850;
        Mon, 21 Jun 2021 09:31:19 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id w12sm3357598oor.35.2021.06.21.09.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:31:19 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 01/23] doc: remove GNU troff workaround
Date:   Mon, 21 Jun 2021 11:30:48 -0500
Message-Id: <20210621163110.1074145-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
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

