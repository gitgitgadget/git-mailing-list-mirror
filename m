Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F1AC47089
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 02:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbiLFCJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 21:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbiLFCJf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 21:09:35 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DBA240A4
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 18:09:34 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id gh17so2815969ejb.6
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 18:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uChl/FJABHgCcYWfJkYu98IH8LraNbjrk8zuXimDxg4=;
        b=UxyVny6vecuTPYcCI+6rK5Jatts5SfbAlZsjLuaGvfOPwuqXsdYScY06717PPk8oHi
         789BQh8Zgovb17g6WYS8uD505rOOn97coTS02KsWoRj4HesWE6ZAr40KYV/x0X3DmNTu
         RvyPr1/eYyGD0JAeWBOBp5R7fNnBEo/DrPGLFEMPMuMRMFVYrJcnbzAT+m0+jgmXgV2e
         HvuHzJzxVZcrOkci+j7DpeMIWWt9gm4w2uvNTu+WAHi+OigYC/aMNRG2k6KaymzZdeiB
         MIwL8CcEQNd36TaWpLiBicaiSaciQt/P4DztQSQ3rW35IVwajnRMcyrvMgPsCWqWN2GF
         TacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uChl/FJABHgCcYWfJkYu98IH8LraNbjrk8zuXimDxg4=;
        b=v2ryrx9WM6FJ8Y+myA5v16XaUnpqb6Zagz6pQ6Bt7L7SwKJREJY7JqC0anv9rcpFbP
         jnvzZGyZS+DRmWHFqkCOvojnbEpm7JJECgTOwS40jkMrLkDbpyhDz9kfQbMI1un9wrBU
         JPOw49tmx7IAzvWOt/DiZ+tVaUQw+XEuWm1jClbamr2m/5BbxKESIPoiNq1p6oOkmc0C
         mKrWupmlZNKzhg4MlxaEeRDZTg3HsZ4KNNcMHBMKnEmZ1OV0c3mT9SboVBzVsSQMm99u
         dcmA2Kc1D6jCiSxJj+kS9S5F/WegXUPpv69yWdHkF4q5ORwthu5a+BZdEEt30kTTJkcp
         Rleg==
X-Gm-Message-State: ANoB5pmuhzdw5s1CpwHqDFd7uRbSILF9XBaNj1FuqxoY9R6rsML2vfC3
        lkWUaZguOKOaENgoGEjDxGw2lGDVo6T2hw==
X-Google-Smtp-Source: AA0mqf4dazbGQqusT99XIbMSLGp2+lKAE6oNLmUVV5q6hoB2CODgXSTmQTmUKtJ7PJ9cwvAHK0PBxA==
X-Received: by 2002:a17:906:b103:b0:7c0:9a2e:2840 with SMTP id u3-20020a170906b10300b007c09a2e2840mr22940636ejy.404.1670292572528;
        Mon, 05 Dec 2022 18:09:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b007c099174a12sm6966186ejm.178.2022.12.05.18.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:09:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 05/15] cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
Date:   Tue,  6 Dec 2022 03:09:03 +0100
Message-Id: <patch-v6-05.15-82ecb797915-20221206T001617Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.1006.gb4c675778ba
In-Reply-To: <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
References: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com> <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the cmake file was made to run on *nix in [1] running the tests
with "ctest" broken, because we'd attempt to invoke our bin-wrappers/,
but they didn't have the executable bit.

In the best case, the "t/test-lib.sh" would be unable to find
"bin-wrappers/git", and we'd fall back on
"GIT_EXEC_PATH=$GIT_BUILD_DIR" using the fallback behavior added in
[2]:

	$ ./t0001-init.sh
	<GIT_BUILD_DIR>/t/../contrib/buildsystems/out/bin-wrappers/git is not executable; using GIT_EXEC_PATH

This was recently somewhat swept under the rug in [3], as ctest would
run them with "--no-bin-wrappers". But still with [3], running e.g.:

	cmake -S contrib/buildsystems -B contrib/buildsystems/out -DCMAKE_BUILD_TYPE=Debug &&
	make -C contrib/buildsystems/out &&
	ctest --test-dir contrib/buildsystems/out --jobs="$(nproc)" --output-on-failure

Fails around 20% of our tests on *nix. So even with [3] we'd fail any
test that needed to invoke one of our built shell, perl or Python
scripts on *nix. E.g. t0012-help.sh would fail on a test that tried to
invoke "git web--browse". The equivalent of this (in the "out"
directory) would happen:

	$ ./git --exec-path=$PWD web--browse
	git: 'web--browse' is not a git command. See 'git --help'.

Which we can fix by "chmod +x"-ing the built "git-web--browse":

	$ chmod +x git-web--browse
	$ ./git --exec-path=$PWD web--browse
	usage: git web--browse [--browser=browser|--tool=browser] [--config=conf.var] url/file ...

The same goes for e.g. the "git-p4" tests, which would fail because
our built "git-p4" wasn't executable, etc. There's also a few other
outstanding issues, which will be fixed in subsequent commits.

Ideally we'd use the file(CHMOD ...) form everywhere, but that syntax
was introduced in cmake 3.19[4], whereas we only require 3.14. Let's
provide a fallback behind a version check, so that we'll eventually be
able to delete the "else" part. Both forms result in the same file
modes.

Before this change:

	80% tests passed, 196 tests failed out of 977

After:

	99% tests passed, 5 tests failed out of 977

The remaining failures will be addressed in subsequent commits.

As this isn't needed on Windows let's skip this there. There's also an
unconfirmed (it works in CI) report[5] that invoking the "chmod"
command fails in some scenarios.

1. f31b6244950 (Merge branch 'yw/cmake-updates', 2022-06-07)
2. e4597aae659 (run test suite without dashed git-commands in PATH, 2009-12-02)
3. 2ea1d8b5563 (cmake: make it easier to diagnose regressions in CTest
   runs, 2022-10-18)
4. https://cmake.org/cmake/help/latest/command/file.html#chmod
5. https://lore.kernel.org/git/87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

write script
---
 contrib/buildsystems/CMakeLists.txt | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index c641e9349c9..7a2c3681e0d 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -840,6 +840,21 @@ add_custom_command(OUTPUT ${git_links} ${git_http_links}
 		DEPENDS git git-remote-http)
 add_custom_target(git-links ALL DEPENDS ${git_links} ${git_http_links})
 
+function(write_script path content)
+	file(WRITE ${path} ${content})
+
+	if(WIN32)
+		message(TRACE "skipping chmod +x '${path}' on Windows")
+	elseif("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" VERSION_GREATER_EQUAL "3.19")
+		file(CHMOD ${path} FILE_PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE)
+	else()
+		execute_process(COMMAND chmod +x ${path}
+				RESULT_VARIABLE CHILD_ERROR)
+		if(CHILD_ERROR)
+			message(FATAL_ERROR "failed to chmod +x '${path}': '${CHILD_ERROR}'")
+		endif()
+	endif()
+endfunction()
 
 #creating required scripts
 set(SHELL_PATH /bin/sh)
@@ -865,7 +880,7 @@ foreach(script ${git_shell_scripts})
 	string(REPLACE "# @@BROKEN_PATH_FIX@@" "" content "${content}")
 	string(REPLACE "@@PERL@@" "${PERL_PATH}" content "${content}")
 	string(REPLACE "@@PAGER_ENV@@" "LESS=FRX LV=-c" content "${content}")
-	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
+	write_script(${CMAKE_BINARY_DIR}/${script} "${content}")
 endforeach()
 
 #perl scripts
@@ -880,13 +895,13 @@ foreach(script ${git_perl_scripts})
 	file(STRINGS ${CMAKE_SOURCE_DIR}/${script}.perl content NEWLINE_CONSUME)
 	string(REPLACE "#!/usr/bin/perl" "#!/usr/bin/perl\n${perl_header}\n" content "${content}")
 	string(REPLACE "@@GIT_VERSION@@" "${PROJECT_VERSION}" content "${content}")
-	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
+	write_script(${CMAKE_BINARY_DIR}/${script} "${content}")
 endforeach()
 
 #python script
 file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
 string(REPLACE "#!/usr/bin/env python" "#!/usr/bin/python" content "${content}")
-file(WRITE ${CMAKE_BINARY_DIR}/git-p4 ${content})
+write_script(${CMAKE_BINARY_DIR}/git-p4 "${content}")
 
 #perl modules
 file(GLOB_RECURSE perl_modules "${CMAKE_SOURCE_DIR}/perl/*.pm")
@@ -1024,20 +1039,20 @@ foreach(script ${wrapper_scripts})
 	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
 	string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
 	string(REPLACE "@@PROG@@" "${script}${EXE_EXTENSION}" content "${content}")
-	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
+	write_script(${CMAKE_BINARY_DIR}/bin-wrappers/${script} "${content}")
 endforeach()
 
 foreach(script ${wrapper_test_scripts})
 	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
 	string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
 	string(REPLACE "@@PROG@@" "t/helper/${script}${EXE_EXTENSION}" content "${content}")
-	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
+	write_script(${CMAKE_BINARY_DIR}/bin-wrappers/${script} "${content}")
 endforeach()
 
 file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
 string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
 string(REPLACE "@@PROG@@" "git-cvsserver" content "${content}")
-file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/git-cvsserver ${content})
+write_script(${CMAKE_BINARY_DIR}/bin-wrappers/git-cvsserver "${content}")
 
 #options for configuring test options
 option(PERL_TESTS "Perform tests that use perl" ON)
-- 
2.39.0.rc1.1006.gb4c675778ba

