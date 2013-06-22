From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 01/14] t/t5505-remote: modernize style
Date: Sat, 22 Jun 2013 13:28:08 +0530
Message-ID: <1371887901-5659-2-git-send-email-artagnon@gmail.com>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 10:01:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqIld-0007xk-LY
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 10:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423318Ab3FVIBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 04:01:46 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:41654 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab3FVIBo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 04:01:44 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so105104pde.23
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 01:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=sMj4DUl0mLg4bUQoxwCniuqFkJXshH8jH61uz3/JxuY=;
        b=pT//33Q/TJABa5pkB5fWGe2aZdaiVMmMe0AXd0FxnKE9OCOhnYDotX+iQ3/Wz3laAJ
         XnP0PQdm1q2z8Yx3PuH3/ffibkT+Xqm+aTenwRBr5PxyUq7khF4u9eWPXajUOcIxKIhe
         173gEkMjrQkKeYGKiwgR3A8ZJJJ/Q4c7oYm7Re8x5PRIoRS6/ExLv+eGImCMOEQ9ojfq
         e/sVzHaI3ZjjM5j9dLLPmzaXjMj63Jjv/8gV9W6vULERzsaM1zoMX3/qM2fE+OH6Lkqe
         sNzg7KWc6QBHHMLGjdu4QdgxD85MIDOLKGcs3RC5KTKvBge8Mo01GG3ipSk7JJCkzVHJ
         LLTw==
X-Received: by 10.66.100.201 with SMTP id fa9mr19600942pab.120.1371888103472;
        Sat, 22 Jun 2013 01:01:43 -0700 (PDT)
Received: from localhost.localdomain ([122.174.20.35])
        by mx.google.com with ESMTPSA id dc3sm8355333pbc.9.2013.06.22.01.01.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 22 Jun 2013 01:01:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.487.gd3dfebf
In-Reply-To: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228678>

Modernize the style of all tests throughout the file:
- Remove spurious blank lines.
- Indent the test body.
- Make sure that all lines end with &&, to make it easier to spot breaks
  in the chain.
- When executing something in a subshell, put the parenthesis on
  separate lines and indent the body.  Also make sure that the first
  statement in the subshell is a 'cd'.
- When redirecting output, replace the > output forms with >output.
- Use the <<-\EOF and <<-EOF forms of heredoc, not <<EOF.  Also, don't
  de-indent the heredoc body.
- When creating an empty file, use : >output form over >output for
  clarity.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5505-remote.sh | 813 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 440 insertions(+), 373 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index dd10ff0..f679ded 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -42,107 +42,104 @@ check_tracking_branch () {
 }
 
 test_expect_success setup '
-
 	setup_repository one &&
 	setup_repository two &&
 	(
-		cd two && git branch another
+		cd two &&
+		git branch another
 	) &&
 	git clone one test
-
 '
 
 test_expect_success C_LOCALE_OUTPUT 'remote information for the origin' '
-(
-	cd test &&
-	tokens_match origin "$(git remote)" &&
-	check_remote_track origin master side &&
-	check_tracking_branch origin HEAD master side
-)
+	(
+		cd test &&
+		tokens_match origin "$(git remote)" &&
+		check_remote_track origin master side &&
+		check_tracking_branch origin HEAD master side
+	)
 '
 
 test_expect_success 'add another remote' '
-(
-	cd test &&
-	git remote add -f second ../two &&
-	tokens_match "origin second" "$(git remote)" &&
-	check_tracking_branch second master side another &&
-	git for-each-ref "--format=%(refname)" refs/remotes |
-	sed -e "/^refs\/remotes\/origin\//d" \
-	    -e "/^refs\/remotes\/second\//d" >actual &&
-	>expect &&
-	test_cmp expect actual
-)
+	(
+		cd test &&
+		git remote add -f second ../two &&
+		tokens_match "origin second" "$(git remote)" &&
+		check_tracking_branch second master side another &&
+		git for-each-ref "--format=%(refname)" refs/remotes |
+		sed -e "/^refs\/remotes\/origin\//d" \
+		    -e "/^refs\/remotes\/second\//d" >actual &&
+		>expect &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success C_LOCALE_OUTPUT 'check remote tracking' '
-(
-	cd test &&
-	check_remote_track origin master side &&
-	check_remote_track second master side another
-)
+	(
+		cd test &&
+		check_remote_track origin master side &&
+		check_remote_track second master side another
+	)
 '
 
 test_expect_success 'remote forces tracking branches' '
-(
-	cd test &&
-	case `git config remote.second.fetch` in
-	+*) true ;;
-	 *) false ;;
-	esac
-)
+	(
+		cd test &&
+		case `git config remote.second.fetch` in
+		+*) true ;;
+		 *) false ;;
+		esac
+	)
 '
 
 test_expect_success 'remove remote' '
-(
-	cd test &&
-	git symbolic-ref refs/remotes/second/HEAD refs/remotes/second/master &&
-	git remote rm second
-)
+	(
+		cd test &&
+		git symbolic-ref refs/remotes/second/HEAD refs/remotes/second/master &&
+		git remote rm second
+	)
 '
 
 test_expect_success C_LOCALE_OUTPUT 'remove remote' '
-(
-	cd test &&
-	tokens_match origin "$(git remote)" &&
-	check_remote_track origin master side &&
-	git for-each-ref "--format=%(refname)" refs/remotes |
-	sed -e "/^refs\/remotes\/origin\//d" >actual &&
-	>expect &&
-	test_cmp expect actual
-)
+	(
+		cd test &&
+		tokens_match origin "$(git remote)" &&
+		check_remote_track origin master side &&
+		git for-each-ref "--format=%(refname)" refs/remotes |
+		sed -e "/^refs\/remotes\/origin\//d" >actual &&
+		: >expect &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'remove remote protects local branches' '
-(
-	cd test &&
-	{ cat >expect1 <<EOF
-Note: A branch outside the refs/remotes/ hierarchy was not removed;
-to delete it, use:
-  git branch -d master
-EOF
-	} &&
-	{ cat >expect2 <<EOF
-Note: Some branches outside the refs/remotes/ hierarchy were not removed;
-to delete them, use:
-  git branch -d foobranch
-  git branch -d master
-EOF
-	} &&
-	git tag footag &&
-	git config --add remote.oops.fetch "+refs/*:refs/*" &&
-	git remote remove oops 2>actual1 &&
-	git branch foobranch &&
-	git config --add remote.oops.fetch "+refs/*:refs/*" &&
-	git remote rm oops 2>actual2 &&
-	git branch -d foobranch &&
-	git tag -d footag &&
-	test_i18ncmp expect1 actual1 &&
-	test_i18ncmp expect2 actual2
-)
-'
-
-cat > test/expect << EOF
+	(
+		cd test &&
+		cat >expect1 <<-\EOF &&
+		Note: A branch outside the refs/remotes/ hierarchy was not removed;
+		to delete it, use:
+		  git branch -d master
+		EOF
+		cat >expect2 <<-\EOF &&
+		Note: Some branches outside the refs/remotes/ hierarchy were not removed;
+		to delete them, use:
+		  git branch -d foobranch
+		  git branch -d master
+		EOF
+		git tag footag &&
+		git config --add remote.oops.fetch "+refs/*:refs/*" &&
+		git remote remove oops 2>actual1 &&
+		git branch foobranch &&
+		git config --add remote.oops.fetch "+refs/*:refs/*" &&
+		git remote rm oops 2>actual2 &&
+		git branch -d foobranch &&
+		git tag -d footag &&
+		test_i18ncmp expect1 actual1 &&
+		test_i18ncmp expect2 actual2
+	)
+'
+
+cat >test/expect <<-EOF
 * remote origin
   Fetch URL: $(pwd)/one
   Push  URL: $(pwd)/one
@@ -172,36 +169,40 @@ cat > test/expect << EOF
 EOF
 
 test_expect_success 'show' '
-	(cd test &&
-	 git config --add remote.origin.fetch refs/heads/master:refs/heads/upstream &&
-	 git fetch &&
-	 git checkout -b ahead origin/master &&
-	 echo 1 >> file &&
-	 test_tick &&
-	 git commit -m update file &&
-	 git checkout master &&
-	 git branch --track octopus origin/master &&
-	 git branch --track rebase origin/master &&
-	 git branch -d -r origin/master &&
-	 git config --add remote.two.url ../two &&
-	 git config --add remote.two.pushurl ../three &&
-	 git config branch.rebase.rebase true &&
-	 git config branch.octopus.merge "topic-a topic-b topic-c" &&
-	 (cd ../one &&
-	  echo 1 > file &&
-	  test_tick &&
-	  git commit -m update file) &&
-	 git config --add remote.origin.push : &&
-	 git config --add remote.origin.push refs/heads/master:refs/heads/upstream &&
-	 git config --add remote.origin.push +refs/tags/lastbackup &&
-	 git config --add remote.two.push +refs/heads/ahead:refs/heads/master &&
-	 git config --add remote.two.push refs/heads/master:refs/heads/another &&
-	 git remote show origin two > output &&
-	 git branch -d rebase octopus &&
-	 test_i18ncmp expect output)
-'
-
-cat > test/expect << EOF
+	(
+		cd test &&
+		git config --add remote.origin.fetch refs/heads/master:refs/heads/upstream &&
+		git fetch &&
+		git checkout -b ahead origin/master &&
+		echo 1 >>file &&
+		test_tick &&
+		git commit -m update file &&
+		git checkout master &&
+		git branch --track octopus origin/master &&
+		git branch --track rebase origin/master &&
+		git branch -d -r origin/master &&
+		git config --add remote.two.url ../two &&
+		git config --add remote.two.pushurl ../three &&
+		git config branch.rebase.rebase true &&
+		git config branch.octopus.merge "topic-a topic-b topic-c" &&
+		(
+			cd ../one &&
+			echo 1 >file &&
+			test_tick &&
+			git commit -m update file
+		) &&
+		git config --add remote.origin.push : &&
+		git config --add remote.origin.push refs/heads/master:refs/heads/upstream &&
+		git config --add remote.origin.push +refs/tags/lastbackup &&
+		git config --add remote.two.push +refs/heads/ahead:refs/heads/master &&
+		git config --add remote.two.push refs/heads/master:refs/heads/another &&
+		git remote show origin two >output &&
+		git branch -d rebase octopus &&
+		test_i18ncmp expect output
+	)
+'
+
+cat >test/expect <<-EOF
 * remote origin
   Fetch URL: $(pwd)/one
   Push  URL: $(pwd)/one
@@ -219,152 +220,187 @@ cat > test/expect << EOF
 EOF
 
 test_expect_success 'show -n' '
-	(mv one one.unreachable &&
-	 cd test &&
-	 git remote show -n origin > output &&
-	 mv ../one.unreachable ../one &&
-	 test_i18ncmp expect output)
+	mv one one.unreachable &&
+	(
+		cd test &&
+		git remote show -n origin >output &&
+		mv ../one.unreachable ../one &&
+		test_i18ncmp expect output
+	)
 '
 
 test_expect_success 'prune' '
-	(cd one &&
-	 git branch -m side side2) &&
-	(cd test &&
-	 git fetch origin &&
-	 git remote prune origin &&
-	 git rev-parse refs/remotes/origin/side2 &&
-	 test_must_fail git rev-parse refs/remotes/origin/side)
+	(
+		cd one &&
+		git branch -m side side2
+	) &&
+	(
+		cd test &&
+		git fetch origin &&
+		git remote prune origin &&
+		git rev-parse refs/remotes/origin/side2 &&
+		test_must_fail git rev-parse refs/remotes/origin/side
+	)
 '
 
 test_expect_success 'set-head --delete' '
-	(cd test &&
-	 git symbolic-ref refs/remotes/origin/HEAD &&
-	 git remote set-head --delete origin &&
-	 test_must_fail git symbolic-ref refs/remotes/origin/HEAD)
+	(
+		cd test &&
+		git symbolic-ref refs/remotes/origin/HEAD &&
+		git remote set-head --delete origin &&
+		test_must_fail git symbolic-ref refs/remotes/origin/HEAD
+	)
 '
 
 test_expect_success 'set-head --auto' '
-	(cd test &&
-	 git remote set-head --auto origin &&
-	 echo refs/remotes/origin/master >expect &&
-	 git symbolic-ref refs/remotes/origin/HEAD >output &&
-	 test_cmp expect output
+	(
+		cd test &&
+		git remote set-head --auto origin &&
+		echo refs/remotes/origin/master >expect &&
+		git symbolic-ref refs/remotes/origin/HEAD >output &&
+		test_cmp expect output
 	)
 '
 
-cat >test/expect <<EOF
+cat >test/expect <<-\EOF
 error: Multiple remote HEAD branches. Please choose one explicitly with:
   git remote set-head two another
   git remote set-head two master
 EOF
 
 test_expect_success 'set-head --auto fails w/multiple HEADs' '
-	(cd test &&
-	 test_must_fail git remote set-head --auto two >output 2>&1 &&
-	test_i18ncmp expect output)
+	(
+		cd test &&
+		test_must_fail git remote set-head --auto two >output 2>&1 &&
+		test_i18ncmp expect output
+	)
 '
 
-cat >test/expect <<EOF
+cat >test/expect <<-\EOF
 refs/remotes/origin/side2
 EOF
 
 test_expect_success 'set-head explicit' '
-	(cd test &&
-	 git remote set-head origin side2 &&
-	 git symbolic-ref refs/remotes/origin/HEAD >output &&
-	 git remote set-head origin master &&
-	 test_cmp expect output)
+	(
+		cd test &&
+		git remote set-head origin side2 &&
+		git symbolic-ref refs/remotes/origin/HEAD >output &&
+		git remote set-head origin master &&
+		test_cmp expect output
+	)
 '
 
-cat > test/expect << EOF
+cat >test/expect <<-EOF
 Pruning origin
 URL: $(pwd)/one
  * [would prune] origin/side2
 EOF
 
 test_expect_success 'prune --dry-run' '
-	(cd one &&
-	 git branch -m side2 side) &&
-	(cd test &&
-	 git remote prune --dry-run origin > output &&
-	 git rev-parse refs/remotes/origin/side2 &&
-	 test_must_fail git rev-parse refs/remotes/origin/side &&
-	(cd ../one &&
-	 git branch -m side side2) &&
-	 test_i18ncmp expect output)
+	(
+		cd one &&
+		git branch -m side2 side) &&
+	(
+		cd test &&
+		git remote prune --dry-run origin >output &&
+		git rev-parse refs/remotes/origin/side2 &&
+		test_must_fail git rev-parse refs/remotes/origin/side &&
+	(
+		cd ../one &&
+		git branch -m side side2) &&
+		test_i18ncmp expect output
+	)
 '
 
 test_expect_success 'add --mirror && prune' '
-	(mkdir mirror &&
-	 cd mirror &&
-	 git init --bare &&
-	 git remote add --mirror -f origin ../one) &&
-	(cd one &&
-	 git branch -m side2 side) &&
-	(cd mirror &&
-	 git rev-parse --verify refs/heads/side2 &&
-	 test_must_fail git rev-parse --verify refs/heads/side &&
-	 git fetch origin &&
-	 git remote prune origin &&
-	 test_must_fail git rev-parse --verify refs/heads/side2 &&
-	 git rev-parse --verify refs/heads/side)
+	mkdir mirror &&
+	(
+		cd mirror &&
+		git init --bare &&
+		git remote add --mirror -f origin ../one
+	) &&
+	(
+		cd one &&
+		git branch -m side2 side
+	) &&
+	(
+		cd mirror &&
+		git rev-parse --verify refs/heads/side2 &&
+		test_must_fail git rev-parse --verify refs/heads/side &&
+		git fetch origin &&
+		git remote prune origin &&
+		test_must_fail git rev-parse --verify refs/heads/side2 &&
+		git rev-parse --verify refs/heads/side
+	)
 '
 
 test_expect_success 'add --mirror=fetch' '
 	mkdir mirror-fetch &&
 	git init mirror-fetch/parent &&
-	(cd mirror-fetch/parent &&
-	 test_commit one) &&
+	(
+		cd mirror-fetch/parent &&
+		test_commit one
+	) &&
 	git init --bare mirror-fetch/child &&
-	(cd mirror-fetch/child &&
-	 git remote add --mirror=fetch -f parent ../parent)
+	(
+		cd mirror-fetch/child &&
+		git remote add --mirror=fetch -f parent ../parent
+	)
 '
 
 test_expect_success 'fetch mirrors act as mirrors during fetch' '
-	(cd mirror-fetch/parent &&
-	 git branch new &&
-	 git branch -m master renamed
+	(
+		cd mirror-fetch/parent &&
+		git branch new &&
+		git branch -m master renamed
 	) &&
-	(cd mirror-fetch/child &&
-	 git fetch parent &&
-	 git rev-parse --verify refs/heads/new &&
-	 git rev-parse --verify refs/heads/renamed
+	(
+		cd mirror-fetch/child &&
+		git fetch parent &&
+		git rev-parse --verify refs/heads/new &&
+		git rev-parse --verify refs/heads/renamed
 	)
 '
 
 test_expect_success 'fetch mirrors can prune' '
-	(cd mirror-fetch/child &&
-	 git remote prune parent &&
-	 test_must_fail git rev-parse --verify refs/heads/master
+	(
+		cd mirror-fetch/child &&
+		git remote prune parent &&
+		test_must_fail git rev-parse --verify refs/heads/master
 	)
 '
 
 test_expect_success 'fetch mirrors do not act as mirrors during push' '
-	(cd mirror-fetch/parent &&
-	 git checkout HEAD^0
+	(
+		cd mirror-fetch/parent &&
+		git checkout HEAD^0
 	) &&
-	(cd mirror-fetch/child &&
-	 git branch -m renamed renamed2 &&
-	 git push parent :
+	(
+		cd mirror-fetch/child &&
+		git branch -m renamed renamed2 &&
+		git push parent :
 	) &&
-	(cd mirror-fetch/parent &&
-	 git rev-parse --verify renamed &&
-	 test_must_fail git rev-parse --verify refs/heads/renamed2
+	(
+		cd mirror-fetch/parent &&
+		git rev-parse --verify renamed &&
+		test_must_fail git rev-parse --verify refs/heads/renamed2
 	)
 '
 
 test_expect_success 'add fetch mirror with specific branches' '
 	git init --bare mirror-fetch/track &&
-	(cd mirror-fetch/track &&
-	 git remote add --mirror=fetch -t heads/new parent ../parent
+	(
+		cd mirror-fetch/track &&
+		git remote add --mirror=fetch -t heads/new parent ../parent
 	)
 '
 
 test_expect_success 'fetch mirror respects specific branches' '
-	(cd mirror-fetch/track &&
-	 git fetch parent &&
-	 git rev-parse --verify refs/heads/new &&
-	 test_must_fail git rev-parse --verify refs/heads/renamed
+	(
+		cd mirror-fetch/track &&
+		git fetch parent &&
+		git rev-parse --verify refs/heads/new &&
+		test_must_fail git rev-parse --verify refs/heads/renamed
 	)
 '
 
@@ -372,60 +408,72 @@ test_expect_success 'add --mirror=push' '
 	mkdir mirror-push &&
 	git init --bare mirror-push/public &&
 	git init mirror-push/private &&
-	(cd mirror-push/private &&
-	 test_commit one &&
-	 git remote add --mirror=push public ../public
+	(
+		cd mirror-push/private &&
+		test_commit one &&
+		git remote add --mirror=push public ../public
 	)
 '
 
 test_expect_success 'push mirrors act as mirrors during push' '
-	(cd mirror-push/private &&
-	 git branch new &&
-	 git branch -m master renamed &&
-	 git push public
+	(
+		cd mirror-push/private &&
+		git branch new &&
+		git branch -m master renamed &&
+		git push public
 	) &&
-	(cd mirror-push/private &&
-	 git rev-parse --verify refs/heads/new &&
-	 git rev-parse --verify refs/heads/renamed &&
-	 test_must_fail git rev-parse --verify refs/heads/master
+	(
+		cd mirror-push/private &&
+		git rev-parse --verify refs/heads/new &&
+		git rev-parse --verify refs/heads/renamed &&
+		test_must_fail git rev-parse --verify refs/heads/master
 	)
 '
 
 test_expect_success 'push mirrors do not act as mirrors during fetch' '
-	(cd mirror-push/public &&
-	 git branch -m renamed renamed2 &&
-	 git symbolic-ref HEAD refs/heads/renamed2
+	(
+		cd mirror-push/public &&
+		git branch -m renamed renamed2 &&
+		git symbolic-ref HEAD refs/heads/renamed2
 	) &&
-	(cd mirror-push/private &&
-	 git fetch public &&
-	 git rev-parse --verify refs/heads/renamed &&
-	 test_must_fail git rev-parse --verify refs/heads/renamed2
+	(
+		cd mirror-push/private &&
+		git fetch public &&
+		git rev-parse --verify refs/heads/renamed &&
+		test_must_fail git rev-parse --verify refs/heads/renamed2
 	)
 '
 
 test_expect_success 'push mirrors do not allow you to specify refs' '
 	git init mirror-push/track &&
-	(cd mirror-push/track &&
-	 test_must_fail git remote add --mirror=push -t new public ../public
+	(
+		cd mirror-push/track &&
+		test_must_fail git remote add --mirror=push -t new public ../public
 	)
 '
 
 test_expect_success 'add alt && prune' '
-	(mkdir alttst &&
-	 cd alttst &&
-	 git init &&
-	 git remote add -f origin ../one &&
-	 git config remote.alt.url ../one &&
-	 git config remote.alt.fetch "+refs/heads/*:refs/remotes/origin/*") &&
-	(cd one &&
-	 git branch -m side side2) &&
-	(cd alttst &&
-	 git rev-parse --verify refs/remotes/origin/side &&
-	 test_must_fail git rev-parse --verify refs/remotes/origin/side2 &&
-	 git fetch alt &&
-	 git remote prune alt &&
-	 test_must_fail git rev-parse --verify refs/remotes/origin/side &&
-	 git rev-parse --verify refs/remotes/origin/side2)
+	mkdir alttst &&
+	(
+		cd alttst &&
+		git init &&
+		git remote add -f origin ../one &&
+		git config remote.alt.url ../one &&
+		git config remote.alt.fetch "+refs/heads/*:refs/remotes/origin/*"
+	) &&
+	(
+		cd one &&
+		git branch -m side side2
+	) &&
+	(
+		cd alttst &&
+		git rev-parse --verify refs/remotes/origin/side &&
+		test_must_fail git rev-parse --verify refs/remotes/origin/side2 &&
+		git fetch alt &&
+		git remote prune alt &&
+		test_must_fail git rev-parse --verify refs/remotes/origin/side &&
+		git rev-parse --verify refs/remotes/origin/side2
+	)
 '
 
 cat >test/expect <<\EOF
@@ -433,20 +481,24 @@ some-tag
 EOF
 
 test_expect_success 'add with reachable tags (default)' '
-	(cd one &&
-	 >foobar &&
-	 git add foobar &&
-	 git commit -m "Foobar" &&
-	 git tag -a -m "Foobar tag" foobar-tag &&
-	 git reset --hard HEAD~1 &&
-	 git tag -a -m "Some tag" some-tag) &&
-	(mkdir add-tags &&
-	 cd add-tags &&
-	 git init &&
-	 git remote add -f origin ../one &&
-	 git tag -l some-tag >../test/output &&
-	 git tag -l foobar-tag >>../test/output &&
-	 test_must_fail git config remote.origin.tagopt) &&
+	(
+		cd one &&
+		: >foobar &&
+		git add foobar &&
+		git commit -m "Foobar" &&
+		git tag -a -m "Foobar tag" foobar-tag &&
+		git reset --hard HEAD~1 &&
+		git tag -a -m "Some tag" some-tag
+	) &&
+	mkdir add-tags &&
+	(
+		cd add-tags &&
+		git init &&
+		git remote add -f origin ../one &&
+		git tag -l some-tag >../test/output &&
+		git tag -l foobar-tag >>../test/output &&
+		test_must_fail git config remote.origin.tagopt
+	) &&
 	test_cmp test/expect test/output
 '
 
@@ -457,14 +509,16 @@ foobar-tag
 EOF
 
 test_expect_success 'add --tags' '
-	(rm -rf add-tags &&
-	 mkdir add-tags &&
-	 cd add-tags &&
-	 git init &&
-	 git remote add -f --tags origin ../one &&
-	 git tag -l some-tag >../test/output &&
-	 git tag -l foobar-tag >>../test/output &&
-	 git config remote.origin.tagopt >>../test/output) &&
+	rm -rf add-tags &&
+	(
+		mkdir add-tags &&
+		cd add-tags &&
+		git init &&
+		git remote add -f --tags origin ../one &&
+		git tag -l some-tag >../test/output &&
+		git tag -l foobar-tag >>../test/output &&
+		git config remote.origin.tagopt >>../test/output
+	) &&
 	test_cmp test/expect test/output
 '
 
@@ -473,25 +527,31 @@ cat >test/expect <<\EOF
 EOF
 
 test_expect_success 'add --no-tags' '
-	(rm -rf add-tags &&
-	 mkdir add-no-tags &&
-	 cd add-no-tags &&
-	 git init &&
-	 git remote add -f --no-tags origin ../one &&
-	 git tag -l some-tag >../test/output &&
-	 git tag -l foobar-tag >../test/output &&
-	 git config remote.origin.tagopt >>../test/output) &&
-	(cd one &&
-	 git tag -d some-tag foobar-tag) &&
+	rm -rf add-tags &&
+	(
+		mkdir add-no-tags &&
+		cd add-no-tags &&
+		git init &&
+		git remote add -f --no-tags origin ../one &&
+		git tag -l some-tag >../test/output &&
+		git tag -l foobar-tag >../test/output &&
+		git config remote.origin.tagopt >>../test/output
+	) &&
+	(
+		cd one &&
+		git tag -d some-tag foobar-tag
+	) &&
 	test_cmp test/expect test/output
 '
 
 test_expect_success 'reject --no-no-tags' '
-	(cd add-no-tags &&
-	 test_must_fail git remote add -f --no-no-tags neworigin ../one)
+	(
+		cd add-no-tags &&
+		test_must_fail git remote add -f --no-no-tags neworigin ../one
+	)
 '
 
-cat > one/expect << EOF
+cat >one/expect <<-\EOF
   apis/master
   apis/side
   drosophila/another
@@ -500,17 +560,17 @@ cat > one/expect << EOF
 EOF
 
 test_expect_success 'update' '
-
-	(cd one &&
-	 git remote add drosophila ../two &&
-	 git remote add apis ../mirror &&
-	 git remote update &&
-	 git branch -r > output &&
-	 test_cmp expect output)
-
+	(
+		cd one &&
+		git remote add drosophila ../two &&
+		git remote add apis ../mirror &&
+		git remote update &&
+		git branch -r >output &&
+		test_cmp expect output
+	)
 '
 
-cat > one/expect << EOF
+cat >one/expect <<-\EOF
   drosophila/another
   drosophila/master
   drosophila/side
@@ -521,34 +581,40 @@ cat > one/expect << EOF
 EOF
 
 test_expect_success 'update with arguments' '
-
-	(cd one &&
-	 for b in $(git branch -r)
-	 do
+	(
+		cd one &&
+		for b in $(git branch -r)
+		do
 		git branch -r -d $b || break
-	 done &&
-	 git remote add manduca ../mirror &&
-	 git remote add megaloprepus ../mirror &&
-	 git config remotes.phobaeticus "drosophila megaloprepus" &&
-	 git config remotes.titanus manduca &&
-	 git remote update phobaeticus titanus &&
-	 git branch -r > output &&
-	 test_cmp expect output)
-
+		done &&
+		git remote add manduca ../mirror &&
+		git remote add megaloprepus ../mirror &&
+		git config remotes.phobaeticus "drosophila megaloprepus" &&
+		git config remotes.titanus manduca &&
+		git remote update phobaeticus titanus &&
+		git branch -r >output &&
+		test_cmp expect output
+	)
 '
 
 test_expect_success 'update --prune' '
-
-	(cd one &&
-	 git branch -m side2 side3) &&
-	(cd test &&
-	 git remote update --prune &&
-	 (cd ../one && git branch -m side3 side2) &&
-	 git rev-parse refs/remotes/origin/side3 &&
-	 test_must_fail git rev-parse refs/remotes/origin/side2)
+	(
+		cd one &&
+		git branch -m side2 side3
+	) &&
+	(
+		cd test &&
+		git remote update --prune &&
+		(
+			cd ../one &&
+			git branch -m side3 side2
+		) &&
+		git rev-parse refs/remotes/origin/side3 &&
+		test_must_fail git rev-parse refs/remotes/origin/side2
+	)
 '
 
-cat > one/expect << EOF
+cat >one/expect <<-\EOF
   apis/master
   apis/side
   manduca/master
@@ -558,117 +624,115 @@ cat > one/expect << EOF
 EOF
 
 test_expect_success 'update default' '
-
-	(cd one &&
-	 for b in $(git branch -r)
-	 do
+	(
+		cd one &&
+		for b in $(git branch -r)
+		do
 		git branch -r -d $b || break
-	 done &&
-	 git config remote.drosophila.skipDefaultUpdate true &&
-	 git remote update default &&
-	 git branch -r > output &&
-	 test_cmp expect output)
-
+		done &&
+		git config remote.drosophila.skipDefaultUpdate true &&
+		git remote update default &&
+		git branch -r >output &&
+		test_cmp expect output
+	)
 '
 
-cat > one/expect << EOF
+cat >one/expect <<-\EOF
   drosophila/another
   drosophila/master
   drosophila/side
 EOF
 
 test_expect_success 'update default (overridden, with funny whitespace)' '
-
-	(cd one &&
-	 for b in $(git branch -r)
-	 do
+	(
+		cd one &&
+		for b in $(git branch -r)
+		do
 		git branch -r -d $b || break
-	 done &&
-	 git config remotes.default "$(printf "\t drosophila  \n")" &&
-	 git remote update default &&
-	 git branch -r > output &&
-	 test_cmp expect output)
-
+		done &&
+		git config remotes.default "$(printf "\t drosophila  \n")" &&
+		git remote update default &&
+		git branch -r >output &&
+		test_cmp expect output
+	)
 '
 
 test_expect_success 'update (with remotes.default defined)' '
-
-	(cd one &&
-	 for b in $(git branch -r)
-	 do
+	(
+		cd one &&
+		for b in $(git branch -r)
+		do
 		git branch -r -d $b || break
-	 done &&
-	 git config remotes.default "drosophila" &&
-	 git remote update &&
-	 git branch -r > output &&
-	 test_cmp expect output)
-
+		done &&
+		git config remotes.default "drosophila" &&
+		git remote update &&
+		git branch -r >output &&
+		test_cmp expect output
+	)
 '
 
 test_expect_success '"remote show" does not show symbolic refs' '
-
 	git clone one three &&
-	(cd three &&
-	 git remote show origin > output &&
-	 ! grep "^ *HEAD$" < output &&
-	 ! grep -i stale < output)
-
+	(
+		cd three &&
+		git remote show origin >output &&
+		! grep "^ *HEAD$" < output &&
+		! grep -i stale < output
+	)
 '
 
 test_expect_success 'reject adding remote with an invalid name' '
-
 	test_must_fail git remote add some:url desired-name
-
 '
 
 # The first three test if the tracking branches are properly renamed,
 # the last two ones check if the config is updated.
 
 test_expect_success 'rename a remote' '
-
 	git clone one four &&
-	(cd four &&
-	 git remote rename origin upstream &&
-	 rmdir .git/refs/remotes/origin &&
-	 test "$(git symbolic-ref refs/remotes/upstream/HEAD)" = "refs/remotes/upstream/master" &&
-	 test "$(git rev-parse upstream/master)" = "$(git rev-parse master)" &&
-	 test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/remotes/upstream/*" &&
-	 test "$(git config branch.master.remote)" = "upstream")
-
+	(
+		cd four &&
+		git remote rename origin upstream &&
+		rmdir .git/refs/remotes/origin &&
+		test "$(git symbolic-ref refs/remotes/upstream/HEAD)" = "refs/remotes/upstream/master" &&
+		test "$(git rev-parse upstream/master)" = "$(git rev-parse master)" &&
+		test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/remotes/upstream/*" &&
+		test "$(git config branch.master.remote)" = "upstream"
+	)
 '
 
 test_expect_success 'rename does not update a non-default fetch refspec' '
-
 	git clone one four.one &&
-	(cd four.one &&
-	 git config remote.origin.fetch +refs/heads/*:refs/heads/origin/* &&
-	 git remote rename origin upstream &&
-	 test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/heads/origin/*" &&
-	 git rev-parse -q origin/master)
-
+	(
+		cd four.one &&
+		git config remote.origin.fetch +refs/heads/*:refs/heads/origin/* &&
+		git remote rename origin upstream &&
+		test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/heads/origin/*" &&
+		git rev-parse -q origin/master
+	)
 '
 
 test_expect_success 'rename a remote with name part of fetch spec' '
-
 	git clone one four.two &&
-	(cd four.two &&
-	 git remote rename origin remote &&
-	 git remote rename remote upstream &&
-	 test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/remotes/upstream/*")
-
+	(
+		cd four.two &&
+		git remote rename origin remote &&
+		git remote rename remote upstream &&
+		test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/remotes/upstream/*"
+	)
 '
 
 test_expect_success 'rename a remote with name prefix of other remote' '
-
 	git clone one four.three &&
-	(cd four.three &&
-	 git remote add o git://example.com/repo.git &&
-	 git remote rename o upstream &&
-	 test "$(git rev-parse origin/master)" = "$(git rev-parse master)")
-
+	(
+		cd four.three &&
+		git remote add o git://example.com/repo.git &&
+		git remote rename o upstream &&
+		test "$(git rev-parse origin/master)" = "$(git rev-parse master)"
+	)
 '
 
-cat > remotes_origin << EOF
+cat >remotes_origin <<-EOF
 URL: $(pwd)/one
 Push: refs/heads/master:refs/heads/upstream
 Pull: refs/heads/master:refs/heads/origin
@@ -677,27 +741,31 @@ EOF
 test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
 	git clone one five &&
 	origin_url=$(pwd)/one &&
-	(cd five &&
-	 git remote remove origin &&
-	 mkdir -p .git/remotes &&
-	 cat ../remotes_origin > .git/remotes/origin &&
-	 git remote rename origin origin &&
-	 ! test -f .git/remotes/origin &&
-	 test "$(git config remote.origin.url)" = "$origin_url" &&
-	 test "$(git config remote.origin.push)" = "refs/heads/master:refs/heads/upstream" &&
-	 test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin")
+	(
+		cd five &&
+		git remote remove origin &&
+		mkdir -p .git/remotes &&
+		cat ../remotes_origin >.git/remotes/origin &&
+		git remote rename origin origin &&
+		! test -f .git/remotes/origin &&
+		test "$(git config remote.origin.url)" = "$origin_url" &&
+		test "$(git config remote.origin.push)" = "refs/heads/master:refs/heads/upstream" &&
+		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin"
+	)
 '
 
 test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
 	git clone one six &&
 	origin_url=$(pwd)/one &&
-	(cd six &&
-	 git remote rm origin &&
-	 echo "$origin_url" > .git/branches/origin &&
-	 git remote rename origin origin &&
-	 ! test -f .git/branches/origin &&
-	 test "$(git config remote.origin.url)" = "$origin_url" &&
-	 test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin")
+	(
+		cd six &&
+		git remote rm origin &&
+		echo "$origin_url" >.git/branches/origin &&
+		git remote rename origin origin &&
+		! test -f .git/branches/origin &&
+		test "$(git config remote.origin.url)" = "$origin_url" &&
+		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin"
+	)
 '
 
 test_expect_success 'remote prune to cause a dangling symref' '
@@ -727,7 +795,6 @@ test_expect_success 'remote prune to cause a dangling symref' '
 '
 
 test_expect_success 'show empty remote' '
-
 	test_create_repo empty &&
 	git clone empty empty-clone &&
 	(
-- 
1.8.3.1.498.gacf2885
