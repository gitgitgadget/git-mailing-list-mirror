Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09670C4167D
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 16:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiKCQmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiKCQkk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 12:40:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FB01B9EB
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 09:38:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id l11so3919156edb.4
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 09:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXZ/2kzsSPub9j6RqWhHbRwdZ7TO5LCmma8SpOy5w+k=;
        b=UF1b+IZCWAKWVyAMiqj4CCWnnWuqbw9P3T188XHpxNVBOZ1ptjZd6xZ8oW0lAaB5O8
         VepTo/Eu09FIjAr6RvtU7r5t/qKzY5DYSnhI8xFP5/kHapcgGp7pc73Mczgu2biA/XrP
         t6S/FdOM5mSdqaUqq088ugHDChf+etyE+elg+0toBkzA6DQ0YczdLDh4b5cOV6TdgzVM
         Xz40DF4/UQDaN20OuRsjGT1RZ8P4XCL0ixIuMbhv1LjAYXlErvRqhb5ZCXkhHX76cFkG
         BMVmHyCAlY5ab8pQ/bO2FkOXMxCG08C3YRj5yZNiki1064oofSAzXZqAWDfNHVo9xJj5
         j9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXZ/2kzsSPub9j6RqWhHbRwdZ7TO5LCmma8SpOy5w+k=;
        b=ND59VXR19kFctJwJgJKPojpbFTLxte85fuxsR48Oc5/DjHH794BAknn8WuxWXnpzV6
         fd8rI437U1t5lt7fUoQVgjiyO7mbukJUr8C45+La/lxsq2UMe45kspcroXTKdAbszCJw
         u12FDBhUCzV7ByJ8alU96CjKKN/CQCr+i4MCMGw0uw37mjjlcDwWzP4w56noUZ99uWVf
         GRJtJ9d+5vHx+frHk0/7mwnJLoAaY0WtQSZFsCW9ZYubpakMdgR2LMR1yLi1DwAMhtyw
         2jyiAhLfRCoWbWxCvLYNeRIh1Zraj1LMPwd1wy0ldAG0wqwDFFgK0G3mKEWpJT5lL1wd
         MD/A==
X-Gm-Message-State: ACrzQf2fsgf3IkypLAPzNXO76NhYg20BbOASKhMAXTzfemyxXWNyM2Nv
        ScWAHXZ8NmDZ5/HVCbaplz5OE/zSySo4Sg==
X-Google-Smtp-Source: AMsMyM58TxIAvVJg7Vi6+pgQVKEMlp/PhQzOAGBAUO3BTUj5yimwTecjPjoALBE6rykx8nPRYNbemA==
X-Received: by 2002:aa7:cc90:0:b0:458:b07c:f35f with SMTP id p16-20020aa7cc90000000b00458b07cf35fmr30371022edt.310.1667493491319;
        Thu, 03 Nov 2022 09:38:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b0078d38cda2b1sm666188ejc.202.2022.11.03.09.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 09:38:10 -0700 (PDT)
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
Subject: [PATCH v4 05/14] cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
Date:   Thu,  3 Nov 2022 17:37:55 +0100
Message-Id: <patch-v4-05.14-eda1c1e95e5-20221103T160255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com> <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
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
index a900aff9960..27c939641e0 100644
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
2.38.0.1451.g86b35f4140a

