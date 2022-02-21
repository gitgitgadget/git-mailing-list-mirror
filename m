Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEE9C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378350AbiBUOsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:48:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378312AbiBUOr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:47:29 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D02B6266
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:47:02 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id k1so27491878wrd.8
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jR8UhyEfKlABU1DWsZl4GRIBnrDbe+8EI49UjDUamhk=;
        b=Y/CBMch0nzOBuDMXJeEfUxBXP3DMVL2I51q+mC3aMAk6rrPOmQ+fmvEp1fvlFA6LyU
         ATYMosTtFPBBQLHYb/M6fFimp7+klO3W7S2Z+vJECa3E152oz0aVsl/CgKyBO46PRVrs
         t5kDxxzZkVF8hSZU1mPJZEIj0Rl1SLUzii4QgdCI4TmIKS+3E04UgNngNXQKduvBMN8c
         Ecgubei/nycRKhbZs8IhRE1YeYUU/OQL9jKqlUV1TZ2dzra/tC36F3MHeLZPE8GPKQea
         UJchSAyF+tQrNN064rRZ8ehWIPjn3HNa3rZSiYYHi3Jatrw16ZQ4fILJev6fAh08HA+4
         88TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jR8UhyEfKlABU1DWsZl4GRIBnrDbe+8EI49UjDUamhk=;
        b=TUhydAKQG9v4NcIoRRXlTT5nH737qiRl4H0f//nrQmnyNEuSVnnI0Usnd0gN/aiFRr
         XnPvbMRZkQu3AyXw9SKarQZ8FI2BWPILqJHa1K2OquRwUz6LUjf05eUitF4zsLDAe94A
         k4fKyTE2vg8lmXn//gdiPhOG8SBdZr6DYKBrxUi2O2zCuXIG3Hmq91uxgAZHjYcukz5X
         I4psUFAdJQq4nvM+ABU5NWfIwxErsQCU2+H88PTveG/FaPvHkNmUoh1hKO+OUyOIbqxy
         7Oq+rc4eeYiDmCzCyyN8yfPBBbHwQ5h5D1zO4+mEGF/0UfHnXbVwSQCX+f5R5itq1Q7X
         D/+g==
X-Gm-Message-State: AOAM531FPoZWNjgLlDlrC0CM45UJXWeSO8G6qgi8M+0SSYLfEYhTO8lU
        yZFSFxRf1ciQh+8y7wpqBeeuk/LjEcAD6g==
X-Google-Smtp-Source: ABdhPJxIZxIGhICSXBwG4DXmvqygtTxYkkmJQzthS/bynx/Q6OO+q354THczr3pmCBlTfGXFMvYmbw==
X-Received: by 2002:a5d:6b06:0:b0:1e3:3e52:8a6 with SMTP id v6-20020a5d6b06000000b001e33e5208a6mr15741937wrw.148.1645454820770;
        Mon, 21 Feb 2022 06:47:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25071094wrz.84.2022.02.21.06.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:47:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 14/25] CI: invoke "make artifacts-tar" directly in windows-build
Date:   Mon, 21 Feb 2022 15:46:26 +0100
Message-Id: <patch-14.25-aecd3ebaafe-20220221T143936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the windows-build job to invoke the "make artifacts-tar" step
directly, instead of calling a "ci/make-test-artifacts.sh" script.

The script was needed because "ci/lib.sh" would set up various
environment variables for us, but now we can instead use the
"ci/lib.sh" in its script mode.

The "mkdir -p" added in b819f1d2cec (ci: parallelize testing on
Windows, 2019-01-29) isn't needed, the same commit added that "mkdir
-p" to the "artifacts-tar" rule itself, so we can have "make" create
the directory for us.

This also has the benefit of making the "build" step less chatty,
since it won't start with the verbose "set -x" output, that's now
contained in the "ci/lib.sh" step.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml |  5 ++++-
 ci/make-test-artifacts.sh  | 10 ----------
 2 files changed, 4 insertions(+), 11 deletions(-)
 delete mode 100755 ci/make-test-artifacts.sh

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 05c5771e7f6..2c23a19eac2 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -87,12 +87,15 @@ jobs:
     steps:
     - uses: actions/checkout@v2
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
+    - run: ci/lib.sh
+      shell: bash
     - name: build
       shell: bash
       env:
         HOME: ${{runner.workspace}}
         NO_PERL: 1
-      run: . /etc/profile && ci/make-test-artifacts.sh artifacts
+      run: . /etc/profile && make artifacts-tar ARTIFACTS_DIRECTORY=artifacts
+      if: success()
     - run: ci/check-unignored-build-artifacts.sh
       if: success()
       shell: bash
diff --git a/ci/make-test-artifacts.sh b/ci/make-test-artifacts.sh
deleted file mode 100755
index 45298562982..00000000000
--- a/ci/make-test-artifacts.sh
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/sh
-#
-# Build Git and store artifacts for testing
-#
-
-mkdir -p "$1" # in case ci/lib.sh decides to quit early
-
-. ${0%/*}/lib.sh
-
-make artifacts-tar ARTIFACTS_DIRECTORY="$1"
-- 
2.35.1.1132.ga1fe46f8690

