Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F48C433B4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C1E61056
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbhCaTKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 15:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbhCaTJx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 15:09:53 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8BBC06174A
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:09:52 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so1677373wmj.1
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z7jqCkyhnuLo5TvRCm8FS5RaieJFpQfOueKScfiAjr0=;
        b=LwHmAYee/89RxSx8N+pbs66DEn/i+7s+0xcwASEPqBS44fxqH+47tvA8lJrOzhfbjh
         0t+LGN7Q6FVxTEMwxGkbtKQpPyb3a7TJQa2/mr9jZN96w7U4jGTR/Mke7RVf7PWL+x8k
         DchMjIR2ARAnTfnV67azTgwD6fX/jAOawXU30jLvdYJmwOJHPPGDSza11I+nkcvctuRN
         ziM/Lh6jvBURaDE4P7bfs4jvmxIRkOtpXD+SwRDM7ftyl8iXwoVU/htd9MIi3PaLIJSK
         KO4iS67ujtlHHrcgismb4OC/n6HQCjcogYMHCgAxLAyi3PRU03vHwI/vuzTIFxv+iENv
         cAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z7jqCkyhnuLo5TvRCm8FS5RaieJFpQfOueKScfiAjr0=;
        b=f9uCWR+CjgPrQuIeZbSpjXjG5EhQZHxP2XYzEbyxRZnM1ckaCPMLkP2m/rGAQkk8ag
         2hQH9FhY+xK/yoctqpLxWJXl2vG2bSGub7GIY4aSmhVBZOjbqe8cPfFtg41AKZWCASp0
         OPTdW22OfSfVXtEyGfS53YJukFnfBRZRTuJkYjIChyrBRaO/oJrDpUQv9cWj5FHt3IUh
         x6YFjfYEOe6NUx71Ec1aRuXttcHSeMC/9XU3nfrcr2OZ0xkW3n38tMowxLT4yfWbe6E9
         MGmCO6oJPkCdligpo0vW+FtVKSAUI4hkIJnr3KuWmSJh+M0VzFbaGDtTcM5PEGuCDmUw
         e/tA==
X-Gm-Message-State: AOAM533FPFfqFFFS68HcJJtP4RfAU79n/KyA8P0lSvh3Zoh0nyQyzbgf
        iSetaKiiIVG8/cZsz10/b/yufJE9A7E=
X-Google-Smtp-Source: ABdhPJwvO/jKlxsXQGUhBjeJMsJ9tmIzz0ouJLh1bhNl7rV8cObJ11pOVWt3qZYWTVqN3Qe2vDZW0Q==
X-Received: by 2002:a1c:b789:: with SMTP id h131mr4531669wmf.106.1617217789889;
        Wed, 31 Mar 2021 12:09:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l8sm6019268wrx.83.2021.03.31.12.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 12:09:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 00/18] tree-walk.h: slimmed down
Date:   Wed, 31 Mar 2021 21:09:28 +0200
Message-Id: <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.474.g72d45d12706
In-Reply-To: <87o8fcqrg8.fsf@evledraar.gmail.com>
References: <87o8fcqrg8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are preparatory changes to the tree-walk.h API to eventually fix
long-broken git-fsck mode checks.

Per http://lore.kernel.org/git/xmqqtup5cnlu.fsf@gitster.g I think the
previous round of this was too big.

So here's a slimmed-down version which stops short of migrating
anything to "enum object_type". There's just:

 * Tests
 * Renaming relevant API *() to *_mode() (the next series will propose a *_type())
 * Adding *_path() API for those users that don't need the "mode" the
   *_mode() function provides
 * Comment updates, fixes to comments.
 * Whitespace changes that would be needed by the next series, but
   which are a good idea anyway while we're at it, e.g. aligning
   function declarations.

Ævar Arnfjörð Bjarmason (18):
  cache.h: add a comment to object_type()
  merge-ort: correct reference to test in 62fdec17a11
  cache.h: have base_name_compare() take "is tree?", not "mode"
  fast-import tests: test for sorting dir/file foo v.s. foo.txt
  mktree tests: test that "mode" is passed when sorting
  diff tests: test that "mode" is passed when sorting
  merge-tree tests: test for the mode comparison in same_entry()
  blame: emit a better error on 'git blame directory'
  notes & match-trees: use name_entry's "pathlen" member
  tree-walk.h users: use temporary variable(s) for "mode"
  match-trees: use "tmp" for mode in shift_tree_by()
  tree.h: format argument lists of read_tree() users
  tree-walk.h API: formatting changes for subsequent commit
  tree-walk.h API doc: improve documentation of get_tree_entry()
  tree-walk.h API: rename get_tree_entry() to get_tree_entry_mode()
  tree-walk.h API: add a get_tree_entry_path() function
  tree-walk.h API: document and format tree_entry_extract()
  tree-entry.h API: rename tree_entry_extract() to
    tree_entry_extract_mode()

 archive.c                       | 21 ++++----
 blame.c                         |  6 +--
 builtin/checkout.c              |  4 +-
 builtin/fast-import.c           | 12 +++--
 builtin/log.c                   |  5 +-
 builtin/ls-tree.c               |  4 +-
 builtin/merge-tree.c            | 12 +++--
 builtin/mktree.c                |  4 +-
 builtin/rm.c                    |  2 +-
 builtin/update-index.c          |  2 +-
 cache.h                         | 11 +++--
 combine-diff.c                  |  8 +--
 fsck.c                          |  2 +-
 line-log.c                      |  2 +-
 match-trees.c                   | 44 ++++++++---------
 merge-ort.c                     | 11 +++--
 merge-recursive.c               | 29 ++++++-----
 notes.c                         | 10 ++--
 object-name.c                   |  7 ++-
 read-cache.c                    | 16 +++---
 t/t1450-fsck.sh                 | 66 +++++++++++++++++++++++++
 t/t4300-merge-tree.sh           | 44 +++++++++++++++++
 t/t8004-blame-with-conflicts.sh | 21 ++++++++
 t/t9300-fast-import.sh          | 87 +++++++++++++++++++++++++++++++++
 tree-diff.c                     | 24 +++++----
 tree-walk.c                     | 30 ++++++++----
 tree-walk.h                     | 35 +++++++++----
 tree.h                          |  5 +-
 unpack-trees.c                  | 18 ++++---
 29 files changed, 410 insertions(+), 132 deletions(-)

Range-diff:
 1:  c307eb53331 <  -:  ----------- show tests: add test for "git show <tree>"
 2:  f37d7705cf0 <  -:  ----------- ls-files tests: add meaningful --with-tree tests
 3:  6291d8a1b5e <  -:  ----------- tree.c API: move read_tree() into builtin/ls-files.c
 4:  466b518e915 <  -:  ----------- ls-files: don't needlessly pass around stage variable
 5:  30c3abfe9b9 <  -:  ----------- ls-files: refactor away read_tree()
 6:  02c42be9249 <  -:  ----------- archive: stop passing "stage" through read_tree_recursive()
 7:  d55e8d4042b <  -:  ----------- tree.h API: expose read_tree_1() as read_tree_at()
 8:  fa157d8baee <  -:  ----------- tree.h API: simplify read_tree_recursive() signature
10:  186f7a7a44b =  1:  a74e02ff0ba cache.h: add a comment to object_type()
24:  092472f3c8d =  2:  57092359bbb merge-ort: correct reference to test in 62fdec17a11
16:  1b6a10f814c !  3:  44c3fdd0085 cache.h: have base_name_compare() take "is tree?", not "mode"
    @@ Commit message
         function to take a boolean argument indicating whether the entry is a
         tree or not, instead of having them call S_ISDIR(mode) on their own.
     
    -    This makes use of the new "object_type" field in the "name_entry".
    +    This introduces no functional change, but makes later (not part of
    +    this series) changes to abstract away "object_type" from "mode" more
    +    readable.
     
         The API being modified here was originally added way back in
         958ba6c96eb (Introduce "base_name_compare()" helper function,
    @@ match-trees.c: static void *fill_tree_desc_strict(struct tree_desc *desc,
      {
     -	return base_name_compare(a->path, tree_entry_len(a), a->mode,
     -				 b->path, tree_entry_len(b), b->mode);
    -+	int istree_a = (a->object_type == OBJ_TREE);
    -+	int istree_b = (b->object_type == OBJ_TREE);
    ++	int istree_a = S_ISDIR(a->mode);
    ++	int istree_b = S_ISDIR(b->mode);
     +	return base_name_compare(a->path, tree_entry_len(a), istree_a,
     +				 b->path, tree_entry_len(b), istree_b);
      }
    @@ tree-diff.c: static int tree_entry_pathcmp(struct tree_desc *t1, struct tree_des
      		return -1;
      
      	e1 = &t1->entry;
    -+	istree_e1 = (e1->object_type == OBJ_TREE);
    ++	istree_e1 = S_ISDIR(e1->mode);
      	e2 = &t2->entry;
     -	cmp = base_name_compare(e1->path, tree_entry_len(e1), e1->mode,
     -				e2->path, tree_entry_len(e2), e2->mode);
    -+	istree_e2 = (e2->object_type == OBJ_TREE);
    ++	istree_e2 = S_ISDIR(e2->mode);
     +	cmp = base_name_compare(e1->path, tree_entry_len(e1), istree_e1,
     +				e2->path, tree_entry_len(e2), istree_e2);
      	return cmp;
    @@ unpack-trees.c: static int do_compare_entry(const struct cache_entry *ce,
      static int compare_entry(const struct cache_entry *ce, const struct traverse_info *info, const struct name_entry *n)
      {
     -	int cmp = do_compare_entry(ce, info, n->path, n->pathlen, n->mode);
    -+	int istree = (n->object_type == OBJ_TREE);
    ++	int istree = S_ISDIR(n->mode);
     +	int cmp = do_compare_entry(ce, info, n->path, n->pathlen, istree);
      	if (cmp)
      		return cmp;
13:  7016008554a =  4:  2ff35f410cd fast-import tests: test for sorting dir/file foo v.s. foo.txt
14:  b0546197b1b =  5:  b3289f7bbe5 mktree tests: test that "mode" is passed when sorting
15:  73e92ac187d =  6:  0be013e47c4 diff tests: test that "mode" is passed when sorting
23:  592fecb7abc !  7:  3367850559b merge-tree tests: test for the mode comparison in same_entry()
    @@ Commit message
         but as seen here it's important that we don't think a path with the
         same content but different modes is the same_entry().
     
    -    The rest of this series will touch code that's relevant to this, but
    -    won't change its behavior. This test is just something I came up with
    -    in testing whether the mode test in same_entry() was needed at all.
    -
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t4300-merge-tree.sh ##
36:  81da5490221 !  8:  3c2ca98716d blame: emit a better error on 'git blame directory'
    @@ Commit message
         something uniquely bad when in a conflicted merge. See
         cd8ae20195 (git-blame shouldn't crash if run in an unmerged tree,
         2007-10-18) and 9aeaab6811 (blame: allow "blame file" in the middle of
    -    a conflicted merge, 2012-09-11) for the bug the t8004 test was
    -    originally meant to address.
    +    a conflicted merge, 2012-09-11) for the bug the test was originally
    +    meant to address.
     
         But when extending it let's grep out the specific error message for
         good measure. Having to change it in the future (e.g. as part of my
    @@ Commit message
     
      ## blame.c ##
     @@ blame.c: static void verify_working_tree_path(struct repository *r,
    + 		struct object_id blob_oid;
    + 		unsigned short mode;
      
    - 	for (parents = work_tree->parents; parents; parents = parents->next) {
    - 		const struct object_id *commit_oid = &parents->item->object.oid;
    --		struct object_id blob_oid;
    --		unsigned short mode;
    --		int ret = get_tree_entry_mode(r, commit_oid, path, &blob_oid,
    --					      &mode);
    --
    --		if (!ret && oid_object_info(r, &blob_oid, NULL) == OBJ_BLOB)
    -+		struct object_id oid;
    -+		if (!get_tree_entry_path(r, commit_oid, path, &oid))
    +-		if (!get_tree_entry(r, commit_oid, path, &blob_oid, &mode) &&
    +-		    oid_object_info(r, &blob_oid, NULL) == OBJ_BLOB)
    ++		if (!get_tree_entry(r, commit_oid, path, &blob_oid, &mode))
      			return;
      	}
      
 9:  0390b1e9ded =  9:  749be26bf8e notes & match-trees: use name_entry's "pathlen" member
11:  4fed508f3cb <  -:  ----------- tree-walk.h: add object_type member to name_entry
12:  c557b67231b <  -:  ----------- tree-walk.c: migrate to using new "object_type" field when possible
17:  f8912a409b5 <  -:  ----------- tree-walk.h users: switch object_type(...) to new .object_type
26:  4babecb7855 ! 10:  5c0a49c188f tree-walk.h users: use temporary variable(s) for "mode"
    @@ Commit message
         In preparation for an eventual rename of the "mode" field, add
         temporary variable(s) in those places where it's used more than once.
     
    -    This will make a subsequent commits easier to read., since we're only
    +    This will make those later commits easier to read, since we're only
         going to need to modify the line on which the assignment happens.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ builtin/merge-tree.c: static struct merge_list *link_entry(unsigned stage, const
      	struct merge_list *link;
     +	unsigned int link_mode;
      
    - 	if (n->object_type == OBJ_NONE)
    + 	if (!n->mode)
      		return entry;
     @@ builtin/merge-tree.c: static struct merge_list *link_entry(unsigned stage, const struct traverse_info
      		path = entry->path;
29:  40f37e99cd9 ! 11:  e190ed39754 match-trees: use "tmp" for mode in shift_tree_by()
    @@ match-trees.c: void shift_tree_by(struct repository *r,
      	unsigned candidate = 0;
      
      	/* Can hash2 be a tree at shift_prefix in tree hash1? */
    --	if (!get_tree_entry_mode(r, hash1, shift_prefix, &sub1, &mode1) &&
    +-	if (!get_tree_entry(r, hash1, shift_prefix, &sub1, &mode1) &&
     -	    S_ISDIR(mode1))
    -+	if (!get_tree_entry_mode(r, hash1, shift_prefix, &sub1, &tmp) &&
    ++	if (!get_tree_entry(r, hash1, shift_prefix, &sub1, &tmp) &&
     +	    S_ISDIR(tmp))
      		candidate |= 1;
      
      	/* Can hash1 be a tree at shift_prefix in tree hash2? */
    --	if (!get_tree_entry_mode(r, hash2, shift_prefix, &sub2, &mode2) &&
    +-	if (!get_tree_entry(r, hash2, shift_prefix, &sub2, &mode2) &&
     -	    S_ISDIR(mode2))
    -+	if (!get_tree_entry_mode(r, hash2, shift_prefix, &sub2, &tmp) &&
    ++	if (!get_tree_entry(r, hash2, shift_prefix, &sub2, &tmp) &&
     +	    S_ISDIR(tmp))
      		candidate |= 2;
      
18:  df43f1a76ac ! 12:  960e15bc7d5 tree.h: format argument lists of read_tree_recursive() users
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    tree.h: format argument lists of read_tree_recursive() users
    +    tree.h: format argument lists of read_tree() users
     
    -    In preparation for adding a new argument to read_tree_fn_t re-indent
    -    and format the argument list of read_tree_recursive() callbacks, and
    +    Re-indent and format the argument list of read_tree() callbacks, and
         the relevant functions they call.
     
    -    This is a whitespace-only change to make reading subsequent commits
    -    easier. I'll be adding a new argument on the "mode" line, so leave
    -    space on it.
    +    This is a whitespace-only change to make changes in a later series
    +    easier to read. In that series I'll be adding a new argument on the
    +    "mode" line, so leave space on it for a new argument.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
19:  152c6d88542 <  -:  ----------- tree.h API: make read_tree_fn_t take an "enum object_type"
20:  1c2f65cb674 <  -:  ----------- tree-walk.h users: migrate "p->mode &&" pattern
21:  163922d427c <  -:  ----------- tree-walk.h users: refactor chained "mode" if/else into switch
22:  21df7c668be <  -:  ----------- tree-walk.h users: migrate miscellaneous "mode" to "object_type"
25:  685da1abbdc <  -:  ----------- fsck.c: switch on "object_type" in fsck_walk_tree()
27:  7251654dd52 ! 13:  9c96d472472 tree-walk.h API: formatting changes for subsequent commit
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## blame.c ##
    -@@ blame.c: static void verify_working_tree_path(struct repository *r,
    - 		const struct object_id *commit_oid = &parents->item->object.oid;
    - 		struct object_id blob_oid;
    - 		unsigned short mode;
    -+		int ret = get_tree_entry(r, commit_oid, path, &blob_oid,
    -+					 &mode);
    - 
    --		if (!get_tree_entry(r, commit_oid, path, &blob_oid, &mode) &&
    --		    oid_object_info(r, &blob_oid, NULL) == OBJ_BLOB)
    -+		if (!ret && oid_object_info(r, &blob_oid, NULL) == OBJ_BLOB)
    - 			return;
    - 	}
    - 
    -
      ## tree-walk.c ##
     @@ tree-walk.c: static int find_tree_entry(struct repository *r, struct tree_desc *t,
      			oidcpy(result, &oid);
30:  7f699bf2d5c ! 14:  44f16d74426 tree-walk.h API: add get_tree_entry_type()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    tree-walk.h API: add get_tree_entry_type()
    +    tree-walk.h API doc: improve documentation of get_tree_entry()
     
    -    Add a get_tree_entry_type() helper function to compliment the existing
    -    get_tree_entry(), and a static get_tree_entry_all() which it uses internally.
    -
    -    Move those users of get_tree_entry_type() who didn't care about the
    -    mode specifically, but just want to know whether the tree entry is one
    -    of OBJ_{BLOB,COMMIT,TREE} over to the new get_tree_entry_type().
    -
    -    The get_tree_entry_all() function itself will be made non-static in a
    -    subsequent commit. I'm leaving its argument list indented accordingly
    -    to reduce churn when I do so.
    +    Change a mention of sha1 to OID and change the comment to a listing of
    +    functions discussed below, right now there's only one function, but
    +    subsequent commits will add more.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## archive.c ##
    -@@ archive.c: static void parse_treeish_arg(const char **argv,
    - 
    - 	if (prefix) {
    - 		struct object_id tree_oid;
    --		unsigned short mode;
    -+		enum object_type object_type;
    - 		int err;
    - 
    --		err = get_tree_entry_mode(ar_args->repo,
    -+		err = get_tree_entry_type(ar_args->repo,
    - 					  &tree->object.oid,
    - 					  prefix, &tree_oid,
    --					  &mode);
    --		if (err || !S_ISDIR(mode))
    -+					  &object_type);
    -+		if (err || object_type != OBJ_TREE)
    - 			die(_("current working directory is untracked"));
    - 
    - 		tree = parse_tree_indirect(&tree_oid);
    -
    - ## match-trees.c ##
    -@@ match-trees.c: void shift_tree_by(struct repository *r,
    - 		   const char *shift_prefix)
    - {
    - 	struct object_id sub1, sub2;
    --	unsigned short tmp;
    -+	enum object_type tmp;
    - 	unsigned candidate = 0;
    - 
    - 	/* Can hash2 be a tree at shift_prefix in tree hash1? */
    --	if (!get_tree_entry_mode(r, hash1, shift_prefix, &sub1, &tmp) &&
    --	    S_ISDIR(tmp))
    -+	if (!get_tree_entry_type(r, hash1, shift_prefix, &sub1, &tmp) &&
    -+	    tmp == OBJ_TREE)
    - 		candidate |= 1;
    - 
    - 	/* Can hash1 be a tree at shift_prefix in tree hash2? */
    --	if (!get_tree_entry_mode(r, hash2, shift_prefix, &sub2, &tmp) &&
    --	    S_ISDIR(tmp))
    -+	if (!get_tree_entry_type(r, hash2, shift_prefix, &sub2, &tmp) &&
    -+	    tmp == OBJ_TREE)
    - 		candidate |= 2;
    - 
    - 	if (candidate == 3) {
    -
    - ## tree-walk.c ##
    -@@ tree-walk.c: struct dir_state {
    - 	struct object_id oid;
    - };
    - 
    -+static int get_tree_entry_all(struct repository *r,
    -+			      const struct object_id *tree_oid,
    -+			      const char *name,
    -+			      struct object_id *oid,
    -+			      unsigned short *mode,
    -+			      enum object_type *object_type);
    -+
    - static int find_tree_entry(struct repository *r, struct tree_desc *t,
    - 			   const char *name, struct object_id *result,
    --			   unsigned short *mode)
    -+			   unsigned short *mode,
    -+			   enum object_type *object_type)
    - {
    - 	int namelen = strlen(name);
    - 	while (t->size) {
    -@@ tree-walk.c: static int find_tree_entry(struct repository *r, struct tree_desc *t,
    - 		}
    - 		if (name[entrylen] != '/')
    - 			continue;
    --		if (!S_ISDIR(*mode))
    -+		if (*object_type != OBJ_TREE)
    - 			break;
    - 		if (++entrylen == namelen) {
    - 			oidcpy(result, &oid);
    - 			return 0;
    - 		}
    --		return get_tree_entry_mode(r, &oid, name + entrylen, result,
    --					   mode);
    -+		return get_tree_entry_all(r, &oid, name + entrylen, result,
    -+					  mode, object_type);
    - 	}
    - 	return -1;
    - }
    - 
    --int get_tree_entry_mode(struct repository *r,
    --			const struct object_id *tree_oid,
    --			const char *name,
    --			struct object_id *oid,
    --			unsigned short *mode)
    -+static int get_tree_entry_all(struct repository *r,
    -+		       const struct object_id *tree_oid,
    -+		       const char *name,
    -+		       struct object_id *oid,
    -+		       unsigned short *mode,
    -+		       enum object_type *object_type)
    - {
    - 	int retval;
    - 	void *tree;
    -@@ tree-walk.c: int get_tree_entry_mode(struct repository *r,
    - 		struct tree_desc t;
    - 		init_tree_desc(&t, tree, size);
    - 		retval = find_tree_entry(r, &t, name, oid,
    --					 mode);
    -+					 mode, object_type);
    - 	}
    - 	free(tree);
    - 	return retval;
    - }
    - 
    -+int get_tree_entry_mode(struct repository *r,
    -+			const struct object_id *tree_oid,
    -+			const char *name,
    -+			struct object_id *oid,
    -+			unsigned short *mode)
    -+{
    -+	enum object_type object_type;
    -+	return get_tree_entry_all(r, tree_oid, name, oid,
    -+				  mode, &object_type);
    -+}
    -+
    -+int get_tree_entry_type(struct repository *r,
    -+			const struct object_id *tree_oid,
    -+			const char *name,
    -+			struct object_id *oid,
    -+			enum object_type *object_type)
    -+{
    -+	unsigned short mode;
    -+	return get_tree_entry_all(r, tree_oid, name, oid,
    -+				  &mode, object_type);
    -+}
    -+
    - /*
    -  * This is Linux's built-in max for the number of symlinks to follow.
    -  * That limit, of course, does not affect git, but it's a reasonable
    -@@ tree-walk.c: enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
    - 		int find_result;
    - 		char *first_slash;
    - 		char *remainder = NULL;
    -+		enum object_type object_type;
    - 
    - 		if (!t.buffer) {
    - 			void *tree;
    -@@ tree-walk.c: enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
    - 		/* Look up the first (or only) path component in the tree. */
    - 		find_result = find_tree_entry(r, &t, namebuf.buf,
    - 					      &current_tree_oid,
    --					      mode);
    -+					      mode, &object_type);
    - 		if (find_result) {
    - 			goto done;
    - 		}
    -
      ## tree-walk.h ##
     @@ tree-walk.h: struct traverse_info {
    -  * Find an entry in a tree given a pathname and the sha1 of a tree to
    + };
    + 
    + /**
    +- * Find an entry in a tree given a pathname and the sha1 of a tree to
    ++ * Find an entry in a tree given a pathname and the OID of a tree to
       * search. Returns 0 if the entry is found and -1 otherwise.
       *
     - * The third and fourth parameters are set to the entry's sha1 and
     - * mode respectively.
    -+ * There are variants of this function depending on what fields in the
    -+ * "struct name_entry" you'd like. You always need a pointer to an
    -+ * appropriate variable to fill in (NULL won't do!):
    ++ * You always need a pointer to an appropriate variable to fill in
    ++ * (NULL won't do!). That variable is:
     + *
    -+ * get_tree_entry_mode(): unsigned int mode
    -+ * get_tree_entry_type(): enum object_type
    ++ * get_tree_entry(): unsigned short mode
       */
    - int get_tree_entry_mode(struct repository *, const struct object_id *, const char *,
    - 			struct object_id *,
    - 			unsigned short *);
    -+int get_tree_entry_type(struct repository *, const struct object_id *, const char *,
    -+			struct object_id *,
    -+			enum object_type *);
    - 
    - /**
    -  * Generate the full pathname of a tree entry based from the root of the
    + int get_tree_entry(struct repository *, const struct object_id *, const char *,
    + 		   struct object_id *,
28:  9e521a3cbf2 ! 15:  adbada0ade8 tree-walk.h API: rename get_tree_entry() to get_tree_entry_mode()
    @@ Commit message
         change is only a search-replacement of the name and indentation of the
         argument lists.
     
    -    A subsequent commits will add get_tree_entry_type() and
    -    get_tree_entry_all() functions. Those changes will be much easier to
    -    read if we do this rename first.
    +    Subsequent commits will add another get_tree_entry_*() function. Those
    +    changes will be much easier to read if we do this rename first.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ blame.c: static void verify_working_tree_path(struct repository *r,
      		const struct object_id *commit_oid = &parents->item->object.oid;
      		struct object_id blob_oid;
      		unsigned short mode;
    --		int ret = get_tree_entry(r, commit_oid, path, &blob_oid,
    --					 &mode);
    -+		int ret = get_tree_entry_mode(r, commit_oid, path, &blob_oid,
    -+					      &mode);
    - 
    - 		if (!ret && oid_object_info(r, &blob_oid, NULL) == OBJ_BLOB)
    +-
    +-		if (!get_tree_entry(r, commit_oid, path, &blob_oid, &mode))
    ++		if (!get_tree_entry_mode(r, commit_oid, path, &blob_oid, &mode))
      			return;
    + 	}
    + 
     @@ blame.c: static int fill_blob_sha1_and_mode(struct repository *r,
      {
      	if (!is_null_oid(&origin->blob_oid))
    @@ match-trees.c: void shift_tree_by(struct repository *r,
      	unsigned candidate = 0;
      
      	/* Can hash2 be a tree at shift_prefix in tree hash1? */
    --	if (!get_tree_entry(r, hash1, shift_prefix, &sub1, &mode1) &&
    -+	if (!get_tree_entry_mode(r, hash1, shift_prefix, &sub1, &mode1) &&
    - 	    S_ISDIR(mode1))
    +-	if (!get_tree_entry(r, hash1, shift_prefix, &sub1, &tmp) &&
    ++	if (!get_tree_entry_mode(r, hash1, shift_prefix, &sub1, &tmp) &&
    + 	    S_ISDIR(tmp))
      		candidate |= 1;
      
      	/* Can hash1 be a tree at shift_prefix in tree hash2? */
    --	if (!get_tree_entry(r, hash2, shift_prefix, &sub2, &mode2) &&
    -+	if (!get_tree_entry_mode(r, hash2, shift_prefix, &sub2, &mode2) &&
    - 	    S_ISDIR(mode2))
    +-	if (!get_tree_entry(r, hash2, shift_prefix, &sub2, &tmp) &&
    ++	if (!get_tree_entry_mode(r, hash2, shift_prefix, &sub2, &tmp) &&
    + 	    S_ISDIR(tmp))
      		candidate |= 2;
      
     
    @@ tree-walk.c: static int find_tree_entry(struct repository *r, struct tree_desc *
     
      ## tree-walk.h ##
     @@ tree-walk.h: struct traverse_info {
    -  * The third and fourth parameters are set to the entry's sha1 and
    -  * mode respectively.
    +  * You always need a pointer to an appropriate variable to fill in
    +  * (NULL won't do!). That variable is:
    +  *
    +- * get_tree_entry(): unsigned short mode
    ++ * get_tree_entry_mode(): unsigned short mode
       */
     -int get_tree_entry(struct repository *, const struct object_id *, const char *,
     -		   struct object_id *,
35:  a2a34fd3e2d ! 16:  3ba77fd3a47 tree-walk.h API: add a get_tree_entry_path() function
    @@ Commit message
         tree-walk.h API: add a get_tree_entry_path() function
     
         Add a get_tree_entry_path() variant in addition to
    -    get_tree_entry_path_{mode,type,all}(). This is for those callers that
    -    need neither the mode nor "enum object_type" parameters filled for
    -    them.
    +    get_tree_entry_path_mode(). This is for those callers that don't need
    +    the "mode" filled for them.
     
    -    There are callers here which don't need the "struct object_id" filled;
    -    forcing callers to pass one just requires they create a throwaway
    -    variable.
    +    There are callers here which don't need the "struct object_id" filled
    +    either, but let's leave that for now. I'm focusing downstream code
    +    that depends on "mode" (or "enum object_type").
     
    -    See the following commits for the introduction of such code that's
    -    being modified here:
    +    The code being modified here was introduced in:
     
          - shift_tree(): 68faf68938e (A new merge stragety[sic] 'subtree'.,
             2007-02-15) for the shift_tree()
    @@ Commit message
          - diagnose_invalid_oid_path(): 009fee4774d (Detailed diagnosis when
            parsing an object name fails., 2009-12-07)
     
    -    Those could potentially be refactored too, but I've got to stop at
    -    some point, and right now I'm focusing downstream code that depends on
    -    "mode" (or "enum object_type").
    -
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## match-trees.c ##
    @@ object-name.c: static void diagnose_invalid_oid_path(struct repository *r,
      			    fullname,
     
      ## tree-walk.c ##
    -@@ tree-walk.c: int get_tree_entry_all(struct repository *r,
    +@@ tree-walk.c: int get_tree_entry_mode(struct repository *r,
      	return retval;
      }
      
    @@ tree-walk.c: int get_tree_entry_all(struct repository *r,
     +			struct object_id *oid)
     +{
     +	unsigned short mode;
    -+	enum object_type object_type;
    -+	return get_tree_entry_all(r, tree_oid, name, oid,
    -+				  &mode, &object_type);
    ++	return get_tree_entry_mode(r, tree_oid, name, oid, &mode);
     +}
     +
    - int get_tree_entry_mode(struct repository *r,
    - 			const struct object_id *tree_oid,
    - 			const char *name,
    + /*
    +  * This is Linux's built-in max for the number of symlinks to follow.
    +  * That limit, of course, does not affect git, but it's a reasonable
     
      ## tree-walk.h ##
     @@ tree-walk.h: struct traverse_info {
    -  * "struct name_entry" you'd like. You always need a pointer to an
    -  * appropriate variable to fill in (NULL won't do!):
    +  * You always need a pointer to an appropriate variable to fill in
    +  * (NULL won't do!). That variable is:
       *
     + * get_tree_entry_path(): <no extra argument, just get the common 'path'>
    -  * get_tree_entry_mode(): unsigned int mode
    -  * get_tree_entry_type(): enum object_type
    -  * get_tree_entry_all(): unsigned int mode, enum object_type
    +  * get_tree_entry_mode(): unsigned short mode
       */
     +int get_tree_entry_path(struct repository *, const struct object_id *, const char *,
     +			struct object_id *);
31:  7ab7576cb16 ! 17:  dc895822828 tree-walk.h API: document and format tree_entry_extract()
    @@ Commit message
         tree-walk.h API: document and format tree_entry_extract()
     
         Document and format the argument list of the tree_entry_extract()
    -    function in preparation for adding a sister function.
    +    function in preparation for eventually adding a sister function.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ tree-walk.h: struct tree_desc {
     + * "struct name_entry" you'd like. You always need a pointer to an
     + * appropriate variable to fill in (NULL won't do!):
     + *
    -+ * tree_entry_extract_mode(): const char *path, unsigned int mode
    ++ * tree_entry_extract(): const char *path, unsigned int mode
       */
     -static inline const struct object_id *tree_entry_extract(struct tree_desc *desc, const char **pathp, unsigned short *modep)
     +static inline const struct object_id *tree_entry_extract(struct tree_desc *desc,
32:  a1bd81d64aa ! 18:  e961a0e8b5b tree-entry.h API: rename tree_entry_extract() to tree_entry_extract_mode()
    @@ tree-diff.c: static struct combine_diff_path *emit_path(struct combine_diff_path
      
      		isdir = S_ISDIR(mode);
     
    + ## tree-walk.c ##
    +@@ tree-walk.c: static int find_tree_entry(struct repository *r, struct tree_desc *t,
    + 		struct object_id oid;
    + 		int entrylen, cmp;
    + 
    +-		oidcpy(&oid, tree_entry_extract(t, &entry, mode));
    ++		oidcpy(&oid, tree_entry_extract_mode(t, &entry, mode));
    + 		entrylen = tree_entry_len(&t->entry);
    + 		update_tree_entry(t);
    + 		if (entrylen > namelen)
    +
      ## tree-walk.h ##
     @@ tree-walk.h: struct tree_desc {
    +  * "struct name_entry" you'd like. You always need a pointer to an
    +  * appropriate variable to fill in (NULL won't do!):
       *
    -  * tree_entry_extract_mode(): const char *path, unsigned int mode
    +- * tree_entry_extract(): const char *path, unsigned int mode
    ++ * tree_entry_extract_mode(): const char *path, unsigned int mode
       */
     -static inline const struct object_id *tree_entry_extract(struct tree_desc *desc,
     -							 const char **pathp,
33:  ce7c19ad39c <  -:  ----------- tree-walk.h API: add a tree_entry_extract_all() function
34:  95eec961be8 <  -:  ----------- tree-walk.h API: add get_tree_entry_all()
37:  4d51da4ea39 <  -:  ----------- tree-walk.h API: add a tree_entry_extract_type() function
-- 
2.31.1.474.g72d45d12706

