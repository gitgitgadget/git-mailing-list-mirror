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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03781C63699
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88C6C20825
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNVVxS+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgKLWoQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbgKLWoP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:44:15 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E075C0613D4
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:15 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id o15so7685866wru.6
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1wYgntNTs6aa+PWjiBIsuK/bgN2C2HFkf4RASyI7wWA=;
        b=DNVVxS+7JxbjYQ+VLVnar4aLETU8VnJgQP6YAKtQV2LAtMINi/vs5OEL6nvfJ/MGi/
         TqwA8qP4wRv1hfgFT2imVsqCz7sGLmsIs8znpn7Vy/Oef6rhAUxjgDlSRJaVBL+yzo8t
         FIt2+3RR5NCUSlJiewFoR9tv/s5lBju+cOlKpKIRjODaqnN86SWaRNyxJgzldQVBDfNY
         gyQqsIibdlLUBOoFmmoEQj5TXpZbmJr4OEyCKHECmH24vtKgAyEcRmXo5xaprFsznJOU
         iSy+/l18sJBmvNfwTEosybGHnTPDUjxuk5Gc5xabenkxvZNqfwGZAI6YOicP5v9XLFD6
         OmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1wYgntNTs6aa+PWjiBIsuK/bgN2C2HFkf4RASyI7wWA=;
        b=ht29Q8DYdOKMjBl39vQ3Ua6xNSEro/pOvp4G8Lu7oDFkvjJWO+n8FD3V/zlL8bLeb7
         vjy0nGzUOajy5AEcPDkQylGzHUIhGOyfui7HLkldbfmQz7IYYqmvr+4UyKTf3IetATBj
         aOXwGbeGNYvvoIgP5vVEQxEW2Drir8dOvwuKQJPgo/PwwbRlHubS4z1/SmZa2zQu7Dto
         GYhhfkPt+k7jDvHvZLNEhmE6f8UBVMxNWOmKYlwSiubx9QJ8B/nSm37wc85nX2r95s5n
         rVuOaTX9myp0xJONqibcJStcbyVcKC4fpOPU5D0FrTvvAWoRLulP6eulAEPTlQ9RTdjc
         tBhw==
X-Gm-Message-State: AOAM5312pFIjK3El7C3n+qazcmq2yGXNk3ocIts0f8lD5SJDbBLWRWOg
        l9MY2cjoKQCMDL/nmHvXXh+JxpadyYk=
X-Google-Smtp-Source: ABdhPJzA7GZaY0KDWlOFti/JX9z7uzjFZsqvB2GuP/4ETe21nI3QpTODaf5uhBJIEGtp/+Xe/+Ifsg==
X-Received: by 2002:a05:6000:1183:: with SMTP id g3mr2070375wrx.7.1605221052795;
        Thu, 12 Nov 2020 14:44:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v12sm8858147wro.72.2020.11.12.14.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:44:12 -0800 (PST)
Message-Id: <8a2511b38e4938f02e99f65d42552899bd6e792c.1605221039.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.git.1605221038.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Nov 2020 22:43:45 +0000
Subject: [PATCH 15/28] t55[4-9]*: adjust the references to the default branch
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
		-e 's/Master/Main/g' -e 's/retsam/niam/g' \
		-- t55[4-9]*.sh t556x*)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Note that t5541 uses the reversed `master` name: `retsam`. We replace it
by the equivalent for `main`: `niam`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5540-http-push-webdav.sh          |  8 +--
 t/t5541-http-push-smart.sh           | 40 +++++++-------
 t/t5542-push-http-shallow.sh         |  8 +--
 t/t5543-atomic-push.sh               | 80 +++++++++++++--------------
 t/t5545-push-options.sh              | 62 ++++++++++-----------
 t/t5548-push-porcelain.sh            | 64 +++++++++++-----------
 t/t5550-http-fetch-dumb.sh           | 20 +++----
 t/t5551-http-fetch-smart.sh          | 20 +++----
 t/t5552-skipping-fetch-negotiator.sh |  2 +-
 t/t5553-set-upstream.sh              | 82 ++++++++++++++--------------
 t/t5561-http-backend.sh              |  4 +-
 t/t556x_common                       |  8 +--
 t/t5570-git-daemon.sh                | 16 +++---
 t/t5571-pre-push-hook.sh             |  4 +-
 t/t5572-pull-submodule.sh            |  4 +-
 t/t5580-unc-paths.sh                 |  2 +-
 t/t5581-http-curl-verbose.sh         |  2 +-
 t/t5582-fetch-negative-refspec.sh    | 22 ++++----
 t/test-lib.sh                        |  2 +-
 19 files changed, 225 insertions(+), 225 deletions(-)

diff --git a/t/t5540-http-push-webdav.sh b/t/t5540-http-push-webdav.sh
index 450321fddb..1973d8bb32 100755
--- a/t/t5540-http-push-webdav.sh
+++ b/t/t5540-http-push-webdav.sh
@@ -71,7 +71,7 @@ test_expect_success 'push already up-to-date' '
 test_expect_success 'push to remote repository with unpacked refs' '
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
 	 rm packed-refs &&
-	 git update-ref refs/heads/master $ORIG_HEAD &&
+	 git update-ref refs/heads/main $ORIG_HEAD &&
 	 git --bare update-server-info) &&
 	git push &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
@@ -91,7 +91,7 @@ test_expect_success 'http-push fetches unpacked objects' '
 	 git remote rm origin &&
 	 git reflog expire --expire=0 --all &&
 	 git prune &&
-	 git push -f -v $HTTPD_URL/dumb/test_repo_unpacked.git master)
+	 git push -f -v $HTTPD_URL/dumb/test_repo_unpacked.git main)
 '
 
 test_expect_success 'http-push fetches packed objects' '
@@ -111,7 +111,7 @@ test_expect_success 'http-push fetches packed objects' '
 	 git remote remove origin &&
 	 git reflog expire --expire=0 --all &&
 	 git prune &&
-	 git push -f -v $HTTPD_URL/dumb/test_repo_packed.git master)
+	 git push -f -v $HTTPD_URL/dumb/test_repo_packed.git main)
 '
 
 test_expect_success 'create and delete remote branch' '
@@ -163,7 +163,7 @@ test_expect_success 'PUT and MOVE sends object to URLs with SHA-1 hash suffix' '
 '
 
 test_http_push_nonff "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
-	"$ROOT_PATH"/test_repo_clone master
+	"$ROOT_PATH"/test_repo_clone main
 
 test_expect_success 'push to password-protected repository (user in URL)' '
 	test_commit pw-user &&
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 187454f5dd..ae90ed230b 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -142,23 +142,23 @@ test_expect_success 'used receive-pack service' '
 '
 
 test_http_push_nonff "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
-	"$ROOT_PATH"/test_repo_clone master 		success
+	"$ROOT_PATH"/test_repo_clone main 		success
 
 test_expect_success 'push fails for non-fast-forward refs unmatched by remote helper' '
 	# create a dissimilarly-named remote ref so that git is unable to match the
 	# two refs (viz. local, remote) unless an explicit refspec is provided.
-	git push origin master:retsam &&
+	git push origin main:niam &&
 
 	echo "change changed" > path2 &&
 	git commit -a -m path2 --amend &&
 
-	# push master too; this ensures there is at least one '"'push'"' command to
+	# push main too; this ensures there is at least one '"'push'"' command to
 	# the remote helper and triggers interaction with the helper.
-	test_must_fail git push -v origin +master master:retsam >output 2>&1'
+	test_must_fail git push -v origin +main main:niam >output 2>&1'
 
 test_expect_success 'push fails for non-fast-forward refs unmatched by remote helper: remote output' '
-	grep "^ + [a-f0-9]*\.\.\.[a-f0-9]* *master -> master (forced update)$" output &&
-	grep "^ ! \[rejected\] *master -> retsam (non-fast-forward)$" output
+	grep "^ + [a-f0-9]*\.\.\.[a-f0-9]* *main -> main (forced update)$" output &&
+	grep "^ ! \[rejected\] *main -> niam (non-fast-forward)$" output
 '
 
 test_expect_success 'push fails for non-fast-forward refs unmatched by remote helper: our output' '
@@ -167,7 +167,7 @@ test_expect_success 'push fails for non-fast-forward refs unmatched by remote he
 '
 
 test_expect_success 'push (chunked)' '
-	git checkout master &&
+	git checkout main &&
 	test_commit commit path3 &&
 	HEAD=$(git rev-parse --verify HEAD) &&
 	test_config http.postbuffer 4 &&
@@ -177,9 +177,9 @@ test_expect_success 'push (chunked)' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
-## References of remote: atomic1(1)            master(2) collateral(2) other(2)
-## References of local :            atomic2(2) master(1) collateral(3) other(2) collateral1(3) atomic(1)
-## Atomic push         :                       master(1) collateral(3)                         atomic(1)
+## References of remote: atomic1(1)            main(2) collateral(2) other(2)
+## References of local :            atomic2(2) main(1) collateral(3) other(2) collateral1(3) atomic(1)
+## Atomic push         :                       main(1) collateral(3)                         atomic(1)
 test_expect_success 'push --atomic also prevents branch creation, reports collateral' '
 	# Setup upstream repo - empty for now
 	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-branches.git &&
@@ -192,15 +192,15 @@ test_expect_success 'push --atomic also prevents branch creation, reports collat
 	test_commit atomic2 &&
 	git branch collateral &&
 	git branch other &&
-	git push "$up" atomic1 master collateral other &&
+	git push "$up" atomic1 main collateral other &&
 	git tag -d atomic1 &&
 
 	# collateral is a valid push, but should be failed by atomic push
 	git checkout collateral &&
 	test_commit collateral1 &&
 
-	# Make master incompatible with upstream to provoke atomic
-	git checkout master &&
+	# Make main incompatible with upstream to provoke atomic
+	git checkout main &&
 	git reset --hard HEAD^ &&
 
 	# Add a new branch which should be failed by atomic push. This is a
@@ -208,7 +208,7 @@ test_expect_success 'push --atomic also prevents branch creation, reports collat
 	git branch atomic &&
 
 	# --atomic should cause entire push to be rejected
-	test_must_fail git push --atomic "$up" master atomic collateral 2>output &&
+	test_must_fail git push --atomic "$up" main atomic collateral 2>output &&
 
 	# the new branch should not have been created upstream
 	test_must_fail git -C "$d" show-ref --verify refs/heads/atomic &&
@@ -216,15 +216,15 @@ test_expect_success 'push --atomic also prevents branch creation, reports collat
 	# upstream should still reflect atomic2, the last thing we pushed
 	# successfully
 	git rev-parse atomic2 >expected &&
-	# on master...
-	git -C "$d" rev-parse refs/heads/master >actual &&
+	# on main...
+	git -C "$d" rev-parse refs/heads/main >actual &&
 	test_cmp expected actual &&
 	# ...and collateral.
 	git -C "$d" rev-parse refs/heads/collateral >actual &&
 	test_cmp expected actual &&
 
 	# the failed refs should be indicated to the user
-	grep "^ ! .*rejected.* master -> master" output &&
+	grep "^ ! .*rejected.* main -> main" output &&
 
 	# the collateral failure refs should be indicated to the user
 	grep "^ ! .*rejected.* atomic -> atomic .*atomic push failed" output &&
@@ -472,9 +472,9 @@ test_expect_success 'clone/fetch scrubs password from reflogs' '
 	test_commit prepare-for-force-fetch &&
 	git switch -c away &&
 	git fetch "$HTTPD_URL_USER_PASS/smart/test_repo.git" \
-		+master:master &&
+		+main:main &&
 	# should have been scrubbed down to vanilla URL
-	git log -g master >reflog &&
+	git log -g main >reflog &&
 	grep "$HTTPD_URL" reflog &&
 	! grep "$HTTPD_URL_USER_PASS" reflog
 '
@@ -498,7 +498,7 @@ test_expect_success 'colorize errors/hints' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	test_must_fail git -c color.transport=always -c color.advice=always \
 		-c color.push=always \
-		push origin origin/master^:master 2>act &&
+		push origin origin/main^:main 2>act &&
 	test_decode_color <act >decoded &&
 	test_i18ngrep "<RED>.*rejected.*<RESET>" decoded &&
 	test_i18ngrep "<RED>error: failed to push some refs" decoded &&
diff --git a/t/t5542-push-http-shallow.sh b/t/t5542-push-http-shallow.sh
index ddc1db722d..0d8f5219da 100755
--- a/t/t5542-push-http-shallow.sh
+++ b/t/t5542-push-http-shallow.sh
@@ -51,12 +51,12 @@ test_expect_success 'push to shallow repo via http' '
 	(
 	cd full &&
 	commit 9 &&
-	git push $HTTPD_URL/smart/repo.git +master:refs/remotes/top/master
+	git push $HTTPD_URL/smart/repo.git +main:refs/remotes/top/main
 	) &&
 	(
 	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
 	git fsck &&
-	git log --format=%s top/master >actual &&
+	git log --format=%s top/main >actual &&
 	cat <<EOF >expect &&
 9
 4
@@ -74,11 +74,11 @@ test_expect_success 'push from shallow repo via http' '
 	git config http.receivepack true
 	) &&
 	commit 10 &&
-	git push $HTTPD_URL/smart/repo.git +master:refs/remotes/top/master &&
+	git push $HTTPD_URL/smart/repo.git +main:refs/remotes/top/main &&
 	(
 	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
 	git fsck &&
-	git log --format=%s top/master >actual &&
+	git log --format=%s top/main >actual &&
 	cat <<EOF >expect &&
 10
 4
diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index 620c30d58f..01a9a6e9e0 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -40,9 +40,9 @@ test_expect_success 'atomic push works for a single branch' '
 		test_commit one &&
 		git push --mirror up &&
 		test_commit two &&
-		git push --atomic up master
+		git push --atomic up main
 	) &&
-	test_refs master master
+	test_refs main main
 '
 
 test_expect_success 'atomic push works for two branches' '
@@ -55,9 +55,9 @@ test_expect_success 'atomic push works for two branches' '
 		test_commit two &&
 		git checkout second &&
 		test_commit three &&
-		git push --atomic up master second
+		git push --atomic up main second
 	) &&
-	test_refs master master &&
+	test_refs main main &&
 	test_refs second second
 '
 
@@ -70,7 +70,7 @@ test_expect_success 'atomic push works in combination with --mirror' '
 		test_commit two &&
 		git push --atomic --mirror up
 	) &&
-	test_refs master master &&
+	test_refs main main &&
 	test_refs second second
 '
 
@@ -79,7 +79,7 @@ test_expect_success 'atomic push works in combination with --force' '
 	(
 		cd workbench &&
 		test_commit one &&
-		git branch second master &&
+		git branch second main &&
 		test_commit two_a &&
 		git checkout second &&
 		test_commit two_b &&
@@ -87,36 +87,36 @@ test_expect_success 'atomic push works in combination with --force' '
 		test_commit four &&
 		git push --mirror up &&
 		# The actual test is below
-		git checkout master &&
+		git checkout main &&
 		test_commit three_a &&
 		git checkout second &&
 		git reset --hard HEAD^ &&
-		git push --force --atomic up master second
+		git push --force --atomic up main second
 	) &&
-	test_refs master master &&
+	test_refs main main &&
 	test_refs second second
 '
 
-# set up two branches where master can be pushed but second can not
+# set up two branches where main can be pushed but second can not
 # (non-fast-forward). Since second can not be pushed the whole operation
-# will fail and leave master untouched.
+# will fail and leave main untouched.
 test_expect_success 'atomic push fails if one branch fails' '
 	mk_repo_pair &&
 	(
 		cd workbench &&
 		test_commit one &&
-		git checkout -b second master &&
+		git checkout -b second main &&
 		test_commit two &&
 		test_commit three &&
 		test_commit four &&
 		git push --mirror up &&
 		git reset --hard HEAD~2 &&
 		test_commit five &&
-		git checkout master &&
+		git checkout main &&
 		test_commit six &&
 		test_must_fail git push --atomic --all up
 	) &&
-	test_refs master HEAD@{7} &&
+	test_refs main HEAD@{7} &&
 	test_refs second HEAD@{4}
 '
 
@@ -126,7 +126,7 @@ test_expect_success 'atomic push fails if one tag fails remotely' '
 	(
 		cd workbench &&
 		test_commit one &&
-		git checkout -b second master &&
+		git checkout -b second main &&
 		test_commit two &&
 		git push --mirror up
 	) &&
@@ -139,14 +139,14 @@ test_expect_success 'atomic push fails if one tag fails remotely' '
 	# see if we can now push both branches.
 	(
 		cd workbench &&
-		git checkout master &&
+		git checkout main &&
 		test_commit three &&
 		git checkout second &&
 		test_commit four &&
 		git tag test_tag &&
-		test_must_fail git push --tags --atomic up master second
+		test_must_fail git push --tags --atomic up main second
 	) &&
-	test_refs master HEAD@{3} &&
+	test_refs main HEAD@{3} &&
 	test_refs second HEAD@{1}
 '
 
@@ -155,7 +155,7 @@ test_expect_success 'atomic push obeys update hook preventing a branch to be pus
 	(
 		cd workbench &&
 		test_commit one &&
-		git checkout -b second master &&
+		git checkout -b second main &&
 		test_commit two &&
 		git push --mirror up
 	) &&
@@ -165,19 +165,19 @@ test_expect_success 'atomic push obeys update hook preventing a branch to be pus
 		HOOK="$HOOKDIR/update" &&
 		mkdir -p "$HOOKDIR" &&
 		write_script "$HOOK" <<-\EOF
-			# only allow update to master from now on
-			test "$1" = "refs/heads/master"
+			# only allow update to main from now on
+			test "$1" = "refs/heads/main"
 		EOF
 	) &&
 	(
 		cd workbench &&
-		git checkout master &&
+		git checkout main &&
 		test_commit three &&
 		git checkout second &&
 		test_commit four &&
-		test_must_fail git push --atomic up master second
+		test_must_fail git push --atomic up main second
 	) &&
-	test_refs master HEAD@{3} &&
+	test_refs main HEAD@{3} &&
 	test_refs second HEAD@{1}
 '
 
@@ -192,21 +192,21 @@ test_expect_success 'atomic push is not advertised if configured' '
 		test_commit one &&
 		git push --mirror up &&
 		test_commit two &&
-		test_must_fail git push --atomic up master
+		test_must_fail git push --atomic up main
 	) &&
-	test_refs master HEAD@{1}
+	test_refs main HEAD@{1}
 '
 
-# References in upstream : master(1) one(1) foo(1)
-# References in workbench: master(2)        foo(1) two(2) bar(2)
-# Atomic push            : master(2)               two(2) bar(2)
+# References in upstream : main(1) one(1) foo(1)
+# References in workbench: main(2)        foo(1) two(2) bar(2)
+# Atomic push            : main(2)               two(2) bar(2)
 test_expect_success 'atomic push reports (reject by update hook)' '
 	mk_repo_pair &&
 	(
 		cd workbench &&
 		test_commit one &&
 		git branch foo &&
-		git push up master one foo &&
+		git push up main one foo &&
 		git tag -d one
 	) &&
 	(
@@ -228,19 +228,19 @@ test_expect_success 'atomic push reports (reject by update hook)' '
 		git branch bar
 	) &&
 	test_must_fail git -C workbench \
-		push --atomic up master two bar >out 2>&1 &&
+		push --atomic up main two bar >out 2>&1 &&
 	fmt_status_report <out >actual &&
 	cat >expect <<-EOF &&
 	To ../upstream
-	 ! [remote rejected] master -> master (atomic push failure)
+	 ! [remote rejected] main -> main (atomic push failure)
 	 ! [remote rejected] two -> two (atomic push failure)
 	 ! [remote rejected] bar -> bar (hook declined)
 	EOF
 	test_cmp expect actual
 '
 
-# References in upstream : master(1) one(1) foo(1)
-# References in workbench: master(2)        foo(1) two(2) bar(2)
+# References in upstream : main(1) one(1) foo(1)
+# References in workbench: main(2)        foo(1) two(2) bar(2)
 test_expect_success 'atomic push reports (mirror, but reject by update hook)' '
 	(
 		cd workbench &&
@@ -252,7 +252,7 @@ test_expect_success 'atomic push reports (mirror, but reject by update hook)' '
 	fmt_status_report <out >actual &&
 	cat >expect <<-EOF &&
 	To ../upstream
-	 ! [remote rejected] master -> master (atomic push failure)
+	 ! [remote rejected] main -> main (atomic push failure)
 	 ! [remote rejected] one (atomic push failure)
 	 ! [remote rejected] bar -> bar (hook declined)
 	 ! [remote rejected] two -> two (atomic push failure)
@@ -260,21 +260,21 @@ test_expect_success 'atomic push reports (mirror, but reject by update hook)' '
 	test_cmp expect actual
 '
 
-# References in upstream : master(2) one(1) foo(1)
-# References in workbench: master(1)        foo(1) two(2) bar(2)
+# References in upstream : main(2) one(1) foo(1)
+# References in workbench: main(1)        foo(1) two(2) bar(2)
 test_expect_success 'atomic push reports (reject by non-ff)' '
 	rm upstream/.git/hooks/update &&
 	(
 		cd workbench &&
-		git push up master &&
+		git push up main &&
 		git reset --hard HEAD^
 	) &&
 	test_must_fail git -C workbench \
-		push --atomic up master foo bar >out 2>&1 &&
+		push --atomic up main foo bar >out 2>&1 &&
 	fmt_status_report <out >actual &&
 	cat >expect <<-EOF &&
 	To ../upstream
-	 ! [rejected] master -> master (non-fast-forward)
+	 ! [rejected] main -> main (non-fast-forward)
 	 ! [rejected] bar -> bar (atomic push failed)
 	EOF
 	test_cmp expect actual
diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index 38e6f7340e..a1276bbc33 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -63,9 +63,9 @@ test_expect_success 'one push option works for a single branch' '
 		test_commit one &&
 		git push --mirror up &&
 		test_commit two &&
-		git push --push-option=asdf up master
+		git push --push-option=asdf up main
 	) &&
-	test_refs master master &&
+	test_refs main main &&
 	echo "asdf" >expect &&
 	test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
 	test_cmp expect upstream/.git/hooks/post-receive.push_options
@@ -79,9 +79,9 @@ test_expect_success 'push option denied by remote' '
 		test_commit one &&
 		git push --mirror up &&
 		test_commit two &&
-		test_must_fail git push --push-option=asdf up master
+		test_must_fail git push --push-option=asdf up main
 	) &&
-	test_refs master HEAD@{1}
+	test_refs main HEAD@{1}
 '
 
 test_expect_success 'two push options work' '
@@ -92,9 +92,9 @@ test_expect_success 'two push options work' '
 		test_commit one &&
 		git push --mirror up &&
 		test_commit two &&
-		git push --push-option=asdf --push-option="more structured text" up master
+		git push --push-option=asdf --push-option="more structured text" up main
 	) &&
-	test_refs master master &&
+	test_refs main main &&
 	printf "asdf\nmore structured text\n" >expect &&
 	test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
 	test_cmp expect upstream/.git/hooks/post-receive.push_options
@@ -123,14 +123,14 @@ test_expect_success 'push options and submodules' '
 
 	git -C parent push \
 		--push-option=asdf --push-option="more structured text" \
-		--recurse-submodules=on-demand up master &&
+		--recurse-submodules=on-demand up main &&
 
-	git -C upstream rev-parse --verify master >expect &&
-	git -C parent/workbench rev-parse --verify master >actual &&
+	git -C upstream rev-parse --verify main >expect &&
+	git -C parent/workbench rev-parse --verify main >actual &&
 	test_cmp expect actual &&
 
-	git -C parent_upstream rev-parse --verify master >expect &&
-	git -C parent rev-parse --verify master >actual &&
+	git -C parent_upstream rev-parse --verify main >expect &&
+	git -C parent rev-parse --verify main >actual &&
 	test_cmp expect actual &&
 
 	printf "asdf\nmore structured text\n" >expect &&
@@ -148,9 +148,9 @@ test_expect_success 'default push option' '
 		test_commit one &&
 		git push --mirror up &&
 		test_commit two &&
-		git -c push.pushOption=default push up master
+		git -c push.pushOption=default push up main
 	) &&
-	test_refs master master &&
+	test_refs main main &&
 	echo "default" >expect &&
 	test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
 	test_cmp expect upstream/.git/hooks/post-receive.push_options
@@ -164,9 +164,9 @@ test_expect_success 'two default push options' '
 		test_commit one &&
 		git push --mirror up &&
 		test_commit two &&
-		git -c push.pushOption=default1 -c push.pushOption=default2 push up master
+		git -c push.pushOption=default1 -c push.pushOption=default2 push up main
 	) &&
-	test_refs master master &&
+	test_refs main main &&
 	printf "default1\ndefault2\n" >expect &&
 	test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
 	test_cmp expect upstream/.git/hooks/post-receive.push_options
@@ -180,9 +180,9 @@ test_expect_success 'push option from command line overrides from-config push op
 		test_commit one &&
 		git push --mirror up &&
 		test_commit two &&
-		git -c push.pushOption=default push --push-option=manual up master
+		git -c push.pushOption=default push --push-option=manual up main
 	) &&
-	test_refs master master &&
+	test_refs main main &&
 	echo "manual" >expect &&
 	test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
 	test_cmp expect upstream/.git/hooks/post-receive.push_options
@@ -196,9 +196,9 @@ test_expect_success 'empty value of push.pushOption in config clears the list' '
 		test_commit one &&
 		git push --mirror up &&
 		test_commit two &&
-		git -c push.pushOption=default1 -c push.pushOption= -c push.pushOption=default2 push up master
+		git -c push.pushOption=default1 -c push.pushOption= -c push.pushOption=default2 push up main
 	) &&
-	test_refs master master &&
+	test_refs main main &&
 	echo "default2" >expect &&
 	test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
 	test_cmp expect upstream/.git/hooks/post-receive.push_options
@@ -212,16 +212,16 @@ test_expect_success 'invalid push option in config' '
 		test_commit one &&
 		git push --mirror up &&
 		test_commit two &&
-		test_must_fail git -c push.pushOption push up master
+		test_must_fail git -c push.pushOption push up main
 	) &&
-	test_refs master HEAD@{1}
+	test_refs main HEAD@{1}
 '
 
 test_expect_success 'push options keep quoted characters intact (direct)' '
 	mk_repo_pair &&
 	git -C upstream config receive.advertisePushOptions true &&
 	test_commit -C workbench one &&
-	git -C workbench push --push-option="\"embedded quotes\"" up master &&
+	git -C workbench push --push-option="\"embedded quotes\"" up main &&
 	echo "\"embedded quotes\"" >expect &&
 	test_cmp expect upstream/.git/hooks/pre-receive.push_options
 '
@@ -244,28 +244,28 @@ mk_http_pair () {
 test_expect_success 'push option denied properly by http server' '
 	mk_http_pair false &&
 	test_commit -C test_http_clone one &&
-	test_must_fail git -C test_http_clone push --push-option=asdf origin master 2>actual &&
+	test_must_fail git -C test_http_clone push --push-option=asdf origin main 2>actual &&
 	test_i18ngrep "the receiving end does not support push options" actual &&
-	git -C test_http_clone push origin master
+	git -C test_http_clone push origin main
 '
 
 test_expect_success 'push options work properly across http' '
 	mk_http_pair true &&
 
 	test_commit -C test_http_clone one &&
-	git -C test_http_clone push origin master &&
-	git -C "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git rev-parse --verify master >expect &&
-	git -C test_http_clone rev-parse --verify master >actual &&
+	git -C test_http_clone push origin main &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git rev-parse --verify main >expect &&
+	git -C test_http_clone rev-parse --verify main >actual &&
 	test_cmp expect actual &&
 
 	test_commit -C test_http_clone two &&
-	git -C test_http_clone push --push-option=asdf --push-option="more structured text" origin master &&
+	git -C test_http_clone push --push-option=asdf --push-option="more structured text" origin main &&
 	printf "asdf\nmore structured text\n" >expect &&
 	test_cmp expect "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git/hooks/pre-receive.push_options &&
 	test_cmp expect "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git/hooks/post-receive.push_options &&
 
-	git -C "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git rev-parse --verify master >expect &&
-	git -C test_http_clone rev-parse --verify master >actual &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git rev-parse --verify main >expect &&
+	git -C test_http_clone rev-parse --verify main >actual &&
 	test_cmp expect actual
 '
 
@@ -273,7 +273,7 @@ test_expect_success 'push options keep quoted characters intact (http)' '
 	mk_http_pair true &&
 
 	test_commit -C test_http_clone one &&
-	git -C test_http_clone push --push-option="\"embedded quotes\"" origin master &&
+	git -C test_http_clone push --push-option="\"embedded quotes\"" origin main &&
 	echo "\"embedded quotes\"" >expect &&
 	test_cmp expect "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git/hooks/pre-receive.push_options
 '
diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index 1b19b3ef55..5a761f3642 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -36,7 +36,7 @@ create_commits_in () {
 		shift ||
 		return 1
 	done &&
-	git -C "$repo" update-ref refs/heads/master $oid
+	git -C "$repo" update-ref refs/heads/main $oid
 }
 
 # Format the output of git-push, git-show-ref and other commands to make a
@@ -57,8 +57,8 @@ make_user_friendly_and_stable_output () {
 }
 
 setup_upstream_and_workbench () {
-	# Upstream  after setup : master(B)  foo(A)  bar(A)  baz(A)
-	# Workbench after setup : master(A)
+	# Upstream  after setup : main(B)  foo(A)  bar(A)  baz(A)
+	# Workbench after setup : main(A)
 	test_expect_success "setup upstream repository and workbench" '
 		rm -rf upstream.git workbench &&
 		git init --bare upstream.git &&
@@ -70,9 +70,9 @@ setup_upstream_and_workbench () {
 			# this fixed-width oid will be replaced with "<OID>".
 			git config core.abbrev 7 &&
 			git remote add origin ../upstream.git &&
-			git update-ref refs/heads/master $A &&
+			git update-ref refs/heads/main $A &&
 			git push origin \
-				$B:refs/heads/master \
+				$B:refs/heads/main \
 				$A:refs/heads/foo \
 				$A:refs/heads/bar \
 				$A:refs/heads/baz
@@ -94,17 +94,17 @@ run_git_push_porcelain_output_test() {
 		;;
 	esac
 
-	# Refs of upstream : master(B)  foo(A)  bar(A)  baz(A)
-	# Refs of workbench: master(A)                  baz(A)  next(A)
-	# git-push         : master(A)  NULL    (B)     baz(A)  next(A)
+	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: main(A)                  baz(A)  next(A)
+	# git-push         : main(A)  NULL    (B)     baz(A)  next(A)
 	test_expect_success "porcelain output of successful git-push ($PROTOCOL)" '
 		(
 			cd workbench &&
-			git update-ref refs/heads/master $A &&
+			git update-ref refs/heads/main $A &&
 			git update-ref refs/heads/baz $A &&
 			git update-ref refs/heads/next $A &&
 			git push --porcelain --force origin \
-				master \
+				main \
 				:refs/heads/foo \
 				$B:bar \
 				baz \
@@ -116,7 +116,7 @@ run_git_push_porcelain_output_test() {
 		=    refs/heads/baz:refs/heads/baz    [up to date]
 		     <COMMIT-B>:refs/heads/bar    <OID-A>..<OID-B>
 		-    :refs/heads/foo    [deleted]
-		+    refs/heads/master:refs/heads/master    <OID-B>...<OID-A> (forced update)
+		+    refs/heads/main:refs/heads/main    <OID-B>...<OID-A> (forced update)
 		*    refs/heads/next:refs/heads/next    [new branch]
 		Done
 		EOF
@@ -127,22 +127,22 @@ run_git_push_porcelain_output_test() {
 		cat >expect <<-EOF &&
 		<COMMIT-B> refs/heads/bar
 		<COMMIT-A> refs/heads/baz
-		<COMMIT-A> refs/heads/master
+		<COMMIT-A> refs/heads/main
 		<COMMIT-A> refs/heads/next
 		EOF
 		test_cmp expect actual
 	'
 
-	# Refs of upstream : master(A)  bar(B)  baz(A)  next(A)
-	# Refs of workbench: master(B)  bar(A)  baz(A)  next(A)
-	# git-push         : master(B)  bar(A)  NULL    next(A)
+	# Refs of upstream : main(A)  bar(B)  baz(A)  next(A)
+	# Refs of workbench: main(B)  bar(A)  baz(A)  next(A)
+	# git-push         : main(B)  bar(A)  NULL    next(A)
 	test_expect_success "atomic push failed ($PROTOCOL)" '
 		(
 			cd workbench &&
-			git update-ref refs/heads/master $B &&
+			git update-ref refs/heads/main $B &&
 			git update-ref refs/heads/bar $A &&
 			test_must_fail git push --atomic --porcelain origin \
-				master \
+				main \
 				bar \
 				:baz \
 				next
@@ -153,7 +153,7 @@ run_git_push_porcelain_output_test() {
 		=    refs/heads/next:refs/heads/next    [up to date]
 		!    refs/heads/bar:refs/heads/bar    [rejected] (non-fast-forward)
 		!    (delete):refs/heads/baz    [rejected] (atomic push failed)
-		!    refs/heads/master:refs/heads/master    [rejected] (atomic push failed)
+		!    refs/heads/main:refs/heads/main    [rejected] (atomic push failed)
 		Done
 		EOF
 		test_cmp expect actual &&
@@ -163,7 +163,7 @@ run_git_push_porcelain_output_test() {
 		cat >expect <<-EOF &&
 		<COMMIT-B> refs/heads/bar
 		<COMMIT-A> refs/heads/baz
-		<COMMIT-A> refs/heads/master
+		<COMMIT-A> refs/heads/main
 		<COMMIT-A> refs/heads/next
 		EOF
 		test_cmp expect actual
@@ -174,16 +174,16 @@ run_git_push_porcelain_output_test() {
 		EOF
 	'
 
-	# Refs of upstream : master(A)  bar(B)  baz(A)  next(A)
-	# Refs of workbench: master(B)  bar(A)  baz(A)  next(A)
-	# git-push         : master(B)  bar(A)  NULL    next(A)
+	# Refs of upstream : main(A)  bar(B)  baz(A)  next(A)
+	# Refs of workbench: main(B)  bar(A)  baz(A)  next(A)
+	# git-push         : main(B)  bar(A)  NULL    next(A)
 	test_expect_success "pre-receive hook declined ($PROTOCOL)" '
 		(
 			cd workbench &&
-			git update-ref refs/heads/master $B &&
+			git update-ref refs/heads/main $B &&
 			git update-ref refs/heads/bar $A &&
 			test_must_fail git push --porcelain --force origin \
-				master \
+				main \
 				bar \
 				:baz \
 				next
@@ -194,7 +194,7 @@ run_git_push_porcelain_output_test() {
 		=    refs/heads/next:refs/heads/next    [up to date]
 		!    refs/heads/bar:refs/heads/bar    [remote rejected] (pre-receive hook declined)
 		!    :refs/heads/baz    [remote rejected] (pre-receive hook declined)
-		!    refs/heads/master:refs/heads/master    [remote rejected] (pre-receive hook declined)
+		!    refs/heads/main:refs/heads/main    [remote rejected] (pre-receive hook declined)
 		Done
 		EOF
 		test_cmp expect actual &&
@@ -204,7 +204,7 @@ run_git_push_porcelain_output_test() {
 		cat >expect <<-EOF &&
 		<COMMIT-B> refs/heads/bar
 		<COMMIT-A> refs/heads/baz
-		<COMMIT-A> refs/heads/master
+		<COMMIT-A> refs/heads/main
 		<COMMIT-A> refs/heads/next
 		EOF
 		test_cmp expect actual
@@ -214,14 +214,14 @@ run_git_push_porcelain_output_test() {
 		rm "$upstream/hooks/pre-receive"
 	'
 
-	# Refs of upstream : master(A)  bar(B)  baz(A)  next(A)
-	# Refs of workbench: master(B)  bar(A)  baz(A)  next(A)
-	# git-push         : master(B)  bar(A)  NULL    next(A)
+	# Refs of upstream : main(A)  bar(B)  baz(A)  next(A)
+	# Refs of workbench: main(B)  bar(A)  baz(A)  next(A)
+	# git-push         : main(B)  bar(A)  NULL    next(A)
 	test_expect_success "non-fastforward push ($PROTOCOL)" '
 		(
 			cd workbench &&
 			test_must_fail git push --porcelain origin \
-				master \
+				main \
 				bar \
 				:baz \
 				next
@@ -231,7 +231,7 @@ run_git_push_porcelain_output_test() {
 		To <URL/of/upstream.git>
 		=    refs/heads/next:refs/heads/next    [up to date]
 		-    :refs/heads/baz    [deleted]
-		     refs/heads/master:refs/heads/master    <OID-A>..<OID-B>
+		     refs/heads/main:refs/heads/main    <OID-A>..<OID-B>
 		!    refs/heads/bar:refs/heads/bar    [rejected] (non-fast-forward)
 		Done
 		EOF
@@ -241,7 +241,7 @@ run_git_push_porcelain_output_test() {
 		make_user_friendly_and_stable_output <out >actual &&
 		cat >expect <<-EOF &&
 		<COMMIT-B> refs/heads/bar
-		<COMMIT-B> refs/heads/master
+		<COMMIT-B> refs/heads/main
 		<COMMIT-A> refs/heads/next
 		EOF
 		test_cmp expect actual
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 483578b2d7..6fdcd0c036 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -26,7 +26,7 @@ test_expect_success 'create http-accessible bare repository with loose objects'
 	 hooks/post-update
 	) &&
 	git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	git push public master:master
+	git push public main:main
 '
 
 test_expect_success 'clone http repository' '
@@ -37,8 +37,8 @@ test_expect_success 'clone http repository' '
 
 test_expect_success 'list refs from outside any repository' '
 	cat >expect <<-EOF &&
-	$(git rev-parse master)	HEAD
-	$(git rev-parse master)	refs/heads/master
+	$(git rev-parse main)	HEAD
+	$(git rev-parse main)	refs/heads/main
 	EOF
 	nongit git ls-remote "$HTTPD_URL/dumb/repo.git" >actual &&
 	test_cmp expect actual
@@ -181,8 +181,8 @@ test_expect_success 'fetch changes via manual http-fetch' '
 
 	HEAD=$(git rev-parse --verify HEAD) &&
 	(cd clone2 &&
-	 git http-fetch -a -w heads/master-new $HEAD $(git config remote.origin.url) &&
-	 git checkout master-new &&
+	 git http-fetch -a -w heads/main-new $HEAD $(git config remote.origin.url) &&
+	 git checkout main-new &&
 	 test $HEAD = $(git rev-parse --verify HEAD)) &&
 	test_cmp file clone2/file
 '
@@ -192,19 +192,19 @@ test_expect_success 'manual http-fetch without -a works just as well' '
 
 	HEAD=$(git rev-parse --verify HEAD) &&
 	(cd clone3 &&
-	 git http-fetch -w heads/master-new $HEAD $(git config remote.origin.url) &&
-	 git checkout master-new &&
+	 git http-fetch -w heads/main-new $HEAD $(git config remote.origin.url) &&
+	 git checkout main-new &&
 	 test $HEAD = $(git rev-parse --verify HEAD)) &&
 	test_cmp file clone3/file
 '
 
 test_expect_success 'http remote detects correct HEAD' '
-	git push public master:other &&
+	git push public main:other &&
 	(cd clone &&
 	 git remote set-head origin -d &&
 	 git remote set-head origin -a &&
 	 git symbolic-ref refs/remotes/origin/HEAD > output &&
-	 echo refs/remotes/origin/master > expect &&
+	 echo refs/remotes/origin/main > expect &&
 	 test_cmp expect output
 	)
 '
@@ -416,7 +416,7 @@ test_expect_success 'set up evil alternates scheme' '
 	evil=$HTTPD_DOCUMENT_ROOT_PATH/evil.git &&
 	git init --bare "$evil" &&
 	# do this by hand to avoid object existence check
-	printf "%s\\t%s\\n" $sha1 refs/heads/master >"$evil/info/refs"
+	printf "%s\\t%s\\n" $sha1 refs/heads/main >"$evil/info/refs"
 '
 
 # Here we'll just redirect via HTTP. In a real-world attack these would be on
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index e40e9ed52f..2215bbcce7 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -18,7 +18,7 @@ test_expect_success 'create http-accessible bare repository' '
 	 git --bare init
 	) &&
 	git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	git push public master:master
+	git push public main:main
 '
 
 setup_askpass_helper
@@ -238,9 +238,9 @@ test_expect_success 'invalid Content-Type rejected' '
 
 test_expect_success 'create namespaced refs' '
 	test_commit namespaced &&
-	git push public HEAD:refs/namespaces/ns/refs/heads/master &&
+	git push public HEAD:refs/namespaces/ns/refs/heads/main &&
 	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
-		symbolic-ref refs/namespaces/ns/HEAD refs/namespaces/ns/refs/heads/master
+		symbolic-ref refs/namespaces/ns/HEAD refs/namespaces/ns/refs/heads/main
 '
 
 test_expect_success 'smart clone respects namespace' '
@@ -271,7 +271,7 @@ test_expect_success 'cookies stored in http.cookiefile when http.savecookies set
 	EOF
 	git config http.cookiefile cookies.txt &&
 	git config http.savecookies true &&
-	git ls-remote $HTTPD_URL/smart_cookies/repo.git master &&
+	git ls-remote $HTTPD_URL/smart_cookies/repo.git main &&
 
 	# NEEDSWORK: If the overspecification of the expected result is reduced, we
 	# might be able to run this test in all protocol versions.
@@ -344,12 +344,12 @@ test_expect_success 'large fetch-pack requests can be sent using chunked encodin
 test_expect_success 'test allowreachablesha1inwant' '
 	test_when_finished "rm -rf test_reachable.git" &&
 	server="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	master_sha=$(git -C "$server" rev-parse refs/heads/master) &&
+	main_sha=$(git -C "$server" rev-parse refs/heads/main) &&
 	git -C "$server" config uploadpack.allowreachablesha1inwant 1 &&
 
 	git init --bare test_reachable.git &&
 	git -C test_reachable.git remote add origin "$HTTPD_URL/smart/repo.git" &&
-	git -C test_reachable.git fetch origin "$master_sha"
+	git -C test_reachable.git fetch origin "$main_sha"
 '
 
 test_expect_success 'test allowreachablesha1inwant with unreachable' '
@@ -363,7 +363,7 @@ test_expect_success 'test allowreachablesha1inwant with unreachable' '
 	git push public :refs/heads/doomed &&
 
 	server="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	master_sha=$(git -C "$server" rev-parse refs/heads/master) &&
+	main_sha=$(git -C "$server" rev-parse refs/heads/main) &&
 	git -C "$server" config uploadpack.allowreachablesha1inwant 1 &&
 
 	git init --bare test_reachable.git &&
@@ -385,7 +385,7 @@ test_expect_success 'test allowanysha1inwant with unreachable' '
 	git push public :refs/heads/doomed &&
 
 	server="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	master_sha=$(git -C "$server" rev-parse refs/heads/master) &&
+	main_sha=$(git -C "$server" rev-parse refs/heads/main) &&
 	git -C "$server" config uploadpack.allowreachablesha1inwant 1 &&
 
 	git init --bare test_reachable.git &&
@@ -444,8 +444,8 @@ test_expect_success 'using fetch command in remote-curl updates refs' '
 	test_commit -C "$SERVER" bar &&
 	git -C client -c protocol.version=0 fetch &&
 
-	git -C "$SERVER" rev-parse master >expect &&
-	git -C client rev-parse origin/master >actual &&
+	git -C "$SERVER" rev-parse main >expect &&
+	git -C client rev-parse origin/main >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index 156c704040..7b9fb4ff02 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -100,7 +100,7 @@ test_expect_success 'use ref advertisement to filter out commits' '
 	git -C server checkout --orphan anotherbranch &&
 	test_commit -C server to_fetch &&
 
-	# The server advertising "c3" (as "refs/heads/master") means that we do
+	# The server advertising "c3" (as "refs/heads/main") means that we do
 	# not need to send any ancestors of "c3", but we still need to send "c3"
 	# itself.
 	test_config -C client fetch.negotiationalgorithm skipping &&
diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
index 7622981cbf..0e6574f526 100755
--- a/t/t5553-set-upstream.sh
+++ b/t/t5553-set-upstream.sh
@@ -32,9 +32,9 @@ test_expect_success 'setup bare parent fetch' '
 	git remote add upstream parent
 '
 
-test_expect_success 'setup commit on master and other fetch' '
+test_expect_success 'setup commit on main and other fetch' '
 	test_commit one &&
-	git push upstream master &&
+	git push upstream main &&
 	git checkout -b other &&
 	test_commit two &&
 	git push upstream other
@@ -43,38 +43,38 @@ test_expect_success 'setup commit on master and other fetch' '
 # tests for fetch --set-upstream
 
 test_expect_success 'fetch --set-upstream does not set upstream w/o branch' '
-	clear_config master other &&
-	git checkout master &&
+	clear_config main other &&
+	git checkout main &&
 	git fetch --set-upstream upstream &&
-	check_config_missing master &&
+	check_config_missing main &&
 	check_config_missing other
 '
 
-test_expect_success 'fetch --set-upstream upstream master sets branch master but not other' '
-	clear_config master other &&
-	git fetch --set-upstream upstream master &&
-	check_config master upstream refs/heads/master &&
+test_expect_success 'fetch --set-upstream upstream main sets branch main but not other' '
+	clear_config main other &&
+	git fetch --set-upstream upstream main &&
+	check_config main upstream refs/heads/main &&
 	check_config_missing other
 '
 
 test_expect_success 'fetch --set-upstream upstream other sets branch other' '
-	clear_config master other &&
+	clear_config main other &&
 	git fetch --set-upstream upstream other &&
-	check_config master upstream refs/heads/other &&
+	check_config main upstream refs/heads/other &&
 	check_config_missing other
 '
 
-test_expect_success 'fetch --set-upstream master:other does not set the branch other2' '
+test_expect_success 'fetch --set-upstream main:other does not set the branch other2' '
 	clear_config other2 &&
-	git fetch --set-upstream upstream master:other2 &&
+	git fetch --set-upstream upstream main:other2 &&
 	check_config_missing other2
 '
 
 test_expect_success 'fetch --set-upstream http://nosuchdomain.example.com fails with invalid url' '
-	# master explicitly not cleared, we check that it is not touched from previous value
+	# main explicitly not cleared, we check that it is not touched from previous value
 	clear_config other other2 &&
 	test_must_fail git fetch --set-upstream http://nosuchdomain.example.com &&
-	check_config master upstream refs/heads/other &&
+	check_config main upstream refs/heads/other &&
 	check_config_missing other &&
 	check_config_missing other2
 '
@@ -83,7 +83,7 @@ test_expect_success 'fetch --set-upstream with valid URL sets upstream to URL' '
 	clear_config other other2 &&
 	url="file://$PWD" &&
 	git fetch --set-upstream "$url" &&
-	check_config master "$url" HEAD &&
+	check_config main "$url" HEAD &&
 	check_config_missing other &&
 	check_config_missing other2
 '
@@ -96,30 +96,30 @@ test_expect_success 'setup bare parent pull' '
 	git remote add upstream parent
 '
 
-test_expect_success 'setup commit on master and other pull' '
+test_expect_success 'setup commit on main and other pull' '
 	test_commit three &&
-	git push --tags upstream master &&
+	git push --tags upstream main &&
 	test_commit four &&
 	git push upstream other
 '
 
-test_expect_success 'pull --set-upstream upstream master sets branch master but not other' '
-	clear_config master other &&
-	git pull --set-upstream upstream master &&
-	check_config master upstream refs/heads/master &&
+test_expect_success 'pull --set-upstream upstream main sets branch main but not other' '
+	clear_config main other &&
+	git pull --set-upstream upstream main &&
+	check_config main upstream refs/heads/main &&
 	check_config_missing other
 '
 
-test_expect_success 'pull --set-upstream master:other2 does not set the branch other2' '
+test_expect_success 'pull --set-upstream main:other2 does not set the branch other2' '
 	clear_config other2 &&
-	git pull --set-upstream upstream master:other2 &&
+	git pull --set-upstream upstream main:other2 &&
 	check_config_missing other2
 '
 
-test_expect_success 'pull --set-upstream upstream other sets branch master' '
-	clear_config master other &&
+test_expect_success 'pull --set-upstream upstream other sets branch main' '
+	clear_config main other &&
 	git pull --set-upstream upstream other &&
-	check_config master upstream refs/heads/other &&
+	check_config main upstream refs/heads/other &&
 	check_config_missing other
 '
 
@@ -130,47 +130,47 @@ test_expect_success 'pull --set-upstream upstream tag does not set the tag' '
 '
 
 test_expect_success 'pull --set-upstream http://nosuchdomain.example.com fails with invalid url' '
-	# master explicitly not cleared, we check that it is not touched from previous value
+	# main explicitly not cleared, we check that it is not touched from previous value
 	clear_config other other2 three &&
 	test_must_fail git pull --set-upstream http://nosuchdomain.example.com &&
-	check_config master upstream refs/heads/other &&
+	check_config main upstream refs/heads/other &&
 	check_config_missing other &&
 	check_config_missing other2 &&
 	check_config_missing three
 '
 
 test_expect_success 'pull --set-upstream upstream HEAD sets branch HEAD' '
-	clear_config master other &&
+	clear_config main other &&
 	git pull --set-upstream upstream HEAD &&
-	check_config master upstream HEAD &&
+	check_config main upstream HEAD &&
 	git checkout other &&
 	git pull --set-upstream upstream HEAD &&
 	check_config other upstream HEAD
 '
 
 test_expect_success 'pull --set-upstream upstream with more than one branch does nothing' '
-	clear_config master three &&
-	git pull --set-upstream upstream master three &&
-	check_config_missing master &&
+	clear_config main three &&
+	git pull --set-upstream upstream main three &&
+	check_config_missing main &&
 	check_config_missing three
 '
 
 test_expect_success 'pull --set-upstream with valid URL sets upstream to URL' '
-	clear_config master other other2 &&
-	git checkout master &&
+	clear_config main other other2 &&
+	git checkout main &&
 	url="file://$PWD" &&
 	git pull --set-upstream "$url" &&
-	check_config master "$url" HEAD &&
+	check_config main "$url" HEAD &&
 	check_config_missing other &&
 	check_config_missing other2
 '
 
 test_expect_success 'pull --set-upstream with valid URL and branch sets branch' '
-	clear_config master other other2 &&
-	git checkout master &&
+	clear_config main other other2 &&
+	git checkout main &&
 	url="file://$PWD" &&
-	git pull --set-upstream "$url" master &&
-	check_config master "$url" refs/heads/master &&
+	git pull --set-upstream "$url" main &&
+	check_config main "$url" refs/heads/main &&
 	check_config_missing other &&
 	check_config_missing other2
 '
diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
index 6eb0294978..c8a9f7f9bb 100755
--- a/t/t5561-http-backend.sh
+++ b/t/t5561-http-backend.sh
@@ -39,9 +39,9 @@ POST() {
 
 grep '^[^#]' >exp <<EOF
 
-###  refs/heads/master
+###  refs/heads/main
 ###
-GET  /smart/repo.git/refs/heads/master HTTP/1.1 404 -
+GET  /smart/repo.git/refs/heads/main HTTP/1.1 404 -
 
 ###  getanyfile default
 ###
diff --git a/t/t556x_common b/t/t556x_common
index 359fcfe32b..670fb89477 100755
--- a/t/t556x_common
+++ b/t/t556x_common
@@ -22,7 +22,7 @@ test_expect_success 'setup repository' '
 	 : >objects/info/http-alternates
 	) &&
 	git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	git push public master:master &&
+	git push public main:main &&
 
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
 	 git repack -a -d
@@ -31,7 +31,7 @@ test_expect_success 'setup repository' '
 	echo other >file &&
 	git add file &&
 	git commit -m two &&
-	git push public master:master &&
+	git push public main:main &&
 
 	LOOSE_URL=$(find_file objects/??) &&
 	PACK_URL=$(find_file objects/pack/*.pack) &&
@@ -51,8 +51,8 @@ get_static_files() {
 
 SMART=smart
 GIT_HTTP_EXPORT_ALL=1 && export GIT_HTTP_EXPORT_ALL
-test_expect_success 'direct refs/heads/master not found' '
-	GET refs/heads/master "404 Not Found"
+test_expect_success 'direct refs/heads/main not found' '
+	GET refs/heads/main "404 Not Found"
 '
 test_expect_success 'static file is ok' '
 	get_static_files "200 OK"
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 8f69a7854f..864d5c985c 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -26,7 +26,7 @@ test_expect_success 'create git-accessible bare repository' '
 	 : >git-daemon-export-ok
 	) &&
 	git remote add public "$GIT_DAEMON_DOCUMENT_ROOT_PATH/repo.git" &&
-	git push public master:master
+	git push public main:main
 '
 
 test_expect_success 'clone git repository' '
@@ -55,12 +55,12 @@ test_expect_success 'no-op fetch without "-v" is quiet' '
 '
 
 test_expect_success 'remote detects correct HEAD' '
-	git push public master:other &&
+	git push public main:other &&
 	(cd clone &&
 	 git remote set-head -d origin &&
 	 git remote set-head -a origin &&
 	 git symbolic-ref refs/remotes/origin/HEAD > output &&
-	 echo refs/remotes/origin/master > expect &&
+	 echo refs/remotes/origin/main > expect &&
 	 test_cmp expect output
 	)
 '
@@ -148,7 +148,7 @@ test_remote_error()
 
 msg="access denied or repository not exported"
 test_expect_success 'clone non-existent' "test_remote_error    '$msg' clone nowhere.git"
-test_expect_success 'push disabled'      "test_remote_error    '$msg' push  repo.git master"
+test_expect_success 'push disabled'      "test_remote_error    '$msg' push  repo.git main"
 test_expect_success 'read access denied' "test_remote_error -x '$msg' fetch repo.git"
 test_expect_success 'not exported'       "test_remote_error -n '$msg' fetch repo.git"
 
@@ -156,7 +156,7 @@ stop_git_daemon
 start_git_daemon --informative-errors
 
 test_expect_success 'clone non-existent' "test_remote_error    'no such repository'      clone nowhere.git"
-test_expect_success 'push disabled'      "test_remote_error    'service not enabled'     push  repo.git master"
+test_expect_success 'push disabled'      "test_remote_error    'service not enabled'     push  repo.git main"
 test_expect_success 'read access denied' "test_remote_error -x 'no such repository'      fetch repo.git"
 test_expect_success 'not exported'       "test_remote_error -n 'repository not exported' fetch repo.git"
 
@@ -192,10 +192,10 @@ test_expect_success FAKENC 'hostname interpolation works after LF-stripping' '
 	fake_nc "$GIT_DAEMON_HOST_PORT" <input >output &&
 	depacketize <output >output.raw &&
 
-	# just pick out the value of master, which avoids any protocol
+	# just pick out the value of main, which avoids any protocol
 	# particulars
-	perl -lne "print \$1 if m{^(\\S+) refs/heads/master}" <output.raw >actual &&
-	git -C "$repo" rev-parse master >expect &&
+	perl -lne "print \$1 if m{^(\\S+) refs/heads/main}" <output.raw >actual &&
+	git -C "$repo" rev-parse main >expect &&
 	test_cmp expect actual
 '
 
diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
index ac53d63869..891f03cd59 100755
--- a/t/t5571-pre-push-hook.sh
+++ b/t/t5571-pre-push-hook.sh
@@ -48,11 +48,11 @@ EOF
 cat >expected <<EOF
 parent1
 repo1
-refs/heads/master $COMMIT2 refs/heads/foreign $COMMIT1
+refs/heads/main $COMMIT2 refs/heads/foreign $COMMIT1
 EOF
 
 test_expect_success 'push with hook' '
-	git push parent1 master:foreign &&
+	git push parent1 main:foreign &&
 	diff expected actual
 '
 
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index 1d75e3b12b..d6a75964d8 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -148,8 +148,8 @@ test_expect_success 'branch has no merge base with remote-tracking counterpart'
 
 	git clone parent child &&
 
-	# Reset master so that it has no merge base with
-	# refs/remotes/origin/master.
+	# Reset main so that it has no merge base with
+	# refs/remotes/origin/main.
 	OTHER=$(git -C child commit-tree -m bar \
 		$(git -C child rev-parse HEAD^{tree})) &&
 	git -C child reset --hard "$OTHER" &&
diff --git a/t/t5580-unc-paths.sh b/t/t5580-unc-paths.sh
index cf768b3a27..511c1ba51d 100755
--- a/t/t5580-unc-paths.sh
+++ b/t/t5580-unc-paths.sh
@@ -53,7 +53,7 @@ test_expect_success fetch '
 	git init to-fetch &&
 	(
 		cd to-fetch &&
-		git fetch "$UNCPATH" master
+		git fetch "$UNCPATH" main
 	)
 '
 
diff --git a/t/t5581-http-curl-verbose.sh b/t/t5581-http-curl-verbose.sh
index 927aad0820..0c6e3b7665 100755
--- a/t/t5581-http-curl-verbose.sh
+++ b/t/t5581-http-curl-verbose.sh
@@ -13,7 +13,7 @@ test_expect_success 'setup repository' '
 	git add file &&
 	git commit -m one &&
 	git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	git push public master:master
+	git push public main:main
 '
 
 test_expect_success 'failure in git-upload-pack is shown' '
diff --git a/t/t5582-fetch-negative-refspec.sh b/t/t5582-fetch-negative-refspec.sh
index 8c61e28fec..9c2b19cae2 100755
--- a/t/t5582-fetch-negative-refspec.sh
+++ b/t/t5582-fetch-negative-refspec.sh
@@ -22,12 +22,12 @@ test_expect_success "clone and setup child repos" '
 		git switch -c alternate &&
 		echo >file updated again by one &&
 		git commit -a -m "updated by one again" &&
-		git switch master
+		git switch main
 	) &&
 	git clone . two &&
 	(
 		cd two &&
-		git config branch.master.remote one &&
+		git config branch.main.remote one &&
 		git config remote.one.url ../one/.git/ &&
 		git config remote.one.fetch +refs/heads/*:refs/remotes/one/* &&
 		git config --add remote.one.fetch ^refs/heads/alternate
@@ -43,9 +43,9 @@ test_expect_success "fetch one" '
 		test_must_fail git rev-parse --verify refs/remotes/one/alternate &&
 		git fetch one &&
 		test_must_fail git rev-parse --verify refs/remotes/one/alternate &&
-		git rev-parse --verify refs/remotes/one/master &&
-		mine=$(git rev-parse refs/remotes/one/master) &&
-		his=$(cd ../one && git rev-parse refs/heads/master) &&
+		git rev-parse --verify refs/remotes/one/main &&
+		mine=$(git rev-parse refs/remotes/one/main) &&
+		his=$(cd ../one && git rev-parse refs/heads/main) &&
 		test "z$mine" = "z$his"
 	)
 '
@@ -57,7 +57,7 @@ test_expect_success "fetch with negative refspec on commandline" '
 		cd three &&
 		alternate_in_one=$(cd ../one && git rev-parse refs/heads/alternate) &&
 		echo $alternate_in_one >expect &&
-		git fetch ../one/.git refs/heads/*:refs/remotes/one/* ^refs/heads/master &&
+		git fetch ../one/.git refs/heads/*:refs/remotes/one/* ^refs/heads/main &&
 		cut -f -1 .git/FETCH_HEAD >actual &&
 		test_cmp expect actual
 	)
@@ -68,8 +68,8 @@ test_expect_success "fetch with negative sha1 refspec fails" '
 	git commit -a -m "updated by origin yet again" &&
 	(
 		cd three &&
-		master_in_one=$(cd ../one && git rev-parse refs/heads/master) &&
-		test_must_fail git fetch ../one/.git refs/heads/*:refs/remotes/one/* ^$master_in_one
+		main_in_one=$(cd ../one && git rev-parse refs/heads/main) &&
+		test_must_fail git fetch ../one/.git refs/heads/*:refs/remotes/one/* ^$main_in_one
 	)
 '
 
@@ -92,10 +92,10 @@ test_expect_success "fetch with negative pattern refspec does not expand prefix"
 	(
 		cd three &&
 		alternate_in_one=$(cd ../one && git rev-parse refs/heads/alternate) &&
-		master_in_one=$(cd ../one && git rev-parse refs/heads/master) &&
+		main_in_one=$(cd ../one && git rev-parse refs/heads/main) &&
 		echo $alternate_in_one >expect &&
-		echo $master_in_one >>expect &&
-		git fetch ../one/.git refs/heads/*:refs/remotes/one/* ^master &&
+		echo $main_in_one >>expect &&
+		git fetch ../one/.git refs/heads/*:refs/remotes/one/* ^main &&
 		cut -f -1 .git/FETCH_HEAD >actual &&
 		test_cmp expect actual
 	)
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ecaa0f36f3..f919021063 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -263,7 +263,7 @@ case "$TEST_NUMBER" in
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-[0-4]*|5[0-4]*|55[0-3]*)
+[0-4]*|5[0-5]*)
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-- 
gitgitgadget

