Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F3FC433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 10:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiCQKOy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiCQKOr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 06:14:47 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4A7DA096
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 7-20020a05600c228700b00385fd860f49so2896426wmf.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CDXxGHX9uKFHh6bpEtsN1YaVHir7DhpLVK3V1AsTlns=;
        b=Sp7wkO9m2e54g8T0Yhle+kgFAuHx8/KkhuXGZH9CA6ZbQzRpSELRNXAO6W7ncz43lq
         lkNUEToV2iIjHYJMAsgnWK5QW1A11w3Kt9jVLard8co9i0maUaaJXKy79AfzFc+syi1R
         I2Q0HyYPzAXxQS23DoTyafxdUQtweZHOEOswjmNn7KNp5jwivg4RTbqX192LMpQxyDR4
         5U1zNgHPGfxcwTds1yEWuVs5qfIdt2MGMkyHR20tQi+SIH21IUom9bHEPKjKb462mEDg
         jzmOrvaoOHVvMyyr+pm9DPyvo3/wxQkuGb4I+sLxM9i4mCZKWN1df4OXcSda1q+k38in
         VyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CDXxGHX9uKFHh6bpEtsN1YaVHir7DhpLVK3V1AsTlns=;
        b=urziWzifipCFT/6cldxQjXOTUrQPtuFgLb2SS8wMyZXma9mvafYDOEc+QCmJZ8Xsp+
         x/Tot+92RHqYIegDpKvFghaYSNARdkm+QwEakDiWfLsGTbSBpwtKyzaVI1Lb1crKC/oj
         V9VrBDxV0jnNUxR7hX/tgKnsx/q6JKgm8su5dKmcFX6LyIhWuOeyOwP/fxcOYsr5cZE6
         xoqLn1/APYD8tDvXOThUCF+jYs9K5Rbho2IZocTUvz1c+VRBxNGy1B0kqs9mCVJOPFLK
         TUFJVXjq7U3wEWDYOWHSf+YlSxvAA29BcgVlWJ0ZbsAzrW3q+VnzNBw6YSlVPGVw7kYE
         FSuQ==
X-Gm-Message-State: AOAM530L/zAZIXij/ekWwNLjQU+MnuLEYdGcJQmcZERiHDgMBO1/9xnC
        7jAgMLoo/rfrapxIy947WQwj/EMxnkk=
X-Google-Smtp-Source: ABdhPJwDA1ayDecwEOSd2yGgo6AXZnoIIFhnm6U0/iK+60nxmqINXell+gbMVhJ3C5RcmdXHL9hDvA==
X-Received: by 2002:a05:600c:4ec9:b0:38b:f1fd:b6b9 with SMTP id g9-20020a05600c4ec900b0038bf1fdb6b9mr8745792wmq.7.1647512008517;
        Thu, 17 Mar 2022 03:13:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i206-20020a1c3bd7000000b0038bfc3ab76csm3903236wma.48.2022.03.17.03.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 03:13:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/13] fetch+push tests: use "test_hook" and "test_when_finished" pattern
Date:   Thu, 17 Mar 2022 11:13:11 +0100
Message-Id: <patch-v3-06.13-0cf152dfca7-20220317T100820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "t5516-fetch-push.sh" test code to make use of the new
"test_hook" helper, and to use "test_when_finished" to have tests
clean up their own state, instead of relying on subsequent tests to
clean the trash directory.

Before this each test would have been responsible for cleaning up
after a preceding test (which may or may not have run, e.g. if --run
or "GIT_SKIP_TESTS" was used), now each test will instead clean up
after itself.

In order to use both "test_hook" and "test_when_finished" we need to
move them out of sub-shells, which requires some refactoring.

While we're at it split up the "push with negotiation" test, now the
middle of the test doesn't need to "rm event", and since it delimited
two halves that were testing two different things the end-state is
easier to read and reason about.

While changing these lines make the minor change from "-fr" to "-rf"
as the "rm" argument, some of them used it already, it's more common
in the test suite, and it leaves the end-state of the file with more
consistency.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5516-fetch-push.sh | 191 +++++++++++++++++++-----------------------
 1 file changed, 88 insertions(+), 103 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 1a20e54adc1..4dfb080433e 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -23,13 +23,10 @@ D=$(pwd)
 
 mk_empty () {
 	repo_name="$1"
-	rm -fr "$repo_name" &&
-	mkdir "$repo_name" &&
-	(
-		cd "$repo_name" &&
-		git init &&
-		git config receive.denyCurrentBranch warn
-	)
+	test_when_finished "rm -rf \"$repo_name\"" &&
+	test_path_is_missing "$repo_name" &&
+	git init "$repo_name" &&
+	git -C "$repo_name" config receive.denyCurrentBranch warn
 }
 
 mk_test () {
@@ -58,40 +55,28 @@ mk_test () {
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
-
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
+	test_hook -C "$repo_name" pre-receive <<-'EOF' &&
+	cat - >>pre-receive.actual
+	EOF
+
+	test_hook -C "$repo_name" update <<-'EOF' &&
+	printf "%s %s %s\n" "$@" >>update.actual
+	EOF
+
+	test_hook -C "$repo_name" post-receive <<-'EOF' &&
+	cat - >>post-receive.actual
+	EOF
+
+	test_hook -C "$repo_name" post-update <<-'EOF'
+	for ref in "$@"
+	do
+		printf "%s\n" "$ref" >>post-update.actual
+	done
+	EOF
 }
 
 mk_child() {
-	rm -rf "$2" &&
+	test_when_finished "rm -rf \"$2\"" &&
 	git clone "$1" "$2"
 }
 
@@ -196,32 +181,32 @@ grep_wrote () {
 	grep 'write_pack_file/wrote.*"value":"'$1'"' $2
 }
 
-test_expect_success 'push with negotiation' '
-	# Without negotiation
+test_expect_success 'push without negotiation' '
 	mk_empty testrepo &&
 	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
 	test_commit -C testrepo unrelated_commit &&
 	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
-	echo now pushing without negotiation &&
+	test_when_finished "rm event" &&
 	GIT_TRACE2_EVENT="$(pwd)/event" git -c protocol.version=2 push testrepo refs/heads/main:refs/remotes/origin/main &&
-	grep_wrote 5 event && # 2 commits, 2 trees, 1 blob
+	grep_wrote 5 event # 2 commits, 2 trees, 1 blob
+'
 
-	# Same commands, but with negotiation
-	rm event &&
+test_expect_success 'push with negotiation' '
 	mk_empty testrepo &&
 	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
 	test_commit -C testrepo unrelated_commit &&
 	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
+	test_when_finished "rm event" &&
 	GIT_TRACE2_EVENT="$(pwd)/event" git -c protocol.version=2 -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main &&
 	grep_wrote 2 event # 1 commit, 1 tree
 '
 
 test_expect_success 'push with negotiation proceeds anyway even if negotiation fails' '
-	rm event &&
 	mk_empty testrepo &&
 	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
 	test_commit -C testrepo unrelated_commit &&
 	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
+	test_when_finished "rm event" &&
 	GIT_TEST_PROTOCOL_VERSION=0 GIT_TRACE2_EVENT="$(pwd)/event" \
 		git -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main 2>err &&
 	grep_wrote 5 event && # 2 commits, 2 trees, 1 blob
@@ -667,7 +652,6 @@ test_expect_success 'push does not update local refs on failure' '
 
 	mk_test testrepo heads/main &&
 	mk_child testrepo child &&
-	mkdir testrepo/.git/hooks &&
 	echo "#!/no/frobnication/today" >testrepo/.git/hooks/pre-receive &&
 	chmod +x testrepo/.git/hooks/pre-receive &&
 	(
@@ -1329,7 +1313,7 @@ done
 
 test_expect_success 'fetch follows tags by default' '
 	mk_test testrepo heads/main &&
-	rm -fr src dst &&
+	test_when_finished "rm -rf src" &&
 	git init src &&
 	(
 		cd src &&
@@ -1339,6 +1323,7 @@ test_expect_success 'fetch follows tags by default' '
 		sed -n "p; s|refs/heads/main$|refs/remotes/origin/main|p" tmp1 |
 		sort -k 3 >../expect
 	) &&
+	test_when_finished "rm -rf dst" &&
 	git init dst &&
 	(
 		cd dst &&
@@ -1364,8 +1349,9 @@ test_expect_success 'peeled advertisements are not considered ref tips' '
 
 test_expect_success 'pushing a specific ref applies remote.$name.push as refmap' '
 	mk_test testrepo heads/main &&
-	rm -fr src dst &&
+	test_when_finished "rm -rf src" &&
 	git init src &&
+	test_when_finished "rm -rf dst" &&
 	git init --bare dst &&
 	(
 		cd src &&
@@ -1388,8 +1374,9 @@ test_expect_success 'pushing a specific ref applies remote.$name.push as refmap'
 
 test_expect_success 'with no remote.$name.push, it is not used as refmap' '
 	mk_test testrepo heads/main &&
-	rm -fr src dst &&
+	test_when_finished "rm -rf src" &&
 	git init src &&
+	test_when_finished "rm -rf dst" &&
 	git init --bare dst &&
 	(
 		cd src &&
@@ -1410,8 +1397,9 @@ test_expect_success 'with no remote.$name.push, it is not used as refmap' '
 
 test_expect_success 'with no remote.$name.push, upstream mapping is used' '
 	mk_test testrepo heads/main &&
-	rm -fr src dst &&
+	test_when_finished "rm -rf src" &&
 	git init src &&
+	test_when_finished "rm -rf dst" &&
 	git init --bare dst &&
 	(
 		cd src &&
@@ -1439,8 +1427,9 @@ test_expect_success 'with no remote.$name.push, upstream mapping is used' '
 
 test_expect_success 'push does not follow tags by default' '
 	mk_test testrepo heads/main &&
-	rm -fr src dst &&
+	test_when_finished "rm -rf src" &&
 	git init src &&
+	test_when_finished "rm -rf dst" &&
 	git init --bare dst &&
 	(
 		cd src &&
@@ -1462,8 +1451,9 @@ test_expect_success 'push does not follow tags by default' '
 
 test_expect_success 'push --follow-tags only pushes relevant tags' '
 	mk_test testrepo heads/main &&
-	rm -fr src dst &&
+	test_when_finished "rm -rf src" &&
 	git init src &&
+	test_when_finished "rm -rf dst" &&
 	git init --bare dst &&
 	(
 		cd src &&
@@ -1501,9 +1491,9 @@ EOF
 '
 
 test_expect_success 'pushing a tag pushes the tagged object' '
-	rm -rf dst.git &&
 	blob=$(echo unreferenced | git hash-object -w --stdin) &&
 	git tag -m foo tag-of-blob $blob &&
+	test_when_finished "rm -rf dst.git" &&
 	git init --bare dst.git &&
 	git push dst.git tag-of-blob &&
 	# the receiving index-pack should have noticed
@@ -1514,7 +1504,7 @@ test_expect_success 'pushing a tag pushes the tagged object' '
 '
 
 test_expect_success 'push into bare respects core.logallrefupdates' '
-	rm -rf dst.git &&
+	test_when_finished "rm -rf dst.git" &&
 	git init --bare dst.git &&
 	git -C dst.git config core.logallrefupdates true &&
 
@@ -1532,7 +1522,7 @@ test_expect_success 'push into bare respects core.logallrefupdates' '
 '
 
 test_expect_success 'fetch into bare respects core.logallrefupdates' '
-	rm -rf dst.git &&
+	test_when_finished "rm -rf dst.git" &&
 	git init --bare dst.git &&
 	(
 		cd dst.git &&
@@ -1553,6 +1543,7 @@ test_expect_success 'fetch into bare respects core.logallrefupdates' '
 '
 
 test_expect_success 'receive.denyCurrentBranch = updateInstead' '
+	mk_empty testrepo &&
 	git push testrepo main &&
 	(
 		cd testrepo &&
@@ -1655,7 +1646,7 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 	) &&
 
 	# (5) push into void
-	rm -fr void &&
+	test_when_finished "rm -rf void" &&
 	git init void &&
 	(
 		cd void &&
@@ -1677,26 +1668,23 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 '
 
 test_expect_success 'updateInstead with push-to-checkout hook' '
-	rm -fr testrepo &&
+	test_when_finished "rm -rf testrepo" &&
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
+	test_hook -C testrepo push-to-checkout <<-\EOF &&
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
@@ -1739,35 +1727,32 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 	) &&
 
 	# push into void
-	rm -fr void &&
+	test_when_finished "rm -rf void" &&
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
+	test_hook -C void push-to-checkout <<-\EOF &&
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
-- 
2.35.1.1384.g7d2906948a1

