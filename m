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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A5AC433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F10A61100
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244336AbhIISt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244469AbhIIStA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 14:49:00 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358EEC06175F
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 11:47:50 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t18so3980993wrb.0
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 11:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ae4MHo7JtDs9a+PsJzP8Nl6SjHFhyQr11bkmy7HliXI=;
        b=q5w9pIRm7ORzTffG3wWxQHi7LFTpETcNSWmGWgwtrtQBGOB8ZfgB4u/3sF5sg4HKtY
         UehGak3aaIg8MzZ/zvz23Z1Fz07VCbHb1v6EhUsCWM0WLgsocqb5IKxNNNKFIL9QPjF2
         6euIm0JW4JVEDHt47t/NhbVr+vZ0DHbee+wy8NfIJftTf2Xun1Mt72ehDrhX7s3sa060
         L1Yk6AJne4Yut15dPj/8o88g9dCCsezqI3Z5hwhCEblT+bIl6uXB9virTAdS7AECeLD+
         hXsODKfuZr6rdS48K+eBTNSXKRcjah1U9OUGe7r0gHElgAebut1OsCCfdCpAsQZ7lGxN
         bDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ae4MHo7JtDs9a+PsJzP8Nl6SjHFhyQr11bkmy7HliXI=;
        b=c300XycNmJ1IvDNY/C/5F2DVVgP9tQzQefivo5bA9tuwptHinhC9evQijJSdILV+jG
         F3+R93R9WMsUa0dwg+BRFDvExsaGENn29Snb/+76ibvm5jg4aMasaAjzswmKqX6/3cKy
         5vSVVzwsNAL/LC1vNzdR0+VSC2Q23SiEBQjBk2koJVmPa30nxGM4VPbF3Lh0XeJ0ga+c
         bLaNNU8GfKVPQgAENeNSI4ZK8jfGkVr19uOi/UrKTydHmrDXHla6PoFIL7WPCB7YsOjr
         t9+u5lBUAUBbLFxPHjp9DMam7/9BOykCEqqR0lMv/Gj8IyuLcbj22ngY1VOocecvP5cd
         Brug==
X-Gm-Message-State: AOAM531I0vLJwDhMVvXYUflD00tlSBxFoCrrz8HigN8gWVjWIJBjXGdF
        zslhi2M7XXCLpYcNe843rN6JmuHpdu0=
X-Google-Smtp-Source: ABdhPJx9qygcU4GAjoNqQHNrr2u/6O8rnKaiCK8sXubc7UgjiWwuclXPCQe/e9DUhpasIx5+9vhuBg==
X-Received: by 2002:adf:a197:: with SMTP id u23mr5301502wru.253.1631213268732;
        Thu, 09 Sep 2021 11:47:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4sm2244312wmc.11.2021.09.09.11.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:47:48 -0700 (PDT)
Message-Id: <fa58f3d73e789e8de4edc0eb3eb93e837cfc6cfa.1631213265.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
        <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Sep 2021 18:47:29 +0000
Subject: [PATCH v2 04/19] reftable: utility functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This commit provides basic utility classes for the reftable library.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                                   |  25 +++-
 contrib/buildsystems/CMakeLists.txt        |  14 ++-
 contrib/buildsystems/Generators/Vcxproj.pm |  11 +-
 reftable/basics.c                          | 128 +++++++++++++++++++++
 reftable/basics.h                          |  60 ++++++++++
 reftable/basics_test.c                     |  98 ++++++++++++++++
 reftable/publicbasics.c                    |  58 ++++++++++
 reftable/reftable-malloc.h                 |  18 +++
 reftable/reftable-tests.h                  |  22 ++++
 reftable/system.h                          |  32 ++++++
 reftable/test_framework.c                  |  23 ++++
 reftable/test_framework.h                  |  53 +++++++++
 t/helper/test-reftable.c                   |   9 ++
 t/helper/test-tool.c                       |   3 +-
 t/helper/test-tool.h                       |   1 +
 t/t0032-reftable-unittest.sh               |  15 +++
 16 files changed, 563 insertions(+), 7 deletions(-)
 create mode 100644 reftable/basics.c
 create mode 100644 reftable/basics.h
 create mode 100644 reftable/basics_test.c
 create mode 100644 reftable/publicbasics.c
 create mode 100644 reftable/reftable-malloc.h
 create mode 100644 reftable/reftable-tests.h
 create mode 100644 reftable/system.h
 create mode 100644 reftable/test_framework.c
 create mode 100644 reftable/test_framework.h
 create mode 100644 t/helper/test-reftable.c
 create mode 100755 t/t0032-reftable-unittest.sh

diff --git a/Makefile b/Makefile
index 429c276058d..0bf5e49aa61 100644
--- a/Makefile
+++ b/Makefile
@@ -743,6 +743,7 @@ TEST_BUILTINS_OBJS += test-read-cache.o
 TEST_BUILTINS_OBJS += test-read-graph.o
 TEST_BUILTINS_OBJS += test-read-midx.o
 TEST_BUILTINS_OBJS += test-ref-store.o
+TEST_BUILTINS_OBJS += test-reftable.o
 TEST_BUILTINS_OBJS += test-regex.o
 TEST_BUILTINS_OBJS += test-repository.o
 TEST_BUILTINS_OBJS += test-revision-walking.o
@@ -821,6 +822,8 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 
 LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
+REFTABLE_LIB = reftable/libreftable.a
+REFTABLE_TEST_LIB = reftable/libreftable_test.a
 
 GENERATED_H += command-list.h
 GENERATED_H += config-list.h
@@ -1195,7 +1198,7 @@ THIRD_PARTY_SOURCES += compat/regex/%
 THIRD_PARTY_SOURCES += sha1collisiondetection/%
 THIRD_PARTY_SOURCES += sha1dc/%
 
-GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB)
+GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
 EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
@@ -2446,7 +2449,15 @@ XDIFF_OBJS += xdiff/xutils.o
 .PHONY: xdiff-objs
 xdiff-objs: $(XDIFF_OBJS)
 
+REFTABLE_OBJS += reftable/basics.o
+REFTABLE_OBJS += reftable/error.o
+REFTABLE_OBJS += reftable/publicbasics.o
+
+REFTABLE_TEST_OBJS += reftable/test_framework.o
+REFTABLE_TEST_OBJS += reftable/basics_test.o
+
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
+
 .PHONY: test-objs
 test-objs: $(TEST_OBJS)
 
@@ -2462,6 +2473,8 @@ OBJECTS += $(PROGRAM_OBJS)
 OBJECTS += $(TEST_OBJS)
 OBJECTS += $(XDIFF_OBJS)
 OBJECTS += $(FUZZ_OBJS)
+OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
+
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
 endif
@@ -2612,6 +2625,12 @@ $(LIB_FILE): $(LIB_OBJS)
 $(XDIFF_LIB): $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
+$(REFTABLE_LIB): $(REFTABLE_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
+
+$(REFTABLE_TEST_LIB): $(REFTABLE_TEST_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
+
 export DEFAULT_EDITOR DEFAULT_PAGER
 
 Documentation/GIT-EXCLUDED-PROGRAMS: FORCE
@@ -2904,7 +2923,7 @@ perf: all
 
 t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
-t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
+t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS) $(REFTABLE_TEST_LIB)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
 check-sha1:: t/helper/test-tool$X
@@ -3234,7 +3253,7 @@ cocciclean:
 clean: profile-clean coverage-clean cocciclean
 	$(RM) *.res
 	$(RM) $(OBJECTS)
-	$(RM) $(LIB_FILE) $(XDIFF_LIB)
+	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 171b4124afe..c2bf5bdffc6 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -640,6 +640,12 @@ parse_makefile_for_sources(libxdiff_SOURCES "XDIFF_OBJS")
 list(TRANSFORM libxdiff_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_library(xdiff STATIC ${libxdiff_SOURCES})
 
+#reftable
+parse_makefile_for_sources(reftable_SOURCES "REFTABLE_OBJS")
+
+list(TRANSFORM reftable_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
+add_library(reftable STATIC ${reftable_SOURCES})
+
 if(WIN32)
 	if(NOT MSVC)#use windres when compiling with gcc and clang
 		add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.res
@@ -662,7 +668,7 @@ endif()
 #link all required libraries to common-main
 add_library(common-main OBJECT ${CMAKE_SOURCE_DIR}/common-main.c)
 
-target_link_libraries(common-main libgit xdiff ${ZLIB_LIBRARIES})
+target_link_libraries(common-main libgit xdiff reftable ${ZLIB_LIBRARIES})
 if(Intl_FOUND)
 	target_link_libraries(common-main ${Intl_LIBRARIES})
 endif()
@@ -902,11 +908,15 @@ if(BUILD_TESTING)
 add_executable(test-fake-ssh ${CMAKE_SOURCE_DIR}/t/helper/test-fake-ssh.c)
 target_link_libraries(test-fake-ssh common-main)
 
+#reftable-tests
+parse_makefile_for_sources(test-reftable_SOURCES "REFTABLE_TEST_OBJS")
+list(TRANSFORM test-reftable_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
+
 #test-tool
 parse_makefile_for_sources(test-tool_SOURCES "TEST_BUILTINS_OBJS")
 
 list(TRANSFORM test-tool_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/t/helper/")
-add_executable(test-tool ${CMAKE_SOURCE_DIR}/t/helper/test-tool.c ${test-tool_SOURCES})
+add_executable(test-tool ${CMAKE_SOURCE_DIR}/t/helper/test-tool.c ${test-tool_SOURCES} ${test-reftable_SOURCES})
 target_link_libraries(test-tool common-main)
 
 set_target_properties(test-fake-ssh test-tool
diff --git a/contrib/buildsystems/Generators/Vcxproj.pm b/contrib/buildsystems/Generators/Vcxproj.pm
index d2584450ba1..1a25789d285 100644
--- a/contrib/buildsystems/Generators/Vcxproj.pm
+++ b/contrib/buildsystems/Generators/Vcxproj.pm
@@ -77,7 +77,7 @@ sub createProject {
     my $libs_release = "\n    ";
     my $libs_debug = "\n    ";
     if (!$static_library) {
-      $libs_release = join(";", sort(grep /^(?!libgit\.lib|xdiff\/lib\.lib|vcs-svn\/lib\.lib)/, @{$$build_structure{"$prefix${name}_LIBS"}}));
+      $libs_release = join(";", sort(grep /^(?!libgit\.lib|xdiff\/lib\.lib|vcs-svn\/lib\.lib|reftable\/libreftable\.lib)/, @{$$build_structure{"$prefix${name}_LIBS"}}));
       $libs_debug = $libs_release;
       $libs_debug =~ s/zlib\.lib/zlibd\.lib/g;
       $libs_debug =~ s/libexpat\.lib/libexpatd\.lib/g;
@@ -232,6 +232,7 @@ EOM
 EOM
     if (!$static_library || $target =~ 'vcs-svn' || $target =~ 'xdiff') {
       my $uuid_libgit = $$build_structure{"LIBS_libgit_GUID"};
+      my $uuid_libreftable = $$build_structure{"LIBS_reftable/libreftable_GUID"};
       my $uuid_xdiff_lib = $$build_structure{"LIBS_xdiff/lib_GUID"};
 
       print F << "EOM";
@@ -241,6 +242,14 @@ EOM
       <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
     </ProjectReference>
 EOM
+      if (!($name =~ /xdiff|libreftable/)) {
+        print F << "EOM";
+    <ProjectReference Include="$cdup\\reftable\\libreftable\\libreftable.vcxproj">
+      <Project>$uuid_libreftable</Project>
+      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
+    </ProjectReference>
+EOM
+      }
       if (!($name =~ 'xdiff')) {
         print F << "EOM";
     <ProjectReference Include="$cdup\\xdiff\\lib\\xdiff_lib.vcxproj">
diff --git a/reftable/basics.c b/reftable/basics.c
new file mode 100644
index 00000000000..f761e48028c
--- /dev/null
+++ b/reftable/basics.c
@@ -0,0 +1,128 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "basics.h"
+
+void put_be24(uint8_t *out, uint32_t i)
+{
+	out[0] = (uint8_t)((i >> 16) & 0xff);
+	out[1] = (uint8_t)((i >> 8) & 0xff);
+	out[2] = (uint8_t)(i & 0xff);
+}
+
+uint32_t get_be24(uint8_t *in)
+{
+	return (uint32_t)(in[0]) << 16 | (uint32_t)(in[1]) << 8 |
+	       (uint32_t)(in[2]);
+}
+
+void put_be16(uint8_t *out, uint16_t i)
+{
+	out[0] = (uint8_t)((i >> 8) & 0xff);
+	out[1] = (uint8_t)(i & 0xff);
+}
+
+int binsearch(size_t sz, int (*f)(size_t k, void *args), void *args)
+{
+	size_t lo = 0;
+	size_t hi = sz;
+
+	/* Invariants:
+	 *
+	 *  (hi == sz) || f(hi) == true
+	 *  (lo == 0 && f(0) == true) || fi(lo) == false
+	 */
+	while (hi - lo > 1) {
+		size_t mid = lo + (hi - lo) / 2;
+
+		if (f(mid, args))
+			hi = mid;
+		else
+			lo = mid;
+	}
+
+	if (lo)
+		return hi;
+
+	return f(0, args) ? 0 : 1;
+}
+
+void free_names(char **a)
+{
+	char **p;
+	if (!a) {
+		return;
+	}
+	for (p = a; *p; p++) {
+		reftable_free(*p);
+	}
+	reftable_free(a);
+}
+
+int names_length(char **names)
+{
+	char **p = names;
+	for (; *p; p++) {
+		/* empty */
+	}
+	return p - names;
+}
+
+void parse_names(char *buf, int size, char ***namesp)
+{
+	char **names = NULL;
+	size_t names_cap = 0;
+	size_t names_len = 0;
+
+	char *p = buf;
+	char *end = buf + size;
+	while (p < end) {
+		char *next = strchr(p, '\n');
+		if (next && next < end) {
+			*next = 0;
+		} else {
+			next = end;
+		}
+		if (p < next) {
+			if (names_len == names_cap) {
+				names_cap = 2 * names_cap + 1;
+				names = reftable_realloc(
+					names, names_cap * sizeof(*names));
+			}
+			names[names_len++] = xstrdup(p);
+		}
+		p = next + 1;
+	}
+
+	names = reftable_realloc(names, (names_len + 1) * sizeof(*names));
+	names[names_len] = NULL;
+	*namesp = names;
+}
+
+int names_equal(char **a, char **b)
+{
+	int i = 0;
+	for (; a[i] && b[i]; i++) {
+		if (strcmp(a[i], b[i])) {
+			return 0;
+		}
+	}
+
+	return a[i] == b[i];
+}
+
+int common_prefix_size(struct strbuf *a, struct strbuf *b)
+{
+	int p = 0;
+	for (; p < a->len && p < b->len; p++) {
+		if (a->buf[p] != b->buf[p])
+			break;
+	}
+
+	return p;
+}
diff --git a/reftable/basics.h b/reftable/basics.h
new file mode 100644
index 00000000000..096b36862b9
--- /dev/null
+++ b/reftable/basics.h
@@ -0,0 +1,60 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef BASICS_H
+#define BASICS_H
+
+/*
+ * miscellaneous utilities that are not provided by Git.
+ */
+
+#include "system.h"
+
+/* Bigendian en/decoding of integers */
+
+void put_be24(uint8_t *out, uint32_t i);
+uint32_t get_be24(uint8_t *in);
+void put_be16(uint8_t *out, uint16_t i);
+
+/*
+ * find smallest index i in [0, sz) at which f(i) is true, assuming
+ * that f is ascending. Return sz if f(i) is false for all indices.
+ *
+ * Contrary to bsearch(3), this returns something useful if the argument is not
+ * found.
+ */
+int binsearch(size_t sz, int (*f)(size_t k, void *args), void *args);
+
+/*
+ * Frees a NULL terminated array of malloced strings. The array itself is also
+ * freed.
+ */
+void free_names(char **a);
+
+/* parse a newline separated list of names. `size` is the length of the buffer,
+ * without terminating '\0'. Empty names are discarded. */
+void parse_names(char *buf, int size, char ***namesp);
+
+/* compares two NULL-terminated arrays of strings. */
+int names_equal(char **a, char **b);
+
+/* returns the array size of a NULL-terminated array of strings. */
+int names_length(char **names);
+
+/* Allocation routines; they invoke the functions set through
+ * reftable_set_alloc() */
+void *reftable_malloc(size_t sz);
+void *reftable_realloc(void *p, size_t sz);
+void reftable_free(void *p);
+void *reftable_calloc(size_t sz);
+
+/* Find the longest shared prefix size of `a` and `b` */
+struct strbuf;
+int common_prefix_size(struct strbuf *a, struct strbuf *b);
+
+#endif
diff --git a/reftable/basics_test.c b/reftable/basics_test.c
new file mode 100644
index 00000000000..1fcd2297256
--- /dev/null
+++ b/reftable/basics_test.c
@@ -0,0 +1,98 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "system.h"
+
+#include "basics.h"
+#include "test_framework.h"
+#include "reftable-tests.h"
+
+struct binsearch_args {
+	int key;
+	int *arr;
+};
+
+static int binsearch_func(size_t i, void *void_args)
+{
+	struct binsearch_args *args = void_args;
+
+	return args->key < args->arr[i];
+}
+
+static void test_binsearch(void)
+{
+	int arr[] = { 2, 4, 6, 8, 10 };
+	size_t sz = ARRAY_SIZE(arr);
+	struct binsearch_args args = {
+		.arr = arr,
+	};
+
+	int i = 0;
+	for (i = 1; i < 11; i++) {
+		int res;
+		args.key = i;
+		res = binsearch(sz, &binsearch_func, &args);
+
+		if (res < sz) {
+			EXPECT(args.key < arr[res]);
+			if (res > 0) {
+				EXPECT(args.key >= arr[res - 1]);
+			}
+		} else {
+			EXPECT(args.key == 10 || args.key == 11);
+		}
+	}
+}
+
+static void test_names_length(void)
+{
+	char *a[] = { "a", "b", NULL };
+	EXPECT(names_length(a) == 2);
+}
+
+static void test_parse_names_normal(void)
+{
+	char in[] = "a\nb\n";
+	char **out = NULL;
+	parse_names(in, strlen(in), &out);
+	EXPECT(!strcmp(out[0], "a"));
+	EXPECT(!strcmp(out[1], "b"));
+	EXPECT(!out[2]);
+	free_names(out);
+}
+
+static void test_parse_names_drop_empty(void)
+{
+	char in[] = "a\n\n";
+	char **out = NULL;
+	parse_names(in, strlen(in), &out);
+	EXPECT(!strcmp(out[0], "a"));
+	EXPECT(!out[1]);
+	free_names(out);
+}
+
+static void test_common_prefix(void)
+{
+	struct strbuf s1 = STRBUF_INIT;
+	struct strbuf s2 = STRBUF_INIT;
+	strbuf_addstr(&s1, "abcdef");
+	strbuf_addstr(&s2, "abc");
+	EXPECT(common_prefix_size(&s1, &s2) == 3);
+	strbuf_release(&s1);
+	strbuf_release(&s2);
+}
+
+int basics_test_main(int argc, const char *argv[])
+{
+	RUN_TEST(test_common_prefix);
+	RUN_TEST(test_parse_names_normal);
+	RUN_TEST(test_parse_names_drop_empty);
+	RUN_TEST(test_binsearch);
+	RUN_TEST(test_names_length);
+	return 0;
+}
diff --git a/reftable/publicbasics.c b/reftable/publicbasics.c
new file mode 100644
index 00000000000..bd0a02d3f68
--- /dev/null
+++ b/reftable/publicbasics.c
@@ -0,0 +1,58 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "reftable-malloc.h"
+
+#include "basics.h"
+#include "system.h"
+
+static void *(*reftable_malloc_ptr)(size_t sz) = &malloc;
+static void *(*reftable_realloc_ptr)(void *, size_t) = &realloc;
+static void (*reftable_free_ptr)(void *) = &free;
+
+void *reftable_malloc(size_t sz)
+{
+	return (*reftable_malloc_ptr)(sz);
+}
+
+void *reftable_realloc(void *p, size_t sz)
+{
+	return (*reftable_realloc_ptr)(p, sz);
+}
+
+void reftable_free(void *p)
+{
+	reftable_free_ptr(p);
+}
+
+void *reftable_calloc(size_t sz)
+{
+	void *p = reftable_malloc(sz);
+	memset(p, 0, sz);
+	return p;
+}
+
+void reftable_set_alloc(void *(*malloc)(size_t),
+			void *(*realloc)(void *, size_t), void (*free)(void *))
+{
+	reftable_malloc_ptr = malloc;
+	reftable_realloc_ptr = realloc;
+	reftable_free_ptr = free;
+}
+
+int hash_size(uint32_t id)
+{
+	switch (id) {
+	case 0:
+	case GIT_SHA1_FORMAT_ID:
+		return GIT_SHA1_RAWSZ;
+	case GIT_SHA256_FORMAT_ID:
+		return GIT_SHA256_RAWSZ;
+	}
+	abort();
+}
diff --git a/reftable/reftable-malloc.h b/reftable/reftable-malloc.h
new file mode 100644
index 00000000000..5f2185f1f34
--- /dev/null
+++ b/reftable/reftable-malloc.h
@@ -0,0 +1,18 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef REFTABLE_H
+#define REFTABLE_H
+
+#include <stddef.h>
+
+/* Overrides the functions to use for memory management. */
+void reftable_set_alloc(void *(*malloc)(size_t),
+			void *(*realloc)(void *, size_t), void (*free)(void *));
+
+#endif
diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
new file mode 100644
index 00000000000..5e7698ae654
--- /dev/null
+++ b/reftable/reftable-tests.h
@@ -0,0 +1,22 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef REFTABLE_TESTS_H
+#define REFTABLE_TESTS_H
+
+int basics_test_main(int argc, const char **argv);
+int block_test_main(int argc, const char **argv);
+int merged_test_main(int argc, const char **argv);
+int record_test_main(int argc, const char **argv);
+int refname_test_main(int argc, const char **argv);
+int reftable_test_main(int argc, const char **argv);
+int stack_test_main(int argc, const char **argv);
+int tree_test_main(int argc, const char **argv);
+int reftable_dump_main(int argc, char *const *argv);
+
+#endif
diff --git a/reftable/system.h b/reftable/system.h
new file mode 100644
index 00000000000..4907306c0c5
--- /dev/null
+++ b/reftable/system.h
@@ -0,0 +1,32 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef SYSTEM_H
+#define SYSTEM_H
+
+/* This header glues the reftable library to the rest of Git */
+
+#include "git-compat-util.h"
+#include "strbuf.h"
+#include "hash.h" /* hash ID, sizes.*/
+#include "dir.h" /* remove_dir_recursively, for tests.*/
+
+#include <zlib.h>
+
+#ifdef NO_UNCOMPRESS2
+/*
+ * This is uncompress2, which is only available in zlib >= 1.2.9
+ * (released as of early 2017)
+ */
+int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
+		uLong *sourceLen);
+#endif
+
+int hash_size(uint32_t id);
+
+#endif
diff --git a/reftable/test_framework.c b/reftable/test_framework.c
new file mode 100644
index 00000000000..84ac972cad0
--- /dev/null
+++ b/reftable/test_framework.c
@@ -0,0 +1,23 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "system.h"
+#include "test_framework.h"
+
+#include "basics.h"
+
+void set_test_hash(uint8_t *p, int i)
+{
+	memset(p, (uint8_t)i, hash_size(GIT_SHA1_FORMAT_ID));
+}
+
+ssize_t strbuf_add_void(void *b, const void *data, size_t sz)
+{
+	strbuf_add(b, data, sz);
+	return sz;
+}
diff --git a/reftable/test_framework.h b/reftable/test_framework.h
new file mode 100644
index 00000000000..774cb275bf6
--- /dev/null
+++ b/reftable/test_framework.h
@@ -0,0 +1,53 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef TEST_FRAMEWORK_H
+#define TEST_FRAMEWORK_H
+
+#include "system.h"
+#include "reftable-error.h"
+
+#define EXPECT_ERR(c)                                                  \
+	if (c != 0) {                                                  \
+		fflush(stderr);                                        \
+		fflush(stdout);                                        \
+		fprintf(stderr, "%s: %d: error == %d (%s), want 0\n",  \
+			__FILE__, __LINE__, c, reftable_error_str(c)); \
+		abort();                                               \
+	}
+
+#define EXPECT_STREQ(a, b)                                               \
+	if (strcmp(a, b)) {                                              \
+		fflush(stderr);                                          \
+		fflush(stdout);                                          \
+		fprintf(stderr, "%s:%d: %s (%s) != %s (%s)\n", __FILE__, \
+			__LINE__, #a, a, #b, b);                         \
+		abort();                                                 \
+	}
+
+#define EXPECT(c)                                                          \
+	if (!(c)) {                                                        \
+		fflush(stderr);                                            \
+		fflush(stdout);                                            \
+		fprintf(stderr, "%s: %d: failed assertion %s\n", __FILE__, \
+			__LINE__, #c);                                     \
+		abort();                                                   \
+	}
+
+#define RUN_TEST(f)                          \
+	fprintf(stderr, "running %s\n", #f); \
+	fflush(stderr);                      \
+	f();
+
+void set_test_hash(uint8_t *p, int i);
+
+/* Like strbuf_add, but suitable for passing to reftable_new_writer
+ */
+ssize_t strbuf_add_void(void *b, const void *data, size_t sz);
+
+#endif
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
new file mode 100644
index 00000000000..3b58e423e7b
--- /dev/null
+++ b/t/helper/test-reftable.c
@@ -0,0 +1,9 @@
+#include "reftable/reftable-tests.h"
+#include "test-tool.h"
+
+int cmd__reftable(int argc, const char **argv)
+{
+	basics_test_main(argc, argv);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 3ce5585e53a..f7c888ffda7 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -53,13 +53,14 @@ static struct test_cmd cmds[] = {
 	{ "pcre2-config", cmd__pcre2_config },
 	{ "pkt-line", cmd__pkt_line },
 	{ "prio-queue", cmd__prio_queue },
-	{ "proc-receive", cmd__proc_receive},
+	{ "proc-receive", cmd__proc_receive },
 	{ "progress", cmd__progress },
 	{ "reach", cmd__reach },
 	{ "read-cache", cmd__read_cache },
 	{ "read-graph", cmd__read_graph },
 	{ "read-midx", cmd__read_midx },
 	{ "ref-store", cmd__ref_store },
+	{ "reftable", cmd__reftable },
 	{ "regex", cmd__regex },
 	{ "repository", cmd__repository },
 	{ "revision-walking", cmd__revision_walking },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 9f0f5228508..25f77469146 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -49,6 +49,7 @@ int cmd__read_cache(int argc, const char **argv);
 int cmd__read_graph(int argc, const char **argv);
 int cmd__read_midx(int argc, const char **argv);
 int cmd__ref_store(int argc, const char **argv);
+int cmd__reftable(int argc, const char **argv);
 int cmd__regex(int argc, const char **argv);
 int cmd__repository(int argc, const char **argv);
 int cmd__revision_walking(int argc, const char **argv);
diff --git a/t/t0032-reftable-unittest.sh b/t/t0032-reftable-unittest.sh
new file mode 100755
index 00000000000..0ed14971a58
--- /dev/null
+++ b/t/t0032-reftable-unittest.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+#
+# Copyright (c) 2020 Google LLC
+#
+
+test_description='reftable unittests'
+
+. ./test-lib.sh
+
+test_expect_success 'unittests' '
+	TMPDIR=$(pwd) && export TMPDIR &&
+	test-tool reftable
+'
+
+test_done
-- 
gitgitgadget

