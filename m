Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF14C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 06:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344239AbiCUGx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 02:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbiCUGx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 02:53:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE5627E
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 23:52:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r10so19331206wrp.3
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 23:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=xBhccJpWdfx25jKM/oS/e9Oldm0UK/xkDIsDc2dhRlQ=;
        b=TEd6oh2zFKBOfiPpTaw+rqFzWhS1Ql8Cw5m8oSwU/bIPi560sdyc9um2gSRMiareTf
         p7urIFVxpi1fTA5eDVBVxNjhvGbaSldjKyyQdSe6QqHR1n1P8KrXuFzroSj23VLZw6wX
         ZiZPGd+jmuBQ4bxFviHmyLNli3eOZOelGwec542YDoagi+WAItksXQk3jGNLF9IAPonN
         lvGNyOby+ixgjaVpfREzlY9NdXlcyqMBMHi+oHJlDe3Eij755nwYDkVNVsjweKiJIzKh
         1cQYHs8fpy508bVJWQk8Lt/XINgLZKdrcB866C2pDxNPM1TRZmiGNhU9t5MzscudEyeh
         iMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xBhccJpWdfx25jKM/oS/e9Oldm0UK/xkDIsDc2dhRlQ=;
        b=BYROSqet4GRXEvM4T+JDKPbYrJKhzFD1Wo+DuML6V73pHRDxwAO18IN1KbaRpTrSxS
         Kyc0xnAx+fch6ohhq9hjsMuc7tHXyiND9sfBS14SIP5ok1R0m0+4hCcXPweMDz1OpDh6
         lxlgVKINjqkFs3z2iHmr9pFGiRRzvvZl1FG2Ji7naN5nTd58MiT624QQ0V2mZ0w7Dj1s
         UN/WcmR5UiVA+8HE4VhF7LY/HGF6mHLhiXYZRjVcD1tZNFqh8ZS6xesgQwygcHOGJAAi
         nNZmpGlFVpYB8tW4iTw24mIcAvgK1Yr0EqOtnb7rEtBF9lK7sBebX4WXW1SvsgO4VIy+
         SfaA==
X-Gm-Message-State: AOAM530gD2j6VP+xRUdYWkKoN5TGz4k+01WXF0Sao7TXDHe5Vdiwv0q2
        2P9x2Z4s5bDVacAt0Jvya4/LQsC2PIw=
X-Google-Smtp-Source: ABdhPJzxDQVjceF4CFkeG6qvKL8OPJOxHgb7JP1x55fLmbuH/NsA9sWjXwENd58z4uznT6Vy34AzHg==
X-Received: by 2002:a5d:6442:0:b0:203:dff2:866c with SMTP id d2-20020a5d6442000000b00203dff2866cmr16749362wrw.465.1647845517976;
        Sun, 20 Mar 2022 23:51:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0037bdfa1665asm22530765wmj.18.2022.03.20.23.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 23:51:57 -0700 (PDT)
Message-Id: <pull.1182.git.1647845516517.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Mar 2022 06:51:56 +0000
Subject: [PATCH] t3200: fix antipatterns in existing branch tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

Fix issues in t3200 branch tests that, if copied, might catch new
contributors out:

Use test_config to show that config state is not being intentionally
left to spill over into other tests.

Use test_cmp_config instead of git config in subshells, so that
git's error code is not lost if/when an unexpected error occurs.

Use output redirection and later content checking instead of
subshells, so that git's error code is not lost if/when an
unexpected error occurs.

Try to eliminate local-fetch-avoiding optimization as it is
error-prone (it is easy to check the wrong thing), hides segfaults,
and yields only a marginal performance improvement anyway.

Introduce local helper test_set_remote to simplify the common local
pattern of setting up a remote via config.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
    RFC: t3200: fix antipatterns in existing branch tests
    
    This is a cleanup of the branch tests following a case where I was
    adding some, and did substantially the wrong thing by following existing
    examples.
    
    I'm submitting this as RFC because I have a couple of significant
    doubts:
    
     1. Does it make sense to do this? I believe it's a good idea to keep
        things "clean" so that newcomers more easily do the right thing than
        the wrong thing, but on the other hand, I've definitely read that we
        have a "don't change things unnecessarily" bias somewhere.
     2. What's the right pattern for the "(git show-ref -q
        refs/remotes/local/main || git fetch local)" fetch-avoidance
        optimization? Removing it adds a second to test runtimes, but Ævar
        warned it hides segfaults

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1182%2FTaoK%2Fcleanup-t3200-tests-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1182/TaoK/cleanup-t3200-tests-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1182

 t/t3200-branch.sh | 448 ++++++++++++++++++++++------------------------
 1 file changed, 212 insertions(+), 236 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 1bc3795847d..a4cbedd7f04 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -11,6 +11,20 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
+test_set_remote () {
+	test_config "remote.$1.url" "$2" &&
+	test_config "remote.$1.fetch" "${3:-"refs/heads/*:refs/remotes/$1/*"}"
+}
+
+fetch_if_remote_ref_missing () {
+	# this is an anti-pattern: swallows segfault
+	#git show-ref -q "refs/remotes/$2/$1" || git fetch "$2"
+	# this is slightly slower, up to 1s out of 6s on this set of tests:
+	git fetch "$2"
+	# this doesn't work
+	#test_might_fail git show-ref -q "refs/remotes/$2/$1" || git fetch "$2"
+}
+
 test_expect_success 'prepare a trivial repository' '
 	echo Hello >A &&
 	git update-index --add A &&
@@ -372,11 +386,9 @@ EOF
 '
 
 test_expect_success 'git branch with column.*' '
-	git config column.ui column &&
-	git config column.branch "dense" &&
+	test_config column.ui column &&
+	test_config column.branch "dense" &&
 	COLUMNS=80 git branch >actual &&
-	git config --unset column.branch &&
-	git config --unset column.ui &&
 	cat >expect <<\EOF &&
   a/b/c   bam   foo   l   * main   n     o/p   r
   abc     bar   j/k   m/m   mb     o/o   q     topic
@@ -389,9 +401,8 @@ test_expect_success 'git branch --column -v should fail' '
 '
 
 test_expect_success 'git branch -v with column.ui ignored' '
-	git config column.ui column &&
+	test_config column.ui column &&
 	COLUMNS=80 git branch -v | cut -c -8 | sed "s/ *$//" >actual &&
-	git config --unset column.ui &&
 	cat >expect <<\EOF &&
   a/b/c
   abc
@@ -435,7 +446,7 @@ test_expect_success 'git branch -m s/s s should work when s/t is deleted' '
 '
 
 test_expect_success 'config information was renamed, too' '
-	test $(git config branch.s.dummy) = Hello &&
+	test_cmp_config Hello branch.s.dummy &&
 	test_must_fail git config branch.s/s.dummy
 '
 
@@ -493,63 +504,57 @@ test_expect_success 'git branch --copy dumps usage' '
 test_expect_success 'git branch -c d e should work' '
 	git branch --create-reflog d &&
 	git reflog exists refs/heads/d &&
-	git config branch.d.dummy Hello &&
+	test_config branch.d.dummy Hello &&
 	git branch -c d e &&
 	git reflog exists refs/heads/d &&
 	git reflog exists refs/heads/e &&
-	echo Hello >expect &&
-	git config branch.e.dummy >actual &&
-	test_cmp expect actual &&
-	echo Hello >expect &&
-	git config branch.d.dummy >actual &&
-	test_cmp expect actual
+	test_cmp_config Hello branch.e.dummy &&
+	test_cmp_config Hello branch.d.dummy
 '
 
 test_expect_success 'git branch --copy is a synonym for -c' '
 	git branch --create-reflog copy &&
 	git reflog exists refs/heads/copy &&
-	git config branch.copy.dummy Hello &&
+	test_config branch.copy.dummy Hello &&
 	git branch --copy copy copy-to &&
 	git reflog exists refs/heads/copy &&
 	git reflog exists refs/heads/copy-to &&
-	echo Hello >expect &&
-	git config branch.copy.dummy >actual &&
-	test_cmp expect actual &&
-	echo Hello >expect &&
-	git config branch.copy-to.dummy >actual &&
-	test_cmp expect actual
+	test_cmp_config Hello branch.copy.dummy &&
+	test_cmp_config Hello branch.copy-to.dummy
 '
 
 test_expect_success 'git branch -c ee ef should copy ee to create branch ef' '
 	git checkout -b ee &&
 	git reflog exists refs/heads/ee &&
-	git config branch.ee.dummy Hello &&
+	test_config branch.ee.dummy Hello &&
 	git branch -c ee ef &&
 	git reflog exists refs/heads/ee &&
 	git reflog exists refs/heads/ef &&
-	test $(git config branch.ee.dummy) = Hello &&
-	test $(git config branch.ef.dummy) = Hello &&
-	test $(git rev-parse --abbrev-ref HEAD) = ee
+	test_cmp_config Hello branch.ee.dummy &&
+	test_cmp_config Hello branch.ef.dummy &&
+	echo ee >expect &&
+	git rev-parse --abbrev-ref HEAD >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git branch -c f/f g/g should work' '
 	git branch --create-reflog f/f &&
 	git reflog exists refs/heads/f/f &&
-	git config branch.f/f.dummy Hello &&
+	test_config branch.f/f.dummy Hello &&
 	git branch -c f/f g/g &&
 	git reflog exists refs/heads/f/f &&
 	git reflog exists refs/heads/g/g &&
-	test $(git config branch.f/f.dummy) = Hello &&
-	test $(git config branch.g/g.dummy) = Hello
+	test_cmp_config Hello branch.f/f.dummy &&
+	test_cmp_config Hello branch.g/g.dummy
 '
 
 test_expect_success 'git branch -c m2 m2 should work' '
 	git branch --create-reflog m2 &&
 	git reflog exists refs/heads/m2 &&
-	git config branch.m2.dummy Hello &&
+	test_config branch.m2.dummy Hello &&
 	git branch -c m2 m2 &&
 	git reflog exists refs/heads/m2 &&
-	test $(git config branch.m2.dummy) = Hello
+	test_cmp_config Hello branch.m2.dummy
 '
 
 test_expect_success 'git branch -c zz zz/zz should fail' '
@@ -619,15 +624,15 @@ test_expect_success 'git branch -C main5 main5 should work when main is checked
 test_expect_success 'git branch -C ab cd should overwrite existing config for cd' '
 	git branch --create-reflog cd &&
 	git reflog exists refs/heads/cd &&
-	git config branch.cd.dummy CD &&
+	test_config branch.cd.dummy CD &&
 	git branch --create-reflog ab &&
 	git reflog exists refs/heads/ab &&
-	git config branch.ab.dummy AB &&
+	test_config branch.ab.dummy AB &&
 	git branch -C ab cd &&
 	git reflog exists refs/heads/ab &&
 	git reflog exists refs/heads/cd &&
-	test $(git config branch.ab.dummy) = AB &&
-	test $(git config branch.cd.dummy) = AB
+	test_cmp_config AB branch.ab.dummy &&
+	test_cmp_config AB branch.cd.dummy
 '
 
 test_expect_success 'git branch -c correctly copies multiple config sections' '
@@ -761,75 +766,67 @@ test_expect_success SYMLINKS 'git branch -m with symlinked .git/refs' '
 '
 
 test_expect_success 'test tracking setup via --track' '
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	test_set_remote local . &&
+	fetch_if_remote_ref_missing main local &&
 	git branch --track my1 local/main &&
-	test $(git config branch.my1.remote) = local &&
-	test $(git config branch.my1.merge) = refs/heads/main
+	test_cmp_config local branch.my1.remote &&
+	test_cmp_config refs/heads/main branch.my1.merge
 '
 
 test_expect_success 'test tracking setup (non-wildcard, matching)' '
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/main:refs/remotes/local/main &&
-	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	test_set_remote local . refs/heads/main:refs/remotes/local/main &&
+	fetch_if_remote_ref_missing main local &&
 	git branch --track my4 local/main &&
-	test $(git config branch.my4.remote) = local &&
-	test $(git config branch.my4.merge) = refs/heads/main
+	test_cmp_config local branch.my4.remote &&
+	test_cmp_config refs/heads/main branch.my4.merge
 '
 
 test_expect_success 'tracking setup fails on non-matching refspec' '
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/main || git fetch local) &&
-	git config remote.local.fetch refs/heads/s:refs/remotes/local/s &&
+	test_set_remote local . &&
+	fetch_if_remote_ref_missing main local &&
+	test_config remote.local.fetch refs/heads/s:refs/remotes/local/s &&
 	test_must_fail git branch --track my5 local/main &&
 	test_must_fail git config branch.my5.remote &&
 	test_must_fail git config branch.my5.merge
 '
 
 test_expect_success 'test tracking setup via config' '
-	git config branch.autosetupmerge true &&
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	test_config branch.autosetupmerge true &&
+	test_set_remote local . &&
+	fetch_if_remote_ref_missing main local &&
 	git branch my3 local/main &&
-	test $(git config branch.my3.remote) = local &&
-	test $(git config branch.my3.merge) = refs/heads/main
+	test_cmp_config local branch.my3.remote &&
+	test_cmp_config refs/heads/main branch.my3.merge
 '
 
 test_expect_success 'test overriding tracking setup via --no-track' '
-	git config branch.autosetupmerge true &&
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	test_config branch.autosetupmerge true &&
+	test_set_remote local . &&
+	fetch_if_remote_ref_missing main local &&
 	git branch --no-track my2 local/main &&
-	git config branch.autosetupmerge false &&
-	! test "$(git config branch.my2.remote)" = local &&
-	! test "$(git config branch.my2.merge)" = refs/heads/main
+	! test_cmp_config local branch.my2.remote &&
+	! test_cmp_config refs/heads/main branch.my2.merge
 '
 
 test_expect_success 'no tracking without .fetch entries' '
-	git config branch.autosetupmerge true &&
+	test_config branch.autosetupmerge true &&
 	git branch my6 s &&
-	git config branch.autosetupmerge false &&
-	test -z "$(git config branch.my6.remote)" &&
-	test -z "$(git config branch.my6.merge)"
+	test_cmp_config "" --default "" branch.my6.remote &&
+	test_cmp_config "" --default "" branch.my6.merge
 '
 
 test_expect_success 'test tracking setup via --track but deeper' '
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/o/o || git fetch local) &&
+	test_set_remote local . &&
+	fetch_if_remote_ref_missing o/o local &&
 	git branch --track my7 local/o/o &&
-	test "$(git config branch.my7.remote)" = local &&
-	test "$(git config branch.my7.merge)" = refs/heads/o/o
+	test_cmp_config local branch.my7.remote &&
+	test_cmp_config refs/heads/o/o branch.my7.merge
 '
 
 test_expect_success 'test deleting branch deletes branch config' '
 	git branch -d my7 &&
-	test -z "$(git config branch.my7.remote)" &&
-	test -z "$(git config branch.my7.merge)"
+	test_cmp_config "" --default "" branch.my7.remote &&
+	test_cmp_config "" --default "" branch.my7.merge
 '
 
 test_expect_success 'test deleting branch without config' '
@@ -850,14 +847,15 @@ test_expect_success 'deleting currently checked out branch fails' '
 
 test_expect_success 'test --track without .fetch entries' '
 	git branch --track my8 &&
-	test "$(git config branch.my8.remote)" &&
-	test "$(git config branch.my8.merge)"
+	git config branch.my8.remote >out &&
+	test -s out &&
+	git config branch.my8.merge >out &&
+	test -s out
 '
 
 test_expect_success 'branch from non-branch HEAD w/autosetupmerge=always' '
-	git config branch.autosetupmerge always &&
-	git branch my9 HEAD^ &&
-	git config branch.autosetupmerge false
+	test_config branch.autosetupmerge always &&
+	git branch my9 HEAD^
 '
 
 test_expect_success 'branch from non-branch HEAD w/--track causes failure' '
@@ -913,16 +911,16 @@ test_expect_success 'use --set-upstream-to modify HEAD' '
 	test_config branch.main.merge foo &&
 	git branch my12 &&
 	git branch --set-upstream-to my12 &&
-	test "$(git config branch.main.remote)" = "." &&
-	test "$(git config branch.main.merge)" = "refs/heads/my12"
+	test_cmp_config "." branch.main.remote &&
+	test_cmp_config "refs/heads/my12" branch.main.merge
 '
 
 test_expect_success 'use --set-upstream-to modify a particular branch' '
 	git branch my13 &&
 	git branch --set-upstream-to main my13 &&
 	test_when_finished "git branch --unset-upstream my13" &&
-	test "$(git config branch.my13.remote)" = "." &&
-	test "$(git config branch.my13.merge)" = "refs/heads/main"
+	test_cmp_config "." branch.my13.remote &&
+	test_cmp_config "refs/heads/main" branch.my13.merge
 '
 
 test_expect_success '--unset-upstream should fail if given a non-existent branch' '
@@ -1003,273 +1001,251 @@ test_expect_success 'git checkout -b g/h/i -l should create a branch and a log'
 
 test_expect_success 'checkout -b makes reflog by default' '
 	git checkout main &&
-	git config --unset core.logAllRefUpdates &&
+	test_unconfig core.logAllRefUpdates &&
 	git checkout -b alpha &&
 	git rev-parse --verify alpha@{0}
 '
 
 test_expect_success 'checkout -b does not make reflog when core.logAllRefUpdates = false' '
 	git checkout main &&
-	git config core.logAllRefUpdates false &&
+	test_config core.logAllRefUpdates false &&
 	git checkout -b beta &&
 	test_must_fail git rev-parse --verify beta@{0}
 '
 
 test_expect_success 'checkout -b with -l makes reflog when core.logAllRefUpdates = false' '
 	git checkout main &&
+	test_config core.logAllRefUpdates false &&
 	git checkout -lb gamma &&
-	git config --unset core.logAllRefUpdates &&
 	git rev-parse --verify gamma@{0}
 '
 
 test_expect_success 'avoid ambiguous track' '
-	git config branch.autosetupmerge true &&
-	git config remote.ambi1.url lalala &&
-	git config remote.ambi1.fetch refs/heads/lalala:refs/heads/main &&
-	git config remote.ambi2.url lilili &&
-	git config remote.ambi2.fetch refs/heads/lilili:refs/heads/main &&
+	test_config branch.autosetupmerge true &&
+	test_set_remote ambi1 lalala refs/heads/lalala:refs/heads/main &&
+	test_set_remote ambi2 lilili refs/heads/lilili:refs/heads/main &&
 	test_must_fail git branch all1 main &&
-	test -z "$(git config branch.all1.merge)"
+	test_cmp_config "" --default "" branch.all1.merge
 '
 
 test_expect_success 'autosetuprebase local on a tracked local branch' '
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase local &&
-	(git show-ref -q refs/remotes/local/o || git fetch local) &&
+	test_set_remote local . &&
+	test_config branch.autosetuprebase local &&
+	fetch_if_remote_ref_missing o local &&
 	git branch mybase &&
 	git branch --track myr1 mybase &&
-	test "$(git config branch.myr1.remote)" = . &&
-	test "$(git config branch.myr1.merge)" = refs/heads/mybase &&
-	test "$(git config branch.myr1.rebase)" = true
+	test_cmp_config . branch.myr1.remote &&
+	test_cmp_config refs/heads/mybase branch.myr1.merge &&
+	test_cmp_config true branch.myr1.rebase
 '
 
 test_expect_success 'autosetuprebase always on a tracked local branch' '
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase always &&
-	(git show-ref -q refs/remotes/local/o || git fetch local) &&
+	test_set_remote local . &&
+	test_config branch.autosetuprebase always &&
+	fetch_if_remote_ref_missing o local &&
 	git branch mybase2 &&
 	git branch --track myr2 mybase &&
-	test "$(git config branch.myr2.remote)" = . &&
-	test "$(git config branch.myr2.merge)" = refs/heads/mybase &&
-	test "$(git config branch.myr2.rebase)" = true
+	test_cmp_config . branch.myr2.remote &&
+	test_cmp_config refs/heads/mybase branch.myr2.merge &&
+	test_cmp_config true branch.myr2.rebase
 '
 
 test_expect_success 'autosetuprebase remote on a tracked local branch' '
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase remote &&
-	(git show-ref -q refs/remotes/local/o || git fetch local) &&
+	test_set_remote local . &&
+	test_config branch.autosetuprebase remote &&
+	fetch_if_remote_ref_missing o local &&
 	git branch mybase3 &&
 	git branch --track myr3 mybase2 &&
-	test "$(git config branch.myr3.remote)" = . &&
-	test "$(git config branch.myr3.merge)" = refs/heads/mybase2 &&
-	! test "$(git config branch.myr3.rebase)" = true
+	test_cmp_config . branch.myr3.remote &&
+	test_cmp_config refs/heads/mybase2 branch.myr3.merge &&
+	! test_cmp_config true branch.myr3.rebase
 '
 
 test_expect_success 'autosetuprebase never on a tracked local branch' '
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase never &&
-	(git show-ref -q refs/remotes/local/o || git fetch local) &&
+	test_set_remote local . &&
+	test_config branch.autosetuprebase never &&
+	fetch_if_remote_ref_missing o local &&
 	git branch mybase4 &&
 	git branch --track myr4 mybase2 &&
-	test "$(git config branch.myr4.remote)" = . &&
-	test "$(git config branch.myr4.merge)" = refs/heads/mybase2 &&
-	! test "$(git config branch.myr4.rebase)" = true
+	test_cmp_config . branch.myr4.remote &&
+	test_cmp_config refs/heads/mybase2 branch.myr4.merge &&
+	! test_cmp_config true branch.myr4.rebase
 '
 
 test_expect_success 'autosetuprebase local on a tracked remote branch' '
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase local &&
-	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	test_set_remote local . &&
+	test_config branch.autosetuprebase local &&
+	fetch_if_remote_ref_missing main local &&
 	git branch --track myr5 local/main &&
-	test "$(git config branch.myr5.remote)" = local &&
-	test "$(git config branch.myr5.merge)" = refs/heads/main &&
-	! test "$(git config branch.myr5.rebase)" = true
+	test_cmp_config local branch.myr5.remote &&
+	test_cmp_config refs/heads/main branch.myr5.merge &&
+	! test_cmp_config true branch.myr5.rebase
 '
 
 test_expect_success 'autosetuprebase never on a tracked remote branch' '
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase never &&
-	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	test_set_remote local . &&
+	test_config branch.autosetuprebase never &&
+	fetch_if_remote_ref_missing main local &&
 	git branch --track myr6 local/main &&
-	test "$(git config branch.myr6.remote)" = local &&
-	test "$(git config branch.myr6.merge)" = refs/heads/main &&
-	! test "$(git config branch.myr6.rebase)" = true
+	test_cmp_config local branch.myr6.remote &&
+	test_cmp_config refs/heads/main branch.myr6.merge &&
+	! test_cmp_config true branch.myr6.rebase
 '
 
 test_expect_success 'autosetuprebase remote on a tracked remote branch' '
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase remote &&
-	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	test_set_remote local . &&
+	test_config branch.autosetuprebase remote &&
+	fetch_if_remote_ref_missing main local &&
 	git branch --track myr7 local/main &&
-	test "$(git config branch.myr7.remote)" = local &&
-	test "$(git config branch.myr7.merge)" = refs/heads/main &&
-	test "$(git config branch.myr7.rebase)" = true
+	test_cmp_config local branch.myr7.remote &&
+	test_cmp_config refs/heads/main branch.myr7.merge &&
+	test_cmp_config true branch.myr7.rebase
 '
 
 test_expect_success 'autosetuprebase always on a tracked remote branch' '
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase remote &&
-	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	test_set_remote local . &&
+	test_config branch.autosetuprebase remote &&
+	fetch_if_remote_ref_missing main local &&
 	git branch --track myr8 local/main &&
-	test "$(git config branch.myr8.remote)" = local &&
-	test "$(git config branch.myr8.merge)" = refs/heads/main &&
-	test "$(git config branch.myr8.rebase)" = true
+	test_cmp_config local branch.myr8.remote &&
+	test_cmp_config refs/heads/main branch.myr8.merge &&
+	test_cmp_config true branch.myr8.rebase
 '
 
 test_expect_success 'autosetuprebase unconfigured on a tracked remote branch' '
-	git config --unset branch.autosetuprebase &&
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	test_unconfig branch.autosetuprebase &&
+	test_set_remote local . &&
+	fetch_if_remote_ref_missing main local &&
 	git branch --track myr9 local/main &&
-	test "$(git config branch.myr9.remote)" = local &&
-	test "$(git config branch.myr9.merge)" = refs/heads/main &&
-	test "z$(git config branch.myr9.rebase)" = z
+	test_cmp_config local branch.myr9.remote &&
+	test_cmp_config refs/heads/main branch.myr9.merge &&
+	test_cmp_config "" --default "" branch.myr9.rebase
 '
 
 test_expect_success 'autosetuprebase unconfigured on a tracked local branch' '
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/o || git fetch local) &&
+	test_set_remote local . &&
+	fetch_if_remote_ref_missing o local &&
 	git branch mybase10 &&
 	git branch --track myr10 mybase2 &&
-	test "$(git config branch.myr10.remote)" = . &&
-	test "$(git config branch.myr10.merge)" = refs/heads/mybase2 &&
-	test "z$(git config branch.myr10.rebase)" = z
+	test_cmp_config . branch.myr10.remote &&
+	test_cmp_config refs/heads/mybase2 branch.myr10.merge &&
+	test_cmp_config "" --default "" branch.myr10.rebase
 '
 
 test_expect_success 'autosetuprebase unconfigured on untracked local branch' '
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	test_set_remote local . &&
+	fetch_if_remote_ref_missing main local &&
 	git branch --no-track myr11 mybase2 &&
-	test "z$(git config branch.myr11.remote)" = z &&
-	test "z$(git config branch.myr11.merge)" = z &&
-	test "z$(git config branch.myr11.rebase)" = z
+	test_cmp_config "" --default "" branch.myr11.remote &&
+	test_cmp_config "" --default "" branch.myr11.merge &&
+	test_cmp_config "" --default "" branch.myr11.rebase
 '
 
 test_expect_success 'autosetuprebase unconfigured on untracked remote branch' '
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	test_set_remote local . &&
+	fetch_if_remote_ref_missing main local &&
 	git branch --no-track myr12 local/main &&
-	test "z$(git config branch.myr12.remote)" = z &&
-	test "z$(git config branch.myr12.merge)" = z &&
-	test "z$(git config branch.myr12.rebase)" = z
+	test_cmp_config "" --default "" branch.myr12.remote &&
+	test_cmp_config "" --default "" branch.myr12.merge &&
+	test_cmp_config "" --default "" branch.myr12.rebase
 '
 
 test_expect_success 'autosetuprebase never on an untracked local branch' '
-	git config branch.autosetuprebase never &&
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	test_config branch.autosetuprebase never &&
+	test_set_remote local . &&
+	fetch_if_remote_ref_missing main local &&
 	git branch --no-track myr13 mybase2 &&
-	test "z$(git config branch.myr13.remote)" = z &&
-	test "z$(git config branch.myr13.merge)" = z &&
-	test "z$(git config branch.myr13.rebase)" = z
+	test_cmp_config "" --default "" branch.myr13.remote &&
+	test_cmp_config "" --default "" branch.myr13.merge &&
+	test_cmp_config "" --default "" branch.myr13.rebase
 '
 
 test_expect_success 'autosetuprebase local on an untracked local branch' '
-	git config branch.autosetuprebase local &&
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	test_config branch.autosetuprebase local &&
+	test_set_remote local . &&
+	fetch_if_remote_ref_missing main local &&
 	git branch --no-track myr14 mybase2 &&
-	test "z$(git config branch.myr14.remote)" = z &&
-	test "z$(git config branch.myr14.merge)" = z &&
-	test "z$(git config branch.myr14.rebase)" = z
+	test_cmp_config "" --default "" branch.myr14.remote &&
+	test_cmp_config "" --default "" branch.myr14.merge &&
+	test_cmp_config "" --default "" branch.myr14.rebase
 '
 
 test_expect_success 'autosetuprebase remote on an untracked local branch' '
-	git config branch.autosetuprebase remote &&
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	test_config branch.autosetuprebase remote &&
+	test_set_remote local . &&
+	fetch_if_remote_ref_missing main local &&
 	git branch --no-track myr15 mybase2 &&
-	test "z$(git config branch.myr15.remote)" = z &&
-	test "z$(git config branch.myr15.merge)" = z &&
-	test "z$(git config branch.myr15.rebase)" = z
+	test_cmp_config "" --default "" branch.myr15.remote &&
+	test_cmp_config "" --default "" branch.myr15.merge &&
+	test_cmp_config "" --default "" branch.myr15.rebase
 '
 
 test_expect_success 'autosetuprebase always on an untracked local branch' '
-	git config branch.autosetuprebase always &&
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	test_config branch.autosetuprebase always &&
+	test_set_remote local . &&
+	fetch_if_remote_ref_missing main local &&
 	git branch --no-track myr16 mybase2 &&
-	test "z$(git config branch.myr16.remote)" = z &&
-	test "z$(git config branch.myr16.merge)" = z &&
-	test "z$(git config branch.myr16.rebase)" = z
+	test_cmp_config "" --default "" branch.myr16.remote &&
+	test_cmp_config "" --default "" branch.myr16.merge &&
+	test_cmp_config "" --default "" branch.myr16.rebase
 '
 
 test_expect_success 'autosetuprebase never on an untracked remote branch' '
-	git config branch.autosetuprebase never &&
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	test_config branch.autosetuprebase never &&
+	test_set_remote local . &&
+	fetch_if_remote_ref_missing main local &&
 	git branch --no-track myr17 local/main &&
-	test "z$(git config branch.myr17.remote)" = z &&
-	test "z$(git config branch.myr17.merge)" = z &&
-	test "z$(git config branch.myr17.rebase)" = z
+	test_cmp_config "" --default "" branch.myr17.remote &&
+	test_cmp_config "" --default "" branch.myr17.merge &&
+	test_cmp_config "" --default "" branch.myr17.rebase
 '
 
 test_expect_success 'autosetuprebase local on an untracked remote branch' '
-	git config branch.autosetuprebase local &&
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	test_config branch.autosetuprebase local &&
+	test_set_remote local . &&
+	fetch_if_remote_ref_missing main local &&
 	git branch --no-track myr18 local/main &&
-	test "z$(git config branch.myr18.remote)" = z &&
-	test "z$(git config branch.myr18.merge)" = z &&
-	test "z$(git config branch.myr18.rebase)" = z
+	test_cmp_config "" --default "" branch.myr18.remote &&
+	test_cmp_config "" --default "" branch.myr18.merge &&
+	test_cmp_config "" --default "" branch.myr18.rebase
 '
 
 test_expect_success 'autosetuprebase remote on an untracked remote branch' '
-	git config branch.autosetuprebase remote &&
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	test_config branch.autosetuprebase remote &&
+	test_set_remote local . &&
+	fetch_if_remote_ref_missing main local &&
 	git branch --no-track myr19 local/main &&
-	test "z$(git config branch.myr19.remote)" = z &&
-	test "z$(git config branch.myr19.merge)" = z &&
-	test "z$(git config branch.myr19.rebase)" = z
+	test_cmp_config "" --default "" branch.myr19.remote &&
+	test_cmp_config "" --default "" branch.myr19.merge &&
+	test_cmp_config "" --default "" branch.myr19.rebase
 '
 
 test_expect_success 'autosetuprebase always on an untracked remote branch' '
-	git config branch.autosetuprebase always &&
-	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	test_config branch.autosetuprebase always &&
+	test_set_remote local . &&
+	fetch_if_remote_ref_missing main local &&
 	git branch --no-track myr20 local/main &&
-	test "z$(git config branch.myr20.remote)" = z &&
-	test "z$(git config branch.myr20.merge)" = z &&
-	test "z$(git config branch.myr20.rebase)" = z
+	test_cmp_config "" --default "" branch.myr20.remote &&
+	test_cmp_config "" --default "" branch.myr20.merge &&
+	test_cmp_config "" --default "" branch.myr20.rebase
 '
 
 test_expect_success 'autosetuprebase always on detached HEAD' '
-	git config branch.autosetupmerge always &&
+	test_config branch.autosetupmerge always &&
 	test_when_finished git checkout main &&
 	git checkout HEAD^0 &&
 	git branch my11 &&
-	test -z "$(git config branch.my11.remote)" &&
-	test -z "$(git config branch.my11.merge)"
+	test_cmp_config "" --default "" branch.my11.remote &&
+	test_cmp_config "" --default "" branch.my11.rebase
 '
 
 test_expect_success 'detect misconfigured autosetuprebase (bad value)' '
-	git config branch.autosetuprebase garbage &&
+	test_config branch.autosetuprebase garbage &&
 	test_must_fail git branch
 '
 
 test_expect_success 'detect misconfigured autosetuprebase (no value)' '
-	git config --unset branch.autosetuprebase &&
+	test_unconfig branch.autosetuprebase &&
 	echo "[branch] autosetuprebase" >>.git/config &&
 	test_must_fail git branch &&
 	git config --unset branch.autosetuprebase
@@ -1277,7 +1253,7 @@ test_expect_success 'detect misconfigured autosetuprebase (no value)' '
 
 test_expect_success 'attempt to delete a branch without base and unmerged to HEAD' '
 	git checkout my9 &&
-	git config --unset branch.my8.merge &&
+	test_unconfig branch.my8.merge &&
 	test_must_fail git branch -d my8
 '
 
@@ -1285,7 +1261,7 @@ test_expect_success 'attempt to delete a branch merged to its base' '
 	# we are on my9 which is the initial commit; traditionally
 	# we would not have allowed deleting my8 that is not merged
 	# to my9, but it is set to track main that already has my8
-	git config branch.my8.merge refs/heads/main &&
+	test_config branch.my8.merge refs/heads/main &&
 	git branch -d my8
 '
 
@@ -1397,8 +1373,8 @@ test_expect_success 'tracking with unexpected .fetch refspec' '
 		git config remote.c.fetch "+refs/remotes/*:refs/remotes/*" &&
 		git fetch c &&
 		git branch --track local/a/main remotes/a/main &&
-		test "$(git config branch.local/a/main.remote)" = "c" &&
-		test "$(git config branch.local/a/main.merge)" = "refs/remotes/a/main" &&
+		test_cmp_config "c" branch.local/a/main.remote &&
+		test_cmp_config "refs/remotes/a/main" branch.local/a/main.merge &&
 		git rev-parse --verify a >expect &&
 		git rev-parse --verify local/a/main >actual &&
 		test_cmp expect actual

base-commit: 4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a
-- 
gitgitgadget
