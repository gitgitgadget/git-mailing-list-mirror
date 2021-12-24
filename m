Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416BDC4332F
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 17:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353355AbhLXRiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 12:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353344AbhLXRiC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 12:38:02 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E691C06175D
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:38:02 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so4240985wmb.1
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ANb4fKgmrhGDzoJIatDLTn9EPh7p5boAEg8CH+XBsgc=;
        b=GkS6sjpO89OoEPINHR5Nw9ovS9lBVzWIiWd7Dqx6boJD0KnHYicS6fq29RwVST2QUF
         w7qAwRIp24YEztqWEazt9Ny/xMVJFgZBlXKzwxotyAv+wt2VlKMbOl2WS4UCN4rpBzC8
         AD7fAig/7vLd0Q9sS5kZ31d9KwK/JN2UZNi9sEE4Y2RKYXaiLIvjunu4KupEnxymU/bP
         VTBkGgoXLpw/JuN2d9FNOU21tu+AiImh5IvqZnWYOXP/a/lMx5eX8e+Y9jN/+Mx/fwgu
         el6oEBbRJt9PhY3Z99FR7ohU9nf0XgdUOdwpDYU7sJT7cp2jCVTqMZ6/U2xpBpGoX9dL
         Pokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ANb4fKgmrhGDzoJIatDLTn9EPh7p5boAEg8CH+XBsgc=;
        b=7kmlT8LR3UbIqfe556dsmvPIiXmfm7T2yKrqu9xCulaJTsWZDvkDeMF1WAn8l3R/M+
         XR2OZxo9dRWTGfsOkDLxcqAqdws3+gmTCm4kRIXQEGxXDvXay61OpsOEqVN27+UPX4uy
         MvhsHqU5uRTHlc81to9vUk5sh6GwijvMAa11kgprX7XwCdQn3mTHtuEkDQXZkuVTDT1o
         N3Bot9PqteIHNtTSxORNljxBvqLDOg5Zn0E0cP9F44DuPazwafTjrknodJTBCLJstZtu
         WHAqcBLovkaLA7Fu12XHT8XTq8/Di6cTV63az0geHGoyp8tsqTdpiKcDjHWTX4mivx5p
         pdSQ==
X-Gm-Message-State: AOAM533AucSE6sJhZGo+VhhLLPuXU547f5ftAC1CLLl+qFOetbLV8jhT
        4CvHKTTP29QhQ2PP6PuX2ShI9lXYpE81vZXU
X-Google-Smtp-Source: ABdhPJxVkdZHecUp5jkxKR5kY78/Hje7hdIgGNug8jXrZrU40ODpKf2kVfn69XSR5yHMAHrhbuS0Fg==
X-Received: by 2002:a7b:c087:: with SMTP id r7mr5704321wmh.17.1640367480584;
        Fri, 24 Dec 2021 09:38:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j3sm8033518wro.22.2021.12.24.09.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 09:38:00 -0800 (PST)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/8] Makefile: use $(wspfx) for $(QUIET...) in shared.mak
Date:   Fri, 24 Dec 2021 18:37:46 +0100
Message-Id: <patch-v2-7.8-90d804ea9a0-20211224T173558Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1215.g6e154b84c77
In-Reply-To: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
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
 shared.mak | 54 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/shared.mak b/shared.mak
index d6f70f3d6c9..f8ebaf30569 100644
--- a/shared.mak
+++ b/shared.mak
@@ -32,6 +32,12 @@ comma = ,
 empty =
 space = $(empty) $(empty)
 
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
2.34.1.1215.g6e154b84c77

