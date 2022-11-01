Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC77C433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiKAWwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiKAWwI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:52:08 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406841F9D0
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:51:57 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v17so231564edc.8
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8kQBj19i/O8q4hstbYt+RcFu15hgiYTgq8jHk4CZiI=;
        b=oUkBY3gWCYhWIKzq4KlcSoLz9XvFIvdDChreNXnfwg2Wz92O26mEyttnjmjuuwDcOD
         WnBUXkoa2L751RJ41M0KOqWOZfyyokErDVGLW/A5UZ4ATCwlN1Eyt0icDB/d8wEFSczG
         OpJMJ5uHzayR+1fBOMKKfwrDKwNaYgvoScZsvy7WkHxsrp3lMqFxzcX320N7p7Y0W1Cn
         CH6r3+2P0ciFZYSAzmRa8YQ57mmj+YgZJGgLZLRFPwG20/CbeT1DyLp2SjjaNiuOGY9W
         Y0Mm/xbQrA0CacXDqfTQr6ynOBsO5gPwgWku1dQ32a4lu8/hAjyYX1Mey7Ke1sb3OsTa
         QIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8kQBj19i/O8q4hstbYt+RcFu15hgiYTgq8jHk4CZiI=;
        b=6GfjKEav+TzmjAsB3FIiEEs4RGozIK3/wVvdLl2qd2fDs1SGmY5GsMcgL+69FIwZMX
         CBreMFYl8rlJs9cbVYQ0ObBaFqcMCMg65ywjQCG4HNuNPvR4B+BGpzRIeqjp4z447ZxB
         YX9jF5W7MwQ7GTt0/jD4nRH600lIfoyKa4ee1+RO50rQU4ESY2OFnsDYmphKhOvdOS1k
         V3gP/wReoICRqb7gfdfTUdc/cY4eOyZMn/FXbSQlyw0ELBZHIchOJTMtXgQ+iLjYMnRn
         +eShrng6lAGYmx+X2h3+HrkaRpzw+vpNyVmBZOq18dtg2PGV2DYBg/DzPkKsA94Hecen
         pgmg==
X-Gm-Message-State: ACrzQf00BPrO/+kjcw4vm3cmgCjUQz9AAuuSVsCdUwTZfyxHRZ1Dn8mS
        CGUuQW34tdHNuKbfeHc9pFZZt7jC7vR4jg==
X-Google-Smtp-Source: AMsMyM4wTjakas7M7gm9vgmQDjlYhKyiXRapMkOWwjza7HKGy/Li6cRFp49LjDpxpJvAepoIGHWntQ==
X-Received: by 2002:aa7:cdcf:0:b0:463:56ff:4cf8 with SMTP id h15-20020aa7cdcf000000b0046356ff4cf8mr13711548edw.215.1667343115483;
        Tue, 01 Nov 2022 15:51:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x20-20020aa7d6d4000000b004580862ffdbsm5012689edr.59.2022.11.01.15.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:51:54 -0700 (PDT)
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
Subject: [PATCH v3 07/12] test-lib.sh: support a "GIT_TEST_BUILD_DIR"
Date:   Tue,  1 Nov 2022 23:51:31 +0100
Message-Id: <patch-v3-07.12-bd7fb1eec24-20221101T225022Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compliment the existing GIT_TEST_INSTALLED variable added in [1] with
one that allows for testing a git built in a directory that's not
"../".

Instead of "test this installed git" ("GIT_TEST_INSTALLED"), this new
"GIT_TEST_BUILD_DIR" is a "test this built directory over
there". E.g. this will pass all tests:

	git clone --depth=1 https://github.com/git/git.git git1
	cp -R git1 git2
	make -C git1
	[apply this change to git2]
	(cd git2 && GIT_TEST_BUILD_DIR="$PWD/../git1" make -C t prove)

This facility and file-based instructions to have the test suite use
another build directory[2] are mutually exclusive, but in a subsequent
commit we'll make CMake use this instead.

1. 6720721e152 (test-lib.sh: Allow running the test suite against
   installed git, 2009-03-16)
2. 350a005e366 (cmake: avoid editing t/test-lib.sh, 2022-10-18)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README      | 3 +++
 t/test-lib.sh | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 979b2d4833d..fc0daef2e41 100644
--- a/t/README
+++ b/t/README
@@ -231,6 +231,9 @@ override the location of the dashed-form subcommands (what
 GIT_EXEC_PATH would be used for during normal operation).
 GIT_TEST_EXEC_PATH defaults to `$GIT_TEST_INSTALLED/git --exec-path`.
 
+Similar to GIT_TEST_INSTALLED, GIT_TEST_BUILD_DIR can be pointed to
+another git.git checkout's build directory, to test its built binaries
+against the tests in this checkout.
 
 Skipping Tests
 --------------
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 36358811a0f..388774a0aa0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -51,7 +51,10 @@ fi
 # For CMake the top-level source directory is different from our build
 # directory. With the top-level Makefile they're the same.
 GIT_SOURCE_DIR="$GIT_BUILD_DIR"
-if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
+if test -n "$GIT_TEST_BUILD_DIR"
+then
+	GIT_BUILD_DIR="$GIT_TEST_BUILD_DIR"
+elif test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
 then
 	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
 	# On Windows, we must convert Windows paths lest they contain a colon
-- 
2.38.0.1280.g8136eb6fab2

