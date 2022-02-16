Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D76C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 04:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343698AbiBPEVm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 23:21:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245039AbiBPEVk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 23:21:40 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07BD9FE4
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 20:21:25 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d27so1336663wrb.5
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 20:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Tp5roF4oBGWzQBI4W2pYntrbLwiaUfEG7QX5VSTbSvA=;
        b=abVxIrgmB2OpLbgtF8rzhqSxwFlIuueWWfhlKs8ymcBFuUE7DQPfWVQahSB+x8O3d/
         5Ft9nvr+BZT/dgbsyHCVEDVns8Slmt5GEODV6dHBk35zomOjT0Uq+GHxifpwPByWP6qp
         6t6w+DXd8bYLlMEzn2pnV5SLz4KLqnDEMECIEEcmmHAiwVWmxwUEPKJUzQ+Kby5HM7NA
         KHA7zXONOh9P9HCkT4yuZy37pn9YsxH62/kz5EcvHX4V0wNbp28mAkpomERSvHZrudRY
         p2bLg2murqKEmovnmjHHaC7UXcD7vADbqCPJn68cL9c1n2r66jrwi3wz4Q+Lwjek3lpM
         NhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Tp5roF4oBGWzQBI4W2pYntrbLwiaUfEG7QX5VSTbSvA=;
        b=pn2pQ1cEubIKWWv8tIRCxRthWMPe/lpdRB5OXzQ9oZyjW6M2hFSHFB7jypFqqbg36B
         TbG5fKcxQQDnAMuVYBi81zJjtA5TzoH8Mnr+nckriNoa4LxR+nFNEQSDy00UC8X6ovmq
         p6nDpPIFOy98FGcuLtMJNh3k5NB7lMG8WU93Avp5z+J8BC/WX1/c4ropVepWEFpkoLoL
         /3ifFnf7RpG5+WHQpYKrcOXCEBtwmUDpXDDQ6QebA7sDhG9lAZ3XYy4k3pscXzHzRyTD
         PVfkSL7LwVBi048oPTQK8Zp4YTPXYf61N5EV3+1BqcPeLCsH6vux4MDRwSj4wfIJKcS2
         IEfA==
X-Gm-Message-State: AOAM530QcRHtvQr9pD/DEiuSafRW9Tjy4bNnj7wk81JvTHCnJVfsG7dU
        4lMRcph7rn/ukhyxRSTEHnXx2mRB350=
X-Google-Smtp-Source: ABdhPJyzTSPvxmAfNV1ToaVMvnZg76o6PLm27Rdh1GG4+a6Q/2ZKcZRjvamOzT1REJPUuSpguFtTxA==
X-Received: by 2002:a5d:6da1:0:b0:1e3:2bf5:13c with SMTP id u1-20020a5d6da1000000b001e32bf5013cmr819020wrs.316.1644985284223;
        Tue, 15 Feb 2022 20:21:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p32sm17525390wms.1.2022.02.15.20.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 20:21:23 -0800 (PST)
Message-Id: <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
References: <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 04:21:18 +0000
Subject: [PATCH v3 0/5] sparse checkout: fix a few bugs and check argument validity for set/add
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

== Maintainer notes ==

Note: There is a small textual and small semantic conflict with
ds/sparse-checkout-requires-per-worktree-config in seen. I included the diff
with the correct resolution near the end of this cover letter. If you'd
prefer I rebased on top of ds/sparse-chckout-requires-per-worktree-config,
let me know.

== Overview ==

This series continues attempts to make sparse-checkouts more user friendly.
A quick overview:

 * Patches 1-2 fix existing bugs from en/sparse-checkout-set (i.e. in
   v2.35.0)
 * Patch 3 fixes sparse-checkout-from-subdirectories-ignores-"prefix" (see
   https://lore.kernel.org/git/29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.com/),
   in cone mode. Since we'll get nasty surprises whether we use or don't use
   "prefix" for non-cone mode, simply throw an error if set/add subcommands
   of sparse-checkout are run from a subdirectory.
 * Patches 4-5 check positional arguments to set/add and provide
   errors/warnings for very likely mistakes. It also adds a --skip-checks
   flag for overridding in case you have a very unusual situation.

== Update history ==

Changes since v2:

 * Dropped patch 5
 * Added Stolee's Reviewed-by

Changes since v1:

 * Dropped the commit changing cone-mode to default (patch 7, which will be
   split into multiple patches and submitted as a separate series)
 * Removed the RFC label
 * Decided to error out when running set/add with paths from a subdirectory
   in non-cone mode, and added tests
 * Changed the warning for non-cone mode with individual files to point out
   that the user is likely trying to select an individual file, but should
   likely add a leading slash to ensure that is what happens
 * Fixed typos, removed unnecessary condition checks

== Conflict resolution ==

Patch to resolve textual and semantic conflict with
ds/sparse-checkout-requires-per-worktree-config:

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
remerge CONFLICT (content): Merge conflict in t/t1091-sparse-checkout-builtin.sh
index 3c6adeb885..3a95d2996d 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -275,24 +275,8 @@ test_expect_success 'sparse-index enabled and disabled' '
     diff -u sparse full | tail -n +3 >actual &&
     test_cmp expect actual &&
 
-<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 286c22e5ec (sparse-checkout: reject arguments in cone-mode that look like patterns)
     git -C repo config --list >config &&
-    ! grep index.sparse config
-|||||||||||||||||||||||||||||||| 89bece5c8c
-        diff -u sparse full | tail -n +3 >actual &&
-        test_cmp expect actual &&
-
-        git -C repo config --list >config &&
-        ! grep index.sparse config
-    )
-================================
-        diff -u sparse full | tail -n +3 >actual &&
-        test_cmp expect actual &&
-
-        git -C repo config --list >config &&
-        test_cmp_config -C repo false index.sparse
-    )
->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 3ce1138272 (config: make git_configset_get_string_tmp() private)
+    test_cmp_config -C repo false index.sparse
 '
 
 test_expect_success 'cone mode: init and set' '
@@ -532,6 +516,7 @@ test_expect_success 'reapply can handle config options' '
     cat >expect <<-\EOF &&
     core.sparsecheckout=true
     core.sparsecheckoutcone=true
+    index.sparse=false
     EOF
     test_cmp expect actual &&
 
@@ -539,6 +524,8 @@ test_expect_success 'reapply can handle config options' '
     git -C repo config --worktree --list >actual &&
     cat >expect <<-\EOF &&
     core.sparsecheckout=true
+    core.sparsecheckoutcone=false
+    index.sparse=false
     EOF
     test_cmp expect actual &&


== CCs ==

Elijah Newren (5):
  sparse-checkout: correct reapply's handling of options
  sparse-checkout: correctly set non-cone mode when expected
  sparse-checkout: pay attention to prefix for {set, add}
  sparse-checkout: error or warn when given individual files
  sparse-checkout: reject arguments in cone-mode that look like patterns

 builtin/sparse-checkout.c          | 81 ++++++++++++++++++++++++++--
 t/t1091-sparse-checkout-builtin.sh | 87 +++++++++++++++++++++++++++++-
 2 files changed, 161 insertions(+), 7 deletions(-)


base-commit: b80121027d1247a0754b3cc46897fee75c050b44
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1118%2Fnewren%2Fsparse-checkout-default-and-arg-validity-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1118/newren/sparse-checkout-default-and-arg-validity-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1118

Range-diff vs v2:

 1:  5536fe6498e ! 1:  5215b7f7179 sparse-checkout: correct reapply's handling of options
     @@ Commit message
          parsing the command line options instead of before.  Add a test and set
          the initial value at the appropriate time.
      
     +    Reviewed-by: Derrick Stolee <derrickstolee@github.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/sparse-checkout.c ##
 2:  9edad872e0d ! 2:  0c2ab523e74 sparse-checkout: correctly set non-cone mode when expected
     @@ Commit message
          being set to the correct mode, so make sure it is set consistently with
          the config values we will be writing to disk.
      
     +    Reviewed-by: Derrick Stolee <derrickstolee@github.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/sparse-checkout.c ##
 3:  f57820e25d6 ! 3:  e68b0a37ff3 sparse-checkout: pay attention to prefix for {set, add}
     @@ Commit message
          [2] https://lore.kernel.org/git/CABPp-BHXZ-XLxY0a3wCATfdq=6-EjW62RzbxKAoFPeXfJswD2w@mail.gmail.com/
      
          Helped-by: Junio Hamano <gitster@pobox.com>
     +    Reviewed-by: Derrick Stolee <derrickstolee@github.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/sparse-checkout.c ##
 4:  c3bb2a3b2f1 ! 4:  1fdebc1953f sparse-checkout: error or warn when given individual files
     @@ Commit message
          specify exactly name a file because it means they are likely missing
          such a missing leading slash.
      
     +    Reviewed-by: Derrick Stolee <derrickstolee@github.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/sparse-checkout.c ##
 5:  c5d4ae2cfd6 < -:  ----------- sparse-checkout: reject non-cone-mode patterns starting with a '#'
 6:  286c22e5ecd ! 5:  2008542d0c7 sparse-checkout: reject arguments in cone-mode that look like patterns
     @@ Commit message
          Inform users they can pass --skip-checks if they have a directory that
          really does have such special characters in its name.
      
     +    Reviewed-by: Derrick Stolee <derrickstolee@github.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/sparse-checkout.c ##
     @@ builtin/sparse-checkout.c: static void sanitize_paths(int argc, const char **arg
       	if (skip_checks)
       		return;
       
     --	if (!core_sparse_checkout_cone)
     --		for (i = 0; i < argc; i++)
     -+	for (i = 0; i < argc; i++) {
     -+		if (core_sparse_checkout_cone) {
     ++	if (core_sparse_checkout_cone) {
     ++		for (i = 0; i < argc; i++) {
      +			if (argv[i][0] == '/')
      +				die(_("specify directories rather than patterns (no leading slash)"));
      +			if (argv[i][0] == '!')
     @@ builtin/sparse-checkout.c: static void sanitize_paths(int argc, const char **arg
      +			    strchr(argv[i], '[') ||
      +			    strchr(argv[i], ']'))
      +				die(_("specify directories rather than patterns.  If your directory really has any of '*?[]' in it, pass --skip-checks"));
     -+		} else {
     - 			if (argv[i][0] == '#')
     - 				die(_("paths beginning with a '#' must be preceeded by a backslash"));
      +		}
      +	}
     - 
     ++
       	for (i = 0; i < argc; i++) {
       		struct cache_entry *ce;
     + 		struct index_state *index = the_repository->index;
      
       ## t/t1091-sparse-checkout-builtin.sh ##
      @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success BSLASHPSPEC 'pattern-checks: escaped characters' '

-- 
gitgitgadget
