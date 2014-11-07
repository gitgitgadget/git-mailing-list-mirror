From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 15/16] refs.c: make lock_packed_refs take an err argument
Date: Fri,  7 Nov 2014 11:39:04 -0800
Message-ID: <1415389145-6391-16-git-send-email-sahlberg@google.com>
References: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 20:49:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpX7-0005f5-Fo
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbaKGTtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:49:08 -0500
Received: from mail-oi0-f73.google.com ([209.85.218.73]:51204 "EHLO
	mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975AbaKGTtH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:49:07 -0500
Received: by mail-oi0-f73.google.com with SMTP id e131so546693oig.0
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 11:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ePrLbiXb1Llk1ucyNJ3+DQ3J8yGGwqkineUWKaVPNyE=;
        b=TT7S1FJD9j0VND0/Z6rm2T8MYwdno1a95DRajTVuT03MHYAH7IVMbQ8/HDd1c9IbCM
         Irqu9W+8fx2XQTtI6w7fO54EyFawDDo09YwcSBxpuyiMf351tCwOOo1K8Q8nq03ZjbpS
         Kp3/vj6lTtHD1o1wLAtJT+QhbKeGKX67dxTp1Nzb8LztRHr37cqx8kWmtKFXpoCL7q2Z
         KJlTcU5lsNS/ffKEcHUK4o+o6rO6O10uRzgijanZ8Z3VLoRXKMWjn+rqEZpcqJL4JdC+
         fJ7SBr53EfnusQYKHGQsoKC89i3GHvJpp0BAWyGnXQmIyY8fqWlKFsbakuq3u4I17M8h
         wTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ePrLbiXb1Llk1ucyNJ3+DQ3J8yGGwqkineUWKaVPNyE=;
        b=Ee6nJjfNu/sGh8EJ/5trKTVlvag7h8j2uJRVBl0neG5SRqW8TmEK+JFaAfUFGwY+Hr
         mTNuY+rvpN0ilyhM/n60BUwV2CR7nDXfsVf3klrf+kdcxbFKqwrJqNZycYEShKn0rKVj
         qfulwvs7Xhc8RnLt9ATamzd0ApYv7QllgzxYSAfHbWQYW61TAXoerXZZBZ93NhHHnxyB
         vBwszIfHsjpo3GTwu7NnzJJBL0qORirCjybQOwjq0ompatmnkEI5uzmTGxMHXxlyG/56
         lQ7PVC4RFtGSGkDwuMTuhPxI1Jj66afHnym83xPuzNLAmTI6mOWii+GfGj7Q92WI4tq0
         0/lQ==
X-Gm-Message-State: ALoCoQkl50BVhjuDBVLvaGMThsko4X5G3nhmArec8/ngOYxarvKSlRZ3H1G7kG0xshclsiYaccjV
X-Received: by 10.182.104.69 with SMTP id gc5mr11064457obb.18.1415389746663;
        Fri, 07 Nov 2014 11:49:06 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id k66si401589yho.7.2014.11.07.11.49.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2014 11:49:06 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id g5OsVHcl.1; Fri, 07 Nov 2014 11:49:06 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0F735E0F5D; Fri,  7 Nov 2014 11:39:10 -0800 (PST)
X-Mailer: git-send-email 2.1.2.810.gfbd2bf7.dirty
In-Reply-To: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 0829c55..1314a9a 100644
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
@@ -3789,10 +3796,7 @@ int transaction_commit(struct transaction *transaction,
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
@@ -3847,10 +3851,7 @@ int transaction_commit(struct transaction *transaction,
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
