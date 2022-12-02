Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E14C4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiLBL31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiLBL3B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:29:01 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42661D3A11
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:28:51 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id a16so6052752edb.9
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 03:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRpMaTgX+0WS90R1rSOR0tedgz2fOezT5GMnc+2qBOQ=;
        b=p1uJSrWAk+L6SwW+07ybkEYLLKXrjYxGYKtX9g6fzkF9mpbp8kYljzZzolf3W6gA1D
         aZlNJMnU+mHKwrHomEsuRHhKCeGUGvC6r831TyQhP+joWeoTyQtf7RpjkBbBzbBsHzYI
         Sy53VP507cD+uE1nd3G/FPGA3N89bbf5//wPbAJx2pEai1Ch54xR7PNSWBGQdIBHviWl
         4I18ZJayM5v8Ta05pSEfpr7kMdDJy3zBdyYYjczJ+FAfzoL8C+AC9kxtWAMAkpxdmK8k
         bHIo16UKIBn2/xyrAdeOC4E9vx78ZFlltXvk7afjc92UghsRHZ6DW3oeoDxJRuta0noC
         /LHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRpMaTgX+0WS90R1rSOR0tedgz2fOezT5GMnc+2qBOQ=;
        b=0dKoNrqE/TIUeV6XpHvzCG5R6tkMhv7DSBkPV0r/6UZyTIkFYyr8daCM2pIpNJPsbo
         YT7VT/i+16r/M8TqOtZ1Xb2Lj0dOXXUPv4LUQbqe4xtvDMNlNigj4Pac9neHK+mWmoQ5
         cYbnkxl7gDa1blF6p7577WfmTYZDhOMH0ZlmPHv3Cu/A3+FswBkIcQKJNQFAkGv6DEyV
         NVMMQmaWiPmoSq0Rsq2z6/5KQERbIyz6SUzFhghmq6d6Zm1GhbujlTMTSB/DqgEcBwPj
         n9RRMkIoT3MrINY1zFJRZFLsMPip9HQjSvkVyiuqEK+Xpp1r8YCgGHmdIY+g6b6kizex
         vUFg==
X-Gm-Message-State: ANoB5pn+n0WLy0oJteY5b75npQdSfp598iQtvSm98neaEZprNl5nTPWI
        8pVEdmjD9gGRhtP9EK7ikhMoD2MoUzjq+Q==
X-Google-Smtp-Source: AA0mqf4bZCYRSbXjVXpWgXadd4JUQ4bj06lBQeiFZ4sBVKwnIH51O7eLEN3EroGMP4vhAXafOa5x7w==
X-Received: by 2002:aa7:c754:0:b0:46b:6096:a884 with SMTP id c20-20020aa7c754000000b0046b6096a884mr17436311eds.152.1669980529228;
        Fri, 02 Dec 2022 03:28:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7df97000000b004611c230bd0sm2850780edy.37.2022.12.02.03.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:28:48 -0800 (PST)
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
Subject: [PATCH v5 08/15] Makefile + test-lib.sh: don't prefer cmake-built to make-built git
Date:   Fri,  2 Dec 2022 12:28:29 +0100
Message-Id: <patch-v5-08.15-9e10cd5bd8a-20221202T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.981.gf846af54b4b
In-Reply-To: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
References: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com> <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
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
2.39.0.rc1.981.gf846af54b4b

