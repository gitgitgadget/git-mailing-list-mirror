Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182EFC00140
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 03:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239254AbiHSDV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 23:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiHSDVy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 23:21:54 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C278C7FB0
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 20:21:52 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bh13so2762618pgb.4
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 20:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=idNgP6FXe+ScWJoatDIN3d0O8bKVRkrO4xJSG66fNkY=;
        b=LyK1D8KffwbTbePeB3NcS+iz8IftQwhi3ubm9AAX6Q8QRffEuzxJJN4LK8DjdFI/s6
         o3xXroSeZI0VMuOSjg5mV7ATpQk8ZgLfVFeEwN5Oa4AeX3Yzdr2i4kh1xCG9kGAxrpem
         d9+g3+7cUdH+VMaqbuI8mHnoqUpMjdQ6keDmAg7InG6eY+/546j2vjFS/H0WopTlMqPJ
         89LRBfL+raF777MMnF5hYol5gS8pGKx3vpdbQw+1zljJdU2z1pS+Mk/t8EKAF2uukPzp
         hcpPhB2b14iW0Z76cLm6dzAWhPKJNkEpNmX/kPP3HGYZl+9F01gfjiRZhr74r7RjGTs4
         J0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=idNgP6FXe+ScWJoatDIN3d0O8bKVRkrO4xJSG66fNkY=;
        b=U7A84pIKmRxBAaAQVZKkGCOLeMCZ/1AMpVom7pdlxkHKAq4wvKpdtx+un4j57w0F/h
         J1jvHCCIACAYRUdxSQNorYOGZC45CPXmCiQru+Ag6DeDBdFgoit+WSzY80ZYg4baC1rw
         qaDODZrbsFAHQhCSwizySyVZFuRGWfV6aIrUxXW0sCKTRQR7jlIn0axBS5M0W+/0GPg4
         AdS0NY3G6tui8zRKZsUIj3jEqXoosA8m00S1FLWY1xnCo67+F0K8OnnyHLmLpsOalzRs
         gy/JuEB88FvQe5QNgWq08KTTnnB6yI/dRwLKK5IqIQHC78bnlZU78bt7SS5QQ0BA+UD1
         5JVA==
X-Gm-Message-State: ACgBeo0lBcAvWredoxgehk8d5EGQfQ7FwlFpUkDlGGaCGOKQX+G4DVa2
        Ir56W/JaJCS9YQJ3ak2xQaU=
X-Google-Smtp-Source: AA6agR4bOHZ1CztXb8cWxI5xkEclaZN0ZXwrggzIWlkOxL7D98iCI+GmeK/EqqqXMNdopQlxnbnqww==
X-Received: by 2002:a63:101f:0:b0:42a:247f:5274 with SMTP id f31-20020a63101f000000b0042a247f5274mr2400649pgl.87.1660879311761;
        Thu, 18 Aug 2022 20:21:51 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902d14300b0016f1319d2a7sm2036995plt.297.2022.08.18.20.21.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2022 20:21:51 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Michael Heemskerk <mheemskerk@atlassian.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 0/9] Fix issues of refx-txn hook for various git commands
Date:   Fri, 19 Aug 2022 11:21:38 +0800
Message-Id: <20220819032147.28841-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <CANYiYbFw71bX827akAG87RSKOozPk313Hoe573O9dQ65_U6sLQ@mail.gmail.com>
References: <CANYiYbFw71bX827akAG87RSKOozPk313Hoe573O9dQ65_U6sLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Before Patrick introduced the reference-transaction hook in git 2.28,
We had implemented some internal transaction hooks "pre-txn" and
"post-txn" for our internal git infrastructure. The "pre-txn" hook is
used to check our site-wide lockfile to disable write services for
one or multiple repositories. The "post-txn" hook is used to update
the timestamp and checksum of the repository. Recently I wanted to
migrate our internal implementation to use ref-txn hooks, but I ran
into the same issues reported by Michael and Bryan:

 * https://lore.kernel.org/git/CAGyf7-GYYA2DOnAVYW--=QEc2WjSHzUhp2OQyuyOr3EOtFDm6g@mail.gmail.com/
 * https://lore.kernel.org/git/pull.1228.git.1651676435634.gitgitgadget@gmail.com/

This patch series try to fix the issues I encountered.

Patch 1/9 adds more testcases in t1416:

 * Some commands failed because the expected "<old-oid>" was
   "<zero-oid>". Such as: "git update-ref -d <ref>".

 * Some commands failed because the "reference-transaction committed"
   command was repeated multiple times for the same changes. Such as:
   "git update-ref -d <ref>" and "git tag -d <tag>".

 * Some commands should not trigger the "reference-transaction" hook
   because no real changes have occurred to the repository. Such as:
   "git pack-refs --all" and "git gc".

 * Some commands did not execute the "reference-transaction" hook at
   all. E.g.: "git branch -c <src> <dest>", "git branch -m <old> <new>".

Patch 2/9 propagates real old-oid found in lockfile to the update
entries for transaction, so we can get proper old-oid in "prepared" and
"committed" stage for refs-txn hook.

Patch 3/9 adds a new flag in transaction, and we can turn off running
the entire hook for git-pack-refs in patch 4/9. We can also turn off the
"committed" and "aborted" stages of the ref-txn hook for
"packed-ref-store", but we can still run "prepared" stage of the hook.
See patch 5/9.

Patch 6/9 and 7/9 create an extended function
"ref_transaction_update_extended()"
to be used in patch 8/9 to reimplement branch copy and rename.

Patch 9/9 reimplents "files_delete_refs()" to fix failed testcases for
"git branch -d" and "git tag -d".

## Commit log changed since v1:

 1:  bd0ceab4a2 !  1:  2860af63ee t1416: more testcases for reference-transaction hook
    @@ Commit message
          * git tag <new-tag> <oid>                      # create new tag
          * git update-ref --stdin                       # create new refs
          * git update-ref <ref> <oid>                   # create new ref
    +     * git update-ref <ref> <new-oid> <old-oid>     # update ref
     
    -    But 16 testcases failed.
    +    But 17 testcases failed.
     
         Some commands failed because the expected "<old-oid>" became
         "<zero-oid>". E.g.:
    @@ Commit message
          * git tag -d <tag>
          * git update-ref --stdin                       # update/delete refs
          * git update-ref -d <ref>
    -     * git update-ref <ref> <new-oid> [<old-oid>]   # update ref
    +     * git update-ref <ref> <new-oid>               # update ref
     
         Some commands failed because the "reference-transaction committed"
         command was repeated multiple times for the same changes. E.g.:
    @@ Commit message
         We will fix the failed testcases in later commits.
     
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
     
 2:  915ff63007 !  2:  1dbd4251aa refs: update missing old-oid in transaction from lockfile
    @@ Commit message
         in any case, get proper old_oid from the lock file and propagate it to
         the corresponding update entry of a transaction.
     
    -    The behavior of the following git commands and four testcases have been
    +    The behavior of the following git commands and five testcases have been
         fixed in t1416:
     
    -     * git branch [-f] <ref> <new-oid>              # update branch
    +     * git branch [-f] <ref> <new-oid>      # update branch
          * git cherry-pick <oid>
          * git rebase
          * git tag -d <tag>
    -     * git update-ref --stdin                       # update refs
    +     * git update-ref --stdin               # update refs
          * git update-ref -d <ref>
    -     * git update-ref <ref> <new-oid> [<old-oid>]   # update ref
    +     * git update-ref <ref> <new-oid>       # update ref
     
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>

 3:  cf7be214c6 !  3:  58658c782d refs: add new field in transaction for running transaction hook
    @@ Commit message
         and aborted. To update a reference, git may create two seperate
         transactions, one for loose reference and one for packed ref-store. This
         may cause duplicate running of the hook for same references. The new
    -    field "hook_flags" in the transaction can turn off running of a specific
    +    field "hook_flags" in the transaction can turn off running a specific
         transaction. In some scenarios, we may only want to turn off certain
         states of a transaction, such as "committed" and "aborted", but want to
         turn on the "prepared" state of the hook to do some pre-checks, so the
    @@ Commit message
         By calling the "ref_store_transaction_begin()" function, all the flags
         of the "hook_flags" field for the new initialized transaction will be
         turned on. The new function "ref_store_transaction_begin_extended()"
    -    will be used in later commits to custom the "hook_flags" field for a
    -    new initialized transaction.
    +    will be used in later commits with a specific "hook_flags" field to
    +    initialize a new transaction.
     
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
 4:  34f6a5803a !  4:  ec0c6a1aed refs: do not run transaction hook for git-pack-refs
    @@ Metadata
      ## Commit message ##
         refs: do not run transaction hook for git-pack-refs
     
    -    git-pack-refs will call "files_pack_refs()" to pack loose references
    -    into the "packed-refs" file, and there are no real changes to the
    -    repository. Therefore, by initializing a transaction with an empty
    -    "hook_flags" field, the "reference-transaction" hook will not run.
    +    The git-pack-refs command will call "files_pack_refs()" to pack loose
    +    references into the "packed-refs" file, and there are no real changes
    +    to the repository. Therefore, by initializing a transaction with an
    +    empty "hook_flags" field, the "reference-transaction" hook will not run.
     
         The "prune_refs()" and "prune_ref()" functions are called from
         "file_pack_refs()", and they are used to prune loose refereces which

 5:  649a5734c3 !  5:  d04425af29 refs: avoid duplicate running of the reference-transaction hook
    @@ Commit message
         If there are references to be deleted in a transaction, we should remove
         each reference from both loose references and the "packed-refs" file.
         The "reference-transaction" hook will run twice, once for the primary
    -    ref-store (loose references), and another for the second ref-store (i.e.
    +    ref-store (loose ref-store), and another for the second ref-store (i.e.
         packed ref-store).
     
         To avoid duplicate running of the "reference-trancaction" hook, we pass
         a special "hook-flags" parameter to initialize the second ref-store.
         The "REF_TRANSACTION_RUN_PREPARED_HOOK" bit is preserved for the
         transaction of the second ref-store because we may still want to call
    -    command "reference-trancaction prepared" for some pre-checks, such as
    -    terminate unwanted transaction for the "packed-refs" file.
    +    command "reference-trancaction prepared" to do some checks. E.g.: We
    +    can create a global lock file (such as "site.lock") to disable writing
    +    permissions for one or multiple repositories.
     
         The behavior of the following git commands and five testcases have been
         fixed in t1416:

 6:  9c5ae8e592 !  6:  7443764f6f refs: add reflog_info to hold more fields for reflog entry
    @@ Commit message
         a new structure "reflog_info" to hold more custom fields for the new
         reflog entry, and add two additional extended version functions.
     
    -    We will use this extension in a later commit to reimplement
    -    "files_copy_or_rename_ref()" using "refs_update_ref_extended()" to
    -    create new reference in a transaction and add proper reflog entry.
    +    We will use this extension in a later commit to reimplement the function
    +    "files_copy_or_rename_ref()" by calling "refs_update_ref_extended()" to
    +    create a new reference in a transaction, while adding proper reflog
    +    entry.
     
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
 7:  602deefb6d !  7:  0347885acc refs: get error message via refs_update_ref_extended()
    @@ Metadata
      ## Commit message ##
         refs: get error message via refs_update_ref_extended()
     
    -    The last parameter for "refs_update_ref_extended()" is an enum
    -    "action_on_err", and we can not use this function to get the specific
    -    error message. Extend this function again to get error message.
    +    The last parameter of the function "refs_update_ref()" is an enum
    +    "action_on_err", and we can not use this function to get the error
    +    message. Extend this function to get error message.
     
         We will use the function "refs_update_ref_extended()" to reimplement
         the function "files_copy_or_rename_ref()" in later commit.

 8:  16f3c34db1 !  8:  3c41c0ac8d refs: reimplement files_copy_or_rename_ref() to run hook
    @@ Metadata
     Author: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## Commit message ##
    -    refs: reimplement files_copy_or_rename_ref() to run hook
    +    refs: reimplement files_copy_or_rename_ref() to run refs-txn hook
     
         When copying or renaming a branch, the "reference-transaction" hook is
    -    not executed. This is because we used to reinvent the wheel in function
    -    "files_copy_or_rename_ref()". By calling "refs_update_ref_extended()" to
    -    reimplement "files_copy_or_rename_ref()", the "reference-transaction"
    -    hook will run correctly.
    +    not executed. This is because we called two low-level functions
    +    "lock_ref_oid_basic()" and "write_ref_to_lockfile()", and reinvented
    +    the wheel in "commit_ref_update()" to update the reference instead of
    +    implementing "files_copy_or_rename_ref()" by calling "refs_update_ref()"
    +    to update a reference in a transaction. The reason for this is that we
    +    want to create a proper reflog for the newly copied reference.
    +
    +    Refactor "files_copy_or_rename_ref()" by calling the extended version
    +    of "refs_update_ref", i.e. "refs_update_ref_extended()", so we can
    +    create the target branch for copying or renaming a branch and generate
    +    a correct reflog file at the same time.
     
         The behavior of the following git commands and two testcases have been
         fixed in t1416:

 9:  c206059145 !  9:  f201436741 refs: reimplement refs_delete_refs() and run hook once
    @@ Metadata
      ## Commit message ##
         refs: reimplement refs_delete_refs() and run hook once
     
    -    When delete references using "git branch -d" or "git tag -d", there will
    -    be duplicate call of "reference-transaction committed" for same refs.
    -    This is because "refs_delete_refs()" is called twice, once for
    -    files-backend and once for packed-backend, and we used to reinvented the
    -    wheel in "files_delete_refs()" and "packed_delete_refs()". By removing
    -    "packed_delete_refs()" and reimplement "files_delete_refs()", the
    -    "reference-transaction" hook will run only once for deleted branches and
    -    tags.
    +    When using "git branch -d" or "git tag -d" to delete one or multiple
    +    references, command "reference-transaction committed" will be called
    +    repeatedly for the same references. This is because the function
    +    "refs_delete_refs()" is called twice, once for loose ref-store and once
    +    for packed ref-store.
    +
    +    The old story starts when running the function "refs_delete_refs()" on a
    +    loose ref-store:
    +
    +     1. Try to remove the references from packed ref-store.
    +
    +        1.1. Lock the packed-ref-store by calling "packed_refs_lock()" in
    +             "files_delete_refs()".
    +
    +        1.2. Call "refs_delete_refs()" on packed-ref-store, and then call
    +             "packed_delete_refs()".
    +
    +        1.3. Create a transaction for packed-ref-store in function
    +             "packed_delete_refs()" by calling the function
    +             "ref_store_transaction_begin()".
    +
    +        2.2. Add update entries for all the references to be removed into
    +             this transaction by calling "ref_transaction_delete()".
    +
    +        2.3. Call "ref_transaction_commit()" to commit the transaction.
    +
    +        2.4. Unlock the packed-ref-store.
    +
    +     2. Try to remove the references one by one by calling the function
    +        "refs_delete_ref()".
    +
    +        2.1. Create a new transaction on loose-ref-store by calling
    +             "ref_store_transaction_begin()".
    +
    +        2.2. Call "ref_transaction_delete()" to add a update entry
    +             for the reference to be deleted into the transaction.
    +
    +        2.3. In "ref_transaction_commit()", it will call functions
    +             "files_transaction_prepare()" and "files_transaction_finish()"
    +             to commit the transaction.
    +
    +             2.3.1. Lock the loose reference.
    +
    +             2.3.2. Create a new packed-transaction, and add a new update
    +                    entry to this packed-transaction. The previous step 1
    +                    makes this operation unnecessary.
    +
    +             2.3.3. Lock the packed-ref-store and call fucntion
    +                    "is_packed_transaction_needed()" to check whether it
    +                    is necessary to commit the transaction, and then
    +                    abort the transaction because the reference is already
    +                    removed from the packed-ref-store in step 1.
    +
    +             2.3.4. Remove the reflog and the loose reference file for
    +                    the reference to be deleted.
    +
    +             2.3.4. Unlock the loose reference.
    +
    +    From the above steps, we can see that "refs_delete_refs()" is not an
    +    atomic operation, but a semi-atomic operation. The operation is atomic
    +    if all references to be deleted are in the packed ref-store, but not
    +    if some references are loose references because we delete the loose
    +    references one by one by calling "refs_delete_ref()" .
    +
    +    Refactored function "files_delete_refs()" to delete references within a
    +    transaction, so the "reference-transaction" hook will only run once for
    +    deleted branches and tags.
     
         The behavior of the following git commands and the last two testcases
         have been fixed in t1416:

## Source code changed since v1:

 2:  915ff63007 !  2:  1dbd4251aa refs: update missing old-oid in transaction from lockfile
    
      ## refs/files-backend.c ##
     @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *refs,
    - 			goto out;
    - 		}
    + 	update->backend_data = lock;
      
    + 	if (update->type & REF_ISSYMREF) {
    ++		const char *ref;
    ++
     +		/*
    -+		 * Propagate old_oid from the lock to the update entry, so we can
    -+		 * provide a real old-oid of to the "reference-transaction" hook.
    ++		 * Read the referent even though we won't use it as part
    ++		 * of the transaction, because we want to set a proper
    ++		 * old_oid for this symref using the oid we got.
     +		 */
    -+		if (!(update->flags & REF_HAVE_OLD)) {
    -+			oidcpy(&update->old_oid, &lock->old_oid);
    -+			update->flags |= REF_HAVE_OLD;
    -+		}
    ++		ref = refs_resolve_ref_unsafe(&refs->base,
    ++					      referent.buf, 0,
    ++					      &lock->old_oid, NULL);
    ++
    + 		if (update->flags & REF_NO_DEREF) {
    + 			/*
    + 			 * We won't be reading the referent as part of
    +-			 * the transaction, so we have to read it here
    +-			 * to record and possibly check old_oid:
    ++			 * the transaction, so we may need to check
    ++			 * old_oid here:
    + 			 */
    +-			if (!refs_resolve_ref_unsafe(&refs->base,
    +-						     referent.buf, 0,
    +-						     &lock->old_oid, NULL)) {
    ++			if (!ref) {
    + 				if (update->flags & REF_HAVE_OLD) {
    + 					strbuf_addf(err, "cannot lock ref '%s': "
    + 						    "error reading reference",
    +@@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *refs,
    + 		}
    + 	}
    + 
    ++	/*
    ++	 * Propagate old_oid from the lock to the update entry, so we can
    ++	 * provide a proper old-oid of to the "reference-transaction" hook.
    ++	 */
    ++	if (!(update->flags & REF_HAVE_OLD) && !is_null_oid(&lock->old_oid)) {
    ++		oidcpy(&update->old_oid, &lock->old_oid);
    ++		update->flags |= REF_HAVE_OLD;
    ++	}
     +
    - 		/*
    - 		 * If this update is happening indirectly because of a
    - 		 * symref update, record the old OID in the parent
    + 	if ((update->flags & REF_HAVE_NEW) &&
    + 	    !(update->flags & REF_DELETING) &&
    + 	    !(update->flags & REF_LOG_ONLY)) {
     
 6:  9c5ae8e592 !  6:  7443764f6f refs: add reflog_info to hold more fields for reflog entry

    @@ refs.c: struct ref_update *ref_transaction_add_update(
      		oidcpy(&update->old_oid, old_oid);
     -	update->msg = normalize_reflog_message(msg);
     +	if (reflog_info) {
    -+		update->reflog_info = xmalloc(sizeof(*reflog_info));
    ++		update->reflog_info = xcalloc(1, sizeof(*reflog_info));
     +		update->reflog_info->msg = normalize_reflog_message(reflog_info->msg);
     +		if (reflog_info->old_oid)
     +			update->reflog_info->old_oid = oiddup(reflog_info->old_oid);

## Testcases changed since v1 are not list here

--

Jiang Xin (9):
  t1416: more testcases for reference-transaction hook
  refs: update missing old-oid in transaction from lockfile
  refs: add new field in transaction for running transaction hook
  refs: do not run transaction hook for git-pack-refs
  refs: avoid duplicate running of the reference-transaction hook
  refs: add reflog_info to hold more fields for reflog entry
  refs: get error message via refs_update_ref_extended()
  refs: reimplement files_copy_or_rename_ref() to run refs-txn hook
  refs: reimplement refs_delete_refs() and run hook once

 refs.c                           |   99 ++-
 refs.h                           |   23 +
 refs/debug.c                     |    2 +-
 refs/files-backend.c             |  177 ++---
 refs/packed-backend.c            |   51 +-
 refs/refs-internal.h             |   25 +-
 t/t1416-ref-transaction-hooks.sh | 1115 +++++++++++++++++++++++++++++-
 t/t5510-fetch.sh                 |   16 +
 8 files changed, 1318 insertions(+), 190 deletions(-)

-- 
2.36.1.25.gc87d5ad63a.dirty

