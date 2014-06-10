From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 20/48] refs.c: change ref_transaction_update() to do error checking and return status
Date: Tue, 10 Jun 2014 15:29:08 -0700
Message-ID: <1402439376-25839-21-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:31:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUYV-0004uB-NO
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbaFJWaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:30:03 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:37068 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296AbaFJW3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:41 -0400
Received: by mail-oa0-f73.google.com with SMTP id eb12so132659oac.4
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8stWK0pOru1iNm4bGFfD2pWGO+1Ds3cnkbC1ds5uLmU=;
        b=cFBwkeXKXFAELu0AIBzx4AB9yS7YRB7iUGAtjVzryhc8GHeuASteZGHzfYd1t3JIuZ
         +BuUXzOSEVN2CEhArXaQvQlgmnfyJsHIXCTeQ3H5r5Q3mAd5Ne6XTL8sZcRJ46VkAoEW
         1R6CiGWxNwriuY8qW8wx+uaM2d2azrd1ZCqmWUsH4NCTFrWtmiTE+ITMQx9Wthqpwz5q
         MVsPmBfBpWYo7ObmetAYmYykRUNz2PzaOexBL6myq50mwZ1zc9+PGZ1Z4wuvdiTIMkW3
         1CnlxCJ1cw1arilZvYMK0H5s/SzkKD1Mzj3HpP1PIFYA0iLcLQ25eWTdKD6jTAtpUqBB
         k7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8stWK0pOru1iNm4bGFfD2pWGO+1Ds3cnkbC1ds5uLmU=;
        b=TKqPd4odK8KwdWdafckgUkGGg444Pp0YVF3W1dtHb/YPXbp3xnucCPWJNV+bi35GZj
         0wbuFwsdemj2+b3XrNhm+5+l5wkUJ3exAM9/GKAfkHlxvk54t+D3yXZD4x+iy6VmOa9G
         endk8mCqzYbcTq37b/wX9/0hnImwxRg7/NcNaaDaJVx7g5VKlyzNmBoea3Owj26cOCGd
         RLGF2T3wXIoXccfRSO9SDeFvigeklJpFh5wy/KGdP3nhjuge0GrzN6nmd3ZaByN8PA5r
         KW8O8H32ub+kkwYscxCLzu9YEaff9/Mt8VkQUpUDruiMiBZ+63vj6TD78Ig+LtqN4mbP
         u5Ng==
X-Gm-Message-State: ALoCoQmgrBh74cYlZEI6UR2ai97Ex9/E8E0Tero+WXbwz0R27EgnN8TGmBiU3qRFETNywby0WY7R
X-Received: by 10.42.85.142 with SMTP id q14mr16447499icl.16.1402439380763;
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t4si1374937yhm.0.2014.06.10.15.29.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 80F3A31C746;
	Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 51452E1220; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251268>

Update ref_transaction_update() do some basic error checking and return
non-zero on error. Update all callers to check ref_transaction_update() for
error. There are currently no conditions in _update that will return error but
there will be in the future. Add an err argument that will be updated on
failure. In future patches we will start doing both locking and checking
for name conflicts in _update instead of _commit at which time this function
will start returning errors for these conditions.

Also check for BUGs during update and die(BUG:...) if we are calling
_update with have_old but the old_sha1 pointer is NULL.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 12 +++++++-----
 refs.c               | 18 ++++++++++++------
 refs.h               | 14 +++++++++-----
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 88ab785..3067b11 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -16,6 +16,7 @@ static struct ref_transaction *transaction;
 
 static char line_termination = '\n';
 static int update_flags;
+static struct strbuf err = STRBUF_INIT;
 
 /*
  * Parse one whitespace- or NUL-terminated, possibly C-quoted argument
@@ -197,8 +198,9 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
 
-	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
+				   update_flags, have_old, &err))
+		die("%s", err.buf);
 
 	update_flags = 0;
 	free(refname);
@@ -286,8 +288,9 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("verify %s: extra input: %s", refname, next);
 
-	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
+				   update_flags, have_old, &err))
+		die("%s", err.buf);
 
 	update_flags = 0;
 	free(refname);
@@ -342,7 +345,6 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	const char *refname, *oldval, *msg = NULL;
 	unsigned char sha1[20], oldsha1[20];
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0, flags = 0;
-	struct strbuf err = STRBUF_INIT;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
diff --git a/refs.c b/refs.c
index 0b1c449..af7e10a 100644
--- a/refs.c
+++ b/refs.c
@@ -3425,19 +3425,25 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 	return update;
 }
 
-void ref_transaction_update(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old)
+int ref_transaction_update(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old,
+			   struct strbuf *err)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
+
+	if (have_old && !old_sha1)
+		die("BUG: have_old is true but old_sha1 is NULL");
 
+	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
 	update->have_old = have_old;
 	if (have_old)
 		hashcpy(update->old_sha1, old_sha1);
+	return 0;
 }
 
 void ref_transaction_create(struct ref_transaction *transaction,
diff --git a/refs.h b/refs.h
index 1eb447d..f7a5e42 100644
--- a/refs.h
+++ b/refs.h
@@ -242,12 +242,16 @@ struct ref_transaction *ref_transaction_begin(void);
  * be deleted.  If have_old is true, then old_sha1 holds the value
  * that the reference should have had before the update, or zeros if
  * it must not have existed beforehand.
+ * Function returns 0 on success and non-zero on failure. A failure to update
+ * means that the transaction as a whole has failed and will need to be
+ * rolled back. On failure the err buffer will be updated.
  */
-void ref_transaction_update(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old);
+int ref_transaction_update(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old,
+			   struct strbuf *err);
 
 /*
  * Add a reference creation to transaction.  new_sha1 is the value
-- 
2.0.0.574.g30c2c5e
