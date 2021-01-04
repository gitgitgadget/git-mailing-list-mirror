Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF87C4332B
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B04792255F
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbhADXvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbhADXvL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 18:51:11 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568A6C061574
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 15:50:30 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id o11so27749868ote.4
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 15:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CSoNXiVIgXuuMi204+Ck9xcirdmhYlx+TDL/YnqXdGQ=;
        b=Dit8IpfuooxWsTpRPqOtHxgxb/YIEhfTNgbQmx0N/WOLMmB5Ei8IFB8tcy1mHzsRxX
         EVHfnVITcYSHkgq04iqXfLnU156AxZ6BqRDkNKyoD4ZCdx9p0Ad+6vmgKGjm6EW9CGV4
         sPCgDF+oq/iCwEsUDp9xfgKlLbhypRpxhvREs52a2N0ybSjQ131W/0KZ7cZVSwRhiRbe
         jasP6zOCsHo+B/l+rq7H7ghurthSmOlblIuIhu7s90P0lOpmqbKFr4qH7Dvj2jCjSy+0
         wkO0NtnOW4M3tOYo59Bwjxz1Fg1IJNasa2LWtMPBwBjhmKkQMV6fDVbiLwtGCan8FdzH
         o+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CSoNXiVIgXuuMi204+Ck9xcirdmhYlx+TDL/YnqXdGQ=;
        b=bNG73nCMPOUOKJYgeqPcwwVjmYSIHq8K7XcN/NhNDuj04cTY8gy9XWTvqsPSHpQg72
         udEKQmCuH/KFVaKk7NdDCfx+mBAoaCKRonfrzNpJ920CkYRwTgcnRiz+l9SlMcsGP8Kx
         oWUUHf10yacOEB6OY8WvUFjFHC0AGFjzAenNm6fqC+BxSsQSNmzg0O7jaLkUqIwVnOWU
         enwAP0SOxc9l0ICwUcLwNgaz2LvuFtafkb7bQORd0eE8x1r+3Vi90GR7lOQBZ3jUVURM
         yFBck5UiomfJkADvQvShdnQnmi8/TouwQ/WlMGjzIZwuCVasNejd6zNWXQRBAwF1tzXR
         6usQ==
X-Gm-Message-State: AOAM532INvrb3vAdaMCawCE/PIAGjz72T+6t4FxqQal41IPN7yAU4wDp
        +5ESiN/e+4IyU2OURw5GPJ5vIBzjScM=
X-Google-Smtp-Source: ABdhPJzD6j5A580/Syrkwe6riKmchQf5Vj91o+UIEOZGLCjuH/iWt0h7R/dIFhpLQrToS/xQxhqwnA==
X-Received: by 2002:a9d:c01:: with SMTP id 1mr39351461otr.107.1609804229556;
        Mon, 04 Jan 2021 15:50:29 -0800 (PST)
Received: from tiger.attlocal.net ([2600:1700:bae0:2de0::26])
        by smtp.gmail.com with ESMTPSA id o135sm13359600ooo.38.2021.01.04.15.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 15:50:29 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 00/17] Add directory rename detection to merge-ort
Date:   Mon,  4 Jan 2021 15:49:49 -0800
Message-Id: <20210104235006.2867404-1-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.106.g3ff750dc32.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on a merge of en/merge-ort-3 and
en/merge-ort-recursive.  It does not depend on the (not-yet-picked-up)
ort-conflict-handling series[1].

This series mostly implements directory rename detection for
merge-ort; I'll cover the "mostly" bit below.  If one merges this
series with en/merge-tests and the ort-conflict-handling series[1],
then this series drops the number of failing tests in the testsuite
under GIT_TEST_MERGE_ALGORITHM=ort from 60 down to 8.

There's a lot of code here, but almost all of the logic is just copied
over from similarly named functions in merge-recursive.c, as
repeatedly noted in the commit messages.  There are several minor
differences spread throughout that make it not be a direct copy:

  * using strmap API instead of direct hashmap calls
  * ort keeps track of all files and directories and their shas in
    opt->priv->paths; no need to re-walk tree objects
  * keeping the necessary invariants for opt->priv->paths
  * we can pre-compute which directories are removed (stored in
    dirs_removed), avoiding the need for some post-processing
  * since ort already has struct rename_info, add the extra data
    there and allocate/free it with the rest of the rename_info
  * no non_unique_new_dir field, leading to the failure of test 2b;
    this will be addressed in a different way with upcoming
    performance work.

These differences make a direct comparison difficult, but there's not
really any new or novel logic; the logic for how directory rename
detection is performed is identical to what is found in
merge-recursive; it's just packed slightly differently.

...with one exception -- the final patch in the series modifies the
logic and makes it different than merge-recursive in order to fix a
known bug (testcase 12f of t6423).

There are still four failing tests in t6423 (directory rename tests)
after this series:

  * one test (2b) where merge-ort erroneously prints a "directory
    rename split" conflict message, despite the fact that there is no
    new file and thus no need for a directory rename to be detected.
    This comes from the lack of a non_unique_new_dir field that I
    didn't bother copying, since performance work will address it in a
    completely different way.
    
  * two tests (12b1 and 12c1) where merge-ort produces the same result
    at merge-recursive (these tests are marked as test_expect_failure
    for merge-recursive).  Some performance work will fix these two
    tests.

  * one test (12f) where merge-ort produces a better result than
    merge-recursive.c (this test is marked as test_expect_failure for
    merge-recursive), but where merge-ort does not yet manage to pass
    the final four lines of the test related to performance checking.

[1] https://lore.kernel.org/git/pull.815.v2.git.1609468488.gitgitgadget@gmail.com/

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

-- 
2.29.1.106.g3ff750dc32.dirty

