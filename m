Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B748FC07E96
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 22:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C7E961474
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 22:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhGDW6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 18:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhGDW54 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 18:57:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F79C061765
        for <git@vger.kernel.org>; Sun,  4 Jul 2021 15:55:20 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v5so19733326wrt.3
        for <git@vger.kernel.org>; Sun, 04 Jul 2021 15:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=77NXCINekiYU4CYx4ZMtBG1HLQhH6gXiNvrgzqAlMUg=;
        b=BjocQF+5FG+WexqcTjngV7lV/xg+GKtfOqvK/N9qgRbHbFbd+EuM+x0/JdDZ53isvQ
         Kj2Twvcun/6yt9zp1OZ7+xyOTxTzPScSaxhxczidUdEOmMqWB5TX+cGn8yQCwajkWPgY
         4FKwZML2aEZmBUKD+96tEvp8e1pyyYWXV19l9MjL8Z/RPnepox1baR/GlXWxTT2FhyAH
         iFhrRaFEgeVpv4tOAxotarMC7OUb1dhuBrOaMPBxdJaYgLX72ez5ogKpXUmbZw01enad
         X3+4hew5XaLxxR9sdmPWibrVmoSlJQ5a3BKHUXptiWy2mdDtGazpZ7wVEjC6V/1ROU2N
         RX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=77NXCINekiYU4CYx4ZMtBG1HLQhH6gXiNvrgzqAlMUg=;
        b=QQGpjBtIxurK+VF9KSGXjfoUF/qUp5StFumduh6zuP5o7j0wr6V/UwGH/T1dU86nmw
         8JZ38yO+Hs4nZtsrwKLUWMmdH9FrCI9HvTJWM7id1Z5rWr+J/wqwnS6rofk6cAxSb0dR
         OYuvsDaGSlB2GBbijboGzwNO++ZYTICHpeiRu8etwMXU9g5MapWdTLV+Vs3w6Yg3m7HY
         EWJpON4ipTuCk3ngpBSGUVsLCu/QbEisWjiq9UNak2cEMw71cBXLvz2V04T9zDqn7/xS
         xtUdGPsyGhW0v6C8QZ9SFOdMZBnBqIwGazVXN5W3KpQ7MLrbBFf6GRSoV5QJcGER+SUN
         rPBg==
X-Gm-Message-State: AOAM533eddj5jEd7YYcjjAXeYrWyb80c8jSOtm9L7TRrpyRPY4iqCik1
        oIDuMdvthY5K7Ow5Z+XJEHVXd8QJ218=
X-Google-Smtp-Source: ABdhPJzVeCAGP4RytGLTkUAes+uVbufTWS70UmFfWPkbGfg9ksExDUvqKn8X4QeZMZa2I8ay196uhQ==
X-Received: by 2002:a5d:5586:: with SMTP id i6mr12321574wrv.195.1625439319396;
        Sun, 04 Jul 2021 15:55:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9sm10697380wrx.59.2021.07.04.15.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 15:55:19 -0700 (PDT)
Message-Id: <2c4cd9dd1c8d966c8df0349bb820449ae1290793.1625439315.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v3.git.1625439315.gitgitgadget@gmail.com>
References: <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
        <pull.878.v3.git.1625439315.gitgitgadget@gmail.com>
From:   "Dennis Ameling via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 04 Jul 2021 22:55:13 +0000
Subject: [PATCH v3 6/7] ci(vs-build): build with NO_GETTEXT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Dennis Ameling <dennis@dennisameling.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Dennis Ameling <dennis@dennisameling.com>

We already build Git for Windows with `NO_GETTEXT` when compiling with
GCC. Let's do the same with Visual C, too.

Note that we do not technically _need_ to pass `NO_GETTEXT` explicitly
in that `make artifacts-tar` invocation because we do this while `MSVC`
is set (which will set `uname_S := Windows`, which in turn will set
`NO_GETTEXT = YesPlease`). But it is definitely nicer to be explicit
here.

Signed-off-by: Dennis Ameling <dennis@dennisameling.com>
Helped-by: Matthias Aßhauer <mha1993@live.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 0f7516c9ef3..c99628681ef 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -159,7 +159,7 @@ jobs:
       shell: bash
       run: |
         cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=`pwd`/compat/vcbuild/vcpkg/installed/x64-windows \
-        -DMSGFMT_EXE=C:/git-sdk-64-minimal/mingw64/bin/msgfmt.exe -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
+        -DNO_GETTEXT=YesPlease -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
     - name: MSBuild
       run: msbuild git.sln -property:Configuration=Release -property:Platform=x64 -maxCpuCount:4 -property:PlatformToolset=v142
     - name: bundle artifact tar
@@ -169,7 +169,7 @@ jobs:
         VCPKG_ROOT: ${{github.workspace}}\compat\vcbuild\vcpkg
       run: |
         mkdir -p artifacts &&
-        eval "$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts 2>&1 | grep ^tar)"
+        eval "$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts NO_GETTEXT=YesPlease 2>&1 | grep ^tar)"
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
-- 
gitgitgadget

