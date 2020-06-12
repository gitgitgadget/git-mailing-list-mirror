Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49BDC433E0
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 18:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 735D5207ED
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 18:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxDnOnCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgFLS3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 14:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLS3b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 14:29:31 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC3CC03E96F
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 11:29:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l11so10699754wru.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 11:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mgRrkprDi4IwQXOIdFqfl05sWinhpKel7Iba5jO9AYk=;
        b=YxDnOnCUg/7rUvTr06SNLG/YAMBGavwab5anxFIcFRJ4GNkaTgAIwlVUwnnz+DEXQJ
         KO1WHfBmx9c+NdFHgxd4pPb+etKpsmpvOUSM0CIXrE3qokehAXLnXhsOGCxy5papLjNK
         gqftZ3VpoxrvzWG+Ci8k3txTjbRpc/bDiYkLp0JPTs+6Kq8OIeVQoawunhkqcGCe7OOg
         r96lMwN6o+baj5iRU8h2V50TncqJGUh5QOclCECleZj+A7x2BEMN9xoj2AWdEJEXCXAg
         nwhsX0Hhw7e2IcKcADAs7cfwRi2iUzDkWsMeWmgb3XcM4GWSFUWIfGDMXy3RGyh9qXov
         3oLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mgRrkprDi4IwQXOIdFqfl05sWinhpKel7Iba5jO9AYk=;
        b=CgvwXaOO0NdhUWzvCjjBnnWzLc/vWciiHfc3zUo0kLRGrhsz+haujHkVy1OgUm0/B1
         xonIQGcmXDagE44Q564b4V8Vq7a70wfYeKCBjJHn2xH/RHgHY6rtJxTTyVdueIfdk/2M
         +NCWpbyj1b+h8EmGI9/00tz28bsKSKwZMNwFe48xBWiMBz8RDjX+hwxys5OO+BZFYlad
         MRB+UJhaG210K+8yd4NVhngFDGjsJutJrCdXoGJP/c8V7U14XC8twJ0E0/AkL1sPAuw1
         udFEJ9Y3EQ6NPjXAg1U+O1ALt/C0y/8QQBK85bHEMLEoJyy7S47c8QSbD3LjRfiyJTeM
         RVaA==
X-Gm-Message-State: AOAM532WJf7EdfiKF3Bf7B1Sg5PR+pLOsMsQ1mLvldz9ZNPQlCDoyCAd
        ZtqSBmmFDKT43ISI71yBtDpQVKZV
X-Google-Smtp-Source: ABdhPJxOquuoIW7V5nSODt9Bt17FfEPk7dbKEx7h6i35NzEAdehCKtyLbqevk/Cwr7vZb+bTie8JCw==
X-Received: by 2002:adf:e3c4:: with SMTP id k4mr16080545wrm.262.1591986568022;
        Fri, 12 Jun 2020 11:29:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14sm11756710wrb.94.2020.06.12.11.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 11:29:27 -0700 (PDT)
Message-Id: <pull.614.v4.git.1591986566.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
References: <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Jun 2020 18:29:18 +0000
Subject: [PATCH v4 0/8] CMake build system for git
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an attempt to build Git using CMake. CMake is cross-platform build
generator which works well on a variety of platforms(primarily Linux and
Windows). Using CMake we can check whether certain headers exist, certain
functions exist, the required libraries are present and configure the build
accordingly. Using CMake we can also build and test Git out of source,
resulting in a clean source tree.

Tested platforms

Ubuntu 18.04 GCC 7.4 Clang 8.0.1

Windows MinGW GCC 9.2 Clang 9 Visual Studio 2015,2017,2019

Changes:

1) The CMake script has been relocated to contrib/buildsystems 2) The CMake
script parses the Makefile for the sources. LIB_OBJS BUILTIN_OBJS XDIFF_OBJS
VCSSVN_OBJS TEST_BUILTINS_OBJS SCRIPT_SH SCRIPT_PERL 3) Philip suggested to
change the error message if sh/bash was not found on windows. 4) CMake now
tests for ICONV_OMITS_BOM, NO_ST_BLOCKS_IN_STRUCT_STAT 5) Renamed the
variable test_helper_sources to test-tool_SOURCES [PATCH 4/8] to be
consistent with the naming of source variables.

Changes v2: Changes 1,2,4 have been rebased to PATCH 01/xx CMake uses
GIT-VERSION-GEN to get the version of Git Fixed a bug where a Windows user
can pose as Linux user and vice versa. [PATCH 6/8]

Changes v3: Patch changes are moved from the commit messages and are placed
here. Code inside check_c_source_(compiles/runs) have been formatted
according to git coding guidelines. [PATCH 1/8] The CMake script parses the
Makefile for SCRIPT_LIB also. [PATCH 2/8] The CMake script globs templates,
po files. Logic has been added to place the template files in their
respective directories instead of hard-coding them. [PATCH 2/8]

Sibi Siddharthan (8):
  Introduce CMake support for configuring Git
  cmake: generate the shell/perl/python scripts and templates,
    translations
  cmake: installation support for git
  cmake: support for testing git with ctest
  cmake: support for testing git when building out of the source tree
  cmake: support for building git on windows with mingw
  cmake: support for building git on windows with msvc and clang.
  ci: modification of main.yml to use cmake for vs-build job

 .github/workflows/main.yml          |   36 +-
 contrib/buildsystems/CMakeLists.txt | 1003 +++++++++++++++++++++++++++
 2 files changed, 1024 insertions(+), 15 deletions(-)
 create mode 100644 contrib/buildsystems/CMakeLists.txt


base-commit: c72c7da667dba3465fb566ecb23457950e28893c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-614%2FSibiSiddharthan%2Fgit-og-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-614/SibiSiddharthan/git-og-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/614

Range-diff vs v3:

 1:  09c972de52b ! 1:  c4e1ba74464 Introduce CMake support for configuring Git
     @@ Commit message
          part of the build. This is needed to generate all those hardlinks for
          the built-in commands of Git.
      
     -    Changes
     -    The CMake script parses the Makefile for:
     -    LIB_OBJS
     -    BUILTIN_OBJS
     -    XDIFF_OBJS
     -    VCSSVN_OBJS
     -    TEST_BUILTINS_OBJS
     -
     -    By doing this we avoid duplication of text between the Makefile and
     -    the CMake script.
     -
     -    The CMake script has been relocated to contrib/buildsystems.
     -
     -    The CMake script uses GIT-VERSION-GEN to determine the version of Git
     -    being built.
     -
          Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
      
       ## contrib/buildsystems/CMakeLists.txt (new) ##
     @@ contrib/buildsystems/CMakeLists.txt (new)
      +Instructions to run CMake:
      +
      +cmake `relative-path-to-CMakeLists.txt` -DCMAKE_BUILD_TYPE=Release
     ++Eg.
     ++From the root of git source tree
     ++	`cmake contrib/buildsystems/ `
     ++This will build the git binaries at the root
     ++
     ++For out of source builds, say build in 'git/git-build/'
     ++	`mkdir git-build;cd git-build; cmake ../contrib/buildsystems/`
     ++This will build the git binaries in git-build directory
      +
      +Possible build configurations(-DCMAKE_BUILD_TYPE) with corresponding
      +compiler flags
     @@ contrib/buildsystems/CMakeLists.txt (new)
      +NOTE: -DCMAKE_BUILD_TYPE is optional. For multi-config generators like Visual Studio
      +this option is ignored
      +
     -+This process generates a Makefile(Linux) , Visual Studio solution(Windows) by default.
     -+Run `make` to build Git on Linux.
     ++This process generates a Makefile(Linux/*BSD/MacOS) , Visual Studio solution(Windows) by default.
     ++Run `make` to build Git on Linux/*BSD/MacOS.
      +Open git.sln on Windows and build Git.
      +
      +NOTE: By default CMake uses Makefile as the build tool on Linux and Visual Studio in Windows,
     @@ contrib/buildsystems/CMakeLists.txt (new)
      +
      +check_c_source_compiles("
      +#include <alloca.h>
     -+int
     -+main ()
     ++
     ++int main(void)
      +{
     -+char *p = (char *) alloca (2 * sizeof (int));
     -+	if (p) return 0;
     ++	char *p = (char *) alloca(2 * sizeof(int));
     ++
     ++	if (p)
     ++		return 0;
      +	return 0;
      +}"
      +HAVE_ALLOCA_H)
     @@ contrib/buildsystems/CMakeLists.txt (new)
      +#include<stdarg.h>
      +#include<string.h>
      +#include<stdlib.h>
     ++
      +int test_vsnprintf(char *str, size_t maxsize, const char *format, ...)
      +{
      +	int ret;
     @@ contrib/buildsystems/CMakeLists.txt (new)
      +	return ret;
      +}
      +
     -+int
     -+main ()
     ++int main(void)
      +{
      +	char buf[6];
     ++
      +	if (test_vsnprintf(buf, 3, \"%s\", \"12345\") != 5
     -+		|| strcmp(buf, \"12\")) return 1;
     ++		|| strcmp(buf, \"12\"))
     ++			return 1;
      +	if (snprintf(buf, 3, \"%s\", \"12345\") != 5
     -+		|| strcmp(buf, \"12\")) return 1;
     -+
     ++		|| strcmp(buf, \"12\"))
     ++			return 1;
      +	return 0;
      +}"
      +SNPRINTF_OK)
     @@ contrib/buildsystems/CMakeLists.txt (new)
      +
      +check_c_source_runs("
      +#include<stdio.h>
     -+int
     -+main ()
     ++
     ++int main(void)
      +{
      +	FILE *f = fopen(\".\", \"r\");
     -+	return f != NULL;
      +
     -+	return 0;
     ++	return f != NULL;
      +}"
      +FREAD_READS_DIRECTORIES_NO)
      +if(NOT FREAD_READS_DIRECTORIES_NO)
     @@ contrib/buildsystems/CMakeLists.txt (new)
      +#ifndef REG_STARTEND
      +#error oops we dont have it
      +#endif
     -+int main(){return 0;}"
     ++
     ++int main(void)
     ++{
     ++	return 0;
     ++}"
      +HAVE_REGEX)
      +if(NOT HAVE_REGEX)
      +	include_directories(${CMAKE_SOURCE_DIR}/compat/regex)
     @@ contrib/buildsystems/CMakeLists.txt (new)
      +#include <sys/types.h>
      +#include <sys/sysctl.h>
      +
     -+int
     -+main ()
     ++int main(void)
      +{
      +	int val, mib[2];
      +	size_t len;
     @@ contrib/buildsystems/CMakeLists.txt (new)
      +	mib[1] = 1;
      +	len = sizeof(val);
      +	return sysctl(mib, 2, &val, &len, NULL, 0) ? 1 : 0;
     -+
     -+	return 0;
      +}"
      +HAVE_BSD_SYSCTL)
      +if(HAVE_BSD_SYSCTL)
     @@ contrib/buildsystems/CMakeLists.txt (new)
      +		char **inbuf, size_t *inbytesleft,
      +		char **outbuf, size_t *outbytesleft);
      +
     -+int main(){return 0;}"
     ++int main(void)
     ++{
     ++	return 0;
     ++}"
      +HAVE_NEW_ICONV)
      +if(HAVE_NEW_ICONV)
      +	set(HAVE_OLD_ICONV 0)
     @@ contrib/buildsystems/CMakeLists.txt (new)
      +typedef char *iconv_ibp;
      +#endif
      +
     -+int main()
     ++int main(void)
      +{
      +	int v;
      +	iconv_t conv;
     -+	char in[] = \"a\"; iconv_ibp pin = in;
     -+	char out[20] = \"\"; char *pout = out;
     -+	size_t isz = sizeof in;
     -+	size_t osz = sizeof out;
     ++	char in[] = \"a\";
     ++	iconv_ibp pin = in;
     ++	char out[20] = \"\";
     ++	char *pout = out;
     ++	size_t isz = sizeof(in);
     ++	size_t osz = sizeof(out);
      +
      +	conv = iconv_open(\"UTF-16\", \"UTF-8\");
      +	iconv(conv, &pin, &isz, &pout, &osz);
 2:  f19794fdbc0 ! 2:  abb9e6e1d58 cmake: generate the shell/perl/python scripts and templates, translations
     @@ Commit message
      
          NOTE: The scripts and templates are generated during configuration.
      
     -    Changes
     -    The CMake script parses the Makefile for:
     -    SCRIPT_SH
     -    SCRIPT_PERL
     -
          Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
      
       ## contrib/buildsystems/CMakeLists.txt ##
     @@ contrib/buildsystems/CMakeLists.txt: macro(parse_makefile_for_sources list_var r
      +	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
      +	string(STRIP ${${list_var}} ${list_var}) #remove trailing/leading whitespaces
      +	string(REPLACE " " ";" ${list_var} ${${list_var}}) #convert string to a list
     -+	list(TRANSFORM ${list_var} REPLACE "${lang}" "") #do the replacement
     ++	if(NOT ${lang}) #exclude for SCRIPT_LIB
     ++		list(TRANSFORM ${list_var} REPLACE "${lang}" "") #do the replacement
     ++	endif()
      +endmacro()
      +
       include(CheckTypeSize)
     @@ contrib/buildsystems/CMakeLists.txt: add_custom_command(OUTPUT ${git_links} ${gi
      +
      +#shell scripts
      +parse_makefile_for_scripts(git_sh_scripts "SCRIPT_SH" ".sh")
     ++parse_makefile_for_scripts(git_shlib_scripts "SCRIPT_LIB" "")
      +set(git_shell_scripts
     -+	${git_sh_scripts}
     -+	git-mergetool--lib git-parse-remote git-rebase--preserve-merges
     -+	git-sh-setup git-sh-i18n git-instaweb)
     ++	${git_sh_scripts} ${git_shlib_scripts} git-instaweb)
      +
      +foreach(script ${git_shell_scripts})
      +	file(STRINGS ${CMAKE_SOURCE_DIR}/${script}.sh content NEWLINE_CONSUME)
     @@ contrib/buildsystems/CMakeLists.txt: add_custom_command(OUTPUT ${git_links} ${gi
      +
      +
      +#templates
     ++file(GLOB templates "${CMAKE_SOURCE_DIR}/templates/*")
     ++list(TRANSFORM templates REPLACE "${CMAKE_SOURCE_DIR}/templates/" "")
     ++list(REMOVE_ITEM templates ".gitignore")
     ++list(REMOVE_ITEM templates "Makefile")
     ++
     ++list(REMOVE_ITEM templates "branches--")
      +file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/branches) #create branches
     -+set(hooks_templates
     -+	applypatch-msg.sample pre-applypatch.sample pre-push.sample
     -+	commit-msg.sample pre-commit.sample pre-rebase.sample
     -+	fsmonitor-watchman.sample pre-merge-commit.sample pre-receive.sample
     -+	post-update.sample prepare-commit-msg.sample update.sample)
      +
      +#templates have @.*@ replacement so use configure_file instead
     -+#hooks
     -+foreach(tm ${hooks_templates})
     -+	configure_file(${CMAKE_SOURCE_DIR}/templates/hooks--${tm} ${CMAKE_BINARY_DIR}/templates/blt/hooks/${tm} @ONLY)
     ++foreach(tm ${templates})
     ++	string(REPLACE "--" "/" blt_tm ${tm})
     ++	string(REPLACE "this" "" blt_tm ${blt_tm})# for this--
     ++	configure_file(${CMAKE_SOURCE_DIR}/templates/${tm} ${CMAKE_BINARY_DIR}/templates/blt/${blt_tm} @ONLY)
      +endforeach()
      +
     -+#info
     -+configure_file(${CMAKE_SOURCE_DIR}/templates/info--exclude ${CMAKE_BINARY_DIR}/templates/blt/info/exclude @ONLY)
     -+
     -+#this
     -+configure_file(${CMAKE_SOURCE_DIR}/templates/this--description ${CMAKE_BINARY_DIR}/templates/blt/description @ONLY)
     -+
      +
      +#translations
      +if(MSGFMT_EXE)
     -+	set(po_files bg  ca  de  el  es  fr  is  it  ko  pt_PT  ru  sv  tr  vi  zh_CN  zh_TW)
     ++	file(GLOB po_files "${CMAKE_SOURCE_DIR}/po/*.po")
     ++	list(TRANSFORM po_files REPLACE "${CMAKE_SOURCE_DIR}/po/" "")
     ++	list(TRANSFORM po_files REPLACE ".po" "")
      +	foreach(po ${po_files})
      +		file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES)
      +		add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo
 3:  6ec73d3e967 ! 3:  4a0dd23cbbf cmake: installation support for git
     @@ Commit message
      
          Then run `make install`
      
     -    Changes:
     -    Removed a comment regarding the installation of gitk.
     -
          Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
      
       ## contrib/buildsystems/CMakeLists.txt ##
 4:  cdc53172b3f ! 4:  db05180e98a cmake: support for testing git with ctest
     @@ Commit message
      
          NOTE: Testing only works when building in source for now.
      
     -    Changes:
     -    Renamed the variable test_helper_sources to test-tool_SOURCES
     -    to be consistent with the naming of source variables.
     -
          Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
      
       ## contrib/buildsystems/CMakeLists.txt ##
 5:  cdc68f102cb = 5:  17e7f3e9de6 cmake: support for testing git when building out of the source tree
 6:  f41cbd43081 ! 6:  549f0cd5fff cmake: support for building git on windows with mingw
     @@ Commit message
          To use CMake on Windows with MinGW do this:
          cmake `relative-path-to-srcdir` -G "MinGW Makefiles"
      
     -    Changes:
     -    Changed the error message when sh.exe is not found on Windows as
     -    suggested by Philip Oakley <philipoakley@iee.email>
     -
     -    v2:
     -    Fixed a bug where a Windows user can pose as Linux user and vice versa.
     -
          Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
      
       ## contrib/buildsystems/CMakeLists.txt ##
 7:  8f36e30cd22 ! 7:  f85ea0ac0ca cmake: support for building git on windows with msvc and clang.
     @@ Commit message
          For Clang builds do this:
      
          On bash
     -    CC=Clang cmake `relative-path-to-srcdir` -G Ninja
     +    CC=clang cmake `relative-path-to-srcdir` -G Ninja
                          -DCMAKE_BUILD_TYPE=[Debug or Release]
      
          On cmd
 8:  bb329d16ce0 ! 8:  2f7cf41e08f ci: modification of main.yml to use cmake for vs-build job
     @@ Commit message
          FindCURL module. An extra definition (-DCURL_NO_CURL_CMAKE=ON) has been
          added to revert to the old behaviour.
      
     -    Edit(Explanation for the reordering of build steps):
          In the configuration phase CMake looks for the required libraries for
          building git (eg zlib,libiconv). So we extract the libraries before we
          configure.
     @@ Commit message
          To check for ICONV_OMITS_BOM libiconv.dll needs to be in the working
          directory of script or path. So we copy the dlls before we configure.
      
     -    Signed-off-by: Sibi Siddharthan <sibisiv.siddharthan@gmail.com>
     +    Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
      
       ## .github/workflows/main.yml ##
      @@ .github/workflows/main.yml: jobs:
     @@ .github/workflows/main.yml: jobs:
         regular:
           needs: ci-config
           if: needs.ci-config.outputs.enabled == 'yes'
     -@@ .github/workflows/main.yml: jobs:
     -     steps:
     -     - uses: actions/checkout@v1
     -     - run: ci/install-dependencies.sh
     --    - run: ci/test-documentation.sh
     -+    - run: ci/test-documentation.sh
     - \ No newline at end of file

-- 
gitgitgadget
