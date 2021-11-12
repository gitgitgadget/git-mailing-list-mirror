Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5BEC433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 851CE60FBF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbhKLVwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 16:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbhKLVwN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 16:52:13 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5A1C061766
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:17 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso10950204wml.1
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2X0xu4jDEXxnsJ6J/Ye4YxTXRWiqQV1ptZzzE7hVqZE=;
        b=Qy/k0yiljZBbAbl4auTUITvwda/qDA3ljCPzcbtV8mu+brhG6ymu7ekAmCIzMlG0co
         11nxIV7oPoV0/CYXfMfV3KYwhE9gKe+tjVAmfT6l6tNLFCPbbHjk/XNEoVNv20Fcntcg
         +uksSZ8oy4YZtL+KB+GPriIb5o1fijuP6o62U59bQQcPjJG2VQYNJtWfGPqVuZTQJadk
         oyeMpxTrylaGbABaCiQvRSNuIk7umgQnb18cfJoF3wawCVNny3irfMOxNwFqUt12pjWi
         evMDdFs8vC2SA3ksgsaYEEkxWwhBlaHkOH3r12zYbcHqpSysyLHbu0hKiUMvHnumCZvv
         o69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2X0xu4jDEXxnsJ6J/Ye4YxTXRWiqQV1ptZzzE7hVqZE=;
        b=efVk17uYqxIEmd37DCyVlg9UO4UIhGmn2YNHVBE5jRoMhnfXtGJwnzLFE6R/XJ+upJ
         gJZRZykJ6AsxOW/Yu9qBsza9zpxm8i3D7fqbOEsvt3GeWHl/QpX8tnI4jYQoGkToijNB
         I6i3d1gsjvIg4Vfj8rYzhSAsj4RKCsUt6JIJWQkARdpXIgsmEhfcTNXiGjg4tttU/slM
         JRN8BZwf0f0mVFgm/VC95H8LPzY6eipwE/Cktgw/U2LhcwUkwp2RREGIq//D020YZkx4
         3lQHjwdxkd75UA0Gp3irz8D7kX+933+kl4Z1sy5mezWtbhOndZA9FLrWBpYMnGSzIeqj
         0lbQ==
X-Gm-Message-State: AOAM530RQMDKEQZhiCqtHrkfOhCbM9vJ5ltCETviVC4fun9y+mLDhYaR
        R0WHVAa8RM6y7C09G+IANLbyREDlUKhE7Q==
X-Google-Smtp-Source: ABdhPJxGpPieoki+9MND35O91aNa0Czowa9OUuNir+cCLy0qJ56F6jkRi736942V4p+dHUSHAl/VDQ==
X-Received: by 2002:a05:600c:ac2:: with SMTP id c2mr37639473wmr.118.1636753755966;
        Fri, 12 Nov 2021 13:49:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h27sm14117189wmc.43.2021.11.12.13.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:49:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/18] Makefile: create a GIT-PYTHON-DEFINES, like "PERL"
Date:   Fri, 12 Nov 2021 22:48:54 +0100
Message-Id: <patch-v2-10.18-41f65a12205-20211112T214150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com> <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new "GIT-PYTHON-DEFINES" file, and untangle the dependency
issues of the Python by copying over the patterns established for
building the adjacent Perl code in preceding commits.

As with Perl, there's no real reason to depend on GIT-BUILD-OPTIONS or
GIT-CFLAGS when building the Python code, nor did we need
GIT-PREFIX. Let's instead add those variables we care about to a
"GIT-PYTHON-DEFINES" and depend on that.

This changes code originally added in ca3bcabf118 (auto-detect changed
prefix and/or changed build flags, 2006-06-15), and adjusted in
96a4647fca5 (Makefile: detect when PYTHON_PATH changes, 2012-12-18).

The relevant code for the "Perl" targets was then added in
07981dce81e (Makefile: rebuild perl scripts when perl paths change,
2013-11-18), and has been adjusted in preceding commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitignore |  2 +-
 Makefile   | 49 +++++++++++++++++++++++++------------------------
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/.gitignore b/.gitignore
index 054249b20a8..845e5d0c355 100644
--- a/.gitignore
+++ b/.gitignore
@@ -8,7 +8,7 @@
 /GIT-PREFIX
 /GIT-PERL-DEFINES
 /GIT-PERL-HEADER
-/GIT-PYTHON-VARS
+/GIT-PYTHON-DEFINES
 /GIT-SCRIPT-DEFINES
 /GIT-USER-AGENT
 /GIT-VERSION-FILE
diff --git a/Makefile b/Makefile
index 361abff2402..c698c5b058a 100644
--- a/Makefile
+++ b/Makefile
@@ -2378,18 +2378,15 @@ GIT-PERL-DEFINES: FORCE
 		echo "$$FLAGS" >$@; \
 	    fi
 
-# This makes sure we depend on the NO_PYTHON setting itself.
-$(SCRIPT_PYTHON_GEN): GIT-BUILD-OPTIONS
+# As with NO_PERL=Y we'll still make GIT-PYTHON-DEFINES if "NO_PYTHON"
+# is defined, for creating the "unimplemented.sh" scripts.
+PYTHON_DEFINES =
+$(SCRIPT_PYTHON_GEN): GIT-PYTHON-DEFINES
+
+ifdef NO_PYTHON
+PYTHON_DEFINES += $(SHELL_PATH_SQ)
+PYTHON_DEFINES += $(NO_PYTHON)
 
-ifndef NO_PYTHON
-$(SCRIPT_PYTHON_GEN): GIT-CFLAGS GIT-PREFIX GIT-PYTHON-VARS
-$(SCRIPT_PYTHON_GEN): % : %.py
-	$(QUIET_GEN) \
-	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
-	    $< >$@+ && \
-	chmod +x $@+ && \
-	mv $@+ $@
-else # NO_PYTHON
 $(SCRIPT_PYTHON_GEN): % : unimplemented.sh
 	$(QUIET_GEN) \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
@@ -2397,8 +2394,24 @@ $(SCRIPT_PYTHON_GEN): % : unimplemented.sh
 	    unimplemented.sh >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
+else # NO_PYTHON
+PYTHON_DEFINES += $(PYTHON_PATH_SQ)
+
+$(SCRIPT_PYTHON_GEN): % : %.py GIT-PYTHON-DEFINES
+	$(QUIET_GEN) \
+	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
+	    $< >$@+ && \
+	chmod +x $@+ && \
+	mv $@+ $@
 endif # NO_PYTHON
 
+GIT-PYTHON-DEFINES: FORCE
+	@FLAGS='$(PYTHON_DEFINES)'; \
+	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
+		echo >&2 "    * new python-specific parameters"; \
+		echo "$$FLAGS" >$@; \
+	    fi
+
 CONFIGURE_RECIPE = sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 			configure.ac >configure.ac+ && \
 		   autoconf -o configure configure.ac+ && \
@@ -2848,18 +2861,6 @@ else
 endif
 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
 
-### Detect Python interpreter path changes
-ifndef NO_PYTHON
-TRACK_PYTHON = $(subst ','\'',-DPYTHON_PATH='$(PYTHON_PATH_SQ)')
-
-GIT-PYTHON-VARS: FORCE
-	@VARS='$(TRACK_PYTHON)'; \
-	    if test x"$$VARS" != x"`cat $@ 2>/dev/null`" ; then \
-		echo >&2 "    * new Python interpreter location"; \
-		echo "$$VARS" >$@; \
-            fi
-endif
-
 test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
 
 all:: $(TEST_PROGRAMS) $(test_bindir_programs)
@@ -3256,7 +3257,7 @@ ifndef NO_TCLTK
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-BUILD-OPTIONS
 	$(RM) GIT-USER-AGENT GIT-PREFIX
-	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PERL-HEADER GIT-PYTHON-VARS
+	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PERL-HEADER GIT-PYTHON-DEFINES
 ifdef MSVC
 	$(RM) $(patsubst %.o,%.o.pdb,$(OBJECTS))
 	$(RM) $(patsubst %.exe,%.pdb,$(OTHER_PROGRAMS))
-- 
2.34.0.rc2.795.g926201d1cc8

