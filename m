From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 14/15] refs.c: make lock_packed_refs take an err argument
Date: Tue, 21 Oct 2014 13:36:59 -0700
Message-ID: <1413923820-14457-15-git-send-email-sahlberg@google.com>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 22:37:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XggBY-0000sF-Q2
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 22:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933308AbaJUUhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 16:37:34 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:33693 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933104AbaJUUhF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 16:37:05 -0400
Received: by mail-ie0-f201.google.com with SMTP id rl12so305896iec.4
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 13:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2yAFvSaSLfBOJu2Gfc+8MFqKWICrFXJGyWfPLNzwloA=;
        b=JnZsDTEFSKS84NaQUMexCTOBx3h2ePYvYYnUpzugJDudOtuOYWCyF6JwHlqYKRmZdX
         rpw/bDXEluo4fg4ml/p2g8elacFa1TePjX8YxFreQiVgBsz5MS7fpKlOounIYF7jIJHq
         1zncvHy6tz3INL+8THXq8kyTsDRFlfN48ObCKqycfArYdStlZakdh1ZFqWR2uWBTLtgR
         f9FG0Y7DFpzBUzYXk4K0oLouV0z/12wD4LicOpQx+r9b+2OUJ/n69ClP450uooNWi2LQ
         e4PhNsRHOKezW8lQyMQJRDbWL8g4JYt976iDv/TznO+H5KVXPe5buojTtVnLXJbPKh24
         OUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2yAFvSaSLfBOJu2Gfc+8MFqKWICrFXJGyWfPLNzwloA=;
        b=BUAVOxKaJKc4Z3TZ6HkTtNMs5m2uENv3cGhqSvFi/wYjruJxnhOsJOQ5TnfE3s1hd1
         4XKOvFLwUNhJqhNcknLli0tKRRbwN+tZT5KalDlwRd9Yo/2a5WnWrYnit9cTH047MM/R
         tNJ3ITNCFFNjcM7FyQJb4AZzBo6ttaHVqzctov4wiBEGRPWMimObf9cCoieG65DPAgwt
         ST1FGmGs1Of2Cot0c6pSszuCYAn15DwVhRzci83pM43f0XdoKxFDRhUNZFjJLbUs6wOj
         Q/dlHIuCcZltOiip4o6zkukzCT6rns59yaTLR3E+dFo9ppCgem+1bKy2YVnRUkPDb7tv
         m2NA==
X-Gm-Message-State: ALoCoQmWEJI7j2JT6lRFr5qxqFsPLk66EaV/4xrDZZoP+AdJp78LxgtRBUexLjaufpKmbkl5ONj9
X-Received: by 10.42.200.206 with SMTP id ex14mr492858icb.4.1413923824146;
        Tue, 21 Oct 2014 13:37:04 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id e24si595477yhe.3.2014.10.21.13.37.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 13:37:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id KTj1wGy2.1; Tue, 21 Oct 2014 13:37:04 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2698CE11B0; Tue, 21 Oct 2014 13:37:03 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.738.gd04b95a
In-Reply-To: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change-Id: Ibfc64ab19257484129ab0ad861b72c02414388df
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index e0d5a82..7fb0d6c 100644
--- a/refs.c
+++ b/refs.c
@@ -2393,13 +2393,17 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
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
@@ -2587,11 +2591,14 @@ static void prune_refs(struct ref_to_prune *r)
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
@@ -3757,10 +3764,7 @@ int transaction_commit(struct transaction *transaction,
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
@@ -3815,10 +3819,7 @@ int transaction_commit(struct transaction *transaction,
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
