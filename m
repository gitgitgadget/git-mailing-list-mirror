From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 00/48] Use ref transactions
Date: Thu, 19 Jun 2014 08:52:42 -0700
Message-ID: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:53:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxeei-00062z-Uh
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758089AbaFSPxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:37619 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757405AbaFSPxd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:33 -0400
Received: by mail-pb0-f74.google.com with SMTP id rq2so296153pbb.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Lsqoo+zGStT5PepcMxBPzpr5MrMRK9ezWedxKp1zBmg=;
        b=RMwammBs+lSoP6L5l5/6N7cnK63/Z4/FoAQDOZQBJjxmX3yXClkp9G+RI0ktYmQOvg
         IbPaUp4788dGLEU5Cdq4O+HWmHnY/Yl07s9oSYYb7LKbgvUUMCE/kftvcv+r/Ol0pvTa
         A3Q0Iimg4f3IFDV5knGQvKU8Cv0Pqvlch2VZTsgkRHBaLxRHkW4kqT3+q/2GSdb46ecN
         c1kjUbOvImKVF3jPD9L2Ui8mEhA+oMwR3VO5fIup+Zxsy25DMg+JtcBm+jdw0TC5qhvU
         0F9sNTvzrPtexZJ7G5MmmUQKYNCMhZhXbKEZoJ5Tn0p0/ee2ZjToY3Qt2OH+owkPvXns
         svSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=Lsqoo+zGStT5PepcMxBPzpr5MrMRK9ezWedxKp1zBmg=;
        b=HjP5C9wAzRTtTesmH21mZNBJ7N8t9QuombZ+ZKuhM19GkZDlQVKgOFJdLK/vCotRGZ
         qX/ug+kDkwFpHPNKbp8t/0rJGsk6TXvgjasPf320/wXAtxG1n5DE0wS0GbkAjgMLUhxn
         epTqtbC1EIP30LOH6oyUJVRpBqPuVVsRuiGx9nkFlyDXLDenD13JHmX5wMs7snhw9i0d
         Tq9lUfgHoJkH7t6x2MJksr13CA0e/EaCOEg3KSnuxduFuKbtiRYiDG8zKxUkbMtriZHA
         deDrDxeoGPPWcuEMNR+zulGuYp37XeSH8CmyaNiVMbea4EdOANHxKSd5AcjbIoWi2myg
         FAKw==
X-Gm-Message-State: ALoCoQl2hiD+HvZzBWp0Uj8QYfsIukfYOoTbha+DDZ9GYqrkBm8gHcT/Wmk5paQoXmfZUbF8SWmR
X-Received: by 10.66.216.161 with SMTP id or1mr2703326pac.38.1403193212831;
        Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t4si421011yhm.0.2014.06.19.08.53.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8ABC431C2E6;
	Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 29FBAE0AF7; Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252115>

This patch series can also be found at
https://github.com/rsahlberg/git/tree/ref-transactions

This patch series is based on current master and expands on the transaction
API. It converts all ref updates, inside refs.c as well as external, to use the
transaction API for updates. This makes most of the ref updates to become
atomic when there are failures locking or writing to a ref.

This version completes the work to convert all ref updates to use transactions.
Now that all updates are through transactions I will start working on
cleaning up the reading of refs and to create an api for managing reflogs but
all that will go in a different patch series.

Version 19:
 Changes based on M Haggertys review:
 1, remove a stray redundant line in
refs.c: log_ref_write should try to return meaningful errno
 2, fix a typo in a comment in
refs.c: verify_lock should set errno to something meaningful
 3, move a patch to change delete_loose_ref so it happens later in the series
refs.c: add an err argument to delete_ref_loose

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
  refs.c: make remove_empty_directories always set errno to something
    sane
  refs.c: commit_packed_refs to return a meaningful errno on failure
  refs.c: make resolve_ref_unsafe set errno to something meaningful on
    error
  refs.c: log_ref_write should try to return meaningful errno
  refs.c: make ref_update_reject_duplicates take a strbuf argument for
    errors
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
  refs.c: add an err argument to delete_ref_loose
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
 builtin/receive-pack.c |  97 ++++++----
 builtin/remote.c       |   5 +-
 builtin/replace.c      |  17 +-
 builtin/tag.c          |  15 +-
 builtin/update-ref.c   |  34 ++--
 cache.h                |   4 +-
 fast-import.c          |  55 ++++--
 lockfile.c             |  39 ++--
 refs.c                 | 505 ++++++++++++++++++++++++++++++++-----------------
 refs.h                 | 131 +++++++++----
 sequencer.c            |  24 ++-
 walker.c               |  58 +++---
 wrapper.c              |  14 +-
 16 files changed, 710 insertions(+), 378 deletions(-)

-- 
2.0.0.438.g337c581
