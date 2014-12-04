From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 00/13] the refs-transactions-reflog series
Date: Thu,  4 Dec 2014 00:29:10 -0800
Message-ID: <1417681763-32334-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 04 09:29:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwRn7-0005bi-O0
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 09:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbaLDI3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 03:29:33 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:61279 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbaLDI3c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 03:29:32 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so15282422iec.22
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 00:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=7bW5L3ZfKfc9xBjv7FgqCxcjpNcpNuhjuvtDuO0hOJA=;
        b=AG7RQObwYNGI9E3mavr6oKR2anMUfjIOYG9JLWLTpMDU+BZlp/xaAWcG5F8fhDtJz9
         5W2Ka6DWRkHUp2PyivwRPRY2OAz6hUGHqhMOZOIfSx+E1POBnEAB8CSsDEAF1MarrH7h
         /iAzZmz9pCVc0MsKHWzzqam0SuTZdWc63gUFj50RbC1HxUl+8w35/IdHqm7kEGUyRNzG
         PcYjozyomYjk5rn21hcgwnnqDfh4okDPzaNeChkTFZD//tVqzSrL/EgxZ0fg9Kyjs3XH
         jOg2GCLS3GwL+Ss0wAywWCWsDyfiyhQnRTTytwcd8tp5YesJdAyjCnWqCwaMJuIInGD8
         UhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7bW5L3ZfKfc9xBjv7FgqCxcjpNcpNuhjuvtDuO0hOJA=;
        b=fBx1pxa1hhtO0YSsRJW5kFt9AOBzCjGc84Idlzh5/5D64CZfVAkbXRG2JGDFWzfba3
         zgTWyG9COrUoPiVLg/QDOnIaEYh/jPJbEAhco7nOBkZ714Sj5X7bRiuldIM+dXFmKnuK
         /0cLv9PESgK52l0htbEU5WH1EfaxLSjAg8vnFQsr9p+XkFpNPjw8UlLWvk3jbHeQ5I4r
         hV09+CE5d5VL9YNE5mXs7U97TNGBwMJ0e5vUehO41EzRBRNEf0OACaH0UkrbRABCquk+
         N9alZgOg9tWXR70RfM34wmGQL6zUnm7Qcjv0+IrUVj3aFWKEAgRbZQgpKLyCOUb7denD
         gaxA==
X-Gm-Message-State: ALoCoQl7kCNvA3xuceyOnhQQ275Lk0j5ZnEFeMrz7JN8ITzstM43BoJxoj6Zu5+w71uL4NpafbFE
X-Received: by 10.43.89.68 with SMTP id bd4mr10182786icc.63.1417681771780;
        Thu, 04 Dec 2014 00:29:31 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5d2c:9a2d:3064:bc4])
        by mx.google.com with ESMTPSA id j2sm14932572igj.14.2014.12.04.00.29.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 00:29:31 -0800 (PST)
X-Mailer: git-send-email 2.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260731>

This is the whole refs-transactions-reflog series[1],
which was in discussion for a bit already. It applies to origin/master.

The idea is to have the reflog being part of the transactions, which
the refs are already using, so the we're moving towards a database
like API in the long run. This makes git easier to maintain as well
as opening the possibility to replace the backend with a real database.

If you've followed the topic a bit, start reading at patch
"[PATCH 06/13] refs.c: add a transaction function to append a reflog"
as the first 5 patches have been discussed a lot separately and can be found in
origin/pu already[2].
The first two patches are deduplicating code.
The third patch is ripping some code out of log_ref_write and introduces
log_ref_write_fd, which does the actual writing.
The patches 4+5 are renaming variables for clarity.

The patch 6 and 7 are the entree in this series. Patch 6 adds two functions to
the refs API: transaction_truncate_reflog and transaction_update_reflog. Both
functions do not affect the files directy, but rather become effective once
transaction_commit function is called. The transaction_truncate_reflog will
wipe the reflog, which can be used for rebuilding the reflog, whereas the
transaction_update_reflog function will just append one entry to the reflog.
The patch 7 will make use of the functions introduced in patch 6. The command
git reflog expire will then use the reflog transactions.

Patch 8 is renaming log_ref_setup to create_reflog and should not

Patches 9-12 are removing functions from the public refs API, which are unused then.

Patch 13 is adding new functionality again, you can finally delete broken refs without
having to know the details on git.

[1] http://comments.gmane.org/gmane.comp.version-control.git/259712 or
    http://www.spinics.net/lists/git/msg242502.html 

[2] patch 1 + 2:
        origin/sb/ref-transaction-unify-to-update
    patch 3:
        origin/sb/log-ref-write-fd
    patch 4 + 5:
        origin/sb/ref-transaction-reflog
    patch 1-5 is unchanged in this series.


Ronnie Sahlberg (9):
  refs.c: make ref_transaction_create a wrapper for
    ref_transaction_update
  refs.c: make ref_transaction_delete a wrapper for
    ref_transaction_update
  refs.c: add a function to append a reflog entry to a fd
  refs.c: rename the transaction functions
  reflog.c: use a reflog transaction when writing during expire
  refs.c: rename log_ref_setup to create_reflog
  refs.c: remove unlock_ref/close_ref/commit_ref from the refs api
  refs.c: remove lock_any_ref_for_update
  refs.c: allow deleting refs with a broken sha1

Stefan Beller (4):
  refs.c: rename transaction.updates to transaction.ref_updates
  refs.c: add a transaction function to truncate or append a reflog
    entry
  refs.c: don't expose the internal struct ref_lock in the header file
  refs.c: use a bit for ref_update have_old

 branch.c               |  13 +-
 builtin/branch.c       |   5 +-
 builtin/checkout.c     |   8 +-
 builtin/commit.c       |  10 +-
 builtin/fetch.c        |  12 +-
 builtin/receive-pack.c |  13 +-
 builtin/reflog.c       |  84 +++++------
 builtin/replace.c      |  10 +-
 builtin/tag.c          |  10 +-
 builtin/update-ref.c   |  26 ++--
 cache.h                |   7 +
 fast-import.c          |  22 +--
 refs.c                 | 371 +++++++++++++++++++++++++++++++------------------
 refs.h                 |  95 ++++++-------
 sequencer.c            |  12 +-
 t/t3200-branch.sh      |   8 ++
 walker.c               |  10 +-
 17 files changed, 408 insertions(+), 308 deletions(-)

-- 
2.2.0
