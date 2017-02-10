Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D35641FAF4
	for <e@80x24.org>; Fri, 10 Feb 2017 11:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752895AbdBJLQh (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 06:16:37 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:57449 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752581AbdBJLQg (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Feb 2017 06:16:36 -0500
X-AuditID: 1207440f-d5fff700000009a2-70-589da108e8ad
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id CC.2C.02466.801AD985; Fri, 10 Feb 2017 06:16:24 -0500 (EST)
Received: from bagpipes.fritz.box (p57906495.dip0.t-ipconnect.de [87.144.100.149])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1ABGLLd025185
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 10 Feb 2017 06:16:22 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/9] Store submodules in a hash, not a linked list
Date:   Fri, 10 Feb 2017 12:16:10 +0100
Message-Id: <cover.1486724698.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsUixO6iqMuxcG6EwcXrKhZdV7qZLBp6rzBb
        9C/vYrO4vWI+s8WSh6+ZLbqnvGW0+NHSw2yxeXM7iwOHx9/3H5g8ds66y+7x4WOcx4JNpR5d
        7UfYPJ717mH0uHhJ2ePzJrkAjigum5TUnMyy1CJ9uwSujAtvprMUHBCsOHl+ClMD43y+LkZO
        DgkBE4mJ3W2MXYxcHEIClxkltjx+ywLhnGKSeLXjLgtIFZuArsSinmYmEFtEQE1iYtshsDgz
        SNG5BWBxYQFXiTnLt7GB2CwCqhJzt64Cq+EVMJc4tu4dC8Q2OYlL274wT2DkWsDIsIpRLjGn
        NFc3NzEzpzg1Wbc4OTEvL7VI10QvN7NELzWldBMjJIT4dzB2rZc5xCjAwajEw/uiZk6EEGti
        WXFl7iFGSQ4mJVHe7zPmRgjxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4bXpAMrxpiRWVqUW5cOk
        pDlYlMR51Zeo+wkJpCeWpGanphakFsFkZTg4lCR4GRYANQoWpaanVqRl5pQgpJk4OEGG8wAN
        dwSp4S0uSMwtzkyHyJ9iVJQS562bD5QQAElklObB9cJi/BWjONArwryBIO08wPQA1/0KaDAT
        0ODrp2eBDC5JREhJNTCW2+bvd4mP4hVPrSu3ObfzzSbuuwfnHUk9KhRs+kB3bRkrd8vER19e
        PbkX8vTcTMXONPebbyRc1mRvvtaf2B/Ev9DrjPAutr6EZXEyK47O/8Ne6fRgKvudnHmeb3mX
        +4SJzdP4eqPkjuc7S//LR40yNB+5u7Ee8Y3NvVppqSlQ32S4dcK769+VWIozEg21mIuKEwHA
        1fg8zAIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v2 of the patch series, considerably reorganized but not that
different codewise. Thanks to Stefan, Junio, and Peff for their
feedback about v1 [1]. I think I have addressed all of your comments.

Changes since v1:

* Rebase from `master` onto `maint` (to match Junio).

* Reorder some commits to make the presentation more logical.

* Added an explicit preparatory commit that just reorders some
  function definitions, because it makes the diff for the subsequent
  commit a lot easier to read.

* Make some preexisting functions private:
  * lookup_ref_store()
  * ref_store_init()

* Remove some unnecessary handling of `submodule == ""` when it is
  already known to have been converted to `NULL`. (Some of the
  purported handling also happened to be broken.)

* Introduce function `register_ref_store()` in a separate step, before
  switching to hashmaps.

* Don't initialize hashmap in `lookup_ref_store()`. (Just return
  `NULL`; the hashmap will be initialized in `register_ref_store()` a
  moment later.)

* Make code in `submodule_hash_cmp()` clearer.

* Use `FLEX_ALLOC_STR()` in `alloc_submodule_hash_entry()`.

* Don't specify an initial size for the submodule hashmap (the default
  is OK).

This patch series is also available from my fork on GitHub [2] as
branch "submodule-hash".

Michael

[1] http://public-inbox.org/git/cover.1486629195.git.mhagger@alum.mit.edu/T/#u
[2] https://github.com/mhagger/git

Michael Haggerty (9):
  refs: reorder some function definitions
  refs: make some ref_store lookup functions private
  refs: remove some unnecessary handling of submodule == ""
  register_ref_store(): new function
  refs: store submodule ref stores in a hashmap
  refs: push the submodule attribute down
  base_ref_store_init(): remove submodule argument
  files_ref_store::submodule: use NULL for the main repository
  read_loose_refs(): read refs using resolve_ref_recursively()

 refs.c               | 107 +++++++++++++++++++++++++++++++++++----------------
 refs/files-backend.c |  77 +++++++++++++++++++++---------------
 refs/refs-internal.h |  48 ++++-------------------
 3 files changed, 127 insertions(+), 105 deletions(-)

-- 
2.9.3

