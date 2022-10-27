Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76ACC433FE
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 03:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiJ0D1z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 23:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbiJ0D1J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 23:27:09 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B1DFAA5C
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 20:27:07 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g12so55794wrs.10
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 20:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkX5lyjU3HruwZsTYTP65qMriFFUGITh5yMD+ykmeVw=;
        b=NOiLDwM31DZPL31vCTRdLZ7jKRpPZD0CxyFmdk2X9oRf9eqcGDGo5oz7anSNwGqUTZ
         RUKC46BnlTUAMTqkRjuCKM0pteeU08+Twp8aJThQychDA75dynt1uk8CdICvQHiEHPYC
         9Y4rmCu2pZ79aKd4CtneXDgdKVnVU/Wp8Tc0TceqIZsRM1cvzJuR2HP6mHxv/idm15pY
         H6OsQT5UGgXuHx2UObhh+R9KclJW1DTfnTDiCqWbkadHzKu9dov191qKiIlztDDLCd12
         7qTAIRh4/nuOmK7cBkEw+ucxRk5iIjjQbvJs1JsnxLHG1qGpElLSLcRhv34lBzWjA7ZT
         UGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkX5lyjU3HruwZsTYTP65qMriFFUGITh5yMD+ykmeVw=;
        b=Z/CGvkIyTlEA9A13LvaOSs5ajQyaBEhlcZVeEKouGMEmwwrt+tl2+sAG854pXzLwuo
         dqgxjrWYHbBu7PcPAQDjUghsRBxEwIBpFH42V4rfyhKgDaNz4MeuXaP7hoBDWyFXLlx9
         RvVtAz5+Zij53baj9SPVMf9Pepevtds6DMkYFKWCKrR3mKqE8EFva/V4LDKZdpv7PAnq
         dfQMYkYMVoabVaYrH80QGJOjPd2OdRBOB1kcyRGcH1HIZgNIDaktB2AMhwWU5DiK8qJc
         ERcQIY8If3AaHBNY2waV0NSHjCTQhCMCKz2bAPn5JXmhbPBwvWF7n8Yo9xSR7GqW4FCn
         c89g==
X-Gm-Message-State: ACrzQf0ZWgdoPtC+LrrxOLSN40tbcCKhtHUMihVx/HokDXk6QYkcR0Gk
        28FL/4apmgGET3dpUpeIKdWdChqmQO+lzA==
X-Google-Smtp-Source: AMsMyM5pujoEP6qlP7PmpwkrYJ/Xqpf/Uvhr5DOSshGyetayt+VLLRZG09Iq12WQWWqm0s49YIKSvA==
X-Received: by 2002:adf:f7d2:0:b0:236:87bc:a8f7 with SMTP id a18-20020adff7d2000000b0023687bca8f7mr5864169wrq.579.1666841225804;
        Wed, 26 Oct 2022 20:27:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hn2-20020a05600ca38200b003c6d0f8c377sm236828wmb.7.2022.10.26.20.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 20:27:05 -0700 (PDT)
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
Subject: [PATCH v2 07/11] test-lib.sh: support a "GIT_TEST_BUILD_DIR"
Date:   Thu, 27 Oct 2022 05:26:48 +0200
Message-Id: <patch-v2-07.11-a9ea3867f5f-20221027T032622Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1250.ge066ede4da3
In-Reply-To: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
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
2.38.0.1250.ge066ede4da3

