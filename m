Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94047C7EE22
	for <git@archiver.kernel.org>; Mon,  8 May 2023 20:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjEHUFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 16:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEHUFX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 16:05:23 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D9B121
        for <git@vger.kernel.org>; Mon,  8 May 2023 13:05:22 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-61b6a4233a1so46527806d6.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 13:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683576321; x=1686168321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkKs3H94LRrtbgRcU1oOYXKaRr6d2XDa1nvRauwXUYI=;
        b=i4+73iylkd40mqo1QjXErJTbrca9iYXz7a1uxPVFPpKOgkZgSSyAQjdl8sVaj+WZdS
         N0/x6ffLM6y5hlaqE1f42rWHxjoIO6Us8AMKNmWGYFVCeIKujqVRqEDgFvqjHZrYQp32
         1YnmoFocmfOExPUnHdHVRyDyNNHmpgbeOjMhQ7iy8FGJ9F44uuzQuPZUeiorcTnFyOhX
         b5uzGvMYH80w9uTGhawedKKh+OryPiZmDrgPXzmZXBiDTVLwzF5o1WfaYHYd6/Gs7JHY
         HbOMtxQtrnWet+FNjczhVsPr1iaCg63YpeMSFqFJ28tZ8QtMaaZM6QHfpv12VIzeUcNo
         b3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683576321; x=1686168321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkKs3H94LRrtbgRcU1oOYXKaRr6d2XDa1nvRauwXUYI=;
        b=d+YvEX6WKvCM2XXCZa97nvAJJVfEPAdt3/r0vSIWZoGNOpa7jq8nJvU070hmBWcrV4
         62m+LXdARhvz67MlTY5f6f/eWb8HEIadKDl2K2KN4XTfjsyy0wjabGJnMg4trWzffDW/
         ABSnHhEQGJuRmSSYfZrbYdB3HyoGSE6lV1kSmlBcR4/oFmqmplPOn1GIHWcoy+TNFZpj
         i8N5EXMeV2pCBkojcPk84FahOwyZW0cxpY3Han5EGKv9n/PRPZIRRf0w7rRq+w9UDj8U
         SimCG6J40V8gaves+TDjCwLlRZr7ZtiXkZw0ENxAX38zfZSfSPm98S+RiSH90gQp+MjB
         BBNA==
X-Gm-Message-State: AC+VfDwuvdJv+bWR5PG87RxhskuRTvYVow3tpQ0/jVup2yXB0p02SLu7
        ChjrYVoa1o2QTmAIiIhrwZYeVHaSENCD2g==
X-Google-Smtp-Source: ACHHUZ7K+Pi4gWXHDTq+IFhejGAAmrxOmP3wvSQwt2nV3WMVbX1aoIipQS3Y77KYU/1JCgMc6ogJDA==
X-Received: by 2002:a05:6214:1d2f:b0:5b4:1d9a:75e7 with SMTP id f15-20020a0562141d2f00b005b41d9a75e7mr19808232qvd.13.1683576320788;
        Mon, 08 May 2023 13:05:20 -0700 (PDT)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id a13-20020a05620a124d00b0074abe1e1457sm2778948qkl.76.2023.05.08.13.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 13:05:20 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v6] write-tree: optimize sparse integration
Date:   Mon,  8 May 2023 16:05:08 -0400
Message-Id: <20230508200508.462423-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230423071243.1863977-1-cheskaqiqi@gmail.com>
References: <20230423071243.1863977-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Remove 'on all' from the test title 'write-tree on all', making it
'write-tree'.

* Add a baseline 'test_all_match git write-tree' before making any
changes to the index, providing a reference point for the 'write-tree'
prior to any modifications.

* Add a comparison of the output of 'git status --porcelain=v2' to test
the working tree after 'write-tree' exits.

* Ensure SKIP_WORKTREE files weren't materialized on disk by using
"test_path_is_missing".

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---

change sine V5:

* We not need to check for the presence of a repository before calling
'prepare_repo_settings()', as the control flow should not reach this
point without a repository. This is because 'setup_git_directory()' is
called for commands with RUN_SETUP set, except when the command line
argument is "-h", in which case 'parse_options()' takes over and exits
the program.

* Change the commit message to make it easier to read.

* Remove whitespace before the line that says # check that SKIP_WORKTREE
files are not materialized".



Range-diff against v5:
1:  df470c2d61 ! 1:  0510b08c96 write-tree: optimize sparse integration
    @@ Metadata
      ## Commit message ##
         write-tree: optimize sparse integration
     
    -    'prepare_repo_settings()' needs to be run inside a repository. Ensure
    -    that the code checks for the presence of a repository before calling
    -    this function. 'write-tree on all' had an unclear meaning of 'on all'.
    -    Change the test name to simply 'write-tree'. Add a baseline
    -    'test_all_match git write-tree' before making any changes to the index,
    -    providing a reference point for the 'write-tree' prior to any
    -    modifications. Add a comparison of the output of
    -    'git status --porcelain=v2' to test the working tree after 'write-tree'
    -    exits. Ensure SKIP_WORKTREE files weren't materialized on disk by using
    +    * Remove 'on all' from the test title 'write-tree on all', making it
    +    'write-tree'.
    +
    +    * Add a baseline 'test_all_match git write-tree' before making any
    +    changes to the index, providing a reference point for the 'write-tree'
    +    prior to any modifications.
    +
    +    * Add a comparison of the output of 'git status --porcelain=v2' to test
    +    the working tree after 'write-tree' exits.
    +
    +    * Ensure SKIP_WORKTREE files weren't materialized on disk by using
         "test_path_is_missing".
     
         Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
     
    - ## builtin/write-tree.c ##
    -@@ builtin/write-tree.c: int cmd_write_tree(int argc, const char **argv, const char *cmd_prefix)
    - 	argc = parse_options(argc, argv, cmd_prefix, write_tree_options,
    - 			     write_tree_usage, 0);
    - 
    --	prepare_repo_settings(the_repository);
    --	the_repository->settings.command_requires_full_index = 0;
    -+	if (the_repository->gitdir) {
    -+		prepare_repo_settings(the_repository);
    -+		the_repository->settings.command_requires_full_index = 0;
    -+	}
    - 
    - 	ret = write_index_as_tree(&oid, &the_index, get_index_file(), flags,
    - 				  tree_prefix);
    -
      ## t/t1092-sparse-checkout-compatibility.sh ##
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'grep sparse directory within submodules' '
      	test_cmp actual expect
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'grep sparse direc
     +	test_all_match git update-index folder1/a &&
     +	test_all_match git write-tree &&
     +	test_all_match git status --porcelain=v2 &&
    -+	
    ++
     +	# check that SKIP_WORKTREE files are not materialized
     +	test_path_is_missing sparse-checkout/folder2/a &&
     +	test_path_is_missing sparse-index/folder2/a
-- 

 t/t1092-sparse-checkout-compatibility.sh | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 0c784813f1..3aa6356a85 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2080,22 +2080,32 @@ test_expect_success 'grep sparse directory within submodules' '
 	test_cmp actual expect
 '
 
-test_expect_success 'write-tree on all' '
+test_expect_success 'write-tree' '
 	init_repos &&
 
+	test_all_match git write-tree &&
+
 	write_script edit-contents <<-\EOF &&
 	echo text >>"$1"
 	EOF
 
+	# make a change inside the sparse cone
 	run_on_all ../edit-contents deep/a &&
-	run_on_all git update-index deep/a &&
+	test_all_match git update-index deep/a &&
 	test_all_match git write-tree &&
+	test_all_match git status --porcelain=v2 &&
 
+	# make a change outside the sparse cone
 	run_on_all mkdir -p folder1 &&
 	run_on_all cp a folder1/a &&
 	run_on_all ../edit-contents folder1/a &&
-	run_on_all git update-index folder1/a &&
-	test_all_match git write-tree
+	test_all_match git update-index folder1/a &&
+	test_all_match git write-tree &&
+	test_all_match git status --porcelain=v2 &&
+
+	# check that SKIP_WORKTREE files are not materialized
+	test_path_is_missing sparse-checkout/folder2/a &&
+	test_path_is_missing sparse-index/folder2/a
 '
 
 test_expect_success 'sparse-index is not expanded: write-tree' '
-- 
2.39.0

