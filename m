From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 00/14] ref-transactions-reflog
Date: Mon, 17 Nov 2014 17:35:36 -0800
Message-ID: <1416274550-2827-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:36:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXi8-0000BI-Gg
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbaKRBfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:35:55 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:43890 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156AbaKRBfy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:35:54 -0500
Received: by mail-ie0-f172.google.com with SMTP id ar1so8499930iec.3
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ueJgf0OrocoXNbPxUJLKLHW6j4ovW2DCHLu2Kb8RfNQ=;
        b=dh5RLbD8bdjSx7NDaSlkF16v/fgb5Awj4Wl2eYQ6W5AiWk78LSHYn1oBtaxrny0zMq
         NzTZZhfEk2FBd0/90jYCrZnEwKEqMIl9ueOhug61Zu067oidmLff3r2fGJ7YBoXH7p5y
         +bqBC39T0CfLOegZrGHbBoTpRhKPiS3lKyDWsRJT03ruxh5ewk5cqaRupsPjzwz5ChYK
         iZ7rmt1kH2jVTUpKQQr/EfwAVeOxPo5nc+RHNN2AP+bt2VE7cCHXoN/KbTN/UmmcOt4Y
         Qq8rdxslFic2neRXO3blW1AZT82XBotgrCROgUZqNIYzgRT+yvmjWa5rhmPWMAqWvv0o
         x29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ueJgf0OrocoXNbPxUJLKLHW6j4ovW2DCHLu2Kb8RfNQ=;
        b=KVVlJM7Xf7d9lm/x1T4pdtd5pHTgPDx19xPGMAMoHYOl/lAuwkOl5i2oeHUc/Thszw
         sKZoHLpYXxU7jEXsb/dZI8oqsZZRXzCmGoM2IB+MNOt0fyAfjpNpRBLIIs4jMvYnf+bA
         991Qv+LbzwDkw6aywnYQvy8Ofq5TK5aO3a4tSLq/EqJShr6gaYmkk+uiud3bXV4peFNU
         1cdFaTW4nh2JC9jQaI6B182fNaREqF6veGL8J0W72avrK284F7qTDB0/nkuuw98TUNtz
         80lKD5K/oeEXfxcQRFndJg+NDN6RAK1qRrATiAQneNOsNd6DHnm9yxZ5LDGFGUu+pRmz
         rUJg==
X-Gm-Message-State: ALoCoQmmNYgXbS0+24hsg9NqWyxcbXSxqGi+MVEuDRBZVdj28KwZMhtdpCoF3ltyOfX8giQ5NLK7
X-Received: by 10.107.152.135 with SMTP id a129mr34399426ioe.39.1416274553720;
        Mon, 17 Nov 2014 17:35:53 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id a4sm6863787igx.10.2014.11.17.17.35.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:35:53 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

The following patch series updates the reflog handling to use transactions.
This patch series has previously been sent to the list[1].

This series converts the reflog handling and builtin/reflog.c to use
a transaction for both the ref as well as the reflog updates.
As a side effect of this it simplifies the reflog marshalling code so that we
only have one place where we marshall the entry.
It also means that we can remove several functions from the public api
towards the end of the series since we no longer need those functions.

This series can also be found at github[2] or at googlesource[3].
Feel free to review, where it suits you best.


Version 3:
 * Go over the commit messages and reword them slightly where appropriate.
   (only cosmetics, like missing/double words, spelling, clarify)
 * As Ronnie announced to change employers soon, he'll have only limited 
   time to work on git in the near future. As this is a rather large patch
   series, he is handing this work over to me. That's why I'm sending the
   patches this time.

Thanks,
Stefan

[1] http://www.spinics.net/lists/git/msg241186.html
[2] https://github.com/stefanbeller/git/tree/ref-transactions-reflog
[3] https://code-review.googlesource.com/#/q/topic:ref-transaction-reflog

Ronnie Sahlberg (14):
  refs.c: make ref_transaction_create a wrapper for
    ref_transaction_update
  refs.c: make ref_transaction_delete a wrapper for
    ref_transaction_update
  refs.c: rename the transaction functions
  refs.c: add a function to append a reflog entry to a fd
  refs.c: add a new update_type field to ref_update
  refs.c: add a transaction function to append a reflog entry
  refs.c: add a flag to allow reflog updates to truncate the log
  refs.c: only write reflog update if msg is non-NULL
  refs.c: allow multiple reflog updates during a single transaction
  reflog.c: use a reflog transaction when writing during expire
  refs.c: rename log_ref_setup to create_reflog
  refs.c: Remove unlock_ref/close_ref/commit_ref from the refs api
  refs.c: remove lock_any_ref_for_update
  refs.c: allow deleting refs with a broken sha1

 branch.c                    |  13 +-
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
 fast-import.c               |  22 +--
 refs.c                      | 403 +++++++++++++++++++++++++++++---------------
 refs.h                      |  87 +++++-----
 sequencer.c                 |  12 +-
 t/t1402-check-ref-format.sh |   8 +
 walker.c                    |  10 +-
 17 files changed, 440 insertions(+), 301 deletions(-)

-- 
2.2.0.rc2.5.gf7b9fb2
