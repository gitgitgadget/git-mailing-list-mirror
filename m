Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34AFC433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B00E961157
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbhDSKxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 06:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhDSKxh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 06:53:37 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB926C06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:05 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e5so4848223wrg.7
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=EnnSJ86t0HxNh4JPOzLT8qBFbtr6FeXRxpZEng8Dask=;
        b=iBBQM616T6v7ZLqi6VPkhm59DrBEGfXzEU4F20fBMALHN217WwfTo5sOrgFfsyn0cQ
         965JI+oKMmvy2wCD1x0jWINvvHAU4eJnXjpqHUj3b22VykmzdIl6Oz0RgIna4dZ2N1SJ
         Z/yW2Ns3aqWwhBZoUFG0TZ3yAVjEv+l2ITZw1ncDqEMb/clDeq11WtEyZOjko7oSzLFh
         RlvLgrrSJEztHD7hzUQ9GZrvP5DvJjMrUp7V+EjjE/dVVxJj1mVy7t5+hfeNllxio8gn
         uuhUYy2XkRp4e5SNOCACydPcT5irHAo1ilf7oy7V4z3RqBQWq284fQlBtlg05niHX2c+
         h4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EnnSJ86t0HxNh4JPOzLT8qBFbtr6FeXRxpZEng8Dask=;
        b=d2r+e2jV0bOIBtVov8IjRzxX6OVMcmOPTzojRQXNzRFuDF+ydyV6S8lbBe1be3cw31
         b50nCHjXcColGqgVbxRJWU3HxiDo8rUoCZX1B9aY0GKdMMv9M65hOCp7ptD2ixzUqIoZ
         H+pHp8Iq2vAY7ca209Oiq8lZxMlUsL7zvFdl3FOAvh9c2nsJJDBOIqPvukt7c3j2bNF2
         ojOGe/RN8zNvM6s9eUEhUfpWpKBPPWr26l40QSGfLav65UzJsIELkxz2dOhFztW5x4cR
         l3khriruYcMCydxIQgFRaBM4qWKGfdnOxlFVdtV3blIge5L6+ZQjbFhJe3l0M5HjAb+e
         toUQ==
X-Gm-Message-State: AOAM532gBEzoOM/bB+fQf+cFSF5sye+ePciO9Cm/Eie1DrsWKRWDX+Vh
        JEEVRHTdcrVg93mytBzZJhxEW7E8vG4=
X-Google-Smtp-Source: ABdhPJx/JK7vaKIUT/V+62micl/cfbqneanthnrGO0d5LQPAsBt3ZvvN1OFjlEb2qtS+7gVtZFJMUA==
X-Received: by 2002:a5d:64af:: with SMTP id m15mr14045795wrp.298.1618829584739;
        Mon, 19 Apr 2021 03:53:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z14sm21481477wrs.96.2021.04.19.03.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 03:53:04 -0700 (PDT)
Message-Id: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 10:52:45 +0000
Subject: [PATCH 00/18] Prepare tests for reftable backend
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rewrites some tests to avoid direct filesystem access.

Introduces the test prereq REFFILES to mark other tests that depend on
specifics of the files ref backend.

Han-Wen Nienhuys (18):
  t4202: split testcase for invalid HEAD symref and HEAD hash
  t9300: check ref existence using git-rev-parse rather than FS check
  t5601: read HEAD using rev-parse
  t1401-symbolic-ref: avoid direct filesystem access
  t1413: use tar to save and restore entire .git directory
  t1301: fix typo in error message
  t5000: inspect HEAD using git-rev-parse
  t7003: use rev-parse rather than FS inspection
  t5304: use "reflog expire --all" to clear the reflog
  test-lib: provide test prereq REFFILES
  t1407: require REFFILES for for_each_reflog test
  t1414: mark corruption test with REFFILES
  t2017: mark --orphan/logAllRefUpdates=false test as REFFILES
  t1404: mark tests that muck with .git directly as REFFILES.
  t7900: mark pack-refs tests as REFFILES
  t7003: check reflog existence only for REFFILES
  t4202: mark bogus head hash test with REFFILES
  t1415: set REFFILES for test specific to storage format

 t/t1301-shared-repo.sh        |  2 +-
 t/t1401-symbolic-ref.sh       | 23 +++++++++--------------
 t/t1404-update-ref-errors.sh  | 30 +++++++++++++++---------------
 t/t1407-worktree-ref-store.sh |  2 +-
 t/t1413-reflog-detach.sh      |  5 ++---
 t/t1414-reflog-walk.sh        |  2 +-
 t/t1415-worktree-refs.sh      |  2 +-
 t/t2017-checkout-orphan.sh    |  2 +-
 t/t4202-log.sh                |  9 ++++++---
 t/t5000-tar-tree.sh           |  7 ++++---
 t/t5304-prune.sh              |  9 +++------
 t/t5601-clone.sh              |  3 ++-
 t/t7003-filter-branch.sh      |  6 ++++--
 t/t7900-maintenance.sh        |  2 +-
 t/t9300-fast-import.sh        |  2 +-
 t/test-lib.sh                 |  2 ++
 16 files changed, 54 insertions(+), 54 deletions(-)


base-commit: 54a391711554ed41b4b0792cfef004abc74893bd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1008%2Fhanwen%2Freffiles-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1008/hanwen/reffiles-v1
Pull-Request: https://github.com/git/git/pull/1008
-- 
gitgitgadget
