Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6588C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD3461BF8
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbhKQKX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbhKQKXg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:23:36 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EC2C06120E
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:35 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d27so3606090wrb.6
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uMfYwHBUpRDL5JDr17GIhC5tp/ZUJ6bi7sOTRaHbMJc=;
        b=UBRzxsqsWRIhyoeEP/69nj27ovADZYsaelV3WQJOtgeowx8yZsww3woHdut+9WraaA
         jxNJz4n/0QM9D9CCHIFbqkYGf4k63a87r/O2DZHqsaLheOgDTv58NoQ2Sii4kuIN8HuG
         3hkYxLIKm4CuVEykCpeB4ChJ3QYQLBgQPPBguYPOksCgq68413Q6RERksBWEOFnYL/hz
         9/rCLShCgZC8mWxFtFIhy+oPIGAa+0SI2fD0WOUAkwmsZwlGBe9sPGZzWqoNRMwba6Ul
         4r8yk5QpCLz2mh9JgrGSluogP82GCOEm3gPKqxLuMtHpEfr+suxKuSx5H7hrSwEBx7uw
         qwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uMfYwHBUpRDL5JDr17GIhC5tp/ZUJ6bi7sOTRaHbMJc=;
        b=if5CRUY5rj5TWyMCcRlNEm9+IHicQUtPs7AI+aDCN6uCBBxwkklkS/FtQRX5P4PHNr
         5l2u5ncweqN2C7JuXtefB4AWpEhraFzlFHbmJJwd+NjT5UO6Gsv4E6C5yGFUX/sLK0kx
         XXcxfvPGDV2UqLjtMqkO34AwvpoS6NEQhQnC3saSuEgEudYJ6WqRc1/JI6CF6W5d1x0r
         T5faamHh94+OVoVSd+zNBKV/RKM41SVIbIdL/sRc9L5o+2fz83FO2+spzS/MAK9tru4d
         sGeNtyg7RY+B9vTriBXp2/apGxuQJ110oS1fjwI9FvmsmYjp3nr7vHLIwdjjXlOwjF2m
         TyHQ==
X-Gm-Message-State: AOAM532as0M/aGZ1kXsnN1bdOmh7zWGdOJC3hmQYGBlNU3FXyesGWKys
        yfPq1DIx/NwD/uEK8c/6rm9uHXmNVk+6cA==
X-Google-Smtp-Source: ABdhPJxkssHHnGFAkRqQXfcGZZaYujYU7LztaGCVDMxC/cMn8E6VeHqgr8HQgxt0Lyqb3vr3d6QOKw==
X-Received: by 2002:adf:fc90:: with SMTP id g16mr18250527wrr.53.1637144434074;
        Wed, 17 Nov 2021 02:20:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n32sm6456256wms.1.2021.11.17.02.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:20:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 10/23] Makefile: create a GIT-PYTHON-DEFINES, like "PERL"
Date:   Wed, 17 Nov 2021 11:20:09 +0100
Message-Id: <patch-v4-10.23-6004cdcd8d9-20211117T101807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com> <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
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
2.34.0.796.g2c87ed6146a

