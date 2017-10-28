Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D575202A0
	for <e@80x24.org>; Sat, 28 Oct 2017 09:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbdJ1JuD (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 05:50:03 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:47161 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750930AbdJ1JuC (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2017 05:50:02 -0400
X-AuditID: 12074413-3a3ff70000007929-18-59f452c9c4d8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 04.47.31017.9C254F95; Sat, 28 Oct 2017 05:50:01 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE7F1.dip0.t-ipconnect.de [84.170.231.241])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9S9nwqV016802
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 28 Oct 2017 05:50:00 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/7] Tidy up the constants related to ref_update::flags
Date:   Sat, 28 Oct 2017 11:49:49 +0200
Message-Id: <cover.1509183413.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsUixO6iqHsy6EukweYFKhZdV7qZLBp6rzBb
        3F4xn9nizJtGRgcWj7/vPzB5XLyk7LH4gZfH501yASxRXDYpqTmZZalF+nYJXBknfkxmLPgl
        ULFtxkrGBsapvF2MnBwSAiYS90+dYu1i5OIQEtjBJNHz9yM7SEJI4BSTxOQjiSA2m4CuxKKe
        ZiYQW0RATWJi2yEWEJtZoEji6/qzYHFhAXeJNRO2MIPYLAKqEjs2/Aar4RUwl9jXsIMFYpm8
        xLkHt5knMHItYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrrpebWaKXmlK6iRHic+EdjLtO
        yh1iFOBgVOLhlcj9HCnEmlhWXJl7iFGSg0lJlHff+U+RQnxJ+SmVGYnFGfFFpTmpxYcYJTiY
        lUR4L/p8iRTiTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnwBgUCNQoW
        paanVqRl5pQgpJk4OEGG8wANbwSp4S0uSMwtzkyHyJ9iNObouHn3DxPHs5mvG5iFWPLy81Kl
        xHlfgJQKgJRmlObBTYPF7StGcaDnhHlng1TxAGMebt4roFVMQKs0JMFWlSQipKQaGItWxMq5
        JXX+PsJ2+6Iv/1+PGScn3rO9+GKxav/Ktkf+a1dsKYw6fuN5/iO3PZYR70z4Y9drClydeItb
        5ZWoxIUDa1SWneL1uiWzvp73DdN9j0UGkrfKTp6ZtOev4dSzHmYm7z/xv3KzNs/o7pMTVFtT
        8O1fsWGgwMc25yvs+xfIHLwg9jLip78SS3FGoqEWc1FxIgCiY1UTtgIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nothing earth-shattering here; just cleaning up some internal details
that have bothered me for a while:

* Make it clearer which flag values the packed backend might confront.

* Reduce the visibility of the constants that are only relevant to the
  files backend. The most notable of these is `REF_ISPRUNING`, which
  previously was special-cased in
  `REF_TRANSACTION_UPDATE_ALLOWED_FLAGS` even though it shouldn't be
  used by callers outside of the refs module.

* Die (rather then silently ignoring) if any disallowed flags are
  passed to `ref_transaction_update()` or friends.

* Rename `REF_NODEREF` to `REF_NO_DEREF` (otherwise it's easy to read
  as `REF_NODE_REF`!)

* Rename `REF_ISPRUNING` to `REF_IS_PRUNING`.

* Make the constants' numerical values correspond to their order.

* Improve a lot of docstrings.

This patch series depends on `bc/object-id`, mostly so that the
comments can talk about OIDs rather than SHA-1s.

These patches are also available as branch `tidy-ref-update-flags`
from my GitHub fork [1].

Michael

[1] https://github.com/mhagger/git

Michael Haggerty (7):
  files_transaction_prepare(): don't leak flags to packed transaction
  prune_ref(): call `ref_transaction_add_update()` directly
  ref_transaction_update(): die on disallowed flags
  ref_transaction_add_update(): remove a check
  refs: tidy up and adjust visibility of the `ref_update` flags
  refs: rename constant `REF_NODEREF` to `REF_NO_DEREF`
  refs: rename constant `REF_ISPRUNING` to `REF_IS_PRUNING`

 builtin/am.c           |   2 +-
 builtin/branch.c       |   2 +-
 builtin/checkout.c     |   2 +-
 builtin/clone.c        |   4 +-
 builtin/notes.c        |   2 +-
 builtin/remote.c       |   6 +--
 builtin/symbolic-ref.c |   2 +-
 builtin/update-ref.c   |   4 +-
 refs.c                 |   6 +--
 refs.h                 |  67 ++++++++++++++++-------------
 refs/files-backend.c   | 113 +++++++++++++++++++++++++++++++++++++------------
 refs/refs-internal.h   |  67 +++++++----------------------
 sequencer.c            |   6 +--
 13 files changed, 155 insertions(+), 128 deletions(-)

-- 
2.14.1

