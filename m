From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 3/5] refs.c: make lock_packed_refs take an err argument
Date: Tue, 19 Aug 2014 09:17:02 -0700
Message-ID: <1408465024-23162-4-git-send-email-sahlberg@google.com>
References: <1408465024-23162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:17:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJm5z-0002yN-Oy
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbaHSQRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:17:10 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:61342 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871AbaHSQRH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:17:07 -0400
Received: by mail-qc0-f202.google.com with SMTP id r5so795809qcx.5
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XBqxLz6uLmqzIMYcCcLStkKDMzEFzT42rdm8DwzLPoc=;
        b=bbmI239Gk3YOHZ7g5Ny0TGxDoOJLDq51akBkfLwrjptzq9v7pMtmGZaX2mkN0HKa7R
         CcpBdyTXb0sperCE/C16WsoioxXXN4AzOVcNDrhvgvlb4PToPGHBFC6D+J9cf1uZGZCg
         /FeqY/7imo2P+DzW2Ubqf2nBNC1mJW9/9tkAXPVywNXKeZ0TYNQbk3KIJehUhxcpTSY3
         +khC88QhAjRi48+9WK7KWCOz6yPFZf9vtEv//NkznsfDOX3Do7GtyyNOEe9Faw2HgCSR
         Zp0UEvlGa2vAI5iqiqbUTVDaLBFvO2K2Yn2S22lGcZRgXORaPNXV3HcIWNSSGqIDSONf
         Z0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XBqxLz6uLmqzIMYcCcLStkKDMzEFzT42rdm8DwzLPoc=;
        b=KRlJa887dy3hH65RsgNJ3LyKITCSJwEhAFHM0bwzjV4qaeXvkUMPPtRGsQ6ERJFIu8
         fhtoc01RGJiifuAompjVoX2gljGBnDdLVqFFT5kiFWy09MmDhXJgHFFDyyswORObqzfY
         wyKcOj5e4flrykbXl4TJZmvPD8kuQ8ugU8Q4WaYQP7r8tqVp8GhnTftB5zFMlUlNJcqw
         J0Y+MuIEZnYqUx2D0xbhLSOfbYZuq8A0mxsQP6XzsKi1kGPWnIPOn7rRc9IKhhQAFfCY
         H2teY9XcCwfhZkpCXsxlU4B5l4jCeS709yppFZXDERmTgFw6TeVBZa9+rkHiggYYhDEx
         EYeA==
X-Gm-Message-State: ALoCoQkx/qJV+zaH8sYhrcTAMl7r7GJhjVmdvEngCTAaG0byEx188VK6Fy7XSF1KgX8KBLWqZDPG
X-Received: by 10.236.17.234 with SMTP id j70mr18984715yhj.26.1408465027192;
        Tue, 19 Aug 2014 09:17:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id x19si329783yhg.0.2014.08.19.09.17.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:17:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 09B3931C529;
	Tue, 19 Aug 2014 09:17:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A312CE0F01; Tue, 19 Aug 2014 09:17:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.ge8f7cba.dirty
In-Reply-To: <1408465024-23162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255465>

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
2.0.1.556.ge8f7cba.dirty
