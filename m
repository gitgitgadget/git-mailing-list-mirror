Return-Path: <SRS0=qAd/=CI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFAAC433E2
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 19:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A313206F0
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 19:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ijhv6gUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgH3T2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Aug 2020 15:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgH3T2b (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Aug 2020 15:28:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A004FC061573
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 12:28:30 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id o18so5721194eje.7
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 12:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=VdAmm0PXspUEfjWkOmbUAkdIpWG+fMFXT6DDsPIl7mA=;
        b=Ijhv6gUvVdquEP6YcMD0cnTAi2KgmP6FJd7dS3+4lBWtY6OoenDRPCu4Aho9PUovf6
         iKWrqYVzOhq+ubGTLo/Ik7i7fWObN6sbY3jckWn6+BNqKcFNEpoRbbYbp1fDaQ542BVF
         yGs+tKjDXxx0vIK2LAReKVZvLrry1IQYZzEURHk0cB6pzO4gpwjmo9jTazQqnGYnFFG6
         J6fGiUf+CtZEXcQg4GFc0Ans73kqdcxCh1jDp1/ZMMhNqxVYN9Ij5/uqDLa+5MEPUaBe
         VOh74uNokBXaSxsy1Y0RpLrdvo9Kj6eRDZCeV+68ufQ6hh+VZLF5oFApoiI3rYekSrTz
         WLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VdAmm0PXspUEfjWkOmbUAkdIpWG+fMFXT6DDsPIl7mA=;
        b=Xjq6AIMjcjhMaipe3h7XHiAk8r9Oa/usNkz5sfjbYv6jxBRzWOAMSgWaOVF1v/J7/6
         wcmw6BH80nIXH9eJTG9tE/0qTxhrbDbiEYpSs62RxVvgsg8+EhY4qaYIHm1cPmSk3hsP
         whBwSPZnnWz1l4l8SFXeZlOxvQKjHUmokbvNfXs0CKtquB4YATqdBM980quYD4kCQbd9
         bgkq3pYdUrNJWP1wQcwI3m3LtsNvyWiWyqAcakDeiqadpXB6srvG6mCF5W2MGye+sS+7
         87yr9+yVlak4xxC/5iQSqj2cwI2HCA5NpAvLG+UtxA4p8dUIYeHyxJkbuSNeN+QN4j/o
         lG+A==
X-Gm-Message-State: AOAM532UKLCPVYP5gE5Ddur9Oacnaq/4jA4o5OgWzjNUT0gstO+d6Xwb
        qzdD1dMQ3OOySVNuIwC3Ft+iWhNx9Zk=
X-Google-Smtp-Source: ABdhPJzS2uN+yisFW3ZxoBFKwi8RRguzBvz/0DNqO1dunsR1nKxGTkPWJQ04xl45ugs68Esyvu9jAw==
X-Received: by 2002:a17:906:6055:: with SMTP id p21mr9287149ejj.173.1598815708874;
        Sun, 30 Aug 2020 12:28:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4sm5965243ejs.32.2020.08.30.12.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 12:28:28 -0700 (PDT)
Message-Id: <pull.714.git.1598815707540.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 30 Aug 2020 19:28:27 +0000
Subject: [PATCH] Makefile: add support for generating JSON compilation
 database
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Tools based on LibClang [1] can make use of a 'JSON Compilation
Database' [2] that keeps track of the exact options used to compile a set
of source files.

The Clang compiler can generate JSON fragments when compiling [3],
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
[3] https://clang.llvm.org/docs/ClangCommandLineReference.html#cmdoption-clang-mj-arg

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    Add support for generating JSON compilation database
    
    I don't have a lot of knowledge of Make double-colon rules, or insight
    into why they are used for the 'all' target, but I think the approach I
    chose makes sense. In particular, I do not list any prerequisite for the
    'compile_commands.json' file, but from what I tested it is still rebuilt
    anytime the 'all' target is rebuilt, which is what we want.
    
    Note: CMakeLists.txt in contrib/buildsystems does not need to be updated
    to also support this feature because CMake supports it out-of-the-box
    [1].
    
    [1] 
    https://cmake.org/cmake/help/latest/variable/CMAKE_EXPORT_COMPILE_COMMANDS.html

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-714%2Fphil-blain%2Fcompiledb-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-714/phil-blain/compiledb-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/714

 .gitignore |  2 ++
 Makefile   | 52 +++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 49 insertions(+), 5 deletions(-)

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
index 65f8cfb236..954bd2aa47 100644
--- a/Makefile
+++ b/Makefile
@@ -462,6 +462,12 @@ all::
 # the global variable _wpgmptr containing the absolute path of the current
 # executable (this is the case on Windows).
 #
+# Define GENERATE_COMPILATION_DATABASE to generate JSON compilation database
+# entries during compilation if your compiler supports it, using the `-MJ` flag.
+# The JSON entries will be placed in the `compile_commands/` directory,
+# and the JSON compilation database can be created afterwards with
+# `make compile_commands.json`.
+#
 # Define DEVELOPER to enable more compiler warnings. Compiler version
 # and family are auto detected, but could be overridden by defining
 # COMPILER_FEATURES (see config.mak.dev). You can still set
@@ -1258,6 +1264,20 @@ $(error please set COMPUTE_HEADER_DEPENDENCIES to yes, no, or auto \
 endif
 endif
 
+ifdef GENERATE_COMPILATION_DATABASE
+compdb_check = $(shell $(CC) $(ALL_CFLAGS) \
+	-c -MJ /dev/null \
+	-x c /dev/null -o /dev/null 2>&1; \
+	echo $$?)
+ifeq ($(compdb_check),0)
+override GENERATE_COMPILATION_DATABASE = yes
+else
+override GENERATE_COMPILATION_DATABASE = no
+$(warning GENERATE_COMPILATION_DATABASE is set, but your compiler does not \
+support generating compilation database entries)
+endif
+endif
+
 ifdef SANE_TOOL_PATH
 SANE_TOOL_PATH_SQ = $(subst ','\'',$(SANE_TOOL_PATH))
 BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix "$(SANE_TOOL_PATH_SQ)"|'
@@ -2381,16 +2401,30 @@ missing_dep_dirs =
 dep_args =
 endif
 
+compdb_dir = compile_commands/
+
+ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
+missing_compdb_dir = $(compdb_dir)
+$(missing_compdb_dir):
+	@mkdir -p $@
+
+compdb_file = $(compdb_dir)$(subst .-,,$(subst /,-,$(dir $@)))$(notdir $@).json
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
@@ -2413,6 +2447,14 @@ else
 $(OBJECTS): $(LIB_H) $(GENERATED_H)
 endif
 
+ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
+all:: compile_commands.json
+compile_commands.json:
+	@$(RM) $@
+	$(QUIET_GEN)sed -e '1s/^/[/' -e '$$s/,$$/]/' $(compdb_dir)*.o.json > $@+
+	@if test -s $@+; then mv $@+ $@; else $(RM) $@+; fi
+endif
+
 exec-cmd.sp exec-cmd.s exec-cmd.o: GIT-PREFIX
 exec-cmd.sp exec-cmd.s exec-cmd.o: EXTRA_CPPFLAGS = \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
@@ -3117,7 +3159,7 @@ clean: profile-clean coverage-clean cocciclean
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
