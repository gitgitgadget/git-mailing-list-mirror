Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3858201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753659AbdEQMGd (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:06:33 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:48811 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753341AbdEQMG3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 08:06:29 -0400
X-AuditID: 12074411-cafff70000003efd-0c-591c3cc31e25
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id D3.9A.16125.3CC3C195; Wed, 17 May 2017 08:06:28 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HC5pg8000430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 08:06:26 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 17/23] get_packed_ref_cache(): assume "packed-refs" won't change while locked
Date:   Wed, 17 May 2017 14:05:40 +0200
Message-Id: <eedc8f85c8237515bc66584649b1e3f3d547049c.1495014840.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsUixO6iqHvERibSYMozQYu1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfGs84m5oIdAhWP/p1jamBcxdvFyMkhIWAi
        MfnAC6YuRi4OIYEdTBI3D/9hh3BOMElcXjuBEaSKTUBXYlFPMxOILSKgJjGx7RALSBGzwGMm
        ib/LuoEcDg5hgViJtmVuIDUsAqoSD6bPZgQJ8wpESRzdVQWxTF5iV9tFVhCbU8BC4v77R+wg
        JUIC5hLbr1dOYORZwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXVC83s0QvNaV0EyMkzAR3
        MM44KXeIUYCDUYmHdwKXdKQQa2JZcWXuIUZJDiYlUd79D4BCfEn5KZUZicUZ8UWlOanFhxgl
        OJiVRHhvmspECvGmJFZWpRblw6SkOViUxHn5lqj7CQmkJ5akZqemFqQWwWRlODiUJHinWAM1
        ChalpqdWpGXmlCCkmTg4QYbzAA3nAqnhLS5IzC3OTIfIn2JUlBLnPQCSEABJZJTmwfXC0sAr
        RnGgV4R5n4NU8QBTCFz3K6DBTECDm0E+4i0uSURISTUwzhSzPy/5/VP1mRKBdvf7J1sXNq/M
        uyYnJXijjenJW4XFx/VZDwl/yuH+dML8yt6zkdM7eR3jUz5e3l/zs8Fu4xGm4qU3BT+oRu91
        847rnvxlGkuMfs/c/wUWnLkXvWzPZYReWrOGTf3MTecj9lFLrK+mrFh2ZclkLTX+fz57Z217
        Otdjof9XdSWW4oxEQy3mouJEANa7fMTeAgAA
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
index c549a8d956..a910c44f38 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -354,13 +354,18 @@ static void files_ref_path(struct files_ref_store *refs,
 
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
+	    !is_lock_file_locked(&refs->packlock) &&
 	    !stat_validity_check(&refs->packed->validity, packed_refs_file))
 		clear_packed_ref_cache(refs);
 
@@ -1300,10 +1305,11 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
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

