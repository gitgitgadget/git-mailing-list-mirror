Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1B1C19F2A
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 04:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiHGEN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Aug 2022 00:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiHGEN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Aug 2022 00:13:56 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26B8B482
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 21:13:54 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 17so5873662plj.10
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 21:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CzP8VEjLY372GNgcO+FrZKq+JJs8rB0kWaTKY2FuWV0=;
        b=WSnsCiv5iPK79ZLD90ZGF8XM1lMJWkZwh9iAW/OYHJ8lsrY1kZpQtvs+aGxYKvXikX
         x/Fs/UNaaI7FMuMHED7SxwMo3FAJO78VPHPpeGBkNr6AelFkih7glRKhFMb1BV/8lHXw
         F1KYJkT+gafngSUuIlN3XH7SP/NvUABh5eXVhGJseVE7PvgIwEvuh5v7gUj7Y6LsBSsx
         bMEtA64BVdVMc+ovIrvMKyFJZty1mP1gjNxjRIczefoaFdL9px6Uym1BoSdt98tDfOYQ
         HhBpAV3RU4gBRHhP4CIaD9bV5+o/Eb5RqF5beMLVtOxbBtoxMjTLqVFSJRg/yD2RU5KZ
         u8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CzP8VEjLY372GNgcO+FrZKq+JJs8rB0kWaTKY2FuWV0=;
        b=TuNBCyCsTxWduSMcMTMVI3U/ALQCHgonHNsKIY8t/iQjnKWSHDuQ39cJaMGHdj1uhA
         5/UIRChP59M03onoF0T6dNaWmA6nnUOfabcq7jcbNOcanVzQxW3LGxNWtjDKLSa1FGqy
         BZXuJwVn8JeGskuRDGtmGSxAILDJWZsDZpTVTfyIAXonQZLmrWdA5IonY0CkuGISUmAd
         4MEsT/ALh283nVWuD8qLiRHrZznwjeaTi+tH9cMZYnGcNskk17swVKn38SdQ7ml1+s4C
         K8pXt1r0jumsaFl2k2DXLtaVrvxDZDpnLWtqHj6sInLIHNDvBCrbG8xuE8CFoigbFqXt
         xZNw==
X-Gm-Message-State: ACgBeo2mMGYL/HZIlPiEFJb6disWDQYUtmYSEDCSOAhUITatHLC+PnM0
        HZufa+iGwgbSuYwXCrxPJmNQrL/bLaW9Mg==
X-Google-Smtp-Source: AA6agR4nrAwy2/hYD56acTQf4kmU5yVVpG+CVm5SJt+hW5Zqp+UrjarmKRtTvCGVnma8onFN97x9OA==
X-Received: by 2002:a17:903:32ca:b0:16f:1c87:9ecd with SMTP id i10-20020a17090332ca00b0016f1c879ecdmr13876025plr.54.1659845633988;
        Sat, 06 Aug 2022 21:13:53 -0700 (PDT)
Received: from ffyuanda.localdomain ([113.65.209.111])
        by smtp.gmail.com with ESMTPSA id v22-20020a17090a0e1600b001f333fab3d6sm8057027pje.18.2022.08.06.21.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 21:13:53 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v2 0/4] rm: integrate with sparse-index
Date:   Sun,  7 Aug 2022 12:13:31 +0800
Message-Id: <20220807041335.1790658-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

## Changes since PATCH v1 ##

1. Move `ensure_not_expanded` test from the first patch to the last one.

2. Mention the parameter of `pathspec_needs_expanded_index()` is
   changed to use `struct index_state`.

3. Modify `ensure_not_expanded` method to record Git commands' stderr
   and stdout.

4. Add a test 'rm pathspec expands index when necessary' to test
   the expected index expansion when different pathspec is supplied.

5. Modify p2000 test by resetting the index in each test loop, so the
   index modification is properly tested. Update the perf stats using
   the results from the modified test.

## PATCH v1 info ##

Turn on sparse-index feature within `git-rm` command.
Add necessary modifications and test them.

Shaoxuan Yuan (4):
  t1092: add tests for `git-rm`
  pathspec.h: move pathspec_needs_expanded_index() from reset.c to here
  rm: expand the index only when necessary
  rm: integrate with sparse-index

 builtin/reset.c                          |  84 +------------------
 builtin/rm.c                             |   7 +-
 pathspec.c                               |  89 ++++++++++++++++++++
 pathspec.h                               |  12 +++
 t/perf/p2000-sparse-operations.sh        |   1 +
 t/t1092-sparse-checkout-compatibility.sh | 100 ++++++++++++++++++++++-
 6 files changed, 205 insertions(+), 88 deletions(-)

Range-diff against v1:
1:  6b424a1eb1 ! 1:  ea4162c6ab t1092: add tests for `git-rm`
    @@ Commit message
         Add tests for `git-rm`, make sure it behaves as expected when
         <pathspec> is both inside or outside of sparse-checkout definition.
     
    -    Also add ensure_not_expanded test to make sure `git-rm` does not
    -    accidentally expand the index when <pathspec> is within the
    -    sparse-checkout definition.
    -
    +    Helped-by: Victoria Dye <vdye@github.com>
    +    Helped-by: Derrick Stolee <derrickstolee@github.com>
         Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
      ## t/t1092-sparse-checkout-compatibility.sh ##
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'mv directory from
     +	test_cmp folder1-sparse sparse-index-out &&
     +	test_sparse_match git status --porcelain=v2
     +'
    -+
    -+test_expect_failure 'sparse index is not expanded: rm' '
    -+	init_repos &&
    -+
    -+	ensure_not_expanded rm deep/a &&
    -+
    -+	# test in-cone wildcard
    -+	git -C sparse-index reset --hard &&
    -+	ensure_not_expanded rm deep/* &&
    -+
    -+	# test recursive rm
    -+	git -C sparse-index reset --hard &&
    -+	ensure_not_expanded rm -r deep
    -+'
     +
      test_done
2:  c2cf8b3c86 ! 2:  061c675c46 pathspec.h: move pathspec_needs_expanded_index() from reset.c to here
    @@ Commit message
         * Add a check in front so if the index is not sparse, return early since
           no expansion is needed.
     
    +    * It now takes an arbitrary 'struct index_state' pointer instead of
    +      using `the_index` and `active_cache`.
    +
         * Add documentation to the function.
     
    +    Helped-by: Victoria Dye <vdye@github.com>
    +    Helped-by: Derrick Stolee <derrickstolee@github.com>
         Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
      ## builtin/reset.c ##
3:  443ca7a682 ! 3:  1c4a85fad3 rm: expand the index only when necessary
    @@ Metadata
      ## Commit message ##
         rm: expand the index only when necessary
     
    -    Originally, rm a pathspec that is out-of-cone in a sparse-index
    -    environment, Git dies with "pathspec '<x>' did not match any files",
    -    mainly because it does not expand the index so nothing is matched.
    -
         Remove the `ensure_full_index()` method so `git-rm` does not always
         expand the index when the expansion is unnecessary, i.e. when
         <pathspec> does not have any possibilities to match anything outside
    @@ Commit message
         <pathspec> contains wildcard that may need a full-index or the
         <pathspec> is simply outside of sparse-checkout definition.
     
    +    Notice that the test 'rm pathspec expands index when necessary' in
    +    t1092 *is* testing this code change behavior, though it will be marked
    +    as 'test_expect_success' only in the next patch, where we officially
    +    mark `command_requires_full_index = 0`, so the index does not expand
    +    unless we tell it to do so.
    +
    +    Notice that because we also want `ensure_full_index` to record the
    +    stdout and stderr from Git command, a corresponding modification
    +    is also included in this patch. The reason we want the "sparse-index-out"
    +    and "sparse-index-err", is that we need to make sure there is no error
    +    from Git command itself, so we can rely on the `test_region` result
    +    and determine if the index is expanded or not.
    +
    +    Helped-by: Victoria Dye <vdye@github.com>
    +    Helped-by: Derrick Stolee <derrickstolee@github.com>
         Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
      ## builtin/rm.c ##
    @@ builtin/rm.c: int cmd_rm(int argc, const char **argv, const char *prefix)
      	for (i = 0; i < active_nr; i++) {
      		const struct cache_entry *ce = active_cache[i];
      
    +
    + ## t/t1092-sparse-checkout-compatibility.sh ##
    +@@ t/t1092-sparse-checkout-compatibility.sh: ensure_not_expanded () {
    + 		shift &&
    + 		test_must_fail env \
    + 			GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
    +-			git -C sparse-index "$@" || return 1
    ++			git -C sparse-index "$@" \
    ++			>sparse-index-out \
    ++			2>sparse-index-error || return 1
    + 	else
    + 		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
    +-			git -C sparse-index "$@" || return 1
    ++			git -C sparse-index "$@" \
    ++			>sparse-index-out \
    ++			2>sparse-index-error || return 1
    + 	fi &&
    + 	test_region ! index ensure_full_index trace2.txt
    + }
    +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'rm pathspec outside sparse definition' '
    + 	test_sparse_match git status --porcelain=v2
    + '
    + 
    ++test_expect_failure 'rm pathspec expands index when necessary' '
    ++	init_repos &&
    ++
    ++	# in-cone pathspec (do not expand)
    ++	ensure_not_expanded rm "deep/deep*" &&
    ++	test_must_be_empty sparse-index-err &&
    ++
    ++	# out-of-cone pathspec (expand)
    ++	! ensure_not_expanded rm --sparse "folder1/a*" &&
    ++	test_must_be_empty sparse-index-err &&
    ++
    ++	# pathspec that should expand index
    ++	! ensure_not_expanded rm "*/a" &&
    ++	test_must_be_empty sparse-index-err &&
    ++
    ++	! ensure_not_expanded rm "**a" &&
    ++	test_must_be_empty sparse-index-err
    ++'
    ++
    + test_done
4:  adb62ca9bf ! 4:  861be8a91e rm: integrate with sparse-index
    @@ Commit message
     
         Enable the sparse index within the `git-rm` command.
     
    -    The `p2000` tests demonstrate a ~96% execution time reduction for
    +    The `p2000` tests demonstrate a ~92% execution time reduction for
         'git rm' using a sparse index.
     
    -    Test                                     before  after
    -    -------------------------------------------------------------
    -    2000.74: git rm -f f2/f4/a (full-v3)     0.66    0.88 +33.0%
    -    2000.75: git rm -f f2/f4/a (full-v4)     0.67    0.75 +12.0%
    -    2000.76: git rm -f f2/f4/a (sparse-v3)   1.99    0.08 -96.0%
    -    2000.77: git rm -f f2/f4/a (sparse-v4)   2.06    0.07 -96.6%
    +    Test                              HEAD~1            HEAD
    +    --------------------------------------------------------------------------
    +    2000.74: git rm ... (full-v3)     0.41(0.37+0.05)   0.43(0.36+0.07) +4.9%
    +    2000.75: git rm ... (full-v4)     0.38(0.34+0.05)   0.39(0.35+0.05) +2.6%
    +    2000.76: git rm ... (sparse-v3)   0.57(0.56+0.01)   0.05(0.05+0.00) -91.2%
    +    2000.77: git rm ... (sparse-v4)   0.57(0.55+0.02)   0.03(0.03+0.00) -94.7%
     
         ----
         Also, normalize a behavioral difference of `git-rm` under sparse-index.
    @@ Commit message
     
         [1] https://github.com/ffyuanda/git/pull/6#discussion_r934861398
     
    +    Helped-by: Victoria Dye <vdye@github.com>
    +    Helped-by: Derrick Stolee <derrickstolee@github.com>
         Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
      ## builtin/rm.c ##
    @@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git blame $SPARSE_CONE/f3/a
      test_perf_on_all git read-tree -mu HEAD
      test_perf_on_all git checkout-index -f --all
      test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
    -+test_perf_on_all git rm -f $SPARSE_CONE/a
    ++test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
      
      test_done
     
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'rm pathspec outsi
      	test_sparse_match git status --porcelain=v2
      '
      
    --test_expect_failure 'sparse index is not expanded: rm' '
    -+test_expect_success 'sparse index is not expanded: rm' '
    +-test_expect_failure 'rm pathspec expands index when necessary' '
    ++test_expect_success 'rm pathspec expands index when necessary' '
      	init_repos &&
      
    - 	ensure_not_expanded rm deep/a &&
    + 	# in-cone pathspec (do not expand)
    +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'rm pathspec expands index when necessary' '
    + 	test_must_be_empty sparse-index-err
    + '
    + 
    ++test_expect_success 'sparse index is not expanded: rm' '
    ++	init_repos &&
    ++
    ++	ensure_not_expanded rm deep/a &&
    ++
    ++	# test in-cone wildcard
    ++	git -C sparse-index reset --hard &&
    ++	ensure_not_expanded rm deep/* &&
    ++
    ++	# test recursive rm
    ++	git -C sparse-index reset --hard &&
    ++	ensure_not_expanded rm -r deep
    ++'
    ++
    + test_done

base-commit: 679aad9e82d0dfd8ef3d1f98fa4629665496cec9
-- 
2.37.0

