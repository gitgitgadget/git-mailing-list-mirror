Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98734C43461
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5375E20716
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Igygc6/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgICWNn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgICWNm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 18:13:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E0FC061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 15:13:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c19so6240025wmd.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 15:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rZdDuYh2qI0Ak3vXPSL8Db94QIf+UEYKZ4Ydnn0V4og=;
        b=Igygc6/9XhUNIXHeBUbfnwErRlqoTWXp8yQ11F87+CzleZc/51X/7Stan7Djh7a0UP
         NAauGDTGIGwOzTeLW6yPI33o5bkmCwCG/uXX2SRH+75NPywQGF0nhmg2Y9DdbXWPnZs4
         GZGRnTTHORmtfnfPO7ZwN+OGVT51WOdxfJ3xF6cR6bDddixPJ2HzPW1E7um6pQwyJuBV
         Kmu7jQqiHcCDCDEaOJ48FvC+wg5Y2g+ujQnu/n9Pj4x0XY8zzFq1b6wUMkV9vPEGEV+9
         mMMSI+NjGQ3SY/RSuPEofHCMCos/4auHJ52uL93l57VecEOMqqvfShWQ21LzdJf7sgKk
         mDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rZdDuYh2qI0Ak3vXPSL8Db94QIf+UEYKZ4Ydnn0V4og=;
        b=jVLAtLgCBlspWpLJK65iMkgvBZvKT55jjYZ2gGeZag6Vqbu37PH+8PZ1skR7szjVjo
         9K6psgiKyi5POAaD2K0FYZ/gXyVWoVbftiF5uuYbOk+YfYdhTO7ukx7mKoUvBtMshnS4
         WXzkIplhqJZ1Hd5lqW6gv+38Q//XjNXGmS6j2fx7RaEKxG244fGk/IkriDXhQbedAPwk
         a8TOTm4BVRVkl0o6rOFDizhDSE0dHqjkoqaUkwxWkKXByqTe/N8+fxoL3kPSKT84FWTM
         3VVDyvbU3a8d7/euROITQcegUAtaXn6Jy3BZblybjeTarwe9Ee9ZIChiCnzuvFNi9Ynv
         v7zw==
X-Gm-Message-State: AOAM532wwr+fIVWkbJrxCaqNvxkqJrKnfIu0tQOzICh9MbS5s1Q3QsaB
        EWXsk2CAA1h4pJOQ06bkRQM0OOneZHw=
X-Google-Smtp-Source: ABdhPJx24GuE+dPd+96fskJajS4/EszbQnc6PwZpot7SiOk7zYtl7XLX2lpCf3TBzFlSDLoUg/tmLg==
X-Received: by 2002:a1c:ed16:: with SMTP id l22mr4309108wmh.80.1599171219700;
        Thu, 03 Sep 2020 15:13:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15sm6633830wmn.24.2020.09.03.15.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:13:39 -0700 (PDT)
Message-Id: <pull.714.v3.git.1599171218675.gitgitgadget@gmail.com>
In-Reply-To: <pull.714.v2.git.1599001759548.gitgitgadget@gmail.com>
References: <pull.714.v2.git.1599001759548.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Sep 2020 22:13:38 +0000
Subject: [PATCH v3] Makefile: add support for generating JSON compilation
 database
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Tools based on LibClang [1] can make use of a 'JSON Compilation
Database' [2] that keeps track of the exact options used to compile a set
of source files.

For example, clangd [3], which is a C language server protocol
implementation, can use a JSON compilation database to determine the
flags needed to compile a file so it can provide proper editor
integration.  As a result, editors supporting the language server
protocol (such as VS Code, Emacs, or Vim, with suitable plugins) can
provide better searching, integration, and refactoring tools.

The Clang compiler can generate JSON fragments when compiling [4],
using the `-MJ` flag. These JSON fragments (one per compiled source
file) can then be concatenated to create the compilation database,
commonly called 'compile_commands.json'.

Add support to the Makefile for generating these JSON fragments as well
as the compilation database itself, if the environment variable
'GENERATE_COMPILATION_DATABASE' is set.

If this variable is set, check that $(CC) indeed supports the `-MJ`
flag, following what is done for automatic dependencies.

All JSON fragments are placed in the 'compile_commands/' directory, and
the compilation database 'compile_commands.json' is generated as a
dependency of the 'all' target using a `sed` invocation.

[1] https://clang.llvm.org/docs/Tooling.html
[2] https://clang.llvm.org/docs/JSONCompilationDatabase.html
[3] https://clangd.llvm.org/
[4] https://clang.llvm.org/docs/ClangCommandLineReference.html#cmdoption-clang-mj-arg

Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    Add support for generating JSON compilation database
    
    Changes since v2: Incorporated Junio's suggestions:
    
     * improved the logic around values of the new 
       GENERATE_COMPILATION_DATABASE macro
     * simplified the Makefile functions used to generate the path of the
       JSON fragments
     * removed the trailing slash after the default value of compdb_dir
    
    Changes since v1:
    
     * Added a paragraph to the commit message to better explain why this
       feature would help Git developers (Thanks Brian!)
     * Corrected the description of the new GENERATE_COMPILATION_DATABASE 
       Makefile knob to make it reflect its actual behavior (cf. 
       https://lore.kernel.org/git/FC95CFF7-F9DA-4CDA-9923-99C3432DCAD5@gmail.com/
       )
    
    v1: I don't have a lot of knowledge of Make double-colon rules, or
    insight into why they are used for the 'all' target, but I think the
    approach I chose makes sense. In particular, I do not list any
    prerequisite for the 'compile_commands.json' file, but from what I
    tested it is still rebuilt anytime the 'all' target is rebuilt, which is
    what we want.
    
    Note: CMakeLists.txt in contrib/buildsystems does not need to be updated
    to also support this feature because CMake supports it out-of-the-box
    [1].
    
    [1] 
    https://cmake.org/cmake/help/latest/variable/CMAKE_EXPORT_COMPILE_COMMANDS.html

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-714%2Fphil-blain%2Fcompiledb-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-714/phil-blain/compiledb-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/714

Range-diff vs v2:

 1:  da9544e4aa ! 1:  1955b6b390 Makefile: add support for generating JSON compilation database
     @@ Makefile: all::
       # the global variable _wpgmptr containing the absolute path of the current
       # executable (this is the case on Windows).
       #
     -+# Define GENERATE_COMPILATION_DATABASE to generate JSON compilation database
     -+# entries during compilation if your compiler supports it, using the `-MJ` flag.
     -+# The JSON entries will be placed in the `compile_commands/` directory,
     -+# and the JSON compilation database 'compile_commands.json' will be created 
     -+# at the root of the repository. 
     ++# Define GENERATE_COMPILATION_DATABASE to "yes" to generate JSON compilation
     ++# database entries during compilation if your compiler supports it, using the
     ++# `-MJ` flag. The JSON entries will be placed in the `compile_commands/`
     ++# directory, and the JSON compilation database 'compile_commands.json' will be
     ++# created at the root of the repository.
      +#
       # Define DEVELOPER to enable more compiler warnings. Compiler version
       # and family are auto detected, but could be overridden by defining
     @@ Makefile: $(error please set COMPUTE_HEADER_DEPENDENCIES to yes, no, or auto \
       endif
       endif
       
     -+ifdef GENERATE_COMPILATION_DATABASE
     ++ifndef GENERATE_COMPILATION_DATABASE
     ++GENERATE_COMPILATION_DATABASE = no
     ++endif
     ++
     ++ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
      +compdb_check = $(shell $(CC) $(ALL_CFLAGS) \
      +	-c -MJ /dev/null \
      +	-x c /dev/null -o /dev/null 2>&1; \
      +	echo $$?)
     -+ifeq ($(compdb_check),0)
     -+override GENERATE_COMPILATION_DATABASE = yes
     -+else
     ++ifneq ($(compdb_check),0)
      +override GENERATE_COMPILATION_DATABASE = no
     -+$(warning GENERATE_COMPILATION_DATABASE is set, but your compiler does not \
     ++$(warning GENERATE_COMPILATION_DATABASE is set to "yes", but your compiler does not \
      +support generating compilation database entries)
      +endif
     ++else
     ++ifneq ($(GENERATE_COMPILATION_DATABASE),no)
     ++$(error please set GENERATE_COMPILATION_DATABASE to "yes" or "no" \
     ++(not "$(GENERATE_COMPILATION_DATABASE)"))
     ++endif
      +endif
      +
       ifdef SANE_TOOL_PATH
     @@ Makefile: missing_dep_dirs =
       dep_args =
       endif
       
     -+compdb_dir = compile_commands/
     ++compdb_dir = compile_commands
      +
      +ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
      +missing_compdb_dir = $(compdb_dir)
      +$(missing_compdb_dir):
      +	@mkdir -p $@
      +
     -+compdb_file = $(compdb_dir)$(subst .-,,$(subst /,-,$(dir $@)))$(notdir $@).json
     ++compdb_file = $(compdb_dir)/$(subst /,-,$@.json)
      +compdb_args = -MJ $(compdb_file)
      +else
      +missing_compdb_dir =
     @@ Makefile: else
      +all:: compile_commands.json
      +compile_commands.json:
      +	@$(RM) $@
     -+	$(QUIET_GEN)sed -e '1s/^/[/' -e '$$s/,$$/]/' $(compdb_dir)*.o.json > $@+
     ++	$(QUIET_GEN)sed -e '1s/^/[/' -e '$$s/,$$/]/' $(compdb_dir)/*.o.json > $@+
      +	@if test -s $@+; then mv $@+ $@; else $(RM) $@+; fi
      +endif
      +


 .gitignore |  2 ++
 Makefile   | 59 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/.gitignore b/.gitignore
index ee509a2ad2..f4c51300e0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -197,6 +197,7 @@
 /git.spec
 *.exe
 *.[aos]
+*.o.json
 *.py[co]
 .depend/
 *.gcda
@@ -218,6 +219,7 @@
 /tags
 /TAGS
 /cscope*
+/compile_commands.json
 *.hcc
 *.obj
 *.lib
diff --git a/Makefile b/Makefile
index 65f8cfb236..39ca667689 100644
--- a/Makefile
+++ b/Makefile
@@ -462,6 +462,12 @@ all::
 # the global variable _wpgmptr containing the absolute path of the current
 # executable (this is the case on Windows).
 #
+# Define GENERATE_COMPILATION_DATABASE to "yes" to generate JSON compilation
+# database entries during compilation if your compiler supports it, using the
+# `-MJ` flag. The JSON entries will be placed in the `compile_commands/`
+# directory, and the JSON compilation database 'compile_commands.json' will be
+# created at the root of the repository.
+#
 # Define DEVELOPER to enable more compiler warnings. Compiler version
 # and family are auto detected, but could be overridden by defining
 # COMPILER_FEATURES (see config.mak.dev). You can still set
@@ -1258,6 +1264,27 @@ $(error please set COMPUTE_HEADER_DEPENDENCIES to yes, no, or auto \
 endif
 endif
 
+ifndef GENERATE_COMPILATION_DATABASE
+GENERATE_COMPILATION_DATABASE = no
+endif
+
+ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
+compdb_check = $(shell $(CC) $(ALL_CFLAGS) \
+	-c -MJ /dev/null \
+	-x c /dev/null -o /dev/null 2>&1; \
+	echo $$?)
+ifneq ($(compdb_check),0)
+override GENERATE_COMPILATION_DATABASE = no
+$(warning GENERATE_COMPILATION_DATABASE is set to "yes", but your compiler does not \
+support generating compilation database entries)
+endif
+else
+ifneq ($(GENERATE_COMPILATION_DATABASE),no)
+$(error please set GENERATE_COMPILATION_DATABASE to "yes" or "no" \
+(not "$(GENERATE_COMPILATION_DATABASE)"))
+endif
+endif
+
 ifdef SANE_TOOL_PATH
 SANE_TOOL_PATH_SQ = $(subst ','\'',$(SANE_TOOL_PATH))
 BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix "$(SANE_TOOL_PATH_SQ)"|'
@@ -2381,16 +2408,30 @@ missing_dep_dirs =
 dep_args =
 endif
 
+compdb_dir = compile_commands
+
+ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
+missing_compdb_dir = $(compdb_dir)
+$(missing_compdb_dir):
+	@mkdir -p $@
+
+compdb_file = $(compdb_dir)/$(subst /,-,$@.json)
+compdb_args = -MJ $(compdb_file)
+else
+missing_compdb_dir =
+compdb_args =
+endif
+
 ASM_SRC := $(wildcard $(OBJECTS:o=S))
 ASM_OBJ := $(ASM_SRC:S=o)
 C_OBJ := $(filter-out $(ASM_OBJ),$(OBJECTS))
 
 .SUFFIXES:
 
-$(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs)
-	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
-$(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs)
-	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
+$(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
+	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
+$(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
+	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
 
 %.s: %.c GIT-CFLAGS FORCE
 	$(QUIET_CC)$(CC) -o $@ -S $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
@@ -2413,6 +2454,14 @@ else
 $(OBJECTS): $(LIB_H) $(GENERATED_H)
 endif
 
+ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
+all:: compile_commands.json
+compile_commands.json:
+	@$(RM) $@
+	$(QUIET_GEN)sed -e '1s/^/[/' -e '$$s/,$$/]/' $(compdb_dir)/*.o.json > $@+
+	@if test -s $@+; then mv $@+ $@; else $(RM) $@+; fi
+endif
+
 exec-cmd.sp exec-cmd.s exec-cmd.o: GIT-PREFIX
 exec-cmd.sp exec-cmd.s exec-cmd.o: EXTRA_CPPFLAGS = \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
@@ -3117,7 +3166,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
 	$(RM) $(HCC)
-	$(RM) -r bin-wrappers $(dep_dirs)
+	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
 	$(RM) -r po/build/
 	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope*
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir

base-commit: d9cd4331470f4d9d78677f12dc79063dab832f53
-- 
gitgitgadget
