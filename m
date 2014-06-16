From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 00/48] Use ref transactions
Date: Mon, 16 Jun 2014 11:03:31 -0700
Message-ID: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:07:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbJC-000656-LY
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbaFPSEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:04:25 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:64112 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932360AbaFPSEW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:22 -0400
Received: by mail-yh0-f74.google.com with SMTP id b6so854835yha.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=5z0mU/q7ULD22ziLn43TCbSUJn7GrSuFpnl9vzaEQi0=;
        b=DmQXlMm8ww/Gxp6HxcjlLBBpw51Q9P2hc1Op+UqREa4VeCshOgeGy4aX+sjUud5FT7
         WUTLmaY7XDLDOY7m/9dpOaEt/D0qe9so+wpGu2pKNw6pMhTae8V9sHabWLltbqLJQVyF
         rJhOIohrLHODVtZarXN2ckpQX84vUvSTF/8NRafTRBCqo+yhmaFXAQmnEdxiCk51ygqc
         gFWposVP+VNIE2rIChmNxzP9hmtuOBrlj+RtiEWrZ4Ye1A/eN1fvY6ybfqPd3A7ri0zU
         2czCvwj1iMDZaSE6p6Mpe0bPJP5V3UJBqNlcUacutbDh7smMdygG/rp009qj7+BqHqSd
         RRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=5z0mU/q7ULD22ziLn43TCbSUJn7GrSuFpnl9vzaEQi0=;
        b=E5dlSFh/VPGMMutPAcB3EPyNW8Q1G6O2Sd7u4hu9u8+MHqTFB9IXzVS8fhv20G/num
         no/+1bQT7cmBmHdT3hWfSbPp2bJ2LMkSrQ0Gu0SwSKFpNM8KFBmU+ETj9kdYI3DaYgkI
         Xq4F9tXQXPBgVaGTVGuiNJQEzsMWQSOloIcMN3XCnfCfMCfZHfkg45aP1EPBPFkHzuBz
         RA4uMvMwkJdXK8doLTPWazQxjbDDsdGfR4dlue9azHr5JkxHCWIgHBE5oQOoCEd2kDUv
         epib3pejnHOroywe2HUdxR9No61xQECn73udRRptN2o8x7+qbugYiCI0nlWymu30DvYP
         midg==
X-Gm-Message-State: ALoCoQl9lX6WGfHXxK9ghO3Y52I6uvspkeW60kkv0wvpL3nXGjVRwPLp2+MP80RG8ioEGiOxue45
X-Received: by 10.236.149.230 with SMTP id x66mr764339yhj.24.1402941862270;
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si997320yhk.4.2014.06.16.11.04.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0ACD531C8AA;
	Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 970E1E0961; Mon, 16 Jun 2014 11:04:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251765>

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

Version 17:
 - Rebase ontop of origin/master and resolve the conflicts.
Version 16:
 - Refactor some string code and fix an old old memory leak in recv-pack
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


*** BLURB HERE ***

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
 builtin/receive-pack.c |  97 ++++++----
 builtin/replace.c      |  15 +-
 builtin/tag.c          |  15 +-
 builtin/update-ref.c   |  34 ++--
 cache.h                |   4 +-
 fast-import.c          |  53 ++++--
 lockfile.c             |  39 ++--
 refs.c                 | 507 ++++++++++++++++++++++++++++++++-----------------
 refs.h                 | 128 +++++++++----
 sequencer.c            |  24 ++-
 walker.c               |  58 +++---
 wrapper.c              |  14 +-
 15 files changed, 705 insertions(+), 373 deletions(-)

-- 
2.0.0.282.g3799eda.dirty
