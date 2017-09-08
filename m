Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5ABE2082D
	for <e@80x24.org>; Fri,  8 Sep 2017 13:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752668AbdIHNwG (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 09:52:06 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:53082 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752679AbdIHNwD (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Sep 2017 09:52:03 -0400
X-AuditID: 1207440c-7fdff7000000143e-da-59b2a082124b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 3F.2B.05182.280A2B95; Fri,  8 Sep 2017 09:52:02 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAEECC.dip0.t-ipconnect.de [84.170.238.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v88Dpvjr002844
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 8 Sep 2017 09:51:59 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/11] Implement transactions for the packed ref store
Date:   Fri,  8 Sep 2017 15:51:42 +0200
Message-Id: <cover.1504877858.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsUixO6iqNu0YFOkwfepohZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHs969zB6
        XLyk7PF5k1wAWxSXTUpqTmZZapG+XQJXxv0v81gKNglUPNw1l62BcQNvFyMnh4SAicT3J+vZ
        uhi5OIQEdjBJTH20HMo5ySSxefJqVpAqNgFdiUU9zUwgtoiAmsTEtkMsIEXMAk+ZJHaevAtW
        JCzgKXHu3HOgIg4OFgFVifmTvEDCvALmEos33WSE2CYvce7BbeYJjFwLGBlWMcol5pTm6uYm
        ZuYUpybrFicn5uWlFuka6uVmluilppRuYoQEDM8Oxm/rZA4xCnAwKvHwTgjdGCnEmlhWXJl7
        iFGSg0lJlFemZ1OkEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRFe81lAOd6UxMqq1KJ8mJQ0B4uS
        OK/qEnU/IYH0xJLU7NTUgtQimKwMB4eSBG/AfKBGwaLU9NSKtMycEoQ0EwcnyHAeoOEbQWp4
        iwsSc4sz0yHypxiNOTpu3v3DxPFl9/0/TEIsefl5qVLivG3zgEoFQEozSvPgpsGi/hWjONBz
        wrxTQAbyABMG3LxXQKuYgFaVPN8AsqokESEl1cAYnHnp3cxDec+ufLwnGnFhh2JgjMhZ7qgN
        /J+MhX6drt/KlZ6+rsDD6O6uXw6LpM3OHH93/c5SZ9X33x9m9SVt4umLFZof8uJTpOxlx5mz
        ZleJrb3kdFDvl1xhqfSR1Te6Z+v4hmfGfXEqm/5G3OS3/FHBf26PP3Bm3T92r2LN90vTpjgl
        rZhrrsRSnJFoqMVcVJwIAAWtgwrVAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v2 of a patch series to implement reference transactions for
the packed refs-store. Thanks to Stefan, Brandon, Junio, and Peff for
your review of v1 [1]. I believe I have addressed all of your
comments.

Changes since v1:

* Patch [01/11]: justify the change better in the log message. Add a
  comment explaining why `get_packed_ref_cache()` is being called but
  the return value discarded.

* Patch [05/11]: Lock the `packed-refs` file *after* successfully
  creating the (empty) transaction object. This prevents leaving the
  file locked if `ref_store_transaction_begin()` fails.

* Patch [06/11]: New patch, fixing a leak of the `refs_to_prune`
  linked list.

* Patch [07/11]: Reimplement test "no bogus intermediate values during
  delete" to work without polling. Also incorporate Junio's change
  `s/grep/test_i18ngrep/`.

These changes are also available as branch `packed-ref-transactions`
from my GitHub repo [2].

Michael

[1] https://public-inbox.org/git/cover.1503993268.git.mhagger@alum.mit.edu/
[2] https://github.com/mhagger/git

Michael Haggerty (11):
  packed-backend: don't adjust the reference count on lock/unlock
  struct ref_transaction: add a place for backends to store data
  packed_ref_store: implement reference transactions
  packed_delete_refs(): implement method
  files_pack_refs(): use a reference transaction to write packed refs
  prune_refs(): also free the linked list
  files_initial_transaction_commit(): use a transaction for packed refs
  t1404: demonstrate two problems with reference transactions
  files_ref_store: use a transaction to update packed refs
  packed-backend: rip out some now-unused code
  files_transaction_finish(): delete reflogs before references

 refs/files-backend.c         | 214 ++++++++++++++------
 refs/packed-backend.c        | 461 +++++++++++++++++++++++++++++--------------
 refs/packed-backend.h        |  17 +-
 refs/refs-internal.h         |   1 +
 t/t1404-update-ref-errors.sh |  73 +++++++
 5 files changed, 550 insertions(+), 216 deletions(-)

-- 
2.14.1

