Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9719920958
	for <e@80x24.org>; Mon, 20 Mar 2017 16:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755644AbdCTQeN (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:34:13 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:55619 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755591AbdCTQeH (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 12:34:07 -0400
X-AuditID: 12074411-4bfff700000005a9-e7-58d0047d140f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 1D.A9.01449.D7400D85; Mon, 20 Mar 2017 12:34:05 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KGXV9S010511
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 12:34:03 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 18/20] commit_packed_refs(): use reference iteration
Date:   Mon, 20 Mar 2017 17:33:23 +0100
Message-Id: <b8d279659c6755c5d042a3062b526e4752114c38.1490026594.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490026594.git.mhagger@alum.mit.edu>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsUixO6iqFvLciHC4NpGdYuuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DA7sHn8ff+ByWPnrLvsHl3tR9g8nvXuYfS4eEnZ4/MmuQC2
        KC6blNSczLLUIn27BK6MFS1XmQuuiVUcvv2cpYHxtFAXIweHhICJxJtpYl2MXBxCAjuYJP7f
        v88O4Zxikli+cQ9LFyMnB5uArsSinmYmEFtEQE1iYtshFpAiZoFHjBJX599lB0kIC7hIXJox
        E8xmEVCVuL7oPSOIzSsQJbHiy342EFtCQF5iV9tFVhCbU8BC4sv9RrAFQgLmEp0LetknMPIs
        YGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrqpebWaKXmlK6iRESToI7GGeclDvEKMDBqMTD
        y3D9fIQQa2JZcWXuIUZJDiYlUd6nt4FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHirXgLleFMS
        K6tSi/JhUtIcLErivHxL1P2EBNITS1KzU1MLUotgsjIcHEoSvFf+ATUKFqWmp1akZeaUIKSZ
        ODhBhvMADVf/AzK8uCAxtzgzHSJ/ilFRSpz3wm+ghABIIqM0D64XFu+vGMWBXhHmrf0FVMUD
        TBVw3a+ABjMBDV524wzI4JJEhJRUA6NhgTC33dyZx80Ev3obS4o7hbqtmbfhWHyWRZn7wQu1
        R3L8WYqXNM1brcUW8nL2+VXq2yZ56fwSNNr7MmamUWSDx2+d5fsCkthcVgZxbf3w4IQe89KN
        0bWB3S8UZdY/bnQSO+F6cMqmjrK7PM2MzIJZ+8N+6j+4EvxvwbX93gvXLLvMscrwU7kSS3FG
        oqEWc1FxIgALXnKp0gIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use reference iteration rather than do_for_each_entry_in_dir() in the
definition of commit_packed_refs().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 736a6c9ff7..0ea42826c8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1293,30 +1293,15 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
  * Write an entry to the packed-refs file for the specified refname.
  * If peeled is non-NULL, write it as the entry's peeled value.
  */
-static void write_packed_entry(FILE *fh, char *refname, unsigned char *sha1,
-			       unsigned char *peeled)
+static void write_packed_entry(FILE *fh, const char *refname,
+			       const unsigned char *sha1,
+			       const unsigned char *peeled)
 {
 	fprintf_or_die(fh, "%s %s\n", sha1_to_hex(sha1), refname);
 	if (peeled)
 		fprintf_or_die(fh, "^%s\n", sha1_to_hex(peeled));
 }
 
-/*
- * An each_ref_entry_fn that writes the entry to a packed-refs file.
- */
-static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
-{
-	enum peel_status peel_status = peel_entry(entry, 0);
-
-	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
-		error("internal error: %s is not a valid packed reference!",
-		      entry->name);
-	write_packed_entry(cb_data, entry->name, entry->u.value.oid.hash,
-			   peel_status == PEEL_PEELED ?
-			   entry->u.value.peeled.hash : NULL);
-	return 0;
-}
-
 /*
  * Lock the packed-refs file for writing. Flags is passed to
  * hold_lock_file_for_update(). Return 0 on success. On errors, set
@@ -1362,9 +1347,10 @@ static int commit_packed_refs(struct files_ref_store *refs)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(refs);
-	int error = 0;
+	int ok, error = 0;
 	int save_errno = 0;
 	FILE *out;
+	struct ref_iterator *iter;
 
 	files_assert_main_repository(refs, "commit_packed_refs");
 
@@ -1376,8 +1362,18 @@ static int commit_packed_refs(struct files_ref_store *refs)
 		die_errno("unable to fdopen packed-refs descriptor");
 
 	fprintf_or_die(out, "%s", PACKED_REFS_HEADER);
-	do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
-				 write_packed_entry_fn, out);
+
+	iter = cache_ref_iterator_begin(packed_ref_cache->cache, NULL, 0);
+	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
+		struct object_id peeled;
+		int peel_error = ref_iterator_peel(iter, &peeled);
+
+		write_packed_entry(out, iter->refname, iter->oid->hash,
+				   peel_error ? NULL : peeled.hash);
+	}
+
+	if (ok != ITER_DONE)
+		die("error while iterating over references");
 
 	if (commit_lock_file(packed_ref_cache->lock)) {
 		save_errno = errno;
-- 
2.11.0

