Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E74C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 17:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiKCRHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 13:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiKCRHO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 13:07:14 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3E71E3FB
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 10:06:29 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bj12so6945064ejb.13
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 10:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5997vH5zhnrlwppWggSGtA+4AlSympbBqBmBnmtqecg=;
        b=No+hEcKP7UDj+esAULJ1LxOLZDWiXFiUilyN8MsR8/OH0GnHMT/jYrU8yv5AyP65BJ
         VSGIxIKVYR73XNWnYp/wgvduH6WKsnHV9vGz62IxUFD9OCEZa4ecEKJygFJfeRnB86fo
         zA86ZTkq1Gi1y00KhonMi9Z885kpVVoWuf6jnKxJ6Tag6qduuQPSB2psAuF8wCP5eFeC
         ferBkkT7++zSYVCSl2yy3Sly6XCmrSimeMwT2E2hrUyHbFTQRuVdKysIj9cRyuPSYdlr
         KGveBbLjTKnXdv4Vz9+hPUO4XpI5HnELgTHLa+oZJJ/K6kyB1rnFr6ikAqwOc6pLR0lW
         oXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5997vH5zhnrlwppWggSGtA+4AlSympbBqBmBnmtqecg=;
        b=mJZpvFUgdasSKwlvUasY0845r7oVyovhw1MRIunTvJA5/8rgyc+Btdk/oCxV//gCPD
         MchtyTl7eDpKsBMKH1VcTZ3mAkHvYqLQbUs89pETfrvG9jZ6l2KHQIpPBxqqMgrtFMCr
         k7OzvpWDzwXAbxa5lgOF/UKH9Gogoa+bRpFovyieifMpgkh8X/xfD8k/jE+kSPeTfKO4
         pj8VJUBJfzYLjjy7eMqFPbGp7sQmUKJ/0v1qb8DNYhA50Ah/64WvUCTeE0JMx86oMqVa
         S8BvnjZO6hB3ADvC4DYBjKdgQhO5p912TnoZ7ZzyspUGFncuLFxRni+D3yAsB9nVxg9F
         5/Tw==
X-Gm-Message-State: ACrzQf1Re5CL8P2xwmFAYAxoXvV6GI1UWuhwdrrNFxc4xPSOOI0TI52E
        P85gmjSGGQ7QqG+JNnqQD3MuFk1Xf0UeRA==
X-Google-Smtp-Source: AMsMyM6vUmUchyvFyDPN5fvPemSQWix8u+dgZwn1Nz/rnocj56Q9FAKN6z/8AwCA0udRBB0N1AfemA==
X-Received: by 2002:a17:907:aa1:b0:7ad:cd92:a48f with SMTP id bz1-20020a1709070aa100b007adcd92a48fmr22887404ejc.369.1667495182521;
        Thu, 03 Nov 2022 10:06:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d644000000b0044e01e2533asm741882edr.43.2022.11.03.10.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:06:21 -0700 (PDT)
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
Subject: [PATCH 03/17] commit: discard partial cache before (re-)reading it
Date:   Thu,  3 Nov 2022 18:06:02 +0100
Message-Id: <patch-03.17-c1003454939-20221103T164632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
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
2.38.0.1451.g86b35f4140a

