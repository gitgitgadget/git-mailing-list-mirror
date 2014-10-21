From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 00/15] ref-transactions-reflog
Date: Tue, 21 Oct 2014 12:24:07 -0700
Message-ID: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 21:24:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgf38-0000PF-Aj
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 21:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbaJUTYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 15:24:36 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:64163 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060AbaJUTYf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 15:24:35 -0400
Received: by mail-pa0-f74.google.com with SMTP id kq14so336957pab.5
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Ds5uRBU9DOqSvPZo/iy+PS42yCghuFBIl0v+qULsMvM=;
        b=HOCwiK8qaxVACtAVZSUXlF9XDWYlohptGRLgkH8/JF35wAurzOvl6WYyfK6Jj2WW/F
         GxlpcJdFpEi4GYHeVmPyJsbWW+RnfjLkRrbQz3OcugWYGxDm71bG9sVbnuXj93IRk1TJ
         3K2amhSB+4qSjxsLSefOpxJCrRafpUfOIx/QeCi5K/UATUg6C0vwupWlq6VwrDX1OedA
         9dY0I1jr3aWQH5ksnwO4mEKgaCiOa2AYuGtB1C9KDz5zJfN6McLEmNcYYXGXakXYDLiV
         wSH5PmyYf6EzwnFZ6+tICz2QTjIuQdJHXhVzu764lnQOz8taWdrMJWKNUJuqsKqNimE5
         LtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ds5uRBU9DOqSvPZo/iy+PS42yCghuFBIl0v+qULsMvM=;
        b=DnbDE3vecnxd2+/Uywx4DquB9SN2x8GUGT39sQxZ+bLXLDz0kMNS+efBdePfTjerWF
         540yuYlxGPmhCLkb/1aQcNPh+PnBeLjld3DVz6xQQ2MfaEbMbhr7IY5LKx0x7qixUlvI
         Wqu4oh0g+7MuoBgxTNexujch3uxuIhZ50UTUgaxDB84WuKMf+2YJNZOSQmsSGkUEF2pQ
         WLrpN/Myp0XJCOZpB9yrtR4j0y7ryrH8zJbIVFv0TAhg+vDhQMllXPRPIji7pd1tsu07
         I6V3iAQDKx8xD3sVmNTuCpVwnS2Tq5SNBHyKoN2W+T5v0hoZkeUfzfNUbkjmcjf+NfHK
         o9UA==
X-Gm-Message-State: ALoCoQlk3XEHD67b4OcCX2QuHaSt+uGP14lvcjm+w2LT37J/FneUzkTmxQKLYUMXO0fi7NcKqxoL
X-Received: by 10.67.5.33 with SMTP id cj1mr18657760pad.39.1413919474693;
        Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id k66si582817yho.7.2014.10.21.12.24.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id O2AvinNw.1; Tue, 21 Oct 2014 12:24:34 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E9A2EE0BD6; Tue, 21 Oct 2014 12:24:33 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.728.g406752a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

List,

Please find a patch that updates the reflog handling to use transactions.
This patch series has previously been sent to the list but is now rebased on
the current content of next which contains ref changes we depend on in this
series.

This series converts the reflog handling and builtin/reflog.c to use
a transaction for both the ref as well as the reflog updates.
As a side effect of this it simplifies the reflog marshalling code so that we
only have one place where we marshall the entry.
It also means that we can remove several functions from the public api
towards the end of the series since we no longer need those functions.

This series can also be found at
https://github.com/rsahlberg/git/tree/ref-transactions-reflog

Ronnie Sahlberg (15):
  refs.c make ref_transaction_create a wrapper to ref_transaction_update
  refs.c: make ref_transaction_delete a wrapper for
    ref_transaction_update
  refs.c: rename the transaction functions
  refs.c: add a new update_type field to ref_update
  refs.c: add a function to append a reflog entry to a fd
  copy.c: make copy_fd preserve meaningful errno
  refs.c: add a transaction function to append a reflog entry
  refs.c: add a flag to allow reflog updates to truncate the log
  refs.c: only write reflog update if msg is non-NULL
  refs.c: allow multiple reflog updates during a single transaction
  reflog.c: use a reflog transaction when writing during expire
  refs.c: rename log_ref_setup to create_reflog
  refs.c: make unlock_ref/close_ref/commit_ref static
  refs.c: remove lock_any_ref_for_update
  refs.c: allow deleting refs with a broken sha1

 branch.c                    |  14 +-
 builtin/branch.c            |   5 +-
 builtin/checkout.c          |   8 +-
 builtin/commit.c            |  10 +-
 builtin/fetch.c             |  12 +-
 builtin/receive-pack.c      |  13 +-
 builtin/reflog.c            |  85 ++++------
 builtin/replace.c           |  10 +-
 builtin/tag.c               |  10 +-
 builtin/update-ref.c        |  26 +--
 cache.h                     |   7 +
 copy.c                      |  15 +-
 fast-import.c               |  22 +--
 refs.c                      | 401 +++++++++++++++++++++++++++++---------------
 refs.h                      |  87 +++++-----
 sequencer.c                 |  12 +-
 t/t1402-check-ref-format.sh |   8 +
 walker.c                    |  10 +-
 18 files changed, 448 insertions(+), 307 deletions(-)

-- 
2.1.0.rc2.206.gedb03e5
