Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E6DC47089
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 02:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbiLFCJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 21:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbiLFCJt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 21:09:49 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3167E248D2
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 18:09:37 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id fc4so2755486ejc.12
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 18:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUq7xuZ0D+6gVl+eHlL+oBolHtQjseWFXsJAh3CnkoI=;
        b=NjGFLCmKzeolp264bADeYs0WyFgitKH9riwVvVDXGSwYlsUdTZJMzz9ULwX9rQzqvh
         aFnnLVtI5A978ss+e+oBLtNS1gbrATxHOQOjN8CSpNTNiojCpD9ZnAWjaI0fq/0U0VQf
         BJNhayI0l5/ir9sJE9wjgsqaUGl9SPqCL1KoNJfpI0El5GNqcbuKkNuUEI5njK30BFDX
         IUMZ74z/MwHEDHTRbLtpUBX+ymjwjeIzdZ09jx9A712I0jBFtYmnEPwOfMHnic+bc+Es
         Os1KbTqyVvgEYKrd8XLVXxKjayn9yfRLfFXsIEfEqlb2x2YCjnC2MmbTOhIufNwDCNX8
         sajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUq7xuZ0D+6gVl+eHlL+oBolHtQjseWFXsJAh3CnkoI=;
        b=IRuzXOZ7+ki4m1XuK6Hp/RCDTCIKN2YapAgazeErgQ1tfTaRgYOfxlfT+4CGNaCGJZ
         hdvgtwZFpOCkyuhphX1QxTM6CaVtXbr5bh+h7tUCuyIl6/U2MNHSp/RJLAWdzNh5T802
         uBrgPyGN/fmiGthQGENmSRHQViNiHUlEwgNuyhZMZV7SP9D6MvCJqHm0r0zK8O5DiWft
         K3vr5j4DEVI2Tf6akq2YEbvqGLHWxDcPs/KCazdthxRQKaf5SpSOFfKxfGD0wusLDzXX
         z9wqCcS6zDoR+W7oHz6uBhCSQq57h2E4jwRtNq1LrPcnreB1Og/2U7ZxSnSkyiOFIMRo
         4F6Q==
X-Gm-Message-State: ANoB5pn9zBel+cYn+gzrxgmCPIvc787ihqOUNPiIrmMDKLlL6xOMhHTT
        oQ57mTx2HMxMutABmnsAARRN4mGDAN8D5Q==
X-Google-Smtp-Source: AA0mqf7Rw5VHgw5ExUJ013z1a2LL17Ttixh3H/ejDvlRl59K4tWnvDvfcUWl1QlSSANXn66ovDctDA==
X-Received: by 2002:a17:907:9c0a:b0:7ae:1e53:8dd4 with SMTP id ld10-20020a1709079c0a00b007ae1e538dd4mr28741371ejc.42.1670292575460;
        Mon, 05 Dec 2022 18:09:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b007c099174a12sm6966186ejm.178.2022.12.05.18.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:09:34 -0800 (PST)
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
Subject: [PATCH v6 08/15] Makefile + test-lib.sh: don't prefer cmake-built to make-built git
Date:   Tue,  6 Dec 2022 03:09:06 +0100
Message-Id: <patch-v6-08.15-b8448c7a8a6-20221206T001617Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.1006.gb4c675778ba
In-Reply-To: <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
References: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com> <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Per ee9e66e4e76 (cmake: avoid editing t/test-lib.sh, 2022-10-18) and
the surrounding discussion the goal of that change was to have
building with cmake and:

	(cd t && ./t0001-init.sh)

Work, to do so we need some way to make the test-lib.sh aware that we
have a build in contrib/buildsystems/out. The downside of doing it via
the GIT-BUILD-DIR facility in ee9e66e4e76 is:

- A "remove this file while at it" only fits into the Makefile
  dependency graph if we "FORCE" a shell command to be run, so doing it
  this way precludes speeding up the Makefile by e.g. making use of the
  "$(file)" function (for which I've got follow-up patches).

- If you build with make, then with cmake, and then e.g.:

	make -C t prove

  We'll run the tests against the cmake version of the tests, not the
  "make" built ones. It's important to get any subtle interaction
  between two conflicting build systems right.

Now we'll instead check if the top-level "git" exists, and only if it
doesn't look for the one built by cmake. This ensures that we'll pick
it up as required when the user is using CMake, without being subject
to the odd interaction of flip-flopping between the two
environments.

It also means that we can remove the rule to remove the
"GIT-BUILD-DIR", if we get to creating "GIT-BUILD-OPTIONS" in the
top-level git. That's because now when building with both "make" and
"cmake" we will always prefer the former for running the tests, so
there's no need to remove the "GIT-BUILD-DIR" file to resolve the
conflicts between the two.

In practice users are building with either "make" or "cmake", and not
mixing the two, but in a subsequent change we'll provide an out for
that "make"-preferring selection behavior, by having "ctest" runs
always prefer the "cmake" built one.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile      | 1 -
 t/test-lib.sh | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index b258fdbed86..c602ce57e64 100644
--- a/Makefile
+++ b/Makefile
@@ -3150,7 +3150,6 @@ else
 	@echo RUNTIME_PREFIX=\'false\' >>$@+
 endif
 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
-	@if test -f GIT-BUILD-DIR; then rm GIT-BUILD-DIR; fi
 
 ### Detect Python interpreter path changes
 ifndef NO_PYTHON
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 36358811a0f..c7d55ff0796 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -51,7 +51,8 @@ fi
 # For CMake the top-level source directory is different from our build
 # directory. With the top-level Makefile they're the same.
 GIT_SOURCE_DIR="$GIT_BUILD_DIR"
-if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
+if test ! -x "$GIT_BUILD_DIR/git" &&
+	test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
 then
 	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
 	# On Windows, we must convert Windows paths lest they contain a colon
-- 
2.39.0.rc1.1006.gb4c675778ba

