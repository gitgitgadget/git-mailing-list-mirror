From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 00/27] Use ref transactions for all ref updates
Date: Mon, 28 Apr 2014 15:54:15 -0700
Message-ID: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:56:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuTT-0007Zc-4P
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243AbaD1Wyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:54:47 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:49242 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbaD1Wyq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:46 -0400
Received: by mail-ve0-f201.google.com with SMTP id jy13so1133182veb.0
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kLM4fbemzTP0hEpHnBgD85NB4UU67KovcFRN8CPijj0=;
        b=D3ptY9U5CXyrXxIVzP6Ubwr2MhvWPjO6m1WjuDzvPdRs+p2bLN7nFnQOOajtNxN11+
         LrmgRA0AMxQynDeWzHIYgNBUdT9OymhTvw875gVrktahniFkfMwPz+o3JCtS91Riu5Ev
         8pWwxhmG2AeYvYKkKXjlw1QUghtgDHyMaSwKJg0WpGjwVLEgxoYh3/EDgy9mVYXwfajC
         mSS3SmRgttVsm8EtIbfyApFpbHhJO5LibXhZkNqo3kESA1K632rNiGHwl4X4BnqnpSoT
         qa2yq1EGa6x6rMRSCRpp0hpNMgjXqrm0Ts287v1f4lxdpK2p0WAzrHduY4r+j2Iy++jA
         Xb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kLM4fbemzTP0hEpHnBgD85NB4UU67KovcFRN8CPijj0=;
        b=LIsNUAp7x5pSfjOG1iRu6kImis6ksD2jJxDVN41B4GWKvXlTU8nOQnL72QanByn53R
         FQNI3WE2p5Y6MjEc6yaYwm5Ck2SFtvIC7ylK7PNN2gsWxhVpg8SodjXMe80VXYMoNR9h
         z3OcRunJ3FSZow/Cey/b/4MYA7rrja5aatJ1mpDm2O6EoEvndfbNaYhTdcs0lG9q0hA1
         EKoVI85rlmNu7XJIq2p25qVFr4aJdNRhUDtb9Q1dFJfTr25t73Z2kzGozhYB3zjx5W2O
         tfPC+M8oh8Jgpvu9MJitWvH05jZn7Aeik7K5GSxVTe8TaOp773v1eiCEXRgdjC5EwDjt
         n8UQ==
X-Gm-Message-State: ALoCoQmK+Klq377IpgRnv4/OvfBKLcNU8r8BOnAcV4xGwIuGWUoxd3c5q59vUq3q31X/KFEEvjez9mw6rG/tfh4xmiVh2mfdyLlYRCFCRA5pOE4ITYGqLeqi4kKSDU54LvXyYWlCQ/Fb86LUWaZgRYzq+xlKlSzN+VMfpY/aU7ur11/RuuJCc6Oqr2gnONtUcuPLbv//CBBM
X-Received: by 10.58.30.78 with SMTP id q14mr13996316veh.10.1398725685185;
        Mon, 28 Apr 2014 15:54:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si1424513yhl.7.2014.04.28.15.54.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id DAFC331C224;
	Mon, 28 Apr 2014 15:54:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5A9E5E080D; Mon, 28 Apr 2014 15:54:44 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247485>

This patch series is based on mhagger/ref-transactions and expands on the
transaction API. It converts all external (outside of refs.c) callers to
use the transaction API for any writes.
This makes most of the ref updates to become atomic when there are failures
locking or writing to a ref.


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

Ronnie Sahlberg (27):
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

 branch.c               |  31 +++++++-------
 builtin/commit.c       |  24 +++++------
 builtin/fetch.c        |  36 ++++++++--------
 builtin/receive-pack.c |  20 ++++-----
 builtin/replace.c      |  15 ++++---
 builtin/tag.c          |  15 ++++---
 builtin/update-ref.c   |  29 +++++++------
 fast-import.c          |  37 ++++++++++------
 refs.c                 | 112 +++++++++++++++++++++++++++++++++----------------
 refs.h                 |  45 ++++++++++----------
 sequencer.c            |  23 +++++++---
 walker.c               |  51 +++++++++++-----------
 12 files changed, 258 insertions(+), 180 deletions(-)

-- 
1.9.1.528.g98b8868.dirty
