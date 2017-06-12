Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 799B91FA7B
	for <e@80x24.org>; Mon, 12 Jun 2017 08:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbdFLIGb (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 04:06:31 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:48104 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751930AbdFLIGa (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Jun 2017 04:06:30 -0400
X-AuditID: 12074414-cffff7000000283f-d0-593e4b84a1d7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id C1.5C.10303.48B4E395; Mon, 12 Jun 2017 04:06:29 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCC5.dip0.t-ipconnect.de [87.188.204.197])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5C86Ic5002255
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 12 Jun 2017 04:06:26 -0400
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
Subject: [PATCH 1/1] lock_packed_refs(): fix cache validity check
Date:   Mon, 12 Jun 2017 10:06:13 +0200
Message-Id: <18f059555ce0e4f46fba783973947f6a26ac4b65.1497253685.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497253685.git.mhagger@alum.mit.edu>
References: <cover.1497253685.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqNvqbRdpsPCDvMXaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8WTuXeZLW6vmM9sseTha2aL7ilvGS1+tPQwW2ze3M7iwOXx9/0HJo+ds+6y
        eyzYVOrx8FUXu0dX+xE2j2e9exg9Ll5S9vi8SS6AI4rLJiU1J7MstUjfLoEr4+ybuYwFO5Qr
        plx7yNLAuFi2i5GDQ0LARKKpXbCLkYtDSGAHk8TJF+eYIZxTTBI3n/cAOZwcbAK6Eot6mplA
        bBEBNYmJbYdYQIqYBTYwS7yZvhosISzgKHFg0lt2EJtFQFXi/f5XYHFegSiJ+58+gg2SEJCX
        2NV2kRXE5hSwkDh9+wMzyBVCAuYSnS/VJjDyLGBkWMUol5hTmqubm5iZU5yarFucnJiXl1qk
        a6GXm1mil5pSuokREoYiOxiPnJQ7xCjAwajEw5uw1zZSiDWxrLgy9xCjJAeTkijvlis2kUJ8
        SfkplRmJxRnxRaU5qcWHGCU4mJVEeO972UUK8aYkVlalFuXDpKQ5WJTEeb8tVvcTEkhPLEnN
        Tk0tSC2CycpwcChJ8M4AaRQsSk1PrUjLzClBSDNxcIIM5wEavscTZHhxQWJucWY6RP4Uo6KU
        OK8ISLMASCKjNA+uF5YmXjGKA70izMsLTBpCPMAUA9f9CmgwE9Dg6yAf8RaXJCKkpBoYq1si
        ig7PDL+wbK/Mt4Pb9k9iWZzRP/1OxhO1WSYzzPqyTp4r42bZKrhvLfMnD/9S8eajfsE2YlyB
        9+/lPk81T39+RmWPrOjdomeXvr97tOLNeqXq9dHzHlkqTHz+YMtRcePEH7mbHpxSWPk6LGS+
        4ZR1u8+vEPw8b8m7dwJbT+rnX+1c9X3dsQlKLMUZiYZazEXFiQDeR8TA7gIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 28ed9830b1 (get_packed_ref_cache(): assume "packed-refs" won't
change while locked, 2017-05-22) assumes that the "packed-refs" file
cannot change while we hold the lock. That assumption is
justified *if* the lock has been held the whole time since the
"packed-refs" file was last read.

But in `lock_packed_refs()`, we ourselves lock the "packed-refs" file
and then call `get_packed_ref_cache()` to ensure that the cache agrees
with the file. The intent is to guard against the possibility that
another process changed the "packed-refs" file the moment before we
locked it.

This check was defeated because `get_packed_ref_cache()` saw that the
file was locked, and therefore didn't do the `stat_validity_check()`
that we want.

The mistake was compounded with a misleading comment in
`lock_packed_refs()` claiming that it was doing the right thing. That
comment came from an earlier draft of the mh/packed-ref-store-prep
patch series when the commits were in a different order.

So instead:

* Extract a function `validate_packed_ref_cache()` that does the
  validity check independent of whether the lock is held.

* Change `get_packed_ref_cache()` to call the new function, but only
  if the lock *isn't* held.

* Change `lock_packed_refs()` to call the new function in any case
  before calling `get_packed_ref_cache()`.

* Fix the comment in `lock_packed_refs()`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
If anybody is curious, patch 28ed9830b1 originally appeared before
00d174489e (files_ref_store: put the packed files lock directly in
this struct, 2017-05-22), when `refs->packed_refs_lock` could be left
NULL until after `get_packed_ref_cache()` was called. In that version
of the patch series, the breakage occurred when the the lock was moved
and the check in `get_packed_ref_cache()` was changed from
`refs->packed_refs_lock` to
`is_lock_file_locked(&refs->packed_refs_lock)`. So either way, it was
the combination of the two patches that caused the regression.

 refs/files-backend.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index d8b3f73147..b040bb3b0a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -369,6 +369,18 @@ static void files_ref_path(struct files_ref_store *refs,
 	}
 }
 
+/*
+ * Check that the packed refs cache (if any) still reflects the
+ * contents of the file. If not, clear the cache.
+ */
+static void validate_packed_ref_cache(struct files_ref_store *refs)
+{
+	if (refs->packed &&
+	    !stat_validity_check(&refs->packed->validity,
+				 files_packed_refs_path(refs)))
+		clear_packed_ref_cache(refs);
+}
+
 /*
  * Get the packed_ref_cache for the specified files_ref_store,
  * creating and populating it if it hasn't been read before or if the
@@ -381,10 +393,8 @@ static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *ref
 {
 	const char *packed_refs_file = files_packed_refs_path(refs);
 
-	if (refs->packed &&
-	    !is_lock_file_locked(&refs->packed_refs_lock) &&
-	    !stat_validity_check(&refs->packed->validity, packed_refs_file))
-		clear_packed_ref_cache(refs);
+	if (!is_lock_file_locked(&refs->packed_refs_lock))
+		validate_packed_ref_cache(refs);
 
 	if (!refs->packed)
 		refs->packed = read_packed_refs(packed_refs_file);
@@ -1311,13 +1321,17 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 			    &refs->packed_refs_lock, files_packed_refs_path(refs),
 			    flags, timeout_value) < 0)
 		return -1;
+
 	/*
-	 * Get the current packed-refs while holding the lock. It is
-	 * important that we call `get_packed_ref_cache()` before
-	 * setting `packed_ref_cache->lock`, because otherwise the
-	 * former will see that the file is locked and assume that the
-	 * cache can't be stale.
+	 * Now that we hold the `packed-refs` lock, make sure that our
+	 * cache matches the current version of the file. Normally
+	 * `get_packed_ref_cache()` does that for us, but that
+	 * function assumes that when the file is locked, any existing
+	 * cache is still valid. We've just locked the file, but it
+	 * might have changed the moment *before* we locked it.
 	 */
+	validate_packed_ref_cache(refs);
+
 	packed_ref_cache = get_packed_ref_cache(refs);
 	/* Increment the reference count to prevent it from being freed: */
 	acquire_packed_ref_cache(packed_ref_cache);
-- 
2.11.0

