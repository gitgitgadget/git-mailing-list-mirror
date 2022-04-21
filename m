Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5641C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391342AbiDUS1F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391292AbiDUS0f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:26:35 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193124B1FB
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id bg25so3002923wmb.4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Lapla7bdj1i+B+MklpJ7L5IL7ja01Drd/6puN0vfq4=;
        b=QHqXBEu5ESK9O4n4eZXVzrrnQRJuyYqKWPtngNHgk7pIh332SWc0XCW/pr80jf5e+F
         9d8uiXVz3+sVcxjR8butmQ0Ww159BhsEVIIhojnqFYNP+Mc1SB8jBP0y7yc+oW5S8tyg
         GZwUkKGohd5Kz5k/GyVDuRj/WjNRegtM8Ai8HZT0CYGx3gQprDKR7+D05bxA4InJbZKM
         fDfZNoTLlJZoFZroLiO6zGZwnTzrzidXVwpRz5ZFFVVYdj73GCJkXMEEcCKNE6o9HdgU
         hKVCwKuh+SQfVGf3eDSwcLeo7y+K3m3Bf97pv/CcPnBRG1dudOQOCmYmR+FStSsln24D
         R5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Lapla7bdj1i+B+MklpJ7L5IL7ja01Drd/6puN0vfq4=;
        b=ThFotZ1yET04oOtjxHmEXK3PNM/U3uepnBEJJDguK123vXPtikUA7noSJuvNREa467
         tZIlzlKAGBPyq+NIQfCVgvNfY/pTFmHgdst++XyQT1L6RRhgH1jfUeIui0GTyQdJkWBy
         exeinj0eauIKdfPLO6s3gBrI+Md4DIy9dcrVfL8Dre+MMk1Uf1sY6NJbK86AAQBQFv5f
         7iEs8+RS15HYxjpZl94QR0pYme1WopClJ7F9Cp7hiUjYxXuzUhqw4NDOHuhTIAc8fKYB
         mCj+WR1Z0TO6N+szcDFEA0RhRmJHN8ik+wC1/7vVshJAiLQcaPvCxW7iZ+929TvBjqrI
         f1hQ==
X-Gm-Message-State: AOAM532Jgr6NfZmgxVxQd2BJgfKlfOd551XND6BAPChJfhhs0feszHxz
        /Pil5AaMgQLJX1MtNHOtpkr0iOHjr5O5ig==
X-Google-Smtp-Source: ABdhPJwuY3IrNZyZzwpcGVxQeFI9Bjj98TCB540O7+2KWtKIR+hYyiVWwtBuM43X3966+6xasuurag==
X-Received: by 2002:a05:600c:20c7:b0:38e:bf41:edef with SMTP id y7-20020a05600c20c700b0038ebf41edefmr9791893wmm.173.1650565419449;
        Thu, 21 Apr 2022 11:23:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:23:38 -0700 (PDT)
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
Subject: [PATCH v5 05/29] CI: remove unused Azure ci/* code
Date:   Thu, 21 Apr 2022 20:23:00 +0200
Message-Id: <patch-v5-05.29-d4671148eb7-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
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
 ci/print-test-failures.sh  |  4 ----
 4 files changed, 1 insertion(+), 44 deletions(-)
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
index a30ab35d9c2..a6cdcfa014b 100755
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
index 740ebb7c529..47e2ea1ad10 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -30,10 +30,6 @@ do
 		test_name="${test_name##*/}"
 		trash_dir="trash directory.$test_name"
 		case "$CI_TYPE" in
-		azure-pipelines)
-			mkdir -p failed-test-artifacts
-			mv "$trash_dir" failed-test-artifacts
-			;;
 		github-actions)
 			mkdir -p failed-test-artifacts
 			echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
-- 
2.36.0.879.g3659959fcca

