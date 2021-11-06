Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2E4C4332F
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A8A2611EE
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbhKFVGW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbhKFVGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:06:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85766C061205
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:03:27 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d5so19540671wrc.1
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GiApjcVNytk/fk5j+mlMzmZNV0SXnxMi9IbXEwRJblc=;
        b=IYwZf+LNQScdIPCxigfEQdew9uX/Syp1gUHVTQHs0Xw7PQ1gvR1D+K1ZisYk6Pl9I5
         kOaUpmNw2V4kEwqcu0FkKvWwEUKDDg3XIl4k8eOLpkvpu/UcWiWL1N4VSMNBs7a7Ror1
         2t+Yn4QIQjM0GSFYka98f75qlCICGXEa/HPaB5R60fogVvQfMNnCPtJGJxqgpp5XlIkU
         qmCVPMvAH7oveyJKZL8mI+rWQA6WHsvnk1BFp/GTf92nZp0vkkJvMez7PO/6/0T1T/fV
         q3OKEgr+psq91LGY+G5YdRYeVKBL5z+uSKrXbUE0FtDFz/NEpKFYJfYqKGUDvSKfXKhH
         KUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GiApjcVNytk/fk5j+mlMzmZNV0SXnxMi9IbXEwRJblc=;
        b=C9MfrB+k0GDe3WWf6D9RBvVOXd/rXB4gVdnalWR6W2yceuRb1CouO8isLlwgsrMO3k
         w5SBQD+1O1c4ci6M7hffUpJvGUDbu5c2/9zIbnthzR3N/6s8Te53jum3scdphoAGN2po
         cPhbTDcac89UQJM3BPbIsGcyYmWDNxzTiMbhQqaBRIrfULoTyHHN72Kt5P2V0vZmHkOp
         cBfF4dt0gLGW/6d6qSKGJk7K5Onp/GoKVw2QX4T+HK8zgSBNjrowkeVe9wMuoJm7zKur
         YOR54wgvKiKiPA3nqwBudaTDI1mKL3y0xywLAraO9zZ7sc0JFIKD9CbiIN1EaFlb/3Im
         RcuA==
X-Gm-Message-State: AOAM5334VMlbFnckHfV/hRNqzcdfPg+E3vuhkkW9sz2ccjwhY6N7AJO0
        Sk60TjaK9DTNtOviGyF/t+7sakhnk9+jfg==
X-Google-Smtp-Source: ABdhPJyqIlkqQ7rInmrnBEQpOnB+omPv1sM+EWaNxo8mP42UsC4xoknJjvoa9bDtmlAYiarFR0ZpNQ==
X-Received: by 2002:adf:dec9:: with SMTP id i9mr66146997wrn.18.1636232605751;
        Sat, 06 Nov 2021 14:03:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u16sm14108433wmc.21.2021.11.06.14.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:03:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/16] Makefile: create a GIT-PYTHON-DEFINES, like "PERL"
Date:   Sat,  6 Nov 2021 22:03:08 +0100
Message-Id: <patch-07.16-24c8f42aa7d-20211106T205717Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
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
"GIT-PYTHON-DEFINES".

This changes code originally added in ca3bcabf118 (auto-detect changed
prefix and/or changed build flags, 2006-06-15), and adjusted in
96a4647fca5 (Makefile: detect when PYTHON_PATH changes, 2012-12-18).

The relevant code for the "Perl" targets was then added in
07981dce81e (Makefile: rebuild perl scripts when perl paths change,
2013-11-18), and has been adjusted in preceding commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitignore |  2 +-
 Makefile   | 50 +++++++++++++++++++++++++-------------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

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
index 354136e30d1..42eb15dc09c 100644
--- a/Makefile
+++ b/Makefile
@@ -2369,18 +2369,14 @@ GIT-PERL-DEFINES: FORCE
 		echo "$$FLAGS" >$@; \
 	    fi
 
-# This makes sure we depend on the NO_PYTHON setting itself.
-$(SCRIPT_PYTHON_GEN): GIT-BUILD-OPTIONS
+# Under NO_PERL=Y we'll still make GIT-PERL-DEFINES. We need to depend
+# on NO_PERL=Y itself for creating "unimplemented.sh" scripts.
+PYTHON_DEFINES =
+$(SCRIPT_PYTHON_GEN): GIT-PYTHON-DEFINES
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
@@ -2388,7 +2384,23 @@ $(SCRIPT_PYTHON_GEN): % : unimplemented.sh
 	    unimplemented.sh >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
-endif # NO_PYTHON
+else
+PYTHON_DEFINES += $(PYTHON_PATH_SQ)
+
+$(SCRIPT_PYTHON_GEN): % : %.py
+	$(QUIET_GEN) \
+	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
+	    $< >$@+ && \
+	chmod +x $@+ && \
+	mv $@+ $@
+endif # PYTHON
+
+GIT-PYTHON-DEFINES: FORCE
+	@FLAGS='$(PYTHON_DEFINES)'; \
+	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
+		echo >&2 "    * new python-specific parameters"; \
+		echo "$$FLAGS" >$@; \
+	    fi
 
 CONFIGURE_RECIPE = sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 			configure.ac >configure.ac+ && \
@@ -2839,18 +2851,6 @@ else
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
@@ -3247,7 +3247,7 @@ ifndef NO_TCLTK
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-BUILD-OPTIONS
 	$(RM) GIT-USER-AGENT GIT-PREFIX
-	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PERL-HEADER GIT-PYTHON-VARS
+	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PERL-HEADER GIT-PYTHON-DEFINES
 ifdef MSVC
 	$(RM) $(patsubst %.o,%.o.pdb,$(OBJECTS))
 	$(RM) $(patsubst %.exe,%.pdb,$(OTHER_PROGRAMS))
-- 
2.34.0.rc1.741.gab7bfd97031

