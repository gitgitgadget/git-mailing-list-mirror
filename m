From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 01/14] refs.c make ref_transaction_create a wrapper to ref_transaction_update
Date: Mon, 16 Jun 2014 09:51:32 -0700
Message-ID: <1402937505-6091-2-git-send-email-sahlberg@google.com>
References: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 18:52:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwa9G-0003HJ-8e
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 18:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbaFPQwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 12:52:42 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:45094 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071AbaFPQvu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 12:51:50 -0400
Received: by mail-qc0-f202.google.com with SMTP id x13so667212qcv.5
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7SXWxwPjVpEmuWmccWu11ThhoI31B/oaEfvq956nfUU=;
        b=jLBVS0Pt4t/s9UZW82p6VwmmqHL7buHoCoZiYtbcoJZfu94bk6TZszE8c1tesShQgl
         hL6e6LT1T5zJJLBqLr+V12OLVCYri2YUgKKjgs6eR/rU9sy9L/LCz1/AKxGJW2E9ewwO
         8YPBGQhm0QNeEuKTupvzSKJe2eyEs2RjBnmhuowJg2mEyW1zKJ71LVRZwkdQyTUtbNig
         bqlDXk3uoZ9+hqZBf9OKHS7D/VwKGS91daC5/egKLB4gfG9ANnHeUDd6Xdd8pjOvxkU/
         1rHov8gvtfUg0tKvHvX3se2hhKjhaCc/3Jh1JSc7dHkvOStCg30p940XiAezkzSimWqQ
         ADIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7SXWxwPjVpEmuWmccWu11ThhoI31B/oaEfvq956nfUU=;
        b=FPQNoHcRIECMg/t6GDVyr9b6zjev+s8YV0gC5Pju7VyBjFCrMie/Sr9vptEQsD5ju7
         q8hq0iKVolg5RK4WV0fwDO+1ewWiBZCZBdCQEfVr32/Qt2ghQHwKuuakWDeKIN1TeFZO
         44KTE6YPVvemT+Q7q6HQhgTyOaXlNexQqYSyDbmrV1acf+1moPJ7rZMFiB9tfJseDg0V
         Vx5AfbwQll20vDiWwD9vcQwovcVw3/gH8RyQk5X5mdMiKwhmbZzUPk1GnYRFKyp3ZXg5
         /DKGymLq6TYLdBmgpxRDEU1PhWm4XegnmLI4p+5H9ApGVGDTAjvE01aXinGgaFEqOZF+
         xVPQ==
X-Gm-Message-State: ALoCoQkpCnvIIg+Ba278G37XVojYcUpZ2vslAfZziT2QS7OYpePgcnem6cazTZ7iun/ly7ODFe7C
X-Received: by 10.236.197.226 with SMTP id t62mr1533274yhn.50.1402937509431;
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si983796yhb.3.2014.06.16.09.51.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 4C0FE5A47A5;
	Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E6FF2E0AF7; Mon, 16 Jun 2014 09:51:48 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.770.gd892650.dirty
In-Reply-To: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251730>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 13 ++-----------
 refs.h |  7 ++++---
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index fbb34c0..c62df4c 100644
--- a/refs.c
+++ b/refs.c
@@ -3509,23 +3509,14 @@ int ref_transaction_create(struct ref_transaction *transaction,
 			   int flags, const char *msg,
 			   struct strbuf *err)
 {
-	struct ref_update *update;
-
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: create called for transaction that is not open");
 
 	if (!new_sha1 || is_null_sha1(new_sha1))
 		die("BUG: create ref with null new_sha1");
 
-	update = add_update(transaction, refname);
-
-	hashcpy(update->new_sha1, new_sha1);
-	hashclr(update->old_sha1);
-	update->flags = flags;
-	update->have_old = 1;
-	if (msg)
-		update->msg = xstrdup(msg);
-	return 0;
+	return ref_transaction_update(transaction, refname, new_sha1,
+				      null_sha1, flags, 1, msg, err);
 }
 
 int ref_transaction_delete(struct ref_transaction *transaction,
diff --git a/refs.h b/refs.h
index 0766a9e..4843706 100644
--- a/refs.h
+++ b/refs.h
@@ -282,9 +282,10 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 /*
  * Add a reference update to transaction.  new_sha1 is the value that
  * the reference should have after the update, or zeros if it should
- * be deleted.  If have_old is true, then old_sha1 holds the value
- * that the reference should have had before the update, or zeros if
- * it must not have existed beforehand.
+ * be deleted.  If have_old is true and old_sha is not the null_sha1
+ * then the previous value of the ref must match or the update will fail.
+ * If have_old is true and old_sha1 is the null_sha1 then the ref must not
+ * already exist and a new ref will be created with new_sha1.
  * Function returns 0 on success and non-zero on failure. A failure to update
  * means that the transaction as a whole has failed and will need to be
  * rolled back.
-- 
2.0.0.770.gd892650.dirty
