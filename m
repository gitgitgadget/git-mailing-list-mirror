Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 952DB2082D
	for <e@80x24.org>; Fri,  8 Sep 2017 13:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753209AbdIHNwH (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 09:52:07 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:53082 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751166AbdIHNwE (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Sep 2017 09:52:04 -0400
X-AuditID: 1207440c-7fdff7000000143e-dc-59b2a084cce8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id EF.2B.05182.480A2B95; Fri,  8 Sep 2017 09:52:04 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAEECC.dip0.t-ipconnect.de [84.170.238.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v88Dpvjs002844
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 8 Sep 2017 09:52:02 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 01/11] packed-backend: don't adjust the reference count on lock/unlock
Date:   Fri,  8 Sep 2017 15:51:43 +0200
Message-Id: <1631f277bb86f653c5c679ca07fbcb2e92410046.1504877858.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1504877858.git.mhagger@alum.mit.edu>
References: <cover.1504877858.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsUixO6iqNuyYFOkweXN0hZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHs969zB6
        XLyk7PF5k1wAWxSXTUpqTmZZapG+XQJXxvk5HAWPRSo2rH7D1MDYItjFyMkhIWAi8fZvM2sX
        IxeHkMAOJomW6VdZIJyTTBIHWtpYQarYBHQlFvU0M4HYIgJqEhPbDoEVMQs8ZZLYefIuUBEH
        h7BApMT8ax4gNSwCqhJv7ixiBLF5BaIkVj3+zg6xTV7i3IPbzCA2p4CFxKt/a9hAbCEBc4mr
        uyexTmDkWcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11AvN7NELzWldBMjJLx4djB+Wydz
        iFGAg1GJh3dC6MZIIdbEsuLK3EOMkhxMSqK8Mj2bIoX4kvJTKjMSizPii0pzUosPMUpwMCuJ
        8JrPAsrxpiRWVqUW5cOkpDlYlMR5VZeo+wkJpCeWpGanphakFsFkZTg4lCR4A+YDNQoWpaan
        VqRl5pQgpJk4OEGG8wAN3whSw1tckJhbnJkOkT/FqMvRcfPuHyYhlrz8vFQpcd62eUBFAiBF
        GaV5cHNgaeEVozjQW8K8U0BG8QBTCtykV0BLmICWlDzfALKkJBEhJdXA2P3xoNreqKc2WTpp
        L1lmLNI1+Hkio++C9d8vy29dz5+YuN1M9K2B05evdddf1XpEaM07H1ThKLpuz80NBcEnPmWl
        R13OEtvy0G7Xyfx/6Zdtg2w//1+xSltwkaqe84moQhfegLMzTqS/NjwWuuhv+1Tl1Udfn6+0
        687xfcwh9+jXA42Hn833piixFGckGmoxFxUnAgDlA6pq5gIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old code incremented the packed ref cache reference count when
acquiring the packed-refs lock, and decremented the count when
releasing the lock. This is unnecessary because:

* Another process cannot change the packed-refs file because it is
  locked.

* When we ourselves change the packed-refs file, we do so by first
  modifying the packed ref-cache, and then writing the data from the
  ref-cache to disk. So the packed ref-cache remains fresh because any
  changes that we plan to make to the file are made in the cache first
  anyway.

So there is no reason for the cache to become stale.

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
 refs/packed-backend.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 412c85034f..b76f14e5b3 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -525,7 +525,6 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 				"packed_refs_lock");
 	static int timeout_configured = 0;
 	static int timeout_value = 1000;
-	struct packed_ref_cache *packed_ref_cache;
 
 	if (!timeout_configured) {
 		git_config_get_int("core.packedrefstimeout", &timeout_value);
@@ -560,9 +559,11 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 	 */
 	validate_packed_ref_cache(refs);
 
-	packed_ref_cache = get_packed_ref_cache(refs);
-	/* Increment the reference count to prevent it from being freed: */
-	acquire_packed_ref_cache(packed_ref_cache);
+	/*
+	 * Now make sure that the packed-refs file as it exists in the
+	 * locked state is loaded into the cache:
+	 */
+	get_packed_ref_cache(refs);
 	return 0;
 }
 
@@ -576,7 +577,6 @@ void packed_refs_unlock(struct ref_store *ref_store)
 	if (!is_lock_file_locked(&refs->lock))
 		die("BUG: packed_refs_unlock() called when not locked");
 	rollback_lock_file(&refs->lock);
-	release_packed_ref_cache(refs->cache);
 }
 
 int packed_refs_is_locked(struct ref_store *ref_store)
-- 
2.14.1

