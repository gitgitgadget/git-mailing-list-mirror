From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 00/48] Use ref transactions
Date: Fri, 20 Jun 2014 07:42:41 -0700
Message-ID: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:43:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy02V-0000uF-F8
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbaFTOnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:43:35 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:41768 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbaFTOnc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:32 -0400
Received: by mail-ob0-f201.google.com with SMTP id nu7so192230obb.0
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=+mWPraAZ5bI4vd9HcIa4XETduvyFXVLyhR+rzlaWMhY=;
        b=o6OAU+lgAljBABSWDu/vuZaIXsLAzjoPjQvTm6ko+cJAVtLe2T37L6njf/hpe8Kyx1
         TV+TyNS2Ilp4ETVhVfvaXLE4GLdtV5Fz2JNv+nPqD4h1Ps8kUaeig10JiNpfZCqtrKID
         SzU4jUSqvMhtjMnDOm5+Vad2ls7ue15HTJOPIZtPYjPMEhkDvgskmAFxYGxNXwayoddo
         48WsK0BzXp/nHgprBPUvfk8XTFkj6ryNf6WJEaD+4YG+2OiplCnvJo1bf4WEgUQLtscc
         Tyx0Gsk77zSVvHzDxAszc9LesqSedH6+GK2bKGQPwa7InzHOgeFYmXx/J6u6EdRffz7s
         5n0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=+mWPraAZ5bI4vd9HcIa4XETduvyFXVLyhR+rzlaWMhY=;
        b=WLiwaPd7LxR2UUQzM+K3KilvnmS+Q4vSa+XAsQLusNSVOZqJGfn0NPV/jRWL3P1tYD
         lM+k+CdJK239IV1bgVsyQ8Lr+3AlE8Oz2lf1tn3e5k+EPgFDelunQbERwY7aVFfupKeA
         +cST8C5dQmds9MdMOW5wXgITbtUE3518RZgpLNWZ3wwI55WtjbdTKOMKhnikZg5HdVaa
         7J3+9+3N983lKGj8fv1k/p/8Tqn/WGbTLJEsqmgXB3W3jj7Wp/vVXQigAOQfUDtaWau9
         bE8ufOLImKK0uGU1tT9t0aohbWGeBtQP42LgFFLX+tbzMvvYIonKYaFHm+Y0i+HWn5rj
         Vmwg==
X-Gm-Message-State: ALoCoQlnjfSgXys7cOQFGUuerbMeH83jst86bnTrAfzzjEjfGboZMDA1iBxoRHUe2x9WRFOK9+GZ
X-Received: by 10.182.87.3 with SMTP id t3mr1547011obz.20.1403275412022;
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j43si432416yhh.5.2014.06.20.07.43.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B968831C6B1;
	Fri, 20 Jun 2014 07:43:31 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4CBE4E0873; Fri, 20 Jun 2014 07:43:31 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252226>

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

Version 20:
 - Whitespace and style changes suggested by Jun.


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
 builtin/replace.c      |  15 +-
 builtin/tag.c          |  15 +-
 builtin/update-ref.c   |  34 ++--
 cache.h                |   4 +-
 fast-import.c          |  53 ++++--
 lockfile.c             |  39 ++--
 refs.c                 | 506 ++++++++++++++++++++++++++++++++-----------------
 refs.h                 | 131 +++++++++----
 sequencer.c            |  24 ++-
 walker.c               |  58 +++---
 wrapper.c              |  14 +-
 16 files changed, 710 insertions(+), 375 deletions(-)

-- 
2.0.0.420.g181e020.dirty
