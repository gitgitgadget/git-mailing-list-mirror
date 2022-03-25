Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FABC433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiCYTdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiCYTdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:33:25 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A651C22387F
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:08:21 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id m3so14897802lfj.11
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lgyXwip1A5ETbGMBBZ7S54p6R7mk1sQNL9D8uDJUYmI=;
        b=P9pQXuvL5IRuL73DisroljbyPLPteoWCn2e4abNL+zaWCcnNjYLfmsDMoAX23T+6rJ
         mf+Z0pJf+T5P6fB4+Iw5/+/3Sw09SAyUFzcsTZ/45NcRHPfFmsVtT1KWwYewoD+jRLeb
         E8AAmbnUsqlt/dpedWNtXd8BNTsFlKhIZwo9465af1BM/uUVnmiq2I1gSjq3sHd/D5nl
         xcRTcq5bP/+c0WCjhLw/abzmc544tvOhlQzxR1eC74gxRCL/rHKbu5SRg8fui5RmoIWH
         rMeJP3R/ea9QEe8zjC+BkBePvwshMUf8iOwYyBOc8RaMlcf/IAcsBxrOM0Ble0WZxQXO
         Woog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lgyXwip1A5ETbGMBBZ7S54p6R7mk1sQNL9D8uDJUYmI=;
        b=6OrcJkHqLHHwUijFaKWZgwd3fWAtAIwaaKdyg3PVaxgFe53ooKtv4mapnUfDw6vMXW
         syooNN9kBoxQvciWNILp+G9ngDMSoNKbOsV13iI4TItHznJmMsSg6m5NVonNOnjuKxgr
         hV261oV5JpLKZaqPrY2M9Jj4GC/C9HBO900+J4Sm66fcu2rcYr5zpS0lr/lI/Lf/yiiM
         SA++zSRgxfejPUcHGZ3wt9tW7B125b/KAUttjOgvLxDmMV63UhQy6/UGhDdhrYzLbGce
         HqyNGLDeZX8NPk2vT6hmYTyOXVuIw35MJdmn/NjltfDlBSh/4dQgabqD3HX8TK73/8YU
         FRxw==
X-Gm-Message-State: AOAM531pHcPmWJr+GxVFwsOolp39irt43pJGFGwNLkAbc+9AiYMOOBex
        TmiRXF2M1zUOT2DHjne5qwkypc0dL/D0sA==
X-Google-Smtp-Source: ABdhPJwIQAKrC723JPQlp4xpCk3BZQuK0HxIuQTeRrNfVDjADNsDrdS2qKgdrusQxPZBWMSVeB//xA==
X-Received: by 2002:a5d:6149:0:b0:204:4a17:bf2 with SMTP id y9-20020a5d6149000000b002044a170bf2mr10456502wrt.379.1648233503406;
        Fri, 25 Mar 2022 11:38:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm6622411wrz.29.2022.03.25.11.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:38:22 -0700 (PDT)
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
Subject: [PATCH v2 05/25] CI: remove unused Azure ci/* code
Date:   Fri, 25 Mar 2022 19:37:56 +0100
Message-Id: <patch-v2-05.25-b5e6d538554-20220325T182534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove Azure-specific code that's been unused since 6081d3898fe (ci:
retire the Azure Pipelines definition, 2020-04-11). As noted in a
larger removal of all of the Azure-supporting code in [1] (although
that missed some of this) there is more of it in-tree, but let's focus
on only the ci/* code for now.

This is needed because in subsequent commits this unused code would
either need to be changed to accommodate changes in ci/*, or be
removed.

As we'll see in those subsequent commits the end-state we're heading
towards will actually make it easier to add new CI types in the
future, even though the only one we're left with now is the GitHub
CI. I.e. the "ci/*" framework will be made to do less, not more. We'll
be offloading more of what it does to our generic build and test
system.

While I'm at it (since the line needs to be touched anyway) change an
odd 'if test true == "$GITHUB_ACTIONS"' to the more usual style used
in other places of 'if test "$GITHUB_ACTIONS" = "true"'.

1. https://lore.kernel.org/git/patch-1.1-eec0a8c3164-20211217T000418Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/install-dependencies.sh |  3 ---
 ci/lib.sh                  | 13 +------------
 ci/mount-fileshare.sh      | 25 -------------------------
 ci/print-test-failures.sh  |  7 +------
 4 files changed, 2 insertions(+), 46 deletions(-)
 delete mode 100755 ci/mount-fileshare.sh

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index dbcebad2fb2..e7ea8799411 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -34,8 +34,6 @@ macos-latest)
 	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
-	test -z "$BREW_INSTALL_PACKAGES" ||
-	brew install $BREW_INSTALL_PACKAGES
 	brew link --force gettext
 	brew install --cask --no-quarantine perforce || {
 		# Update the definitions and try again
@@ -69,7 +67,6 @@ Documentation)
 	sudo apt-get -q update
 	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make
 
-	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
 	sudo gem install --version 1.5.8 asciidoctor
 	;;
 linux-gcc-default)
diff --git a/ci/lib.sh b/ci/lib.sh
index 5a8938d4b3c..ad1aa59a384 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -29,18 +29,7 @@ export TERM=${TERM:-dumb}
 # Clear MAKEFLAGS that may come from the outside world.
 export MAKEFLAGS=
 
-if test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
-then
-	CI_TYPE=azure-pipelines
-	# We are running in Azure Pipelines
-	CC="${CC:-gcc}"
-
-	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
-	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
-	MAKEFLAGS="$MAKEFLAGS --jobs=10"
-	test Windows_NT != "$AGENT_OS" ||
-	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
-elif test true = "$GITHUB_ACTIONS"
+if test "$GITHUB_ACTIONS" = "true"
 then
 	CI_TYPE=github-actions
 	CC="${CC:-gcc}"
diff --git a/ci/mount-fileshare.sh b/ci/mount-fileshare.sh
deleted file mode 100755
index 26b58a80960..00000000000
--- a/ci/mount-fileshare.sh
+++ /dev/null
@@ -1,25 +0,0 @@
-#!/bin/sh
-
-die () {
-	echo "$*" >&2
-	exit 1
-}
-
-test $# = 4 ||
-die "Usage: $0 <share> <username> <password> <mountpoint>"
-
-mkdir -p "$4" || die "Could not create $4"
-
-case "$(uname -s)" in
-Linux)
-	sudo mount -t cifs -o vers=3.0,username="$2",password="$3",dir_mode=0777,file_mode=0777,serverino "$1" "$4"
-	;;
-Darwin)
-	pass="$(echo "$3" | sed -e 's/\//%2F/g' -e 's/+/%2B/g')" &&
-	mount -t smbfs,soft "smb://$2:$pass@${1#//}" "$4"
-	;;
-*)
-	die "No support for $(uname -s)"
-	;;
-esac ||
-die "Could not mount $4"
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 00fcf27b1b2..0c63b6f7962 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -38,14 +38,9 @@ do
 		test_name="${TEST_EXIT%.exit}"
 		test_name="${test_name##*/}"
 		trash_dir="trash directory.$test_name"
+		mkdir -p failed-test-artifacts
 		case "$CI_TYPE" in
-		azure-pipelines)
-			mkdir -p failed-test-artifacts
-			mv "$trash_dir" failed-test-artifacts
-			continue
-			;;
 		github-actions)
-			mkdir -p failed-test-artifacts
 			echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
 			cp "${TEST_EXIT%.exit}.out" failed-test-artifacts/
 			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
-- 
2.35.1.1517.g20a06c426a7

