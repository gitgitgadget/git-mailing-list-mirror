Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA04C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC36064D99
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhCKAit (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 19:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhCKAie (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 19:38:34 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B51C061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:38:34 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u16so25338471wrt.1
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=SwK27IDHSZcKaXl2VIAvbeO5HecmLIwRWpKQ3C7EM8A=;
        b=La1h8elKx21VsTpgr42rrPoHrkFa09gIgyCENQihQUSH+pJK/CTFR7jGbKX6GwpZS5
         alAijmp/vmkjDPViBPn9LEq/JWCH5AVNL7bw8GL5FHUWhe/21x7rbKvkAQXJvhzHmlBr
         FyRaLARsx2dzNQ/LgTGjajwG1ED8lnAdyj08q67xKZAoESJKVprzLdpMdzKR2GLoUYBI
         SYbpN92i9TwET+tB7HwfEbdR6BH9ImbyTmgI6iQITjBb8l11tHV6QdY9DiGnzZjchdO9
         n3XdZsjXZai0qWN3+4fmpDIgPMcslpHnAUEctcoRrjZiS+c5wpJx53zOV4w3ovtv8cRO
         Haxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=SwK27IDHSZcKaXl2VIAvbeO5HecmLIwRWpKQ3C7EM8A=;
        b=ZbfC9eo3gGogcUEyaKwdN4pHHdYtAr1EkuaFeGp9km3+Og1ulxTTVWpSAxlce5nZdQ
         OQb3vEFpBGJo4RykXVUzj1a/WyyXJS/6D//JNKxQYvsxI/fNLqF9VMVk5aJti8GifjCC
         Clw/PW8aHV7HTjJXnbl7pVVsfiKHo0r92kmHJegkY+RCrBrgLZfzmxI9zCN+mxjbl+iN
         6Wyy+0CISIXroNXNZ8YOcYVAaTsJn+WF18RxkBgNY71hf+IjGyLz9nqy+7doP+n2XD/+
         oXbNx6kA1eIXoYq6fVxeeKUbF6cSChfxZgV6nFJiHArHB387mml/cxqeuxJNxWu63l16
         iluA==
X-Gm-Message-State: AOAM5329lfkGZl+Cd0V60LdR8DydcWAZeLe+GnYZzFcgoNUGlwqguxMG
        P414MMOflPk4DnbkhHgzEeU9aNq324E=
X-Google-Smtp-Source: ABdhPJxoCKLAljpu9umKLJ8hmrH6JomnRFf1HIaHoxI43UYmVjnyUbwwic9FyqE8Yk9/0ZSJcCUHEQ==
X-Received: by 2002:adf:ea0e:: with SMTP id q14mr6097549wrm.389.1615423112941;
        Wed, 10 Mar 2021 16:38:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v13sm1186944wrt.45.2021.03.10.16.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:38:32 -0800 (PST)
Message-Id: <pull.845.v3.git.1615423111.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
References: <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Mar 2021 00:38:23 +0000
Subject: [PATCH v3 0/8] Optimization batch 9: avoid detecting irrelevant renames
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series determines paths which meet special cases where detection of
renames is irrelevant, where the irrelevance is due to the fact that the
merge machinery will arrive at the same result regardless of whether a
rename is detected for any of those paths.

Changes since v2:

 * Added an extended comment about filtering order to the first patch, to
   address Stolee's question
 * Added a new testcase that will fail if the critical "if (content_relevant
   || location_relevant)" check only checks for one of those two or the
   intersection of those two, as suggested by Stolee
 * Fixed the other minor problems Stolee pointed out in his review (stray
   newline, wording of comment)

Elijah Newren (8):
  diffcore-rename: enable filtering possible rename sources
  merge-ort: precompute subset of sources for which we need rename
    detection
  merge-ort: add data structures for an alternate tree traversal
  merge-ort: introduce wrappers for alternate tree traversal
  merge-ort: precompute whether directory rename detection is needed
  merge-ort: use relevant_sources to filter possible rename sources
  merge-ort: skip rename detection entirely if possible
  diffcore-rename: avoid doing basename comparisons for irrelevant
    sources

 diffcore-rename.c                   |  63 ++++++--
 diffcore.h                          |   1 +
 merge-ort.c                         | 234 +++++++++++++++++++++++++++-
 t/t6423-merge-rename-directories.sh |  71 +++++++++
 4 files changed, 354 insertions(+), 15 deletions(-)


base-commit: 4be565c472088d4144063b736308bf2a57331f45
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-845%2Fnewren%2Fort-perf-batch-9-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-845/newren/ort-perf-batch-9-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/845

Range-diff vs v2:

 1:  dab8e3c6aee5 ! 1:  3b253f5a63ed diffcore-rename: enable filtering possible rename sources
     @@ Commit message
          sources we detect renames for, and have merge-ort pass that set of
          relevant_sources to diffcore_rename_extended().
      
     +    A note about filtering order:
     +
     +    Some may be curious why we don't filter out irrelevant sources at the
     +    same time we filter out exact renames.  While that technically could be
     +    done at this point, there are two reasons to defer it:
     +
     +    First, was to reinforce a lesson that was too easy to forget.  As I
     +    mentioned above, in the past I filtered irrelevant sources out before
     +    exact rename checking, and then discovered that exact renames' ability
     +    to remove both sources and destinations was an important consideration
     +    and thus doing the filtering after exact rename checking would speed
     +    things up.  Then at some point I realized that basename matching could
     +    also remove both sources and destinations, and decided to put irrelevant
     +    source filtering after basename filtering.  That slowed things down a
     +    lot.  But, despite learning about this important ordering, in later
     +    restructuring I forgot and made the same mistake of putting the
     +    filtering after basename guided rename detection again.  So, I have this
     +    series of patches structured to do the irrelevant filtering last to
     +    start to show how much extra it costs, and then add relevant filtering
     +    in to find_basename_matches() to show how much it speeds things up.
     +    Basically, it's a way to reinforce something that apparently was too
     +    easy to forget, and make sure the commit messages record this lesson.
     +
     +    Second, the items in the "relevant_sources" in this patch series will
     +    include all sources that *might be* relevant.  It has to be conservative
     +    and catch anything that might need a rename, but in the patch series
     +    after this one we'll find ways to weed out more of the *might be*
     +    relevant ones.  Unfortunately, merge-ort does not have sufficient
     +    information to weed those ones out, and there isn't enough information
     +    at the time of filtering exact renames out to remove the extra ones
     +    either.  It has to be deferred.  So the deferral is in part to simplify
     +    some later additions.
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diffcore-rename.c ##
 2:  33c231331744 ! 2:  d8378b3dde6c merge-ort: precompute subset of sources for which we need rename detection
     @@ Commit message
                 found under a different path than in the merge base or on the
                 other side of history.
      
     -    This commit concentrates just on the three-way content merging; it will
     -    punt and mark all sources as needed for directory rename detection, and
     -    leave it to future commits to narrow that down more.
     +    Add a simple testcase showing the two kinds of reasons renames are
     +    relevant; it's a testcase that will only pass if we detect both kinds of
     +    needed renames.
     +
     +    Other than the testcase added above, this commit concentrates just on
     +    the three-way content merging; it will punt and mark all sources as
     +    needed for directory rename detection, and leave it to future commits to
     +    narrow that down more.
      
          The point of three-way content merging is to reconcile changes made on
          *both* sides of history.  What if the file wasn't modified on both
     @@ merge-ort.c: static void merge_start(struct merge_options *opt, struct merge_res
       	}
       
       	/*
     +
     + ## t/t6423-merge-rename-directories.sh ##
     +@@ t/t6423-merge-rename-directories.sh: test_expect_merge_algorithm failure success '12f: Trivial directory resolve, cac
     + 	)
     + '
     + 
     ++# Testcase 12g, Testcase with two kinds of "relevant" renames
     ++#   Commit O: somefile_O, subdir/{a_O,b_O}
     ++#   Commit A: somefile_A, subdir/{a_O,b_O,c_A}
     ++#   Commit B: newfile_B,  newdir/{a_B,b_B}
     ++#   Expected: newfile_{merged}, newdir/{a_B,b_B,c_A}
     ++
     ++test_setup_12g () {
     ++	test_create_repo 12g &&
     ++	(
     ++		cd 12g &&
     ++
     ++		mkdir -p subdir &&
     ++		test_write_lines upon a time there was a >somefile &&
     ++		test_write_lines 1 2 3 4 5 6 7 8 9 10 >subdir/a &&
     ++		test_write_lines one two three four five six >subdir/b &&
     ++		git add . &&
     ++		test_tick &&
     ++		git commit -m "O" &&
     ++
     ++		git branch O &&
     ++		git branch A &&
     ++		git branch B &&
     ++
     ++		git switch A &&
     ++		test_write_lines once upon a time there was a >somefile &&
     ++		> subdir/c &&
     ++		git add somefile subdir/c &&
     ++		test_tick &&
     ++		git commit -m "A" &&
     ++
     ++		git checkout B &&
     ++		git mv somefile newfile &&
     ++		git mv subdir newdir &&
     ++		echo repo >>newfile &&
     ++		test_write_lines 1 2 3 4 5 6 7 8 9 10 11 >newdir/a &&
     ++		test_write_lines one two three four five six seven >newdir/b &&
     ++		git add newfile newdir &&
     ++		test_tick &&
     ++		git commit -m "B"
     ++	)
     ++}
     ++
     ++test_expect_success '12g: Testcase with two kinds of "relevant" renames' '
     ++	test_setup_12g &&
     ++	(
     ++		cd 12g &&
     ++
     ++		git checkout A^0 &&
     ++
     ++		git -c merge.directoryRenames=true merge -s recursive B^0 &&
     ++
     ++		test_write_lines once upon a time there was a repo >expect &&
     ++		test_cmp expect newfile &&
     ++
     ++		git ls-files -s >out &&
     ++		test_line_count = 4 out &&
     ++
     ++		git rev-parse >actual \
     ++			HEAD:newdir/a  HEAD:newdir/b   HEAD:newdir/c &&
     ++		git rev-parse >expect \
     ++			B:newdir/a     B:newdir/b      A:subdir/c &&
     ++		test_cmp expect actual &&
     ++
     ++		test_must_fail git rev-parse HEAD:subdir/a &&
     ++		test_must_fail git rev-parse HEAD:subdir/b &&
     ++		test_must_fail git rev-parse HEAD:subdir/c &&
     ++		test_path_is_missing subdir/ &&
     ++		test_path_is_file newdir/c
     ++	)
     ++'
     ++
     + ###########################################################################
     + # SECTION 13: Checking informational and conflict messages
     + #
 3:  89b43c9f75a0 = 3:  a57cc981608c merge-ort: add data structures for an alternate tree traversal
 4:  6497050c0012 ! 4:  b595245fe902 merge-ort: introduce wrappers for alternate tree traversal
     @@ merge-ort.c: static char *unique_path(struct strmap *existing_paths,
      +			 renames->callback_data[i].dirmask,
      +			 renames->callback_data[i].names,
      +			 info);
     -+
      +	}
      +
      +	renames->callback_data_nr = old_offset;
 5:  608d5a4c6ad7 = 5:  dc146a867b16 merge-ort: precompute whether directory rename detection is needed
 6:  d62fdee45ad3 = 6:  375c9b36861b merge-ort: use relevant_sources to filter possible rename sources
 7:  cd931286f24d ! 7:  80a0c27a74ad merge-ort: skip rename detection entirely if possible
     @@ merge-ort.c: static int detect_and_process_renames(struct merge_options *opt,
      +cleanup:
      +	/*
      +	 * Free now unneeded filepairs, which would have been handled
     -+	 * in collect_renames() normally but we're about to skip that
     -+	 * code...
     ++	 * in collect_renames() normally but we skipped that code.
      +	 */
      +	for (s = MERGE_SIDE1; s <= MERGE_SIDE2; s++) {
      +		struct diff_queue_struct *side_pairs;
 8:  c443ba8abb89 = 8:  98b0c7de5e70 diffcore-rename: avoid doing basename comparisons for irrelevant sources

-- 
gitgitgadget
