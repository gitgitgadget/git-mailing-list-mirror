Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA428C43219
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4AA560FE7
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbhKLVw2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 16:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbhKLVwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 16:52:16 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31E4C06120B
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:24 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s13so17927492wrb.3
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3OwKm/HU1WpT1yIwrMvNcrq2ZhOaCcpZp9Vl5Whjmjs=;
        b=c1bH9+WoWjVZWkdA4ubM1F+97KILN+QuLVA9eiQZwvXTs8G9Id6lF4zM2T+Xcownb9
         iw3j1NjG5mJSmV16WVnT4L5vmnG47VzLt7P0SKJNCyBW7DqKN8TLg6pefq3Wwkjy3Drw
         jtXkmi7hq8+9HDJ/Pk8Z6L4nhGceeG0ZxXsrziEYM3XJuixiB25yM2z0z/6+RVhgY829
         xNwLCID1Laj4uIRIMfFJZnTsYulPmjsFhE2uN3BSE68piFXqU3qXhsbrvfOT01LNU0qx
         OedwZSMMPVi/aXhDdHM9wpy9NVE3OSBOPxzVRA3Xdm9Kxx8zgYbZfz6tx8PRkiabOuWc
         bFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3OwKm/HU1WpT1yIwrMvNcrq2ZhOaCcpZp9Vl5Whjmjs=;
        b=d6zWbCLKT1K6uqJBzWDyyO3OoArYzB2Ot2ayU5t0u/x8+owckOf5Nfr9S+oK+UiPPe
         mhaxTHD19C0BnOlVmm1DysFlAEospCbSe0v2J2KSoIF5EgvY2uYrd2wOGnC7gBvOz0yD
         zNV5WiSkGR6+DTfob/fppPjUaIZ5+6AVdlG7a/HmV684y3QRJqsQR7DzqqNob/GFBzaI
         q90ed3QprlFCpTWjsn3sSGvEpQ4NGiikiiagxbeNfiZdpCMOBwhFHxCBlmNv1sNPbmEJ
         ky9tcfGpITRhb7Dvi64qqK/QJESoYqsfPexAImgmlR3TqPBXoQmVi4O17cFMTtfykX6l
         26yg==
X-Gm-Message-State: AOAM531urW4SCz5fwobDB2g5+XpPrvrjyKqnx0ud0dGHyQluWywUJM1X
        Zulb9Y4xZ+JFEC/7FUVjohmdo1/2/Mxqhg==
X-Google-Smtp-Source: ABdhPJz5qO9L4r0vxvSjIGlnga6Rsh4E8ZRRs3OTEg0HgB9c5ZO3vAk1nl2Z0griEXUDRv4GooaCFw==
X-Received: by 2002:a05:6000:18ad:: with SMTP id b13mr22272312wri.195.1636753762842;
        Fri, 12 Nov 2021 13:49:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h27sm14117189wmc.43.2021.11.12.13.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:49:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 17/18] Makefile: use $(wspfx) for $(QUIET...) in shared.mak
Date:   Fri, 12 Nov 2021 22:49:01 +0100
Message-Id: <patch-v2-17.18-34f692144d1-20211112T214150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com> <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the mostly move-only change in the preceding commit to use the
$(wspfx) variable for defining the QUIET padding, to guarantee that
it's consistent with the "TRACK_template" template.

    $ make CFLAGS=-I$RANDOM grep.o wspfx='$(space)->'
     -> GIT-CFLAGS PARAMETERS (changed)
     -> CC grep.o

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 shared.mak | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/shared.mak b/shared.mak
index 80176f705fc..a1b62b272f8 100644
--- a/shared.mak
+++ b/shared.mak
@@ -50,39 +50,39 @@ ifneq ($(findstring s,$(MAKEFLAGS)),s)
 ifndef V
 ## common
 	QUIET_SUBDIR0  = +@subdir=
-	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
+	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo $(wspfx_sq) SUBDIR $$subdir; \
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
 
 	QUIET          = @
-	QUIET_GEN      = @echo '   ' GEN $@;
+	QUIET_GEN      = @echo $(wspfx_sq) GEN $@;
 
 ## Used in "Makefile"
-	QUIET_CC       = @echo '   ' CC $@;
-	QUIET_AR       = @echo '   ' AR $@;
-	QUIET_LINK     = @echo '   ' LINK $@;
-	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
-	QUIET_LNCP     = @echo '   ' LN/CP $@;
-	QUIET_XGETTEXT = @echo '   ' XGETTEXT $@;
-	QUIET_MSGFMT   = @echo '   ' MSGFMT $@;
-	QUIET_GCOV     = @echo '   ' GCOV $@;
-	QUIET_SP       = @echo '   ' SP $<;
-	QUIET_HDR      = @echo '   ' HDR $(<:hcc=h);
-	QUIET_RC       = @echo '   ' RC $@;
-	QUIET_SPATCH   = @echo '   ' SPATCH $<;
+	QUIET_CC       = @echo $(wspfx_sq) CC $@;
+	QUIET_AR       = @echo $(wspfx_sq) AR $@;
+	QUIET_LINK     = @echo $(wspfx_sq) LINK $@;
+	QUIET_BUILT_IN = @echo $(wspfx_sq) BUILTIN $@;
+	QUIET_LNCP     = @echo $(wspfx_sq) LN/CP $@;
+	QUIET_XGETTEXT = @echo $(wspfx_sq) XGETTEXT $@;
+	QUIET_MSGFMT   = @echo $(wspfx_sq) MSGFMT $@;
+	QUIET_GCOV     = @echo $(wspfx_sq) GCOV $@;
+	QUIET_SP       = @echo $(wspfx_sq) SP $<;
+	QUIET_HDR      = @echo $(wspfx_sq) HDR $(<:hcc=h);
+	QUIET_RC       = @echo $(wspfx_sq) RC $@;
+	QUIET_SPATCH   = @echo $(wspfx_sq) SPATCH $<;
 
 ## Used in "Documentation/Makefile"
-	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
-	QUIET_XMLTO	= @echo '   ' XMLTO $@;
-	QUIET_DB2TEXI	= @echo '   ' DB2TEXI $@;
-	QUIET_MAKEINFO	= @echo '   ' MAKEINFO $@;
-	QUIET_DBLATEX	= @echo '   ' DBLATEX $@;
-	QUIET_XSLTPROC	= @echo '   ' XSLTPROC $@;
-	QUIET_GEN	= @echo '   ' GEN $@;
+	QUIET_ASCIIDOC	= @echo $(wspfx_sq) ASCIIDOC $@;
+	QUIET_XMLTO	= @echo $(wspfx_sq) XMLTO $@;
+	QUIET_DB2TEXI	= @echo $(wspfx_sq) DB2TEXI $@;
+	QUIET_MAKEINFO	= @echo $(wspfx_sq) MAKEINFO $@;
+	QUIET_DBLATEX	= @echo $(wspfx_sq) DBLATEX $@;
+	QUIET_XSLTPROC	= @echo $(wspfx_sq) XSLTPROC $@;
+	QUIET_GEN	= @echo $(wspfx_sq) GEN $@;
 	QUIET_STDERR	= 2> /dev/null
 
-	QUIET_LINT_GITLINK	= @echo '   ' LINT GITLINK $<;
-	QUIET_LINT_MANSEC	= @echo '   ' LINT MAN SEC $<;
-	QUIET_LINT_MANEND	= @echo '   ' LINT MAN END $<;
+	QUIET_LINT_GITLINK	= @echo $(wspfx_sq) LINT GITLINK $<;
+	QUIET_LINT_MANSEC	= @echo $(wspfx_sq) LINT MAN SEC $<;
+	QUIET_LINT_MANEND	= @echo $(wspfx_sq) LINT MAN END $<;
 
 	export V
 endif
-- 
2.34.0.rc2.795.g926201d1cc8

