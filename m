From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 0/5] ref-transactions-rename
Date: Wed, 30 Jul 2014 14:52:43 -0700
Message-ID: <1406757168-3729-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 23:53:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCbo6-0005lM-9m
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 23:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbaG3VxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 17:53:03 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:43348 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbaG3Vw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 17:52:56 -0400
Received: by mail-pd0-f202.google.com with SMTP id w10so345785pde.1
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 14:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gRMjipIX5uN4mA9gfrKb7cW0szUvWQWDbpChRp615RQ=;
        b=RaZAAhli4+L74h1atXvGoeFI+OIQW3loO1lSiCItG1VOpe2QEIQVGR3z8SMt45zrnC
         IpVX7bJZSGke5o9DwBCg27d//k2wLlDK5sdTxIbtM7NmH9NUwj8MH9V3+vnOxzLK0ZWn
         xOO+jN0NXwFbrcDXd0F5k5rA+YYZnh8hqMLM/6Dtc2JgRR6udgcmoTzhvgv3W40brJe5
         0i7YNGC8hpaEHBn2M+NneWI+JyuiOjKqWdGwURueJ9vtys4jhf0big3mR1MrayWMGMcv
         FElPhYMf7zomyyqSk4Ib9aKgvdVKsP0d42H/mFRGtfXJ9F8unZfb5l2NKfJ/zlucE/WF
         AMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gRMjipIX5uN4mA9gfrKb7cW0szUvWQWDbpChRp615RQ=;
        b=d4peeHFTUB654NeeVA4duk/Zowrcf7EY14Kf0XFuLw1v8rP7hzHpmQ6YLdQIY9n3/H
         IRoeakqELFFjdCEv6HbdPgU3tXRlwyVCccURGhdqA2xmX459jauz+RbXwU2QtCrFg1pP
         FDp8cGn6+B6Czulm8QTC98N9A+3JEWyRd3W7ru/kzqRRub/7OKeEbZL2NNK750onG5m5
         ZbORxVWLN8FPKIY6vbonJCN7K/oCkplxGJvudFAzPG8SHKnIhKLTOME/9O2bhGry8QT8
         BKNTTjgNg8WLBMwOlzHuw6jek2hQYtx17tjc8Ab2e4Q5Y6Y6MPaLi6ahYs9DPzCMjB3l
         GVjQ==
X-Gm-Message-State: ALoCoQnOKBlgpwRCrV0QLfSEOrvqr39uQEau3t2b/Mxxp7tB57v2DlZuL3vpuJu+zNcXPD14t4oS
X-Received: by 10.66.190.67 with SMTP id go3mr2969897pac.10.1406757175163;
        Wed, 30 Jul 2014 14:52:55 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l23si227060yhg.1.2014.07.30.14.52.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jul 2014 14:52:55 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 231FD31C0AF;
	Wed, 30 Jul 2014 14:52:54 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B21A4E0726; Wed, 30 Jul 2014 14:52:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.523.g0041e8a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254520>


This patch series adds support for using transactions and atomic renames.
It focuses on what needs to be done in order to support fully atomic
and rollbackable renames that may or may not involve name conflicts.

By performing the actual delete old/create new via a single operation to
the packed refs file this process will also appear as an atomic change for
any external observers.

(While this series is "short" it contains a very important change where
we start performing ref changes as operations inside a locked packed refs
file instead of as discreete operations of loose ref files.
This approach will be extended in the next patch series where we will start
using it also to make multi-ref creations/updates become fully
atomic for external observers.)

Version 2:
 -- Updated with Jonathans suggestions from last week.


This series is built on iand depend on the previous reflog series:
  * rs/ref-transaction-reflog (2014-07-23) 15 commits
   - refs.c: allow deleting refs with a broken sha1
   - refs.c: remove lock_any_ref_for_update
   - refs.c: make unlock_ref/close_ref/commit_ref static
   - refs.c: rename log_ref_setup to create_reflog
   - reflog.c: use a reflog transaction when writing during expire
   - refs.c: allow multiple reflog updates during a single transaction
   - refs.c: only write reflog update if msg is non-NULL
   - refs.c: add a flag to allow reflog updates to truncate the log
   - refs.c: add a transaction function to append a reflog entry
   - lockfile.c: make hold_lock_file_for_append preserve meaningful errno
   - refs.c: add a function to append a reflog entry to a fd
   - refs.c: add a new update_type field to ref_update
   - refs.c: rename the transaction functions
   - refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
   - refs.c: make ref_transaction_create a wrapper to ref_transaction_update
   (this branch uses rs/ref-transaction and rs/ref-transaction-1.)



Ronnie Sahlberg (5):
  refs.c: allow passing raw git_committer_info as email to
    _update_reflog
  refs.c: return error instead of dying when locking fails during
    transaction
  refs.c: use packed refs when deleting refs during a transaction
  refs.c: update rename_ref to use a transaction
  refs.c: rollback the lockfile before we die() in repack_without_refs

 builtin/reflog.c  |  19 ++-
 builtin/remote.c  |  14 +-
 refs.c            | 377 ++++++++++++++++++++++++++++++------------------------
 refs.h            |  25 +++-
 t/t3200-branch.sh |   7 -
 5 files changed, 255 insertions(+), 187 deletions(-)

-- 
2.0.1.523.g0041e8a
