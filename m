Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1A7C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 00:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhKWAXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 19:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhKWAXn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 19:23:43 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5152EC061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 16:20:36 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 133so17125675wme.0
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 16:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JrtZYcl3YI0VdLJyeZJK/97YtbXnVYLsJw75ivmGnos=;
        b=jCecbR83smXQfQwEXDR8/L4RlVVcMU5SuNm+Xhh2RHi7hCGVs9JWU3VnTCjq7Yfcf/
         KYqnV0mMvqr9Y0ZpqfL/8oie5y0nNAEbZ71IZHkg7gnUI/QnpKBpSP7wIGeImcpC5nR5
         Mf0VtO+OysXy38ZXHIxpsJc2tIjiYGGAaT5WMZJe2FAKRbV0i4xXZH90eJoKqVFhBQ+R
         vc+m4Q6IUr12YOg4Vud66q6O0ELoem1CqPkuJZmniffhWv5GPh5fTYqQwomnVBsobx5h
         NOP9TyfnQUnIDnnND9gdpiJPtf99CZzFVIwYxDgXjFaIJEN/tIuFka4ZJ+iZYvMw+2Lg
         4+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JrtZYcl3YI0VdLJyeZJK/97YtbXnVYLsJw75ivmGnos=;
        b=hwZ6Jf/G7npHV8dbqsmo2HA1G70NVfVx9TjV4RH8XduGLsUGcpx5Xi81I29CEehDwp
         a+5vgOyxWgdhrgMDUStSkju6+QFOVRNvYlDex6841Dyq2DZd/YtGYtq7vrEi32uw/tOJ
         QSxjjnl1uEUt6NlSiJSE+/gsecziAY1one45YgSTpBqOCB14AaHqL0nT9zu5CspJ9z5w
         leT2tWJmo/fhGzHhjH7nwq9c0KOngSRL9VRiFX1LMLSgC6bOmZYt2knyUu9J8vxf71Xe
         ktaPzMKtns72UlVpKrzK5QPCbygeXzJZXgbJy49OK67gCgyxpkv+bdufeKj8iXam0VJe
         FP1A==
X-Gm-Message-State: AOAM531RYSKC8iGPi5KIk58ZCsgYA+lLhb3WnKWQvdDbwzoP1q5zix0R
        5ISno92UZ9J6ymyrXzb8D6O+GvDisHg=
X-Google-Smtp-Source: ABdhPJySX4BFBiJ2qn2e30UBRbH4FSfgUnxtjjb5uVrvD3TzJ1wMZNRp0VYZ7f1NmiLt2IfmFDHlXg==
X-Received: by 2002:a05:600c:2c4a:: with SMTP id r10mr35825649wmg.125.1637626834743;
        Mon, 22 Nov 2021 16:20:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15sm9803799wrr.65.2021.11.22.16.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 16:20:34 -0800 (PST)
Message-Id: <pull.1059.v5.git.1637626833.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v4.git.1635515487.gitgitgadget@gmail.com>
References: <pull.1059.v4.git.1635515487.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Nov 2021 00:20:29 +0000
Subject: [PATCH v5 0/4] sparse-index: expand/collapse based on 'index.sparse'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series updates do_read_index to use the index.sparse config setting
when determining whether the index should be expanded or collapsed. If the
command & repo allow use of a sparse index, index.sparse is enabled, and a
full index is read from disk, the index is collapsed before returning to the
caller. Conversely, if index.sparse is disabled but the index read from disk
is sparse, the index is expanded before returning. This allows index.sparse
to control use of the sparse index in addition to its existing control over
how the index is written to disk. It also introduces the ability to
enable/disable the sparse index on a command-by-command basis (e.g.,
allowing a user to troubleshoot a sparse-aware command with '-c
index.sparse=false' [1]).

While testing this change, a bug was found in 'test-tool read-cache' in
which config settings for the repository were not initialized before
preparing the repo settings. This caused index.sparse to always be 'false'
when using the test helper in a cone-mode sparse checkout, breaking tests in
t1091 and t1092. The issue is fixed by moving prepare_repo_settings after
config setup.


Changes since V1
================

 * Add ensure_correct_sparsity function that ensures the index is sparse if
   the repository settings (including index.sparse) allow it, otherwise
   ensuring the index is expanded to full.
 * Restructure condition in do_read_index to, rather than check specifically
   for the index.sparse config setting, call ensure_correct_sparsity
   unconditionally when command_requires_full_index is false.


Changes since V2
================

 * Rename can_convert_to_sparse to is_sparse_index_allowed to more
   accurately reflect what the function returns.
 * Remove index-iterating checks from is_sparse_index_allowed, leaving only
   inexpensive checks on config settings & sparse checkout patterns. Checks
   are still part of convert_to_sparse to ensure it behaves exactly as it
   did before this series.
 * Restructure ensure_correct_sparsity for better readability.
 * Fix test_env variable scope.


Changes since V3
================

 * Add a new patch to avoid unnecessary cache tree free/recreation when
   possible in convert_to_sparse.


Changes since V4
================

 * Updated patch 4/4 commit message to better explain practical reasons for
   making this change.

[1]
https://lore.kernel.org/git/cc60c6e7-ecef-ae22-8ec7-ab290ff2b830@gmail.com/

Thanks! -Victoria

Victoria Dye (4):
  test-read-cache.c: prepare_repo_settings after config init
  sparse-index: avoid unnecessary cache tree clearing
  sparse-index: add ensure_correct_sparsity function
  sparse-index: update do_read_index to ensure correct sparsity

 read-cache.c                             |  8 ++++
 sparse-index.c                           | 58 ++++++++++++++++++------
 sparse-index.h                           |  1 +
 t/helper/test-read-cache.c               |  5 +-
 t/t1092-sparse-checkout-compatibility.sh | 31 +++++++++++++
 5 files changed, 86 insertions(+), 17 deletions(-)


base-commit: f443b226ca681d87a3a31e245a70e6bc2769123c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1059%2Fvdye%2Fsparse%2Findex-sparse-config-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1059/vdye/sparse/index-sparse-config-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1059

Range-diff vs v4:

 1:  6974ce7e7f5 = 1:  6974ce7e7f5 test-read-cache.c: prepare_repo_settings after config init
 2:  91351ac4bde = 2:  91351ac4bde sparse-index: avoid unnecessary cache tree clearing
 3:  d2133ca1724 = 3:  d2133ca1724 sparse-index: add ensure_correct_sparsity function
 4:  b67cd9d07f8 ! 4:  3237a519c80 sparse-index: update do_read_index to ensure correct sparsity
     @@ Metadata
       ## Commit message ##
          sparse-index: update do_read_index to ensure correct sparsity
      
     -    If `command_requires_full_index` is false, ensure correct in-core index
     -    sparsity on read by calling `ensure_correct_sparsity`. This change is meant
     -    to update the how the index is read in a command after sparse index-related
     -    repository settings are modified. Previously, for example, if `index.sparse`
     -    were changed from `true` to `false`, the in-core index on the next command
     -    would be sparse. The index would only be expanded to full when it was next
     -    written to disk.
     +    Unless `command_requires_full_index` forces index expansion, ensure in-core
     +    index sparsity matches config settings on read by calling
     +    `ensure_correct_sparsity`. This makes the behavior of the in-core index more
     +    consistent between different methods of updating sparsity: manually changing
     +    the `index.sparse` config setting vs. executing
     +    `git sparse-checkout --[no-]sparse-index init`
      
     -    By adding a call to `ensure_correct_sparsity`, the in-core index now matches
     -    the sparsity dictated by the relevant repository settings as soon as it is
     -    read into memory, rather than when it is later written to disk.
     +    Although index sparsity is normally updated with `git sparse-checkout init`,
     +    ensuring correct sparsity after a manual `index.sparse` change has some
     +    practical benefits:
     +
     +    1. It allows for command-by-command sparsity toggling with
     +       `-c index.sparse=<true|false>`, e.g. when troubleshooting issues with the
     +       sparse index.
     +    2. It prevents users from experiencing abnormal slowness after setting
     +       `index.sparse` to `true` due to use of a full index in all commands until
     +       the on-disk index is updated.
      
          Helped-by: Junio C Hamano <gitster@pobox.com>
          Co-authored-by: Derrick Stolee <dstolee@microsoft.com>

-- 
gitgitgadget
