Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9ABC2D0F9
	for <git@archiver.kernel.org>; Tue, 12 May 2020 16:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0724E206B9
	for <git@archiver.kernel.org>; Tue, 12 May 2020 16:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSHr2r2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgELQvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 12:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbgELQvD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 12:51:03 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F09C05BD09
        for <git@vger.kernel.org>; Tue, 12 May 2020 09:51:01 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n5so9345429wmd.0
        for <git@vger.kernel.org>; Tue, 12 May 2020 09:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kttkqlVYNcry8k3gDCD/wP9gF/WIzWs8BbeiQqCRuEc=;
        b=mSHr2r2OBB3sucBaJwxWO6u0vATtWL/47R+4AZmE3aE8wPFl2TJzLdWZNatMKnWNDa
         0EgVlYDPiz9BkDQM59K5Bx1UixYvnd2aOsLAEBqbc398Cjf1nh95M08w+XkV/oeFObId
         awP7fhsKdb2ptGMxJb3Yqzf1fg1IGaNAvVdJqJ3KdI+yJgNo1EXgN6gergXGzRURvsXE
         CsFJLxix3yCJN1fK1ZNi4ztkCBzZ9184PVu0FI9CBFr6UbmpZJu0wDXikLtxJQiBTJFt
         ibW3PJtrjMtAR6i6Dh5ELDq2wRIaUwQGQlb2u69ilB1FEOQAbAr9XlIgrqFjZWdRMQsb
         ARaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kttkqlVYNcry8k3gDCD/wP9gF/WIzWs8BbeiQqCRuEc=;
        b=dgcWvtXUbo3VTXWoZkpzM69RGnBS+4M+SWud8MA5PVZENmIeIMupv1YqDQpTitKrU7
         nDPzb6Q0YWAuyuGwPS7dltAmw0g2iJ7WieasPxOdAL38CKajYKsJAIMoi6bDaGxv/Y+J
         kmoeGVu/DlXiLVdVh+ZQoH6BzMW+yoCyMiumSKOJKr5diCZyzZrZWItDs1wA2I7fnH4e
         eJE4L55QW9hZRqUlkpMBWHzqjdzb/s+XIA5gJ3QhiBabVRKnEN6e7kus/S81LU4PXO3f
         eaZ24sQw3kDEkqhxO0C1W9IWll0qUV6sxFUW7MvJGOpIdlEphHLMDx1T4zQQFlXcOEAk
         BNNQ==
X-Gm-Message-State: AGi0PuYiV/GA8dNPhFC0QoG9r2ayc+RgpBhvikMu/81TF59Sb+LZ9S+5
        CxFUnDp3tFTkw4y0j+YHAkc8NG9s
X-Google-Smtp-Source: APiQypKd1xxljLnbj/oSQ+VSlpjXXSPqj96BZvDnjpZMO2kpjjOkaEQRsnRLW8A88vKlyF/wKfr2aA==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr10864339wmf.8.1589302260005;
        Tue, 12 May 2020 09:51:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 1sm32556135wmz.13.2020.05.12.09.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 09:50:59 -0700 (PDT)
Message-Id: <2bd8870fb96a5c032108c84db2f8a79c69053644.1589302254.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 May 2020 16:50:47 +0000
Subject: [PATCH v2 04/11] cmake: support for testing git with ctest
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>

This patch provides an alternate way to test git using ctest.
CTest ships with CMake, so there is no additional dependency being
introduced.

To perform the tests with ctest do this after building:
ctest -j[number of jobs]

NOTE: -j is optional, the default number of jobs is 1

Each of the jobs does this:
cd t/ && sh t[something].sh

The reason for using CTest is that it logs the output of the tests
in a neat way, which can be helpful during diagnosis of failures.

After the tests have run ctest generates three log files located in
`build-directory`/Testing/Temporary/

These log files are:

CTestCostData.txt:
This file contains the time taken to complete each test.

LastTestsFailed.log:
This log file contains the names of the tests that have failed in the
run.

LastTest.log:
This log file contains the log of all the tests that have run.
A snippet of the file is given below.

10/901 Testing: D:/my/git-master/t/t0009-prio-queue.sh
10/901 Test: D:/my/git-master/t/t0009-prio-queue.sh
Command: "sh.exe" "D:/my/git-master/t/t0009-prio-queue.sh"
Directory: D:/my/git-master/t
"D:/my/git-master/t/t0009-prio-queue.sh"
Output:
----------------------------------------------------------
ok 1 - basic ordering
ok 2 - mixed put and get
ok 3 - notice empty queue
ok 4 - stack order
passed all 4 test(s)
1..4
<end of output>
Test time =   1.11 sec

NOTE: Testing only works when building in source for now.

Changes:
Renamed the variable test_helper_sources to test-tool_SOURCES
to be consistent with the naming of source variables.

Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
---
 CMakeLists.txt | 142 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 1e9f2fe8ff6..05fbb05c6ad 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -23,6 +23,7 @@ include(CheckIncludeFile)
 include(CheckFunctionExists)
 include(CheckSymbolExists)
 include(CheckStructHasMember)
+include(CTest)
 
 find_package(ZLIB REQUIRED)
 find_package(CURL)
@@ -680,3 +681,144 @@ install(DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/ DESTINATION share/git-core/
 if(MSGFMT_EXE)
 	install(DIRECTORY ${CMAKE_BINARY_DIR}/po/build/locale DESTINATION share)
 endif()
+
+
+if(BUILD_TESTING)
+
+#tests-helpers
+add_executable(test-fake-ssh t/helper/test-fake-ssh.c)
+target_link_libraries(test-fake-ssh common-main)
+
+add_executable(test-line-buffer t/helper/test-line-buffer.c)
+target_link_libraries(test-line-buffer common-main vcs-svn)
+
+add_executable(test-svn-fe t/helper/test-svn-fe.c)
+target_link_libraries(test-svn-fe common-main vcs-svn)
+
+set(test-tool_SOURCES
+	t/helper/test-tool.c t/helper/test-advise.c t/helper/test-bloom.c t/helper/test-chmtime.c
+	t/helper/test-config.c t/helper/test-ctype.c t/helper/test-date.c t/helper/test-delta.c
+	t/helper/test-dir-iterator.c t/helper/test-drop-caches.c t/helper/test-dump-cache-tree.c
+	t/helper/test-dump-fsmonitor.c t/helper/test-dump-split-index.c
+	t/helper/test-dump-untracked-cache.c t/helper/test-example-decorate.c
+	t/helper/test-genrandom.c t/helper/test-genzeros.c t/helper/test-hash.c
+	t/helper/test-hashmap.c t/helper/test-hash-speed.c t/helper/test-index-version.c
+	t/helper/test-json-writer.c t/helper/test-lazy-init-name-hash.c
+	t/helper/test-match-trees.c t/helper/test-mergesort.c t/helper/test-mktemp.c
+	t/helper/test-oidmap.c t/helper/test-online-cpus.c t/helper/test-parse-options.c
+	t/helper/test-parse-pathspec-file.c t/helper/test-path-utils.c t/helper/test-pkt-line.c
+	t/helper/test-prio-queue.c t/helper/test-progress.c t/helper/test-reach.c
+	t/helper/test-read-cache.c t/helper/test-read-graph.c t/helper/test-read-midx.c
+	t/helper/test-ref-store.c t/helper/test-regex.c t/helper/test-repository.c
+	t/helper/test-revision-walking.c t/helper/test-run-command.c t/helper/test-scrap-cache-tree.c
+	t/helper/test-serve-v2.c t/helper/test-sha1.c t/helper/test-oid-array.c t/helper/test-sha256.c
+	t/helper/test-sigchain.c t/helper/test-strcmp-offset.c t/helper/test-string-list.c
+	t/helper/test-submodule-config.c t/helper/test-submodule-nested-repo-config.c t/helper/test-subprocess.c
+	t/helper/test-trace2.c t/helper/test-urlmatch-normalization.c t/helper/test-xml-encode.c
+	t/helper/test-wildmatch.c t/helper/test-windows-named-pipe.c t/helper/test-write-cache.c)
+
+add_executable(test-tool ${test-tool_SOURCES})
+target_link_libraries(test-tool common-main)
+
+set_target_properties(test-fake-ssh test-line-buffer test-svn-fe test-tool
+			PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/t/helper)
+
+#wrapper scripts
+set(wrapper_scripts
+	git git-upload-pack git-receive-pack git-upload-archive git-shell git-remote-ext)
+
+set(wrapper_test_scripts
+	test-fake-ssh test-line-buffer test-svn-fe test-tool)
+
+
+foreach(script ${wrapper_scripts})
+	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
+	string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
+	string(REPLACE "@@PROG@@" "${script}" content "${content}")
+	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
+endforeach()
+
+foreach(script ${wrapper_test_scripts})
+	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
+	string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
+	string(REPLACE "@@PROG@@" "t/helper/${script}" content "${content}")
+	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
+endforeach()
+
+file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
+string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
+string(REPLACE "@@PROG@@" "git-cvsserver" content "${content}")
+file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/git-cvsserver ${content})
+
+#options for configuring test options
+option(PERL_TESTS "Perform tests that use perl" ON)
+option(PYTHON_TESTS "Perform tests that use python" ON)
+
+#GIT-BUILD-OPTIONS
+set(TEST_SHELL_PATH ${SHELL_PATH})
+set(DIFF diff)
+set(PYTHON_PATH /usr/bin/python)
+set(TAR tar)
+set(NO_CURL )
+set(NO_EXPAT )
+set(USE_LIBPCRE1 )
+set(USE_LIBPCRE2 )
+set(NO_LIBPCRE1_JIT )
+set(NO_PERL )
+set(NO_PTHREADS )
+set(NO_PYTHON )
+set(PAGER_ENV "LESS=FRX LV=-c")
+set(DC_SHA1 YesPlease)
+set(RUNTIME_PREFIX true)
+set(NO_GETTEXT )
+
+if(NOT CURL_FOUND)
+	set(NO_CURL 1)
+endif()
+
+if(NOT EXPAT_FOUND)
+	set(NO_EXPAT 1)
+endif()
+
+if(NOT Intl_FOUND)
+	set(NO_GETTEXT 1)
+endif()
+
+if(NOT PERL_TESTS)
+	set(NO_PERL 1)
+endif()
+
+if(NOT PYTHON_TESTS)
+	set(NO_PYTHON 1)
+endif()
+
+file(WRITE ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "SHELL_PATH='${SHELL_PATH}'\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "TEST_SHELL_PATH='${TEST_SHELL_PATH}'\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PERL_PATH='${PERL_PATH}'\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "DIFF='${DIFF}'\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PYTHON_PATH='${PYTHON_PATH}'\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "TAR='${TAR}'\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_CURL='${NO_CURL}'\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_EXPAT='${NO_EXPAT}'\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "USE_LIBPCRE1='${USE_LIBPCRE1}'\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_LIBPCRE1_JIT='${NO_LIBPCRE1_JIT}'\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PERL='${NO_PERL}'\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PTHREADS='${NO_PTHREADS}'\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_UNIX_SOCKETS='${NO_UNIX_SOCKETS}'\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PAGER_ENV='${PAGER_ENV}'\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "DC_SHA1='${DC_SHA1}'\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "X=''\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "RUNTIME_PREFIX='${RUNTIME_PREFIX}'\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PYTHON='${NO_PYTHON}'\n")
+
+file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
+
+#test
+foreach(tsh ${test_scipts})
+	add_test(NAME ${tsh}
+		COMMAND ${SH_EXE} ${tsh}
+		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
+endforeach()
+
+endif()#BUILD_TESTING
\ No newline at end of file
-- 
gitgitgadget

