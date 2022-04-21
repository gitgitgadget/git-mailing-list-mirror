Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF307C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391317AbiDUS13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391324AbiDUS0p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:26:45 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E054B1C4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c10so7864233wrb.1
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TNUVJxC79CfszbM9CXqmRo7F85wzo5iIoKEaX8LvQfU=;
        b=W/4ijIaqoDOiYiZRMpwp5f3T5ZJFJsEOkOxL/VOwM5PiEzMpL8yo5cr8mkGIDMqOuO
         gPnUag/WvGtlGJ9DNTzfIwkB/SsgDdEQDjybXTZ+AmKTfmYCrtPCiD/NFySDrNoQhN73
         3LqcdHpRm8bQLVaZ4e3GlwQCmFhJo674lMbUV/eCoGhokaO0a1WIIqGFymP7rMN42m3K
         frd6jIrmYTXlT1wHrq0zx0l5EOG6ZwDT0Pa4BTjlRECRlPWK3a3vhso+8yde1JGQC4MA
         tXlZW10zFI2OI309A4NL9QGFNwhmi/uR4QXyN4S3OvfScNPKpEJe2NS27FKLDHJHnrUx
         HGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TNUVJxC79CfszbM9CXqmRo7F85wzo5iIoKEaX8LvQfU=;
        b=EX+maJ4oWOOaNu6h/HS7fn7MBx9SxXdPX5+3E0pZzL5df4Bd2YZDc337w5A3+lWBNB
         Mf0RdQ8GWiZW0VjjVGXdzvxmOWHPu6pMbCwCn+RFWL+kXEaKXWPHgQbTFaPnUdeGIYRE
         Et+VD0dzt+rqMHugFBTO7BlnLSWnbSrBEnYz0aLIm1t6Jh+BXt7XV5fkv7N1XLa17Lvk
         +zYlkvWZJGNk+jr8tHjCMULtRWm+i8YAoeH2FMO68g7js/w/n656YnOa4BQiMvPRExbE
         g8aJuBwIVvH85qVVSt1c2lkUJKV4MXtPmP4Og6AzA2yz95ZKBuoGRXOWNig69didB0Cc
         iT2Q==
X-Gm-Message-State: AOAM531eP93LWKv3buXzfH49oFwRjVS172Z2aOI/DlFn7wzY90wXAteo
        Y+VEXunvCIHkFynqRgkZZTSDBFXN91IeZw==
X-Google-Smtp-Source: ABdhPJzF/gascFQmuOXJ1QZxrPE3s0J6gUw3A+L6hQFTw+XMmbTPj7QAQMjhkHZPl435iJ4pXOLChA==
X-Received: by 2002:a5d:6981:0:b0:205:e04a:e20f with SMTP id g1-20020a5d6981000000b00205e04ae20fmr759757wru.6.1650565432370;
        Thu, 21 Apr 2022 11:23:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:23:51 -0700 (PDT)
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
Subject: [PATCH v5 18/29] CI: combine ci/install{,-docker}-dependencies.sh
Date:   Thu, 21 Apr 2022 20:23:13 +0200
Message-Id: <patch-v5-18.29-a218be76819-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
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
index 88eb2ef2dad..42944020436 100644
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
index 1ad4dd7db39..adece989491 100755
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
2.36.0.879.g3659959fcca

