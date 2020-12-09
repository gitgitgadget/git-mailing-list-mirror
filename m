Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88313C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5431D2332A
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388073AbgLITvj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgLITmK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 14:42:10 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80983C0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 11:41:30 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r14so3043183wrn.0
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 11:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=wapMAQsrlaWj41G5Kk2Fh/pi3q+xTkkstjnL13LrO8Y=;
        b=SvqYcTEhJN6xnFt6S7DI7mG4o/jRd8vH2/oGrbV6XFTVluFyMB1NbKj43DvBungO7s
         zB5Oju4NcEBhltsgNKLHHOgWw2NjILsDXF3TJ5NAdilsbRRP2ZLTOXOlox70XBJvp6x8
         lqb1Al081eFW+ECBlnbAchLLZp4mP/M8Iv+cqDzNJY/DC5V6RHMfHRz39dMmCX0Ib023
         ELZt0h9tBHsbAApL4EemmjjDn7A5tGVelLWDUSiptzq9ey/2ScLWP3co+oXKARN/RAtW
         28Po8bSR2zlNqFwCfvELSgvH8LRkcpH7MLUP1lWnlF1NtzClwu6DRKLHr5ei0JmUyxue
         xyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wapMAQsrlaWj41G5Kk2Fh/pi3q+xTkkstjnL13LrO8Y=;
        b=Pb1088NfvTwraT0h/3R8u/o3phFTzynzYcneEZOVu3258wEHVbeIetlT0SpvtPSCy0
         z8XZkDTPVF6OfpSj0dntgCZWVMRHkzNJyx/0ob/AJwZTYELTpBwWJfvScohh1AderjMQ
         UbTV71/TDs+873GTmTVOYEOUKZo2Abye26PZVz/szNCyCDiIL+0oDzJG7b9NuirOSYF/
         RCXTefTZd9fkBMBX3sD+drhTXMuoHGZAlgoXcn3StjrPhJQZf0v9AUQ0kCcbGvFE28nU
         O0lhSyROlFUhu2my5GIPHG+DpOhX7aAiFDio/k3rjdMF3qYJNOCC8w1po8YGI6Tyzg9Q
         EtPA==
X-Gm-Message-State: AOAM5320ixoJQ2VFF2YUqkwDJdR63bgklujgI3oFfVNydiC9jzD48aA/
        gW6tEokNFCYmf5HfGEMOSSRAddUwMjk=
X-Google-Smtp-Source: ABdhPJyHHULCFK8+PQrATlMTHjNMSDRX2F3AkkAVqlkg0aQI5cPaGeZsIyAipg9zkW33GeiTeSUh7A==
X-Received: by 2002:a5d:6443:: with SMTP id d3mr4309433wrw.422.1607542889012;
        Wed, 09 Dec 2020 11:41:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j7sm4889970wmb.40.2020.12.09.11.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:41:28 -0800 (PST)
Message-Id: <pull.812.git.1607542887.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 19:41:16 +0000
Subject: [PATCH 00/11] merge-ort: add basic rename detection
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series builds on en/merge-ort-2 and adds basic rename detection to
merge-ort.

The first five patches set up the basic algorithm structure. Patches 6-10
implement different type of rename-related cases, one-by-one. Patch 11 also
implements a rename-related case, but one that merge-recursive doesn't
really handle.

A couple early patches mimic or even copy from merge-recursive, but in later
patches the implementation here diverges heavily from merge-recursive's.
Patches 6-10 refer to this repeatedly, all having a slight variant of the
following paragraph in their commit messages:

The consolidation of $NUM separate codepaths into one is made possible
by a change in design: process_renames() tweaks the conflict_info
entries within opt->priv->paths such that process_entry() can then
handle all the non-rename conflict types (directory/file, modify/delete,
etc.) orthogonally.  This means we're much less likely to miss special
implementation of some kind of combination of conflict types (see
commits brought in by 66c62eaec6 ("Merge branch 'en/merge-tests'",
2020-11-18), especially commit ef52778708 ("merge tests: expect improved
directory/file conflict handling in ort", 2020-10-26) for more details).
That, together with letting worktree/index updating be handled
orthogonally in the merge_switch_to_result() function, dramatically
simplifies the code for various special rename cases.

This patch series does not make more tests pass under
GIT_TEST_MERGE_ALGORITHM=ort by itself, because once renames are handled
then content merging needs to happen and that code still does a die("Not yet
implemented."). I'll be soon submitting parallel patches for more basic
conflict handling and recursiveness, and when all three series are merged
down (in any order), it will drop the number of test failures under
GIT_TEST_MERGE_ALGORITHM=ort from 1448 to 60.

Elijah Newren (11):
  merge-ort: add basic data structures for handling renames
  merge-ort: add initial outline for basic rename detection
  merge-ort: implement detect_regular_renames()
  merge-ort: implement compare_pairs() and collect_renames()
  merge-ort: add basic outline for process_renames()
  merge-ort: add implementation of both sides renaming identically
  merge-ort: add implementation of both sides renaming differently
  merge-ort: add implementation of rename collisions
  merge-ort: add implementation of rename/delete conflicts
  merge-ort: add implementation of normal rename handling
  merge-ort: add implementation of type-changed rename handling

 merge-ort.c | 439 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 423 insertions(+), 16 deletions(-)


base-commit: 2f73290465428ae9d088819b8a07bc5c4efe4a8b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-812%2Fnewren%2Fort-renames-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-812/newren/ort-renames-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/812
-- 
gitgitgadget
