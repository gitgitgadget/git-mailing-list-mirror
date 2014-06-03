From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 12/41] refs.c: change ref_transaction_update() to do error checking and return status
Date: Tue,  3 Jun 2014 14:37:30 -0700
Message-ID: <1401831479-3388-13-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:42:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwT8-0007ro-Og
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934069AbaFCVl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:41:59 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:41807 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934130AbaFCViI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:08 -0400
Received: by mail-ob0-f202.google.com with SMTP id wm4so1534151obc.3
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eXmQqS0WM/uzCodZu402FnxjWJJiywjTFr7mgNGXQDY=;
        b=hXnU4rZzG4Ql/h8lTdLWLEDYG7LRR2S5ISHUnRYmYJhpqGY2LhmSEY98eLPp/wGywR
         2xvH4hwVoOCiKwE5Xblk+tI+hCCPr+ZY+uC9YVS92rSWE4ByP6jhvPRkIqSRtYBHNJOA
         /0y6ciG2hf+VXKXRIXaT2D2oBKeRl+bILHV+GIYltWWWC0dEVXEMsstenQ1OlaKeg2jE
         Jw/pYRV2DsV1Co4nfnEi7VWuF1O1qIPptb9fHGiOMKRdZk46qnpzq3VtJY80Z06msbxz
         RKIMH2bbcxe2D4KiODBULdkTsykH9Wahypbh8MRiRZvDLsp2E390lHDaiax9GzM4KaAV
         GXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eXmQqS0WM/uzCodZu402FnxjWJJiywjTFr7mgNGXQDY=;
        b=O7XOx13Dve9j0lCmp39/t25L/JQPcjlzwShzEAmRR+qEJ8xPQSbeqdvES39HCeuBzX
         XU3PnL/WshRejjUCL/1D3BF5/7AxMNGwphWxj5DKLKzok3q65CDO1RA1gpF+S3cx88zw
         zHvcP2NPNu7/8EuYpZfTmubBtsbMp77m8J50YO4MdAcA3Z4obC14d5rRBXA5FGkvMyPP
         FmGyASM3UoH4XI+It+qn09X4mfUPBf5D/W140NEjDTeS9wr7CyhOL5nN1gDOXpGig976
         L/R9MOcFXUBHZ9NgnlDB5aHsLtkIvjnyl1aGEMtIELxZTIuR1q3nCwkNekN0ku1X5+p7
         zZnQ==
X-Gm-Message-State: ALoCoQn2NVnvzFvTv7LbVZNh+RCyy/JitzRWPehggWg/LFGOAtNivGCgre/ErC1rDE9KzJJrokgL
X-Received: by 10.182.97.165 with SMTP id eb5mr19463561obb.43.1401831487385;
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si28753yhp.6.2014.06.03.14.38.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 269835A43C6;
	Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D10A2E0F40; Tue,  3 Jun 2014 14:38:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250684>

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
index fb44978..f5e7a12 100644
--- a/refs.c
+++ b/refs.c
@@ -3418,19 +3418,25 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
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
index 6ee9c9e..32edf3f 100644
--- a/refs.h
+++ b/refs.h
@@ -234,12 +234,16 @@ struct ref_transaction *ref_transaction_begin(void);
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
2.0.0.567.g64a7adf
