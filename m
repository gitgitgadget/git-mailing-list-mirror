Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90433C433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A10161164
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhJNAIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhJNAIl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:08:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC9BC061746
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:37 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u18so13866624wrg.5
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T4wwSL5pm5LRmFLQso8GD2KUD5Wz57N509vbSi+KJrU=;
        b=EVSU1RjlRRgRVT5Loe3AhZPGoKI2tQR4F/ZG7tcAevWCM0v7cnkMThLVdjBYOtgq0t
         BPv0NCha3oKQT5x1tNN9rgdwNRTiGXn8JXqDWXuv9EV9p/82iQF8Hw+Njc17NTomuZhn
         z1E2v9XES3h5dm9Y53sUyANS6BGKeeWemXiOXPzUXJUysh08zTAke+2e5qYx/gioURCI
         zcnW9IghP3dYHVFp8ZOzOWk36gxBxJCaeJ3UgF23VaXW79+bbBqvacfOogsU3RfXP7tu
         slRDj31gElsNQ0Zb2oqPLfegMhoTf0AyZIloQtlmNbom4x/jrnI5Xy6fBYghdlrN1+An
         IuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T4wwSL5pm5LRmFLQso8GD2KUD5Wz57N509vbSi+KJrU=;
        b=5dUOrO31iSNrSAQhFUA4f7PqgCCitMr0KFOExR8ZxZXBKrbY/ezj7+P7T0m7T+RMhR
         Oq0/D04jrfsPv9B7WgKfj/BnB3sBgAc6ZbGTafmBVj8XTFuFcHYbZKCy6XlM5ij8O0ir
         eyzLXvlBlBkEVrHo+o7kkpWXmVgbpUg8IKOPYUCaVzJmIxFGXLKD4mBRnhQiI0w5zVOW
         waraljqq+BWvmzDwkv57kiZfGtq6UDVIr5JlQd0t5XOk/emD7gErb71/TsXRWxrphjRP
         jHU7GoAontX4sWqzicCllRpnx/U64FsYMYGYHIkPszpOJhTxueS9IQ6fMfgFVv63ym2S
         Tyyw==
X-Gm-Message-State: AOAM531uHMtXAjal/ibTAEmRh8f+XGoE+F/5b3Mczih+gE8M3pShWqqm
        TK3v8XvaB9Fd49k43i7A1tTEwTLIy/Q/Ow==
X-Google-Smtp-Source: ABdhPJwmE849MkR0SjsZxQyrURKX4r5Tz8uesxV01Krs3Rp2amJ0kdQySXwkZJG5E0CxSsqLfXKozQ==
X-Received: by 2002:adf:ab43:: with SMTP id r3mr2726078wrc.225.1634169994641;
        Wed, 13 Oct 2021 17:06:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm670711wmi.43.2021.10.13.17.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:06:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/20] refs: stop having the API set "errno"
Date:   Thu, 14 Oct 2021 02:06:12 +0200
Message-Id: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series changes the refs API to stop explicitly or implicitly
exposing "errno" to indicate its state, and instead moves to pushing
up an explicit "failure_errno" variable, or in other cases we migrate
callers entirely away from getting any errno values at all (because
they never cared).

This makes the eventual integration of the reftable backend much
easier to reason about, because we can be assured that the refs.c
function interface is everything we need to care about, and that some
callers e.g. don't expect the reftable backend to fake up certain
errno values in case of certain types of failures.

This topic replaces ab/refs-errno-cleanup, which was the result of
Junio peeling off the first 4 patches of this 10-part series:
https://lore.kernel.org/git/cover-v10-0.8-00000000000-20210823T114712Z-avarab@gmail.com/

It's been marked as "meh" for a while in What's Cooking, I think just
doing those first patches (or those 10) doesn't really show the
end-state benefit, so here's all of it.

In re-rolling this I found more cases where we could remove dead code
in the refs file backend, which made this easier, see in particular
06/20. Patches 08-18/20 are piecemeal moves away from setting "errno"
(which in most cases wasn't needed), and finally 19-20/20 removes a
transitory API function used in this series so that this migration
could be done incrementally.

Han-Wen Nienhuys (3):
  branch tests: test for errno propagating on failing read
  refs API: make refs_read_raw_ref() not set errno
  refs API: make parse_loose_ref_contents() not set errno

Ævar Arnfjörð Bjarmason (17):
  refs API: add a version of refs_resolve_ref_unsafe() with "errno"
  refs API: make refs_rename_ref_available() static
  refs/files: remove "name exist?" check in lock_ref_oid_basic()
  refs API: remove refs_read_ref_full() wrapper
  refs API: make resolve_gitlink_ref() not set errno
  refs API: make loose_fill_ref_dir() not set errno
  refs API: make files_copy_or_rename_ref() et al not set errno
  refs API: ignore errno in worktree.c's add_head_info()
  refs API: ignore errno in worktree.c's find_shared_symref()
  refs tests: ignore ignore errno in test-ref-store helper
  refs API: make refs_resolve_refdup() not set errno
  refs API: make refs_ref_exists() not set errno
  refs API: make resolve_ref_unsafe() not set errno
  refs API: make expand_ref() & repo_dwim_log() not set errno
  refs API: don't expose "errno" in run_transaction_hook()
  refs API: post-migration API renaming [1/2]
  refs API: post-migration API renaming [2/2]

 refs.c                    | 124 +++++++++++++++++++------------------
 refs.h                    |  10 ++-
 refs/files-backend.c      | 125 +++++++++++++++++++++++++-------------
 refs/packed-backend.c     |   7 ++-
 refs/refs-internal.h      |  26 +++-----
 sequencer.c               |  10 ++-
 t/helper/test-ref-store.c |   3 +-
 t/t3200-branch.sh         |  21 +++++++
 worktree.c                |  17 ++++--
 9 files changed, 209 insertions(+), 134 deletions(-)

Range-diff:
 6:  6dae8b643ad =  1:  bea88e382c0 branch tests: test for errno propagating on failing read
 4:  05f3a346e3b !  2:  46641111885 refs: make errno output explicit for read_raw_ref_fn
    @@
      ## Metadata ##
    -Author: Han-Wen Nienhuys <hanwen@google.com>
    +Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    refs: make errno output explicit for read_raw_ref_fn
    +    refs API: add a version of refs_resolve_ref_unsafe() with "errno"
     
    -    This makes it explicit how alternative ref backends should report errors in
    -    read_raw_ref_fn.
    +    Add a new refs_werrres_ref_unsafe() function, which is like
    +    refs_resolve_ref_unsafe() except that it explicitly saves away the
    +    "errno" to a passed-in parameter, the refs_resolve_ref_unsafe() then
    +    becomes a wrapper for it.
     
    -    read_raw_ref_fn needs to supply a credible errno for a number of cases. These
    -    are primarily:
    +    In subsequent commits we'll migrate code over to it, before finally
    +    making "refs_resolve_ref_unsafe()" with an "errno" parameter the
    +    canonical version, so this this function exists only so that we can
    +    incrementally migrate callers, it will be going away in a subsequent
    +    commit.
     
    -    1) The files backend calls read_raw_ref from lock_raw_ref, and uses the
    -    resulting error codes to create/remove directories as needed.
    +    As the added comment notes has a rather tortured name to be the same
    +    length as "refs_resolve_ref_unsafe", to avoid churn as we won't need
    +    to re-indent the argument lists, similarly the documentation and
    +    structure of it in refs.h is designed to minimize a diff in a
    +    subsequent commit, where that documentation will be added to the new
    +    refs_resolve_ref_unsafe().
     
    -    2) ENOENT should be translated in a zero OID, optionally with REF_ISBROKEN set,
    -    returning the last successfully resolved symref. This is necessary so
    -    read_raw_ref("HEAD") on an empty repo returns refs/heads/main (or the default branch
    -    du-jour), and we know on which branch to create the first commit.
    +    At the end of this migration the "meaningful errno" TODO item left in
    +    76d70dc0c63 (refs.c: make resolve_ref_unsafe set errno to something
    +    meaningful on error, 2014-06-20) will be resolved.
     
    -    Make this information flow explicit by adding a failure_errno to the signature
    -    of read_raw_ref. All errnos from the files backend are still propagated
    -    unchanged, even though inspection suggests only ENOTDIR, EISDIR and ENOENT are
    -    relevant.
    +    As can be seen from the use of refs_read_raw_ref() we'll also need to
    +    convert some functions that the new refs_werrres_ref_unsafe() itself
    +    calls to take this "failure_errno". That will be done in subsequent
    +    commits.
     
         Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## refs.c ##
     @@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store,
    - 	}
    - 
    - 	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
    --					   type);
    -+					   type, &errno);
    - }
    - 
    - /* This function needs to return a meaningful errno on failure */
    -
    - ## refs/debug.c ##
    -@@ refs/debug.c: debug_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
    - 
    - static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
    - 			      struct object_id *oid, struct strbuf *referent,
    --			      unsigned int *type)
    -+			      unsigned int *type, int *failure_errno)
    - {
    - 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
    - 	int res = 0;
    - 
    - 	oidcpy(oid, null_oid());
    --	errno = 0;
    - 	res = drefs->refs->be->read_raw_ref(drefs->refs, refname, oid, referent,
    --					    type);
    -+					    type, failure_errno);
    - 
    - 	if (res == 0) {
    - 		trace_printf_key(&trace_refs, "read_raw_ref: %s: %s (=> %s) type %x: %d\n",
    -@@ refs/debug.c: static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
    - 	} else {
    - 		trace_printf_key(&trace_refs,
    - 				 "read_raw_ref: %s: %d (errno %d)\n", refname,
    --				 res, errno);
    -+				 res, *failure_errno);
    - 	}
    - 	return res;
    - }
    -
    - ## refs/files-backend.c ##
    -@@ refs/files-backend.c: static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
    - 	return refs->loose;
    + 					   type, &errno);
      }
      
    --static int files_read_raw_ref(struct ref_store *ref_store,
    --			      const char *refname, struct object_id *oid,
    --			      struct strbuf *referent, unsigned int *type)
    -+static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
    -+			      struct object_id *oid, struct strbuf *referent,
    -+			      unsigned int *type, int *failure_errno)
    +-/* This function needs to return a meaningful errno on failure */
    +-const char *refs_resolve_ref_unsafe(struct ref_store *refs,
    ++const char *refs_werrres_ref_unsafe(struct ref_store *refs,
    + 				    const char *refname,
    + 				    int resolve_flags,
    +-				    struct object_id *oid, int *flags)
    ++				    struct object_id *oid,
    ++				    int *flags, int *failure_errno)
      {
    - 	struct files_ref_store *refs =
    - 		files_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
    -@@ refs/files-backend.c: static int files_read_raw_ref(struct ref_store *ref_store,
    - 	struct stat st;
    - 	int fd;
    - 	int ret = -1;
    --	int save_errno;
    - 	int remaining_retries = 3;
    - 
    - 	*type = 0;
    -@@ refs/files-backend.c: static int files_read_raw_ref(struct ref_store *ref_store,
    - 	ret = parse_loose_ref_contents(buf, oid, referent, type);
    - 
    - out:
    --	save_errno = errno;
    -+	*failure_errno = errno;
    - 	strbuf_release(&sb_path);
    - 	strbuf_release(&sb_contents);
    --	errno = save_errno;
    - 	return ret;
    - }
    + 	static struct strbuf sb_refname = STRBUF_INIT;
    + 	struct object_id unused_oid;
    + 	int unused_flags;
    + 	int symref_count;
    + 
    ++	assert(failure_errno);
    ++
    + 	if (!oid)
    + 		oid = &unused_oid;
    + 	if (!flags)
    +@@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
    + 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
    + 		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
    + 		    !refname_is_safe(refname)) {
    +-			errno = EINVAL;
    ++			*failure_errno = EINVAL;
    + 			return NULL;
    + 		}
      
    -@@ refs/files-backend.c: static int lock_raw_ref(struct files_ref_store *refs,
    - 	struct strbuf ref_file = STRBUF_INIT;
    - 	int attempts_remaining = 3;
    - 	int ret = TRANSACTION_GENERIC_ERROR;
    -+	int failure_errno;
    +@@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
    + 	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
    + 		unsigned int read_flags = 0;
      
    - 	assert(err);
    - 	files_assert_main_repository(refs, "lock_raw_ref");
    -@@ refs/files-backend.c: static int lock_raw_ref(struct files_ref_store *refs,
    - 	if (hold_lock_file_for_update_timeout(
    - 			    &lock->lk, ref_file.buf, LOCK_NO_DEREF,
    - 			    get_files_ref_lock_timeout_ms()) < 0) {
    --		if (errno == ENOENT && --attempts_remaining > 0) {
    -+		int myerr = errno;
     +		errno = 0;
    -+		if (myerr == ENOENT && --attempts_remaining > 0) {
    - 			/*
    - 			 * Maybe somebody just deleted one of the
    - 			 * directories leading to ref_file.  Try
    -@@ refs/files-backend.c: static int lock_raw_ref(struct files_ref_store *refs,
    + 		if (refs_read_raw_ref(refs, refname,
    + 				      oid, &sb_refname, &read_flags)) {
    + 			*flags |= read_flags;
    ++			if (errno)
    ++				*failure_errno = errno;
    + 
    + 			/* In reading mode, refs must eventually resolve */
    + 			if (resolve_flags & RESOLVE_REF_READING)
    +@@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
    + 			 * may show errors besides ENOENT if there are
    + 			 * similarly-named refs.
      			 */
    - 			goto retry;
    - 		} else {
    --			unable_to_lock_message(ref_file.buf, errno, err);
    -+			unable_to_lock_message(ref_file.buf, myerr, err);
    - 			goto error_return;
    - 		}
    - 	}
    -@@ refs/files-backend.c: static int lock_raw_ref(struct files_ref_store *refs,
    - 	 * fear that its value will change.
    - 	 */
    - 
    --	if (files_read_raw_ref(&refs->base, refname,
    --			       &lock->old_oid, referent, type)) {
    --		if (errno == ENOENT) {
    -+	if (files_read_raw_ref(&refs->base, refname, &lock->old_oid, referent,
    -+			       type, &failure_errno)) {
    -+		if (failure_errno == ENOENT) {
    - 			if (mustexist) {
    - 				/* Garden variety missing reference. */
    - 				strbuf_addf(err, "unable to resolve reference '%s'",
    -@@ refs/files-backend.c: static int lock_raw_ref(struct files_ref_store *refs,
    - 				 *   reference named "refs/foo/bar/baz".
    - 				 */
    - 			}
    --		} else if (errno == EISDIR) {
    -+		} else if (failure_errno == EISDIR) {
    - 			/*
    - 			 * There is a directory in the way. It might have
    - 			 * contained references that have been deleted. If
    -@@ refs/files-backend.c: static int lock_raw_ref(struct files_ref_store *refs,
    - 					goto error_return;
    - 				}
    +-			if (errno != ENOENT &&
    +-			    errno != EISDIR &&
    +-			    errno != ENOTDIR)
    ++			if (*failure_errno != ENOENT &&
    ++			    *failure_errno != EISDIR &&
    ++			    *failure_errno != ENOTDIR)
    + 				return NULL;
    + 
    + 			oidclr(oid);
    +@@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
    + 		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
    + 			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
    + 			    !refname_is_safe(refname)) {
    +-				errno = EINVAL;
    ++				*failure_errno = EINVAL;
    + 				return NULL;
      			}
    --		} else if (errno == EINVAL && (*type & REF_ISBROKEN)) {
    -+		} else if (failure_errno == EINVAL && (*type & REF_ISBROKEN)) {
    - 			strbuf_addf(err, "unable to resolve reference '%s': "
    - 				    "reference broken", refname);
    - 			goto error_return;
    - 		} else {
    - 			strbuf_addf(err, "unable to resolve reference '%s': %s",
    --				    refname, strerror(errno));
    -+				    refname, strerror(failure_errno));
    - 			goto error_return;
    + 
    +@@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
      		}
    + 	}
      
    -
    - ## refs/packed-backend.c ##
    -@@ refs/packed-backend.c: static struct snapshot *get_snapshot(struct packed_ref_store *refs)
    - 	return refs->snapshot;
    +-	errno = ELOOP;
    ++	*failure_errno = ELOOP;
    + 	return NULL;
      }
      
    --static int packed_read_raw_ref(struct ref_store *ref_store,
    --			       const char *refname, struct object_id *oid,
    --			       struct strbuf *referent, unsigned int *type)
    -+static int packed_read_raw_ref(struct ref_store *ref_store, const char *refname,
    -+			       struct object_id *oid, struct strbuf *referent,
    -+			       unsigned int *type, int *failure_errno)
    ++const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
    ++				    int resolve_flags, struct object_id *oid,
    ++				    int *flags)
    ++{
    ++	int failure_errno = 0;
    ++	const char *refn;
    ++	refn = refs_werrres_ref_unsafe(refs, refname, resolve_flags,
    ++				       oid, flags, &failure_errno);
    ++	if (!refn)
    ++		errno = failure_errno;
    ++	return refn;
    ++}
    ++
    + /* backend functions */
    + int refs_init_db(struct strbuf *err)
      {
    - 	struct packed_ref_store *refs =
    - 		packed_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
    -@@ refs/packed-backend.c: static int packed_read_raw_ref(struct ref_store *ref_store,
    - 
    - 	if (!rec) {
    - 		/* refname is not a packed reference. */
    --		errno = ENOENT;
    -+		*failure_errno = ENOENT;
    - 		return -1;
    - 	}
    - 
     
    - ## refs/refs-internal.h ##
    -@@ refs/refs-internal.h: typedef int reflog_expire_fn(struct ref_store *ref_store,
    -  * properly-formatted or even safe reference name. NEITHER INPUT NOR
    -  * OUTPUT REFERENCE NAMES ARE VALIDATED WITHIN THIS FUNCTION.
    -  *
    -- * Return 0 on success. If the ref doesn't exist, set errno to ENOENT
    -- * and return -1. If the ref exists but is neither a symbolic ref nor
    -- * an object ID, it is broken; set REF_ISBROKEN in type, and return -1
    -- * (errno should not be ENOENT) If there is another error reading the
    -- * ref, set errno appropriately and return -1.
    -+ * Return 0 on success, or -1 on failure. If the ref exists but is neither a
    -+ * symbolic ref nor an object ID, it is broken. In this case set REF_ISBROKEN in
    -+ * type, and return -1 (failure_errno should not be ENOENT)
    -+ *
    -+ * failure_errno provides errno codes that are interpreted beyond error
    -+ * reporting. The following error codes have special meaning:
    -+ *    * ENOENT: the ref doesn't exist
    -+ *    * EISDIR: ref name is a directory
    -+ *    * ENOTDIR: ref prefix is not a directory
    + ## refs.h ##
    +@@ refs.h: struct string_list;
    + struct string_list_item;
    + struct worktree;
    + 
    ++/*
    ++ * Callers should not inspect "errno" on failure, but rather pass in a
    ++ * "failure_errno" parameter, on failure the "errno" will indicate the
    ++ * type of failure encountered, but not necessarily one that came from
    ++ * a syscall. We might have faked it up.
    ++ */
    ++const char *refs_werrres_ref_unsafe(struct ref_store *refs,
    ++				    const char *refname,
    ++				    int resolve_flags,
    ++				    struct object_id *oid,
    ++				    int *flags, int *failure_errno);
    ++
    + /*
    +  * Resolve a reference, recursively following symbolic refererences.
       *
    -  * Backend-specific flags might be set in type as well, regardless of
    -  * outcome.
    -@@ refs/refs-internal.h: typedef int reflog_expire_fn(struct ref_store *ref_store,
    -  * - in all other cases, referent will be untouched, and therefore
    -  *   refname will still be valid and unchanged.
    -  */
    --typedef int read_raw_ref_fn(struct ref_store *ref_store,
    --			    const char *refname, struct object_id *oid,
    --			    struct strbuf *referent, unsigned int *type);
    -+typedef int read_raw_ref_fn(struct ref_store *ref_store, const char *refname,
    -+			    struct object_id *oid, struct strbuf *referent,
    -+			    unsigned int *type, int *failure_errno);
    - 
    - struct ref_storage_be {
    - 	struct ref_storage_be *next;
 5:  fa9260f25fa !  3:  a1a80715ffe refs: add failure_errno to refs_read_raw_ref() signature
    @@ Metadata
     Author: Han-Wen Nienhuys <hanwen@google.com>
     
      ## Commit message ##
    -    refs: add failure_errno to refs_read_raw_ref() signature
    +    refs API: make refs_read_raw_ref() not set errno
     
    -    This lets us use the explicit errno output parameter in refs_resolve_ref_unsafe.
    -
    -    Some of our callers explicitly do not care about the errno, rather
    -    than understanding NULL let's have them declare that they don't care
    -    by passing in an "ignore_errno". There's only three of them, and using
    -    that pattern will make it more obvious that they want to throw away
    -    data, let's also add a comment to one of the callers about why we'd
    -    like to ignore the errno.
    -
    -    Let's not extend that to refs_resolve_ref_unsafe() itself for now, it
    -    has a large set of legacy callers, so we're faking up the old "errno"
    -    behavior for it. We can convert those callers to
    -    refs_resolve_ref_unsafe_with_errno() later.
    +    Add a "failure_errno" to refs_read_raw_ref(), his allows
    +    refs_werrres_ref_unsafe() to pass along its "failure_errno", as a
    +    first step before its own callers are migrated to pass it further up
    +    the chain.
     
         We are leaving out out the refs_read_special_head() in
    -    refs_read_raw_ref() for now, as noted in the next commit moving it to
    -    "failure_errno" will require some special consideration.
    -
    -    We're intentionally mis-indenting the argument list of the new
    -    refs_resolve_ref_unsafe_with_errno(), it will be non-static in a
    -    subsequent commit, doing it this way makes that diff smaller.
    +    refs_read_raw_ref() for now, as noted in a subsequent commit moving it
    +    to "failure_errno" will require some special consideration.
     
         Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ refs.c: static int refs_read_special_head(struct ref_store *ref_store,
     +					   type, failure_errno);
      }
      
    --/* This function needs to return a meaningful errno on failure */
    --const char *refs_resolve_ref_unsafe(struct ref_store *refs,
    --				    const char *refname,
    --				    int resolve_flags,
    --				    struct object_id *oid, int *flags)
    -+static const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
    -+					       const char *refname,
    -+					       int resolve_flags,
    -+					       struct object_id *oid,
    -+					       int *flags, int *failure_errno)
    - {
    - 	static struct strbuf sb_refname = STRBUF_INIT;
    - 	struct object_id unused_oid;
    - 	int unused_flags;
    - 	int symref_count;
    - 
    -+	assert(failure_errno);
    -+
    - 	if (!oid)
    - 		oid = &unused_oid;
    - 	if (!flags)
    -@@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
    - 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
    - 		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
    - 		    !refname_is_safe(refname)) {
    --			errno = EINVAL;
    -+			*failure_errno = EINVAL;
    - 			return NULL;
    - 		}
    - 
    -@@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
    + const char *refs_werrres_ref_unsafe(struct ref_store *refs,
    +@@ refs.c: const char *refs_werrres_ref_unsafe(struct ref_store *refs,
      	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
      		unsigned int read_flags = 0;
      
    +-		errno = 0;
     -		if (refs_read_raw_ref(refs, refname,
     -				      oid, &sb_refname, &read_flags)) {
     +		if (refs_read_raw_ref(refs, refname, oid, &sb_refname,
     +				      &read_flags, failure_errno)) {
      			*flags |= read_flags;
    - 
    - 			/* In reading mode, refs must eventually resolve */
    -@@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
    - 			 * may show errors besides ENOENT if there are
    - 			 * similarly-named refs.
    - 			 */
    --			if (errno != ENOENT &&
    --			    errno != EISDIR &&
    --			    errno != ENOTDIR)
    -+			if (*failure_errno != ENOENT &&
    -+			    *failure_errno != EISDIR &&
    -+			    *failure_errno != ENOTDIR)
    - 				return NULL;
    - 
    - 			oidclr(oid);
    -@@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
    - 		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
    - 			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
    - 			    !refname_is_safe(refname)) {
    --				errno = EINVAL;
    -+				*failure_errno = EINVAL;
    - 				return NULL;
    - 			}
    - 
    -@@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
    - 		}
    - 	}
    - 
    --	errno = ELOOP;
    -+	*failure_errno = ELOOP;
    - 	return NULL;
    - }
    - 
    -+const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
    -+				    int resolve_flags, struct object_id *oid,
    -+				    int *flags)
    -+{
    -+	int failure_errno = 0;
    -+	const char *refn;
    -+	refn = refs_resolve_ref_unsafe_with_errno(refs, refname, resolve_flags,
    -+						  oid, flags, &failure_errno);
    -+	if (!refn)
    -+		/* For unmigrated legacy callers */
    -+		errno = failure_errno;
    -+	return refn;
    -+}
    -+
    - /* backend functions */
    - int refs_init_db(struct strbuf *err)
    - {
    + 			if (errno)
    + 				*failure_errno = errno;
     @@ refs.c: int refs_verify_refname_available(struct ref_store *refs,
      
      	strbuf_grow(&dirname, strlen(refname) + 1);
 7:  18bf4a0e97c !  4:  758c761abcf refs: explicitly return failure_errno from parse_loose_ref_contents
    @@ Metadata
     Author: Han-Wen Nienhuys <hanwen@google.com>
     
      ## Commit message ##
    -    refs: explicitly return failure_errno from parse_loose_ref_contents
    +    refs API: make parse_loose_ref_contents() not set errno
    +
    +    Change the parse_loose_ref_contents() function to stop setting "errno"
    +    and failure, and to instead pass up a "failure_errno" via a
    +    parameter. This requires changing its callers to do the same.
     
         The EINVAL error from parse_loose_ref_contents is used in files-backend
         to create a custom error message.
 1:  f06b054e861 !  5:  cdf17fa34a4 refs file backend: move raceproof_create_file() here
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    refs file backend: move raceproof_create_file() here
    +    refs API: make refs_rename_ref_available() static
     
    -    Move the raceproof_create_file() API added to cache.h and
    -    object-file.c in 177978f56ad (raceproof_create_file(): new function,
    -    2017-01-06) to its only user, refs/files-backend.c.
    +    Move the refs_rename_ref_available() function into
    +    "refs/files-backend.c". It is file-backend specific.
     
    -    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    This function was added in 5fe7d825da8 (refs.c: pass a list of names
    +    to skip to is_refname_available, 2014-05-01) as rename_ref_available()
    +    and was only ever used in this one file-backend specific codepath. So
    +    let's move it there.
     
    - ## cache.h ##
    -@@ cache.h: enum scld_error safe_create_leading_directories(char *path);
    - enum scld_error safe_create_leading_directories_const(const char *path);
    - enum scld_error safe_create_leading_directories_no_share(char *path);
    - 
    --/*
    -- * Callback function for raceproof_create_file(). This function is
    -- * expected to do something that makes dirname(path) permanent despite
    -- * the fact that other processes might be cleaning up empty
    -- * directories at the same time. Usually it will create a file named
    -- * path, but alternatively it could create another file in that
    -- * directory, or even chdir() into that directory. The function should
    -- * return 0 if the action was completed successfully. On error, it
    -- * should return a nonzero result and set errno.
    -- * raceproof_create_file() treats two errno values specially:
    -- *
    -- * - ENOENT -- dirname(path) does not exist. In this case,
    -- *             raceproof_create_file() tries creating dirname(path)
    -- *             (and any parent directories, if necessary) and calls
    -- *             the function again.
    -- *
    -- * - EISDIR -- the file already exists and is a directory. In this
    -- *             case, raceproof_create_file() removes the directory if
    -- *             it is empty (and recursively any empty directories that
    -- *             it contains) and calls the function again.
    -- *
    -- * Any other errno causes raceproof_create_file() to fail with the
    -- * callback's return value and errno.
    -- *
    -- * Obviously, this function should be OK with being called again if it
    -- * fails with ENOENT or EISDIR. In other scenarios it will not be
    -- * called again.
    -- */
    --typedef int create_file_fn(const char *path, void *cb);
    --
    --/*
    -- * Create a file in dirname(path) by calling fn, creating leading
    -- * directories if necessary. Retry a few times in case we are racing
    -- * with another process that is trying to clean up the directory that
    -- * contains path. See the documentation for create_file_fn for more
    -- * details.
    -- *
    -- * Return the value and set the errno that resulted from the most
    -- * recent call of fn. fn is always called at least once, and will be
    -- * called more than once if it returns ENOENT or EISDIR.
    -- */
    --int raceproof_create_file(const char *path, create_file_fn fn, void *cb);
    --
    - int mkdir_in_gitdir(const char *path);
    - char *expand_user_path(const char *path, int real_home);
    - const char *enter_repo(const char *path, int strict);
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## object-file.c ##
    -@@ object-file.c: enum scld_error safe_create_leading_directories_const(const char *path)
    - 	return result;
    + ## refs.c ##
    +@@ refs.c: const char *find_descendant_ref(const char *dirname,
    + 	return NULL;
      }
      
    --int raceproof_create_file(const char *path, create_file_fn fn, void *cb)
    +-int refs_rename_ref_available(struct ref_store *refs,
    +-			      const char *old_refname,
    +-			      const char *new_refname)
     -{
    --	/*
    --	 * The number of times we will try to remove empty directories
    --	 * in the way of path. This is only 1 because if another
    --	 * process is racily creating directories that conflict with
    --	 * us, we don't want to fight against them.
    --	 */
    --	int remove_directories_remaining = 1;
    --
    --	/*
    --	 * The number of times that we will try to create the
    --	 * directories containing path. We are willing to attempt this
    --	 * more than once, because another process could be trying to
    --	 * clean up empty directories at the same time as we are
    --	 * trying to create them.
    --	 */
    --	int create_directories_remaining = 3;
    --
    --	/* A scratch copy of path, filled lazily if we need it: */
    --	struct strbuf path_copy = STRBUF_INIT;
    --
    --	int ret, save_errno;
    --
    --	/* Sanity check: */
    --	assert(*path);
    +-	struct string_list skip = STRING_LIST_INIT_NODUP;
    +-	struct strbuf err = STRBUF_INIT;
    +-	int ok;
     -
    --retry_fn:
    --	ret = fn(path, cb);
    --	save_errno = errno;
    --	if (!ret)
    --		goto out;
    +-	string_list_insert(&skip, old_refname);
    +-	ok = !refs_verify_refname_available(refs, new_refname,
    +-					    NULL, &skip, &err);
    +-	if (!ok)
    +-		error("%s", err.buf);
     -
    --	if (errno == EISDIR && remove_directories_remaining-- > 0) {
    --		/*
    --		 * A directory is in the way. Maybe it is empty; try
    --		 * to remove it:
    --		 */
    --		if (!path_copy.len)
    --			strbuf_addstr(&path_copy, path);
    --
    --		if (!remove_dir_recursively(&path_copy, REMOVE_DIR_EMPTY_ONLY))
    --			goto retry_fn;
    --	} else if (errno == ENOENT && create_directories_remaining-- > 0) {
    --		/*
    --		 * Maybe the containing directory didn't exist, or
    --		 * maybe it was just deleted by a process that is
    --		 * racing with us to clean up empty directories. Try
    --		 * to create it:
    --		 */
    --		enum scld_error scld_result;
    --
    --		if (!path_copy.len)
    --			strbuf_addstr(&path_copy, path);
    --
    --		do {
    --			scld_result = safe_create_leading_directories(path_copy.buf);
    --			if (scld_result == SCLD_OK)
    --				goto retry_fn;
    --		} while (scld_result == SCLD_VANISHED && create_directories_remaining-- > 0);
    --	}
    --
    --out:
    --	strbuf_release(&path_copy);
    --	errno = save_errno;
    --	return ret;
    +-	string_list_clear(&skip, 0);
    +-	strbuf_release(&err);
    +-	return ok;
     -}
     -
    - static void fill_loose_path(struct strbuf *buf, const struct object_id *oid)
    + int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
      {
    - 	int i;
    + 	struct object_id oid;
     
      ## refs/files-backend.c ##
    -@@ refs/files-backend.c: static struct ref_iterator *files_ref_iterator_begin(
    - 	return ref_iterator;
    - }
    +@@ refs/files-backend.c: static int commit_ref_update(struct files_ref_store *refs,
    + 			     const struct object_id *oid, const char *logmsg,
    + 			     struct strbuf *err);
      
     +/*
    -+ * Callback function for raceproof_create_file(). This function is
    -+ * expected to do something that makes dirname(path) permanent despite
    -+ * the fact that other processes might be cleaning up empty
    -+ * directories at the same time. Usually it will create a file named
    -+ * path, but alternatively it could create another file in that
    -+ * directory, or even chdir() into that directory. The function should
    -+ * return 0 if the action was completed successfully. On error, it
    -+ * should return a nonzero result and set errno.
    -+ * raceproof_create_file() treats two errno values specially:
    ++ * Check whether an attempt to rename old_refname to new_refname would
    ++ * cause a D/F conflict with any existing reference (other than
    ++ * possibly old_refname). If there would be a conflict, emit an error
    ++ * message and return false; otherwise, return true.
     + *
    -+ * - ENOENT -- dirname(path) does not exist. In this case,
    -+ *             raceproof_create_file() tries creating dirname(path)
    -+ *             (and any parent directories, if necessary) and calls
    -+ *             the function again.
    -+ *
    -+ * - EISDIR -- the file already exists and is a directory. In this
    -+ *             case, raceproof_create_file() removes the directory if
    -+ *             it is empty (and recursively any empty directories that
    -+ *             it contains) and calls the function again.
    -+ *
    -+ * Any other errno causes raceproof_create_file() to fail with the
    -+ * callback's return value and errno.
    -+ *
    -+ * Obviously, this function should be OK with being called again if it
    -+ * fails with ENOENT or EISDIR. In other scenarios it will not be
    -+ * called again.
    -+ */
    -+typedef int create_file_fn(const char *path, void *cb);
    -+
    -+/*
    -+ * Create a file in dirname(path) by calling fn, creating leading
    -+ * directories if necessary. Retry a few times in case we are racing
    -+ * with another process that is trying to clean up the directory that
    -+ * contains path. See the documentation for create_file_fn for more
    -+ * details.
    -+ *
    -+ * Return the value and set the errno that resulted from the most
    -+ * recent call of fn. fn is always called at least once, and will be
    -+ * called more than once if it returns ENOENT or EISDIR.
    ++ * Note that this function is not safe against all races with other
    ++ * processes (though rename_ref() catches some races that might get by
    ++ * this check).
     + */
    -+static int raceproof_create_file(const char *path, create_file_fn fn, void *cb)
    ++static int refs_rename_ref_available(struct ref_store *refs,
    ++			      const char *old_refname,
    ++			      const char *new_refname)
     +{
    -+	/*
    -+	 * The number of times we will try to remove empty directories
    -+	 * in the way of path. This is only 1 because if another
    -+	 * process is racily creating directories that conflict with
    -+	 * us, we don't want to fight against them.
    -+	 */
    -+	int remove_directories_remaining = 1;
    -+
    -+	/*
    -+	 * The number of times that we will try to create the
    -+	 * directories containing path. We are willing to attempt this
    -+	 * more than once, because another process could be trying to
    -+	 * clean up empty directories at the same time as we are
    -+	 * trying to create them.
    -+	 */
    -+	int create_directories_remaining = 3;
    -+
    -+	/* A scratch copy of path, filled lazily if we need it: */
    -+	struct strbuf path_copy = STRBUF_INIT;
    -+
    -+	int ret, save_errno;
    -+
    -+	/* Sanity check: */
    -+	assert(*path);
    -+
    -+retry_fn:
    -+	ret = fn(path, cb);
    -+	save_errno = errno;
    -+	if (!ret)
    -+		goto out;
    ++	struct string_list skip = STRING_LIST_INIT_NODUP;
    ++	struct strbuf err = STRBUF_INIT;
    ++	int ok;
     +
    -+	if (errno == EISDIR && remove_directories_remaining-- > 0) {
    -+		/*
    -+		 * A directory is in the way. Maybe it is empty; try
    -+		 * to remove it:
    -+		 */
    -+		if (!path_copy.len)
    -+			strbuf_addstr(&path_copy, path);
    ++	string_list_insert(&skip, old_refname);
    ++	ok = !refs_verify_refname_available(refs, new_refname,
    ++					    NULL, &skip, &err);
    ++	if (!ok)
    ++		error("%s", err.buf);
     +
    -+		if (!remove_dir_recursively(&path_copy, REMOVE_DIR_EMPTY_ONLY))
    -+			goto retry_fn;
    -+	} else if (errno == ENOENT && create_directories_remaining-- > 0) {
    -+		/*
    -+		 * Maybe the containing directory didn't exist, or
    -+		 * maybe it was just deleted by a process that is
    -+		 * racing with us to clean up empty directories. Try
    -+		 * to create it:
    -+		 */
    -+		enum scld_error scld_result;
    -+
    -+		if (!path_copy.len)
    -+			strbuf_addstr(&path_copy, path);
    -+
    -+		do {
    -+			scld_result = safe_create_leading_directories(path_copy.buf);
    -+			if (scld_result == SCLD_OK)
    -+				goto retry_fn;
    -+		} while (scld_result == SCLD_VANISHED && create_directories_remaining-- > 0);
    -+	}
    -+
    -+out:
    -+	strbuf_release(&path_copy);
    -+	errno = save_errno;
    -+	return ret;
    ++	string_list_clear(&skip, 0);
    ++	strbuf_release(&err);
    ++	return ok;
     +}
     +
    - static int remove_empty_directories(struct strbuf *path)
    - {
    - 	/*
    + static int files_copy_or_rename_ref(struct ref_store *ref_store,
    + 			    const char *oldrefname, const char *newrefname,
    + 			    const char *logmsg, int copy)
    +
    + ## refs/refs-internal.h ##
    +@@ refs/refs-internal.h: const char *find_descendant_ref(const char *dirname,
    + 				const struct string_list *extras,
    + 				const struct string_list *skip);
    + 
    +-/*
    +- * Check whether an attempt to rename old_refname to new_refname would
    +- * cause a D/F conflict with any existing reference (other than
    +- * possibly old_refname). If there would be a conflict, emit an error
    +- * message and return false; otherwise, return true.
    +- *
    +- * Note that this function is not safe against all races with other
    +- * processes (though rename_ref() catches some races that might get by
    +- * this check).
    +- */
    +-int refs_rename_ref_available(struct ref_store *refs,
    +-			      const char *old_refname,
    +-			      const char *new_refname);
    +-
    + /* We allow "recursive" symbolic refs. Only within reason, though */
    + #define SYMREF_MAXDEPTH 5
    + 
 2:  ba0f5f5fb0a <  -:  ----------- refs: remove EINVAL errno output from specification of read_raw_ref_fn
 -:  ----------- >  6:  3162bf28505 refs/files: remove "name exist?" check in lock_ref_oid_basic()
 3:  2c4c30e8e06 !  7:  288237b1900 refs/files-backend: stop setting errno from lock_ref_oid_basic
    @@
      ## Metadata ##
    -Author: Han-Wen Nienhuys <hanwen@google.com>
    +Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    refs/files-backend: stop setting errno from lock_ref_oid_basic
    +    refs API: remove refs_read_ref_full() wrapper
     
    -    refs/files-backend.c::lock_ref_oid_basic() tries to signal how it failed
    -    to its callers using errno.
    +    Remove the refs_read_ref_full() wrapper in favor of migrating various
    +    refs.c API users to the underlying refs_werrres_ref_unsafe() function.
     
    -    It is safe to stop setting errno here, because the callers of this
    -    file-scope static function are
    +    A careful reading of these callers shows that the callers of this
    +    function did not care about "errno", by moving away from the
    +    refs_resolve_ref_unsafe() wrapper we can be sure that nothing relies
    +    on it anymore.
     
    -    * files_copy_or_rename_ref()
    -    * files_create_symref()
    -    * files_reflog_expire()
    -
    -    None of them looks at errno after seeing a negative return from
    -    lock_ref_oid_basic() to make any decision, and no caller of these three
    -    functions looks at errno after they signal a failure by returning a
    -    negative value. In particular,
    -
    -    * files_copy_or_rename_ref() - here, calls are followed by error()
    -    (which performs I/O) or write_ref_to_lockfile() (which calls
    -    parse_object() which may perform I/O)
    -
    -    * files_create_symref() - here, calls are followed by error() or
    -    create_symref_locked() (which performs I/O and does not inspect
    -    errno)
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    -    * files_reflog_expire() - here, calls are followed by error() or
    -    refs_reflog_exists() (which calls a function in a vtable that is not
    -    documented to use and/or preserve errno)
    + ## refs.c ##
    +@@ refs.c: struct ref_filter {
    + 	void *cb_data;
    + };
    + 
    +-int refs_read_ref_full(struct ref_store *refs, const char *refname,
    +-		       int resolve_flags, struct object_id *oid, int *flags)
    ++int read_ref_full(const char *refname, int resolve_flags, struct object_id *oid, int *flags)
    + {
    +-	if (refs_resolve_ref_unsafe(refs, refname, resolve_flags, oid, flags))
    ++	int ignore_errno;
    ++	struct ref_store *refs = get_main_ref_store(the_repository);
    ++
    ++	if (refs_werrres_ref_unsafe(refs, refname, resolve_flags,
    ++				    oid, flags, &ignore_errno))
    + 		return 0;
    + 	return -1;
    + }
    + 
    +-int read_ref_full(const char *refname, int resolve_flags, struct object_id *oid, int *flags)
    +-{
    +-	return refs_read_ref_full(get_main_ref_store(the_repository), refname,
    +-				  resolve_flags, oid, flags);
    +-}
    +-
    + int read_ref(const char *refname, struct object_id *oid)
    + {
    + 	return read_ref_full(refname, RESOLVE_REF_READING, oid, NULL);
    +@@ refs.c: int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
    + {
    + 	struct object_id oid;
    + 	int flag;
    ++	int ignore_errno;
    + 
    +-	if (!refs_read_ref_full(refs, "HEAD", RESOLVE_REF_READING,
    +-				&oid, &flag))
    ++	if (refs_werrres_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING,
    ++				    &oid, &flag, &ignore_errno))
    + 		return fn("HEAD", &oid, flag, cb_data);
    + 
    + 	return 0;
     
    -    Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
    -    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    + ## refs.h ##
    +@@ refs.h: char *refs_resolve_refdup(struct ref_store *refs,
    + char *resolve_refdup(const char *refname, int resolve_flags,
    + 		     struct object_id *oid, int *flags);
    + 
    +-int refs_read_ref_full(struct ref_store *refs, const char *refname,
    +-		       int resolve_flags, struct object_id *oid, int *flags);
    + int read_ref_full(const char *refname, int resolve_flags,
    + 		  struct object_id *oid, int *flags);
    + int read_ref(const char *refname, struct object_id *oid);
     
      ## refs/files-backend.c ##
    -@@ refs/files-backend.c: static int create_reflock(const char *path, void *cb)
    - 
    - /*
    -  * Locks a ref returning the lock on success and NULL on failure.
    -- * On failure errno is set to something meaningful.
    -  */
    - static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
    - 					   const char *refname, int *type,
     @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
      {
      	struct strbuf ref_file = STRBUF_INIT;
      	struct ref_lock *lock;
    --	int last_errno = 0;
    ++	int ignore_errno;
      
      	files_assert_main_repository(refs, "lock_ref_oid_basic");
      	assert(err);
     @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
    - 	if (!refs_resolve_ref_unsafe(&refs->base, refname,
    - 				     RESOLVE_REF_NO_RECURSE,
    - 				     &lock->old_oid, type)) {
    --		last_errno = errno;
    - 		if (!refs_verify_refname_available(&refs->base, refname,
    - 						   NULL, NULL, err))
    - 			strbuf_addf(err, "unable to resolve reference '%s': %s",
    --				    refname, strerror(last_errno));
    -+				    refname, strerror(errno));
    - 
      		goto error_return;
      	}
    -@@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
    + 
    +-	if (refs_read_ref_full(&refs->base, lock->ref_name,
    +-			       0,
    +-			       &lock->old_oid, NULL))
    ++	if (!refs_werrres_ref_unsafe(&refs->base, lock->ref_name, 0,
    ++				     &lock->old_oid, NULL, &ignore_errno))
    + 		oidclr(&lock->old_oid);
    + 	goto out;
    + 
    +@@ refs/files-backend.c: static int files_copy_or_rename_ref(struct ref_store *ref_store,
    + 	struct strbuf tmp_renamed_log = STRBUF_INIT;
    + 	int log, ret;
    + 	struct strbuf err = STRBUF_INIT;
    ++	int ignore_errno;
    + 
    + 	files_reflog_path(refs, &sb_oldref, oldrefname);
    + 	files_reflog_path(refs, &sb_newref, newrefname);
    +@@ refs/files-backend.c: static int files_copy_or_rename_ref(struct ref_store *ref_store,
    + 	 * the safety anyway; we want to delete the reference whatever
    + 	 * its current value.
      	 */
    - 	if (is_null_oid(&lock->old_oid) &&
    - 	    refs_verify_refname_available(refs->packed_ref_store, refname,
    --					  NULL, NULL, err)) {
    --		last_errno = ENOTDIR;
    -+					  NULL, NULL, err))
    - 		goto error_return;
    --	}
    +-	if (!copy && !refs_read_ref_full(&refs->base, newrefname,
    +-				RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
    +-				NULL, NULL) &&
    ++	if (!copy && refs_werrres_ref_unsafe(&refs->base, newrefname,
    ++					     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
    ++					     NULL, NULL, &ignore_errno) &&
    + 	    refs_delete_ref(&refs->base, NULL, newrefname,
    + 			    NULL, REF_NO_DEREF)) {
    + 		if (errno == EISDIR) {
    +@@ refs/files-backend.c: static void update_symref_reflog(struct files_ref_store *refs,
    + {
    + 	struct strbuf err = STRBUF_INIT;
    + 	struct object_id new_oid;
    ++	int ignore_errno;
    ++
    + 	if (logmsg &&
    +-	    !refs_read_ref_full(&refs->base, target,
    +-				RESOLVE_REF_READING, &new_oid, NULL) &&
    ++	    refs_werrres_ref_unsafe(&refs->base, target,
    ++				    RESOLVE_REF_READING, &new_oid, NULL,
    ++				    &ignore_errno) &&
    + 	    files_log_ref_write(refs, refname, &lock->old_oid,
    + 				&new_oid, logmsg, 0, &err)) {
    + 		error("%s", err.buf);
    +@@ refs/files-backend.c: static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
    + 		(struct files_reflog_iterator *)ref_iterator;
    + 	struct dir_iterator *diter = iter->dir_iterator;
    + 	int ok;
    ++	int ignore_errno;
      
    - 	lock->ref_name = xstrdup(refname);
    + 	while ((ok = dir_iterator_advance(diter)) == ITER_OK) {
    + 		int flags;
    +@@ refs/files-backend.c: static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
    + 		if (ends_with(diter->basename, ".lock"))
    + 			continue;
      
    - 	if (raceproof_create_file(ref_file.buf, create_reflock, &lock->lk)) {
    --		last_errno = errno;
    - 		unable_to_lock_message(ref_file.buf, errno, err);
    - 		goto error_return;
    - 	}
    -@@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
    +-		if (refs_read_ref_full(iter->ref_store,
    +-				       diter->relative_path, 0,
    +-				       &iter->oid, &flags)) {
    ++		if (!refs_werrres_ref_unsafe(iter->ref_store,
    ++					     diter->relative_path, 0,
    ++					     &iter->oid, &flags,
    ++					     &ignore_errno)) {
    + 			error("bad ref for %s", diter->path.buf);
    + 			continue;
    + 		}
    +@@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *refs,
    + 			 * the transaction, so we have to read it here
    + 			 * to record and possibly check old_oid:
    + 			 */
    +-			if (refs_read_ref_full(&refs->base,
    +-					       referent.buf, 0,
    +-					       &lock->old_oid, NULL)) {
    ++			int ignore_errno;
    ++			if (!refs_werrres_ref_unsafe(&refs->base,
    ++						     referent.buf, 0,
    ++						     &lock->old_oid, NULL,
    ++						     &ignore_errno)) {
    + 				if (update->flags & REF_HAVE_OLD) {
    + 					strbuf_addf(err, "cannot lock ref '%s': "
    + 						    "error reading reference",
    +
    + ## worktree.c ##
    +@@ worktree.c: int other_head_refs(each_ref_fn fn, void *cb_data)
    + 		struct worktree *wt = *p;
    + 		struct object_id oid;
    + 		int flag;
    ++		int ignore_errno;
      
    -  out:
    - 	strbuf_release(&ref_file);
    --	errno = last_errno;
    - 	return lock;
    - }
    + 		if (wt->is_current)
    + 			continue;
      
    + 		strbuf_reset(&refname);
    + 		strbuf_worktree_ref(wt, &refname, "HEAD");
    +-		if (!refs_read_ref_full(get_main_ref_store(the_repository),
    +-					refname.buf,
    +-					RESOLVE_REF_READING,
    +-					&oid, &flag))
    ++		if (refs_werrres_ref_unsafe(get_main_ref_store(the_repository),
    ++					    refname.buf,
    ++					    RESOLVE_REF_READING,
    ++					    &oid, &flag, &ignore_errno))
    + 			ret = fn(refname.buf, &oid, flag, cb_data);
    + 		if (ret)
    + 			break;
 -:  ----------- >  8:  acb484ea547 refs API: make resolve_gitlink_ref() not set errno
 -:  ----------- >  9:  4be84c9bf53 refs API: make loose_fill_ref_dir() not set errno
 -:  ----------- > 10:  8753210f9cc refs API: make files_copy_or_rename_ref() et al not set errno
 -:  ----------- > 11:  9fe85926140 refs API: ignore errno in worktree.c's add_head_info()
 -:  ----------- > 12:  8d87db98041 refs API: ignore errno in worktree.c's find_shared_symref()
 -:  ----------- > 13:  954633bcbb2 refs tests: ignore ignore errno in test-ref-store helper
 -:  ----------- > 14:  fbbc08d3ebd refs API: make refs_resolve_refdup() not set errno
 -:  ----------- > 15:  4b2a4dbe7d5 refs API: make refs_ref_exists() not set errno
 -:  ----------- > 16:  888b1884c29 refs API: make resolve_ref_unsafe() not set errno
 -:  ----------- > 17:  e2885f13c9b refs API: make expand_ref() & repo_dwim_log() not set errno
 -:  ----------- > 18:  df50373a272 refs API: don't expose "errno" in run_transaction_hook()
 8:  7d94a32af83 ! 19:  4c80b05bf1d refs: make errno output explicit for refs_resolve_ref_unsafe
    @@
      ## Metadata ##
    -Author: Han-Wen Nienhuys <hanwen@google.com>
    +Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    refs: make errno output explicit for refs_resolve_ref_unsafe
    +    refs API: post-migration API renaming [1/2]
     
    -    This introduces refs_resolve_ref_unsafe_with_errno(), which makes the API
    -    contract for the errno output explicit. The implementation still relies on
    -    the global errno variable to ensure no side effects of this refactoring.
    +    In preceding commits all callers of refs_resolve_ref_unsafe() were
    +    migrated to the transitory refs_werrres_ref_unsafe() function.
     
    -    lock_ref_oid_basic() in files-backend.c is the only caller of refs_resolve_ref()
    -    that needs error information to make logic decisions, so update that caller
    +    As a first step in getting rid of it let's remove the old function
    +    from the public API (it went unused in a preceding commit).
    +
    +    We then provide both a coccinelle rule to do the rename, and a macro
    +    to avoid breaking the existing callers.
     
    -    Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## contrib/coccinelle/refs.pending.cocci (new) ##
    +@@
    ++@@
    ++expression refs, refname, resolve_flags, oid, flags, failure_errno;
    ++@@
    ++- refs_werrres_ref_unsafe(refs, refname, resolve_flags, oid, flags, failure_errno)
    +++ refs_resolve_ref_unsafe(refs, refname, resolve_flags, oid, flags, failure_errno)
    +
      ## refs.c ##
     @@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
      					   type, failure_errno);
      }
      
    --static const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
    -+const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
    - 					       const char *refname,
    - 					       int resolve_flags,
    - 					       struct object_id *oid,
    -
    - ## refs.h ##
    -@@ refs.h: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
    +-const char *refs_werrres_ref_unsafe(struct ref_store *refs,
    ++const char *refs_resolve_ref_unsafe(struct ref_store *refs,
    + 				    const char *refname,
      				    int resolve_flags,
      				    struct object_id *oid,
    - 				    int *flags);
    -+/**
    -+ * refs_resolve_ref_unsafe_with_errno() is like
    -+ * refs_resolve_ref_unsafe(), but provide access to errno code that
    -+ * lead to a failure. We guarantee that errno is set to a meaningful
    -+ * value on non-zero return.
    -+ */
    -+const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
    -+					       const char *refname,
    -+					       int resolve_flags,
    -+					       struct object_id *oid,
    -+					       int *flags, int *failure_errno);
    - const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
    - 			       struct object_id *oid, int *flags);
    +@@ refs.c: const char *refs_werrres_ref_unsafe(struct ref_store *refs,
    + 	return NULL;
    + }
      
    -
    - ## refs/files-backend.c ##
    -@@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
    +-const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
    +-				    int resolve_flags, struct object_id *oid,
    +-				    int *flags)
    +-{
    +-	int failure_errno = 0;
    +-	const char *refn;
    +-	refn = refs_werrres_ref_unsafe(refs, refname, resolve_flags,
    +-				       oid, flags, &failure_errno);
    +-	if (!refn)
    +-		errno = failure_errno;
    +-	return refn;
    +-}
    +-
    + /* backend functions */
    + int refs_init_db(struct strbuf *err)
      {
    - 	struct strbuf ref_file = STRBUF_INIT;
    - 	struct ref_lock *lock;
    -+	int resolve_errno = 0;
    +
    + ## refs.h ##
    +@@ refs.h: struct string_list;
    + struct string_list_item;
    + struct worktree;
      
    - 	files_assert_main_repository(refs, "lock_ref_oid_basic");
    - 	assert(err);
    -@@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
    - 	CALLOC_ARRAY(lock, 1);
    +-/*
    +- * Callers should not inspect "errno" on failure, but rather pass in a
    +- * "failure_errno" parameter, on failure the "errno" will indicate the
    +- * type of failure encountered, but not necessarily one that came from
    +- * a syscall. We might have faked it up.
    +- */
    +-const char *refs_werrres_ref_unsafe(struct ref_store *refs,
    +-				    const char *refname,
    +-				    int resolve_flags,
    +-				    struct object_id *oid,
    +-				    int *flags, int *failure_errno);
    +-
    + /*
    +  * Resolve a reference, recursively following symbolic refererences.
    +  *
    +@@ refs.h: const char *refs_werrres_ref_unsafe(struct ref_store *refs,
    +  * resolved. The function returns NULL for such ref names.
    +  * Caps and underscores refers to the special refs, such as HEAD,
    +  * FETCH_HEAD and friends, that all live outside of the refs/ directory.
    ++ *
    ++ * Callers should not inspect "errno" on failure, but rather pass in a
    ++ * "failure_errno" parameter, on failure the "errno" will indicate the
    ++ * type of failure encountered, but not necessarily one that came from
    ++ * a syscall. We might have faked it up.
    +  */
    + #define RESOLVE_REF_READING 0x01
    + #define RESOLVE_REF_NO_RECURSE 0x02
    + #define RESOLVE_REF_ALLOW_BAD_NAME 0x04
      
    - 	files_ref_path(refs, &ref_file, refname);
    --	if (!refs_resolve_ref_unsafe(&refs->base, refname,
    --				     RESOLVE_REF_NO_RECURSE,
    --				     &lock->old_oid, type)) {
    -+	if (!refs_resolve_ref_unsafe_with_errno(&refs->base, refname,
    -+						RESOLVE_REF_NO_RECURSE,
    -+						&lock->old_oid, type,
    -+						&resolve_errno)) {
    - 		if (!refs_verify_refname_available(&refs->base, refname,
    - 						   NULL, NULL, err))
    - 			strbuf_addf(err, "unable to resolve reference '%s': %s",
    --				    refname, strerror(errno));
    -+				    refname, strerror(resolve_errno));
    ++#define refs_werrres_ref_unsafe(refs, refname, resolve_flags, oid, flags, failure_errno) \
    ++	refs_resolve_ref_unsafe(refs, refname, resolve_flags, oid, flags, failure_errno)
    + const char *refs_resolve_ref_unsafe(struct ref_store *refs,
    + 				    const char *refname,
    + 				    int resolve_flags,
    + 				    struct object_id *oid,
    +-				    int *flags);
    ++				    int *flags, int *failure_errno);
    ++
    + const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
    + 			       struct object_id *oid, int *flags);
      
    - 		goto error_return;
    - 	}
 -:  ----------- > 20:  54b18e3a719 refs API: post-migration API renaming [2/2]
-- 
2.33.1.1346.g48288c3c089

