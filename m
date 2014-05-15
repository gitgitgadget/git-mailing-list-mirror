From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 00/44] Use ref transactions for all ref updates
Date: Thu, 15 May 2014 10:29:15 -0700
Message-ID: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:32:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzWJ-00030c-Bc
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873AbaEORcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:32:33 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:37708 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231AbaEORaG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:06 -0400
Received: by mail-yh0-f73.google.com with SMTP id f73so637279yha.0
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=OF15uUHWvmgBVgrEOLEy2NJGZJtKCXTncfVIVlNEa6Y=;
        b=XBXa04mwkcxQobLnSPgfY1ukJXpSDtedKAvbgbv0ZhLvt2vUMZ6kSMBdmVPEf4Z8x2
         8sVZv5HSBotMjPyMC3W0IHBwJRVwrqaigAmTpR3v9HY+xvVfKyUKPI29dVm2YshKtZKg
         ZG4Qc+1Mz7G1y2kh9UpN5jAvSyWsekchc1J5gXXA/Vgnd7ib2aVMFqhsbrQ43Ai71HvI
         s/3+gUBqggDrTv4/aD8CqdR4zKbuxUnzwxwRuGOyutgRwSxhN2T74dK5ZouxWgnK6JyZ
         xcDKlgetCdHGLAY3cTb4Yi2trQMLJFgaPer72szT7vE21xNzAPlB92sfObf9Mv68Kn2K
         7SlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OF15uUHWvmgBVgrEOLEy2NJGZJtKCXTncfVIVlNEa6Y=;
        b=PiEI4dGM5q7I85Nep8MwMRu4qdBPJ141wH+FEnsUVu+rUIzhSNLeTSDR+3JFamIKtZ
         hKa84eQ3z8AlF9Tzw1rpsbRipj26PDomoeP0lvAVGmzE6+e0T1koElBJvzkCMxQrYnJH
         9HhvOJ0PR+mjwSvyObHy4Fi0KylEdcbSkhc7Z2cQ/RJFHUU2InQj7h5t89W5/LctOMig
         CHpYOaPsZDIXZEza1X4a4v6SUjeaHn08mR+9lGo0Aoa88RvoxH8B8S71gKu6qo0o++/b
         +8TMgNkhcr35gsb3z9UA4wE4Fys67Q1l8271UlyVWVgZXxQ1TMP4hpLl0Z7sLYhfhkFs
         Hf8A==
X-Gm-Message-State: ALoCoQn4HYapZItYFh7uYbG21243/nuAyzWTVaft+EHdDf0Dkp5S/kiMydmqFtuRUgC5HFK+TQDm
X-Received: by 10.52.146.45 with SMTP id sz13mr4707886vdb.6.1400175005793;
        Thu, 15 May 2014 10:30:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si273155yhk.4.2014.05.15.10.30.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8F15331C1CD;
	Thu, 15 May 2014 10:30:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 38026E1084; Thu, 15 May 2014 10:30:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249159>

This patch series can also be found at
https://github.com/rsahlberg/git/tree/ref-transactions


This patch series is based on next and expands on the transaction API. It
converts all ref updates, inside refs.c as well as external, to use the
transaction API for updates. This makes most of the ref updates to become
atomic when there are failures locking or writing to a ref.

This version completes the work to convert all ref updates to use transactions.
Now that all updates are through transactions I will start working on
cleaning up the reading of refs and to create an api for managing reflogs but
all that will go in a different patch series.

Version 8:
 - Updates after review by JN
 - Improve commit messages
 - Add a patch that adds an err argument to repack_without_refs
 - Add a patch that adds an err argument to delete_loose_ref
 - Better document that a _update/_delete/_create failure means the whole
   transaction has failed and needs rollback.

Version 7:
 - Updated commit messages per JNs review comments.
 - Changed REF_ISPRUNING and REF_ISPACKONLY to be private flags and not
   exposed through refs.h

Version 6:
 - Convert all updates in refs.c to use transactions too.

Version 5:
 - Reword commit messages for having _create/_delete/_update returning
   success/failure. There are no conditions yet that return an error from
   these failures but there will be in the future. So we still check the
   return from these functions in the callers in preparation for this.
 - Don't leak memory by just passing a strbuf_detach() pointer to functions.
   Use <obj>.buf and explicitely strbuf_release the data afterwards.
 - Remove the function update_ref_lock.
 - Remove the function update_ref_write.
 - Track transaction status and die(BUG:) if we call _create/_delete/_update/
   _commit for a transaction that is not OPEN.

Version 4:
 - Rename patch series from "Use ref transactions from most callers" to
   "Use ref transactions for all ref updates".
 - Convert all external ref writes to use transactions and make write_ref_sha1
   and lock_ref_sha1 static functions.
 - Change the ref commit and free handling so we no longer pass pointer to
   pointer to _commit. _commit no longer frees the transaction. The caller
   MUST call _free itself.
 - Change _commit to take a strbuf pointer instead of a char* for error
   reporting back to the caller.
 - Re-add the walker patch after fixing it.

Version 3:
 - Remove the walker patch for now. Walker needs more complex solution
   so defer it until the basics are done.
 - Remove the onerr argument to ref_transaction_commit(). All callers
   that need to die() on error now have to do this explicitely.
 - Pass an error string from ref_transaction_commit() back to the callers
   so that they can craft a nice error message upon failures.
 - Make ref_transaction_rollback() accept NULL as argument.
 - Change ref_transaction_commit() to take a pointer to pointer argument for
   the transaction and have it clear the callers pointer to NULL when
   invoked. This allows for much nicer handling of transaction rollback on
   failure.
Version 2:
 - Add a patch to ref_transaction_commit to make it honor onerr even if the
   error triggered in ref_Transaction_commit itself rather than in a call
   to other functions (that already honor onerr).
 - Add a patch to make the update_ref() helper function use transactions
   internally.
 - Change ref_transaction_update to die() instead of error() if we pass
   if a NULL old_sha1 but have have_old == true.
 - Change ref_transaction_create to die() instead of error() if new_sha1
   is false but we pass it a null_sha1.
 - Change ref_transaction_delete die() instead of error() if we pass
   if a NULL old_sha1 but have have_old == true.
 - Change several places to do  if(!transaction || ref_transaction_update()
   || ref_Transaction_commit()) die(generic-message) instead of checking each
   step separately and having a different message for each failure.
   Most users are likely not interested in what step of the transaction
   failed and only whether it failed or not.
 - Change commit.c to only pass a pointer to ref_transaction_update
   iff current_head is non-NULL.
   The previous patch used to compute a garbage pointer for
   current_head->object.sha1 and relied on the fact that ref_transaction_update
   would not try to dereference this pointer if !!current_head was 0.
 - Updated commit message for the walker_fetch change to try to justify why
   the change in locking semantics should not be harmful.



Ronnie Sahlberg (44):
  refs.c: constify the sha arguments for
    ref_transaction_create|delete|update
  refs.c: allow passing NULL to ref_transaction_free
  refs.c: add a strbuf argument to ref_transaction_commit for error
    logging
  refs.c: add an err argument to repack_without_refs
  refs.c: make ref_update_reject_duplicates take a strbuf argument for
    errors
  refs.c: add an err argument ro delete_loose_ref
  refs.c: make update_ref_write update a strbuf on failure
  update-ref.c: log transaction error from the update_ref
  refs.c: remove the onerr argument to ref_transaction_commit
  refs.c: change ref_transaction_update() to do error checking and
    return status
  refs.c: change ref_transaction_create to do error checking and return
    status
  refs.c: ref_transaction_delete to check for error and return status
  tag.c: use ref transactions when doing updates
  replace.c: use the ref transaction functions for updates
  commit.c: use ref transactions for updates
  sequencer.c: use ref transactions for all ref updates
  fast-import.c: change update_branch to use ref transactions
  branch.c: use ref transaction for all ref updates
  refs.c: change update_ref to use a transaction
  refs.c: free the transaction before returning when number of updates
    is 0
  refs.c: ref_transaction_commit should not free the transaction
  fetch.c: clear errno before calling functions that might set it
  fetch.c: change s_update_ref to use a ref transaction
  fetch.c: use a single ref transaction for all ref updates
  receive-pack.c: use a reference transaction for updating the refs
  fast-import.c: use a ref transaction when dumping tags
  walker.c: use ref transaction for ref updates
  refs.c: make write_ref_sha1 static
  refs.c: make lock_ref_sha1 static
  refs.c: add transaction.status and track OPEN/CLOSED/ERROR
  refs.c: remove the update_ref_lock function
  refs.c: remove the update_ref_write function
  refs.c: remove lock_ref_sha1
  refs.c: make prune_ref use a transaction to delete the ref
  refs.c: make delete_ref use a transaction
  refs.c: pass the ref log message to _create/delete/update instead of
    _commit
  refs.c: pass NULL as *flags to read_ref_full
  refs.c: pack all refs before we start to rename a ref
  refs.c: move the check for valid refname to lock_ref_sha1_basic
  refs.c: call lock_ref_sha1_basic directly from commit
  refs.c: add a new flag for transaction delete for refs we know are
    packed only
  refs.c: pass a skip list to name_conflict_fn
  refs.c: make rename_ref use a transaction
  refs.c: remove forward declaration of write_ref_sha1

 branch.c               |  31 ++--
 builtin/commit.c       |  24 ++-
 builtin/fetch.c        |  29 ++--
 builtin/receive-pack.c |  20 +--
 builtin/replace.c      |  15 +-
 builtin/tag.c          |  15 +-
 builtin/update-ref.c   |  32 ++--
 fast-import.c          |  39 +++--
 refs.c                 | 443 ++++++++++++++++++++++++++++---------------------
 refs.h                 |  54 +++---
 sequencer.c            |  24 ++-
 t/t3200-branch.sh      |   2 +-
 walker.c               |  51 +++---
 13 files changed, 449 insertions(+), 330 deletions(-)

-- 
2.0.0.rc3.477.g0f8edf7
