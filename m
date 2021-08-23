Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2BDC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EFFD61206
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbhHWLhB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbhHWLhB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:37:01 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF890C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o39-20020a05600c512700b002e74638b567so2882947wms.2
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n9lx9eU80qeuAIZ+BGmm6Q99N+CaItJKu7Wdi9vJi6k=;
        b=L5+twoR9OX4jcXXaDWcQVJKs1iyBHPVi9y5LnmamaTvnI2OijlajwsywmJtjWx/PDt
         mqONzMXEfLfPwasNANNDLH5UzitheMcjPtB2NfwU629sKS/H6FHmVu4LYW/sSdvemO3J
         qeEKvNKCuMDaVHDPNjGr+HbCcqX8h1AxuNHXm12gBhzkMZi0to6yisFsbQUHETdwrOSn
         5uh3+u+P35Du5BsU5J/3go6DgIH9FcfKqNt3mID6pow6fMtInnL69m8J4k0bVUaaCwnu
         Q+KFnI3F+Khr8AIgMMvqJDEKIEbYzQC+E2DYpUq44dZqi+Mw/w9r37ZOSkWLjeZsEAFF
         UNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n9lx9eU80qeuAIZ+BGmm6Q99N+CaItJKu7Wdi9vJi6k=;
        b=PYTFVywhdqV3Dcxxb3amP1qoNwvXsfPbQR72UDoGltjvsmwZtomf9QMzGbhgtvZCQs
         MgAbFd5Mo50EwsK15wE8zlqcZ/B6LI3suarkCzW1wi6A+8IBNlHU5J93sSmY5EaHGRkg
         DeB7HeGYrQo+FmznspRrHEnLZpPxrGwGJxb7PeYWMLjBCCo56nIhNGtjKYJYVigRZ/aB
         txwCRMWB/6RY0uHveLm+A2bOxnpJSUaf9vVNO/oOQfJirUx/96GJ/Iqp7PTohM2YU1Cm
         fOZtx829loX2+CEeAjeuzBtO++iwopjm5aKk0+bbp9+2NYYPe/iWigeOlQch77nqfaL2
         yk+Q==
X-Gm-Message-State: AOAM530sKIgEIDI/4yknb2RvPNfsoUrd1A7+MwRuYHvhBiI6olzJbLe3
        U3eJg+vtCS8pBSJw0BW7XW5NNNHfMMWQAOtr
X-Google-Smtp-Source: ABdhPJyUSiLRzrnCwpU0B58UDT0+eiEFJHYfLie6QfCduL6TUY9UBg6hbMoTbF85eQcUSNyOa41CTQ==
X-Received: by 2002:a1c:ed13:: with SMTP id l19mr16052058wmh.48.1629718576994;
        Mon, 23 Aug 2021 04:36:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g35sm20555313wmp.9.2021.08.23.04.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:36:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 00/13] fix "git reflog expire" race & get rid of EISDIR in refs API
Date:   Mon, 23 Aug 2021 13:36:01 +0200
Message-Id: <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.g438caf9576d
In-Reply-To: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of
https://lore.kernel.org/git/cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com

This incorporates Jeff King's
https://lore.kernel.org/git/YQyGe9qOPRA0nf5v@coredump.intra.peff.net;
so this replaces ab/refs-files-cleanup and
jk/refs-files-cleanup-cleanup.

There's also a trivial commit message grammar fix here that Junio
already squashed into his version of v4. The rest of the changes are
all due to the rebase on Jeff's commit to get rid of the "flags"
parameter.

But most importantly there's a new "refs API: remove OID argument to
reflog_expire()" patch here, to change the function signature of
reflog_expire() to not pass the OID. Leaving it in place caused a
segfault in the reftable topic, now it just won't compile in
combination with this. I'm submitting update(s) to those other topics
on top to make these all work nicely together.

Jeff King (1):
  refs: drop unused "flags" parameter to lock_ref_oid_basic()

Ævar Arnfjörð Bjarmason (12):
  refs/packet: add missing BUG() invocations to reflog callbacks
  refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
  refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
  refs/files: remove unused "skip" in lock_raw_ref() too
  refs/debug: re-indent argument list for "prepare"
  refs: make repo_dwim_log() accept a NULL oid
  refs/files: add a comment about refs_reflog_exists() call
  reflog expire: don't lock reflogs using previously seen OID
  refs API: remove OID argument to reflog_expire()
  refs/files: remove unused "oid" in lock_ref_oid_basic()
  refs/files: remove unused "errno == EISDIR" code
  refs/files: remove unused "errno != ENOTDIR" condition

 builtin/reflog.c      |  13 ++---
 reflog-walk.c         |   3 +-
 refs.c                |  13 +++--
 refs.h                |   9 ++-
 refs/debug.c          |   8 +--
 refs/files-backend.c  | 132 +++++++++++-------------------------------
 refs/packed-backend.c |   7 ++-
 refs/refs-internal.h  |   2 +-
 8 files changed, 64 insertions(+), 123 deletions(-)

Range-diff against v4:
 1:  92fc3af0727 =  1:  61cf49b9582 refs/packet: add missing BUG() invocations to reflog callbacks
 2:  67cd2331fb4 !  2:  a20548c1a4d refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
    @@ Metadata
      ## Commit message ##
         refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
     
    -    The lock_ref_oid_basic() function has gradually been by most callers
    -    no longer performing a low-level "acquire lock, update and release",
    -    and instead using the ref transaction API. So there are only 4
    -    remaining callers of lock_ref_oid_basic().
    +    The lock_ref_oid_basic() function has gradually been replaced by
    +    most callers no longer performing a low-level "acquire lock,
    +    update and release", and instead using the ref transaction API.
    +    So there are only 4 remaining callers of lock_ref_oid_basic().
     
         None of those callers pass REF_DELETING anymore, the last caller went
         away in 92b1551b1d (refs: resolve symbolic refs first,
 -:  ----------- >  3:  d3216a6b1d8 refs: drop unused "flags" parameter to lock_ref_oid_basic()
 3:  7d76514b559 !  4:  3e538eb3008 refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
    @@ refs/files-backend.c: static int create_reflock(const char *path, void *cb)
      					   const struct object_id *old_oid,
     -					   const struct string_list *extras,
     -					   const struct string_list *skip,
    - 					   unsigned int flags, int *type,
    - 					   struct strbuf *err)
    + 					   int *type, struct strbuf *err)
      {
    + 	struct strbuf ref_file = STRBUF_INIT;
     @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
      			last_errno = errno;
      			if (!refs_verify_refname_available(
    @@ refs/files-backend.c: static int files_copy_or_rename_ref(struct ref_store *ref_
      
      	logmoved = log;
      
    +-
     -	lock = lock_ref_oid_basic(refs, newrefname, NULL, NULL, NULL,
    --				  REF_NO_DEREF, NULL, &err);
    -+	lock = lock_ref_oid_basic(refs, newrefname, NULL, REF_NO_DEREF, NULL,
    -+				  &err);
    +-				  NULL, &err);
    ++	lock = lock_ref_oid_basic(refs, newrefname, NULL, NULL, &err);
      	if (!lock) {
      		if (copy)
      			error("unable to copy '%s' to '%s': %s", oldrefname, newrefname, err.buf);
    @@ refs/files-backend.c: static int files_copy_or_rename_ref(struct ref_store *ref_
      
       rollback:
     -	lock = lock_ref_oid_basic(refs, oldrefname, NULL, NULL, NULL,
    -+	lock = lock_ref_oid_basic(refs, oldrefname, NULL,
    - 				  REF_NO_DEREF, NULL, &err);
    +-				  NULL, &err);
    ++	lock = lock_ref_oid_basic(refs, oldrefname, NULL, NULL, &err);
      	if (!lock) {
      		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
    + 		strbuf_release(&err);
     @@ refs/files-backend.c: static int files_create_symref(struct ref_store *ref_store,
    + 	struct ref_lock *lock;
      	int ret;
      
    - 	lock = lock_ref_oid_basic(refs, refname, NULL,
    --				  NULL, NULL, REF_NO_DEREF, NULL,
    -+				  REF_NO_DEREF, NULL,
    - 				  &err);
    +-	lock = lock_ref_oid_basic(refs, refname, NULL,
    +-				  NULL, NULL, NULL,
    +-				  &err);
    ++	lock = lock_ref_oid_basic(refs, refname, NULL, NULL, &err);
      	if (!lock) {
      		error("%s", err.buf);
    + 		strbuf_release(&err);
     @@ refs/files-backend.c: static int files_reflog_expire(struct ref_store *ref_store,
    + 	 * reference itself, plus we might need to update the
      	 * reference if --updateref was specified:
      	 */
    - 	lock = lock_ref_oid_basic(refs, refname, oid,
    --				  NULL, NULL, REF_NO_DEREF,
    -+				  REF_NO_DEREF,
    - 				  &type, &err);
    +-	lock = lock_ref_oid_basic(refs, refname, oid,
    +-				  NULL, NULL, &type, &err);
    ++	lock = lock_ref_oid_basic(refs, refname, oid, &type, &err);
      	if (!lock) {
      		error("cannot lock ref '%s': %s", refname, err.buf);
    + 		strbuf_release(&err);
 4:  852f86e666f =  5:  b7335e79f8b refs/files: remove unused "skip" in lock_raw_ref() too
 5:  685b48328af =  6:  24449766060 refs/debug: re-indent argument list for "prepare"
 6:  b75e7673d70 =  7:  3b7daf03e5a refs: make repo_dwim_log() accept a NULL oid
 7:  7fe6c9bd921 =  8:  51abe459e70 refs/files: add a comment about refs_reflog_exists() call
 8:  c9c2da35997 !  9:  aba12606cea reflog expire: don't lock reflogs using previously seen OID
    @@ refs/files-backend.c: static int files_reflog_expire(struct ref_store *ref_store
      	 * reference itself, plus we might need to update the
      	 * reference if --updateref was specified:
      	 */
    --	lock = lock_ref_oid_basic(refs, refname, oid,
    -+	lock = lock_ref_oid_basic(refs, refname, NULL,
    - 				  REF_NO_DEREF,
    - 				  &type, &err);
    +-	lock = lock_ref_oid_basic(refs, refname, oid, &type, &err);
    ++	lock = lock_ref_oid_basic(refs, refname, NULL, &type, &err);
      	if (!lock) {
    -@@ refs/files-backend.c: static int files_reflog_expire(struct ref_store *ref_store,
    + 		error("cannot lock ref '%s': %s", refname, err.buf);
      		strbuf_release(&err);
      		return -1;
      	}
 -:  ----------- > 10:  5afa8f1be29 refs API: remove OID argument to reflog_expire()
 9:  b61c734cf5c ! 11:  7712e29abe6 refs/files: remove unused "oid" in lock_ref_oid_basic()
    @@ refs/files-backend.c: static struct ref_iterator *files_ref_iterator_begin(
      {
      	/*
     @@ refs/files-backend.c: static int create_reflock(const char *path, void *cb)
    +  * On failure errno is set to something meaningful.
       */
      static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
    - 					   const char *refname,
    +-					   const char *refname,
     -					   const struct object_id *old_oid,
    - 					   unsigned int flags, int *type,
    - 					   struct strbuf *err)
    +-					   int *type, struct strbuf *err)
    ++					   const char *refname, int *type,
    ++					   struct strbuf *err)
      {
      	struct strbuf ref_file = STRBUF_INIT;
      	struct ref_lock *lock;
    @@ refs/files-backend.c: static int files_copy_or_rename_ref(struct ref_store *ref_
      
      	logmoved = log;
      
    --	lock = lock_ref_oid_basic(refs, newrefname, NULL, REF_NO_DEREF, NULL,
    --				  &err);
    -+	lock = lock_ref_oid_basic(refs, newrefname, REF_NO_DEREF, NULL, &err);
    +-	lock = lock_ref_oid_basic(refs, newrefname, NULL, NULL, &err);
    ++	lock = lock_ref_oid_basic(refs, newrefname, NULL, &err);
      	if (!lock) {
      		if (copy)
      			error("unable to copy '%s' to '%s': %s", oldrefname, newrefname, err.buf);
    @@ refs/files-backend.c: static int files_copy_or_rename_ref(struct ref_store *ref_
      	goto out;
      
       rollback:
    --	lock = lock_ref_oid_basic(refs, oldrefname, NULL,
    --				  REF_NO_DEREF, NULL, &err);
    -+	lock = lock_ref_oid_basic(refs, oldrefname, REF_NO_DEREF, NULL, &err);
    +-	lock = lock_ref_oid_basic(refs, oldrefname, NULL, NULL, &err);
    ++	lock = lock_ref_oid_basic(refs, oldrefname, NULL, &err);
      	if (!lock) {
      		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
      		strbuf_release(&err);
    @@ refs/files-backend.c: static int files_create_symref(struct ref_store *ref_store
      	struct ref_lock *lock;
      	int ret;
      
    --	lock = lock_ref_oid_basic(refs, refname, NULL,
    --				  REF_NO_DEREF, NULL,
    --				  &err);
    -+	lock = lock_ref_oid_basic(refs, refname, REF_NO_DEREF, NULL, &err);
    +-	lock = lock_ref_oid_basic(refs, refname, NULL, NULL, &err);
    ++	lock = lock_ref_oid_basic(refs, refname, NULL, &err);
      	if (!lock) {
      		error("%s", err.buf);
      		strbuf_release(&err);
    @@ refs/files-backend.c: static int files_reflog_expire(struct ref_store *ref_store
      	 * reference itself, plus we might need to update the
      	 * reference if --updateref was specified:
      	 */
    --	lock = lock_ref_oid_basic(refs, refname, NULL,
    --				  REF_NO_DEREF,
    --				  &type, &err);
    -+	lock = lock_ref_oid_basic(refs, refname, REF_NO_DEREF, &type, &err);
    +-	lock = lock_ref_oid_basic(refs, refname, NULL, &type, &err);
    ++	lock = lock_ref_oid_basic(refs, refname, &type, &err);
      	if (!lock) {
      		error("cannot lock ref '%s': %s", refname, err.buf);
      		strbuf_release(&err);
10:  009abc99688 = 12:  f746939a27a refs/files: remove unused "errno == EISDIR" code
11:  acb131cc1c5 = 13:  2e30ee04edb refs/files: remove unused "errno != ENOTDIR" condition
-- 
2.33.0.662.g438caf9576d

