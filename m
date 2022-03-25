Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878BDC433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiCYTkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiCYTiA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:38:00 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9526105AA0
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:10:33 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r7so4973504wmq.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ywie1WwJGTRWa4mqhGnsSwUCCnAwJ5Nah8p9uHXD2hg=;
        b=LcfM8cdNGjWRh1QxMQZAYU1X7sGxXyVyACuml21/BFu5CwLQvTPp3P/Q8WacshQYyq
         nVpUlXh8xb/tYyceoATbOXA9RT+yqPxeYbk94mw7WUHVTGdHjBQladfSzz7ch4IsVrwz
         TQHo8f/JX6M/+lE8iSMHnIctORFVkoSYD2ueXiyyjMbrQy+C8OydJgrQGhVd9tVp9+x+
         IZk3R9DPWCeLus+7+gbtcpZ8VbbqwSETNDtjEayGTrduOs6gQfsGBiHFTXshTM45vig3
         vu8yLeD6FVY56AfYhchIedD7pRk5TVhsSixROmsEQuPIUQOj2IKWXwjTAKn5rY1+vRwM
         GVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ywie1WwJGTRWa4mqhGnsSwUCCnAwJ5Nah8p9uHXD2hg=;
        b=smbutOQAhtqO1kfkGOzQbkLmyfF9D1SRDkkzR7FAIt2RzU7uWpQWAJ/wW7T2UlAjdF
         kNVN84Gl/4wWL2dsH1RWauioOUg4hInZEiZuaT871oVRAzIcUyiWJGQF9K850XOrwYpk
         Wk+i55BUepW4RFtpxNvqAp7a/XK+fyxfOFYXI6z9JZknYptT420j14sSysPJKj4vQpUr
         x0RBnb9p++GvoKPCBBVPuLS+ruydCMcaaJj4yOQsc4xcHCp6C9CvVav7AIPzP9nNGlBY
         6UlvmVmCHR7G2cj4ZsPHCxhQ3jXo7hOstUxW6jyCuNt/KLaP933O06tcrlUmQuBl/dLX
         hHkw==
X-Gm-Message-State: AOAM533cwi1YJZ8oOCqvDxLFwX81/iO5732Un/yaMh9hj4aId0A2n89l
        opSTkmhKl0ozaipVb7WFPpTeqHoUckDbPA==
X-Google-Smtp-Source: ABdhPJw2j9ReRAhWsMQY99cWj1+iVi/hSuVeA/hqaDdkiX0mwB0IqnZacHB3RFnxWWCIUrzhKJNkpg==
X-Received: by 2002:a05:600c:3847:b0:38c:a460:7679 with SMTP id s7-20020a05600c384700b0038ca4607679mr21148273wmr.23.1648233507286;
        Fri, 25 Mar 2022 11:38:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm6622411wrz.29.2022.03.25.11.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:38:26 -0700 (PDT)
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
Subject: [PATCH v2 09/25] CI: move p4 and git-lfs variables to ci/install-dependencies.sh
Date:   Fri, 25 Mar 2022 19:38:00 +0100
Message-Id: <patch-v2-09.25-3be91c26d44-20220325T182534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
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
2.35.1.1517.g20a06c426a7

