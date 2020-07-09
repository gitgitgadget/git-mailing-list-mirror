Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF09C433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 21:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DFBA20672
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 21:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naQQU6o2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgGIVLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 17:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgGIVLv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 17:11:51 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0934DC08C5CE
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 14:11:51 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so3497064wme.5
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 14:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AgQB6i90CZUj9SxvLJRYW/MEVJVdgZ3HGO2F4wcWCts=;
        b=naQQU6o2IszYgMbQXvSa2OB3xhQex9MEnGHS4sAXD5ppKawxs2XS4vxmhMUbz6iRHC
         MdEevotWDDHT5nKutGLlMMEmyIAcbwSHMLbc9bR7S2nF8SkeckDigsJYgBaDvfmS6S1e
         7igXqdFIRj3CVEW+LmbCxwpcsrAX64AyhpB76j8Ahvvic+jquo/8gabdcZ1vF5xLqX67
         ioLgD99FkMfHxPtx8HWpfvH2KGnQb3y2abZMV5eiWnbZlSXjPbk/TwA7KBLgnUUH3l+C
         LNTWeKWJ8E/nxEVnNm1FyT3rx5Jq/ExH9bhHSTgX0D/32F+7hxUo0lX7aQhgawBPvRI2
         U6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AgQB6i90CZUj9SxvLJRYW/MEVJVdgZ3HGO2F4wcWCts=;
        b=BYtd1xCh9uP75A+hKiu3Kide3JuO90zAwnf0mNRzstMyO2JANRpMSHEWwTl2JINpiy
         yTHv6Ro6yRLhqeeo2YonmpEseJRTg8GR9VmxWpqSVu+KBR+ZJQiot5Gbdw5yqV6JKseT
         o6Z2WRbb0JtvjdWF0scqEDz9yT/5+mSYH8oFgX6az+s4iM9vfQ43nNW+W2py2luMYa8F
         kK1ZGDo209/n9+EVz0uZl+WQCkqxQKJCZNVRVPyqngDlFu3LPbPLRbUcAOV5sI/V4jao
         PV+BqmTuy41cNfxRAYzasvgx7EKl3KE4hqymiOP8KY8rPEO8lMBWQ7O8aUWU3hv8vrU5
         +9Ow==
X-Gm-Message-State: AOAM531KJolyfaZjIYBIWU3yHgjFTWdddaa25WzX5lZ+mpovYy7AsOsw
        6Fclrp5L7rdcWwGx0s2uOBinLbAY
X-Google-Smtp-Source: ABdhPJyXTfxvwqiVN9PdmVwjTHtzRDrCyI88HTvCGQfE7YgcVoN3Jf3J47RI8KVg8gwxKw/a9HD+HA==
X-Received: by 2002:a1c:48d7:: with SMTP id v206mr175392wma.145.1594329109346;
        Thu, 09 Jul 2020 14:11:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v18sm7702905wrv.49.2020.07.09.14.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 14:11:48 -0700 (PDT)
Message-Id: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
In-Reply-To: <pull.673.git.1594056572.gitgitgadget@gmail.com>
References: <pull.673.git.1594056572.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Jul 2020 21:11:45 +0000
Subject: [PATCH v2 0/3] Remove special casing for PSEUDOREF updates
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This gets rid of the special casing code for pseudorefs in refs.c

This is in preparation for reftable.

v2

 * remove special casing of non-HEAD pseudorefs; update t1400 and t1405
   accordingly
 * open question: should git-update-ref.txt be updated, when it talks about
   logAllRefUpdates?

Han-Wen Nienhuys (3):
  t1400: use git rev-parse for testing PSEUDOREF existence
  Modify pseudo refs through ref backend storage
  Make HEAD a PSEUDOREF rather than PER_WORKTREE.

 refs.c                    | 127 +++-----------------------------------
 t/t1400-update-ref.sh     |  30 ++++-----
 t/t1405-main-ref-store.sh |   5 +-
 3 files changed, 29 insertions(+), 133 deletions(-)


base-commit: 4a0fcf9f760c9774be77f51e1e88a7499b53d2e2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-673%2Fhanwen%2Fpseudoref-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-673/hanwen/pseudoref-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/673

Range-diff vs v1:

 -:  ---------- > 1:  9c3dc4b2cb t1400: use git rev-parse for testing PSEUDOREF existence
 1:  6821f57bdf ! 2:  871b411517 Modify pseudo refs through ref backend storage
     @@ Commit message
          well. Tooling that works directly on files under .git should be
          updated to use git commands to read refs instead.
      
     -    This needs the following fixes
     +    The following behaviors change:
      
     -    * Only write log for HEAD pseudo ref. Fixes t1400
     -      'core.logAllRefUpdates=always creates no reflog for ORIG_HEAD'
     +    * Updates to pseudorefs (eg. ORIG_HEAD) with
     +      core.logAllRefUpdates=always will create reflogs for the pseudoref.
      
     -    * t1400: change hard coded error messages to check for.
     -
     -    * don't deref non-HEAD pseudoref symrefs. This fixes t1405. Without
     -      this, a deleting a FOO symref pointing to refs/heads/master will remove
     -      master too.
     +    * non-HEAD pseudoref symrefs are also dereferenced on deletion. Update
     +      t1405 accordingly.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     @@ refs.c: int refs_update_ref(struct ref_store *refs, const char *msg,
       	if (ret) {
       		const char *str = _("update_ref failed for ref '%s': %s");
      
     - ## refs/files-backend.c ##
     -@@ refs/files-backend.c: static int files_delete_refs(struct ref_store *ref_store, const char *msg,
     - 
     - 	for (i = 0; i < refnames->nr; i++) {
     - 		const char *refname = refnames->items[i].string;
     --
     - 		if (refs_delete_ref(&refs->base, msg, refname, NULL, flags))
     - 			result |= error(_("could not remove reference %s"), refname);
     - 	}
     -@@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *refs,
     - 	update->backend_data = lock;
     + ## t/t1400-update-ref.sh ##
     +@@ t/t1400-update-ref.sh: test_expect_success 'core.logAllRefUpdates=always creates reflog by default' '
     + 	git reflog exists $outside
     + '
       
     - 	if (update->type & REF_ISSYMREF) {
     --		if (update->flags & REF_NO_DEREF) {
     -+		if (update->flags & REF_NO_DEREF ||
     -+		    (ref_type(update->refname) == REF_TYPE_PSEUDOREF &&
     -+		     strcmp(update->refname, "HEAD"))) {
     - 			/*
     - 			 * We won't be reading the referent as part of
     - 			 * the transaction, so we have to read it here
     -@@ refs/files-backend.c: static int files_transaction_finish(struct ref_store *ref_store,
     - 		struct ref_update *update = transaction->updates[i];
     - 		struct ref_lock *lock = update->backend_data;
     +-test_expect_success 'core.logAllRefUpdates=always creates no reflog for ORIG_HEAD' '
     ++test_expect_success 'core.logAllRefUpdates=always creates reflog for ORIG_HEAD' '
     + 	test_config core.logAllRefUpdates always &&
     + 	git update-ref ORIG_HEAD $A &&
     +-	test_must_fail git reflog exists ORIG_HEAD
     ++	git reflog exists ORIG_HEAD
     + '
       
     --		if (update->flags & REF_NEEDS_COMMIT ||
     --		    update->flags & REF_LOG_ONLY) {
     -+		if ((ref_type(lock->ref_name) != REF_TYPE_PSEUDOREF ||
     -+		     !strcmp(lock->ref_name, "HEAD")) &&
     -+		    (update->flags & REF_NEEDS_COMMIT ||
     -+		     update->flags & REF_LOG_ONLY)) {
     - 			if (files_log_ref_write(refs,
     - 						lock->ref_name,
     - 						&lock->old_oid,
     -
     - ## t/t1400-update-ref.sh ##
     + test_expect_success '--no-create-reflog overrides core.logAllRefUpdates=always' '
      @@ t/t1400-update-ref.sh: test_expect_success 'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER
       test_expect_success 'given old value for missing pseudoref, do not create' '
       	test_must_fail git update-ref PSEUDOREF $A $B 2>err &&
     - 	test_path_is_missing .git/PSEUDOREF &&
     + 	test_must_fail git rev-parse PSEUDOREF &&
      -	test_i18ngrep "could not read ref" err
      +	test_i18ngrep "unable to resolve reference" err
       '
     @@ t/t1400-update-ref.sh: test_expect_success 'git cat-file blob master@{2005-05-26
      @@ t/t1400-update-ref.sh: test_expect_success 'overwrite pseudoref with correct old value' '
       test_expect_success 'do not overwrite pseudoref with wrong old value' '
       	test_must_fail git update-ref PSEUDOREF $D $E 2>err &&
     - 	test $C = $(cat .git/PSEUDOREF) &&
     + 	test $C = $(git rev-parse PSEUDOREF) &&
      -	test_i18ngrep "unexpected object ID" err
      +	test_i18ngrep "cannot lock ref.*expected" err
       '
     @@ t/t1400-update-ref.sh: test_expect_success 'overwrite pseudoref with correct old
      @@ t/t1400-update-ref.sh: test_expect_success 'do not delete pseudoref with wrong old value' '
       	git update-ref PSEUDOREF $A &&
       	test_must_fail git update-ref -d PSEUDOREF $B 2>err &&
     - 	test $A = $(cat .git/PSEUDOREF) &&
     + 	test $A = $(git rev-parse PSEUDOREF) &&
      -	test_i18ngrep "unexpected object ID" err
      +	test_i18ngrep "cannot lock ref.*expected" err
       '
       
       test_expect_success 'delete pseudoref with correct old value' '
     +
     + ## t/t1405-main-ref-store.sh ##
     +@@ t/t1405-main-ref-store.sh: test_expect_success 'create_symref(FOO, refs/heads/master)' '
     + test_expect_success 'delete_refs(FOO, refs/tags/new-tag)' '
     + 	git rev-parse FOO -- &&
     + 	git rev-parse refs/tags/new-tag -- &&
     ++	m=$(git rev-parse master) &&
     + 	$RUN delete-refs 0 nothing FOO refs/tags/new-tag &&
     + 	test_must_fail git rev-parse FOO -- &&
     +-	test_must_fail git rev-parse refs/tags/new-tag --
     ++	test_must_fail git rev-parse refs/tags/new-tag --&&
     ++	test_must_fail git rev-parse master -- &&
     ++	git update-ref refs/heads/master $m
     + '
     + 
     + test_expect_success 'rename_refs(master, new-master)' '
 2:  470821dc6d = 3:  1c2b9d5f17 Make HEAD a PSEUDOREF rather than PER_WORKTREE.

-- 
gitgitgadget
