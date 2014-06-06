From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 11/40] refs.c: remove the onerr argument to ref_transaction_commit
Date: Fri,  6 Jun 2014 15:28:49 -0700
Message-ID: <1402093758-3162-12-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:31:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2f7-00033e-EZ
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661AbaFFWaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:30:46 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:40561 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbaFFW3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:23 -0400
Received: by mail-qa0-f74.google.com with SMTP id j5so679353qaq.1
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/FtXrihH7ulkmuYiSSZxikEdZaoUhoKqyt05QOOGLgw=;
        b=I03LlzlRPZcqzddW+9CCjQ+3tN0Rx8P8N/YJo4DhXfMiBjWe9oWpew3/dIyDBCbS1T
         HMg9SYXvLvnNxspsPHopIj9SArdOzRkDeX95gIby+axwT8JakIrIocf9ecj9m/JD+Vb8
         0Q9xKl7NvGwCk9oURJxQjNLAkqLuIy+ov+8ob5IsK6KNfNeuoJ0H4ZW3AfoUMA6ldvFC
         wBln4OaSYUhou2C4vIC1LAw1AP7JjeX7tG0khfbHiaqzXHk6ZU/dxHEfIH/CrxkbbYWC
         JqXahz31UPa3QcGIzeN351+UMUTH6nGcPuYnQKyX8MqMkj/jH1ruXuyEbbggVLSKPswn
         m1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/FtXrihH7ulkmuYiSSZxikEdZaoUhoKqyt05QOOGLgw=;
        b=ODz1vppybbiIGi2Vkgq5rYYtIsrgO0T2MuLFOom86L3G2uOdWKgkF+un5pgtHidkfs
         6Rp5u+NHa4e2Y2q4OHPeIMqd5/84Ny62CecSRKU2IkM0vcncQhIQ+jvqg/ExgHPLfNms
         xPo+fVUSLo69AcUw++FQmPiC15b4b2FH0nYXOZgkUVLU6o6xQSgVI6LJs7TqyFAzh2r5
         hWSmZteGAMxkA9HYkjJh07ejBdpGjafaInd3601f6sZESNUykmvSu2uygCkKmnFH8Iqf
         iXaGX0vSOXZtiKxS4NbprmAQJc5KtZWiKWHBrc47Nk/W6/HtYFfmZV4Oq9yNp+X17HOB
         3TCw==
X-Gm-Message-State: ALoCoQnsxhrbRx9VunI8huzC3IEIFtQtIDUCXkBWJj0MGefDgL5bsfvoo2VZux5lO7zF/eVFWfTS
X-Received: by 10.58.127.66 with SMTP id ne2mr5249831veb.27.1402093762185;
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id ds6si750430vdb.0.2014.06.06.15.29.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id C92A75A44F9;
	Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 86467E09AC; Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250999>

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
index 6696082..fb44978 100644
--- a/refs.c
+++ b/refs.c
@@ -3481,8 +3481,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
-					struct strbuf *err,
-					enum action_on_err onerr)
+					struct strbuf *err)
 {
 	int i;
 	for (i = 1; i < n; i++)
@@ -3492,22 +3491,13 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
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
@@ -3522,7 +3512,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, err, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err);
 	if (ret)
 		goto cleanup;
 
@@ -3534,7 +3524,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       (update->have_old ?
 						update->old_sha1 : NULL),
 					       update->flags,
-					       &update->type, onerr);
+					       &update->type,
+					       UPDATE_REFS_QUIET_ON_ERR);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
@@ -3552,7 +3543,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.582.ge25c160
