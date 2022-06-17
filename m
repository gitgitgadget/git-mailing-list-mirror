Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD63C43334
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 00:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379354AbiFQAUz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 20:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379290AbiFQAUr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 20:20:47 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5981F63395
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 17:20:44 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id l4so2640883pgh.13
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 17:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z5RYilFKv93oAPvCOKUO0wMOUTz1O3gaoew6mz7A8/k=;
        b=lGbvejv435moxrXENfsto9+kF/+Qz+6fg6RLXDZdLD6meMBDdTdC+YzJMMJ9Ui5Eva
         ZzDfe8zvn0pxRKfJjB7jVqhbeWhMZ2U/3kg7lRChGGIkt/scZhXnuq6Pab41AvCIC5Di
         Z2aRpVwjp5TC3uUcqWqQTzZySV1gzIwV+xiGd3cMjsCwwAjd3Wm/D9Rk7/UhAVfKUXUu
         lnRnOxVKxQkIMi9bEx1yonCCwqdMiCOUr4T91wM6oX+raNqC3BB7hkQ9OXyi/JDSe3A9
         oXChIcknp7ybg5uw2jH9HUER0aGl1Vjc2BM4i6Idva0kgRBKhxLD3PsKOryWgQ/ObngT
         umNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z5RYilFKv93oAPvCOKUO0wMOUTz1O3gaoew6mz7A8/k=;
        b=U97liwqur/dqQwWyDWMJZLndPopwqMd+dqxpmINLW/gmzKu9gz1u3r5tIcvj8SgVU3
         yMP/taWUXEP+R6czuwzhzSrPaDZw97gyDl6fz4FjRMqgEUHbA0aGn7tL9eqTkhUhVtdY
         NZtTc9qEGEZQzPJqnsBQjQksayw23kNP7f4we+vVu3e64UNwMhmmxUbnpmO9Pp7v2wP8
         Rjxw8b6WNIpMf1o5SlqQEAw++sX3me/PqhHgXierHZAbLohqnb5Zs3af/eRTq0wQNw46
         06kSzjXVDadr9n6iC/MHXGKTM8khD0qbgXmOKIBai2f9Y3X9muW2XFYnsRA6yKhTFa1N
         Vp9Q==
X-Gm-Message-State: AJIora+Ofr9JbxbIeqR0LNIkRZ5DgEiSpjxNXDtnEjsEhSkmo0Uxb5Y6
        RTv7GgqNGrYftOTLdTG0mZ8wwu+/zTs=
X-Google-Smtp-Source: AGRyM1sFzgt1zpAd8mVI1gPPcHJmPOjW7rcaZwbgFttVJ3tjE8o4WvWaO8ssDzRAc4Z901mjcGJuOw==
X-Received: by 2002:a62:7cca:0:b0:4fd:e594:fac0 with SMTP id x193-20020a627cca000000b004fde594fac0mr7313138pfc.79.1655425243456;
        Thu, 16 Jun 2022 17:20:43 -0700 (PDT)
Received: from JEKELLER-HOME.localdomain ([50.39.231.65])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090301c100b001663165eb16sm2260623plh.7.2022.06.16.17.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 17:20:43 -0700 (PDT)
From:   Jacob Keller <jacob.keller@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v3 5/6] t5505: use test_config where appropriate
Date:   Thu, 16 Jun 2022 17:20:35 -0700
Message-Id: <20220617002036.1577-6-jacob.keller@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220617002036.1577-1-jacob.keller@gmail.com>
References: <20220617002036.1577-1-jacob.keller@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.e.keller@intel.com>

The t5505-remote.sh function makes heavy use of git config, often
leaving potentially stale configuration which may affect future tests.
Fix this by using test_config instead, which ensures the configuration
values get unset.

The t5505-remote.sh script makes use of the --add option of git config.
Teach this option to test_config, and then use test_config where
appropriate.

Some configuration values in the 'show' test are left alone. This is
done because these values are actually relied upon by future tests, and
clearing them breaks the expectations.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 t/t5505-remote.sh       | 52 ++++++++++++++++++++---------------------
 t/test-lib-functions.sh |  6 ++++-
 2 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 7914379ed253..8cad753023ef 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -95,7 +95,7 @@ test_expect_success 'filters for promisor remotes are listed by git remote -v' '
 	git -C pc remote -v >out &&
 	grep "srv.bare (fetch) \[blob:none\]" out &&
 
-	git -C pc config remote.origin.partialCloneFilter object:type=commit &&
+	test_config -C pc remote.origin.partialCloneFilter object:type=commit &&
 	git -C pc remote -v >out &&
 	grep "srv.bare (fetch) \[object:type=commit\]" out
 '
@@ -155,10 +155,10 @@ test_expect_success 'remove remote protects local branches' '
 	  git branch -d main
 	EOF
 	git -C test tag footag &&
-	git -C test config --add remote.oops.fetch "+refs/*:refs/*" &&
+	test_config -C test --add remote.oops.fetch "+refs/*:refs/*" &&
 	git -C test remote remove oops 2>actual1 &&
 	git -C test branch foobranch &&
-	git -C test config --add remote.oops.fetch "+refs/*:refs/*" &&
+	test_config -C test --add remote.oops.fetch "+refs/*:refs/*" &&
 	git -C test remote rm oops 2>actual2 &&
 	git -C test branch -d foobranch &&
 	git -C test tag -d footag &&
@@ -183,7 +183,7 @@ test_expect_success 'remove remote with a branch without configured merge' '
 	git -C test remote add two ../two &&
 	git -C test fetch two &&
 	git -C test checkout -b second two/main^0 &&
-	git -C test config branch.second.remote two &&
+	test_config -C test branch.second.remote two &&
 	git -C test checkout main &&
 	git -C test remote rm two
 '
@@ -294,8 +294,7 @@ cat >expect <<EOF
 EOF
 
 test_expect_success 'show with negative refspecs' '
-	test_when_finished "git -C test config --unset-all --fixed-value remote.origin.fetch ^refs/heads/main" &&
-	git -C test config --add remote.origin.fetch ^refs/heads/main &&
+	test_config -C test --add remote.origin.fetch ^refs/heads/main &&
 	git -C test remote show origin >output &&
 	test_cmp expect output
 '
@@ -317,8 +316,7 @@ cat >expect <<EOF
 EOF
 
 test_expect_failure 'show stale with negative refspecs' '
-	test_when_finished "git -C test config --unset-all --fixed-value remote.origin.fetch ^refs/heads/side" &&
-	git -C test config --add remote.origin.fetch ^refs/heads/side &&
+	test_config -C test --add remote.origin.fetch ^refs/heads/side &&
 	git -C test remote show origin >output &&
 	test_cmp expect output
 '
@@ -488,8 +486,8 @@ test_expect_success 'add alt && prune' '
 	mkdir alttst &&
 	git -C alttst init &&
 	git -C alttst remote add -f origin ../one &&
-	git -C alttst config remote.alt.url ../one &&
-	git -C alttst config remote.alt.fetch "+refs/heads/*:refs/remotes/origin/*" &&
+	test_config -C alttst remote.alt.url ../one &&
+	test_config -C alttst remote.alt.fetch "+refs/heads/*:refs/remotes/origin/*" &&
 	git -C one branch -m side side2 &&
 	git -C alttst rev-parse --verify refs/remotes/origin/side &&
 	test_must_fail git -C alttst rev-parse --verify refs/remotes/origin/side2 &&
@@ -590,8 +588,8 @@ test_expect_success 'update with arguments' '
 	done &&
 	git -C one remote add manduca ../mirror &&
 	git -C one remote add megaloprepus ../mirror &&
-	git -C one config remotes.phobaeticus "drosophila megaloprepus" &&
-	git -C one config remotes.titanus manduca &&
+	test_config -C one remotes.phobaeticus "drosophila megaloprepus" &&
+	test_config -C one remotes.titanus manduca &&
 	git -C one remote update phobaeticus titanus &&
 	git -C one branch -r >output &&
 	test_cmp expect output
@@ -619,7 +617,7 @@ test_expect_success 'update default' '
 	do
 	git -C one branch -r -d $b || exit 1
 	done &&
-	git -C one config remote.drosophila.skipDefaultUpdate true &&
+	test_config -C one remote.drosophila.skipDefaultUpdate true &&
 	git -C one remote update default &&
 	git -C one branch -r >output &&
 	test_cmp expect output
@@ -636,7 +634,7 @@ test_expect_success 'update default (overridden, with funny whitespace)' '
 	do
 	git -C one branch -r -d $b || exit 1
 	done &&
-	git -C one config remotes.default "$(printf "\t drosophila  \n")" &&
+	test_config -C one remotes.default "$(printf "\t drosophila  \n")" &&
 	git -C one remote update default &&
 	git -C one branch -r >output &&
 	test_cmp expect output
@@ -647,7 +645,7 @@ test_expect_success 'update (with remotes.default defined)' '
 	do
 	git -C one branch -r -d $b || exit 1
 	done &&
-	git -C one config remotes.default "drosophila" &&
+	test_config -C one remotes.default "drosophila" &&
 	git -C one remote update &&
 	git -C one branch -r >output &&
 	test_cmp expect output
@@ -670,7 +668,7 @@ test_expect_success 'reject adding remote with an invalid name' '
 test_expect_success 'rename a remote' '
 	test_config --global remote.pushDefault origin &&
 	git clone one four &&
-	git -C four config branch.main.pushRemote origin &&
+	test_config -C four branch.main.pushRemote origin &&
 	GIT_TRACE2_EVENT=$(pwd)/trace \
 		git -C four remote rename --progress origin upstream &&
 	test_region progress "Renaming remote references" trace &&
@@ -686,7 +684,7 @@ test_expect_success 'rename a remote' '
 
 test_expect_success 'rename a remote renames repo remote.pushDefault' '
 	git clone one four.1 &&
-	git -C four.1 config remote.pushDefault origin &&
+	test_config -C four.1 remote.pushDefault origin &&
 	git -C four.1 remote rename origin upstream &&
 	grep pushDefault four.1/.git/config &&
 	test "$(git -C four.1 config --local remote.pushDefault)" = "upstream"
@@ -695,7 +693,7 @@ test_expect_success 'rename a remote renames repo remote.pushDefault' '
 test_expect_success 'rename a remote renames repo remote.pushDefault but ignores global' '
 	test_config --global remote.pushDefault other &&
 	git clone one four.2 &&
-	git -C four.2 config remote.pushDefault origin &&
+	test_config -C four.2 remote.pushDefault origin &&
 	git -C four.2 remote rename origin upstream &&
 	test "$(git -C four.2 config --global remote.pushDefault)" = "other" &&
 	test "$(git -C four.2 config --local remote.pushDefault)" = "upstream"
@@ -704,7 +702,7 @@ test_expect_success 'rename a remote renames repo remote.pushDefault but ignores
 test_expect_success 'rename a remote renames repo remote.pushDefault but keeps global' '
 	test_config --global remote.pushDefault origin &&
 	git clone one four.3 &&
-	git -C four.3 config remote.pushDefault origin &&
+	test_config -C four.3 remote.pushDefault origin &&
 	git -C four.3 remote rename origin upstream &&
 	test "$(git -C four.3 config --global remote.pushDefault)" = "origin" &&
 	test "$(git -C four.3 config --local remote.pushDefault)" = "upstream"
@@ -712,7 +710,7 @@ test_expect_success 'rename a remote renames repo remote.pushDefault but keeps g
 
 test_expect_success 'rename does not update a non-default fetch refspec' '
 	git clone one four.one &&
-	git -C four.one config remote.origin.fetch +refs/heads/*:refs/heads/origin/* &&
+	test_config -C four.one remote.origin.fetch +refs/heads/*:refs/heads/origin/* &&
 	git -C four.one remote rename origin upstream &&
 	test "$(git -C four.one config remote.upstream.fetch)" = "+refs/heads/*:refs/heads/origin/*" &&
 	git -C four.one rev-parse -q origin/main
@@ -742,7 +740,7 @@ test_expect_success 'rename succeeds with existing remote.<target>.prune' '
 test_expect_success 'remove a remote' '
 	test_config --global remote.pushDefault origin &&
 	git clone one four.five &&
-	git -C four.five config branch.main.pushRemote origin &&
+	test_config -C four.five branch.main.pushRemote origin &&
 	git -C four.five remote remove origin &&
 	test -z "$(git -C four.five for-each-ref refs/remotes/origin)" &&
 	test_must_fail git -C four.five config branch.main.remote &&
@@ -752,7 +750,7 @@ test_expect_success 'remove a remote' '
 
 test_expect_success 'remove a remote removes repo remote.pushDefault' '
 	git clone one four.five.1 &&
-	git -C four.five.1 config remote.pushDefault origin &&
+	test_config -C four.five.1 remote.pushDefault origin &&
 	git -C four.five.1 remote remove origin &&
 	test_must_fail git -C four.five.1 config --local remote.pushDefault
 '
@@ -760,7 +758,7 @@ test_expect_success 'remove a remote removes repo remote.pushDefault' '
 test_expect_success 'remove a remote removes repo remote.pushDefault but ignores global' '
 	test_config --global remote.pushDefault other &&
 	git clone one four.five.2 &&
-	git -C four.five.2 config remote.pushDefault origin &&
+	test_config -C four.five.2 remote.pushDefault origin &&
 	git -C four.five.2 remote remove origin &&
 	test "$(git -C four.five.2 config --global remote.pushDefault)" = "other" &&
 	test_must_fail git -C four.five.2 config --local remote.pushDefault
@@ -769,7 +767,7 @@ test_expect_success 'remove a remote removes repo remote.pushDefault but ignores
 test_expect_success 'remove a remote removes repo remote.pushDefault but keeps global' '
 	test_config --global remote.pushDefault origin &&
 	git clone one four.five.3 &&
-	git -C four.five.3 config remote.pushDefault origin &&
+	test_config -C four.five.3 remote.pushDefault origin &&
 	git -C four.five.3 remote remove origin &&
 	test "$(git -C four.five.3 config --global remote.pushDefault)" = "origin" &&
 	test_must_fail git -C four.five.3 config --local remote.pushDefault
@@ -1210,9 +1208,9 @@ test_expect_success 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and
 	git -C two tag -a -m "Some tag" my-tag main &&
 	git -C two update-ref refs/trees/my-head-tree HEAD^{tree} &&
 	git -C two update-ref refs/blobs/my-file-blob HEAD:file &&
-	git -C test config --add remote.two.fetch "+refs/tags/*:refs/remotes/tags-from-two/*" &&
-	git -C test config --add remote.two.fetch "+refs/trees/*:refs/remotes/trees-from-two/*" &&
-	git -C test config --add remote.two.fetch "+refs/blobs/*:refs/remotes/blobs-from-two/*" &&
+	test_config -C test --add remote.two.fetch "+refs/tags/*:refs/remotes/tags-from-two/*" &&
+	test_config -C test --add remote.two.fetch "+refs/trees/*:refs/remotes/trees-from-two/*" &&
+	test_config -C test --add remote.two.fetch "+refs/blobs/*:refs/remotes/blobs-from-two/*" &&
 	git -C test fetch --no-tags two &&
 
 	test_must_fail git -C test push origin refs/remotes/two/another:dst 2>err &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 9957eb2e6c30..7955ef03b8c4 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -574,6 +574,7 @@ test_unconfig () {
 # Set git config, automatically unsetting it after the test is over.
 test_config () {
 	global=
+	add=
 	config_dir=
 	while test $# != 0
 	do
@@ -585,6 +586,9 @@ test_config () {
 		--global)
 			global=--global
 			;;
+		--add)
+			add=--add
+			;;
 		-*)
 			BUG "invalid test_config option: $1"
 			;;
@@ -606,7 +610,7 @@ test_config () {
 	esac
 
 	test_when_finished "test_unconfig ${config_dir:+-C '$config_dir'} --fixed-value $global '$1' '$2'" &&
-	git ${config_dir:+-C "$config_dir"} config $global "$1" "$2"
+	git ${config_dir:+-C "$config_dir"} config $global $add "$1" "$2"
 }
 
 write_script () {
-- 
2.36.1

