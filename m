Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1994BC433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 01:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9E9720810
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 01:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDyIJ1wK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgFQBV2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 21:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgFQBV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 21:21:27 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12748C061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 18:21:27 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b6so513413wrs.11
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 18:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=u3LrZ9LaVzwJ1gGHbHFYmOiHNX+5hiDiRqrvbGjMQTA=;
        b=DDyIJ1wKjlIcDEw+TbcJVA12uIx88vh263KOdGFjeFxY2M1bZ0rag7GS6goe6KBzkI
         YmG2ZcIk60jAT6wz4a3FnmVoc4ZHyLkw+RZyTewi0L2MJbRuVk1ji/6VVDWXcSahNgpo
         RGKcNWjOrO1uZYQrm8gKNJcR3ydw+3f31HbzCbqEcNqhgWcc8hgDzNCchqAS/VplC/zM
         0Ke57Aq4FVx87spDF1LL8QKK9N/pM0FPPZnRrlbSpoao73KOyw6mWUQpQxX8yMRX1OnF
         b5qXkHfxjfo89tOTrCgHbPH+HEeCHmW11i9R5ASqK6dbniMQmNicwn1dMuR9uGC3ZXzY
         B4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u3LrZ9LaVzwJ1gGHbHFYmOiHNX+5hiDiRqrvbGjMQTA=;
        b=VJxH5B7t8+qGhr8Y6Wyh+7Anf3kergXrqij1Nkq3GPIbogPCMiSnFNd/SqnyWIxzZG
         mBjwy/2QUDpxPSqbUErDpFxyJzWjAN/RVx4K2A5wSVlqWn9/1MwylRzXwtSwNSS31/rS
         GIw6DGv1pEpJXNwRK7zowjkwF9ezu9BWFYzpuOlUYIApTSE6ODATjIaymlnUpNfdmL/B
         9xQdbcJWhpv2s2SQriuD1hdmNxD3QLv0/wcVgT19ULMQlpUXKwBJbKJgp7Ii4LjAycI7
         6y2KFnriY5pEiRpovkQdQ9907iOjMKqgCTkf2agl6iIS4zAlxDLoIgGJde8b0e8RvA8U
         z5HQ==
X-Gm-Message-State: AOAM531tcdmS1ggyCtWKSWJH8ufwEGVk8vvNR+7T+2+2aLAryjH9ghzr
        i3Q/42C7m6DZE6WnZ1wQtdnWgPIv
X-Google-Smtp-Source: ABdhPJwHBRvsjTWxD0bv3ME4xQ3vmyQW4k+nd1m36bI7fMjt/KOgtZ+UL1AbQk+5Zs0HMJaXdVVfZQ==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr6103289wrv.58.1592356885366;
        Tue, 16 Jun 2020 18:21:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k21sm32582454wrd.24.2020.06.16.18.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 18:21:24 -0700 (PDT)
Message-Id: <pull.809.git.git.1592356884310.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Jun 2020 01:21:24 +0000
Subject: [PATCH] unpack-trees: do not set SKIP_WORKTREE on submodules
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     matheus.bernardino@usp.br, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

As noted in commit e7d7c73249 ("git-sparse-checkout: clarify
interactions with submodules", 2020-06-10), sparse-checkout cannot
remove submodules even if they don't match the sparsity patterns,
because doing so would risk data loss -- unpushed, uncommitted, or
untracked changes could all be lost.  That commit also updated the
documentation to point out that submodule initialization state was a
parallel, orthogonal reason that entries in the index might not be
present in the working tree.

However, sparsity and submodule initialization weren't actually fully
orthogonal yet.  The SKIP_WORKTREE handling in unpack_trees would
attempt to set the SKIP_WORKTREE bit on submodules when the submodule
did not match the sparsity patterns.  This resulted in innocuous but
potentially alarming warning messages:

    warning: unable to rmdir 'sha1collisiondetection': Directory not empty

It could also make things confusing since the entry would be marked as
SKIP_WORKTREE in the index but actually still be present in the working
tree:

    $ git ls-files -t | grep sha1collisiondetection
    S sha1collisiondetection
    $ ls -al sha1collisiondetection/ | wc -l
    13

Submodules have always been their own form of "partial checkout"
behavior, with their own "present or not" state determined by running
"git submodule [init|deinit|update]".  Enforce that separation by having
the SKIP_WORKTREE logic not touch submodules and allow submodules to
continue using their own initialization state for determining if the
submodule is present.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    unpack-trees: do not set SKIP_WORKTREE on submodules
    
    Interactions between submodules and sparsity patterns have come up a few
    times, with a certain edge case coming up multiple times recently:
    should a submodule have the SKIP_WORKTREE bit set if the submodule path
    does not match the sparsity patterns?[1][2][3].
    
    Here I try to resolve the question, with the answer of 'no'.
    
    This patch depends on en/sparse-with-submodule-doc lightly -- the commit
    message in this patch references the commit from that other series. It
    could possibly be considered an addition to that other topic, but
    "sparse-with-submodule-doc" implies the other topic is only a
    documentation change, whereas this patch involves a code change.
    
    [1] 
    https://lore.kernel.org/git/pull.805.git.git.1591831009762.gitgitgadget@gmail.com/
    
    > Since submodules may have unpushed changes or untracked files,
    > removing them could result in data loss. Thus, changing sparse
    > inclusion/exclusion rules will not cause an already checked out
    > submodule to be removed from the working copy. Said another way, just
    > as checkout will not cause submodules to be automatically removed or
    > initialized even when switching between branches that remove or add
    > submodules, using sparse-checkout to reduce or expand the scope of
    > "interesting" files will not cause submodules to be automatically
    > deinitialized or initialized either.
    
    [2] 
    https://lore.kernel.org/git/CABPp-BE+BL3Nq=Co=-kNB_wr=6gqX8zcGwa0ega_pGBpk6xYsg@mail.gmail.com/
    
    > If sparsity patterns would exclude a submodule that is initialized,
    > sparse-checkout clearly can't remove the submodule. However, should it
    > set the SKIP_WORKTREE bit for that submodule if it's not going to
    > remove it?
    
    [3] 
    https://lore.kernel.org/git/CABPp-BFJG7uFAZNidDPK2o7eHv-eYBsmcdnVxkOnKcZo7WzmFQ@mail.gmail.com/
    
    >> Or if you don't deinitialize a submodule that is excluded by the
    >> sparsity patterns (thus remaining in the working copy, anyway).
    >
    > This case requires more thought. If a submodule doesn't match the
    > sparsity patterns, we already said elsewhere that sparse-checkout
    > should not remove the submodule (since doing so would risk data loss).
    > But do we set the SKIP_WORKTREE bit for it? Generally, sparse-checkout
    > avoids removing files with modifications, and if it doesn't remove
    > them it also doesn't set the SKIP_WORKTREE bit. For consistency,
    > should sparse-checkout not set SKIP_WORKTREE for initialized
    > submodules?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-809%2Fnewren%2Fsparse-submodule-no-skip-worktree-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-809/newren/sparse-submodule-no-skip-worktree-v1
Pull-Request: https://github.com/git/git/pull/809

 unpack-trees.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 4be5fc30754..9922522b29d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1524,7 +1524,7 @@ static void mark_new_skip_worktree(struct pattern_list *pl,
 	int i;
 
 	/*
-	 * 1. Pretend the narrowest worktree: only unmerged entries
+	 * 1. Pretend the narrowest worktree: only unmerged files and symlinks
 	 * are checked out
 	 */
 	for (i = 0; i < istate->cache_nr; i++) {
@@ -1533,7 +1533,8 @@ static void mark_new_skip_worktree(struct pattern_list *pl,
 		if (select_flag && !(ce->ce_flags & select_flag))
 			continue;
 
-		if (!ce_stage(ce) && !(ce->ce_flags & CE_CONFLICTED))
+		if (!ce_stage(ce) && !(ce->ce_flags & CE_CONFLICTED) &&
+		    !S_ISGITLINK(ce->ce_mode))
 			ce->ce_flags |= skip_wt_flag;
 		else
 			ce->ce_flags &= ~skip_wt_flag;

base-commit: eebb51ba8cab97c0b3f3f18eaab7796803b8494b
-- 
gitgitgadget
