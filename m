Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3934EC433E2
	for <git@archiver.kernel.org>; Fri, 29 May 2020 13:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 145FA206E2
	for <git@archiver.kernel.org>; Fri, 29 May 2020 13:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRPG9fHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgE2Nke (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 09:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgE2Nkb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 09:40:31 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD86EC03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 06:40:30 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r7so3711572wro.1
        for <git@vger.kernel.org>; Fri, 29 May 2020 06:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iPdJHPPwp9ESA4pKPEUgZPvxABcaPcm1YcFWNUgoLcs=;
        b=VRPG9fHWlCp0OU+dEcH5U9/6NI82RowgUaHzFa5oR86+weNY6/Jan3gPiNAsENFDmt
         R9EoRGQQ3KxYt2RWakSFxaf3TF+Xu4WykbETPqzlOWW6bcfIJnX8rtrKYg+lTbtdnpbh
         +eYbv0i8/oPPgmHxRBCke09Db08cL8AzfRpuj9OP5S0MVT5KrQ9lqrPAeEqMJ+nh4OsZ
         CR9CH+9HKFzKCVkMr0OtCuXR3uOVaZl4Wt8mzdNkTdFNwIDRTIFTUNDI5RpROcEV6ex4
         9Ug/zk+zmoPzzr0ikGFEPDeoBQbNHfdvlgkGbZFqACDy8bJUOUKrznj182YBDCn682pz
         rh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iPdJHPPwp9ESA4pKPEUgZPvxABcaPcm1YcFWNUgoLcs=;
        b=AZ8tCiNsWQAFXty8cvqIClSIvsu8TJjhjWe+FjccHjKfh5pPxJunGsG7t1hTqiV2Rg
         frw2BN912DZf0ETxhZBW5S0N85UiFrr4cDO2HjxYwggigr8ejPMqKo5ob/FHXtLCD1/2
         Oda/6iC9sCGziJOViWZocd2sDyYfZWV42bTCRu0ePAsTwQpgtwBoisKFr4fcPEr8D10L
         73/VA6JTLhaDlzdumGHU2jiH6lMMk9vCfChoR3mpe0OvDl2FwKVsQFzaMB+dK5jqHzm3
         ZPlYUwz3ISXSQeDDQrlpgeCngB7JjE1M4xifFoeti58xVlVUrUOZnbznPD3tWqDM515G
         2BKg==
X-Gm-Message-State: AOAM5315pfrHwS13xhblMz6W1rH3ZcgnjFhMFHV79lPsSBewZFe0c2+/
        gMX0R26NspoYRd3AfPsiSyblxZkZ
X-Google-Smtp-Source: ABdhPJwjn5M/RnCYqgsOB58DbEQQNzmaEln/TVSi8DKiqLIFhnFKDuAFUtJSBw3v7VfP3CTMp0avCg==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr8832333wru.68.1590759629134;
        Fri, 29 May 2020 06:40:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h20sm11277723wma.6.2020.05.29.06.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 06:40:28 -0700 (PDT)
Message-Id: <cdc53172b3f073095911fe9f7f5ff8ea6546013c.1590759624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
        <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 May 2020 13:40:20 +0000
Subject: [PATCH v3 4/8] cmake: support for testing git with ctest
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
 contrib/buildsystems/CMakeLists.txt | 124 ++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 0cde1a02cbc..33a3559eb8c 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -86,6 +86,7 @@ include(CheckIncludeFile)
 include(CheckFunctionExists)
 include(CheckSymbolExists)
 include(CheckStructHasMember)
+include(CTest)
 
 find_package(ZLIB REQUIRED)
 find_package(CURL)
@@ -731,3 +732,126 @@ install(DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/ DESTINATION share/git-core/
 if(MSGFMT_EXE)
 	install(DIRECTORY ${CMAKE_BINARY_DIR}/po/build/locale DESTINATION share)
 endif()
+
+
+if(BUILD_TESTING)
+
+#tests-helpers
+add_executable(test-fake-ssh ${CMAKE_SOURCE_DIR}/t/helper/test-fake-ssh.c)
+target_link_libraries(test-fake-ssh common-main)
+
+add_executable(test-line-buffer ${CMAKE_SOURCE_DIR}/t/helper/test-line-buffer.c)
+target_link_libraries(test-line-buffer common-main vcs-svn)
+
+add_executable(test-svn-fe ${CMAKE_SOURCE_DIR}/t/helper/test-svn-fe.c)
+target_link_libraries(test-svn-fe common-main vcs-svn)
+
+#test-tool
+parse_makefile_for_sources(test-tool_SOURCES "TEST_BUILTINS_OBJS")
+
+list(TRANSFORM test-tool_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/t/helper/")
+add_executable(test-tool ${CMAKE_SOURCE_DIR}/t/helper/test-tool.c ${test-tool_SOURCES})
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
-- 
gitgitgadget

