Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CCB11F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfHQSmB (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45203 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfHQSmB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id w26so4787891pfq.12
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YSPwMu9beZtZ1D2/+e4klMkfbEkDBGj5uwmx76FHp7E=;
        b=f1FcJn2mKRV9BfzS/1KSUtTmyPgkdIj8hg/q4bRpaXrbgnG6skcMNFr/JY1JD9so9O
         YQLMoj3onSIh1e0IHKhcQZbD+7XhZmqGjDvRVSJ90PCFcu19bCs3Qc8fGbbVJScoJePp
         Qlc0Anfwqutu7WS8ci+ycfRVpJwiTq/DY9Hjrshxo1andEW3JS2pEPg8ULAJkIcxsqij
         6wSDnVXAZq0TC0GkHq9r0hCGGhdLeiFj7O9nFVQVdbZQMvyA7ffnkFO6FXkWhpB5nDMn
         qOogwNFHdCtMNErQaplflrEPedPxscoMr5hDreBt7DzyRlCNqGKrDlEGrbZjGpkiCV5e
         /prA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YSPwMu9beZtZ1D2/+e4klMkfbEkDBGj5uwmx76FHp7E=;
        b=KUrMKZr5Fr5x9+Vm6P028cUwRMcvUAl/WVDmyK2GIvPOWSfPxEAG2O19W30MKWZunx
         jqXOh4G3Qb8qMIfixdFUdCfDW5bbejwyJn+CrznaiRW0zTKSR0gcAnlifnjAMORrplq1
         KGpGF+LMCx1Apqbd7hV0bPBkwI3CMPxi8ppqrYJo7iquXO91nqRVBRwNM5VWPakUBzJe
         PP4/5pGSsfW5Tfro4Aw8Pwq7HyCuZT8/PR1AcS1s66vevP7UxqCFNCfbW3SU6j4sA64m
         zG+H3BrIScxmwiI0jw9+aOpVzJtdRvcC4t1voVNJXcxl9zM/jGe3aXlOwB/8tIdZLce+
         0+7Q==
X-Gm-Message-State: APjAAAW4kOehCBqtH+yJLIPOE3Sz7rZmwDedNsipLcKqtSLekv1LRtMv
        fVmMsiG3mT7QZ0ppza3kUqBcW5VL
X-Google-Smtp-Source: APXvYqywuT/steiyjPEMRlw4Bd2F6l3KEfu2Gfk8RSURuDtuwl95ug97FlKuxl7GuW1H1k8AfiMROA==
X-Received: by 2002:aa7:9ab6:: with SMTP id x22mr16970751pfi.80.1566067319521;
        Sat, 17 Aug 2019 11:41:59 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:41:58 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 00/24] Clean up merge API
Date:   Sat, 17 Aug 2019 11:41:20 -0700
Message-Id: <20190817184144.32179-1-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.28.g5f89f15d7b.dirty
In-Reply-To: <20190815214053.16594-1-newren@gmail.com>
References: <20190815214053.16594-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before writing a replacement merge strategy for recursive, I decided to
first cleanup the merge API -- streamlining merge-recursive.h and making
it more readable.  This includes some minor fixes found along the way.

Changes since v3 (full range-diff below):
  * Addressed feedback from Junio and SZEDER:
    * [Patch 4] Avoided looping over commit_list in determining
                ancestor_name
    * [Patch 12] s/inmemory/in_core/ in new cache-tree function name
    * [Patch 18] restored the '>= 0' comparision
    * [Patch 21] Use FREE_AND_NULL
    * [Patch 23] Use range checks for show_rename_progress (don't use
                 a bitfield), and don't compare an unsigned using >= 0.

Notes:
  * Patches 7, 9, 13, 14, and 15 only changed in the range-diff due to
    context changes from other patches

Derrick Stolee (1):
  merge-recursive: introduce an enum for detect_directory_renames values

Elijah Newren (23):
  merge-recursive: be consistent with assert
  checkout: provide better conflict hunk description with detached HEAD
  merge-recursive: enforce opt->ancestor != NULL when calling
    merge_trees()
  merge-recursive: provide a better label for diff3 common ancestor
  merge-recursive: future-proof update_file_flags() against memory leaks
  merge-recursive: remove another implicit dependency on the_repository
  Ensure index matches head before invoking merge machinery, round N
  merge-recursive: exit early if index != head
  merge-recursive: remove useless parameter in merge_trees()
  merge-recursive: don't force external callers to do our logging
  cache-tree: share code between functions writing an index as a tree
  merge-recursive: fix some overly long lines
  merge-recursive: use common name for ancestors/common/base_list
  merge-recursive: rename 'mrtree' to 'result_tree', for clarity
  merge-recursive: rename merge_options argument to opt in header
  merge-recursive: move some definitions around to clean up the header
  merge-recursive: consolidate unnecessary fields in merge_options
  merge-recursive: comment and reorder the merge_options fields
  merge-recursive: avoid losing output and leaking memory holding that
    output
  merge-recursive: split internal fields into a separate struct
  merge-recursive: rename MERGE_RECURSIVE_* to MERGE_VARIANT_*
  merge-recursive: add sanity checks for relevant merge_options
  merge-recursive: alphabetize include list

 builtin/am.c                      |   2 +-
 builtin/checkout.c                |  14 +-
 builtin/merge-recursive.c         |   4 +
 builtin/stash.c                   |   2 +
 cache-tree.c                      |  85 +++--
 cache-tree.h                      |   3 +-
 merge-recursive.c                 | 566 ++++++++++++++++++------------
 merge-recursive.h                 | 164 +++++----
 sequencer.c                       |   5 +-
 t/t3030-merge-recursive.sh        |   9 +-
 t/t6036-recursive-corner-cases.sh |   8 +-
 t/t6047-diff3-conflict-markers.sh | 189 ++++++++++
 12 files changed, 717 insertions(+), 334 deletions(-)
 create mode 100755 t/t6047-diff3-conflict-markers.sh

Range-diff:
 1:  21f1e04dc9 =  1:  7f99c2401e merge-recursive: be consistent with assert
 2:  ac24702773 =  2:  b305348f45 checkout: provide better conflict hunk description with detached HEAD
 3:  fd14ed9490 =  3:  5b9e32a356 merge-recursive: enforce opt->ancestor != NULL when calling merge_trees()
 4:  540a1d17d7 !  4:  566a55cf76 merge-recursive: provide a better label for diff3 common ancestor
    @@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
      	struct commit *merged_common_ancestors;
      	struct tree *mrtree;
      	int clean;
    -+	int num_merge_bases;
    ++	const char *ancestor_name;
     +	struct strbuf merge_base_abbrev = STRBUF_INIT;
     +
     +	if (!opt->call_depth)
    @@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
      	if (show(opt, 4)) {
      		output(opt, 4, _("Merging:"));
     @@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
    - 			output_commit_title(opt, iter->item);
    + 
    + 		tree = lookup_tree(opt->repo, opt->repo->hash_algo->empty_tree);
    + 		merged_common_ancestors = make_virtual_commit(opt->repo, tree, "ancestor");
    ++		ancestor_name = "empty tree";
    ++	} else if (ca) {
    ++		ancestor_name = "merged common ancestors";
    ++	} else {
    ++		strbuf_add_unique_abbrev(&merge_base_abbrev,
    ++					 &merged_common_ancestors->object.oid,
    ++					 DEFAULT_ABBREV);
    ++		ancestor_name = merge_base_abbrev.buf;
      	}
      
    -+	num_merge_bases = commit_list_count(ca);
    - 	merged_common_ancestors = pop_commit(&ca);
    - 	if (merged_common_ancestors == NULL) {
    - 		/* if there is no common ancestor, use an empty tree */
    + 	for (iter = ca; iter; iter = iter->next) {
     @@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
      	if (!opt->call_depth)
      		repo_read_index(opt->repo);
      
     -	opt->ancestor = "merged common ancestors";
    -+	switch (num_merge_bases) {
    -+	case 0:
    -+		opt->ancestor = "<empty tree>";
    -+		break;
    -+	case 1:
    -+		strbuf_add_unique_abbrev(&merge_base_abbrev,
    -+					 &merged_common_ancestors->object.oid,
    -+					 DEFAULT_ABBREV);
    -+		opt->ancestor = merge_base_abbrev.buf;
    -+		break;
    -+	default:
    -+		opt->ancestor = "merged common ancestors";
    -+	}
    ++	opt->ancestor = ancestor_name;
      	clean = merge_trees(opt, get_commit_tree(h1), get_commit_tree(h2),
      			    get_commit_tree(merged_common_ancestors),
      			    &mrtree);
    @@ t/t6047-diff3-conflict-markers.sh (new)
     +
     +		test_must_fail git -c merge.conflictstyle=diff3 merge --allow-unrelated-histories -s recursive R^0 &&
     +
    -+		grep "|||||| <empty tree>" content
    ++		grep "|||||| empty tree" content
     +	)
     +'
     +
 5:  19ff6a9503 =  5:  9c0bab2a0b merge-recursive: introduce an enum for detect_directory_renames values
 6:  5e44146da1 =  6:  2cd1a60a16 merge-recursive: future-proof update_file_flags() against memory leaks
 7:  df210eb029 !  7:  27a339781f merge-recursive: remove another implicit dependency on the_repository
    @@ Commit message
     
      ## merge-recursive.c ##
     @@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
    - 	default:
    - 		opt->ancestor = "merged common ancestors";
    - 	}
    + 		repo_read_index(opt->repo);
    + 
    + 	opt->ancestor = ancestor_name;
     -	clean = merge_trees(opt, get_commit_tree(h1), get_commit_tree(h2),
     -			    get_commit_tree(merged_common_ancestors),
     +	clean = merge_trees(opt,
 8:  74dd7b8f59 =  8:  133c470371 Ensure index matches head before invoking merge machinery, round N
 9:  f04eba4184 !  9:  f43a229ae6 merge-recursive: exit early if index != head
    @@ merge-recursive.c: static struct commit_list *reverse_commit_list(struct commit_
      	struct commit_list *iter;
      	struct commit *merged_common_ancestors;
     @@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
    - 	int num_merge_bases;
    + 	const char *ancestor_name;
      	struct strbuf merge_base_abbrev = STRBUF_INIT;
      
     -	if (!opt->call_depth)
    @@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
      			return -1;
      		opt->branch1 = saved_b1;
     @@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
    - 	default:
    - 		opt->ancestor = "merged common ancestors";
    - 	}
    + 		repo_read_index(opt->repo);
    + 
    + 	opt->ancestor = ancestor_name;
     -	clean = merge_trees(opt,
     -			    repo_get_commit_tree(opt->repo, h1),
     -			    repo_get_commit_tree(opt->repo, h2),
10:  8688d40739 = 10:  678dfbf507 merge-recursive: remove useless parameter in merge_trees()
11:  a92d460707 = 11:  7b28da5637 merge-recursive: don't force external callers to do our logging
12:  dec0ea7409 ! 12:  c1ae5cc1c4 cache-tree: share code between functions writing an index as a tree
    @@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *op
      			init_merge_options(&o, the_repository);
      			o.verbosity = 0;
     -			work = write_tree_from_memory(&o);
    -+			work = write_inmemory_index_as_tree(the_repository);
    ++			work = write_in_core_index_as_tree(the_repository);
      
      			ret = reset_tree(new_tree,
      					 opts, 1,
    @@ cache-tree.c: static struct cache_tree *cache_tree_find(struct cache_tree *it, c
      	return it;
      }
      
    -+int write_index_as_tree_internal(struct object_id *oid, struct index_state *index_state, int cache_tree_valid, int flags, const char *prefix)
    ++static int write_index_as_tree_internal(struct object_id *oid,
    ++					struct index_state *index_state,
    ++					int cache_tree_valid,
    ++					int flags,
    ++					const char *prefix)
     +{
     +	if (flags & WRITE_TREE_IGNORE_CACHE_TREE) {
     +		cache_tree_free(&index_state->cache_tree);
    @@ cache-tree.c: static struct cache_tree *cache_tree_find(struct cache_tree *it, c
     +	return 0;
     +}
     +
    -+struct tree* write_inmemory_index_as_tree(struct repository *repo) {
    ++struct tree* write_in_core_index_as_tree(struct repository *repo) {
     +	struct object_id o;
     +	int was_valid, ret;
     +
    @@ cache-tree.h: void cache_tree_verify(struct repository *, struct index_state *);
      #define WRITE_TREE_UNMERGED_INDEX (-2)
      #define WRITE_TREE_PREFIX_ERROR (-3)
      
    -+struct tree* write_inmemory_index_as_tree(struct repository *repo);
    ++struct tree* write_in_core_index_as_tree(struct repository *repo);
      int write_index_as_tree(struct object_id *oid, struct index_state *index_state, const char *index_path, int flags, const char *prefix);
      void prime_cache_tree(struct repository *, struct index_state *, struct tree *);
      
    @@ merge-recursive.c: static int merge_trees_internal(struct merge_options *opt,
      
     -	if (opt->call_depth && !(*result = write_tree_from_memory(opt)))
     +	if (opt->call_depth &&
    -+	    !(*result = write_inmemory_index_as_tree(opt->repo)))
    ++	    !(*result = write_in_core_index_as_tree(opt->repo)))
      		return -1;
      
      	return clean;
13:  b51f3d1924 ! 13:  2e9fb223d9 merge-recursive: fix some overly long lines
    @@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt
     -		merged_common_ancestors = make_virtual_commit(opt->repo, tree, "ancestor");
     +		merged_common_ancestors = make_virtual_commit(opt->repo,
     +							      tree, "ancestor");
    - 	}
    - 
    - 	for (iter = ca; iter; iter = iter->next) {
    + 		ancestor_name = "empty tree";
    + 	} else if (ca) {
    + 		ancestor_name = "merged common ancestors";
     @@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
      	return clean;
      }
14:  a069cc4cca ! 14:  230d903012 merge-recursive: use common name for ancestors/common/base_list
    @@ merge-recursive.c: static struct commit_list *reverse_commit_list(struct commit_
     +	struct commit *merged_merge_bases;
      	struct tree *mrtree;
      	int clean;
    - 	int num_merge_bases;
    + 	const char *ancestor_name;
     @@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt,
      		output_commit_title(opt, h2);
      	}
    @@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt
      			output_commit_title(opt, iter->item);
      	}
      
    --	num_merge_bases = commit_list_count(ca);
     -	merged_common_ancestors = pop_commit(&ca);
     -	if (merged_common_ancestors == NULL) {
    -+	num_merge_bases = commit_list_count(merge_bases);
     +	merged_merge_bases = pop_commit(&merge_bases);
     +	if (merged_merge_bases == NULL) {
      		/* if there is no common ancestor, use an empty tree */
    @@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt
     -							      tree, "ancestor");
     +		merged_merge_bases = make_virtual_commit(opt->repo, tree,
     +							 "ancestor");
    + 		ancestor_name = "empty tree";
    +-	} else if (ca) {
    ++	} else if (merge_bases) {
    + 		ancestor_name = "merged common ancestors";
    + 	} else {
    + 		strbuf_add_unique_abbrev(&merge_base_abbrev,
    +-					 &merged_common_ancestors->object.oid,
    ++					 &merged_merge_bases->object.oid,
    + 					 DEFAULT_ABBREV);
    + 		ancestor_name = merge_base_abbrev.buf;
      	}
      
     -	for (iter = ca; iter; iter = iter->next) {
    @@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt
      			return err(opt, _("merge returned no commit"));
      	}
      
    -@@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt,
    - 		break;
    - 	case 1:
    - 		strbuf_add_unique_abbrev(&merge_base_abbrev,
    --					 &merged_common_ancestors->object.oid,
    -+					 &merged_merge_bases->object.oid,
    - 					 DEFAULT_ABBREV);
    - 		opt->ancestor = merge_base_abbrev.buf;
    - 		break;
     @@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt,
      				     repo_get_commit_tree(opt->repo, h1),
      				     repo_get_commit_tree(opt->repo, h2),
15:  93a3ce6b88 ! 15:  28c20a2d08 merge-recursive: rename 'mrtree' to 'result_tree', for clarity
    @@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt
     -	struct tree *mrtree;
     +	struct tree *result_tree;
      	int clean;
    - 	int num_merge_bases;
    + 	const char *ancestor_name;
      	struct strbuf merge_base_abbrev = STRBUF_INIT;
     @@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt,
      				     repo_get_commit_tree(opt->repo, h2),
16:  1b1df10c11 = 16:  50e2e51cf6 merge-recursive: rename merge_options argument to opt in header
17:  1526977a85 = 17:  b8cd111bd2 merge-recursive: move some definitions around to clean up the header
18:  c90f2f15cd ! 18:  9bb8a7f162 merge-recursive: consolidate unnecessary fields in merge_options
    @@ merge-recursive.c: static int add_cacheinfo(struct merge_options *opt,
      {
     -	return opt->merge_detect_rename >= 0 ? opt->merge_detect_rename :
     -		opt->diff_detect_rename >= 0 ? opt->diff_detect_rename : 1;
    -+	return (opt->detect_renames != -1) ? opt->detect_renames : 1;
    ++	return (opt->detect_renames >= 0) ? opt->detect_renames : 1;
      }
      
      static void init_tree_desc_from_tree(struct tree_desc *desc, struct tree *tree)
    @@ merge-recursive.c: static struct diff_queue_struct *get_diffpairs(struct merge_o
     -	opts.rename_limit = opt->merge_rename_limit >= 0 ? opt->merge_rename_limit :
     -			    opt->diff_rename_limit >= 0 ? opt->diff_rename_limit :
     -			    1000;
    -+	opts.rename_limit = (opt->rename_limit != -1) ? opt->rename_limit : 1000;
    ++	opts.rename_limit = (opt->rename_limit >= 0) ? opt->rename_limit : 1000;
      	opts.rename_score = opt->rename_score;
      	opts.show_rename_progress = opt->show_rename_progress;
      	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
19:  6d930dba72 = 19:  2140490796 merge-recursive: comment and reorder the merge_options fields
20:  ec3e15f6a8 = 20:  02478e2088 merge-recursive: avoid losing output and leaking memory holding that output
21:  7edfac7048 ! 21:  2781ca78d7 merge-recursive: split internal fields into a separate struct
    @@ merge-recursive.c: static int merge_trees_internal(struct merge_options *opt,
      
     -	if (opt->call_depth &&
     +	if (opt->priv->call_depth &&
    - 	    !(*result = write_inmemory_index_as_tree(opt->repo)))
    + 	    !(*result = write_in_core_index_as_tree(opt->repo)))
      		return -1;
      
     @@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt,
    @@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt
     +	if (!opt->priv->call_depth)
      		repo_read_index(opt->repo);
      
    - 	switch (num_merge_bases) {
    + 	opt->ancestor = ancestor_name;
     @@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt,
      		return clean;
      	}
    @@ merge-recursive.c: static int merge_start(struct merge_options *opt, struct tree
      		diff_warn_rename_limit("merge.renamelimit",
     -				       opt->needed_rename_limit, 0);
     +				       opt->priv->needed_rename_limit, 0);
    -+	free(opt->priv);
    -+	opt->priv = NULL;
    ++	FREE_AND_NULL(opt->priv);
      }
      
      int merge_trees(struct merge_options *opt,
22:  9a381873c2 = 22:  5a52aa786e merge-recursive: rename MERGE_RECURSIVE_* to MERGE_VARIANT_*
23:  c6bc8a196f ! 23:  b7e6c2436a merge-recursive: add sanity checks for relevant merge_options
    @@ merge-recursive.c: static int merge_start(struct merge_options *opt, struct tree
     +	       opt->detect_directory_renames <= MERGE_DIRECTORY_RENAMES_TRUE);
     +	assert(opt->rename_limit >= -1);
     +	assert(opt->rename_score >= 0 && opt->rename_score <= MAX_SCORE);
    ++	assert(opt->show_rename_progress >= 0 && opt->show_rename_progress <= 1);
     +
     +	assert(opt->xdl_opts >= 0);
     +	assert(opt->recursive_variant >= MERGE_VARIANT_NORMAL &&
     +	       opt->recursive_variant <= MERGE_VARIANT_THEIRS);
     +
     +	assert(opt->verbosity >= 0 && opt->verbosity <= 5);
    -+	assert(opt->buffer_output >= 0 && opt->buffer_output <= 2);
    ++	assert(opt->buffer_output <= 2);
     +	assert(opt->obuf.len == 0);
     +
     +	assert(opt->priv == NULL);
    @@ merge-recursive.c: static int merge_start(struct merge_options *opt, struct tree
      	if (repo_index_has_changes(opt->repo, head, &sb)) {
      		err(opt, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
      		    sb.buf);
    -
    - ## merge-recursive.h ##
    -@@ merge-recursive.h: struct merge_options {
    - 	} detect_directory_renames;
    - 	int rename_limit;
    - 	int rename_score;
    --	int show_rename_progress;
    -+	int show_rename_progress : 1;
    - 
    - 	/* xdiff-related options (patience, ignore whitespace, ours/theirs) */
    - 	long xdl_opts;
24:  2123e9e4e4 = 24:  6ac9e42a3e merge-recursive: alphabetize include list
-- 
2.23.0.rc2.28.g5f89f15d7b.dirty

