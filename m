Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65A0C4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiLBL3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbiLBL2t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:28:49 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3F0B0DFE
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:28:47 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id td2so10870193ejc.5
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 03:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eX0lw1Z8r4an8SNDEnxWdsU6pKhOB0yvbUtbL9Eol2g=;
        b=WFp0oCapaxmeOIUczwKMKVXQ4Y+1sMBhwgvOwSOebBKn/DAnTPMeZr3pPbzP5ChFWE
         DO0fsO1lKRjrouYX2yfyMBhb2Jv3bEDe/PxKMmlEE7PwulC3GvzKBLfe+vG3kHmLoo2S
         ypTR710GeAd3DzF3pnPa7/HYw3El5kJMPgN8L3NfyRvrxAUO1IerTk5AH79TdHQ7LAgg
         TSk6SXMuveYI4z6g5wRPUKj8MeMEDQykTprLpFPaH1oFlkDTaw39XFkAid3oPpXQeZYV
         ko+Fd2zKFBVb6FUwF1AacJC2CcP1nS+x1fXLAxcurekZYcFl1Xok/QFfwmuCSibwQ8Zu
         f94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eX0lw1Z8r4an8SNDEnxWdsU6pKhOB0yvbUtbL9Eol2g=;
        b=mHKMYh6GTQHxgsKb4nyttTBkjYUiS1VBi7QMLaydGtjNIT6iJNL31xK+/4VgKbNh/d
         ysIodj2Qv1q1hi7qojC4ufnbcGBMaWuBWe8MjOLOoJK3ltmEKijZZrH9qOWMlbJICaED
         W0H+F9sygdyOJfPcBGD1R+xHsdvTR10uVonxp8ScdSTyBUm8hNTlnt+UGTpOgDQRWJZa
         7bLwG5ysygrnAUSkx1AZuHN3Y488nd9tYzkfYG+/89zAGZjpAtg+nD1e3lafAUIpzGDZ
         f/YKLZAhcbgNPy7AIk46RIjHuX1Lyjzn2EkDnpLNKyaDKmFuNRMjv0xjdhIGfTuk2zh3
         YcGg==
X-Gm-Message-State: ANoB5pkoXkuB79ik7xtetTs1lTcC6dtloCMXDSouzEkTb6P6iJFFBJBs
        yGYd9B38y4cEilH7r118zWmjG5UlvbY83A==
X-Google-Smtp-Source: AA0mqf58yki5VTlMsn9cmXvUaLkPk3rZqPEqqKCK5Rl/dqyg8nVawPzNUjpjZc1qdJki8Y3WoZnA6w==
X-Received: by 2002:a17:906:6681:b0:7ae:732d:bc51 with SMTP id z1-20020a170906668100b007ae732dbc51mr47582730ejo.549.1669980525662;
        Fri, 02 Dec 2022 03:28:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7df97000000b004611c230bd0sm2850780edy.37.2022.12.02.03.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:28:44 -0800 (PST)
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
Subject: [PATCH v5 05/15] cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
Date:   Fri,  2 Dec 2022 12:28:26 +0100
Message-Id: <patch-v5-05.15-435452314fa-20221202T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.981.gf846af54b4b
In-Reply-To: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
References: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com> <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
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

1. f31b6244950 (Merge branch 'yw/cmake-updates', 2022-06-07)
2. e4597aae659 (run test suite without dashed git-commands in PATH, 2009-12-02)
3. 2ea1d8b5563 (cmake: make it easier to diagnose regressions in CTest
   runs, 2022-10-18)
4. https://cmake.org/cmake/help/latest/command/file.html#chmod

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

write script
---
 contrib/buildsystems/CMakeLists.txt | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index c641e9349c9..2248b755b3b 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -840,6 +840,19 @@ add_custom_command(OUTPUT ${git_links} ${git_http_links}
 		DEPENDS git git-remote-http)
 add_custom_target(git-links ALL DEPENDS ${git_links} ${git_http_links})
 
+function(write_script path content)
+	file(WRITE ${path} ${content})
+
+	if("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" VERSION_GREATER_EQUAL "3.19")
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
@@ -865,7 +878,7 @@ foreach(script ${git_shell_scripts})
 	string(REPLACE "# @@BROKEN_PATH_FIX@@" "" content "${content}")
 	string(REPLACE "@@PERL@@" "${PERL_PATH}" content "${content}")
 	string(REPLACE "@@PAGER_ENV@@" "LESS=FRX LV=-c" content "${content}")
-	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
+	write_script(${CMAKE_BINARY_DIR}/${script} "${content}")
 endforeach()
 
 #perl scripts
@@ -880,13 +893,13 @@ foreach(script ${git_perl_scripts})
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
@@ -1024,20 +1037,20 @@ foreach(script ${wrapper_scripts})
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
2.39.0.rc1.981.gf846af54b4b

