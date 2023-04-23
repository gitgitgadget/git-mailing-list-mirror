Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B817C77B76
	for <git@archiver.kernel.org>; Sun, 23 Apr 2023 07:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjDWHNE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Apr 2023 03:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjDWHNC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2023 03:13:02 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FE91BE3
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 00:13:01 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-760ed95b9e6so77656239f.1
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 00:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682233980; x=1684825980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+02wxYmr5VPVeFF5jX0SWvoyUkG1NmsSqeyBaEJREzo=;
        b=i60ougoXF999Y0eeOxBZ3T9knU/eLJ9cx28Z1ts203MGRcGoeUk/z+GSmdFcoSR+Gg
         NI9gOQ5PcKg6kRCE0dBWDSrJvwFpCpvSIq+ePwsnqUmHlsjgFzlxro4crWr1OqGPI1mI
         momXMizZVXp0KSdoxDIxNptJbvWHwaa7KvipknTWhC04n0gWvHAhSkfr6CmaZQIkBTmT
         Id4Ok/40UXo+nCpQhe/GRv88eni32SkbHCekL5kxtVH0ia3JImcKkc+iiuonUh+SQeNQ
         0m9akqfXYu9LtDt31LLGnA3YzxhQ9EEzRRc3G378QqKs3mZUGL3Fg1o/rmImqk1sf5Da
         1X/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682233980; x=1684825980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+02wxYmr5VPVeFF5jX0SWvoyUkG1NmsSqeyBaEJREzo=;
        b=dIbDgV2BHeFq1Xi2KqI59Je5ScK4WCDAyDYBohtMel5CHrMrZAcO++KdXVmdvLi5vE
         haREB71nBl77NtNHIzG05d28KbLsdSxOgAvgNBo3Vzj0a7/nXzUojixdf+BpOSMGw7iC
         wJKxONonlsVlrCU7YS5gLGb5YFenlSACSaoezqCY3URyVL6GwahKU3YCyJm1Yrx6Vu6a
         Yi9VtJfL3V3FN8a+hIqIzmVrv4+yOO6wlfwijmWE1NBnX7zdmC3lmSI7k2admWu0qu/M
         G0rl1aaVLl47smzs1xZ0t4OGjsz700jzgQu65fkTWpbi/HrUXZ5rjq2oj0LHED+qVVdU
         ZW9Q==
X-Gm-Message-State: AAQBX9fh6TDn+x5vMuomyEtgt4NLMJcTYhnnQh/rp42uPHZZccdANgAs
        BGpjln+29KlDy2mad7tmWPAOof5NlnU16g==
X-Google-Smtp-Source: AKy350Y2+Ln3LwjHd4R3egXgHWSR3eOhcssG4T+UfRY8TJBWjHooOfS2FWHM7PZKchkjKK5nBxuGag==
X-Received: by 2002:a5d:8c98:0:b0:760:ec3c:33ea with SMTP id g24-20020a5d8c98000000b00760ec3c33eamr3273472ion.7.1682233980230;
        Sun, 23 Apr 2023 00:13:00 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id b22-20020a056602219600b0075970bbe68bsm2291522iob.45.2023.04.23.00.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 00:12:59 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v5] write-tree: optimize sparse integration
Date:   Sun, 23 Apr 2023 03:12:43 -0400
Message-Id: <20230423071243.1863977-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230421004108.32554-1-cheskaqiqi@gmail.com>
References: <20230421004108.32554-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'prepare_repo_settings()' needs to be run inside a repository. Ensure
that the code checks for the presence of a repository before calling
this function. 'write-tree on all' had an unclear meaning of 'on all'.
Change the test name to simply 'write-tree'. Add a baseline
'test_all_match git write-tree' before making any changes to the index,
providing a reference point for the 'write-tree' prior to any
modifications. Add a comparison of the output of
'git status --porcelain=v2' to test the working tree after 'write-tree'
exits. Ensure SKIP_WORKTREE files weren't materialized on disk by using
"test_path_is_missing".

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---

* Update commit message.

* 'command_requires_full_index' to be set after 'parse_options'.

* Remove trailing whitespace.


Range-diff against v4:
1:  07f9bbd3c4 ! 1:  df470c2d61 write-tree: integrate with sparse index
    @@ Metadata
     Author: Shuqi Liang <cheskaqiqi@gmail.com>
     
      ## Commit message ##
    -    write-tree: integrate with sparse index
    +    write-tree: optimize sparse integration
     
    -    Update 'git write-tree' to allow using the sparse-index in memory
    -    without expanding to a full one.
    -
    -    The recursive algorithm for update_one() was already updated in 2de37c5
    -    (cache-tree: integrate with sparse directory entries, 2021-03-03) to
    -    handle sparse directory entries in the index. Hence we can just set the
    -    requires-full-index to false for "write-tree".
    -
    -    The `p2000` tests demonstrate a ~96% execution time reduction for 'git
    -    write-tree' using a sparse index:
    -
    -    Test                                           before  after
    -    -----------------------------------------------------------------
    -    2000.78: git write-tree (full-v3)              0.34    0.33 -2.9%
    -    2000.79: git write-tree (full-v4)              0.32    0.30 -6.3%
    -    2000.80: git write-tree (sparse-v3)            0.47    0.02 -95.8%
    -    2000.81: git write-tree (sparse-v4)            0.45    0.02 -95.6%
    +    'prepare_repo_settings()' needs to be run inside a repository. Ensure
    +    that the code checks for the presence of a repository before calling
    +    this function. 'write-tree on all' had an unclear meaning of 'on all'.
    +    Change the test name to simply 'write-tree'. Add a baseline
    +    'test_all_match git write-tree' before making any changes to the index,
    +    providing a reference point for the 'write-tree' prior to any
    +    modifications. Add a comparison of the output of
    +    'git status --porcelain=v2' to test the working tree after 'write-tree'
    +    exits. Ensure SKIP_WORKTREE files weren't materialized on disk by using
    +    "test_path_is_missing".
     
         Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
     
      ## builtin/write-tree.c ##
     @@ builtin/write-tree.c: int cmd_write_tree(int argc, const char **argv, const char *cmd_prefix)
    - 	};
    + 	argc = parse_options(argc, argv, cmd_prefix, write_tree_options,
    + 			     write_tree_usage, 0);
      
    - 	git_config(git_default_config, NULL);
    -+	
    +-	prepare_repo_settings(the_repository);
    +-	the_repository->settings.command_requires_full_index = 0;
     +	if (the_repository->gitdir) {
     +		prepare_repo_settings(the_repository);
     +		the_repository->settings.command_requires_full_index = 0;
     +	}
    -+
    - 	argc = parse_options(argc, argv, cmd_prefix, write_tree_options,
    - 			     write_tree_usage, 0);
      
    --	prepare_repo_settings(the_repository);
    --	the_repository->settings.command_requires_full_index = 0;
    --
      	ret = write_index_as_tree(&oid, &the_index, get_index_file(), flags,
      				  tree_prefix);
    - 	switch (ret) {
     
      ## t/t1092-sparse-checkout-compatibility.sh ##
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'grep sparse directory within submodules' '
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'grep sparse direc
      '
      
      test_expect_success 'sparse-index is not expanded: write-tree' '
    -@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is not expanded: write-tree' '
    - 
    - 	echo "test1" >>sparse-index/a &&
    - 	git -C sparse-index update-index a &&
    --	ensure_not_expanded write-tree
    -+	ensure_not_expanded write-tree 
    - '
    - 
    - test_done

 builtin/write-tree.c                     |  6 ++++--
 t/t1092-sparse-checkout-compatibility.sh | 18 ++++++++++++++----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 32e302a813..52caa096a8 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -41,8 +41,10 @@ int cmd_write_tree(int argc, const char **argv, const char *cmd_prefix)
 	argc = parse_options(argc, argv, cmd_prefix, write_tree_options,
 			     write_tree_usage, 0);
 
-	prepare_repo_settings(the_repository);
-	the_repository->settings.command_requires_full_index = 0;
+	if (the_repository->gitdir) {
+		prepare_repo_settings(the_repository);
+		the_repository->settings.command_requires_full_index = 0;
+	}
 
 	ret = write_index_as_tree(&oid, &the_index, get_index_file(), flags,
 				  tree_prefix);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 0c784813f1..2a467e4b31 100755
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

