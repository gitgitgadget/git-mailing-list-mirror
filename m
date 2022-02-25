Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEBEC433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 09:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbiBYJFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 04:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238884AbiBYJFV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 04:05:21 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8377DABE
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 01:04:49 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o62-20020a1ca541000000b00380e3cc26b7so1293261wme.0
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 01:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l/m7K3guB63ks7TFa0duoZkR5t0qS6FclhgjX96MFys=;
        b=pQ4lzD0LU9PeGjZuurC1m3rSyvr95DNLC8uh0DoDCIdPKMgYLoChzJGdKr9CzMcjFo
         1o7IhS56/airD+mN+vHiTrwTIb+QF+d8opkEYnS1c+yQhv9M++7Y4B3PxoCVHbnXzXuA
         hwTF1lJZbomjw5JqFSnlawHI9KL0+mbl9egT1bK8sY1tXX61oF54PCMlsFhIcEZvMBz5
         cKe+ViNv9TorLON+jc1PmxHZbf5nGzEJ5a5AfPEOzkwyvKwZ2KgRPEB1AbtpNskUQR3O
         M6bpKF31oW/p5gtqlRt46hsYLjutHHYEnXvaYZgk7EgDTpGPdLuS1r9T9i+QBfMOStdE
         oLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l/m7K3guB63ks7TFa0duoZkR5t0qS6FclhgjX96MFys=;
        b=XWur0buhpCv6SGR6EtQlLWpwkwKChRPy8Z8uEWqRc4mungbg7iiPb5AcCuxbZt0lZy
         3JiBzf9UvbEg2hC0fS4w9eDencwx1OUxWSATrg6KjRBZguUOPOXUfvx3Fb7+vDH9xR1f
         B4ZkWg+OMHbzuUpI0EO5ScO2O7l8qhOk0avcWWfSC7c8goETcX859H3y2Z/+IsaRhw+z
         tjSD9o7eo5h6mRBWsP3nZ89QZl/0UGrtF3W29/os3s0qX8Set8t/sZaHKY0Mu+BHcsg2
         Tnx9UejP9bmW+71hiPLBtr+/CnK8tcWwyp8jAqM90BN2aq7/i+Rcn4uiIyaYqN4pUcwY
         yrmA==
X-Gm-Message-State: AOAM533LTjoOe3oZInNs+H3qxoqoVZLjHnAO9RpiPLiYqWXMqFngNmvq
        RrFQsagkfIJr1ponnPO1E0Srk5SVE+flsA==
X-Google-Smtp-Source: ABdhPJz81sigo20RUscGiYEfrReU4nXz4fH/6r20PxiwAUR5fF71H0CGb2M6VEbGAvSogjeQZfNyyQ==
X-Received: by 2002:a7b:c5d1:0:b0:37f:a8a3:9e17 with SMTP id n17-20020a7bc5d1000000b0037fa8a39e17mr1793552wmk.109.1645779887693;
        Fri, 25 Feb 2022 01:04:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l38-20020a05600c1d2600b0037e9090fb1esm5636657wms.24.2022.02.25.01.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 01:04:47 -0800 (PST)
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
Subject: [PATCH v3 8/9] Makefile: use $(wspfx) for $(QUIET...) in shared.mak
Date:   Fri, 25 Feb 2022 10:04:34 +0100
Message-Id: <patch-v3-8.9-510306d2219-20220225T090127Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1175.gf9e1b23ea35
In-Reply-To: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
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
index 20be9ddf5a6..6e0f103b65f 100644
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
2.35.1.1175.gf9e1b23ea35

