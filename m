Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E9DC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12B3A61B31
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbhKPMFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbhKPMEg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:04:36 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78158C061229
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:44 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id i5so37089287wrb.2
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jf4RXCd0z9lfXfN8DlxDnYnxN7b5y/MQKB5pAP3Qfy4=;
        b=LaSw1UZZhFu5dlU2sv2veA3nw2q2hHALsSiJm8DCZk/Uu+uQpCBijDkPLtjDJdMnTU
         qA73AQParcFBXaH+GjrvbwtWOIFAh0abY/FqUFAzOPQ6hA6rHiy5JjztOAodqbrzcwaF
         Yn06b140VO0kDsVH58pd8nSBJAZerJa/+T12RLhJLe5py2pGePPJTudlLR3bRvT1A4Rf
         7vXC9HJCMeQyErvJFFoLX/LA1TCsDJB12608+nknbB1Q1ayIfHgXmCTaCw15gONoJWPk
         m0VUmAbZF0ylwbfgqeYST0ghjRfpH0nZf6uTO2nDJpnc7OVSS1LEX29utcSho/JzLNUV
         qlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jf4RXCd0z9lfXfN8DlxDnYnxN7b5y/MQKB5pAP3Qfy4=;
        b=qS6akNh2/Mh7rEVGdE6SRk/cb3BzZuvlNyioQuZav8K22hJBaWNieni2wHxSYJ9nsM
         J05v0IFrWUaB9ZdSiqejhSt3FbI+3AnYuCtLwZi93P8brHba8dsE0cA8w8UTlz6NTva9
         KaSVSOtf4QyHdLtI66DQd2VoSQKvWRq0cgCirwsBUc1yj7Vc7P9XFuGrKxji0cOkGcDw
         cORwfTRA3xyWLumK1g83bbWosWu0AK68DIAEJt9vlSFjicnP+igrfL9/n1buuzqI3eUm
         mQ+G2NirffqomMQJqsrlEwNGwM0S2Gu6EVl4JxdPdLTVDLwkK+cOB2OpwbOez8NgBCjR
         JcVw==
X-Gm-Message-State: AOAM5322BUw7BYk2Bcdla6zaB4OOR9GDA+hjPYoSD+q+tlJMQVnWBeUv
        ecOGVqBMczjsfzxuW1Ym09joU7l+aBoNUg==
X-Google-Smtp-Source: ABdhPJxR9aPe1pmz+KXgY7edVAgIOcNq/uCisDUecmTRq+zj74nMTNDincTMCISpuXPzkb2Unljfog==
X-Received: by 2002:a5d:6508:: with SMTP id x8mr8717951wru.388.1637064042855;
        Tue, 16 Nov 2021 04:00:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k37sm2427922wms.21.2021.11.16.04.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:00:42 -0800 (PST)
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
Subject: [PATCH v3 10/23] Makefile: create a GIT-PYTHON-DEFINES, like "PERL"
Date:   Tue, 16 Nov 2021 13:00:10 +0100
Message-Id: <patch-v3-10.23-e9b61cd0ba5-20211116T114334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com> <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
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
2.34.0.795.g1e9501ab396

