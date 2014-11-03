From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 16/17] refs.c: make lock_packed_refs take an err argument
Date: Mon,  3 Nov 2014 11:02:18 -0800
Message-ID: <1415041339-18450-17-git-send-email-sahlberg@google.com>
References: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:03:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlMuF-0001m8-0X
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445AbaKCTCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:02:48 -0500
Received: from mail-pd0-f202.google.com ([209.85.192.202]:40463 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbaKCTCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:02:25 -0500
Received: by mail-pd0-f202.google.com with SMTP id ft15so1995468pdb.3
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4izx0nncm++mmRwF+qoj8JSZlxOlAQhjn6NVaGKb/NU=;
        b=oG/DH+nOPYm4tD/D/xrNgx1zGR6YE5b1isbyo2CA6a51xXLYOodwGiuUe25lqVnCe3
         uUVSyixx014+06eUDu5qP+JroEJDkxL2hMXvxhvb4MgPqubzWQ7F8MxI4vHnb9lnDchS
         ZnIiTUNF81CubtCImD0mJ3QKU5wM1en6ZDqP5a/OlOqFSwKU3UYB32q9fJzpLN7wTcl4
         U7Xuvs4sLDuPicApqzeyc6mb+tnt8K0T47ZyRK/EWnIE1RVE6rczA6k9cFCYJ8hFjX39
         9B/KWo2xdf+kBdgBA3smjN9/u9x7MXTdAmtsnCJez+m0ttGge0ghMErd4zGs2FUZn61Q
         XjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4izx0nncm++mmRwF+qoj8JSZlxOlAQhjn6NVaGKb/NU=;
        b=eplA7h/1qTldOCuu2oATbD0wgoggMGY9yiuoAVltCq6IzZRma6fe+1S+IbaYkziTHU
         AB0Y31LGzpB+exUbWc03vawHW072U3J1l6eS1199kkd0P2iUkf9snSbcBkB5Q+qdv14d
         rWPeYpnGaKix8YNGxXllTWDCGOd3V0siQcbXFC3qRh6x5qxQ8Wxc1f6LUE8p+XKH/xVa
         7ma8cs7GHAG2vrsODqJHh031REMcRggu+vVoeeoVIBymcK8TlXy03JtjLVvCVIuXGqyJ
         P9NX1o85djouhxs62j7mbamOUlMa7jOr2p8WPC1Jnef6GrPgsHNTYvqELzwaNrU1co+N
         I37w==
X-Gm-Message-State: ALoCoQlWVDioIYVL+Zfgi2p5E+jOkUlndndqlOMWicYdMPgbZw5OGz3hhWLUCge/9mn8cBRFccGO
X-Received: by 10.66.219.135 with SMTP id po7mr33979581pac.9.1415041344759;
        Mon, 03 Nov 2014 11:02:24 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id e24si975168yhe.3.2014.11.03.11.02.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 11:02:24 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id 8XdCBcWq.2; Mon, 03 Nov 2014 11:02:24 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2FBF8E1154; Mon,  3 Nov 2014 11:02:23 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 0b9cb8d..92e7714 100644
--- a/refs.c
+++ b/refs.c
@@ -2398,13 +2398,17 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
-/* This should return a meaningful errno on failure */
-static int lock_packed_refs(int flags)
+static int lock_packed_refs(struct strbuf *err)
 {
 	struct packed_ref_cache *packed_ref_cache;
 
-	if (hold_lock_file_for_update(&packlock, git_path("packed-refs"), flags) < 0)
+	if (hold_lock_file_for_update(&packlock, git_path("packed-refs"),
+				      0) < 0) {
+		if (err)
+			unable_to_lock_message(git_path("packed-refs"),
+					       errno, err);
 		return -1;
+	}
 	/*
 	 * Get the current packed-refs while holding the lock.  If the
 	 * packed-refs file has been modified since we last read it,
@@ -2592,11 +2596,14 @@ static void prune_refs(struct ref_to_prune *r)
 int pack_refs(unsigned int flags)
 {
 	struct pack_refs_cb_data cbdata;
+	struct strbuf err = STRBUF_INIT;
 
 	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.flags = flags;
 
-	lock_packed_refs(LOCK_DIE_ON_ERROR);
+	if (lock_packed_refs(&err))
+		die("%s", err.buf);
+
 	cbdata.packed_refs = get_packed_refs(&ref_cache);
 
 	do_for_each_entry_in_dir(get_loose_refs(&ref_cache), 0,
@@ -3791,10 +3798,7 @@ int transaction_commit(struct transaction *transaction,
 	}
 
 	/* Lock packed refs during commit */
-	if (lock_packed_refs(0)) {
-		if (err)
-			unable_to_lock_message(git_path("packed-refs"),
-					       errno, err);
+	if (lock_packed_refs(err)) {
 		ret = -1;
 		goto cleanup;
 	}
@@ -3849,10 +3853,7 @@ int transaction_commit(struct transaction *transaction,
 			goto cleanup;
 		}
 		/* lock the packed refs again so no one can change it */
-		if (lock_packed_refs(0)) {
-			if (err)
-				unable_to_lock_message(git_path("packed-refs"),
-						       errno, err);
+		if (lock_packed_refs(err)) {
 			ret = -1;
 			goto cleanup;
 		}
-- 
2.1.0.rc2.206.gedb03e5
