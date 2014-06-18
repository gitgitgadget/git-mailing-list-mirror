From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 01/14] refs.c make ref_transaction_create a wrapper to ref_transaction_update
Date: Wed, 18 Jun 2014 10:08:53 -0700
Message-ID: <1403111346-18466-2-git-send-email-sahlberg@google.com>
References: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 19:09:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxJMl-0007A7-TX
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753618AbaFRRJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:09:35 -0400
Received: from mail-qg0-f74.google.com ([209.85.192.74]:41605 "EHLO
	mail-qg0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbaFRRJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:09:10 -0400
Received: by mail-qg0-f74.google.com with SMTP id z60so47933qgd.1
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fyEaVk4F168XFwbTys7ivjdhsenJwf450jVUMyjG0u0=;
        b=On3p+iUG+pyZqxnNTbotfy8zIjghBfauqzSTfYQCeTUndtN6I50CZWzZhRbrnCKzpv
         /dcKEpcQ9AuB12HcKv/owQ5VHHbAf3nxlyc7KVYjWCIC7LGRzkt6cR0HqoxJ139tuSaH
         EqYBrS/zC1VYGJwDYgd0482YhseTqTcTWCAtRipIq9dV46tf4FGdwHlRIv9obS9uiwIx
         uff8jlQgL71QI6KGHFoT39dKJiWtsN0FA6HR9yGgFY6GpsywtbfVzpG6cNS7JI5xBK/e
         pZdMUTREongJylZeLvVQzrSEJzihjKDF1BFSnax+diWDZznvluaTQQUnYlmaZpM1LEqm
         8tFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fyEaVk4F168XFwbTys7ivjdhsenJwf450jVUMyjG0u0=;
        b=hSgL0GNjcgBpqUkw8GTH3/gYvIkryBrAFnwPVNOIQPBBIdVVdmo4C/M2Q/e8aCwHJU
         0be3kepmk6OXfzvpZ3lI6tO+1QVXfwRwEMutT0H8nUpOh4KNwCTdUSJFhQFVilfXl5LX
         sFa+w1hDnc464dlT4e05CtoqaDefumeQpgeED0vDQ0aY0pvtAuPStnoBFlTxozB5ggyY
         WJQxcnqtXgaYwuTdhQl9QyfuwE8VDC6JVNoByzFbs8ayvd2Bv63/ScMPgCDAdK9zuRmc
         vHpz+10+/r80k9R35ocy9Pg6vaM+4UU4kMgu5KdwotDGnzSRSUR4G9a5VANZYMikCGNL
         uMdQ==
X-Gm-Message-State: ALoCoQmJazeZ+1mYDOhoU2ZvXWkfgfaMLHHw3/2fmAj42xvax/Srpyi1kD55xCYLNGCS94GCc9tl
X-Received: by 10.236.175.42 with SMTP id y30mr45289yhl.42.1403111349838;
        Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v12si100874yhe.2.2014.06.18.10.09.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id AE8C35A478E;
	Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 49F69E0A43; Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.467.g08c0633
In-Reply-To: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251998>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 13 ++-----------
 refs.h |  7 ++++---
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index dfbf003..a9f91ab 100644
--- a/refs.c
+++ b/refs.c
@@ -3487,23 +3487,14 @@ int ref_transaction_create(struct ref_transaction *transaction,
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
index db463d0..495740d 100644
--- a/refs.h
+++ b/refs.h
@@ -283,9 +283,10 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
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
2.0.0.467.g08c0633
