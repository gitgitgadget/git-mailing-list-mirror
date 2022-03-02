Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0470C433FE
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 13:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242168AbiCBNXj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242144AbiCBNXb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 08:23:31 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F67F25CF
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 05:22:41 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d3so2804205wrf.1
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 05:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bqkIQoy8IGKpHxwlad6S30B3tPn7r7hdgA6VXZfe+Oo=;
        b=O+tASzB4I7NBz5GUVyjq9OjkDc+jK+4V9+lGTd+TovV2EJXYkq02okH1KCwoKvDgQr
         swYs0bbIooECP+l5a6PZHcgC+Kh2+XqBmVQ5mUma/cufpWdmbFnnBM0BRRlooS1Nd5n7
         DVrhDugRvwyWKl9AcxdOJsPV84qj1IbdjGP5gtrTTCNbgjr8qylQZ8XUx1CjhitjZXe6
         rXZ8bI05kPW7BC/R5pc6/IJQwpSocZATyqGNKnK88P4d3sLU5jhLGE4WmOJqvj8YF7p7
         7lpndVf3jG1eIXAriwIIzM5BX49bPDDqeNeKplCpK7jCN00ONvgOYU79cYqyBaIieNak
         IlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bqkIQoy8IGKpHxwlad6S30B3tPn7r7hdgA6VXZfe+Oo=;
        b=5qB4alGp8kMWHKuFWdfzPsNeipsuCB9oXxEPKa2MjeD+pQPs5kYDt5AyS2JdmzOiNk
         77aHsk0ggmiQobQ1niO43U+ZdYxnp/htwJ8XHzG84AJFJWXDdJUYNe7PsGfTRsO9+1um
         C2x3E/0uo8jIkcxSfFNlvmT2vIDO2lR3SlFPkETFVw3MTODLuwQ3UNyx0uYVerm4GXA/
         F6RK6A3hcImsPi5xwZxJAyp39PWe1HWgs4o9A6NjuHMKB8JkFd5WpAhSfPO41L/6Xd4S
         oqvhNFZvg10Rb2gPgoYhdXNroM/oRax3i1LhQlLNJ/4Wm65cdcti7u2VETpnPY3keEOD
         oAUg==
X-Gm-Message-State: AOAM532pzU1L+V5+lPHjs3JcKyPrnmZWF7mRaYrvHc1nL3rFhCcmWQiL
        8ZkOQS5Zyzo2kduKtxrPvbVqCbcWz/MFuA==
X-Google-Smtp-Source: ABdhPJyl2fvckMFMY4GfroO54IholuXmMf6kxbxWOFDuP1Gi6gjhxxfxlssMN/PEPAMIGnx/Bd+PFQ==
X-Received: by 2002:a5d:5918:0:b0:1f0:3295:f4ec with SMTP id v24-20020a5d5918000000b001f03295f4ecmr2140638wrd.451.1646227359627;
        Wed, 02 Mar 2022 05:22:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d648d000000b001efd62a840dsm10814197wri.111.2022.03.02.05.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 05:22:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/10] hook tests: get rid of unnecessary sub-shells
Date:   Wed,  2 Mar 2022 14:22:25 +0100
Message-Id: <patch-06.10-d86ee06b46e-20220302T131859Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the repository setup code for tests that test hooks the use
of sub-shells when setting up the test repository and hooks.

A subsequent commit will change the hook setup to use a helper that
makes use of "test_when_finished", which cannot be used in
sub-shells. Let's change that setup code, and the adjacent and similar
"mk_empty" code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5516-fetch-push.sh   | 150 ++++++++++++++++++----------------------
 t/t6500-gc.sh           |  18 ++---
 t/t9800-git-p4-basic.sh |  24 ++++---
 3 files changed, 94 insertions(+), 98 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 1a20e54adc1..e4bb7581568 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -24,12 +24,8 @@ D=$(pwd)
 mk_empty () {
 	repo_name="$1"
 	rm -fr "$repo_name" &&
-	mkdir "$repo_name" &&
-	(
-		cd "$repo_name" &&
-		git init &&
-		git config receive.denyCurrentBranch warn
-	)
+	git init "$repo_name" &&
+	git -C "$repo_name" config receive.denyCurrentBranch warn
 }
 
 mk_test () {
@@ -58,36 +54,35 @@ mk_test () {
 mk_test_with_hooks() {
 	repo_name=$1
 	mk_test "$@" &&
-	(
-		cd "$repo_name" &&
-		mkdir .git/hooks &&
-		cd .git/hooks &&
-
-		cat >pre-receive <<-'EOF' &&
-		#!/bin/sh
-		cat - >>pre-receive.actual
-		EOF
 
-		cat >update <<-'EOF' &&
-		#!/bin/sh
-		printf "%s %s %s\n" "$@" >>update.actual
-		EOF
-
-		cat >post-receive <<-'EOF' &&
-		#!/bin/sh
-		cat - >>post-receive.actual
-		EOF
-
-		cat >post-update <<-'EOF' &&
-		#!/bin/sh
-		for ref in "$@"
-		do
-			printf "%s\n" "$ref" >>post-update.actual
-		done
-		EOF
-
-		chmod +x pre-receive update post-receive post-update
-	)
+	cat >"$repo_name"/.git/hooks/pre-receive <<-'EOF' &&
+	#!/bin/sh
+	cat - >>pre-receive.actual
+	EOF
+
+	cat >"$repo_name"/.git/hooks/update <<-'EOF' &&
+	#!/bin/sh
+	printf "%s %s %s\n" "$@" >>update.actual
+	EOF
+
+	cat >"$repo_name"/.git/hooks/post-receive <<-'EOF' &&
+	#!/bin/sh
+	cat - >>post-receive.actual
+	EOF
+
+	cat >"$repo_name"/.git/hooks/post-update <<-'EOF' &&
+	#!/bin/sh
+	for ref in "$@"
+	do
+		printf "%s\n" "$ref" >>post-update.actual
+	done
+	EOF
+
+	chmod +x \
+	      "$repo_name"/.git/hooks/pre-receive \
+	      "$repo_name"/.git/hooks/update \
+	      "$repo_name"/.git/hooks/post-receive \
+	      "$repo_name"/.git/hooks/post-update
 }
 
 mk_child() {
@@ -667,7 +662,6 @@ test_expect_success 'push does not update local refs on failure' '
 
 	mk_test testrepo heads/main &&
 	mk_child testrepo child &&
-	mkdir testrepo/.git/hooks &&
 	echo "#!/no/frobnication/today" >testrepo/.git/hooks/pre-receive &&
 	chmod +x testrepo/.git/hooks/pre-receive &&
 	(
@@ -1679,24 +1673,21 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 test_expect_success 'updateInstead with push-to-checkout hook' '
 	rm -fr testrepo &&
 	git init testrepo &&
-	(
-		cd testrepo &&
-		git pull .. main &&
-		git reset --hard HEAD^^ &&
-		git tag initial &&
-		git config receive.denyCurrentBranch updateInstead &&
-		write_script .git/hooks/push-to-checkout <<-\EOF
-		echo >&2 updating from $(git rev-parse HEAD)
-		echo >&2 updating to "$1"
-
-		git update-index -q --refresh &&
-		git read-tree -u -m HEAD "$1" || {
-			status=$?
-			echo >&2 read-tree failed
-			exit $status
-		}
-		EOF
-	) &&
+	git -C testrepo pull .. main &&
+	git -C testrepo reset --hard HEAD^^ &&
+	git -C testrepo tag initial &&
+	git -C testrepo config receive.denyCurrentBranch updateInstead &&
+	write_script testrepo/.git/hooks/push-to-checkout <<-\EOF &&
+	echo >&2 updating from $(git rev-parse HEAD)
+	echo >&2 updating to "$1"
+
+	git update-index -q --refresh &&
+	git read-tree -u -m HEAD "$1" || {
+		status=$?
+		echo >&2 read-tree failed
+		exit $status
+	}
+	EOF
 
 	# Try pushing into a pristine
 	git push testrepo main &&
@@ -1741,33 +1732,30 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 	# push into void
 	rm -fr void &&
 	git init void &&
-	(
-		cd void &&
-		git config receive.denyCurrentBranch updateInstead &&
-		write_script .git/hooks/push-to-checkout <<-\EOF
-		if git rev-parse --quiet --verify HEAD
-		then
-			has_head=yes
-			echo >&2 updating from $(git rev-parse HEAD)
-		else
-			has_head=no
-			echo >&2 pushing into void
-		fi
-		echo >&2 updating to "$1"
-
-		git update-index -q --refresh &&
-		case "$has_head" in
-		yes)
-			git read-tree -u -m HEAD "$1" ;;
-		no)
-			git read-tree -u -m "$1" ;;
-		esac || {
-			status=$?
-			echo >&2 read-tree failed
-			exit $status
-		}
-		EOF
-	) &&
+	git -C void config receive.denyCurrentBranch updateInstead &&
+	write_script void/.git/hooks/push-to-checkout <<-\EOF &&
+	if git rev-parse --quiet --verify HEAD
+	then
+		has_head=yes
+		echo >&2 updating from $(git rev-parse HEAD)
+	else
+		has_head=no
+		echo >&2 pushing into void
+	fi
+	echo >&2 updating to "$1"
+
+	git update-index -q --refresh &&
+	case "$has_head" in
+	yes)
+		git read-tree -u -m HEAD "$1" ;;
+	no)
+		git read-tree -u -m "$1" ;;
+	esac || {
+		status=$?
+		echo >&2 read-tree failed
+		exit $status
+	}
+	EOF
 
 	git push void main &&
 	(
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index c2021267f2c..a6b0db22867 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -101,12 +101,12 @@ test_expect_success 'pre-auto-gc hook can stop auto gc' '
 	EOF
 
 	git init pre-auto-gc-hook &&
+	write_script "pre-auto-gc-hook/.git/hooks/pre-auto-gc" <<-\EOF &&
+	echo >&2 no gc for you &&
+	exit 1
+	EOF
 	(
 		cd pre-auto-gc-hook &&
-		write_script ".git/hooks/pre-auto-gc" <<-\EOF &&
-		echo >&2 no gc for you &&
-		exit 1
-		EOF
 
 		git config gc.auto 3 &&
 		git config gc.autoDetach false &&
@@ -128,12 +128,14 @@ test_expect_success 'pre-auto-gc hook can stop auto gc' '
 	See "git help gc" for manual housekeeping.
 	EOF
 
+	write_script "pre-auto-gc-hook/.git/hooks/pre-auto-gc" <<-\EOF &&
+	echo >&2 will gc for you &&
+	exit 0
+	EOF
+
 	(
 		cd pre-auto-gc-hook &&
-		write_script ".git/hooks/pre-auto-gc" <<-\EOF &&
-		echo >&2 will gc for you &&
-		exit 0
-		EOF
+
 		git gc --auto >../out.actual 2>../err.actual
 	) &&
 
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 806005a793a..3c1534c94d6 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -277,16 +277,22 @@ test_expect_success 'run hook p4-pre-submit before submit' '
 		git commit -m "add hello.txt" &&
 		git config git-p4.skipSubmitEdit true &&
 		git p4 submit --dry-run >out &&
-		grep "Would apply" out &&
-		mkdir -p .git/hooks &&
-		write_script .git/hooks/p4-pre-submit <<-\EOF &&
-		exit 0
-		EOF
+		grep "Would apply" out
+	) &&
+	mkdir -p "$git"/.git/hooks &&
+	write_script "$git"/.git/hooks/p4-pre-submit <<-\EOF &&
+	exit 0
+	EOF
+	(
+		cd "$git" &&
 		git p4 submit --dry-run >out &&
-		grep "Would apply" out &&
-		write_script .git/hooks/p4-pre-submit <<-\EOF &&
-		exit 1
-		EOF
+		grep "Would apply" out
+	) &&
+	write_script "$git"/.git/hooks/p4-pre-submit <<-\EOF &&
+	exit 1
+	EOF
+	(
+		cd "$git" &&
 		test_must_fail git p4 submit --dry-run >errs 2>&1 &&
 		! grep "Would apply" errs
 	)
-- 
2.35.1.1228.g56895c6ee86

