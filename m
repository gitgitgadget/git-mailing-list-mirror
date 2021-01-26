Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279A9C433E6
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 004692247F
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391904AbhAZQJv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392775AbhAZQIA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 11:08:00 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E811C061A2E
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:07:20 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m2so2927400wmm.1
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0pwmM2oPLVwUmyF3DFgO7pyM+q1+IAWbc5zUv7pt4zQ=;
        b=oiPu8r7QncxOfs/Z7J91aBP9coLPb4WSpmeRJFSVTdbqPthWsu2M2WL4y1uQ50dmnA
         aJxZu+7jdzmkXPkHttM2h85haaS864sX0kKfXTcOd8GqjTzgli0K5uRibWo6x5aE9wjl
         Iah9k3l3SU7S2C//tdfPhRSBkHXsghxomyUkK0ueZOZ+xmcT2FWYpXX9d9lTnVe1LF75
         sFcN0fDxf/Rkm2q5EamgEVryPhaqXUviI8janlCWfUXAvl/sWOyXIZspsa1CwYNnAuVq
         0wDeOWB3f5b407QAMQFbNzs7Y64jaRcNdWQEq7pD/DSqg2U2qRolckUQ1mzEx4MksPH/
         Ihfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0pwmM2oPLVwUmyF3DFgO7pyM+q1+IAWbc5zUv7pt4zQ=;
        b=pDkjXxnDLWUarW1RYIfWalH98/gDIx57h78xPyoda2RrZaz2G195aWJv+rf99u78DX
         BsNI4LL2sTJvVPOOUg5K9yi+NVgJj4q5NIn1RQ83RxlA4wuYqRaoRuvBkRh6HNKj3D2R
         H3CF1l07auuGw30G+pBB1A7MD9jo2JmQv6HnnGJvKkIpIfQklo+vKceEeQcfM7THRUAd
         eF4ZUBuIdk85wV8aQCV5BCI9x6mjcrLCaAaFZeC8JSsLO+LbnIQhLr5yKmIx9QJ3pgaT
         k4D70GKRb7fyrF0FRbmTUjNV+E/w3tiwkJUE7DKCSUZ2JmDuUtzBLHtQBpKjGX6Q9XpW
         F2QA==
X-Gm-Message-State: AOAM530Z/HSfCz5WlvR6sE/W/LDTDEW7v+vz5UwMdrBbfJEHr3c0/f3P
        6xvQwQKbNZLbraLBzT2PeA6Ck5EhJEo06A==
X-Google-Smtp-Source: ABdhPJzsa425/L/rMncqeEr9ZEKknjHnrSLRA4SxzaUFE92KTgwu29qIEm2q05aDgp1kfCb6e88QgQ==
X-Received: by 2002:a7b:c09a:: with SMTP id r26mr440948wmh.64.1611677238701;
        Tue, 26 Jan 2021 08:07:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k6sm17209743wro.27.2021.01.26.08.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 08:07:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/4] Makefile: add a NO_{INSTALL_,}SCRIPT_FALLBACKS target
Date:   Tue, 26 Jan 2021 17:07:08 +0100
Message-Id: <20210126160708.20903-5-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210126160708.20903-1-avarab@gmail.com>
References: <20210126160708.20903-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a target to skip the installation of e.g. dummy "git-svn" when
NO_PERL is defined. This makes it easier to generate more minimal
installations, e.g. for embedded use that's never going to care about
"git-svn" not being around.

We do some basic sanity checking that e.g. NO_INSTALL_SCRIPT_FALLBACKS
isn't set without some of NO_{PERL,PYTHON,TCLTK}, and that you don't
set NO_INSTALL_SCRIPT_FALLBACKS without NO_SCRIPT_FALLBACKS. Otherwise
"make install" would error out.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index cfa7bc58edf..b3c212891b6 100644
--- a/Makefile
+++ b/Makefile
@@ -338,6 +338,10 @@ all::
 # when hardlinking a file to another name and unlinking the original file right
 # away (some NTFS drivers seem to zero the contents in that scenario).
 #
+# Define NO_SCRIPT_FALLBACKS if you'd like to not generate and install
+# the fallback scripts which defining NO_PERL and NO_PYTHON would
+# normally produce. See also NO_INSTALL_SCRIPT_FALLBACKS.
+#
 # Define INSTALL_SYMLINKS if you prefer to have everything that can be
 # symlinked between bin/ and libexec/ to use relative symlinks between
 # the two. This option overrides NO_CROSS_DIRECTORY_HARDLINKS and
@@ -351,6 +355,11 @@ all::
 # Define NO_INSTALL_HARDLINKS if you prefer to use either symbolic links or
 # copies to install built-in git commands e.g. git-cat-file.
 #
+# Define NO_INSTALL_SCRIPT_FALLBACKS to skip the installation of
+# script fallbacks you didn't generate due to also setting
+# NO_SCRIPT_FALLBACKS. Using this without also defining
+# NO_SCRIPT_FALLBACKS is not supported.
+#
 # Define SKIP_DASHED_BUILT_INS if you do not need the dashed versions of the
 # built-ins to be linked/copied at all.
 #
@@ -603,6 +612,19 @@ THIRD_PARTY_SOURCES =
 # interactive shell sessions without exporting it.
 unexport CDPATH
 
+# Sanity check options
+ifdef NO_INSTALL_SCRIPT_FALLBACKS
+ifndef NO_SCRIPT_FALLBACKS
+$(error Setting NO_INSTALL_SCRIPT_FALLBACKS is only supported if NO_SCRIPT_FALLBACKS is also set!)
+endif
+endif
+
+ifdef NO_SCRIPT_FALLBACKS
+ifeq (,$(NO_PERL)$(NO_PYTHON)$(NO_TCLTK))
+$(error You should set some of NO_{PERL,PYTHON,TCLTK} when using NO_SCRIPT_FALLBACKS)
+endif
+endif
+
 SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
@@ -659,10 +681,12 @@ clean-perl-script:
 clean-python-script:
 	$(RM) $(SCRIPT_PYTHON_GEN)
 
-SCRIPTS  = $(SCRIPT_SH_GEN)
+SCRIPTS = $(SCRIPT_SH_GEN)
+ifndef NO_SCRIPT_FALLBACKS
 SCRIPTS += $(SCRIPT_PERL_GEN)
 SCRIPTS += $(SCRIPT_PYTHON_GEN)
 SCRIPTS += git-instaweb
+endif
 
 ETAGS_TARGET = TAGS
 
@@ -804,7 +828,9 @@ BINDIR_PROGRAMS_NEED_X += git-shell
 BINDIR_PROGRAMS_NEED_X += git-upload-archive
 BINDIR_PROGRAMS_NEED_X += git-upload-pack
 
+ifndef NO_INSTALL_SCRIPT_FALLBACKS
 BINDIR_PROGRAMS_NO_X += git-cvsserver
+endif
 
 # Set paths to tools early so that they can be used for version tests.
 ifndef SHELL_PATH
@@ -2322,6 +2348,7 @@ git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
 	chmod +x $@+ && \
 	mv $@+ $@
 else # NO_PERL
+ifndef NO_SCRIPT_FALLBACKS
 $(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
@@ -2329,6 +2356,7 @@ $(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
 	    unimplemented.sh >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
+endif # NO_SCRIPT_FALLBACKS
 endif # NO_PERL
 
 # This makes sure we depend on the NO_PYTHON setting itself.
@@ -2343,6 +2371,7 @@ $(SCRIPT_PYTHON_GEN): % : %.py
 	chmod +x $@+ && \
 	mv $@+ $@
 else # NO_PYTHON
+ifndef NO_SCRIPT_FALLBACKS
 $(SCRIPT_PYTHON_GEN): % : unimplemented.sh
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
@@ -2350,6 +2379,7 @@ $(SCRIPT_PYTHON_GEN): % : unimplemented.sh
 	    unimplemented.sh >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
+endif # NO_SCRIPT_FALLBACKS
 endif # NO_PYTHON
 
 CONFIGURE_RECIPE = $(RM) configure configure.ac+ && \
@@ -2735,6 +2765,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
 	@echo NO_PTHREADS=\''$(subst ','\'',$(subst ','\'',$(NO_PTHREADS)))'\' >>$@+
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
+	@echo NO_SCRIPT_FALLBACKS=\''$(subst ','\'',$(subst ','\'',$(NO_SCRIPT_FALLBACKS)))'\' >>$@+
 	@echo NO_TEST_TOOLS=\''$(subst ','\'',$(subst ','\'',$(NO_TEST_TOOLS)))'\' >>$@+
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
 	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
-- 
2.29.2.222.g5d2a92d10f8

