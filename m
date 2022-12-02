Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C24C4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbiLBL3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbiLBL3B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:29:01 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450B7D3DFF
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:28:52 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vp12so10860088ejc.8
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 03:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6ZoeMtA9Vr+KsujbPW/xOSGEcbTwCzza+dgVf4X0Os=;
        b=BnG5ZCtn/HcUy7JPIsh6TxCAkc3h/fxMVh8/UYDBhN/EzDFd2zIQ/XxUloDGgoCqs9
         jdur5unsg56VDz2eYb80CKLdmqUuBOE4hHYe65/kfILvT7cb2cZlVXqjCO6QP8jPvjhP
         0BhsIM4Ha+mSYLphp1HsHVCDWVgZwXQmapnVR1eBtjPtQXPU2qXDpFS5u6UDCIeDUcOO
         JdImdRza+RQkbWSfk5kGnI0e1bgUEHcIygdHXgyxHNvBJ32n8CkbO9Ee3Bwr+Cnx+/J7
         YLDPURwQi7/9MVdmCF2w0flonV9jlliQa2a5amzKd79XLzbm7PF0F7O6cgWK3KBYlBDI
         l7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6ZoeMtA9Vr+KsujbPW/xOSGEcbTwCzza+dgVf4X0Os=;
        b=tuvix2kyMh6HaEF0fs4zUrTj+Z3YaB23GoBfor4oF8ZodpCZJyYh1du8jyUbhOMG0G
         t6MfFHP3oS3mWzuE1eP42jFNUxt6sPQVNHNGOTFwuynDrLdyKnqsdUfgwCDrpXAtZSJb
         p60l58U3z6h65f/ypmC/CftBRITZ8UihWP1TtOwfSPlqAsYsGXZFBZP4pErDolNfjoki
         +zByUvY7j0BcPEpTi4dRQVXhB+gKl8PpUL9EUDZcRyaQOydBjCjkg0WC0qXRZk2G9/2u
         bdVm4V/q6KvqwWor+bXJoqTHY+6LiM3VO43Qb9CNog8UhVj1nNcfI6TjnVJUWpUV6Ywp
         bTjg==
X-Gm-Message-State: ANoB5pm+PKnW1VxsYcFMmYioNL4hduSHdfdViYEK6xF0NwUaITe9OKE2
        PR0AerbaT425Xlmq8P8sT/q32ODioNj1VQ==
X-Google-Smtp-Source: AA0mqf4zVlvojiRb7Q9O6VYDmXKR8XstDArJ9QDwtflS1W+wvh5sojSG5PFIgOJFwEqmKQAoqDrcsg==
X-Received: by 2002:a17:906:f189:b0:7ae:3fa3:d7c6 with SMTP id gs9-20020a170906f18900b007ae3fa3d7c6mr56971721ejb.494.1669980530337;
        Fri, 02 Dec 2022 03:28:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7df97000000b004611c230bd0sm2850780edy.37.2022.12.02.03.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:28:49 -0800 (PST)
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
Subject: [PATCH v5 09/15] test-lib.sh: support a "GIT_TEST_BUILD_DIR"
Date:   Fri,  2 Dec 2022 12:28:30 +0100
Message-Id: <patch-v5-09.15-df5aea35bbd-20221202T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.981.gf846af54b4b
In-Reply-To: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
References: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com> <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
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
2.39.0.rc1.981.gf846af54b4b

