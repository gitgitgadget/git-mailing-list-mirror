From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 00/48] Use ref transactions
Date: Tue, 17 Jun 2014 08:53:14 -0700
Message-ID: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:58:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvlr-0008KI-Gn
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933619AbaFQP6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:58:00 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:64409 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756165AbaFQPyF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:05 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so1026713qcz.4
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=N9p2ADTCKxDRhrHF0WyP/Bukyentfunsaj28CVEtqyA=;
        b=H5a9C4k1nV/a9gJNjIG6GAsYNXXJpLYsjKAX3nYJjPZPuVMrobHZp+BL/R/Qag5OtK
         YxuCpve1awqbkcylE/cTTZoUs0YidGJT356i8busdCjjGRtWqz/3c4LiLyGjbwGga8lL
         hSSnWFwyALiov8jGzNWMzJkghzBrcKYQpfkaweK06Fd3mGqqtNojqtYNnEn7soKjJm9c
         ko4HoGVpx7Xcz3qbw3RslCnL7RwUthIchFpWgoqKpEJj9LSJYkSxn5nUWwBp8naEcJZn
         dMsvLBRqTI/x333sJg5I6MUrkv7aLpG6JUD4n8xLx3gvtF8aCU5D6Y9xskF1ZdrppCYd
         yiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=N9p2ADTCKxDRhrHF0WyP/Bukyentfunsaj28CVEtqyA=;
        b=CksD1Uhg3JJjgX0Bc757l7pdPp4lqLHZPWZIEqpGQZ5L3WGtIMpy/UbAEm/wDd7c38
         MQI9sXNzUAoRO/XZc/0+MC2N8B9xLcgdlWuiI2vyR5O6dsrzVQDhnObLLOKDyQkVz14z
         8kB9OTiL7yD7TiMRGgKX4UcXCx61gckffcmSRoejOEpd0Asbc/gj59qt0+bDkgOMi6dv
         CZt+caoEr2nRtH1eihOa+Yxjh53++PG9z1RrdwtRZm6GqxEQi/FSJHxh2YiP+SOU0vt8
         lEpLMmfLSaeypfsIGm8cQF6o9a9Xj+/haYutA0MXb9lP+7W8vzSRbLHuX62HaIB0gE9m
         YAfw==
X-Gm-Message-State: ALoCoQlOlnr2wOhVxrT/oZuALzRTTdLy2VRZuOl+9mGmy5x4S341lLx/r+oU/ywgIRhw6Y7DZHwo
X-Received: by 10.58.37.164 with SMTP id z4mr123079vej.28.1403020444261;
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si1209150yhb.3.2014.06.17.08.54.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 10E0431C76B;
	Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A99CAE0FBE; Tue, 17 Jun 2014 08:54:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251913>

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

Version 18:
 - rebase ontop of current master, as of 201406170851
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
 builtin/remote.c       |   5 +-
 builtin/replace.c      |  17 +-
 builtin/tag.c          |  15 +-
 builtin/update-ref.c   |  34 ++--
 cache.h                |   4 +-
 fast-import.c          |  55 ++++--
 lockfile.c             |  39 ++--
 refs.c                 | 506 ++++++++++++++++++++++++++++++++-----------------
 refs.h                 | 131 +++++++++----
 sequencer.c            |  24 ++-
 walker.c               |  58 +++---
 wrapper.c              |  14 +-
 16 files changed, 711 insertions(+), 378 deletions(-)

-- 
2.0.0.438.gec92e5c
