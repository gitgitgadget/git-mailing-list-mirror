Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A90C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbiDMTyi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbiDMTy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:54:29 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50C05F4D0
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:05 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c10so4156761wrb.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kYZ5DqbSSL4w0iww5+QZypYcPXBnFvdTFkv3iMHxxeg=;
        b=aHPwY4i1p/eSnkPRmwczdWSApVYSfRpM1JCW48dBneY3lLduVsE6Ha/lHOBEKlhvbh
         4xwmZ+OP9iNDDtgcHsEg4KnaytPy82gmLUgNwQMh5WAMFQ2gYe8JJHkVM0Nd8dhvsHLI
         TrGMr2d618oAtztichPufdy91tmOvWzPC49tJ4N3Jy8fYDHiMXX1//kbtHiYa7NM9PBv
         01RWOBCQdBYgZYRVfZ0OAOMh/ywsk4weEp3ng9SLz1LrkU03dh6lIgAJJAG4s4cOqMCS
         d2CaqYbf2+e7N2ipYV7US/2nAmpV+fR5SS+HxShD59uOBAlCU5SnXM4ajp2rmquRPtPU
         QYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kYZ5DqbSSL4w0iww5+QZypYcPXBnFvdTFkv3iMHxxeg=;
        b=kcm5xgMQAMceng/4z39mn435MgazknIC7KbHlem4t5apxUkjWKVyv+K7HEZJpxuonc
         qLE/SKP1NkSOAM19SRLt5maMvwjkYQQ6bwY32kGI4BoBvXaQD0dGjlM4O5zt6UvXZBZ2
         iHf66UapiORWhGY74hgOjJ+6dZ12m1tpqY4kxF2EqcoWTLCIuesT5cOuVD5XNog8Ad94
         qvG9RDQGk8QbzQqILMxQWpqt1SCOy0VBdYs3NZ+iDDFqFr3LKRfp6sTWD5XTQIypDV72
         H0wSBIBg3IpOX9lVOQK0vsIhqgf/T7kz8tlHiDSZQJ33blTFt6hNjY1+8VkjsVF3IwnR
         8rCg==
X-Gm-Message-State: AOAM530R73yLMYMkSNQoC53poWuq3QjSsTFXhdeBvcryao21S756Iwe3
        C20nxcGYz2XVIE98ihyPFeEmAu2R3RtVjw==
X-Google-Smtp-Source: ABdhPJysRhKR7kt9dXb1MIkwcvAYSYwTi7qhyb6i/VYGUbJNwkvBDN+2J8CpZz6WzToehJYfM4/GFQ==
X-Received: by 2002:adf:9581:0:b0:1ed:c341:4ed1 with SMTP id p1-20020adf9581000000b001edc3414ed1mr310646wrp.299.1649879523679;
        Wed, 13 Apr 2022 12:52:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm3432484wms.35.2022.04.13.12.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:52:03 -0700 (PDT)
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
Subject: [PATCH v3 10/29] CI: move p4 and git-lfs variables to ci/install-dependencies.sh
Date:   Wed, 13 Apr 2022 21:51:23 +0200
Message-Id: <patch-v3-10.29-9a31b7d5011-20220413T194847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
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
2.36.0.rc2.843.g193535c2aa7

