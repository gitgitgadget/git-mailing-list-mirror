Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F498C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 09:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiJUJpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 05:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiJUJor (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 05:44:47 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03712357CC
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:44:46 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id bh7-20020a05600c3d0700b003c6fb3b2052so1618534wmb.2
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSvc5V+ula3OLaS92rj7OLVYmWSqPp/M2w75EqGBo7g=;
        b=qL6U+iPC3I5J8IFF6+zsNN5bSqg0qwckVmXRKaSn25e2JZue5eUM/nFwVjLPx9/cQu
         BRE5ZJ/oC5oOAavuZXfIny2ha2wDthyHpJpxxmqSHmXL9M2tMNIwD+FOFXJAttAbFfYc
         zlQdmetGTzTO0Skfeslxp1cunFpbT9jtTlqmJO9Dn1UZ/ia79YNXrGVszyz98TanrmPn
         b9gTAETC8aeabnNaR1NsaWYnSXV18is2AC9BAyVqf0TdhgK3r/1ijVbHuuwsYN4vGdmK
         FH1aiXCy7ynji02yAu0DaqYXoVBL1eTnZt34AvglVeIZtZZTm9Z4RmJg5+jT7+ueejau
         DLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSvc5V+ula3OLaS92rj7OLVYmWSqPp/M2w75EqGBo7g=;
        b=TuKjY9PMSIOQLzVQ/2mYfP3qpC6ktaOa63oNzttxUfIlzfjxpfDfs3yCG/e3+N7cXN
         rXPo1ecbWxJeIqy1+nUpGr7eSzgqoHJI9s3FyG9LMQGW2E5olC+AR7b/LVLTohcTC+5j
         rvSNrG3cS0JByzOtqlt5l8c9+mWzCTbko7ShuLuiQepYHE7qCGHXLlSTuJTkTmvJzGcl
         OhyY2Iry1ORsne0FeY4O3Kv3OGC7Laba+dPD/a7Z7Is9D3ybXEb+zNLKhQVf7r9ogLu7
         08VXkaJP4GIjmqVIZ6kdHdQrCBzKWjAaR+kzcBq8HqLuXTUt6pzTssqkr9dnrSOvrWRV
         n4Vw==
X-Gm-Message-State: ACrzQf18qcSnCfUnERJdp0aT8u71UbvoETicUFfIp14jF+7iALfswSz4
        5Ezr0MN8hGyMWqJcMuTLIbBrrS85aootsQ==
X-Google-Smtp-Source: AMsMyM4/DeHGz1duHYr80AzTYe3m/Chb9vZ6DpVi57bBLDC83mmX4E8IKZegAe8f/jhT4Q7TMbe6iA==
X-Received: by 2002:a05:600c:4e0e:b0:3c6:fbc5:e2c3 with SMTP id b14-20020a05600c4e0e00b003c6fbc5e2c3mr14098704wmq.120.1666345483988;
        Fri, 21 Oct 2022 02:44:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u6-20020adfeb46000000b002258235bda3sm18277768wrn.61.2022.10.21.02.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 02:44:43 -0700 (PDT)
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
Subject: [PATCH 2/9] cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
Date:   Fri, 21 Oct 2022 11:44:15 +0200
Message-Id: <patch-2.9-2c1d194e590-20221021T091013Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1205.gcea0601d673
In-Reply-To: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The cmake recipe added in [1] did not create the bin-wrappers/*
directory, and thus fell back on running the tests with the equivalent
of "--no-bin-wrappers".

Thus the. "t/test-lib.sh" would be unable to find "bin-wrappers/git",
and we'd fall back on "GIT_EXEC_PATH=$GIT_BUILD_DIR" using the
fallback behavior added in [2]:

	$ ./t0001-init.sh
	<GIT_BUILD_DIR>/t/../contrib/buildsystems/out/bin-wrappers/git is not executable; using GIT_EXEC_PATH

Or rather, this is what would have happened on *nix, but until [3]
there wasn't any non-Windows support for "cmake". On Windows it didn't
matter that the bin-wrappers weren't made executable, since there's no
executable bit, instead the emulation layer looks at whether a file
has a shebang.

But with [3] we've effectively used the semi-equivalent of
"--no-bin-wrappers" unintentionally on *nix, and furthermore because
we didn't make these executable

In addition, we'd fail any test that needed to invoke one of our built
shell, perl or Python scripts on *nix. E.g. t0012-help.sh would fail
on a test that tried to invoke "git web--browse". I.e. the equivalent
of this (in the "out" directory) would happen:

	$ ./git --exec-path=$PWD web--browse
	git: 'web--browse' is not a git command. See 'git --help'.

Which we can fix by "chmod +x"-ing the built "git-web--browse":

	$ chmod +x git-web--browse
	$ ./git --exec-path=$PWD web--browse
	usage: git web--browse [--browser=browser|--tool=browser] [--config=conf.var] url/file ...

The same goes for e.g. the "git-p4" tests, which would fail because
our built "git-p4" wasn't executable, etc.

This change should ideally use file(CHMOD ...), but that's much newer
than our required cmake version[1].

1. a30e4c531d9 (Merge branch 'ss/cmake-build', 2020-08-11)
2. e4597aae659 (run test suite without dashed git-commands in PATH, 2009-12-02)
3. f31b6244950 (Merge branch 'yw/cmake-updates', 2022-06-07)
4. https://cmake.org/cmake/help/latest/command/file.html#chmod

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index fd0c6ef4971..464c41a1fdf 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -836,6 +836,7 @@ foreach(script ${git_shell_scripts})
 	string(REPLACE "@@PERL@@" "${PERL_PATH}" content "${content}")
 	string(REPLACE "@@PAGER_ENV@@" "LESS=FRX LV=-c" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
+	execute_process(COMMAND chmod +x ${CMAKE_BINARY_DIR}/${script})
 endforeach()
 
 #perl scripts
@@ -851,12 +852,14 @@ foreach(script ${git_perl_scripts})
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
@@ -995,6 +998,7 @@ foreach(script ${wrapper_scripts})
 	string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
 	string(REPLACE "@@PROG@@" "${script}${EXE_EXTENSION}" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
+	execute_process(COMMAND chmod +x ${CMAKE_BINARY_DIR}/bin-wrappers/${script})
 endforeach()
 
 foreach(script ${wrapper_test_scripts})
@@ -1002,12 +1006,14 @@ foreach(script ${wrapper_test_scripts})
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
2.38.0.1205.gcea0601d673

