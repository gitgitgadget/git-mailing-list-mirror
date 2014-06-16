From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 19/48] refs.c: remove the onerr argument to ref_transaction_commit
Date: Mon, 16 Jun 2014 11:03:50 -0700
Message-ID: <1402941859-29354-20-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:08:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbKR-0007V4-Kb
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648AbaFPSHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:07:11 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:37481 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932643AbaFPSEY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:24 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so1153577iec.2
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4UBgP26XirI2Mdbk8bLkdYXr/2uNsC93grarbfiA6P0=;
        b=XJT39NjPiBrKGZpaL4fPhbqnGs9XQiPBF+X/3Mybdxm759AMzl5eO0w6g5yNpSDemz
         +BopKTA3IBCHA2TbnQfrxMK25lHiEvqs6ewkAP7iV3fKN+nmrCKGS3fWBb5OpQGbyHLV
         5XWkcOp79N0zWHNNI3ZxWwN8Eij7RB74UJc6bokjbUcRtQ/ngkg792hRwlgpbJyrhQ0e
         io5Of5Ar/sYZChCVb8538xn59/wrrt89iUXx90jTBCp4jKNGKgJAacQI/VmhBe1n7l1q
         0stVBTnsTJGD3/nMk5cm/O6ke0w4rqRSzLSYV1hdVu1kbEGi8v+1BqwUgyRLIIWDydxh
         20+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4UBgP26XirI2Mdbk8bLkdYXr/2uNsC93grarbfiA6P0=;
        b=jZ/GgkJiXwg/tSBTlQQkUWIeoawF8xpXhDsBOBjpBleXUM42JXidpJvzqQkZ1740UK
         2IaVR//OB2QuKe/K5l5Qq4UmrcLUSV304RmEReQjCWNCB3lW7B3TNPdrpy9XMkkApNtG
         ZdmvVr/Kl9fvZSgzpYG3Lff2AU9ZxbwWtwCobqErvRS6GIMA00dlgNRgDzKWFL64JIpw
         L+e6DkMyjurWs8oMKoxRZVanjrO+ncqdEc31XheennTCtfrtlCQbqCyY457chqF7w2Rd
         6ca5TmAdaWYLVVQK7D52VY4+sfWqADrB9ypzugggXnF2QhPAAgRTR8ZDaDeJ4caEb01u
         YYrg==
X-Gm-Message-State: ALoCoQnHxs/fugPMSWXzXH+0OeRJ0CvikSn7tG1xgqd0x+YqqpLySt4Gcs3GlEsJJSPZwb1usqYI
X-Received: by 10.42.94.8 with SMTP id z8mr2194icm.3.1402941863156;
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si997324yhk.4.2014.06.16.11.04.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id D672E5A490D;
	Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B2E51E0F37; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251778>

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
index 59992bc..fdbd107 100644
--- a/refs.c
+++ b/refs.c
@@ -3488,8 +3488,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
-					struct strbuf *err,
-					enum action_on_err onerr)
+					struct strbuf *err)
 {
 	int i;
 	for (i = 1; i < n; i++)
@@ -3499,22 +3498,13 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
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
@@ -3529,7 +3519,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, err, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err);
 	if (ret)
 		goto cleanup;
 
@@ -3541,7 +3531,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       (update->have_old ?
 						update->old_sha1 : NULL),
 					       update->flags,
-					       &update->type, onerr);
+					       &update->type,
+					       UPDATE_REFS_QUIET_ON_ERR);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
@@ -3559,7 +3550,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
index 86f0984..1eb447d 100644
--- a/refs.h
+++ b/refs.h
@@ -278,8 +278,7 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * the transaction failed. The string does not end in newline.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err,
-			   enum action_on_err onerr);
+			   const char *msg, struct strbuf *err);
 
 /*
  * Free an existing transaction and all associated data.
-- 
2.0.0.282.g3799eda.dirty
