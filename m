Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E88B1F516
	for <e@80x24.org>; Sun,  1 Jul 2018 01:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbeGABZM (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 21:25:12 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:34043 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbeGABZL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 21:25:11 -0400
Received: by mail-ot0-f196.google.com with SMTP id i17-v6so13857724otl.1
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 18:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KcihYLThOES9FHQkdt02/oiWh9g1iRRYZMZFparklRU=;
        b=KX05mgOBD2fuhtCQ0cgtneGzFX7RKRzW5uteFkgmlZSK+GPCroBPrSAvLHPL3DxlHv
         RzrXD726TyWDKWmm0Ti8yEGAqRmBFkF6UKGJKSi+vvF2Fbapckdgz2Ur+3iDkkboGA70
         qTWiqAmJpX79gcGWKscEAnZJeXSJpptZ0Ux50979wzjYJIR7edM6uOZ6Zj1Axo0SjQ6g
         mKL7bDHn6FeL+pAzwQ2ci3zF9Krkteopxc/WEvxvPE+FlyWcPCuTqphxZ+gzm8D5KLIm
         oHMsxzp+cObXrVFSXnj8ueHv8NYU27ks9En2nuzFLc/fHxwXjTVB9p/VzWBlH+9cJM1V
         jO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KcihYLThOES9FHQkdt02/oiWh9g1iRRYZMZFparklRU=;
        b=FsiEqiLk9esJRfIRMJgFI3zO8FyEpKdQMhGGH2MXOzni5h8JFvwb8yYEE23Bwu52K+
         YKr7OL1sCwoxModm8HqTx75w/yzRZz6AMcp/llJ6vGokNsLeTdjtfVR0c3rzx516JDso
         DjsUfiS56D46BiNsRQBGJLzYZU0R9TrroZ4mcIWPRTUB5+MAdqe60s2C8EGELbIMF61m
         KzUXSOPdDZPbddsbbGviU+nWUQXJEsaYbFtWn6oXf39B9yXXVr1qUB4guhgkYooNc2PC
         P3WfOkrhSkfirrYlPPf3rePC8UyoS+oiF1KNWz6DVufgzY2bSvm/dYbSsuwUOHY+KiB2
         GrnQ==
X-Gm-Message-State: APt69E0UzGVrneL+nrhKuc+OXSV1mh6ANvujC/oXUNBLCwM5pt3zo152
        7hNhTlGeg4YSvK1UluY0B760CA==
X-Google-Smtp-Source: AAOMgpdf9pVEo+Saek5o296WFFWUFFVl7vDFeJS9IxAGLjUt/dUZlLfQgXTn2PDjc3V8+t9yVy7Xyw==
X-Received: by 2002:a9d:131b:: with SMTP id f27-v6mr11522531ote.270.1530408310597;
        Sat, 30 Jun 2018 18:25:10 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id g20-v6sm3509394ote.38.2018.06.30.18.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 18:25:09 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 0/9] Fix merge issues with index not matching HEAD
Date:   Sat, 30 Jun 2018 18:24:54 -0700
Message-Id: <20180701012503.14382-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.137.g2a11d05a6.dirty
In-Reply-To: <20180603065810.23841-1-newren@gmail.com>
References: <20180603065810.23841-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series exists to fix problems for merges when the index doesn't
match HEAD.  We've had an almost comical number of these types of
problems in our history, as thoroughly documented in the commit
message for the final patch.

v1 can be found here:
  https://public-inbox.org/git/20180603065810.23841-1-newren@gmail.com/

Changes since v1 (full branch-diff below):
  * Minor wording tweaks to a few commit messages (fixing typos,
    rewrapping, etc.)
    
  * Move index_has_changes() to read-cache.c, and (partially) lift the
    assumption that we're always operating on the_index -- as
    suggested by Junio.  A full lift of the assumption would conflict
    with and duplicate work Duy is doing, so there is a simple BUG()
    check in place for now.
    
  * Add two new patches to the _beginning_ of the series, to implement
    the last point.  Reason: Since this series will probably conflict
    slightly with Duy's not-yet-submitted work to remove assumption of
    the_index throughout the codebase, I figured this would make it
    the clearest and easiest for him to fix up small conflicts.
    (Alternatively, if folks would rather that my series wait for his
    to go through, it should make it much easier for me to rebase my
    series on top of his work by having these placeholders at the
    beginning.)

Questions I'm particularly interested in reviewers addressing:

  * Do my two patches at the beginning make sense?  In particular, is
    the BUG() a reasonable way to limit conflicts with Duy for now,
    while he works on more thoroughly stamping out assumed the_index
    usage?

  * Does the series flow well?  I was curious if I should reorder the
    series when I submitted v1, but no one commented on that question.

  * The second to last patch points out that current git incorrectly
    implements what would be a safe exception to the index matching
    HEAD before a merge rule.  Would it be more desireable to
    correctly implement the safe exception (even though it would be
    somewhat difficult), rather than just disallow the exception for
    merge-recursive as I did in that patch?

  * Given the large number of problems we've had in this area -- as
    documented in the final commit message -- should we be more
    defensive and disallow all merge strategies from having even
    so-called safe exceptions?  We could do this in a single place,
    which would have prevented all the current and most if not all
    historical problems in this area, by just enforcing that the index
    match HEAD in builtin/merge.c.  (See the second to last paragraph
    of the last commit message for more details.)

Elijah Newren (9):
  read-cache.c: move index_has_changes() from merge.c
  index_has_changes(): avoid assuming operating on the_index
  t6044: verify that merges expected to abort actually abort
  t6044: add a testcase for index matching head, when head doesn't match
    HEAD
  merge-recursive: make sure when we say we abort that we actually abort
  merge-recursive: fix assumption that head tree being merged is HEAD
  t6044: add more testcases with staged changes before a merge is
    invoked
  merge-recursive: enforce rule that index matches head before merging
  merge: fix misleading pre-merge check documentation

 Documentation/git-merge.txt              |   6 +-
 builtin/am.c                             |   7 +-
 cache.h                                  |  16 +--
 merge-recursive.c                        |  14 +--
 merge.c                                  |  31 ------
 read-cache.c                             |  40 ++++++++
 t/t6044-merge-unrelated-index-changes.sh |  67 +++++++++++--
 t/t7504-commit-msg-hook.sh               |   4 +-
 t/t7611-merge-abort.sh                   | 118 -----------------------
 9 files changed, 124 insertions(+), 179 deletions(-)

-:  --------- > 1:  ff2501ac4 read-cache.c: move index_has_changes() from merge.c
-:  --------- > 2:  5813ca722 index_has_changes(): avoid assuming operating on the_index
1:  730e5e483 = 3:  ca11503bd t6044: verify that merges expected to abort actually abort
2:  36f7cc0a3 = 4:  386390899 t6044: add a testcase for index matching head, when head doesn't match HEAD
3:  70899afa3 ! 5:  8a900d2ee merge-recursive: make sure when we say we abort that we actually abort
    @@ -19,7 +19,7 @@
     @@
      		struct strbuf sb = STRBUF_INIT;
      
    - 		if (!o->call_depth && index_has_changes(&sb)) {
    + 		if (!o->call_depth && index_has_changes(&the_index, &sb)) {
     -			err(o, _("Dirty index: cannot merge (dirty: %s)"),
     +			err(o, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
      			    sb.buf);
4:  eab2f36a4 ! 6:  2564b29e9 merge-recursive: fix assumption that head tree being merged is HEAD
    @@ -6,10 +6,9 @@
         base, head, and remote.  Since the user is allowed to specify head, we can
         not necesarily assume that head == HEAD.
     
    -    We modify index_has_changes() to take an extra argument specifying the
    -    tree to compare the index to.  If NULL, it will compare to HEAD.  We then
    -    use this from merge-recursive to make sure we compare to the
    -    user-specified head.
    +    Modify index_has_changes() to take an extra argument specifying the tree
    +    to compare against.  If NULL, it will compare to HEAD.  We then use this
    +    from merge-recursive to make sure we compare to the user-specified head.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
    @@ -20,8 +19,8 @@
      
      	refresh_and_write_cache();
      
    --	if (index_has_changes(&sb)) {
    -+	if (index_has_changes(&sb, NULL)) {
    +-	if (index_has_changes(&the_index, &sb)) {
    ++	if (index_has_changes(&the_index, NULL, &sb)) {
      		write_state_bool(state, "dirtyindex", 1);
      		die(_("Dirty index: cannot apply patches (dirty: %s)"), sb.buf);
      	}
    @@ -29,8 +28,9 @@
      			 * Applying the patch to an earlier tree and merging
      			 * the result may have produced the same tree as ours.
      			 */
    --			if (!apply_status && !index_has_changes(NULL)) {
    -+			if (!apply_status && !index_has_changes(NULL, NULL)) {
    +-			if (!apply_status && !index_has_changes(&the_index, NULL)) {
    ++			if (!apply_status &&
    ++			    !index_has_changes(&the_index, NULL, NULL)) {
      				say(state, stdout, _("No changes -- Patch already applied."));
      				goto next;
      			}
    @@ -38,8 +38,8 @@
      
      	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
      
    --	if (!index_has_changes(NULL)) {
    -+	if (!index_has_changes(NULL, NULL)) {
    +-	if (!index_has_changes(&the_index, NULL)) {
    ++	if (!index_has_changes(&the_index, NULL, NULL)) {
      		printf_ln(_("No changes - did you forget to use 'git add'?\n"
      			"If there is nothing left to stage, chances are that something else\n"
      			"already introduced the same changes; you might want to skip this patch."));
    @@ -48,20 +48,32 @@
     --- a/cache.h
     +++ b/cache.h
     @@
    - extern void move_index_extensions(struct index_state *dst, struct index_state *src);
    + /* Forward structure decls */
    + struct pathspec;
    + struct child_process;
    ++struct tree;
    + 
    + /*
    +  * Copy the sha1 and stat state of a cache entry from one to
    +@@
      extern int unmerged_index(const struct index_state *);
      
    --/**
    -- * Returns 1 if the index differs from HEAD, 0 otherwise. When on an unborn
    -- * branch, returns 1 if there are entries in the index, 0 otherwise. If an
    -- * strbuf is provided, the space-separated list of files that differ will be
    -- * appended to it.
    -- */
    --extern int index_has_changes(struct strbuf *sb);
    --
    + /**
    +- * Returns 1 if istate differs from HEAD, 0 otherwise.  When on an unborn
    +- * branch, returns 1 if there are entries in istate, 0 otherwise.  If an
    +- * strbuf is provided, the space-separated list of files that differ will
    +- * be appended to it.
    ++ * Returns 1 if istate differs from tree, 0 otherwise.  If tree is NULL,
    ++ * compares istate to HEAD.  If tree is NULL and on an unborn branch,
    ++ * returns 1 if there are entries in istate, 0 otherwise.  If an strbuf is
    ++ * provided, the space-separated list of files that differ will be appended
    ++ * to it.
    +  */
    + extern int index_has_changes(const struct index_state *istate,
    ++			     struct tree *tree,
    + 			     struct strbuf *sb);
    + 
      extern int verify_path(const char *path, unsigned mode);
    - extern int strcmp_offset(const char *s1, const char *s2, size_t *first_change);
    - extern int index_dir_exists(struct index_state *istate, const char *name, int namelen);
     
     diff --git a/merge-recursive.c b/merge-recursive.c
     --- a/merge-recursive.c
    @@ -70,26 +82,31 @@
      	if (oid_eq(&common->object.oid, &merge->object.oid)) {
      		struct strbuf sb = STRBUF_INIT;
      
    --		if (!o->call_depth && index_has_changes(&sb)) {
    -+		if (!o->call_depth && index_has_changes(&sb, head)) {
    +-		if (!o->call_depth && index_has_changes(&the_index, &sb)) {
    ++		if (!o->call_depth && index_has_changes(&the_index, head, &sb)) {
      			err(o, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
      			    sb.buf);
      			return -1;
     
    -diff --git a/merge.c b/merge.c
    ---- a/merge.c
    -+++ b/merge.c
    +diff --git a/read-cache.c b/read-cache.c
    +--- a/read-cache.c
    ++++ b/read-cache.c
     @@
    - 	return oid_to_hex(commit ? &commit->object.oid : the_hash_algo->empty_tree);
    + 	return 0;
      }
      
    --int index_has_changes(struct strbuf *sb)
    -+int index_has_changes(struct strbuf *sb, struct tree *tree)
    +-int index_has_changes(const struct index_state *istate, struct strbuf *sb)
    ++int index_has_changes(const struct index_state *istate,
    ++		      struct tree *tree,
    ++		      struct strbuf *sb)
      {
     -	struct object_id head;
     +	struct object_id cmp;
      	int i;
      
    + 	if (istate != &the_index) {
    + 		BUG("index_has_changes cannot yet accept istate != &the_index; do_diff_cache needs updating first.");
    + 	}
     -	if (!get_oid_tree("HEAD", &head)) {
     +	if (tree)
     +		cmp = tree->object.oid;
    @@ -118,20 +135,3 @@
      	git reset --hard &&
      	git checkout C^0 &&
      
    -
    -diff --git a/tree.h b/tree.h
    ---- a/tree.h
    -+++ b/tree.h
    -@@
    - extern int read_tree(struct tree *tree, int stage, struct pathspec *pathspec,
    - 		     struct index_state *istate);
    - 
    -+/**
    -+ * Returns 1 if the index differs from tree, 0 otherwise.  If tree is NULL,
    -+ * compares to HEAD.  If tree is NULL and on an unborn branch, returns 1 if
    -+ * there are entries in the index, 0 otherwise. If an strbuf is provided,
    -+ * the space-separated list of files that differ will be appended to it.
    -+ */
    -+extern int index_has_changes(struct strbuf *sb, struct tree *tree);
    -+
    - #endif /* TREE_H */
5:  4aa0684c0 ! 7:  88a8e44a2 t6044: add more testcases with staged changes before a merge is invoked
    @@ -5,8 +5,9 @@
         According to Documentation/git-merge.txt,
     
             ...[merge will] abort if there are any changes registered in the index
    -        relative to the `HEAD` commit.  (One exception is when the changed index
    -        entries are in the state that would result from the merge already.)
    +        relative to the `HEAD` commit.  (One exception is when the changed
    +        index entries are in the state that would result from the merge
    +        already.)
     
         Add some tests showing that this exception, while it does accurately state
         what would be a safe condition under which we could allow the merge to
6:  905f2683f ! 8:  c0049b788 merge-recursive: enforce rule that index matches head before merging
    @@ -48,16 +48,16 @@
         commit, just like the 'ours' and 'octopus' strategies do.
     
         Some testcase fixups were in order:
    -      t6044: We no longer expect stray staged changes to sometimes result
    -             in the merge continuing.  Also, fixes a case where a merge
    -             didn't abort but should have.
    -      t7504: had a few tests that had stray staged changes that were not
    -             actually part of the test under consideration
           t7611: had many tests designed to show that `git merge --abort` could
                  not always restore the index and working tree to the state they
                  were in before the merge started.  The tests that were associated
                  with having changes in the index before the merge started are no
                  longer applicable, so they have been removed.
    +      t7504: had a few tests that had stray staged changes that were not
    +             actually part of the test under consideration
    +      t6044: We no longer expect stray staged changes to sometimes result
    +             in the merge continuing.  Also, fix a case where a merge
    +             didn't abort but should have.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
    @@ -70,7 +70,7 @@
      	int code, clean;
     +	struct strbuf sb = STRBUF_INIT;
     +
    -+	if (!o->call_depth && index_has_changes(&sb, head)) {
    ++	if (!o->call_depth && index_has_changes(&the_index, head, &sb)) {
     +		err(o, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
     +		    sb.buf);
     +		return -1;
    @@ -84,7 +84,7 @@
      	if (oid_eq(&common->object.oid, &merge->object.oid)) {
     -		struct strbuf sb = STRBUF_INIT;
     -
    --		if (!o->call_depth && index_has_changes(&sb, head)) {
    +-		if (!o->call_depth && index_has_changes(&the_index, head, &sb)) {
     -			err(o, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
     -			    sb.buf);
     -			return -1;
7:  69f6fe8b1 ! 9:  557c5d94c merge: fix misleading pre-merge check documentation
    @@ -20,7 +20,7 @@
     
             ...the index file must match the tree of `HEAD` commit...
             [NOTE]
    -        This is a bit of a lite.  In certain special cases [explained
    +        This is a bit of a lie.  In certain special cases [explained
             in detail]...
             Otherwise, merge will refuse to do any harm to your repository
             (that is...your working tree...and index are left intact).

-- 
2.18.0.137.g2a11d05a6.dirty
