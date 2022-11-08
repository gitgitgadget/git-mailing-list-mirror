Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F233C43219
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbiKHSSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbiKHSR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:17:59 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FA838BD
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:17:57 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id f5so40807878ejc.5
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5gyXYJHKYH9gbfcVlFUEaXvZS9Ghrsg31nkXVrycmk=;
        b=O8CAW16s65VbN5QcjOlMe27dWiggcQEIADzghnO9g29iYX4dbMYl4OjccszvPfNfTx
         TkR8RGJwLA5bnPxquXCY2Ae+1vKlU2SE+TudXtSnAe6FFze5Fm/q0v5vB2RhkCegWRfT
         n08tjUjoN6j1bF/vG5l+mpsF+J1LqxusvH99eyrJDDi5v2gy+lBdcmtMEfOJ4Yci42aT
         Cmmn+AkJKt3XQxtBPHke0j83hmlfORkcYlXh1zsqK/8NnriU1Mumo3LTx4jWZ3+LheL5
         vIpf3ajAb37x6gllLu63po7v3BSOzhEcFAVU3HYwhAzCB869nFmVYRTm9Q62bryAJ5rH
         1FuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5gyXYJHKYH9gbfcVlFUEaXvZS9Ghrsg31nkXVrycmk=;
        b=cukOrQl1k8kOKotRdOeitW2GzMH9LFCvhjn7oabWI8EYeGcbJlsHNLSi98Ycbc8CGM
         9X1O314ahKPiLJXYiPGWjfCHy2dUDySjioW3ZesqUBv3UqoLLMQZ9pWdw0fV6oA0MpUi
         zuHduMt0rLWrWTVvD2vgGT2btoBVbrOvTjwkrdkZSOVQBBPOGkouYHaCXKWc8MVYlXpz
         gElN5ui80BmxWMaUABRCd4dIx6aGTqistK1i3N6OC1/T1AJmmT0Nrm8PiYquZgH/R6PV
         ryt87rjU8nLBNG8iwit9Z4f9puadSJmwcPzsj8V0fOM0HlRwPNJPQHNC8rDgKB8Gwm/v
         ovyQ==
X-Gm-Message-State: ACrzQf1aKO8WEAVLpB0B11D7HGVO7+SDgMf6M1et47L8ATng7empaJkE
        R5j6gWzgS3kMyW+qjqCPledbQh3ourMbyA==
X-Google-Smtp-Source: AMsMyM4Z6KstvIYa8nTOHERWADQMa+IleTyAjCJ57hFIBaFgm8yC77VihFwKiXaRiPXCe/hy6Ka5Jw==
X-Received: by 2002:a17:906:b345:b0:7ae:8d4:4204 with SMTP id cd5-20020a170906b34500b007ae08d44204mr32072091ejb.746.1667931475615;
        Tue, 08 Nov 2022 10:17:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709063e5200b007a62215eb4esm4994131eji.16.2022.11.08.10.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:17:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/15] commit: discard partial cache before (re-)reading it
Date:   Tue,  8 Nov 2022 19:17:39 +0100
Message-Id: <patch-v2-03.15-8e76a29cce7-20221108T172650Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1467.g709fbdff1a9
In-Reply-To: <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The read_cache() in prepare_to_commit() would end up clobbering the
pointer we had for a previously populated "the_index.cache_tree" in
the very common case of "git commit" stressed by e.g. the tests being
changed here.

We'd populate "the_index.cache_tree" by calling
"update_main_cache_tree" in prepare_index(), but would not end up with
a "fully prepared" index. What constitutes an existing index is
clearly overly fuzzy, here we'll check "active_nr" (aka
"the_index.cache_nr"), but our "the_index.cache_tree" might have been
malloc()'d already.

Thus the code added in 11c8a74a64a (commit: write cache-tree data when
writing index anyway, 2011-12-06) would end up allocating the
"cache_tree", and would interact here with code added in
7168624c353 (Do not generate full commit log message if it is not
going to be used, 2007-11-28). The result was a very common memory
leak.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit.c                        | 7 +++++--
 t/t0068-for-each-repo.sh                | 1 +
 t/t0070-fundamental.sh                  | 1 +
 t/t1404-update-ref-errors.sh            | 2 ++
 t/t1409-avoid-packing-refs.sh           | 1 +
 t/t1413-reflog-detach.sh                | 1 +
 t/t1501-work-tree.sh                    | 2 ++
 t/t2025-checkout-no-overlay.sh          | 1 +
 t/t3009-ls-files-others-nonsubmodule.sh | 1 +
 t/t3010-ls-files-killed-modified.sh     | 2 ++
 t/t4045-diff-relative.sh                | 2 ++
 t/t4111-apply-subdir.sh                 | 1 +
 t/t4135-apply-weird-filenames.sh        | 1 +
 t/t4213-log-tabexpand.sh                | 1 +
 t/t5618-alternate-refs.sh               | 2 ++
 t/t6301-for-each-ref-errors.sh          | 1 +
 t/t7520-ignored-hook-warning.sh         | 1 +
 t/t7614-merge-signoff.sh                | 1 +
 t/t9003-help-autocorrect.sh             | 2 ++
 19 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e22bdf23f5f..c291199b704 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -987,8 +987,11 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct object_id oid;
 		const char *parent = "HEAD";
 
-		if (!active_nr && read_cache() < 0)
-			die(_("Cannot read index"));
+		if (!active_nr) {
+			discard_cache();
+			if (read_cache() < 0)
+				die(_("Cannot read index"));
+		}
 
 		if (amend)
 			parent = "HEAD^1";
diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index 4675e852517..9f63f612425 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -2,6 +2,7 @@
 
 test_description='git for-each-repo builtin'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'run based on configured value' '
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 8d59905ef09..574de341980 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -6,6 +6,7 @@ test_description='check that the most basic functions work
 Verify wrappers and compatibility functions.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'character classes (isspace, isalpha etc.)' '
diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 13c2b43bbae..b5606d93b52 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='Test git update-ref error handling'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Create some references, perhaps run pack-refs --all, then try to
diff --git a/t/t1409-avoid-packing-refs.sh b/t/t1409-avoid-packing-refs.sh
index be12fb63506..f23c0152a85 100755
--- a/t/t1409-avoid-packing-refs.sh
+++ b/t/t1409-avoid-packing-refs.sh
@@ -2,6 +2,7 @@
 
 test_description='avoid rewriting packed-refs unnecessarily'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Add an identifying mark to the packed-refs file header line. This
diff --git a/t/t1413-reflog-detach.sh b/t/t1413-reflog-detach.sh
index 934688a1ee8..d2a4822d46f 100755
--- a/t/t1413-reflog-detach.sh
+++ b/t/t1413-reflog-detach.sh
@@ -4,6 +4,7 @@ test_description='Test reflog interaction with detached HEAD'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 reset_state () {
diff --git a/t/t1501-work-tree.sh b/t/t1501-work-tree.sh
index b75558040ff..ae6528aecea 100755
--- a/t/t1501-work-tree.sh
+++ b/t/t1501-work-tree.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test separate work tree'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2025-checkout-no-overlay.sh b/t/t2025-checkout-no-overlay.sh
index 8f13341cf8e..3832c3de813 100755
--- a/t/t2025-checkout-no-overlay.sh
+++ b/t/t2025-checkout-no-overlay.sh
@@ -2,6 +2,7 @@
 
 test_description='checkout --no-overlay <tree-ish> -- <pathspec>'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3009-ls-files-others-nonsubmodule.sh b/t/t3009-ls-files-others-nonsubmodule.sh
index 963f3462b75..14218b34243 100755
--- a/t/t3009-ls-files-others-nonsubmodule.sh
+++ b/t/t3009-ls-files-others-nonsubmodule.sh
@@ -18,6 +18,7 @@ This test runs git ls-files --others with the following working tree:
       git repository with a commit and an untracked file
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup: directories' '
diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modified.sh
index 580e158f991..054178703d7 100755
--- a/t/t3010-ls-files-killed-modified.sh
+++ b/t/t3010-ls-files-killed-modified.sh
@@ -41,6 +41,8 @@ Also for modification test, the cache and working tree have:
 We should report path0, path1, path2/file2, path3/file3, path7 and path8
 modified without reporting path9 and path10.  submod1 is also modified.
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'git update-index --add to add various paths.' '
diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index fab351b48a1..198dfc91906 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='diff --relative tests'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4111-apply-subdir.sh b/t/t4111-apply-subdir.sh
index 1618a6dbc7c..e9a87d761d1 100755
--- a/t/t4111-apply-subdir.sh
+++ b/t/t4111-apply-subdir.sh
@@ -2,6 +2,7 @@
 
 test_description='patching from inconvenient places'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4135-apply-weird-filenames.sh b/t/t4135-apply-weird-filenames.sh
index 6bc3fb97a75..d3502c6fddf 100755
--- a/t/t4135-apply-weird-filenames.sh
+++ b/t/t4135-apply-weird-filenames.sh
@@ -2,6 +2,7 @@
 
 test_description='git apply with weird postimage filenames'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4213-log-tabexpand.sh b/t/t4213-log-tabexpand.sh
index 53a4af32449..590fce95e90 100755
--- a/t/t4213-log-tabexpand.sh
+++ b/t/t4213-log-tabexpand.sh
@@ -2,6 +2,7 @@
 
 test_description='log/show --expand-tabs'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 HT="	"
diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
index 3353216f09e..f905db0a3fd 100755
--- a/t/t5618-alternate-refs.sh
+++ b/t/t5618-alternate-refs.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test handling of --alternate-refs traversal'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Avoid test_commit because we want a specific and known set of refs:
diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index 40edf9dab53..bfda1f46ad2 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -2,6 +2,7 @@
 
 test_description='for-each-ref errors for broken refs'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 ZEROS=$ZERO_OID
diff --git a/t/t7520-ignored-hook-warning.sh b/t/t7520-ignored-hook-warning.sh
index dc57526e6f1..184b2589893 100755
--- a/t/t7520-ignored-hook-warning.sh
+++ b/t/t7520-ignored-hook-warning.sh
@@ -2,6 +2,7 @@
 
 test_description='ignored hook warning'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7614-merge-signoff.sh b/t/t7614-merge-signoff.sh
index fee258d4f0c..cf96a35e8e7 100755
--- a/t/t7614-merge-signoff.sh
+++ b/t/t7614-merge-signoff.sh
@@ -8,6 +8,7 @@ This test runs git merge --signoff and makes sure that it works.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Setup test files
diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
index f00deaf3815..4b9cb4c942f 100755
--- a/t/t9003-help-autocorrect.sh
+++ b/t/t9003-help-autocorrect.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='help.autocorrect finding a match'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.38.0.1467.g709fbdff1a9

