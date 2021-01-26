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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40509C43381
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D382220B
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392730AbhAZQJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392774AbhAZQIA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 11:08:00 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43E0C061A29
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:07:18 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 190so2934360wmz.0
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CQwfjZOWrRXum1b87XrtCgo9ClLzoL5PjqGHBkL1PBU=;
        b=Pk3ElZK2HWixteVoTYcrEwHnOzbgCqvu02Olf3fAfJ1DOv1a7sXq1IR104ECdXD3kd
         C2tC53z4u+1eBERjLIal7ss2P/zCFmGAoBxjnbYqPRZnFJghVPHt/RA8YjKX4wjRjmVy
         //LgynMwFuzY8wSs7vYlVL/b9CFpJNzdN3B80z/iixX1ErxqclOJ5/46mIOxQmFQT/VB
         3iTZxMnD1vsr2k1ifQsp2zM8+O33UQ/aziBh5QZ4UyTdCRG1vnbF7dR2kfg+3Oy+2DOk
         bmXz6pJEbC896cfWlH+TRFBnXb6FhzQCKInALlooUAVLaJWiwko/PBlaasQfiHMUsLh8
         qQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CQwfjZOWrRXum1b87XrtCgo9ClLzoL5PjqGHBkL1PBU=;
        b=V78x/i7xPJBG57+iyY69ENyaachVlCppyhgN8HqVAOSnYXokCAsZYp4MvaVXYvqKkq
         6njTyuVLrdii6hL89nQ8rFORus7PH7LATg8Pvi/RWwwS33Q94VUSkJI7TU73ZzQz6eZR
         qN0MeuT5FySgJT3UOy3YOTXjd4l/x5lFXMDMmiuGyKoBKeIlb6Gko4AXfadYCtLaRSYl
         l3V6HQPDCFZoxXh9mxrxkQZcAeKh/tCXMd+gdcR7vB+0wbGCaFmHjjqZsqI1hYyg6/xp
         gCLyPBpz7LD2JNbAcMcLM/QgS5lqx3w39nh9xBy08SZwII6teCVc8i41Lw3oH9b6AM0D
         Z9mA==
X-Gm-Message-State: AOAM531uQFY5boSTQDux9AMyyJFGCtztEauKYc4hSK9LYf/R/uvqMXBg
        C9+vnPy6Te9PxgujLfUERfZi58hf6QzEAg==
X-Google-Smtp-Source: ABdhPJzPheLeCTqIhRdaCTDugEjaHX0QM1MxjggFdlBkc1y15kgVbu/YhH+VTSIWbbPZTcanr/7LCQ==
X-Received: by 2002:a1c:3185:: with SMTP id x127mr380909wmx.117.1611677237037;
        Tue, 26 Jan 2021 08:07:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k6sm17209743wro.27.2021.01.26.08.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 08:07:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/4] Makefile: add a NO_TEST_TOOLS flag
Date:   Tue, 26 Jan 2021 17:07:07 +0100
Message-Id: <20210126160708.20903-4-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210126160708.20903-1-avarab@gmail.com>
References: <20210126160708.20903-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a NO_TEST_TOOLS flag to build an installable git, but one that
can't run "make test". This is useful e.g. in CI environments where
you'd like to run external tests against a built git, but have no
desire to run git's own tests.

On my 8 core machine this saves me around 1 second out of an otherwise
11-12 second build time. So it doesn't make all the difference, but
when you're wanting to run tests against a lot of git versions it adds
up.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile      | 6 ++++++
 t/test-lib.sh | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/Makefile b/Makefile
index 4031fb1b22f..cfa7bc58edf 100644
--- a/Makefile
+++ b/Makefile
@@ -309,6 +309,9 @@ all::
 #
 # Define NO_TCLTK if you do not want Tcl/Tk GUI.
 #
+# Define NO_TEST_TOOLS if you'd like to skip building the assets
+# required to run the tests. 
+#
 # Define SANE_TEXT_GREP to "-a" if you use recent versions of GNU grep
 # and egrep that are pickier when their input contains non-ASCII data.
 #
@@ -2732,6 +2735,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
 	@echo NO_PTHREADS=\''$(subst ','\'',$(subst ','\'',$(NO_PTHREADS)))'\' >>$@+
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
+	@echo NO_TEST_TOOLS=\''$(subst ','\'',$(subst ','\'',$(NO_TEST_TOOLS)))'\' >>$@+
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
 	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
 	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
@@ -2787,8 +2791,10 @@ GIT-PYTHON-VARS: FORCE
             fi
 endif
 
+ifndef NO_TEST_TOOLS
 test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
 TEST_TOOLS = $(TEST_PROGRAMS) $(test_bindir_programs)
+endif
 
 all:: $(TEST_TOOLS)
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 03c1c0836f1..4029cd18031 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -55,6 +55,11 @@ then
 	exit 1
 fi
 . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
+if test -n "$NO_TEST_TOOLS"
+then
+	echo >&2 'error: NO_TEST_TOOLS=$NO_TEST_TOOLS set in GIT-BUILD-OPTIONS, cannot run tests!.'
+	exit 1
+fi
 export PERL_PATH SHELL_PATH
 
 # Disallow the use of abbreviated options in the test suite by default
-- 
2.29.2.222.g5d2a92d10f8

