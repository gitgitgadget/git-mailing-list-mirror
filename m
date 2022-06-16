Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60E2CCA47A
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 20:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378715AbiFPUzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378466AbiFPUzB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 16:55:01 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9825FF06
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 13:55:00 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id f16so1358353pjj.1
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 13:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2JDvnFJVEmEllgempv0SSc8ggl3gzmZDr/Ke4JNo3Zk=;
        b=R3qqoclVbPhZZVKa4cLlcoAQcxxMIl+joysMeOJY0d6NPD4leokQWhD9BPjjofLrmZ
         o/KWyipJ4YJ/X8zmWLf4+N7pRYi0RM8mN7sjDpxDlX/iIGcNieALeaLpRwF1LhmhhFv4
         18f2xhDId5HGr+U/QHn8NhHCRUZca+D72N53FC/Iizcqd9i7nLMBodZYC7uUnZNVA86p
         j0hKl65xe7fLiMvvyJTEuKdkEKTshxY7L7iLjfsFEyY3jZ19XQFBf46sJsATgYLjND5K
         5uoZgts76TGQTmV8qHcdjUD1/c23UJeymjh2zKzJ8iPLxmWPcFn8R5dMY2i2JvKGgO1f
         fyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2JDvnFJVEmEllgempv0SSc8ggl3gzmZDr/Ke4JNo3Zk=;
        b=lT5/MKkEU7t8WymBeHxOSd9Hnfr7QhwavJTBlh6v3qgBOETOoVTM+KBq+BmoV6D93l
         46hI4YVAsVkLeGnHizLO5PufqjbfyTZ//H9sbBKdyziF2guWO1WfPaQRHlRdH/ekGDxA
         4wIu1aNkKWvCZrYAiCXQqxu0ryaQCFF8Kns2tESDjoGYBGqntToqMrioI6cYZ44RaTaB
         1uoLi1mRUzkKVD9cfkGNCLLHOx6ZuYNouIN0THWjFCLdj08RvsEFqyMYj7ggQETm3bCi
         i8Z43/1aZ/0mhANmEpyS3pk7gmP2PDdz0PveXoZeWVIDe6wzrVSethE0cMkHWeYzTsMY
         jajg==
X-Gm-Message-State: AJIora9Jst5cLKwWOndnOHDyaV79EaIrnEaDa8A2eUHse/g+u2M/iQE9
        mg/iPJrE8bI/UmrXEQFEsyVHKSFuheE=
X-Google-Smtp-Source: AGRyM1vUTy8V6OgVxul6ysprz/yFBUgzYzC0aTOO421MUdhWRakZMfuTCtJdOlLA6/wN93/SZFKwqQ==
X-Received: by 2002:a17:902:ee8d:b0:164:7dd:6cc6 with SMTP id a13-20020a170902ee8d00b0016407dd6cc6mr6622297pld.84.1655412899547;
        Thu, 16 Jun 2022 13:54:59 -0700 (PDT)
Received: from JEKELLER-HOME.localdomain ([50.39.231.65])
        by smtp.gmail.com with ESMTPSA id j4-20020aa783c4000000b0051b9e224623sm2249165pfn.141.2022.06.16.13.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:54:59 -0700 (PDT)
From:   Jacob Keller <jacob.keller@gmail.com>
X-Google-Original-From: Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 4/5] t5505: use test_config where appropriate
Date:   Thu, 16 Jun 2022 13:54:55 -0700
Message-Id: <20220616205456.19081-5-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616205456.19081-1-jacob.e.keller@intel.com>
References: <20220616205456.19081-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
 t/t5505-remote.sh       | 46 ++++++++++++++++++++---------------------
 t/test-lib-functions.sh |  6 +++++-
 2 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 163d0f2371b0..ac5198141e79 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -81,7 +81,7 @@ test_expect_success 'filters for promisor remotes are listed by git remote -v' '
 	git -C pc remote -v >out &&
 	grep "srv.bare (fetch) \[blob:none\]" out &&
 
-	git -C pc config remote.origin.partialCloneFilter object:type=commit &&
+	test_config -C pc remote.origin.partialCloneFilter object:type=commit &&
 	git -C pc remote -v >out &&
 	grep "srv.bare (fetch) \[object:type=commit\]" out
 '
@@ -141,10 +141,10 @@ test_expect_success 'remove remote protects local branches' '
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
@@ -169,7 +169,7 @@ test_expect_success 'remove remote with a branch without configured merge' '
 	git -C test remote add two ../two &&
 	git -C test fetch two &&
 	git -C test checkout -b second two/main^0 &&
-	git -C test config branch.second.remote two &&
+	test_config -C test branch.second.remote two &&
 	git -C test checkout main &&
 	git -C test remote rm two
 '
@@ -428,8 +428,8 @@ test_expect_success 'add alt && prune' '
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
@@ -530,8 +530,8 @@ test_expect_success 'update with arguments' '
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
@@ -559,7 +559,7 @@ test_expect_success 'update default' '
 	do
 	git -C one branch -r -d $b || exit 1
 	done &&
-	git -C one config remote.drosophila.skipDefaultUpdate true &&
+	test_config -C one remote.drosophila.skipDefaultUpdate true &&
 	git -C one remote update default &&
 	git -C one branch -r >output &&
 	test_cmp expect output
@@ -576,7 +576,7 @@ test_expect_success 'update default (overridden, with funny whitespace)' '
 	do
 	git -C one branch -r -d $b || exit 1
 	done &&
-	git -C one config remotes.default "$(printf "\t drosophila  \n")" &&
+	test_config -C one remotes.default "$(printf "\t drosophila  \n")" &&
 	git -C one remote update default &&
 	git -C one branch -r >output &&
 	test_cmp expect output
@@ -587,7 +587,7 @@ test_expect_success 'update (with remotes.default defined)' '
 	do
 	git -C one branch -r -d $b || exit 1
 	done &&
-	git -C one config remotes.default "drosophila" &&
+	test_config -C one remotes.default "drosophila" &&
 	git -C one remote update &&
 	git -C one branch -r >output &&
 	test_cmp expect output
@@ -610,7 +610,7 @@ test_expect_success 'reject adding remote with an invalid name' '
 test_expect_success 'rename a remote' '
 	test_config --global remote.pushDefault origin &&
 	git clone one four &&
-	git -C four config branch.main.pushRemote origin &&
+	test_config -C four branch.main.pushRemote origin &&
 	GIT_TRACE2_EVENT=$(pwd)/trace \
 		git -C four remote rename --progress origin upstream &&
 	test_region progress "Renaming remote references" trace &&
@@ -626,7 +626,7 @@ test_expect_success 'rename a remote' '
 
 test_expect_success 'rename a remote renames repo remote.pushDefault' '
 	git clone one four.1 &&
-	git -C four.1 config remote.pushDefault origin &&
+	test_config -C four.1 remote.pushDefault origin &&
 	git -C four.1 remote rename origin upstream &&
 	grep pushDefault four.1/.git/config &&
 	test "$(git -C four.1 config --local remote.pushDefault)" = "upstream"
@@ -635,7 +635,7 @@ test_expect_success 'rename a remote renames repo remote.pushDefault' '
 test_expect_success 'rename a remote renames repo remote.pushDefault but ignores global' '
 	test_config --global remote.pushDefault other &&
 	git clone one four.2 &&
-	git -C four.2 config remote.pushDefault origin &&
+	test_config -C four.2 remote.pushDefault origin &&
 	git -C four.2 remote rename origin upstream &&
 	test "$(git -C four.2 config --global remote.pushDefault)" = "other" &&
 	test "$(git -C four.2 config --local remote.pushDefault)" = "upstream"
@@ -644,7 +644,7 @@ test_expect_success 'rename a remote renames repo remote.pushDefault but ignores
 test_expect_success 'rename a remote renames repo remote.pushDefault but keeps global' '
 	test_config --global remote.pushDefault origin &&
 	git clone one four.3 &&
-	git -C four.3 config remote.pushDefault origin &&
+	test_config -C four.3 remote.pushDefault origin &&
 	git -C four.3 remote rename origin upstream &&
 	test "$(git -C four.3 config --global remote.pushDefault)" = "origin" &&
 	test "$(git -C four.3 config --local remote.pushDefault)" = "upstream"
@@ -652,7 +652,7 @@ test_expect_success 'rename a remote renames repo remote.pushDefault but keeps g
 
 test_expect_success 'rename does not update a non-default fetch refspec' '
 	git clone one four.one &&
-	git -C four.one config remote.origin.fetch +refs/heads/*:refs/heads/origin/* &&
+	test_config -C four.one remote.origin.fetch +refs/heads/*:refs/heads/origin/* &&
 	git -C four.one remote rename origin upstream &&
 	test "$(git -C four.one config remote.upstream.fetch)" = "+refs/heads/*:refs/heads/origin/*" &&
 	git -C four.one rev-parse -q origin/main
@@ -682,7 +682,7 @@ test_expect_success 'rename succeeds with existing remote.<target>.prune' '
 test_expect_success 'remove a remote' '
 	test_config --global remote.pushDefault origin &&
 	git clone one four.five &&
-	git -C four.five config branch.main.pushRemote origin &&
+	test_config -C four.five branch.main.pushRemote origin &&
 	git -C four.five remote remove origin &&
 	test -z "$(git -C four.five for-each-ref refs/remotes/origin)" &&
 	test_must_fail git -C four.five config branch.main.remote &&
@@ -692,7 +692,7 @@ test_expect_success 'remove a remote' '
 
 test_expect_success 'remove a remote removes repo remote.pushDefault' '
 	git clone one four.five.1 &&
-	git -C four.five.1 config remote.pushDefault origin &&
+	test_config -C four.five.1 remote.pushDefault origin &&
 	git -C four.five.1 remote remove origin &&
 	test_must_fail git -C four.five.1 config --local remote.pushDefault
 '
@@ -700,7 +700,7 @@ test_expect_success 'remove a remote removes repo remote.pushDefault' '
 test_expect_success 'remove a remote removes repo remote.pushDefault but ignores global' '
 	test_config --global remote.pushDefault other &&
 	git clone one four.five.2 &&
-	git -C four.five.2 config remote.pushDefault origin &&
+	test_config -C four.five.2 remote.pushDefault origin &&
 	git -C four.five.2 remote remove origin &&
 	test "$(git -C four.five.2 config --global remote.pushDefault)" = "other" &&
 	test_must_fail git -C four.five.2 config --local remote.pushDefault
@@ -709,7 +709,7 @@ test_expect_success 'remove a remote removes repo remote.pushDefault but ignores
 test_expect_success 'remove a remote removes repo remote.pushDefault but keeps global' '
 	test_config --global remote.pushDefault origin &&
 	git clone one four.five.3 &&
-	git -C four.five.3 config remote.pushDefault origin &&
+	test_config -C four.five.3 remote.pushDefault origin &&
 	git -C four.five.3 remote remove origin &&
 	test "$(git -C four.five.3 config --global remote.pushDefault)" = "origin" &&
 	test_must_fail git -C four.five.3 config --local remote.pushDefault
@@ -1150,9 +1150,9 @@ test_expect_success 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and
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
index 0057b42988a4..f445d0609b33 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -566,6 +566,7 @@ test_unconfig () {
 # Set git config, automatically unsetting it after the test is over.
 test_config () {
 	global=
+	add=
 	config_dir=
 	while test $# != 0
 	do
@@ -577,6 +578,9 @@ test_config () {
 		--global)
 			global=yes
 			;;
+		--add)
+			add=yes
+			;;
 		-*)
 			BUG "invalid test_config option: $1"
 			;;
@@ -587,7 +591,7 @@ test_config () {
 		shift
 	done
 	test_when_finished "test_unconfig ${config_dir:+-C '$config_dir'} --fixed-value ${global:+--global} '$1' '$2'" &&
-	git ${config_dir:+-C "$config_dir"} config ${global:+--global} "$1" "$2"
+	git ${config_dir:+-C "$config_dir"} config ${global:+--global} ${add:+--add} "$1" "$2"
 }
 
 write_script () {
-- 
2.36.1

