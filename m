Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F21C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 02:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E2422D58
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 02:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbhALC1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 21:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbhALC1v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 21:27:51 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AABC061786
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 18:27:11 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id c132so436772pga.3
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 18:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YXPsctrUw1cNggt16ngOxNT53InRH2HXrcMTjiKL0Z0=;
        b=nVvaK9whfENfexoj/Vw7nDV6tCybl2bk9H1maASXk68SPdkilAZ4FnWTVaQ+yAPNHw
         xYV76BWq0tpqwlsdHlhwCMJSmGdM72ss34dfSaxG8rsVjSqe2zaaCb43OQGX9VvfgYlR
         FTwSqyLQhY3BF4x9ARVFuIwMygXbylIXu0e2iyHwup4MO5UsV0MDdMUuGSufNXC3pxzW
         fzkgmWP+xZd7pQ6hijML7FJyCevT3S1qyZVZtD9IX4B7WN4dMNCtLnUfqUSJqFYOnsxd
         +Jo9bZdTWKhdpGvfCB0/uioRlboKhllLzKfb8U7bet5r8PFum+zkzMeKkUoQGJncI14j
         1BNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YXPsctrUw1cNggt16ngOxNT53InRH2HXrcMTjiKL0Z0=;
        b=eBBWoolc7O9VIVhEMl5OPsKLg9mVzGtpFK/ybbAFzD+iiJ4TXdkMUr3PnY2VqMX7bp
         IBPcJSwL7M2GgnLdv0EGMg2MlVjv8I5V1raLxQiMEaeCUBWsqYv+T0JkxRLUNBwrXobX
         IZpimT02nxYxmgvSi1XgLfItGZx0NoDoIHMPx8Vo/24i4XAOiNWGAIMS49Tq2MeG8+A4
         SZ/5TqyTpf2ZqAWpp/6npLUqnwCclHpJkFjYi9cQnClRk+vz5SdpvtjA/Io5z0jgf8Vm
         Gj0dlRRJTChgNAgQMAfcZOl9d+ewTemXdTJ1LBdNTNpACYgpCcEyT3tavpu8SCkVGtJE
         qRZw==
X-Gm-Message-State: AOAM533+xO4gqbX2D12lnWOr4nyzd+a6TJdrYib1u6ORs8hw3ZWJ6ykU
        aM2dxu9NCn2hWEdpsC1Ywv9+7nk5Hx0=
X-Google-Smtp-Source: ABdhPJxkVLDooVJLCPe7vx/MfeZsM0GDRZpdd26Ko8ZpiePUfiAl7ZKYXneRiJ9VIxfSyW/To36Idw==
X-Received: by 2002:aa7:83c2:0:b029:1a5:daa9:f22f with SMTP id j2-20020aa783c20000b02901a5daa9f22fmr2321309pfn.48.1610418430681;
        Mon, 11 Jan 2021 18:27:10 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id cq15sm813134pjb.27.2021.01.11.18.27.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2021 18:27:10 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v6 1/3] test: add helper functions for git-bundle
Date:   Mon, 11 Jan 2021 21:27:01 -0500
Message-Id: <20210112022703.1884-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqq1rer8cbz.fsf@gitster.c.googlers.com>
References: <xmqq1rer8cbz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Move git-bundle related functions from t5510 to a library, and this lib
will be shared with a new testcase t6020 which finds a known breakage of
"git-bundle".

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5510-fetch.sh           |  26 +--
 t/t6020-bundle-misc.sh     | 394 +++++++++++++++++++++++++++++++++++++
 t/test-bundle-functions.sh |  42 ++++
 3 files changed, 440 insertions(+), 22 deletions(-)
 create mode 100755 t/t6020-bundle-misc.sh
 create mode 100644 t/test-bundle-functions.sh

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 2013051a64..1e398380eb 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -6,22 +6,10 @@ test_description='Per branch config variables affects "git fetch".
 '
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/test-bundle-functions.sh
 
 D=$(pwd)
 
-test_bundle_object_count () {
-	git verify-pack -v "$1" >verify.out &&
-	test "$2" = $(grep "^$OID_REGEX " verify.out | wc -l)
-}
-
-convert_bundle_to_pack () {
-	while read x && test -n "$x"
-	do
-		:;
-	done
-	cat
-}
-
 test_expect_success setup '
 	echo >file original &&
 	git add file &&
@@ -312,9 +300,7 @@ test_expect_success 'unbundle 1' '
 
 test_expect_success 'bundle 1 has only 3 files ' '
 	cd "$D" &&
-	convert_bundle_to_pack <bundle1 >bundle.pack &&
-	git index-pack bundle.pack &&
-	test_bundle_object_count bundle.pack 3
+	test_bundle_object_count bundle1 3
 '
 
 test_expect_success 'unbundle 2' '
@@ -329,9 +315,7 @@ test_expect_success 'bundle does not prerequisite objects' '
 	git add file2 &&
 	git commit -m add.file2 file2 &&
 	git bundle create bundle3 -1 HEAD &&
-	convert_bundle_to_pack <bundle3 >bundle.pack &&
-	git index-pack bundle.pack &&
-	test_bundle_object_count bundle.pack 3
+	test_bundle_object_count bundle3 3
 '
 
 test_expect_success 'bundle should be able to create a full history' '
@@ -884,9 +868,7 @@ test_expect_success 'all boundary commits are excluded' '
 	git merge otherside &&
 	ad=$(git log --no-walk --format=%ad HEAD) &&
 	git bundle create twoside-boundary.bdl main --since="$ad" &&
-	convert_bundle_to_pack <twoside-boundary.bdl >twoside-boundary.pack &&
-	pack=$(git index-pack --fix-thin --stdin <twoside-boundary.pack) &&
-	test_bundle_object_count .git/objects/pack/pack-${pack##pack	}.pack 3
+	test_bundle_object_count --thin twoside-boundary.bdl 3
 '
 
 test_expect_success 'fetch --prune prints the remotes url' '
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
new file mode 100755
index 0000000000..201f34b5c3
--- /dev/null
+++ b/t/t6020-bundle-misc.sh
@@ -0,0 +1,394 @@
+#!/bin/sh
+#
+# Copyright (c) 2021 Jiang Xin
+#
+
+test_description='Test git-bundle'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/test-bundle-functions.sh
+
+# Create a commit or tag and set the variable with the object ID.
+test_commit_setvar () {
+	notick=
+	signoff=
+	indir=
+	merge=
+	tag=
+	var=
+
+	while test $# != 0
+	do
+		case "$1" in
+		--merge)
+			merge=t
+			;;
+		--tag)
+			tag=t
+			;;
+		--notick)
+			notick=t
+			;;
+		--signoff)
+			signoff="$1"
+			;;
+		-C)
+			shift
+			indir="$1"
+			;;
+		-*)
+			echo >&2 "error: unknown option $1"
+			return 1
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+	if test $# -lt 2
+	then
+		echo >&2 "error: test_commit_setvar must have at least 2 arguments"
+		return 1
+	fi
+	var=$1
+	shift
+	indir=${indir:+"$indir"/}
+	if test -z "$notick"
+	then
+		test_tick
+	fi &&
+	if test -n "$merge"
+	then
+		git ${indir:+ -C "$indir"} merge --no-edit --no-ff \
+			${2:+-m "$2"} "$1" &&
+		oid=$(git ${indir:+ -C "$indir"} rev-parse HEAD)
+	elif test -n "$tag"
+	then
+		git ${indir:+ -C "$indir"} tag -m "$1" "$1" "${2:-HEAD}" &&
+		oid=$(git ${indir:+ -C "$indir"} rev-parse "$1")
+	else
+		file=${2:-"$1.t"} &&
+		echo "${3-$1}" >"$indir$file" &&
+		git ${indir:+ -C "$indir"} add "$file" &&
+		git ${indir:+ -C "$indir"} commit $signoff -m "$1" &&
+		oid=$(git ${indir:+ -C "$indir"} rev-parse HEAD)
+	fi &&
+	eval $var=$oid
+}
+
+# Format the output of git commands to make a user-friendly and stable
+# text.  We can easily prepare the expect text without having to worry
+# about future changes of the commit ID and spaces of the output.
+make_user_friendly_and_stable_output () {
+	sed \
+		-e "s/${A%${A#???????}}[0-9a-f]*/<COMMIT-A>/g" \
+		-e "s/${B%${B#???????}}[0-9a-f]*/<COMMIT-B>/g" \
+		-e "s/${C%${C#???????}}[0-9a-f]*/<COMMIT-C>/g" \
+		-e "s/${D%${D#???????}}[0-9a-f]*/<COMMIT-D>/g" \
+		-e "s/${E%${E#???????}}[0-9a-f]*/<COMMIT-E>/g" \
+		-e "s/${F%${F#???????}}[0-9a-f]*/<COMMIT-F>/g" \
+		-e "s/${G%${G#???????}}[0-9a-f]*/<COMMIT-G>/g" \
+		-e "s/${H%${H#???????}}[0-9a-f]*/<COMMIT-H>/g" \
+		-e "s/${I%${I#???????}}[0-9a-f]*/<COMMIT-I>/g" \
+		-e "s/${J%${J#???????}}[0-9a-f]*/<COMMIT-J>/g" \
+		-e "s/${K%${K#???????}}[0-9a-f]*/<COMMIT-K>/g" \
+		-e "s/${L%${L#???????}}[0-9a-f]*/<COMMIT-L>/g" \
+		-e "s/${M%${M#???????}}[0-9a-f]*/<COMMIT-M>/g" \
+		-e "s/${N%${N#???????}}[0-9a-f]*/<COMMIT-N>/g" \
+		-e "s/${O%${O#???????}}[0-9a-f]*/<COMMIT-O>/g" \
+		-e "s/${P%${P#???????}}[0-9a-f]*/<COMMIT-P>/g" \
+		-e "s/${TAG1%${TAG1#???????}}[0-9a-f]*/<TAG-1>/g" \
+		-e "s/${TAG2%${TAG2#???????}}[0-9a-f]*/<TAG-2>/g" \
+		-e "s/${TAG3%${TAG3#???????}}[0-9a-f]*/<TAG-3>/g" \
+		-e "s/ *\$//"
+}
+
+#            (C)   (D, pull/1/head, topic/1)
+#             o --- o
+#            /       \                              (L)
+#           /         \        o (H, topic/2)             (M, tag:v2)
+#          /    (F)    \      /                                 (N, tag:v3)
+#         /      o --------- o (G, pull/2/head)      o --- o --- o (release)
+#        /      /        \    \                      /       \
+#  o --- o --- o -------- o -- o ------------------ o ------- o --- o (main)
+# (A)   (B)  (E, tag:v1) (I)  (J)                  (K)       (O)   (P)
+#
+test_expect_success 'setup' '
+	# Try to make a stable fixed width for abbreviated commit ID,
+	# this fixed-width oid will be replaced with "<OID>".
+	git config core.abbrev 7 &&
+
+	# branch main: commit A & B
+	test_commit_setvar A "Commit A" main.txt &&
+	test_commit_setvar B "Commit B" main.txt &&
+
+	# branch topic/1: commit C & D, refs/pull/1/head
+	git checkout -b topic/1 &&
+	test_commit_setvar C "Commit C" topic-1.txt &&
+	test_commit_setvar D "Commit D" topic-1.txt &&
+	git update-ref refs/pull/1/head HEAD &&
+
+	# branch topic/1: commit E, tag v1
+	git checkout main &&
+	test_commit_setvar E "Commit E" main.txt &&
+	test_commit_setvar --tag TAG1 v1 &&
+
+	# branch topic/2: commit F & G, refs/pull/2/head
+	git checkout -b topic/2 &&
+	test_commit_setvar F "Commit F" topic-2.txt &&
+	test_commit_setvar G "Commit G" topic-2.txt &&
+	git update-ref refs/pull/2/head HEAD &&
+	test_commit_setvar H "Commit H" topic-2.txt &&
+
+	# branch main: merge commit I & J
+	git checkout main &&
+	test_commit_setvar --merge I topic/1 "Merge commit I" &&
+	test_commit_setvar --merge J refs/pull/2/head "Merge commit J" &&
+
+	# branch main: commit K
+	git checkout main &&
+	test_commit_setvar K "Commit K" main.txt &&
+
+	# branch release:
+	git checkout -b release &&
+	test_commit_setvar L "Commit L" release.txt &&
+	test_commit_setvar M "Commit M" release.txt &&
+	test_commit_setvar --tag TAG2 v2 &&
+	test_commit_setvar N "Commit N" release.txt &&
+	test_commit_setvar --tag TAG3 v3 &&
+
+	# branch main: merge commit O, commit P
+	git checkout main &&
+	test_commit_setvar --merge O tags/v2 "Merge commit O" &&
+	test_commit_setvar P "Commit P" main.txt
+'
+
+test_expect_failure 'create bundle from special rev: main^!' '
+	git bundle create special-rev.bdl "main^!" &&
+
+	git bundle list-heads special-rev.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-\EOF &&
+	<COMMIT-P> refs/heads/main
+	EOF
+	test_i18ncmp expect actual &&
+
+	git bundle verify special-rev.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-\EOF &&
+	The bundle contains this ref:
+	<COMMIT-P> refs/heads/main
+	The bundle requires this ref:
+	<COMMIT-O>
+	EOF
+	test_i18ncmp expect actual &&
+
+	test_bundle_object_count special-rev.bdl 3
+'
+
+test_expect_success 'create bundle with --max-count option' '
+	git bundle create max-count.bdl --max-count 1 \
+		main \
+		"^release" \
+		refs/tags/v1 \
+		refs/pull/1/head \
+		refs/pull/2/head &&
+
+	git bundle verify max-count.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-\EOF &&
+	The bundle contains these 2 refs:
+	<COMMIT-P> refs/heads/main
+	<TAG-1> refs/tags/v1
+	The bundle requires this ref:
+	<COMMIT-O>
+	EOF
+	test_i18ncmp expect actual &&
+
+	test_bundle_object_count max-count.bdl 4
+'
+
+test_expect_success 'create bundle with --since option' '
+	git log -1 --pretty="%ad" $M >actual &&
+	cat >expect <<-\EOF &&
+	Thu Apr 7 15:26:13 2005 -0700
+	EOF
+	test_cmp expect actual &&
+
+	git bundle create since.bdl \
+		--since "Thu Apr 7 15:27:00 2005 -0700" \
+		--all &&
+
+	git bundle verify since.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-\EOF &&
+	The bundle contains these 5 refs:
+	<COMMIT-P> refs/heads/main
+	<COMMIT-N> refs/heads/release
+	<TAG-2> refs/tags/v2
+	<TAG-3> refs/tags/v3
+	<COMMIT-P> HEAD
+	The bundle requires these 2 refs:
+	<COMMIT-M>
+	<COMMIT-K>
+	EOF
+	test_i18ncmp expect actual &&
+
+	test_bundle_object_count --thin since.bdl 13
+'
+
+test_expect_success 'create bundle 1 - no prerequisites' '
+	git bundle create 1.bdl topic/1 topic/2 &&
+
+	cat >expect <<-\EOF &&
+	The bundle contains these 2 refs:
+	<COMMIT-D> refs/heads/topic/1
+	<COMMIT-H> refs/heads/topic/2
+	The bundle records a complete history.
+	EOF
+
+	# verify bundle, which has no prerequisites
+	git bundle verify 1.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	test_i18ncmp expect actual &&
+
+	test_bundle_object_count 1.bdl 24
+'
+
+test_expect_success 'create bundle 2 - has prerequisites' '
+	git bundle create 2.bdl \
+		--ignore-missing \
+		^topic/deleted \
+		^$D \
+		^topic/2 \
+		release &&
+
+	cat >expect <<-\EOF &&
+	The bundle contains this ref:
+	<COMMIT-N> refs/heads/release
+	The bundle requires these 3 refs:
+	<COMMIT-D>
+	<COMMIT-E>
+	<COMMIT-G>
+	EOF
+
+	git bundle verify 2.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	test_i18ncmp expect actual &&
+
+	test_bundle_object_count 2.bdl 16
+'
+
+test_expect_success 'fail to verify bundle without prerequisites' '
+	git init --bare test1.git &&
+
+	cat >expect <<-\EOF &&
+	error: Repository lacks these prerequisite commits:
+	error: <COMMIT-D>
+	error: <COMMIT-E>
+	error: <COMMIT-G>
+	EOF
+
+	test_must_fail git -C test1.git bundle verify ../2.bdl 2>&1 |
+		make_user_friendly_and_stable_output >actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'create bundle 3 - two refs, same object' '
+	git bundle create --version=3 3.bdl \
+		^release \
+		^topic/1 \
+		^topic/2 \
+		main \
+		HEAD &&
+
+	cat >expect <<-\EOF &&
+	The bundle contains these 2 refs:
+	<COMMIT-P> refs/heads/main
+	<COMMIT-P> HEAD
+	The bundle requires these 2 refs:
+	<COMMIT-M>
+	<COMMIT-K>
+	EOF
+
+	git bundle verify 3.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	test_i18ncmp expect actual &&
+
+	test_bundle_object_count 3.bdl 4
+'
+
+test_expect_success 'create bundle 4 - with tags' '
+	git bundle create 4.bdl \
+		^main \
+		^release \
+		^topic/1 \
+		^topic/2 \
+		--all &&
+
+	cat >expect <<-\EOF &&
+	The bundle contains these 3 refs:
+	<TAG-1> refs/tags/v1
+	<TAG-2> refs/tags/v2
+	<TAG-3> refs/tags/v3
+	The bundle records a complete history.
+	EOF
+
+	git bundle verify 4.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	test_i18ncmp expect actual &&
+
+	test_bundle_object_count 4.bdl 3
+'
+
+test_expect_success 'clone from bundle' '
+	git clone --mirror 1.bdl mirror.git &&
+	git -C mirror.git show-ref |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-\EOF &&
+	<COMMIT-D> refs/heads/topic/1
+	<COMMIT-H> refs/heads/topic/2
+	EOF
+	test_cmp expect actual &&
+
+	git -C mirror.git fetch ../2.bdl "+refs/*:refs/*" &&
+	git -C mirror.git show-ref |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-\EOF &&
+	<COMMIT-N> refs/heads/release
+	<COMMIT-D> refs/heads/topic/1
+	<COMMIT-H> refs/heads/topic/2
+	EOF
+	test_cmp expect actual &&
+
+	git -C mirror.git fetch ../3.bdl "+refs/*:refs/*" &&
+	git -C mirror.git show-ref |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-\EOF &&
+	<COMMIT-P> refs/heads/main
+	<COMMIT-N> refs/heads/release
+	<COMMIT-D> refs/heads/topic/1
+	<COMMIT-H> refs/heads/topic/2
+	EOF
+	test_cmp expect actual &&
+
+	git -C mirror.git fetch ../4.bdl "+refs/*:refs/*" &&
+	git -C mirror.git show-ref |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-\EOF &&
+	<COMMIT-P> refs/heads/main
+	<COMMIT-N> refs/heads/release
+	<COMMIT-D> refs/heads/topic/1
+	<COMMIT-H> refs/heads/topic/2
+	<TAG-1> refs/tags/v1
+	<TAG-2> refs/tags/v2
+	<TAG-3> refs/tags/v3
+	EOF
+	test_cmp expect actual
+'
+
+test_done
diff --git a/t/test-bundle-functions.sh b/t/test-bundle-functions.sh
new file mode 100644
index 0000000000..cf7ed818b2
--- /dev/null
+++ b/t/test-bundle-functions.sh
@@ -0,0 +1,42 @@
+# Library of git-bundle related functions.
+
+# Display the pack data contained in the bundle file, bypassing the
+# header that contains the signature, prerequisites and references.
+convert_bundle_to_pack () {
+	while read x && test -n "$x"
+	do
+		:;
+	done
+	cat
+}
+
+# Check count of objects in a bundle file.
+# We can use "--thin" opiton to check thin pack, which must be fixed by
+# command `git-index-pack --fix-thin --stdin`.
+test_bundle_object_count () {
+	thin=
+	if test "$1" = "--thin"
+	then
+		thin=t
+		shift
+	fi
+	if test $# -ne 2
+	then
+		echo >&2 "args should be: <bundle> <count>"
+		return 1
+	fi
+	bundle=$1
+	pack=$bundle.pack
+	convert_bundle_to_pack <"$bundle" >"$pack" &&
+	if test -n "$thin"
+	then
+		mv "$pack" "$bundle.thin.pack" &&
+		git index-pack --stdin --fix-thin "$pack" <"$bundle.thin.pack"
+	else
+		git index-pack "$pack"
+	fi || return 1
+	count=$(git show-index <"${pack%pack}idx" | wc -l) &&
+	test $2 = $count && return 0
+	echo >&2 "error: object count for $bundle is $count, not $2"
+	return 1
+}
-- 
2.28.0.15.gba9e81f0bd

