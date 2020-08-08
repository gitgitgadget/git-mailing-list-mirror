Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F9CC433DF
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 17:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93268206CD
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 17:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqSNU+fo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgHHRBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 13:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHRBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 13:01:25 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B7CC061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 10:01:25 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a14so4418613wra.5
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 10:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tYM6Z48tE1es4qqho5S1R8pWkhTPq5STOnsKYKK64dw=;
        b=MqSNU+fospRYDkifwMyuqmSw+MyCuMwJuBxjatc/u3y9V6lgxpRfQwgnjVcV8SahCq
         CiHpqQ5Qa/ScGdUyLa8yWnWYw/N13ECDXEb3cC3910z1994vEzXGKsCKEJt3Rw+2RObw
         8sapjwJqOxlfHF42QEvWBM8HYJcWhPzcv0EK+lQG8/jbodUvAWmnv4ISoS31VGIPXzR7
         SvV9wweeMpq8Je+7Tu3pMqd0iijjXYtdE4C1oTbPp5vOxBpyRf9XuAZJLWmkqZgoW2xQ
         p6wihMXSv07r/HZPEWq5yC3S3uGV2EID4ZM3xKzurmJ/fRx0rAyHSQSjDwAIIMbFFCvo
         NIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tYM6Z48tE1es4qqho5S1R8pWkhTPq5STOnsKYKK64dw=;
        b=dZ11wl3Sn55g/et78CMmh9zpj5Lf400kBY2SO94Lk8D8i6mFnf6BZGx2+RrR+CmXVJ
         McV8rJSQWxY5KVzsJ6UMhAP9aqAFNgStVtgeVQfx9pJz4AG0mMMG+x4GhsJoH3MszS8R
         trLs7dMlp8EEBeLzfcOosOkuwedCOag5+NDK0GUvQjtbcXkWusVpfL+cOb+5VYi2P612
         Mubehkb9/GRqsnczuu2nCNShWnjBYcNB0M2vNMG1OqPyZwSRMhYgxuaj+l8QtVvC/Qul
         cHhzoqn0DrG3ilSPH3s1CRKKo9hyP0fFHFMNXpbCoBD3KHoEPJD27l8hj4DsYfp87ZaD
         PeNQ==
X-Gm-Message-State: AOAM531tW6XAGqDstXUHp7kB2wzmCZpH6xq9/emokkClz4d+XkN8f2av
        YiKg9pZAiD6bw3EcNoHuJoATvq84
X-Google-Smtp-Source: ABdhPJzGaxrV6SIFzi4yKEuMHHhS448RKwy2teA5cJ94fw1Ru2vXzpjRPLZeywsGip+TbOEI8o6uKw==
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr16891105wrn.110.1596906082587;
        Sat, 08 Aug 2020 10:01:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm14730798wru.64.2020.08.08.10.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 10:01:22 -0700 (PDT)
Message-Id: <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
In-Reply-To: <pull.827.git.git.1596644952296.gitgitgadget@gmail.com>
References: <pull.827.git.git.1596644952296.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 Aug 2020 17:01:09 +0000
Subject: [PATCH v2 00/11] Start preparing merge-related tests to work with multiple merge backends
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series starts preparing the merge related tests to work with multiple
backends: merge-recursive or merge-ort. Further work will be coming.

v1 of this series only had the first patch (which collected merge machinery
related tests into t64*.sh). This series adds 10 more patches, which:

Changes since v1:

 * tighten some testcases so they don't pass with completely wrong results
 * fix various errors in causing many test_expect_failure tests to fail for
   the wrong reasons
 * add clarifying comments or fix various comments
 * make some tests more flexible in handling console output messages
   produced by either backend.
 * I'm curious about portability of the second-to-last patch -- is it safe
   to use backreferences with test_i18n_grep? If not, anyone have
   alternative ideas for handling those needed changes?

The greater flexibility patches at the end of the series also previews some
of the design changes being brought by merge-ort.

Elijah Newren (11):
  Collect merge-related tests to t64xx
  t6418: tighten delete/normalize conflict testcase
  t6422: fix bad check against missing file
  t6416, t6422: fix incorrect untracked file count
  t6423: fix test setup for a couple tests
  t6422: fix multiple errors with the mod6 test expectations
  t6416, t6423: clarify some comments and fix some typos
  t6423: add an explanation about why one of the tests does not pass
  t6422, t6426: be more flexible for add/add conflicts involving renames
  t642[23]: be more flexible for add/add conflicts involving pair
    renames
  t6425: be more flexible with rename/delete conflict messages

 t/{t6020-merge-df.sh => t6400-merge-df.sh}    |  0
 ...ss-cross.sh => t6401-merge-criss-cross.sh} |  0
 ...-merge-rename.sh => t6402-merge-rename.sh} |  0
 ...6023-merge-file.sh => t6403-merge-file.sh} |  0
 ...sive-merge.sh => t6404-recursive-merge.sh} |  0
 ...ge-symlinks.sh => t6405-merge-symlinks.sh} |  0
 ...6026-merge-attr.sh => t6406-merge-attr.sh} |  0
 ...-merge-binary.sh => t6407-merge-binary.sh} |  0
 ...p-to-date.sh => t6408-merge-up-to-date.sh} |  0
 ...erge-subtree.sh => t6409-merge-subtree.sh} |  0
 ...ge-filemode.sh => t6411-merge-filemode.sh} |  0
 ...-rename.sh => t6412-merge-large-rename.sh} |  0
 ...6033-merge-crlf.sh => t6413-merge-crlf.sh} |  0
 ...cruft.sh => t6414-merge-rename-nocruft.sh} |  0
 ...mlink.sh => t6415-merge-dir-to-symlink.sh} |  0
 ...ses.sh => t6416-recursive-corner-cases.sh} |  4 +-
 ...s-theirs.sh => t6417-merge-ours-theirs.sh} |  0
 ...-text-auto.sh => t6418-merge-text-auto.sh} |  3 +-
 ...gnorecase.sh => t6419-merge-ignorecase.sh} |  0
 ....sh => t6422-merge-rename-corner-cases.sh} | 68 +++++++++++--------
 ...s.sh => t6423-merge-rename-directories.sh} | 39 +++++++----
 ...=> t6424-merge-unrelated-index-changes.sh} |  0
 ...delete.sh => t6425-merge-rename-delete.sh} |  3 +-
 ...h => t6426-merge-skip-unneeded-updates.sh} |  2 +-
 ...ers.sh => t6427-diff3-conflict-markers.sh} |  0
 ...-recursive.sh => t6430-merge-recursive.sh} |  0
 ...-criscross.sh => t6431-merge-criscross.sh} |  0
 ...=> t6432-merge-recursive-space-options.sh} |  0
 ...ge-toplevel.sh => t6433-merge-toplevel.sh} |  0
 ...> t6434-merge-recursive-rename-options.sh} |  0
 ...-merge-sparse.sh => t6435-merge-sparse.sh} |  0
 ...-overwrite.sh => t6436-merge-overwrite.sh} |  0
 ...dule-merge.sh => t6437-submodule-merge.sh} |  0
 ...438-submodule-directory-file-conflicts.sh} |  0
 ...r-msgs.sh => t6439-merge-co-error-msgs.sh} |  0
 35 files changed, 71 insertions(+), 48 deletions(-)
 rename t/{t6020-merge-df.sh => t6400-merge-df.sh} (100%)
 rename t/{t6021-merge-criss-cross.sh => t6401-merge-criss-cross.sh} (100%)
 rename t/{t6022-merge-rename.sh => t6402-merge-rename.sh} (100%)
 rename t/{t6023-merge-file.sh => t6403-merge-file.sh} (100%)
 rename t/{t6024-recursive-merge.sh => t6404-recursive-merge.sh} (100%)
 rename t/{t6025-merge-symlinks.sh => t6405-merge-symlinks.sh} (100%)
 rename t/{t6026-merge-attr.sh => t6406-merge-attr.sh} (100%)
 rename t/{t6027-merge-binary.sh => t6407-merge-binary.sh} (100%)
 rename t/{t6028-merge-up-to-date.sh => t6408-merge-up-to-date.sh} (100%)
 rename t/{t6029-merge-subtree.sh => t6409-merge-subtree.sh} (100%)
 rename t/{t6031-merge-filemode.sh => t6411-merge-filemode.sh} (100%)
 rename t/{t6032-merge-large-rename.sh => t6412-merge-large-rename.sh} (100%)
 rename t/{t6033-merge-crlf.sh => t6413-merge-crlf.sh} (100%)
 rename t/{t6034-merge-rename-nocruft.sh => t6414-merge-rename-nocruft.sh} (100%)
 rename t/{t6035-merge-dir-to-symlink.sh => t6415-merge-dir-to-symlink.sh} (100%)
 rename t/{t6036-recursive-corner-cases.sh => t6416-recursive-corner-cases.sh} (99%)
 rename t/{t6037-merge-ours-theirs.sh => t6417-merge-ours-theirs.sh} (100%)
 rename t/{t6038-merge-text-auto.sh => t6418-merge-text-auto.sh} (99%)
 rename t/{t6039-merge-ignorecase.sh => t6419-merge-ignorecase.sh} (100%)
 rename t/{t6042-merge-rename-corner-cases.sh => t6422-merge-rename-corner-cases.sh} (94%)
 rename t/{t6043-merge-rename-directories.sh => t6423-merge-rename-directories.sh} (98%)
 rename t/{t6044-merge-unrelated-index-changes.sh => t6424-merge-unrelated-index-changes.sh} (100%)
 rename t/{t6045-merge-rename-delete.sh => t6425-merge-rename-delete.sh} (72%)
 rename t/{t6046-merge-skip-unneeded-updates.sh => t6426-merge-skip-unneeded-updates.sh} (99%)
 rename t/{t6047-diff3-conflict-markers.sh => t6427-diff3-conflict-markers.sh} (100%)
 rename t/{t3030-merge-recursive.sh => t6430-merge-recursive.sh} (100%)
 rename t/{t3031-merge-criscross.sh => t6431-merge-criscross.sh} (100%)
 rename t/{t3032-merge-recursive-space-options.sh => t6432-merge-recursive-space-options.sh} (100%)
 rename t/{t3033-merge-toplevel.sh => t6433-merge-toplevel.sh} (100%)
 rename t/{t3034-merge-recursive-rename-options.sh => t6434-merge-recursive-rename-options.sh} (100%)
 rename t/{t3035-merge-sparse.sh => t6435-merge-sparse.sh} (100%)
 rename t/{t7607-merge-overwrite.sh => t6436-merge-overwrite.sh} (100%)
 rename t/{t7405-submodule-merge.sh => t6437-submodule-merge.sh} (100%)
 rename t/{t7613-merge-submodule.sh => t6438-submodule-directory-file-conflicts.sh} (100%)
 rename t/{t7609-merge-co-error-msgs.sh => t6439-merge-co-error-msgs.sh} (100%)


base-commit: dc04167d378fb29d30e1647ff6ff51dd182bc9a3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-827%2Fnewren%2Fmerge-test-rename-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-827/newren/merge-test-rename-v2
Pull-Request: https://github.com/git/git/pull/827

Range-diff vs v1:

  1:  3a2b7e9743 =  1:  3a2b7e9743 Collect merge-related tests to t64xx
  -:  ---------- >  2:  621c9a159e t6418: tighten delete/normalize conflict testcase
  -:  ---------- >  3:  7f408b7d40 t6422: fix bad check against missing file
  -:  ---------- >  4:  9ce80f2f94 t6416, t6422: fix incorrect untracked file count
  -:  ---------- >  5:  382d65649d t6423: fix test setup for a couple tests
  -:  ---------- >  6:  56e169b1d8 t6422: fix multiple errors with the mod6 test expectations
  -:  ---------- >  7:  7b534d123a t6416, t6423: clarify some comments and fix some typos
  -:  ---------- >  8:  f2d7e744fc t6423: add an explanation about why one of the tests does not pass
  -:  ---------- >  9:  b4e165eca4 t6422, t6426: be more flexible for add/add conflicts involving renames
  -:  ---------- > 10:  a9a02a0ca5 t642[23]: be more flexible for add/add conflicts involving pair renames
  -:  ---------- > 11:  38f6573511 t6425: be more flexible with rename/delete conflict messages

-- 
gitgitgadget
