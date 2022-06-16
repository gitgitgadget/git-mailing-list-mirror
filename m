Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253D6C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 20:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378720AbiFPUzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378681AbiFPUzB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 16:55:01 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D665FF0C
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 13:54:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so2851276pjm.2
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 13:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X62qGNAbf0qLHfRim1nCrabMXCCosDMaoKDqLzTTn+Q=;
        b=ZU1OsmYti4SM7DDaUPV23ZByJLr5JbeYZjh+40qCtmr96JGyT1nLlAS8NiiCnjqjBl
         6yxbrSPldHLls9al9E0nEXnMk9NSshHVrnh2yUsWbTyGBpTO1lX/ZNWd21FRqrMjdhe3
         mK5cUvT8FQSLhYvfWUrOJKiLWV1FUy68OZsF7X6/wK4NUGktburrjo8N5xll/ZPX030G
         RHMEVjhY08rzk4Zyl+Dbxc+JjYEnn5uKdxHYBGNydf+e9TOgWxautOCdZMndUKxHrs5/
         R7sCZtDfWs9sYX43EB0JtdJDJU5NsZPPJoG5ONDYsbsUFYpA0kjkNwDgB3WRS+L2LlgC
         uWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X62qGNAbf0qLHfRim1nCrabMXCCosDMaoKDqLzTTn+Q=;
        b=IwbeK6mOds6nKCPq+Ksfyjr3np/z0gIRjZG/jv5T/tLFDZ9xcnCTVBsAicHpDJR3Tm
         7Xzn/cXFtgOzQkhE+UXfjUaqLwo3reHwj4DwEZfMRS3LCz6fNomGhNswVeU70DUJQbp7
         23BmdiudXAtFpLjqjcZa/bAaBIaI7xr4CTVtHjlUlVYTcyTcB2iipozx+wB2hm/tkyFD
         DHvfzBprCi4/qjQH5svWb13gBeUPBdcSOvSKOiYp1/ZM/uBf7gKMvaVkeCoV238BocT4
         Lox05WsrDB9vVRvdRFA8utKKy9B/++m9ibMuyPe5ASESq9HR18PDhkxdQ4A9+j8eSIQg
         Jgxw==
X-Gm-Message-State: AJIora+FbC/wTB5kWoru5m9F4AefVmP6X/Ecohrb1oCXtvwppSgK1rMj
        lIcinCzpq3fWztUygTgcE3afbWqYDy8=
X-Google-Smtp-Source: AGRyM1tTsc58py6ZI0nl3Jqu7ngVi7gptvwfHT9F93rLEOTXHeKe50Rf+6AidwxKF7nKXpkaxb9dWQ==
X-Received: by 2002:a17:903:120b:b0:168:98a9:221f with SMTP id l11-20020a170903120b00b0016898a9221fmr6062885plh.48.1655412897329;
        Thu, 16 Jun 2022 13:54:57 -0700 (PDT)
Received: from JEKELLER-HOME.localdomain ([50.39.231.65])
        by smtp.gmail.com with ESMTPSA id j4-20020aa783c4000000b0051b9e224623sm2249165pfn.141.2022.06.16.13.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:54:57 -0700 (PDT)
From:   Jacob Keller <jacob.keller@gmail.com>
X-Google-Original-From: Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 1/5] t5505: remove sub shell use in favor of git -C
Date:   Thu, 16 Jun 2022 13:54:52 -0700
Message-Id: <20220616205456.19081-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616205456.19081-1-jacob.e.keller@intel.com>
References: <20220616205456.19081-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The t5505-remote.sh test script makes liberal use of sub shells to move
directories before executing a series of git commands. This is not the
typical style of a more modern test script. Instead, newer tests favor
the use of git's "-C" option to change directory before executing.

Update this test script to drop the unnecessary sub shells. Where
necessary, adjust the paths of various output files to account for this
change.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 t/t5505-remote.sh | 1047 +++++++++++++++++----------------------------
 1 file changed, 401 insertions(+), 646 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index fff14e13ed43..d5db7ce055bc 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -28,14 +28,14 @@ tokens_match () {
 }
 
 check_remote_track () {
-	actual=$(git remote show "$1" | sed -ne 's|^    \(.*\) tracked$|\1|p')
+	actual=$(git -C test remote show "$1" | sed -ne 's|^    \(.*\) tracked$|\1|p')
 	shift &&
 	tokens_match "$*" "$actual"
 }
 
 check_tracking_branch () {
 	f="" &&
-	r=$(git for-each-ref "--format=%(refname)" |
+	r=$(git -C test for-each-ref "--format=%(refname)" |
 		sed -ne "s|^refs/remotes/$1/||p") &&
 	shift &&
 	tokens_match "$*" "$r"
@@ -44,10 +44,7 @@ check_tracking_branch () {
 test_expect_success setup '
 	setup_repository one &&
 	setup_repository two &&
-	(
-		cd two &&
-		git branch another
-	) &&
+	git -C two branch another &&
 	git clone one test
 '
 
@@ -57,25 +54,19 @@ test_expect_success 'add remote whose URL agrees with url.<...>.insteadOf' '
 '
 
 test_expect_success 'remote information for the origin' '
-	(
-		cd test &&
-		tokens_match origin "$(git remote)" &&
-		check_remote_track origin main side &&
-		check_tracking_branch origin HEAD main side
-	)
+	tokens_match origin "$(git -C test remote)" &&
+	check_remote_track origin main side &&
+	check_tracking_branch origin HEAD main side
 '
 
 test_expect_success 'add another remote' '
-	(
-		cd test &&
-		git remote add -f second ../two &&
-		tokens_match "origin second" "$(git remote)" &&
-		check_tracking_branch second main side another &&
-		git for-each-ref "--format=%(refname)" refs/remotes |
-		sed -e "/^refs\/remotes\/origin\//d" \
-		    -e "/^refs\/remotes\/second\//d" >actual &&
-		test_must_be_empty actual
-	)
+	git -C test remote add -f second ../two &&
+	tokens_match "origin second" "$(git -C test remote)" &&
+	check_tracking_branch second main side another &&
+	git -C test for-each-ref "--format=%(refname)" refs/remotes |
+	sed -e "/^refs\/remotes\/origin\//d" \
+		-e "/^refs\/remotes\/second\//d" >actual &&
+	test_must_be_empty actual
 '
 
 test_expect_success 'setup bare clone for server' '
@@ -113,76 +104,58 @@ test_expect_success 'filters are listed by git remote -v only' '
 '
 
 test_expect_success 'check remote-tracking' '
-	(
-		cd test &&
-		check_remote_track origin main side &&
-		check_remote_track second main side another
-	)
+	check_remote_track origin main side &&
+	check_remote_track second main side another
 '
 
 test_expect_success 'remote forces tracking branches' '
-	(
-		cd test &&
-		case $(git config remote.second.fetch) in
-		+*) true ;;
-		 *) false ;;
-		esac
-	)
+	case $(git -C test config remote.second.fetch) in
+	+*) true ;;
+	 *) false ;;
+	esac
 '
 
 test_expect_success 'remove remote' '
-	(
-		cd test &&
-		git symbolic-ref refs/remotes/second/HEAD refs/remotes/second/main &&
-		git remote rm second
-	)
+	git -C test symbolic-ref refs/remotes/second/HEAD refs/remotes/second/main &&
+	git -C test remote rm second
 '
 
 test_expect_success 'remove remote' '
-	(
-		cd test &&
-		tokens_match origin "$(git remote)" &&
-		check_remote_track origin main side &&
-		git for-each-ref "--format=%(refname)" refs/remotes |
-		sed -e "/^refs\/remotes\/origin\//d" >actual &&
-		test_must_be_empty actual
-	)
+	tokens_match origin "$(git -C test remote)" &&
+	check_remote_track origin main side &&
+	git -C test for-each-ref "--format=%(refname)" refs/remotes |
+	sed -e "/^refs\/remotes\/origin\//d" >actual &&
+	test_must_be_empty actual
 '
 
 test_expect_success 'remove remote protects local branches' '
-	(
-		cd test &&
-		cat >expect1 <<-\EOF &&
-		Note: A branch outside the refs/remotes/ hierarchy was not removed;
-		to delete it, use:
-		  git branch -d main
-		EOF
-		cat >expect2 <<-\EOF &&
-		Note: Some branches outside the refs/remotes/ hierarchy were not removed;
-		to delete them, use:
-		  git branch -d foobranch
-		  git branch -d main
-		EOF
-		git tag footag &&
-		git config --add remote.oops.fetch "+refs/*:refs/*" &&
-		git remote remove oops 2>actual1 &&
-		git branch foobranch &&
-		git config --add remote.oops.fetch "+refs/*:refs/*" &&
-		git remote rm oops 2>actual2 &&
-		git branch -d foobranch &&
-		git tag -d footag &&
-		test_cmp expect1 actual1 &&
-		test_cmp expect2 actual2
-	)
+	cat >expect1 <<-\EOF &&
+	Note: A branch outside the refs/remotes/ hierarchy was not removed;
+	to delete it, use:
+	  git branch -d main
+	EOF
+	cat >expect2 <<-\EOF &&
+	Note: Some branches outside the refs/remotes/ hierarchy were not removed;
+	to delete them, use:
+	  git branch -d foobranch
+	  git branch -d main
+	EOF
+	git -C test tag footag &&
+	git -C test config --add remote.oops.fetch "+refs/*:refs/*" &&
+	git -C test remote remove oops 2>actual1 &&
+	git -C test branch foobranch &&
+	git -C test config --add remote.oops.fetch "+refs/*:refs/*" &&
+	git -C test remote rm oops 2>actual2 &&
+	git -C test branch -d foobranch &&
+	git -C test tag -d footag &&
+	test_cmp expect1 actual1 &&
+	test_cmp expect2 actual2
 '
 
 test_expect_success 'remove errors out early when deleting non-existent branch' '
-	(
-		cd test &&
-		echo "error: No such remote: '\''foo'\''" >expect &&
-		test_expect_code 2 git remote rm foo 2>actual &&
-		test_cmp expect actual
-	)
+	echo "error: No such remote: '\''foo'\''" >expect &&
+	test_expect_code 2 git -C test remote rm foo 2>actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'remove remote with a branch without configured merge' '
@@ -193,24 +166,18 @@ test_expect_success 'remove remote with a branch without configured merge' '
 		git -C test config --remove-section branch.second;
 		true
 	)" &&
-	(
-		cd test &&
-		git remote add two ../two &&
-		git fetch two &&
-		git checkout -b second two/main^0 &&
-		git config branch.second.remote two &&
-		git checkout main &&
-		git remote rm two
-	)
+	git -C test remote add two ../two &&
+	git -C test fetch two &&
+	git -C test checkout -b second two/main^0 &&
+	git -C test config branch.second.remote two &&
+	git -C test checkout main &&
+	git -C test remote rm two
 '
 
 test_expect_success 'rename errors out early when deleting non-existent branch' '
-	(
-		cd test &&
-		echo "error: No such remote: '\''foo'\''" >expect &&
-		test_expect_code 2 git remote rename foo bar 2>actual &&
-		test_cmp expect actual
-	)
+	echo "error: No such remote: '\''foo'\''" >expect &&
+	test_expect_code 2 git -C test remote rename foo bar 2>actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'rename errors out early when new name is invalid' '
@@ -241,7 +208,7 @@ test_expect_success 'add invalid foreign_vcs remote' '
 	test_cmp expect actual
 '
 
-cat >test/expect <<EOF
+cat >expect <<EOF
 * remote origin
   Fetch URL: $(pwd)/one
   Push  URL: $(pwd)/one
@@ -269,40 +236,34 @@ cat >test/expect <<EOF
 EOF
 
 test_expect_success 'show' '
-	(
-		cd test &&
-		git config --add remote.origin.fetch refs/heads/main:refs/heads/upstream &&
-		git fetch &&
-		git checkout -b ahead origin/main &&
-		echo 1 >>file &&
-		test_tick &&
-		git commit -m update file &&
-		git checkout main &&
-		git branch --track octopus origin/main &&
-		git branch --track rebase origin/main &&
-		git branch -d -r origin/main &&
-		git config --add remote.two.url ../two &&
-		git config --add remote.two.pushurl ../three &&
-		git config branch.rebase.rebase true &&
-		git config branch.octopus.merge "topic-a topic-b topic-c" &&
-		(
-			cd ../one &&
-			echo 1 >file &&
-			test_tick &&
-			git commit -m update file
-		) &&
-		git config --add remote.origin.push : &&
-		git config --add remote.origin.push refs/heads/main:refs/heads/upstream &&
-		git config --add remote.origin.push +refs/tags/lastbackup &&
-		git config --add remote.two.push +refs/heads/ahead:refs/heads/main &&
-		git config --add remote.two.push refs/heads/main:refs/heads/another &&
-		git remote show origin two >output &&
-		git branch -d rebase octopus &&
-		test_cmp expect output
-	)
+	git -C test config --add remote.origin.fetch refs/heads/main:refs/heads/upstream &&
+	git -C test fetch &&
+	git -C test checkout -b ahead origin/main &&
+	echo 1 >>test/file &&
+	test_tick &&
+	git -C test commit -m update file &&
+	git -C test checkout main &&
+	git -C test branch --track octopus origin/main &&
+	git -C test branch --track rebase origin/main &&
+	git -C test branch -d -r origin/main &&
+	git -C test config --add remote.two.url ../two &&
+	git -C test config --add remote.two.pushurl ../three &&
+	git -C test config branch.rebase.rebase true &&
+	git -C test config branch.octopus.merge "topic-a topic-b topic-c" &&
+	echo 1 >one/file &&
+	test_tick &&
+	git -C one commit -m update file &&
+	git -C test config --add remote.origin.push : &&
+	git -C test config --add remote.origin.push refs/heads/main:refs/heads/upstream &&
+	git -C test config --add remote.origin.push +refs/tags/lastbackup &&
+	git -C test config --add remote.two.push +refs/heads/ahead:refs/heads/main &&
+	git -C test config --add remote.two.push refs/heads/main:refs/heads/another &&
+	git -C test remote show origin two >output &&
+	git -C test branch -d rebase octopus &&
+	test_cmp expect output
 '
 
-cat >test/expect <<EOF
+cat >expect <<EOF
 * remote origin
   Fetch URL: $(pwd)/one
   Push  URL: $(pwd)/one
@@ -321,72 +282,51 @@ EOF
 
 test_expect_success 'show -n' '
 	mv one one.unreachable &&
-	(
-		cd test &&
-		git remote show -n origin >output &&
-		mv ../one.unreachable ../one &&
-		test_cmp expect output
-	)
+	git -C test remote show -n origin >output &&
+	mv one.unreachable one &&
+	test_cmp expect output
 '
 
 test_expect_success 'prune' '
-	(
-		cd one &&
-		git branch -m side side2
-	) &&
-	(
-		cd test &&
-		git fetch origin &&
-		git remote prune origin &&
-		git rev-parse refs/remotes/origin/side2 &&
-		test_must_fail git rev-parse refs/remotes/origin/side
-	)
+	git -C one branch -m side side2 &&
+	git -C test fetch origin &&
+	git -C test remote prune origin &&
+	git -C test rev-parse refs/remotes/origin/side2 &&
+	test_must_fail git -C test rev-parse refs/remotes/origin/side
 '
 
 test_expect_success 'set-head --delete' '
-	(
-		cd test &&
-		git symbolic-ref refs/remotes/origin/HEAD &&
-		git remote set-head --delete origin &&
-		test_must_fail git symbolic-ref refs/remotes/origin/HEAD
-	)
+	git -C test symbolic-ref refs/remotes/origin/HEAD &&
+	git -C test remote set-head --delete origin &&
+	test_must_fail git -C test symbolic-ref refs/remotes/origin/HEAD
 '
 
 test_expect_success 'set-head --auto' '
-	(
-		cd test &&
-		git remote set-head --auto origin &&
-		echo refs/remotes/origin/main >expect &&
-		git symbolic-ref refs/remotes/origin/HEAD >output &&
-		test_cmp expect output
-	)
+	git -C test remote set-head --auto origin &&
+	echo refs/remotes/origin/main >expect &&
+	git -C test symbolic-ref refs/remotes/origin/HEAD >output &&
+	test_cmp expect output
 '
 
 test_expect_success 'set-head --auto has no problem w/multiple HEADs' '
-	(
-		cd test &&
-		git fetch two "refs/heads/*:refs/remotes/two/*" &&
-		git remote set-head --auto two >output 2>&1 &&
-		echo "two/HEAD set to main" >expect &&
-		test_cmp expect output
-	)
+	git -C test fetch two "refs/heads/*:refs/remotes/two/*" &&
+	git -C test remote set-head --auto two >output 2>&1 &&
+	echo "two/HEAD set to main" >expect &&
+	test_cmp expect output
 '
 
-cat >test/expect <<\EOF
+cat >expect <<\EOF
 refs/remotes/origin/side2
 EOF
 
 test_expect_success 'set-head explicit' '
-	(
-		cd test &&
-		git remote set-head origin side2 &&
-		git symbolic-ref refs/remotes/origin/HEAD >output &&
-		git remote set-head origin main &&
-		test_cmp expect output
-	)
+	git -C test remote set-head origin side2 &&
+	git -C test symbolic-ref refs/remotes/origin/HEAD >output &&
+	git -C test remote set-head origin main &&
+	test_cmp expect output
 '
 
-cat >test/expect <<EOF
+cat >expect <<EOF
 Pruning origin
 URL: $(pwd)/one
  * [would prune] origin/side2
@@ -395,206 +335,131 @@ EOF
 test_expect_success 'prune --dry-run' '
 	git -C one branch -m side2 side &&
 	test_when_finished "git -C one branch -m side side2" &&
-	(
-		cd test &&
-		git remote prune --dry-run origin >output &&
-		git rev-parse refs/remotes/origin/side2 &&
-		test_must_fail git rev-parse refs/remotes/origin/side &&
-		test_cmp expect output
-	)
+	git -C test remote prune --dry-run origin >output &&
+	git -C test rev-parse refs/remotes/origin/side2 &&
+	test_must_fail git -C test rev-parse refs/remotes/origin/side &&
+	test_cmp expect output
 '
 
 test_expect_success 'add --mirror && prune' '
 	mkdir mirror &&
-	(
-		cd mirror &&
-		git init --bare &&
-		git remote add --mirror -f origin ../one
-	) &&
-	(
-		cd one &&
-		git branch -m side2 side
-	) &&
-	(
-		cd mirror &&
-		git rev-parse --verify refs/heads/side2 &&
-		test_must_fail git rev-parse --verify refs/heads/side &&
-		git fetch origin &&
-		git remote prune origin &&
-		test_must_fail git rev-parse --verify refs/heads/side2 &&
-		git rev-parse --verify refs/heads/side
-	)
+	git -C mirror init --bare &&
+	git -C mirror remote add --mirror -f origin ../one &&
+	git -C one branch -m side2 side &&
+	git -C mirror rev-parse --verify refs/heads/side2 &&
+	test_must_fail git -C mirror rev-parse --verify refs/heads/side &&
+	git -C mirror fetch origin &&
+	git -C mirror remote prune origin &&
+	test_must_fail git -C mirror rev-parse --verify refs/heads/side2 &&
+	git -C mirror rev-parse --verify refs/heads/side
 '
 
 test_expect_success 'add --mirror=fetch' '
 	mkdir mirror-fetch &&
 	git init -b main mirror-fetch/parent &&
-	(
-		cd mirror-fetch/parent &&
-		test_commit one
-	) &&
+	test_commit -C mirror-fetch/parent one &&
 	git init --bare mirror-fetch/child &&
-	(
-		cd mirror-fetch/child &&
-		git remote add --mirror=fetch -f parent ../parent
-	)
+	git -C mirror-fetch/child remote add --mirror=fetch -f parent ../parent
 '
 
 test_expect_success 'fetch mirrors act as mirrors during fetch' '
-	(
-		cd mirror-fetch/parent &&
-		git branch new &&
-		git branch -m main renamed
-	) &&
-	(
-		cd mirror-fetch/child &&
-		git fetch parent &&
-		git rev-parse --verify refs/heads/new &&
-		git rev-parse --verify refs/heads/renamed
-	)
+	git -C mirror-fetch/parent branch new &&
+	git -C mirror-fetch/parent branch -m main renamed &&
+	git -C mirror-fetch/child fetch parent &&
+	git -C mirror-fetch/child rev-parse --verify refs/heads/new &&
+	git -C mirror-fetch/child rev-parse --verify refs/heads/renamed
 '
 
 test_expect_success 'fetch mirrors can prune' '
-	(
-		cd mirror-fetch/child &&
-		git remote prune parent &&
-		test_must_fail git rev-parse --verify refs/heads/main
-	)
+	git -C mirror-fetch/child remote prune parent &&
+	test_must_fail git -C mirror-fetch/child rev-parse --verify refs/heads/main
 '
 
 test_expect_success 'fetch mirrors do not act as mirrors during push' '
-	(
-		cd mirror-fetch/parent &&
-		git checkout HEAD^0
-	) &&
-	(
-		cd mirror-fetch/child &&
-		git branch -m renamed renamed2 &&
-		git push parent :
-	) &&
-	(
-		cd mirror-fetch/parent &&
-		git rev-parse --verify renamed &&
-		test_must_fail git rev-parse --verify refs/heads/renamed2
-	)
+	git -C mirror-fetch/parent checkout HEAD^0 &&
+	git -C mirror-fetch/child branch -m renamed renamed2 &&
+	git -C mirror-fetch/child push parent : &&
+	git -C mirror-fetch/parent rev-parse --verify renamed &&
+	test_must_fail git -C mirror-fetch/parent rev-parse --verify refs/heads/renamed2
 '
 
 test_expect_success 'add fetch mirror with specific branches' '
 	git init --bare mirror-fetch/track &&
-	(
-		cd mirror-fetch/track &&
-		git remote add --mirror=fetch -t heads/new parent ../parent
-	)
+	git -C mirror-fetch/track remote add --mirror=fetch -t heads/new parent ../parent
 '
 
 test_expect_success 'fetch mirror respects specific branches' '
-	(
-		cd mirror-fetch/track &&
-		git fetch parent &&
-		git rev-parse --verify refs/heads/new &&
-		test_must_fail git rev-parse --verify refs/heads/renamed
-	)
+	git -C mirror-fetch/track fetch parent &&
+	git -C mirror-fetch/track rev-parse --verify refs/heads/new &&
+	test_must_fail git -C mirror-fetch/track rev-parse --verify refs/heads/renamed
 '
 
 test_expect_success 'add --mirror=push' '
 	mkdir mirror-push &&
 	git init --bare mirror-push/public &&
 	git init -b main mirror-push/private &&
-	(
-		cd mirror-push/private &&
-		test_commit one &&
-		git remote add --mirror=push public ../public
-	)
+	test_commit -C mirror-push/private one &&
+	git -C mirror-push/private remote add --mirror=push public ../public
 '
 
 test_expect_success 'push mirrors act as mirrors during push' '
-	(
-		cd mirror-push/private &&
-		git branch new &&
-		git branch -m main renamed &&
-		git push public
-	) &&
-	(
-		cd mirror-push/private &&
-		git rev-parse --verify refs/heads/new &&
-		git rev-parse --verify refs/heads/renamed &&
-		test_must_fail git rev-parse --verify refs/heads/main
-	)
+	git -C mirror-push/private branch new &&
+	git -C mirror-push/private branch -m main renamed &&
+	git -C mirror-push/private push public &&
+	git -C mirror-push/private rev-parse --verify refs/heads/new &&
+	git -C mirror-push/private rev-parse --verify refs/heads/renamed &&
+	test_must_fail git -C mirror-push/private rev-parse --verify refs/heads/main
 '
 
 test_expect_success 'push mirrors do not act as mirrors during fetch' '
-	(
-		cd mirror-push/public &&
-		git branch -m renamed renamed2 &&
-		git symbolic-ref HEAD refs/heads/renamed2
-	) &&
-	(
-		cd mirror-push/private &&
-		git fetch public &&
-		git rev-parse --verify refs/heads/renamed &&
-		test_must_fail git rev-parse --verify refs/heads/renamed2
-	)
+	git -C mirror-push/public branch -m renamed renamed2 &&
+	git -C mirror-push/public symbolic-ref HEAD refs/heads/renamed2 &&
+	git -C mirror-push/private fetch public &&
+	git -C mirror-push/private rev-parse --verify refs/heads/renamed &&
+	test_must_fail git -C mirror-push/private rev-parse --verify refs/heads/renamed2
 '
 
 test_expect_success 'push mirrors do not allow you to specify refs' '
 	git init mirror-push/track &&
-	(
-		cd mirror-push/track &&
-		test_must_fail git remote add --mirror=push -t new public ../public
-	)
+	test_must_fail git -C mirror-push/track remote add --mirror=push -t new public ../public
 '
 
 test_expect_success 'add alt && prune' '
 	mkdir alttst &&
-	(
-		cd alttst &&
-		git init &&
-		git remote add -f origin ../one &&
-		git config remote.alt.url ../one &&
-		git config remote.alt.fetch "+refs/heads/*:refs/remotes/origin/*"
-	) &&
-	(
-		cd one &&
-		git branch -m side side2
-	) &&
-	(
-		cd alttst &&
-		git rev-parse --verify refs/remotes/origin/side &&
-		test_must_fail git rev-parse --verify refs/remotes/origin/side2 &&
-		git fetch alt &&
-		git remote prune alt &&
-		test_must_fail git rev-parse --verify refs/remotes/origin/side &&
-		git rev-parse --verify refs/remotes/origin/side2
-	)
+	git -C alttst init &&
+	git -C alttst remote add -f origin ../one &&
+	git -C alttst config remote.alt.url ../one &&
+	git -C alttst config remote.alt.fetch "+refs/heads/*:refs/remotes/origin/*" &&
+	git -C one branch -m side side2 &&
+	git -C alttst rev-parse --verify refs/remotes/origin/side &&
+	test_must_fail git -C alttst rev-parse --verify refs/remotes/origin/side2 &&
+	git -C alttst fetch alt &&
+	git -C alttst remote prune alt &&
+	test_must_fail git -C alttst rev-parse --verify refs/remotes/origin/side &&
+	git -C alttst rev-parse --verify refs/remotes/origin/side2
 '
 
-cat >test/expect <<\EOF
+cat >expect <<\EOF
 some-tag
 EOF
 
 test_expect_success 'add with reachable tags (default)' '
-	(
-		cd one &&
-		>foobar &&
-		git add foobar &&
-		git commit -m "Foobar" &&
-		git tag -a -m "Foobar tag" foobar-tag &&
-		git reset --hard HEAD~1 &&
-		git tag -a -m "Some tag" some-tag
-	) &&
+	>one/foobar &&
+	git -C one add foobar &&
+	git -C one commit -m "Foobar" &&
+	git -C one tag -a -m "Foobar tag" foobar-tag &&
+	git -C one reset --hard HEAD~1 &&
+	git -C one tag -a -m "Some tag" some-tag &&
 	mkdir add-tags &&
-	(
-		cd add-tags &&
-		git init &&
-		git remote add -f origin ../one &&
-		git tag -l some-tag >../test/output &&
-		git tag -l foobar-tag >>../test/output &&
-		test_must_fail git config remote.origin.tagopt
-	) &&
-	test_cmp test/expect test/output
+	git -C add-tags init &&
+	git -C add-tags remote add -f origin ../one &&
+	git -C add-tags tag -l some-tag >output &&
+	git -C add-tags tag -l foobar-tag >>output &&
+	test_must_fail git -C add-tags config remote.origin.tagopt &&
+	test_cmp expect output
 '
 
-cat >test/expect <<\EOF
+cat >expect <<\EOF
 some-tag
 foobar-tag
 --tags
@@ -602,49 +467,37 @@ EOF
 
 test_expect_success 'add --tags' '
 	rm -rf add-tags &&
-	(
-		mkdir add-tags &&
-		cd add-tags &&
-		git init &&
-		git remote add -f --tags origin ../one &&
-		git tag -l some-tag >../test/output &&
-		git tag -l foobar-tag >>../test/output &&
-		git config remote.origin.tagopt >>../test/output
-	) &&
-	test_cmp test/expect test/output
+	mkdir add-tags &&
+	git -C add-tags init &&
+	git -C add-tags remote add -f --tags origin ../one &&
+	git -C add-tags tag -l some-tag >output &&
+	git -C add-tags tag -l foobar-tag >>output &&
+	git -C add-tags config remote.origin.tagopt >>output &&
+	test_cmp expect output
 '
 
-cat >test/expect <<\EOF
+cat >expect <<\EOF
 --no-tags
 EOF
 
 test_expect_success 'add --no-tags' '
 	rm -rf add-tags &&
-	(
-		mkdir add-no-tags &&
-		cd add-no-tags &&
-		git init &&
-		git remote add -f --no-tags origin ../one &&
-		grep tagOpt .git/config &&
-		git tag -l some-tag >../test/output &&
-		git tag -l foobar-tag >../test/output &&
-		git config remote.origin.tagopt >>../test/output
-	) &&
-	(
-		cd one &&
-		git tag -d some-tag foobar-tag
-	) &&
-	test_cmp test/expect test/output
+	mkdir add-no-tags &&
+	git -C add-no-tags init &&
+	git -C add-no-tags remote add -f --no-tags origin ../one &&
+	grep tagOpt add-no-tags/.git/config &&
+	git -C add-no-tags tag -l some-tag >output &&
+	git -C add-no-tags tag -l foobar-tag >output &&
+	git -C add-no-tags config remote.origin.tagopt >>output &&
+	git -C one tag -d some-tag foobar-tag &&
+	test_cmp expect output
 '
 
 test_expect_success 'reject --no-no-tags' '
-	(
-		cd add-no-tags &&
-		test_must_fail git remote add -f --no-no-tags neworigin ../one
-	)
+	test_must_fail git -C add-no-tags remote add -f --no-no-tags neworigin ../one
 '
 
-cat >one/expect <<\EOF
+cat >expect <<\EOF
   apis/main
   apis/side
   drosophila/another
@@ -653,17 +506,14 @@ cat >one/expect <<\EOF
 EOF
 
 test_expect_success 'update' '
-	(
-		cd one &&
-		git remote add drosophila ../two &&
-		git remote add apis ../mirror &&
-		git remote update &&
-		git branch -r >output &&
-		test_cmp expect output
-	)
+	git -C one remote add drosophila ../two &&
+	git -C one remote add apis ../mirror &&
+	git -C one remote update &&
+	git -C one branch -r >output &&
+	test_cmp expect output
 '
 
-cat >one/expect <<\EOF
+cat >expect <<\EOF
   drosophila/another
   drosophila/main
   drosophila/side
@@ -674,40 +524,28 @@ cat >one/expect <<\EOF
 EOF
 
 test_expect_success 'update with arguments' '
-	(
-		cd one &&
-		for b in $(git branch -r)
-		do
-		git branch -r -d $b || exit 1
-		done &&
-		git remote add manduca ../mirror &&
-		git remote add megaloprepus ../mirror &&
-		git config remotes.phobaeticus "drosophila megaloprepus" &&
-		git config remotes.titanus manduca &&
-		git remote update phobaeticus titanus &&
-		git branch -r >output &&
-		test_cmp expect output
-	)
+	for b in $(git -C one branch -r)
+	do
+	git -C one branch -r -d $b || exit 1
+	done &&
+	git -C one remote add manduca ../mirror &&
+	git -C one remote add megaloprepus ../mirror &&
+	git -C one config remotes.phobaeticus "drosophila megaloprepus" &&
+	git -C one config remotes.titanus manduca &&
+	git -C one remote update phobaeticus titanus &&
+	git -C one branch -r >output &&
+	test_cmp expect output
 '
 
 test_expect_success 'update --prune' '
-	(
-		cd one &&
-		git branch -m side2 side3
-	) &&
-	(
-		cd test &&
-		git remote update --prune &&
-		(
-			cd ../one &&
-			git branch -m side3 side2
-		) &&
-		git rev-parse refs/remotes/origin/side3 &&
-		test_must_fail git rev-parse refs/remotes/origin/side2
-	)
+	git -C one branch -m side2 side3 &&
+	git -C test remote update --prune &&
+	git -C one branch -m side3 side2 &&
+	git -C test rev-parse refs/remotes/origin/side3 &&
+	test_must_fail git -C test rev-parse refs/remotes/origin/side2
 '
 
-cat >one/expect <<-\EOF
+cat >expect <<-\EOF
   apis/main
   apis/side
   manduca/main
@@ -717,61 +555,49 @@ cat >one/expect <<-\EOF
 EOF
 
 test_expect_success 'update default' '
-	(
-		cd one &&
-		for b in $(git branch -r)
-		do
-		git branch -r -d $b || exit 1
-		done &&
-		git config remote.drosophila.skipDefaultUpdate true &&
-		git remote update default &&
-		git branch -r >output &&
-		test_cmp expect output
-	)
+	for b in $(git -C one branch -r)
+	do
+	git -C one branch -r -d $b || exit 1
+	done &&
+	git -C one config remote.drosophila.skipDefaultUpdate true &&
+	git -C one remote update default &&
+	git -C one branch -r >output &&
+	test_cmp expect output
 '
 
-cat >one/expect <<\EOF
+cat >expect <<\EOF
   drosophila/another
   drosophila/main
   drosophila/side
 EOF
 
 test_expect_success 'update default (overridden, with funny whitespace)' '
-	(
-		cd one &&
-		for b in $(git branch -r)
-		do
-		git branch -r -d $b || exit 1
-		done &&
-		git config remotes.default "$(printf "\t drosophila  \n")" &&
-		git remote update default &&
-		git branch -r >output &&
-		test_cmp expect output
-	)
+	for b in $(git -C one branch -r)
+	do
+	git -C one branch -r -d $b || exit 1
+	done &&
+	git -C one config remotes.default "$(printf "\t drosophila  \n")" &&
+	git -C one remote update default &&
+	git -C one branch -r >output &&
+	test_cmp expect output
 '
 
 test_expect_success 'update (with remotes.default defined)' '
-	(
-		cd one &&
-		for b in $(git branch -r)
-		do
-		git branch -r -d $b || exit 1
-		done &&
-		git config remotes.default "drosophila" &&
-		git remote update &&
-		git branch -r >output &&
-		test_cmp expect output
-	)
+	for b in $(git -C one branch -r)
+	do
+	git -C one branch -r -d $b || exit 1
+	done &&
+	git -C one config remotes.default "drosophila" &&
+	git -C one remote update &&
+	git -C one branch -r >output &&
+	test_cmp expect output
 '
 
 test_expect_success '"remote show" does not show symbolic refs' '
 	git clone one three &&
-	(
-		cd three &&
-		git remote show origin >output &&
-		! grep "^ *HEAD$" < output &&
-		! grep -i stale < output
-	)
+	git -C three remote show origin >output &&
+	! grep "^ *HEAD$" < output &&
+	! grep -i stale < output
 '
 
 test_expect_success 'reject adding remote with an invalid name' '
@@ -784,87 +610,66 @@ test_expect_success 'reject adding remote with an invalid name' '
 test_expect_success 'rename a remote' '
 	test_config_global remote.pushDefault origin &&
 	git clone one four &&
-	(
-		cd four &&
-		git config branch.main.pushRemote origin &&
-		GIT_TRACE2_EVENT=$(pwd)/trace \
-			git remote rename --progress origin upstream &&
-		test_region progress "Renaming remote references" trace &&
-		grep "pushRemote" .git/config &&
-		test -z "$(git for-each-ref refs/remotes/origin)" &&
-		test "$(git symbolic-ref refs/remotes/upstream/HEAD)" = "refs/remotes/upstream/main" &&
-		test "$(git rev-parse upstream/main)" = "$(git rev-parse main)" &&
-		test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/remotes/upstream/*" &&
-		test "$(git config branch.main.remote)" = "upstream" &&
-		test "$(git config branch.main.pushRemote)" = "upstream" &&
-		test "$(git config --global remote.pushDefault)" = "origin"
-	)
+	git -C four config branch.main.pushRemote origin &&
+	GIT_TRACE2_EVENT=$(pwd)/trace \
+		git -C four remote rename --progress origin upstream &&
+	test_region progress "Renaming remote references" trace &&
+	grep "pushRemote" four/.git/config &&
+	test -z "$(git -C four for-each-ref refs/remotes/origin)" &&
+	test "$(git -C four symbolic-ref refs/remotes/upstream/HEAD)" = "refs/remotes/upstream/main" &&
+	test "$(git -C four rev-parse upstream/main)" = "$(git -C four rev-parse main)" &&
+	test "$(git -C four config remote.upstream.fetch)" = "+refs/heads/*:refs/remotes/upstream/*" &&
+	test "$(git -C four config branch.main.remote)" = "upstream" &&
+	test "$(git -C four config branch.main.pushRemote)" = "upstream" &&
+	test "$(git -C four config --global remote.pushDefault)" = "origin"
 '
 
 test_expect_success 'rename a remote renames repo remote.pushDefault' '
 	git clone one four.1 &&
-	(
-		cd four.1 &&
-		git config remote.pushDefault origin &&
-		git remote rename origin upstream &&
-		grep pushDefault .git/config &&
-		test "$(git config --local remote.pushDefault)" = "upstream"
-	)
+	git -C four.1 config remote.pushDefault origin &&
+	git -C four.1 remote rename origin upstream &&
+	grep pushDefault four.1/.git/config &&
+	test "$(git -C four.1 config --local remote.pushDefault)" = "upstream"
 '
 
 test_expect_success 'rename a remote renames repo remote.pushDefault but ignores global' '
 	test_config_global remote.pushDefault other &&
 	git clone one four.2 &&
-	(
-		cd four.2 &&
-		git config remote.pushDefault origin &&
-		git remote rename origin upstream &&
-		test "$(git config --global remote.pushDefault)" = "other" &&
-		test "$(git config --local remote.pushDefault)" = "upstream"
-	)
+	git -C four.2 config remote.pushDefault origin &&
+	git -C four.2 remote rename origin upstream &&
+	test "$(git -C four.2 config --global remote.pushDefault)" = "other" &&
+	test "$(git -C four.2 config --local remote.pushDefault)" = "upstream"
 '
 
 test_expect_success 'rename a remote renames repo remote.pushDefault but keeps global' '
 	test_config_global remote.pushDefault origin &&
 	git clone one four.3 &&
-	(
-		cd four.3 &&
-		git config remote.pushDefault origin &&
-		git remote rename origin upstream &&
-		test "$(git config --global remote.pushDefault)" = "origin" &&
-		test "$(git config --local remote.pushDefault)" = "upstream"
-	)
+	git -C four.3 config remote.pushDefault origin &&
+	git -C four.3 remote rename origin upstream &&
+	test "$(git -C four.3 config --global remote.pushDefault)" = "origin" &&
+	test "$(git -C four.3 config --local remote.pushDefault)" = "upstream"
 '
 
 test_expect_success 'rename does not update a non-default fetch refspec' '
 	git clone one four.one &&
-	(
-		cd four.one &&
-		git config remote.origin.fetch +refs/heads/*:refs/heads/origin/* &&
-		git remote rename origin upstream &&
-		test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/heads/origin/*" &&
-		git rev-parse -q origin/main
-	)
+	git -C four.one config remote.origin.fetch +refs/heads/*:refs/heads/origin/* &&
+	git -C four.one remote rename origin upstream &&
+	test "$(git -C four.one config remote.upstream.fetch)" = "+refs/heads/*:refs/heads/origin/*" &&
+	git -C four.one rev-parse -q origin/main
 '
 
 test_expect_success 'rename a remote with name part of fetch spec' '
 	git clone one four.two &&
-	(
-		cd four.two &&
-		git remote rename origin remote &&
-		git remote rename remote upstream &&
-		test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/remotes/upstream/*"
-	)
+	git -C four.two remote rename origin remote &&
+	git -C four.two remote rename remote upstream &&
+	test "$(git -C four.two config remote.upstream.fetch)" = "+refs/heads/*:refs/remotes/upstream/*"
 '
 
 test_expect_success 'rename a remote with name prefix of other remote' '
 	git clone one four.three &&
-	(
-		cd four.three &&
-		git remote add o git://example.com/repo.git &&
-		git remote rename o upstream &&
-		test "$(git rev-parse origin/main)" = "$(git rev-parse main)"
-	)
+	git -C four.three remote add o git://example.com/repo.git &&
+	git -C four.three remote rename o upstream &&
+	test "$(git -C four.three rev-parse origin/main)" = "$(git -C four.three rev-parse main)"
 '
 
 test_expect_success 'rename succeeds with existing remote.<target>.prune' '
@@ -877,49 +682,37 @@ test_expect_success 'rename succeeds with existing remote.<target>.prune' '
 test_expect_success 'remove a remote' '
 	test_config_global remote.pushDefault origin &&
 	git clone one four.five &&
-	(
-		cd four.five &&
-		git config branch.main.pushRemote origin &&
-		git remote remove origin &&
-		test -z "$(git for-each-ref refs/remotes/origin)" &&
-		test_must_fail git config branch.main.remote &&
-		test_must_fail git config branch.main.pushRemote &&
-		test "$(git config --global remote.pushDefault)" = "origin"
-	)
+	git -C four.five config branch.main.pushRemote origin &&
+	git -C four.five remote remove origin &&
+	test -z "$(git -C four.five for-each-ref refs/remotes/origin)" &&
+	test_must_fail git -C four.five config branch.main.remote &&
+	test_must_fail git -C four.five config branch.main.pushRemote &&
+	test "$(git -C four.five config --global remote.pushDefault)" = "origin"
 '
 
 test_expect_success 'remove a remote removes repo remote.pushDefault' '
 	git clone one four.five.1 &&
-	(
-		cd four.five.1 &&
-		git config remote.pushDefault origin &&
-		git remote remove origin &&
-		test_must_fail git config --local remote.pushDefault
-	)
+	git -C four.five.1 config remote.pushDefault origin &&
+	git -C four.five.1 remote remove origin &&
+	test_must_fail git -C four.five.1 config --local remote.pushDefault
 '
 
 test_expect_success 'remove a remote removes repo remote.pushDefault but ignores global' '
 	test_config_global remote.pushDefault other &&
 	git clone one four.five.2 &&
-	(
-		cd four.five.2 &&
-		git config remote.pushDefault origin &&
-		git remote remove origin &&
-		test "$(git config --global remote.pushDefault)" = "other" &&
-		test_must_fail git config --local remote.pushDefault
-	)
+	git -C four.five.2 config remote.pushDefault origin &&
+	git -C four.five.2 remote remove origin &&
+	test "$(git -C four.five.2 config --global remote.pushDefault)" = "other" &&
+	test_must_fail git -C four.five.2 config --local remote.pushDefault
 '
 
 test_expect_success 'remove a remote removes repo remote.pushDefault but keeps global' '
 	test_config_global remote.pushDefault origin &&
 	git clone one four.five.3 &&
-	(
-		cd four.five.3 &&
-		git config remote.pushDefault origin &&
-		git remote remove origin &&
-		test "$(git config --global remote.pushDefault)" = "origin" &&
-		test_must_fail git config --local remote.pushDefault
-	)
+	git -C four.five.3 config remote.pushDefault origin &&
+	git -C four.five.3 remote remove origin &&
+	test "$(git -C four.five.3 config --global remote.pushDefault)" = "origin" &&
+	test_must_fail git -C four.five.3 config --local remote.pushDefault
 '
 
 cat >remotes_origin <<EOF
@@ -933,91 +726,67 @@ EOF
 test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
 	git clone one five &&
 	origin_url=$(pwd)/one &&
-	(
-		cd five &&
-		git remote remove origin &&
-		mkdir -p .git/remotes &&
-		cat ../remotes_origin >.git/remotes/origin &&
-		git remote rename origin origin &&
-		test_path_is_missing .git/remotes/origin &&
-		test "$(git config remote.origin.url)" = "$origin_url" &&
-		cat >push_expected <<-\EOF &&
-		refs/heads/main:refs/heads/upstream
-		refs/heads/next:refs/heads/upstream2
-		EOF
-		cat >fetch_expected <<-\EOF &&
-		refs/heads/main:refs/heads/origin
-		refs/heads/next:refs/heads/origin2
-		EOF
-		git config --get-all remote.origin.push >push_actual &&
-		git config --get-all remote.origin.fetch >fetch_actual &&
-		test_cmp push_expected push_actual &&
-		test_cmp fetch_expected fetch_actual
-	)
+	git -C five remote remove origin &&
+	mkdir -p five/.git/remotes &&
+	cat remotes_origin >five/.git/remotes/origin &&
+	git -C five remote rename origin origin &&
+	test_path_is_missing .git/remotes/origin &&
+	test "$(git -C five config remote.origin.url)" = "$origin_url" &&
+	cat >push_expected <<-\EOF &&
+	refs/heads/main:refs/heads/upstream
+	refs/heads/next:refs/heads/upstream2
+	EOF
+	cat >fetch_expected <<-\EOF &&
+	refs/heads/main:refs/heads/origin
+	refs/heads/next:refs/heads/origin2
+	EOF
+	git -C five config --get-all remote.origin.push >push_actual &&
+	git -C five config --get-all remote.origin.fetch >fetch_actual &&
+	test_cmp push_expected push_actual &&
+	test_cmp fetch_expected fetch_actual
 '
 
 test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
 	git clone one six &&
 	origin_url=$(pwd)/one &&
-	(
-		cd six &&
-		git remote rm origin &&
-		echo "$origin_url#main" >.git/branches/origin &&
-		git remote rename origin origin &&
-		test_path_is_missing .git/branches/origin &&
-		test "$(git config remote.origin.url)" = "$origin_url" &&
-		test "$(git config remote.origin.fetch)" = "refs/heads/main:refs/heads/origin" &&
-		test "$(git config remote.origin.push)" = "HEAD:refs/heads/main"
-	)
+	git -C six remote rm origin &&
+	echo "$origin_url#main" >six/.git/branches/origin &&
+	git -C six remote rename origin origin &&
+	test_path_is_missing .git/branches/origin &&
+	test "$(git -C six config remote.origin.url)" = "$origin_url" &&
+	test "$(git -C six config remote.origin.fetch)" = "refs/heads/main:refs/heads/origin" &&
+	test "$(git -C six config remote.origin.push)" = "HEAD:refs/heads/main"
 '
 
 test_expect_success 'migrate a remote from named file in $GIT_DIR/branches (2)' '
 	git clone one seven &&
-	(
-		cd seven &&
-		git remote rm origin &&
-		echo "quux#foom" > .git/branches/origin &&
-		git remote rename origin origin &&
-		test_path_is_missing .git/branches/origin &&
-		test "$(git config remote.origin.url)" = "quux" &&
-		test "$(git config remote.origin.fetch)" = "refs/heads/foom:refs/heads/origin" &&
-		test "$(git config remote.origin.push)" = "HEAD:refs/heads/foom"
-	)
+	git -C seven remote rm origin &&
+	echo "quux#foom" >seven/.git/branches/origin &&
+	git -C seven remote rename origin origin &&
+	test_path_is_missing .git/branches/origin &&
+	test "$(git -C seven config remote.origin.url)" = "quux" &&
+	test "$(git -C seven config remote.origin.fetch)" = "refs/heads/foom:refs/heads/origin" &&
+	test "$(git -C seven config remote.origin.push)" = "HEAD:refs/heads/foom"
 '
 
 test_expect_success 'remote prune to cause a dangling symref' '
 	git clone one eight &&
-	(
-		cd one &&
-		git checkout side2 &&
-		git branch -D main
-	) &&
-	(
-		cd eight &&
-		git remote prune origin
-	) >err 2>&1 &&
+	git -C one checkout side2 &&
+	git -C one branch -D main &&
+	git -C eight remote prune origin >err 2>&1 &&
 	test_i18ngrep "has become dangling" err &&
 
 	: And the dangling symref will not cause other annoying errors &&
-	(
-		cd eight &&
-		git branch -a
-	) 2>err &&
+	git -C eight branch -a 2>err &&
 	! grep "points nowhere" err &&
-	(
-		cd eight &&
-		test_must_fail git branch nomore origin
-	) 2>err &&
+	test_must_fail git -C eight branch nomore origin 2>err &&
 	test_i18ngrep "dangling symref" err
 '
 
 test_expect_success 'show empty remote' '
 	test_create_repo empty &&
 	git clone empty empty-clone &&
-	(
-		cd empty-clone &&
-		git remote show origin
-	)
+	git -C empty-clone remote show origin
 '
 
 test_expect_success 'remote set-branches requires a remote' '
@@ -1054,36 +823,34 @@ test_expect_success 'remote set-branches' '
 	EOF
 
 	git clone .git/ setbranches &&
-	(
-		cd setbranches &&
-		git remote rename origin scratch &&
-		git config --get-all remote.scratch.fetch >config-result &&
-		sort <config-result >../actual.initial &&
+	git -C setbranches remote rename origin scratch &&
+	git -C setbranches config --get-all remote.scratch.fetch >config-result &&
+	sort <config-result >actual.initial &&
 
-		git remote set-branches scratch --add other &&
-		git config --get-all remote.scratch.fetch >config-result &&
-		sort <config-result >../actual.add &&
+	git -C setbranches remote set-branches scratch --add other &&
+	git -C setbranches config --get-all remote.scratch.fetch >config-result &&
+	sort <config-result >actual.add &&
 
-		git remote set-branches scratch maint main next &&
-		git config --get-all remote.scratch.fetch >config-result &&
-		sort <config-result >../actual.replace &&
+	git -C setbranches remote set-branches scratch maint main next &&
+	git -C setbranches config --get-all remote.scratch.fetch >config-result &&
+	sort <config-result >actual.replace &&
 
-		git remote set-branches --add scratch seen t/topic &&
-		git config --get-all remote.scratch.fetch >config-result &&
-		sort <config-result >../actual.add-two &&
+	git -C setbranches remote set-branches --add scratch seen t/topic &&
+	git -C setbranches config --get-all remote.scratch.fetch >config-result &&
+	sort <config-result >actual.add-two &&
 
-		git config --unset-all remote.scratch.fetch &&
-		git config remote.scratch.fetch \
-			refs/heads/main:refs/remotes/scratch/main &&
-		git config --add remote.scratch.fetch \
-			+refs/heads/next:refs/remotes/scratch/next &&
-		git config --get-all remote.scratch.fetch >config-result &&
-		sort <config-result >../actual.setup-ffonly &&
+	git -C setbranches config --unset-all remote.scratch.fetch &&
+	git -C setbranches config remote.scratch.fetch \
+		refs/heads/main:refs/remotes/scratch/main &&
+	git -C setbranches config --add remote.scratch.fetch \
+		+refs/heads/next:refs/remotes/scratch/next &&
+	git -C setbranches config --get-all remote.scratch.fetch >config-result &&
+	sort <config-result >actual.setup-ffonly &&
+
+	git -C setbranches remote set-branches --add scratch seen &&
+	git -C setbranches config --get-all remote.scratch.fetch >config-result &&
+	sort <config-result >actual.respect-ffonly &&
 
-		git remote set-branches --add scratch seen &&
-		git config --get-all remote.scratch.fetch >config-result &&
-		sort <config-result >../actual.respect-ffonly
-	) &&
 	test_cmp expect.initial actual.initial &&
 	test_cmp expect.add actual.add &&
 	test_cmp expect.replace actual.replace &&
@@ -1096,14 +863,11 @@ test_expect_success 'remote set-branches with --mirror' '
 	echo "+refs/*:refs/*" >expect.initial &&
 	echo "+refs/heads/main:refs/heads/main" >expect.replace &&
 	git clone --mirror .git/ setbranches-mirror &&
-	(
-		cd setbranches-mirror &&
-		git remote rename origin scratch &&
-		git config --get-all remote.scratch.fetch >../actual.initial &&
+	git -C setbranches-mirror remote rename origin scratch &&
+	git -C setbranches-mirror config --get-all remote.scratch.fetch >actual.initial &&
 
-		git remote set-branches scratch heads/main &&
-		git config --get-all remote.scratch.fetch >../actual.replace
-	) &&
+	git -C setbranches-mirror remote set-branches scratch heads/main &&
+	git -C setbranches-mirror config --get-all remote.scratch.fetch >actual.replace &&
 	test_cmp expect.initial actual.initial &&
 	test_cmp expect.replace actual.replace
 '
@@ -1361,56 +1125,47 @@ test_expect_success 'add remote matching the "insteadOf" URL' '
 '
 
 test_expect_success 'unqualified <dst> refspec DWIM and advice' '
-	test_when_finished "(cd test && git tag -d some-tag)" &&
-	(
-		cd test &&
-		git tag -a -m "Some tag" some-tag main &&
-		for type in commit tag tree blob
-		do
-			if test "$type" = "blob"
-			then
-				oid=$(git rev-parse some-tag:file)
-			else
-				oid=$(git rev-parse some-tag^{$type})
-			fi &&
-			test_must_fail git push origin $oid:dst 2>err &&
-			test_i18ngrep "error: The destination you" err &&
-			test_i18ngrep "hint: Did you mean" err &&
-			test_must_fail git -c advice.pushUnqualifiedRefName=false \
-				push origin $oid:dst 2>err &&
-			test_i18ngrep "error: The destination you" err &&
-			test_i18ngrep ! "hint: Did you mean" err ||
-			exit 1
-		done
-	)
+	test_when_finished "git -C test tag -d some-tag" &&
+	git -C test tag -a -m "Some tag" some-tag main &&
+	for type in commit tag tree blob
+	do
+		if test "$type" = "blob"
+		then
+			oid=$(git -C test rev-parse some-tag:file)
+		else
+			oid=$(git -C test rev-parse some-tag^{$type})
+		fi &&
+		test_must_fail git -C test push origin $oid:dst 2>err &&
+		test_i18ngrep "error: The destination you" err &&
+		test_i18ngrep "hint: Did you mean" err &&
+		test_must_fail git -C test -c advice.pushUnqualifiedRefName=false \
+			push origin $oid:dst 2>err &&
+		test_i18ngrep "error: The destination you" err &&
+		test_i18ngrep ! "hint: Did you mean" err ||
+		exit 1
+	done
 '
 
 test_expect_success 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and advice' '
-	(
-		cd two &&
-		git tag -a -m "Some tag" my-tag main &&
-		git update-ref refs/trees/my-head-tree HEAD^{tree} &&
-		git update-ref refs/blobs/my-file-blob HEAD:file
-	) &&
-	(
-		cd test &&
-		git config --add remote.two.fetch "+refs/tags/*:refs/remotes/tags-from-two/*" &&
-		git config --add remote.two.fetch "+refs/trees/*:refs/remotes/trees-from-two/*" &&
-		git config --add remote.two.fetch "+refs/blobs/*:refs/remotes/blobs-from-two/*" &&
-		git fetch --no-tags two &&
+	git -C two tag -a -m "Some tag" my-tag main &&
+	git -C two update-ref refs/trees/my-head-tree HEAD^{tree} &&
+	git -C two update-ref refs/blobs/my-file-blob HEAD:file &&
+	git -C test config --add remote.two.fetch "+refs/tags/*:refs/remotes/tags-from-two/*" &&
+	git -C test config --add remote.two.fetch "+refs/trees/*:refs/remotes/trees-from-two/*" &&
+	git -C test config --add remote.two.fetch "+refs/blobs/*:refs/remotes/blobs-from-two/*" &&
+	git -C test fetch --no-tags two &&
 
-		test_must_fail git push origin refs/remotes/two/another:dst 2>err &&
-		test_i18ngrep "error: The destination you" err &&
+	test_must_fail git -C test push origin refs/remotes/two/another:dst 2>err &&
+	test_i18ngrep "error: The destination you" err &&
 
-		test_must_fail git push origin refs/remotes/tags-from-two/my-tag:dst-tag 2>err &&
-		test_i18ngrep "error: The destination you" err &&
+	test_must_fail git -C test push origin refs/remotes/tags-from-two/my-tag:dst-tag 2>err &&
+	test_i18ngrep "error: The destination you" err &&
 
-		test_must_fail git push origin refs/remotes/trees-from-two/my-head-tree:dst-tree 2>err &&
-		test_i18ngrep "error: The destination you" err &&
+	test_must_fail git -C test push origin refs/remotes/trees-from-two/my-head-tree:dst-tree 2>err &&
+	test_i18ngrep "error: The destination you" err &&
 
-		test_must_fail git push origin refs/remotes/blobs-from-two/my-file-blob:dst-blob 2>err &&
-		test_i18ngrep "error: The destination you" err
-	)
+	test_must_fail git -C test push origin refs/remotes/blobs-from-two/my-file-blob:dst-blob 2>err &&
+	test_i18ngrep "error: The destination you" err
 '
 
 test_done
-- 
2.36.1

