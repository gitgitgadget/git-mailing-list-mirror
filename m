Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554DDC433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 17:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243491AbiBYRKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 12:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243482AbiBYRKv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 12:10:51 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9647C1688CC
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 09:10:18 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l1-20020a7bcf01000000b0037f881182a8so2080173wmg.2
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 09:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vOmrGxFyxHldpUiqesNZqqOJHHsmeZkHcv0PDy4CREc=;
        b=EeukSZwPqCsz0L9RZ4ZqlhtP89TAtW0mKAbxZtEV4bsae3IP2t8QU3p62C+U8O41zA
         nwD6dIQtLzQyAkqe+9USVT36Gh1FBM95l7w/szXxJTgd6hVwm49AXWw/EW7bvVpQ5xOz
         FL5YJSCfsJ7AoYnsuKEpChC3PWJ3vE33ALrNU39O9N2gac1CRJIsmBXIFzTSraAQovu2
         sW7/OCthR/BFOPfjk5y3tadohPUzMO4rpqE6eWVb03f4Ob4cRGSve5DHB2s/Pn1gq9de
         A0rB3aWOHgm/TXSvoxULgNl0su5mLCicY89rya4A/flw1So2hlBQsqbF4ewg7cenbZiD
         NmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vOmrGxFyxHldpUiqesNZqqOJHHsmeZkHcv0PDy4CREc=;
        b=jGM2U/wE4skHUgU192LONMi8lpVGiMsk5TrtowUBOY/+r8+LfhhP+2ZlsQXmgDdgXm
         ub2mn1sGvJdjCB+/wKZxrS4nkckrM78OHDmc7zEe1bAz/YtzpdPWDFBv6Cn3ICzHcUaS
         1DofZGTy34Ykj4Rg359rq5R3n2HMoAiwrr5lxdUlrpWHzPZRQ0LWAQMQ1JHJ57FvfLjN
         JMbnwP2EJpPRqQLJPXjHkSnIxiY15NTfyynztjPbyvg6ftCgBOU21Lw3J8Eop4TnoU1V
         GAu7YCSBi5ZjMlrxhl+Thu3kxLZT/31AF0a6RHpKQoQtlES+aCdrBrLQILxn3rky4baR
         mdEA==
X-Gm-Message-State: AOAM531kAjt3A+agXtwYlJ9eRSRmwhD16owvqYb0kqmvOUWLG7tPHo6i
        RcuQ3Nb358nmdE9cH++mywyotLeNucM=
X-Google-Smtp-Source: ABdhPJxCKUkcGX5/XlxjbCeSxaU4+gtnpwJak/vLjzuCEsuVRRS7jbBBykVMa97bBLRjI/mSVvFFfA==
X-Received: by 2002:a05:600c:22c9:b0:381:3b27:89be with SMTP id 9-20020a05600c22c900b003813b2789bemr2649959wmg.83.1645809016646;
        Fri, 25 Feb 2022 09:10:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9-20020adfeac9000000b001e68d090023sm2880461wrn.68.2022.02.25.09.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 09:10:16 -0800 (PST)
Message-Id: <pull.986.v2.git.1645809015.gitgitgadget@gmail.com>
In-Reply-To: <pull.986.git.1624559401.gitgitgadget@gmail.com>
References: <pull.986.git.1624559401.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 17:10:11 +0000
Subject: [PATCH v2 0/3] Empty untracked cache performance issue
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset addresses a performance issue with untracked cache. When a new
untracked cache structure is added to the index but remains empty,
subsequent "git status" calls populate it but do not write the index - so
they perform as though the index were disabled.

This situation can be caused in several different ways:

 * Running "git update-index --untracked-cache" on a repo that did not have
   the untracked cache
 * Modifying the git configuration to enable untracked cache, but then
   immediately running "git status -uall", causing the untracked cache to be
   created, but not used/populated (and the index written).
 * (likely others)

The patchset includes fixes to t7519, which otherwise starts failing because
it wasn't testing what it intended to.

Tao Klerks (3):
  t7519: avoid file to index mtime race for untracked cache
  t7519: populate untracked cache before test
  untracked-cache: write index when populating empty untracked cache

 dir.c                       | 10 +++++++---
 t/t7519-status-fsmonitor.sh |  7 +++++++
 2 files changed, 14 insertions(+), 3 deletions(-)


base-commit: 4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-986%2FTaoK%2Ftaok-empty-untracked-cache-bug-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-986/TaoK/taok-empty-untracked-cache-bug-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/986

Range-diff vs v1:

 1:  c4d2a3cab4b ! 1:  9421b71540d Add a second's delay to t7519 for untracked cache
     @@ Metadata
      Author: Tao Klerks <tao@klerks.biz>
      
       ## Commit message ##
     -    Add a second's delay to t7519 for untracked cache
     +    t7519: avoid file to index mtime race for untracked cache
      
          In t7519 there is a test that writes files to disk, and immediately
     -    writes the untracked index. Because of mtime-comparison logic
     -    that uses a 1-second resolution, this means the cached entries
     -    are not trusted/used under some circumstances (see
     -    read-cache.c#is_racy_stat()).
     +    writes the untracked index. Because of mtime-comparison logic that
     +    uses a 1-second resolution, this means the cached entries are not
     +    trusted/used under some circumstances
     +    (see read-cache.c#is_racy_stat()).
      
     -    Untracked cache tests in t7063 use a 1-second delay to avoid
     -    this issue. We should do the same here.
     +    Untracked cache tests in t7063 use a 1-second delay to avoid this
     +    issue, but we don't want to introduce arbitrary slowdowns, so instead
     +    use test-tool chmtime to backdate the files slightly.
      
     -    This change doesn't actually affect the outcome of the test,
     -    but does enhance its validity, and becomes relevant after
     -    later changes
     +    This change doesn't actually affect the outcome of the test, but does
     +    enhance its validity, and becomes relevant after later changes.
      
          Signed-off-by: Tao Klerks <tao@klerks.biz>
      
       ## t/t7519-status-fsmonitor.sh ##
     -@@ t/t7519-status-fsmonitor.sh: clean_repo () {
     - 	git clean -fd
     - }
     - 
     -+avoid_racy() {
     -+	sleep 1
     -+}
     -+
     - dirty_repo () {
     - 	: >untracked &&
     - 	: >dir1/untracked &&
      @@ t/t7519-status-fsmonitor.sh: test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
     + 		cd dot-git &&
     + 		mkdir -p .git/hooks &&
     + 		: >tracked &&
     ++		test-tool chmtime =-60 tracked &&
     + 		: >modified &&
     ++		test-tool chmtime =-60 modified &&
     + 		mkdir dir1 &&
     + 		: >dir1/tracked &&
     ++		test-tool chmtime =-60 dir1/tracked &&
     + 		: >dir1/modified &&
     ++		test-tool chmtime =-60 dir1/modified &&
     + 		mkdir dir2 &&
     + 		: >dir2/tracked &&
     ++		test-tool chmtime =-60 dir2/tracked &&
       		: >dir2/modified &&
     ++		test-tool chmtime =-60 dir2/modified &&
       		write_integration_script &&
       		git config core.fsmonitor .git/hooks/fsmonitor-test &&
     -+		avoid_racy &&
       		git update-index --untracked-cache &&
     - 		git update-index --fsmonitor &&
     - 		GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace-before" \
 2:  d63faad03a4 ! 2:  d29a68e65a0 In t7519, populate untracked cache before test
     @@ Metadata
      Author: Tao Klerks <tao@klerks.biz>
      
       ## Commit message ##
     -    In t7519, populate untracked cache before test
     +    t7519: populate untracked cache before test
      
     -    In its current state, the t7519 test dealing with untracked
     -    cache assumes that
     -    "git update-index --untracked-cache" will *populate*
     -    the untracked cache. This is not correct - it will only add
     -    an empty untracked cache structure to the index.
     +    In its current state, the t7519 test dealing with untracked cache
     +    assumes that "git update-index --untracked-cache" will *populate* the
     +    untracked cache. This is not correct - it will only add an empty
     +    untracked cache structure to the index.
      
     -    If we're going to compare two git status runs with
     -    something interesting happening in-between, we
     -    need to ensure that the index is in a stable/steady
     -    state *before* that first run.
     +    If we're going to compare two git status runs with something
     +    interesting happening in-between, we need to ensure that the index is
     +    in a stable/steady state *before* that first run.
      
     -    We achieve this by adding another prior "git status"
     -    run.
     +    Achieve this by adding another prior "git status" run.
      
     -    At this stage this change does nothing, because there
     -    is a bug, addressed in the next patch. whereby once
     -    the empty untracked cache structure is added by the
     -    update-index invocation, the untracked cache gets
     -    updated in every subsequent "git status" call, but the
     -    index with these updates does not get written down.
     +    At this stage this change does nothing, because there is a bug,
     +    addressed in the next patch, whereby once the empty untracked cache
     +    structure is added by the update-index invocation, the untracked cache
     +    gets updated in every subsequent "git status" call, but the index with
     +    these updates does not get written down.
      
     -    That bug actually invalidates this entire test case -
     -    but we're fixing that next.
     +    That bug actually invalidates this entire test case - but we're fixing
     +    that next.
      
          Signed-off-by: Tao Klerks <tao@klerks.biz>
      
       ## t/t7519-status-fsmonitor.sh ##
      @@ t/t7519-status-fsmonitor.sh: test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
     - 		avoid_racy &&
     + 		git config core.fsmonitor .git/hooks/fsmonitor-test &&
       		git update-index --untracked-cache &&
       		git update-index --fsmonitor &&
      +		git status &&
 3:  627f1952fd8 ! 3:  190b27e518a Write index when populating empty untracked cache
     @@ Metadata
      Author: Tao Klerks <tao@klerks.biz>
      
       ## Commit message ##
     -    Write index when populating empty untracked cache
     +    untracked-cache: write index when populating empty untracked cache
      
     -    It is expected that an empty/unpopulated untracked
     -    cache structure can be written to the index - by update-
     -    index, or by a "git status" call that sees the untracked cache
     -    should be enabled, but is running with options that make
     -    it non-applicable in that run.
     +    It is expected that an empty/unpopulated untracked cache structure can
     +    be written to the index - by update-index, or by a "git status" call
     +    that sees the untracked cache should be enabled and is not, but is
     +    running with options that make the untracked cache non-applicable in
     +    that run (eg a pathspec).
      
     -    Currently, if that happens, then subsequent "git status"
     -    calls end up populating the untracked cache, but not
     -    writing the index (not saving their work) - so the
     -    performance outcome is almost identical to the cache
     -    being altogether disabled.
     +    Currently, if that happens, then subsequent "git status" calls end up
     +    populating the untracked cache, but not writing the index (not saving
     +    their work) - so the performance outcome is almost identical to the
     +    cache being altogether disabled.
      
     -    This continues until the index gets written with the cache
     -    populated, for some *other* reason.
     +    This continues until the index gets written with the untracked cache
     +    populated, for some *other* reason, such as a working tree change.
      
     -    In this change, we detect the "existing cache is empty
     -    and it looks like we are using it" condition, and queues
     -    an index write when this happens.
     +    Detect the condition where an empty untracked cache exists in the
     +    index and we will collect the list of untracked paths, and queue an
     +    index write under that condition, so that the collected untracked
     +    paths can be written out to the untracked cache extension in the
     +    index.
      
     -    This change depends on previous fixes to t7519 for the
     -    "ignore .git changes when invalidating UNTR" test case to
     -    pass - before this fix, the test never actually did anything
     -    as it was not set up correctly.
     +    This change depends on previous fixes to t7519 for the "ignore .git
     +    changes when invalidating UNTR" test case to pass - before this fix,
     +    the test never actually did anything as it was not set up correctly.
      
          Signed-off-by: Tao Klerks <tao@klerks.biz>
      
     @@ dir.c: static struct untracked_cache_dir *validate_untracked_cache(struct dir_st
       
      -	if (!dir->untracked->root)
      +	if (!dir->untracked->root) {
     ++		/* Untracked cache existed but is not initialized; fix that */
       		FLEX_ALLOC_STR(dir->untracked->root, name, "");
     -+		/*
     -+		 * If we've had to initialize the root, then what we had was an
     -+		 * empty uninitialized untracked cache structure. We will be
     -+		 * populating it now, so we should trigger an index write.
     -+		 */
      +		istate->cache_changed |= UNTRACKED_CHANGED;
      +	}
       

-- 
gitgitgadget
