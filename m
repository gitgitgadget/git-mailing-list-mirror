Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05176C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 04:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A9761154
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 04:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhIHEtE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 00:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhIHEtC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 00:49:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AB4C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 21:47:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b6so1168629wrh.10
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 21:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=nSb3WTUthmbzfj2MKUgzoBkWAdBSqq5C8tpkWd1RipY=;
        b=Q2AQgEQtVMDQBgAe7MEKLM+bEMVXgYnfgPkyy+I9LqhJ9hYhIgFihjTw6+e0laFa5r
         89mie6pdhuNB7sW70WFEd5o3H322p1OD5zSH/72iCiajKChtHj1DBeXLFlFo/riwc/ik
         ptogrgP769VExPmhC+c+K1LciwHNgHuO1vOGwROqKq4Gm7+nimsCyNNAfzCajyIR+IzU
         g/dLwHhCc7T8yQXn7TWEFZvjAyGWYTam8TgsHVV2NIRGRlA8MCEHRLdLqWR/f7Y9BUoo
         EU8CP5hgRByJl2EQYW8rpLfsBjoQYLWB8P7BALuiIPAFdTYbVTev4sKpEIAWydA/nQ0b
         xN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nSb3WTUthmbzfj2MKUgzoBkWAdBSqq5C8tpkWd1RipY=;
        b=eBJDrZ926SJ/78X3hwitIOnJ91g9mDlGzR5UReJ/x5cHlCSpk5fCoYRqhkQkyAakCv
         LQ5w8qEvLixwu5Kq7dptuW2vv5rvKcvi+/TBuNqw38HZLUktchwAX1kRRqTV2cyYyGkt
         xq/6L9JF2Xpto6qEE6CEasF0s42K+YzG8JrXlB/P9OIdqR1OhzekD4Op8/BqrixY3X//
         zGKEfSW1kSgG2SQg3ILO19DDkK8GdkhMDhk7y1F6v6gd8K208cAaFec7/gIWsVoRrJq4
         7Lk+DygAj7LBm4NsK9NqdK2BCHWHbtcZkvrFlQ2p257UJxwJ+++wZzXOjuSbNV9mJxIr
         GA8Q==
X-Gm-Message-State: AOAM531iM+KO4uuiHYw1WnJLueNYtsfXZ/+TgyryTqw4Bj7xcQkWjtPx
        5LRrOfT56TeVjQFrztb8tVMT2cXyQw4=
X-Google-Smtp-Source: ABdhPJy1ANglr5QKaPopxzUeLaKdd+VvbihDhcHWFmmfao+2KAhdoOViccIR/B/Zppxz5oGqz5Mahg==
X-Received: by 2002:a05:6000:1569:: with SMTP id 9mr1724399wrz.242.1631076473433;
        Tue, 07 Sep 2021 21:47:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f3sm847610wmj.28.2021.09.07.21.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 21:47:53 -0700 (PDT)
Message-Id: <pull.1088.git.git.1631076472457.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 04:47:52 +0000
Subject: [PATCH] tests: remove leftover untracked files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Remove untracked files that are unwanted after they are done being used.

While the set of cases in this patch is certainly far from
comprehensive, it was motivated by some work to see what the fallout
would be if we were to make the removal of untracked files as a side
effect of other commands into an error.  Some cases were a bit more
involved than the testcase changes included in this patch, but the ones
included here represent the simple cases.  While this patch is not that
important since we are not changing the behavior of those other commands
into an error in the near term, I thought these changes were useful
anyway as an explicit documentation of the intent that these untracked
files are no longer useful.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    tests: remove leftover untracked files
    
    Remove untracked files that are unwanted after they are done being used.
    
    While the set of cases in this patch is certainly far from
    comprehensive, it was motivated by some work to see what the fallout
    would be if we were to make the removal of untracked files as a side
    effect of other commands into an error. Some cases were a bit more
    involved than the testcase changes included in this patch, but the ones
    included here represent the simple cases. While this patch is not that
    important since we are not changing the behavior of those other commands
    into an error in the near term, I thought these changes were useful
    anyway as an explicit documentation of the intent that these untracked
    files are no longer useful.
    
    Signed-off-by: Elijah Newren newren@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1088%2Fnewren%2Fremove-leftover-test-crud-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1088/newren/remove-leftover-test-crud-v1
Pull-Request: https://github.com/git/git/pull/1088

 t/t0090-cache-tree.sh                    | 1 +
 t/t2021-checkout-overwrite.sh            | 1 +
 t/t3404-rebase-interactive.sh            | 1 +
 t/t3435-rebase-gpg-sign.sh               | 1 +
 t/t3510-cherry-pick-sequence.sh          | 1 +
 t/t5304-prune.sh                         | 1 +
 t/t6415-merge-dir-to-symlink.sh          | 6 ++++--
 t/t6424-merge-unrelated-index-changes.sh | 1 +
 t/t6430-merge-recursive.sh               | 4 +++-
 t/t6436-merge-overwrite.sh               | 3 ++-
 t/t7201-co.sh                            | 1 +
 t/t7600-merge.sh                         | 1 +
 12 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 9bf66c9e68d..90675726484 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -195,6 +195,7 @@ test_expect_success 'reset --hard gives cache-tree' '
 
 test_expect_success 'reset --hard without index gives cache-tree' '
 	rm -f .git/index &&
+	git clean -fd &&
 	git reset --hard &&
 	test_cache_tree
 '
diff --git a/t/t2021-checkout-overwrite.sh b/t/t2021-checkout-overwrite.sh
index 70d69263e68..660132ff8d5 100755
--- a/t/t2021-checkout-overwrite.sh
+++ b/t/t2021-checkout-overwrite.sh
@@ -48,6 +48,7 @@ test_expect_success 'checkout commit with dir must not remove untracked a/b' '
 
 test_expect_success SYMLINKS 'the symlink remained' '
 
+	test_when_finished "rm a/b" &&
 	test -h a/b
 '
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index d877872e8f4..972ce026bbc 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -297,6 +297,7 @@ test_expect_success 'abort with error when new base cannot be checked out' '
 		output &&
 	test_i18ngrep "file1" output &&
 	test_path_is_missing .git/rebase-merge &&
+	rm file1 &&
 	git reset --hard HEAD^
 '
 
diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
index ec107668580..5f8ba2c7399 100755
--- a/t/t3435-rebase-gpg-sign.sh
+++ b/t/t3435-rebase-gpg-sign.sh
@@ -65,6 +65,7 @@ test_rebase_gpg_sign ! true  -i --gpg-sign --no-gpg-sign
 test_rebase_gpg_sign   false -i --no-gpg-sign --gpg-sign
 
 test_expect_failure 'rebase -p --no-gpg-sign override commit.gpgsign' '
+	test_when_finished "git clean -f" &&
 	git reset --hard merged &&
 	git config commit.gpgsign true &&
 	git rebase -p --no-gpg-sign --onto=one fork-point main &&
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 49010aa9469..3b0fa66c33d 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -238,6 +238,7 @@ test_expect_success 'allow skipping commit but not abort for a new history' '
 '
 
 test_expect_success 'allow skipping stopped cherry-pick because of untracked file modifications' '
+	test_when_finished "rm unrelated" &&
 	pristine_detach initial &&
 	git rm --cached unrelated &&
 	git commit -m "untrack unrelated" &&
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 7cabb85ca6e..8ae314af585 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -291,6 +291,7 @@ test_expect_success 'prune: handle HEAD reflog in multiple worktrees' '
 		cat ../expected >blob &&
 		git add blob &&
 		git commit -m "second commit in third" &&
+		git clean -f && # Remove untracked left behind by deleting index
 		git reset --hard HEAD^
 	) &&
 	git prune --expire=now &&
diff --git a/t/t6415-merge-dir-to-symlink.sh b/t/t6415-merge-dir-to-symlink.sh
index 2ce104aca7c..2655e295f5a 100755
--- a/t/t6415-merge-dir-to-symlink.sh
+++ b/t/t6415-merge-dir-to-symlink.sh
@@ -25,7 +25,8 @@ test_expect_success 'checkout does not clobber untracked symlink' '
 	git reset --hard main &&
 	git rm --cached a/b &&
 	git commit -m "untracked symlink remains" &&
-	test_must_fail git checkout start^0
+	test_must_fail git checkout start^0 &&
+	git clean -fd    # Do not leave the untracked symlink in the way
 '
 
 test_expect_success 'a/b-2/c/d is kept when clobbering symlink b' '
@@ -34,7 +35,8 @@ test_expect_success 'a/b-2/c/d is kept when clobbering symlink b' '
 	git rm --cached a/b &&
 	git commit -m "untracked symlink remains" &&
 	git checkout -f start^0 &&
-	test_path_is_file a/b-2/c/d
+	test_path_is_file a/b-2/c/d &&
+	git clean -fd    # Do not leave the untracked symlink in the way
 '
 
 test_expect_success 'checkout should not have deleted a/b-2/c/d' '
diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
index 5e3779ebc93..89dd544f388 100755
--- a/t/t6424-merge-unrelated-index-changes.sh
+++ b/t/t6424-merge-unrelated-index-changes.sh
@@ -132,6 +132,7 @@ test_expect_success 'merge-recursive, when index==head but head!=HEAD' '
 
 	# Make index match B
 	git diff C B -- | git apply --cached &&
+	test_when_finished "git clean -fd" &&  # Do not leave untracked around
 	# Merge B & F, with B as "head"
 	git merge-recursive A -- B F > out &&
 	test_i18ngrep "Already up to date" out
diff --git a/t/t6430-merge-recursive.sh b/t/t6430-merge-recursive.sh
index ffcc01fe65d..a0efe7cb6db 100755
--- a/t/t6430-merge-recursive.sh
+++ b/t/t6430-merge-recursive.sh
@@ -718,7 +718,9 @@ test_expect_success 'merge-recursive remembers the names of all base trees' '
 	# merge-recursive prints in reverse order, but we do not care
 	sort <trees >expect &&
 	sed -n "s/^virtual //p" out | sort >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+
+	git clean -fd
 '
 
 test_expect_success 'merge-recursive internal merge resolves to the sameness' '
diff --git a/t/t6436-merge-overwrite.sh b/t/t6436-merge-overwrite.sh
index 84b4aacf496..c0b7bd7c3fe 100755
--- a/t/t6436-merge-overwrite.sh
+++ b/t/t6436-merge-overwrite.sh
@@ -68,7 +68,8 @@ test_expect_success 'will not overwrite removed file' '
 	git commit -m "rm c1.c" &&
 	cp important c1.c &&
 	test_must_fail git merge c1a &&
-	test_cmp important c1.c
+	test_cmp important c1.c &&
+	rm c1.c  # Do not leave untracked file in way of future tests
 '
 
 test_expect_success 'will not overwrite re-added file' '
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 7f6e23a4bb9..b7ba1c3268e 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -585,6 +585,7 @@ test_expect_success 'checkout --conflict=diff3' '
 '
 
 test_expect_success 'failing checkout -b should not break working tree' '
+	git clean -fd &&  # Remove untracked files in the way
 	git reset --hard main &&
 	git symbolic-ref HEAD refs/heads/main &&
 	test_must_fail git checkout -b renamer side^ &&
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 2ef39d3088e..c773e30b3fa 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -717,6 +717,7 @@ test_expect_success 'failed fast-forward merge with --autostash' '
 	git reset --hard c0 &&
 	git merge-file file file.orig file.5 &&
 	cp file.5 other &&
+	test_when_finished "rm other" &&
 	test_must_fail git merge --autostash c1 2>err &&
 	test_i18ngrep "Applied autostash." err &&
 	test_cmp file.5 file

base-commit: e0a2f5cbc585657e757385ad918f167f519cfb96
-- 
gitgitgadget
