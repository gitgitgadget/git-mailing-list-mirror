Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2008C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346282AbiDRQdQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346268AbiDRQcM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:12 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E47F3120E
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso12048199wme.5
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lL+uXFxLnlYak39cDgCQ9LuG1z3NwA2nI7Vbl7zmjg8=;
        b=ctYOU53n2ud7vWdcLNcb6pbww0Yp8BwJ+bCfDttjXPqwmTUWCGurXa6TwaCHbt7mJD
         kSAFMLYFWhAS8Xie2JuIUwtXHhy1L0CTVQKaLkVGuFHWA4jw0W4gNufwjBZfBuFU+M7V
         AmbNoLHPDuH67XU5loE0s7wLNwyoRudMRWmGY/+UU9Bq7RthdhGuPqzX7IzgrL7CjZ50
         ebejcqW+LJDmvXTHJ7LJzeSxkNOSVBLgOdwJC1/EPeFaoY2K4eQOpsFMZDI06h6+HcvQ
         /eww/1DgrqhS4Tr0r0+E6IwnDnAV0i+zQfC4pU2BBKoxSg4ZKMgDd+1+JRPHosHmX/ES
         xUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lL+uXFxLnlYak39cDgCQ9LuG1z3NwA2nI7Vbl7zmjg8=;
        b=1g7eO0Zc3nv3wCsJgGXr1B57m1uvW6+zWv9IPPC/DY5zYX6epx3qqtINE/hh8DfBEi
         wczQ2YMFEDAvPrkP0WQTO0KCPJKW5PUB8zryet1UNu8++305LJhuDLzXZCQz3hIsGPEe
         yMrSd6y0+IroBDLJNy6y5fGDG7h0vq9KAXe+3SC5DtVe2UT10JZsWLl+x4BHq+Cpq2lx
         ZZ+jbEkwJHWIpem99fM+jRNEqOYDWPdk0KGuc3/lUSVEXI8tYzSBZetq5zWMtxZoQiT8
         u7PZHqZVmMNQdQWqz4yfqvsCsBhlysoKgWS9HQhR6SCFb5cIV3S7iDvr+zbQy8Kt4sPq
         Sjiw==
X-Gm-Message-State: AOAM5328AgDqteGn+8UYs8eTfmQgksaRwxhyf1oLMxVUAvepwIqD52Mt
        UruiqyG0PJH3vmUY+HUC4cmjyjDtRPZpTA==
X-Google-Smtp-Source: ABdhPJzqLOl8TxjL5Rf5UZjFPsaopAqkRGdolnaaviLL6QVFm527eGfvHug2JVM4KdSOLple90ArtQ==
X-Received: by 2002:a05:600c:3585:b0:392:90a9:41dc with SMTP id p5-20020a05600c358500b0039290a941dcmr8999087wmq.4.1650299369625;
        Mon, 18 Apr 2022 09:29:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.28
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
Subject: [PATCH v4 18/31] CI: make ci/install-dependencies.sh POSIX-compatible
Date:   Mon, 18 Apr 2022 18:28:55 +0200
Message-Id: <patch-v4-18.31-eec7a11376e-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the unportable constructs in the "ci/install-dependencies.sh"
scripts to use POSIX replacements, and have it run under "/bin/sh"
instead of "/usr/bin/env bash". We needed to:

* Replace pushd/popd with a sub-shell.
* Change "mkdir --parents" to "mkdir -p".
* Use POSIX "export" syntax.

This is in preparation for combining this script and
"ci/install-docker-dependencies.sh", which doesn't have access to
"bash".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/install-dependencies.sh | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 01006379fd0..db58de0a6fd 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -1,4 +1,4 @@
-#!/usr/bin/env bash
+#!/bin/sh
 #
 # Install dependencies required to build and test Git on Linux and macOS
 #
@@ -21,7 +21,8 @@ ubuntu-latest)
 
 	P4_PATH="$HOME/custom/p4"
 	GIT_LFS_PATH="$HOME/custom/git-lfs"
-	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
+	PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
+	export PATH
 	if test -n "$GITHUB_PATH"
 	then
 		echo "$PATH" >>"$GITHUB_PATH"
@@ -33,22 +34,28 @@ ubuntu-latest)
 	sudo apt-get -q update
 	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
 		$UBUNTU_COMMON_PKGS $CC_PACKAGE
-	mkdir --parents "$P4_PATH"
-	pushd "$P4_PATH"
+	mkdir -p "$P4_PATH"
+	(
+		cd "$P4_PATH"
 		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
 		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4"
 		chmod u+x p4d
 		chmod u+x p4
-	popd
-	mkdir --parents "$GIT_LFS_PATH"
-	pushd "$GIT_LFS_PATH"
+	)
+	mkdir -p "$GIT_LFS_PATH"
+	(
+		cd "$GIT_LFS_PATH"
 		wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
 		tar --extract --gunzip --file "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
 		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
-	popd
+	)
 	;;
 macos-latest)
-	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
+	HOMEBREW_NO_AUTO_UPDATE=1
+	export HOMEBREW_NO_AUTO_UPDATE
+	HOMEBREW_NO_INSTALL_CLEANUP=1
+	export HOMEBREW_NO_INSTALL_CLEANUP
+
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
 	brew link --force gettext
-- 
2.36.0.rc2.898.gdf6bbac50ff

