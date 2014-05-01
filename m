From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 29/42] refs.c: remove the update_ref_lock function
Date: Thu,  1 May 2014 13:37:29 -0700
Message-ID: <1398976662-6962-30-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:38:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxkq-0001dO-JI
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbaEAUiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:38:50 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:49010 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbaEAUh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:57 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so549212vcb.0
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sCILmo/Z2XRlN7hj/1x7SOqV35Bce+YVUvKpm/yRByo=;
        b=GIqjx2YroHsM3PJzwN2XhvW9H5qkw16Ken+AbCUOr3R/dwCR/p51Godq1sIy+xrdMp
         onzXPldyiv8SF2J64Ng9clAWUdTInaM3KvqIfZA2mU71Fc0Apk5AMJg9cxV8XF0KoNqk
         7hKYD46785DbIFSRxlq5i0xixe6UfBzA4EYQyoYbYK0Qjkan5G3/3Jll7w4E5QpFHhuo
         BMo7lbkRn/WPQoAzSu9Cbx06ZklLwa33t87LZbL+sU3NKQ356rQ83QxAczbrkJc0R+u6
         Cw+5SZmFAv9J0+CVq//8RABUGHnYnDXP5WmWbwEMPIzVzaLIp+auJWiCacCxlRUypqS9
         zecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sCILmo/Z2XRlN7hj/1x7SOqV35Bce+YVUvKpm/yRByo=;
        b=BEeX2ZJOw2FFFhQYLlzWRvs2BttjZ5wKAdqu8uufgOmVuGMbNgW0BgCq7pqudXd8Vk
         bcqGy8N9ecbntzbeKY2N6jg7r+kTlXgKylVtuthE0bM2HeN2+K6J66mE4CwCl6i8eCTI
         6c6WncmkgZ5RGCYPeTpABCPhOzGKplljoDG/lCLnvxIwlOqA0iv+JLGj4m/lrjvYK7l0
         oru6ifSj0CrbJ8bkaGPuN+7UwBzbDyN7beJE1GGF9O7y6vhQ/ws755svcQN3oeewNzgQ
         xugsH/pivtdasU5j7oGkkAMQwJwGpp1ldIKWXOdugCa6vWkN7TOfXVFnwUDTBqoVQlnA
         v6Kw==
X-Gm-Message-State: ALoCoQn4YSwRQlf9Sna0T1k6ObFa/8zBZ0q4CF/wgmFzFFl5SOeFisUs43Ng8Gcj3Ic6Rnd5IPx7
X-Received: by 10.58.210.2 with SMTP id mq2mr6547369vec.3.1398976676786;
        Thu, 01 May 2014 13:37:56 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g21si3538081yhe.3.2014.05.01.13.37.56
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:56 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id A1AD831C1CC;
	Thu,  1 May 2014 13:37:56 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 66A44E097F; Thu,  1 May 2014 13:37:56 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247853>

Since we now only call update_ref_lock with onerr==QUIET_ON_ERR we no longer
need this function and can replace it with just calling lock_any_ref_for_update
directly.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index 206e1a2..9f5435d 100644
--- a/refs.c
+++ b/refs.c
@@ -3235,24 +3235,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3496,12 +3478,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
 				strbuf_addf(err ,"Cannot lock the ref '%s'.",
-- 
2.0.0.rc1.351.g4d2c8e4
