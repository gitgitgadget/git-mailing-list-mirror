Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A927C54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 12:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjALMzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 07:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjALMze (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 07:55:34 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844744C718
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:55:32 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso14955688wms.5
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75almMSzSgdePTQ968VlkLzwcEkKXKTMAGteNdLdwdQ=;
        b=mpPLtR9NNQA3LRHNSpq0dGEJ5ytXxjjqe9EChQxAfN8CzNa6SGVPldKRTAxYF+gIQn
         UxiBB703bOMLxQ/mR4/BsLy1FBFLYliDqpSBJKtJ0pYLaft1LXdJtNEXec6dONWzRvBQ
         jPzLLzxgCC0gAfyvLKo+D/1lBcPXIYKz4HWlbdATeRsm31Mj4n1VAcxwCKIi72/hdzAA
         wftDb0FeB87GX/NWcefRoNsrhY3k6uswIcyGyLVUXIGN4KaSc0Lv607IoRPf8idKQJnD
         TJrwYiaCdaMqXoJr5A+QCOXhI7tZOhkDUbtuHtsuQO8SMrEBnzuFkv0g7dfJGIu874li
         CpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75almMSzSgdePTQ968VlkLzwcEkKXKTMAGteNdLdwdQ=;
        b=A7X6h7E5WI2S8jyW72LRxAJCPtg/23GEwi1cKE0O4x+Gs2TMS1/uXwq10ObNi9RSU5
         AlCN1jXJjeEvIHCKz5NQ0i5oFFEswk3bnH8TOATY83S7SFYg5TOIoFYgxosNTBNfuIHo
         TrObzKxY19MgctSBEP0HBSI0tw4bFtqoh+1dpxWVDT1LSZGiPk9t0yfzCk9pHrO6KYUd
         KS0COXiuGfzeD9atQHb/3V/hyPVKeFH3LbhGgL85f7ckPGs+KgVVXbggnUwcQepqNqxP
         IYvN/xqD2OwT0Frr4T27Vx/NKxwW/giwON9jxWfBSSWMe0nRXWgW2rHBYZ62jwuaBk2Q
         N03Q==
X-Gm-Message-State: AFqh2kpJkHWAprWkMWf5Rw91+Ode0Br8yS7uWXNpjgR6qOEdYDuTfdql
        GJRO/IdhqSI2D3027ADuL9c3uYfZdN81DQ==
X-Google-Smtp-Source: AMrXdXuDOCbUpeRiheK5FG5qvWINfQOZxkS4WtSRgKYqviMQGJAmeNbgXK3pv+2nUY0XGiDa8/NxHw==
X-Received: by 2002:a1c:ed19:0:b0:3d3:52bb:3984 with SMTP id l25-20020a1ced19000000b003d352bb3984mr56214519wmh.17.1673528130551;
        Thu, 12 Jan 2023 04:55:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c154c00b003d9fba3c7a4sm8462473wmg.16.2023.01.12.04.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:55:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/6] cache API: always have a "istate->repo"
Date:   Thu, 12 Jan 2023 13:55:22 +0100
Message-Id: <cover-v2-0.6-00000000000-20230112T124842Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1205.g2ca064edc27
In-Reply-To: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "struct index_state" contains a "repo" member, which should be a
pointer to the repository for that index, but which due to us
constructing such structs on an ad-hoc basis in various places wasn't
always available.

We'd thus end up with code like this, in the recent
ds/omit-trailing-hash-in-index topic:

			       struct repository *r = istate->repo ? istate->repo : the_repository;

Really we should be able to trust the "istate->repo", but were
carrying those sorts of conditionals because our index might come from
a manually constructed source, so we'd have to fall back to
"the_repository".

This series changes the relvant code so the "repo" field is always
non-NULL, as 6/6 here shows we had various workarounds in place for
that, which can now go away.

For v1 and more general summary, see:
https://lore.kernel.org/git/cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com/

See
https://github.com/avar/git/tree/avar/do-not-lazy-populate-istate-repo-2
for passing CI and a fetchable branch for this topic.

Change since v1:

 * Typo/rewording/correcting of commit messages
 * Kept a "TODO" comment which Derrick notes I shouldn't have removed

 * Derrick suggested in
   https://lore.kernel.org/git/6b92fad2-6b74-fddb-679c-8c8735e7103d@github.com/
   that things might be nicer if we had an explicit initializer, which
   was also the subject of the previous discussion at
   https://lore.kernel.org/git/xmqqmt6vqo2w.fsf@gitster.g/; but
   concluded that it was probably best to leave it for now.

   I tried it out, and I think it's worth just doing that now, which
   is why there's a new 5/6 here: We start by adding an
   INDEX_STATE_INIT macro, and corresponding function.

   There's a bit of churn in 6/6 as all of those now will take a
   "repo" argument, but I think the end result is worth it, because
   even if "repo" remains the only thing that we need to initialize
   we're now able to use ALLOC_ARRAY() instead of CALLOC_ARRAY().

   We'll thus be helped by analysis tools (which would show access to
   un-init'd memory) if we miss properly init-ing not just the "repo"
   field, but anything in the structure, so our test coverage will be
   better.

   It also makes the code easier to follow and change, as it's now
   more obvious where we initialize this, and it'll be easier to
   change it in the future if e.g. we add a new member that has
   mandatory initialization (e.g. a "struct strbuf").

Ævar Arnfjörð Bjarmason (6):
  builtin/difftool.c: { 0 }-initialize rather than using memset()
  sparse-index.c: expand_to_path() can assume non-NULL "istate"
  sparse-index API: BUG() out on NULL ensure_full_index()
  read-cache.c: refactor set_new_index_sparsity() for subsequent commit
  cache API: add a "INDEX_STATE_INIT" macro/function, add
    release_index()
  treewide: always have a valid "index_state.repo" member

 apply.c                   |  2 +-
 builtin/difftool.c        |  4 +---
 builtin/sparse-checkout.c |  1 +
 builtin/stash.c           | 16 ++++++-------
 builtin/worktree.c        |  2 +-
 cache.h                   | 16 +++++++++++++
 fsmonitor-settings.c      | 14 ------------
 fsmonitor.c               |  2 +-
 merge-recursive.c         |  2 +-
 read-cache.c              | 48 +++++++++++++++++++--------------------
 repository.c              |  8 +++++--
 revision.c                |  2 +-
 sparse-index.c            | 15 ++++--------
 split-index.c             |  3 ++-
 unpack-trees.c            |  5 ++--
 15 files changed, 69 insertions(+), 71 deletions(-)

Range-diff against v1:
1:  214fe7d3fc2 = 1:  214fe7d3fc2 builtin/difftool.c: { 0 }-initialize rather than using memset()
2:  6db74fe958f = 2:  6db74fe958f sparse-index.c: expand_to_path() can assume non-NULL "istate"
3:  d96388acef6 ! 3:  25e9cff0e97 sparse-index API: fix TODO, BUG() out on NULL ensure_full_index()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    sparse-index API: fix TODO, BUG() out on NULL ensure_full_index()
    +    sparse-index API: BUG() out on NULL ensure_full_index()
     
         Make the ensure_full_index() function stricter, and have it only
         accept a non-NULL "struct index_state". This function (and this
         behavior) was added in [1].
     
         The only reason it needed to be this lax was due to interaction with
    -    repo_index_has_changes(). See the addition of that code in . This
    -    fixes one of the TODO comments added in 0c18c059a15, the other one was
    -    already removed in [3].
    +    repo_index_has_changes(). See the addition of that code in [2].
     
         The other reason for why this was needed dates back to interaction
    -    with code added in [4]. In [5] we started calling ensure_full_index()
    +    with code added in [3]. In [4] we started calling ensure_full_index()
         in unpack_trees(), but the caller added in 34110cd4e39 wants to pass
         us a NULL "dst_index". Let's instead do the NULL check in
         unpack_trees() itself.
     
         1. 4300f8442a2 (sparse-index: implement ensure_full_index(), 2021-03-30)
         2. 0c18c059a15 (read-cache: ensure full index, 2021-04-01)
    -    3. d76723ee531 (status: use sparse-index throughout, 2021-07-14).
    -    4. 34110cd4e39 (Make 'unpack_trees()' have a separate source and
    +    3. 34110cd4e39 (Make 'unpack_trees()' have a separate source and
            destination index, 2008-03-06)
    -    5. 6863df35503 (unpack-trees: ensure full index, 2021-03-30)
    +    4. 6863df35503 (unpack-trees: ensure full index, 2021-03-30)
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## read-cache.c ##
    -@@ read-cache.c: int repo_index_has_changes(struct repository *repo,
    - 		}
    - 		diff_flush(&opt);
    - 		return opt.flags.has_changes != 0;
    --	} else {
    --		/* TODO: audit for interaction with sparse-index. */
    -+	} else if (istate) {
    - 		ensure_full_index(istate);
    - 		for (i = 0; sb && i < istate->cache_nr; i++) {
    - 			if (i)
    -@@ read-cache.c: int repo_index_has_changes(struct repository *repo,
    - 			strbuf_addstr(sb, istate->cache[i]->name);
    - 		}
    - 		return !!istate->cache_nr;
    -+	} else {
    -+		return 0;
    - 	}
    - }
    - 
    -
      ## sparse-index.c ##
     @@ sparse-index.c: void expand_index(struct index_state *istate, struct pattern_list *pl)
      	 * If the index is already full, then keep it full. We will convert
4:  e514a881e38 = 4:  a75977bd37b read-cache.c: refactor set_new_index_sparsity() for subsequent commit
-:  ----------- > 5:  ae256efe94a cache API: add a "INDEX_STATE_INIT" macro/function, add release_index()
5:  b3b0e592101 ! 6:  291233b0420 treewide: always have a valid "index_state.repo" member
    @@ Commit message
         second-guessing is the "istate->repo ? istate->repo : the_repository"
         code in [2]. We can now simply use "istate->repo".
     
    +    We're doing this by making use of the INDEX_STATE_INIT() macro (and
    +    corresponding function) added in the preceding commit, which now have
    +    mandatory "repo" arguments. As seen here there are cases where we set
    +    it to NULL, but only if we're about to fill in the correct non-NULL
    +    "repo" right afterwards.
    +
         For "fsmonitor-settings.c" we can remove the initialization of a NULL
         "r" argument to "the_repository". This was added back in [3], and was
         needed at the time for callers that would pass us the "r" from an
    @@ apply.c: static int preimage_oid_in_gitlink_patch(struct patch *p, struct object
      static int build_fake_ancestor(struct apply_state *state, struct patch *list)
      {
      	struct patch *patch;
    --	struct index_state result = { NULL };
    -+	struct index_state result = { .repo = state->repo };
    +-	struct index_state result = INDEX_STATE_INIT;
    ++	struct index_state result = INDEX_STATE_INIT(state->repo);
      	struct lock_file lock = LOCK_INIT;
      	int res;
      
    @@ builtin/difftool.c: static int run_dir_diff(const char *extcmd, int symlinks, co
      	struct hashmap symlinks2 = HASHMAP_INIT(pair_cmp, NULL);
      	struct hashmap_iter iter;
      	struct pair_entry *entry;
    --	struct index_state wtindex = { 0 };
    -+	struct index_state wtindex = { .repo = the_repository };
    +-	struct index_state wtindex = INDEX_STATE_INIT;
    ++	struct index_state wtindex = INDEX_STATE_INIT(the_repository);
      	struct checkout lstate, rstate;
      	int err = 0;
      	struct child_process cmd = CHILD_PROCESS_INIT;
    @@ builtin/sparse-checkout.c: static int update_working_directory(struct pattern_li
      	o.head_idx = -1;
      	o.src_index = r->index;
      	o.dst_index = r->index;
    -+	o.result.repo = r;
    +-	index_state_init(&o.result);
    ++	index_state_init(&o.result, r);
      	o.skip_sparse_checkout = 0;
      	o.pl = pl;
      
    @@ builtin/stash.c: static int save_untracked_files(struct stash_info *info, struct
      	int ret = 0;
      	struct strbuf untracked_msg = STRBUF_INIT;
      	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
    --	struct index_state istate = { NULL };
    -+	struct index_state istate = { .repo = the_repository };
    +-	struct index_state istate = INDEX_STATE_INIT;
    ++	struct index_state istate = INDEX_STATE_INIT(the_repository);
      
      	cp_upd_index.git_cmd = 1;
      	strvec_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
    @@ builtin/stash.c: static int stash_staged(struct stash_info *info, struct strbuf
      {
      	int ret = 0;
      	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
    --	struct index_state istate = { NULL };
    -+	struct index_state istate = { .repo = the_repository };
    +-	struct index_state istate = INDEX_STATE_INIT;
    ++	struct index_state istate = INDEX_STATE_INIT(the_repository);
      
      	if (write_index_as_tree(&info->w_tree, &istate, the_repository->index_file,
      				0, NULL)) {
    @@ builtin/stash.c: static int stash_patch(struct stash_info *info, const struct pa
      	int ret = 0;
      	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
      	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
    --	struct index_state istate = { NULL };
    -+	struct index_state istate = { .repo = the_repository };
    +-	struct index_state istate = INDEX_STATE_INIT;
    ++	struct index_state istate = INDEX_STATE_INIT(the_repository);
      	char *old_index_env = NULL, *old_repo_index_file;
      
      	remove_path(stash_index_path.buf);
    @@ builtin/stash.c: static int stash_working_tree(struct stash_info *info, const st
      	struct rev_info rev;
      	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
      	struct strbuf diff_output = STRBUF_INIT;
    --	struct index_state istate = { NULL };
    -+	struct index_state istate = { .repo = the_repository };
    +-	struct index_state istate = INDEX_STATE_INIT;
    ++	struct index_state istate = INDEX_STATE_INIT(the_repository);
      
      	init_revisions(&rev, NULL);
      	copy_pathspec(&rev.prune_data, ps);
    @@ builtin/worktree.c: static int unlock_worktree(int ac, const char **av, const ch
      
      static void validate_no_submodules(const struct worktree *wt)
      {
    --	struct index_state istate = { NULL };
    -+	struct index_state istate = { .repo = the_repository };
    +-	struct index_state istate = INDEX_STATE_INIT;
    ++	struct index_state istate = INDEX_STATE_INIT(the_repository);
      	struct strbuf path = STRBUF_INIT;
      	int i, found_submodules = 0;
      
     
    + ## cache.h ##
    +@@ cache.h: struct index_state {
    +  * If the variable won't be used again, use release_index() to free()
    +  * its resources. If it needs to be used again use discard_index(),
    +  * which does the same thing, but will use use index_state_init() at
    +- * the end.
    ++ * the end. The discard_index() will use its own "istate->repo" as the
    ++ * "r" argument to index_state_init() in that case.
    +  */
    +-#define INDEX_STATE_INIT { 0 }
    +-void index_state_init(struct index_state *istate);
    ++#define INDEX_STATE_INIT(r) { \
    ++	.repo = (r), \
    ++}
    ++void index_state_init(struct index_state *istate, struct repository *r);
    + void release_index(struct index_state *istate);
    + 
    + /* Name hashing */
    +
      ## fsmonitor-settings.c ##
     @@ fsmonitor-settings.c: static void lookup_fsmonitor_settings(struct repository *r)
      
    @@ merge-recursive.c: static int unpack_trees_start(struct merge_options *opt,
      {
      	int rc;
      	struct tree_desc t[3];
    --	struct index_state tmp_index = { NULL };
    -+	struct index_state tmp_index = { .repo = opt->repo };
    +-	struct index_state tmp_index = INDEX_STATE_INIT;
    ++	struct index_state tmp_index = INDEX_STATE_INIT(opt->repo);
      
      	memset(&opt->priv->unpack_opts, 0, sizeof(opt->priv->unpack_opts));
      	if (opt->priv->call_depth)
    @@ read-cache.c: int do_read_index(struct index_state *istate, const char *path, in
      	 * If the command explicitly requires a full index, force it
      	 * to be full. Otherwise, correct the sparsity based on repository
     @@ read-cache.c: int read_index_from(struct index_state *istate, const char *path,
    - 		discard_index(split_index->base);
    + 		release_index(split_index->base);
      	else
    - 		CALLOC_ARRAY(split_index->base, 1);
    -+	split_index->base->repo = istate->repo;
    + 		ALLOC_ARRAY(split_index->base, 1);
    +-	index_state_init(split_index->base);
    ++	index_state_init(split_index->base, istate->repo);
      
      	base_oid_hex = oid_to_hex(&split_index->base_oid);
      	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_oid_hex);
    +@@ read-cache.c: int is_index_unborn(struct index_state *istate)
    + 	return (!istate->cache_nr && !istate->timestamp.sec);
    + }
    + 
    +-void index_state_init(struct index_state *istate)
    ++void index_state_init(struct index_state *istate, struct repository *r)
    + {
    +-	struct index_state blank = INDEX_STATE_INIT;
    ++	struct index_state blank = INDEX_STATE_INIT(r);
    + 	memcpy(istate, &blank, sizeof(*istate));
    + }
    + 
    +@@ read-cache.c: void release_index(struct index_state *istate)
    + void discard_index(struct index_state *istate)
    + {
    + 	release_index(istate);
    +-	index_state_init(istate);
    ++	index_state_init(istate, istate->repo);
    + }
    + 
    + /*
     @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
      	int ieot_entries = 1;
      	struct index_entry_offset_table *ieot = NULL;
    @@ repository.c: void initialize_the_repository(void)
      	the_repo.remote_state = remote_state_new();
      	the_repo.parsed_objects = parsed_object_pool_new();
      
    -+	the_index.repo = the_repository;
    ++	index_state_init(&the_index, the_repository);
     +
      	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
      }
      
    +@@ repository.c: int repo_read_index(struct repository *repo)
    + 
    + 	if (!repo->index) {
    + 		ALLOC_ARRAY(repo->index, 1);
    +-		index_state_init(repo->index);
    ++		index_state_init(repo->index, NULL /* set below */);
    + 	}
    + 
    + 	/* Complete the double-reference */
     
      ## revision.c ##
     @@ revision.c: void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
      	worktrees = get_worktrees();
      	for (p = worktrees; *p; p++) {
      		struct worktree *wt = *p;
    --		struct index_state istate = { NULL };
    -+		struct index_state istate = { .repo = revs->repo };
    +-		struct index_state istate = INDEX_STATE_INIT;
    ++		struct index_state istate = INDEX_STATE_INIT(revs->repo);
      
      		if (wt->is_current)
      			continue; /* current index already taken care of */
    @@ split-index.c
     @@ split-index.c: void move_cache_to_base_index(struct index_state *istate)
      	}
      
    - 	CALLOC_ARRAY(si->base, 1);
    -+	si->base->repo = istate->repo;
    + 	ALLOC_ARRAY(si->base, 1);
    +-	index_state_init(si->base);
    ++	index_state_init(si->base, istate->repo);
      	si->base->version = istate->version;
      	/* zero timestamp disables racy test in ce_write_index() */
      	si->base->timestamp = istate->timestamp;
     
      ## unpack-trees.c ##
     @@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
    + 		populate_from_existing_patterns(o, &pl);
      	}
      
    - 	memset(&o->result, 0, sizeof(o->result));
    -+	o->result.repo = o->src_index->repo;
    +-	index_state_init(&o->result);
    ++	index_state_init(&o->result, o->src_index->repo);
      	o->result.initialized = 1;
      	o->result.timestamp.sec = o->src_index->timestamp.sec;
      	o->result.timestamp.nsec = o->src_index->timestamp.nsec;
-- 
2.39.0.1205.g2ca064edc27

