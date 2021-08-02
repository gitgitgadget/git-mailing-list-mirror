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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9DDC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9583A61102
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhHBQxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhHBQxs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 12:53:48 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5BFC06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 09:53:38 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l11-20020a7bcf0b0000b0290253545c2997so376736wmg.4
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 09:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0JdD2c36sKZIqw5rMS7cinhxygxzkLfXg9PMlncLUZU=;
        b=il7tDKNSrvVSEw3nogDA9CSKHFD08TjVuHzDsslSIoVJ6TurFgSQaAgSm07dQglyV5
         x4YAH6CK31Y0UzAvqo+lKn5fTqkXq3Jn1HmMhKIVihO2mSpLtxjmbKK8QwlFEAvHuZ7N
         XmTca+EmTGsHMbFlzSC0H11Vs1L4DeVKhIJHS7SeZAVJlcPNVAwGNrMmu8S6Me8sW2dM
         CIMPjNMMK81uXxDXo+2tn439gQg27DgGNhRYdO735Po9NItm3FgomhJxnqDFcjwWCNuc
         tHhXD9xx74D3Bl47ZWfjshjVTawxbSTuCfORSHzcSADPMhxVk5J3APqlrkYsnIdLo9Z0
         MsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0JdD2c36sKZIqw5rMS7cinhxygxzkLfXg9PMlncLUZU=;
        b=LN8g33UFiZDM9t02esDdltUi0QGGZ6iLyjimxdB1YTSsEf/1k4Ln5sFxf9A+SaXD1r
         d77Q91IHN7DH938APHUXeXl7RSqIeVhiLd/JwccQRmSwE8e1zowSqwmr2pOTuAOj7hDD
         f+bnlqCwMUGKP2YnexPLXzeO7gMVH6D4pjQqPL+TBQCab8uD9u1t76zCaeORO5r+6Clc
         /eZWlX+43u7B0znqwTxVcV/d5PmRVKRjIHS2MmaRkOTE0GjYP7YTMk0GD4LpAp9tz06c
         F63R+HfrNXWeaPsV2XUfrrRWtuhUnPbiW4IBUywOuf4c1TfpfsUHug1qQd/Io79hCvdZ
         eqQA==
X-Gm-Message-State: AOAM531toZCXDzwDuCwF1SLKsPKinsCisv9WTEA8wTgCnlInT7Ti8h8T
        Rg4wwadiT2ujHX72EC3DK8dIsjZpNrA=
X-Google-Smtp-Source: ABdhPJywb7RGPQCFAmQyHBlFhY2rqf9wMh8zk3+prpCaHRHJfW8Cy6QHqf7PU2WD81Y6X72+PUd/GQ==
X-Received: by 2002:a1c:1d44:: with SMTP id d65mr17761489wmd.181.1627923217590;
        Mon, 02 Aug 2021 09:53:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17sm5456566wrw.17.2021.08.02.09.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 09:53:37 -0700 (PDT)
Message-Id: <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
References: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 16:53:25 +0000
Subject: [PATCH v3 00/11] Fix direct filesystem access in various test files.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a few test failures in the reftable series.

Han-Wen Nienhuys (11):
  t6050: use git-update-ref rather than filesystem access
  t1503: mark symlink test as REFFILES
  t6120: use git-update-ref rather than filesystem access
  t3320: use git-symbolic-ref rather than filesystem access
  t2402: use ref-store test helper to create broken symlink
  t1405: use 'git reflog exists' to check reflog existence
  t1405: mark test for 'git pack-refs' as REFFILES
  t1410: mark test as REFFILES
  t7064: use update-ref -d to remove upstream branch
  t6500: use "ls -1" to snapshot ref database state
  t6001: avoid direct file system access

 t/t1405-main-ref-store.sh        | 18 ++++++++++++------
 t/t1410-reflog.sh                |  4 +++-
 t/t1503-rev-parse-verify.sh      |  2 +-
 t/t2402-worktree-list.sh         |  2 +-
 t/t3320-notes-merge-worktrees.sh | 12 +++++++-----
 t/t6001-rev-list-graft.sh        |  3 ++-
 t/t6050-replace.sh               |  2 +-
 t/t6120-describe.sh              |  6 ++++--
 t/t6500-gc.sh                    |  5 +++--
 t/t7064-wtstatus-pv2.sh          |  5 +----
 10 files changed, 35 insertions(+), 24 deletions(-)


base-commit: 940fe202adcbf9fa1825c648d97cbe1b90d26aec
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1052%2Fhanwen%2Ftest-fixes-v3-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1052/hanwen/test-fixes-v3-v3
Pull-Request: https://github.com/git/git/pull/1052

Range-diff vs v2:

  1:  d7616038d88 =  1:  ad9fd570024 t6050: use git-update-ref rather than filesystem access
  2:  cbd2128c331 =  2:  b03be9ede7f t1503: mark symlink test as REFFILES
  3:  cbf90c13e5b =  3:  b62c3175c4c t6120: use git-update-ref rather than filesystem access
  4:  7b98d092811 =  4:  22bff0b0791 t3320: use git-symbolic-ref rather than filesystem access
  5:  0047266de6b =  5:  ceca139bcfc t2402: use ref-store test helper to create broken symlink
  6:  eb2c53d19cf =  6:  add97ad8d0b t1405: use 'git reflog exists' to check reflog existence
  7:  05dead16f1c !  7:  5f9a01fd86a t1405: mark test for 'git pack-refs' as REFFILES
     @@ Metadata
       ## Commit message ##
          t1405: mark test for 'git pack-refs' as REFFILES
      
     -    The outcome of the pack-refs operation is not checked. This was apparently
     -    forgotten in the commit introducing this test: 16feb99d (Mar 26 2017, "t1405:
     -    some basic tests on main ref store").
     +    The tests verifies that "pack-refs" causes loose refs to be packed. As both
     +    loose and packed refs are concepts specific to the files backend, mark the test
     +    as REFFILES.
      
     -    I tried adding the obvious check this, but it seems to fail on the freebsd_12
     -    builder.
     +    Check the outcome of the pack-refs operation. This was apparently forgotten in
     +    the commit introducing this test: 16feb99d (Mar 26 2017, "t1405: some basic
     +    tests on main ref store").
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     @@ t/t1405-main-ref-store.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      +test_expect_success REFFILES 'pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE)' '
       	N=`find .git/refs -type f | wc -l` &&
       	test "$N" != 0 &&
     - 	$RUN pack-refs 3 &&
     +-	$RUN pack-refs 3 &&
     +-	N=`find .git/refs -type f | wc -l`
     ++	ALL_OR_PRUNE_FLAG=3 &&
     ++	$RUN pack-refs ${ALL_OR_PRUNE_FLAG} &&
     ++	N=`find .git/refs -type f` &&
     ++	test -z "$N"
     + '
     + 
     + test_expect_success 'create_symref(FOO, refs/heads/main)' '
  8:  f931a26de58 !  8:  45bc0772c64 t1410: mark test as REFFILES
     @@ Metadata
       ## Commit message ##
          t1410: mark test as REFFILES
      
     -    In reftable, one cannot take a lock on an individual ref.
     +    This test takes a lock on the target of a symref, and then verifies that it is
     +    possible to expire the symref's reflog. In reftable, one can only take a global
     +    lock (which would prevent the symref reflog from being expired altogether.)
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
  9:  3685ba90f60 =  9:  1326e99a1fd t7064: use update-ref -d to remove upstream branch
 10:  ccdbf3749fe ! 10:  55eb2094811 t6500: use "ls -1" to snapshot ref database state
     @@ Commit message
          By doing ls -1 .git/{reftable,refs/heads}, we can capture changes to both
          reftable and packed/loose ref storage.
      
     +    This relies on the fact that git-pack-refs (which we're looking for here)
     +    changes the number (loose/packed storage) and/or names (reftable) files used for
     +    ref storage.
     +
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## t/t6500-gc.sh ##
 11:  81e46f95536 = 11:  4a3418b7954 t6001: avoid direct file system access

-- 
gitgitgadget
