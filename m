From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 00/42] Use ref transactions for all ref updates
Date: Wed, 14 May 2014 14:16:34 -0700
Message-ID: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:21:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkgcB-0001WN-De
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843AbaENVRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:17:21 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:49971 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbaENVRT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:19 -0400
Received: by mail-qc0-f202.google.com with SMTP id x3so34079qcv.1
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=J0Zui7v/UVlY+B4LYsyX5EE1LW5nbJCbhAHnIDJQ6x8=;
        b=B58Y7HnsCPJycU11khVlDAD1OvTYlLSHoLPOSAqDTZUfTKW62DFMR4oSgIS+J0DIWL
         P90VdN1ZZXZt77fKxwHE2/LjECf1IZobkam3xiELG1DZJGf/rHmHcoXKPjRy9lAFcsnI
         3lJ4upVaN+Fo6wobK2/KtQZZDWRezBOxptkFhoFZ0smLjMF5/ZXtv8uT9bNxCZqpTBy3
         8E9YQyZvnlC5fxEVJx9lfIHPt2F80WNj8LZDs3lLRyOnNxJ1p/LA7QO8Mm80FO2xZJW4
         g+EoGWzgizdv2g6t89f9MPzJwmrZKYCVh+334jSdKhDNvs7q2+vUzs1CNdl4hqHDQCbs
         mYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J0Zui7v/UVlY+B4LYsyX5EE1LW5nbJCbhAHnIDJQ6x8=;
        b=SBuKxQtSsyMc9jDjRtIVA49bNCTsuTqbqXE1l32Q9qrG9f+BaRJ2Wou8HbOGdThezQ
         0mzH/tUZYvSj29TEwzqHzgn1FqZsJK7mvgn9nMF6u25opwbt3IrcsTyJ71YfCaVtrS90
         uIJc346mu+hwK+Sn0nlJhD+wK6T7rl36HYBWKlrjWqYK+csPN9BQTnUmVP33Z1t4XSCN
         DRXL4NhbTpqbTcawingzMEbdOCrAS6QRxh1Y+ySMbW3NbopPNoeIADhFWS/k0pGqPthh
         5Ldgo18jac292AesiIcZUibxcDpNTlZ2irV5W5XOc5CrCJngxv9WtZtvr4lYTog26vTL
         osUg==
X-Gm-Message-State: ALoCoQn3unWWPVabxgVniUXV4wE9k1Fagqvs0wn7/agvd+HVxix+I/igDKEFEtgrUH2E/ILpMEWw
X-Received: by 10.52.90.168 with SMTP id bx8mr2551988vdb.5.1400102238716;
        Wed, 14 May 2014 14:17:18 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si144146yhl.7.2014.05.14.14.17.18
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:18 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 7CCA15A4292;
	Wed, 14 May 2014 14:17:18 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 216B4E0973; Wed, 14 May 2014 14:17:18 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248991>

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


Ronnie Sahlberg (42):
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
 refs.c                 | 413 ++++++++++++++++++++++++++++---------------------
 refs.h                 |  48 +++---
 sequencer.c            |  24 ++-
 t/t3200-branch.sh      |   2 +-
 walker.c               |  51 +++---
 13 files changed, 422 insertions(+), 321 deletions(-)

-- 
2.0.0.rc3.471.g2055d11.dirty
