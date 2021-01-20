Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642F3C43381
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F73E23440
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbhATSmx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 13:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391914AbhATS2q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 13:28:46 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5759C0613CF
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 10:28:05 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a12so24007736wrv.8
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 10:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2V3y6i5n8BwH0jcwNs2T8NHykEtg/D0Vw0FiVg5n9So=;
        b=c3dA5chD87kMx2BE+bYTLyXvirYdGanJtJM/zPQ4TObCpsdXEniWT1SG9bYfJ58qcw
         bV7Bc41prKCLme2ic1eBR3sbRjqmSjsM9WGkg4t1niJi+aGVuRP7YQcfFpYyPSfIsQjL
         le5KF93hDTxm5UOjnKESsoRICcn5qgZgrBemJHghjg9tFQm+ighB6azsYCl9pz89w0Mc
         Y+3URjUkMmeOJ1MbBSSg7sk9are+gN70f/3YVPwest0Ek7aW8EZCr+qgE4yxl1aoL1lb
         ZpmD+3nkqPKA2W+LnhlOEWbVSXdpD6XgZOMgr4igyPlJ2GUI8alSLNkME4tvzIAuTPxG
         nfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2V3y6i5n8BwH0jcwNs2T8NHykEtg/D0Vw0FiVg5n9So=;
        b=WzNDJFNww+4ydhV1abxAK5MdlwmchS71RRxaU9Xpj7idhnGocUQUwSC7Ebjx/bsUOM
         tvFzsTQhnOdkyQFs8MUoNFv2g1qmnY6EA3ZBMvh1PXFR5thALvX7fEEsHrbUDNg4B22I
         VDKxUIrbP8ok0X/2EH8DreiOLrHvT+JAdlyZDAqVWnUsXaCd/oNk4yTObzIPsv6Gsmkh
         0pJ+yRxHJfnoL9pt5QTJ01IR0ngoImasKtGnQjxmlbYhwGMBDCOy8Qk3Aulr3A8MpO2P
         HCWdWE0kfE2HCDcwQrXgDAbac6vvo8e0StXl4BcNbtMsqlCkIToSmMK5062MBLWuup8d
         aV3g==
X-Gm-Message-State: AOAM533giu6ym4gbV0WH+bG/qxD8vXZPwg32zSKzlPJWRmkZyAsr2b3k
        g3j7AvPnH0TMD0Y5df7tMpgFiPPGzig=
X-Google-Smtp-Source: ABdhPJwAxHFIgdQvd4qWluwQrIEybsnYE+bsiPZ5BDvQAHp9DahWfFuyhdtBOlRiPRNwu9We531Xyw==
X-Received: by 2002:a5d:5387:: with SMTP id d7mr10307336wrv.417.1611167284248;
        Wed, 20 Jan 2021 10:28:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18sm5920942wrp.74.2021.01.20.10.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 10:28:03 -0800 (PST)
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
Subject: [PATCH v2 1/3] ci: remove GETTEXT_POISON jobs
Date:   Wed, 20 Jan 2021 19:27:57 +0100
Message-Id: <20210120182759.31102-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210111144740.6092-1-avarab@gmail.com>
References: <20210111144740.6092-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent commit will remove GETTEXT_POISON entirely, let's start
by removing the CI jobs that enable the option.

We cannot just remove the job because the CI is implicitly depending
on the "poison" job being a sort of "default" job in the sense that
it's the job that was otherwise run with the default compiler, no
other GIT_TEST_* options etc. So let's keep it under the name
"linux-gcc-default".

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
index 0b1184e04a..67852d0d37 100755
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

