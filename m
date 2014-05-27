From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 13/41] refs.c: change ref_transaction_create to do error checking and return status
Date: Tue, 27 May 2014 13:25:32 -0700
Message-ID: <1401222360-21175-14-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:27:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNyA-00045K-OH
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbaE0U1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:27:03 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:57917 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939AbaE0U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:05 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so1645391yhl.3
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RTbToNCxWFJucZRypY2giQr4YzJmhYj6ltzTCPxCC/w=;
        b=CCmE+QWe6POwvkFHrgheHIJCqcNCfpkI3CVEQ4OS07XElUivbGfxCU2DUavghufV3o
         tkIXao7i2+z+YddbzYdePT0gM/yrhLjrZwAT0r51xYsGCDWqWERzbxfb+Nt4PnB0M6K+
         Xs+i1C872v0HUAWa56+jF3YyKzAPq+Ru9MJZ0Bj29LsBKUkf7D5oJSgH7y+Y51U5fxwk
         hK9xrqVMd/roNdnftrSCfd/hRsasnDZwdkmNZBUN0Spgja/5bg0YzMCl6HmJsTDvZpKX
         0tXieo9Bj8Fh9uWKcR/mt3m/Zw5YsZR4H9iBIkTzZU5a7NC5PQ4b8V1LnNQyE4iQC943
         YkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RTbToNCxWFJucZRypY2giQr4YzJmhYj6ltzTCPxCC/w=;
        b=fW3v2JB+HKJhFQCzf4lCwUQnqTTxjokWBLLH+xIRbJJU5WXwApI17QSVyYZoXFt6EN
         dY5+mzomObhznu/F3ZdYy9K6lQVveiMmMDXZPij/KITSwQZtfDY8x4s3DntwpDW5BgW1
         v0GESmp40515aAIUBzLKMQO9hptI7H5k9jIUKQ+xVZ0CvO911sv0aIxaaLFEHo1QY0dG
         fgvYTjkNVRdPM9hXS5OSM172jIyFj05+zBPFJMVTVpuvktTXlQuDp81a0xDixzm2TYb2
         0EZ+9sSMwOZzPH8FZTD0YaFum3/ZS/FJszUoUiICXc8HQkCzyEGaxEpnFyPgRA5VqJ1t
         fDmw==
X-Gm-Message-State: ALoCoQnGvHSb/TMv42EIzX25X1jvliEFCMX/cV5TuuTPTkgu013MB5VaxzNHJzXqCF/Wu43mCUge
X-Received: by 10.52.4.164 with SMTP id l4mr12428072vdl.3.1401222364546;
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si1574644yhj.5.2014.05.27.13.26.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 4DD402F4AB9;
	Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2772FE1170; Tue, 27 May 2014 13:26:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250220>

Do basic error checking in ref_transaction_create() and make it return
non-zero on error. Update all callers to check the result of
ref_transaction_create(). There are currently no conditions in _create that
will return error but there will be in the future. Add an err argument that
will be updated on failure.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  4 +++-
 refs.c               | 18 ++++++++++++------
 refs.h               | 25 ++++++++++++++++++-------
 3 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 3067b11..41121fa 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -226,7 +226,9 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("create %s: extra input: %s", refname, next);
 
-	ref_transaction_create(transaction, refname, new_sha1, update_flags);
+	if (ref_transaction_create(transaction, refname, new_sha1,
+				   update_flags, &err))
+		die("%s", err.buf);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index 79a4477..709758d 100644
--- a/refs.c
+++ b/refs.c
@@ -3397,18 +3397,24 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	return 0;
 }
 
-void ref_transaction_create(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    int flags)
+int ref_transaction_create(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   int flags,
+			   struct strbuf *err)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
+
+	if (!new_sha1 || is_null_sha1(new_sha1))
+		die("BUG: create ref with null new_sha1");
+
+	update = add_update(transaction, refname);
 
-	assert(!is_null_sha1(new_sha1));
 	hashcpy(update->new_sha1, new_sha1);
 	hashclr(update->old_sha1);
 	update->flags = flags;
 	update->have_old = 1;
+	return 0;
 }
 
 void ref_transaction_delete(struct ref_transaction *transaction,
diff --git a/refs.h b/refs.h
index 32edf3f..22b8cc3 100644
--- a/refs.h
+++ b/refs.h
@@ -215,6 +215,15 @@ enum action_on_err {
 };
 
 /*
+ * Transaction functions that take an err argument will append an error
+ * string to this buffer if there was a failure.
+ * This string is not cleared on each call and may contain an aggregate of
+ * errors from several previous calls.
+ * If the caller needs a guarantee that the buffer will only contain the
+ * current or most recent error it must call strbuf_reset before calling
+ * the transaction function.
+ */
+/*
  * Begin a reference transaction.  The reference transaction must
  * be freed by calling ref_transaction_free().
  */
@@ -236,7 +245,7 @@ struct ref_transaction *ref_transaction_begin(void);
  * it must not have existed beforehand.
  * Function returns 0 on success and non-zero on failure. A failure to update
  * means that the transaction as a whole has failed and will need to be
- * rolled back. On failure the err buffer will be updated.
+ * rolled back.
  */
 int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
@@ -250,11 +259,15 @@ int ref_transaction_update(struct ref_transaction *transaction,
  * that the reference should have after the update; it must not be the
  * null SHA-1.  It is verified that the reference does not exist
  * already.
+ * Function returns 0 on success and non-zero on failure. A failure to create
+ * means that the transaction as a whole has failed and will need to be
+ * rolled back.
  */
-void ref_transaction_create(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    int flags);
+int ref_transaction_create(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   int flags,
+			   struct strbuf *err);
 
 /*
  * Add a reference deletion to transaction.  If have_old is true, then
@@ -270,8 +283,6 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
  * problem.
- * If err is non-NULL we will add an error string to it to explain why
- * the transaction failed. The string does not end in newline.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   const char *msg, struct strbuf *err);
-- 
2.0.0.rc3.474.g0203784
