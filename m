From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 36/48] refs.c: remove the update_ref_lock function
Date: Tue, 10 Jun 2014 15:29:24 -0700
Message-ID: <1402439376-25839-37-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:32:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUYd-00051B-2V
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbaFJWaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:30:08 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:44190 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-pd0-f201.google.com with SMTP id v10so138339pde.4
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3EMi9Ng3iwADF7PCJUD4/O9hi059B4JO5vOFD9iVhDE=;
        b=Ar9j6no19ANxj8dMj3Rm4RXtnDlKRCcPiIzT8l8uvf78Il2AiNBTIhhQGIq1tgUlC/
         EJr6NuxKWGSQ4Df/DwNDdY7NLkf/MCknleeGZXHu4MhMIOmHOcRUaefk9i36EC0adaWq
         EJ0iZoaz43kTb9X50XA1JhbkCmlll20S08ccb1wRpfn/K63K9UC1Dzxk1l3g+n2ge7gN
         xCA2drx2Y1BO7c/PFV9cxausWu3cCdikTXfF32nZ7uC8/4aGBuBBmkQS6MYQBSkk9ZrA
         3y7EbRtauklN+RCbUgdToWYsel4k0lCAX6Xx6iF530ng8kZ+1gM/2QC3xm0DAQAKnVPo
         R6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3EMi9Ng3iwADF7PCJUD4/O9hi059B4JO5vOFD9iVhDE=;
        b=Oix+2Z76tKNEkqDeSZAhBNyQVClX7wqk3XVt5qe93x9C1GsFlLkDhMJTSJkpq+zza+
         jW6cPubf5kcmp4vKDQWc9n66WdBOhENnhxkTFdSg/Z+ZWGjV7IKuo9qzqyTO3WqHYgFy
         vOGkNdSinGxBSrkOtA5ENabgbpMXnnbvrtZuywF02AolATZkjXeN2YqpoBCEvsN+tHO7
         mx/a6hb2PKfgmbldFw63kYLzMJpDWC/TvrjGDf37Rur5l7VtmSSE3RD3OgmVMM9l2Lw4
         6s6uN98lAK90kF2LzAMx4T1J/lHJamBsJbmgckZWpfTUQ+SFqpdIBKTcv4/yfE+OIVzj
         jL/A==
X-Gm-Message-State: ALoCoQnMrwQr9nqV67T21jq+2V973GTWDobC+lnPBCfWJvypJeMuO5aKkSq9mahZ7LmoOMhNMRfS
X-Received: by 10.66.194.106 with SMTP id hv10mr807547pac.6.1402439381503;
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si1395066yhp.6.2014.06.10.15.29.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 51F185A472D;
	Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 32AE2E0B27; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251270>

Since we now only call update_ref_lock with onerr==QUIET_ON_ERR we no longer
need this function and can replace it with just calling lock_any_ref_for_update
directly.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index ace6f87..c42472c 100644
--- a/refs.c
+++ b/refs.c
@@ -3330,24 +3330,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
-static struct ref_lock *update_ref_lock(const char *refname,
-					const unsigned char *oldval,
-					int flags, int *type_p,
-					enum action_on_err onerr)
-{
-	struct ref_lock *lock;
-	lock = lock_any_ref_for_update(refname, oldval, flags, type_p);
-	if (!lock) {
-		const char *str = "Cannot lock the ref '%s'.";
-		switch (onerr) {
-		case UPDATE_REFS_MSG_ON_ERR: error(str, refname); break;
-		case UPDATE_REFS_DIE_ON_ERR: die(str, refname); break;
-		case UPDATE_REFS_QUIET_ON_ERR: break;
-		}
-	}
-	return lock;
-}
-
 static int update_ref_write(const char *action, const char *refname,
 			    const unsigned char *sha1, struct ref_lock *lock,
 			    struct strbuf *err, enum action_on_err onerr)
@@ -3597,12 +3579,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		update->lock = update_ref_lock(update->refname,
-					       (update->have_old ?
-						update->old_sha1 : NULL),
-					       update->flags,
-					       &update->type,
-					       UPDATE_REFS_QUIET_ON_ERR);
+		update->lock = lock_any_ref_for_update(update->refname,
+						       (update->have_old ?
+							update->old_sha1 :
+							NULL),
+						       update->flags,
+						       &update->type);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
-- 
2.0.0.574.g30c2c5e
