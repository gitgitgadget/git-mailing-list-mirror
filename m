Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 541DA20401
	for <e@80x24.org>; Thu, 15 Jun 2017 14:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752577AbdFOOs5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 10:48:57 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:63425 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752540AbdFOOsO (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 10:48:14 -0400
X-AuditID: 1207440e-1f7ff70000000c7e-50-59429e279c3c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 41.66.03198.82E92495; Thu, 15 Jun 2017 10:48:08 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCC0A.dip0.t-ipconnect.de [87.188.204.10])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5FElbR6014537
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 15 Jun 2017 10:48:06 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/28] rollback_packed_refs(): take a `packed_ref_store *` parameter
Date:   Thu, 15 Jun 2017 16:47:17 +0200
Message-Id: <ba97a6b127e31d76557464e6c88d8c33831ae173.1497534157.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqKsxzynSYM19Nou1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDJOn1jGVnCYt2LJ/WXMDYzHubsY
        OTkkBEwkei4dY+pi5OIQEtjBJPH+y2sWkISQwEkmiYO9fCA2m4CuxKKeZiYQW0RATWJi2yEW
        kAZmgUnMEm+vLQRLCAuESLzasYcVxGYRUJVYveUFWJxXIEqi4/ETJoht8hK72i6C1XAKWEjM
        /rKOuYuRA2iZucSx5RoTGHkWMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI11svNLNFLTSnd
        xAgJOb4djO3rZQ4xCnAwKvHwKjQ4RQqxJpYVV+YeYpTkYFIS5eWXAwrxJeWnVGYkFmfEF5Xm
        pBYfYpTgYFYS4Z06ByjHm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLg
        NZ4L1ChYlJqeWpGWmVOCkGbi4AQZzgM0/C/Y8OKCxNzizHSI/ClGRSlxXg+QhABIIqM0D64X
        lhJeMYoDvSLMOw+kigeYTuC6XwENZgIaHHTBAWRwSSJCSqqBcc6+0xzm7bX7tt0p9I9ivX/g
        T9FrztcmU90buiMfNmobvXct0tso//BzmmptWMiNwpRkte5bd2dnnP9j2sCv+v2cYxf/wlV7
        va2eT90UWBqYbnzvVB9PZuTaDCcPTU2T4/4ydoYPuG9d5RRhnvDz/nnlaRkPaqQ5rn8seR5X
        dLrQpi/8VomeEktxRqKhFnNRcSIAMUdRmuQCAAA=
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

