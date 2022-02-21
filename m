Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7842BC433FE
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378317AbiBUOr5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:47:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378305AbiBUOr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:47:29 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8186D5FCF
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:46:57 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v12so27529544wrv.2
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EhDGSve0vZuK/v7hn9A3BTJOjFaVHhTjk6bB5p9fNgM=;
        b=StRGXmDNf5OR2C+taFvvMpexKpSco0pr0yj/NXulRPM3M6NnL+mXitKFeXjMZ609ej
         KjqwITB+JqATaZNa9SBSPPlV1jRdxhhqCrir/wLK1qLhrb+TmaYxCmP+7sSgP22rqT1e
         hQ5UTczMz8iOy6dn9UkSsHFsW2fFrRyZWkQFmz9lrh1GxB1DLdBTTrcUO6u2io0bb7kI
         wTnQ8sowbV8qRuVd5PwhKt0VFl4OaPmKNgh4QEsWOiTDF/qIgQoNk4QEjgIaSJGL2W+y
         5J2+MIp/tBLEiZUt4vBB1MOLJIbC2+KWKPhJbt9+CNZV45/dm8WXucVdQVP7AkFk8sx1
         5J8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EhDGSve0vZuK/v7hn9A3BTJOjFaVHhTjk6bB5p9fNgM=;
        b=vf0ROgs0HeHpP0p1dwW7JImXaDT1jTEyI9nFTZw49O5K6uChQBRAYSP1AeC4N8NUdu
         pIi72m/UIngqsJpPjJBVwFF6n9VKodU24P6j78sz/92i5gMPIZIE4GgAigEzAcm0cH8X
         wMXfTMDY3slk6pJytcwxlA3jTXtSXUKkkXa//sG3rlALL8o/U5KbcOaQfsfwaFDj2AKE
         EPPjixKzuvUfxOIt74gh0neUI4wCunGb1R35G3AUSRiM7wemWSMsZxDZ9r1UDFFZhOfA
         cPM7eaie38XGqEFSAQ/RAyy9zqcxBH/TmJEw1bW58ZI/NbAuMibfI+jGC6qhpIt88Vd+
         zczA==
X-Gm-Message-State: AOAM5326cs1pJOKl4FXu1/bGXMULVL8k9OVMqrHw1ECJtGDBWpjM6LV/
        qY07xpHFPszzZ6bD//bYPpr+VhisdEjRKg==
X-Google-Smtp-Source: ABdhPJyqktaP5bzzaUTerr63XoarTDPD8lgy68onv0eMhKq2bqq8/zJ74UjFR+Xi4vlydHh12onqGg==
X-Received: by 2002:adf:e5d1:0:b0:1e6:1109:5a11 with SMTP id a17-20020adfe5d1000000b001e611095a11mr16065192wrn.641.1645454815876;
        Mon, 21 Feb 2022 06:46:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25071094wrz.84.2022.02.21.06.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:46:55 -0800 (PST)
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
Subject: [PATCH 09/25] CI: move p4 and git-lfs variables to ci/install-dependencies.sh
Date:   Mon, 21 Feb 2022 15:46:21 +0100
Message-Id: <patch-09.25-a1d0796259e-20220221T143936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the declaration of variables that are only used by the
"ubuntu-latest" block in "ci/install-dependencies.sh" there from
"ci/lib.sh".

This makes the code easier to follow, and changes "ci/lib.sh" to a
library that only exports CI variables for general use, we didn't need
to export these $P4_PATH and $GIT_LFS_PATH variables.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/install-dependencies.sh | 17 +++++++++++++++--
 ci/lib.sh                  | 12 ------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index e7ea8799411..34b4400f38b 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -5,14 +5,27 @@
 
 . ${0%/*}/lib.sh
 
-P4WHENCE=http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
-LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
 UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
  tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
  libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
 
 case "$runs_on_pool" in
 ubuntu-latest)
+	# The Linux build installs the defined dependency versions below.
+	# The OS X build installs much more recent versions, whichever
+	# were recorded in the Homebrew database upon creating the OS X
+	# image.
+	# Keep that in mind when you encounter a broken OS X build!
+	LINUX_P4_VERSION="16.2"
+	LINUX_GIT_LFS_VERSION="1.5.2"
+
+	P4_PATH="$HOME/custom/p4"
+	GIT_LFS_PATH="$HOME/custom/git-lfs"
+	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
+
+	P4WHENCE=http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
+	LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
+
 	sudo apt-get -q update
 	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
 		$UBUNTU_COMMON_PKGS $CC_PACKAGE
diff --git a/ci/lib.sh b/ci/lib.sh
index ad1aa59a384..6b37b10d750 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -65,18 +65,6 @@ ubuntu-latest)
 	fi
 
 	export GIT_TEST_HTTPD=true
-
-	# The Linux build installs the defined dependency versions below.
-	# The OS X build installs much more recent versions, whichever
-	# were recorded in the Homebrew database upon creating the OS X
-	# image.
-	# Keep that in mind when you encounter a broken OS X build!
-	export LINUX_P4_VERSION="16.2"
-	export LINUX_GIT_LFS_VERSION="1.5.2"
-
-	P4_PATH="$HOME/custom/p4"
-	GIT_LFS_PATH="$HOME/custom/git-lfs"
-	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
 	;;
 macos-latest)
 	if [ "$jobname" = osx-gcc ]
-- 
2.35.1.1132.ga1fe46f8690

