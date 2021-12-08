Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D867C433FE
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 14:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbhLHPBj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 10:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbhLHPBh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 10:01:37 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BCAC0617A1
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 06:58:05 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso4349346wms.3
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 06:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VUmW6BaPqW/VKAJh7qAPXMARtUIzaLoARcdzT0EasME=;
        b=b/+SwZ37GBKOeEEHEXVJ1j9VAW8ExNuYnw44PScFVT0kmHI3DpaAdLU+ntfCGVWuAM
         /PzdC5eUbjdsCtJIUctu+chmdtHMSgyjHAlr0KFaxwr2OC3EjVXVda7d4Ez4m7WKz6AO
         fIBg82f4KsBLzfsNkvuy7sGc5AVqrACan+9lZd0nYTE7WsTIVCmzJISf46aNNwI82V3q
         xYW059QBRMPuQ5pQpEkSNxzQ5deNoHmzrvfm9zydxcsOgndtYCIGfscyFzO7VZByLmRb
         JPO/UBmhQ6rlnrtlHfGu3yLt/kselbPQQhZxokSvfypL9Lgb8Gm3Vz+e+iwx0JncuGjk
         kE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VUmW6BaPqW/VKAJh7qAPXMARtUIzaLoARcdzT0EasME=;
        b=DI7ZS9hv3ObCFYKL5bYzSMy5gzOuaapPzHYk7toxTCHAnKiTZt2rQHevcM4/RZo2Ie
         EIuNbh216vMN/8xbJsNB9kKRV16h/o0W125qcGPcxRYEPxLN3yz3CJcR4PVNuxNJMvyE
         dWPmawIGD3KVEQb7QXhuyRGrjObE4gNaxYZyMcrl9/iJBS0ZgGaFk+2kEmVcUmiCScjN
         d+Z6n4/ity9Tr0joAteqABUmlV+TozPPLccurlYl0VDCz6N21XbPAD4CEloCg/KtgRee
         PTgQMpB0OyqEZbp/TzCj79RbFQO31iGF6TuZtR5A140F3nyFHSajHvzT+T+ouz5EhaY8
         R0bA==
X-Gm-Message-State: AOAM532nProiOAiF+dtVSXEAPVipT/fN5p9lywbeTgsY6iZ63sglbIRL
        cKsNR80WAv1G8OMNfWkhR0eTXb0vQEc=
X-Google-Smtp-Source: ABdhPJytV2JHts7SNm92YX4fBdlFq9BNA0VCJH4TYWbw1Inf9VPC3y9zV6dFdXGbmWMAr3aQkzlFAA==
X-Received: by 2002:a05:600c:1914:: with SMTP id j20mr16750373wmq.26.1638975483305;
        Wed, 08 Dec 2021 06:58:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v2sm2724107wmc.36.2021.12.08.06.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 06:58:02 -0800 (PST)
Message-Id: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 14:57:47 +0000
Subject: [PATCH v2 00/14] rebase: reset_head() related fixes and improvements
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the comments on V1. I have tried to improve the commit messages
to explain better the motivation and implications of the changes in this
series and I have added some more tests. I have rebased onto v2.34.0 to
avoid some merges conflicts.

Changes since V1:

 * Patch 1 - unchanged.
 * Patches 2, 3 - these are new and fix an bug I noticed while adding a test
   to patch 4.
 * Patches 4, 5 - improved commit messages and added tests.
 * Patch 6 - reworded commit message.
 * Patch 7 - split out some changes that used to be in patch 9.
 * Patch 8 - in principle the same but the range-diff is noisy due to the
   addition of patch 3.
 * Patch 9 - reworded commit message.
 * Patch 10 - unchanged.
 * Patch 11 - reworded commit message and a couple of comments.
 * Patch 12 - minor changes to comments.
 * Patch 13 - cosmetic changes to commit message and tests.
 * Patch 14 - cosmetic changes to commit message.

Cover letter for V1: Fix some issues with the implementation and use of
reset_head(). The last patch was previously posted as [1], I have updated
the commit message and rebased it onto the fixes in this series. There are a
couple of small conflicts merging this into seen, I think they should be
easy to resolve (in rebase.c take both sides in reset.c take the changed
lines from each side). These patches are based on pw/rebase-of-a-tag-fix

[1]
https://lore.kernel.org/git/39ad40c9297531a2d42b7263a1d41b1ecbc23c0a.1631108472.git.gitgitgadget@gmail.com/

Phillip Wood (14):
  rebase: factor out checkout for up to date branch
  t5403: refactor rebase post-checkout hook tests
  rebase: pass correct arguments to post-checkout hook
  rebase: do not remove untracked files on checkout
  rebase --apply: don't run post-checkout hook if there is an error
  reset_head(): remove action parameter
  create_autostash(): remove unneeded parameter
  reset_head(): factor out ref updates
  reset_head(): make default_reflog_action optional
  rebase: cleanup reset_head() calls
  reset_head(): take struct rebase_head_opts
  rebase --apply: fix reflog
  rebase --apply: set ORIG_HEAD correctly
  rebase -m: don't fork git checkout

 builtin/merge.c               |   6 +-
 builtin/rebase.c              | 101 +++++++++++++----------
 reset.c                       | 149 ++++++++++++++++++++--------------
 reset.h                       |  48 ++++++++++-
 sequencer.c                   |  47 ++++-------
 sequencer.h                   |   3 +-
 t/t3406-rebase-message.sh     |  23 ++++++
 t/t3418-rebase-continue.sh    |  26 ++++++
 t/t5403-post-checkout-hook.sh |  67 +++++++++++----
 9 files changed, 312 insertions(+), 158 deletions(-)


base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1049%2Fphillipwood%2Fwip%2Frebase-reset-head-fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1049/phillipwood/wip/rebase-reset-head-fixes-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1049

Range-diff vs v1:

  1:  4d3441c2b25 =  1:  0e84d00572e rebase: factor out checkout for up to date branch
  -:  ----------- >  2:  a67a5a03b94 t5403: refactor rebase post-checkout hook tests
  -:  ----------- >  3:  07867760e68 rebase: pass correct arguments to post-checkout hook
  2:  c8f64113216 !  4:  2b499704c8f reset_head(): fix checkout
     @@ Metadata
      Author: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## Commit message ##
     -    reset_head(): fix checkout
     +    rebase: do not remove untracked files on checkout
      
     -    The reset bit should only be set if flags contains RESET_HEAD_HARD.
     -    The test for `!deatch_head` dates back to the original implementation
     -    of reset_head() in ac7f467fef ("builtin/rebase: support running "git
     -    rebase <upstream>"", 2018-08-07) and was correct until e65123a71d
     +    If "git rebase [--apply|--merge] <upstream> <branch>" detects that
     +    <upstream> is an ancestor of <branch> then it will fast-forward and
     +    checkout <branch>. Normally a checkout or picking a commit during a
     +    rebase will refuse to overwrite untracked files, however rebase does
     +    overwrite untracked files when checking <branch>.
     +
     +    The fix is to only set reset in `unpack_tree_opts` if flags contains
     +    `RESET_HEAD_HARD`. t5403 may seem like an odd home for the new test
     +    but it will be extended in the next commit to check that the
     +    post-checkout hook is not run when the checkout fails.
     +
     +    The test for `!deatch_head` dates back to the
     +    original implementation of reset_head() in
     +    ac7f467fef ("builtin/rebase: support running "git rebase <upstream>"",
     +    2018-08-07) and was correct until e65123a71d
          ("builtin rebase: support `git rebase <upstream> <switch-to>`",
          2018-09-04) started using reset_head() to checkout <switch-to> when
          fast-forwarding.
      
     +    Note that 480d3d6bf9 ("Change unpack_trees' 'reset' flag into an
     +    enum", 2021-09-27) also fixes this bug as it changes reset_head() to
     +    never remove untracked files. I think this fix is still worthwhile as
     +    it makes it clear that the same settings are used for detached and
     +    non-detached checkouts.
     +
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## reset.c ##
      @@ reset.c: int reset_head(struct repository *r, struct object_id *oid, const char *action,
     - 	unpack_tree_opts.update = 1;
       	unpack_tree_opts.merge = 1;
     + 	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
       	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
      -	if (!detach_head)
      +	if (reset_hard)
     - 		unpack_tree_opts.reset = 1;
     + 		unpack_tree_opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
       
       	if (repo_read_index_unmerged(r) < 0) {
     +
     + ## t/t5403-post-checkout-hook.sh ##
     +@@ t/t5403-post-checkout-hook.sh: test_rebase () {
     + 		test_cmp_rev three $new &&
     + 		test $flag = 1
     + 	'
     ++
     ++	test_expect_success "rebase $args checkout does not remove untracked files" '
     ++		test_when_finished "test_might_fail git rebase --abort" &&
     ++		git update-ref refs/heads/rebase-fast-forward three &&
     ++		git checkout two &&
     ++		echo untracked >three.t &&
     ++		test_when_finished "rm three.t" &&
     ++		test_must_fail git rebase $args HEAD rebase-fast-forward 2>err &&
     ++		grep "untracked working tree files would be overwritten by checkout" err
     ++'
     + }
     + 
     + test_rebase --apply &&
  3:  28872cbca68 !  5:  04e7340a7e7 reset_head(): don't run checkout hook if there is an error
     @@ Metadata
      Author: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## Commit message ##
     -    reset_head(): don't run checkout hook if there is an error
     +    rebase --apply: don't run post-checkout hook if there is an error
      
          The hook should only be run if the worktree and refs were successfully
     -    updated.
     +    updated. This primarily affects "rebase --apply" but also "rebase
     +    --merge" when it fast-forwards.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     @@ reset.c: reset_head_refs:
      -	if (run_hook)
      +	if (!ret && run_hook)
       		run_hook_le(NULL, "post-checkout",
     - 			    oid_to_hex(orig ? orig : null_oid()),
     + 			    oid_to_hex(head ? head : null_oid()),
       			    oid_to_hex(oid), "1", NULL);
     +
     + ## t/t5403-post-checkout-hook.sh ##
     +@@ t/t5403-post-checkout-hook.sh: test_rebase () {
     + 
     + 	test_expect_success "rebase $args checkout does not remove untracked files" '
     + 		test_when_finished "test_might_fail git rebase --abort" &&
     ++		test_when_finished "rm -f .git/post-checkout.args" &&
     + 		git update-ref refs/heads/rebase-fast-forward three &&
     + 		git checkout two &&
     ++		rm -f .git/post-checkout.args &&
     + 		echo untracked >three.t &&
     + 		test_when_finished "rm three.t" &&
     + 		test_must_fail git rebase $args HEAD rebase-fast-forward 2>err &&
     +-		grep "untracked working tree files would be overwritten by checkout" err
     ++		grep "untracked working tree files would be overwritten by checkout" err &&
     ++		test_path_is_missing .git/post-checkout.args
     ++
     + '
     + }
     + 
  4:  fbaf64d6b28 !  6:  32ffa98c1bc reset_head(): remove action parameter
     @@ Metadata
       ## Commit message ##
          reset_head(): remove action parameter
      
     -    The action parameter is passed as the command name to
     -    setup_unpack_trees_porcelain(). All but two cases pass either
     -    "checkout" or "reset". The case that passes "reset --hard" should be
     -    passing "reset" instead. The case that passes "Fast-forwarded" is only
     -    updating HEAD and so does not call unpack_trees(). The value can be
     -    determined by checking whether flags contains RESET_HEAD_HARD so it
     -    does not need to be specified by the caller.
     +    The only use of the action parameter is to setup the error messages
     +    for unpack_trees(). All but two cases pass either "checkout" or
     +    "reset". The case that passes "reset --hard" would be better passing
     +    "reset" so that the error messages match the builtin reset command
     +    like all the other callers that are doing a reset. The case that
     +    passes "Fast-forwarded" is only updating HEAD and so the parameter is
     +    unused in that case as it does not call unpack_trees(). The value to
     +    pass to setup_unpack_trees_porcelain() can be determined by checking
     +    whether flags contains RESET_HEAD_HARD without the caller having to
     +    specify it.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     @@ reset.c: int reset_head(struct repository *r, struct object_id *oid, const char
      +	const char *action, *reflog_action;
       	struct strbuf msg = STRBUF_INIT;
       	size_t prefix_len;
     - 	struct object_id *orig = NULL, oid_orig,
     + 	struct object_id *old_orig = NULL, oid_old_orig;
      @@ reset.c: int reset_head(struct repository *r, struct object_id *oid, const char *action,
       	if (refs_only)
       		goto reset_head_refs;
  -:  ----------- >  7:  341fe183c18 create_autostash(): remove unneeded parameter
  5:  0744c3d143b !  8:  29e06e7d36d reset_head(): factor out ref updates
     @@ Metadata
       ## Commit message ##
          reset_head(): factor out ref updates
      
     -    In the next commit we will stop trying to update HEAD when we are just
     -    clearing changes from the working tree. Move the code that updates the
     -    refs to its own function in preparation for that.
     +    In the next commit we will stop trying to update HEAD when we are
     +    removing uncommitted changes from the working tree. Move the code that
     +    updates the refs to its own function in preparation for that.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     @@ reset.c
       #include "unpack-trees.h"
       
      +static int update_refs(const struct object_id *oid, const char *switch_to_branch,
     -+		       const char *reflog_head, const char *reflog_orig_head,
     ++		       const struct object_id *head, const char *reflog_head,
     ++		       const char *reflog_orig_head,
      +		       const char *default_reflog_action, unsigned flags)
      +{
      +	unsigned detach_head = flags & RESET_HEAD_DETACH;
      +	unsigned run_hook = flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
      +	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
     -+	struct object_id *orig = NULL, oid_orig, *old_orig = NULL, oid_old_orig;
     ++	struct object_id *old_orig = NULL, oid_old_orig;
      +	struct strbuf msg = STRBUF_INIT;
      +	const char *reflog_action;
      +	size_t prefix_len;
     @@ reset.c
      +	if (update_orig_head) {
      +		if (!get_oid("ORIG_HEAD", &oid_old_orig))
      +			old_orig = &oid_old_orig;
     -+		if (!get_oid("HEAD", &oid_orig)) {
     -+			orig = &oid_orig;
     ++		if (head) {
      +			if (!reflog_orig_head) {
      +				strbuf_addstr(&msg, "updating ORIG_HEAD");
      +				reflog_orig_head = msg.buf;
      +			}
     -+			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
     ++			update_ref(reflog_orig_head, "ORIG_HEAD", head,
      +				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
      +		} else if (old_orig)
      +			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
     @@ reset.c
      +		reflog_head = msg.buf;
      +	}
      +	if (!switch_to_branch)
     -+		ret = update_ref(reflog_head, "HEAD", oid, orig,
     ++		ret = update_ref(reflog_head, "HEAD", oid, head,
      +				 detach_head ? REF_NO_DEREF : 0,
      +				 UPDATE_REFS_MSG_ON_ERR);
      +	else {
     @@ reset.c
      +	}
      +	if (!ret && run_hook)
      +		run_hook_le(NULL, "post-checkout",
     -+			    oid_to_hex(orig ? orig : null_oid()),
     ++			    oid_to_hex(head ? head : null_oid()),
      +			    oid_to_hex(oid), "1", NULL);
      +	strbuf_release(&msg);
      +	return ret;
     @@ reset.c
      -	unsigned run_hook = flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
       	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
      -	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
     - 	struct object_id head_oid;
     + 	struct object_id *head = NULL, head_oid;
       	struct tree_desc desc[2] = { { NULL }, { NULL } };
       	struct lock_file lock = LOCK_INIT;
       	struct unpack_trees_options unpack_tree_opts = { 0 };
     @@ reset.c
      -	const char *action, *reflog_action;
      -	struct strbuf msg = STRBUF_INIT;
      -	size_t prefix_len;
     --	struct object_id *orig = NULL, oid_orig,
     --		*old_orig = NULL, oid_old_orig;
     +-	struct object_id *old_orig = NULL, oid_old_orig;
      +	const char *action;
       	int ret = 0, nr = 0;
       
     @@ reset.c: int reset_head(struct repository *r, struct object_id *oid,
       
       	if (refs_only)
      -		goto reset_head_refs;
     -+		return update_refs(oid, switch_to_branch, reflog_head,
     ++		return update_refs(oid, switch_to_branch, head, reflog_head,
      +				   reflog_orig_head, default_reflog_action,
      +				   flags);
       
     @@ reset.c: int reset_head(struct repository *r, struct object_id *oid,
      -	if (update_orig_head) {
      -		if (!get_oid("ORIG_HEAD", &oid_old_orig))
      -			old_orig = &oid_old_orig;
     --		if (!get_oid("HEAD", &oid_orig)) {
     --			orig = &oid_orig;
     +-		if (head) {
      -			if (!reflog_orig_head) {
      -				strbuf_addstr(&msg, "updating ORIG_HEAD");
      -				reflog_orig_head = msg.buf;
      -			}
     --			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
     +-			update_ref(reflog_orig_head, "ORIG_HEAD", head,
      -				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
      -		} else if (old_orig)
      -			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
     @@ reset.c: int reset_head(struct repository *r, struct object_id *oid,
      -		reflog_head = msg.buf;
      -	}
      -	if (!switch_to_branch)
     --		ret = update_ref(reflog_head, "HEAD", oid, orig,
     +-		ret = update_ref(reflog_head, "HEAD", oid, head,
      -				 detach_head ? REF_NO_DEREF : 0,
      -				 UPDATE_REFS_MSG_ON_ERR);
      -	else {
     @@ reset.c: int reset_head(struct repository *r, struct object_id *oid,
      -	}
      -	if (!ret && run_hook)
      -		run_hook_le(NULL, "post-checkout",
     --			    oid_to_hex(orig ? orig : null_oid()),
     +-			    oid_to_hex(head ? head : null_oid()),
      -			    oid_to_hex(oid), "1", NULL);
     -+	ret = update_refs(oid, switch_to_branch, reflog_head, reflog_orig_head,
     -+			  default_reflog_action, flags);
     ++	ret = update_refs(oid, switch_to_branch, head, reflog_head,
     ++			  reflog_orig_head, default_reflog_action, flags);
       
       leave_reset_head:
      -	strbuf_release(&msg);
  6:  4503defe591 !  9:  9d00a218daf reset_head(): make default_reflog_action optional
     @@ Commit message
      
          This parameter is only needed when a ref is going to be updated and
          the caller does not pass an explicit reflog message. Callers that are
     -    just discarding changes in the working tree like create_autostash() do
     -    not update any refs so should not have to worry about passing this
     -    parameter.
     +    only discarding uncommitted changes in the working tree such as such
     +    as "rebase --skip" or create_autostash() do not update any refs so
     +    should not have to worry about passing this parameter.
      
     -    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     +    This change is not intended to have any user visible changes. The
     +    pointer comparison between `oid` and `&head_oid` checks that the
     +    caller did not pass an oid to be checked out. As no callers pass
     +    RESET_HEAD_RUN_POST_CHECKOUT_HOOK without passing an oid there are
     +    no changes to when the post-checkout hook is run. As update_ref() only
     +    updates the ref if the oid passed to it differs from the current ref
     +    there are no changes to when HEAD is updated.
      
     - ## builtin/merge.c ##
     -@@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
     - 
     - 		if (autostash)
     - 			create_autostash(the_repository,
     --					 git_path_merge_autostash(the_repository),
     --					 "merge");
     -+					 git_path_merge_autostash(the_repository));
     - 		if (checkout_fast_forward(the_repository,
     - 					  &head_commit->object.oid,
     - 					  &commit->object.oid,
     -@@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
     - 
     - 	if (autostash)
     - 		create_autostash(the_repository,
     --				 git_path_merge_autostash(the_repository),
     --				 "merge");
     -+				 git_path_merge_autostash(the_repository));
     - 
     - 	/* We are going to make a new commit. */
     - 	git_committer_info(IDENT_STRICT);
     +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## builtin/rebase.c ##
      @@ builtin/rebase.c: static int move_to_original_branch(struct rebase_options *opts)
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       			die(_("could not discard worktree changes"));
       		remove_branch_state(the_repository, 0);
       		if (read_basic_state(&options))
     -@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     - 		die(_("could not read index"));
     - 
     - 	if (options.autostash) {
     --		create_autostash(the_repository, state_dir_path("autostash", &options),
     --				 DEFAULT_REFLOG_ACTION);
     -+		create_autostash(the_repository,
     -+				 state_dir_path("autostash", &options));
     - 	}
     - 
     - 	if (require_clean_work_tree(the_repository, "rebase",
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
       			options.head_name ? options.head_name : "detached HEAD",
       			oid_to_hex(&options.onto->object.oid));
     @@ reset.c: int reset_head(struct repository *r, struct object_id *oid,
       	unsigned reset_hard = flags & RESET_HEAD_HARD;
       	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
      +	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
     - 	struct object_id head_oid;
     + 	struct object_id *head = NULL, head_oid;
       	struct tree_desc desc[2] = { { NULL }, { NULL } };
       	struct lock_file lock = LOCK_INIT;
      @@ reset.c: int reset_head(struct repository *r, struct object_id *oid,
       		goto leave_reset_head;
       	}
       
     --	ret = update_refs(oid, switch_to_branch, reflog_head, reflog_orig_head,
     --			  default_reflog_action, flags);
     +-	ret = update_refs(oid, switch_to_branch, head, reflog_head,
     +-			  reflog_orig_head, default_reflog_action, flags);
      +	if (oid != &head_oid || update_orig_head || switch_to_branch)
     -+		ret = update_refs(oid, switch_to_branch, reflog_head,
     ++		ret = update_refs(oid, switch_to_branch, head, reflog_head,
      +				  reflog_orig_head, default_reflog_action,
      +				  flags);
       
     @@ reset.c: int reset_head(struct repository *r, struct object_id *oid,
       	rollback_lock_file(&lock);
      
       ## sequencer.c ##
     -@@ sequencer.c: static enum todo_command peek_command(struct todo_list *todo_list, int offset)
     - 	return -1;
     - }
     - 
     --void create_autostash(struct repository *r, const char *path,
     --		      const char *default_reflog_action)
     -+void create_autostash(struct repository *r, const char *path)
     -+
     - {
     - 	struct strbuf buf = STRBUF_INIT;
     - 	struct lock_file lock_file = LOCK_INIT;
     -@@ sequencer.c: void create_autostash(struct repository *r, const char *path,
     +@@ sequencer.c: void create_autostash(struct repository *r, const char *path)
       		write_file(path, "%s", oid_to_hex(&oid));
       		printf(_("Created autostash: %s\n"), buf.buf);
       		if (reset_head(r, NULL, NULL, RESET_HEAD_HARD, NULL, NULL,
     --			       default_reflog_action) < 0)
     +-			       "") < 0)
      +			       NULL) < 0)
       			die(_("could not reset --hard"));
       
       		if (discard_index(r->index) < 0 ||
     -
     - ## sequencer.h ##
     -@@ sequencer.h: void commit_post_rewrite(struct repository *r,
     - 			 const struct commit *current_head,
     - 			 const struct object_id *new_head);
     - 
     --void create_autostash(struct repository *r, const char *path,
     --		      const char *default_reflog_action);
     -+void create_autostash(struct repository *r, const char *path);
     - int save_autostash(const char *path);
     - int apply_autostash(const char *path);
     - int apply_autostash_oid(const char *stash_oid);
  7:  5ffc7e64ff1 = 10:  5ea636009e7 rebase: cleanup reset_head() calls
  8:  267e074e6db ! 11:  24b0566aba5 reset_head(): take struct rebase_head_opts
     @@ Metadata
       ## Commit message ##
          reset_head(): take struct rebase_head_opts
      
     -    This function already takes a confusingly large number of parameters
     -    some of which are optional or not always required. The following
     -    commits will add a couple more parameters so change it to take a
     -    struct of options first.
     +    This function takes a confusingly large number of parameters which
     +    makes it difficult to remember which order to pass them in. The
     +    following commits will add a couple more parameters which makes the
     +    problem worse. To address this change the function to take a struct of
     +    options. Using a struct means that it is no longer necessary to
     +    remember which order to pass the parameters in and anyone reading the
     +    code can easily see which value is passed to each parameter.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## builtin/rebase.c ##
     -@@ builtin/rebase.c: static void add_var(struct strbuf *buf, const char *name, const char *value)
     +@@ builtin/rebase.c: static int finish_rebase(struct rebase_options *opts)
       static int move_to_original_branch(struct rebase_options *opts)
       {
       	struct strbuf orig_head_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
     @@ builtin/rebase.c: static int rebase_config(const char *var, const char *value, v
       	strbuf_release(&buf);
       
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     - 	char *squash_onto_name = NULL;
       	int reschedule_failed_exec = -1;
       	int allow_preemptive_ff = 1;
     + 	int preserve_merges_selected = 0;
      +	struct reset_head_opts ropts = { 0 };
       	struct option builtin_rebase_options[] = {
       		OPT_STRING(0, "onto", &options.onto_name,
     @@ reset.c
       #include "unpack-trees.h"
       
      -static int update_refs(const struct object_id *oid, const char *switch_to_branch,
     --		       const char *reflog_head, const char *reflog_orig_head,
     +-		       const struct object_id *head, const char *reflog_head,
     +-		       const char *reflog_orig_head,
      -		       const char *default_reflog_action, unsigned flags)
      +static int update_refs(const struct reset_head_opts *opts,
     -+		       const struct object_id *oid)
     ++		       const struct object_id *oid,
     ++		       const struct object_id *head)
       {
      -	unsigned detach_head = flags & RESET_HEAD_DETACH;
      -	unsigned run_hook = flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
     @@ reset.c
      +	const char *reflog_head = opts->head_msg;
      +	const char *reflog_orig_head = opts->orig_head_msg;
      +	const char *default_reflog_action = opts->default_reflog_action;
     - 	struct object_id *orig = NULL, oid_orig, *old_orig = NULL, oid_old_orig;
     + 	struct object_id *old_orig = NULL, oid_old_orig;
       	struct strbuf msg = STRBUF_INIT;
       	const char *reflog_action;
      @@ reset.c: static int update_refs(const struct object_id *oid, const char *switch_to_branch
     @@ reset.c: static int update_refs(const struct object_id *oid, const char *switch_
      +	unsigned reset_hard = opts->flags & RESET_HEAD_HARD;
      +	unsigned refs_only = opts->flags & RESET_HEAD_REFS_ONLY;
      +	unsigned update_orig_head = opts->flags & RESET_ORIG_HEAD;
     - 	struct object_id head_oid;
     + 	struct object_id *head = NULL, head_oid;
       	struct tree_desc desc[2] = { { NULL }, { NULL } };
       	struct lock_file lock = LOCK_INIT;
      @@ reset.c: int reset_head(struct repository *r, struct object_id *oid,
       		oid = &head_oid;
       
       	if (refs_only)
     --		return update_refs(oid, switch_to_branch, reflog_head,
     +-		return update_refs(oid, switch_to_branch, head, reflog_head,
      -				   reflog_orig_head, default_reflog_action,
      -				   flags);
     -+		return update_refs(opts, oid);
     ++		return update_refs(opts, oid, head);
       
       	action = reset_hard ? "reset" : "checkout";
       	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
     @@ reset.c: int reset_head(struct repository *r, struct object_id *oid,
       	}
       
       	if (oid != &head_oid || update_orig_head || switch_to_branch)
     --		ret = update_refs(oid, switch_to_branch, reflog_head,
     +-		ret = update_refs(oid, switch_to_branch, head, reflog_head,
      -				  reflog_orig_head, default_reflog_action,
      -				  flags);
     -+		ret = update_refs(opts, oid);
     ++		ret = update_refs(opts, oid, head);
       
       leave_reset_head:
       	rollback_lock_file(&lock);
      
       ## reset.h ##
      @@
     + 
     + #define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
     + 
     ++/* Request a detached checkout */
     + #define RESET_HEAD_DETACH (1<<0)
     ++/* Request a reset rather than a checkout */
     + #define RESET_HEAD_HARD (1<<1)
     ++/* Run the post-checkout hook */
     + #define RESET_HEAD_RUN_POST_CHECKOUT_HOOK (1<<2)
     ++/* Only update refs, do not touch the worktree */
       #define RESET_HEAD_REFS_ONLY (1<<3)
     ++/* Update ORIG_HEAD as well as HEAD */
       #define RESET_ORIG_HEAD (1<<4)
       
      -int reset_head(struct repository *r, struct object_id *oid,
     @@ reset.h
      -	       const char *reflog_orig_head, const char *reflog_head,
      -	       const char *default_reflog_action);
      +struct reset_head_opts {
     -+	/* The oid of the commit to checkout/reset to. Defaults to HEAD */
     ++	/*
     ++	 * The commit to checkout/reset to. Defaults to HEAD.
     ++	 */
      +	const struct object_id *oid;
     -+	 /* Optional branch to switch to */
     ++	/*
     ++	 * Optional branch to switch to.
     ++	 */
      +	const char *branch;
     -+	/* Flags defined above */
     ++	/*
     ++	 * Flags defined above.
     ++	 */
      +	unsigned flags;
     -+	 /*
     -+	  * Optional reflog message for HEAD, if this is not set then
     -+	  * default_reflog_action must be.
     -+	  */
     ++	/*
     ++	 * Optional reflog message for HEAD, if this omitted but oid or branch
     ++	 * are given then default_reflog_action must be given.
     ++	 */
      +	const char *head_msg;
      +	/*
     -+	 * Optional reflog message for ORIG_HEAD, if this is not set and flags
     -+	 * contains RESET_ORIG_HEAD then default_reflog_action must be set.
     ++	 * Optional reflog message for ORIG_HEAD, if this omitted and flags
     ++	 * contains RESET_ORIG_HEAD then default_reflog_action must be given.
      +	 */
      +	const char *orig_head_msg;
      +	/*
  9:  cdb0de221d5 ! 12:  dc5d11291e7 rebase --apply: fix reflog
     @@ Commit message
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## builtin/rebase.c ##
     -@@ builtin/rebase.c: static void add_var(struct strbuf *buf, const char *name, const char *value)
     +@@ builtin/rebase.c: static int finish_rebase(struct rebase_options *opts)
       
       static int move_to_original_branch(struct rebase_options *opts)
       {
     @@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts
      
       ## reset.h ##
      @@ reset.h: struct reset_head_opts {
     - 	const char *branch;
     - 	/* Flags defined above */
     + 	 * Flags defined above.
     + 	 */
       	unsigned flags;
     -+	 /* Optional reflog message for branch, defaults to head_msg. */
     ++	/*
     ++	 * Optional reflog message for branch, defaults to head_msg.
     ++	 */
      +	const char *branch_msg;
     - 	 /*
     - 	  * Optional reflog message for HEAD, if this is not set then
     - 	  * default_reflog_action must be.
     + 	/*
     + 	 * Optional reflog message for HEAD, if this omitted but oid or branch
     + 	 * are given then default_reflog_action must be given.
      
       ## t/t3406-rebase-message.sh ##
      @@ t/t3406-rebase-message.sh: test_expect_success 'GIT_REFLOG_ACTION' '
 10:  e8884efcc83 ! 13:  45a5b5e9818 rebase --apply: set ORIG_HEAD correctly
     @@ Commit message
          At the start of a rebase ORIG_HEAD is updated to tip of the branch
          being rebased. Unfortunately reset_head() always uses the current
          value of HEAD for this which is incorrect if the rebase is started
     -    with 'git rebase <upstream> <branch>' as in that case ORIG_HEAD should
     +    with "git rebase <upstream> <branch>" as in that case ORIG_HEAD should
          be updated to <branch>. This only affects the "apply" backend as the
          "merge" backend does not yet use reset_head() for the initial
          checkout. Fix this by passing in orig_head when calling reset_head()
     @@ reset.c: static int update_refs(const struct reset_head_opts *opts,
       				strbuf_addstr(&msg, "updating ORIG_HEAD");
       				reflog_orig_head = msg.buf;
       			}
     --			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
     +-			update_ref(reflog_orig_head, "ORIG_HEAD", head,
      +			update_ref(reflog_orig_head, "ORIG_HEAD",
     -+				   orig_head ? orig_head : orig,
     ++				   orig_head ? orig_head : head,
       				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
       		} else if (old_orig)
       			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
      
       ## reset.h ##
     -@@
     - struct reset_head_opts {
     - 	/* The oid of the commit to checkout/reset to. Defaults to HEAD */
     +@@ reset.h: struct reset_head_opts {
     + 	 * The commit to checkout/reset to. Defaults to HEAD.
     + 	 */
       	const struct object_id *oid;
     -+	/* Optional commit when setting ORIG_HEAD. Defaults to HEAD */
     ++	/*
     ++	 * Optional value to set ORIG_HEAD. Defaults to HEAD.
     ++	 */
      +	const struct object_id *orig_head;
     - 	 /* Optional branch to switch to */
     - 	const char *branch;
     - 	/* Flags defined above */
     + 	/*
     + 	 * Optional branch to switch to.
     + 	 */
      
       ## t/t3418-rebase-continue.sh ##
      @@ t/t3418-rebase-continue.sh: test_expect_success 'there is no --no-reschedule-failed-exec in an ongoing rebas
       	test_expect_code 129 git rebase --edit-todo --no-reschedule-failed-exec
       '
       
     -+test_orig_head_helper() {
     ++test_orig_head_helper () {
      +	test_when_finished 'git rebase --abort &&
      +		git checkout topic &&
      +		git reset --hard commit-new-file-F2-on-topic-branch' &&
     @@ t/t3418-rebase-continue.sh: test_expect_success 'there is no --no-reschedule-fai
      +	test_cmp_rev ORIG_HEAD commit-new-file-F2-on-topic-branch
      +}
      +
     -+test_orig_head() {
     ++test_orig_head () {
      +	type=$1
      +	test_expect_success "rebase $type sets ORIG_HEAD correctly" '
      +		git checkout topic &&
 11:  2c8c60c3f31 ! 14:  3f64b9274b5 rebase -m: don't fork git checkout
     @@ Commit message
          rebase -m: don't fork git checkout
      
          Now that reset_head() can handle the initial checkout of onto
     -    correctly use it in the "merge" backend instead of forking 'git
     -    checkout'.  This opens the way for us to stop calling the
     -    post-checkout hook in the future. Not running 'git checkout' means
     -    that 'rebase -i/m' no longer recurse submodules when checking out
     -    'onto' (thanks to Philippe Blain for pointing this out). As the rest
     +    correctly use it in the "merge" backend instead of forking "git
     +    checkout".  This opens the way for us to stop calling the
     +    post-checkout hook in the future. Not running "git checkout" means
     +    that "rebase -i/m" no longer recurse submodules when checking out
     +    "onto" (thanks to Philippe Blain for pointing this out). As the rest
          of rebase does not know what to do with submodules this is probably a
          good thing. When using merge-ort rebase ought be able to handle
          submodules correctly if it parsed the submodule config, such a change

-- 
gitgitgadget
