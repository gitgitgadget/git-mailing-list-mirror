From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v21 19/19] refs.c: change ref_transaction_update() to do error checking and return status
Date: Mon, 14 Jul 2014 13:59:01 -0700
Message-ID: <1405371541-32121-20-git-send-email-sahlberg@google.com>
References: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 23:00:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6nLt-0003E7-K9
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 23:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757246AbaGNU7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 16:59:52 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:59127 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756997AbaGNU7I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:59:08 -0400
Received: by mail-ie0-f202.google.com with SMTP id rl12so445395iec.3
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GarL3sW4nkbiNd0UrlRs+L3qbVpgVHLHR83goE7GdXg=;
        b=ZLLCD4vq0+7kQa4nH50uv9fusf2OJWQJtg3JssC+eFQfIg0viWYXUjeoqKCndZuVIM
         4/gd5TSFeiUTJEM+NRzRO6TzzF5xl1cWNocz8F4N52XaJC+WFRZaactRRgLBe3MY4voT
         aYdpiY3jZbmkp61RAcrFFkMQr2CxS/IVvQ17W+clM91Ort/besEFwhwRHfZqwfJgCsJy
         W6yCpw92oZuhI4SvUwmsvUqFM81DJu/nGm1iygzMmGuAVU0k9DUgDpi4Egrnr+O8Dvbf
         wA8h8sOjjEY20wbpiolgTnkYUCmfpTCUfzDUoPCJDkLfBLu/ti5ZcarD5dVcXvB9lzSL
         uoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GarL3sW4nkbiNd0UrlRs+L3qbVpgVHLHR83goE7GdXg=;
        b=P8tvOdWXnlHzLIq544PrFKDSG3+iuqoQ61X/Y05JsNyLYum3BZ4OuLzlHoGsqg2Qe9
         3VRSEAnt6uy5+4/xW+j5VkVGMtOIFAf7/LUyibaRaOjPYQETdmRdByQ7aXVPTcUydPhb
         X/db0dgr3bHKmIRmFVSLUaetXvunh5F8NWpWGz6hBkdSML+uSXAviGfoYbHXewveRorb
         5j0ka0kfn7SxBFaE6HWlFEkz1nV1NiZviWncl+nnXCoef8FFKQPEHadfP8qtb+ztUC8E
         xgvMdKl9gCGtlOIcyLENAEhAGPrTb1HlVaTeeRk6dOO/poHBQVsmgtT/J8FPjps83dpK
         T0vQ==
X-Gm-Message-State: ALoCoQmlCG/hT3X3B00ohl5na0JvQ/Jq0IAhe2ldYLtkuPFQJOWAuv7+CvUoJ8dbqEikj3seobhx
X-Received: by 10.43.67.68 with SMTP id xt4mr5194443icb.23.1405371546290;
        Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v12si822288yhe.2.2014.07.14.13.59.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1392A31C42D;
	Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id EA549E07CD; Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.546.gf603308
In-Reply-To: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253530>

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
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
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
index 4f78bd9..3f05e88 100644
--- a/refs.c
+++ b/refs.c
@@ -3428,19 +3428,25 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
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
index 163b45c..c5376ce 100644
--- a/refs.h
+++ b/refs.h
@@ -246,12 +246,16 @@ struct ref_transaction *ref_transaction_begin(void);
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
2.0.1.546.gf603308
