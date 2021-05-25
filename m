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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6C0C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B328661423
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhEYKtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 06:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbhEYKtg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 06:49:36 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A74C061756
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:05 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so16987098otk.5
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PpJMC6KUqTNLKh7b5a+5L94zbQfMGs9IUqUaUKeLYac=;
        b=svzxnnuXhKPiZpXutrJNYVFtGXTVD4LpHX8YUjQjPXhiis8bojVnLkuEiWdfRyZ4b9
         HvNOY95CgO/6GyZRgkAoqMIyOgIKLd8F30xEeJS3hEZd/TOejPUpCeda9KVw1edTS4h8
         sxEzPfxaWNkIo0ws7Z4sWrI9ciUdPhweTl9wxc9TQeC9nKEsxKvPylDpZ8jDUFWPcE/Q
         8PQPihXaTaXvhb67IMQozwUnba/n9pGolHP0aEk8rFoDxoOWApUwK6W7fGdC5/bll9en
         3NoJ/d9zBZNEMWIqMMxJHs/e9c+R+JOQTRqgw+7Byjb3BNXqx9C21mdYYp3Li7yfGky4
         w41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PpJMC6KUqTNLKh7b5a+5L94zbQfMGs9IUqUaUKeLYac=;
        b=bQZOxV/oe/JIWo4W07txo7sm+L7tr2qi3bcXRYmy60jdBUwXhbzxp2yw7SJSa00kYT
         ltKP2aA+J3RZ8uQ5QtZPN0WA6Eri/h30h9xUvNbyf5Fj6zNNHdYgm1nhG/oqXWb3hQlA
         jTBou01GSIigWCCiHeTZCo67doFjVlzJ/x/k+yK5Q0VTFrV4d1k2tcyUWiYxp8sXehv5
         74CRftPUyX3tNBgvvaJWcHz1hnKhCbnTxvrPMoZsTeSduqyLVRKAeaUAwghltI/Yaipf
         cUJCgD20aQlHrfke+vzwH9d5mKVULK5n+JDLZ9ptnH+ysxTNyO4X4CLswCW3VkZ6kE/J
         gTLg==
X-Gm-Message-State: AOAM531qqJUBEjKlzrnCCiVUIdCNxYYrMYk2vVSHk1kq4d71G2QPiUBF
        EdtGW9L5C97V5OVLZKBWXf+1gpswnd0CdQ==
X-Google-Smtp-Source: ABdhPJwR+l+gLBeZf886uyLUQ9CAPl/c7mkNOa3eVcO9poyX+q8lF88h6Nux9tscsoJz8pi8koGjxg==
X-Received: by 2002:a05:6830:1284:: with SMTP id z4mr23139323otp.148.1621939684936;
        Tue, 25 May 2021 03:48:04 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id o18sm3683027otp.61.2021.05.25.03.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:48:04 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 01/12] doc: remove GNU troff workaround
Date:   Tue, 25 May 2021 05:47:51 -0500
Message-Id: <20210525104802.158336-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210525104802.158336-1-felipe.contreras@gmail.com>
References: <20210525104802.158336-1-felipe.contreras@gmail.com>
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
index 3a2d3c80a8..55dbdee98e 100644
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
2.32.0.rc0

