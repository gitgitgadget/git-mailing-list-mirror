Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6D6C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbiCINTj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbiCINTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:19:25 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E533179274
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:18:01 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u1so2962049wrg.11
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kXuHhGZkmEKFdBnjBbLuSyBLTsXpbVknEr7XXYCIv74=;
        b=cZ8Zg7Kd1cCsBzxlRNYmhRp5/VxIzBOHm8ACiwHd2M5nhn+p2KZMiPZSiZLROsqDca
         Aghr2fkCf2ZgHiSmCYW7Zp2F1QNZjSHFaKybSbrL2WivqolSjiVwyKdgClod8s2HO9xK
         LYJEcmusBJuyDlIRZbAbJoi+4IGOtVe6+hoJxeBA7uzGkDgwR8yk3AqumyXRAzu2SbmE
         LrTpBz5ulSmGCaxkKv+kphfwSGtvb1fq6H/CSQDIMtmtsxOgd2C+q7w4+3C+vT7mrAie
         gUV8lhjbUZ4WA4YiJ6t2x7076K0oFqITPhtLHuMRGN7gEKrD4Ng3bRyGoCVri6/o3Y3L
         eCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kXuHhGZkmEKFdBnjBbLuSyBLTsXpbVknEr7XXYCIv74=;
        b=ZPELZtCMRMBnUrLVq/FNx30oeQe/4w+7jieKr/49hL4r3YcbZg/uudQzaocC2qHfGv
         Q9NfRy6IOMdYRtrdETJ39ssz4b1ItPksHNfRjLcy+xntCc9cGE6mnagZnc4Eimp4EZsJ
         c3V9re274JKUehKCotaCEaR+LP2t1ihrtY3S+UzE1BBJBJnRrK/2erPXlisS2sVAN3K6
         J7CWcliVjz2s1KrgniMnuH1sCpLCHEHhXEHsmMNLfMDVSeqvC8Zj+3kXe2Re3vqgvQQi
         hOw4DcAxESZ4MfUwW77Ppm2VK1SOk539HGmm0Dn+a07fo3m9WBXi1TqmvEBluzKv/avz
         QgsQ==
X-Gm-Message-State: AOAM531jow5IdIRe4Se1C2EsU2mI+AW1thWPSFYD3HNyIBkuYNT+IrBC
        HsMQB+oWp8K1YmPVio8H8S3tp5RfXCCJGQ==
X-Google-Smtp-Source: ABdhPJzjszYpnKdEuYTKz5/NaeUcGzd4xCPGf7gVOj4easVQUJ5gHEzVmJa76NVo0d0ix6AHLc4/Vw==
X-Received: by 2002:a5d:5241:0:b0:1f0:1842:efbd with SMTP id k1-20020a5d5241000000b001f01842efbdmr15241697wrc.320.1646831879014;
        Wed, 09 Mar 2022 05:17:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:17:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 17/24] revisions API: have release_revisions() release "cmdline"
Date:   Wed,  9 Mar 2022 14:16:47 +0100
Message-Id: <patch-17.24-b5687ed1355-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the the release_revisions() function so that it frees the
"cmdline" in the "struct ref_info". This in combination with a
preceding change to free "commits" and "mailmap" means that we can
whitelist another test under "TEST_PASSES_SANITIZE_LEAK=true".

There was a proposal in [1] to do away with xstrdup()-ing this
add_rev_cmdline(), perhaps that would be worthwhile, but for now let's
just free() it.

We could also make that a "char *" in "struct rev_cmdline_entry"
itself, but since we own it let's expose it as a constant to outside
callers. I proposed that in [2] but have since changed my mind. See
14d30cdfc04 (ref-filter: fix memory leak in `free_array_item()`,
2019-07-10), c514c62a4fd (checkout: fix leak of non-existent branch
names, 2020-08-14) and other log history hits for "free((char *)" for
prior art.

This includes the tests we had false-positive passes on before my
6798b08e848 (perl Git.pm: don't ignore signalled failure in
_cmd_close(), 2022-02-01), now they pass for real.

Since there are 66 tests matching t/t[0-9]*git-svn*.sh it's easier to
list those that don't pass than to touch most of those 66. So let's
introduce a "TEST_FAILS_SANITIZE_LEAK=true", which if set in the tests
won't cause lib-git-svn.sh to set "TEST_PASSES_SANITIZE_LEAK=true.

This change also marks all the tests that we removed
"TEST_FAILS_SANITIZE_LEAK=true" from in an earlier commit due to
removing the UNLEAK() from cmd_format_patch(), we can now assert that
its API use doesn't leak any "struct rev_info" memory.

This change also made commit "t5503-tagfollow.sh" pass on current
master, but that would regress when combined with
ps/fetch-atomic-fixup's de004e848a9 (t5503: simplify setup of test
which exercises failure of backfill, 2022-03-03) (through no fault of
that topic, that change started using "git clone" in the test, which
has an outstanding leak). Let's leave that test out for now to avoid
in-flight semantic conflicts.

1. https://lore.kernel.org/git/YUj%2FgFRh6pwrZalY@carlos-mbp.lan/
2. https://lore.kernel.org/git/87o88obkb1.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

fixup with bc0e0439040?
---
 revision.c                                       | 12 ++++++++++++
 t/lib-git-svn.sh                                 |  4 ++++
 t/t0062-revision-walking.sh                      |  1 +
 t/t0101-at-syntax.sh                             |  2 ++
 t/t1060-object-corruption.sh                     |  2 ++
 t/t2015-checkout-unborn.sh                       |  1 +
 t/t3408-rebase-multi-line.sh                     |  1 +
 t/t4207-log-decoration-colors.sh                 |  1 +
 t/t4212-log-corrupt.sh                           |  1 +
 t/t5313-pack-bounds-checks.sh                    |  2 ++
 t/t5322-pack-objects-sparse.sh                   |  1 +
 t/t5506-remote-groups.sh                         |  1 +
 t/t5513-fetch-track.sh                           |  1 +
 t/t5515-fetch-merge-logic.sh                     |  1 +
 t/t5518-fetch-exit-status.sh                     |  1 +
 t/t5532-fetch-proxy.sh                           |  2 ++
 t/t5900-repo-selection.sh                        |  2 ++
 t/t6002-rev-list-bisect.sh                       |  1 +
 t/t6003-rev-list-topo-order.sh                   |  1 +
 t/t6018-rev-list-glob.sh                         |  1 +
 t/t6019-rev-list-ancestry-path.sh                |  1 +
 t/t6100-rev-list-in-order.sh                     |  1 +
 t/t6101-rev-parse-parents.sh                     |  1 +
 t/t6114-keep-packs.sh                            |  2 ++
 t/t7702-repack-cyclic-alternate.sh               |  2 ++
 t/t9100-git-svn-basic.sh                         |  1 +
 t/t9101-git-svn-props.sh                         |  2 ++
 t/t9104-git-svn-follow-parent.sh                 |  2 ++
 t/t9106-git-svn-commit-diff-clobber.sh           |  2 ++
 t/t9122-git-svn-author.sh                        |  2 ++
 t/t9129-git-svn-i18n-commitencoding.sh           |  1 +
 t/t9139-git-svn-non-utf8-commitencoding.sh       |  1 +
 t/t9148-git-svn-propset.sh                       |  1 +
 t/t9151-svn-mergeinfo.sh                         |  1 +
 t/t9157-git-svn-fetch-merge.sh                   |  2 ++
 t/t9159-git-svn-no-parent-mergeinfo.sh           |  2 ++
 t/t9161-git-svn-mergeinfo-push.sh                |  1 +
 t/t9162-git-svn-dcommit-interactive.sh           |  2 ++
 t/t9163-git-svn-reset-clears-caches.sh           |  1 +
 t/t9165-git-svn-fetch-merge-branch-of-branch.sh  |  2 ++
 t/t9166-git-svn-fetch-merge-branch-of-branch2.sh |  2 ++
 41 files changed, 71 insertions(+)

diff --git a/revision.c b/revision.c
index 2050a691683..6c83a715dee 100644
--- a/revision.c
+++ b/revision.c
@@ -2926,6 +2926,17 @@ static void release_revisions_commit_list(struct rev_info *revs)
 	revs->commits = NULL;
 }
 
+static void release_revisions_cmdline(struct rev_cmdline_info *cmdline)
+{
+	unsigned int i;
+
+	if (!cmdline)
+		return;
+	for (i = 0; i < cmdline->nr; i++)
+		free((char *)cmdline->rev[i].name);
+	FREE_AND_NULL(cmdline->rev);
+}
+
 static void release_revisions_mailmap(struct string_list *mailmap)
 {
 	if (!mailmap)
@@ -2940,6 +2951,7 @@ void release_revisions(struct rev_info *revs)
 		return;
 	release_revisions_commit_list(revs);
 	object_array_clear(&revs->pending);
+	release_revisions_cmdline(&revs->cmdline);
 	release_revisions_mailmap(revs->mailmap);
 }
 
diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 2fde2353fd3..ea28971e8ee 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -1,3 +1,7 @@
+if test -z "$TEST_FAILS_SANITIZE_LEAK"
+then
+	TEST_PASSES_SANITIZE_LEAK=true
+fi
 . ./test-lib.sh
 
 if test -n "$NO_SVN_TESTS"
diff --git a/t/t0062-revision-walking.sh b/t/t0062-revision-walking.sh
index 8e215867b8c..b9480c81781 100755
--- a/t/t0062-revision-walking.sh
+++ b/t/t0062-revision-walking.sh
@@ -5,6 +5,7 @@
 
 test_description='Test revision walking api'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >run_twice_expected <<-EOF
diff --git a/t/t0101-at-syntax.sh b/t/t0101-at-syntax.sh
index a1998b558f9..878aadd64c9 100755
--- a/t/t0101-at-syntax.sh
+++ b/t/t0101-at-syntax.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='various @{whatever} syntax tests'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index bc89371f534..5b8e47e346c 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='see how we handle various forms of corruption'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # convert "1234abcd" to ".git/objects/12/34abcd"
diff --git a/t/t2015-checkout-unborn.sh b/t/t2015-checkout-unborn.sh
index a9721215fab..9425aae6395 100755
--- a/t/t2015-checkout-unborn.sh
+++ b/t/t2015-checkout-unborn.sh
@@ -4,6 +4,7 @@ test_description='checkout from unborn branch'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3408-rebase-multi-line.sh b/t/t3408-rebase-multi-line.sh
index cde3562e3a6..7b4607d72f2 100755
--- a/t/t3408-rebase-multi-line.sh
+++ b/t/t3408-rebase-multi-line.sh
@@ -5,6 +5,7 @@ test_description='rebasing a commit with multi-line first paragraph.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index b8709424981..36ac6aff1e4 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -8,6 +8,7 @@ test_description='Test for "git log --decorate" colors'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
index 0244888a5a7..30a219894bb 100755
--- a/t/t4212-log-corrupt.sh
+++ b/t/t4212-log-corrupt.sh
@@ -2,6 +2,7 @@
 
 test_description='git log with invalid commit headers'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5313-pack-bounds-checks.sh b/t/t5313-pack-bounds-checks.sh
index 535313e4dc8..cc4cfaa9d37 100755
--- a/t/t5313-pack-bounds-checks.sh
+++ b/t/t5313-pack-bounds-checks.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='bounds-checking of access to mmapped on-disk file formats'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 clear_base () {
diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
index d39958c066d..770695c9278 100755
--- a/t/t5322-pack-objects-sparse.sh
+++ b/t/t5322-pack-objects-sparse.sh
@@ -4,6 +4,7 @@ test_description='pack-objects object selection using sparse algorithm'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup repo' '
diff --git a/t/t5506-remote-groups.sh b/t/t5506-remote-groups.sh
index 8f150c0793e..5bac03ede81 100755
--- a/t/t5506-remote-groups.sh
+++ b/t/t5506-remote-groups.sh
@@ -4,6 +4,7 @@ test_description='git remote group handling'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 mark() {
diff --git a/t/t5513-fetch-track.sh b/t/t5513-fetch-track.sh
index 65d1e05bd62..c46c4dbaefc 100755
--- a/t/t5513-fetch-track.sh
+++ b/t/t5513-fetch-track.sh
@@ -2,6 +2,7 @@
 
 test_description='fetch follows remote-tracking branches correctly'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 320d26796d2..c100a809c5e 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -14,6 +14,7 @@ export GIT_TEST_PROTOCOL_VERSION
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 build_script () {
diff --git a/t/t5518-fetch-exit-status.sh b/t/t5518-fetch-exit-status.sh
index 5c4ac2556e7..c13120088fa 100755
--- a/t/t5518-fetch-exit-status.sh
+++ b/t/t5518-fetch-exit-status.sh
@@ -8,6 +8,7 @@ test_description='fetch exit status test'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5532-fetch-proxy.sh b/t/t5532-fetch-proxy.sh
index 9c2798603b4..d664912799b 100755
--- a/t/t5532-fetch-proxy.sh
+++ b/t/t5532-fetch-proxy.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='fetching via git:// using core.gitproxy'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup remote repo' '
diff --git a/t/t5900-repo-selection.sh b/t/t5900-repo-selection.sh
index 14e59c5b3e4..a84faac242d 100755
--- a/t/t5900-repo-selection.sh
+++ b/t/t5900-repo-selection.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='selecting remote repo in ambiguous cases'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 reset() {
diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index b95a0212adf..162cf50778d 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -4,6 +4,7 @@
 #
 test_description='Tests git rev-list --bisect functionality'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-t6000.sh # t6xxx specific functions
 
diff --git a/t/t6003-rev-list-topo-order.sh b/t/t6003-rev-list-topo-order.sh
index 24d1836f417..1f7d7dd20c1 100755
--- a/t/t6003-rev-list-topo-order.sh
+++ b/t/t6003-rev-list-topo-order.sh
@@ -5,6 +5,7 @@
 
 test_description='Tests git rev-list --topo-order functionality'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-t6000.sh # t6xxx specific functions
 
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index 24b34add833..e1abc5c2b32 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -5,6 +5,7 @@ test_description='rev-list/rev-parse --glob'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 commit () {
diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
index af57a04b7ff..66f787606ec 100755
--- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -24,6 +24,7 @@ test_description='--ancestry-path'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_merge () {
diff --git a/t/t6100-rev-list-in-order.sh b/t/t6100-rev-list-in-order.sh
index e934bc239c5..88ed7bd75a7 100755
--- a/t/t6100-rev-list-in-order.sh
+++ b/t/t6100-rev-list-in-order.sh
@@ -2,6 +2,7 @@
 
 test_description='rev-list testing in-commit-order'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup a commit history with trees, blobs' '
diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index c571fa51797..a3a41c7a3e4 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -8,6 +8,7 @@ test_description='Test git rev-parse with different parent options'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_cmp_rev_output () {
diff --git a/t/t6114-keep-packs.sh b/t/t6114-keep-packs.sh
index 9239d8aa46d..44246f8a63e 100755
--- a/t/t6114-keep-packs.sh
+++ b/t/t6114-keep-packs.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='rev-list with .keep packs'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7702-repack-cyclic-alternate.sh b/t/t7702-repack-cyclic-alternate.sh
index 93b74867ac8..f3cdb98eec2 100755
--- a/t/t7702-repack-cyclic-alternate.sh
+++ b/t/t7702-repack-cyclic-alternate.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='repack involving cyclic alternate'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index fea41b3c360..7c5b847f584 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -8,6 +8,7 @@ test_description='git svn basic tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 prepare_utf8_locale
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 8b5681dd68a..d043e80fc34 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='git svn property tests'
+
+TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 mkdir import
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index c7d8e0bf00f..5cf2ef4b8b0 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='git svn fetching'
+
+TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'initialize repo' '
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index aec45bca3b7..3cab0b9720a 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -2,6 +2,8 @@
 #
 # Copyright (c) 2006 Eric Wong
 test_description='git svn commit-diff clobber'
+
+TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'initialize repo' '
diff --git a/t/t9122-git-svn-author.sh b/t/t9122-git-svn-author.sh
index 9e8fe38e7ef..527ba3d2932 100755
--- a/t/t9122-git-svn-author.sh
+++ b/t/t9122-git-svn-author.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='git svn authorship'
+
+TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'setup svn repository' '
diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i18n-commitencoding.sh
index 01e1e8a8f76..185248a4cd7 100755
--- a/t/t9129-git-svn-i18n-commitencoding.sh
+++ b/t/t9129-git-svn-i18n-commitencoding.sh
@@ -4,6 +4,7 @@
 
 test_description='git svn honors i18n.commitEncoding in config'
 
+TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 compare_git_head_with () {
diff --git a/t/t9139-git-svn-non-utf8-commitencoding.sh b/t/t9139-git-svn-non-utf8-commitencoding.sh
index 22d80b0be2b..b7f756b2b7f 100755
--- a/t/t9139-git-svn-non-utf8-commitencoding.sh
+++ b/t/t9139-git-svn-non-utf8-commitencoding.sh
@@ -4,6 +4,7 @@
 
 test_description='git svn refuses to dcommit non-UTF8 messages'
 
+TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 # ISO-2022-JP can pass for valid UTF-8, so skipping that in this test
diff --git a/t/t9148-git-svn-propset.sh b/t/t9148-git-svn-propset.sh
index aebb28995e5..6cc76a07b39 100755
--- a/t/t9148-git-svn-propset.sh
+++ b/t/t9148-git-svn-propset.sh
@@ -5,6 +5,7 @@
 
 test_description='git svn propset tests'
 
+TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'setup propset via import' '
diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index c93a5beab25..85221d439bd 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -5,6 +5,7 @@
 
 test_description='git-svn svn mergeinfo properties'
 
+TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'load svn dump' "
diff --git a/t/t9157-git-svn-fetch-merge.sh b/t/t9157-git-svn-fetch-merge.sh
index 991d2aa1be6..4d8cfdf8446 100755
--- a/t/t9157-git-svn-fetch-merge.sh
+++ b/t/t9157-git-svn-fetch-merge.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='git svn merge detection'
+
+TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 svn_ver="$(svn --version --quiet)"
diff --git a/t/t9159-git-svn-no-parent-mergeinfo.sh b/t/t9159-git-svn-no-parent-mergeinfo.sh
index 69e4815781c..ce42487a507 100755
--- a/t/t9159-git-svn-no-parent-mergeinfo.sh
+++ b/t/t9159-git-svn-no-parent-mergeinfo.sh
@@ -1,5 +1,7 @@
 #!/bin/sh
 test_description='git svn handling of root commits in merge ranges'
+
+TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 svn_ver="$(svn --version --quiet)"
diff --git a/t/t9161-git-svn-mergeinfo-push.sh b/t/t9161-git-svn-mergeinfo-push.sh
index f113acaa6c2..89f2518685c 100755
--- a/t/t9161-git-svn-mergeinfo-push.sh
+++ b/t/t9161-git-svn-mergeinfo-push.sh
@@ -6,6 +6,7 @@
 
 test_description='git-svn svn mergeinfo propagation'
 
+TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'load svn dump' "
diff --git a/t/t9162-git-svn-dcommit-interactive.sh b/t/t9162-git-svn-dcommit-interactive.sh
index e38d9fa37b5..e2aa8ed88a9 100755
--- a/t/t9162-git-svn-dcommit-interactive.sh
+++ b/t/t9162-git-svn-dcommit-interactive.sh
@@ -3,6 +3,8 @@
 # Copyright (c) 2011 Frédéric Heitzmann
 
 test_description='git svn dcommit --interactive series'
+
+TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'initialize repo' '
diff --git a/t/t9163-git-svn-reset-clears-caches.sh b/t/t9163-git-svn-reset-clears-caches.sh
index 978eb62ff4f..e457cf28153 100755
--- a/t/t9163-git-svn-reset-clears-caches.sh
+++ b/t/t9163-git-svn-reset-clears-caches.sh
@@ -7,6 +7,7 @@ test_description='git svn reset clears memoized caches'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 svn_ver="$(svn --version --quiet)"
diff --git a/t/t9165-git-svn-fetch-merge-branch-of-branch.sh b/t/t9165-git-svn-fetch-merge-branch-of-branch.sh
index a4813c2b09c..58b736dc132 100755
--- a/t/t9165-git-svn-fetch-merge-branch-of-branch.sh
+++ b/t/t9165-git-svn-fetch-merge-branch-of-branch.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='git svn merge detection'
+
+TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 svn_ver="$(svn --version --quiet)"
diff --git a/t/t9166-git-svn-fetch-merge-branch-of-branch2.sh b/t/t9166-git-svn-fetch-merge-branch-of-branch2.sh
index 52f2e46a5b4..9f7deb26d0e 100755
--- a/t/t9166-git-svn-fetch-merge-branch-of-branch2.sh
+++ b/t/t9166-git-svn-fetch-merge-branch-of-branch2.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='git svn merge detection'
+
+TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 svn_ver="$(svn --version --quiet)"
-- 
2.35.1.1295.g6b025d3e231

