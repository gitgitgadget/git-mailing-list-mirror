Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D42AC433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 00:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhLQA04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhLQA0n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 19:26:43 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E2EC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:42 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id b73so561925wmd.0
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hg4v54dxA7kun56V9Ck1S+zqBse/AcXdAYygUxZlavY=;
        b=IlK7M+ftXLlDzwJBtw+IhgH+yGLFgmKIgB/Q5pSB4GvvfZ7J8EGD6fx4HSquy1bWuU
         bxHyMoJYH0yoTyIA8zy3QteMaHzjqqrVZsJCb8ICg2DduYSfoYDKTfBa/Yzyle3lwwgY
         vkuWjrvl2TMryD75ekMhz7S+4hhDsnljlYhqHogdNud8qnxNRCA/VU4loe91bFIM64w2
         baRoTeaKNEtndSuYdFbAKxzGFaeqU59Kua0/PhzqEl7fdvw4LgNk3ZYyiTC/rQNHU2xg
         i6Z0XlbPMuq8nGgczvWeN9zxiXPiC5q8dP6wgVk3pHEliJ2W5MxeV5FAedFN6cJkEGL+
         tDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hg4v54dxA7kun56V9Ck1S+zqBse/AcXdAYygUxZlavY=;
        b=PWVrrfVIN2oxZdEwGE3GEmSgnaAkzbpmpRKM92mpQx33BjF+O1hJOWHhBwYz9Vdb8J
         s5RbPJOWJfSid329PEl/YSeDrZk9EIu9JwQQV2xKejNUKoyFWfj/9JcdEVkHW0OSAeQq
         SEY1Pggvye+5Oq+QJPVqXUeLVKjKCm69y/39AFmn+vAblIr2W4gEICP+eCeup2s3JmRE
         WghOFlsFigaVAC1Y7Vk11lo88G8V5Y3o746EK9E2WzraQr+5IpyW++zB+NgX5xsqQ6Eb
         Sn53rjz22PIY9p/8GYgKtOmYAvPvBSXVYZU9S+mJXDQpPvrC6airrqc3sJpoAYf+1Rh6
         rcqQ==
X-Gm-Message-State: AOAM5332Vvc+gdivNKdqkEa6IX3CJ3uc5pyo7Wlj1hknqOt/f4zuVvdI
        kIZ76gAyy7m59ZyEavxPasgJO+LqhrBuCA==
X-Google-Smtp-Source: ABdhPJyO6QeKyCkYz7fgrUQvHxaeqBQ/26Ig3iSa/PU7aalsCI3PWGB95bZFBZrPuFu/uO5GTS+EMg==
X-Received: by 2002:a05:600c:34d2:: with SMTP id d18mr286720wmq.146.1639700801169;
        Thu, 16 Dec 2021 16:26:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm8127349wmq.41.2021.12.16.16.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:26:40 -0800 (PST)
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
Subject: [PATCH 10/11] Makefile: create a GIT-PYTHON-DEFINES, like "PERL"
Date:   Fri, 17 Dec 2021 01:26:26 +0100
Message-Id: <patch-10.11-fe79797f45e-20211217T002023Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
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
index 3be3dc9621d..f2cee13ea5d 100644
--- a/Makefile
+++ b/Makefile
@@ -2388,18 +2388,15 @@ GIT-PERL-DEFINES: FORCE
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
@@ -2407,8 +2404,24 @@ $(SCRIPT_PYTHON_GEN): % : unimplemented.sh
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
@@ -2895,18 +2908,6 @@ else
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
@@ -3303,7 +3304,7 @@ ifndef NO_TCLTK
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-BUILD-OPTIONS
 	$(RM) GIT-USER-AGENT GIT-PREFIX
-	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PERL-HEADER GIT-PYTHON-VARS
+	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PERL-HEADER GIT-PYTHON-DEFINES
 ifdef MSVC
 	$(RM) $(patsubst %.o,%.o.pdb,$(OBJECTS))
 	$(RM) $(patsubst %.exe,%.pdb,$(OTHER_PROGRAMS))
-- 
2.34.1.1119.g7a3fc8778ee

