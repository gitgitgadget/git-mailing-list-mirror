Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED0BF20209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbdGAScO (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:32:14 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:46462 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752092AbdGAScL (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:32:11 -0400
X-AuditID: 12074413-b45ff700000069ec-92-5957ea90e29e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 38.EC.27116.09AE7595; Sat,  1 Jul 2017 14:31:46 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBQ010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:31:42 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 13/30] rollback_packed_refs(): take a `packed_ref_store *` parameter
Date:   Sat,  1 Jul 2017 20:30:51 +0200
Message-Id: <f920fc693ffd464120e8925d6e7faeae8b8a8dab.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqDvpVXikwbYHChZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntljy8DWzRfeUt4wWP1p6mC02b25nceD0+Pv+A5PHzll32T0WbCr1
        6Go/wubxrHcPo8fFS8oenzfJBbBHcdmkpOZklqUW6dslcGWcPrGMreAwb8WS+8uYGxiPc3cx
        cnJICJhILJqwmamLkYtDSGAHk8TKIxfYIJyTTBLtv16ygVSxCehKLOppZgKxRQTUJCa2HWIB
        KWIWmMQs8fbaQrCEsEC4xO8JcxlBbBYBVYkNM/rBbF6BKIlNF+ewQayTl9jVdpEVxOYUsJD4
        07aeGcQWEjCXaD7YxzKBkWcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1zvdzMEr3UlNJN
        jJCwE97BuOuk3CFGAQ5GJR7eDSFhkUKsiWXFlbmHGCU5mJREeVdeC40U4kvKT6nMSCzOiC8q
        zUktPsQowcGsJMKb+zw8Uog3JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8Gh
        JMHLBIwvIcGi1PTUirTMnBKENBMHJ8hwHqDhC++CDC8uSMwtzkyHyJ9i1OV4NeH/NyYhlrz8
        vFQpcd7Wl0BFAiBFGaV5cHNg6eIVozjQW8K8ES+AqniAqQZu0iugJUxAS4RnhIAsKUlESEk1
        MG5S9Co7xrxnl9zMqecPhimdFdgqpFoQMV39sgzjrRq57L9nIw6x5x2R39N/7qEq18IUvWTt
        wrcba6+FO6ZZLLNZLrbT90jpzsOCad6XmrXFnby3fTZasZZ90YWnl1SYLBQ32Vz/umjvDqsz
        PU53b58KVpOd+GbLjdOifEsX85046N159Ev2BEclluKMREMt5qLiRAD3sf298gIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only cares about the packed-refs part of the reference store.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5d159620f0..a08d3fbadf 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1434,18 +1434,17 @@ static int commit_packed_refs(struct packed_ref_store *refs)
  * in-memory packed reference cache.  (The packed-refs file will be
  * read anew if it is needed again after this function is called.)
  */
-static void rollback_packed_refs(struct files_ref_store *refs)
+static void rollback_packed_refs(struct packed_ref_store *refs)
 {
-	struct packed_ref_cache *packed_ref_cache =
-		get_packed_ref_cache(refs->packed_ref_store);
+	struct packed_ref_cache *packed_ref_cache = get_packed_ref_cache(refs);
 
-	files_assert_main_repository(refs, "rollback_packed_refs");
+	packed_assert_main_repository(refs, "rollback_packed_refs");
 
-	if (!is_lock_file_locked(&refs->packed_ref_store->lock))
+	if (!is_lock_file_locked(&refs->lock))
 		die("BUG: packed-refs not locked");
-	rollback_lock_file(&refs->packed_ref_store->lock);
+	rollback_lock_file(&refs->lock);
 	release_packed_ref_cache(packed_ref_cache);
-	clear_packed_ref_cache(refs->packed_ref_store);
+	clear_packed_ref_cache(refs);
 }
 
 struct ref_to_prune {
@@ -1657,7 +1656,7 @@ static int repack_without_refs(struct files_ref_store *refs,
 		 * All packed entries disappeared while we were
 		 * acquiring the lock.
 		 */
-		rollback_packed_refs(refs);
+		rollback_packed_refs(refs->packed_ref_store);
 		return 0;
 	}
 
-- 
2.11.0

