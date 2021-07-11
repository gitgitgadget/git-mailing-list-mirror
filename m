Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CEAC07E9B
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C6861175
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhGKQdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 12:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhGKQdg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 12:33:36 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA02C0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:48 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i94so21115513wri.4
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=innIWXRfbo7qEjrXgmn3KoaqkWsAxQ6lLQHzPLZCaDw=;
        b=FIujNGn8ZVNUyABZR8uvB/92QgxrP8W2aST32r+TPWevrFNMWlVIR3+ZC/Nub0nmnf
         RUnm4Jh3YOqJf5DyW6dhPfJTghcS8xua6iyL2cYiWlXoxC0OU2npkx9PlUkTLce0ItaK
         V+FaLjuVDgmcwyRfabloVK1D8uXW9gBfu3IWW4ocW3nSguEymxFYqXDrxdwBMqZsyeh+
         Jfcz0FoHRwPdvdn+KCGL8de2dxPKVxvIQpSKwjiXBtKMSsf3yUZfv3ny+3ypICLVmlwh
         +xcehcANgArF/VpSlWpG/M9/Gj1huGDyqq0S2mZtO+u5Sbz4xcJUyvhzXCObAncRmDPt
         9prA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=innIWXRfbo7qEjrXgmn3KoaqkWsAxQ6lLQHzPLZCaDw=;
        b=hXb6Ceeu5qdWOdaK+y/Vdy3le5Tdg8VBmJu7vbKg5KvKXfgXY7fFURGaWNfhL19MZ4
         vq48fRXWGFPQMe1loGZZ+ZssXhXbv9CMUQge7aGykShyjKGUwkmpDI2NRiSUKoUS73on
         OZGefrXm72pIY+GG4xWtufMTaWeSXwYCOevnR/GiOIeVT9uAp3PHvzGVBCB5gPhu3bJ8
         w0Nrbezykzbw23A5GWTmQTKdjVztLpnjiXvFcGR3Tejg7DjZARQDw4WleN3NBp9l3bAj
         x+z+/BVwDGGnantvPxluvDQOKTJxZ31tyNZr8yHaS//swCCJ3Sed+xaW6SspVVGJU+n7
         S7Ug==
X-Gm-Message-State: AOAM530qAwpl7DwhwpmGb4NSZmwG/WQWhIqKN8h8dvDAvSXG8lv987dS
        WCOPc9N6PWZrTpLHvH+fS3sEltgRF8T82w==
X-Google-Smtp-Source: ABdhPJxeOERlMj66UobeM+XmQgz6lpc3mfdGQYhCn3TId5dGWMCFDL8HO+eJG+SslRlrbbNHDCtF1g==
X-Received: by 2002:adf:e689:: with SMTP id r9mr35233290wrm.416.1626021045937;
        Sun, 11 Jul 2021 09:30:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w3sm678091wrt.55.2021.07.11.09.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 09:30:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6? 00/17] refs API: get rid of errno setting entirely
Date:   Sun, 11 Jul 2021 18:30:24 +0200
Message-Id: <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
References: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After starting a review of v5 of Han-Wen's where I was coming up with
squashes-on-top I continued with it and saw if I could get rid of
errno setting entirely in refs.

The end-state of that is that we do that:
	
	$ git -P grep -w errno refs.c
	refs.c:                 if (errno != EPIPE) {
	refs.c:                         /* Don't leak errno outside this API */
	refs.c:                         errno = 0;

The rest has various bugfixes etc. to Han-Wen's version.

I'm not sure about:

    refs: make errno ignoring explicit in lock_ref_oid_basic()

But it's an edge case that's present in Han-Wen's, but just
ignored/skipped past. Now it's a BUG(), I haven't been able to hit it
in testing, but maybe we do hit it somehow.

My amendmend of:

    refs: explicitly return failure_errno from parse_loose_ref_contents

Has it calling BUG() to assert that whenever we return non-zero we set
errno as expected, there were a few cases where functions omitted one
errno case, but set another.

Arguably everything as of 08/17 should be its follow-up series. I've
included it because I think looking at those patches assures the
reader that we didn't miss any subtle errno edge cases.

(I removed my Reviewed-by trailer because it seemed redundant to SOB,
and if I have SOB already on something saying I reviewed it seemed
odd...)

1. https://lore.kernel.org/git/pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com/

Han-Wen Nienhuys (6):
  refs: remove EINVAL errno output from specification of read_raw_ref_fn
  refs/files-backend: stop setting errno from lock_ref_oid_basic
  refs: make errno output explicit for read_raw_ref_fn
  refs: add failure_errno to refs_read_raw_ref() signature
  refs: explicitly return failure_errno from parse_loose_ref_contents
  refs: make errno output explicit for refs_resolve_ref_unsafe

Ævar Arnfjörð Bjarmason (11):
  refs: make errno ignoring explicit in lock_ref_oid_basic()
  refs file-backend.c: stop setting "EBUSY" in verify_lock()
  refs file-backend.c: deal with errno directly in verify_lock()
  refs API: remove refs_read_ref_full() wrapper
  refs API: make resolve_gitlink_ref() not set errno
  refs API: make refs_resolve_ref_unsafe() static
  refs API: make refs_resolve_refdup() not set errno
  refs API: make refs_ref_exists() not set errno
  refs API: make resolve_ref_unsafe() not set errno
  refs API: make expand_ref() and repo_dwim_log() not set errno
  refs API: don't leak "errno" in run_transaction_hook()

 refs.c                    | 122 ++++++++++++++++----------
 refs.h                    |  17 ++--
 refs/debug.c              |   4 +-
 refs/files-backend.c      | 180 +++++++++++++++++++++-----------------
 refs/packed-backend.c     |  15 ++--
 refs/refs-internal.h      |  32 ++++---
 sequencer.c               |  10 ++-
 t/helper/test-ref-store.c |   5 +-
 worktree.c                |  27 +++---
 9 files changed, 244 insertions(+), 168 deletions(-)

Range-diff:
 1:  d6a41c3c0cb !  1:  57517368c34 refs: remove EINVAL errno output from specification of read_raw_ref_fn
    @@ Commit message
         Spotted by Ævar Arnfjörð Bjarmason <avarab@gmail.com>.
     
         Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## refs/refs-internal.h ##
     @@ refs/refs-internal.h: typedef int reflog_expire_fn(struct ref_store *ref_store,
 2:  95025080c16 !  2:  61cf7611473 refs/files-backend: stop setting errno from lock_ref_oid_basic
    @@ Commit message
         refs_reflog_exists() (which calls a function in a vtable that is not
         documented to use and/or preserve errno)
     
    +    In the case of the "errno != ENOTDIR" case that originates in 5b2d8d6f218
    +    (lock_ref_sha1_basic(): improve diagnostics for ref D/F conflicts,
    +    2015-05-11), there the "last_errno" was saved away to return it from
    +    lock_ref_oid_basic(), now that we're no longer doing that we can skip
    +    that entirely and use "errno" directly. A follow-up change will
    +    extract the specific errno we want earlier in this function.
    +
         Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
    -    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## refs/files-backend.c ##
     @@ refs/files-backend.c: static int create_reflock(const char *path, void *cb)
    @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_re
      					    &refs->base,
      					    refname, extras, skip, err))
     @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
    + 						     refname, resolve_flags,
      						     &lock->old_oid, type);
      	}
    - 	if (!resolved) {
    +-	if (!resolved) {
     -		last_errno = errno;
    -+		int last_errno = errno;
    - 		if (last_errno != ENOTDIR ||
    +-		if (last_errno != ENOTDIR ||
     -		    !refs_verify_refname_available(&refs->base, refname,
     -						   extras, skip, err))
    -+		    /* in case of D/F conflict, try to generate a better error
    -+		     * message. If that fails, fall back to strerror(ENOTDIR).
    -+		     */
    -+		    !refs_verify_refname_available(&refs->base, refname, extras,
    -+						   skip, err))
    - 			strbuf_addf(err, "unable to resolve reference '%s': %s",
    - 				    refname, strerror(last_errno));
    +-			strbuf_addf(err, "unable to resolve reference '%s': %s",
    +-				    refname, strerror(last_errno));
    +-
    ++	if (!resolved &&
    ++	    (errno != ENOTDIR ||
    ++	     /* in case of D/F conflict, try to generate a better error
    ++	      * message. If that fails, fall back to strerror(ENOTDIR).
    ++	      */
    ++	     !refs_verify_refname_available(&refs->base, refname, extras,
    ++					    skip, err))) {
    ++		strbuf_addf(err, "unable to resolve reference '%s': %s",
    ++			    refname, strerror(errno));
    + 		goto error_return;
    + 	}
      
     @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
      	if (is_null_oid(&lock->old_oid) &&
 3:  7feedb97201 !  3:  a4e5f2d02fb refs: make errno output explicit for read_raw_ref_fn
    @@ Commit message
         relevant.
     
         Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
    -    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## refs.c ##
     @@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store,
    - 		      const char *refname, struct object_id *oid,
    - 		      struct strbuf *referent, unsigned int *type)
    - {
    -+	int result;
    -+	int failure_errno;
    - 	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
    - 		return refs_read_special_head(ref_store, refname, oid, referent,
    - 					      type);
      	}
      
    --	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
    + 	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
     -					   type);
    -+	failure_errno = 0;
    -+	result = ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
    -+					     type, &failure_errno);
    -+	if (failure_errno)
    -+		errno = failure_errno;
    -+	return result;
    ++					   type, &errno);
      }
      
      /* This function needs to return a meaningful errno on failure */
    @@ refs/files-backend.c: static int lock_raw_ref(struct files_ref_store *refs,
      	struct strbuf ref_file = STRBUF_INIT;
      	int attempts_remaining = 3;
      	int ret = TRANSACTION_GENERIC_ERROR;
    -+	int failure_errno = 0;
    ++	int failure_errno;
      
      	assert(err);
      	files_assert_main_repository(refs, "lock_raw_ref");
    +@@ refs/files-backend.c: static int lock_raw_ref(struct files_ref_store *refs,
    + 	if (hold_lock_file_for_update_timeout(
    + 			    &lock->lk, ref_file.buf, LOCK_NO_DEREF,
    + 			    get_files_ref_lock_timeout_ms()) < 0) {
    +-		if (errno == ENOENT && --attempts_remaining > 0) {
    ++		int myerr = errno;
    ++		errno = 0;
    ++		if (myerr == ENOENT && --attempts_remaining > 0) {
    + 			/*
    + 			 * Maybe somebody just deleted one of the
    + 			 * directories leading to ref_file.  Try
    +@@ refs/files-backend.c: static int lock_raw_ref(struct files_ref_store *refs,
    + 			 */
    + 			goto retry;
    + 		} else {
    +-			unable_to_lock_message(ref_file.buf, errno, err);
    ++			unable_to_lock_message(ref_file.buf, myerr, err);
    + 			goto error_return;
    + 		}
    + 	}
     @@ refs/files-backend.c: static int lock_raw_ref(struct files_ref_store *refs,
      	 * fear that its value will change.
      	 */
 4:  ef91f5cee13 !  4:  270cda29c3a refs: add failure_errno to refs_read_raw_ref() signature
    @@ Commit message
     
         This lets us use the explicit errno output parameter in refs_resolve_ref_unsafe.
     
    +    Some of our callers explicitly do not care about the errno, rather
    +    than understanding NULL let's have them declare that they don't care
    +    by passing in an "ignore_errno". There's only three of them, and using
    +    that pattern will make it more obvious that they want to throw away
    +    data, let's also add a comment to one of the callers about why we'd
    +    like to ignore the errno.
    +
    +    Let's not extend that to refs_resolve_ref_unsafe() itself for now, it
    +    has a large set of legacy callers, so we're faking up the old "errno"
    +    behavior for it. We can convert those callers to
    +    refs_resolve_ref_unsafe_with_errno() later.
    +
    +    We are leaving out out the refs_read_special_head() in
    +    refs_read_raw_ref() for now, as noted in the next commit moving it to
    +    "failure_errno" will require some special consideration.
    +
    +    We're intentionally mis-indenting the argument list of the new
    +    refs_resolve_ref_unsafe_with_errno(), it will be non-static in a
    +    subsequent commit, doing it this way makes that diff smaller.
    +
         Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
    -    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## refs.c ##
     @@ refs.c: static int refs_read_special_head(struct ref_store *ref_store,
    @@ refs.c: static int refs_read_special_head(struct ref_store *ref_store,
     -int refs_read_raw_ref(struct ref_store *ref_store,
     -		      const char *refname, struct object_id *oid,
     -		      struct strbuf *referent, unsigned int *type)
    --{
    --	int result;
    --	int failure_errno;
     +int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
     +		      struct object_id *oid, struct strbuf *referent,
     +		      unsigned int *type, int *failure_errno)
    -+{
    -+	int unused_errno;
    -+	if (!failure_errno)
    -+		failure_errno = &unused_errno;
    -+	*failure_errno = 0;
    + {
    ++	assert(failure_errno);
      	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
      		return refs_read_special_head(ref_store, refname, oid, referent,
      					      type);
      	}
      
    --	failure_errno = 0;
    --	result = ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
    --					     type, &failure_errno);
    --	if (failure_errno)
    --		errno = failure_errno;
    --	return result;
    -+	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
    + 	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
    +-					   type, &errno);
     +					   type, failure_errno);
      }
      
    @@ refs.c: static int refs_read_special_head(struct ref_store *ref_store,
     -				    const char *refname,
     -				    int resolve_flags,
     -				    struct object_id *oid, int *flags)
    -+const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
    ++static const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
     +					       const char *refname,
     +					       int resolve_flags,
     +					       struct object_id *oid,
    @@ refs.c: static int refs_read_special_head(struct ref_store *ref_store,
      	static struct strbuf sb_refname = STRBUF_INIT;
      	struct object_id unused_oid;
      	int unused_flags;
    -+	int unused_errno;
      	int symref_count;
      
    ++	assert(failure_errno);
    ++
      	if (!oid)
    + 		oid = &unused_oid;
    + 	if (!flags)
     @@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
    - 		flags = &unused_flags;
    - 
    - 	*flags = 0;
    -+	if (!failure_errno)
    -+		failure_errno = &unused_errno;
    -+	*failure_errno = 0;
    - 
      	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
      		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
    -@@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
    + 		    !refname_is_safe(refname)) {
    +-			errno = EINVAL;
    ++			*failure_errno = EINVAL;
    + 			return NULL;
    + 		}
      
    +@@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
      	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
      		unsigned int read_flags = 0;
    -+		int read_failure = 0;
      
     -		if (refs_read_raw_ref(refs, refname,
     -				      oid, &sb_refname, &read_flags)) {
     +		if (refs_read_raw_ref(refs, refname, oid, &sb_refname,
    -+				      &read_flags, &read_failure)) {
    ++				      &read_flags, failure_errno)) {
      			*flags |= read_flags;
      
    -+			*failure_errno = read_failure;
    -+
      			/* In reading mode, refs must eventually resolve */
    - 			if (resolve_flags & RESOLVE_REF_READING)
    - 				return NULL;
     @@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
      			 * may show errors besides ENOENT if there are
      			 * similarly-named refs.
    @@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
     -			if (errno != ENOENT &&
     -			    errno != EISDIR &&
     -			    errno != ENOTDIR)
    -+			if (read_failure != ENOENT && read_failure != EISDIR &&
    -+			    read_failure != ENOTDIR)
    ++			if (*failure_errno != ENOENT &&
    ++			    *failure_errno != EISDIR &&
    ++			    *failure_errno != ENOTDIR)
      				return NULL;
      
      			oidclr(oid);
     @@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
    + 		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
    + 			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
    + 			    !refname_is_safe(refname)) {
    +-				errno = EINVAL;
    ++				*failure_errno = EINVAL;
    + 				return NULL;
    + 			}
    + 
    +@@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
    + 		}
    + 	}
    + 
    +-	errno = ELOOP;
    ++	*failure_errno = ELOOP;
      	return NULL;
      }
      
    @@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
     +				    int resolve_flags, struct object_id *oid,
     +				    int *flags)
     +{
    -+	int ignore = 0;
    -+	return refs_resolve_ref_unsafe_with_errno(refs, refname, resolve_flags,
    -+						  oid, flags, &ignore);
    ++	int failure_errno = 0;
    ++	const char *refn;
    ++	refn = refs_resolve_ref_unsafe_with_errno(refs, refname, resolve_flags,
    ++						  oid, flags, &failure_errno);
    ++	if (!refn)
    ++		/* For unmigrated legacy callers */
    ++		errno = failure_errno;
    ++	return refn;
     +}
     +
      /* backend functions */
      int refs_init_db(struct strbuf *err)
      {
    +@@ refs.c: int refs_verify_refname_available(struct ref_store *refs,
    + 
    + 	strbuf_grow(&dirname, strlen(refname) + 1);
    + 	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
    ++		/*
    ++		 * Just saying "Is a directory" when we e.g. can't
    ++		 * lock some multi-level ref isn't very informative,
    ++		 * the user won't be told *what* is a directory, so
    ++		 * let's not use strerror() below.
    ++		 */
    ++		int ignore_errno;
    + 		/* Expand dirname to the new prefix, not including the trailing slash: */
    + 		strbuf_add(&dirname, refname + dirname.len, slash - refname - dirname.len);
    + 
     @@ refs.c: int refs_verify_refname_available(struct ref_store *refs,
      		if (skip && string_list_has_string(skip, dirname.buf))
      			continue;
      
     -		if (!refs_read_raw_ref(refs, dirname.buf, &oid, &referent, &type)) {
     +		if (!refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
    -+				       &type, NULL)) {
    ++				       &type, &ignore_errno)) {
      			strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
      				    dirname.buf, refname);
      			goto cleanup;
     
      ## refs/files-backend.c ##
     @@ refs/files-backend.c: static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
    + 		goto out;
    + 
      	if (lstat(path, &st) < 0) {
    ++		int ignore_errno;
      		if (errno != ENOENT)
      			goto out;
     -		if (refs_read_raw_ref(refs->packed_ref_store, refname,
     -				      oid, referent, type)) {
     +		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
    -+				      referent, type, NULL)) {
    ++				      referent, type, &ignore_errno)) {
      			errno = ENOENT;
      			goto out;
      		}
     @@ refs/files-backend.c: static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
    + 
    + 	/* Is it a directory? */
    + 	if (S_ISDIR(st.st_mode)) {
    ++		int ignore_errno;
    + 		/*
    + 		 * Even though there is a directory where the loose
      		 * ref is supposed to be, there could still be a
      		 * packed ref:
      		 */
     -		if (refs_read_raw_ref(refs->packed_ref_store, refname,
     -				      oid, referent, type)) {
     +		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
    -+				      referent, type, NULL)) {
    ++				      referent, type, &ignore_errno)) {
      			errno = EISDIR;
      			goto out;
      		}
    @@ refs/packed-backend.c: int is_packed_transaction_needed(struct ref_store *ref_st
      	ret = 0;
      	for (i = 0; i < transaction->nr; i++) {
      		struct ref_update *update = transaction->updates[i];
    -+		int failure_errno = 0;
    ++		int failure_errno;
      		unsigned int type;
      		struct object_id oid;
      
 5:  6918c214d1b !  5:  f5197cdc0b8 refs: explicitly return failure_errno from parse_loose_ref_contents
    @@ Commit message
         The EINVAL error from parse_loose_ref_contents is used in files-backend
         to create a custom error message.
     
    +    In untangling this we discovered a tricky edge case. The
    +    refs_read_special_head() function was relying on
    +    parse_loose_ref_contents() setting EINVAL.
    +
    +    By converting it to use "saved_errno" we can migrate away from "errno"
    +    in this part of the code entirely, and do away with an existing
    +    "save_errno" pattern, its only purpose was to not clobber the "errno"
    +    we previously needed at the end of files_read_raw_ref().
    +
    +    Let's assert that we can do that by not having files_read_raw_ref()
    +    itself operate on *failure_errno in addition to passing it on. Instead
    +    we'll assert that if we return non-zero we actually do set errno, thus
    +    assuring ourselves and callers that they can trust the resulting
    +    "failure_errno".
    +
         Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
    -    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## refs.c ##
     @@ refs.c: int for_each_fullref_in_prefixes(const char *namespace,
    @@ refs.c: static int refs_read_special_head(struct ref_store *ref_store,
      done:
      	strbuf_release(&full_path);
     @@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
    - 	*failure_errno = 0;
    + 	assert(failure_errno);
      	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
      		return refs_read_special_head(ref_store, refname, oid, referent,
     -					      type);
    @@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
     
      ## refs/files-backend.c ##
     @@ refs/files-backend.c: static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
    + 	int fd;
    + 	int ret = -1;
    + 	int remaining_retries = 3;
    ++	int myerr = 0;
    + 
    + 	*type = 0;
    + 	strbuf_reset(&sb_path);
    +@@ refs/files-backend.c: static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
    + 
    + 	if (lstat(path, &st) < 0) {
    + 		int ignore_errno;
    +-		if (errno != ENOENT)
    ++		myerr = errno;
    ++		errno = 0;
    ++		if (myerr != ENOENT)
    + 			goto out;
    + 		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
    + 				      referent, type, &ignore_errno)) {
    +-			errno = ENOENT;
    ++			myerr = ENOENT;
    + 			goto out;
    + 		}
    + 		ret = 0;
    +@@ refs/files-backend.c: static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
    + 	if (S_ISLNK(st.st_mode)) {
    + 		strbuf_reset(&sb_contents);
    + 		if (strbuf_readlink(&sb_contents, path, st.st_size) < 0) {
    +-			if (errno == ENOENT || errno == EINVAL)
    ++			myerr = errno;
    ++			errno = 0;
    ++			if (myerr == ENOENT || myerr == EINVAL)
    + 				/* inconsistent with lstat; retry */
    + 				goto stat_ref;
    + 			else
    +@@ refs/files-backend.c: static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
    + 		 */
    + 		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
    + 				      referent, type, &ignore_errno)) {
    +-			errno = EISDIR;
    ++			myerr = EISDIR;
    + 			goto out;
    + 		}
    + 		ret = 0;
    +@@ refs/files-backend.c: static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
    + 	 */
    + 	fd = open(path, O_RDONLY);
    + 	if (fd < 0) {
    +-		if (errno == ENOENT && !S_ISLNK(st.st_mode))
    ++		myerr = errno;
    ++		if (myerr == ENOENT && !S_ISLNK(st.st_mode))
    + 			/* inconsistent with lstat; retry */
    + 			goto stat_ref;
    + 		else
    +@@ refs/files-backend.c: static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
    + 	}
    + 	strbuf_reset(&sb_contents);
    + 	if (strbuf_read(&sb_contents, fd, 256) < 0) {
    +-		int save_errno = errno;
    + 		close(fd);
    +-		errno = save_errno;
    + 		goto out;
    + 	}
    + 	close(fd);
      	strbuf_rtrim(&sb_contents);
      	buf = sb_contents.buf;
      
     -	ret = parse_loose_ref_contents(buf, oid, referent, type);
    --
    -+	ret = parse_loose_ref_contents(buf, oid, referent, type, failure_errno);
    -+	errno = *failure_errno;
    ++	ret = parse_loose_ref_contents(buf, oid, referent, type, &myerr);
    + 
      out:
    -+	/*
    -+	 * Many system calls in this function can fail with ENOTDIR/EISDIR, and
    -+	 * we want to collect all of them, so simply copy the error out from
    -+	 * errno.
    -+	 */
    - 	*failure_errno = errno;
    +-	*failure_errno = errno;
    ++	if (ret && !myerr)
    ++		BUG("returning non-zero %d, should have set myerr!", ret);
    ++	*failure_errno = myerr;
    ++
      	strbuf_release(&sb_path);
      	strbuf_release(&sb_contents);
    -@@ refs/files-backend.c: static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
    + 	return ret;
      }
      
      int parse_loose_ref_contents(const char *buf, struct object_id *oid,
 6:  85a14bde904 !  6:  96689e523f1 refs: make errno output explicit for refs_resolve_ref_unsafe
    @@ Commit message
         that needs error information to make logic decisions, so update that caller
     
         Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
    -    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +
    + ## refs.c ##
    +@@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
    + 					   type, failure_errno);
    + }
    + 
    +-static const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
    ++const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
    + 					       const char *refname,
    + 					       int resolve_flags,
    + 					       struct object_id *oid,
    +
    + ## refs.h ##
    +@@ refs.h: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
    + 				    int resolve_flags,
    + 				    struct object_id *oid,
    + 				    int *flags);
    ++/**
    ++ * refs_resolve_ref_unsafe_with_errno() is like
    ++ * refs_resolve_ref_unsafe(), but provide access to errno code that
    ++ * lead to a failure. We guarantee that errno is set to a meaningful
    ++ * value on non-zero return.
    ++ */
    ++const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
    ++					       const char *refname,
    ++					       int resolve_flags,
    ++					       struct object_id *oid,
    ++					       int *flags, int *failure_errno);
    + const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
    + 			       struct object_id *oid, int *flags);
    + 
     
      ## refs/files-backend.c ##
     @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
    @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_re
     @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
      						     &lock->old_oid, type);
      	}
    - 	if (!resolved) {
    --		int last_errno = errno;
    --		if (last_errno != ENOTDIR ||
    -+		if (resolve_errno != ENOTDIR ||
    - 		    /* in case of D/F conflict, try to generate a better error
    - 		     * message. If that fails, fall back to strerror(ENOTDIR).
    - 		     */
    - 		    !refs_verify_refname_available(&refs->base, refname, extras,
    - 						   skip, err))
    - 			strbuf_addf(err, "unable to resolve reference '%s': %s",
    --				    refname, strerror(last_errno));
    -+				    refname, strerror(resolve_errno));
    - 
    + 	if (!resolved &&
    +-	    (errno != ENOTDIR ||
    ++	    (resolve_errno != ENOTDIR ||
    + 	     /* in case of D/F conflict, try to generate a better error
    + 	      * message. If that fails, fall back to strerror(ENOTDIR).
    + 	      */
    + 	     !refs_verify_refname_available(&refs->base, refname, extras,
    + 					    skip, err))) {
    + 		strbuf_addf(err, "unable to resolve reference '%s': %s",
    +-			    refname, strerror(errno));
    ++			    refname, strerror(resolve_errno));
      		goto error_return;
      	}
    -
    - ## refs/refs-internal.h ##
    -@@ refs/refs-internal.h: int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
    - 		      struct object_id *oid, struct strbuf *referent,
    - 		      unsigned int *type, int *failure_errno);
      
    -+/* Like refs_resolve_ref_unsafe, but provide access to errno code that lead to a
    -+ * failure. */
    -+const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
    -+					       const char *refname,
    -+					       int resolve_flags,
    -+					       struct object_id *oid,
    -+					       int *flags, int *failure_errno);
    -+
    - /*
    -  * Write an error to `err` and return a nonzero value iff the same
    -  * refname appears multiple times in `refnames`. `refnames` must be
 -:  ----------- >  7:  10a40c9244e refs: make errno ignoring explicit in lock_ref_oid_basic()
 -:  ----------- >  8:  ff38a3f1936 refs file-backend.c: stop setting "EBUSY" in verify_lock()
 -:  ----------- >  9:  cdec272f06f refs file-backend.c: deal with errno directly in verify_lock()
 -:  ----------- > 10:  bd0639945a4 refs API: remove refs_read_ref_full() wrapper
 -:  ----------- > 11:  a359d1533bd refs API: make resolve_gitlink_ref() not set errno
 -:  ----------- > 12:  07d550015ac refs API: make refs_resolve_ref_unsafe() static
 -:  ----------- > 13:  73b70491515 refs API: make refs_resolve_refdup() not set errno
 -:  ----------- > 14:  1e9de48d850 refs API: make refs_ref_exists() not set errno
 -:  ----------- > 15:  446b50280be refs API: make resolve_ref_unsafe() not set errno
 -:  ----------- > 16:  37c5b88d7d8 refs API: make expand_ref() and repo_dwim_log() not set errno
 -:  ----------- > 17:  f914df0bb25 refs API: don't leak "errno" in run_transaction_hook()
-- 
2.32.0-dev

