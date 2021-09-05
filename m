Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DF2C433F5
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 23:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 919AF60E93
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 23:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbhIEXws (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 19:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbhIEXwr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 19:52:47 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B939C061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 16:51:43 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o39-20020a05600c512700b002e74638b567so3570107wms.2
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 16:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yFSdDYd/lw6tWAOJj9Ojhzsn8yDq+UXCk8FF68k8NjY=;
        b=UMfO0RJ8NKn/Y2fJmgao6Tr0MR9cv5oEcn7G3lCs1qh7fBGHoGzYjjGgSn7obdQxyc
         ieQ/CcPZF9pWrEyInB7YUpgdl8ulPvhP92RX/A2TfVTRxMjw7zGZcFla7JDKljxc8nYk
         suTDPjO8LO/dAlKhJyz2ShwBuNPCBcS86L+heWxCI7ifYPXkIgEWvFvEnxoO7dhNaLnZ
         wtS0VtNOAxoZNp1r/IaNPmuM16QjW0PK6GurPfl5sGGFUK1oSdkOrjibojr71W14vkea
         d41dbgOHfX8kbTgvuvOk90ohRJa4bLpHFXScCYDkRFTTfgkowNs4pmtZbfNiACdV8lT1
         OLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yFSdDYd/lw6tWAOJj9Ojhzsn8yDq+UXCk8FF68k8NjY=;
        b=Nrc7eq9hm31lqaQG9bV5pndUuNQ7UHCbFB9hCj0zpuo6THne0Qzcc8I0kU1Wfq0abg
         hKrQY+DYWr5FlrsYErZkiOQYeFLTIQcXcWMxyk5uh9IrYAuPnZUNXNC73pSSYB2z3Bel
         eGS/u6RDN/TzKfmFXpYrb/Qse+cmNEEumJq4BffZ/JWfyOaajZ14bSsoMK8soOoQRL3I
         gAzq31JjZ5pKCDYjIKJCU81dywliZzSrQ1fxbZFBrUGLdgoX1wCiALga+qkP7GkOiOpr
         iotwV8QuhJmAYYN/Y8pc02mvJOJPilfJeHpds4+bewcR9wbgF4X3/60pFQuX8ZQ9tNj0
         WzBA==
X-Gm-Message-State: AOAM530+Fsw+ZX3APbo6Oq7HJO3DL6bKGjz5SJQqJtvT61FNtvZx8e71
        wJPnur2IRdqyUCEQTqaNwnBks/YQ224=
X-Google-Smtp-Source: ABdhPJwxAEe8aYtv+VN86vp6TcbkyMzUJOCcVgCeSIx5gXqmWWwNt/Cg2O4p7lUlHb72LXpLWhRhQQ==
X-Received: by 2002:a7b:c18c:: with SMTP id y12mr8576624wmi.3.1630885902056;
        Sun, 05 Sep 2021 16:51:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q85sm5683300wme.23.2021.09.05.16.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 16:51:41 -0700 (PDT)
Message-Id: <43415de761ac029b67645d9131b38e761ef6ae21.1630885899.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1031.git.1630885899.gitgitgadget@gmail.com>
References: <pull.1031.git.1630885899.gitgitgadget@gmail.com>
From:   "Andrew Olsen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 05 Sep 2021 23:51:37 +0000
Subject: [PATCH 2/4] Makefile for list-object-filter extensions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrew Olsen <andrew232@gmail.com>,
        Andrew Olsen <andrew.olsen@koordinates.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrew Olsen <andrew.olsen@koordinates.com>

Custom list-object-filter extensions can be compiled into Git using the
FILTER_EXTENSIONS Makefile argument.

Signed-off-by: Andrew Olsen <andrew.olsen@koordinates.com>
---
 Makefile                            | 35 +++++++++++++++++++++++++++--
 compat/vcbuild/README               |  5 +++--
 config.mak.uname                    |  6 ++---
 contrib/buildsystems/CMakeLists.txt |  7 ++++++
 4 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 429c276058d..0b1d0be81a5 100644
--- a/Makefile
+++ b/Makefile
@@ -471,6 +471,11 @@ all::
 # directory, and the JSON compilation database 'compile_commands.json' will be
 # created at the root of the repository.
 #
+# Define FILTER_EXTENSIONS to a space-separated list of static library plugins
+# that implement the filter-object-list extension API. Each of this filter
+# extensions will then be available in addition to the builtin ones such as
+# "blob:limit" and "object:type". See contrib/filter-extensions/README.txt
+#
 # Define DEVELOPER to enable more compiler warnings. Compiler version
 # and family are auto detected, but could be overridden by defining
 # COMPILER_FEATURES (see config.mak.dev). You can still set
@@ -824,6 +829,7 @@ XDIFF_LIB = xdiff/lib.a
 
 GENERATED_H += command-list.h
 GENERATED_H += config-list.h
+GENERATED_C += list-objects-filter-extensions.c
 
 LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
 	$(FIND) . \
@@ -916,6 +922,7 @@ LIB_OBJS += levenshtein.o
 LIB_OBJS += line-log.o
 LIB_OBJS += line-range.o
 LIB_OBJS += linear-assignment.o
+LIB_OBJS += list-objects-filter-extensions.o
 LIB_OBJS += list-objects-filter-options.o
 LIB_OBJS += list-objects-filter.o
 LIB_OBJS += list-objects.o
@@ -2116,6 +2123,19 @@ ifdef DEFAULT_HELP_FORMAT
 BASIC_CFLAGS += -DDEFAULT_HELP_FORMAT='"$(DEFAULT_HELP_FORMAT)"'
 endif
 
+ifneq ($(FILTER_EXTENSIONS),)
+FILTER_EXT_PATHS = $(dir $(FILTER_EXTENSIONS))
+
+$(FILTER_EXTENSIONS): $(FILTER_EXT_PATHS)
+	$(QUIET_SUBDIR0)$(@D) $(QUIET_SUBDIR1) \
+		ALL_CFLAGS='$(subst ','\'',$(ALL_CFLAGS))' \
+		ALL_LDFLAGS='$(subst ','\'',$(ALL_LDFLAGS))' \
+		PROFILE_DIR='$(subst ','\'',$(PROFILE_DIR))' \
+		$(@F)
+
+GITLIBS += $(FILTER_EXTENSIONS)
+endif
+
 PAGER_ENV_SQ = $(subst ','\'',$(PAGER_ENV))
 PAGER_ENV_CQ = "$(subst ",\",$(subst \,\\,$(PAGER_ENV)))"
 PAGER_ENV_CQ_SQ = $(subst ','\'',$(PAGER_ENV_CQ))
@@ -2222,7 +2242,7 @@ git.sp git.s git.o: EXTRA_CPPFLAGS = \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
 
-git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
+git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS) $(EXTENSION_LIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS)
 
@@ -2261,6 +2281,10 @@ command-list.h: $(wildcard Documentation/git*.txt)
 		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
 		command-list.txt >$@+ && mv $@+ $@
 
+list-objects-filter-extensions.c: generate-list-objects-filter-extensions.sh GIT-BUILD-OPTIONS
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-list-objects-filter-extensions.sh \
+		$(FILTER_EXTENSIONS) > $@+ && mv $@+ $@
+
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
 	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV):\
@@ -2612,6 +2636,7 @@ $(LIB_FILE): $(LIB_OBJS)
 $(XDIFF_LIB): $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
+
 export DEFAULT_EDITOR DEFAULT_PAGER
 
 Documentation/GIT-EXCLUDED-PROGRAMS: FORCE
@@ -2857,6 +2882,9 @@ ifdef RUNTIME_PREFIX
 	@echo RUNTIME_PREFIX=\'true\' >>$@+
 else
 	@echo RUNTIME_PREFIX=\'false\' >>$@+
+endif
+ifdef FILTER_EXTENSIONS
+	@echo FILTER_EXTENSIONS=\''$(subst ','\'',$(subst ','\'',$(FILTER_EXTENSIONS)))'\' >>$@+
 endif
 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
 
@@ -3241,7 +3269,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(HCC)
 	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
 	$(RM) -r po/build/
-	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope*
+	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(GENERATED_C) $(ETAGS_TARGET) tags cscope*
 	$(RM) -r .dist-tmp-dir .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
@@ -3256,6 +3284,9 @@ endif
 ifndef NO_TCLTK
 	$(MAKE) -C gitk-git clean
 	$(MAKE) -C git-gui clean
+endif
+ifneq ($(FILTER_EXTENSIONS),)
+	$(foreach FP,$(FILTER_EXTENSIONS),$(MAKE) -C $(dir $(FP)) clean && ) true
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-BUILD-OPTIONS
 	$(RM) GIT-USER-AGENT GIT-PREFIX
diff --git a/compat/vcbuild/README b/compat/vcbuild/README
index 51fb083dbbe..5e39022eade 100644
--- a/compat/vcbuild/README
+++ b/compat/vcbuild/README
@@ -92,8 +92,9 @@ The Steps of Build Git with VS2008
    the git operations.
 
 3. Inside Git's directory run the command:
-       make command-list.h config-list.h
-   to generate the header file needed to compile git.
+       make command-list.h config-list.h list-objects-filter-extensions.c
+   to generate those source files that are not included in the repo, but
+   instead are automatically generated from other files.
 
 4. Then either build Git with the GNU Make Makefile in the Git projects
    root
diff --git a/config.mak.uname b/config.mak.uname
index 76516aaa9a5..405e7d91e7a 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -735,9 +735,9 @@ vcxproj:
 	 echo '</Project>') >git-remote-http/LinkOrCopyRemoteHttp.targets
 	git add -f git/LinkOrCopyBuiltins.targets git-remote-http/LinkOrCopyRemoteHttp.targets
 
-	# Add command-list.h and config-list.h
-	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 config-list.h command-list.h
-	git add -f config-list.h command-list.h
+	# Add command-list.h, config-list.h list-objects-filter-extensions.c
+	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 config-list.h command-list.h list-objects-filter-extensions.c
+	git add -f config-list.h command-list.h list-objects-filter-extensions.c
 
 	# Add scripts
 	rm -f perl/perl.mak
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 171b4124afe..60627a2892f 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -624,6 +624,13 @@ if(NOT EXISTS ${CMAKE_BINARY_DIR}/config-list.h)
 			OUTPUT_FILE ${CMAKE_BINARY_DIR}/config-list.h)
 endif()
 
+if(NOT EXISTS ${CMAKE_BINARY_DIR}/list-objects-filter-extensions.c)
+	message("Generating list-objects-filter-extensions.c")
+	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-list-objects-filter-extensions.sh
+			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
+			OUTPUT_FILE ${CMAKE_BINARY_DIR}/list-objects-filter-extensions.c)
+endif()
+
 include_directories(${CMAKE_BINARY_DIR})
 
 #build
-- 
gitgitgadget

