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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659A8C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C36161C30
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhGFS6k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 14:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhGFS6k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 14:58:40 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A4AC061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 11:56:00 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id h18-20020a05600c3512b029020e4ceb9588so2511409wmq.5
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 11:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=zzaEQ2OGypKG1Xq5Wrt+hqbms2O/4R/XVdSG7oP17RQ=;
        b=vQpjnaTSNonkzjdwkmfBnyJVFIZf7b1EpZo1VPqPRpXn6sLKFgDKwb6zS5QHLaj477
         ckzsO5wv3QuAJgB/YC1csYuGWTPWlTaWALQHbltNJxb/QoE4dgY065AYdr3MysMpdwi8
         tH4ZI+fXVV6p6F/WzLMlqd8OllkKEyH9+ElhCGtkVTURHYEjMkhiJ4k0YKX/9y+AnEDZ
         usDKMYf8VcnXedBuBGuCfBEZGN2dju4gC6opESv7ZFKAvvoL91IXILXuvcpdiHhaNPbx
         NHqk+f8ZkPd/aC4k8dEaXmRevg6JZNOBTq9wcLE3QO+sq21q/PFrePSz49xKNWrPeugI
         iSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=zzaEQ2OGypKG1Xq5Wrt+hqbms2O/4R/XVdSG7oP17RQ=;
        b=TxFOb/EfZu6NIN8DCp9FSK/8pwtLG5qeQ3FKshiWcyWGRcPvS7hwoFkP0FilLE8dyP
         NN+OQwZpRl955jogKAELbPHzU0I11M9bK840m6/cZwOz/pNg/583CJJq+qpIquJ5BUAv
         Cr7n0gSo/96Do3jjiGtRl+X4DGVj+SfMTCj1SeLZ7ca3S3ljbJriqRIuxOrc3XZJBhvy
         7hmx108etKNGWUqOwQHoORQGjFbv1Uiku83eE7Ie9DsXYnxLw7cXS3+aYa2hfcWPCCdY
         SutBqJbdXJ8jr76gjkwd1Dc+4fcRjdrKJlgPWLG/91KFRsxUODafZYmL8RZHuehU9A3T
         l0Xg==
X-Gm-Message-State: AOAM533yl9/Df46lCMjerLGuRvhGjYYQGzlxFNu7CRRSFCGxNbcPzFRU
        8C6AaQdfyYhcodalYpTbbvBhJfMBrYM=
X-Google-Smtp-Source: ABdhPJxzFy2pGxvHYI6CE8zae1sHqh2dHFJrzxhLgWtudQTQ9oPdWDwUwPVCbTh3/DwMMFFTGBjIqw==
X-Received: by 2002:a1c:25c6:: with SMTP id l189mr2495831wml.49.1625597758801;
        Tue, 06 Jul 2021 11:55:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r16sm20969063wrx.63.2021.07.06.11.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 11:55:58 -0700 (PDT)
Message-Id: <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v3.git.git.1625518566.gitgitgadget@gmail.com>
References: <pull.1012.v3.git.git.1625518566.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jul 2021 18:55:51 +0000
Subject: [PATCH v4 0/6] refs: cleanup errno sideband ref related functions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v5

 * address Ævar's comment; punt on clearing errno.

Han-Wen Nienhuys (6):
  refs: remove EINVAL errno output from specification of read_raw_ref_fn
  refs/files-backend: stop setting errno from lock_ref_oid_basic
  refs: make errno output explicit for read_raw_ref_fn
  refs: add failure_errno to refs_read_raw_ref() signature
  refs: explicitly return failure_errno from parse_loose_ref_contents
  refs: make errno output explicit for refs_resolve_ref_unsafe

 refs.c                | 60 ++++++++++++++++++++++++-----------
 refs/debug.c          |  4 +--
 refs/files-backend.c  | 73 ++++++++++++++++++++++---------------------
 refs/packed-backend.c | 15 ++++-----
 refs/refs-internal.h  | 40 ++++++++++++++++--------
 5 files changed, 116 insertions(+), 76 deletions(-)


base-commit: 670b81a890388c60b7032a4f5b879f2ece8c4558
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1012%2Fhanwen%2Feinval-sideband-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1012/hanwen/einval-sideband-v4
Pull-Request: https://github.com/git/git/pull/1012

Range-diff vs v3:

 1:  e2a0e5387ab ! 1:  d6a41c3c0cb refs: remove EINVAL errno output from specification of read_raw_ref_fn
     @@ Commit message
          Spotted by Ævar Arnfjörð Bjarmason <avarab@gmail.com>.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     -    Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
      
       ## refs/refs-internal.h ##
      @@ refs/refs-internal.h: typedef int reflog_expire_fn(struct ref_store *ref_store,
 2:  c594c9c5c67 ! 2:  ff7ea6efcba refs/files-backend: stop setting errno from lock_ref_oid_basic
     @@ Commit message
          documented to use and/or preserve errno)
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     -    Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
     -    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     +    Reviewed-By: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## refs/files-backend.c ##
      @@ refs/files-backend.c: static int create_reflock(const char *path, void *cb)
 3:  b017caf54ba ! 3:  ff5696b0875 refs: make errno output explicit for read_raw_ref_fn
     @@ Commit message
          relevant.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     -    Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
     -    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     +    Reviewed-By: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## refs.c ##
      @@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store,
 4:  4aaa9d3bd6f ! 4:  9c933706cb0 refs: add failure_errno to refs_read_raw_ref() signature
     @@ Commit message
          This lets us use the explicit errno output parameter in refs_resolve_ref_unsafe.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     -    Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
     -    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     +    Reviewed-By: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## refs.c ##
      @@ refs.c: done:
 -:  ----------- > 5:  ab147afb38d refs: explicitly return failure_errno from parse_loose_ref_contents
 5:  ed5347d7bb6 ! 6:  0526a41b4b3 refs: make errno output explicit for refs_resolve_ref_unsafe
     @@ Commit message
          that needs error information to make logic decisions, so update that caller
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     -    Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
     -    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     +    Reviewed-By: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## refs/files-backend.c ##
      @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,

-- 
gitgitgadget
