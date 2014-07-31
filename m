From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 3/5] refs.c: make lock_packed_refs take an err argument
Date: Thu, 31 Jul 2014 14:25:08 -0700
Message-ID: <1406841910-3278-4-git-send-email-sahlberg@google.com>
References: <1406841910-3278-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 23:25:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCxr0-0000bc-6E
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 23:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114AbaGaVZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 17:25:27 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:33559 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976AbaGaVZR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 17:25:17 -0400
Received: by mail-ie0-f202.google.com with SMTP id rl12so956141iec.5
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 14:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qH1FydRyZYNPRgaPZj0OvodHD9L6pU43rX079M0Gi7A=;
        b=UYvQVdeA0oIcF1xcTocTzkNTBKD2rIVINtx3elLXgABGpZdRMI7/zcMOBkKWT9/fMT
         gbV8a2myJr6irbpfblAq5mqRSyGthYBTH/tU0hs8UjpZ77Wl93FfmGn3/DTvgy1afuVO
         smAsUVcy3ZpdFNp4hRl6OPTowpnxv33WHzgLgaTt4uNKEjImV0BWZHCtjPYZm6PQQuZG
         cL/T7KXjk5FQAb/bPQHglTcNdE6lRMdShw61NReuEIoosVuzlf5o7DIYvqMBgkwQgrlf
         vPaNi5kkBQnza1WwxgzY61KDS0K0JFEm4JGzxuH2bBclAk0JOsFvrBr/weQFknE8QEXO
         jn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qH1FydRyZYNPRgaPZj0OvodHD9L6pU43rX079M0Gi7A=;
        b=gO6PekSFcEJF/07Lfnu5/jhRoqYpviCaRrKhCpjC6KNNeByMeLJd3zq/Q6Ted6E5y0
         /L+l8npB42FzkUuHdUTCMs+J41rM0iyzMWBr/NfXGZhJFt2LB1JVwS2ktZoX0oU72wlu
         VwXWyK1lSnBl0Ahc7zSicJcIex9EgFzK5+vvsH3YqoLONl5eHCWItKGD4vtQ6C5WwjAn
         ASxEwNREdrR33H6jXrbLSYKwfWcT/dfw4xmK0oGqr8cHm0jXLjRo1lrpLLLyYXMMWTLk
         O9nJC8E+KhF1AepPiMNLc95W/7e6SuNYVO0FlMzeFyn+oK8n8I05TSLF7wWu+VRgGoLP
         9T8w==
X-Gm-Message-State: ALoCoQmr+C9FJHtD01YlBGCWuyFdwHkqhZ9ZQkjDUcrSbPXqFknMtaf/oIn2I+wXJb3Ff3W8mhDR
X-Received: by 10.42.90.209 with SMTP id l17mr985588icm.34.1406841916411;
        Thu, 31 Jul 2014 14:25:16 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z7si52808ign.2.2014.07.31.14.25.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jul 2014 14:25:16 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id F17E15A4712;
	Thu, 31 Jul 2014 14:25:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 832F4E07A1; Thu, 31 Jul 2014 14:25:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.523.g70700c9
In-Reply-To: <1406841910-3278-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254605>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 0aad8c8..cfe1292 100644
--- a/refs.c
+++ b/refs.c
@@ -2270,13 +2270,17 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
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
@@ -2460,11 +2464,14 @@ static void prune_refs(struct ref_to_prune *r)
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
@@ -3626,10 +3633,7 @@ int transaction_commit(struct ref_transaction *transaction,
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
@@ -3684,10 +3688,7 @@ int transaction_commit(struct ref_transaction *transaction,
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
2.0.1.523.g70700c9
