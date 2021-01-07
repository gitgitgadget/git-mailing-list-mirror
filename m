Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8B2C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B25AF2343F
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbhAGVgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 16:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbhAGVgt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 16:36:49 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1BDC0612F5
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 13:36:09 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g185so6751681wmf.3
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 13:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jOnrDIJ8HZXfz4GS7M784Nbk4cTj8ZlEDW7pNNzo2LY=;
        b=kYm0htFiAfV9VY1K1z4jzw5oVGkliBXWIYCSEd/JthCKmbqJkOppVGQNnHg6kMVW0m
         UrCjQBxE1hO/yBeN/5Jiu1DMAMliNCbHHqzZ+gnHew1ylZ0Wk7q8T32FAuqchyQ+PZoc
         s6tp9ZDSKbY5jRpD4Ir/5FVSDFa7ocqZ4U2GGQYCs5+eM4bqbUFMuEVPGJ/aJi6aO5ey
         CpFF4ZMGwrmAsdTe6w8EmdWz1qZMaES46PAJ2uuifvRDhggrxSPuDsyecGP7P76Oc5aR
         WUL9NBo4czbsUxsO9G4Loh4YtcRjwtSl6YjJ/ZQYu7BBi6Qfj5WgZW6JTx/SS0EHNI/C
         YwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jOnrDIJ8HZXfz4GS7M784Nbk4cTj8ZlEDW7pNNzo2LY=;
        b=M3/hEXXqG14SarEIcXs/GutGoK3FkaGMEUHOowxvuKBpSxBQdoDzaAGxeB6jfVH2n/
         Rc/nhkxlQb3uOQ1gZUTlb38ZuxJf9K0PrPcm2gSBHBz4e+Sn5KhoNMFAOO6p20hjz+YD
         r3JdBzrGr97PTb/beKakJNvFDFWuKe3+07+An8k5WqSUYZSZ46hJzpXGvP0JymPUn5/s
         R+jsUeQL77piOwn0gnPXBn3sx/sSZ2u13bFN5J0VxR041PXqLgDbRuXAX8ofJyfOtM66
         GSU2OLmqllLysW8oANknYAamfIChi1GcreqmMZEH23MZooTVY6Cyed5hmpxrhdHyvCui
         zr+A==
X-Gm-Message-State: AOAM5320fg92KmFYd9GUuhuqYTB2gcICs7dHGFE7uBz+MWInCmXtiMfP
        Chb1kEk3T1MYwnmQlNJ4WlLnJ9WQdxo=
X-Google-Smtp-Source: ABdhPJwTJPlCyBCH0nnbEvH9V3xxE9a0otQ2vDR99EY/AWDZbqg6hQCcIPypSjri4W4Jfd/Vp0mQpg==
X-Received: by 2002:a7b:cf08:: with SMTP id l8mr380864wmg.189.1610055367384;
        Thu, 07 Jan 2021 13:36:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9sm10607294wrs.70.2021.01.07.13.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:36:06 -0800 (PST)
Message-Id: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.1610049687.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 21:35:48 +0000
Subject: [PATCH v2 00/17] Add directory rename detection to merge-ort
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Sorry for the deluge of email. Only change since v1 is dropping the "DO NOT
SUBMIT" patch at the end that was meant to be part of later optimization
work. Now this series actually matches what I sent on Monday at
https://lore.kernel.org/git/20210104235006.2867404-1-newren@gmail.com/, as I
meant to do with v1.]

This series depends on a merge of en/merge-ort-3 and en/merge-ort-recursive.
It does not depend on the en/ort-conflict-handling.

This series mostly implements directory rename detection for merge-ort; I'll
cover the "mostly" bit below. If one merges this series with en/merge-tests
and en/ort-conflict-handling, then this series drops the number of failing
tests in the testsuite under GIT_TEST_MERGE_ALGORITHM=ort from 60 down to 8.

There's a lot of code here, but almost all of the logic is just copied over
from similarly named functions in merge-recursive.c, as repeatedly noted in
the commit messages. There are several minor differences spread throughout
that make it not be a direct copy:

 * using strmap API instead of direct hashmap calls
 * ort keeps track of all files and directories and their shas in
   opt->priv->paths; no need to re-walk tree objects
 * keeping the necessary invariants for opt->priv->paths
 * we can pre-compute which directories are removed (stored in
   dirs_removed), avoiding the need for some post-processing
 * since ort already has struct rename_info, add the extra data there and
   allocate/free it with the rest of the rename_info
 * no non_unique_new_dir field, leading to the failure of test 2b; this will
   be addressed in a different way with upcoming performance work.

These differences make a direct comparison difficult, but there's not really
any new or novel logic; the logic for how directory rename detection is
performed is identical to what is found in merge-recursive; it's just
packaged slightly differently.

...with one exception -- the final patch in the series modifies the logic
and makes it different than merge-recursive in order to fix a known bug
(testcase 12f of t6423).

There are still four failing tests in t6423 (directory rename tests) after
this series:

 * one test (2b) where merge-ort erroneously prints a "directory rename
   split" conflict message, despite the fact that there is no new file and
   thus no need for a directory rename to be detected. This comes from the
   lack of a non_unique_new_dir field that I didn't bother copying, since
   performance work will address it in a completely different way.

 * two tests (12b1 and 12c1) where merge-ort produces the same result at
   merge-recursive (these tests are marked as test_expect_failure for
   merge-recursive). Some performance work will fix these two tests.

 * one test (12f) where merge-ort produces a better result than
   merge-recursive.c (this test is marked as test_expect_failure for
   merge-recursive), but where merge-ort does not yet manage to pass the
   final four lines of the test related to performance checking.

Elijah Newren (17):
  merge-ort: add new data structures for directory rename detection
  merge-ort: initialize and free new directory rename data structures
  merge-ort: collect which directories are removed in dirs_removed
  merge-ort: add outline for computing directory renames
  merge-ort: add outline of get_provisional_directory_renames()
  merge-ort: copy get_renamed_dir_portion() from merge-recursive.c
  merge-ort: implement compute_rename_counts()
  merge-ort: implement handle_directory_level_conflicts()
  merge-ort: modify collect_renames() for directory rename handling
  merge-ort: implement compute_collisions()
  merge-ort: implement apply_dir_rename() and check_dir_renamed()
  merge-ort: implement check_for_directory_rename()
  merge-ort: implement handle_path_level_conflicts()
  merge-ort: add a new toplevel_dir field
  merge-ort: implement apply_directory_rename_modifications()
  merge-ort: process_renames() now needs more defensiveness
  merge-ort: fix a directory rename detection bug

 merge-ort.c | 831 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 812 insertions(+), 19 deletions(-)


base-commit: 9c85b62e817e83401855e4f2e11283be8386739e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-835%2Fnewren%2Fort-directory-renames-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-835/newren/ort-directory-renames-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/835

Range-diff vs v1:

  1:  41a99640cc5 =  1:  41a99640cc5 merge-ort: add new data structures for directory rename detection
  2:  762151802be =  2:  762151802be merge-ort: initialize and free new directory rename data structures
  3:  bb4b6d20480 =  3:  bb4b6d20480 merge-ort: collect which directories are removed in dirs_removed
  4:  ccb30dfc3c4 =  4:  ccb30dfc3c4 merge-ort: add outline for computing directory renames
  5:  bb4285250cd =  5:  bb4285250cd merge-ort: add outline of get_provisional_directory_renames()
  6:  4e79a96ba1c =  6:  4e79a96ba1c merge-ort: copy get_renamed_dir_portion() from merge-recursive.c
  7:  1e48cde01b9 =  7:  1e48cde01b9 merge-ort: implement compute_rename_counts()
  8:  f6efa4350d6 =  8:  f6efa4350d6 merge-ort: implement handle_directory_level_conflicts()
  9:  bdd9d6cd702 =  9:  bdd9d6cd702 merge-ort: modify collect_renames() for directory rename handling
 10:  9a06c698857 = 10:  9a06c698857 merge-ort: implement compute_collisions()
 11:  2ffb93c37ac = 11:  2ffb93c37ac merge-ort: implement apply_dir_rename() and check_dir_renamed()
 12:  cbfdf4d9ba0 = 12:  cbfdf4d9ba0 merge-ort: implement check_for_directory_rename()
 13:  734891cb315 = 13:  734891cb315 merge-ort: implement handle_path_level_conflicts()
 14:  4b912f2c025 = 14:  4b912f2c025 merge-ort: add a new toplevel_dir field
 15:  d74417e86c5 = 15:  d74417e86c5 merge-ort: implement apply_directory_rename_modifications()
 16:  11e45af831d = 16:  11e45af831d merge-ort: process_renames() now needs more defensiveness
 17:  551878bd84d = 17:  551878bd84d merge-ort: fix a directory rename detection bug
 18:  786dc8f0c44 <  -:  ----------- DO NOT SUBMIT: directory rename stuff for redo_after_renames

-- 
gitgitgadget
