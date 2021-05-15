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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD01C433ED
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FFD2613B5
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhEOL6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 07:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhEOL6L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 07:58:11 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB885C061573
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:56:57 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id j75so2039681oih.10
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=13FZ22kzClkXXGCXWszEtqo2ZqmLq3CraeHJYFpBRZU=;
        b=ij6rtM46p5GbPWEAFEJSoyqjBA5QETmwZ9MraJZ00I4KWg9hkzUPj+t9NAIhY6fGoE
         iNouxtvXiJmVY2NWVF7+j04erUbCa16Aw+BYxL/iAJ9mvXahSE72qFk2oYDGvZDTzH/N
         E5zyPp2t1C/I08Cthx1bEgpdqnafVTfYsNWW9wv94/HAHx5jwNOS4p0TUgp9Qw0OY0P8
         XnfwBMtsS5eOaeWGUgB9EFq93N7+7PiflfZcmb8gj0LwRWzDo2ucYHoEy+EOARaqGuQ4
         1lM5wa+A0EpIJmH4pc1DaZx7JzgDCkCxTDX/1FZMIE3omSPDr54wPjv5PRh+jMNSAZ24
         qnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=13FZ22kzClkXXGCXWszEtqo2ZqmLq3CraeHJYFpBRZU=;
        b=szQAAZH9JUIBphgH3rbc3YLnevTNuLNeYmhl/ucMT5/uyoQ+fayXQtreTVgN0mn5TM
         WB1RXETsJp4ipsw3R5Cp9XVYR5beXy196sltayK693gV8UPYRWAAYuq9WFBR5VGpkMXj
         LlglJMtoHJxQPT1kKLHwyPRN3CusKaC05zIclCsD+pDsknZC/13RSf97yxw5tHcJ0AQ3
         qxTzt/F4OWViMPrX2ny0MV8GNIfjrSJLRnOG/pgDGy4LOO27dS9ZkGPKaeqWaKO6oKPv
         OpnZCRnjayvbbJHdCeq22AXjCVPunaD25T/ZTtUrzq0vWLoZjcu1arnhbo7r5857rkbu
         ki1Q==
X-Gm-Message-State: AOAM530ZJ9MFRU94GaAw/lB4Bm97TSsSyGWookN0bJCjY0QP9V/l00D2
        hgDtyWYCOSXpS8/kplFaI6Z2l5m8k49D/Q==
X-Google-Smtp-Source: ABdhPJyM5jlyVwTEqEfNojbF5yVdEDrvFBrlnyTcL/zF85dQOnjo9ZgL8MQg3QyNzC7HAyCJpYIB0A==
X-Received: by 2002:aca:4acf:: with SMTP id x198mr36527314oia.111.1621079816898;
        Sat, 15 May 2021 04:56:56 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id f9sm1932354otq.27.2021.05.15.04.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 04:56:56 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 01/12] doc: remove GNU troff workaround
Date:   Sat, 15 May 2021 06:56:42 -0500
Message-Id: <20210515115653.922902-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515115653.922902-1-felipe.contreras@gmail.com>
References: <20210515115653.922902-1-felipe.contreras@gmail.com>
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
diff --git a/Makefile b/Makefile
index 93664d6714..2a94cef62f 100644
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
2.31.1

