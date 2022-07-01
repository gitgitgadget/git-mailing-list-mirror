Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D7EC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbiGAKnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236244AbiGAKnG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:43:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D032676E95
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:43:04 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o19-20020a05600c4fd300b003a0489f414cso1315256wmq.4
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oq8EI+tV9mQ2J54w/9eIRSLjIR9CFgG6XuYLo85SYIY=;
        b=mSHJHk447gDjImp6WYZjpeFkxzHOskGLW3J8HH0yc4/D/rnYkOxzPr7xziyMysAhEQ
         tqviRzdCHpCjWnVcLYjRkPbx2cPbJdgjEdpQKZZSLGNAGLtvwyvzWV14Ns1+lXhOfK5O
         vtZrMcEp1MdW1qQN+QzqXNE8EUm7noQDhggSyVKyUIB0rlV2ac7E5VXdyogOIoSchTR2
         KSjaxd9Gnv8mK42eAYbdK4zzuzBbDXZLBGYdBiBA4cUFvVRpoPwkbP/bqptdWJTuEQC/
         CiHg5yuKQ9377VwTHCvOROl3x8MCFYmNQGZLsabAygq6FI4mF0hukOFDBuU41NanH82w
         sEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oq8EI+tV9mQ2J54w/9eIRSLjIR9CFgG6XuYLo85SYIY=;
        b=5AvF8SDaC/hDhDJwZyj0wucO/M45fwgpzZ7HuE/E5tHVtuwgee+Ub+TOxdFi/B2iT6
         O/WWWzHblnaA1DF39e4r0apQXEF3ihmrRe4U0Yr5Pgu2lvxeOsun24jYRAMCXd3H8Bhs
         YRAdpbwGLnAo5C6JzLIdKWI79ufVutroCcHwWIRNjeNjWjIPIixguGJ1IvB00f9/OWgR
         Mv/mdMc1lkYFXu6vHcsfcWTmELCj4p3745Q1VZYz66e6Bl6ndIRRNJVtasZuZInvC9Kl
         th0WBO6IJ0lIHh5lUU+cnZoRPElDhna6gUMmt56zT+gfXaYuMLSLMqaxJN+xntZKQHnK
         uR2w==
X-Gm-Message-State: AJIora+ZGEcrDE0fxTrMBYXWJoBXbxNvVqw17tbw7OwJsywZ6CCxkBCo
        m3cnFJb4jfqHLrNBhzAg/u1qsKLbvcWlOQ==
X-Google-Smtp-Source: AGRyM1sSTyV0hVN72P8sZei0qbMc18M6+52sxdfEharVcuSYfLVHtGWZ3g9bGweQ8JIbHIE/CLn2zQ==
X-Received: by 2002:a05:600c:4a09:b0:3a1:88f3:8ae9 with SMTP id c9-20020a05600c4a0900b003a188f38ae9mr4543750wmp.177.1656672183022;
        Fri, 01 Jul 2022 03:43:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q63-20020a1c4342000000b003973c54bd69sm6257674wma.1.2022.07.01.03.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:43:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/11] built-ins: fix common memory leaks
Date:   Fri,  1 Jul 2022 12:42:49 +0200
Message-Id: <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix common memory leaks in built-ins, for a general overview see the
v1 CL:
https://lore.kernel.org/git/cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com/

Changes since v1:

 * Amend the commit message of 2/11, we always get copy_ref() data,
   but note that we do so via an indirection in clone.c
 * Replace 8/11, maybe that solution is going overboard, we could also
   just drop it from this series...

Ævar Arnfjörð Bjarmason (11):
  check-ref-format: fix trivial memory leak
  clone: fix memory leak in wanted_peer_refs()
  submodule.c: free() memory from xgetcwd()
  revert: free "struct replay_opts" members
  cat-file: fix a memory leak in --batch-command mode
  merge-file: refactor for subsequent memory leak fix
  merge-file: fix memory leaks on error path
  checkout: avoid "struct unpack_trees_options" leak
  gc: fix a memory leak
  cat-file: fix a common "struct object_context" memory leak
  pull: fix a "struct oid_array" memory leak

 builtin/cat-file.c                   | 33 +++++++++++++++++--------
 builtin/check-ref-format.c           | 11 ++++++---
 builtin/checkout.c                   | 36 +++++++++++++++++-----------
 builtin/clone.c                      |  1 +
 builtin/gc.c                         |  8 ++++++-
 builtin/merge-file.c                 | 32 ++++++++++++++-----------
 builtin/pull.c                       | 16 ++++++++-----
 builtin/revert.c                     |  3 +++
 submodule.c                          |  3 ++-
 t/t0028-working-tree-encoding.sh     |  1 +
 t/t1051-large-conversion.sh          |  2 ++
 t/t1402-check-ref-format.sh          |  1 +
 t/t3304-notes-mixed.sh               |  1 +
 t/t4044-diff-index-unique-abbrev.sh  |  2 ++
 t/t4140-apply-ita.sh                 |  1 +
 t/t5314-pack-cycle-detection.sh      |  4 ++--
 t/t5524-pull-msg.sh                  |  1 +
 t/t6403-merge-file.sh                |  2 ++
 t/t6417-merge-ours-theirs.sh         |  1 +
 t/t6422-merge-rename-corner-cases.sh |  1 +
 t/t8007-cat-file-textconv.sh         |  2 ++
 t/t8010-cat-file-filters.sh          |  2 ++
 t/t9101-git-svn-props.sh             |  1 -
 t/t9104-git-svn-follow-parent.sh     |  1 -
 t/t9132-git-svn-broken-symlink.sh    |  1 -
 t/t9301-fast-import-notes.sh         |  1 +
 26 files changed, 114 insertions(+), 54 deletions(-)

Range-diff against v1:
 1:  f35cf7c6ee9 =  1:  f35cf7c6ee9 check-ref-format: fix trivial memory leak
 2:  8e424238071 !  2:  24a1eaa51a3 clone: fix memory leak in copy_ref() call
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    clone: fix memory leak in copy_ref() call
    +    clone: fix memory leak in wanted_peer_refs()
     
         Fix a memory leak added in 0ec4b1650cc (clone: fix ref selection in
    -    --single-branch --branch=xxx, 2012-06-22), we need to free_refs() the
    -    result of copy_ref().
    +    --single-branch --branch=xxx, 2012-06-22).
    +
    +    Whether we get our "remote_head" from copy_ref() directly, or with a
    +    call to guess_remote_head() it'll be the result of a copy_ref() in
    +    either case, as guess_remote_head() is a wrapper for copy_ref() (or it
    +    returns NULL).
     
         We can't mark any tests passing passing with SANITIZE=leak using
         "TEST_PASSES_SANITIZE_LEAK=true" as a result of this change, but
 3:  a687d1281f8 =  3:  691b178aaf0 submodule.c: free() memory from xgetcwd()
 4:  c9c2380be34 =  4:  6fc895676f4 revert: free "struct replay_opts" members
 5:  9ba267377ee =  5:  692d6e0e3d8 cat-file: fix a memory leak in --batch-command mode
 6:  17e66130b94 =  6:  d894e97b5ae merge-file: refactor for subsequent memory leak fix
 7:  8803a0df799 =  7:  8658f3ad020 merge-file: fix memory leaks on error path
 8:  94e28aa7ab3 !  8:  e21d7e4e9df checkout: add a missing clear_unpack_trees_porcelain()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    checkout: add a missing clear_unpack_trees_porcelain()
    +    checkout: avoid "struct unpack_trees_options" leak
     
         In 1c41d2805e4 (unpack_trees_options: free messages when done,
         2018-05-21) we started calling clear_unpack_trees_porcelain() on this
    -    codepath, but missed this error path, let's also clear what we've
    -    allocated in that case.
    +    codepath, but missed this error path.
    +
    +    We could call clear_unpack_trees_porcelain() just before we error()
    +    and return when unmerged_cache() fails, but the more correct fix is to
    +    not have the unmerged_cache() check happen in the middle of our
    +    "topts" setup.
    +
    +    Before 23cbf11b5c0 (merge-recursive: porcelain messages for checkout,
    +    2010-08-11) we would not malloc() to setup our "topts", which is when
    +    this started to leak on the error path.
    +
    +    Before that this code wasn't conflating the setup of "topts" and the
    +    unmerged_cache() call in any meaningful way. The initial version in
    +    782c2d65c24 (Build in checkout, 2008-02-07) just does a "memset" of
    +    it, and initializes a single struct member.
    +
    +    Then in 8ccba008ee3 (unpack-trees: allow Porcelain to give different
    +    error messages, 2008-05-17) we added the initialization of the error
    +    message, which as noted above finally started leaking in 23cbf11b5c0.
    +
    +    Let's fix the memory leak, and avoid future issues by initializing the
    +    "topts" with a helper function. There are no functional changes here.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/checkout.c ##
    +@@ builtin/checkout.c: static void setup_branch_path(struct branch_info *branch)
    + 	branch->path = strbuf_detach(&buf, NULL);
    + }
    + 
    ++static void init_topts(struct unpack_trees_options *topts, int merge,
    ++		       int show_progress, int overwrite_ignore,
    ++		       struct commit *old_commit)
    ++{
    ++	memset(topts, 0, sizeof(*topts));
    ++	topts->head_idx = -1;
    ++	topts->src_index = &the_index;
    ++	topts->dst_index = &the_index;
    ++
    ++	setup_unpack_trees_porcelain(topts, "checkout");
    ++
    ++	topts->initial_checkout = is_cache_unborn();
    ++	topts->update = 1;
    ++	topts->merge = 1;
    ++	topts->quiet = merge && old_commit;
    ++	topts->verbose_update = show_progress;
    ++	topts->fn = twoway_merge;
    ++	topts->preserve_ignored = !overwrite_ignore;
    ++}
    ++
    + static int merge_working_tree(const struct checkout_opts *opts,
    + 			      struct branch_info *old_branch_info,
    + 			      struct branch_info *new_branch_info,
     @@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
    + 		struct unpack_trees_options topts;
    + 		const struct object_id *old_commit_oid;
    + 
    +-		memset(&topts, 0, sizeof(topts));
    +-		topts.head_idx = -1;
    +-		topts.src_index = &the_index;
    +-		topts.dst_index = &the_index;
    +-
    +-		setup_unpack_trees_porcelain(&topts, "checkout");
    +-
      		refresh_cache(REFRESH_QUIET);
      
      		if (unmerged_cache()) {
    -+			clear_unpack_trees_porcelain(&topts);
    - 			error(_("you need to resolve your current index first"));
    - 			return 1;
    +@@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
      		}
    + 
    + 		/* 2-way merge to the new branch */
    +-		topts.initial_checkout = is_cache_unborn();
    +-		topts.update = 1;
    +-		topts.merge = 1;
    +-		topts.quiet = opts->merge && old_branch_info->commit;
    +-		topts.verbose_update = opts->show_progress;
    +-		topts.fn = twoway_merge;
    ++		init_topts(&topts, opts->merge, opts->show_progress,
    ++			   opts->overwrite_ignore, old_branch_info->commit);
    + 		init_checkout_metadata(&topts.meta, new_branch_info->refname,
    + 				       new_branch_info->commit ?
    + 				       &new_branch_info->commit->object.oid :
    + 				       &new_branch_info->oid, NULL);
    +-		topts.preserve_ignored = !opts->overwrite_ignore;
    + 
    + 		old_commit_oid = old_branch_info->commit ?
    + 			&old_branch_info->commit->object.oid :
 9:  b51a275b6b1 =  9:  10a97a9cac4 gc: fix a memory leak
10:  9474e2bcf93 = 10:  481d006378b cat-file: fix a common "struct object_context" memory leak
11:  022399ad652 = 11:  5666104943f pull: fix a "struct oid_array" memory leak
-- 
2.37.0.900.g4d0de1cceb2

