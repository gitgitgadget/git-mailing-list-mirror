Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5072AC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 12:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F7C860F91
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 12:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344258AbhIBMPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 08:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343984AbhIBMPp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 08:15:45 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479D4C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 05:14:47 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so1292306pjc.3
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 05:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PD+IvmkMhN/dtIvs9AIv16ArQxRH9usCy2rB4nvy0tg=;
        b=heM6aspEnw92uDDvipdutv8HAJCZMS4QRkxCOUTS9zbvgUs8ZXe4recOWs0ZPeMfsw
         fTi7ceoMu8Cwl6zgzkbpURXvBmtewHs2W5zRNnRLfDTjGbITu2Z4pwCjULtnyr4dxSK9
         seOAJ3GoBAN1R+4VxZXnGu1k2pTi9SZsd+3nahai/wJC+ERIMnzbsm+o20qUwFOPRi4X
         Hl+giGJbMOGZCpKsX0+PC92zmuy/SAuYpV13Od0mFOjN1Xnglj92oIThcBOeBNwvTo17
         gRyXuYMS9+clawjgLXo/fmEuzBGYY5Px+8BRXvbYgKk3NoJNgWLQaziEKtFWzHTp/kGZ
         Yapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PD+IvmkMhN/dtIvs9AIv16ArQxRH9usCy2rB4nvy0tg=;
        b=tv1BSsw7m7oV0wHalNJJdJ/NBcNVEaXyUhsTiPfgYrjYbyboctgEdwmM/f9lqGgwKH
         I401EDkncMsMd4/aTGKlFKJIIzN7LUw03qPAaYefJb4fbTT/NuIuzkz9fGNyeOtN52Cc
         1sRbF3cxgF/Qm2tzXPtY675OiCx5zwk4O+IChAsgd2moWLcEryYAu0tNGQfqZXwYYECl
         l/oOnT0h1Yic9YauNDVCL7SXxuInbCOMwD34gPW+A4UKZgZV6HblTDPS1Q2ToQFCbYSg
         pb6vp8MGVFEplououKQphBRSzjrWeurmxVz0GWRiQEcnQs+j/I8zX4HRfRQtoVmYGeSX
         TDdg==
X-Gm-Message-State: AOAM533ASRc8fQ4Y8RA+fRglqR7hRemv+qdN9Cs7/tsKyWRIJlC27H58
        a9WzjORuOT6a3XhHdvANlhz+QjzaDa9XGw==
X-Google-Smtp-Source: ABdhPJyevCkHde2lA31SNgQNsyXTiRfMJuJqqJvFwDWmgU2W1rdau2pwkrSGzokRhJ/Za8kciTxcEA==
X-Received: by 2002:a17:902:b7c8:b0:138:c28f:a775 with SMTP id v8-20020a170902b7c800b00138c28fa775mr2624087plz.11.1630584886640;
        Thu, 02 Sep 2021 05:14:46 -0700 (PDT)
Received: from ubuntu.mate (subs32-116-206-28-35.three.co.id. [116.206.28.35])
        by smtp.gmail.com with ESMTPSA id u2sm2126219pjv.10.2021.09.02.05.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 05:14:46 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, felipe.contreras@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v3] make: add INSTALL_STRIP option variable
Date:   Thu,  2 Sep 2021 19:11:05 +0700
Message-Id: <20210902121104.14778-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Add $(INSTALL_STRIP), which allows passing stripping options to
$(INSTALL).

For this to work, installing executables must be split to installing
compiled binaries and scripts portions, since $(INSTALL_STRIP) is only
meaningful to the former.

Users can set this variable depending on their system. For example,
Linux users can use `-s --strip-program=strip`, while FreeBSD users can
simply set to `-s` and choose strip program with $STRIPBIN.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---

 Changes from v3 [1]:
   - Squash suggestion patch from Junio, which suggests dropping
     install-stripped target and rename $(INSTALL_OPTS) to
     $(INSTALL_STRIP).
   - Describe $(INSTALL_STRIP) usage on the top of Makefile

 Note: In the future, we may add global $(INSTALL_OPTS), which applies
 to both compiled binaries and scripts. When such happens, we should
 rename $(INSTALL_STRIP) to $(INSTALL_STRIP_OPTS).

 [1]: https://lore.kernel.org/git/xmqqo89cqkt9.fsf@gitster.g/T/#t

 Makefile | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index d1feab008f..ebef4da50c 100644
--- a/Makefile
+++ b/Makefile
@@ -465,6 +465,9 @@ all::
 # the global variable _wpgmptr containing the absolute path of the current
 # executable (this is the case on Windows).
 #
+# INSTALL_STRIP can be set to "-s" to strip binaries during installation,
+# if your $(INSTALL) command supports the option.
+#
 # Define GENERATE_COMPILATION_DATABASE to "yes" to generate JSON compilation
 # database entries during compilation if your compiler supports it, using the
 # `-MJ` flag. The JSON entries will be placed in the `compile_commands/`
@@ -3004,7 +3007,8 @@ mergetools_instdir = $(prefix)/$(mergetoolsdir)
 endif
 mergetools_instdir_SQ = $(subst ','\'',$(mergetools_instdir))
 
-install_bindir_programs := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)) $(BINDIR_PROGRAMS_NO_X)
+install_bindir_xprograms := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X))
+install_bindir_programs := $(install_bindir_xprograms) $(BINDIR_PROGRAMS_NO_X)
 
 .PHONY: profile-install profile-fast-install
 profile-install: profile
@@ -3013,12 +3017,17 @@ profile-install: profile
 profile-fast-install: profile-fast
 	$(MAKE) install
 
+INSTALL_STRIP =
+
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $(INSTALL_STRIP) $(PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $(SCRIPTS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) $(INSTALL_STRIP) $(install_bindir_xprograms) '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) $(BINDIR_PROGRAMS_NO_X) '$(DESTDIR_SQ)$(bindir_SQ)'
+
 ifdef MSVC
 	# We DO NOT install the individual foo.o.pdb files because they
 	# have already been rolled up into the exe's pdb file.

base-commit: 6c40894d2466d4e7fddc047a05116aa9d14712ee
-- 
2.25.1

