Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77833C77B73
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 07:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjDSHWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 03:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjDSHWF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 03:22:05 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F7B2D71
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 00:22:03 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7606d6b0db3so327419939f.1
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 00:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681888922; x=1684480922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQbhFKtHZwKdoLBlfliKXTeGKCMOmeeUsA1H5k1BLPM=;
        b=FpuOcYXIZjoC+hP92KZGYyZHZbEjwvLWm+/FYU5pbaqa/kviqqmF2AzETKFYKGbOjp
         vZMOafHKbWHjxaHyIgc9wh/ciBctKdkz0VaGZ+33/PEUGy5DrdeSth7F2dnNKSo67AE0
         e0oZniObDU/LfJYppYBmCsu/PugmDSY17nLYLGqcNxiXJDvVyuFMKxnTFkPFphInrnS/
         L6QXPoQDfTnU1QtOwkP7QuO6n9MgF6PMbjdxWElfXWxwOO9aQxH9YdW4GAyF5zwH4bG+
         JILXKgyir5d6iUhfm/kEb17h7UW1lIR9f3ypE9yxM2kNfKbynzimedGAwUt+Jn3fruyJ
         2ruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681888922; x=1684480922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQbhFKtHZwKdoLBlfliKXTeGKCMOmeeUsA1H5k1BLPM=;
        b=LqZKXnPk0LC//iwJeG1v4mMjzAQo1tiErvdJT9fEWVNAEqeax5B3IJK8D2N5iDyv4Y
         GSKpJ7ORreGjPLTlN2iYxEHKsb4IbCNshWCXYI8WPsJCBFLQi1yc+rKTXNO5odVTetMa
         6aTk/gpb0vX6KGDLSoQhO+2i95rhy+fluqk+T0KDdYyB9P1e3nb0HoAWtI9j0j6XOf7x
         jDXvpJo0Jc0K/Rv9SaTv6fyB5UPs30UZoJUYW7IPkUi8QzascGdeSz37VIPAp8kAmWUJ
         JbAwNcGQyr46RnhManL1KDOSEpL3c37o6FeQF2WbwAKeKexPy8IXf6+xoIigFQphiq44
         08Lw==
X-Gm-Message-State: AAQBX9cBNewL5hulJZ4/0z5b5yLDujFevewAMm14uQYOF0p8/7H0tngX
        fOhubxbK3uDxEsaoACKPLvK6YQ1Ggnt+gw==
X-Google-Smtp-Source: AKy350a6ls9yYXEYH4QsOTQi8vEPuoArV1SNUZ2yOCTUzRhJTglL/LqSlnIL657N+YSrIK7BPuvDqw==
X-Received: by 2002:a05:6602:1805:b0:760:a817:7d60 with SMTP id t5-20020a056602180500b00760a8177d60mr3891611ioh.12.1681888922145;
        Wed, 19 Apr 2023 00:22:02 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id q23-20020a5d87d7000000b0071d93cda853sm4529236ios.42.2023.04.19.00.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 00:22:01 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v3] write-tree: integrate with sparse index
Date:   Wed, 19 Apr 2023 03:21:48 -0400
Message-Id: <20230419072148.4297-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230404003539.1578245-1-cheskaqiqi@gmail.com>
References: <20230404003539.1578245-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update 'git write-tree' to allow using the sparse-index in memory
without expanding to a full one.

The recursive algorithm for update_one() was already updated in 2de37c5
(cache-tree: integrate with sparse directory entries, 2021-03-03) to
handle sparse directory entries in the index. Hence we can just set the
requires-full-index to false for "write-tree".

The `p2000` tests demonstrate a ~96% execution time reduction for 'git
write-tree' using a sparse index:

Test                                           before  after
-----------------------------------------------------------------
2000.78: git write-tree (full-v3)              0.34    0.33 -2.9%
2000.79: git write-tree (full-v4)              0.32    0.30 -6.3%
2000.80: git write-tree (sparse-v3)            0.47    0.02 -95.8%
2000.81: git write-tree (sparse-v4)            0.45    0.02 -95.6%

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---

* Modified the code to ensure prepare_repo_settings() is called only 
when inside a repository.

* Change 'write-tree on all' to just 'write-tree'.

* Have a baseline 'test_all_match git write-tree' before making any 
changes to the index.

* Add  'git status --porcelain=v2'.

* Ensuring that SKIP_WORKTREE files weren't materialized on disk by
using "test_path_is_missing".

* Use 'test_all_match' on the 'git update-index'.



Range-diff against v2:
1:  8873c79759 ! 1:  cfa43c6cc7 write-tree: integrate with sparse index
    @@ Commit message
     
      ## builtin/write-tree.c ##
     @@ builtin/write-tree.c: int cmd_write_tree(int argc, const char **argv, const char *cmd_prefix)
    - 	argc = parse_options(argc, argv, cmd_prefix, write_tree_options,
    - 			     write_tree_usage, 0);
    + 	};
      
    + 	git_config(git_default_config, NULL);
    ++	
    ++	if (the_repository->gitdir) {
     +	prepare_repo_settings(the_repository);
     +	the_repository->settings.command_requires_full_index = 0;
    -+	
    - 	ret = write_cache_as_tree(&oid, flags, tree_prefix);
    - 	switch (ret) {
    - 	case 0:
    ++	}
    ++
    + 	argc = parse_options(argc, argv, cmd_prefix, write_tree_options,
    + 			     write_tree_usage, 0);
    + 
     
      ## t/perf/p2000-sparse-operations.sh ##
     @@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git checkout-index -f --all
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'grep sparse direc
      	test_cmp actual expect
      '
      
    -+test_expect_success 'write-tree on all' '
    ++test_expect_success 'write-tree' '
     +	init_repos &&
     +
    ++	test_all_match git write-tree &&
    ++
     +	write_script edit-contents <<-\EOF &&
     +	echo text >>"$1"
     +	EOF
     +
    ++	# make a change inside the sparse cone
     +	run_on_all ../edit-contents deep/a &&
    -+	run_on_all git update-index deep/a &&
    ++	test_all_match git update-index deep/a &&
     +	test_all_match git write-tree &&
    ++	test_all_match git status --porcelain=v2 &&
     +
    ++	# make a change outside the sparse cone
     +	run_on_all mkdir -p folder1 &&
     +	run_on_all cp a folder1/a &&
     +	run_on_all ../edit-contents folder1/a &&
    -+	run_on_all git update-index folder1/a &&
    -+	test_all_match git write-tree
    ++	test_all_match git update-index folder1/a &&
    ++	test_all_match git write-tree &&
    ++	test_all_match git status --porcelain=v2 &&
    ++	
    ++	# check that SKIP_WORKTREE files are not materialized
    ++	test_path_is_missing sparse-checkout/folder2/a &&
    ++	test_path_is_missing sparse-index/folder2/a
     +'
     +
     +test_expect_success 'sparse-index is not expanded: write-tree' '



 builtin/write-tree.c                     |  6 ++++
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 38 ++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 45d61707e7..23d63844de 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -35,6 +35,12 @@ int cmd_write_tree(int argc, const char **argv, const char *cmd_prefix)
 	};
 
 	git_config(git_default_config, NULL);
+	
+	if (the_repository->gitdir) {
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+	}
+
 	argc = parse_options(argc, argv, cmd_prefix, write_tree_options,
 			     write_tree_usage, 0);
 
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 3242cfe91a..9924adfc26 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -125,5 +125,6 @@ test_perf_on_all git checkout-index -f --all
 test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
 test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
 test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
+test_perf_on_all git write-tree 
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 801919009e..d3eb31326b 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2055,4 +2055,42 @@ test_expect_success 'grep sparse directory within submodules' '
 	test_cmp actual expect
 '
 
+test_expect_success 'write-tree' '
+	init_repos &&
+
+	test_all_match git write-tree &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>"$1"
+	EOF
+
+	# make a change inside the sparse cone
+	run_on_all ../edit-contents deep/a &&
+	test_all_match git update-index deep/a &&
+	test_all_match git write-tree &&
+	test_all_match git status --porcelain=v2 &&
+
+	# make a change outside the sparse cone
+	run_on_all mkdir -p folder1 &&
+	run_on_all cp a folder1/a &&
+	run_on_all ../edit-contents folder1/a &&
+	test_all_match git update-index folder1/a &&
+	test_all_match git write-tree &&
+	test_all_match git status --porcelain=v2 &&
+	
+	# check that SKIP_WORKTREE files are not materialized
+	test_path_is_missing sparse-checkout/folder2/a &&
+	test_path_is_missing sparse-index/folder2/a
+'
+
+test_expect_success 'sparse-index is not expanded: write-tree' '
+	init_repos &&
+
+	ensure_not_expanded write-tree &&
+
+	echo "test1" >>sparse-index/a &&
+	git -C sparse-index update-index a &&
+	ensure_not_expanded write-tree 
+'
+
 test_done
-- 
2.39.0

