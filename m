Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706BCC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241477AbiEYKEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbiEYKEw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:04:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FBA6E8C3
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e2so17781523wrc.1
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JmiK0IZ8ftEe9QrndmCy4xy1TM6BpU5EDxYQfhy4NiI=;
        b=DWjiocseQ8qImwcTGRr+5epZucMQ/MqTq23xOwR5oE5uj6T88mnIAO6SWN/8mEuCnF
         4YC2WCt3XdYowD6NztQ8iBOIURezgvj/E8fcvH6ionSCRwwtXOg9ZimeULkTa6mbsmB2
         3xfS36QHvGXupqvoAHblZ6xOssEElyOU+xVODXrUM3yuqwMmeYh3m21+CPCZvqc2QM6f
         dakOZy92FTz72CYSDzHD7dNbE8lzCuUr1kCkb18zxZv4bK8D+bumL6XWnaKuYpSW84/J
         7xCjGTBcTmMSmBS+ZegaPGhBVd3jRadGlQSCHmfFcjDrMjpX5U8BOTDYt60vE6v/6DnN
         3ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JmiK0IZ8ftEe9QrndmCy4xy1TM6BpU5EDxYQfhy4NiI=;
        b=hGKzpPvEiOUTL7VM/Njxe5X2EOB04HxbDU70vkm8txJ1Gofwo0kW+oMjDPm3/t1LLw
         rQa5zuwPWOLrhnk9pydLLIlRGkiwZ+KTfCItoYRsyVbSFHAN9kHFcDfa/Eu/PRXewWec
         Kz73jYM2QM27ekzPDbaPllT6amjItdKp8g9DGqgyFM9r4dq9Lvea+W+2DZTeKi8RF3BA
         3lGgL55vyZVsv8IBIt9Mzan6WDqBUMg9OWrwr2rIF1Ld9oooaJsqvCdwNmXExq40zuce
         rpsFkd7XcSvDo4ULI3I6hdGltRMEPvDFUR2ukM81mIgj2aDyS7kNUG4mfbqp7Cgyg1du
         NyKA==
X-Gm-Message-State: AOAM532Sv0Hha5/i89yefM2KBlpDhBcvpUjXcncjMgJ66vJCOhjhFDiR
        B2l7UiJ1fGz0rAYQP8+5fb/kxlVMA82EkA==
X-Google-Smtp-Source: ABdhPJx/c6GUuqjusbN1pEwyEeEzRiqMvVt2svXzhXqCy/597Hoqpn7AWD5jflkhQjPfIKW0cLHtmQ==
X-Received: by 2002:adf:fc01:0:b0:20c:ff9a:2c53 with SMTP id i1-20020adffc01000000b0020cff9a2c53mr25987204wrr.142.1653473087259;
        Wed, 25 May 2022 03:04:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:04:46 -0700 (PDT)
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
Subject: [PATCH v6 05/29] CI: remove unused Azure ci/* code
Date:   Wed, 25 May 2022 12:03:44 +0200
Message-Id: <patch-v6-05.29-66b0a383daf-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
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
index 107757a1fea..4fa3e282dda 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -34,8 +34,6 @@ macos-latest)
 	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
-	test -z "$BREW_INSTALL_PACKAGES" ||
-	brew install $BREW_INSTALL_PACKAGES
 	brew link --force gettext
 	mkdir -p $HOME/bin
 	(
@@ -71,7 +69,6 @@ Documentation)
 	sudo apt-get -q update
 	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make
 
-	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
 	sudo gem install --version 1.5.8 asciidoctor
 	;;
 linux-gcc-default)
diff --git a/ci/lib.sh b/ci/lib.sh
index e04b53b428d..ebb9461ff42 100755
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
 	CC="${CC_PACKAGE:-${CC:-gcc}}"
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
2.36.1.1045.gf356b5617dd

