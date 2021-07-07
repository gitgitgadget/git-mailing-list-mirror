Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CC8C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 19:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42E3361CC2
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 19:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhGGTKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 15:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhGGTKd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 15:10:33 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2198C061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 12:07:52 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id g8-20020a1c9d080000b02901f13dd1672aso3728007wme.0
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 12:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=3U8V5B2uSD6BZSEQy6aBz7kQJhZle2T68Hk3c9vC3XA=;
        b=Au+8oTARs+++LocGwK4VzA/jNbhvfitGnn1d5E2kpfsAcWHwAhyW++g3pFbGHUGv+v
         1xEi5hFiXPubBUm4T8a+59wSC+TKb6misJpXFwFSAxofihFUUQFXhX/4K3bgTQRpo9R6
         +aWr07F9E3z6GrsJvKHEgPoExVmHP3DeVpieUIssP6a0HrjUTFzm4LL6zyEo4S5Pd86s
         3oAkq3ptz1O+XvvTHTQcg0pGqb2O923TCo8d/LMQtsMFrqP4JrdcrJX6rtR5ez+truBz
         4qLfDXzuF9kaqQDKYhTPAhpZjP4902xlk7gHO+uYbKUOrVeXt0sa019gHqP4E0O6K+S6
         xulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=3U8V5B2uSD6BZSEQy6aBz7kQJhZle2T68Hk3c9vC3XA=;
        b=MJ/+SCA9D/kwXXuYQUh3kQPjXvtrfVv5Mme58sIRz/6McLVXXKHVlgL535Z5SmEGBW
         usOyE0Yf7SvmTnVj+ovQW+aVJ2sh0CJ/nzk1I4thsBCgJe2edNKiNKzeeUboS0+6lRkv
         qPNKKq2rgHezzN76kBq2PGOcefqxDkbl8C9NKH4/rM5/ZI5V+Z/wMTuCUbVQImCHBZqa
         bmCclFa/zlusi0p0RM2H5iRrUb9+rhr2dzkBDQVbK63j4A8QDLHAVj0qoSvzAYvPmmth
         04C2SC12lDteWIgSFcJPrhzbJQ4isuasvSTWH9bl99uq6R28ABzW2qjINatWd3ij5N6L
         eWtw==
X-Gm-Message-State: AOAM531qSWtQnWfZ1GuZxZRSEkaSGdil41wfRgSZEh5/gGej0Kdbz3Hw
        UQt+toIRyk47WqbwpPVdJ49oGcLVIRA=
X-Google-Smtp-Source: ABdhPJw3B0vX1uVZWJb0Y3kwf7yYkbD7hCNDhUPETLew9P5r6aTLsBsHbCKKkUrcmBQVIYvusUx1ow==
X-Received: by 2002:a05:600c:154d:: with SMTP id f13mr10971590wmg.139.1625684871355;
        Wed, 07 Jul 2021 12:07:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w22sm7205299wmc.4.2021.07.07.12.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 12:07:50 -0700 (PDT)
Message-Id: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
References: <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Jul 2021 19:07:43 +0000
Subject: [PATCH v5 0/6] refs: cleanup errno sideband ref related functions
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

 refs.c                | 58 ++++++++++++++++++++++-----------
 refs/debug.c          |  4 +--
 refs/files-backend.c  | 74 ++++++++++++++++++++++---------------------
 refs/packed-backend.c | 15 +++++----
 refs/refs-internal.h  | 40 +++++++++++++++--------
 5 files changed, 115 insertions(+), 76 deletions(-)


base-commit: 670b81a890388c60b7032a4f5b879f2ece8c4558
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1012%2Fhanwen%2Feinval-sideband-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1012/hanwen/einval-sideband-v5
Pull-Request: https://github.com/git/git/pull/1012

Range-diff vs v4:

 1:  d6a41c3c0cb = 1:  d6a41c3c0cb refs: remove EINVAL errno output from specification of read_raw_ref_fn
 2:  ff7ea6efcba ! 2:  95025080c16 refs/files-backend: stop setting errno from lock_ref_oid_basic
     @@ Commit message
          documented to use and/or preserve errno)
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     -    Reviewed-By: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## refs/files-backend.c ##
      @@ refs/files-backend.c: static int create_reflock(const char *path, void *cb)
 3:  ff5696b0875 ! 3:  7feedb97201 refs: make errno output explicit for read_raw_ref_fn
     @@ Commit message
          relevant.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     -    Reviewed-By: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## refs.c ##
      @@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store,
 4:  9c933706cb0 ! 4:  ef91f5cee13 refs: add failure_errno to refs_read_raw_ref() signature
     @@ Commit message
          This lets us use the explicit errno output parameter in refs_resolve_ref_unsafe.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     -    Reviewed-By: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## refs.c ##
      @@ refs.c: done:
     @@ refs.c: done:
      -int refs_read_raw_ref(struct ref_store *ref_store,
      -		      const char *refname, struct object_id *oid,
      -		      struct strbuf *referent, unsigned int *type)
     +-{
     +-	int result;
     +-	int failure_errno;
      +int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
      +		      struct object_id *oid, struct strbuf *referent,
      +		      unsigned int *type, int *failure_errno)
     - {
     --	int result;
     --	int failure_errno;
     -+	int ignore;
     -+	if (failure_errno)
     -+		*failure_errno = 0;
     -+	else
     -+		failure_errno = &ignore;
     -+
     ++{
     ++	int unused_errno;
     ++	if (!failure_errno)
     ++		failure_errno = &unused_errno;
     ++	*failure_errno = 0;
       	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
       		return refs_read_special_head(ref_store, refname, oid, referent,
       					      type);
 5:  ab147afb38d ! 5:  6918c214d1b refs: explicitly return failure_errno from parse_loose_ref_contents
     @@ Commit message
          to create a custom error message.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     -    Reviewed-By: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## refs.c ##
      @@ refs.c: int for_each_fullref_in_prefixes(const char *namespace,
     @@ refs.c: static int refs_read_special_head(struct ref_store *ref_store,
       done:
       	strbuf_release(&full_path);
      @@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
     - 
     + 	*failure_errno = 0;
       	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
       		return refs_read_special_head(ref_store, refname, oid, referent,
      -					      type);
     @@ refs/files-backend.c: stat_ref:
      +	ret = parse_loose_ref_contents(buf, oid, referent, type, failure_errno);
      +	errno = *failure_errno;
       out:
     -+	/* Collect all types of failures from errno. Many system calls in this
     -+	 * function can fail with ENOTDIR/EISDIR, and we want to collect all of
     -+	 * them.
     ++	/*
     ++	 * Many system calls in this function can fail with ENOTDIR/EISDIR, and
     ++	 * we want to collect all of them, so simply copy the error out from
     ++	 * errno.
      +	 */
       	*failure_errno = errno;
       	strbuf_release(&sb_path);
 6:  0526a41b4b3 ! 6:  85a14bde904 refs: make errno output explicit for refs_resolve_ref_unsafe
     @@ Commit message
          that needs error information to make logic decisions, so update that caller
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     -    Reviewed-By: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## refs/files-backend.c ##
      @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,

-- 
gitgitgadget
