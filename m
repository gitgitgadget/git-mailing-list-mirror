Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7497C4708C
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 02:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbiLFCKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 21:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbiLFCJt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 21:09:49 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2345A248E3
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 18:09:38 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id vp12so2809141ejc.8
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 18:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2St+QUt0mvUlgktyu+E/VHX5plavms8gTBOOD36edxA=;
        b=I2XCSPwkTX/HE4raMzR/ZErPlGB5j7AzUTGcKdNBvTcHg9M7N9UdqT8rKo5yComVUy
         0+0mm2Rz/HT3NATZICI3VEl8vFJxGeX9UyBSojKpoKj/ASZlP+hkW8HDF8RPItvHKuT4
         lmm/L9DsGpzUHzLpTA+/8p0kF7OwL7Fe1w4dFOfxvWP7as+l487HkYdX0BR1jpcKwnIU
         9QjDr+8ct3nEBJE5BHc5EGgOACrfXY2BYjbqva3afF5XRCy7+5MBLaHpIh0/d6EJE33Z
         sIp5GttuU3bNFCEJ2JGX30VS46cV68SPJ3QyGLhpl1Sxy/nQDWyRjeoetKD6fSn9nGDT
         /9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2St+QUt0mvUlgktyu+E/VHX5plavms8gTBOOD36edxA=;
        b=jGPQh0mwBZj/FwKU7ggeV9y03cOwf7SnSKT2+7YdPG6oECPjcNNKrEnhdIlZ1brTFT
         ROIJBXTM/5ti9C6BbQptbc6MgDPbG7lrUbBZjhQVKrEA4lINHn7XpdlbpwbryOcQkuFY
         JnBQB1mPF3CZEhB0uhsOXcapnoyc5wVqrRM1VEf/U36Bm0a+cEBrR36vbuEKHUPhNbrT
         hg3VfiqPjHdwnen6rwWdnEmC0bIN5Hk5M3oGz1iToqsJIDQIeCU/jSuALA6FctjFrNJi
         NSlZEny2r8JXdcvpnaJUi3HUhNftVYv3rUVPSL445eNyXCyCfaJFIXpEmhW1OnNFBaN8
         yFHw==
X-Gm-Message-State: ANoB5plEww5LueVq4bS+UB5vl9eFn7DyerVs44JAkWmZPL7mqoYojoUD
        2y1WSD641EFLgRxNf+Wf3LOkVDlX07hW/A==
X-Google-Smtp-Source: AA0mqf7SC+Rf0dU3KvIAHl+NLg8xTd9L3QnjMj7ZjThHeW5ayF8SpSW27S3YoQOV4FV/mjFfDhx+RQ==
X-Received: by 2002:a17:907:a710:b0:7ba:fd1f:524 with SMTP id vw16-20020a170907a71000b007bafd1f0524mr11308537ejc.361.1670292576363;
        Mon, 05 Dec 2022 18:09:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b007c099174a12sm6966186ejm.178.2022.12.05.18.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:09:35 -0800 (PST)
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
Subject: [PATCH v6 09/15] test-lib.sh: support a "GIT_TEST_BUILD_DIR"
Date:   Tue,  6 Dec 2022 03:09:07 +0100
Message-Id: <patch-v6-09.15-5135e40969e-20221206T001617Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.1006.gb4c675778ba
In-Reply-To: <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
References: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com> <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Complement the existing GIT_TEST_INSTALLED variable added in [1] with
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
another build directory[2] are mutually exclusive. In a subsequent
commit we'll make CMake and CTest optionally prefer this method.

1. 6720721e152 (test-lib.sh: Allow running the test suite against
   installed git, 2009-03-16)
2. 350a005e366 (cmake: avoid editing t/test-lib.sh, 2022-10-18)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README      | 3 +++
 t/test-lib.sh | 7 +++++++
 2 files changed, 10 insertions(+)

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
index c7d55ff0796..a1b5c7c6ce1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -55,6 +55,13 @@ if test ! -x "$GIT_BUILD_DIR/git" &&
 	test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
 then
 	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
+elif test -n "$GIT_TEST_BUILD_DIR"
+then
+	GIT_BUILD_DIR="$GIT_TEST_BUILD_DIR"
+fi
+
+if test "$GIT_SOURCE_DIR" != "$GIT_BUILD_DIR"
+then
 	# On Windows, we must convert Windows paths lest they contain a colon
 	case "$(uname -s)" in
 	*MINGW*)
-- 
2.39.0.rc1.1006.gb4c675778ba

