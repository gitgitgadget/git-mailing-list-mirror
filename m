Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68DAC433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346352AbiDRQdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346267AbiDRQcM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:12 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F822FFC0
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:32 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso12099277wma.0
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nrZkbMjpJo1GfRus8xCpCuztuPRLTHMFysiUl4sI/nQ=;
        b=FD5Okn1vhXudIBP275ejKPqw4QKjLvCciYdxs6GABY7TCOsR0M2rDTqM3N3/SywRPG
         wCGW1yuLpfGIYL3QnxW52hQDoctObA1wREs/uyY/MMyGtnCwx3sQZwo8z7smtvsLEWkl
         RjRMu9xaU8OdI4r4TkkoB/1EvrePMhReSveMr0WE1zdRHzd/Vsh7Kg43r38/kL05iKhs
         lf1XmiwlYV02UIgoT1tolwyRbvqMUTOO+XjjsSOrtcDNHQU4lQOrkxGnwm6tFk5A5R+a
         oK9PLxyrQq6A80GixMJr4QQbl6ezkh78qO6mifyvJgxaRe3z98FsJKbeJmYyeqcGIVal
         /w4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nrZkbMjpJo1GfRus8xCpCuztuPRLTHMFysiUl4sI/nQ=;
        b=YOjG5oRG8hSzqzCzg/0oVhRrvPiZ7soX8oZ2kGbt7XzRhy5hacByWKtDhMRUdsWQFP
         99tD0yFivCOblTC3S9h7sBObYfs8R8nvOZo8pm0kNv1EtbOdJvDBmAVw8VVuVpbA5+md
         S7889iLBfjrZMiyPnLn6y+aJyOSj8QzJrRatffH1alhjpqrpnPWvgdV8j4oQfCM23q88
         zxH1JA9yfAzigURWtes73Ng5WzykrV1muyO7Xtwb6gsXu/LHLXdI7l/8kCUzMKcJ9rG8
         flavbFLSjp/a5YsiN0moSWkizWMWHiw65Sgy9kCVpJ5ZKa3Pa+HwquK1DRf46HHCJen/
         uC4A==
X-Gm-Message-State: AOAM532qVTjK4G+0O5XWBwk0XmzBI+d9MpVssZAGz4P8RDb8+82MyPfe
        l8ijqofbmmMWO0WPv1AT9sfdr+Ge41Yn+w==
X-Google-Smtp-Source: ABdhPJyaIXv2jmTyNawfH36MUKVdPHvyzLdAtZY6H3/6TamHPjG20PJ7N/8jqivJ/TDYB4zTaFZIew==
X-Received: by 2002:a1c:35c2:0:b0:38e:c75d:90a3 with SMTP id c185-20020a1c35c2000000b0038ec75d90a3mr11795097wma.98.1650299370503;
        Mon, 18 Apr 2022 09:29:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:29 -0700 (PDT)
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
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 19/31] CI: combine ci/install{,-docker}-dependencies.sh
Date:   Mon, 18 Apr 2022 18:28:56 +0200
Message-Id: <patch-v4-19.31-a9c98582de1-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Combine the "ci/install-dependencies.sh" and
"ci/install-docker-dependencies.sh" into one script. The "case"
statement in the latter only cared about "$jobname", and can be folded
into the same "case" statement in the former.

The reason they split up is historical, until a preceding commit
"ci/lib.sh" required "bash", which might not have been available in
"docker".

This also fixes issue in "ci/install-docker-dependencies.sh" where
we'd hide errors due to not using "set -e". Now that we include
"ci/lib.sh" we won't have that potential issue.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml        |  2 +-
 ci/install-dependencies.sh        | 15 +++++++++++++++
 ci/install-docker-dependencies.sh | 22 ----------------------
 3 files changed, 16 insertions(+), 23 deletions(-)
 delete mode 100755 ci/install-docker-dependencies.sh

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 92b914f16fd..3fd3e4f873c 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -311,7 +311,7 @@ jobs:
     container: ${{matrix.vector.image}}
     steps:
     - uses: actions/checkout@v1
-    - run: ci/install-docker-dependencies.sh
+    - run: ci/install-dependencies.sh
     - run: ci/lib.sh
     - run: make
     - run: make test
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index db58de0a6fd..8e41747ef6f 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -97,6 +97,21 @@ linux-gcc-default)
 	sudo apt-get -q update
 	sudo apt-get -q -y install $UBUNTU_COMMON_PKGS
 	;;
+linux32)
+	linux32 --32bit i386 sh -c '
+		apt update >/dev/null &&
+		apt install -y build-essential libcurl4-openssl-dev \
+			libssl-dev libexpat-dev gettext python >/dev/null
+	'
+	;;
+linux-musl)
+	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
+		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
+	;;
+pedantic)
+	dnf -yq update >/dev/null &&
+	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
+	;;
 esac
 
 if type p4d >/dev/null && type p4 >/dev/null
diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependencies.sh
deleted file mode 100755
index 78b7e326da6..00000000000
--- a/ci/install-docker-dependencies.sh
+++ /dev/null
@@ -1,22 +0,0 @@
-#!/bin/sh
-#
-# Install dependencies required to build and test Git inside container
-#
-
-case "$jobname" in
-linux32)
-	linux32 --32bit i386 sh -c '
-		apt update >/dev/null &&
-		apt install -y build-essential libcurl4-openssl-dev \
-			libssl-dev libexpat-dev gettext python >/dev/null
-	'
-	;;
-linux-musl)
-	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
-		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
-	;;
-pedantic)
-	dnf -yq update >/dev/null &&
-	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
-	;;
-esac
-- 
2.36.0.rc2.898.gdf6bbac50ff

