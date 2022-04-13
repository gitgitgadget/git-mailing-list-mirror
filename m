Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606ACC433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbiDMTyb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbiDMTyW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:54:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BB631DCC
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q3so3498985wrj.7
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KDNZ571zlXAYf5vSBIaRatC5rxkgtLsjLynW+wqdIjU=;
        b=YOiPIHNKmFCgiT49u3Fn6vVW8sc1TzBYqO9r4v7Olf3scJe1CfhDd82ZSyJ/e5x3SF
         yMrkADINa/QEvfeSlPrRW0kPL3fyl3LLnBO9A8+NsWhmLoGZN6A5VYC3eNHc1irn+4jU
         y+yOf/42EqQCseq0LVZnQRemriTDEiSntEPoW8p411uJzA5wxwz2Ztfge/y/fzdOWc4U
         K3uxyUo+NJ6jp2/6Vz6zOyS3ymSDEZmc3QDeRU75JjR+Ldx6qDIune+FLVnoWOwNz5pz
         lJwVLkcfOtZUBAKseCOgAtwyZ/MZnMPoshNK+rT7gwiUpQ/t4TgHVuKefIcig/6q3Sl9
         lFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KDNZ571zlXAYf5vSBIaRatC5rxkgtLsjLynW+wqdIjU=;
        b=rsWJlKEZZitNlUCW9+tguou5/gyGi5LLt74cAvbskY1Ov9BeJ4P6IRA/0yJdNdt/CF
         zG7sRdmLvPHpS0m4rNo1mW02pVGzz1iQfkANhBwTy9oI/kZ/Q5s1MC7sdNmz57357jYZ
         lUewneklVXJoaMPkL5UmA1ZuMC9Q4w1dOq8seLBJvxlnfHZ4b8vUDpOUS1t0C+VJdqsJ
         omOoN2tx3A3k614gxieFdRzBCmFGFJR38Zd+opBGCO5tsbUoxuj7HndYghmQXXiigQcF
         a3KNA2K7LhYhczmK0AiW2dDKTdCoKGFtzh9mIe7o83pf2RZ9owHJ10l8hPeZtdsEffNZ
         XeIw==
X-Gm-Message-State: AOAM532/ub/4QDU/t57RE2XiYr/mqnieyhdEb4gWBbJiiuWcX16k8E6T
        +pTOcx4VZYcj5TYlcB76PpqLsZJewan9rQ==
X-Google-Smtp-Source: ABdhPJxFz3vfD0qS90E4AMFnoyoFRLP8hyAAd3oMYu/GelMVjOzGX391Zy9vLKbHrudG1KWWncbCzg==
X-Received: by 2002:a5d:4cce:0:b0:207:a1f1:6f50 with SMTP id c14-20020a5d4cce000000b00207a1f16f50mr321568wrt.139.1649879518755;
        Wed, 13 Apr 2022 12:51:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm3432484wms.35.2022.04.13.12.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:51:57 -0700 (PDT)
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
Subject: [PATCH v3 05/29] CI: remove unused Azure ci/* code
Date:   Wed, 13 Apr 2022 21:51:18 +0200
Message-Id: <patch-v3-05.29-b2e456f9a9b-20220413T194847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
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
 ci/print-test-failures.sh  |  5 -----
 4 files changed, 1 insertion(+), 45 deletions(-)
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
index d12eaf338f9..c4b829c1eed 100755
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
index 00fcf27b1b2..a878cca67e4 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -39,11 +39,6 @@ do
 		test_name="${test_name##*/}"
 		trash_dir="trash directory.$test_name"
 		case "$CI_TYPE" in
-		azure-pipelines)
-			mkdir -p failed-test-artifacts
-			mv "$trash_dir" failed-test-artifacts
-			continue
-			;;
 		github-actions)
 			mkdir -p failed-test-artifacts
 			echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
-- 
2.36.0.rc2.843.g193535c2aa7

