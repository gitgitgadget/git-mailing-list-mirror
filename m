Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D009C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 18:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbiLSSj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 13:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbiLSSjh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 13:39:37 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05FBAA
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:39:35 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h11so9551461wrw.13
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMOWW5c03eR4V5eRVVWvlsYH0kUdIcD2s72yRrq3Png=;
        b=eq1NWN1z/dEYBIlDL8/JRO+KU5AEOLEpYIyXtyMAfFBGRvTiiGFEbHsh0w8AwJMSZ2
         5u2sgk2ki/JdpvpdzB+a8frZYXAbX0H5g2kgzW+wQ7493qa4nHbQVWwiT05fcHW1FE3q
         bYPiicRN7leJSFM0pneYyLVNcii79b5wCBgSMjVwO2kfgUQ//q+8P1Gf3JXtu6mCSAZn
         NZrEVdhs3GIw6mMejBcot+TKGG5FvxnShSBmgCv+P6WM7vqTBX0pGDxjsDu/uHYuza0d
         Dd5Hm1CAkct57r5xRteAfXgmSZbqGs3N+sIA9JYg6lzp47NuXYNuuJWFb+Ixgz7PuOH9
         MgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMOWW5c03eR4V5eRVVWvlsYH0kUdIcD2s72yRrq3Png=;
        b=wQaZGlavrLk91sAetHKqAPQyFSx9AQ1jFTGoLo6wYySTelm1/RqXLqm4MzTSs6wkl1
         vhJekTJrUqnfO62IXGxzxiIrxlBEtUVZ2BSFRY0RqRB7azKyfMyjZfG7WqVjDguXIgh0
         8psKwa3qlSzrnQ/T7Qg2cLg3kk1f6BEK84kPW00SrTGhNGOElB5H3k5Cefc7TTjWgz6e
         UuJ+odnSmgbGZnWvlsCt2GtW3n/IfwE7ghTiOi779m6lMdrpOW/BJ0+4HG8prb/tphZg
         mzIWMqG3x65aIgXfBEU/8znB418XHCAblt4ZnTDd5pGUKmdNw11dgki4gnYBuFddi/ri
         Bqrw==
X-Gm-Message-State: ANoB5pnDhHEuvlL0/LSXFVt7c5N/wjQjEwa32pKk6PSc1eXJV+vJuYt+
        yg4FwuYw9waAkQZ8PLMmsj/cFYfPuhP08w==
X-Google-Smtp-Source: AA0mqf5Xlf+nZn3kW/fRdws6zUZRrOa5swih8dpxjFLV4PneiO7yfFeNjzpp5XJA9/FcMre6RFY3KQ==
X-Received: by 2002:a05:6000:1d94:b0:236:770a:665a with SMTP id bk20-20020a0560001d9400b00236770a665amr26837167wrb.66.1671475175214;
        Mon, 19 Dec 2022 10:39:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a13-20020adfe5cd000000b0025dac4b615dsm7286790wrn.3.2022.12.19.10.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:39:34 -0800 (PST)
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
Subject: [PATCH 6/6] cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
Date:   Mon, 19 Dec 2022 19:39:24 +0100
Message-Id: <patch-6.6-3724cad82e0-20221219T183623Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1071.g97ce8966538
In-Reply-To: <cover-0.6-00000000000-20221219T183623Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221219T183623Z-avarab@gmail.com>
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
index 29b73ecbbbc..74b094ae5dc 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -847,6 +847,21 @@ add_custom_command(OUTPUT ${git_links} ${git_http_links}
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
@@ -872,7 +887,7 @@ foreach(script ${git_shell_scripts})
 	string(REPLACE "# @@BROKEN_PATH_FIX@@" "" content "${content}")
 	string(REPLACE "@@PERL@@" "${PERL_PATH}" content "${content}")
 	string(REPLACE "@@PAGER_ENV@@" "LESS=FRX LV=-c" content "${content}")
-	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
+	write_script(${CMAKE_BINARY_DIR}/${script} "${content}")
 endforeach()
 
 #perl scripts
@@ -887,13 +902,13 @@ foreach(script ${git_perl_scripts})
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
 file(COPY ${CMAKE_SOURCE_DIR}/git-p4.py DESTINATION ${CMAKE_BINARY_DIR}/)
 
 #perl modules
@@ -1032,20 +1047,20 @@ foreach(script ${wrapper_scripts})
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
2.39.0.1071.g97ce8966538

