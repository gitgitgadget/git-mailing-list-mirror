Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FA7C4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 10:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiKYKAF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 05:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiKYKAA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 05:00:00 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8DD9FD0
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:59:59 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id a22-20020a17090a6d9600b0021896eb5554so7265813pjk.1
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRib8Rk4sTGCxnnBLDWNeG8JJpJ2LwUGEpetiFcLvMw=;
        b=OVZtkm+0yhq7ipBbgVn60oIJpXesRbLwocd6tpPFFHV/XTTc/nJbC/+EnihK+G2OT6
         4YPJcFdGgMR5CmEKlAKaUggr94Vrq62mrnkBUIGqnj1oseeLcknTgOboXSzPb+C+nR5x
         3yky3KvZ8JWuQnh4PVU/sktLNRJMDhJAN13BPYf4ndsAzU0Xejyeg4s5Q7N+vw91+Edd
         tX68YjuY8DGTwCMtgVk4PRBKnC+YH0QHy/VSOxncQYMjzhvMxomzQSZjs4c3lkv9xOjQ
         935fjsj4HsKPizVlhCgBm6A8PWepqIPXSWbo08WaJ/uHd97qtPxpsHINCFOt2gKL1oCL
         XSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRib8Rk4sTGCxnnBLDWNeG8JJpJ2LwUGEpetiFcLvMw=;
        b=AHUmdun1OwNI1Zjf7hz5Fn9o/6Fv0uIEzh4MvkVLdMtUd3klxGhErpK4Xsn3BKjL2W
         CBbR4N24q2RexOI4AmkK5GxWjdYdyzYQT/5OhYO6Ygl0kR8DD4CufozRLMqpb5hNNhVR
         4r01FjVLowyx6nSeX3NTRjMYa9QwgyRswHj7X+hh7U1X4uVKLJpWDuhoVisp9PW2dwAl
         kXBQNtTs84Tng6dRIRxGILa7x5DRQbQgO+cKB8YI3McdipaviCEXzmKZae4AbuTGgybR
         xarxrieuTer50eyM65QpWGCpgSNr5d5DcJO2sFEAoD3Ds1mZWZLFkuwEbUKhFID6UqBp
         KyIA==
X-Gm-Message-State: ANoB5pnd0CX7jh9RNK1leHef9VL54DpmC+i0s0In2W+unLIOzoJgHi4e
        7kZbJ4Snuhp95b2CQfw6RNJLYpf+b2U=
X-Google-Smtp-Source: AA0mqf6fEcRbvfDg0EiLSSL39w9sG2zi7E62n+9lfIwPBq2mWfmP+PZXT372iGZMU+Yzwps2Z6y3KQ==
X-Received: by 2002:a17:90a:ac0f:b0:218:bc3e:95f4 with SMTP id o15-20020a17090aac0f00b00218bc3e95f4mr22551967pjq.150.1669370398490;
        Fri, 25 Nov 2022 01:59:58 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id bd12-20020a170902830c00b00186b0ac12c5sm2904514plb.172.2022.11.25.01.59.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Nov 2022 01:59:58 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 1/4] github-actions: run gcc-8 on ubuntu-20.04 image
Date:   Fri, 25 Nov 2022 17:59:51 +0800
Message-Id: <20221125095954.4826-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221124153934.12470-1-worldhello.net@gmail.com>
References: <20221124153934.12470-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

GitHub starts to upgrade its runner image "ubuntu-latest" from version
"ubuntu-20.04" to version "ubuntu-22.04". It will fail to find and
install "gcc-8" package on the new runner image.

Change some of the runner images from "ubuntu-latest" to "ubuntu-20.04"
in order to install "gcc-8" as a dependency.

The first revision of this patch tried to replace "$runs_on_pool" in
"ci/*.sh" with a new "$runs_on_os" environment variable based on the
"os" filed in the matrix strategy. But these "os" fields in matrix
strategies are obsolete legacies from commit [1] and commit [2], and
are no longer useful. So remove these unused "os" fields.

[1]: c08bb26010 (CI: rename the "Linux32" job to lower-case "linux32",
                 2021-11-23)
[2]: 25715419bf (CI: don't run "make test" twice in one job, 2021-11-23)

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 .github/workflows/main.yml | 7 ++-----
 ci/install-dependencies.sh | 2 +-
 ci/lib.sh                  | 2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 592f9193a8..9afacfa0b3 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -227,17 +227,15 @@ jobs:
             pool: ubuntu-latest
           - jobname: linux-sha256
             cc: clang
-            os: ubuntu
             pool: ubuntu-latest
           - jobname: linux-gcc
             cc: gcc
             cc_package: gcc-8
-            pool: ubuntu-latest
+            pool: ubuntu-20.04
           - jobname: linux-TEST-vars
             cc: gcc
-            os: ubuntu
             cc_package: gcc-8
-            pool: ubuntu-latest
+            pool: ubuntu-20.04
           - jobname: osx-clang
             cc: clang
             pool: macos-latest
@@ -288,7 +286,6 @@ jobs:
         - jobname: linux-musl
           image: alpine
         - jobname: linux32
-          os: ubuntu32
           image: daald/ubuntu32:xenial
         - jobname: pedantic
           image: fedora
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 107757a1fe..feefd6e9bb 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -12,7 +12,7 @@ UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
  libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
 
 case "$runs_on_pool" in
-ubuntu-latest)
+ubuntu-*)
 	sudo apt-get -q update
 	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
 		$UBUNTU_COMMON_PKGS $CC_PACKAGE
diff --git a/ci/lib.sh b/ci/lib.sh
index 24d20a5d64..eb203662c5 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -226,7 +226,7 @@ export GIT_TEST_CLONE_2GB=true
 export SKIP_DASHED_BUILT_INS=YesPlease
 
 case "$runs_on_pool" in
-ubuntu-latest)
+ubuntu-*)
 	if test "$jobname" = "linux-gcc-default"
 	then
 		break
-- 
2.39.0.rc0

