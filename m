From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 00/48] Use ref transactions
Date: Tue, 10 Jun 2014 15:28:48 -0700
Message-ID: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:37:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUan-00073Y-Qq
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177AbaFJWcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:32:14 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:41203 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169AbaFJW3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:41 -0400
Received: by mail-ve0-f202.google.com with SMTP id oz11so493858veb.5
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=kBR3WnkrKV0blGzRNiaX8t49us2QnXzxw/X1moBJaBM=;
        b=cWDTj0+DMqaHXDVqnCzyn2eXLZCj9rZOepSN4lxEDZRJFrMEwu5UWzbgjab/hSHmjm
         II5AhiObYG99HBLfxjRvZtblPBErRXqFAlYUK/fIwgTIq1tssJIMr3HCzJGHhUEdHzGq
         fVfnFHHODCIcu098j1JFwGmQARlqXZQmV9yi+wDYIrKUYMhvkauqPM9kW82cMKGxV7KG
         V6hfSjIBgOFa/Dtbjm9ma3mQCOUF81xY6UVid9kxfKqQgeTMO5RQzXe4PQPfCCaeEksA
         hPd5HXwIwn5CBCdniH7bnrOEXBdnSVZqJNRCSXvh+64cvxdgAgd0q8tS506M7hazUJri
         L/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=kBR3WnkrKV0blGzRNiaX8t49us2QnXzxw/X1moBJaBM=;
        b=L4bfNJNDN02qaqE024ZOJhJUuiu/j5OqR5s/CDRSDEoos/24mdlAsFCzJ6Am6S8g8i
         Oax9fLUVol0qqXNVDAgGt1gdVsR6iF2qyVq2/ObS366/AFqPrSyeELr8FmwgH0V4kOnT
         NawiWBvUGZYbL1KIfxyQ4SfiTmam+DUyCFroQKGQLVPTxANiCX+U8E/p1VMWz50udB1H
         pk5zTSwtRrH40fie0LNP35JuQ8QIqy47Sr5UJqI2Ev8mLG0Zjk84s+cAK1z8+FlKnnk3
         mbOnsBRNGBIppg79qtI52r8pxvL1VneZSt23saOGPlxZYPZnh0ZuHG68Mf7Ap/ylRJTJ
         abRQ==
X-Gm-Message-State: ALoCoQmIvSjSk+li9M1iAGgCa9OLaLVMZbZ+3i5KSfEUJxjVadxUOMl6Zc+i4KQVUeXePo3aH0oi
X-Received: by 10.224.79.212 with SMTP id q20mr16651757qak.9.1402439380030;
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si1395388yhk.4.2014.06.10.15.29.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id C66175A46F1;
	Tue, 10 Jun 2014 15:29:39 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 65C35E0A0A; Tue, 10 Jun 2014 15:29:39 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251280>

Final version.

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

Version 15:
 - Break the errno updates out into smaller individual patches
   as per JNs suggestion.
Version 14:
 - Remove the patch to pack the refs before rename. We do not need this
   with the reworked renames that will come 2 series later.
   The rename_ref changes are thus no longer part of this series.
Version 13:
 - This version should cover all of JNs suggestions on the previous series.
   If I missed anything I appologize.
...

Ronnie Sahlberg (48):
  refs.c: remove ref_transaction_rollback
  refs.c: ref_transaction_commit should not free the transaction
  refs.c: constify the sha arguments for
    ref_transaction_create|delete|update
  refs.c: allow passing NULL to ref_transaction_free
  refs.c: add a strbuf argument to ref_transaction_commit for error
    logging
  lockfile.c: add a new public function unable_to_lock_message
  lockfile.c: make lock_file return a meaningful errno on failurei
  refs.c: add an err argument to repack_without_refs
  refs.c: make sure log_ref_setup returns a meaningful errno
  refs.c: verify_lock should set errno to something meaningful
  refs.c: make remove_empty_directories alwasy set errno to something
    sane
  refs.c: commit_packed_refs to return a meaningful errno on failure
  refs.c: make resolve_ref_unsafe set errno to something meaningful on
    error
  refs.c: log_ref_write should try to return meaningful errno
  refs.c: make ref_update_reject_duplicates take a strbuf argument for
    errors
  refs.c: add an err argument to delete_ref_loose
  refs.c: make update_ref_write update a strbuf on failure
  update-ref: use err argument to get error from ref_transaction_commit
  refs.c: remove the onerr argument to ref_transaction_commit
  refs.c: change ref_transaction_update() to do error checking and
    return status
  refs.c: change ref_transaction_create to do error checking and return
    status
  refs.c: update ref_transaction_delete to check for error and return
    status
  refs.c: make ref_transaction_begin take an err argument
  refs.c: add transaction.status and track OPEN/CLOSED/ERROR
  tag.c: use ref transactions when doing updates
  replace.c: use the ref transaction functions for updates
  commit.c: use ref transactions for updates
  sequencer.c: use ref transactions for all ref updates
  fast-import.c: change update_branch to use ref transactions
  branch.c: use ref transaction for all ref updates
  refs.c: change update_ref to use a transaction
  receive-pack.c: use a reference transaction for updating the refs
  fast-import.c: use a ref transaction when dumping tags
  walker.c: use ref transaction for ref updates
  refs.c: make lock_ref_sha1 static
  refs.c: remove the update_ref_lock function
  refs.c: remove the update_ref_write function
  refs.c: remove lock_ref_sha1
  refs.c: make prune_ref use a transaction to delete the ref
  refs.c: make delete_ref use a transaction
  refs.c: pass the ref log message to _create/delete/update instead of
    _commit
  refs.c: pass NULL as *flags to read_ref_full
  refs.c: move the check for valid refname to lock_ref_sha1_basic
  refs.c: call lock_ref_sha1_basic directly from commit
  refs.c: pass a skip list to name_conflict_fn
  refs.c: propagate any errno==ENOTDIR from _commit back to the callers
  fetch.c: change s_update_ref to use a ref transaction
  refs.c: make write_ref_sha1 static

 branch.c               |  30 +--
 builtin/commit.c       |  24 ++-
 builtin/fetch.c        |  36 ++--
 builtin/receive-pack.c |  32 +++-
 builtin/replace.c      |  15 +-
 builtin/tag.c          |  15 +-
 builtin/update-ref.c   |  34 ++--
 cache.h                |   4 +-
 fast-import.c          |  54 ++++--
 lockfile.c             |  39 ++--
 refs.c                 | 507 ++++++++++++++++++++++++++++++++-----------------
 refs.h                 | 128 +++++++++----
 sequencer.c            |  24 ++-
 walker.c               |  58 +++---
 14 files changed, 659 insertions(+), 341 deletions(-)

-- 
2.0.0.574.g30c2c5e
