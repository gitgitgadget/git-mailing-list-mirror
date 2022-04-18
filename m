Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612C0C433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346256AbiDRQcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346237AbiDRQcK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:10 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BD730573
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:23 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b19so19103247wrh.11
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d0sXNE/dgFltvX/BiGHV9JJD9ZeYB57oScaZ3ZM9gWE=;
        b=kmAd8cUw9dDS4KJYaAodDZw9ieRykIeCZ84IuYPHxnVJ4LDvcxV8o6nBKl3UfpoeC+
         EAX6EiBKHltiyJszOgM717xdrfelhEv8DuNwNbVQry5+nZ7uxRnci+lePX440oZKki99
         Y4MvbHza/BIzOJr9hjlzYEH0mnmW2ap/q1Cf7NFKlG5/GnMFFaXXXlaIk8XFKWbmpbgX
         YLT/WiZAnLdL6WhizN24DZe1tIsqzv7WXNUFNwX9G+feKbJZ63k5NYs7P0n0/eHKVxOC
         so1PmPhr33mEwg58+dorJH45bOOcQx+t83oy8X/amT9Kv3B3e7YGW/jx+FF12Wnt2ayo
         lEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d0sXNE/dgFltvX/BiGHV9JJD9ZeYB57oScaZ3ZM9gWE=;
        b=s0nIckLE8NOVitNPP3SIcvR7W/ytmLiHyc8+lwn97Kqui2II4bZYTRjmHATcp17IZj
         xcI9LfkACr+DMkt7tV+klPK9GKJvytAJ8jQtkyI6XO1dCWSWjbjnCGXcQvcU9dQAgVbk
         ANio/xBIz4/+HtDYtNbZx5ulnG1ZLnFuRQPyvgOte7uYOMUyG0puAwECPF0gczjiJlfo
         w/de1NHOJwRsHxdLH4kvzzwkLHv0a8sK4jjWzTy+TUx0wbxz5bVCJ3jlh/OW14ePwQQA
         N9c8cwzE7YFZHH/G0Q0eob2is/B4zLZH20xkw+0rJTxZtAjT8TQ6IbD9kGzOwXU7Itgz
         9CyA==
X-Gm-Message-State: AOAM530rvNWieMc+K2Rj4bzfJAIdS9Y6pGkEU3A6fEBp6tKkNY52oI79
        drhwZmJX0SdlU45/Vv+eGKCleI9p5hSW+A==
X-Google-Smtp-Source: ABdhPJyNeUHfnq0RLxdD+PeIzuKYllbk6RG4w6cpIp1km6ocz5iECcp7i1Ipi7KTZA9PZhhn4vD8gQ==
X-Received: by 2002:a5d:588a:0:b0:204:1f72:2d90 with SMTP id n10-20020a5d588a000000b002041f722d90mr8927478wrf.651.1650299361793;
        Mon, 18 Apr 2022 09:29:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:21 -0700 (PDT)
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
Subject: [PATCH v4 10/31] CI: move p4 and git-lfs variables to ci/install-dependencies.sh
Date:   Mon, 18 Apr 2022 18:28:47 +0200
Message-Id: <patch-v4-10.31-3cdeae9c141-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
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
index 21c009757f4..5736a4d2e04 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -67,18 +67,6 @@ ubuntu-latest)
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
2.36.0.rc2.898.gdf6bbac50ff

