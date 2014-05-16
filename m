From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 09/44] refs.c: remove the onerr argument to ref_transaction_commit
Date: Fri, 16 May 2014 10:36:57 -0700
Message-ID: <1400261852-31303-10-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:40:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM6v-0003E3-Eu
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758149AbaEPRjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:39:49 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:39470 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757237AbaEPRhi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:38 -0400
Received: by mail-oa0-f73.google.com with SMTP id i4so587499oah.0
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U9MKAQk9+425Zgbla0oZZvXVi6Fnpea8oG2FeAqfX8w=;
        b=VOY892Pga7wSU0axBKTWYR9QqzzyLBv16fI+M9+vwBZD4T5bv9NO/emYMEtw3HhqLp
         F+rf5Hu8IMEt1n9IJ/E0T6zjj/P+arVlAwUWoCFztErrVsB3qGXtZFVT8jUrTG47LKrH
         +yxkxy0OS7Fq3S54T9zE01PczHbaxF4RjH21WzgbP9CHKLMLndpwxTv+D3HLvsbkKfmF
         EiQZIVwByHoUstSqi+0A/zvTvDYFks7fH1w/lMCDpRhNsfhsJsHGuqTiO6UmZW6a0/7e
         2dPCv2+OeZoZ9f6ZGXuvv3RxrX8BL7Kf1LDzKsLrkOWvz2Hy0qrAChyanUgzEHfQ4gfc
         srdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U9MKAQk9+425Zgbla0oZZvXVi6Fnpea8oG2FeAqfX8w=;
        b=ak/STcBhFAC6LDmsSO8U1bmvz+Xe2PSGNittnPnFRoy5n4qzTgzH2nmhAhvkqaqAtC
         sVQPOfMo+tUX88fR5Q1jsBI2SJGQU6L7mrqNjNI5J9WnQJNfWO2IL70+lZfOy4fUHTgO
         Eg8ArzomjZz8ozJeDi5Clof8D+qrHXi4cSWKXIa8WLjK6WcbibJ9NP3it8ouz0YbOp+l
         SgWXTy8wZfEJKwGyzqq7ehF+TKwFNf2pfKgWY8beAmCbYk7fYwumAydJQCYtidXBxEUD
         htWyq6+Le50AzKrvyJbfEfPcAXIm0sCzm2vnWD0fQYtGIsRyAcKMynAoLTzolpdX8EVn
         EfDw==
X-Gm-Message-State: ALoCoQkHiNqM3Bcf1Vk2B8efsCzz/crUNulHgz/2iMPpH8nwcdJqiTQr4Xn72Tooa4Icm23gL4NQ
X-Received: by 10.182.75.193 with SMTP id e1mr8889991obw.1.1400261857154;
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n43si191473yhe.1.2014.05.16.10.37.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id DA05E31C273;
	Fri, 16 May 2014 10:37:36 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 999F3E0746; Fri, 16 May 2014 10:37:36 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249395>

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
index 582c74b..29cfe78 100644
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
index 8669fc9..05e65fa 100644
--- a/refs.h
+++ b/refs.h
@@ -271,8 +271,7 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * the transaction failed. The string does not end in newline.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err,
-			   enum action_on_err onerr);
+			   const char *msg, struct strbuf *err);
 
 /*
  * Free an existing transaction and all associated data.
-- 
2.0.0.rc3.510.g20c254b
