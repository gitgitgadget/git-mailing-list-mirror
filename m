From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 11/41] refs.c: remove the onerr argument to ref_transaction_commit
Date: Tue, 27 May 2014 13:25:30 -0700
Message-ID: <1401222360-21175-12-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:28:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNyW-0004YH-Gs
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587AbaE0U1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:27:40 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:35535 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897AbaE0U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:05 -0400
Received: by mail-pa0-f73.google.com with SMTP id lj1so1510474pab.2
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=axrgEn79E/RACXA0/gX5yL/JuekV/yNtbU6N0m2vyv8=;
        b=eYWraYiDiHTC1FTf5PasYTyUYzlYOyGsXkVYIHPuF5w8vHutSyxlDXwjWUOmLH/dDA
         hufR6j9zfTscB4+UXdgBm8qvZwnuC/1wHTH7+RWCh7MjMbGa9aVoRGWxgZJ70vhFxyBt
         Sgc5cxU7ECxcBurdTZAn6PS6OgpkGC9XZOQ4hfWyWJi0fDY+wPHcnkmEgS3PhgM+YjzA
         nSzbaJSBc9hX0OgxihY3ROwxs9CftljRL14HKgKirD/N1AHwj+hK1TcaJw1EF+mdq3vh
         umMl2+J9gxHhGN5ATG6WEwimu1rYN9YAL/lO9YfAqgKP6rBCsm1Cznb0FeZW6jQT2ZqD
         soGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=axrgEn79E/RACXA0/gX5yL/JuekV/yNtbU6N0m2vyv8=;
        b=gMX32nfyxtcl/zEGDj0m/7lnfaRDfcjAtRJIFSyXyci845Q6m75/rI2eiipUWlnrMF
         YVleXboe+IuzfbVpk/u2tmgcdj9ppGXcyrgZ/jhinKneWJum2o7zTRlE/+yuH9otjN1O
         RfpnAVtvZPRIcgcgZlck6sO9cKiXioTTsC9/OhINOLeiVjHPkBkleIrAHdGW6QlQmB7E
         GmesNnv2vmTUXHQJ7Q36UWgh9uhOvqXaxHIck+1UcTxgtlZEzmp/W5P2fERGj48v6WWt
         InDNn9g/0HrPkr+cq8RxH/2McEAdr0l7cx+GhqF+IS9o+Mh2nZjm+/QdJvSiddrsGE20
         TD4g==
X-Gm-Message-State: ALoCoQmH8l4rL5/iy+nL2gfMOiXA8TyeJR2K2Ts7xBDxhc3XglgVFRDZctJ/N2nKFu2hl5nvg+C3
X-Received: by 10.66.246.196 with SMTP id xy4mr3451364pac.11.1401222364360;
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id h13si137570yhj.0.2014.05.27.13.26.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0CC2637053C;
	Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B00ACE14EA; Tue, 27 May 2014 13:26:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250227>

Since all callers now use QUIET_ON_ERR we no longer need to provide an onerr
argument any more. Remove the onerr argument from the ref_transaction_commit
signature.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  3 +--
 refs.c               | 22 +++++++---------------
 refs.h               |  3 +--
 3 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index aec9004..88ab785 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -366,8 +366,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		if (ref_transaction_commit(transaction, msg, &err,
-					   UPDATE_REFS_QUIET_ON_ERR))
+		if (ref_transaction_commit(transaction, msg, &err))
 			die("%s", err.buf);
 		ref_transaction_free(transaction);
 		return 0;
diff --git a/refs.c b/refs.c
index b28f7d4..00b6e9a 100644
--- a/refs.c
+++ b/refs.c
@@ -3439,8 +3439,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
-					struct strbuf *err,
-					enum action_on_err onerr)
+					struct strbuf *err)
 {
 	int i;
 	for (i = 1; i < n; i++)
@@ -3450,22 +3449,13 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 			if (err)
 				strbuf_addf(err, str, updates[i]->refname);
 
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
-			   const char *msg, struct strbuf *err,
-			   enum action_on_err onerr)
+			   const char *msg, struct strbuf *err)
 {
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
@@ -3480,7 +3470,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, err, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err);
 	if (ret)
 		goto cleanup;
 
@@ -3492,7 +3482,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       (update->have_old ?
 						update->old_sha1 : NULL),
 					       update->flags,
-					       &update->type, onerr);
+					       &update->type,
+					       UPDATE_REFS_QUIET_ON_ERR);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
@@ -3510,7 +3501,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
index 94d4cd4..6ee9c9e 100644
--- a/refs.h
+++ b/refs.h
@@ -270,8 +270,7 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * the transaction failed. The string does not end in newline.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err,
-			   enum action_on_err onerr);
+			   const char *msg, struct strbuf *err);
 
 /*
  * Free an existing transaction and all associated data.
-- 
2.0.0.rc3.474.g0203784
