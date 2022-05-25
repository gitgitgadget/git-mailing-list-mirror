Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482BDC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiEYKHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241902AbiEYKFE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:05:04 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B26D6E8FE
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id s28so29254562wrb.7
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JpJIpnNMNCEnGQxKxI7826SyALKsnBXTM1S8FbHNPUM=;
        b=C1LqAZ0ospXLppVVshNdqwGCrFF1+ZqDJEERWwZy6IhcVpivB2WyLMURcVKPtfEfcu
         fDQhzd504sq1EWuNGyO8Y5GN5FigDlG/JGj7KeCFMmlTw2WvnPuP7aM5FsIZ49uL8It8
         8AQ8R4URvyvPUkjX/UfvKPqNG/JOSE9d0l5S3cIOMV04TN8LyEUm9N3G7rDL6Y8bJyRC
         wcglaf6QF2/Bb/v9EnrS2piMcFRGIiCPubx9O5IokkYxegaPh/hlVKuBqz+Q/JWBKjj0
         FFX2R9pQhRV3/0KwPlkUqPi8VIwUggHpvSXZEkYTuQYCRp1Vx+6vaHdooyZrB32BNrqP
         jRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JpJIpnNMNCEnGQxKxI7826SyALKsnBXTM1S8FbHNPUM=;
        b=KK3aL1RP5kkCT6J9RCyc09DPmJi8uiISbNFFc6W8i5m331ovKHXT0TKh7HE2qwfKa/
         TstCE4n04zUkqSDr+Ch/G2lbUHgRdA0lkfr0ngb+dPHQlrrLE2nkEStnQoQFXpUCwSPH
         HGX8BvAIDfKL6PNTamjy+r1uMg4/HEmYqoMvXt+s3Y76qHE9wFflcvQocIBjJJ/J52o3
         X48agDKAauiXGdfbjiJIJYNxgF/Mf5G8oUyriPS2E1d7G+8CqgGctEePLteNofbH1Wsl
         x2Lmo8jZvJV0qudrTJD806lKcTDOAAuiAe5AC+qHMp6k6lD49wcI7OBrHWTeVIbMVm1o
         MDEQ==
X-Gm-Message-State: AOAM530v8x+hGfb5SCVz/tqUFQ8sLP3zR9kSEtChJchYDp6w0RZzJSeg
        W1oZch0yscJ82xUxK/P2wyBsUv4vNvP5Ew==
X-Google-Smtp-Source: ABdhPJz+3eTi/i0bpzcWb4A38bKLNiOEQ/IpZB0tMF84Z8VA+cBXSW4jfY+6yBSu6uiJ8fOx9soYtw==
X-Received: by 2002:a5d:52ce:0:b0:20c:e030:b05a with SMTP id r14-20020a5d52ce000000b0020ce030b05amr25872386wrv.174.1653473100818;
        Wed, 25 May 2022 03:05:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:05:00 -0700 (PDT)
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
Subject: [PATCH v6 18/29] CI: combine ci/install{,-docker}-dependencies.sh
Date:   Wed, 25 May 2022 12:03:57 +0200
Message-Id: <patch-v6-18.29-7925b2610fc-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
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
index 3e05d38d4ab..cc7fd3bd7f8 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -99,6 +99,21 @@ linux-gcc-default)
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
 
 if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
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
2.36.1.1045.gf356b5617dd

