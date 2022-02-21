Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E79C433FE
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378332AbiBUOrt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:47:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378299AbiBUOrR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:47:17 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E950838A5
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:46:53 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j9-20020a05600c190900b0037bff8a24ebso13660131wmq.4
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f49KGz3e37xjRKjzAr5CLd2/qJwdIq3VCIRWvRn/2wU=;
        b=Q5zdopKMihAxle3hCZL1FinGprHPBvvW+wiWQKwpmqUYbfOEynIjBF96MimCTetYXC
         4t6ZsPfx4qzjVSY+O88OULdYlYl+olQN30HFgJugozowcI/bdqwHnewqZNoUhxgcpzjB
         NXJe+Pn2S91Trcph1uK6PwIbBGOSF+I8kop3CgNXSeJMXsp5ZsjWGeKZkXOqXqi6FHT9
         RRs/X60VwJ4TMW99EtzBhuxPXn8dAv3onFvHkzh29ZVl2eWB6q1HzsVlSECd/Mjbd+JN
         9SCUaw1rlUH+WZeF3TCazGK4f6KNjjlSEeqnIp5egZP/8/qhfYr+/OaEzN/qcSAIpY1y
         wm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f49KGz3e37xjRKjzAr5CLd2/qJwdIq3VCIRWvRn/2wU=;
        b=0GxVXJ6jcwUq5RsVExXGRSHG0TrcZA5hLJaHXziPiDQk1qnvv9rRPHT1ve2nrPJqY8
         7Y/CwjjPMytu1Qm8xFmwXg9KaIbArO6VXWP5Z/D2Um40pUeTA39kiTBGnqongRg+wnbg
         9bgYwKSaFnGkKkcWEUCF8u7wRhzxReME81ompUo7y1AfqPzCnZKodkRzcmwAWPYhxT89
         24H2PZg/NOGVjpJuNT9GKJ0oxwUZkJn2khduo6PvU+gZ3uIxiDvvKHn/qwWIDTSlClai
         Veu2XAj6Mxu0jQ2ThiFwsQe0K5ocTRK0tLKufHIkVZNt4YmRsmFJqwBc+EzNVinXdyZB
         /9EQ==
X-Gm-Message-State: AOAM532eMi0IP78RAxzF4qlrkQDHWOnrNHlAj85lq8rZ1xvvVhCqKpaF
        NqQRDUZZtc7IjonwkffIbAKBNz/eDwD4ug==
X-Google-Smtp-Source: ABdhPJxejbn7Hpm3cuLKFbJSEr/z+Bk8oGSV/SLkYCuaq/l+XZH0OQfNugYEenZxj9vVjd1PU+JTnw==
X-Received: by 2002:a05:600c:230d:b0:37d:5882:ec9b with SMTP id 13-20020a05600c230d00b0037d5882ec9bmr21426038wmo.162.1645454812114;
        Mon, 21 Feb 2022 06:46:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25071094wrz.84.2022.02.21.06.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:46:51 -0800 (PST)
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
Subject: [PATCH 05/25] CI: remove unused Azure ci/* code
Date:   Mon, 21 Feb 2022 15:46:17 +0100
Message-Id: <patch-05.25-4738a22a36d-20220221T143936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
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
2.35.1.1132.ga1fe46f8690

