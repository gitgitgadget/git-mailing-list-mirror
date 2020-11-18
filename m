Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D21C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 11:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30B04207D3
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 11:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2RnO5nj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgKRLsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 06:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgKRLsw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 06:48:52 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E49C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 03:48:51 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c17so1841660wrc.11
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 03:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lSegqNfvWDiP613ePWQpHYT7Fxcp40Jd75rX0gXDmv8=;
        b=O2RnO5njA+uq3nHu3gSXSlP13sCQHu9IK87mxbOwVEbcj/hEk5PRn+6YP0Bh/DG3XM
         vj0O3Usx+WEcm9GQul990s8i6RqGNfG9PotuO571jVcxvp73UKRmIOL+cJXmJZtKhPKZ
         qt83Ml6wBVeMMpPpQKfGaKUhk/OS7hm2EDhVb3y6oucaqbWqR94K5KYdMRXP/QiLQZsQ
         P9RQ28n+aDsPTWlfFQdcGZZWUAWuNglFbP8RvAxrslm2fsl+8t/f1fT5NCDLOQMzbGyG
         D4PK+S5FqGm4K5Yz6cHsEbZU+/EMB92e/mkOgdxWTyjmgrL1aXv4kwV3+/JIR4Sq0VgH
         aCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lSegqNfvWDiP613ePWQpHYT7Fxcp40Jd75rX0gXDmv8=;
        b=S5fJPIXk5f/moy+D62bTi5JMjZoWOJtB+9H1dFDHE+eZYwsE76bJEXgprPUP+idlSV
         HMqMCrNxDkPEkCxCHb2oQybs5H3cjJb3e1ABj7+jt2ZtrnbPurEbup5kfckoLbtR1GRq
         mJpPATbt7Cd1yzYaqiDZ5fiI/vwSkMi8Xhz8iYMlxULsd1TTiCbKGNorT3twVj/4nZVR
         +ZZ68rmvdCHP3kohzsm4tbIixVJl9ZX1GXWnJ3o62sNGKugMJU84w8cCoB+ASQbO1me5
         NND/nLQywDxLgVG8Q3hcnnQtCqTIhZqRUjEHUzu/o2Ig+9irNxDw/k6W7acI481gyAnw
         54kQ==
X-Gm-Message-State: AOAM531wPMjUev31uBdMuGDLFpA6bvho7TlR3tq2pQTPi6AKpaK2WN+E
        pY9Q8uLrMmjvK9vHxz39/irZO6p8Af0=
X-Google-Smtp-Source: ABdhPJyIL4G4GyOVhsI0Wi1h+lErZuLvoMi9kSrthinNz17HQ+LnvT8QV1wiN/Sd3WwBM3BiuwGggg==
X-Received: by 2002:adf:cd8d:: with SMTP id q13mr4456072wrj.61.1605700130026;
        Wed, 18 Nov 2020 03:48:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b17sm32679462wru.12.2020.11.18.03.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 03:48:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 28/27] tests: run tests omitted by PREPARE_FOR_MAIN_BRANCH
Date:   Wed, 18 Nov 2020 12:48:34 +0100
Message-Id: <20201118114834.11137-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reinstate the test coverage lost due to PREPARE_FOR_MAIN_BRANCH. The
remaining impact of that prerequisite was mainly missing coverage from
submodule fetches being lost[1], e.g. impacting my in-flight
ab/retire-parse-remote. Now the prerequisite is effectively a
noop. This goes on top of [2].

I'm not removing the PREPARE_FOR_MAIN_BRANCH prerequisite to keep this
change small, instead it's now effectively a noop. It can be removed
in some later change.

The only remaining occurrences in t5526-fetch-submodules.sh can be
removed without breakage with:

    perl -pi -e 's/PREPARE_FOR_MAIN_BRANCH //g' t/t5526-fetch-submodules.sh

Which at this point leaves only the now-unused prerequisite
declaration in test-lib.sh.

The coverage in t9902-completion.sh was restored by partially
reverting[3]. After that we were left with one test in a mixed
state. It setup "master" but tested for "mai". Change it back to
"mas", pending a more complete refactoring of that test.

This change only conflicts between next..seen by clashing with Peter
Kaestle's in-flights submodule fix[4]. Fixing the resulting logic
error in t5526-fetch-submodules.sh is trivial, simply:

    - compare_refs_in_dir A origin/master B origin/master
    + compare_refs_in_dir A origin/main B origin/main

1. 66713e84e7 ("tests: prepare aligned mentions of the default branch name", 2020-10-23)
2. https://public-inbox.org/git/pull.762.v2.git.1605629547.gitgitgadget@gmail.com/
3. 8164360fc8 ("t9902: prepare a test for the upcoming default branch name", 2020-10-23)
4. https://public-inbox.org/git/1605196853-37359-1-git-send-email-peter.kaestle@nokia.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Tue, Nov 17 2020, Johannes Schindelin via GitGitGadget wrote:
> To avoid even more conflicts with topics that did not even make it to seen 
> yet, this patch series specifically excludes t3404, t4013, t5310, t5526,
> t6300, t7064, t7817, t9902: in those test scripts, we will still use master 
> for the time being. Once the topics in question have settled, I will send
> the appropriate follow-up patches to adjust them to use main instead.

This is not a replacement for that subsequent cleanup, but seems like
a simple enough thing to have now to reinstate the missing test
coverage.

Perhaps there's some topics not in "seen" that you have in mind as
conflicting, but as noted above the conflict produced here with
in-flight in "seen" is trivial.

Seems worth having that sooner than later if Junio's willing juggle
that.

 t/t5526-fetch-submodules.sh | 6 +++---
 t/t9902-completion.sh       | 6 +++---
 t/test-lib.sh               | 9 +++------
 3 files changed, 9 insertions(+), 12 deletions(-)

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
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 5c01c75d40..3696b85acb 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1055,13 +1055,13 @@ test_expect_success 'teardown after filtering matching refs' '
 	git -C otherrepo branch -D matching/branch-in-other
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH '__git_refs - for-each-ref format specifiers in prefix' '
+test_expect_success '__git_refs - for-each-ref format specifiers in prefix' '
 	cat >expected <<-EOF &&
 	evil-%%-%42-%(refname)..master
 	EOF
 	(
-		cur="evil-%%-%42-%(refname)..mai" &&
-		__git_refs "" "" "evil-%%-%42-%(refname).." mai >"$actual"
+		cur="evil-%%-%42-%(refname)..mas" &&
+		__git_refs "" "" "evil-%%-%42-%(refname).." mas >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index d39bdf04ce..ed489b2213 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -257,7 +257,7 @@ case "$TRASH_DIRECTORY" in
 esac
 
 case "$TEST_NUMBER" in
-3404|4013|5310|5526|6300|7064|7817|9902)
+3404|4013|5310|6300|7064|7817|9902)
 	# Avoid conflicts with patch series that are cooking at the same time
 	# as the patch series changing the default of `init.defaultBranch`.
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
@@ -1725,12 +1725,9 @@ test_lazy_prereq REBASE_P '
 	test -z "$GIT_TEST_SKIP_REBASE_P"
 '
 
-# Special-purpose prereq for transitioning to a new default branch name:
-# Some tests need more than just a mindless (case-preserving) s/master/main/g
-# replacement. The non-trivial adjustments are guarded behind this
-# prerequisite, acting kind of as a feature flag
+# Obsolete, do not use, removed soon!
 test_lazy_prereq PREPARE_FOR_MAIN_BRANCH '
-	test "$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME" = main
+	test "$TEST_NAME" = "t5526-fetch-submodules"
 '
 
 # Ensure that no test accidentally triggers a Git command
-- 
2.29.2.222.g5d2a92d10f8

