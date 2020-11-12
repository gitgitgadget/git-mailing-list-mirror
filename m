Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535A8C64E7A
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCC2620825
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiTCUjwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgKLWoa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbgKLWoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:44:25 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FC9C0613D6
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:15 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c9so6577659wml.5
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zJDXpbxaHZTrQ49b3N+Ml5X+dENsW6OLPvQ1MI/pSKw=;
        b=RiTCUjwQvhh7lmEu42/09LcvXbdFtd3SqqOklMshfHgFb7lrBJjzO36t44aimiVgvu
         XSUTokligDzMFMeZUtPIj7BkDu825DoEN4f0YNkwmPhLjzJ8mU5bS0522ffK7UD5MThZ
         XJUWd+rjW9fLXhUui/q/VGr7r0ui5Cow1J2CF28xIaV1oRGM58CmiPNzPA5sMwBsTK7x
         sNDg81UgAQUy5RFReTQPGIPJ4IvcTsy43WtEJMD/Obvmp3YO5HsnMXB5nWEW5YSwVquT
         C5opVg+vuu17NYWiU6SPdguVXlU0VRUBQg4DaI1r3L6oaiiHpxG9ySDasjTZOGDMmNaL
         k78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zJDXpbxaHZTrQ49b3N+Ml5X+dENsW6OLPvQ1MI/pSKw=;
        b=XdnKp85+FnUQl38IcJaFnNCVx/AAEJw/c24sIRfzFGWeLG00/LfgHUKG0n8KahQru7
         aiNHbheXj6dscUBmsxcD5PQBhemVxxdLSD/6rKwWb5gmhjtrFJI3dAgLBT3tpiA9I+z1
         nDOFs7Bh8M+ibm4/MHpNxa1GEXV61HERmU00HoiRVoWLZzal4PLvMJc2RgApSF8FR/wA
         egTk6uKE0MiRhDPlZBCLE4eFGQrDRep/Dr+FFDgBmf8ydh/7M/0niVAP2q7Yg9oXz/iw
         UTZo6jEcpYx10Pw52DwQ3nb659Vaic+7B6EoH2dUcNcY63WIBbrKWoVt3A3tpsV1ogNc
         /XkA==
X-Gm-Message-State: AOAM5337Pp1A+UAb5RMSbzYV+3En9gyjmQKgSqPc0ysvD/hBAlUiVW6D
        BWpg1o7vZKX0T98WaNNVeyFUOC/pNc4=
X-Google-Smtp-Source: ABdhPJzdmyaWOVCvl0YqeIeuSofQuDyNa4qAqR8HTqoEhR8GHR81l7gd0oEbZnNIoIqj/hpzp02nIQ==
X-Received: by 2002:a05:600c:2202:: with SMTP id z2mr43194wml.95.1605221051988;
        Thu, 12 Nov 2020 14:44:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g23sm7989838wmh.21.2020.11.12.14.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:44:11 -0800 (PST)
Message-Id: <3aef39320e96aad10e133f1c97a9010aa85aa894.1605221039.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.git.1605221038.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Nov 2020 22:43:44 +0000
Subject: [PATCH 14/28] t55[23]*: adjust the references to the default branch
 name "main"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This trick was performed via

	$ (cd t &&
	   sed -i -e 's/master/main/g' -e 's/MASTER/MAIN/g' \
		-e 's/Master/Main/g' -e 's/naster/nain/g' -- t55[23]*.sh)

Note that t5533 contains a variation of the name `master` (`naster`)
that we rename here, too.

This commit allows us to define
`GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main` for that range of tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5520-pull.sh                |  30 +++---
 t/t5521-pull-options.sh        |  16 +--
 t/t5523-push-upstream.sh       |  30 +++---
 t/t5526-fetch-submodules.sh    |   6 +-
 t/t5527-fetch-odd-refs.sh      |  14 +--
 t/t5528-push-default.sh        |  98 ++++++++---------
 t/t5529-push-errors.sh         |   2 +-
 t/t5530-upload-pack-error.sh   |   2 +-
 t/t5531-deep-submodule-push.sh | 188 ++++++++++++++++-----------------
 t/t5533-push-cas.sh            | 142 ++++++++++++-------------
 t/t5534-push-signed.sh         |   4 +-
 t/t5537-fetch-shallow.sh       |  30 +++---
 t/t5538-push-shallow.sh        |  22 ++--
 t/t5539-fetch-http-shallow.sh  |  14 +--
 t/test-lib.sh                  |   2 +-
 15 files changed, 300 insertions(+), 300 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 9fae07cdfa..3be99df66d 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -48,11 +48,11 @@ test_expect_success 'pulling into void' '
 	test_cmp file cloned/file
 '
 
-test_expect_success 'pulling into void using master:master' '
+test_expect_success 'pulling into void using main:main' '
 	git init cloned-uho &&
 	(
 		cd cloned-uho &&
-		git pull .. master:master
+		git pull .. main:main
 	) &&
 	test_path_is_file file &&
 	test_path_is_file cloned-uho/file &&
@@ -64,7 +64,7 @@ test_expect_success 'pulling into void does not overwrite untracked files' '
 	(
 		cd cloned-untracked &&
 		echo untracked >file &&
-		test_must_fail git pull .. master &&
+		test_must_fail git pull .. main &&
 		echo untracked >expect &&
 		test_cmp expect file
 	)
@@ -76,7 +76,7 @@ test_expect_success 'pulling into void does not overwrite staged files' '
 		cd cloned-staged-colliding &&
 		echo "alternate content" >file &&
 		git add file &&
-		test_must_fail git pull .. master &&
+		test_must_fail git pull .. main &&
 		echo "alternate content" >expect &&
 		test_cmp expect file &&
 		git cat-file blob :file >file.index &&
@@ -90,7 +90,7 @@ test_expect_success 'pulling into void does not remove new staged files' '
 		cd cloned-staged-new &&
 		echo "new tracked file" >newfile &&
 		git add newfile &&
-		git pull .. master &&
+		git pull .. main &&
 		echo "new tracked file" >expect &&
 		test_cmp expect newfile &&
 		git cat-file blob :newfile >newfile.index &&
@@ -102,15 +102,15 @@ test_expect_success 'pulling into void must not create an octopus' '
 	git init cloned-octopus &&
 	(
 		cd cloned-octopus &&
-		test_must_fail git pull .. master master &&
+		test_must_fail git pull .. main main &&
 		test_path_is_missing file
 	)
 '
 
 test_expect_success 'test . as a remote' '
-	git branch copy master &&
+	git branch copy main &&
 	git config branch.copy.remote . &&
-	git config branch.copy.merge refs/heads/master &&
+	git config branch.copy.merge refs/heads/main &&
 	echo updated >file &&
 	git commit -a -m updated &&
 	git checkout copy &&
@@ -126,7 +126,7 @@ test_expect_success 'test . as a remote' '
 '
 
 test_expect_success 'the default remote . should not break explicit pull' '
-	git checkout -b second master^ &&
+	git checkout -b second main^ &&
 	echo modified >file &&
 	git commit -a -m modified &&
 	git checkout copy &&
@@ -361,7 +361,7 @@ test_expect_success 'failed --rebase shows advice' '
 
 test_expect_success '--rebase fails with multiple branches' '
 	git reset --hard before-rebase &&
-	test_must_fail git pull --rebase . copy master 2>err &&
+	test_must_fail git pull --rebase . copy main 2>err &&
 	test_cmp_rev HEAD before-rebase &&
 	test_i18ngrep "Cannot rebase onto multiple branches" err &&
 	echo modified >expect &&
@@ -500,7 +500,7 @@ test_expect_success 'pull --rebase does not warn on --no-verify-signatures' '
 	test_i18ngrep ! "verify-signatures" err
 '
 
-# add a feature branch, keep-merge, that is merged into master, so the
+# add a feature branch, keep-merge, that is merged into main, so the
 # test can try preserving the merge commit (or not) with various
 # --rebase flags/pull.rebase settings.
 test_expect_success 'preserve merge setup' '
@@ -699,12 +699,12 @@ test_expect_success 'pull --rebase dies early with dirty working directory' '
 '
 
 test_expect_success 'pull --rebase works on branch yet to be born' '
-	git rev-parse master >expect &&
+	git rev-parse main >expect &&
 	mkdir empty_repo &&
 	(
 		cd empty_repo &&
 		git init &&
-		git pull --rebase .. master &&
+		git pull --rebase .. main &&
 		git rev-parse HEAD >../actual
 	) &&
 	test_cmp expect actual
@@ -720,7 +720,7 @@ test_expect_success 'pull --rebase fails on unborn branch with staged changes' '
 		echo staged-file >expect &&
 		git ls-files >actual &&
 		test_cmp expect actual &&
-		test_must_fail git pull --rebase .. master 2>err &&
+		test_must_fail git pull --rebase .. main 2>err &&
 		git ls-files >actual &&
 		test_cmp expect actual &&
 		git show :staged-file >actual &&
@@ -779,7 +779,7 @@ test_expect_success 'setup for avoiding reapplying old patches' '
 	(
 		cd dst &&
 		test_might_fail git rebase --abort &&
-		git reset --hard origin/master
+		git reset --hard origin/main
 	) &&
 	git clone --bare src src-replace.git &&
 	rm -rf src &&
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index db1a381cd9..ae80aaa480 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -99,13 +99,13 @@ test_expect_success 'git pull --force' '
 	cat >>.git/config <<-\EOF &&
 	[remote "one"]
 		url = ../parent
-		fetch = refs/heads/master:refs/heads/mirror
+		fetch = refs/heads/main:refs/heads/mirror
 	[remote "two"]
 		url = ../parent
-		fetch = refs/heads/master:refs/heads/origin
-	[branch "master"]
+		fetch = refs/heads/main:refs/heads/origin
+	[branch "main"]
 		remote = two
-		merge = refs/heads/master
+		merge = refs/heads/main
 	EOF
 	git pull two &&
 	test_commit A &&
@@ -124,9 +124,9 @@ test_expect_success 'git pull --all' '
 	[remote "two"]
 		url = ../parent
 		fetch = refs/heads/*:refs/remotes/two/*
-	[branch "master"]
+	[branch "main"]
 		remote = one
-		merge = refs/heads/master
+		merge = refs/heads/main
 	EOF
 	git pull --all
 	)
@@ -139,7 +139,7 @@ test_expect_success 'git pull --dry-run' '
 		cd clonedry &&
 		git pull --dry-run ../parent &&
 		test_path_is_missing .git/FETCH_HEAD &&
-		test_path_is_missing .git/refs/heads/master &&
+		test_path_is_missing .git/refs/heads/main &&
 		test_path_is_missing .git/index &&
 		test_path_is_missing file
 	)
@@ -153,7 +153,7 @@ test_expect_success 'git pull --all --dry-run' '
 		git remote add origin ../parent &&
 		git pull --all --dry-run &&
 		test_path_is_missing .git/FETCH_HEAD &&
-		test_path_is_missing .git/refs/remotes/origin/master &&
+		test_path_is_missing .git/refs/remotes/origin/main &&
 		test_path_is_missing .git/index &&
 		test_path_is_missing file
 	)
diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index e47b5db5d6..a2eaa877a2 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -26,19 +26,19 @@ check_config() {
 	test_cmp expect.$1 actual.$1
 }
 
-test_expect_success 'push -u master:master' '
-	git push -u upstream master:master &&
-	check_config master upstream refs/heads/master
+test_expect_success 'push -u main:main' '
+	git push -u upstream main:main &&
+	check_config main upstream refs/heads/main
 '
 
-test_expect_success 'push -u master:other' '
-	git push -u upstream master:other &&
-	check_config master upstream refs/heads/other
+test_expect_success 'push -u main:other' '
+	git push -u upstream main:other &&
+	check_config main upstream refs/heads/other
 '
 
-test_expect_success 'push -u --dry-run master:otherX' '
-	git push -u --dry-run upstream master:otherX &&
-	check_config master upstream refs/heads/other
+test_expect_success 'push -u --dry-run main:otherX' '
+	git push -u --dry-run upstream main:otherX &&
+	check_config main upstream refs/heads/other
 '
 
 test_expect_success 'push -u topic_2:topic_2' '
@@ -74,7 +74,7 @@ test_expect_success 'push -u HEAD' '
 test_expect_success TTY 'progress messages go to tty' '
 	ensure_fresh_upstream &&
 
-	test_terminal git push -u upstream master >out 2>err &&
+	test_terminal git push -u upstream main >out 2>err &&
 	test_i18ngrep "Writing objects" err
 '
 
@@ -82,7 +82,7 @@ test_expect_success 'progress messages do not go to non-tty' '
 	ensure_fresh_upstream &&
 
 	# skip progress messages, since stderr is non-tty
-	git push -u upstream master >out 2>err &&
+	git push -u upstream main >out 2>err &&
 	test_i18ngrep ! "Writing objects" err
 '
 
@@ -90,21 +90,21 @@ test_expect_success 'progress messages go to non-tty (forced)' '
 	ensure_fresh_upstream &&
 
 	# force progress messages to stderr, even though it is non-tty
-	git push -u --progress upstream master >out 2>err &&
+	git push -u --progress upstream main >out 2>err &&
 	test_i18ngrep "Writing objects" err
 '
 
 test_expect_success TTY 'push -q suppresses progress' '
 	ensure_fresh_upstream &&
 
-	test_terminal git push -u -q upstream master >out 2>err &&
+	test_terminal git push -u -q upstream main >out 2>err &&
 	test_i18ngrep ! "Writing objects" err
 '
 
 test_expect_success TTY 'push --no-progress suppresses progress' '
 	ensure_fresh_upstream &&
 
-	test_terminal git push -u --no-progress upstream master >out 2>err &&
+	test_terminal git push -u --no-progress upstream main >out 2>err &&
 	test_i18ngrep ! "Unpacking objects" err &&
 	test_i18ngrep ! "Writing objects" err
 '
@@ -112,7 +112,7 @@ test_expect_success TTY 'push --no-progress suppresses progress' '
 test_expect_success TTY 'quiet push' '
 	ensure_fresh_upstream &&
 
-	test_terminal git push --quiet --no-progress upstream master 2>&1 | tee output &&
+	test_terminal git push --quiet --no-progress upstream main 2>&1 | tee output &&
 	test_must_be_empty output
 '
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index dd8e423d25..f45ba02b8a 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -481,7 +481,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "don't fetch submodule when newly re
 	test_i18ncmp expect.err actual.err &&
 	(
 		cd submodule &&
-		git checkout -q master
+		git checkout -q main
 	)
 '
 
@@ -663,9 +663,9 @@ test_expect_success 'fetch new submodule commits on-demand without .gitmodules e
 	git config -f .gitmodules --remove-section submodule.sub1 &&
 	git add .gitmodules &&
 	git commit -m "delete gitmodules file" &&
-	git checkout -B master &&
+	git checkout -B main &&
 	git -C downstream fetch &&
-	git -C downstream checkout origin/master &&
+	git -C downstream checkout origin/main &&
 
 	C=$(git -C submodule commit-tree -m "yet another change outside refs/heads" HEAD^{tree}) &&
 	git -C submodule update-ref refs/changes/7 $C &&
diff --git a/t/t5527-fetch-odd-refs.sh b/t/t5527-fetch-odd-refs.sh
index 3b0cb98422..c6a4db4c59 100755
--- a/t/t5527-fetch-odd-refs.sh
+++ b/t/t5527-fetch-odd-refs.sh
@@ -5,13 +5,13 @@ test_description='test fetching of oddly-named refs'
 
 # afterwards we will have:
 #  HEAD - two
-#  refs/for/refs/heads/master - one
-#  refs/heads/master - three
+#  refs/for/refs/heads/main - one
+#  refs/heads/main - three
 test_expect_success 'setup repo with odd suffix ref' '
 	echo content >file &&
 	git add . &&
 	git commit -m one &&
-	git update-ref refs/for/refs/heads/master HEAD &&
+	git update-ref refs/for/refs/heads/main HEAD &&
 	echo content >>file &&
 	git commit -a -m two &&
 	echo content >>file &&
@@ -22,7 +22,7 @@ test_expect_success 'setup repo with odd suffix ref' '
 test_expect_success 'suffix ref is ignored during fetch' '
 	git clone --bare file://"$PWD" suffix &&
 	echo three >expect &&
-	git --git-dir=suffix log -1 --format=%s refs/heads/master >actual &&
+	git --git-dir=suffix log -1 --format=%s refs/heads/main >actual &&
 	test_cmp expect actual
 '
 
@@ -33,7 +33,7 @@ test_expect_success 'try to create repo with absurdly long refname' '
 	(
 		cd long &&
 		test_commit long &&
-		test_commit master
+		test_commit main
 	) &&
 	if git -C long update-ref refs/heads/$ref1440 long; then
 		test_set_prereq LONG_REF
@@ -46,7 +46,7 @@ test_expect_success LONG_REF 'fetch handles extremely long refname' '
 	git fetch long refs/heads/*:refs/remotes/long/* &&
 	cat >expect <<-\EOF &&
 	long
-	master
+	main
 	EOF
 	git for-each-ref --format="%(subject)" refs/remotes/long >actual &&
 	test_cmp expect actual
@@ -55,7 +55,7 @@ test_expect_success LONG_REF 'fetch handles extremely long refname' '
 test_expect_success LONG_REF 'push handles extremely long refname' '
 	git push long :refs/heads/$ref1440 &&
 	git -C long for-each-ref --format="%(subject)" refs/heads >actual &&
-	echo master >expect &&
+	echo main >expect &&
 	test_cmp expect actual
 '
 
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index f0a287d97d..b6d1776c98 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -41,7 +41,7 @@ test_push_failure () {
 
 # $1 = success or failure
 # $2 = push.default value
-# $3 = branch to check for actual output (master or foo)
+# $3 = branch to check for actual output (main or foo)
 # $4 = [optional] switch to triangular workflow
 test_pushdefault_workflow () {
 	workflow=central
@@ -51,8 +51,8 @@ test_pushdefault_workflow () {
 		pushdefault=parent2
 	fi
 	test_expect_success "push.default = $2 $1 in $workflow workflows" "
-		test_config branch.master.remote parent1 &&
-		test_config branch.master.merge refs/heads/foo &&
+		test_config branch.main.remote parent1 &&
+		test_config branch.main.merge refs/heads/foo &&
 		test_config remote.pushdefault $pushdefault &&
 		test_commit commit-for-$2${4+-triangular} &&
 		test_push_$1 $2 $3 ${4+repo2}
@@ -60,32 +60,32 @@ test_pushdefault_workflow () {
 }
 
 test_expect_success '"upstream" pushes to configured upstream' '
-	git checkout master &&
-	test_config branch.master.remote parent1 &&
-	test_config branch.master.merge refs/heads/foo &&
+	git checkout main &&
+	test_config branch.main.remote parent1 &&
+	test_config branch.main.merge refs/heads/foo &&
 	test_commit two &&
 	test_push_success upstream foo
 '
 
 test_expect_success '"upstream" does not push on unconfigured remote' '
-	git checkout master &&
-	test_unconfig branch.master.remote &&
+	git checkout main &&
+	test_unconfig branch.main.remote &&
 	test_commit three &&
 	test_push_failure upstream
 '
 
 test_expect_success '"upstream" does not push on unconfigured branch' '
-	git checkout master &&
-	test_config branch.master.remote parent1 &&
-	test_unconfig branch.master.merge &&
+	git checkout main &&
+	test_config branch.main.remote parent1 &&
+	test_unconfig branch.main.merge &&
 	test_commit four &&
 	test_push_failure upstream
 '
 
 test_expect_success '"upstream" does not push when remotes do not match' '
-	git checkout master &&
-	test_config branch.master.remote parent1 &&
-	test_config branch.master.merge refs/heads/foo &&
+	git checkout main &&
+	test_config branch.main.remote parent1 &&
+	test_config branch.main.merge refs/heads/foo &&
 	test_config push.default upstream &&
 	test_commit five &&
 	test_must_fail git push parent2
@@ -121,99 +121,99 @@ test_expect_success 'push from/to new branch with current creates remote branch'
 '
 
 test_expect_success 'push to existing branch, with no upstream configured' '
-	test_config branch.master.remote repo1 &&
-	git checkout master &&
+	test_config branch.main.remote repo1 &&
+	git checkout main &&
 	test_push_failure simple &&
 	test_push_failure upstream
 '
 
 test_expect_success 'push to existing branch, upstream configured with same name' '
-	test_config branch.master.remote repo1 &&
-	test_config branch.master.merge refs/heads/master &&
-	git checkout master &&
+	test_config branch.main.remote repo1 &&
+	test_config branch.main.merge refs/heads/main &&
+	git checkout main &&
 	test_commit six &&
-	test_push_success upstream master &&
+	test_push_success upstream main &&
 	test_commit seven &&
-	test_push_success simple master
+	test_push_success simple main
 '
 
 test_expect_success 'push to existing branch, upstream configured with different name' '
-	test_config branch.master.remote repo1 &&
-	test_config branch.master.merge refs/heads/other-name &&
-	git checkout master &&
+	test_config branch.main.remote repo1 &&
+	test_config branch.main.merge refs/heads/other-name &&
+	git checkout main &&
 	test_commit eight &&
 	test_push_success upstream other-name &&
 	test_commit nine &&
 	test_push_failure simple &&
 	git --git-dir=repo1 log -1 --format="%h %s" "other-name" >expect-other-name &&
-	test_push_success current master &&
+	test_push_success current main &&
 	git --git-dir=repo1 log -1 --format="%h %s" "other-name" >actual-other-name &&
 	test_cmp expect-other-name actual-other-name
 '
 
-# We are on 'master', which integrates with 'foo' from parent1
+# We are on 'main', which integrates with 'foo' from parent1
 # remote (set in test_pushdefault_workflow helper).  Push to
 # parent1 in centralized, and push to parent2 in triangular workflow.
-# The parent1 repository has 'master' and 'foo' branches, while
-# the parent2 repository has only 'master' branch.
+# The parent1 repository has 'main' and 'foo' branches, while
+# the parent2 repository has only 'main' branch.
 #
 # test_pushdefault_workflow() arguments:
 # $1 = success or failure
 # $2 = push.default value
-# $3 = branch to check for actual output (master or foo)
+# $3 = branch to check for actual output (main or foo)
 # $4 = [optional] switch to triangular workflow
 
-# update parent1's master (which is not our upstream)
-test_pushdefault_workflow success current master
+# update parent1's main (which is not our upstream)
+test_pushdefault_workflow success current main
 
 # update parent1's foo (which is our upstream)
 test_pushdefault_workflow success upstream foo
 
 # upstream is foo which is not the name of the current branch
-test_pushdefault_workflow failure simple master
+test_pushdefault_workflow failure simple main
 
-# master and foo are updated
-test_pushdefault_workflow success matching master
+# main and foo are updated
+test_pushdefault_workflow success matching main
 
-# master is updated
-test_pushdefault_workflow success current master triangular
+# main is updated
+test_pushdefault_workflow success current main triangular
 
 # upstream mode cannot be used in triangular
 test_pushdefault_workflow failure upstream foo triangular
 
 # in triangular, 'simple' works as 'current' and update the branch
 # with the same name.
-test_pushdefault_workflow success simple master triangular
+test_pushdefault_workflow success simple main triangular
 
-# master is updated (parent2 does not have foo)
-test_pushdefault_workflow success matching master triangular
+# main is updated (parent2 does not have foo)
+test_pushdefault_workflow success matching main triangular
 
 # default tests, when no push-default is specified. This
 # should behave the same as "simple" in non-triangular
 # settings, and as "current" otherwise.
 
 test_expect_success 'default behavior allows "simple" push' '
-	test_config branch.master.remote parent1 &&
-	test_config branch.master.merge refs/heads/master &&
+	test_config branch.main.remote parent1 &&
+	test_config branch.main.merge refs/heads/main &&
 	test_config remote.pushdefault parent1 &&
-	test_commit default-master-master &&
-	test_push_success "" master
+	test_commit default-main-main &&
+	test_push_success "" main
 '
 
 test_expect_success 'default behavior rejects non-simple push' '
-	test_config branch.master.remote parent1 &&
-	test_config branch.master.merge refs/heads/foo &&
+	test_config branch.main.remote parent1 &&
+	test_config branch.main.merge refs/heads/foo &&
 	test_config remote.pushdefault parent1 &&
-	test_commit default-master-foo &&
+	test_commit default-main-foo &&
 	test_push_failure ""
 '
 
 test_expect_success 'default triangular behavior acts like "current"' '
-	test_config branch.master.remote parent1 &&
-	test_config branch.master.merge refs/heads/foo &&
+	test_config branch.main.remote parent1 &&
+	test_config branch.main.merge refs/heads/foo &&
 	test_config remote.pushdefault parent2 &&
 	test_commit default-triangular &&
-	test_push_success "" master repo2
+	test_push_success "" main repo2
 '
 
 test_done
diff --git a/t/t5529-push-errors.sh b/t/t5529-push-errors.sh
index 9871307fd4..ce85fd30ad 100755
--- a/t/t5529-push-errors.sh
+++ b/t/t5529-push-errors.sh
@@ -32,7 +32,7 @@ test_expect_success 'detect missing branches early' '
 test_expect_success 'detect missing sha1 expressions early' '
 	echo no >rp-ran &&
 	echo no >expect &&
-	test_must_fail git push origin master~2:master &&
+	test_must_fail git push origin main~2:main &&
 	test_cmp expect rp-ran
 '
 
diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index 9dd2d2457a..7c1460eaa9 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -115,7 +115,7 @@ test_expect_success 'create empty repository' '
 
 test_expect_success 'fetch fails' '
 
-	test_must_fail git fetch .. master
+	test_must_fail git fetch .. main
 
 '
 
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 4ad059e6be..afc0cd79f6 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -30,7 +30,7 @@ test_expect_success setup '
 test_expect_success 'push works with recorded gitlink' '
 	(
 		cd work &&
-		git push ../pub.git master
+		git push ../pub.git main
 	)
 '
 
@@ -45,7 +45,7 @@ test_expect_success 'push if submodule has no remote' '
 		cd work &&
 		git add gar/bage &&
 		git commit -m "Second commit for gar/bage" &&
-		git push --recurse-submodules=check ../pub.git master
+		git push --recurse-submodules=check ../pub.git main
 	)
 '
 
@@ -66,21 +66,21 @@ test_expect_success 'push fails if submodule commit not on remote' '
 		git commit -m "Third commit for gar/bage" &&
 		# the push should fail with --recurse-submodules=check
 		# on the command line...
-		test_must_fail git push --recurse-submodules=check ../pub.git master &&
+		test_must_fail git push --recurse-submodules=check ../pub.git main &&
 
 		# ...or if specified in the configuration..
-		test_must_fail git -c push.recurseSubmodules=check push ../pub.git master
+		test_must_fail git -c push.recurseSubmodules=check push ../pub.git main
 	)
 '
 
 test_expect_success 'push succeeds after commit was pushed to remote' '
 	(
 		cd work/gar/bage &&
-		git push origin master
+		git push origin main
 	) &&
 	(
 		cd work &&
-		git push --recurse-submodules=check ../pub.git master
+		git push --recurse-submodules=check ../pub.git main
 	)
 '
 
@@ -95,13 +95,13 @@ test_expect_success 'push succeeds if submodule commit not on remote but using o
 		cd work &&
 		git add gar/bage &&
 		git commit -m "Recurse on-demand on command line for gar/bage" &&
-		git push --recurse-submodules=on-demand ../pub.git master &&
+		git push --recurse-submodules=on-demand ../pub.git main &&
 		# Check that the supermodule commit got there
 		git fetch ../pub.git &&
-		git diff --quiet FETCH_HEAD master &&
+		git diff --quiet FETCH_HEAD main &&
 		# Check that the submodule commit got there too
 		cd gar/bage &&
-		git diff --quiet origin/master master
+		git diff --quiet origin/main main
 	)
 '
 
@@ -116,13 +116,13 @@ test_expect_success 'push succeeds if submodule commit not on remote but using o
 		cd work &&
 		git add gar/bage &&
 		git commit -m "Recurse on-demand from config for gar/bage" &&
-		git -c push.recurseSubmodules=on-demand push ../pub.git master &&
+		git -c push.recurseSubmodules=on-demand push ../pub.git main &&
 		# Check that the supermodule commit got there
 		git fetch ../pub.git &&
-		git diff --quiet FETCH_HEAD master &&
+		git diff --quiet FETCH_HEAD main &&
 		# Check that the submodule commit got there too
 		cd gar/bage &&
-		git diff --quiet origin/master master
+		git diff --quiet origin/main main
 	)
 '
 
@@ -137,13 +137,13 @@ test_expect_success 'push succeeds if submodule commit not on remote but using a
 		cd work &&
 		git add gar/bage &&
 		git commit -m "Recurse submodule.recurse from config for gar/bage" &&
-		git -c submodule.recurse push ../pub.git master &&
+		git -c submodule.recurse push ../pub.git main &&
 		# Check that the supermodule commit got there
 		git fetch ../pub.git &&
-		git diff --quiet FETCH_HEAD master &&
+		git diff --quiet FETCH_HEAD main &&
 		# Check that the submodule commit got there too
 		cd gar/bage &&
-		git diff --quiet origin/master master
+		git diff --quiet origin/main main
 	)
 '
 
@@ -161,34 +161,34 @@ test_expect_success 'push recurse-submodules on command line overrides config' '
 
 		# Ensure that we can override on-demand in the config
 		# to just check submodules
-		test_must_fail git -c push.recurseSubmodules=on-demand push --recurse-submodules=check ../pub.git master &&
+		test_must_fail git -c push.recurseSubmodules=on-demand push --recurse-submodules=check ../pub.git main &&
 		# Check that the supermodule commit did not get there
 		git fetch ../pub.git &&
-		git diff --quiet FETCH_HEAD master^ &&
+		git diff --quiet FETCH_HEAD main^ &&
 		# Check that the submodule commit did not get there
-		(cd gar/bage && git diff --quiet origin/master master^) &&
+		(cd gar/bage && git diff --quiet origin/main main^) &&
 
 		# Ensure that we can override check in the config to
 		# disable submodule recursion entirely
-		(cd gar/bage && git diff --quiet origin/master master^) &&
-		git -c push.recurseSubmodules=on-demand push --recurse-submodules=no ../pub.git master &&
+		(cd gar/bage && git diff --quiet origin/main main^) &&
+		git -c push.recurseSubmodules=on-demand push --recurse-submodules=no ../pub.git main &&
 		git fetch ../pub.git &&
-		git diff --quiet FETCH_HEAD master &&
-		(cd gar/bage && git diff --quiet origin/master master^) &&
+		git diff --quiet FETCH_HEAD main &&
+		(cd gar/bage && git diff --quiet origin/main main^) &&
 
 		# Ensure that we can override check in the config to
 		# disable submodule recursion entirely (alternative form)
-		git -c push.recurseSubmodules=on-demand push --no-recurse-submodules ../pub.git master &&
+		git -c push.recurseSubmodules=on-demand push --no-recurse-submodules ../pub.git main &&
 		git fetch ../pub.git &&
-		git diff --quiet FETCH_HEAD master &&
-		(cd gar/bage && git diff --quiet origin/master master^) &&
+		git diff --quiet FETCH_HEAD main &&
+		(cd gar/bage && git diff --quiet origin/main main^) &&
 
 		# Ensure that we can override check in the config to
 		# push the submodule too
-		git -c push.recurseSubmodules=check push --recurse-submodules=on-demand ../pub.git master &&
+		git -c push.recurseSubmodules=check push --recurse-submodules=on-demand ../pub.git main &&
 		git fetch ../pub.git &&
-		git diff --quiet FETCH_HEAD master &&
-		(cd gar/bage && git diff --quiet origin/master master)
+		git diff --quiet FETCH_HEAD main &&
+		(cd gar/bage && git diff --quiet origin/main main)
 	)
 '
 
@@ -205,31 +205,31 @@ test_expect_success 'push recurse-submodules last one wins on command line' '
 		git commit -m "Recurse on command-line overriding earlier command-line for gar/bage" &&
 
 		# should result in "check"
-		test_must_fail git push --recurse-submodules=on-demand --recurse-submodules=check ../pub.git master &&
+		test_must_fail git push --recurse-submodules=on-demand --recurse-submodules=check ../pub.git main &&
 		# Check that the supermodule commit did not get there
 		git fetch ../pub.git &&
-		git diff --quiet FETCH_HEAD master^ &&
+		git diff --quiet FETCH_HEAD main^ &&
 		# Check that the submodule commit did not get there
-		(cd gar/bage && git diff --quiet origin/master master^) &&
+		(cd gar/bage && git diff --quiet origin/main main^) &&
 
 		# should result in "no"
-		git push --recurse-submodules=on-demand --recurse-submodules=no ../pub.git master &&
+		git push --recurse-submodules=on-demand --recurse-submodules=no ../pub.git main &&
 		# Check that the supermodule commit did get there
 		git fetch ../pub.git &&
-		git diff --quiet FETCH_HEAD master &&
+		git diff --quiet FETCH_HEAD main &&
 		# Check that the submodule commit did not get there
-		(cd gar/bage && git diff --quiet origin/master master^) &&
+		(cd gar/bage && git diff --quiet origin/main main^) &&
 
 		# should result in "no"
-		git push --recurse-submodules=on-demand --no-recurse-submodules ../pub.git master &&
+		git push --recurse-submodules=on-demand --no-recurse-submodules ../pub.git main &&
 		# Check that the submodule commit did not get there
-		(cd gar/bage && git diff --quiet origin/master master^) &&
+		(cd gar/bage && git diff --quiet origin/main main^) &&
 
 		# But the options in the other order should push the submodule
-		git push --recurse-submodules=check --recurse-submodules=on-demand ../pub.git master &&
+		git push --recurse-submodules=check --recurse-submodules=on-demand ../pub.git main &&
 		# Check that the submodule commit did get there
 		git fetch ../pub.git &&
-		(cd gar/bage && git diff --quiet origin/master master)
+		(cd gar/bage && git diff --quiet origin/main main)
 	)
 '
 
@@ -244,13 +244,13 @@ test_expect_success 'push succeeds if submodule commit not on remote using on-de
 		cd work &&
 		git add gar/bage &&
 		git commit -m "Recurse on-demand on command-line overriding config for gar/bage" &&
-		git -c push.recurseSubmodules=check push --recurse-submodules=on-demand ../pub.git master &&
+		git -c push.recurseSubmodules=check push --recurse-submodules=on-demand ../pub.git main &&
 		# Check that the supermodule commit got there
 		git fetch ../pub.git &&
-		git diff --quiet FETCH_HEAD master &&
+		git diff --quiet FETCH_HEAD main &&
 		# Check that the submodule commit got there
 		cd gar/bage &&
-		git diff --quiet origin/master master
+		git diff --quiet origin/main main
 	)
 '
 
@@ -265,14 +265,14 @@ test_expect_success 'push succeeds if submodule commit disabling recursion from
 		cd work &&
 		git add gar/bage &&
 		git commit -m "Recurse disable on command-line overriding config for gar/bage" &&
-		git -c push.recurseSubmodules=check push --recurse-submodules=no ../pub.git master &&
+		git -c push.recurseSubmodules=check push --recurse-submodules=no ../pub.git main &&
 		# Check that the supermodule commit got there
 		git fetch ../pub.git &&
-		git diff --quiet FETCH_HEAD master &&
+		git diff --quiet FETCH_HEAD main &&
 		# But that the submodule commit did not
-		( cd gar/bage && git diff --quiet origin/master master^ ) &&
+		( cd gar/bage && git diff --quiet origin/main main^ ) &&
 		# Now push it to avoid confusing future tests
-		git push --recurse-submodules=on-demand ../pub.git master
+		git push --recurse-submodules=on-demand ../pub.git main
 	)
 '
 
@@ -287,14 +287,14 @@ test_expect_success 'push succeeds if submodule commit disabling recursion from
 		cd work &&
 		git add gar/bage &&
 		git commit -m "Recurse disable on command-line alternative overriding config for gar/bage" &&
-		git -c push.recurseSubmodules=check push --no-recurse-submodules ../pub.git master &&
+		git -c push.recurseSubmodules=check push --no-recurse-submodules ../pub.git main &&
 		# Check that the supermodule commit got there
 		git fetch ../pub.git &&
-		git diff --quiet FETCH_HEAD master &&
+		git diff --quiet FETCH_HEAD main &&
 		# But that the submodule commit did not
-		( cd gar/bage && git diff --quiet origin/master master^ ) &&
+		( cd gar/bage && git diff --quiet origin/main main^ ) &&
 		# Now push it to avoid confusing future tests
-		git push --recurse-submodules=on-demand ../pub.git master
+		git push --recurse-submodules=on-demand ../pub.git main
 	)
 '
 
@@ -304,7 +304,7 @@ test_expect_success 'submodule entry pointing at a tag is error' '
 	git -C work update-index --cacheinfo 160000 "$tag" gar/bage &&
 	git -C work commit -m "bad commit" &&
 	test_when_finished "git -C work reset --hard HEAD^" &&
-	test_must_fail git -C work push --recurse-submodules=on-demand ../pub.git master 2>err &&
+	test_must_fail git -C work push --recurse-submodules=on-demand ../pub.git main 2>err &&
 	test_i18ngrep "is a tag, not a commit" err
 '
 
@@ -319,9 +319,9 @@ test_expect_success 'push fails if recurse submodules option passed as yes' '
 		cd work &&
 		git add gar/bage &&
 		git commit -m "Recurse push fails if recurse submodules option passed as yes for gar/bage" &&
-		test_must_fail git push --recurse-submodules=yes ../pub.git master &&
-		test_must_fail git -c push.recurseSubmodules=yes push ../pub.git master &&
-		git push --recurse-submodules=on-demand ../pub.git master
+		test_must_fail git push --recurse-submodules=yes ../pub.git main &&
+		test_must_fail git -c push.recurseSubmodules=yes push ../pub.git main &&
+		git push --recurse-submodules=on-demand ../pub.git main
 	)
 '
 
@@ -363,7 +363,7 @@ test_expect_success 'push succeeds if submodule has no remote and is on the firs
 		) &&
 		git add b &&
 		git commit -m "added submodule" &&
-		git push --recurse-submodules=check origin master
+		git push --recurse-submodules=check origin main
 	)
 '
 
@@ -372,21 +372,21 @@ test_expect_success 'push unpushed submodules when not needed' '
 		cd work &&
 		(
 			cd gar/bage &&
-			git checkout master &&
+			git checkout main &&
 			>junk5 &&
 			git add junk5 &&
 			git commit -m "Fifth junk" &&
 			git push &&
-			git rev-parse origin/master >../../../expected
+			git rev-parse origin/main >../../../expected
 		) &&
-		git checkout master &&
+		git checkout main &&
 		git add gar/bage &&
 		git commit -m "Fifth commit for gar/bage" &&
-		git push --recurse-submodules=on-demand ../pub.git master
+		git push --recurse-submodules=on-demand ../pub.git main
 	) &&
 	(
 		cd submodule.git &&
-		git rev-parse master >../actual
+		git rev-parse main >../actual
 	) &&
 	test_cmp expected actual
 '
@@ -394,7 +394,7 @@ test_expect_success 'push unpushed submodules when not needed' '
 test_expect_success 'push unpushed submodules when not needed 2' '
 	(
 		cd submodule.git &&
-		git rev-parse master >../expected
+		git rev-parse main >../expected
 	) &&
 	(
 		cd work &&
@@ -407,11 +407,11 @@ test_expect_success 'push unpushed submodules when not needed 2' '
 		>junk2 &&
 		git add junk2 &&
 		git commit -m "Second junk for work" &&
-		git push --recurse-submodules=on-demand ../pub.git master
+		git push --recurse-submodules=on-demand ../pub.git main
 	) &&
 	(
 		cd submodule.git &&
-		git rev-parse master >../actual
+		git rev-parse main >../actual
 	) &&
 	test_cmp expected actual
 '
@@ -421,20 +421,20 @@ test_expect_success 'push unpushed submodules recursively' '
 		cd work &&
 		(
 			cd gar/bage &&
-			git checkout master &&
+			git checkout main &&
 			> junk7 &&
 			git add junk7 &&
 			git commit -m "Seventh junk" &&
-			git rev-parse master >../../../expected
+			git rev-parse main >../../../expected
 		) &&
-		git checkout master &&
+		git checkout main &&
 		git add gar/bage &&
 		git commit -m "Seventh commit for gar/bage" &&
-		git push --recurse-submodules=on-demand ../pub.git master
+		git push --recurse-submodules=on-demand ../pub.git main
 	) &&
 	(
 		cd submodule.git &&
-		git rev-parse master >../actual
+		git rev-parse main >../actual
 	) &&
 	test_cmp expected actual
 '
@@ -444,64 +444,64 @@ test_expect_success 'push unpushable submodule recursively fails' '
 		cd work &&
 		(
 			cd gar/bage &&
-			git rev-parse origin/master >../../../expected &&
-			git checkout master~0 &&
+			git rev-parse origin/main >../../../expected &&
+			git checkout main~0 &&
 			> junk8 &&
 			git add junk8 &&
 			git commit -m "Eighth junk"
 		) &&
 		git add gar/bage &&
 		git commit -m "Eighth commit for gar/bage" &&
-		test_must_fail git push --recurse-submodules=on-demand ../pub.git master
+		test_must_fail git push --recurse-submodules=on-demand ../pub.git main
 	) &&
 	(
 		cd submodule.git &&
-		git rev-parse master >../actual
+		git rev-parse main >../actual
 	) &&
-	test_when_finished git -C work reset --hard master^ &&
+	test_when_finished git -C work reset --hard main^ &&
 	test_cmp expected actual
 '
 
 test_expect_success 'push --dry-run does not recursively update submodules' '
 	(
 		cd work/gar/bage &&
-		git checkout master &&
-		git rev-parse master >../../../expected_submodule &&
+		git checkout main &&
+		git rev-parse main >../../../expected_submodule &&
 		> junk9 &&
 		git add junk9 &&
 		git commit -m "Ninth junk" &&
 
 		# Go up to 'work' directory
 		cd ../.. &&
-		git checkout master &&
-		git rev-parse master >../expected_pub &&
+		git checkout main &&
+		git rev-parse main >../expected_pub &&
 		git add gar/bage &&
 		git commit -m "Ninth commit for gar/bage" &&
-		git push --dry-run --recurse-submodules=on-demand ../pub.git master
+		git push --dry-run --recurse-submodules=on-demand ../pub.git main
 	) &&
-	git -C submodule.git rev-parse master >actual_submodule &&
-	git -C pub.git rev-parse master >actual_pub &&
+	git -C submodule.git rev-parse main >actual_submodule &&
+	git -C pub.git rev-parse main >actual_pub &&
 	test_cmp expected_pub actual_pub &&
 	test_cmp expected_submodule actual_submodule
 '
 
 test_expect_success 'push --dry-run does not recursively update submodules' '
-	git -C work push --dry-run --recurse-submodules=only ../pub.git master &&
+	git -C work push --dry-run --recurse-submodules=only ../pub.git main &&
 
-	git -C submodule.git rev-parse master >actual_submodule &&
-	git -C pub.git rev-parse master >actual_pub &&
+	git -C submodule.git rev-parse main >actual_submodule &&
+	git -C pub.git rev-parse main >actual_pub &&
 	test_cmp expected_pub actual_pub &&
 	test_cmp expected_submodule actual_submodule
 '
 
 test_expect_success 'push only unpushed submodules recursively' '
-	git -C work/gar/bage rev-parse master >expected_submodule &&
-	git -C pub.git rev-parse master >expected_pub &&
+	git -C work/gar/bage rev-parse main >expected_submodule &&
+	git -C pub.git rev-parse main >expected_pub &&
 
-	git -C work push --recurse-submodules=only ../pub.git master &&
+	git -C work push --recurse-submodules=only ../pub.git main &&
 
-	git -C submodule.git rev-parse master >actual_submodule &&
-	git -C pub.git rev-parse master >actual_pub &&
+	git -C submodule.git rev-parse main >actual_submodule &&
+	git -C pub.git rev-parse main >actual_pub &&
 	test_cmp expected_submodule actual_submodule &&
 	test_cmp expected_pub actual_pub
 '
@@ -517,14 +517,14 @@ test_expect_success 'push propagating the remotes name to a submodule' '
 	git -C work commit -m "Tenth junk added to gar/bage" &&
 
 	# Fails when submodule does not have a matching remote
-	test_must_fail git -C work push --recurse-submodules=on-demand pub master &&
+	test_must_fail git -C work push --recurse-submodules=on-demand pub main &&
 	# Succeeds when submodules has matching remote and refspec
-	git -C work push --recurse-submodules=on-demand origin master &&
+	git -C work push --recurse-submodules=on-demand origin main &&
 
-	git -C submodule.git rev-parse master >actual_submodule &&
-	git -C pub.git rev-parse master >actual_pub &&
-	git -C work/gar/bage rev-parse master >expected_submodule &&
-	git -C work rev-parse master >expected_pub &&
+	git -C submodule.git rev-parse main >actual_submodule &&
+	git -C pub.git rev-parse main >actual_pub &&
+	git -C work/gar/bage rev-parse main >expected_submodule &&
+	git -C work rev-parse main >expected_pub &&
 	test_cmp expected_submodule actual_submodule &&
 	test_cmp expected_pub actual_pub
 '
@@ -548,7 +548,7 @@ test_expect_success 'push propagating refspec to a submodule' '
 	test_must_fail git -C work push --recurse-submodules=on-demand origin \
 		HEAD:refs/heads/branch2 &&
 
-	git -C work/gar/bage branch branch2 master &&
+	git -C work/gar/bage branch branch2 main &&
 	git -C work push --recurse-submodules=on-demand origin branch2 &&
 
 	git -C submodule.git rev-parse branch2 >actual_submodule &&
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index 7813e8470e..9fcec604c3 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -29,22 +29,22 @@ setup_src_dup_dst () {
 	(
 		cd dup &&
 		git fetch &&
-		git merge origin/master &&
-		git switch -c branch master~2 &&
+		git merge origin/main &&
+		git switch -c branch main~2 &&
 		test_commit D &&
 		test_commit E &&
 		git push origin --all
 	) &&
 	(
 		cd src &&
-		git switch master &&
+		git switch main &&
 		git fetch --all &&
 		git branch branch --track origin/branch &&
-		git rebase origin/master
+		git rebase origin/main
 	) &&
 	(
 		cd dup &&
-		git switch master &&
+		git switch main &&
 		test_commit F &&
 		test_commit G &&
 		git switch branch &&
@@ -65,11 +65,11 @@ test_expect_success 'push to update (protected)' '
 	(
 		cd dst &&
 		test_commit D &&
-		test_must_fail git push --force-with-lease=master:master origin master 2>err &&
+		test_must_fail git push --force-with-lease=main:main origin main 2>err &&
 		grep "stale info" err
 	) &&
-	git ls-remote . refs/heads/master >expect &&
-	git ls-remote src refs/heads/master >actual &&
+	git ls-remote . refs/heads/main >expect &&
+	git ls-remote src refs/heads/main >actual &&
 	test_cmp expect actual
 '
 
@@ -78,11 +78,11 @@ test_expect_success 'push to update (protected, forced)' '
 	(
 		cd dst &&
 		test_commit D &&
-		git push --force --force-with-lease=master:master origin master 2>err &&
+		git push --force --force-with-lease=main:main origin main 2>err &&
 		grep "forced update" err
 	) &&
-	git ls-remote dst refs/heads/master >expect &&
-	git ls-remote src refs/heads/master >actual &&
+	git ls-remote dst refs/heads/main >expect &&
+	git ls-remote src refs/heads/main >actual &&
 	test_cmp expect actual
 '
 
@@ -90,20 +90,20 @@ test_expect_success 'push to update (protected, tracking)' '
 	setup_srcdst_basic &&
 	(
 		cd src &&
-		git checkout master &&
+		git checkout main &&
 		test_commit D &&
 		git checkout HEAD^0
 	) &&
-	git ls-remote src refs/heads/master >expect &&
+	git ls-remote src refs/heads/main >expect &&
 	(
 		cd dst &&
 		test_commit E &&
-		git ls-remote . refs/remotes/origin/master >expect &&
-		test_must_fail git push --force-with-lease=master origin master &&
-		git ls-remote . refs/remotes/origin/master >actual &&
+		git ls-remote . refs/remotes/origin/main >expect &&
+		test_must_fail git push --force-with-lease=main origin main &&
+		git ls-remote . refs/remotes/origin/main >actual &&
 		test_cmp expect actual
 	) &&
-	git ls-remote src refs/heads/master >actual &&
+	git ls-remote src refs/heads/main >actual &&
 	test_cmp expect actual
 '
 
@@ -111,18 +111,18 @@ test_expect_success 'push to update (protected, tracking, forced)' '
 	setup_srcdst_basic &&
 	(
 		cd src &&
-		git checkout master &&
+		git checkout main &&
 		test_commit D &&
 		git checkout HEAD^0
 	) &&
 	(
 		cd dst &&
 		test_commit E &&
-		git ls-remote . refs/remotes/origin/master >expect &&
-		git push --force --force-with-lease=master origin master
+		git ls-remote . refs/remotes/origin/main >expect &&
+		git push --force --force-with-lease=main origin main
 	) &&
-	git ls-remote dst refs/heads/master >expect &&
-	git ls-remote src refs/heads/master >actual &&
+	git ls-remote dst refs/heads/main >expect &&
+	git ls-remote src refs/heads/main >actual &&
 	test_cmp expect actual
 '
 
@@ -131,10 +131,10 @@ test_expect_success 'push to update (allowed)' '
 	(
 		cd dst &&
 		test_commit D &&
-		git push --force-with-lease=master:master^ origin master
+		git push --force-with-lease=main:main^ origin main
 	) &&
-	git ls-remote dst refs/heads/master >expect &&
-	git ls-remote src refs/heads/master >actual &&
+	git ls-remote dst refs/heads/main >expect &&
+	git ls-remote src refs/heads/main >actual &&
 	test_cmp expect actual
 '
 
@@ -143,11 +143,11 @@ test_expect_success 'push to update (allowed, tracking)' '
 	(
 		cd dst &&
 		test_commit D &&
-		git push --force-with-lease=master origin master 2>err &&
+		git push --force-with-lease=main origin main 2>err &&
 		! grep "forced update" err
 	) &&
-	git ls-remote dst refs/heads/master >expect &&
-	git ls-remote src refs/heads/master >actual &&
+	git ls-remote dst refs/heads/main >expect &&
+	git ls-remote src refs/heads/main >actual &&
 	test_cmp expect actual
 '
 
@@ -157,22 +157,22 @@ test_expect_success 'push to update (allowed even though no-ff)' '
 		cd dst &&
 		git reset --hard HEAD^ &&
 		test_commit D &&
-		git push --force-with-lease=master origin master 2>err &&
+		git push --force-with-lease=main origin main 2>err &&
 		grep "forced update" err
 	) &&
-	git ls-remote dst refs/heads/master >expect &&
-	git ls-remote src refs/heads/master >actual &&
+	git ls-remote dst refs/heads/main >expect &&
+	git ls-remote src refs/heads/main >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'push to delete (protected)' '
 	setup_srcdst_basic &&
-	git ls-remote src refs/heads/master >expect &&
+	git ls-remote src refs/heads/main >expect &&
 	(
 		cd dst &&
-		test_must_fail git push --force-with-lease=master:master^ origin :master
+		test_must_fail git push --force-with-lease=main:main^ origin :main
 	) &&
-	git ls-remote src refs/heads/master >actual &&
+	git ls-remote src refs/heads/main >actual &&
 	test_cmp expect actual
 '
 
@@ -180,9 +180,9 @@ test_expect_success 'push to delete (protected, forced)' '
 	setup_srcdst_basic &&
 	(
 		cd dst &&
-		git push --force --force-with-lease=master:master^ origin :master
+		git push --force --force-with-lease=main:main^ origin :main
 	) &&
-	git ls-remote src refs/heads/master >actual &&
+	git ls-remote src refs/heads/main >actual &&
 	test_must_be_empty actual
 '
 
@@ -190,10 +190,10 @@ test_expect_success 'push to delete (allowed)' '
 	setup_srcdst_basic &&
 	(
 		cd dst &&
-		git push --force-with-lease=master origin :master 2>err &&
+		git push --force-with-lease=main origin :main 2>err &&
 		grep deleted err
 	) &&
-	git ls-remote src refs/heads/master >actual &&
+	git ls-remote src refs/heads/main >actual &&
 	test_must_be_empty actual
 '
 
@@ -201,12 +201,12 @@ test_expect_success 'cover everything with default force-with-lease (protected)'
 	setup_srcdst_basic &&
 	(
 		cd src &&
-		git branch naster master^
+		git branch nain main^
 	) &&
 	git ls-remote src refs/heads/\* >expect &&
 	(
 		cd dst &&
-		test_must_fail git push --force-with-lease origin master master:naster
+		test_must_fail git push --force-with-lease origin main main:nain
 	) &&
 	git ls-remote src refs/heads/\* >actual &&
 	test_cmp expect actual
@@ -216,16 +216,16 @@ test_expect_success 'cover everything with default force-with-lease (allowed)' '
 	setup_srcdst_basic &&
 	(
 		cd src &&
-		git branch naster master^
+		git branch nain main^
 	) &&
 	(
 		cd dst &&
 		git fetch &&
-		git push --force-with-lease origin master master:naster
+		git push --force-with-lease origin main main:nain
 	) &&
-	git ls-remote dst refs/heads/master |
-	sed -e "s/master/naster/" >expect &&
-	git ls-remote src refs/heads/naster >actual &&
+	git ls-remote dst refs/heads/main |
+	sed -e "s/main/nain/" >expect &&
+	git ls-remote src refs/heads/nain >actual &&
 	test_cmp expect actual
 '
 
@@ -233,7 +233,7 @@ test_expect_success 'new branch covered by force-with-lease' '
 	setup_srcdst_basic &&
 	(
 		cd dst &&
-		git branch branch master &&
+		git branch branch main &&
 		git push --force-with-lease=branch origin branch
 	) &&
 	git ls-remote dst refs/heads/branch >expect &&
@@ -245,7 +245,7 @@ test_expect_success 'new branch covered by force-with-lease (explicit)' '
 	setup_srcdst_basic &&
 	(
 		cd dst &&
-		git branch branch master &&
+		git branch branch main &&
 		git push --force-with-lease=branch: origin branch
 	) &&
 	git ls-remote dst refs/heads/branch >expect &&
@@ -257,12 +257,12 @@ test_expect_success 'new branch already exists' '
 	setup_srcdst_basic &&
 	(
 		cd src &&
-		git checkout -b branch master &&
+		git checkout -b branch main &&
 		test_commit F
 	) &&
 	(
 		cd dst &&
-		git branch branch master &&
+		git branch branch main &&
 		test_must_fail git push --force-with-lease=branch: origin branch
 	)
 '
@@ -277,7 +277,7 @@ test_expect_success 'background updates of REMOTE can be mitigated with a non-up
 		cd dst &&
 		test_commit G &&
 		git remote add origin-push ../src.bare &&
-		git push origin-push master:master
+		git push origin-push main:main
 	) &&
 	git clone --no-local src.bare dst2 &&
 	test_when_finished "rm -rf dst2" &&
@@ -299,58 +299,58 @@ test_expect_success 'background updates of REMOTE can be mitigated with a non-up
 test_expect_success 'background updates to remote can be mitigated with "--force-if-includes"' '
 	setup_src_dup_dst &&
 	test_when_finished "rm -fr dst src dup" &&
-	git ls-remote dst refs/heads/master >expect.master &&
+	git ls-remote dst refs/heads/main >expect.main &&
 	git ls-remote dst refs/heads/branch >expect.branch &&
 	(
 		cd src &&
 		git switch branch &&
 		test_commit I &&
-		git switch master &&
+		git switch main &&
 		test_commit J &&
 		git fetch --all &&
 		test_must_fail git push --force-with-lease --force-if-includes --all
 	) &&
-	git ls-remote dst refs/heads/master >actual.master &&
+	git ls-remote dst refs/heads/main >actual.main &&
 	git ls-remote dst refs/heads/branch >actual.branch &&
-	test_cmp expect.master actual.master &&
+	test_cmp expect.main actual.main &&
 	test_cmp expect.branch actual.branch
 '
 
 test_expect_success 'background updates to remote can be mitigated with "push.useForceIfIncludes"' '
 	setup_src_dup_dst &&
 	test_when_finished "rm -fr dst src dup" &&
-	git ls-remote dst refs/heads/master >expect.master &&
+	git ls-remote dst refs/heads/main >expect.main &&
 	(
 		cd src &&
 		git switch branch &&
 		test_commit I &&
-		git switch master &&
+		git switch main &&
 		test_commit J &&
 		git fetch --all &&
 		git config --local push.useForceIfIncludes true &&
-		test_must_fail git push --force-with-lease=master origin master
+		test_must_fail git push --force-with-lease=main origin main
 	) &&
-	git ls-remote dst refs/heads/master >actual.master &&
-	test_cmp expect.master actual.master
+	git ls-remote dst refs/heads/main >actual.main &&
+	test_cmp expect.main actual.main
 '
 
 test_expect_success '"--force-if-includes" should be disabled for --force-with-lease="<refname>:<expect>"' '
 	setup_src_dup_dst &&
 	test_when_finished "rm -fr dst src dup" &&
-	git ls-remote dst refs/heads/master >expect.master &&
+	git ls-remote dst refs/heads/main >expect.main &&
 	(
 		cd src &&
 		git switch branch &&
 		test_commit I &&
-		git switch master &&
+		git switch main &&
 		test_commit J &&
-		remote_head="$(git rev-parse refs/remotes/origin/master)" &&
+		remote_head="$(git rev-parse refs/remotes/origin/main)" &&
 		git fetch --all &&
-		test_must_fail git push --force-if-includes --force-with-lease="master:$remote_head" 2>err &&
+		test_must_fail git push --force-if-includes --force-with-lease="main:$remote_head" 2>err &&
 		grep "stale info" err
 	) &&
-	git ls-remote dst refs/heads/master >actual.master &&
-	test_cmp expect.master actual.master
+	git ls-remote dst refs/heads/main >actual.main &&
+	test_cmp expect.main actual.main
 '
 
 test_expect_success '"--force-if-includes" should allow forced update after a rebase ("pull --rebase")' '
@@ -360,10 +360,10 @@ test_expect_success '"--force-if-includes" should allow forced update after a re
 		cd src &&
 		git switch branch &&
 		test_commit I &&
-		git switch master &&
+		git switch main &&
 		test_commit J &&
-		git pull --rebase origin master &&
-		git push --force-if-includes --force-with-lease="master"
+		git pull --rebase origin main &&
+		git push --force-if-includes --force-with-lease="main"
 	)
 '
 
@@ -374,11 +374,11 @@ test_expect_success '"--force-if-includes" should allow forced update after a re
 		cd src &&
 		git switch branch &&
 		test_commit I &&
-		git switch master &&
+		git switch main &&
 		test_commit J &&
-		git pull --rebase origin master &&
+		git pull --rebase origin main &&
 		git rebase --onto HEAD~4 HEAD~1 &&
-		git push --force-if-includes --force-with-lease="master"
+		git push --force-if-includes --force-with-lease="main"
 	)
 '
 
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index af0385fb89..0e850a76de 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -9,11 +9,11 @@ prepare_dst () {
 	rm -fr dst &&
 	test_create_repo dst &&
 
-	git push dst master:noop master:ff master:noff
+	git push dst main:noop main:ff main:noff
 }
 
 test_expect_success setup '
-	# master, ff and noff branches pointing at the same commit
+	# main, ff and noff branches pointing at the same commit
 	test_tick &&
 	git commit --allow-empty -m initial &&
 
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index a55202d2d3..01071f2306 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -49,7 +49,7 @@ test_expect_success 'fetch from shallow clone' '
 	cd shallow2 &&
 	git fetch &&
 	git fsck &&
-	git log --format=%s origin/master >actual &&
+	git log --format=%s origin/main >actual &&
 	test_write_lines 5 4 3 >expect &&
 	test_cmp expect actual
 	)
@@ -64,7 +64,7 @@ test_expect_success 'fetch --depth from shallow clone' '
 	cd shallow2 &&
 	git fetch --depth=2 &&
 	git fsck &&
-	git log --format=%s origin/master >actual &&
+	git log --format=%s origin/main >actual &&
 	test_write_lines 6 5 >expect &&
 	test_cmp expect actual
 	)
@@ -75,7 +75,7 @@ test_expect_success 'fetch --unshallow from shallow clone' '
 	cd shallow2 &&
 	git fetch --unshallow &&
 	git fsck &&
-	git log --format=%s origin/master >actual &&
+	git log --format=%s origin/main >actual &&
 	test_write_lines 6 5 4 3 >expect &&
 	test_cmp expect actual
 	)
@@ -89,7 +89,7 @@ test_expect_success 'fetch --unshallow from a full clone' '
 	test_write_lines 4 3 >expect &&
 	test_cmp expect actual &&
 	git -c fetch.writeCommitGraph fetch --unshallow &&
-	git log origin/master --format=%s >actual &&
+	git log origin/main --format=%s >actual &&
 	test_write_lines 4 3 2 1 >expect &&
 	test_cmp expect actual
 	)
@@ -104,9 +104,9 @@ test_expect_success 'fetch something upstream has but hidden by clients shallow
 	git commit -m add-1-back &&
 	(
 	cd shallow2 &&
-	git fetch ../.git +refs/heads/master:refs/remotes/top/master &&
+	git fetch ../.git +refs/heads/main:refs/remotes/top/main &&
 	git fsck &&
-	git log --format=%s top/master >actual &&
+	git log --format=%s top/main >actual &&
 	test_write_lines add-1-back 4 3 >expect &&
 	test_cmp expect actual
 	) &&
@@ -135,7 +135,7 @@ test_expect_success 'fetch that requires changes in .git/shallow is filtered' '
 test_expect_success 'fetch --update-shallow' '
 	(
 	cd shallow &&
-	git checkout master &&
+	git checkout main &&
 	commit 7 &&
 	git tag -m foo heavy-tag HEAD^ &&
 	git tag light-tag HEAD^:tracked
@@ -146,13 +146,13 @@ test_expect_success 'fetch --update-shallow' '
 	git fsck &&
 	git for-each-ref --sort=refname --format="%(refname)" >actual.refs &&
 	cat <<-\EOF >expect.refs &&
-	refs/remotes/shallow/master
+	refs/remotes/shallow/main
 	refs/remotes/shallow/no-shallow
 	refs/tags/heavy-tag
 	refs/tags/light-tag
 	EOF
 	test_cmp expect.refs actual.refs &&
-	git log --format=%s shallow/master >actual &&
+	git log --format=%s shallow/main >actual &&
 	test_write_lines 7 6 5 4 3 >expect &&
 	test_cmp expect actual
 	)
@@ -161,7 +161,7 @@ test_expect_success 'fetch --update-shallow' '
 test_expect_success 'fetch --update-shallow (with fetch.writeCommitGraph)' '
 	(
 	cd shallow &&
-	git checkout master &&
+	git checkout main &&
 	commit 8 &&
 	git tag -m foo heavy-tag-for-graph HEAD^ &&
 	git tag light-tag-for-graph HEAD^:tracked
@@ -173,7 +173,7 @@ test_expect_success 'fetch --update-shallow (with fetch.writeCommitGraph)' '
 	git fsck &&
 	git for-each-ref --sort=refname --format="%(refname)" >actual.refs &&
 	cat <<-EOF >expect.refs &&
-	refs/remotes/shallow/master
+	refs/remotes/shallow/main
 	refs/remotes/shallow/no-shallow
 	refs/tags/heavy-tag
 	refs/tags/heavy-tag-for-graph
@@ -181,7 +181,7 @@ test_expect_success 'fetch --update-shallow (with fetch.writeCommitGraph)' '
 	refs/tags/light-tag-for-graph
 	EOF
 	test_cmp expect.refs actual.refs &&
-	git log --format=%s shallow/master >actual &&
+	git log --format=%s shallow/main >actual &&
 	test_write_lines 8 7 6 5 4 3 >expect &&
 	test_cmp expect actual
 	)
@@ -206,7 +206,7 @@ test_expect_success '.git/shallow is edited by repack' '
 	test_commit -C shallow-server E &&
 	test_commit -C shallow-server D &&
 	d="$(git -C shallow-server rev-parse --verify D^0)" &&
-	git -C shallow-server checkout master &&
+	git -C shallow-server checkout main &&
 
 	git clone --depth=1 --no-tags --no-single-branch \
 		"file://$PWD/shallow-server" shallow-client &&
@@ -244,7 +244,7 @@ test_expect_success 'shallow fetches check connectivity before writing shallow f
 	git -C "$REPO" config protocol.version 2 &&
 	git -C client config protocol.version 2 &&
 
-	git -C client fetch --depth=2 "$HTTPD_URL/one_time_perl/repo" master:a_branch &&
+	git -C client fetch --depth=2 "$HTTPD_URL/one_time_perl/repo" main:a_branch &&
 
 	# Craft a situation in which the server sends back an unshallow request
 	# with an empty packfile. This is done by refetching with a shorter
@@ -256,7 +256,7 @@ test_expect_success 'shallow fetches check connectivity before writing shallow f
 	       >"$HTTPD_ROOT_PATH/one-time-perl" &&
 	test_must_fail env GIT_TEST_SIDEBAND_ALL=0 git -C client \
 		fetch --depth=1 "$HTTPD_URL/one_time_perl/repo" \
-		master:a_branch &&
+		main:a_branch &&
 
 	# Ensure that the one-time-perl script was used.
 	! test -e "$HTTPD_ROOT_PATH/one-time-perl" &&
diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
index ecbf84d21c..9d3e946bf1 100755
--- a/t/t5538-push-shallow.sh
+++ b/t/t5538-push-shallow.sh
@@ -44,9 +44,9 @@ test_expect_success 'push from shallow clone' '
 	(
 	cd shallow &&
 	commit 5 &&
-	git push ../.git +master:refs/remotes/shallow/master
+	git push ../.git +main:refs/remotes/shallow/main
 	) &&
-	git log --format=%s shallow/master >actual &&
+	git log --format=%s shallow/main >actual &&
 	git fsck &&
 	cat <<EOF >expect &&
 5
@@ -61,10 +61,10 @@ EOF
 test_expect_success 'push from shallow clone, with grafted roots' '
 	(
 	cd shallow2 &&
-	test_must_fail git push ../.git +master:refs/remotes/shallow2/master 2>err &&
-	grep "shallow2/master.*shallow update not allowed" err
+	test_must_fail git push ../.git +main:refs/remotes/shallow2/main 2>err &&
+	grep "shallow2/main.*shallow update not allowed" err
 	) &&
-	test_must_fail git rev-parse shallow2/master &&
+	test_must_fail git rev-parse shallow2/main &&
 	git fsck
 '
 
@@ -72,9 +72,9 @@ test_expect_success 'add new shallow root with receive.updateshallow on' '
 	test_config receive.shallowupdate true &&
 	(
 	cd shallow2 &&
-	git push ../.git +master:refs/remotes/shallow2/master
+	git push ../.git +main:refs/remotes/shallow2/main
 	) &&
-	git log --format=%s shallow2/master >actual &&
+	git log --format=%s shallow2/main >actual &&
 	git fsck &&
 	cat <<EOF >expect &&
 c
@@ -87,12 +87,12 @@ test_expect_success 'push from shallow to shallow' '
 	(
 	cd shallow &&
 	git --git-dir=../shallow2/.git config receive.shallowupdate true &&
-	git push ../shallow2/.git +master:refs/remotes/shallow/master &&
+	git push ../shallow2/.git +main:refs/remotes/shallow/main &&
 	git --git-dir=../shallow2/.git config receive.shallowupdate false
 	) &&
 	(
 	cd shallow2 &&
-	git log --format=%s shallow/master >actual &&
+	git log --format=%s shallow/main >actual &&
 	git fsck &&
 	cat <<EOF >expect &&
 5
@@ -106,10 +106,10 @@ EOF
 test_expect_success 'push from full to shallow' '
 	! git --git-dir=shallow2/.git cat-file blob $(echo 1|git hash-object --stdin) &&
 	commit 1 &&
-	git push shallow2/.git +master:refs/remotes/top/master &&
+	git push shallow2/.git +main:refs/remotes/top/main &&
 	(
 	cd shallow2 &&
-	git log --format=%s top/master >actual &&
+	git log --format=%s top/main >actual &&
 	git fsck &&
 	cat <<EOF >expect &&
 1
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow.sh
index 82aa99ae87..4397197829 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -32,7 +32,7 @@ test_expect_success 'clone http repository' '
 	(
 	cd clone &&
 	git fsck &&
-	git log --format=%s origin/master >actual &&
+	git log --format=%s origin/main >actual &&
 	cat <<EOF >expect &&
 7
 6
@@ -60,9 +60,9 @@ test_expect_success 'no shallow lines after receiving ACK ready' '
 				refs/heads/unrelated$i:refs/heads/unrelated$i ||
 			exit 1
 		done &&
-		git checkout master &&
+		git checkout main &&
 		test_commit new &&
-		git push  "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" master
+		git push  "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" main
 	) &&
 	(
 		cd clone &&
@@ -95,7 +95,7 @@ test_expect_success 'clone shallow since ...' '
 
 test_expect_success 'fetch shallow since ...' '
 	git -C shallow11 fetch --shallow-since "200000000 +0700" origin &&
-	git -C shallow11 log --pretty=tformat:%s origin/master >actual &&
+	git -C shallow11 log --pretty=tformat:%s origin/main >actual &&
 	cat >expected <<-\EOF &&
 	three
 	two
@@ -120,7 +120,7 @@ test_expect_success 'shallow clone exclude tag two' '
 
 test_expect_success 'fetch exclude tag one' '
 	git -C shallow12 fetch --shallow-exclude one origin &&
-	git -C shallow12 log --pretty=tformat:%s origin/master >actual &&
+	git -C shallow12 log --pretty=tformat:%s origin/main >actual &&
 	test_write_lines three two >expected &&
 	test_cmp expected actual
 '
@@ -136,12 +136,12 @@ test_expect_success 'fetching deepen' '
 	git clone --depth 1 $HTTPD_URL/smart/shallow-deepen.git deepen &&
 	mv "$HTTPD_DOCUMENT_ROOT_PATH/shallow-deepen.git" .git &&
 	test_commit four &&
-	git -C deepen log --pretty=tformat:%s master >actual &&
+	git -C deepen log --pretty=tformat:%s main >actual &&
 	echo three >expected &&
 	test_cmp expected actual &&
 	mv .git "$HTTPD_DOCUMENT_ROOT_PATH/shallow-deepen.git" &&
 	git -C deepen fetch --deepen=1 &&
-	git -C deepen log --pretty=tformat:%s origin/master >actual &&
+	git -C deepen log --pretty=tformat:%s origin/main >actual &&
 	cat >expected <<-\EOF &&
 	four
 	three
diff --git a/t/test-lib.sh b/t/test-lib.sh
index a12a1993d0..ecaa0f36f3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -263,7 +263,7 @@ case "$TEST_NUMBER" in
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-[0-4]*|5[0-4]*|55[01]*)
+[0-4]*|5[0-4]*|55[0-3]*)
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-- 
gitgitgadget

