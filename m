Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEFEC54EE9
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 13:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiIANUP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 09:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbiIANTo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 09:19:44 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F188C23
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 06:17:36 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id h1so9005168wmd.3
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 06:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zgzUq6OtZukBmaY+ckeZVoeLz6KXDEFIRlPJHqPFGxM=;
        b=g2mhObcXUNpvfb92cXMCTjUqZP4G0+11LlXCJYUba0A1onXGhGE2ZVDa5+TRDclQjl
         MypbqLuj5t3YxkalPiSEdNLGdavvli9ojWcLmWA4T2xSHuey2jdZw5C8z1R0XMf8K9Kh
         8iIFPrZEGAq5yhTv83+jfJpKd7P8pRhHcivAOF8PKliileK4lIAgctmlupycjzt27Yoq
         4Kfb2OfsU8pg04xTjGKAlit7d7VqtHxQXua/gRPQwNEh6vbnQBY4SvEYMMaIYBL77TCD
         8vAPzMrCczQA8rpahmFBRQqTi8BreRReHRUXsSyVvPBNGKORbevYW/xIJtcgILJwNc/8
         LUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zgzUq6OtZukBmaY+ckeZVoeLz6KXDEFIRlPJHqPFGxM=;
        b=KvvNECtuoxiik+NEGNbKHPFVvyx3Hwgs9pmhsoCSoQfegBZR2JI/owUq66hZN1cPul
         7+NcNLA3C/Nf9cVY3L+RNJOvRsnubQl2VFZ2Q6CTXxwx6DI5/QEvFQ1Te1XUKn8ZYNN8
         5k3GcbPr3glGEwXv1rdzvAKZu+GScBAzHbcIc0gfDByAK6dZq2yskSlgK1MjBIwBJg+H
         ZI2+imhNv+GxuJnDpzTtvGvV3sNH0CZG9+LNwWk6G/UGzY+Mlnb3pOhHzDVsUfxaPgCG
         sRtxxJHTKNjASmjI/KCqnTlWciSW0p45tyaEE0bd6IeOsoKwEzrxmUNxbOlfn04Fm+S+
         N63Q==
X-Gm-Message-State: ACgBeo0ArIOOn6KzvvX8wL/Y/Gn8tW42GNqkd1Qr1TvoH1ajyPRW/SMI
        nGcPuuC6cd3AsIdgG3uHCckujV3Wxp2M2Q==
X-Google-Smtp-Source: AA6agR6edf3NJLr/IAp4fQtjJxP/udvnvTsIlks43AYzCmlP1v5AuoiGZFFM3ptLCR8y0nd0pJnQtw==
X-Received: by 2002:a05:600c:3781:b0:3a6:804a:afc with SMTP id o1-20020a05600c378100b003a6804a0afcmr5159989wmr.27.1662038254196;
        Thu, 01 Sep 2022 06:17:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb52000000b00225239d9265sm14816089wrs.74.2022.09.01.06.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 06:17:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] Makefile: simplify $(test_bindir_programs) rule by splitting it up
Date:   Thu,  1 Sep 2022 15:17:26 +0200
Message-Id: <patch-3.5-0f66992d5f7-20220901T130817Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1426.g360dd7cf8ca
In-Reply-To: <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
References: <sso99so6-n28s-rq86-8q20-4456r3pn869r@tzk.qr> <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the @@PROG@@ substitution was added in [1] it was a simple matter
of doing a:

	's|@@PROG@@|$(@F)|'

Then when t/helpers were added in [2] followed by the ".exe" needing
to be appended in [3] this previously simple rule ended up as a dense
one-liner.

It has been pointed out that this is hard to read[4], but the problem
isn't the "design of the Makefile syntax". It's we now have to
after-the-fact determine if we were dealing with a bin-wrapper/ that
needed to have $(X) appended, a t/helper/, or a non-binary (currently
only git-cvsserver).

That would be a problem in any language. We're starting out with three
lists, and then end up having to heuristically determine given a
member of any of those lists which list that member came from. Let's
just stop doing that and keep track of what member belongs to which
list.

We can do this by splitting up the single "bin-wrappers/%" rule into a
rule for each of the three lists. With the
"cmd_munge_script_sed_shell_path_arg" define added in a preceding
commit this is easy, we just need to add a sister template to the
existing "cmd_munge_script" added in [5].

There is then an an in-flight change[6] that generalizes this to
support "scalar". That change needed to further special-case the
pre-image here, as we couldn't rely on the "git%" heuristic to mean
"not from the $(TEST_PROGRAMS_NEED_X) variable".

With this conflicting change that special-casing becomes
unnecessary. The conflict between the two can be resolved entirely in
favor of this change, as the other change adds "scalar" to
"$(BINDIR_PROGRAMS_NEED_X)", and we are no longer losing track of
which members belong to that list.

This change can be tested with e.g.:

	git checkout master &&
	make SHELL_PATH=/bin/bash X=.exe &&
	mv bin-wrappers bin-wrappers.master &&
	<apply this change> &&
	make SHELL_PATH=/bin/bash X=.exe &&
	diff -ru bin-wrappers{.master,}

Which will show an empty diff, i.e. we've correctly dealt with the
combination of $(SHELL_PATH), $(X) and these three variables here.

1. ea925196f1b (build dashless "bin-wrappers" directory similar to
   installed bindir, 2009-12-02)
2. e6e7530d10b (test helpers: move test-* to t/helper/ subdirectory,
   2016-04-13)
3. 3a94cb31d52 (bin-wrappers: append `.exe` to target paths if
   necessary, 2019-07-29)
4. https://lore.kernel.org/git/sso99so6-n28s-rq86-8q20-4456r3pn869r@tzk.qr/
5. 46bac904581 (Do not install shell libraries executable, 2010-01-31)
6. https://lore.kernel.org/git/4d69e5eaccb8873eece666a3d2bb2b22abdde7ea.1661961746.git.gitgitgadget@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 0d6b2caa7d9..96de9e55864 100644
--- a/Makefile
+++ b/Makefile
@@ -597,6 +597,7 @@ export TCL_PATH TCLTK_PATH
 PTHREAD_LIBS = -lpthread
 
 # Guard against environment variables
+BIN_WRAPPERS =
 BUILTIN_OBJS =
 BUILT_INS =
 COMPAT_CFLAGS =
@@ -3061,16 +3062,34 @@ GIT-PYTHON-VARS: FORCE
             fi
 endif
 
-test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
+define cmd_munge_bin_wrappers_script
+sed \
+	-e $(call cmd_munge_script_sed_shell_path_arg) \
+	-e 's|@@BUILD_DIR@@|$(shell pwd)|' \
+	-e 's|@@PROG@@|$(2)$(1)$(3)|' \
+	<$< >$@ && \
+	chmod +x $@
+endef
 
-all:: $(test_bindir_programs)
+BW_BINDIR_PROGRAMS_NEED_X = $(BINDIR_PROGRAMS_NEED_X:%=bin-wrappers/%)
+BIN_WRAPPERS += $(BW_BINDIR_PROGRAMS_NEED_X)
+$(BW_BINDIR_PROGRAMS_NEED_X): wrap-for-bin.sh
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN)$(call cmd_munge_bin_wrappers_script,$(@F),,$X)
 
-bin-wrappers/%: wrap-for-bin.sh
+BW_BINDIR_PROGRAMS_NO_X = $(BINDIR_PROGRAMS_NO_X:%=bin-wrappers/%)
+BIN_WRAPPERS += $(BW_BINDIR_PROGRAMS_NO_X)
+$(BW_BINDIR_PROGRAMS_NO_X): wrap-for-bin.sh
 	$(call mkdir_p_parent_template)
-	$(QUIET_GEN)sed -e $(call cmd_munge_script_sed_shell_path_arg) \
-	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
-	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
-	chmod +x $@
+	$(QUIET_GEN)$(call cmd_munge_bin_wrappers_script,$(@F))
+
+BW_TEST_PROGRAMS_NEED_X = $(TEST_PROGRAMS_NEED_X:%=bin-wrappers/%)
+BIN_WRAPPERS += $(BW_TEST_PROGRAMS_NEED_X)
+$(BW_TEST_PROGRAMS_NEED_X): wrap-for-bin.sh
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN)$(call cmd_munge_bin_wrappers_script,$(@F),t/helper/,$X)
+
+all:: $(BIN_WRAPPERS)
 
 # GNU make supports exporting all variables by "export" without parameters.
 # However, the environment gets quite big, and some programs have problems
@@ -3403,7 +3422,7 @@ OTHER_PROGRAMS += $(shell echo *.dll t/helper/*.dll)
 endif
 
 artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
-		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
+		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(BIN_WRAPPERS) \
 		$(MOFILES)
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
 		SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
-- 
2.37.3.1426.g360dd7cf8ca

