From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 01/11] refs.c make ref_transaction_create a wrapper to ref_transaction_update
Date: Wed,  4 Jun 2014 11:57:42 -0700
Message-ID: <1401908272-7600-2-git-send-email-sahlberg@google.com>
References: <1401908272-7600-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 20:58:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsGOE-0007zq-Ie
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 20:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbaFDS6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 14:58:09 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:50781 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbaFDS6H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 14:58:07 -0400
Received: by mail-vc0-f201.google.com with SMTP id hq11so986366vcb.2
        for <git@vger.kernel.org>; Wed, 04 Jun 2014 11:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=38WigZvahYEgirSQZazE1BEb1nd11MnD+0YQ2MMjNnU=;
        b=PHVYRF+kcUA64x1x+VC3Q8zaxxAy5m1nRLTldkqMCA+t2+aSCcDd6u06zvvsldE+FE
         ZHr+jW2L8dhoAaNPuORftr4SMtA3NBp6WSAGz6R3X4o0zbmonEUuYzYnSnZoZFRMrHcb
         OReFV7zIs2B916QbfRoNv3iA1t1GJSWjz9kiSHSYQi5+Bhx57Xm0SNSE0LYPdEee4SG4
         xOdBcW8xsOpiUGfA2CUvNwdKIBy3bRYczZ6CtKjyPd58yd1U7kGd2FeS1GNf9i5tekyg
         FdeRsNCXzRCOtwDARtay6xxfZLbIpCl8N1Pz7L5RBpRa1k4c0dLJd+B5oWWzz8T14yWi
         NFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=38WigZvahYEgirSQZazE1BEb1nd11MnD+0YQ2MMjNnU=;
        b=a9i/DRLZouV5s9Xs0cV8Q2F3IlXRiausRfulrINDb0eim6EHZiF/Qt1Qvt7gNMQhmE
         JU5Boik/MT0O1BYPfvGYjHRLr8WmGStZKQtCIjlJlBSoOaG8CiGbjLxcEENr0sxihdoa
         VoPV+T1HNpN5GL4alMYgbik/wVxNYBKOCswEdwXOozZnwmWzIl5aXb5GvIa8nrBr3q8O
         90AWCs3C/a6gY2Mvi75GBEpx4t3Ry01FmjV3Bo/c1t/56ZybnVuWbIHcbYKQIlBnpTK2
         OLdYy8PZe684W5I97hEAhjM91VVDy+Lq77huue0XLZpp/nbW9Z4Efkkgl2tXgzCiRHvO
         RFMw==
X-Gm-Message-State: ALoCoQmjPS7hXyGs+3tSvA4G0qaf1WZ+oVlyJfsH18SQVYn3S+T7X95EbnE5qB9K1FEeKzjZJXEH
X-Received: by 10.58.220.4 with SMTP id ps4mr9051928vec.38.1401908286580;
        Wed, 04 Jun 2014 11:58:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si331408yhj.5.2014.06.04.11.58.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jun 2014 11:58:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6D32E31DB2C;
	Wed,  4 Jun 2014 11:58:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1E8D0E0887; Wed,  4 Jun 2014 11:58:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.578.gb9e379f
In-Reply-To: <1401908272-7600-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250763>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 11 ++---------
 refs.h |  7 ++++---
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index f8a6c9a..2dfedf4 100644
--- a/refs.c
+++ b/refs.c
@@ -3464,15 +3464,8 @@ int ref_transaction_create(struct ref_transaction *transaction,
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
index 8177052..eedddbf 100644
--- a/refs.h
+++ b/refs.h
@@ -273,9 +273,10 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
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
2.0.0.578.gb9e379f
