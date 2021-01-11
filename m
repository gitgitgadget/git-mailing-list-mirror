Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBE2C433E9
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 14:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE7A2255F
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 14:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388885AbhAKOs3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 09:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbhAKOs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 09:48:28 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EABC06179F
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 06:47:48 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id m5so14938wrx.9
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 06:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/khtcN2cKB92yLdvLortv7ZL2Exg1QOTImz56YhFsUI=;
        b=G9V4BigeUtUycPMu+bvMFv6EWDNrYtm1MG52QMqKZhcnzMQ1rIHdH+Y1JQqfDjoqfy
         c3xK/ETGNJi6m/vzZYMMKe/tbc7sbSOHNYONgafFFD0l9cXeaYLEb7XjzlyNgt8PZYWL
         h81+e2QuT7imGupWaIs0ZELBXfH2Yz6EKK7Vc8wXJhOAdmZ6Ro/tmd+/iqtjQb1wWwGl
         renidhfIdJ2Lsk+iwaJoUQfz2rPUH38nsP1DDtszycTSODk7ET5mRkC1BhYP84/KXvpg
         Ne4/kgzYtuKx4QKT/pmr5A6CxtOgtoya+Se8sC4oTGUdsGAe9JP1tnJayTNvpqx8zt3e
         0O6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/khtcN2cKB92yLdvLortv7ZL2Exg1QOTImz56YhFsUI=;
        b=FcNOM8QjHaheqZUxcKy322gSOsJa0xP/kderJm8EEbYDvoi7u0J8+0EM4MX+V/sIO3
         BrlhCsrh0RKWa9OPfEAG7bvi04DXUUsQR9J0XVwBxBITruWe8fie90erWW/jl4ag74eI
         vj9PKTvgQmMTLLMkig5ZYtv7/xW0Oi25balv6xtzPDLeTGr7JEKsnldTq7AOZvUU37PZ
         SJ9mnRI6MlVuhG75akcYwb3lYP8Mj7X/OkslTtsTv3fpgyqJcR5t1o0W6ufWBGk4Bf2F
         /sLt6Lzda9Pe/akdKwNj0dyIfiQTH4tsFxpTl/9NDv2UTk8O0ckxmUq6Oc+UGPjPDa+n
         LfQQ==
X-Gm-Message-State: AOAM531f4BLn8cQE9c7C5La/BDeusRFm4jTTFdix4Fen1V3ItQ4aHucw
        17O9VVs8DOXfGZGPRziIcLiqHfqTkiSMHQ==
X-Google-Smtp-Source: ABdhPJzFSpJ3mS7e5+hVH92Fnwz2Xk5Sm04TuDQykis7w8l+pc4obfBLfRA7mo/EixZYXIvtY46dXQ==
X-Received: by 2002:adf:80d0:: with SMTP id 74mr16985838wrl.110.1610376467110;
        Mon, 11 Jan 2021 06:47:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5sm26132697wrz.18.2021.01.11.06.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:47:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/6] ci: remove GETTEXT_POISON jobs
Date:   Mon, 11 Jan 2021 15:47:35 +0100
Message-Id: <20210111144740.6092-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <87pn2b6eyb.fsf@evledraar.gmail.com>
References: <87pn2b6eyb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent commit will remove GETTEXT_POISON entirely, let's start
by removing the CI jobs that enable the option.

We cannot just remove the job because the CI is implicitly depending
on the "poison" job being a sort of "default" job. Let's instead add a
"default" job.

This means we can remove the initial "make test" from the "linux-gcc"
job (it does another one after setting a bunch of GIT_TEST_*
variables).

I'm not doing that because it would conflict with the in-flight
334afbc76fb (tests: mark tests relying on the current default for
`init.defaultBranch`, 2020-11-18) (currently on the "seen" branch, so
the SHA-1 will almost definitely change). It's going to use that "make
test" again for different reasons, so let's preserve it for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml | 2 +-
 .travis.yml                | 2 +-
 ci/install-dependencies.sh | 2 +-
 ci/lib.sh                  | 3 +--
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index aef6643648..8b52df200f 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -286,7 +286,7 @@ jobs:
           - jobname: osx-gcc
             cc: gcc
             pool: macos-latest
-          - jobname: GETTEXT_POISON
+          - jobname: linux-gcc-default
             cc: gcc
             pool: ubuntu-latest
     env:
diff --git a/.travis.yml b/.travis.yml
index 05f3e3f8d7..908330a0a3 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -16,7 +16,7 @@ compiler:
 
 matrix:
   include:
-    - env: jobname=GETTEXT_POISON
+    - env: jobname=linux-gcc-default
       os: linux
       compiler:
       addons:
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 0229a77f7d..79c0633a18 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -72,7 +72,7 @@ Documentation)
 	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
 	sudo gem install --version 1.5.8 asciidoctor
 	;;
-linux-gcc-4.8|GETTEXT_POISON)
+linux-gcc-default|linux-gcc-4.8)
 	sudo apt-get -q update
 	sudo apt-get -q -y install $UBUNTU_COMMON_PKGS
 	;;
diff --git a/ci/lib.sh b/ci/lib.sh
index 38c0eac351..d848c036c5 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -220,8 +220,7 @@ osx-clang|osx-gcc)
 	# Travis CI OS X
 	export GIT_SKIP_TESTS="t9810 t9816"
 	;;
-GETTEXT_POISON)
-	export GIT_TEST_GETTEXT_POISON=true
+linux-gcc-default)
 	;;
 Linux32)
 	CC=gcc
-- 
2.29.2.222.g5d2a92d10f8

