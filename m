Return-Path: <SRS0=J6fK=EP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5DBC388F9
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 00:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF9C3206E3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 00:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtCc2m/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgKIAJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 19:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728942AbgKIAJc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 19:09:32 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49AEC0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 16:09:31 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id p1so6915130wrf.12
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 16:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pif9dbkJ+jB0ovKVxg1H2OhOFDFrN0mVs7u6W61rMRA=;
        b=dtCc2m/n7qz+r/Dn0ZqN4+nUfl5r+A/gZo79yZdwlpYmHh7tWQnZDZNAilNOiJsEwK
         d9Upaq47OpERmQT59kaS9q0JGbDQTGQ5WfjOtaHYJzhdMgpxWP+CTC2sQF4cHox3ETbI
         KsJ4tbGpEG/ynDfpSfc9brwWbdSrP7AZEi2EJySl2c8PwJTaHq1CgUkm+vVSf5PrwCQt
         544mOOUDv1YmEHuy3NTOO0jDGPZpo/510q7LqDlwgrGJejgjcx5fW2ToWVbrMdwt5+CO
         Aj3wEITi5xqKToPCmQfHvDlFQBr1X+Hlb2zPmHw+5u+vt/k7HT9aYLCWWuV8+5w9Vc72
         j3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pif9dbkJ+jB0ovKVxg1H2OhOFDFrN0mVs7u6W61rMRA=;
        b=l4QpWg2C/IFpi4+AfuuhnIX5ok8FhUAFyW+bQJrK4iIqv7o28rSJTN3mA9ZHKQXFA7
         gaIbC+TMJMrbl25C0xb2b5s9+y3Zef3L0a1EF6kPwQGi05P9uh3uA1NccGTY28Uv17sQ
         tcemV1FDjYabWbtC/J+V+Uw5C/8/tu3Tgxk2tMkaPumtq7x4jQKqRXjVaJjTGf4f4zRn
         8aZsqNRys2H6cy5hHzbEusV3SMJBEy0NqZfY+G1FnwAyjtGMC1kU7uNqT2P6BkDqIj2d
         IVrXrDPWemf9HsUyKQmvJ/RPx4OaOVD+zhkIiVckEgHiZa//UJQYqRHLau1x4dG3fcD7
         Fd9A==
X-Gm-Message-State: AOAM5312opY/D0WiMPZyvBH5+ra9o5QGlrXiasrVLwOEM+82hWagjN65
        hvy/D2wA4USuYBVUM3JmPGERHagdjwo=
X-Google-Smtp-Source: ABdhPJzIocysW29aSt7WAh868hBig47O8IURsRMHe4zz6msXFNz+5EraBns7vNRu4iWeUSaKufZAOQ==
X-Received: by 2002:a5d:4104:: with SMTP id l4mr14070655wrp.276.1604880570281;
        Sun, 08 Nov 2020 16:09:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y10sm11219311wru.94.2020.11.08.16.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 16:09:29 -0800 (PST)
Message-Id: <fa09f1de515756e41a1f16f1d62607856bf5b684.1604880565.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.784.git.1604880565.gitgitgadget@gmail.com>
References: <pull.784.git.1604880565.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Nov 2020 00:09:23 +0000
Subject: [PATCH 4/6] t5400,t5402: consistently indent with tabs, not with
 spaces
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

This patch actually prepares for the upcoming patches to replace
`master` with `main` in these tests: we do not want those changes to be
flagged by the new `check-whitespace` GitHub workflow (even if those
changes do not introduce the whitespace issues, they touch lines
affected by those issues without fixing them).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5400-send-pack.sh       | 153 +++++++++++++++++++------------------
 t/t5402-post-merge-hook.sh |  16 ++--
 2 files changed, 85 insertions(+), 84 deletions(-)

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index b84618c925..cc86ef213e 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -21,14 +21,15 @@ test_expect_success setup '
 	i=0 &&
 	while test $i -le $cnt
 	do
-	    i=$(($i+1)) &&
-	    test_tick &&
-	    echo "Commit #$i" >mozart/is/pink &&
-	    git update-index --add mozart/is/pink &&
-	    tree=$(git write-tree) &&
-	    commit=$(echo "Commit #$i" | git commit-tree $tree -p $parent) &&
-	    git update-ref refs/tags/commit$i $commit &&
-	    parent=$commit || return 1
+		i=$(($i+1)) &&
+		test_tick &&
+		echo "Commit #$i" >mozart/is/pink &&
+		git update-index --add mozart/is/pink &&
+		tree=$(git write-tree) &&
+		commit=$(echo "Commit #$i" |
+			 git commit-tree $tree -p $parent) &&
+		git update-ref refs/tags/commit$i $commit &&
+		parent=$commit || return 1
 	done &&
 	git update-ref HEAD "$commit" &&
 	git clone ./. victim &&
@@ -38,14 +39,14 @@ test_expect_success setup '
 	i=0 &&
 	while test $i -le $cnt
 	do
-	    i=$(($i+1)) &&
-	    test_tick &&
-	    echo "Rebase #$i" >mozart/is/pink &&
-	    git update-index --add mozart/is/pink &&
-	    tree=$(git write-tree) &&
-	    commit=$(echo "Rebase #$i" | git commit-tree $tree -p $parent) &&
-	    git update-ref refs/tags/rebase$i $commit &&
-	    parent=$commit || return 1
+		i=$(($i+1)) &&
+		test_tick &&
+		echo "Rebase #$i" >mozart/is/pink &&
+		git update-index --add mozart/is/pink &&
+		tree=$(git write-tree) &&
+		commit=$(echo "Rebase #$i" | git commit-tree $tree -p $parent) &&
+		git update-ref refs/tags/rebase$i $commit &&
+		parent=$commit || return 1
 	done &&
 	git update-ref HEAD "$commit" &&
 	echo Rebase &&
@@ -57,11 +58,11 @@ test_expect_success 'pack the source repository' '
 '
 
 test_expect_success 'pack the destination repository' '
-    (
-	cd victim &&
-	git repack -a -d &&
-	git prune
-    )
+	(
+		cd victim &&
+		git repack -a -d &&
+		git prune
+	)
 '
 
 test_expect_success 'refuse pushing rewound head without --force' '
@@ -85,10 +86,10 @@ test_expect_success 'push can be used to delete a ref' '
 
 test_expect_success 'refuse deleting push with denyDeletes' '
 	(
-	    cd victim &&
-	    test_might_fail git branch -D extra &&
-	    git config receive.denyDeletes true &&
-	    git branch extra master
+		cd victim &&
+		test_might_fail git branch -D extra &&
+		git config receive.denyDeletes true &&
+		git branch extra master
 	) &&
 	test_must_fail git send-pack ./victim :extra master
 '
@@ -118,9 +119,9 @@ test_expect_success 'override denyDeletes with git -c receive-pack' '
 
 test_expect_success 'denyNonFastforwards trumps --force' '
 	(
-	    cd victim &&
-	    test_might_fail git branch -D extra &&
-	    git config receive.denyNonFastforwards true
+		cd victim &&
+		test_might_fail git branch -D extra &&
+		git config receive.denyNonFastforwards true
 	) &&
 	victim_orig=$(cd victim && git rev-parse --verify master) &&
 	test_must_fail git send-pack --force ./victim master^:master &&
@@ -143,16 +144,16 @@ test_expect_success 'send-pack --all sends all branches' '
 test_expect_success 'push --all excludes remote-tracking hierarchy' '
 	mkdir parent &&
 	(
-	    cd parent &&
-	    git init && : >file && git add file && git commit -m add
+		cd parent &&
+		git init && : >file && git add file && git commit -m add
 	) &&
 	git clone parent child &&
 	(
-	    cd child && git push --all
+		cd child && git push --all
 	) &&
 	(
-	    cd parent &&
-	    test -z "$(git for-each-ref refs/remotes/origin)"
+		cd parent &&
+		test -z "$(git for-each-ref refs/remotes/origin)"
 	)
 '
 
@@ -160,33 +161,33 @@ test_expect_success 'receive-pack runs auto-gc in remote repo' '
 	rm -rf parent child &&
 	git init parent &&
 	(
-	    # Setup a repo with 2 packs
-	    cd parent &&
-	    echo "Some text" >file.txt &&
-	    git add . &&
-	    git commit -m "Initial commit" &&
-	    git repack -adl &&
-	    echo "Some more text" >>file.txt &&
-	    git commit -a -m "Second commit" &&
-	    git repack
+		# Setup a repo with 2 packs
+		cd parent &&
+		echo "Some text" >file.txt &&
+		git add . &&
+		git commit -m "Initial commit" &&
+		git repack -adl &&
+		echo "Some more text" >>file.txt &&
+		git commit -a -m "Second commit" &&
+		git repack
 	) &&
 	cp -R parent child &&
 	(
-	    # Set the child to auto-pack if more than one pack exists
-	    cd child &&
-	    git config gc.autopacklimit 1 &&
-	    git config gc.autodetach false &&
-	    git branch test_auto_gc &&
-	    # And create a file that follows the temporary object naming
-	    # convention for the auto-gc to remove
-	    : >.git/objects/tmp_test_object &&
-	    test-tool chmtime =-1209601 .git/objects/tmp_test_object
+		# Set the child to auto-pack if more than one pack exists
+		cd child &&
+		git config gc.autopacklimit 1 &&
+		git config gc.autodetach false &&
+		git branch test_auto_gc &&
+		# And create a file that follows the temporary object naming
+		# convention for the auto-gc to remove
+		: >.git/objects/tmp_test_object &&
+		test-tool chmtime =-1209601 .git/objects/tmp_test_object
 	) &&
 	(
-	    cd parent &&
-	    echo "Even more text" >>file.txt &&
-	    git commit -a -m "Third commit" &&
-	    git send-pack ../child HEAD:refs/heads/test_auto_gc
+		cd parent &&
+		echo "Even more text" >>file.txt &&
+		git commit -a -m "Third commit" &&
+		git send-pack ../child HEAD:refs/heads/test_auto_gc
 	) &&
 	test ! -e child/.git/objects/tmp_test_object
 '
@@ -195,15 +196,15 @@ rewound_push_setup() {
 	rm -rf parent child &&
 	mkdir parent &&
 	(
-	    cd parent &&
-	    git init &&
-	    echo one >file && git add file && git commit -m one &&
-	    git config receive.denyCurrentBranch warn &&
-	    echo two >file && git commit -a -m two
+		cd parent &&
+		git init &&
+		echo one >file && git add file && git commit -m one &&
+		git config receive.denyCurrentBranch warn &&
+		echo two >file && git commit -a -m two
 	) &&
 	git clone parent child &&
 	(
-	    cd child && git reset --hard HEAD^
+		cd child && git reset --hard HEAD^
 	)
 }
 
@@ -211,16 +212,16 @@ test_expect_success 'pushing explicit refspecs respects forcing' '
 	rewound_push_setup &&
 	parent_orig=$(cd parent && git rev-parse --verify master) &&
 	(
-	    cd child &&
-	    test_must_fail git send-pack ../parent \
-		refs/heads/master:refs/heads/master
+		cd child &&
+		test_must_fail git send-pack ../parent \
+			refs/heads/master:refs/heads/master
 	) &&
 	parent_head=$(cd parent && git rev-parse --verify master) &&
 	test "$parent_orig" = "$parent_head" &&
 	(
-	    cd child &&
-	    git send-pack ../parent \
-	        +refs/heads/master:refs/heads/master
+		cd child &&
+		git send-pack ../parent \
+			+refs/heads/master:refs/heads/master
 	) &&
 	parent_head=$(cd parent && git rev-parse --verify master) &&
 	child_head=$(cd child && git rev-parse --verify master) &&
@@ -231,16 +232,16 @@ test_expect_success 'pushing wildcard refspecs respects forcing' '
 	rewound_push_setup &&
 	parent_orig=$(cd parent && git rev-parse --verify master) &&
 	(
-	    cd child &&
-	    test_must_fail git send-pack ../parent \
-	        "refs/heads/*:refs/heads/*"
+		cd child &&
+		test_must_fail git send-pack ../parent \
+			"refs/heads/*:refs/heads/*"
 	) &&
 	parent_head=$(cd parent && git rev-parse --verify master) &&
 	test "$parent_orig" = "$parent_head" &&
 	(
-	    cd child &&
-	    git send-pack ../parent \
-	        "+refs/heads/*:refs/heads/*"
+		cd child &&
+		git send-pack ../parent \
+			"+refs/heads/*:refs/heads/*"
 	) &&
 	parent_head=$(cd parent && git rev-parse --verify master) &&
 	child_head=$(cd child && git rev-parse --verify master) &&
@@ -250,8 +251,8 @@ test_expect_success 'pushing wildcard refspecs respects forcing' '
 test_expect_success 'deny pushing to delete current branch' '
 	rewound_push_setup &&
 	(
-	    cd child &&
-	    test_must_fail git send-pack ../parent :refs/heads/master 2>errs
+		cd child &&
+		test_must_fail git send-pack ../parent :refs/heads/master 2>errs
 	)
 '
 
@@ -289,7 +290,7 @@ test_expect_success 'receive-pack de-dupes .have lines' '
 	EOF
 
 	GIT_TRACE_PACKET=$(pwd)/trace GIT_TEST_PROTOCOL_VERSION=0 \
-	    git push \
+	git push \
 		--receive-pack="unset GIT_TRACE_PACKET; git-receive-pack" \
 		fork HEAD:foo &&
 	extract_ref_advertisement <trace >refs &&
diff --git a/t/t5402-post-merge-hook.sh b/t/t5402-post-merge-hook.sh
index 6eb2ffd6ec..4aeea8f5b7 100755
--- a/t/t5402-post-merge-hook.sh
+++ b/t/t5402-post-merge-hook.sh
@@ -15,7 +15,7 @@ test_expect_success setup '
 	git update-index a &&
 	tree1=$(git write-tree) &&
 	commit1=$(echo modify | git commit-tree $tree1 -p $commit0) &&
-        git update-ref refs/heads/master $commit0 &&
+	git update-ref refs/heads/master $commit0 &&
 	git clone ./. clone1 &&
 	GIT_DIR=clone1/.git git update-index --add a &&
 	git clone ./. clone2 &&
@@ -23,34 +23,34 @@ test_expect_success setup '
 '
 
 for clone in 1 2; do
-    cat >clone${clone}/.git/hooks/post-merge <<'EOF'
+	cat >clone${clone}/.git/hooks/post-merge <<'EOF'
 #!/bin/sh
 echo $@ >> $GIT_DIR/post-merge.args
 EOF
-    chmod u+x clone${clone}/.git/hooks/post-merge
+	chmod u+x clone${clone}/.git/hooks/post-merge
 done
 
 test_expect_success 'post-merge does not run for up-to-date ' '
-        GIT_DIR=clone1/.git git merge $commit0 &&
+	GIT_DIR=clone1/.git git merge $commit0 &&
 	! test -f clone1/.git/post-merge.args
 '
 
 test_expect_success 'post-merge runs as expected ' '
-        GIT_DIR=clone1/.git git merge $commit1 &&
+	GIT_DIR=clone1/.git git merge $commit1 &&
 	test -e clone1/.git/post-merge.args
 '
 
 test_expect_success 'post-merge from normal merge receives the right argument ' '
-        grep 0 clone1/.git/post-merge.args
+	grep 0 clone1/.git/post-merge.args
 '
 
 test_expect_success 'post-merge from squash merge runs as expected ' '
-        GIT_DIR=clone2/.git git merge --squash $commit1 &&
+	GIT_DIR=clone2/.git git merge --squash $commit1 &&
 	test -e clone2/.git/post-merge.args
 '
 
 test_expect_success 'post-merge from squash merge receives the right argument ' '
-        grep 1 clone2/.git/post-merge.args
+	grep 1 clone2/.git/post-merge.args
 '
 
 test_done
-- 
gitgitgadget

