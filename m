Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6B2C77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 20:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjEHUV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 16:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEHUVz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 16:21:55 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EBD213C
        for <git@vger.kernel.org>; Mon,  8 May 2023 13:21:53 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3ef4a74b42dso25367531cf.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 13:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683577312; x=1686169312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qnzn+4W7xWkidowl7lc4umQIqOLhsZYjwZuFOEM2hBs=;
        b=RnpLvFIW31B4AG2xT1unQWBJAg91Z+uCC/cOLQZ/J6E2UyiG40hwpG8sLBXMspEAbR
         w/tE0lV/decxNfWUNKi+O8mjL7UZNlcBsP0b0p5mc/CfKM1w83bORAlbIZEKLLwb9NO9
         gOeXq/rTAmioCPcxCDtnzsDLqpjOV6w+jgCYtbqbhhr4SgAvJf1jRFqwPIne5AiyNLZ2
         +fLHXJ2ii8WP9NAqrxg8VrA+z14L62B23eD0timT+QNfH6sFemF3RACP46ZzPyQU9UJB
         8ruUahM5Gx1/a6qJGioyuu0iebaQRPe1p4azq1jC405upcR1UwP5L3MFMS4zHl/8NRuX
         WKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683577312; x=1686169312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qnzn+4W7xWkidowl7lc4umQIqOLhsZYjwZuFOEM2hBs=;
        b=D6dY3MhiNQAZZVpAIRVIfRj6BCNzwtimzdYFJV0lNCbYnLsd3oQlNtTKk/WEX5RbmK
         iMDtktIJxJhjR8ZTcX99WOHvrE0kVqmJPUfLFe8Rz9NKTF0IzmOhj1AGyrcjmAQZVQum
         xukzp4BfmpMLYRV493xIvUavSF72xU+pfmWV+LAMkSYOTGw3y6YzP16SgOsDS+1qMaRr
         XZxk4TjOT9w3wLVuJYz9tjZ1QBtCbaMZcoHlPgRabq3GsvT0yCgj5IZDoXU+7aqxytyM
         FS2EUeDqQYBp/fSOUeXi+v5hkpP8K2JRD6X4DIFAkUlD5XnBmNMBDI6cRZI7sx3zYctE
         CZOw==
X-Gm-Message-State: AC+VfDwNclaAtYM5Zb+hFLHbB5AGOkXjb24I4bDe4EFcMqWZyMxHxg4w
        M0E2nPq61pQ+ymotgLWC2/MqcbbFEF8QMg==
X-Google-Smtp-Source: ACHHUZ592emh/YFDojUCzNNY10p9QH2VNe6LQqSQWoK5/k5K0UQcN8tAXgKRvAaj97VRsvkkdOPpNA==
X-Received: by 2002:a05:622a:5d3:b0:3f0:ac80:1ed7 with SMTP id d19-20020a05622a05d300b003f0ac801ed7mr18010730qtb.45.1683577312590;
        Mon, 08 May 2023 13:21:52 -0700 (PDT)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id s15-20020ac85ecf000000b003eb136bec50sm3196725qtx.66.2023.05.08.13.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 13:21:52 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v6] write-tree: optimize sparse integration
Date:   Mon,  8 May 2023 16:21:40 -0400
Message-Id: <20230508202140.464363-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230508200508.462423-1-cheskaqiqi@gmail.com>
References: <20230508200508.462423-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* 'on all' in the title of the test 'write-tree on all' was unclear;
remove it.

* Add a baseline 'test_all_match git write-tree' before making any
changes to the index, providing a reference point for the 'write-tree'
prior to any modifications.

* Add a comparison of the output of 'git status --porcelain=v2' to test
the working tree after 'write-tree' exits.

* Ensure SKIP_WORKTREE files weren't materialized on disk by using
"test_path_is_missing".

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---

My apologies, please ignore the previous v6 iteration.

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
1:  df470c2d61 ! 1:  e6c21ec6b8 write-tree: optimize sparse integration
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
    +    * 'on all' in the title of the test 'write-tree on all' was unclear;
    +    remove it.
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

