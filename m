Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4112C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 12:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241967AbiCBMup (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241961AbiCBMuh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 07:50:37 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B219C2E48
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 04:49:48 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p4so1070265wmg.1
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 04:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0vpY75k4+/LjtypE8oOo+8hz0gbmBZ+WR1AbXn/+PXM=;
        b=itXh1TznK9NjR2E2ahW6XBPrmhqUC7zIoC5QiIylX90cfPxlK3GIv75itaDBxkrooI
         K05HmmJW8ERgH39RLJtam65M4QLFBPgr9Ug98nMhnZU0OVAXuMwCfEe8Bdt5FeMIWQ4R
         fp4amxO1+KPkVD0Woqyr5/w66MUvjyc+2MY5xIfQgpf9XuhdJIs5OlYoxokBukcYIwjC
         YqDFs5GbvtKj5pVLsgD0ka1N0qYqLI8NX4YiL6raqG26MHcBdlLy5GfvmOXnmKozqcXJ
         LJiFcvG+aQSwoZMLciQtbSI2FMmPxzQJlVDF5VouiX3IoFoxIqgSNb+YhViO4oz62qwF
         gnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0vpY75k4+/LjtypE8oOo+8hz0gbmBZ+WR1AbXn/+PXM=;
        b=edDxuzqpPpbnvzf1woA4drwQC8Q/OTtNHfuyb6TXTEHIi9BlljvPYgo0DIfKRINqhu
         sz8ycKwWp6dibrdkkpmTlQgp0SDNAlZN1eCL+6cUkeSZoCZw2QtXqWJzwk4le9LBiHFB
         hgQZt1xDa544rLYqrhz3hVdIEsHb34Mt1PFQEv4C/ogkuC3BMaikbhk60N0nMe2MUiAt
         Tzm9rrylYU/RzmXebiH7mSmzZn+BM6MIKaiWoSL3GcZIj2reNAKm2SccAcqWGLtVrBXE
         rKB6B+EtioOguPpyPhyAleMWP51/JD7FFpMnnThPKQ6mprjJ7kSZ/uAGn55sBFwR7x3f
         tprg==
X-Gm-Message-State: AOAM532XCr8F8ZjEqe3FrYy2DNELaeu1MxHWKpqFStCcxsqHRRkAg09B
        UQV6TtAJik/BNa4yNgRtUTzHGW2niAnuHA==
X-Google-Smtp-Source: ABdhPJzgHaTTOTn/BzvVkF8HJi3eQn7ulrygB7g7ZiYG1XRbkB3273xG4f/6DUftTpIMozWMoUizjQ==
X-Received: by 2002:a05:600c:4c9a:b0:381:2d4a:759a with SMTP id g26-20020a05600c4c9a00b003812d4a759amr20704024wmp.57.1646225386261;
        Wed, 02 Mar 2022 04:49:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p30-20020a1c545e000000b003811f9102c0sm8210107wmi.32.2022.03.02.04.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 04:49:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 8/9] Makefile: use $(wspfx) for $(QUIET...) in shared.mak
Date:   Wed,  2 Mar 2022 13:49:16 +0100
Message-Id: <patch-v4-8.9-3733b0c8df1-20220302T124320Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the mostly move-only change in the preceding commit to use the
$(wspfx) variable for defining the QUIET padding. This refactoring
will make it easier to emit that exact amount of padding in functions
that we might add to shared.mak in the future.

Such a function is not part of this patch series, but a
"TRACK_template" that I'd like to add as a follow-up to it makes use
of this. Let's make this change now while modifying these QUIET rules
is fresh in our minds.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 shared.mak | 54 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/shared.mak b/shared.mak
index c45b2812eb6..bb910273538 100644
--- a/shared.mak
+++ b/shared.mak
@@ -32,6 +32,12 @@ comma := ,
 empty :=
 space := $(empty) $(empty)
 
+## wspfx: the whitespace prefix padding for $(QUIET...) and similarly
+## aligned output.
+wspfx = $(space)$(space)$(space)
+wspfx_SQ = '$(subst ','\'',$(wspfx))'
+# ' closing quote to appease Emacs make-mode.elxo
+
 ### Quieting
 ## common
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
@@ -47,39 +53,39 @@ ifneq ($(findstring s,$(MAKEFLAGS)),s)
 ifndef V
 ## common
 	QUIET_SUBDIR0  = +@subdir=
-	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
+	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo $(wspfx_SQ) SUBDIR $$subdir; \
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
 
 	QUIET          = @
-	QUIET_GEN      = @echo '   ' GEN $@;
+	QUIET_GEN      = @echo $(wspfx_SQ) GEN $@;
 
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
+	QUIET_CC       = @echo $(wspfx_SQ) CC $@;
+	QUIET_AR       = @echo $(wspfx_SQ) AR $@;
+	QUIET_LINK     = @echo $(wspfx_SQ) LINK $@;
+	QUIET_BUILT_IN = @echo $(wspfx_SQ) BUILTIN $@;
+	QUIET_LNCP     = @echo $(wspfx_SQ) LN/CP $@;
+	QUIET_XGETTEXT = @echo $(wspfx_SQ) XGETTEXT $@;
+	QUIET_MSGFMT   = @echo $(wspfx_SQ) MSGFMT $@;
+	QUIET_GCOV     = @echo $(wspfx_SQ) GCOV $@;
+	QUIET_SP       = @echo $(wspfx_SQ) SP $<;
+	QUIET_HDR      = @echo $(wspfx_SQ) HDR $(<:hcc=h);
+	QUIET_RC       = @echo $(wspfx_SQ) RC $@;
+	QUIET_SPATCH   = @echo $(wspfx_SQ) SPATCH $<;
 
 ## Used in "Documentation/Makefile"
-	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
-	QUIET_XMLTO	= @echo '   ' XMLTO $@;
-	QUIET_DB2TEXI	= @echo '   ' DB2TEXI $@;
-	QUIET_MAKEINFO	= @echo '   ' MAKEINFO $@;
-	QUIET_DBLATEX	= @echo '   ' DBLATEX $@;
-	QUIET_XSLTPROC	= @echo '   ' XSLTPROC $@;
-	QUIET_GEN	= @echo '   ' GEN $@;
+	QUIET_ASCIIDOC	= @echo $(wspfx_SQ) ASCIIDOC $@;
+	QUIET_XMLTO	= @echo $(wspfx_SQ) XMLTO $@;
+	QUIET_DB2TEXI	= @echo $(wspfx_SQ) DB2TEXI $@;
+	QUIET_MAKEINFO	= @echo $(wspfx_SQ) MAKEINFO $@;
+	QUIET_DBLATEX	= @echo $(wspfx_SQ) DBLATEX $@;
+	QUIET_XSLTPROC	= @echo $(wspfx_SQ) XSLTPROC $@;
+	QUIET_GEN	= @echo $(wspfx_SQ) GEN $@;
 	QUIET_STDERR	= 2> /dev/null
 
-	QUIET_LINT_GITLINK	= @echo '   ' LINT GITLINK $<;
-	QUIET_LINT_MANSEC	= @echo '   ' LINT MAN SEC $<;
-	QUIET_LINT_MANEND	= @echo '   ' LINT MAN END $<;
+	QUIET_LINT_GITLINK	= @echo $(wspfx_SQ) LINT GITLINK $<;
+	QUIET_LINT_MANSEC	= @echo $(wspfx_SQ) LINT MAN SEC $<;
+	QUIET_LINT_MANEND	= @echo $(wspfx_SQ) LINT MAN END $<;
 
 	export V
 endif
-- 
2.35.1.1228.g56895c6ee86

