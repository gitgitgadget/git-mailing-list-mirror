From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 00/30] Use ref transactions for all ref updates
Date: Tue, 29 Apr 2014 15:18:45 -0700
Message-ID: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:21:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGP6-0003nO-CU
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965264AbaD2WTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:19:19 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:50733 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965250AbaD2WTS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:18 -0400
X-Greylist: delayed 84264 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Apr 2014 18:19:18 EDT
Received: by mail-pa0-f74.google.com with SMTP id rd3so167825pab.1
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ppikNeQihXQUOrIhz2poAWuPTz4mljYe/HvLGC24Ixg=;
        b=W3OrSAD13yGk25ETvrnPG1iRY3UJB0Y7BgNlt5eELpypzYyxmGwR8+PO0I91SAUmry
         FRsFYFwt7Y9+OXbS9NSh3yncknHAhOCAINpGbjKUDknxkETjGNppD/ilFYKnDgAYisyl
         4xSU+xJt5I7GA5wMqD+j1ZKhdsNUtNO9Z7RCS021r7d43fhf0eHmewe8ThJtpmWHFjrO
         I3OyVZbqj97IhyRfYPC1nAga4EiGZkOfuR+6+zfSciErjnHq/IGQiX80DqHCJmwSRSh0
         Fic4wcjQ3/U3SqHTY/380MR9NwK6jnWE74K0W+NXfU9BH+wl50TXaEucFkhxUSfxXNAq
         yMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ppikNeQihXQUOrIhz2poAWuPTz4mljYe/HvLGC24Ixg=;
        b=OC19GktgIlNAxBu+NZktTKPhokega/nL+rw36z9L5SfZMaRfBhg+VbMqDZW6O+r/XI
         EGKhkUISOn3qJXt2gYqANkARIXhI1Ax8fCX9frcr56SBuRB34PMQ4N40wduX01xn2Nd4
         tt6Qyc0hesvOo6sqeJSswD8mpGqAstw5JYXMO2DaNroQKQ80nMeM1tUCOKxgmfapZ9al
         p27T9slAShPs4Xccu0VQy8EMnX5jYhQ8JGWprImpTgApjyrvEqWpVB2IwoRXzVALHndD
         7BpAWQeGbpqShMdhG8KO5zeEKAS34G/6BWCRiwFzzg1RnEakf+h1oKJ2UMykxliLAmbY
         Q+pA==
X-Gm-Message-State: ALoCoQnUw5aDAMuWTl+UCfcm0vOtsecOWtsB9AKnklmMyWPKOHdLigoNDBUipJLPmrEPMEuTU8y843BE9wJEEZJSNPOEB9mHbNDwExAYhfiR0P6/iblXOf7ABTBDKCPoKQjOpnuEkUW22xGR6QmtIFYxfLgVgDnF71PC1MPVY8Bes+6lbOa9BO8vM3NIrcyoci1HFtvyhE1P
X-Received: by 10.66.233.8 with SMTP id ts8mr368743pac.38.1398809957695;
        Tue, 29 Apr 2014 15:19:17 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si2738462yhb.6.2014.04.29.15.19.17
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:17 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6F0B731C1D2;
	Tue, 29 Apr 2014 15:19:17 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 12A36E0A5B; Tue, 29 Apr 2014 15:19:16 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247646>

This patch series is based on mhagger/ref-transactions and expands on the
transaction API. It converts all external (outside of refs.c) callers to
use the transaction API for any writes.
This makes most of the ref updates to become atomic when there are failures
locking or writing to a ref.

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

Ronnie Sahlberg (30):
  refs.c: constify the sha arguments for
    ref_transaction_create|delete|update
  refs.c: allow passing NULL to ref_transaction_free
  refs.c: add a strbuf argument to ref_transaction_commit for error
    logging
  refs.c: make ref_update_reject_duplicates take a strbuf argument for
    errors
  update-ref.c: log transaction error from the update_ref
  refs.c: make update_ref_write update a strbuf on failure
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

 branch.c               |  31 ++++----
 builtin/commit.c       |  24 +++---
 builtin/fetch.c        |  35 ++++-----
 builtin/receive-pack.c |  20 ++---
 builtin/replace.c      |  15 ++--
 builtin/tag.c          |  15 ++--
 builtin/update-ref.c   |  29 +++++---
 fast-import.c          |  38 ++++++----
 refs.c                 | 193 +++++++++++++++++++++++++++++--------------------
 refs.h                 |  45 ++++++------
 sequencer.c            |  24 ++++--
 walker.c               |  51 ++++++-------
 12 files changed, 297 insertions(+), 223 deletions(-)

-- 
1.9.1.532.gf8485a6
