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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E92C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 20:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 526F461983
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 20:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhGEU6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 16:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhGEU6q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 16:58:46 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF703C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 13:56:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v5so23490617wrt.3
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 13:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2hzK5kYCwkR6Nfq4Fy1aGmj6L5M9JpV+bfflwszRkaY=;
        b=FQkT1MNMJTu+C3KRE2oHegtEQrLNtFv4GbxsJeBrb451J/cCQlG29dA/9wnLeRxdWF
         SmkuK2DOqSATs88xXCQDZoxLbGpSStUCKlhfioTZXydS4SW6oCA55IW92+mkEbCjwWEf
         uO51a3uqbKA7puA7he52Nxqbr9uGIpEVwmuR8N/0N0uQglpjBP+OstqrOTSlRV0gl6zK
         yNaHcx00QR5p6+DAeKSqThmJndr3O+bd6Sd9ubMN1lmB6nFIZg733NcqGVfiwSuFntY8
         sbhtbUJZ/wp3+Y1Kt5O2gLxD8qLBzjm9x2uyMzjlkvNjjZwWOXYMwg+RA/TIw6SWuR+s
         WJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=2hzK5kYCwkR6Nfq4Fy1aGmj6L5M9JpV+bfflwszRkaY=;
        b=EwggTYHseTgvfA48t9sgoav3swriNhAKhle0LMHa/bznjwK7pYpO1UfFw6P78bO64Y
         To64QM7CkQW9XzCwh9alixhBzTPH5dxpTfVbQZbKe0H/xZwoCSm0s7bpHHdLPvab4G78
         cT5z0MlzQ7ELXYuyBH5dPSrFM/Q5GrYwRYwO2CswbqrfEmibdQ76SHAa7ynBVn0juuE7
         L1mRnn0xaQQhq67VuJZbHLhPLqzdLRfaV8h91bX7l1WxbNmpYxNsyiQnuKoalJj3XZ9K
         tveDmh1o9MvkcOiVU9WuasR0lUj1OhiUW5+UbXzMWNBEnkVAhgWdf6tRCTwhsVDgcej1
         n99g==
X-Gm-Message-State: AOAM530t3sXLDkKUZo3Nu7kUlRw0Xajvba/2kOI7vmeomaR1l+qS/pLD
        nB6/eoSWbNpECNkScpNqFc+rKirojE4=
X-Google-Smtp-Source: ABdhPJw3DQv3QPAmzQ0zK8cbts0Ws0P6z7OMrhScNdAlsrD6492LWB2ohAtjWsKLplJUuN3SREjc6g==
X-Received: by 2002:adf:8bc9:: with SMTP id w9mr17194256wra.378.1625518567482;
        Mon, 05 Jul 2021 13:56:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18sm14770622wru.53.2021.07.05.13.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 13:56:07 -0700 (PDT)
Message-Id: <pull.1012.v3.git.git.1625518566.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
References: <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Jul 2021 20:56:00 +0000
Subject: [PATCH v3 0/5] refs: cleanup errno sideband ref related functions
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

Han-Wen Nienhuys (5):
  refs: remove EINVAL errno output from specification of read_raw_ref_fn
  refs/files-backend: stop setting errno from lock_ref_oid_basic
  refs: make errno output explicit for read_raw_ref_fn
  refs: add failure_errno to refs_read_raw_ref() signature
  refs: make errno output explicit for refs_resolve_ref_unsafe

 refs.c                | 52 ++++++++++++++++++++++++++-----------
 refs/debug.c          |  4 +--
 refs/files-backend.c  | 60 ++++++++++++++++++++-----------------------
 refs/packed-backend.c | 15 ++++++-----
 refs/refs-internal.h  | 34 ++++++++++++++++--------
 5 files changed, 98 insertions(+), 67 deletions(-)


base-commit: 670b81a890388c60b7032a4f5b879f2ece8c4558
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1012%2Fhanwen%2Feinval-sideband-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1012/hanwen/einval-sideband-v3
Pull-Request: https://github.com/git/git/pull/1012

Range-diff vs v2:

 1:  f9b92e62b59 = 1:  e2a0e5387ab refs: remove EINVAL errno output from specification of read_raw_ref_fn
 2:  cbe09a48036 ! 2:  c594c9c5c67 refs/files-backend: stop setting errno from lock_ref_oid_basic
     @@ Commit message
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
          Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## refs/files-backend.c ##
      @@ refs/files-backend.c: static int create_reflock(const char *path, void *cb)
     @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_re
      -		last_errno = errno;
      +		int last_errno = errno;
       		if (last_errno != ENOTDIR ||
     - 		    !refs_verify_refname_available(&refs->base, refname,
     - 						   extras, skip, err))
     +-		    !refs_verify_refname_available(&refs->base, refname,
     +-						   extras, skip, err))
     ++		    /* in case of D/F conflict, try to generate a better error
     ++		     * message. If that fails, fall back to strerror(ENOTDIR).
     ++		     */
     ++		    !refs_verify_refname_available(&refs->base, refname, extras,
     ++						   skip, err))
     + 			strbuf_addf(err, "unable to resolve reference '%s': %s",
     + 				    refname, strerror(last_errno));
     + 
      @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
       	if (is_null_oid(&lock->old_oid) &&
       	    refs_verify_refname_available(refs->packed_ref_store, refname,
 3:  3e2831e59c8 ! 3:  b017caf54ba refs: make errno output explicit for read_raw_ref_fn
     @@ Metadata
       ## Commit message ##
          refs: make errno output explicit for read_raw_ref_fn
      
     +    This makes it explicit how alternative ref backends should report errors in
     +    read_raw_ref_fn.
     +
          read_raw_ref_fn needs to supply a credible errno for a number of cases. These
          are primarily:
      
     @@ Commit message
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
          Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## refs.c ##
      @@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store,
       		      const char *refname, struct object_id *oid,
       		      struct strbuf *referent, unsigned int *type)
       {
     -+	int result, failure;
     ++	int result;
     ++	int failure_errno;
       	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
       		return refs_read_special_head(ref_store, refname, oid, referent,
       					      type);
     @@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store,
       
      -	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
      -					   type);
     -+	failure = 0;
     ++	failure_errno = 0;
      +	result = ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
     -+					     type, &failure);
     -+	errno = failure;
     ++					     type, &failure_errno);
     ++	if (failure_errno)
     ++		errno = failure_errno;
      +	return result;
       }
       
     @@ refs/files-backend.c: stat_ref:
       
       out:
      -	save_errno = errno;
     -+	if (failure_errno)
     -+		*failure_errno = errno;
     ++	*failure_errno = errno;
       	strbuf_release(&sb_path);
       	strbuf_release(&sb_contents);
      -	errno = save_errno;
     @@ refs/refs-internal.h: typedef int reflog_expire_fn(struct ref_store *ref_store,
      - * an object ID, it is broken; set REF_ISBROKEN in type, and return -1
      - * (errno should not be ENOENT) If there is another error reading the
      - * ref, set errno appropriately and return -1.
     -+ * Return 0 on success. If the ref doesn't exist, set failure_errno to ENOENT
     -+ * and return -1. If the ref exists but is neither a symbolic ref nor an object
     -+ * ID, it is broken; set REF_ISBROKEN in type, and return -1 (failure_errno
     -+ * should not be ENOENT). The files backend may return EISDIR (if the ref name
     -+ * is a directory) and ENOTDIR (if a ref prefix is not a directory). If there is
     -+ * another error reading the ref, set failure_errno appropriately and return -1.
     ++ * Return 0 on success, or -1 on failure. If the ref exists but is neither a
     ++ * symbolic ref nor an object ID, it is broken. In this case set REF_ISBROKEN in
     ++ * type, and return -1 (failure_errno should not be ENOENT)
     ++ *
     ++ * failure_errno provides errno codes that are interpreted beyond error
     ++ * reporting. The following error codes have special meaning:
     ++ *    * ENOENT: the ref doesn't exist
     ++ *    * EISDIR: ref name is a directory
     ++ *    * ENOTDIR: ref prefix is not a directory
        *
        * Backend-specific flags might be set in type as well, regardless of
        * outcome.
 4:  11b2184044d < -:  ----------- refs: make errno output explicit for refs_resolve_ref_unsafe
 6:  2b346caf1ae ! 4:  4aaa9d3bd6f refs: add failure_errno to refs_read_raw_ref() signature
     @@ Metadata
       ## Commit message ##
          refs: add failure_errno to refs_read_raw_ref() signature
      
     -    This makes the errno output of refs_read_raw_ref explicit.
     +    This lets us use the explicit errno output parameter in refs_resolve_ref_unsafe.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
          Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## refs.c ##
      @@ refs.c: done:
     @@ refs.c: done:
      +		      struct object_id *oid, struct strbuf *referent,
      +		      unsigned int *type, int *failure_errno)
       {
     --	int result, failure;
     +-	int result;
     +-	int failure_errno;
     ++	int ignore;
      +	if (failure_errno)
      +		*failure_errno = 0;
     ++	else
     ++		failure_errno = &ignore;
     ++
       	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
       		return refs_read_special_head(ref_store, refname, oid, referent,
       					      type);
       	}
       
     --	failure = 0;
     +-	failure_errno = 0;
      -	result = ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
     --					     type, &failure);
     --	errno = failure;
     +-					     type, &failure_errno);
     +-	if (failure_errno)
     +-		errno = failure_errno;
      -	return result;
      +	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
      +					   type, failure_errno);
       }
       
     - /* This function needs to return a meaningful errno on failure */
     +-/* This function needs to return a meaningful errno on failure */
     +-const char *refs_resolve_ref_unsafe(struct ref_store *refs,
     +-				    const char *refname,
     +-				    int resolve_flags,
     +-				    struct object_id *oid, int *flags)
     ++const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
     ++					       const char *refname,
     ++					       int resolve_flags,
     ++					       struct object_id *oid,
     ++					       int *flags, int *failure_errno)
     + {
     + 	static struct strbuf sb_refname = STRBUF_INIT;
     + 	struct object_id unused_oid;
     + 	int unused_flags;
     ++	int unused_errno;
     + 	int symref_count;
     + 
     + 	if (!oid)
     +@@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
     + 		flags = &unused_flags;
     + 
     + 	*flags = 0;
     ++	if (!failure_errno)
     ++		failure_errno = &unused_errno;
     ++	*failure_errno = 0;
     + 
     + 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
     + 		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
      @@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
       
       	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
     @@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
      +				      &read_flags, &read_failure)) {
       			*flags |= read_flags;
       
     ++			*failure_errno = read_failure;
     ++
       			/* In reading mode, refs must eventually resolve */
     + 			if (resolve_flags & RESOLVE_REF_READING)
     + 				return NULL;
      @@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
       			 * may show errors besides ENOENT if there are
       			 * similarly-named refs.
     @@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
       				return NULL;
       
       			oidclr(oid);
     +@@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
     + 	return NULL;
     + }
     + 
     ++const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
     ++				    int resolve_flags, struct object_id *oid,
     ++				    int *flags)
     ++{
     ++	int ignore = 0;
     ++	return refs_resolve_ref_unsafe_with_errno(refs, refname, resolve_flags,
     ++						  oid, flags, &ignore);
     ++}
     ++
     + /* backend functions */
     + int refs_init_db(struct strbuf *err)
     + {
      @@ refs.c: int refs_verify_refname_available(struct ref_store *refs,
       		if (skip && string_list_has_string(skip, dirname.buf))
       			continue;
     @@ refs/files-backend.c: stat_ref:
       		}
      
       ## refs/packed-backend.c ##
     -@@ refs/packed-backend.c: static int packed_read_raw_ref(struct ref_store *ref_store, const char *refname,
     - 
     - 	if (!rec) {
     - 		/* refname is not a packed reference. */
     --		*failure_errno = ENOENT;
     -+		if (failure_errno)
     -+			*failure_errno = ENOENT;
     - 		return -1;
     - 	}
     - 
      @@ refs/packed-backend.c: int is_packed_transaction_needed(struct ref_store *ref_store,
       	ret = 0;
       	for (i = 0; i < transaction->nr; i++) {
       		struct ref_update *update = transaction->updates[i];
     -+		int failure;
     ++		int failure_errno = 0;
       		unsigned int type;
       		struct object_id oid;
       
     @@ refs/packed-backend.c: int is_packed_transaction_needed(struct ref_store *ref_st
      -				       &oid, &referent, &type) ||
      -		    errno != ENOENT) {
      +		if (!refs_read_raw_ref(ref_store, update->refname, &oid,
     -+				       &referent, &type, &failure) ||
     -+		    failure != ENOENT) {
     ++				       &referent, &type, &failure_errno) ||
     ++		    failure_errno != ENOENT) {
       			/*
       			 * We have to actually delete that reference
       			 * -> this transaction is needed.
     @@ refs/refs-internal.h: struct ref_update {
      +		      struct object_id *oid, struct strbuf *referent,
      +		      unsigned int *type, int *failure_errno);
       
     - /* Like refs_resolve_ref_unsafe, but provide access to errno code that lead to a
     -  * failure. */
     + /*
     +  * Write an error to `err` and return a nonzero value iff the same
 5:  005ee8e6fb2 ! 5:  ed5347d7bb6 refs: use refs_resolve_ref_unsafe_with_errno() where needed
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    refs: use refs_resolve_ref_unsafe_with_errno() where needed
     +    refs: make errno output explicit for refs_resolve_ref_unsafe
     +
     +    This introduces refs_resolve_ref_unsafe_with_errno(), which makes the API
     +    contract for the errno output explicit. The implementation still relies on
     +    the global errno variable to ensure no side effects of this refactoring.
      
          lock_ref_oid_basic() in files-backend.c is the only caller of refs_resolve_ref()
     -    that needs error information to make logic decisions.
     +    that needs error information to make logic decisions, so update that caller
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
          Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## refs/files-backend.c ##
      @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
     @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_re
       	if (!resolved) {
      -		int last_errno = errno;
      -		if (last_errno != ENOTDIR ||
     --		    !refs_verify_refname_available(&refs->base, refname,
     --						   extras, skip, err))
      +		if (resolve_errno != ENOTDIR ||
     -+		    !refs_verify_refname_available(&refs->base, refname, extras,
     -+						   skip, err))
     + 		    /* in case of D/F conflict, try to generate a better error
     + 		     * message. If that fails, fall back to strerror(ENOTDIR).
     + 		     */
     + 		    !refs_verify_refname_available(&refs->base, refname, extras,
     + 						   skip, err))
       			strbuf_addf(err, "unable to resolve reference '%s': %s",
      -				    refname, strerror(last_errno));
      +				    refname, strerror(resolve_errno));
       
       		goto error_return;
       	}
     +
     + ## refs/refs-internal.h ##
     +@@ refs/refs-internal.h: int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
     + 		      struct object_id *oid, struct strbuf *referent,
     + 		      unsigned int *type, int *failure_errno);
     + 
     ++/* Like refs_resolve_ref_unsafe, but provide access to errno code that lead to a
     ++ * failure. */
     ++const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
     ++					       const char *refname,
     ++					       int resolve_flags,
     ++					       struct object_id *oid,
     ++					       int *flags, int *failure_errno);
     ++
     + /*
     +  * Write an error to `err` and return a nonzero value iff the same
     +  * refname appears multiple times in `refnames`. `refnames` must be
 7:  d8651621968 < -:  ----------- refs: clear errno return in refs_resolve_ref_unsafe()
 8:  2a9ebe43dea < -:  ----------- refs: explicitly propagate errno from refs_read_raw_ref

-- 
gitgitgadget
