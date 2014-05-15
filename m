From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 09/44] refs.c: remove the onerr argument to ref_transaction_commit
Date: Thu, 15 May 2014 10:29:24 -0700
Message-ID: <1400174999-26786-10-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:32:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzWR-00039P-5P
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859AbaEORc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:32:27 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:47894 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755387AbaEORaH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:07 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so255933pbc.4
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6t47aiqogAtbPIOGdmx3v7vsjya8TE025HJ0ai6zCoY=;
        b=GFYbh/GhB+7moaKbzJPWPWIIz/5epwmB/OYGTD4AvLCeJPbiId3vJxrBjPa2uYRh/C
         M676bl46g5S/dl5mqNIZKZg6s93hRxGqALBdHQFWR3DOXgg5QAZMJdB/2BbfERRMiYAG
         AY4NFKDZpAYn64cTzQIi13V4NR9Ond4BzAZ6eWctsIaH554Rj4zeBI5NPI/jgroUqNLG
         eq2/Xax/u8QtF1Q28E5LDhLhJbenXeJSyoAPFxet4cfFYXELatPafxxxC4s097cAs5u3
         mstiLrHtExXCdP8cNDW8mPPGcDbN4C4PAeWNbkYagoiCW8FzuO2FYIEEbzFqIElvwn6c
         s6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6t47aiqogAtbPIOGdmx3v7vsjya8TE025HJ0ai6zCoY=;
        b=UpRcXy9O/Aiu0EIrr+MJ5TFcXVJRPsagaNIrMgk9yCfXlh/0jJ2hmeKNyDnKSQeEpE
         mJchEVff7O/dab3+BFX8Z47D3ZB2NEZm0WiWjDQHcRa2nXMl1/A5q7VZjWPj48F3cWzG
         dQrSJwpJZ2Tk11unSd0ZZqfkaHAMWD4MSIOI79g/3qpmtK9YPCsXH+wVd94YZhcsZAXz
         dpu75sXqCSD6JI8Bnov4YM3BKYwv999iXDUCDrqomdhrrLnxlBE41cNFRylIvftKcRKP
         /200284JG+l294YKCK53sNUcT5VrRPaV9ESZwY749et+SGqvulXNYUUzLrmdYkIw0JyL
         v3QQ==
X-Gm-Message-State: ALoCoQnCSrswQsHadQBBwJyc5d2q62XoxbOrPk4boBaHQMeAGLwfyV8DTbxaIkvLPVUdK9nf/rHi
X-Received: by 10.67.4.170 with SMTP id cf10mr2961086pad.31.1400175006324;
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id h18si274174yhj.0.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 082605A42E1;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AB8C5E1530; Thu, 15 May 2014 10:30:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249163>

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
index 207e24d..2bef2a0 100644
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
 		return 0;
 	}
diff --git a/refs.c b/refs.c
index 18dff1b..bc21060 100644
--- a/refs.c
+++ b/refs.c
@@ -3416,8 +3416,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
-					struct strbuf *err,
-					enum action_on_err onerr)
+					struct strbuf *err)
 {
 	int i;
 	for (i = 1; i < n; i++)
@@ -3427,22 +3426,13 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
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
@@ -3457,7 +3447,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, err, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err);
 	if (ret)
 		goto cleanup;
 
@@ -3469,7 +3459,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       (update->have_old ?
 						update->old_sha1 : NULL),
 					       update->flags,
-					       &update->type, onerr);
+					       &update->type,
+					       UPDATE_REFS_QUIET_ON_ERR);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
@@ -3487,7 +3478,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
index 25ae110..555ee59 100644
--- a/refs.h
+++ b/refs.h
@@ -278,8 +278,7 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * the transaction failed. The string does not end in newline.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err,
-			   enum action_on_err onerr);
+			   const char *msg, struct strbuf *err);
 
 /** Lock a ref and then write its file */
 int update_ref(const char *action, const char *refname,
-- 
2.0.0.rc3.477.g0f8edf7
