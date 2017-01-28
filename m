Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 605E71F437
	for <e@80x24.org>; Sat, 28 Jan 2017 21:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbdA1Va5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jan 2017 16:30:57 -0500
Received: from mout.web.de ([212.227.15.4]:55449 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751663AbdA1Va4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2017 16:30:56 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LkyHN-1bx9V209QL-00ampY; Sat, 28
 Jan 2017 22:13:41 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/5] introduce SWAP macro
Message-ID: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
Date:   Sat, 28 Jan 2017 22:13:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:JOe8hFUhEImzS5tdgMNutJstY2ZnxcahIKJTdWgY2pOhV1y8CZ6
 9uLhHha72o6bfnkPlk+GQt6KwQOE7btyN0PPThFxF1GNoW+mPz5xOPptZqUo/zNiB75xAqv
 UofkB/KpFDEmDI9da12onUQlqBywFLOVObCAQnXxDYMzseoXbMVuhLEN+UmNEbVrwbBq8Wt
 /QYYPLaxCJoByE5ENz+CA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ty3gIkeP1zE=:l2htg2HSTB9zZCUud9gJ10
 akYt9KyqJ2HPf2opPuQehChyWkpx8g/2WrESPE950IuYg/iU9FiGmMtgHc9zWV8h3y7og+A5H
 yBeXBRR7c9hpMGGovlBXHMMrTNmcBygyBF7ElKEx+25ya1NelC1ee5kfB/aamE3NbrSk5jjXv
 NTFxXavUlmoUB19NrKk5lA7ZVtw560j0sjoZs6FRKyeY+DDISk9kqVfqvRpyPgsPn6PRPSVTd
 H/MYNVInervMDUdqSGYE57rkbQMsahfx8Y1AV0CSYjHNLykiTOGGpE3IWaoGBTS7uZ+Y5//VG
 w82bhECJCR62VRSOdhEvAeL/UeeGpQhFK5WvNKB8GquOHMqfqxFHTIrsRTOE38A0dcQaQReEx
 2OUr6W2Qb0sIdVXXDfjPpdMYSVbk+KtWB3ebuudYTceVfDieHQ/SdXWDHu0BO6CiBDbac7f+F
 +CxlB7JtKb84Cko70DMI2T3gJJNHi0pJbl0uKu25PPZ3JvPlTQpb+o0WvcG6nBApzgVSdG+54
 kYWQVYwoSuNtxzKoNqBXE5NRp1y2orPkgqcXcuvcR55KwAd3rR9J5yk/W+AfipNOf/aOz6lYB
 uEG2ot+WM26zoRrKy7uuZaOJ02YMHWRj+B8z/NHaoLuA4zCa0TTg1SiRIyeuW+wx+w6pR8A1e
 1S792CBh6pNhepglS2CCwn0qDwUblBpNaZlfVlFmfdnFAyJ50dK52JNy82NftK4FXBIZGhqWH
 QXdFyIRVlJ5l6HWl4x1YHxDkthKw9hwfezGvxEXXldn+eWkj6sUe7opKE99StP8w4WqhkmTrL
 BRdZC46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Exchanging the value of two variables requires declaring a temporary
variable and repeating their names.  The swap macro in apply.c
simplifies this for its callers without changing the compiled binary.
Polish this macro and export it, then use it throughout the code to
reduce repetition and hide the declaration of temporary variables.

  add SWAP macro
  apply: use SWAP macro
  use SWAP macro
  diff: use SWAP macro
  graph: use SWAP macro

 apply.c                       | 23 +++++++----------------
 builtin/diff-tree.c           |  4 +---
 builtin/diff.c                |  9 +++------
 contrib/coccinelle/swap.cocci | 28 ++++++++++++++++++++++++++++
 diff-no-index.c               |  6 ++----
 diff.c                        | 12 ++++--------
 git-compat-util.h             | 10 ++++++++++
 graph.c                       | 11 ++---------
 line-range.c                  |  3 +--
 merge-recursive.c             |  5 +----
 object.c                      |  4 +---
 pack-revindex.c               |  5 +----
 prio-queue.c                  |  4 +---
 strbuf.h                      |  4 +---
 14 files changed, 63 insertions(+), 65 deletions(-)
 create mode 100644 contrib/coccinelle/swap.cocci

-- 
2.11.0

