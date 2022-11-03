Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F1EC433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 16:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiKCQnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiKCQkk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 12:40:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499631A3B0
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 09:38:16 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id v27so3942109eda.1
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 09:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srdmAH0MeaSe0rddADN9c0Rs8I6WU+jcY0EK9S9/hpY=;
        b=fNpMwnk9TPgmxl7KHZHHGahOppT+XoyCMDuZChEDB0u2Ijk8oR0Led451x72JjLL5J
         cEkuyhiW2Xyde1TikjfRjYaUjw+VDFelZL/FPjtF+EftOHO3OfVztz0R0kVbzXnqFsN/
         nW3DD5Yi8gYRcbrWAtI48fvm/bPeGLEQm/JTaN/zNNE6tTIp0TatglMtl3rc62f8LlGk
         IRPrvZpKn+2UyGoJwo0UCQBTj0ySaDwyLTcVhs8j4u/v7ADWk/OK2QVsKIUhxz+aMi2z
         sB3j4ke9FyeA0+fLg3SFIAuNJRuGVM7UedGksP2HqaL+Oh4G/GEb/RqXH1+U47kQegqq
         xjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=srdmAH0MeaSe0rddADN9c0Rs8I6WU+jcY0EK9S9/hpY=;
        b=rKPmx0XHaOLpEVE/u/8AGRDGKM1rBuGZINQTwV2D4IHsI/sjKqic3+JlK36Q2XI/gE
         U0sNWT0IlzPJkC6c/49075mv92QvHj7/RQERjTtX8RggEEFsKiDNPOMriDEKwjG+ry1h
         kwN8YNWdvtOz+JN04S+E/7ktZaya5OxVUfinfep/fWh7PIFBxT/jFp03Rvjoy0w5XJH6
         nrFp/ei/imdtkupmofYjsj0PEwWlWIfQIaP25iz3HbOhFQi0E0ZE3vlYc+FdKDT5LNjf
         Htz9C6YFLl/GQu6pC4/++fLr2LHFNK6EZxcGGs3MJblhDRqLeZj+hVrPYQYynjGDE7Gi
         1w7g==
X-Gm-Message-State: ACrzQf1pR3dDiZ8AgAIjmephxFuLEff4HTfUBezVMDSI29JGbXdcrYFM
        /WLdeRe6GbWlzv5WDbMi3gsQtDtDu9SnAA==
X-Google-Smtp-Source: AMsMyM79YzbknJFl0EMMBh3LjUqixnIwoY+UzizRvcMoxuxXcK6GMvw+3/mUYGYKiVa9vcXNtDwumg==
X-Received: by 2002:a05:6402:909:b0:435:a8b:5232 with SMTP id g9-20020a056402090900b004350a8b5232mr31281623edz.240.1667493494465;
        Thu, 03 Nov 2022 09:38:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b0078d38cda2b1sm666188ejc.202.2022.11.03.09.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 09:38:13 -0700 (PDT)
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
Subject: [PATCH v4 08/14] test-lib.sh: support a "GIT_TEST_BUILD_DIR"
Date:   Thu,  3 Nov 2022 17:37:58 +0100
Message-Id: <patch-v4-08.14-87a2c77ee68-20221103T160255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com> <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
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
2.38.0.1451.g86b35f4140a

