Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388A5C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiKAWwK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiKAWvz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:51:55 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACC81EC42
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:51:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id b2so40874516eja.6
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFw70LFk72BUWBINjXeHrI+Dxj4so793FpLuWPX6eFo=;
        b=OwTtITnQGKe/3xhi8yUcMh/iuoQRt7SZsgTOiBnUnXF3op93gzlJ/2ioh4JsTR/kfl
         ZE6ylUdiCDIG/NgoLD14qpw+3WdvxtN6NvDYRot+svrsI9MzvGKyXYquhZdEFqYwh519
         U42f/e8AjtM61q1qChJGSdnhllh5uKh3tiCnxYbmwDCDg3YkoL6HfWm/fBr1Din5Z5Yf
         ugoBoxdfUcYnZWddljrGyu1Tw080byttcAn84GDIOz18LlX2g0VgCPnDdk85XP5jXX6p
         OdF2mPtJV2c5kSWbnuIRcKWNIGKcCN3sHGCKsokUDAmnxprDOU4bcWXapgj6y2uPus7F
         cNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFw70LFk72BUWBINjXeHrI+Dxj4so793FpLuWPX6eFo=;
        b=JuR0MibKhPJQpgH/B6yDfDXNN4EZNk8uZOFj4CrvqRaTgo5zb7I79IABmUi/FEXEc6
         g79ixEY61eYwD9LEcAmDlV9ipvnoH50KNZHXgl7+x48JTi0PFyART+pIA7LFHFOgpxwI
         l7yZ3diPQ89FdSvRBV+KMBdvJLLIkN+uGEobzoF0CcomLKjhpcLWhu0MopJw5PntiaQx
         2YQSMLhMrTJh5MQGdGUip/rPhRgtqlk/xzhBPKonyYZWe/OCBZMJ/XvEd/xntzXhcYLY
         D39Ic0R/mbUq0ce2wCSYDkOyyb3qrlhvZVTms6Ui7784dljkFtJMrmrHbj/l70BppYTS
         Mzyw==
X-Gm-Message-State: ACrzQf1HB/dOnDc+luZLMri4LPgDjjRQ0IASKDnb3MKZbcgVyel5vQIa
        u2cOZaX93H05vichedRNeDsIX+WEQlVEgg==
X-Google-Smtp-Source: AMsMyM66ekHXKkWnm8nCNcQ+NxHoFcU8QRN6VFbEWtKic5Oj1kK/6Ykc7/7WJeSEfkLSNdUIBnUSKQ==
X-Received: by 2002:a17:907:70b:b0:740:ef93:2ffb with SMTP id xb11-20020a170907070b00b00740ef932ffbmr19691584ejb.93.1667343112199;
        Tue, 01 Nov 2022 15:51:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x20-20020aa7d6d4000000b004580862ffdbsm5012689edr.59.2022.11.01.15.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:51:51 -0700 (PDT)
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
Subject: [PATCH v3 04/12] cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
Date:   Tue,  1 Nov 2022 23:51:28 +0100
Message-Id: <patch-v3-04.12-ad551f53de9-20221101T225022Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
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

Fails around 20% of our testts on *nix. So even with [3] we'd fail any
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

This change should ideally use file(CHMOD ...), but the "file(CHMOD"
feature is much newer than our required cmake version[5].

Before this change:

	80% tests passed, 196 tests failed out of 977

After:

	99% tests passed, 5 tests failed out of 977

The remaining failures will be addressed in subsequent commits.

There was a suggestion of using a function to abstract this away[6],
which sounds good. But after spending too long trying to get all
combinations of "${content}" and ${content} (unqoted) in the function
and its callers working I wasn't able to fix the quoting issues it
introduced.

A lot of this is duplicated already, we can follow-up at some other
time with refactoring, and address any tricky quoting issues in
calling function with these parameters then.

1. f31b6244950 (Merge branch 'yw/cmake-updates', 2022-06-07)
2. e4597aae659 (run test suite without dashed git-commands in PATH, 2009-12-02)
3. 2ea1d8b5563 (cmake: make it easier to diagnose regressions in CTest
   runs, 2022-10-18)
4. a30e4c531d9 (Merge branch 'ss/cmake-build', 2020-08-11)
5. https://cmake.org/cmake/help/latest/command/file.html#chmod
6. https://lore.kernel.org/git/0fda0e54-0432-7690-74a7-3d1a59923e0c@dunelm.org.uk/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index dd46ad25fb7..127a4a17853 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -864,6 +864,7 @@ foreach(script ${git_shell_scripts})
 	string(REPLACE "@@PERL@@" "${PERL_PATH}" content "${content}")
 	string(REPLACE "@@PAGER_ENV@@" "LESS=FRX LV=-c" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
+	execute_process(COMMAND chmod +x ${CMAKE_BINARY_DIR}/${script})
 endforeach()
 
 #perl scripts
@@ -879,12 +880,14 @@ foreach(script ${git_perl_scripts})
 	string(REPLACE "#!/usr/bin/perl" "#!/usr/bin/perl\n${perl_header}\n" content "${content}")
 	string(REPLACE "@@GIT_VERSION@@" "${PROJECT_VERSION}" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
+	execute_process(COMMAND chmod +x ${CMAKE_BINARY_DIR}/${script})
 endforeach()
 
 #python script
 file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
 string(REPLACE "#!/usr/bin/env python" "#!/usr/bin/python" content "${content}")
 file(WRITE ${CMAKE_BINARY_DIR}/git-p4 ${content})
+execute_process(COMMAND chmod +x ${CMAKE_BINARY_DIR}/git-p4)
 
 #perl modules
 file(GLOB_RECURSE perl_modules "${CMAKE_SOURCE_DIR}/perl/*.pm")
@@ -1023,6 +1026,7 @@ foreach(script ${wrapper_scripts})
 	string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
 	string(REPLACE "@@PROG@@" "${script}${EXE_EXTENSION}" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
+	execute_process(COMMAND chmod +x ${CMAKE_BINARY_DIR}/bin-wrappers/${script})
 endforeach()
 
 foreach(script ${wrapper_test_scripts})
@@ -1030,12 +1034,14 @@ foreach(script ${wrapper_test_scripts})
 	string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
 	string(REPLACE "@@PROG@@" "t/helper/${script}${EXE_EXTENSION}" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
+	execute_process(COMMAND chmod +x ${CMAKE_BINARY_DIR}/bin-wrappers/${script})
 endforeach()
 
 file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
 string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
 string(REPLACE "@@PROG@@" "git-cvsserver" content "${content}")
 file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/git-cvsserver ${content})
+execute_process(COMMAND chmod +x ${CMAKE_BINARY_DIR}/bin-wrappers/git-cvsserver)
 
 #options for configuring test options
 option(PERL_TESTS "Perform tests that use perl" ON)
-- 
2.38.0.1280.g8136eb6fab2

