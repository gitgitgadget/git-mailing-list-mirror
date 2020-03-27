Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336ECC2D0ED
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044D02074D
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbx+Wsug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgC0AtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:49:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39746 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgC0AtG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 20:49:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so9466052wrt.6
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 17:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jCO4zOVD6gvloc/J/Oc/wRTk/nnZ4V8UbAFf6bRTU+c=;
        b=dbx+WsugiW7N9YfMh9TvQO4OU2gjgmdIUYHB86Fh7sJjOumXWuko1zBxMcD+OCqqh/
         11ub5AGdOrFMXckJtHpk39tcF7abCdO++nrvo5Dq/DRMjRBpVLDw2kucz0wgGTdFRv1b
         ONUNSUe8uYWa5a7Zg+cP459mls71cBveCVpGLLjWFOE67PA9UDVGWXHvq5x84lJ2OKDN
         7VXJfVDxgvkLisI/RXQjYVVVWNRa5l79bLTpMy3C4T3sHLRHwqiv+y04ztlETVpd1ny/
         /uVcZGBoIO44vLlZcJQZrp4/A8uLwsPWokR9pIFY3i3gd7fNBJyaZLT6CxQIwr0eOLEr
         ma5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jCO4zOVD6gvloc/J/Oc/wRTk/nnZ4V8UbAFf6bRTU+c=;
        b=fi634SgW6IUU+qNAA1nXqraJmcfDSofeQkl2fsMN4N1ULIuzGUkG49SqVJFtT0nrau
         n8tKdhi7VaJJMgrDPy7MqbGkhsSUmF5VYMKaUje/qGPyJf9si327rjI6SaZ9lYnrrGz6
         un/TV6QdehtfFnPQz13YWmNIM6S+ar0twbiBTKNV175/utebNGAl2L/wZKum2tTL3HxW
         iJ155D6qBVQT94UaLyQmtYvlaao0dj7zUhY9W99KJ9UIUY3Uvd+fdYnUmhDuBVh6N6Ut
         akLqVCNNgcMi9Su8O9dVc9gzp7rtkzWkOqT0MM1mcBc+GApmE5iJJExc1uT314uy1OjC
         GpZw==
X-Gm-Message-State: ANhLgQ0VBAbdkWxbnxIt5XNrdHyuvgf7UL+wLKWNXpQJooDADV3ZH61q
        UBUaFzZi+1iBjsDlvfLS9uG+CBCk
X-Google-Smtp-Source: ADFU+vvfjNeFu/g3LW6EGLB0pa6Xpedx9mhlYTp0Zwf+jz7zjyEamzoAvU4O4HcbTmAuiAhwg0k74w==
X-Received: by 2002:adf:feca:: with SMTP id q10mr11915120wrs.199.1585270143300;
        Thu, 26 Mar 2020 17:49:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t124sm6226719wmg.13.2020.03.26.17.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 17:49:02 -0700 (PDT)
Message-Id: <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
References: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Mar 2020 00:48:43 +0000
Subject: [PATCH v3 00/18] Sparse checkout improvements -- improved sparsity updating
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series provides a replacement for the sparsity updating in
sparse-checkout that is based on the logic from git read-tree -mu HEAD. The
most important bit is patch 9 and its lengthy commit message explaining the
current state and rationale for most the series, though patches 16 and 17
have additional related directions and rationale for the series. Those three
patches are the most important to review.

Changes since v2:

 * addressed Stolee's cleanups and added his Reviewed-by to the series
   (hopefully the next two changes don't invalidate that)
 * added a test for the new 'reapply' subcommand (noticed it was missing
   with Stolee's test coverage report)
 * fix a minor issue with two of the other tests I modified -- when I'm
   grepping through stderr for a command, I need to make sure to actually
   record stderr from that command (otherwise my grep is looking through the
   stderr of a previous command that was recorded). Also, since I messed
   this up, I added one or two more sanity checks while I was at it.

Elijah Newren (18):
  unpack-trees: fix minor typo in comment
  unpack-trees: remove unused error type
  unpack-trees: simplify verify_absent_sparse()
  unpack-trees: simplify pattern_list freeing
  t1091: make some tests a little more defensive against failures
  unpack-trees: allow check_updates() to work on a different index
  unpack-trees: do not mark a dirty path with SKIP_WORKTREE
  unpack-trees: pull sparse-checkout pattern reading into a new function
  unpack-trees: add a new update_sparsity() function
  sparse-checkout: use new update_sparsity() function
  sparse-checkout: use improved unpack_trees porcelain messages
  unpack-trees: move ERROR_WOULD_LOSE_SUBMODULE earlier
  unpack-trees: rename ERROR_* fields meant for warnings to WARNING_*
  unpack-trees: split display_error_msgs() into two
  unpack-trees: make sparse path messages sound like warnings
  unpack-trees: provide warnings on sparse updates for unmerged paths
    too
  unpack-trees: failure to set SKIP_WORKTREE bits always just a warning
  sparse-checkout: provide a new reapply subcommand

 Documentation/git-sparse-checkout.txt |  10 +
 builtin/sparse-checkout.c             |  55 +++---
 t/t1011-read-tree-sparse-checkout.sh  |  11 +-
 t/t1091-sparse-checkout-builtin.sh    | 105 ++++++++++-
 t/t2018-checkout-branch.sh            |  22 +++
 unpack-trees.c                        | 255 ++++++++++++++++++++------
 unpack-trees.h                        |  28 ++-
 7 files changed, 375 insertions(+), 111 deletions(-)


base-commit: be8661a3286c67a5d4088f4226cbd7f8b76544b0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-726%2Fnewren%2Fsparse-checkout-improvements-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-726/newren/sparse-checkout-improvements-v3
Pull-Request: https://github.com/git/git/pull/726

Range-diff vs v2:

  1:  3c183727c98 !  1:  bb41a2a52f4 unpack-trees: fix minor typo in comment
     @@ -2,6 +2,7 @@
      
          unpack-trees: fix minor typo in comment
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/unpack-trees.c b/unpack-trees.c
  2:  e6beb1c5810 !  2:  1dc36eb33f7 unpack-trees: remove unused error type
     @@ -19,6 +19,7 @@
          introduced and nothing else has used it in the intervening decade
          either.  Remove it.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/unpack-trees.c b/unpack-trees.c
  3:  739b52393fe !  3:  97a95e91d8f unpack-trees: simplify verify_absent_sparse()
     @@ -11,6 +11,7 @@
          and no other caller has been created, and no other value has ever been
          passed, so just pass the expected value to begin with.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/unpack-trees.c b/unpack-trees.c
  4:  65772dd46df !  4:  1ce5dbe9c68 unpack-trees: simplify pattern_list freeing
     @@ -13,6 +13,7 @@
          additional flag in unpack_trees_options.  Put the logic back in the
          relevant function and discard the now unnecessary flag.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
  5:  5cbab2a7a56 !  5:  da4b74093cd t1091: make some tests a little more defensive against failures
     @@ -2,6 +2,7 @@
      
          t1091: make some tests a little more defensive against failures
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
  6:  5fea19f0136 !  6:  555eedf5380 unpack-trees: allow check_updates() to work on a different index
     @@ -6,6 +6,7 @@
          to use this function in combination with a different index_state, so
          take the intended index_state as a parameter.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/unpack-trees.c b/unpack-trees.c
  7:  3d2531ca818 !  7:  10ec70fa697 unpack-trees: do not mark a dirty path with SKIP_WORKTREE
     @@ -15,6 +15,7 @@
          paths.  Leaving dirty working files in the working tree is thus a
          natural extension of what we have already been doing.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/unpack-trees.c b/unpack-trees.c
  8:  27d6304d33f !  8:  8ed2f4e49ed unpack-trees: pull sparse-checkout pattern reading into a new function
     @@ -6,6 +6,7 @@
          path_patterns from $GIT_DIR/info/sparse-checkout so that we can re-use
          it elsewhere.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/unpack-trees.c b/unpack-trees.c
  9:  a46439c8536 !  9:  3a1f084641e unpack-trees: add a new update_sparsity() function
     @@ -71,6 +71,7 @@
          are marked SKIP_WORKTREE and thus doesn't delete them, and `commit -a`
          is similar), it seems logical to me.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/unpack-trees.c b/unpack-trees.c
     @@ -130,7 +131,6 @@
      +
      +		if (!ce_skip_worktree(ce))
      +			empty_worktree = 0;
     -+
      +	}
      +
      +	/*
     @@ -166,8 +166,8 @@
       --- a/unpack-trees.h
       +++ b/unpack-trees.h
      @@
     - 	NB_UNPACK_TREES_ERROR_TYPES
     - };
     + int unpack_trees(unsigned n, struct tree_desc *t,
     + 		 struct unpack_trees_options *options);
       
      +enum update_sparsity_result {
      +	UPDATE_SPARSITY_SUCCESS = 0,
     @@ -176,14 +176,7 @@
      +	UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES = -2
      +};
      +
     - /*
     -  * Sets the list of user-friendly error messages to be used by the
     -  * command "cmd" (either merge or checkout), and show_all_errors to 1.
     -@@
     - int unpack_trees(unsigned n, struct tree_desc *t,
     - 		 struct unpack_trees_options *options);
     - 
     -+int update_sparsity(struct unpack_trees_options *options);
     ++enum update_sparsity_result update_sparsity(struct unpack_trees_options *options);
      +
       int verify_uptodate(const struct cache_entry *ce,
       		    struct unpack_trees_options *o);
 10:  27ed4a3f7a2 ! 10:  9040ac97175 sparse-checkout: use new update_sparsity() function
     @@ -6,6 +6,12 @@
          codepaths for setting the SKIP_WORKTREE bits and instead use the new
          update_sparsity() function.
      
     +    Note that when an issue is hit, the error message splits 'error' and
     +    'Cannot update sparse checkout' on separate lines.  For now, we use two
     +    greps to find both pieces of the error message but subsequent commits
     +    will clean up the messages reported to the user.
     +
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
     @@ -147,14 +153,21 @@
      +	test_i18ngrep "error" err &&
      +	test_i18ngrep "Cannot update sparse checkout" err &&
      +
     -+	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
     ++	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* 2>err &&
      +	test_i18ngrep "error" err &&
      +	test_i18ngrep "Cannot update sparse checkout" err &&
     ++	test_path_is_file dirty/folder1/a &&
      +
     -+	git -C dirty sparse-checkout disable &&
     -+	test_i18ngrep "error" err &&
     -+	test_i18ngrep "Cannot update sparse checkout" err &&
     ++	git -C dirty sparse-checkout disable 2>err &&
     ++	test_must_be_empty err &&
      +
       	git -C dirty reset --hard &&
       	git -C dirty sparse-checkout init &&
       	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
     +-	git -C dirty sparse-checkout disable
     ++	test_path_is_missing dirty/folder1/a &&
     ++	git -C dirty sparse-checkout disable &&
     ++	test_path_is_file dirty/folder1/a
     + '
     + 
     + test_expect_success 'cone mode: set with core.ignoreCase=true' '
 11:  79b9cc1df55 ! 11:  e9c7e8ec46f sparse-checkout: use improved unpack_trees porcelain messages
     @@ -23,6 +23,7 @@
          we even called unpack_trees().  The previous commit changed that,
          though, so let's use the better error messages.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
     @@ -50,15 +51,10 @@
      -	test_i18ngrep "Cannot update sparse checkout" err &&
      +	test_i18ngrep "error.*Cannot update sparse checkout" err &&
       
     - 	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
     + 	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* 2>err &&
      -	test_i18ngrep "error" err &&
      -	test_i18ngrep "Cannot update sparse checkout" err &&
      +	test_i18ngrep "error.*Cannot update sparse checkout" err &&
     + 	test_path_is_file dirty/folder1/a &&
       
     - 	git -C dirty sparse-checkout disable &&
     --	test_i18ngrep "error" err &&
     --	test_i18ngrep "Cannot update sparse checkout" err &&
     -+	test_i18ngrep "error.*Cannot update sparse checkout" err &&
     - 
     - 	git -C dirty reset --hard &&
     - 	git -C dirty sparse-checkout init &&
     + 	git -C dirty sparse-checkout disable 2>err &&
 12:  2ba7bbdaee3 ! 12:  c3741107a9d unpack-trees: move ERROR_WOULD_LOSE_SUBMODULE earlier
     @@ -5,6 +5,7 @@
          A minor change, but we want to convert the sparse messages to warnings
          and this allows us to group warnings and errors.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/unpack-trees.c b/unpack-trees.c
 13:  203ece0ec2f ! 13:  90c514e220b unpack-trees: rename ERROR_* fields meant for warnings to WARNING_*
     @@ -6,6 +6,7 @@
          rather than an error; rename the enum values to reflect this intent as
          a simple step towards that goal.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/unpack-trees.c b/unpack-trees.c
     @@ -72,4 +73,4 @@
      +	NB_UNPACK_TREES_ERROR_TYPES,
       };
       
     - enum update_sparsity_result {
     + /*
 14:  57679c8e292 ! 14:  5676e890f65 unpack-trees: split display_error_msgs() into two
     @@ -10,6 +10,7 @@
          A subsequent commit will further modify unpack_trees() and how it calls
          the new display_warning_msgs().
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
     @@ -22,16 +23,12 @@
      -	test_i18ngrep "error.*Cannot update sparse checkout" err &&
      +	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
       
     - 	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
     + 	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* 2>err &&
      -	test_i18ngrep "error.*Cannot update sparse checkout" err &&
      +	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
     + 	test_path_is_file dirty/folder1/a &&
       
     - 	git -C dirty sparse-checkout disable &&
     --	test_i18ngrep "error.*Cannot update sparse checkout" err &&
     -+	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
     - 
     - 	git -C dirty reset --hard &&
     - 	git -C dirty sparse-checkout init &&
     + 	git -C dirty sparse-checkout disable 2>err &&
      
       diff --git a/unpack-trees.c b/unpack-trees.c
       --- a/unpack-trees.c
     @@ -100,7 +97,7 @@
      +{
      +	int e;
      +	unsigned warning_displayed = 0;
     -+	for (e = NB_UNPACK_TREES_ERROR_TYPES+1;
     ++	for (e = NB_UNPACK_TREES_ERROR_TYPES + 1;
      +	     e < NB_UNPACK_TREES_WARNING_TYPES; e++) {
      +		struct string_list *rejects = &o->unpack_rejects[e];
      +
     @@ -160,7 +157,7 @@
      +	NB_UNPACK_TREES_WARNING_TYPES,
       };
       
     - enum update_sparsity_result {
     + /*
      @@
       	struct dir_struct *dir;
       	struct pathspec *pathspec;
 15:  02a8e01f35b ! 15:  74e13ccee40 unpack-trees: make sparse path messages sound like warnings
     @@ -7,6 +7,7 @@
          operation abort.  Reword the messages to make sense in their new
          context.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
     @@ -28,16 +29,12 @@
      -	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
      +	test_i18ngrep "warning.*The following paths are not up to date" err &&
       
     - 	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
     + 	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* 2>err &&
      -	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
      +	test_i18ngrep "warning.*The following paths are not up to date" err &&
     + 	test_path_is_file dirty/folder1/a &&
       
     - 	git -C dirty sparse-checkout disable &&
     --	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
     -+	test_i18ngrep "warning.*The following paths are not up to date" err &&
     - 
     - 	git -C dirty reset --hard &&
     - 	git -C dirty sparse-checkout init &&
     + 	git -C dirty sparse-checkout disable 2>err &&
      
       diff --git a/unpack-trees.c b/unpack-trees.c
       --- a/unpack-trees.c
 16:  f664a6dcbb3 ! 16:  5d9e8a9d27e unpack-trees: provide warnings on sparse updates for unmerged paths too
     @@ -7,13 +7,14 @@
          those files have dirty changes.  Add a similar warning for unmerged
          paths as well.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
       --- a/t/t1091-sparse-checkout-builtin.sh
       +++ b/t/t1091-sparse-checkout-builtin.sh
      @@
     - 	git -C dirty sparse-checkout disable
     + 	test_path_is_file dirty/folder1/a
       '
       
      +test_expect_success 'sparse-checkout (init|set|disable) warns with unmerged status' '
     @@ -28,10 +29,11 @@
      +	git -C unmerged sparse-checkout init 2>err &&
      +	test_i18ngrep "warning.*The following paths are unmerged" err &&
      +
     -+	git -C unmerged sparse-checkout set /folder2/* /deep/deeper1/* &&
     ++	git -C unmerged sparse-checkout set /folder2/* /deep/deeper1/* 2>err &&
      +	test_i18ngrep "warning.*The following paths are unmerged" err &&
     ++	test_path_is_file dirty/folder1/a &&
      +
     -+	git -C unmerged sparse-checkout disable &&
     ++	git -C unmerged sparse-checkout disable 2>err &&
      +	test_i18ngrep "warning.*The following paths are unmerged" err &&
      +
      +	git -C unmerged reset --hard &&
 17:  fa997a1c72f ! 17:  844306c3e86 unpack-trees: failure to set SKIP_WORKTREE bits always just a warning
     @@ -37,6 +37,7 @@
          Downgrade any errors from inability to toggle the SKIP_WORKTREE bit to a
          warning and allow the operations to continue.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
 18:  5730f7d250a ! 18:  93dbdd78acf sparse-checkout: provide a new reapply subcommand
     @@ -7,6 +7,7 @@
          due to dirty changes, users may want a command to simply 'reapply' the
          sparsity rules.  Provide one.
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
     @@ -64,3 +65,55 @@
       		if (!strcmp(argv[0], "disable"))
       			return sparse_checkout_disable(argc, argv);
       	}
     +
     + diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
     + --- a/t/t1091-sparse-checkout-builtin.sh
     + +++ b/t/t1091-sparse-checkout-builtin.sh
     +@@
     + 	git -C unmerged sparse-checkout disable
     + '
     + 
     ++test_expect_success 'sparse-checkout reapply' '
     ++	git clone repo tweak &&
     ++
     ++	echo dirty >tweak/deep/deeper2/a &&
     ++
     ++	cat >input <<-EOF &&
     ++	0 0000000000000000000000000000000000000000	folder1/a
     ++	100644 $(git -C tweak rev-parse HEAD:folder1/a) 1	folder1/a
     ++	EOF
     ++	git -C tweak update-index --index-info <input &&
     ++
     ++	git -C tweak sparse-checkout init --cone 2>err &&
     ++	test_i18ngrep "warning.*The following paths are not up to date" err &&
     ++	test_i18ngrep "warning.*The following paths are unmerged" err &&
     ++
     ++	git -C tweak sparse-checkout set folder2 deep/deeper1 2>err &&
     ++	test_i18ngrep "warning.*The following paths are not up to date" err &&
     ++	test_i18ngrep "warning.*The following paths are unmerged" err &&
     ++
     ++	git -C tweak sparse-checkout reapply 2>err &&
     ++	test_i18ngrep "warning.*The following paths are not up to date" err &&
     ++	test_path_is_file tweak/deep/deeper2/a &&
     ++	test_i18ngrep "warning.*The following paths are unmerged" err &&
     ++	test_path_is_file tweak/folder1/a &&
     ++
     ++	git -C tweak checkout HEAD deep/deeper2/a &&
     ++	git -C tweak sparse-checkout reapply 2>err &&
     ++	test_i18ngrep ! "warning.*The following paths are not up to date" err &&
     ++	test_path_is_missing tweak/deep/deeper2/a &&
     ++	test_i18ngrep "warning.*The following paths are unmerged" err &&
     ++	test_path_is_file tweak/folder1/a &&
     ++
     ++	git -C tweak add folder1/a &&
     ++	git -C tweak sparse-checkout reapply 2>err &&
     ++	test_must_be_empty err &&
     ++	test_path_is_missing tweak/deep/deeper2/a &&
     ++	test_path_is_missing tweak/folder1/a &&
     ++
     ++	git -C tweak sparse-checkout disable
     ++'
     ++
     + test_expect_success 'cone mode: set with core.ignoreCase=true' '
     + 	rm repo/.git/info/sparse-checkout &&
     + 	git -C repo sparse-checkout init --cone &&

-- 
gitgitgadget
