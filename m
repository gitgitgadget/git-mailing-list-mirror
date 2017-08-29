Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F8A620285
	for <e@80x24.org>; Tue, 29 Aug 2017 08:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751322AbdH2IUv (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 04:20:51 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:51553 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751295AbdH2IUq (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Aug 2017 04:20:46 -0400
X-AuditID: 12074411-f95ff70000007f0a-af-59a523db7f45
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 4E.C9.32522.BD325A95; Tue, 29 Aug 2017 04:20:43 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC836.dip0.t-ipconnect.de [87.188.200.54])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7T8KcRt002808
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 29 Aug 2017 04:20:42 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/10] packed-backend: don't adjust the reference count on lock/unlock
Date:   Tue, 29 Aug 2017 10:20:25 +0200
Message-Id: <c5d66cadb70efdb5b5ce91fbcc5673621f5d4792.1503993268.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1503993268.git.mhagger@alum.mit.edu>
References: <cover.1503993268.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsUixO6iqHtHeWmkwbaFzBZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHs969zB6
        XLyk7PF5k1wAWxSXTUpqTmZZapG+XQJXxpa951gKJgtW7G2fxtzAuISvi5GTQ0LAROLPgoOM
        XYxcHEICO5gktj3cxQThnGSS2Ph1KQtIFZuArsSinmYmEFtEQE1iYtshFpAiZoGnTBI7T95l
        BUkIC4RJ3O7rZQOxWQRUJZbtamcHsXkFoiT2n+xghFgnL3HuwW1mEJtTwELi0udHYHEhAXOJ
        050PmCcw8ixgZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuql5tZopeaUrqJERJigjsYZ5yU
        O8QowMGoxMO70npJpBBrYllxZe4hRkkOJiVR3gyFpZFCfEn5KZUZicUZ8UWlOanFhxglOJiV
        RHiD2YFyvCmJlVWpRfkwKWkOFiVxXr4l6n5CAumJJanZqakFqUUwWRkODiUJXi5gLAkJFqWm
        p1akZeaUIKSZODhBhvMADXcCqeEtLkjMLc5Mh8ifYlSUEuedoAiUEABJZJTmwfXCUsArRnGg
        V4R5fUHaeYDpA677FdBgJqDBioILQQaXJCKkpBoYWzQP3OOe1RxvW9nG/8UrJP2uW+sOYavb
        WXsb/Fb5zi74MtPqg+3MmxdTZOcau76sCr6xxyHm1NLG7Z9W516RP6B+t0XzWItzxc3LV/9M
        lTrwuGZnR4E+94l8nzLlrkCzSLspEV+UpbkCgvcsbc4RL2cq5OmIXXRfZnb8zLjpaSayAbMu
        pHkosRRnJBpqMRcVJwIAQW2wn9wCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old code incremented the packed ref cache reference count when
acquiring the packed-refs lock, and decremented the count when
releasing the lock. This is unnecessary because a locked packed-refs
file cannot be changed, so there is no reason for the cache to become
stale.

Moreover, the extra reference count causes a problem if we
intentionally clear the packed refs cache, as we sometimes need to do
if we change the cache in anticipation of writing a change to disk,
but then the write to disk fails. In that case, `packed_refs_unlock()`
would have no easy way to find the cache whose reference count it
needs to decrement.

This whole issue will soon become moot due to upcoming changes that
avoid changing the in-memory cache as part of updating the packed-refs
on disk, but this change makes that transition easier.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 412c85034f..7e348feac3 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -525,7 +525,6 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 				"packed_refs_lock");
 	static int timeout_configured = 0;
 	static int timeout_value = 1000;
-	struct packed_ref_cache *packed_ref_cache;
 
 	if (!timeout_configured) {
 		git_config_get_int("core.packedrefstimeout", &timeout_value);
@@ -560,9 +559,7 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 	 */
 	validate_packed_ref_cache(refs);
 
-	packed_ref_cache = get_packed_ref_cache(refs);
-	/* Increment the reference count to prevent it from being freed: */
-	acquire_packed_ref_cache(packed_ref_cache);
+	get_packed_ref_cache(refs);
 	return 0;
 }
 
@@ -576,7 +573,6 @@ void packed_refs_unlock(struct ref_store *ref_store)
 	if (!is_lock_file_locked(&refs->lock))
 		die("BUG: packed_refs_unlock() called when not locked");
 	rollback_lock_file(&refs->lock);
-	release_packed_ref_cache(refs->cache);
 }
 
 int packed_refs_is_locked(struct ref_store *ref_store)
-- 
2.14.1

