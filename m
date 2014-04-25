From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 07/19] refs.c: remove the onerr argument to ref_transaction_commit
Date: Fri, 25 Apr 2014 09:14:42 -0700
Message-ID: <1398442494-23438-8-git-send-email-sahlberg@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 18:15:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdimu-00076U-1l
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 18:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbaDYQPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 12:15:14 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:57032 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761AbaDYQPE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 12:15:04 -0400
Received: by mail-yh0-f74.google.com with SMTP id f10so629753yha.1
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 09:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=loRcDD0fqL5N0Tw+xLvPOThKWe84nczSmpogFmKKG58=;
        b=H9IcxBhskVc5/rAvRczS22Kn/x0pq8ohOM33atrJ6UMOjVUoQ2iFDa806hfMEDa6Ji
         su3gDNXG4yoh1fjcuZk/23k0hepnR9ha9n7AiTOnvLNiW0sB77OtAAGOSXoo+egI4HsZ
         W0AnsU4UvETN3Bvc/8k4YwRkrnnd2HdMQC+tT1Se2ZfcWT2tcUOx9qTJPdzMS/RoqEzC
         YYWsMFT4H1gZNSur/NDEg5xQ3z4XsSiZPJlq04hP4jrDB117vZqWGOcUXhPDtvUDQ8RZ
         8OJ8gnjQU90KxaxV3axNsdez/pvqvex2Drncx4kzZL8Zch0rupjDQfYyCGcNmUAmcliS
         cIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=loRcDD0fqL5N0Tw+xLvPOThKWe84nczSmpogFmKKG58=;
        b=XRr3R5HsODOnsbHn43edn5jAM9MYcf+G9nFAowIqXCYkrVz6UB3yJQ6iE62QWgmHVY
         gJxx4uDQXpJRQ2/cgyJAHD2aRymnDqLo5PSW3CIUWjzAz9wOE/Ygt+veRM4ARtUUXQeb
         vjQwQNGUhv+0wmTxH8RSsrOhas4hxmydF9xMyQwwS6w7snxpQ+b7NzkO9W+O59KhL1Bw
         wyXn0OL4breEFtccfdEENrkLIJ6PIrxgWIRP98RofybgKmGuYiWIDos/IvLEvCf5M6jg
         411GIMm+SFNrcnqDplZ8ndzUiTD27HqyDmt1tQu13lcbm1HD7zEfvOvy9T2PhuYmzXhb
         Yz/A==
X-Gm-Message-State: ALoCoQm7N+IFDt/4YEcishOncUhK2XRy+9hJGHzObDmpMF7yjqVR3F7iBOIvfiuHPRNPBZJlgVL5AVNMcJCcxSMfG2KJ77CRN+NM2lYQQ4mQlj4RwHfbi9/tZtZDkM6LcHstz7zeTuU5gWYKGvow71dVrLHkZJ0HnVy4/xkWjqZ8Acclp93gYLSKUzEp9mjwLWeTBdtomwV3
X-Received: by 10.236.130.101 with SMTP id j65mr2963692yhi.29.1398442502688;
        Fri, 25 Apr 2014 09:15:02 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id g21si1051085yhe.3.2014.04.25.09.15.02
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Apr 2014 09:15:02 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 714165A4260;
	Fri, 25 Apr 2014 09:15:02 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E6849E0B12; Fri, 25 Apr 2014 09:15:01 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.521.g5dc89fa
In-Reply-To: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247053>

Since we now pass meaningful error messages back from ref_transaction_commit
on failures, we no longer need to provide a onerr argument. The callers can now
on commit failures die() with a meaningful, and in most cases even better than
before, error message.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  3 +--
 refs.c               | 22 +++++++---------------
 refs.h               |  3 +--
 3 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 47c9b53..df3cd92 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -368,8 +368,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		if (ref_transaction_commit(transaction, msg, &err,
-					   UPDATE_REFS_QUIET_ON_ERR))
+		if (ref_transaction_commit(transaction, msg, &err))
 			die("update_ref failed: %s", err);
 		return 0;
 	}
diff --git a/refs.c b/refs.c
index 7562151..0e2df81 100644
--- a/refs.c
+++ b/refs.c
@@ -3397,8 +3397,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
-					char **err,
-					enum action_on_err onerr)
+					char **err)
 {
 	int i;
 	for (i = 1; i < n; i++)
@@ -3410,22 +3409,13 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 				snprintf(*err, PATH_MAX + 41, str,
 					 updates[i]->refname);
 			}
-			switch (onerr) {
-			case UPDATE_REFS_MSG_ON_ERR:
-				error(str, updates[i]->refname); break;
-			case UPDATE_REFS_DIE_ON_ERR:
-				die(str, updates[i]->refname); break;
-			case UPDATE_REFS_QUIET_ON_ERR:
-				break;
-			}
 			return 1;
 		}
 	return 0;
 }
 
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, char **err,
-			   enum action_on_err onerr)
+			   const char *msg, char **err)
 {
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
@@ -3443,7 +3433,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, err, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err);
 	if (ret)
 		goto cleanup;
 
@@ -3455,7 +3445,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       (update->have_old ?
 						update->old_sha1 : NULL),
 					       update->flags,
-					       &update->type, onerr);
+					       &update->type,
+					       UPDATE_REFS_QUIET_ON_ERR);
 		if (!update->lock) {
 			if (err) {
 				const char *str = "Cannot lock the ref '%s'.";
@@ -3476,7 +3467,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			ret = update_ref_write(msg,
 					       update->refname,
 					       update->new_sha1,
-					       update->lock, err, onerr);
+					       update->lock, err,
+					       UPDATE_REFS_QUIET_ON_ERR);
 			update->lock = NULL; /* freed by update_ref_write */
 			if (ret)
 				goto cleanup;
diff --git a/refs.h b/refs.h
index 615c73d..f3db632 100644
--- a/refs.h
+++ b/refs.h
@@ -272,8 +272,7 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * why a commit failed. This string must be free()ed by the caller.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, char **err,
-			   enum action_on_err onerr);
+			   const char *msg, char **err);
 
 /** Lock a ref and then write its file */
 int update_ref(const char *action, const char *refname,
-- 
1.9.1.521.g5dc89fa
