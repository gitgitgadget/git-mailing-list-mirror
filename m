From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 00/14] ref-transactions-reflog
Date: Mon, 16 Jun 2014 09:51:31 -0700
Message-ID: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 18:53:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwa9k-0003n8-4q
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 18:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbaFPQxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 12:53:07 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:49990 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248AbaFPQvt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 12:51:49 -0400
Received: by mail-pd0-f201.google.com with SMTP id v10so418942pde.2
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Nyn+hy7gHvdUlLxxAHxiWI/snC2IOT4jJ9IQQWPVOSU=;
        b=XfUpOhzfbqir9OUSHEgSoCt6g0iImu7dbNgbM92LzHzxZS0iUcSeipLriwAyKcX79Y
         tgHDyS5E+SBqPJ37Eq5WMp9tR6l6eObfmupDLex/sztnHxhI9rP4yhIsAXdvNc6IR531
         7qCtxezpk2cHIguURefAluad3CWZarMbBaMHm+2u9XHk++0/VIlJofFkWgf4yGwtxGlX
         as7uqYMcQlf2tBYtFI7ykNSdwOwkxDdwdaVc7tfaqVt1Cjs8XbsHraa8WmfoWmdIPLHC
         UKuEG0Nqo14A66nIF3KtEFeG9aUTXkPsTTm/xFWiiRRtRNvKTnMsKVLHMT+uUABNuQ1y
         zW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Nyn+hy7gHvdUlLxxAHxiWI/snC2IOT4jJ9IQQWPVOSU=;
        b=aRl0bXvp1uG+DkogUtjnHX2gIvMARE+g3yyx96ft0CDlC6bUeI4/EytySRXsvRuYIj
         NVJNlWCQqnLqYJfVNd9iFkchO/0Wx4T48p+6dXkUef2J3bI5DUIXZDNcS74xLIR3Dhzf
         r17PioltXguQwTAOINYocIwGEB9JAptlp6FS+1G9XKnxCHYtR7qy2f45xOiHusEYaW0r
         oJT40kh0YerJWG6dnNUXBvLkFT7qnb70uEGWIRWUKzDyoanZxVW9k2DNmwIUwPoZwsPQ
         +2algtP88+oPKUjUBDbnROwrCl7nDV5K9yam6xWorcqxu4IOU8xAHexmSfAAN5iZ3hHj
         419w==
X-Gm-Message-State: ALoCoQkF9S9DKWiESQw4sGxLoX9n89XPUMrCBPa9zLFO+9QMXWjd4/sStcEo19DslGNp/DuQpEE1
X-Received: by 10.66.138.17 with SMTP id qm17mr772208pab.34.1402937509345;
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si983795yhb.3.2014.06.16.09.51.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 27A9D5A461A;
	Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BAEEDE09C2; Mon, 16 Jun 2014 09:51:48 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.770.gd892650.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251734>

This patch series builds on the ref-transactions series added to origin/pu.
It adds support for updating the reflog during a transaction and changes
builtin/reflog.c to use a transaction.
With this series in place we now have only one single place where we
write reflog entries and only two places where we read and parse the entries
(the two interators).

This is version 2 of the series and is mainly rebased and tweaked to apply
ontop of origin/pu and all the changes/conflicts between it and the previous
base.

Ronnie Sahlberg (14):
  refs.c make ref_transaction_create a wrapper to ref_transaction_update
  refs.c: make ref_transaction_delete a wrapper for
    ref_transaction_update
  refs.c: rename the transaction functions
  refs.c: add a new update_type field to ref_update
  refs.c: add a function to append a reflog entry to a fd
  lockfile.c: make hold_lock_file_for_append preserve meaningful errno
  refs.c: add a transaction function to append a reflog entry
  refs.c: add a flag to allow reflog updates to truncate the log
  refs.c: only write reflog update if msg is non-NULL
  refs.c: allow multiple reflog updates during a single transaction
  reflog.c: use a reflog transaction when writing during expire
  refs.c: rename log_ref_setup to create_reflog
  refs.c: make unlock_ref/close_ref/commit_ref static
  refs.c: remove lock_any_ref_for_update

 branch.c               |  11 +-
 builtin/checkout.c     |   8 +-
 builtin/commit.c       |  14 +-
 builtin/fetch.c        |  12 +-
 builtin/receive-pack.c |  14 +-
 builtin/reflog.c       |  85 +++++-----
 builtin/replace.c      |  10 +-
 builtin/tag.c          |  10 +-
 builtin/update-ref.c   |  22 +--
 copy.c                 |  20 ++-
 fast-import.c          |  22 +--
 lockfile.c             |   7 +-
 refs.c                 | 428 +++++++++++++++++++++++++++++++++----------------
 refs.h                 | 109 +++++++------
 sequencer.c            |  12 +-
 walker.c               |  16 +-
 16 files changed, 475 insertions(+), 325 deletions(-)

-- 
2.0.0.770.gd892650.dirty
