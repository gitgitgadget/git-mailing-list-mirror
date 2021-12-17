Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404E8C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 01:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhLQBjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 20:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhLQBjk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 20:39:40 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A01C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 17:39:39 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a9so1145822wrr.8
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 17:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9tGzt+Y8pkOZwDNBIvUnB7iS87kRtAtGy4jbXK5NH8o=;
        b=IvsFCgBdNDVa/XATHW34D7WcAZuVyj7yTGjS5nZUVwX392+AciJvvIMz8+ev07ig13
         5x9UT1SIKy3wN+gcnaWQA/IILTgq3CfikwlD29hP/+MOVUBXtjZ1/PxpicRXxLZ+Nf0w
         M3fBlKMavhodksq4xXZG4/ANLcmqyflhmFxhZR/h9NsOIeXQ9sMqaqbMzSgVl7547KPF
         y12BsppV09LC1pX7RplT6IvCnj/d5DKErKdTqx1WafjOO6ZuH35/q+VG9emBMChEb/6L
         3rsrA38Q9h6xVsalW7zP1hX/tXAQENKfnq2NhSKPynAjfdyt9asd3BdaNw1m3+IekzfM
         QopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9tGzt+Y8pkOZwDNBIvUnB7iS87kRtAtGy4jbXK5NH8o=;
        b=m2bqis8rHR6cWqkqLNFHoKCBLpTIoLaL4xTU3WWdWqOUystPTVUMtVIPQ5xvolGzB9
         OwQgYlx3emraw0nHPt7weB2YsyXCQrzss0Uuy9NtZ6cwCUgEya+GKFZH2e7rGhEoG4Bc
         1G0q8on2BmZDC3+LjXVYrM05zLc70olz8y1QfHLBSwx04COluVZxlwEcNf14/OjQytf4
         UiV3of62bTNezyRsCQjfXYLGtbeUx8TuWeZ3D6WeCVTYGw+tD1QHqt+tEdkBB2ra1CXF
         9F5bXq0xQ6Ri9CpRtXFEdjeBVLwE3rwZ2qjr8wYEIR/7Zg0tPY3eXIJs3QKYqEyDhDxf
         HO6g==
X-Gm-Message-State: AOAM530rIhymNrqFh5J65m2qrjU+XiYZu55HJGWVmLhCpUa1rJbzSidl
        I1TTes+ghSjQy6I8/+w/dXu7F2Fx83dzKA==
X-Google-Smtp-Source: ABdhPJwlwCB6wUhkLFVK1a1ZRRcoTwmfzKq2y3UA1KFVr/5MsvcCgAnlRYaEzMuwOs/xZWsNUIp2Sw==
X-Received: by 2002:adf:e904:: with SMTP id f4mr497845wrm.245.1639705177942;
        Thu, 16 Dec 2021 17:39:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c4sm5843869wrr.37.2021.12.16.17.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 17:39:37 -0800 (PST)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 7/8] Makefile: use $(wspfx) for $(QUIET...) in shared.mak
Date:   Fri, 17 Dec 2021 02:39:25 +0100
Message-Id: <patch-7.8-3daef7672be-20211217T012902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-0.8-00000000000-20211217T012902Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211217T012902Z-avarab@gmail.com>
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
2.34.1.1119.g7a3fc8778ee

