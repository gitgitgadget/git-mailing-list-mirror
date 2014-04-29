From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 07/30] refs.c: remove the onerr argument to ref_transaction_commit
Date: Tue, 29 Apr 2014 15:18:52 -0700
Message-ID: <1398809955-32008-8-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:20:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGOP-000335-CX
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965349AbaD2WUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:20:40 -0400
Received: from mail-ig0-f201.google.com ([209.85.213.201]:36886 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965265AbaD2WTV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:21 -0400
Received: by mail-ig0-f201.google.com with SMTP id l13so76363iga.4
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PkXAIKj6syo1ebsSYrlBaIdVYt0LEMQbeteXpHqX5Uk=;
        b=LIXqHyeczK+YPu+pbsHSurvq1smVpYLDaosaptcEnPIpTcszTfM8B0mC4jsGMQq8x7
         ZnfwMeVEdnexdk6jhta2tZnuXqlpimJKWOCdZC1NYHG8x6QvFv2snyFdrJGOueSpFu3j
         MUgLrUyQ1tuKW44aObflSZn2oa7vrtNgySpAhyYRxKO65DWAjYUhEAFzkhKIatur0it/
         vgSU+MquvzKAikapvs0S9Drq53UW+dKqQ2kENZg7UIHD3EAhkDdelDnP+RITh+xz/dNz
         YWIsjdGwhPygdBqdiKjcwl1XxNzPqx0lgw0OENFrXQyd313MB2f+vjjExGvrfUL2eChz
         gsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PkXAIKj6syo1ebsSYrlBaIdVYt0LEMQbeteXpHqX5Uk=;
        b=L4ppR7nZgtx5+/eyYcpk8QT/SDAtTnH6z6FgDqDchNOEzlJwY8NbhBE8mSrOmZKIjd
         dqIO3M6eVlCrG5YCHeIhCuXzkhDhy1z0JLugkFIdWOL81IrWVSw+DsfKIz+HLxfd08Dw
         FPKTeaMMh48BuzK2UgvQnkFgo3X/QO+HEhofWRmuSJRgx0uV3ksRDo4BTIZDJolfGGgJ
         KyjKARviR1RHMftNII24ZXS8zDEkp+4R3V/aY5psQHCCnFrCA+vgjFNetL/iAd0fG0aF
         5Qlxyc//lZPUkcO8dCig1UErVnulPUhEXaOkeUo8QSwROy9O8JdvNiQsst+KgvHW8+qA
         2YoQ==
X-Gm-Message-State: ALoCoQl18IvdgjTVvHvMYTU44gZZ18M7vcjdHcs58NcZG6ISmx7Eu1s0c0NI4y0uOxy1f24nevyLfE+iHye9VtOCM95AlEFeeV7s3fpVkOn/yoj6AqcHL/7fnIHiZVlCGaGVJK4TH4neu1yXpXjo7v8RGEwdOeS/qldKrgfacOroqcvAgpHsQCKIvh62PJ9yF1SKVKd9Pipc
X-Received: by 10.182.219.226 with SMTP id pr2mr311230obc.44.1398809960708;
        Tue, 29 Apr 2014 15:19:20 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si2739351yhk.4.2014.04.29.15.19.20
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:20 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 678325A4121;
	Tue, 29 Apr 2014 15:19:20 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2C0E4E0A5B; Tue, 29 Apr 2014 15:19:20 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247643>

Since all callers now use QUIET_ON_ERR we no longer need to provide an onerr
argument any more. Remove the onerr argument from the ref_transaction_commit
signature.

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
index 5e06fd9..308e13e 100644
--- a/refs.c
+++ b/refs.c
@@ -3396,8 +3396,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
-					struct strbuf *err,
-					enum action_on_err onerr)
+					struct strbuf *err)
 {
 	int i;
 	for (i = 1; i < n; i++)
@@ -3407,22 +3406,13 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
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
@@ -3437,7 +3427,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, err, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err);
 	if (ret)
 		goto cleanup;
 
@@ -3449,7 +3439,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       (update->have_old ?
 						update->old_sha1 : NULL),
 					       update->flags,
-					       &update->type, onerr);
+					       &update->type,
+					       UPDATE_REFS_QUIET_ON_ERR);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err ,"Cannot lock the ref '%s'.",
@@ -3467,7 +3458,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
index ff87e14..bc7715e 100644
--- a/refs.h
+++ b/refs.h
@@ -272,8 +272,7 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * the transaction failed.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err,
-			   enum action_on_err onerr);
+			   const char *msg, struct strbuf *err);
 
 /** Lock a ref and then write its file */
 int update_ref(const char *action, const char *refname,
-- 
1.9.1.532.gf8485a6
