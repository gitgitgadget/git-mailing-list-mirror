From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 18/48] refs.c: remove the onerr argument to ref_transaction_commit
Date: Thu, 19 Jun 2014 08:53:00 -0700
Message-ID: <1403193210-6028-19-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:56:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxegt-0000Hk-P8
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757861AbaFSPzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:55:50 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:38866 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757867AbaFSPxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:34 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so694258iec.0
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0SN9Arg9zmXsFCYbqnfPwkIXznRhCKXw6Dfu5pOeHkk=;
        b=DF23qxofIVhDBR2J3niKBGtCootXw2P+unPXX4ZqmE9Gc02i+zvJU/g6O8x7Jca7FN
         vdk8BPFHG10betPy5ao/bbi4uWQC0d8jddsQvIjd805Y/1M5ND7x2i0mchv308N1ddDP
         M0X0O5oK274Knj80I9jko2dr6GkHX16TWMxg4VgsGui4JCKksMHO+iELjTrs9a2LVsDS
         C+Qig6fxqvpRD1nfJ6XB3OVdudxdWXgZLxzYA2OOpXF9xeYUUWx9vpeCI7b7R/5cmHJH
         AzKMfI4NzRqwh+evHVpO76qMVGgAHr1pV63dmWkdf/edoFKNl6/GKt8nAWcezaT57yRH
         KGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0SN9Arg9zmXsFCYbqnfPwkIXznRhCKXw6Dfu5pOeHkk=;
        b=JxRiMVL/Vgo9s49EIECbJtRSjdpDDQGemcLxOlbzLU4PTre8w644H1UbpP2SkhMf6s
         MY5eFFGowXApaqapaH/seK5LJPg2DsrMZRoLy54lB24zjxBqEPlDLZ3UwDTh6oOKkIcg
         2uN+ptxXcOrjRMmNmcOMIXFFSRzqMvSYk4KB3X4d1m+trfh08Nyrf9FVV9KM83wIbZG7
         xXKXmbADGNTNEZHSzpU9QagUMxexomF/vonKqRaIi2SDf9eQ7dMYfie/1ONg5Vp8spFo
         E3htGokQPU+fFnd70Fl2j7iqx2r9FeJMHkqO6LKQzBPT62hcHjnN2LTSrDFGZw8eR+8l
         F00A==
X-Gm-Message-State: ALoCoQmtTvbb0mExmToUK/t1SccBb9HrquTRYXW6GlZXHpfPwYVUEBbKLUMqzBZfHBDlhe3Jw2cm
X-Received: by 10.182.255.225 with SMTP id at1mr2688895obd.29.1403193213514;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si419898yhb.3.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 468F05A42EE;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0A845E0734; Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252148>

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
index 003b313..4f78bd9 100644
--- a/refs.c
+++ b/refs.c
@@ -3491,8 +3491,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
-					struct strbuf *err,
-					enum action_on_err onerr)
+					struct strbuf *err)
 {
 	int i;
 	for (i = 1; i < n; i++)
@@ -3502,22 +3501,13 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
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
@@ -3532,7 +3522,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, err, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err);
 	if (ret)
 		goto cleanup;
 
@@ -3544,7 +3534,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       (update->have_old ?
 						update->old_sha1 : NULL),
 					       update->flags,
-					       &update->type, onerr);
+					       &update->type,
+					       UPDATE_REFS_QUIET_ON_ERR);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
@@ -3562,7 +3553,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
index e588ff8..163b45c 100644
--- a/refs.h
+++ b/refs.h
@@ -282,8 +282,7 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * the transaction failed. The string does not end in newline.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err,
-			   enum action_on_err onerr);
+			   const char *msg, struct strbuf *err);
 
 /*
  * Free an existing transaction and all associated data.
-- 
2.0.0.438.g337c581
