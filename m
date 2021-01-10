Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C14DC433E0
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 14:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C742376E
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 14:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbhAJObF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 09:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbhAJObE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 09:31:04 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A43C061794
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 06:30:24 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b5so8879499pjl.0
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 06:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=624kKrPYiDldkSC1lLmkzOoMf7lf+363IUQoMwKEiO4=;
        b=LTvaANHmr+Da8JahyZqssRkii0wpPuuBRwlMY2BpWB7ZYz0vuNietnTtUuZeXzDeHv
         QrYqNzyFDxFjvBTc6QEov1BojDNzVVe1PtIZJfnLo2x1gQO/hdM2VxzVvtuBOfAY5BUM
         /mATKi75GvDf9TH4CwZQ4PJGCFCUjnkjOblHLK8JlI7r4OovV8UIQpiQwV5yTtoVP4S6
         nSAmGq9twUgEZAtHXbVIx/PNvw8KU+hZjFQ3bXRzO1lcQTLIjE1BWwLXowCaQQwZ3qe1
         SaQ61Xq/lNAgqWa77xYMq0OPr7gaPovbIYZQFtO115C0T4x/tbLX+blqGXm6CNEnrB98
         I5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=624kKrPYiDldkSC1lLmkzOoMf7lf+363IUQoMwKEiO4=;
        b=uBAH7iAe4KgOvhfmsj2kksTQ5FMmodLAga5PBBgKyIViem/95ccqvYiJsUYlMX8gba
         s5RyAc5gxKEcJjMPiV7A9NjH5r0VwnWu9i1rQQxN1aAoycIXWyCtDMfE+wPdZwkRP9AD
         j1M3z29kOg9SFdiD2dgtK+s+QxI74Ttq1Yzyl2xI6GX3FMQ/L+njFDoV/WUEt7oLEzRU
         r5ZHB044v0dT/vjetgKuLFXgd00H6vcsSFBr1EWZCCvsvvua0lPJ8pSN7BcrC58TCnUA
         GZg1VytwXIMVMVVcJwEzIwme9GMx5yCFxTxUHyPmCqRmVGOj5FC2aASCtoE9YyAU8Poo
         Ke5Q==
X-Gm-Message-State: AOAM531igOiS2/f9lW87aeO141OMSrdNbJAnWyMDUFsqNUrGb/wvZw+J
        gFjpTzaQjSLse3aGitZ7CvBflcpGnG0=
X-Google-Smtp-Source: ABdhPJyCYZ4Z3snMTsJAyGs/smT4rS3ZXDn1GVzkCCSBtAe2q70nJ3qOhdNvs4weXGOd2wVQO1UJEA==
X-Received: by 2002:a17:902:d351:b029:db:e003:3b88 with SMTP id l17-20020a170902d351b02900dbe0033b88mr12334376plk.70.1610289023599;
        Sun, 10 Jan 2021 06:30:23 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id a13sm16044863pfr.59.2021.01.10.06.30.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 06:30:23 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v5 1/3] test: add helper functions for git-bundle
Date:   Sun, 10 Jan 2021 09:30:17 -0500
Message-Id: <20210110143019.5625-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqqbldxg466.fsf@gitster.c.googlers.com>
References: <xmqqbldxg466.fsf@gitster.c.googlers.com>
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
 t/t6020-bundle-misc.sh     | 396 +++++++++++++++++++++++++++++++++++++
 t/test-bundle-functions.sh |  47 +++++
 3 files changed, 447 insertions(+), 22 deletions(-)
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
index 0000000000..637cdb5a8e
--- /dev/null
+++ b/t/t6020-bundle-misc.sh
@@ -0,0 +1,396 @@
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
+
+	var=$1
+	shift
+	if test -z "$var"
+	then
+		echo >&2 "error: var is not defined"
+		return 1
+	fi
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
+		git ${indir:+ -C "$indir"} tag -m "$1" "$1" &&
+		oid=$(git ${indir:+ -C "$indir"} rev-parse "$1")
+	else
+		file=${2:-"$1.t"} &&
+		echo "${3-$1}" > "$indir$file" &&
+		git ${indir:+ -C "$indir"} add "$file" &&
+		git ${indir:+ -C "$indir"} commit $signoff -m "$1" &&
+		oid=$(git ${indir:+ -C "$indir"} rev-parse HEAD)
+	fi &&
+	eval $var=$oid
+}
+
+
+# Format the output of git commands to make a user-friendly and stable
+# text.  We can easily prepare the expect text without having to worry
+# about future changes of the commit ID and spaces of the output.
+make_user_friendly_and_stable_output () {
+	sed \
+		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<COMMIT-A>/g" \
+		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<COMMIT-B>/g" \
+		-e "s/$(echo $C | cut -c1-7)[0-9a-f]*/<COMMIT-C>/g" \
+		-e "s/$(echo $D | cut -c1-7)[0-9a-f]*/<COMMIT-D>/g" \
+		-e "s/$(echo $E | cut -c1-7)[0-9a-f]*/<COMMIT-E>/g" \
+		-e "s/$(echo $F | cut -c1-7)[0-9a-f]*/<COMMIT-F>/g" \
+		-e "s/$(echo $G | cut -c1-7)[0-9a-f]*/<COMMIT-G>/g" \
+		-e "s/$(echo $H | cut -c1-7)[0-9a-f]*/<COMMIT-H>/g" \
+		-e "s/$(echo $I | cut -c1-7)[0-9a-f]*/<COMMIT-I>/g" \
+		-e "s/$(echo $J | cut -c1-7)[0-9a-f]*/<COMMIT-J>/g" \
+		-e "s/$(echo $K | cut -c1-7)[0-9a-f]*/<COMMIT-K>/g" \
+		-e "s/$(echo $L | cut -c1-7)[0-9a-f]*/<COMMIT-L>/g" \
+		-e "s/$(echo $M | cut -c1-7)[0-9a-f]*/<COMMIT-M>/g" \
+		-e "s/$(echo $N | cut -c1-7)[0-9a-f]*/<COMMIT-N>/g" \
+		-e "s/$(echo $O | cut -c1-7)[0-9a-f]*/<COMMIT-O>/g" \
+		-e "s/$(echo $P | cut -c1-7)[0-9a-f]*/<COMMIT-P>/g" \
+		-e "s/$(echo $TAG1 | cut -c1-7)[0-9a-f]*/<TAG-1>/g" \
+		-e "s/$(echo $TAG2 | cut -c1-7)[0-9a-f]*/<TAG-2>/g" \
+		-e "s/$(echo $TAG3 | cut -c1-7)[0-9a-f]*/<TAG-3>/g" \
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
index 0000000000..0853eb1eca
--- /dev/null
+++ b/t/test-bundle-functions.sh
@@ -0,0 +1,47 @@
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
+	fi
+	if test $? -ne 0
+	then
+		echo >&2 "error: fail to convert $bundle or index-pack"
+		return 1
+	fi
+	count=$(git show-index <"${pack%pack}idx" | wc -l) &&
+	test $2 = $count && return 0
+	echo >&2 "error: object count for $bundle is $count, not $2"
+	return 1
+}
-- 
2.30.0.2.g06d2f50715

