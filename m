Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA47B202A0
	for <e@80x24.org>; Sat, 28 Oct 2017 09:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbdJ1JQP (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 05:16:15 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:46212 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751268AbdJ1JQM (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2017 05:16:12 -0400
X-AuditID: 1207440c-7fdff7000000143e-69-59f44ad936b9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id C0.4E.05182.9DA44F95; Sat, 28 Oct 2017 05:16:10 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE7F1.dip0.t-ipconnect.de [84.170.231.241])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9S9G5TE015456
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 28 Oct 2017 05:16:07 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/2] Avoid rewriting "packed-refs" unnecessarily
Date:   Sat, 28 Oct 2017 11:16:00 +0200
Message-Id: <cover.1509181545.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsUixO6iqHvL60ukwbQ2SYuuK91MFg29V5gt
        bq+Yz2zxo6WH2eLMm0ZGB1aPv+8/MHk8693D6HHxkrLH4gdeHp83yQWwRnHZpKTmZJalFunb
        JXBlvJx5i63gI1dF8/3/zA2Mrzi6GDk4JARMJBacMeti5OIQEtjBJLH7znV2COcUk8TxVy/Z
        uhg5OdgEdCUW9TQzgdgiAmoSE9sOsYAUMQv0Mko8WvyKESQhLOAsMfP7ShYQm0VAVWLro+3M
        IDavgLnEmdOX2UFsCQF5iXMPbjNPYORawMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXUC83
        s0QvNaV0EyMkEHh2MH5bJ3OIUYCDUYmHVzL3c6QQa2JZcWXuIUZJDiYlUd595z9FCvEl5adU
        ZiQWZ8QXleakFh9ilOBgVhLhzXP+EinEm5JYWZValA+TkuZgURLnVV2i7ickkJ5YkpqdmlqQ
        WgSTleHgUJLg5QUGvJBgUWp6akVaZk4JQpqJgxNkOA/Q8N+eIMOLCxJzizPTIfKnGI05Om7e
        /cPE8Wzm6wZmIZa8/LxUKXHevSClAiClGaV5cNNg0fyKURzoOWHeqyBVPMBEADfvFdAqJqBV
        GpJgq0oSEVJSDYwZnp0ZTwIi+b61R19at1BPxWaH1enwf20slkGuRTXB/SfdC6V5Q2fs1JmX
        75k62VSYbZLgPhPOn76vpIL0rqbXbOL+eWB7/cf/Tzvszmw6czL2ekWpd92Fyj8ZOtX3l6lc
        6WOKUbHnmBKTXXQgpzGpIeeNjKL5vFsftgaI35y4+8aRT7XKZ5VYijMSDbWYi4oTASmaeZ7B
        AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reroll make some logically small changes to v1 [1] that are
textually very big:

* Invert the sense of `is_packed_transaction_noop()` and rename it to
  `is_packed_transaction_needed()`. This makes the logic easier to
  follow and document.

* Add a big comment to that function, describing the cases when it
  returns false positives and explaining why that isn't a problem.

* In the commit message for patch 02, gives a lot more information
  about the regression that it is fixing. Thanks to Eric for the
  suggestion.

These patches are also available as branch
`avoid-rewriting-packed-refs` on my GitHub fork [2]. They now use
`mh/packed-ref-transactions` as the base, since that is where Junio
chose to apply v1.

Michael

[1] https://public-inbox.org/git/cover.1508924577.git.mhagger@alum.mit.edu/
[2] https://github.com/mhagger/git

Michael Haggerty (2):
  t1409: check that `packed-refs` is not rewritten unnecessarily
  files-backend: don't rewrite the `packed-refs` file unnecessarily

 refs/files-backend.c          |  18 ++++++-
 refs/packed-backend.c         |  94 +++++++++++++++++++++++++++++++++
 refs/packed-backend.h         |   9 ++++
 t/t1409-avoid-packing-refs.sh | 118 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 238 insertions(+), 1 deletion(-)
 create mode 100755 t/t1409-avoid-packing-refs.sh

-- 
2.14.1

