From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 07/42] refs.c: remove the onerr argument to ref_transaction_commit
Date: Wed, 14 May 2014 14:16:41 -0700
Message-ID: <1400102236-30082-8-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:21:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkgcA-0001WN-TP
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbaENVVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:21:13 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:45608 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901AbaENVRX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:23 -0400
Received: by mail-ve0-f201.google.com with SMTP id db11so34040veb.2
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H+wI05mKDJPG4s7YQ30xi+8Lyzyq+75ejX/q78ILWGY=;
        b=nxcDgMzwxoa1S3z6HkDPwiGXxCCm8rAAmZsFQLmoKZNSLoW9If1cs5EPLNUXNlm+/+
         DOfRO4cnOs+V4jAVk/ixmLYpVIIPII7wYHdeirTcjP4kX4uDKbeuuMVg3XzpbF2nM0FZ
         nZCYGJOOBDGUUdAJgtnWMrPtpIDeRMui7UxHD5EtbBtvM2AXqSOdM6JkZGnGeaXXltJF
         epCEOiFy/Z9X3tsVzOozUmPU/ifXImQ+zlA8UBIgonUAWgWyhOC9KIIkkYWprPNTUGHl
         8BSVsS7CziMbN62Yc1VBlLY7sp5iaYdkF5/7xkpu8acXxhKST807SPNs+PdwJ45jQSDU
         MlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H+wI05mKDJPG4s7YQ30xi+8Lyzyq+75ejX/q78ILWGY=;
        b=jWaA3E8/rQ9PruVm9QlA5pAk6hmzMk8jPPz9ObyM+nA4qOC4IsK3wg7aU19Stv1AO0
         96fTJumTSzr4GJ35vPWFm4tNs8o6ohV0vcVkM7uJcw1P+NP0y0Hx42+5COAYMjH4bNaP
         mn/wQo3Mb+fyTZpvzw4imsS9EHy140PEfbR9mJzgaaDHEmrBFkBRh+9VfLXS60euTIuk
         MAFDZRU0gJpk5eA9jERK+mX11D6VzYHeBay4+Ih+tXwh4/4mer56VI5i9ijzZdo8i3lH
         +y6bRop7oTEQNdmIBMP/17+ua5czywZuVl7QbBZRNw0Vwcq9GHj5yZN69U1SwyeN7Lbr
         ngSw==
X-Gm-Message-State: ALoCoQlB3keSBkSsqin2XXrH9MmXLNJeieIWGYSUF/A89alAWwe0nIzpMyK/kyOH3veA4Imn9dRx
X-Received: by 10.236.110.68 with SMTP id t44mr2720175yhg.31.1400102242247;
        Wed, 14 May 2014 14:17:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si145192yhk.4.2014.05.14.14.17.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id F1C385A4292;
	Wed, 14 May 2014 14:17:21 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B62BEE0973; Wed, 14 May 2014 14:17:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248992>

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
index 8051aac..bfba348 100644
--- a/refs.c
+++ b/refs.c
@@ -3405,8 +3405,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
-					struct strbuf *err,
-					enum action_on_err onerr)
+					struct strbuf *err)
 {
 	int i;
 	for (i = 1; i < n; i++)
@@ -3416,22 +3415,13 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
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
@@ -3446,7 +3436,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, err, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err);
 	if (ret)
 		goto cleanup;
 
@@ -3458,7 +3448,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       (update->have_old ?
 						update->old_sha1 : NULL),
 					       update->flags,
-					       &update->type, onerr);
+					       &update->type,
+					       UPDATE_REFS_QUIET_ON_ERR);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
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
2.0.0.rc3.471.g2055d11.dirty
