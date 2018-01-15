Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DDE91FAE2
	for <e@80x24.org>; Mon, 15 Jan 2018 12:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933465AbeAOMRx (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 07:17:53 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:45525 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932252AbeAOMRw (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Jan 2018 07:17:52 -0500
X-AuditID: 1207440e-1a9ff70000000b4f-58-5a5c9bece076
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 6E.6B.02895.CEB9C5A5; Mon, 15 Jan 2018 07:17:49 -0500 (EST)
Received: from bagpipes.fritz.box (p54AAEF2D.dip0.t-ipconnect.de [84.170.239.45])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w0FCHiEp010101
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 15 Jan 2018 07:17:46 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Kim Gybels <kgybels@infogroep.be>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/3] Supplements to "packed_ref_cache: don't use mmap() for small files"
Date:   Mon, 15 Jan 2018 13:17:32 +0100
Message-Id: <cover.1516017331.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180114191416.2368-1-kgybels@infogroep.be>
References: <20180114191416.2368-1-kgybels@infogroep.be>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsUixO6iqPt2dkyUweT98hZdV7qZLBp6rzBb
        9C/vYrM42DmT1eL2ivnMDqwef99/YPL48DHOo+/IGkaPi5eUPT5vkgtgjeKySUnNySxLLdK3
        S+DKOP3uK3vBNL6K1n1T2RoYt3F3MXJySAiYSPxf94+pi5GLQ0hgB5PErh9n2CGci0wS09Zv
        YwWpYhPQlVjU08wEYosIqEocnD+FEaSIWWAFo8Taph6whLBAhMT5XceYQWwWoKIfLWfYQGxe
        AXOJXysOMkOsk5d4v+A+I4jNKWApcfTdNrAaIQELiU+HPjFPYORZwMiwilEuMac0Vzc3MTOn
        ODVZtzg5MS8vtUjXWC83s0QvNaV0EyMkdPh2MLavlznEKMDBqMTDG7EsOkqINbGsuDL3EKMk
        B5OSKK96b0yUEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHexmCgHG9KYmVValE+TEqag0VJnFdt
        ibqfkEB6YklqdmpqQWoRTFaGg0NJgvfGLKBGwaLU9NSKtMycEoQ0EwcnyHAeoOGrQGp4iwsS
        c4sz0yHypxh1OW68eN3GLMSSl5+XKiXO2wVSJABSlFGaBzcHFvOvGMWB3hLmvQVSxQNMF3CT
        XgEtYQJaUr8kEmRJSSJCSqqBUdP11+tHWs0nF2bpRRW/3XC1o48xqWEFEzd/UV5NorOZ05SJ
        +8Mul5j933irMYzl8K7WVRn3OytP2gTZKyqd4Fhj+9HnRVt23unYGHb+4J4b7VGOwQLCK8/P
        NfUxTpl+4fHVnqnnlzFMDz3y76Dl+n0lFYdmpm203Hwtyi2v9v7RHqvA2IUxSizFGYmGWsxF
        xYkA9Hm6D9QCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your patch. I haven't measured the performance difference
of `mmap()` vs. `read()` for small `packed-refs` files, but it's not
surprising that `read()` would be faster.

I especially like the fix for zero-length `packed-refs` files. (Even
though AFAIK Git never writes such files, they are totally legitimate
and shouldn't cause Git to fail.) With or without the additions
mentioned below,

Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>

While reviewing your patch, I realized that some areas of the existing
code use constructs that are undefined according to the C standard,
such as computing `NULL + 0` and `NULL - NULL`. This was already wrong
(and would come up more frequently after your change). Even though
these are unlikely to be problems in the real world, it would be good
to avoid them.

So I will follow up this email with three patches:

1. Mention that `snapshot::buf` can be NULL for empty files

   I suggest squashing this into your patch, to make it clear that
   `snapshot::buf` and `snapshot::eof` can also be NULL if the
   `packed-refs` file is empty.

2. create_snapshot(): exit early if the file was empty

   Avoid undefined behavior by returning early if `snapshot->buf` is
   NULL.

3. find_reference_location(): don't invoke if `snapshot->buf` is NULL

   Avoid undefined behavior and confusing semantics by not calling
   `find_reference_location()` when `snapshot->buf` is NULL.

Michael

Michael Haggerty (3):
  SQUASH? Mention that `snapshot::buf` can be NULL for empty files
  create_snapshot(): exit early if the file was empty
  find_reference_location(): don't invoke if `snapshot->buf` is NULL

 refs/packed-backend.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

-- 
2.14.2

