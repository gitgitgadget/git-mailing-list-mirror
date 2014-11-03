From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 00/15] ref-transactions-reflog
Date: Mon,  3 Nov 2014 08:55:42 -0800
Message-ID: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 17:59:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlKyd-0003Rr-QU
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 17:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbaKCQ7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 11:59:17 -0500
Received: from mail-oi0-f73.google.com ([209.85.218.73]:49777 "EHLO
	mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbaKCQ4D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 11:56:03 -0500
Received: by mail-oi0-f73.google.com with SMTP id e131so1668078oig.0
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 08:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=lx9tXwF80U93PuvvevbNj6wHBOGQYl8HiTx5g2mov4s=;
        b=g95jmyLyG9DTpvAPs3t/bJqodoG4KXXWfFn4FvTAKG8JEOCsR7KHay2gKSQSCBrioF
         L7qT6lnU3KMpwx0mw9UUFiKDwEj5Xcn26uQr7iS/p99DZphkxykUwRx0E8F1wLLi83TN
         pvWed9hl7DjQmaAl9hzA/qhxj/D+Uadk6BK+zXw0xSNOuX+W4/Kwjojimj6VC4XiOJ1C
         lmY3LlLu/o0gmDj3Kba+B+ZxVpKcDmXKPYP9mNXoMEAP7URIA61sE+KOBX0rpjq0LfHO
         rWMzSEM3GAYXk8RByPUpRsK/YbYaT9d2ib7XlEcg4ZE7FyE1YhShgyowh9JQf4zTpZLO
         XUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lx9tXwF80U93PuvvevbNj6wHBOGQYl8HiTx5g2mov4s=;
        b=mkv/6uiVX5XXigM//glSZ5uNDbVXggA0iRvri9GeWKc0e6shFs7YkXRmxBNbIplgc4
         yu4S7j2MkLvJBCFiVPEO90Wr+HekAxUT14apQibx7LOumBnBMjUpyL7mHo7QpmQaWSuJ
         GQKrnV+1JgBgbztjspdFReagZnXNQfxoCORi1A7ewm12HK/SitVZduxcOTJ9FUSSg9FL
         umDfSu6Xeg+7JYfEB+suXWRetdCYKh7JzOx+ppZl0UPxg3k8JT28loPTTTKWM0zomlnX
         a6f37VbXNrKBiGuU2hANXEBKhPnTpQagLbO4DZSGZMHleXEcBhYsZz8C8iWBDpg7i6Q5
         lvuw==
X-Gm-Message-State: ALoCoQlhy06w+LEV/+2bAdOt6vw6jnJG7ka7BXEEtT7NvCj58k/ZMI05eUmpsx6GwaJOCW7ExJL9
X-Received: by 10.43.104.66 with SMTP id dl2mr21861901icc.9.1415033762672;
        Mon, 03 Nov 2014 08:56:02 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id s23si959283yhf.0.2014.11.03.08.56.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 08:56:02 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id t5oTJsEs.1; Mon, 03 Nov 2014 08:56:02 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DA44BE0D1C; Mon,  3 Nov 2014 08:56:01 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
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

Version 2:
- Clarify the commit message to refs.c: only write reflog update if msg is
  non-NULL to highlight that msg==NULL and REFLOG_TRUNCATE control othogonal
  features.
- Improve the comments for the transaction flags field in refs.c: allow
  multiple reflog updates during a single transaction.


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
 refs.c                      | 403 +++++++++++++++++++++++++++++---------------
 refs.h                      |  87 +++++-----
 sequencer.c                 |  12 +-
 t/t1402-check-ref-format.sh |   8 +
 walker.c                    |  10 +-
 18 files changed, 450 insertions(+), 307 deletions(-)

-- 
2.1.0.rc2.206.gedb03e5
