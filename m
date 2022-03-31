Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1FEC433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348737AbiCaBOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352287AbiCaBOW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:14:22 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D305C66C89
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:23 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r13so31517341wrr.9
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g2OVi0jtdLZ/Y/u/FXD3UiUkeS3O98os+i+NF6/uOJw=;
        b=aR43qYLUcYc4edzbWWNrlhkJ2vumlztcV/FbsTx0fVCbRKLagjW2PE3tbW60Z4pbzo
         nrafZE9mQrdINYj8ETuTPu6XJ1kM9OBI/snnWlyypdWuRTHG2X/RfYg2YnnwgAymHM36
         yTfly1zdKlZUD2UtrPAjEiakSW2OU3gvqDiofVrUANIvOGDSuKL7TKEqbf0Zv3jxXbMn
         Bc8RD8JWg+j6g/DdfyyZs8X+mW54DvQxLrl8HzxLlNoX7NnjDnTIq5cpxB31Y8ojlbYB
         Pv+dNVpyojCaBHvGcATeIgSlyI3R4nTdL7UwXvLkWgYtcQJ6BA0gtyQJ+Kg1nLojiO7A
         jFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g2OVi0jtdLZ/Y/u/FXD3UiUkeS3O98os+i+NF6/uOJw=;
        b=HpGkmiSgArdMxBWjR6FR9nzPDaDXcTfqpkyyVTWFudCqHg0/AqEKtebmI8C/w5r0Pt
         1a5cvPurxQh8JWtUS+d+Gx4T1WmUPl65XxoXjnuUTxKr9dVQ7Lw2w1gxquoueQh1nfhY
         YQwsgWDiHbB82Z8XRUhXKCV+Igqi+mOZ91wlCNlOG3iaFEOL704fc2f2AhbcAW6pPH6u
         WfSutfDLfI06nCLSDdzYmftJ+dz6kyY1Wpg7bTPLFBngF4yYHcuLhuEVoaCcDw3ogAsP
         Gec58qJk98TTt1QpuiIE37SjFLFlvXGzuhgirIl35KuCMs01v2oFybnsUyvJoudhArgx
         4YsA==
X-Gm-Message-State: AOAM532XGou4pdH0tNCOjM0rjmG/M0X+cc8kXMhQBXMCSmiSVIORWDKe
        IHmunU+5daSJyZfURQPQbAFOOVoIju8+aA==
X-Google-Smtp-Source: ABdhPJxbEQGx/9G+X4jjuMc7DGv/mcZiZ17OSO3gS7tniwhSViVqJio07gejrgbYQ1zsJPri8VUqvA==
X-Received: by 2002:a05:6000:1545:b0:205:a82d:8007 with SMTP id 5-20020a056000154500b00205a82d8007mr2077202wry.88.1648689142000;
        Wed, 30 Mar 2022 18:12:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5789218wmv.31.2022.03.30.18.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:12:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 19/27] revisions API: have release_revisions() release "filter"
Date:   Thu, 31 Mar 2022 03:11:24 +0200
Message-Id: <patch-v4-19.27-065c3cc91b2-20220331T005325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1557.g4e3e9cdb5e0
In-Reply-To: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com> <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the the release_revisions() function so that it frees the
"filter" in the "struct rev_info". This in combination with a
preceding change to free "cmdline" means that we can mark another set
of tests as passing under "TEST_PASSES_SANITIZE_LEAK=true".

The "filter" member was added recently in ffaa137f646 (revision: put
object filter into struct rev_info, 2022-03-09), and this fixes leaks
intruded in the subsequent leak 7940941de1f (pack-objects: use
rev.filter when possible, 2022-03-09) and 105c6f14ad3 (bundle: parse
filter capability, 2022-03-09).

The "builtin/pack-objects.c" leak in 7940941de1f was effectively with
us already, but the variable was referred to by a "static" file-scoped
variable. The "bundle.c " leak in 105c6f14ad3 was newly introduced
with the new "filter" feature for bundles.

The "t5600-clone-fail-cleanup.sh" change here to add
"TEST_PASSES_SANITIZE_LEAK=true" is one of the cases where
run-command.c in not carrying the abort() exit code upwards would have
had that test passing before, but now it *actually* passes[1]. We
should fix the lack of 1=1 mapping of SANITIZE=leak testing to actual
leaks some other time, but it's an existing edge case, let's just mark
the really-passing test as passing for now.

1. https://lore.kernel.org/git/220303.86fsnz5o9w.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c                         | 1 +
 t/t1060-object-corruption.sh       | 1 +
 t/t2015-checkout-unborn.sh         | 1 +
 t/t4207-log-decoration-colors.sh   | 1 +
 t/t5301-sliding-window.sh          | 2 ++
 t/t5313-pack-bounds-checks.sh      | 2 ++
 t/t5316-pack-delta-depth.sh        | 2 ++
 t/t5320-delta-islands.sh           | 2 ++
 t/t5322-pack-objects-sparse.sh     | 1 +
 t/t5506-remote-groups.sh           | 1 +
 t/t5513-fetch-track.sh             | 1 +
 t/t5532-fetch-proxy.sh             | 2 ++
 t/t5600-clone-fail-cleanup.sh      | 1 +
 t/t5900-repo-selection.sh          | 2 ++
 t/t6101-rev-parse-parents.sh       | 1 +
 t/t6114-keep-packs.sh              | 2 ++
 t/t7702-repack-cyclic-alternate.sh | 2 ++
 t/t9127-git-svn-partial-rebuild.sh | 1 -
 18 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 8177afebda8..2d52f1b518d 100644
--- a/revision.c
+++ b/revision.c
@@ -2959,6 +2959,7 @@ void release_revisions(struct rev_info *revs)
 	release_revisions_commit_list(revs);
 	object_array_clear(&revs->pending);
 	release_revisions_cmdline(&revs->cmdline);
+	list_objects_filter_release(&revs->filter);
 	release_revisions_mailmap(revs->mailmap);
 }
 
diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index e8a58b15897..5b8e47e346c 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -2,6 +2,7 @@
 
 test_description='see how we handle various forms of corruption'
 
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
diff --git a/t/t5301-sliding-window.sh b/t/t5301-sliding-window.sh
index 76f9798ab95..3ccaaeb3977 100755
--- a/t/t5301-sliding-window.sh
+++ b/t/t5301-sliding-window.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='mmap sliding window tests'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success \
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
diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
index e9045009a11..eb4ef3dda4d 100755
--- a/t/t5316-pack-delta-depth.sh
+++ b/t/t5316-pack-delta-depth.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='pack-objects breaks long cross-pack delta chains'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This mirrors a repeated push setup:
diff --git a/t/t5320-delta-islands.sh b/t/t5320-delta-islands.sh
index fea92a5777f..124d47603df 100755
--- a/t/t5320-delta-islands.sh
+++ b/t/t5320-delta-islands.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='exercise delta islands'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # returns true iff $1 is a delta based on $2
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
diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup.sh
index 34b3df40275..c814afa5656 100755
--- a/t/t5600-clone-fail-cleanup.sh
+++ b/t/t5600-clone-fail-cleanup.sh
@@ -13,6 +13,7 @@ Unless the directory already exists, in which case we clean up only what we
 wrote.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 corrupt_repo () {
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
diff --git a/t/t9127-git-svn-partial-rebuild.sh b/t/t9127-git-svn-partial-rebuild.sh
index 90b1b30dde5..97f495bd49b 100755
--- a/t/t9127-git-svn-partial-rebuild.sh
+++ b/t/t9127-git-svn-partial-rebuild.sh
@@ -5,7 +5,6 @@
 
 test_description='git svn partial-rebuild tests'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'initialize svnrepo' '
-- 
2.35.1.1557.g4e3e9cdb5e0

