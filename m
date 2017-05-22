Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F6C82023D
	for <e@80x24.org>; Mon, 22 May 2017 14:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934730AbdEVOTE (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:19:04 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:44144 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934550AbdEVOSz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:18:55 -0400
X-AuditID: 1207440f-701ff700000004e5-53-5922f34df667
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 0F.45.01253.D43F2295; Mon, 22 May 2017 10:18:53 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24S023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:18:51 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 19/25] get_packed_ref_cache(): assume "packed-refs" won't change while locked
Date:   Mon, 22 May 2017 16:17:49 +0200
Message-Id: <6f28d8349797120fe344d6ed160df2e80a41c7a2.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqOv7WSnS4O9WfYu1z+4wWTxff4Ld
        outKN5NFQ+8VZosnc+8yW9xeMZ/ZYsnD18wW3VPeMlr8aOlhtti8uZ3Fgcvj7/sPTB47Z91l
        91iwqdTj4asudo+u9iNsHs969zB6XLyk7PF5k1wARxSXTUpqTmZZapG+XQJXxq/WnWwFBwQq
        5iy7ytzAuIm3i5GTQ0LAROLj22usXYxcHEICO5gknhxcwwzhnGKSOLDyKQtIFZuArsSinmYm
        EFtEQE1iYtshFpAiZoENzBJvpq8GSnBwCAskSGzbHANSwyKgKvF9yRRmEJtXIEqicV4jM8Q2
        eYldbRdZQWxOAQuJ37MOgM0UEjCX6P23mmUCI88CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmp
        RbomermZJXqpKaWbGCGByL+DsWu9zCFGAQ5GJR5ejcdKkUKsiWXFlbmHGCU5mJREeY++AQrx
        JeWnVGYkFmfEF5XmpBYfYpTgYFYS4dW+C5TjTUmsrEotyodJSXOwKInzqi9R9xMSSE8sSc1O
        TS1ILYLJynBwKEnwTv4E1ChYlJqeWpGWmVOCkGbi4AQZzgM0nOkzyPDigsTc4sx0iPwpRkUp
        cV4DkGYBkERGaR5cLyxRvGIUB3pFmLcQpIoHmGTgul8BDWYCGmz9TB5kcEkiQkqqgdFUoyao
        T3o3+58CxrTXOs4voj2Z7nau2vYzeJ3epZiQXTcf802/cep4jsHTHX5RBQdXnrlobs04tTFM
        eFrVa2H5raX1nP/ds1uuP2i+GH19ApfvL0WNryy5Z95x/mv+2H+6VkDg7c5ER2eJO0rLFk+o
        jJO1fdpbb/pWRrLaLZhnZ2qahu3pqUosxRmJhlrMRcWJAAN86ObvAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we've got the "packed-refs" file locked, then it can't change;
there's no need to keep calling `stat_validity_check()` on it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 29514392b0..c4bc9550d3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -342,13 +342,18 @@ static void files_ref_path(struct files_ref_store *refs,
 
 /*
  * Get the packed_ref_cache for the specified files_ref_store,
- * creating it if necessary.
+ * creating and populating it if it hasn't been read before or if the
+ * file has been changed (according to its `validity` field) since it
+ * was last read. On the other hand, if we hold the lock, then assume
+ * that the file hasn't been changed out from under us, so skip the
+ * extra `stat()` call in `stat_validity_check()`.
  */
 static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *refs)
 {
 	const char *packed_refs_file = files_packed_refs_path(refs);
 
 	if (refs->packed &&
+	    !is_lock_file_locked(&refs->packed_refs_lock) &&
 	    !stat_validity_check(&refs->packed->validity, packed_refs_file))
 		clear_packed_ref_cache(refs);
 
@@ -1288,10 +1293,11 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 			    flags, timeout_value) < 0)
 		return -1;
 	/*
-	 * Get the current packed-refs while holding the lock.  If the
-	 * packed-refs file has been modified since we last read it,
-	 * this will automatically invalidate the cache and re-read
-	 * the packed-refs file.
+	 * Get the current packed-refs while holding the lock. It is
+	 * important that we call `get_packed_ref_cache()` before
+	 * setting `packed_ref_cache->lock`, because otherwise the
+	 * former will see that the file is locked and assume that the
+	 * cache can't be stale.
 	 */
 	packed_ref_cache = get_packed_ref_cache(refs);
 	/* Increment the reference count to prevent it from being freed: */
-- 
2.11.0

