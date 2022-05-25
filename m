Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C620C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242226AbiEYKFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241512AbiEYKEz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:04:55 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCBE6D970
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:54 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t13so10213608wrg.9
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pv23aLRm7M7M9zoZ6G4oiLO8NHwTny1h9XdPo91/9/o=;
        b=gXXrnOyMSGqIbtCgYyPmBErucLEa2eFKLTDLoYoD0A8JdOE20tHaRIXGXWys7b2Ubu
         I3whN4ajanbFQtBwDW7Elp+rXPuJYwTSvZljIpCT4305oLvPXtvLQqu5JapfwCwmmw3a
         T/PtR+9KsgfnYhQzYyJkh7NRub4h0633J3bGhkS74kWSrWmo5OSRlrQD7PGDzpnBUhR7
         FiO+loZleAUP2/UoEXc2n2TZ9GU7U+HvBFBn2w2LqPIsfI75YibDDW63dOVRI/YPtgk3
         lq/4xGJJ0LDQ3SxwMmbkr7D3YR3jMyraRqeuSRdbd4yLiXTGggLkhyLQGd4A+hfdEJ/K
         kZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pv23aLRm7M7M9zoZ6G4oiLO8NHwTny1h9XdPo91/9/o=;
        b=T3/fRvlhlr5WC5ANM+DVKNdVLBPiCJRr7FtPz4UJi9q1x6FjatNXZtnonD6kMxBlgq
         PmB/BjXkLDKb8jaokEwLSSmK0dllG4UdteP/nZ20f6H23AY/r+v5GeZZHGwgNS6Iyd2k
         r+WqOKOBIhlBew92cP8bwGhmme1yqdAqhiV9JQPpa0qYD8yEb1opL6uWjoYdti+aNpps
         IFj3Gj/pDD1TjBnPf6AeqCv97/NKdWhF16SKlJJf3wQuVpKoNiw8bBO9ahFRHstuFbAd
         Hzo3CRoUeBNf2xOwq3h/25oafW1jCZz5vyL1YnhkMEXCAaG11glp7SZVkiiQBFhC++P+
         gGxw==
X-Gm-Message-State: AOAM532e7JmlND48zlEHv9vVYbxx9XyjvaUvYsZiSrl3UY75JVzuzx5U
        30JBw3AM+7EoIH+H2aZf/OjOnCkRdPKcjA==
X-Google-Smtp-Source: ABdhPJxjfiiPM951xOjOpWQZAbvo1dTixVC9yMNS5aJAVtVyutavwjitvF4XbPTPLodgEAVg6JSCgw==
X-Received: by 2002:a05:6000:791:b0:20e:615c:aae4 with SMTP id bu17-20020a056000079100b0020e615caae4mr26535754wrb.206.1653473092293;
        Wed, 25 May 2022 03:04:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:04:51 -0700 (PDT)
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
Subject: [PATCH v6 10/29] CI: move p4 and git-lfs variables to ci/install-dependencies.sh
Date:   Wed, 25 May 2022 12:03:49 +0200
Message-Id: <patch-v6-10.29-e208a9ab1e2-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
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
index 4fa3e282dda..41a9185bb1e 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -5,14 +5,27 @@
 
 . ${0%/*}/lib.sh
 
-P4WHENCE=https://cdist2.perforce.com/perforce/r$LINUX_P4_VERSION
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
+	P4WHENCE=https://cdist2.perforce.com/perforce/r$LINUX_P4_VERSION
+	LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
+
 	sudo apt-get -q update
 	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
 		$UBUNTU_COMMON_PKGS $CC_PACKAGE
diff --git a/ci/lib.sh b/ci/lib.sh
index 5f95f55a147..e789cd2a1cd 100755
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
2.36.1.1045.gf356b5617dd

