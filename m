Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC423C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbiJZOnM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbiJZOm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:42:58 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A247F103DA6
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:42:46 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n14so6114689wmq.3
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCKw8x6Xc1xO7S9fTawrj4RoSzKiCNF20006exH6gOs=;
        b=mg5KG+LwXu4DEDBB27GH8tNlXbazT9Rgmrt27+mZNvyvLOnSX8FGKwxAJluJwFpiwG
         h42ONtT2Jcj0NmiBWAm3j6jp1hLXX97Q4/pnzMUnH57v8aqtr02inL98R4c4dpkGtMg8
         z6bS6kWrt92LQ96fDbvN4aYXCTfHDhR5dJefh4nXsF0k31Y+Q/1iwnQ7M0ObUB4a17Qw
         37kqBf0WXR1Q/EaiESfVHokN/ttQI3/Fn2AZnpsPbm5lqnLK7b/v8yn8snsKm0+PJXvH
         KsZgVSJ5dED783BQc8SS+GfSS06FgZGdLUM8Wo72gUQEIVVSGCmPQCX1RW/NieVQC0xi
         zzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCKw8x6Xc1xO7S9fTawrj4RoSzKiCNF20006exH6gOs=;
        b=o/96wxe+HREpcPx2fejZo/GtOSWKsS/MWB0wdqrAFX8KqLR1ue3Q6grJ6nhhD2IQvS
         JMEpDaITyOFuLMU1cgcXIbdPMxAJCfE0L6bS2Mn3VYeAzw+KDpYLUm5nNcxGRB7eccDD
         4NuAD0YXTJN1oBZW4INQ13ca1JWXBh0bpb0YqTEgLWFE6lfHnxiuEqE/f0Wx47Zi3pZ6
         +/3hXlAaFe4gHsebv2rX+0SDQ8/3KHICCNsFfOQ7z2eY/wc7oGYMjAqhz8WVPUwdaxKv
         W+HJP45zvIvki9ERMfVNJS/Moy31ov13aQOWSx0ceGIHLaJkLf+ulrrp4siIegM58vdk
         HzjA==
X-Gm-Message-State: ACrzQf3ntsje3xpJeccRUtyyRrZqazgQpn6F6KVRM2DaRrD5ijyrTSan
        YH+tJRNwEVTc50+44+6y8rcASua1UEVUMg==
X-Google-Smtp-Source: AMsMyM53UgsWzcJYtE9qJosH8P809RLixt9Ivu7pC6jjEj5Umsh5vKfqcZHQ4jX+oD63T2O/5+SrDg==
X-Received: by 2002:a05:600c:600e:b0:3c6:fc59:5eda with SMTP id az14-20020a05600c600e00b003c6fc595edamr2796880wmb.30.1666795364815;
        Wed, 26 Oct 2022 07:42:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c304500b003a84375d0d1sm1934367wmh.44.2022.10.26.07.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:42:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/3] Makefile: simplify $(test_bindir_programs) rule by splitting it up
Date:   Wed, 26 Oct 2022 16:42:37 +0200
Message-Id: <patch-v2-3.3-400f487e30d-20221026T143534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com>
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

The "filter-out" added in [6] has now become unnecessary per the
above, it was an artifact of us losing track of what was in which of
our lists to begin with.

This change can be tested with e.g.:

	git checkout master &&
	make SHELL_PATH=/bin/bash X=.exe &&
	mv bin-wrappers bin-wrappers.master &&
	<apply this change> &&
	make SHELL_PATH=/bin/bash X=.exe &&
	diff -ru bin-wrappers{.master,}

Which will show an empty diff, i.e. we've correctly dealt with the
combination of $(SHELL_PATH), $(X) and these three variables here.

This also fixes an issue with the "bin-wrappers/" scripts have never had properly declared
dependency information, i.e. this has never worked:

	make clean &&
	make bin-wrappers/git &&
	# the script is there, but no "./git" is built
	./bin-wrappers/git

There was no reason not to have that work, just as most things
generated by the Makefile have proper dependency information.

Before this commit doing this would have been painful, but now it's
easy to pass this as a parameter to our "bin_wrappers_template"

1. ea925196f1b (build dashless "bin-wrappers" directory similar to
   installed bindir, 2009-12-02)
2. e6e7530d10b (test helpers: move test-* to t/helper/ subdirectory,
   2016-04-13)
3. 3a94cb31d52 (bin-wrappers: append `.exe` to target paths if
   necessary, 2019-07-29)
4. https://lore.kernel.org/git/sso99so6-n28s-rq86-8q20-4456r3pn869r@tzk.qr/
5. 46bac904581 (Do not install shell libraries executable, 2010-01-31)
6. 7b5c93c6c68" (scalar: include in standard Git build & installation,
   2022-09-02)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index a8cfa096dc1..d551a89bbff 100644
--- a/Makefile
+++ b/Makefile
@@ -595,6 +595,7 @@ export TCL_PATH TCLTK_PATH
 PTHREAD_LIBS = -lpthread
 
 # Guard against environment variables
+BIN_WRAPPERS =
 BUILTIN_OBJS =
 BUILT_INS =
 COMPAT_CFLAGS =
@@ -3062,16 +3063,39 @@ GIT-PYTHON-VARS: FORCE
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
+define bin_wrappers_template
+
+## bin_wrappers_template
+# 1 = $(1)
+# 2 = $(2)
+# 3 = $(3)
+# 4 = $(4)
+BW_$(1) = $$($(1):%=bin-wrappers/%)
+BIN_WRAPPERS += $$(BW_$(1))
+all:: $$(BW_$(1))
+$$(BW_$(1)): bin-wrappers/% : $(3)%$(4)
+$$(BW_$(1)): wrap-for-bin.sh
+	$$(call mkdir_p_parent_template)
+	$$(QUIET_GEN)$$(call cmd_munge_bin_wrappers_script,$(2),$(3),$(4))
+endef
 
-bin-wrappers/%: wrap-for-bin.sh
-	$(call mkdir_p_parent_template)
-	$(QUIET_GEN)sed -e $(call cmd_munge_script_sed_shell_path_arg) \
-	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
-	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
-	chmod +x $@
+define bin_wrappers_templates
+$(call bin_wrappers_template,BINDIR_PROGRAMS_NEED_X,'$$(@F)',,$$X)
+$(call bin_wrappers_template,BINDIR_PROGRAMS_NO_X,'$$(@F)')
+$(call bin_wrappers_template,TEST_PROGRAMS_NEED_X,'$$(@F)',t/helper/,$$X)
+endef
+$(eval $(call bin_wrappers_templates))
+
+all:: $(BIN_WRAPPERS)
 
 # GNU make supports exporting all variables by "export" without parameters.
 # However, the environment gets quite big, and some programs have problems
@@ -3404,7 +3428,7 @@ OTHER_PROGRAMS += $(shell echo *.dll t/helper/*.dll)
 endif
 
 artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
-		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
+		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(BIN_WRAPPERS) \
 		$(MOFILES)
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
 		SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
-- 
2.38.0.1251.g3eefdfb5e7a

