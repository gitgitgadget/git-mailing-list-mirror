Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628B0C433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 08:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbiBOIci (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 03:32:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbiBOIch (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 03:32:37 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD1FA94EE
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 00:32:27 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v12so30796845wrv.2
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 00:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Y75kwY3YbWlZeRJiQcHToSlBZUfnQ69xJLB7x67Fja4=;
        b=S7ft7w5jlc4jnd/vhIYqcuazHmDDsrae+HMmhAj7HlTVlo6psGnMHWDILzXFXSXAeH
         PI5eH1BDONOPMnC5enqujdcF4KwlQTBa6R5bQCyWzbvnYNlT4eGQafFR+lmXsA5Uc0b7
         hydmjgEr5ftoGL1Zpkp3emNpS/6aG48Vhsm9YzUzuGmlp7vKTsJIFmljrWKxrwt4xcWR
         6Hc4gWegjnhQ1UX7lgLWpzP+MKJwCcNkVXaOAq5pLnxfjT6ZuiXmz30V+1SlCN4uDIUb
         qpiek3e/YBfJxtAuNMwl7+M30utSgE6LRWGPu75ETU9ndJ1EbWJd8gmGgTEeShjHxTfo
         uulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Y75kwY3YbWlZeRJiQcHToSlBZUfnQ69xJLB7x67Fja4=;
        b=Gczhr7h/rBxXlrADSwUHkANOqRYNcb8WeU2RDooGGupUgLWMF1fw8sCHZykqhcTc5M
         NgBkNOH+HIzPtrpThyJ/Ho8Iw5Mdi+iwS5bbU2R3n6Ox/DRgn/58bkOI0n8bpaspUiv2
         DvCmq3Str4LnRinFbx0c85bJdvse4FCLtVcPzNy/dzbN1jCXlwJLav8xJM32h1pjPZoU
         tCs3G/rQbyPTcoXEOHjE8zQwHxPFMKNHz7TfPP6sLKqhwkbrm30DByML+SN+FZF+mqAH
         gaMKFJTVTWcfbjOxSu9HK63OX+TSlSucAAO4iYq4AMSX7RCgbgQNIqdPFNwvbZJJfQOi
         e4aQ==
X-Gm-Message-State: AOAM532ZUVgKEnee48H95knsJYWkAfLoI2WI05qTNFOPap/D+VDpWNvd
        hxQ1g1kVFLqRgkDLPTKQHyyb+CGB7nU=
X-Google-Smtp-Source: ABdhPJxvaGMOJWirNJTewjLfT/cjco6RiP0N5xMWz7ycO3Oa3ehXm26yT1x+2ZofiofIPAr+KxllAA==
X-Received: by 2002:adf:cd0f:: with SMTP id w15mr2164557wrm.335.1644913945214;
        Tue, 15 Feb 2022 00:32:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14sm13356856wmq.3.2022.02.15.00.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 00:32:24 -0800 (PST)
Message-Id: <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 08:32:17 +0000
Subject: [PATCH v2 0/6] sparse checkout: fix a few bugs and check argument validity for set/add
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

Note1: This has been rebased on origin/master. v1 wasn't picked up anyway,
so this shouldn't matter, but just pointing it out.

Note2: There is a small textual and small semantic conflict with
ds/sparse-checkout-requires-per-worktree-config in seen. I included the diff
with the correct resolution near the end of this cover letter.

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
 * Patches 4-6 check positional arguments to set/add and provide
   errors/warnings for very likely mistakes. It also adds a --skip-checks
   flag for overridding in case you have a very unusual situation.

== Update history ==

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

Elijah Newren (6):
  sparse-checkout: correct reapply's handling of options
  sparse-checkout: correctly set non-cone mode when expected
  sparse-checkout: pay attention to prefix for {set, add}
  sparse-checkout: error or warn when given individual files
  sparse-checkout: reject non-cone-mode patterns starting with a '#'
  sparse-checkout: reject arguments in cone-mode that look like patterns

 builtin/sparse-checkout.c          | 84 +++++++++++++++++++++++++--
 t/t1091-sparse-checkout-builtin.sh | 93 +++++++++++++++++++++++++++++-
 2 files changed, 170 insertions(+), 7 deletions(-)


base-commit: b80121027d1247a0754b3cc46897fee75c050b44
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1118%2Fnewren%2Fsparse-checkout-default-and-arg-validity-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1118/newren/sparse-checkout-default-and-arg-validity-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1118

Range-diff vs v1:

 1:  00777e77118 ! 1:  5536fe6498e sparse-checkout: correct reapply's handling of options
     @@ t/t1091-sparse-checkout-builtin.sh: test_expect_failure 'sparse-checkout reapply
      +	cat >expect <<-\EOF &&
      +	core.sparsecheckout=true
      +	core.sparsecheckoutcone=true
     -+	index.sparse=false
      +	EOF
      +	test_cmp expect actual &&
      +
     @@ t/t1091-sparse-checkout-builtin.sh: test_expect_failure 'sparse-checkout reapply
      +	git -C repo config --worktree --list >actual &&
      +	cat >expect <<-\EOF &&
      +	core.sparsecheckout=true
     -+	core.sparsecheckoutcone=false
     -+	index.sparse=false
      +	EOF
      +	test_cmp expect actual &&
      +
 2:  3bab5960404 ! 2:  9edad872e0d sparse-checkout: correctly set non-cone mode when expected
     @@ Commit message
      
          commit f2e3a218e8 ("sparse-checkout: enable `set` to initialize
          sparse-checkout mode", 2021-12-14) made the `set` command able to
     -    intialize sparse-checkout mode, but it also had to function when
     +    initialize sparse-checkout mode, but it also had to function when
          sparse-checkout mode was already setup and the user just wanted to
          change the sparsity paths.  So, if the user passed --cone or --no-cone,
          then we should override the current setting, but if they didn't pass
     @@ Commit message
          set the in-memory cone mode value (core_sparse_checkout_one) when
          --no-cone was specified, but since it did set the config setting on
          disk, any subsequent git invocation would correctly get non-cone mode.
     -    As such, the error did not previously matter.  However, a sbusequent
     +    As such, the error did not previously matter.  However, a subsequent
          commit will add some logic that depends on core_sparse_checkout_cone
          being set to the correct mode, so make sure it is set consistently with
          the config values we will be writing to disk.
     @@ builtin/sparse-checkout.c: static int update_modes(int *cone_mode, int *sparse_i
       		core_sparse_checkout_cone = 1;
       	} else {
       		mode = MODE_ALL_PATTERNS;
     -+		if (record_mode)
     -+			core_sparse_checkout_cone = 0;
     ++		core_sparse_checkout_cone = 0;
       	}
       	if (record_mode && set_config(mode))
       		return 1;
 3:  679f869ff11 ! 3:  f57820e25d6 sparse-checkout: pay attention to prefix for {set, add}
     @@ Commit message
          while the later will result in
             fatal: Invalid path '/toplevel-dir': No such file or directory
          despite the fact that both are valid gitignore-style patterns that would
     -    select real files if added to the sparse-checkout file.  However, these
     -    commands can be run successfully from the toplevel directory, and many
     -    gitignore-style patterns ARE paths, and bash completion seems to be
     -    suggesting directories and files, so perhaps for consistency we pay
     -    attention to the prefix?  It's not clear what is okay here, but maybe
     -    that's yet another reason to deprecate non-cone mode as we will do later
     -    in this series.
     +    select real files if added to the sparse-checkout file.  This might lead
     +    people to just use the path without the leading slash, potentially
     +    resulting in them grabbing files with the same name throughout the
     +    directory hierarchy contrary to their expectations.  See also [1] and
     +    [2].  Adding prefix seems to just be fraught with error; so for now
     +    simply throw an error in non-cone mode when sparse-checkout set/add are
     +    run from a subdirectory.
      
     -    For now, incorporate prefix into the positional arguments for either
     -    cone or non-cone mode.  For additional discussion of this issue, see
     -    https://lore.kernel.org/git/29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.com/
     +    [1] https://lore.kernel.org/git/e1934710-e228-adc4-d37c-f706883bd27c@gmail.com/
     +    [2] https://lore.kernel.org/git/CABPp-BHXZ-XLxY0a3wCATfdq=6-EjW62RzbxKAoFPeXfJswD2w@mail.gmail.com/
      
          Helped-by: Junio Hamano <gitster@pobox.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
     @@ builtin/sparse-checkout.c: static int modify_pattern_list(int argc, const char *
      +		int i;
      +		int prefix_len = strlen(prefix);
      +
     ++		if (!core_sparse_checkout_cone)
     ++			die("please run from the toplevel directory in non-cone mode");
     ++
      +		for (i = 0; i < argc; i++)
      +			argv[i] = prefix_path(prefix, prefix_len, argv[i]);
      +	}
     @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'malformed cone-mode pat
      +	EOF
      +	test_cmp expect actual
      +'
     ++
     ++test_expect_success 'set from subdir in non-cone mode throws an error' '
     ++	git -C repo sparse-checkout disable &&
     ++	test_must_fail git -C repo/deep sparse-checkout set --no-cone deeper2 ../folder1 2>error &&
     ++
     ++	grep "run from the toplevel directory in non-cone mode" error
     ++'
     ++
     ++test_expect_success 'set from subdir in non-cone mode throws an error' '
     ++	git -C repo sparse-checkout set --no-cone deep/deeper2 &&
     ++	test_must_fail git -C repo/deep sparse-checkout add deeper1/deepest ../folder1 2>error &&
     ++
     ++	grep "run from the toplevel directory in non-cone mode" error
     ++'
      +
       test_done
 4:  5e27cad17a7 ! 4:  c3bb2a3b2f1 sparse-checkout: error or warn when given individual files
     @@ Commit message
          (e.g. for the case when the given path IS a directory on another
          branch).
      
     -    Non-cone mode accepts general gitignore patterns.  However, it has an
     -    O(N*M) performance baked into its design, where all N index files must
     -    be matched against all M sparse-checkout patterns with EVERY call to
     -    unpack_trees() that updates the working tree.  As such, it is important
     -    to keep the number of patterns small, and thus we should warn users to
     -    prefer passing directories and more generic glob patterns to get the
     -    paths they want instead of listing each individual file.  (The
     -    --skip-checks argument can also be used to bypass this warning.)  Also,
     -    even when users do want to specify individual files, they will often
     -    want to do so by providing a leading '/' (to avoid selecting the same
     -    filename in all subdirectories), in which case this error message would
     -    never trigger anyway.
     +    Non-cone mode accepts general gitignore patterns.  There are many
     +    reasons to avoid this mode, but one possible reason to use it instead of
     +    cone mode: to be able to select individual files within a directory.
     +    However, if a file is passed to set/add in non-cone mode, you won't be
     +    selecting a single file, you'll be selecting a file with the same name
     +    in any directory.  Thus users will likely want to prefix any paths they
     +    specify with a leading '/' character; warn users if the patterns they
     +    specify exactly name a file because it means they are likely missing
     +    such a missing leading slash.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ builtin/sparse-checkout.c: static void sanitize_paths(int argc, const char **arg
      -		int i;
       		int prefix_len = strlen(prefix);
       
     + 		if (!core_sparse_checkout_cone)
     +@@ builtin/sparse-checkout.c: static void sanitize_paths(int argc, const char **argv, const char *prefix)
       		for (i = 0; i < argc; i++)
       			argv[i] = prefix_path(prefix, prefix_len, argv[i]);
       	}
     @@ builtin/sparse-checkout.c: static void sanitize_paths(int argc, const char **arg
      +		if (core_sparse_checkout_cone)
      +			die(_("\"%s\" is not a directory; to treat it as a directory anyway, rerun with --skip-checks"), argv[i]);
      +		else
     -+			warning(_("path \"%s\" is an individual file; passing directories or less specific patterns is recommended (see NON-CONE PROBLEMS in the git-sparse-checkout manual)."), argv[i]);
     ++			warning(_("pass a leading slash before paths such as \"%s\" if you want a single file (see NON-CONE PROBLEMS in the git-sparse-checkout manual)."), argv[i]);
      +	}
       }
       
     @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'different sparse-checko
       	cat >expect <<-\EOF &&
       	/*
       	!/*/
     -@@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'add from subdir pays attention to prefix' '
     - 	test_cmp expect actual
     +@@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'set from subdir in non-cone mode throws an error' '
     + 	grep "run from the toplevel directory in non-cone mode" error
       '
       
      +test_expect_success 'by default, cone mode will error out when passed files' '
     @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'add from subdir pays at
      +	git -C repo sparse-checkout reapply --no-cone &&
      +	git -C repo sparse-checkout add .gitignore 2>warning &&
      +
     -+	grep "passing directories or less specific patterns is recommended" warning
     ++	grep "pass a leading slash before paths.*if you want a single file" warning
      +'
      +
       test_done
 5:  265cbe36b2d ! 5:  c5d4ae2cfd6 sparse-checkout: reject non-cone-mode patterns starting with a '#'
     @@ builtin/sparse-checkout.c: static void sanitize_paths(int argc, const char **arg
      
       ## t/t1091-sparse-checkout-builtin.sh ##
      @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'by default, non-cone mode will warn on individual files' '
     - 	grep "passing directories or less specific patterns is recommended" warning
     + 	grep "pass a leading slash before paths.*if you want a single file" warning
       '
       
      +test_expect_success 'paths starting with hash must be escaped in non-cone mode' '
 6:  502da48b8f4 = 6:  286c22e5ecd sparse-checkout: reject arguments in cone-mode that look like patterns
 7:  e30119b96df < -:  ----------- sparse-checkout: make --cone the default and deprecate --no-cone

-- 
gitgitgadget
