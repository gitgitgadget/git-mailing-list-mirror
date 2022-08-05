Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B83C19F2A
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 03:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbiHEDFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 23:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiHEDFw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 23:05:52 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D6A2DFA
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 20:05:50 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q16so1568024pgq.6
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 20:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Lv1PmHn/prWWHdRiOzL9eyIudlCQzCXaQ00OMiSuA0=;
        b=D30h51dXzbpa+2EVyDevu33y4YlglNtz3pyU3xlhCegWp5EBPdJxJGuPKO/mjRcyTs
         JH99EPEa+t05CLGKb0y6+h/2Zr2YALrMCdH3aOOnKCU25FbPt1nKhWe+Ep/RNT2qVgn/
         OOX6LmvtXy1lfeYUCkrt4eoLUWSQS+a63aEZw/rd6TimkWEDU2edJarAGCEIzbOGEDjC
         LVSfKfDcVoeG8Gr8JX0WTBlbkpDd2/HxiCZndC6Xb7I7S3ZK2iYKpsjUQ1/U3KB3Fdlg
         4QPGUahCg6jcU1UjjNXn+U2vg8uJYaKXrLi45VKfU1/CRNKH8nj88cgIF8JPJVMtKRSU
         Nwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Lv1PmHn/prWWHdRiOzL9eyIudlCQzCXaQ00OMiSuA0=;
        b=otTYpWBBf8YzGoBHtJAZI58bDRQ4hCrcA/tjNkBkaTqyaev7W3OZqfvoMgBMzK9o+o
         N+TehcSb35JVd2bzX7TGSN82GMJHXckyxXPj8OCxT3AJkrmTUl0R+H6Gg3nV3Toitjvh
         EzREc3kQGxSCzoAZUUF33Dwh4d/tnZM4k6MdaoVRpSARO8/jscfdeGeXr1Hsa89SS63B
         IWvKH2IDu8GFV6RRqNNG6aCDKEN8D1cAcdTh35RES9Duc04wb4WNqlx/I+lRHTKkLtzJ
         WRvSEbajoOFZb20dlMZcNw44nsT3ee8tp+odrkgOOaalx+Ng6k0thkjkVbHyjJ1sdy3H
         EDqg==
X-Gm-Message-State: ACgBeo0nb9AY/d3B4ktffgUDopVca2Me/2ZoXMhBQ8h7HaM1XyR35ZwO
        n9w8rs3n5bXwTkT7azptp/k/UuIFicWJC9Rv
X-Google-Smtp-Source: AA6agR5dXRiSYp9mESeO4xsWKbHObKU+2f9WnuD9ev1InGqvxvfIgbz6/eH6mCGaXET4NGpCeSP+Ug==
X-Received: by 2002:a63:2223:0:b0:41c:7995:ef4f with SMTP id i35-20020a632223000000b0041c7995ef4fmr4167516pgi.451.1659668749161;
        Thu, 04 Aug 2022 20:05:49 -0700 (PDT)
Received: from ffyuanda.localdomain ([113.65.229.239])
        by smtp.gmail.com with ESMTPSA id i6-20020a654d06000000b0040df0c9a1aasm570234pgt.14.2022.08.04.20.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 20:05:48 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v2 0/9] mv: from in-cone to out-of-cone
Date:   Fri,  5 Aug 2022 11:05:19 +0800
Message-Id: <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

## Changes since PATCH v1 ##

1. Change "grep -x" to ^ and $ in t7002 test, and remove some
   useless "-x" (lines that are *not* ambiguous).

2. Rename check_dir_in_index() to empty_dir_has_sparse_contents()
   and add more precise documentation.

3. Reverse return values from empty_dir_has_sparse_contents() to
   comply with the method's name.

4. Make some commit messages more natural/fluent/without typos.

5. Split commit "mv: from in-cone to out-of-cone" to two commits,
   one does in-to-out functionality, the other one does advice.

6. Take care a few memory leaks (`xstrdup`s).

7. Add a new way to recursively cleanup empty WORKING_DIRECTORY.

## leftover bits ##

I decided *not* to solve these bits in v2, but in a future v3,
so things can be handled one at a time, not exceeding my capability.

1. When trying to move from-in-to-out, the mechanism assumes that
   the <destination> is out-of-cone, and by cone-mode definition,
   <destination> is basically an invisible directory 
   (SKIP_WORKTREE_DIR). However, the dirty move mechanism materializes
   the moved file to make sure the information is not lost, and this
   mechanism brings the invisible directory back into the worktree.
   Hence, if we want to perform a second move from-in-to-out, the
   assumption that <destination> is not on-disk is broken, and
   everything follows breaks too. 

2. A logic loophole introduced in the previous out-to-in patch,
   especially in b91a2b6594 (mv: add check_dir_in_index() and solve 
   general dir check issue). Please detach your head to b91a2b6594
   for context. Copy and paste: 
   
                    git switch b91a2b6594
   
   When moving from out-to-in, <source> is an invisible 
   SKIP_WORKTREE_DIR. Line 226 uses `lstat()` to make
   sure the <source> is not on-disk; then line 233-237 checks if
   <source> is a SKIP_WORKTREE_DIR. If the check passes, line 236
   jump to line 276 and try to verify <source> is a directory using
   `S_ISDIR`. However, because the prerequisite is that the line 226
   `lstat()` fails so we can go through the steps said above; and when
   it fails, the `st` stat, especially the `st_mode` member, is either
   an uninitialized chunk of garbage, or the result from previous
   `lstat()`. In this case, `st_mode` *is* from a previous `lstat()`,
   on line 205. This `lstat()` is testing the <destination>, which,
   under the out-to-in situation, is always an on-disk directory.
   Thus, by a series of coincidence, the `S_ISDIR()` on line 276
   succeed and everything *looks* OK test-wise. But clearly the `st`
   at this point is an impostor: it does not reflect the actual stat
   situation of <source> and it luckily slips through.

   This needs to be fixed.

## PATCH v1 info ##

This is a sister series to the previous "from out-of-cone to in-cone" [1]
series. This series is trying to make the opposite operation possible for
'mv', namely move <source>, which is in-cone, to <destination>, which is
out-of-cone.

Other than the main task, there are also some minor fixes done.

[1] https://lore.kernel.org/git/20220331091755.385961-1-shaoxuan.yuan02@gmail.com/

Shaoxuan Yuan (9):
  t7002: add tests for moving from in-cone to out-of-cone
  mv: rename check_dir_in_index() to empty_dir_has_sparse_contents()
  mv: free the *with_slash in check_dir_in_index()
  mv: check if <destination> is a SKIP_WORKTREE_DIR
  mv: remove BOTH from enum update_mode
  mv: from in-cone to out-of-cone
  mv: cleanup empty WORKING_DIRECTORY
  advice.h: add advise_on_moving_dirty_path()
  mv: check overwrite for in-to-out move

 advice.c                      |  19 +++++
 advice.h                      |   1 +
 builtin/mv.c                  | 143 ++++++++++++++++++++++++++------
 t/t7002-mv-sparse-checkout.sh | 150 +++++++++++++++++++++++++++++++++-
 4 files changed, 286 insertions(+), 27 deletions(-)

Range-diff against v1:
 1:  31d1136d40 !  1:  5de0a2585f t7002: add tests for moving from in-cone to out-of-cone
    @@ Commit message
         A dirty move should move the <source> to the <destination>, both in the
         working tree and the index, but should *not* remove the resulted path
         from the working tree and should *not* turn on its CE_SKIP_WORKTREE bit.
    -    Instead advise user to "git add" this path and run "git sparse-checkout
    -    reapply" to re-sparsify that path.
     
         Also make sure that if <destination> exists in the index (existing
         check for if <destination> is in the worktree is not enough in
         in-to-out moves), warn user against the overwrite. And Git should force
         the overwrite when supplied with -f or --force.
     
    +    Helped-by: Derrick Stolee <derrickstolee@github.com>
    +    Helped-by: Victoria Dye <vdye@github.com>
         Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
      ## t/t7002-mv-sparse-checkout.sh ##
    -@@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'setup' "
    - 	updated in the index:
    - 	EOF
    - 
    --	cat >sparse_hint <<-EOF
    -+	cat >sparse_hint <<-EOF &&
    - 	hint: If you intend to update such entries, try one of the following:
    - 	hint: * Use the --sparse option.
    - 	hint: * Disable or modify the sparsity rules.
    - 	hint: Disable this message with \"git config advice.updateSparsePath false\"
    - 	EOF
    -+
    -+	cat >dirty_error_header <<-EOF &&
    -+	The following paths have been moved outside the
    -+	sparse-checkout definition but are not sparse due to local
    -+	modifications.
    -+	EOF
    -+
    -+	cat >dirty_hint <<-EOF
    -+	hint: To correct the sparsity of these paths, do the following:
    -+	hint: * Use \"git add --sparse <paths>\" to update the index
    -+	hint: * Use \"git sparse-checkout reapply\" to apply the sparsity rules
    -+	hint: Disable this message with \"git config advice.updateSparsePath false\"
    -+	EOF
    - "
    - 
    - test_expect_success 'mv refuses to move sparse-to-sparse' '
     @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'move sparse file to existing destination with --force and -
      	test_cmp expect sub/file1
      '
    @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'move sparse file to existing
     +	test_path_is_missing sub/d &&
     +	test_path_is_missing folder1/d &&
     +	git ls-files -t >actual &&
    -+	! grep -x "H sub/d" actual &&
    -+	grep -x "S folder1/d" actual
    ++	! grep "^H sub/d\$" actual &&
    ++	grep "S folder1/d" actual
     +'
     +
     +test_expect_failure 'move clean path from in-cone to out-of-cone overwrite' '
    @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'move sparse file to existing
     +	test_path_is_missing sub/file1 &&
     +	test_path_is_missing folder1/file1 &&
     +	git ls-files -t >actual &&
    -+	! grep -x "H sub/file1" actual &&
    -+	grep -x "S folder1/file1" actual &&
    ++	! grep "H sub/file1" actual &&
    ++	grep "S folder1/file1" actual &&
     +
     +	# compare file content before move and after move
     +	echo "sub/file1 overwrite" >expect &&
    @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'move sparse file to existing
     +	test_cmp expect stderr &&
     +
     +	git mv --sparse sub/d folder1 2>stderr &&
    -+	cat dirty_error_header >expect &&
    -+	echo "folder1/d" >>expect &&
    -+	cat dirty_hint >>expect &&
    -+	test_cmp expect stderr &&
     +
     +	test_path_is_missing sub/d &&
     +	test_path_is_file folder1/d &&
     +	git ls-files -t >actual &&
    -+	! grep -x "H sub/d" actual &&
    -+	grep -x "H folder1/d" actual
    ++	! grep "^H sub/d\$" actual &&
    ++	grep "H folder1/d" actual
     +'
     +
     +test_expect_failure 'move dir from in-cone to out-of-cone' '
    @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'move sparse file to existing
     +	git mv --sparse sub/dir folder1 2>stderr &&
     +	test_must_be_empty stderr &&
     +
    -+	test_path_is_missing sub/dir &&
     +	test_path_is_missing folder1 &&
     +	git ls-files -t >actual &&
    -+	! grep -x "H sub/dir/e" actual &&
    -+	grep -x "S folder1/dir/e" actual
    ++	! grep "H sub/dir/e" actual &&
    ++	grep "S folder1/dir/e" actual
     +'
     +
     +test_expect_failure 'move partially-dirty dir from in-cone to out-of-cone' '
    @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'move sparse file to existing
     +	test_cmp expect stderr &&
     +
     +	git mv --sparse sub/dir folder1 2>stderr &&
    -+	cat dirty_error_header >expect &&
    -+	echo "folder1/dir/e2" >>expect &&
    -+	echo "folder1/dir/e3" >>expect &&
    -+	cat dirty_hint >>expect &&
    -+	test_cmp expect stderr &&
     +
    -+	test_path_is_missing sub/dir &&
     +	test_path_is_missing folder1/dir/e &&
     +	test_path_is_file folder1/dir/e2 &&
     +	test_path_is_file folder1/dir/e3 &&
     +	git ls-files -t >actual &&
    -+	! grep -x "H sub/dir/e" actual &&
    -+	! grep -x "H sub/dir/e2" actual &&
    -+	! grep -x "H sub/dir/e3" actual &&
    -+	grep -x "S folder1/dir/e" actual &&
    -+	grep -x "H folder1/dir/e2" actual &&
    -+	grep -x "H folder1/dir/e3" actual
    ++	! grep "H sub/dir/e" actual &&
    ++	! grep "H sub/dir/e2" actual &&
    ++	! grep "H sub/dir/e3" actual &&
    ++	grep "S folder1/dir/e" actual &&
    ++	grep "H folder1/dir/e2" actual &&
    ++	grep "H folder1/dir/e3" actual
     +'
     +
      test_done
 2:  df17173219 <  -:  ---------- mv: add documentation for check_dir_in_index()
 -:  ---------- >  2:  ebf8382f15 mv: rename check_dir_in_index() to empty_dir_has_sparse_contents()
 3:  61af1a2546 !  3:  26871b1070 mv: free the *with_slash in check_dir_in_index()
    @@ Commit message
     
         *with_slash may be a malloc'd pointer, and when it is, free it.
     
    +    Helped-by: Derrick Stolee <derrickstolee@github.com>
    +    Helped-by: Victoria Dye <vdye@github.com>
         Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
      ## builtin/mv.c ##
     @@ builtin/mv.c: static int index_range_of_same_dir(const char *src, int length,
       */
    - static int check_dir_in_index(const char *name)
    + static int empty_dir_has_sparse_contents(const char *name)
      {
    -+	int ret = 1;
    ++	int ret = 0;
      	const char *with_slash = add_slash(name);
      	int length = strlen(with_slash);
      
    -@@ builtin/mv.c: static int check_dir_in_index(const char *name)
    +@@ builtin/mv.c: static int empty_dir_has_sparse_contents(const char *name)
      	if (pos < 0) {
      		pos = -pos - 1;
      		if (pos >= the_index.cache_nr)
    --			return 1;
    +-			return 0;
     +			goto free_return;
      		ce = active_cache[pos];
      		if (strncmp(with_slash, ce->name, length))
    --			return 1;
    +-			return 0;
     +			goto free_return;
      		if (ce_skip_worktree(ce))
    --			return 0;
    -+			ret = 0;
    +-			return 1;
    ++			ret = 1;
      	}
    --	return 1;
    +-	return 0;
     +
     +free_return:
     +	if (with_slash != name)
 4:  c83fa51784 !  4:  872b3ebdce mv: check if <destination> is a SKIP_WORKTREE_DIR
    @@ Commit message
         in-cone to out-of-cone" patch.
     
         Change the logic so that Git first check if <destination> is a directory
    -    with all its contents sparsified (a SKIP_WORKTREE_DIR). If yes,
    -    then treat <destination> as a directory exists in the working tree, and
    -    thus using the second form of 'git-mv', i.e. move into this
    -    <destination>, and mark <destination> as a SKIP_WORKTREE_DIR.
    -    If no, continue the original checking logic.
    +    with all its contents sparsified (a SKIP_WORKTREE_DIR).
    +
    +    If <destination> is such a sparse directory, then we should modify the
    +    index the same way as we would if this were a non-sparse directory. We
    +    must be careful to ensure that the <destination> is marked with
    +    SKIP_WORKTREE_DIR.
     
         Also add a `dst_w_slash` to reuse the result from `add_slash()`, which
         was everywhere and can be simplified.
     
    +    Helped-by: Derrick Stolee <derrickstolee@github.com>
    +    Helped-by: Victoria Dye <vdye@github.com>
         Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
      ## builtin/mv.c ##
    @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
      		OPT_END(),
      	};
      	const char **source, **destination, **dest_path, **submodule_gitfile;
    --	enum update_mode *modes;
     +	const char *dst_w_slash;
    -+	enum update_mode *modes, dst_mode = 0;
    + 	enum update_mode *modes;
      	struct stat st;
      	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
    - 	struct lock_file lock_file = LOCK_INIT;
     @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
      	if (argc == 1 && is_directory(argv[0]) && !is_directory(argv[1]))
      		flags = 0;
    @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
      	} else {
     -		if (argc != 1)
     +		if (!path_in_sparse_checkout(dst_w_slash, &the_index) &&
    -+		    !check_dir_in_index(dst_w_slash)) {
    ++		    empty_dir_has_sparse_contents(dst_w_slash)) {
     +			destination = internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BASENAME);
    -+			dst_mode |= SKIP_WORKTREE_DIR;
     +		} else if (argc != 1) {
      			die(_("destination '%s' is not a directory"), dest_path[0]);
     -		destination = dest_path;
     +		} else {
     +			destination = dest_path;
     +		}
    - 	}
    -+	if (dst_w_slash != dest_path[0])
    ++	}
    ++	if (dst_w_slash != dest_path[0]) {
     +		free((char *)dst_w_slash);
    ++		dst_w_slash = NULL;
    + 	}
      
      	/* Checking */
    - 	for (i = 0; i < argc; i++) {
 5:  e50ff529c5 !  5:  df625cf852 mv: remove BOTH from enum update_mode
    @@ Metadata
      ## Commit message ##
         mv: remove BOTH from enum update_mode
     
    -    Since BOTH is not practically used anywhere in the code and its meaning
    -    is unclear, remove it.
    +    Since BOTH is not used anywhere in the code and its meaning is unclear,
    +    remove it.
     
    +    Helped-by: Derrick Stolee <derrickstolee@github.com>
    +    Helped-by: Victoria Dye <vdye@github.com>
         Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
      ## builtin/mv.c ##
 6:  1ae2e26237 !  6:  e4a4742d8b mv: from in-cone to out-of-cone
    @@ Commit message
         A dirty move should move the <source> to the <destination>, both in the
         working tree and the index, but should *not* remove the resulted path
         from the working tree and should *not* turn on its CE_SKIP_WORKTREE bit.
    -    Instead advise user to "git add" this path and run "git sparse-checkout
    -    reapply" to re-sparsify that path.
     
    +    Helped-by: Derrick Stolee <derrickstolee@github.com>
         Helped-by: Victoria Dye <vdye@github.com>
         Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
    - ## advice.c ##
    -@@ advice.c: void detach_advice(const char *new_name)
    - 
    - 	fprintf(stderr, fmt, new_name);
    - }
    -+
    -+void advise_on_moving_dirty_path(struct string_list *pathspec_list)
    -+{
    -+	struct string_list_item *item;
    -+
    -+	if (!pathspec_list->nr)
    -+		return;
    -+
    -+	fprintf(stderr, _("The following paths have been moved outside the\n"
    -+			  "sparse-checkout definition but are not sparse due to local\n"
    -+			  "modifications.\n"));
    -+	for_each_string_list_item(item, pathspec_list)
    -+		fprintf(stderr, "%s\n", item->string);
    -+
    -+	advise_if_enabled(ADVICE_UPDATE_SPARSE_PATH,
    -+			  _("To correct the sparsity of these paths, do the following:\n"
    -+			    "* Use \"git add --sparse <paths>\" to update the index\n"
    -+			    "* Use \"git sparse-checkout reapply\" to apply the sparsity rules"));
    -+}
    -
    - ## advice.h ##
    -@@ advice.h: void NORETURN die_conclude_merge(void);
    - void NORETURN die_ff_impossible(void);
    - void advise_on_updating_sparse_paths(struct string_list *pathspec_list);
    - void detach_advice(const char *new_name);
    -+void advise_on_moving_dirty_path(struct string_list *pathspec_list);
    - 
    - #endif /* ADVICE_H */
    -
      ## builtin/mv.c ##
     @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
    + 	};
    + 	const char **source, **destination, **dest_path, **submodule_gitfile;
    + 	const char *dst_w_slash;
    +-	enum update_mode *modes;
    ++	enum update_mode *modes, dst_mode = 0;
    + 	struct stat st;
    + 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
      	struct lock_file lock_file = LOCK_INIT;
      	struct cache_entry *ce;
      	struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
    @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
      
      	git_config(git_default_config, NULL);
      
    +@@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
    + 		if (!path_in_sparse_checkout(dst_w_slash, &the_index) &&
    + 		    empty_dir_has_sparse_contents(dst_w_slash)) {
    + 			destination = internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BASENAME);
    ++			dst_mode = SKIP_WORKTREE_DIR;
    + 		} else if (argc != 1) {
    + 			die(_("destination '%s' is not a directory"), dest_path[0]);
    + 		} else {
     @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
      		const char *src = source[i], *dst = destination[i];
      		enum update_mode mode = modes[i];
      		int pos;
    -+		int up_to_date = 0;
    ++		int sparse_and_dirty = 0;
      		struct checkout state = CHECKOUT_INIT;
      		state.istate = &the_index;
      
    @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
      		pos = cache_name_pos(src, strlen(src));
      		assert(pos >= 0);
     +		if (!(mode & SPARSE) && !lstat(src, &st))
    -+			up_to_date = !ce_modified(active_cache[pos], &st, 0);
    ++			sparse_and_dirty = ce_modified(active_cache[pos], &st, 0);
      		rename_cache_entry_at(pos, dst);
      
     -		if ((mode & SPARSE) &&
    @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
     +		if (ignore_sparse &&
     +		    core_apply_sparse_checkout &&
     +		    core_sparse_checkout_cone) {
    - 
    --			dst_pos = cache_name_pos(dst, strlen(dst));
    --			active_cache[dst_pos]->ce_flags &= ~CE_SKIP_WORKTREE;
    -+			/* from out-of-cone to in-cone */
     +			if ((mode & SPARSE) &&
     +			    path_in_sparse_checkout(dst, &the_index)) {
    ++				/* from out-of-cone to in-cone */
     +				int dst_pos = cache_name_pos(dst, strlen(dst));
     +				struct cache_entry *dst_ce = active_cache[dst_pos];
    - 
    --			if (checkout_entry(active_cache[dst_pos], &state, NULL, NULL))
    --				die(_("cannot checkout %s"), active_cache[dst_pos]->name);
    ++
     +				dst_ce->ce_flags &= ~CE_SKIP_WORKTREE;
     +
     +				if (checkout_entry(dst_ce, &state, NULL, NULL))
     +					die(_("cannot checkout %s"), dst_ce->name);
    -+				continue;
    -+			}
    -+
    -+			/* from in-cone to out-of-cone */
    -+			if ((dst_mode & SKIP_WORKTREE_DIR) &&
    -+			    !(mode & SPARSE) &&
    -+			    !path_in_sparse_checkout(dst, &the_index)) {
    ++			} else if ((dst_mode & SKIP_WORKTREE_DIR) &&
    ++				   !(mode & SPARSE) &&
    ++				   !path_in_sparse_checkout(dst, &the_index)) {
    ++				/* from in-cone to out-of-cone */
     +				int dst_pos = cache_name_pos(dst, strlen(dst));
     +				struct cache_entry *dst_ce = active_cache[dst_pos];
    -+				char *src_dir = dirname(xstrdup(src));
    -+
    -+				if (up_to_date) {
    + 
    +-			dst_pos = cache_name_pos(dst, strlen(dst));
    +-			active_cache[dst_pos]->ce_flags &= ~CE_SKIP_WORKTREE;
    +-
    +-			if (checkout_entry(active_cache[dst_pos], &state, NULL, NULL))
    +-				die(_("cannot checkout %s"), active_cache[dst_pos]->name);
    ++				/*
    ++				 * if src is clean, it will suffice to remove it
    ++				 */
    ++				if (!sparse_and_dirty) {
     +					dst_ce->ce_flags |= CE_SKIP_WORKTREE;
     +					unlink_or_warn(src);
     +				} else {
    ++					/*
    ++					 * if src is dirty, move it to the
    ++					 * destination and create leading
    ++					 * dirs if necessary
    ++					 */
    ++					char *dst_dup = xstrdup(dst);
     +					string_list_append(&dirty_paths, dst);
    -+					safe_create_leading_directories(xstrdup(dst));
    ++					safe_create_leading_directories(dst_dup);
    ++					FREE_AND_NULL(dst_dup);
     +					rename(src, dst);
     +				}
    -+				if ((mode & INDEX) && is_empty_dir(src_dir))
    -+					rmdir_or_warn(src_dir);
     +			}
      		}
      	}
      
    -+	if (dirty_paths.nr)
    -+		advise_on_moving_dirty_path(&dirty_paths);
    -+
    - 	if (gitmodules_modified)
    - 		stage_updated_gitmodules(&the_index);
    - 
     @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
      		die(_("Unable to write new index file"));
      
    @@ t/t7002-mv-sparse-checkout.sh: test_expect_failure 'move clean path from in-cone
      	setup_sparse_checkout &&
      	echo "modified" >>sub/d &&
     @@ t/t7002-mv-sparse-checkout.sh: test_expect_failure 'move dirty path from in-cone to out-of-cone' '
    - 	grep -x "H folder1/d" actual
    + 	grep "H folder1/d" actual
      '
      
     -test_expect_failure 'move dir from in-cone to out-of-cone' '
    @@ t/t7002-mv-sparse-checkout.sh: test_expect_failure 'move dirty path from in-cone
      	setup_sparse_checkout &&
      
     @@ t/t7002-mv-sparse-checkout.sh: test_expect_failure 'move dir from in-cone to out-of-cone' '
    - 	grep -x "S folder1/dir/e" actual
    + 	grep "S folder1/dir/e" actual
      '
      
     -test_expect_failure 'move partially-dirty dir from in-cone to out-of-cone' '
 -:  ---------- >  7:  fec084aaae mv: cleanup empty WORKING_DIRECTORY
 -:  ---------- >  8:  ac5345c013 advice.h: add advise_on_moving_dirty_path()
 7:  672b4053cf !  9:  70d5a67731 mv: check overwrite for in-to-out move
    @@ Metadata
      ## Commit message ##
         mv: check overwrite for in-to-out move
     
    -    Add checking logic for overwritng when moving from in-cone to
    +    Add checking logic for overwriting when moving from in-cone to
         out-of-cone. It is the index version of the original overwrite logic.
     
    +    Helped-by: Derrick Stolee <derrickstolee@github.com>
         Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
      ## builtin/mv.c ##
    @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
     
      ## t/t7002-mv-sparse-checkout.sh ##
     @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'move clean path from in-cone to out-of-cone' '
    - 	grep -x "S folder1/d" actual
    + 	grep "S folder1/d" actual
      '
      
     -test_expect_failure 'move clean path from in-cone to out-of-cone overwrite' '

base-commit: 4af7188bc97f70277d0f10d56d5373022b1fa385
-- 
2.37.0

