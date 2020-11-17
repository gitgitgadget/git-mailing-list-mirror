Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEED4C63798
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8520124655
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay31ABQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgKQQMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 11:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgKQQMg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 11:12:36 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5849AC0617A6
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:35 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j7so23732200wrp.3
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OxH17uSWJ/QORey+01gkJHWf0z+LwRN7YeXNVNthbl8=;
        b=Ay31ABQK++Uaj9CJ79JjN9t9V1GM7v242geI7fwpCtB+A7hjVu+IGDyfEcMgS6+Det
         RD7oasHCgEcyP+CDVOXBIuzrPcN2brvonyYn02sw+L5EMRxXnnnC08tvKfNn4Rub5WkV
         pQNspZyQFxPlnFHNyZCt8VcXd+mnpPE+zvFIOdFpImb5jk03KaWxHBaoI5YNl1ssJmIe
         hqRZt27w6nSwT8pnSN/EzVDc/TX9TNsX1aCHZCIs3o9NW0crhQ5p0/c3tDQFs3b2Tleo
         bO792LO7YnDDNPKSO54t4NpH0LA5sjV+qJRxOaQEhH7cEVCAFvoBKvRo3xZrtFbPipMy
         Yt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OxH17uSWJ/QORey+01gkJHWf0z+LwRN7YeXNVNthbl8=;
        b=KCrznEm/pFAWR/EXO/rAAQ6onKH6mq81at57tyDCpIxadN0Z5EuGuHUYpfpPtGc8cg
         J6uL8ay5X1e1IptmPQCv+41LWDbEM8cKlC4lO6NlsDJCbyso+9Aw0Iyd3H/Zd4iqt1CK
         0MOnkVVRRtr72d6XzaRkdGyuELRvSAaFnstI/Fyr2dMem5FRX1WmgiPGNsSJNTZDeeqS
         4VDtyx0qUL2ZR3RPJ1AJQsU1fGmKtZIIIUpQhCE/kJTqvRu8BSfLdH70ZAbVN3MlTSRm
         VZV0QMPxUVtOfHF6MqLBktyPkg9JVeFiyCmarpinbSiJvNii0IukKLxIi+uCdVUp7gft
         OoTQ==
X-Gm-Message-State: AOAM531EWx5DCrD6pw/40QB9Glv9N/TsiwXV17V7JgRZZ68kaEjjsEgp
        LqR4ExzfWNgDRZM5fuqeIpI4uu0YG98=
X-Google-Smtp-Source: ABdhPJxSNKmtlURQc5Ppi5KOXUoe6pJXZrWF6+lZc5ZjmL0bVtz7JMMQbTqSVdF+TrAH4hlWxnhb+w==
X-Received: by 2002:adf:de05:: with SMTP id b5mr236085wrm.131.1605629553070;
        Tue, 17 Nov 2020 08:12:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i11sm29168713wro.85.2020.11.17.08.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 08:12:32 -0800 (PST)
Message-Id: <0d4f1275f745f90a1ea007dfc82510f0040ab4a0.1605629548.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Nov 2020 16:12:03 +0000
Subject: [PATCH v2 03/27] t2*: adjust the references to the default branch
 name "main"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This trick was performed via

	$ (cd t &&
	   sed -i -e 's/master/main/g' -e 's/MASTER/MAIN/g' \
		-e 's/Master/Main/g' -- t2*.sh)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t2007-checkout-symlink.sh              | 10 ++--
 t/t2009-checkout-statinfo.sh             |  8 +--
 t/t2010-checkout-ambiguous.sh            |  4 +-
 t/t2011-checkout-invalid-head.sh         | 16 +++---
 t/t2012-checkout-last.sh                 | 48 ++++++++--------
 t/t2015-checkout-unborn.sh               |  2 +-
 t/t2017-checkout-orphan.sh               | 44 +++++++--------
 t/t2020-checkout-detach.sh               | 28 +++++-----
 t/t2022-checkout-paths.sh                | 22 ++++----
 t/t2023-checkout-m.sh                    | 10 ++--
 t/t2024-checkout-dwim.sh                 | 70 ++++++++++++------------
 t/t2027-checkout-track.sh                |  6 +-
 t/t2030-unresolve-info.sh                |  6 +-
 t/t2060-switch.sh                        | 30 +++++-----
 t/t2070-restore.sh                       |  4 +-
 t/t2106-update-index-assume-unchanged.sh |  2 +-
 t/t2400-worktree-add.sh                  | 66 +++++++++++-----------
 t/t2401-worktree-prune.sh                |  2 +-
 t/t2402-worktree-list.sh                 | 20 +++----
 t/t2405-worktree-submodule.sh            |  6 +-
 t/test-lib.sh                            |  2 +-
 21 files changed, 203 insertions(+), 203 deletions(-)

diff --git a/t/t2007-checkout-symlink.sh b/t/t2007-checkout-symlink.sh
index fc9aad530e..d6468ad8f3 100755
--- a/t/t2007-checkout-symlink.sh
+++ b/t/t2007-checkout-symlink.sh
@@ -12,14 +12,14 @@ test_expect_success setup '
 	echo hello >frotz/filfre &&
 	git add frotz/filfre &&
 	test_tick &&
-	git commit -m "master has file frotz/filfre" &&
+	git commit -m "main has file frotz/filfre" &&
 
 	git branch side &&
 
 	echo goodbye >nitfol &&
 	git add nitfol &&
 	test_tick &&
-	git commit -m "master adds file nitfol" &&
+	git commit -m "main adds file nitfol" &&
 
 	git checkout side &&
 
@@ -34,13 +34,13 @@ test_expect_success setup '
 
 test_expect_success 'switch from symlink to dir' '
 
-	git checkout master
+	git checkout main
 
 '
 
-test_expect_success 'Remove temporary directories & switch to master' '
+test_expect_success 'Remove temporary directories & switch to main' '
 	rm -fr frotz xyzzy nitfol &&
-	git checkout -f master
+	git checkout -f main
 '
 
 test_expect_success 'switch from dir to symlink' '
diff --git a/t/t2009-checkout-statinfo.sh b/t/t2009-checkout-statinfo.sh
index f3c2152087..91940f3c60 100755
--- a/t/t2009-checkout-statinfo.sh
+++ b/t/t2009-checkout-statinfo.sh
@@ -21,13 +21,13 @@ test_expect_success 'branch switching' '
 	git reset --hard &&
 	test "$(git diff-files --raw)" = "" &&
 
-	git checkout master &&
+	git checkout main &&
 	test "$(git diff-files --raw)" = "" &&
 
 	git checkout side &&
 	test "$(git diff-files --raw)" = "" &&
 
-	git checkout master &&
+	git checkout main &&
 	test "$(git diff-files --raw)" = ""
 
 '
@@ -37,13 +37,13 @@ test_expect_success 'path checkout' '
 	git reset --hard &&
 	test "$(git diff-files --raw)" = "" &&
 
-	git checkout master world &&
+	git checkout main world &&
 	test "$(git diff-files --raw)" = "" &&
 
 	git checkout side world &&
 	test "$(git diff-files --raw)" = "" &&
 
-	git checkout master world &&
+	git checkout main world &&
 	test "$(git diff-files --raw)" = ""
 
 '
diff --git a/t/t2010-checkout-ambiguous.sh b/t/t2010-checkout-ambiguous.sh
index 2e47fe01cf..64395479e8 100755
--- a/t/t2010-checkout-ambiguous.sh
+++ b/t/t2010-checkout-ambiguous.sh
@@ -17,7 +17,7 @@ test_expect_success 'reference must be a tree' '
 '
 
 test_expect_success 'branch switching' '
-	test "refs/heads/master" = "$(git symbolic-ref HEAD)" &&
+	test "refs/heads/main" = "$(git symbolic-ref HEAD)" &&
 	git checkout world -- &&
 	test "refs/heads/world" = "$(git symbolic-ref HEAD)"
 '
@@ -57,7 +57,7 @@ test_expect_success 'disambiguate checking out from a tree-ish' '
 '
 
 test_expect_success 'accurate error message with more than one ref' '
-	test_must_fail git checkout HEAD master -- 2>actual &&
+	test_must_fail git checkout HEAD main -- 2>actual &&
 	test_i18ngrep 2 actual &&
 	test_i18ngrep "one reference expected, 2 given" actual
 '
diff --git a/t/t2011-checkout-invalid-head.sh b/t/t2011-checkout-invalid-head.sh
index 0e8d56aa76..d92f8582ea 100755
--- a/t/t2011-checkout-invalid-head.sh
+++ b/t/t2011-checkout-invalid-head.sh
@@ -11,12 +11,12 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'checkout should not start branch from a tree' '
-	test_must_fail git checkout -b newbranch master^{tree}
+	test_must_fail git checkout -b newbranch main^{tree}
 '
 
-test_expect_success 'checkout master from invalid HEAD' '
+test_expect_success 'checkout main from invalid HEAD' '
 	echo $ZERO_OID >.git/HEAD &&
-	git checkout master --
+	git checkout main --
 '
 
 test_expect_success 'checkout notices failure to lock HEAD' '
@@ -26,7 +26,7 @@ test_expect_success 'checkout notices failure to lock HEAD' '
 '
 
 test_expect_success 'create ref directory/file conflict scenario' '
-	git update-ref refs/heads/outer/inner master &&
+	git update-ref refs/heads/outer/inner main &&
 
 	# do not rely on symbolic-ref to get a known state,
 	# as it may use the same code we are testing
@@ -37,12 +37,12 @@ test_expect_success 'create ref directory/file conflict scenario' '
 
 test_expect_success 'checkout away from d/f HEAD (unpacked, to branch)' '
 	reset_to_df &&
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'checkout away from d/f HEAD (unpacked, to detached)' '
 	reset_to_df &&
-	git checkout --detach master
+	git checkout --detach main
 '
 
 test_expect_success 'pack refs' '
@@ -51,11 +51,11 @@ test_expect_success 'pack refs' '
 
 test_expect_success 'checkout away from d/f HEAD (packed, to branch)' '
 	reset_to_df &&
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'checkout away from d/f HEAD (packed, to detached)' '
 	reset_to_df &&
-	git checkout --detach master
+	git checkout --detach main
 '
 test_done
diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
index e7ba8c505f..7a126337ca 100755
--- a/t/t2012-checkout-last.sh
+++ b/t/t2012-checkout-last.sh
@@ -24,7 +24,7 @@ test_expect_success 'first branch switch' '
 
 test_expect_success '"checkout -" switches back' '
 	git checkout - &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/main"
 '
 
 test_expect_success '"checkout -" switches forth' '
@@ -98,56 +98,56 @@ test_expect_success 'merge base test setup' '
 	git commit -m third
 '
 
-test_expect_success 'another...master' '
+test_expect_success 'another...main' '
 	git checkout another &&
-	git checkout another...master &&
-	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify master^)"
+	git checkout another...main &&
+	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify main^)"
 '
 
-test_expect_success '...master' '
+test_expect_success '...main' '
 	git checkout another &&
-	git checkout ...master &&
-	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify master^)"
+	git checkout ...main &&
+	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify main^)"
 '
 
-test_expect_success 'master...' '
+test_expect_success 'main...' '
 	git checkout another &&
-	git checkout master... &&
-	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify master^)"
+	git checkout main... &&
+	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify main^)"
 '
 
 test_expect_success '"checkout -" works after a rebase A' '
-	git checkout master &&
+	git checkout main &&
 	git checkout other &&
-	git rebase master &&
+	git rebase main &&
 	git checkout - &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/main"
 '
 
 test_expect_success '"checkout -" works after a rebase A B' '
-	git branch moodle master~1 &&
-	git checkout master &&
+	git branch moodle main~1 &&
+	git checkout main &&
 	git checkout other &&
-	git rebase master moodle &&
+	git rebase main moodle &&
 	git checkout - &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/main"
 '
 
 test_expect_success '"checkout -" works after a rebase -i A' '
-	git checkout master &&
+	git checkout main &&
 	git checkout other &&
-	git rebase -i master &&
+	git rebase -i main &&
 	git checkout - &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/main"
 '
 
 test_expect_success '"checkout -" works after a rebase -i A B' '
-	git branch foodle master~1 &&
-	git checkout master &&
+	git branch foodle main~1 &&
+	git checkout main &&
 	git checkout other &&
-	git rebase master foodle &&
+	git rebase main foodle &&
 	git checkout - &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/main"
 '
 
 test_done
diff --git a/t/t2015-checkout-unborn.sh b/t/t2015-checkout-unborn.sh
index 37bdcedcc9..2b3e6dc27e 100755
--- a/t/t2015-checkout-unborn.sh
+++ b/t/t2015-checkout-unborn.sh
@@ -11,7 +11,7 @@ test_expect_success 'setup' '
 	 git add file &&
 	 git commit -m base
 	) &&
-	git fetch parent master:origin
+	git fetch parent main:origin
 '
 
 test_expect_success 'checkout from unborn preserves untracked files' '
diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
index 655f278c5f..e2ce29c8e7 100755
--- a/t/t2017-checkout-orphan.sh
+++ b/t/t2017-checkout-orphan.sh
@@ -29,34 +29,34 @@ test_expect_success '--orphan creates a new orphan branch from HEAD' '
 	test_tick &&
 	git commit -m "Third Commit" &&
 	test_must_fail git rev-parse --verify HEAD^ &&
-	git diff-tree --quiet master alpha
+	git diff-tree --quiet main alpha
 '
 
 test_expect_success '--orphan creates a new orphan branch from <start_point>' '
-	git checkout master &&
-	git checkout --orphan beta master^ &&
+	git checkout main &&
+	git checkout --orphan beta main^ &&
 	test_must_fail git rev-parse --verify HEAD &&
 	test "refs/heads/beta" = "$(git symbolic-ref HEAD)" &&
 	test_tick &&
 	git commit -m "Fourth Commit" &&
 	test_must_fail git rev-parse --verify HEAD^ &&
-	git diff-tree --quiet master^ beta
+	git diff-tree --quiet main^ beta
 '
 
 test_expect_success '--orphan must be rejected with -b' '
-	git checkout master &&
+	git checkout main &&
 	test_must_fail git checkout --orphan new -b newer &&
-	test refs/heads/master = "$(git symbolic-ref HEAD)"
+	test refs/heads/main = "$(git symbolic-ref HEAD)"
 '
 
 test_expect_success '--orphan must be rejected with -t' '
-	git checkout master &&
-	test_must_fail git checkout --orphan new -t master &&
-	test refs/heads/master = "$(git symbolic-ref HEAD)"
+	git checkout main &&
+	test_must_fail git checkout --orphan new -t main &&
+	test refs/heads/main = "$(git symbolic-ref HEAD)"
 '
 
 test_expect_success '--orphan ignores branch.autosetupmerge' '
-	git checkout master &&
+	git checkout main &&
 	git config branch.autosetupmerge always &&
 	git checkout --orphan gamma &&
 	test -z "$(git config branch.gamma.merge)" &&
@@ -65,7 +65,7 @@ test_expect_success '--orphan ignores branch.autosetupmerge' '
 '
 
 test_expect_success '--orphan makes reflog by default' '
-	git checkout master &&
+	git checkout main &&
 	git config --unset core.logAllRefUpdates &&
 	git checkout --orphan delta &&
 	test_must_fail git rev-parse --verify delta@{0} &&
@@ -74,7 +74,7 @@ test_expect_success '--orphan makes reflog by default' '
 '
 
 test_expect_success '--orphan does not make reflog when core.logAllRefUpdates = false' '
-	git checkout master &&
+	git checkout main &&
 	git config core.logAllRefUpdates false &&
 	git checkout --orphan epsilon &&
 	test_must_fail git rev-parse --verify epsilon@{0} &&
@@ -83,7 +83,7 @@ test_expect_success '--orphan does not make reflog when core.logAllRefUpdates =
 '
 
 test_expect_success '--orphan with -l makes reflog when core.logAllRefUpdates = false' '
-	git checkout master &&
+	git checkout main &&
 	git checkout -l --orphan zeta &&
 	test_must_fail git rev-parse --verify zeta@{0} &&
 	git commit -m Zeta &&
@@ -91,33 +91,33 @@ test_expect_success '--orphan with -l makes reflog when core.logAllRefUpdates =
 '
 
 test_expect_success 'giving up --orphan not committed when -l and core.logAllRefUpdates = false deletes reflog' '
-	git checkout master &&
+	git checkout main &&
 	git checkout -l --orphan eta &&
 	test_must_fail git rev-parse --verify eta@{0} &&
-	git checkout master &&
+	git checkout main &&
 	test_must_fail git rev-parse --verify eta@{0}
 '
 
 test_expect_success '--orphan is rejected with an existing name' '
-	git checkout master &&
-	test_must_fail git checkout --orphan master &&
-	test refs/heads/master = "$(git symbolic-ref HEAD)"
+	git checkout main &&
+	test_must_fail git checkout --orphan main &&
+	test refs/heads/main = "$(git symbolic-ref HEAD)"
 '
 
 test_expect_success '--orphan refuses to switch if a merge is needed' '
-	git checkout master &&
+	git checkout main &&
 	git reset --hard &&
 	echo local >>"$TEST_FILE" &&
 	cat "$TEST_FILE" >"$TEST_FILE.saved" &&
-	test_must_fail git checkout --orphan new master^ &&
-	test refs/heads/master = "$(git symbolic-ref HEAD)" &&
+	test_must_fail git checkout --orphan new main^ &&
+	test refs/heads/main = "$(git symbolic-ref HEAD)" &&
 	test_cmp "$TEST_FILE" "$TEST_FILE.saved" &&
 	git diff-index --quiet --cached HEAD &&
 	git reset --hard
 '
 
 test_expect_success 'cannot --detach on an unborn branch' '
-	git checkout master &&
+	git checkout main &&
 	git checkout --orphan new &&
 	test_must_fail git checkout --detach
 '
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index b748db9946..25885c3065 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -22,7 +22,7 @@ check_no_orphan_warning() {
 }
 
 reset () {
-	git checkout master &&
+	git checkout main &&
 	check_not_detached
 }
 
@@ -85,7 +85,7 @@ test_expect_success 'checkout --detach errors out for non-commit' '
 
 test_expect_success 'checkout --detach errors out for extra argument' '
 	reset &&
-	git checkout master &&
+	git checkout main &&
 	test_must_fail git checkout --detach tag one.t &&
 	check_not_detached
 '
@@ -113,7 +113,7 @@ test_expect_success 'checkout warns on orphan commits' '
 	echo new content >orphan &&
 	git commit -a -m orphan2 &&
 	orphan2=$(git rev-parse HEAD) &&
-	git checkout master 2>stderr
+	git checkout main 2>stderr
 '
 
 test_expect_success 'checkout warns on orphan commits: output' '
@@ -132,7 +132,7 @@ test_expect_success 'checkout warns orphaning 1 of 2 commits: output' '
 test_expect_success 'checkout does not warn leaving ref tip' '
 	reset &&
 	git checkout --detach two &&
-	git checkout master 2>stderr
+	git checkout main 2>stderr
 '
 
 test_expect_success 'checkout does not warn leaving ref tip' '
@@ -142,7 +142,7 @@ test_expect_success 'checkout does not warn leaving ref tip' '
 test_expect_success 'checkout does not warn leaving reachable commit' '
 	reset &&
 	git checkout --detach HEAD^ &&
-	git checkout master 2>stderr
+	git checkout main 2>stderr
 '
 
 test_expect_success 'checkout does not warn leaving reachable commit' '
@@ -150,14 +150,14 @@ test_expect_success 'checkout does not warn leaving reachable commit' '
 '
 
 cat >expect <<'EOF'
-Your branch is behind 'master' by 1 commit, and can be fast-forwarded.
+Your branch is behind 'main' by 1 commit, and can be fast-forwarded.
   (use "git pull" to update your local branch)
 EOF
 test_expect_success 'tracking count is accurate after orphan check' '
 	reset &&
-	git branch child master^ &&
+	git branch child main^ &&
 	git config branch.child.remote . &&
-	git config branch.child.merge refs/heads/master &&
+	git config branch.child.merge refs/heads/main &&
 	git checkout child^ &&
 	git checkout child >stdout &&
 	test_i18ncmp expect stdout
@@ -189,9 +189,9 @@ test_expect_success 'no advice given for explicit detached head state' '
 # Detached HEAD tests for GIT_PRINT_SHA1_ELLIPSIS (new format)
 test_expect_success 'describe_detached_head prints no SHA-1 ellipsis when not asked to' "
 
-	commit=$(git rev-parse --short=12 master^) &&
-	commit2=$(git rev-parse --short=12 master~2) &&
-	commit3=$(git rev-parse --short=12 master~3) &&
+	commit=$(git rev-parse --short=12 main^) &&
+	commit2=$(git rev-parse --short=12 main~2) &&
+	commit3=$(git rev-parse --short=12 main~3) &&
 
 	# The first detach operation is more chatty than the following ones.
 	cat >1st_detach <<-EOF &&
@@ -271,9 +271,9 @@ test_expect_success 'describe_detached_head prints no SHA-1 ellipsis when not as
 # Detached HEAD tests for GIT_PRINT_SHA1_ELLIPSIS (old format)
 test_expect_success 'describe_detached_head does print SHA-1 ellipsis when asked to' "
 
-	commit=$(git rev-parse --short=12 master^) &&
-	commit2=$(git rev-parse --short=12 master~2) &&
-	commit3=$(git rev-parse --short=12 master~3) &&
+	commit=$(git rev-parse --short=12 main^) &&
+	commit2=$(git rev-parse --short=12 main~2) &&
+	commit3=$(git rev-parse --short=12 main~3) &&
 
 	# The first detach operation is more chatty than the following ones.
 	cat >1st_detach <<-EOF &&
diff --git a/t/t2022-checkout-paths.sh b/t/t2022-checkout-paths.sh
index 6844afafc0..4174620cf4 100755
--- a/t/t2022-checkout-paths.sh
+++ b/t/t2022-checkout-paths.sh
@@ -5,15 +5,15 @@ test_description='checkout $tree -- $paths'
 
 test_expect_success setup '
 	mkdir dir &&
-	>dir/master &&
+	>dir/main &&
 	echo common >dir/common &&
-	git add dir/master dir/common &&
-	test_tick && git commit -m "master has dir/master" &&
+	git add dir/main dir/common &&
+	test_tick && git commit -m "main has dir/main" &&
 	git checkout -b next &&
-	git mv dir/master dir/next0 &&
+	git mv dir/main dir/next0 &&
 	echo next >dir/next1 &&
 	git add dir &&
-	test_tick && git commit -m "next has dir/next but not dir/master"
+	test_tick && git commit -m "next has dir/next but not dir/main"
 '
 
 test_expect_success 'checking out paths out of a tree does not clobber unrelated paths' '
@@ -26,11 +26,11 @@ test_expect_success 'checking out paths out of a tree does not clobber unrelated
 	echo untracked >expect.next2 &&
 	cat expect.next2 >dir/next2 &&
 
-	git checkout master dir &&
+	git checkout main dir &&
 
 	test_cmp expect.common dir/common &&
-	test_path_is_file dir/master &&
-	git diff --exit-code master dir/master &&
+	test_path_is_file dir/main &&
+	git diff --exit-code main dir/main &&
 
 	test_path_is_missing dir/next0 &&
 	test_cmp expect.next1 dir/next1 &&
@@ -52,11 +52,11 @@ test_expect_success 'do not touch unmerged entries matching $path but not in $tr
 	EOF
 	git update-index --index-info <expect.next0 &&
 
-	git checkout master dir &&
+	git checkout main dir &&
 
 	test_cmp expect.common dir/common &&
-	test_path_is_file dir/master &&
-	git diff --exit-code master dir/master &&
+	test_path_is_file dir/main &&
+	git diff --exit-code main dir/main &&
 	git ls-files -s dir/next0 >actual.next0 &&
 	test_cmp expect.next0 actual.next0
 '
diff --git a/t/t2023-checkout-m.sh b/t/t2023-checkout-m.sh
index fca3f85824..ddcfcc3e9b 100755
--- a/t/t2023-checkout-m.sh
+++ b/t/t2023-checkout-m.sh
@@ -10,15 +10,15 @@ test_expect_success setup '
 	test_tick &&
 	test_commit both.txt both.txt initial &&
 	git branch topic &&
-	test_commit modified_in_master both.txt in_master &&
-	test_commit added_in_master each.txt in_master &&
+	test_commit modified_in_main both.txt in_main &&
+	test_commit added_in_main each.txt in_main &&
 	git checkout topic &&
 	test_commit modified_in_topic both.txt in_topic &&
 	test_commit added_in_topic each.txt in_topic
 '
 
-test_expect_success 'git merge master' '
-    test_must_fail git merge master
+test_expect_success 'git merge main' '
+    test_must_fail git merge main
 '
 
 clean_branchnames () {
@@ -61,7 +61,7 @@ test_expect_success 'force checkout a conflict file creates stage zero entry' '
 		git checkout topic &&
 		echo c >a &&
 		C_OBJ=$(git hash-object a) &&
-		git checkout -m master &&
+		git checkout -m main &&
 		test_cmp_rev :1:a $A_OBJ &&
 		test_cmp_rev :2:a $B_OBJ &&
 		test_cmp_rev :3:a $C_OBJ &&
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index a4f8d3a67e..4a1c901456 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -29,11 +29,11 @@ status_uno_is_clean () {
 }
 
 test_expect_success 'setup' '
-	test_commit my_master &&
+	test_commit my_main &&
 	git init repo_a &&
 	(
 		cd repo_a &&
-		test_commit a_master &&
+		test_commit a_main &&
 		git checkout -b foo &&
 		test_commit a_foo &&
 		git checkout -b bar &&
@@ -44,7 +44,7 @@ test_expect_success 'setup' '
 	git init repo_b &&
 	(
 		cd repo_b &&
-		test_commit b_master &&
+		test_commit b_main &&
 		git checkout -b foo &&
 		test_commit b_foo &&
 		git checkout -b baz &&
@@ -60,23 +60,23 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'checkout of non-existing branch fails' '
-	git checkout -B master &&
+	git checkout -B main &&
 	test_might_fail git branch -D xyzzy &&
 
 	test_must_fail git checkout xyzzy &&
 	status_uno_is_clean &&
 	test_must_fail git rev-parse --verify refs/heads/xyzzy &&
-	test_branch master
+	test_branch main
 '
 
 test_expect_success 'checkout of branch from multiple remotes fails #1' '
-	git checkout -B master &&
+	git checkout -B main &&
 	test_might_fail git branch -D foo &&
 
 	test_must_fail git checkout foo &&
 	status_uno_is_clean &&
 	test_must_fail git rev-parse --verify refs/heads/foo &&
-	test_branch master
+	test_branch main
 '
 
 test_expect_success 'when arg matches multiple remotes, do not fallback to interpreting as pathspec' '
@@ -100,21 +100,21 @@ test_expect_success 'when arg matches multiple remotes, do not fallback to inter
 '
 
 test_expect_success 'checkout of branch from multiple remotes fails with advice' '
-	git checkout -B master &&
+	git checkout -B main &&
 	test_might_fail git branch -D foo &&
 	test_must_fail git checkout foo 2>stderr &&
-	test_branch master &&
+	test_branch main &&
 	status_uno_is_clean &&
 	test_i18ngrep "^hint: " stderr &&
 	test_must_fail git -c advice.checkoutAmbiguousRemoteBranchName=false \
 		checkout foo 2>stderr &&
-	test_branch master &&
+	test_branch main &&
 	status_uno_is_clean &&
 	test_i18ngrep ! "^hint: " stderr
 '
 
 test_expect_success PERL 'checkout -p with multiple remotes does not print advice' '
-	git checkout -B master &&
+	git checkout -B main &&
 	test_might_fail git branch -D foo &&
 
 	git checkout -p foo 2>stderr &&
@@ -123,7 +123,7 @@ test_expect_success PERL 'checkout -p with multiple remotes does not print advic
 '
 
 test_expect_success 'checkout of branch from multiple remotes succeeds with checkout.defaultRemote #1' '
-	git checkout -B master &&
+	git checkout -B main &&
 	status_uno_is_clean &&
 	test_might_fail git branch -D foo &&
 
@@ -135,7 +135,7 @@ test_expect_success 'checkout of branch from multiple remotes succeeds with chec
 '
 
 test_expect_success 'checkout of branch from a single remote succeeds #1' '
-	git checkout -B master &&
+	git checkout -B main &&
 	test_might_fail git branch -D bar &&
 
 	git checkout bar &&
@@ -146,7 +146,7 @@ test_expect_success 'checkout of branch from a single remote succeeds #1' '
 '
 
 test_expect_success 'checkout of branch from a single remote succeeds #2' '
-	git checkout -B master &&
+	git checkout -B main &&
 	test_might_fail git branch -D baz &&
 
 	git checkout baz &&
@@ -157,33 +157,33 @@ test_expect_success 'checkout of branch from a single remote succeeds #2' '
 '
 
 test_expect_success '--no-guess suppresses branch auto-vivification' '
-	git checkout -B master &&
+	git checkout -B main &&
 	status_uno_is_clean &&
 	test_might_fail git branch -D bar &&
 
 	test_must_fail git checkout --no-guess bar &&
 	test_must_fail git rev-parse --verify refs/heads/bar &&
-	test_branch master
+	test_branch main
 '
 
 test_expect_success 'checkout.guess = false suppresses branch auto-vivification' '
-	git checkout -B master &&
+	git checkout -B main &&
 	status_uno_is_clean &&
 	test_might_fail git branch -D bar &&
 
 	test_config checkout.guess false &&
 	test_must_fail git checkout bar &&
 	test_must_fail git rev-parse --verify refs/heads/bar &&
-	test_branch master
+	test_branch main
 '
 
 test_expect_success 'setup more remotes with unconventional refspecs' '
-	git checkout -B master &&
+	git checkout -B main &&
 	status_uno_is_clean &&
 	git init repo_c &&
 	(
 		cd repo_c &&
-		test_commit c_master &&
+		test_commit c_main &&
 		git checkout -b bar &&
 		test_commit c_bar &&
 		git checkout -b spam &&
@@ -192,7 +192,7 @@ test_expect_success 'setup more remotes with unconventional refspecs' '
 	git init repo_d &&
 	(
 		cd repo_d &&
-		test_commit d_master &&
+		test_commit d_main &&
 		git checkout -b baz &&
 		test_commit d_baz &&
 		git checkout -b eggs &&
@@ -208,29 +208,29 @@ test_expect_success 'setup more remotes with unconventional refspecs' '
 '
 
 test_expect_success 'checkout of branch from multiple remotes fails #2' '
-	git checkout -B master &&
+	git checkout -B main &&
 	status_uno_is_clean &&
 	test_might_fail git branch -D bar &&
 
 	test_must_fail git checkout bar &&
 	status_uno_is_clean &&
 	test_must_fail git rev-parse --verify refs/heads/bar &&
-	test_branch master
+	test_branch main
 '
 
 test_expect_success 'checkout of branch from multiple remotes fails #3' '
-	git checkout -B master &&
+	git checkout -B main &&
 	status_uno_is_clean &&
 	test_might_fail git branch -D baz &&
 
 	test_must_fail git checkout baz &&
 	status_uno_is_clean &&
 	test_must_fail git rev-parse --verify refs/heads/baz &&
-	test_branch master
+	test_branch main
 '
 
 test_expect_success 'checkout of branch from a single remote succeeds #3' '
-	git checkout -B master &&
+	git checkout -B main &&
 	status_uno_is_clean &&
 	test_might_fail git branch -D spam &&
 
@@ -242,7 +242,7 @@ test_expect_success 'checkout of branch from a single remote succeeds #3' '
 '
 
 test_expect_success 'checkout of branch from a single remote succeeds #4' '
-	git checkout -B master &&
+	git checkout -B main &&
 	status_uno_is_clean &&
 	test_might_fail git branch -D eggs &&
 
@@ -254,7 +254,7 @@ test_expect_success 'checkout of branch from a single remote succeeds #4' '
 '
 
 test_expect_success 'checkout of branch with a file having the same name fails' '
-	git checkout -B master &&
+	git checkout -B main &&
 	status_uno_is_clean &&
 	test_might_fail git branch -D spam &&
 
@@ -262,11 +262,11 @@ test_expect_success 'checkout of branch with a file having the same name fails'
 	test_must_fail git checkout spam &&
 	status_uno_is_clean &&
 	test_must_fail git rev-parse --verify refs/heads/spam &&
-	test_branch master
+	test_branch main
 '
 
 test_expect_success 'checkout of branch with a file in subdir having the same name fails' '
-	git checkout -B master &&
+	git checkout -B main &&
 	status_uno_is_clean &&
 	test_might_fail git branch -D spam &&
 
@@ -276,11 +276,11 @@ test_expect_success 'checkout of branch with a file in subdir having the same na
 	test_must_fail git -C sub checkout spam &&
 	status_uno_is_clean &&
 	test_must_fail git rev-parse --verify refs/heads/spam &&
-	test_branch master
+	test_branch main
 '
 
 test_expect_success 'checkout <branch> -- succeeds, even if a file with the same name exists' '
-	git checkout -B master &&
+	git checkout -B main &&
 	status_uno_is_clean &&
 	test_might_fail git branch -D spam &&
 
@@ -294,7 +294,7 @@ test_expect_success 'checkout <branch> -- succeeds, even if a file with the same
 
 test_expect_success 'loosely defined local base branch is reported correctly' '
 
-	git checkout master &&
+	git checkout main &&
 	status_uno_is_clean &&
 	git branch strict &&
 	git branch loose &&
@@ -302,8 +302,8 @@ test_expect_success 'loosely defined local base branch is reported correctly' '
 
 	test_config branch.strict.remote . &&
 	test_config branch.loose.remote . &&
-	test_config branch.strict.merge refs/heads/master &&
-	test_config branch.loose.merge master &&
+	test_config branch.strict.merge refs/heads/main &&
+	test_config branch.loose.merge main &&
 
 	git checkout strict | sed -e "s/strict/BRANCHNAME/g" >expect &&
 	status_uno_is_clean &&
diff --git a/t/t2027-checkout-track.sh b/t/t2027-checkout-track.sh
index bcba1bf90c..bc46c5a68e 100755
--- a/t/t2027-checkout-track.sh
+++ b/t/t2027-checkout-track.sh
@@ -10,14 +10,14 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'checkout --track -b creates a new tracking branch' '
-	git checkout --track -b branch1 master &&
+	git checkout --track -b branch1 main &&
 	test $(git rev-parse --abbrev-ref HEAD) = branch1 &&
 	test $(git config --get branch.branch1.remote) = . &&
-	test $(git config --get branch.branch1.merge) = refs/heads/master
+	test $(git config --get branch.branch1.merge) = refs/heads/main
 '
 
 test_expect_success 'checkout --track -b rejects an extra path argument' '
-	test_must_fail git checkout --track -b branch2 master one.t 2>err &&
+	test_must_fail git checkout --track -b branch2 main one.t 2>err &&
 	test_i18ngrep "cannot be used with updating paths" err
 '
 
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index 309199bca2..3cdd73c172 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -59,7 +59,7 @@ test_expect_success setup '
 	test_commit fourth fi/le fourth &&
 	git checkout add-add &&
 	test_commit fifth add-differently &&
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'add records switch clears' '
@@ -183,8 +183,8 @@ test_expect_success 'rerere forget (binary)' '
 '
 
 test_expect_success 'rerere forget (add-add conflict)' '
-	git checkout -f master &&
-	echo master >add-differently &&
+	git checkout -f main &&
+	echo main >add-differently &&
 	git add add-differently &&
 	git commit -m "add differently" &&
 	test_must_fail git merge fifth &&
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index 68c9101b02..11f85f8861 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -23,41 +23,41 @@ test_expect_success 'switch branch' '
 '
 
 test_expect_success 'switch and detach' '
-	test_when_finished git switch master &&
-	test_must_fail git switch master^{commit} &&
-	git switch --detach master^{commit} &&
+	test_when_finished git switch main &&
+	test_must_fail git switch main^{commit} &&
+	git switch --detach main^{commit} &&
 	test_must_fail git symbolic-ref HEAD
 '
 
 test_expect_success 'switch and detach current branch' '
-	test_when_finished git switch master &&
-	git switch master &&
+	test_when_finished git switch main &&
+	git switch main &&
 	git switch --detach &&
 	test_must_fail git symbolic-ref HEAD
 '
 
 test_expect_success 'switch and create branch' '
-	test_when_finished git switch master &&
-	git switch -c temp master^ &&
-	test_cmp_rev master^ refs/heads/temp &&
+	test_when_finished git switch main &&
+	git switch -c temp main^ &&
+	test_cmp_rev main^ refs/heads/temp &&
 	echo refs/heads/temp >expected-branch &&
 	git symbolic-ref HEAD >actual-branch &&
 	test_cmp expected-branch actual-branch
 '
 
 test_expect_success 'force create branch from HEAD' '
-	test_when_finished git switch master &&
-	git switch --detach master &&
+	test_when_finished git switch main &&
+	git switch --detach main &&
 	test_must_fail git switch -c temp &&
 	git switch -C temp &&
-	test_cmp_rev master refs/heads/temp &&
+	test_cmp_rev main refs/heads/temp &&
 	echo refs/heads/temp >expected-branch &&
 	git symbolic-ref HEAD >actual-branch &&
 	test_cmp expected-branch actual-branch
 '
 
 test_expect_success 'new orphan branch from empty' '
-	test_when_finished git switch master &&
+	test_when_finished git switch main &&
 	test_must_fail git switch --orphan new-orphan HEAD &&
 	git switch --orphan new-orphan &&
 	test_commit orphan &&
@@ -69,7 +69,7 @@ test_expect_success 'new orphan branch from empty' '
 '
 
 test_expect_success 'orphan branch works with --discard-changes' '
-	test_when_finished git switch master &&
+	test_when_finished git switch main &&
 	echo foo >foo.txt &&
 	git switch --discard-changes --orphan new-orphan2 &&
 	git ls-files >tracked-files &&
@@ -77,7 +77,7 @@ test_expect_success 'orphan branch works with --discard-changes' '
 '
 
 test_expect_success 'switching ignores file of same branch name' '
-	test_when_finished git switch master &&
+	test_when_finished git switch main &&
 	: >first-branch &&
 	git switch first-branch &&
 	echo refs/heads/first-branch >expected &&
@@ -86,7 +86,7 @@ test_expect_success 'switching ignores file of same branch name' '
 '
 
 test_expect_success 'guess and create branch' '
-	test_when_finished git switch master &&
+	test_when_finished git switch main &&
 	test_must_fail git switch --no-guess foo &&
 	test_config checkout.guess false &&
 	test_must_fail git switch foo &&
diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index 89e5a142c9..46e27212d6 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -15,7 +15,7 @@ test_expect_success 'setup' '
 	echo ignored >ignored &&
 	echo /ignored >.gitignore &&
 	git add one two .gitignore &&
-	git update-ref refs/heads/one master
+	git update-ref refs/heads/one main
 '
 
 test_expect_success 'restore without pathspec is not ok' '
@@ -91,7 +91,7 @@ test_expect_success 'restore --ignore-unmerged ignores unmerged entries' '
 		git switch -c first &&
 		echo first >unmerged &&
 		git commit -am first &&
-		git switch -c second master &&
+		git switch -c second main &&
 		echo second >unmerged &&
 		git commit -am second &&
 		test_must_fail git merge first &&
diff --git a/t/t2106-update-index-assume-unchanged.sh b/t/t2106-update-index-assume-unchanged.sh
index 99d858c6b7..2b923824c9 100755
--- a/t/t2106-update-index-assume-unchanged.sh
+++ b/t/t2106-update-index-assume-unchanged.sh
@@ -19,6 +19,6 @@ test_expect_success 'do not switch branches with dirty file' \
 	 git checkout other &&
 	 echo dirt >file &&
 	 git update-index --assume-unchanged file &&
-	 test_must_fail git checkout master'
+	 test_must_fail git checkout main'
 
 test_done
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 5a7495474a..deca7b0271 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -12,12 +12,12 @@ test_expect_success 'setup' '
 
 test_expect_success '"add" an existing worktree' '
 	mkdir -p existing/subtree &&
-	test_must_fail git worktree add --detach existing master
+	test_must_fail git worktree add --detach existing main
 '
 
 test_expect_success '"add" an existing empty worktree' '
 	mkdir existing_empty &&
-	git worktree add --detach existing_empty master
+	git worktree add --detach existing_empty main
 '
 
 test_expect_success '"add" using shorthand - fails when no previous branch' '
@@ -29,7 +29,7 @@ test_expect_success '"add" using - shorthand' '
 	echo hello >myworld &&
 	git add myworld &&
 	git commit -m myworld &&
-	git checkout master &&
+	git checkout main &&
 	git worktree add short-hand - &&
 	echo refs/heads/newbranch >expect &&
 	git -C short-hand rev-parse --symbolic-full-name HEAD >actual &&
@@ -37,7 +37,7 @@ test_expect_success '"add" using - shorthand' '
 '
 
 test_expect_success '"add" refuses to checkout locked branch' '
-	test_must_fail git worktree add zere master &&
+	test_must_fail git worktree add zere main &&
 	! test -d zere &&
 	! test -d .git/worktrees/zere
 '
@@ -46,13 +46,13 @@ test_expect_success 'checking out paths not complaining about linked checkouts'
 	(
 	cd existing_empty &&
 	echo dirty >>init.t &&
-	git checkout master -- init.t
+	git checkout main -- init.t
 	)
 '
 
 test_expect_success '"add" worktree' '
 	git rev-parse HEAD >expect &&
-	git worktree add --detach here master &&
+	git worktree add --detach here main &&
 	(
 		cd here &&
 		test_cmp ../init.t init.t &&
@@ -65,7 +65,7 @@ test_expect_success '"add" worktree' '
 
 test_expect_success '"add" worktree with lock' '
 	git rev-parse HEAD >expect &&
-	git worktree add --detach --lock here-with-lock master &&
+	git worktree add --detach --lock here-with-lock main &&
 	test -f .git/worktrees/here-with-lock/locked
 '
 
@@ -73,7 +73,7 @@ test_expect_success '"add" worktree from a subdir' '
 	(
 		mkdir sub &&
 		cd sub &&
-		git worktree add --detach here master &&
+		git worktree add --detach here main &&
 		cd here &&
 		test_cmp ../../init.t init.t
 	)
@@ -82,19 +82,19 @@ test_expect_success '"add" worktree from a subdir' '
 test_expect_success '"add" from a linked checkout' '
 	(
 		cd here &&
-		git worktree add --detach nested-here master &&
+		git worktree add --detach nested-here main &&
 		cd nested-here &&
 		git fsck
 	)
 '
 
 test_expect_success '"add" worktree creating new branch' '
-	git worktree add -b newmaster there master &&
+	git worktree add -b newmain there main &&
 	(
 		cd there &&
 		test_cmp ../init.t init.t &&
 		git symbolic-ref HEAD >actual &&
-		echo refs/heads/newmaster >expect &&
+		echo refs/heads/newmain >expect &&
 		test_cmp expect actual &&
 		git fsck
 	)
@@ -103,7 +103,7 @@ test_expect_success '"add" worktree creating new branch' '
 test_expect_success 'die the same branch is already checked out' '
 	(
 		cd here &&
-		test_must_fail git checkout newmaster
+		test_must_fail git checkout newmain
 	)
 '
 
@@ -112,20 +112,20 @@ test_expect_success SYMLINKS 'die the same branch is already checked out (symlin
 	ref=$(git -C there symbolic-ref HEAD) &&
 	rm "$head" &&
 	ln -s "$ref" "$head" &&
-	test_must_fail git -C here checkout newmaster
+	test_must_fail git -C here checkout newmain
 '
 
 test_expect_success 'not die the same branch is already checked out' '
 	(
 		cd here &&
-		git worktree add --force anothernewmaster newmaster
+		git worktree add --force anothernewmain newmain
 	)
 '
 
 test_expect_success 'not die on re-checking out current branch' '
 	(
 		cd there &&
-		git checkout newmaster
+		git checkout newmain
 	)
 '
 
@@ -133,14 +133,14 @@ test_expect_success '"add" from a bare repo' '
 	(
 		git clone --bare . bare &&
 		cd bare &&
-		git worktree add -b bare-master ../there2 master
+		git worktree add -b bare-main ../there2 main
 	)
 '
 
 test_expect_success 'checkout from a bare repo without "add"' '
 	(
 		cd bare &&
-		test_must_fail git checkout master
+		test_must_fail git checkout main
 	)
 '
 
@@ -148,7 +148,7 @@ test_expect_success '"add" default branch of a bare repo' '
 	(
 		git clone --bare . bare2 &&
 		cd bare2 &&
-		git worktree add ../there3 master
+		git worktree add ../there3 main
 	)
 '
 
@@ -165,7 +165,7 @@ test_expect_success 'checkout with grafts' '
 	EOF
 	git log --format=%s -2 >actual &&
 	test_cmp expected actual &&
-	git worktree add --detach grafted master &&
+	git worktree add --detach grafted main &&
 	git --git-dir=grafted/.git log --format=%s -2 >actual &&
 	test_cmp expected actual
 '
@@ -226,34 +226,34 @@ test_expect_success '"add" no auto-vivify with --detach and <branch> omitted' '
 '
 
 test_expect_success '"add" -b/-B mutually exclusive' '
-	test_must_fail git worktree add -b poodle -B poodle bamboo master
+	test_must_fail git worktree add -b poodle -B poodle bamboo main
 '
 
 test_expect_success '"add" -b/--detach mutually exclusive' '
-	test_must_fail git worktree add -b poodle --detach bamboo master
+	test_must_fail git worktree add -b poodle --detach bamboo main
 '
 
 test_expect_success '"add" -B/--detach mutually exclusive' '
-	test_must_fail git worktree add -B poodle --detach bamboo master
+	test_must_fail git worktree add -B poodle --detach bamboo main
 '
 
 test_expect_success '"add -B" fails if the branch is checked out' '
-	git rev-parse newmaster >before &&
-	test_must_fail git worktree add -B newmaster bamboo master &&
-	git rev-parse newmaster >after &&
+	git rev-parse newmain >before &&
+	test_must_fail git worktree add -B newmain bamboo main &&
+	git rev-parse newmain >after &&
 	test_cmp before after
 '
 
 test_expect_success 'add -B' '
-	git worktree add -B poodle bamboo2 master^ &&
+	git worktree add -B poodle bamboo2 main^ &&
 	git -C bamboo2 symbolic-ref HEAD >actual &&
 	echo refs/heads/poodle >expected &&
 	test_cmp expected actual &&
-	test_cmp_rev master^ poodle
+	test_cmp_rev main^ poodle
 '
 
 test_expect_success 'add --quiet' '
-	git worktree add --quiet another-worktree master 2>actual &&
+	git worktree add --quiet another-worktree main 2>actual &&
 	test_must_be_empty actual
 '
 
@@ -348,24 +348,24 @@ test_branch_upstream () {
 
 test_expect_success '--track sets up tracking' '
 	test_when_finished rm -rf track &&
-	git worktree add --track -b track track master &&
-	test_branch_upstream track . master
+	git worktree add --track -b track track main &&
+	test_branch_upstream track . main
 '
 
 # setup remote repository $1 and repository $2 with $1 set up as
-# remote.  The remote has two branches, master and foo.
+# remote.  The remote has two branches, main and foo.
 setup_remote_repo () {
 	git init $1 &&
 	(
 		cd $1 &&
-		test_commit $1_master &&
+		test_commit $1_main &&
 		git checkout -b foo &&
 		test_commit upstream_foo
 	) &&
 	git init $2 &&
 	(
 		cd $2 &&
-		test_commit $2_master &&
+		test_commit $2_main &&
 		git remote add $1 ../$1 &&
 		git config remote.$1.fetch \
 			"refs/heads/*:refs/remotes/$1/*" &&
diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index a6ce7f590b..7a2ff04f44 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -87,7 +87,7 @@ test_expect_success 'not prune recent checkouts' '
 
 test_expect_success 'not prune proper checkouts' '
 	test_when_finished rm -r .git/worktrees &&
-	git worktree add --detach "$PWD/nop" master &&
+	git worktree add --detach "$PWD/nop" main &&
 	git worktree prune &&
 	test -d .git/worktrees/nop
 '
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 795ddca2e4..03603d0dd0 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -21,7 +21,7 @@ test_expect_success 'rev-parse --git-common-dir on main worktree' '
 test_expect_success 'rev-parse --git-path objects linked worktree' '
 	echo "$(git rev-parse --show-toplevel)/.git/objects" >expect &&
 	test_when_finished "rm -rf linked-tree actual expect && git worktree prune" &&
-	git worktree add --detach linked-tree master &&
+	git worktree add --detach linked-tree main &&
 	git -C linked-tree rev-parse --git-path objects >actual &&
 	test_cmp expect actual
 '
@@ -29,7 +29,7 @@ test_expect_success 'rev-parse --git-path objects linked worktree' '
 test_expect_success '"list" all worktrees from main' '
 	echo "$(git rev-parse --show-toplevel) $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
 	test_when_finished "rm -rf here out actual expect && git worktree prune" &&
-	git worktree add --detach here master &&
+	git worktree add --detach here main &&
 	echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
 	git worktree list >out &&
 	sed "s/  */ /g" <out >actual &&
@@ -39,7 +39,7 @@ test_expect_success '"list" all worktrees from main' '
 test_expect_success '"list" all worktrees from linked' '
 	echo "$(git rev-parse --show-toplevel) $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
 	test_when_finished "rm -rf here out actual expect && git worktree prune" &&
-	git worktree add --detach here master &&
+	git worktree add --detach here main &&
 	echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
 	git -C here worktree list >out &&
 	sed "s/  */ /g" <out >actual &&
@@ -52,7 +52,7 @@ test_expect_success '"list" all worktrees --porcelain' '
 	echo "branch $(git symbolic-ref HEAD)" >>expect &&
 	echo >>expect &&
 	test_when_finished "rm -rf here actual expect && git worktree prune" &&
-	git worktree add --detach here master &&
+	git worktree add --detach here main &&
 	echo "worktree $(git -C here rev-parse --show-toplevel)" >>expect &&
 	echo "HEAD $(git rev-parse HEAD)" >>expect &&
 	echo "detached" >>expect &&
@@ -63,8 +63,8 @@ test_expect_success '"list" all worktrees --porcelain' '
 
 test_expect_success '"list" all worktrees with locked annotation' '
 	test_when_finished "rm -rf locked unlocked out && git worktree prune" &&
-	git worktree add --detach locked master &&
-	git worktree add --detach unlocked master &&
+	git worktree add --detach locked main &&
+	git worktree add --detach unlocked main &&
 	git worktree lock locked &&
 	git worktree list >out &&
 	grep "/locked  *[0-9a-f].* locked$" out &&
@@ -76,13 +76,13 @@ test_expect_success 'bare repo setup' '
 	echo "data" >file1 &&
 	git add file1 &&
 	git commit -m"File1: add data" &&
-	git push bare1 master &&
+	git push bare1 main &&
 	git reset --hard HEAD^
 '
 
 test_expect_success '"list" all worktrees from bare main' '
 	test_when_finished "rm -rf there out actual expect && git -C bare1 worktree prune" &&
-	git -C bare1 worktree add --detach ../there master &&
+	git -C bare1 worktree add --detach ../there main &&
 	echo "$(pwd)/bare1 (bare)" >expect &&
 	echo "$(git -C there rev-parse --show-toplevel) $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
 	git -C bare1 worktree list >out &&
@@ -92,7 +92,7 @@ test_expect_success '"list" all worktrees from bare main' '
 
 test_expect_success '"list" all worktrees --porcelain from bare main' '
 	test_when_finished "rm -rf there actual expect && git -C bare1 worktree prune" &&
-	git -C bare1 worktree add --detach ../there master &&
+	git -C bare1 worktree add --detach ../there main &&
 	echo "worktree $(pwd)/bare1" >expect &&
 	echo "bare" >>expect &&
 	echo >>expect &&
@@ -106,7 +106,7 @@ test_expect_success '"list" all worktrees --porcelain from bare main' '
 
 test_expect_success '"list" all worktrees from linked with a bare main' '
 	test_when_finished "rm -rf there out actual expect && git -C bare1 worktree prune" &&
-	git -C bare1 worktree add --detach ../there master &&
+	git -C bare1 worktree add --detach ../there main &&
 	echo "$(pwd)/bare1 (bare)" >expect &&
 	echo "$(git -C there rev-parse --show-toplevel) $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
 	git -C there worktree list >out &&
diff --git a/t/t2405-worktree-submodule.sh b/t/t2405-worktree-submodule.sh
index e1b2bfd87e..ccc47fae97 100755
--- a/t/t2405-worktree-submodule.sh
+++ b/t/t2405-worktree-submodule.sh
@@ -31,7 +31,7 @@ test_expect_success 'add superproject worktree' '
 '
 
 test_expect_failure 'submodule is checked out just after worktree add' '
-	git -C worktree diff --submodule master"^!" >out &&
+	git -C worktree diff --submodule main"^!" >out &&
 	grep "file1 updated" out
 '
 
@@ -41,7 +41,7 @@ test_expect_success 'add superproject worktree and initialize submodules' '
 '
 
 test_expect_success 'submodule is checked out just after submodule update in linked worktree' '
-	git -C worktree-submodule-update diff --submodule master"^!" >out &&
+	git -C worktree-submodule-update diff --submodule main"^!" >out &&
 	grep "file1 updated" out
 '
 
@@ -51,7 +51,7 @@ test_expect_success 'add superproject worktree and manually add submodule worktr
 '
 
 test_expect_success 'submodule is checked out after manually adding submodule worktree' '
-	git -C linked_submodule diff --submodule master"^!" >out &&
+	git -C linked_submodule diff --submodule main"^!" >out &&
 	grep "file1 updated" out
 '
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 126004e342..3bb6675390 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -257,7 +257,7 @@ case "$TRASH_DIRECTORY" in
 esac
 
 case "$TEST_NUMBER" in
-[01]*)
+[0-2]*)
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-- 
gitgitgadget

