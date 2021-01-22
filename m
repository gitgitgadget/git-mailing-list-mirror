Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569AFC433E6
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 13:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 063F523437
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 13:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbhAVNFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 08:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbhAVNEu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 08:04:50 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58BFC0613D6
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 05:04:02 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d16so4337521wro.11
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 05:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M/ZkJgzlLDQCORadiiZMln61JalZmJG0eV/NmzqyoeY=;
        b=oIqfdo88ZxPeWIheHV8h4XkE2oStIRMS3vpwxKq1D0aTPZvWvkKn2NApL3MfLrjHva
         5h6o/EZPzQpp+a45RwY6oxYsL0dqEcVLoE+apGbwuEqEHdZoBjcdhhd/0sgn+bWxX4aX
         ccld5a8ugYhf9PTLk6ErjNRSBpvTSEfpmOeSJfpwtZDLRmG/0G4ysXVQwyZXSZ0Z8mN5
         yDsAB1e3e0CF9j4yy/Uq7LibchyC52JM2vxpa7tXlUswqBko6NmlEtQeDMGGDT24Nu64
         /K52/4KIt5avo3RcwwR6ek25lprXPVTywq75BdMuA75lu5trs2ey/l21A4ntDsCOjEel
         Q1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M/ZkJgzlLDQCORadiiZMln61JalZmJG0eV/NmzqyoeY=;
        b=YdGrixSwUxP0hBhlsDhMRpgRvA6sFHpffUS/5jnhFWXN2ykpB94rIQFUgk7dBkiT9/
         94LQLlJGz62af6IIJ2MK1/c87v6pWqYiNyS3X773iezKBpibw3y9urEmSkuND2eqD/c3
         RUOMvWtnYZF90h94ZGsnL/IfBmkVp7QUi4417YzRqUQxeLPEuBCM5uhk2dIueZXx1tBJ
         rtVFH1NiySwqG1Kjnfa/WiacFvtHzEmB+mIn0ddLEU/dtEtfPPdS+hdq7BBFgUuvM68x
         KfcK3B5Fj9pgh6bUAk1Ore2J07E5OQyGBh3Bi2cvFPK4udZpZdVvNCRwwH4hz5wBprs4
         Zl5A==
X-Gm-Message-State: AOAM532z+19txcuFt/A9Gt68G3WvDDBDz2EBNxwZlyIGOqphp1ZCJgg5
        OgxebK0jrub68JfFYgWM+98jty4gf+Q=
X-Google-Smtp-Source: ABdhPJzQb75O0aWAWq/HEV/u8n0l10gWYkW+hUiT2KNPuIGFzcntAPn7ZhVpzd4QSq9YkE+Lz7fsCg==
X-Received: by 2002:adf:f9d0:: with SMTP id w16mr4423080wrr.137.1611320641138;
        Fri, 22 Jan 2021 05:04:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18sm11279043wmc.31.2021.01.22.05.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 05:04:00 -0800 (PST)
Message-Id: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.git.1611161639.gitgitgadget@gmail.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Jan 2021 13:03:51 +0000
Subject: [PATCH v2 0/8] More index cleanups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <stolee@gmail.com>,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on ds/cache-tree-basics.

Here are a few more cleanups that are vaguely related to the index. I
discovered these while preparing my sparse-index RFC that I intend to send
early next week.

The biggest patch is the final one, which creates a test script for
comparing sparse-checkouts to full checkouts. There are some commands that
do not behave similarly. This script will be the backbone of my testing
strategy for the sparse-index by adding a new mode to compare
sparse-checkouts with the two index types (full and sparse).


UPDATES IN V2
=============

 * Fixed duplicated test in t1092.

 * Changed the implementation of 'test_region' after I discovered the
   negation doesn't work correctly. (I updated the test to use what was in
   t0500-progress-display.sh at the last minute before v1, but that
   implementation was wrong.) The use of it in t0500-progress-display.sh was
   incorrect, as well.

 * Updated commit messages to be more informative and have fewer typos.

 * I dropped the patch that placed the sparse-checkout patterns in struct
   index_state. I'll re-introduce that in time for the actual use of the
   member.

Thanks, -Stolee

Derrick Stolee (8):
  cache-tree: clean up cache_tree_update()
  cache-tree: extract subtree_pos()
  fsmonitor: de-duplicate BUG()s around dirty bits
  repository: add repo reference to index_state
  name-hash: use trace2 regions for init
  sparse-checkout: load sparse-checkout patterns
  test-lib: test_region looks for trace2 regions
  t1092: test interesting sparse-checkout scenarios

 builtin/sparse-checkout.c                |   5 -
 cache-tree.c                             |  20 +-
 cache-tree.h                             |   2 +
 cache.h                                  |   1 +
 dir.c                                    |  17 ++
 dir.h                                    |   2 +
 fsmonitor.c                              |  27 +-
 name-hash.c                              |   3 +
 repository.c                             |   4 +
 t/t0500-progress-display.sh              |   3 +-
 t/t1092-sparse-checkout-compatibility.sh | 298 +++++++++++++++++++++++
 t/test-lib-functions.sh                  |  40 +++
 unpack-trees.c                           |   6 +-
 13 files changed, 394 insertions(+), 34 deletions(-)
 create mode 100755 t/t1092-sparse-checkout-compatibility.sh


base-commit: a4b6d202caad83c6dc29abe9b17e53a1b3fb54a0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-839%2Fderrickstolee%2Fmore-index-cleanups-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-839/derrickstolee/more-index-cleanups-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/839

Range-diff vs v1:

  1:  0bccfd34ae5 !  1:  f9dccaed0ac cache-tree: clean up cache_tree_update()
     @@ Commit message
          cache-tree: clean up cache_tree_update()
      
          Make the method safer by allocating a cache_tree member for the given
     -    index_state if it is not already present.
     +    index_state if it is not already present. This is preferrable to a
     +    BUG() statement or returning with an error because future callers will
     +    want to populate an empty cache-tree using this method.
      
          Also drop local variables that are used exactly once and can be found
          directly from the 'istate' parameter.
  2:  a6f2406a795 =  2:  84323e04d08 cache-tree: extract subtree_pos()
  3:  838922de2e9 =  3:  31095f9aa0e fsmonitor: de-duplicate BUG()s around dirty bits
  4:  d4ff0468fc0 !  4:  a0d89d7a973 repository: add repo reference to index_state
     @@ Metadata
       ## Commit message ##
          repository: add repo reference to index_state
      
     -    It will be helpful to add behavior to index opertations that might
     +    It will be helpful to add behavior to index operations that might
          trigger an object lookup. Since each index belongs to a specific
          repository, add a 'repo' pointer to struct index_state that allows
          access to this repository.
  5:  3ba4b35f09c =  5:  bc092f5c703 name-hash: use trace2 regions for init
  6:  64358ec7ea2 =  6:  04d1daf7222 sparse-checkout: load sparse-checkout patterns
  7:  91344f5108c <  -:  ----------- sparse-checkout: hold pattern list in index
  8:  8326a9b5320 !  7:  8832ce84623 test-lib: test_region looks for trace2 regions
     @@ Commit message
          entered and left in a given trace2 event log.
      
          There is one existing test (t0500-progress-display.sh) that performs
     -    this check already, so use the helper function instead. More uses will
     -    be added in a later change.
     +    this check already, so use the helper function instead. Note that this
     +    changes the expectations slightly. The old test (incorrectly) used two
     +    patterns for the 'grep' invocation, but this performs an OR of the
     +    patterns, not an AND. This means that as long as one region_enter event
     +    was logged, the test would succeed, even if it was not due to the
     +    progress category.
     +
     +    More uses will be added in a later change.
      
          t6423-merge-rename-directories.sh also greps for region_enter lines, but
          it verifies the number of such lines, which is not the same as an
     @@ t/t0500-progress-display.sh: test_expect_success 'progress generates traces' '
       	# t0212/parse_events.perl intentionally omits regions and data.
      -	grep -e "region_enter" -e "\"category\":\"progress\"" trace.event &&
      -	grep -e "region_leave" -e "\"category\":\"progress\"" trace.event &&
     -+	test_region category progress trace.event &&
     ++	test_region progress "Working hard" trace.event &&
       	grep "\"key\":\"total_objects\",\"value\":\"40\"" trace.event &&
       	grep "\"key\":\"total_bytes\",\"value\":\"409600\"" trace.event
       '
     @@ t/test-lib-functions.sh: test_subcommand () {
      +		shift
      +	fi
      +
     -+	grep -e "region_enter" -e "\"category\":\"$1\",\"label\":\"$2\"" "$3"
     ++	grep -e "\"region_enter\".*\"category\":\"$1\",\"label\":\"$2\"" "$3"
      +	exitcode=$?
      +
      +	if test $exitcode != $expect_exit
     @@ t/test-lib-functions.sh: test_subcommand () {
      +		return 1
      +	fi
      +
     -+	grep -e "region_leave" -e "\"category\":\"$1\",\"label\":\"$2\"" "$3"
     ++	grep -e "\"region_leave\".*\"category\":\"$1\",\"label\":\"$2\"" "$3"
      +	exitcode=$?
      +
      +	if test $exitcode != $expect_exit
  9:  555e210dc03 !  8:  984458007ed t1092: test interesting sparse-checkout scenarios
     @@ Commit message
          These also document some behaviors that differ from a full checkout, and
          possibly in a way that is not intended.
      
     +    The test is designed to be run with "--run=1,X" where 'X' is an
     +    interesting test case. Each test uses 'init_repos' to reset the full and
     +    sparse copies of the initial-repo that is created by the first test
     +    case. This also makes it possible to have test cases leave the working
     +    directory or index in unusual states without disturbing later cases.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## t/t1092-sparse-checkout-compatibility.sh (new) ##
     @@ t/t1092-sparse-checkout-compatibility.sh (new)
      +	init_repos &&
      +
      +	write_script edit-contents <<-\EOF &&
     -+	echo text >>README.md
     -+	EOF
     -+	run_on_all "../edit-contents" &&
     -+
     -+	test_all_match git add README.md &&
     -+	test_all_match git status --porcelain=v2 &&
     -+	test_all_match git commit -m "Add README.md" &&
     -+
     -+	test_all_match git checkout HEAD~1 &&
     -+	test_all_match git checkout - &&
     -+
     -+	run_on_all "../edit-contents" &&
     -+
     -+	test_all_match git add -A &&
     -+	test_all_match git status --porcelain=v2 &&
     -+	test_all_match git commit -m "Extend README.md" &&
     -+
     -+	test_all_match git checkout HEAD~1 &&
     -+	test_all_match git checkout -
     -+'
     -+
     -+test_expect_success 'add, commit, checkout' '
     -+	init_repos &&
     -+
     -+	write_script edit-contents <<-\EOF &&
      +	echo text >>$1
      +	EOF
      +	run_on_all "../edit-contents README.md" &&
     @@ t/t1092-sparse-checkout-compatibility.sh (new)
      +	do
      +		test_all_match git checkout rename-base &&
      +		test_all_match git checkout $branch -- .&&
     -+		test_all_match git diff --staged &&
     ++		test_all_match git diff --staged --no-renames &&
      +		test_all_match git diff --staged --find-renames || return 1
      +	done
      +'

-- 
gitgitgadget
