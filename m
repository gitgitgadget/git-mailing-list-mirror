Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0733C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1B1261414
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbhKPMH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235900AbhKPMEp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:04:45 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C771EC061230
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:50 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o29so16693760wms.2
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NcgkNGk4LHO5zXDgYbnt0ZesM4Wt3+ivuJEBZM6P0Dc=;
        b=XqqTk2nhtoapzPJYR7S7n2cPeNCg6SXkvsMPxrADbvj4l3zNXmTR9paVK20U7kd0Vl
         FkavxGIGDmIdGSCfgo/x9n7dIY2S5dSX3krJi0/a8SQ5POp+aC/+j1Cg3ecu8NtxI4RX
         oht12LZmK5ygRxZsTnCS8kYQ7BDWPr5U/qd/ew1eFa97pO6kAJsJsnjxpKjZkfWOHyJq
         GahKuYSX4emumVZR1zt7AoOBXyt2Of/wJcEpQK5h+AC9U9S/r0FISnSKuFEt9dAU9+is
         y8sgp89lngVPf2mLr81zRiQ5CNsxlscslDe/Lu8nOho1xWQppxXAr5MzQbX81ULf4mOm
         riYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NcgkNGk4LHO5zXDgYbnt0ZesM4Wt3+ivuJEBZM6P0Dc=;
        b=u1soKl+PFN/Yt85gPa//tfO4KmfcXidaZgWttX3wUVtMBC6+o8JZ1Mx2KA0tcjnmEp
         gTFKjnCoXpaXHPHjzuwE5L7Be5PmSoxQGHs4/pp5F41jjQupNrYiFmXQ2rESMG4pZ+v+
         K0IwznLHDkw0zbDJeyBZFfBnSt0bmn9REUlS/QEMos+3S32Rk04JWVprxob7kVMCxl4Z
         4QG3wpChptLj+SGbBz8Qo37nfkU6R/x++vnkvvzmlQgUAaewk87fw8FC5oNfWlF3s4Rp
         QIBtFHLRWXKht7dXi8thETRLUk6laxMvbTU7dM5bZVOLW8v11mqZwDH8EFKgChhPcw+1
         kw8A==
X-Gm-Message-State: AOAM530pTM/KJgvZJpWqfMj1P+Bn8xg61LzJVgqODEhW2gC2dHyXhV5x
        lLyKRsU3xYvKvj+mIEeOAYBPCOLYf+5cBg==
X-Google-Smtp-Source: ABdhPJyMiCUndD1d9tsjLs5HRgmzLvNJLBqKiSkLOW29AcP+1GTMesvc1lhx/RK/RLBFhL6iPj5yKg==
X-Received: by 2002:a7b:c005:: with SMTP id c5mr6993796wmb.150.1637064049055;
        Tue, 16 Nov 2021 04:00:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k37sm2427922wms.21.2021.11.16.04.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:00:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 17/23] Makefile: use $(wspfx) for $(QUIET...) in shared.mak
Date:   Tue, 16 Nov 2021 13:00:17 +0100
Message-Id: <patch-v3-17.23-22264f431c8-20211116T114334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com> <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
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
2.34.0.795.g1e9501ab396

