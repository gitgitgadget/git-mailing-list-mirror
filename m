From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 02/14] refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
Date: Wed, 18 Jun 2014 10:08:54 -0700
Message-ID: <1403111346-18466-3-git-send-email-sahlberg@google.com>
References: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 19:09:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxJMS-0006uT-Bt
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbaFRRJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:09:13 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:40671 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbaFRRJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:09:10 -0400
Received: by mail-ve0-f202.google.com with SMTP id oy12so143164veb.3
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pYJChcNv9kTyyBBWQRc9Z4CvYs6BEoOTslFgIRk9Lj8=;
        b=nUT6m3CR41C4R6NsId74ea8e3YoGQwb/g+7E5NtNqawz+MEPXkLP0lQd7qi9v70tVJ
         A96DjLfgjJhT1TkQjJKFAd6rCngCokKdsfKekqGjB2V17nGugJUB9nQg0KedyigbKi6g
         xWpTlAHAdpPv1B35iki2ryfC7cymh5uzo05Kq9V+Xjea+UZ8CBqBBcGSY9nKwsx5zHbi
         vEKBMGQ6vlSNJPDaMbLqRZDotE0RG953rM8rMnyrwGXexJ033CNfsRT8Zh5hOUkZRtqI
         8nI9n1xaIAhBU4DkrmRS7x1bEo73+kv15q3N7LHZOlSCzLJinRCesysLDdeGgBGjXuCF
         cuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pYJChcNv9kTyyBBWQRc9Z4CvYs6BEoOTslFgIRk9Lj8=;
        b=FhL+OrpSoI6CIE3qne6bwIYfDhS8l99Y1Wsl4tHGwHizcDW3eAdVPJO7EvWkY+3t+r
         GgnYB5O36AnEKYxqEM0iW4FglNFCupaJx2Z8FNsyrRTaQuqrb9/wsBUBXhIHKOQuYQTD
         /LbtI4Vxca23WvI/56o6RzJpE8slEyNlsl7cvTh3U1mFC13n00tgToE4gAwuC/3Q6LZ1
         TAHKs07VwW3+XZ34TL641dD5eOEd8RUpWCuama/u6Fid47ndwPiwQFVt/iTLn0MG+qNh
         a4LdxLt1puKHVPBa8MjjiXXNG/UmBLhJ6xu+3+c8F50po91KwXwpYze4hXO/E90hvhXy
         Q88w==
X-Gm-Message-State: ALoCoQkICulDRTPvGAZAejRG+cQaaMQWKwrswPQ3a/dTu/9ckKS4+2+K0v05bwZEMEyG1HHw9UvT
X-Received: by 10.58.151.201 with SMTP id us9mr1282825veb.23.1403111349638;
        Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si173339yhk.4.2014.06.18.10.09.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 7B4B65A4790;
	Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 28F06E0424; Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.467.g08c0633
In-Reply-To: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251993>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 17 +++++------------
 refs.h |  2 +-
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index a9f91ab..0eace70 100644
--- a/refs.c
+++ b/refs.c
@@ -3503,24 +3503,17 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 			   int flags, int have_old, const char *msg,
 			   struct strbuf *err)
 {
-	struct ref_update *update;
-
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: delete called for transaction that is not open");
 
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
-	update = add_update(transaction, refname);
-	update->flags = flags;
-	update->have_old = have_old;
-	if (have_old) {
-		assert(!is_null_sha1(old_sha1));
-		hashcpy(update->old_sha1, old_sha1);
-	}
-	if (msg)
-		update->msg = xstrdup(msg);
-	return 0;
+	if (have_old && is_null_sha1(old_sha1))
+		die("BUG: have_old is true but old_sha1 is null_sha1");
+
+	return ref_transaction_update(transaction, refname, null_sha1,
+				      old_sha1, flags, have_old, msg, err);
 }
 
 int update_ref(const char *action, const char *refname,
diff --git a/refs.h b/refs.h
index 495740d..20bb152 100644
--- a/refs.h
+++ b/refs.h
@@ -282,7 +282,7 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
  * Add a reference update to transaction.  new_sha1 is the value that
- * the reference should have after the update, or zeros if it should
+ * the reference should have after the update, or null_sha1 if it should
  * be deleted.  If have_old is true and old_sha is not the null_sha1
  * then the previous value of the ref must match or the update will fail.
  * If have_old is true and old_sha1 is the null_sha1 then the ref must not
-- 
2.0.0.467.g08c0633
