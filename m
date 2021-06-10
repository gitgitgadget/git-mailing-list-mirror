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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFB6C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4944E613DE
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFJM74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 08:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFJM74 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 08:59:56 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3499C061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 05:57:51 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f2so2193159wri.11
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 05:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=TrJRRAYjEtuaSpD6X62xr9BJrlGzmTa3hUFlOJQZSu8=;
        b=tbMKLnBeKzhQ/RlusOaii8+qy5YecLT4tZ1dYwV1Ed9xoT5WbPqrrBYCxB6n+93qkG
         cGu8ntoBCbQSfnPWPZy0cwM+BNk0goxh9nGY1mc/M4Hgo4k7HU1seOJbasRdSQ583zB4
         9I6n/4pT3QY+4JIWPUE1dWzS0nMf+7wAE1oQcLp9ScCqwARjoMXcah0TYohZwQkv4R2W
         e3cNd/0arWFIihIl/P1MWwpP6jl1gtqtWipmBds7fBzpHTLPD42mZuUopeJNF5VbI94E
         HHNCqvv0WmrdZ/u8J1q/Bct/PhWBSafoj/XaTwqaMcGFBN/NwzZg2hxXllIZo8uZX4+Y
         1z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=TrJRRAYjEtuaSpD6X62xr9BJrlGzmTa3hUFlOJQZSu8=;
        b=OGbmxD/B9waXdxpbUUX/1t2k0vqtBkCnxbSvwRr31ZaurTXDHgGP8/xG9mWGcVt+MP
         RYv48X26BpRgWWgEqHegDGXtKrLvr7xJpTkO0jaxAohLm/CzNJSZF/6GSNNhW009gX/S
         pen7tYTcVHtKPidxJYTgfeldEhKTTAtacoBI6HHrxANXuu11zvIU12sU4c6cJcKWCufV
         X+tnLF1XcLgpzQ9z91J5dd1GMDb5+p7uBKQ2Jm9PEG6z3EeLfHIfpOkPEG6vTSXMDV01
         xRybdmbB64b7lOCisY8Vi2ebjMwRRov53TOo3Yn+aV7TqyJ2MRQe/ObqG8kOd/tu/vgi
         9BzQ==
X-Gm-Message-State: AOAM530pU91wu2E0BacJ8MRvH2phDWRE58fXdfW/+m8cUeMuWsuq0JFB
        PBVvBF25pgElzyuwuqoV1dbphi3oV5Q=
X-Google-Smtp-Source: ABdhPJywHeN7pUub8e2AEt/Rk6RMK5lyqsN7/tke+Vhlfz/6mv8GgwfBwTUStsXyLZJ5no3jFzfIQw==
X-Received: by 2002:a5d:4f8f:: with SMTP id d15mr5180084wru.85.1623329870214;
        Thu, 10 Jun 2021 05:57:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q11sm3303453wrx.80.2021.06.10.05.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 05:57:49 -0700 (PDT)
Message-Id: <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Jun 2021 12:57:40 +0000
Subject: [PATCH v2 0/8] refs: cleanup errno sideband ref related functions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4

 * commit msg tweaks in response to Jun.

Han-Wen Nienhuys (8):
  refs: remove EINVAL errno output from specification of read_raw_ref_fn
  refs/files-backend: stop setting errno from lock_ref_oid_basic
  refs: make errno output explicit for read_raw_ref_fn
  refs: make errno output explicit for refs_resolve_ref_unsafe
  refs: use refs_resolve_ref_unsafe_with_errno() where needed
  refs: add failure_errno to refs_read_raw_ref() signature
  refs: clear errno return in refs_resolve_ref_unsafe()
  refs: explicitly propagate errno from refs_read_raw_ref

 refs.c                | 51 +++++++++++++++++++++++--------------
 refs/debug.c          |  4 +--
 refs/files-backend.c  | 58 +++++++++++++++++++------------------------
 refs/packed-backend.c | 16 ++++++------
 refs/refs-internal.h  | 31 +++++++++++++++--------
 5 files changed, 90 insertions(+), 70 deletions(-)


base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1012%2Fhanwen%2Feinval-sideband-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1012/hanwen/einval-sideband-v2
Pull-Request: https://github.com/git/git/pull/1012

Range-diff vs v1:

 1:  7e8181e77d40 ! 1:  f9b92e62b598 refs: remove EINVAL specification from the errno sideband in read_raw_ref_fn
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    refs: remove EINVAL specification from the errno sideband in read_raw_ref_fn
     +    refs: remove EINVAL errno output from specification of read_raw_ref_fn
      
     -    A grep for EINVAL */*c reveals that no code inspects EINVAL after reading
     -    references.
     +    This commit does not change code; it documents the fact that an alternate ref
     +    backend does not need to return EINVAL from read_raw_ref_fn to function
     +    properly.
      
     -    The files ref backend does use EINVAL so parse_loose_ref_contents() can
     -    communicate to lock_raw_ref() about garbage following the hex SHA1, or a short
     -    read in files_read_raw_ref(), but the files backend does not call into
     -    refs_read_raw_ref(), so its EINVAL sideband error is unused.
     +    This is correct, because refs_read_raw_ref is only called from;
     +
     +    * resolve_ref_unsafe(), which does not care for the EINVAL errno result.
     +
     +    * refs_verify_refname_available(), which does not inspect errno.
     +
     +    * files-backend.c, where errno is overwritten on failure.
     +
     +    * packed-backend.c (is_packed_transaction_needed), which calls it for the
     +      packed ref backend, which never emits EINVAL.
     +
     +    A grep for EINVAL */*c reveals that no code checks errno against EINVAL after
     +    reading references. In addition, the refs.h file does not mention errno at all.
     +
     +    A grep over resolve_ref_unsafe() turned up the following callers that inspect
     +    errno:
     +
     +    * sequencer.c::print_commit_summary, which uses it for die_errno
     +
     +    * lock_ref_oid_basic(), which only treats EISDIR and ENOTDIR specially.
     +
     +    The files ref backend does use EINVAL. The files backend does not call into
     +    the generic API (refs_read_raw), but into the files-specific function
     +    (files_read_raw_ref), which we are not changing in this commit.
      
          As the errno sideband is unintuitive and error-prone, remove EINVAL
          value, as a step towards getting rid of the errno sideband altogether.
     @@ Commit message
          Spotted by Ævar Arnfjörð Bjarmason <avarab@gmail.com>.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
      
       ## refs/refs-internal.h ##
      @@ refs/refs-internal.h: typedef int reflog_expire_fn(struct ref_store *ref_store,
     -  * properly-formatted or even safe reference name. NEITHER INPUT NOR
     -  * OUTPUT REFERENCE NAMES ARE VALIDATED WITHIN THIS FUNCTION.
        *
     -- * Return 0 on success. If the ref doesn't exist, set errno to ENOENT
     -- * and return -1. If the ref exists but is neither a symbolic ref nor
     +  * Return 0 on success. If the ref doesn't exist, set errno to ENOENT
     +  * and return -1. If the ref exists but is neither a symbolic ref nor
      - * an object ID, it is broken; set REF_ISBROKEN in type, set errno to
      - * EINVAL, and return -1. If there is another error reading the ref,
      - * set errno appropriately and return -1.
     -+ * Return 0 on success. If the ref doesn't exist, set errno to ENOENT and return
     -+ * -1. If the ref exists but is neither a symbolic ref nor an object ID, it is
     -+ * broken; set REF_ISBROKEN in type, and return -1. If there is another error
     -+ * reading the ref, set errno appropriately and return -1.
     ++ * an object ID, it is broken; set REF_ISBROKEN in type, and return -1
     ++ * (errno should not be ENOENT) If there is another error reading the
     ++ * ref, set errno appropriately and return -1.
        *
        * Backend-specific flags might be set in type as well, regardless of
        * outcome.
 2:  b2c72097e5e8 ! 2:  cbe09a48036c refs/files-backend: stop setting errno from lock_ref_oid_basic
     @@ Metadata
       ## Commit message ##
          refs/files-backend: stop setting errno from lock_ref_oid_basic
      
     -    Errno is a global variable written by almost all system calls, and therefore it
     -    is hard to reason about its state. It's also useless for user-visible errors, as
     -    it leaves no place to report the offending file and/or syscall.
     +    refs/files-backend.c::lock_ref_oid_basic() tries to signal how it failed
     +    to its callers using errno.
      
     -    For the copy/rename support, calls to lock_ref_oid_basic() in this file are
     -    followed by:
     +    It is safe to stop setting errno here, because the callers of this
     +    file-scope static function are
      
     -    * lock_ref_oid_basic (copy/rename rollback error path)
     +    * files_copy_or_rename_ref()
     +    * files_create_symref()
     +    * files_reflog_expire()
      
     -    * write_ref_to_lockfile (both in the rollback path and the success path of
     -      copy/rename)
     +    None of them looks at errno after seeing a negative return from
     +    lock_ref_oid_basic() to make any decision, and no caller of these three
     +    functions looks at errno after they signal a failure by returning a
     +    negative value. In particular,
      
     -    These calls do not inspect the incoming errno. As they perform I/O, they can
     -    clobber errno. For this reason, callers cannot reliably observe the errno that
     -    lock_ref_oid_basic() generated, so it is unsound for programmatic use.
     +    * files_copy_or_rename_ref() - here, calls are followed by error()
     +    (which performs I/O) or write_ref_to_lockfile() (which calls
     +    parse_object() which may perform I/O)
      
     -    For files_create_symref() and files_reflog_expire(), grepping over callers
     -    showed no callers inspecting errno.
     +    * files_create_symref() - here, calls are followed by error() or
     +    create_symref_locked() (which performs I/O and does not inspect
     +    errno)
     +
     +    * files_reflog_expire() - here, calls are followed by error() or
     +    refs_reflog_exists() (which calls a function in a vtable that is not
     +    documented to use and/or preserve errno)
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
      
       ## refs/files-backend.c ##
      @@ refs/files-backend.c: static int create_reflock(const char *path, void *cb)
 3:  ebd7b8380bf7 ! 3:  3e2831e59c8e refs: make errno output explicit for read_raw_ref_fn
     @@ Commit message
          relevant.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
      
       ## refs.c ##
      @@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store,
     @@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store,
       
      -	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
      -					   type);
     ++	failure = 0;
      +	result = ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
      +					     type, &failure);
      +	errno = failure;
     @@ refs/debug.c: debug_ref_iterator_begin(struct ref_store *ref_store, const char *
       {
       	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
       	int res = 0;
     - 
     - 	oidcpy(oid, &null_oid);
     +@@ refs/debug.c: static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
     + 	oidcpy(oid, null_oid());
     + 	errno = 0;
       	res = drefs->refs->be->read_raw_ref(drefs->refs, refname, oid, referent,
      -					    type);
      +					    type, failure_errno);
     @@ refs/refs-internal.h: typedef int reflog_expire_fn(struct ref_store *ref_store,
        * properly-formatted or even safe reference name. NEITHER INPUT NOR
        * OUTPUT REFERENCE NAMES ARE VALIDATED WITHIN THIS FUNCTION.
        *
     -- * Return 0 on success. If the ref doesn't exist, set errno to ENOENT and return
     -- * -1. If the ref exists but is neither a symbolic ref nor an object ID, it is
     -- * broken; set REF_ISBROKEN in type, and return -1. If there is another error
     -- * reading the ref, set errno appropriately and return -1.
     +- * Return 0 on success. If the ref doesn't exist, set errno to ENOENT
     +- * and return -1. If the ref exists but is neither a symbolic ref nor
     +- * an object ID, it is broken; set REF_ISBROKEN in type, and return -1
     +- * (errno should not be ENOENT) If there is another error reading the
     +- * ref, set errno appropriately and return -1.
      + * Return 0 on success. If the ref doesn't exist, set failure_errno to ENOENT
      + * and return -1. If the ref exists but is neither a symbolic ref nor an object
     -+ * ID, it is broken; set REF_ISBROKEN in type, and return -1. For the files
     -+ * backend, EISDIR and ENOTDIR may be set if the ref name is a directory. If
     -+ * there is another error reading the ref, set failure_errno appropriately and
     -+ * return -1.
     ++ * ID, it is broken; set REF_ISBROKEN in type, and return -1 (failure_errno
     ++ * should not be ENOENT). The files backend may return EISDIR (if the ref name
     ++ * is a directory) and ENOTDIR (if a ref prefix is not a directory). If there is
     ++ * another error reading the ref, set failure_errno appropriately and return -1.
        *
        * Backend-specific flags might be set in type as well, regardless of
        * outcome.
 -:  ------------ > 4:  11b2184044d7 refs: make errno output explicit for refs_resolve_ref_unsafe
 4:  dd3eceade4fc ! 5:  005ee8e6fb2a refs: make errno output explicit for refs_resolve_ref_unsafe
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    refs: make errno output explicit for refs_resolve_ref_unsafe
     +    refs: use refs_resolve_ref_unsafe_with_errno() where needed
      
     -    This introduces refs_resolve_ref_unsafe_with_errno(), which makes the API
     -    contract for the errno output explicit. The implementation still relies on
     -    the global errno variable to ensure no side effects.
     +    lock_ref_oid_basic() in files-backend.c is the only caller of refs_resolve_ref()
     +    that needs error information to make logic decisions.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     -
     - ## refs.c ##
     -@@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
     - 	return NULL;
     - }
     - 
     -+const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
     -+					       const char *refname,
     -+					       int resolve_flags,
     -+					       struct object_id *oid,
     -+					       int *flags, int *failure_errno)
     -+{
     -+	const char *result = refs_resolve_ref_unsafe(refs, refname,
     -+						     resolve_flags, oid, flags);
     -+	*failure_errno = errno;
     -+	return result;
     -+}
     -+
     - /* backend functions */
     - int refs_init_db(struct strbuf *err)
     - {
     -
     - ## refs.h ##
     -@@ refs.h: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
     - 				    int resolve_flags,
     - 				    struct object_id *oid,
     - 				    int *flags);
     -+
     - const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
     - 			       struct object_id *oid, int *flags);
     - 
     +    Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
      
       ## refs/files-backend.c ##
      @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
       	int mustexist = (old_oid && !is_null_oid(old_oid));
       	int resolve_flags = RESOLVE_REF_NO_RECURSE;
       	int resolved;
     -+	int resolve_errno;
     ++	int resolve_errno = 0;
       
       	files_assert_main_repository(refs, "lock_ref_oid_basic");
       	assert(err);
     @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_re
       
       		goto error_return;
       	}
     -
     - ## refs/refs-internal.h ##
     -@@ refs/refs-internal.h: int refs_read_raw_ref(struct ref_store *ref_store,
     - 		      const char *refname, struct object_id *oid,
     - 		      struct strbuf *referent, unsigned int *type);
     - 
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
 5:  039fc4be4b90 ! 6:  2b346caf1aed refs: add failure_errno to refs_read_raw_ref() signature
     @@ Commit message
          refs: add failure_errno to refs_read_raw_ref() signature
      
          This makes the errno output of refs_read_raw_ref explicit.
     -    lock_raw_ref() now explicitly reads the errno output of refs_read_raw_ref.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
      
       ## refs.c ##
      @@ refs.c: static int refs_read_special_head(struct ref_store *ref_store,
     @@ refs.c: static int refs_read_special_head(struct ref_store *ref_store,
      +		      unsigned int *type, int *failure_errno)
       {
      -	int result, failure;
     ++	if (failure_errno)
     ++		*failure_errno = 0;
       	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
       		return refs_read_special_head(ref_store, refname, oid, referent,
       					      type);
       	}
       
     +-	failure = 0;
      -	result = ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
      -					     type, &failure);
      -	errno = failure;
 6:  1bb350ea5d21 ! 7:  d86516219689 refs: clear errno return in refs_resolve_ref_unsafe()
     @@ Commit message
          This is done in a separate commit, to pinpoint the precise cause should there be
          regressions in error reporting.
      
     +    This is implemented by renaming the existing logic to a static function
     +    refs_resolve_unsafe_implicit_errno(), minimizing the code diff.
     +
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
      
       ## refs.c ##
      @@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
     @@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
      -				    const char *refname,
      -				    int resolve_flags,
      -				    struct object_id *oid, int *flags)
     -+static const char *refs_resolve_ref_unsafe_errno(struct ref_store *refs,
     -+						 const char *refname,
     -+						 int resolve_flags,
     -+						 struct object_id *oid,
     -+						 int *flags)
     ++static const char *
     ++refs_resolve_ref_unsafe_implicit_errno(struct ref_store *refs,
     ++				       const char *refname, int resolve_flags,
     ++				       struct object_id *oid, int *flags)
       {
       	static struct strbuf sb_refname = STRBUF_INIT;
       	struct object_id unused_oid;
     @@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
      +				    int resolve_flags, struct object_id *oid,
      +				    int *flags)
      +{
     -+	const char *result = refs_resolve_ref_unsafe_errno(
     ++	const char *result = refs_resolve_ref_unsafe_implicit_errno(
      +		refs, refname, resolve_flags, oid, flags);
      +	errno = 0;
      +	return result;
     @@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
       {
      -	const char *result = refs_resolve_ref_unsafe(refs, refname,
      -						     resolve_flags, oid, flags);
     -+	const char *result = refs_resolve_ref_unsafe_errno(
     ++	const char *result = refs_resolve_ref_unsafe_implicit_errno(
      +		refs, refname, resolve_flags, oid, flags);
       	*failure_errno = errno;
       	return result;
 7:  95d64d73353d < -:  ------------ refs: stop setting EINVAL and ELOOP in symref resolution
 8:  9e161eeb5f6b ! 8:  2a9ebe43deac refs: explicitly propagate errno from refs_read_raw_ref
     @@ Commit message
          refs_read_raw_ref().
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
      
       ## refs.c ##
      @@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
     @@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
       }
       
      -/* This function needs to return a meaningful errno on failure */
     --static const char *refs_resolve_ref_unsafe_errno(struct ref_store *refs,
     --						 const char *refname,
     --						 int resolve_flags,
     --						 struct object_id *oid,
     --						 int *flags)
     +-static const char *
     +-refs_resolve_ref_unsafe_implicit_errno(struct ref_store *refs,
     +-				       const char *refname, int resolve_flags,
     +-				       struct object_id *oid, int *flags)
      +const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
      +					       const char *refname,
      +					       int resolve_flags,
     @@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
       {
       	static struct strbuf sb_refname = STRBUF_INIT;
       	struct object_id unused_oid;
     -@@ refs.c: static const char *refs_resolve_ref_unsafe_errno(struct ref_store *refs,
     +@@ refs.c: refs_resolve_ref_unsafe_implicit_errno(struct ref_store *refs,
       		flags = &unused_flags;
       
       	*flags = 0;
     @@ refs.c: static const char *refs_resolve_ref_unsafe_errno(struct ref_store *refs,
       
       	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
       		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
     -@@ refs.c: static const char *refs_resolve_ref_unsafe_errno(struct ref_store *refs,
     + 		    !refname_is_safe(refname)) {
     +-			errno = EINVAL;
     ++			*failure_errno = EINVAL;
     + 			return NULL;
     + 		}
     + 
     +@@ refs.c: refs_resolve_ref_unsafe_implicit_errno(struct ref_store *refs,
       				      &read_flags, &read_failure)) {
       			*flags |= read_flags;
       
     @@ refs.c: static const char *refs_resolve_ref_unsafe_errno(struct ref_store *refs,
       			/* In reading mode, refs must eventually resolve */
       			if (resolve_flags & RESOLVE_REF_READING)
       				return NULL;
     +@@ refs.c: refs_resolve_ref_unsafe_implicit_errno(struct ref_store *refs,
     + 		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
     + 			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
     + 			    !refname_is_safe(refname)) {
     +-				errno = EINVAL;
     ++				*failure_errno = EINVAL;
     + 				return NULL;
     + 			}
     + 
     +@@ refs.c: refs_resolve_ref_unsafe_implicit_errno(struct ref_store *refs,
     + 		}
     + 	}
     + 
     +-	errno = ELOOP;
     ++	*failure_errno = ELOOP;
     + 	return NULL;
     + }
     + 
      @@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
       				    int resolve_flags, struct object_id *oid,
       				    int *flags)
       {
     --	const char *result = refs_resolve_ref_unsafe_errno(
     +-	const char *result = refs_resolve_ref_unsafe_implicit_errno(
      -		refs, refname, resolve_flags, oid, flags);
      -	errno = 0;
      -	return result;
     @@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *
      -					       struct object_id *oid,
      -					       int *flags, int *failure_errno)
      -{
     --	const char *result = refs_resolve_ref_unsafe_errno(
     +-	const char *result = refs_resolve_ref_unsafe_implicit_errno(
      -		refs, refname, resolve_flags, oid, flags);
      -	*failure_errno = errno;
      -	return result;

-- 
gitgitgadget
