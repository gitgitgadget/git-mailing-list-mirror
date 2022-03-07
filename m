Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597ADC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242435AbiCGMpB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241954AbiCGMoz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:44:55 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE9436B4E
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:43:55 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l10so5255653wmb.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i+oimSuGBy43LYuA9DBVhfucEsh09CmcENdjotzuVHI=;
        b=bXO+CqH+7AgDgALzWBLZi7pjnate/enpcgR6HnGpB8erbvxH9ScSWXNb8HMoUgrKlh
         luodorTmHaUGonb8TD0XStpFhSrkdyJm4mWJz/88CpeGR/Sw7fc/ABneUBaaz+lPQHbT
         dXqF8PP4wfvlrAmUWa8jol8+nFXuE9pJygr9WJC24CJ2zXYbBdjxSDsaCnl4xg0aWlSm
         3YWt0+xI0RKrU6dC5PJS0UE1vSltTcP/FDqbS627x7ZI7N6ZiAT+GaxzLeP1Mtvs1Qu2
         WIslrduhwTBqce7pSpy6Z2P1KLPRRe7nJQ6SoxwgisqXhWFQHuXlp1YMfpWwZneBiejJ
         NCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i+oimSuGBy43LYuA9DBVhfucEsh09CmcENdjotzuVHI=;
        b=D+SXeVl+D7ay05Q13sv98HjAwYfs1ggL2HRRLvbv8BxX+vodXhJB15Zf7DbGYs06Hh
         LbHkC6on0P6/yulrMAPAs29awtZl8NDyy0YbyM3ZLEWcBjO4A67Esgdqhj15wwBASQSL
         YkFobFIV3eMaY9cgxV8MNokbynPqD8nWJs2VISe6OnNIc37XoMhm9Zo8NyxW8KNjGEel
         bU4fg8lagrBJdM5qwgKCuKr8TuseBdpiLKnZAZviVn52rzlj27zrBHG7GPhx57hSxGly
         fpbTkhfbN9Kbr5ZanIcq227nCzlnYyxQZa0d5+veQyvvs+5ejUnqOOuhqx16+klOj1RY
         PbUg==
X-Gm-Message-State: AOAM5325EB3m/o8pQhVQP/kAxL/A5+Js7Xw/Elxh+B2/aUFaDRbCEioH
        UMRl97NtcmKrAZIsNZX8+hu16R8MPIRdkA==
X-Google-Smtp-Source: ABdhPJxlrr9vdjBdfFdA/HqzS3hUaPOC7HqPw3JGv5TadEUuXCBsuy1THwxptkOIVGiEtPCdjPdUwQ==
X-Received: by 2002:a1c:7916:0:b0:389:8d21:caa9 with SMTP id l22-20020a1c7916000000b003898d21caa9mr8839180wme.106.1646657033780;
        Mon, 07 Mar 2022 04:43:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d5985000000b001f0122f63e1sm5974671wri.85.2022.03.07.04.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:43:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/10] hook tests: get rid of unnecessary sub-shells
Date:   Mon,  7 Mar 2022 13:43:37 +0100
Message-Id: <patch-v2-06.10-08bd1629d65-20220307T123909Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
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
2.35.1.1242.gfeba0eae32b

