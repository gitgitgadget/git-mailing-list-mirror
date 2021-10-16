Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEBAC433EF
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D3D960E96
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240134AbhJPJm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244009AbhJPJlu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 05:41:50 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CA0C061769
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:32 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id g39so150436wmp.3
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zLjvJLeqNFkKgkhfVTyocthOIi3bhJW8+IUS8s5wRJM=;
        b=cnpksMHO7fHsO6ZHQSyiib9/B98EusJcY04mnuO+dwZ6QT9LeCH5zQf1k7bvCZbA9Y
         YvI4d7S4H0184MH/e4EIfBpMGLB92NqADwevnSPr1IJkgAlqsyXY226JWUaOi7+qK+Jj
         NkVS5w/wq8GCbENV+M5AE78bSszYRaqHKctIE0nnbjo3b6Ot3TV6ceSGvTyk4k50wY2V
         MJjEt7/2utFMUeGAme5gSRQsw3SUBi0zD6Wq6GGFW16lMvJqm8JFOcWT4oghMXtBuyXg
         6YlOo9pTMtP27QYkP3wXwp/nGomW9Qf4ARB+ci0urmfRqfMks0Zd0qjKJXZ1AiShMZKQ
         zJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zLjvJLeqNFkKgkhfVTyocthOIi3bhJW8+IUS8s5wRJM=;
        b=W2/fSFd1/Wq3DFKFU5Z6+nEr2CfL6/oUWXgQYYwhlMC47TWYESRhl1zRiKIzNn4KBI
         pmql1Wt3y200EgF4HR1Mv5ogvvCtyRtc2bvxZznbgfakj4SrtMPYyryiA58DnqMpPaYp
         w2JrPigdlEMqm5iuqb7xrG0T6VXb0n1+ARpypC1E79FqoMojS6ZrrfUY38CGtFN5MgmD
         /yrF5iVNcr4+tpAc+7+iR7tCSXho6+7ZYYKivg+Sc9BSd+MqV1Q+U57p94c/NkphreLX
         I9dIqaVOSjppuEEOH7TfVT0SKDcHrvKP2U/cYXkp3xL1LoU0kfHU4KVHJvM4fGqWzU/H
         fxHA==
X-Gm-Message-State: AOAM530Qkvny1c+V018g5Cx5ZxHZX6zUQkzC2XFoSHjHOhgxjZa0jkay
        jFVMdNeJIvdlxvrT5XD0ctsT4KewQ2e5CA==
X-Google-Smtp-Source: ABdhPJwlHzINc4HHf4g3d5f0ZtK38tbiDkNCxB14nN04VJf6xb/xjn9/IPcvwdfT9k67RR8xVtZneQ==
X-Received: by 2002:a1c:a914:: with SMTP id s20mr17982376wme.6.1634377170285;
        Sat, 16 Oct 2021 02:39:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k22sm6993492wrd.59.2021.10.16.02.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:39:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/21] refs: stop having the API set "errno"
Date:   Sat, 16 Oct 2021 11:39:06 +0200
Message-Id: <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See [1] for the v1 summary. There was a regression there with "git
reflog"'s "--updateref" option, which had no meaningful tests in the
test suite (only one test in "t1503-rev-parse-verify.sh"). Test for
it, and address Eric's comment about "t3200-branch.sh" by
re-structuring that test away from a for-loop.

1. https://lore.kernel.org/git/cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com/

Han-Wen Nienhuys (3):
  branch tests: test for errno propagating on failing read
  refs API: make refs_read_raw_ref() not set errno
  refs API: make parse_loose_ref_contents() not set errno

Ævar Arnfjörð Bjarmason (18):
  refs API: add a version of refs_resolve_ref_unsafe() with "errno"
  refs API: make refs_rename_ref_available() static
  reflog tests: add --updateref tests
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

 refs.c                      | 124 +++++++++++++++--------------
 refs.h                      |  10 ++-
 refs/files-backend.c        | 153 ++++++++++++++++++++++++------------
 refs/packed-backend.c       |   7 +-
 refs/refs-internal.h        |  26 ++----
 sequencer.c                 |  10 ++-
 t/helper/test-ref-store.c   |   3 +-
 t/t1417-reflog-updateref.sh |  65 +++++++++++++++
 t/t3200-branch.sh           |  22 ++++++
 worktree.c                  |  17 ++--
 10 files changed, 294 insertions(+), 143 deletions(-)
 create mode 100755 t/t1417-reflog-updateref.sh

Range-diff against v1:
 1:  bea88e382c0 !  1:  1863c597c98 branch tests: test for errno propagating on failing read
    @@ t/t3200-branch.sh: test_expect_success SYMLINKS 'git branch -m u v should fail w
      
     +test_expect_success SYMLINKS 'git branch -m with symlinked .git/refs' '
     +	test_when_finished "rm -rf subdir" &&
    -+	git init subdir &&
    ++	git init --bare subdir &&
     +
    -+	(
    -+		cd subdir &&
    -+		for d in refs objects packed-refs
    -+		do
    -+			rm -rf .git/$d &&
    -+			ln -s ../../.git/$d .git/$d
    -+		done
    -+	) &&
    -+	git --git-dir subdir/.git/ branch rename-src &&
    ++	rm -rfv subdir/refs subdir/objects subdir/packed-refs &&
    ++	ln -s ../.git/refs subdir/refs &&
    ++	ln -s ../.git/objects subdir/objects &&
    ++	ln -s ../.git/packed-refs subdir/packed-refs &&
    ++
    ++	git -C subdir rev-parse --absolute-git-dir >subdir.dir &&
    ++	git rev-parse --absolute-git-dir >our.dir &&
    ++	! test_cmp subdir.dir our.dir &&
    ++
    ++	git -C subdir log &&
    ++	git -C subdir branch rename-src &&
     +	git rev-parse rename-src >expect &&
    -+	git --git-dir subdir/.git/ branch -m rename-src rename-dest &&
    ++	git -C subdir branch -m rename-src rename-dest &&
     +	git rev-parse rename-dest >actual &&
     +	test_cmp expect actual &&
     +	git branch -D rename-dest
 2:  46641111885 =  2:  f6d784b4979 refs API: add a version of refs_resolve_ref_unsafe() with "errno"
 3:  a1a80715ffe =  3:  8932b109087 refs API: make refs_read_raw_ref() not set errno
 4:  758c761abcf !  4:  988bf62b3f2 refs API: make parse_loose_ref_contents() not set errno
    @@ refs/refs-internal.h: struct ref_store {
      
      /*
       * Fill in the generic part of refs and add it to our collection of
    -
    - ## t/t3200-branch.sh ##
    -@@ t/t3200-branch.sh: test_expect_success SYMLINKS 'git branch -m with symlinked .git/refs' '
    - 	) &&
    - 	git --git-dir subdir/.git/ branch rename-src &&
    - 	git rev-parse rename-src >expect &&
    -+	# Tests a BUG() assertion in files_read_raw_ref()
    - 	git --git-dir subdir/.git/ branch -m rename-src rename-dest &&
    - 	git rev-parse rename-dest >actual &&
    - 	test_cmp expect actual &&
 5:  cdf17fa34a4 =  5:  8073f93a904 refs API: make refs_rename_ref_available() static
 -:  ----------- >  6:  d3242f5f687 reflog tests: add --updateref tests
 6:  3162bf28505 !  7:  7db3b446632 refs/files: remove "name exist?" check in lock_ref_oid_basic()
    @@ Commit message
         already, or something we're about to discover by trying to lock the
         ref with raceproof_create_file().
     
    +    The one exception is the caller in files_reflog_expire(), who passes
    +    us a "type" to find out if the reference is a symref or not. We can
    +    move the that logic over to that caller, which can now defer its
    +    discovery of whether or not the ref is a symref until it's needed. In
    +    the preceding commit an exhaustive regression test was added for that
    +    case in a new test in "t1417-reflog-updateref.sh".
    +
         The improved diagnostics here were added in
         5b2d8d6f218 (lock_ref_sha1_basic(): improve diagnostics for ref D/F
         conflicts, 2015-05-11), and then much of the surrounding code went
    @@ Commit message
           reflog we're expiring exists.
     
           See ae35e16cd43 (reflog expire: don't lock reflogs using previously
    -      seen OID, 2021-08-23) for the current state of that code.
    +      seen OID, 2021-08-23) for the current state of that code, and
    +      5e6f003ca8a (reflog_expire(): ignore --updateref for symbolic
    +      references, 2015-03-03) for the code we'd break if we only did a
    +      "update = !!ref" here, which is covered by the aforementioned
    +      regression test in "t1417-reflog-updateref.sh".
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## refs/files-backend.c ##
    +@@ refs/files-backend.c: static int create_reflock(const char *path, void *cb)
    +  * Locks a ref returning the lock on success and NULL on failure.
    +  */
    + static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
    +-					   const char *refname, int *type,
    ++					   const char *refname,
    + 					   struct strbuf *err)
    + {
    + 	struct strbuf ref_file = STRBUF_INIT;
     @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
      	CALLOC_ARRAY(lock, 1);
      
    @@ refs/files-backend.c: static int commit_ref_update(struct files_ref_store *refs,
       */
      static int refs_rename_ref_available(struct ref_store *refs,
      			      const char *old_refname,
    +@@ refs/files-backend.c: static int files_copy_or_rename_ref(struct ref_store *ref_store,
    + 
    + 	logmoved = log;
    + 
    +-	lock = lock_ref_oid_basic(refs, newrefname, NULL, &err);
    ++	lock = lock_ref_oid_basic(refs, newrefname, &err);
    + 	if (!lock) {
    + 		if (copy)
    + 			error("unable to copy '%s' to '%s': %s", oldrefname, newrefname, err.buf);
    +@@ refs/files-backend.c: static int files_copy_or_rename_ref(struct ref_store *ref_store,
    + 	goto out;
    + 
    +  rollback:
    +-	lock = lock_ref_oid_basic(refs, oldrefname, NULL, &err);
    ++	lock = lock_ref_oid_basic(refs, oldrefname, &err);
    + 	if (!lock) {
    + 		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
    + 		strbuf_release(&err);
    +@@ refs/files-backend.c: static int files_create_symref(struct ref_store *ref_store,
    + 	struct ref_lock *lock;
    + 	int ret;
    + 
    +-	lock = lock_ref_oid_basic(refs, refname, NULL, &err);
    ++	lock = lock_ref_oid_basic(refs, refname, &err);
    + 	if (!lock) {
    + 		error("%s", err.buf);
    + 		strbuf_release(&err);
    +@@ refs/files-backend.c: static int files_reflog_expire(struct ref_store *ref_store,
    + 	struct strbuf log_file_sb = STRBUF_INIT;
    + 	char *log_file;
    + 	int status = 0;
    +-	int type;
    + 	struct strbuf err = STRBUF_INIT;
    + 	const struct object_id *oid;
    + 
    +@@ refs/files-backend.c: static int files_reflog_expire(struct ref_store *ref_store,
    + 	 * reference itself, plus we might need to update the
    + 	 * reference if --updateref was specified:
    + 	 */
    +-	lock = lock_ref_oid_basic(refs, refname, &type, &err);
    ++	lock = lock_ref_oid_basic(refs, refname, &err);
    + 	if (!lock) {
    + 		error("cannot lock ref '%s': %s", refname, err.buf);
    + 		strbuf_release(&err);
    +@@ refs/files-backend.c: static int files_reflog_expire(struct ref_store *ref_store,
    + 		 * a reference if there are no remaining reflog
    + 		 * entries.
    + 		 */
    +-		int update = (flags & EXPIRE_REFLOGS_UPDATE_REF) &&
    +-			!(type & REF_ISSYMREF) &&
    +-			!is_null_oid(&cb.last_kept_oid);
    ++		int update = 0;
    ++
    ++		if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
    ++		    !is_null_oid(&cb.last_kept_oid)) {
    ++			int ignore_errno;
    ++			int type;
    ++			const char *ref;
    ++
    ++			ref = refs_werrres_ref_unsafe(&refs->base, refname,
    ++						      RESOLVE_REF_NO_RECURSE,
    ++						      NULL, &type,
    ++						      &ignore_errno);
    ++			update = !!(ref && !(type & REF_ISSYMREF));
    ++		}
    + 
    + 		if (close_lock_file_gently(&reflog_lock)) {
    + 			status |= error("couldn't write %s: %s", log_file,
 7:  288237b1900 =  8:  b2532614430 refs API: remove refs_read_ref_full() wrapper
 8:  acb484ea547 =  9:  65beb51ae4e refs API: make resolve_gitlink_ref() not set errno
 9:  4be84c9bf53 = 10:  c99c59dcc57 refs API: make loose_fill_ref_dir() not set errno
10:  8753210f9cc = 11:  22883846a6a refs API: make files_copy_or_rename_ref() et al not set errno
11:  9fe85926140 = 12:  b90e65abd7d refs API: ignore errno in worktree.c's add_head_info()
12:  8d87db98041 = 13:  38f5f54938f refs API: ignore errno in worktree.c's find_shared_symref()
13:  954633bcbb2 = 14:  1289d78e4f3 refs tests: ignore ignore errno in test-ref-store helper
14:  fbbc08d3ebd = 15:  152a831b8be refs API: make refs_resolve_refdup() not set errno
15:  4b2a4dbe7d5 = 16:  c4e87181121 refs API: make refs_ref_exists() not set errno
16:  888b1884c29 = 17:  cae56498b43 refs API: make resolve_ref_unsafe() not set errno
17:  e2885f13c9b = 18:  146b030a142 refs API: make expand_ref() & repo_dwim_log() not set errno
18:  df50373a272 = 19:  3d630872aff refs API: don't expose "errno" in run_transaction_hook()
19:  4c80b05bf1d = 20:  56f855d32b7 refs API: post-migration API renaming [1/2]
20:  54b18e3a719 ! 21:  0135fb5949f refs API: post-migration API renaming [2/2]
    @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
      						     referent.buf, 0,
      						     &lock->old_oid, NULL,
      						     &ignore_errno)) {
    +@@ refs/files-backend.c: static int files_reflog_expire(struct ref_store *ref_store,
    + 			int type;
    + 			const char *ref;
    + 
    +-			ref = refs_werrres_ref_unsafe(&refs->base, refname,
    ++			ref = refs_resolve_ref_unsafe(&refs->base, refname,
    + 						      RESOLVE_REF_NO_RECURSE,
    + 						      NULL, &type,
    + 						      &ignore_errno);
     
      ## sequencer.c ##
     @@ sequencer.c: void print_commit_summary(struct repository *r,
-- 
2.33.1.1338.g20da966911a

