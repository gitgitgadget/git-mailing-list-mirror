Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADFBC20209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752191AbdGASc2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:32:28 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:43717 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752156AbdGASc0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:32:26 -0400
X-AuditID: 12074414-4f7ff70000001c95-3f-5957eaaf85ab
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 5F.25.07317.FAAE7595; Sat,  1 Jul 2017 14:32:15 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBd010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:32:13 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 26/30] clear_packed_ref_cache(): don't protest if the lock is held
Date:   Sat,  1 Jul 2017 20:31:04 +0200
Message-Id: <8de06c76181aff06d7236d3a5f7305500f728bde.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqLv+VXikwfcrBhZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntljy8DWzRfeUt4wWP1p6mC02b25nceD0+Pv+A5PHzll32T0WbCr1
        6Go/wubxrHcPo8fFS8oenzfJBbBHcdmkpOZklqUW6dslcGUsOX+KqWA7W8XHk5ENjKtYuxg5
        OSQETCQWPz8CZgsJ7GCS6PnL38XIBWSfZJKYN+MrWIJNQFdiUU8zE4gtIqAmMbHtEAtIEbPA
        JGaJt9cWgiWEBUIl/r6eywxiswioSjScPscOYvMKREk0L+2E2iYvsavtIpjNKWAh8adtPTPE
        ZnOJ5oN9LBMYeRYwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0rXQy80s0UtNKd3ECAk5kR2M
        R07KHWIU4GBU4uHdEBIWKcSaWFZcmXuIUZKDSUmUd+W10EghvqT8lMqMxOKM+KLSnNTiQ4wS
        HMxKIry5z8MjhXhTEiurUovyYVLSHCxK4rzfFqv7CQmkJ5akZqemFqQWwWRlODiUJHgnvQRq
        FCxKTU+tSMvMKUFIM3FwggznARq+8C7I8OKCxNzizHSI/ClGY46mD1u+MHG8mvD/G5MQS15+
        XqqUOG8ryDgBkNKM0jy4abC08YpRHOg5YV4GYBIR4gGmHLh5r4BWMQGtEp4RArKqJBEhJdXA
        GMvxyFNg9cS1wVEuppbn7TzW2h3m37z/WfK/MwlaO3Z47py2XUKw807JqptPCl9XMC1Kfvt8
        a0lEya/iC75HgnbfDn9v0SQqJLE1SEnh1HYv2XSjkFk/Op0jGmynnTOUnGj0etEr48x/dk+v
        FHP0rTpvUztXcXPtIo8/X13D3fq81DLOb9K4ocRSnJFoqMVcVJwIAEdlPdf2AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing callers already check that the lock isn't held just
before calling `clear_packed_ref_cache()`, and in the near future we
want to be able to call this function when the lock is held.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index f27943f9a1..96d92a5eea 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -133,8 +133,6 @@ static void clear_packed_ref_cache(struct packed_ref_store *refs)
 	if (refs->cache) {
 		struct packed_ref_cache *cache = refs->cache;
 
-		if (is_lock_file_locked(&refs->lock))
-			die("BUG: packed-ref cache cleared while locked");
 		refs->cache = NULL;
 		release_packed_ref_cache(cache);
 	}
-- 
2.11.0

