From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 01/15] refs.c make ref_transaction_create a wrapper to ref_transaction_update
Date: Mon,  3 Nov 2014 08:55:43 -0800
Message-ID: <1415033757-9539-2-git-send-email-sahlberg@google.com>
References: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 18:03:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlL2b-0005ua-5I
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 18:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbaKCRDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 12:03:37 -0500
Received: from mail-yh0-f74.google.com ([209.85.213.74]:64329 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbaKCRDf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 12:03:35 -0500
Received: by mail-yh0-f74.google.com with SMTP id 29so708828yhl.1
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 09:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5MDT1i1V4ghhkeQX4BLSnu7Gpz54h4/huSfdP09qlVg=;
        b=R5T3b9kganf3DsHqzTlxRTP1Tc4XwrrBkJZNlea0FPJbt4jTn1AgXoRX4zhWRyJ0QB
         0n3vRuPtsE/S9sO/iqCmWCxkydbkLcWDNNjKTWPPdfWc0mUYgKN/K4vThxVo3JNCkn/i
         V1mhlT3mmUfA6PalP+l4wAhifaw3hn+AvM+PXzy6f2fKaamUmslROPZ5z9cj4XXQCt2F
         d5s/6SHIkvbxGYUeQ6bOQNnH05uWm8pfEgPREVI6Ej+IQeO+hLmchoW1IY5Wr06gEz0B
         pumMV+Dcc73yjt0Z4s743A5ViKRswOkKZqClnJrDzCtfQqfIf3eBF0v6ytANTb7ad3qq
         Vl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5MDT1i1V4ghhkeQX4BLSnu7Gpz54h4/huSfdP09qlVg=;
        b=QXVJJaEZkfZtcOEQ84Gz1NYRUWc9VG42hm+qIw0T44KFcJn1aFaWboa22LJv1LwFFh
         fdVQtQqzQuM9CqJtghIUBxirvXgWfnKaVMA4ei0gAr8II43DOQxyRX1R/0YrAQP0SfNm
         BYhkuYJdX9CUQSSR9EXBLA6lMMx0mYFCiH0DQl8pLCMYmcJOKQ8kIR4dgrua+zP/bLjR
         q3JJ0IGt4tja7jZ+n6lUUVUJurPjd+jaCEWiJIC0Avp6IHkcJUAQSGuQH3ffuG/baVcz
         ZpRRNQO1DHKq3h5BYCdH53mMTWo7GariSYsFN71cDjlHEoPRHH0lO/tfgdYwA0psTQ4y
         r+pg==
X-Gm-Message-State: ALoCoQlEf9hr3z2jV/VpeqwsyZhjL71mS3rz1n1pYym9/faJHmRwbyW1lL/EMZMj1+FkZh3dq/7Z
X-Received: by 10.236.104.233 with SMTP id i69mr26608286yhg.37.1415034214849;
        Mon, 03 Nov 2014 09:03:34 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id t28si959290yhb.4.2014.11.03.09.03.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 09:03:34 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id rUIvNE95.1; Mon, 03 Nov 2014 09:03:34 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1B915E0C1B; Mon,  3 Nov 2014 08:56:01 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ref_transaction_update function can already be used to create refs by
passing null_sha1 as the old_sha1 parameter. Simplify by replacing
transaction_create with a thin wrapper.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/refs.c b/refs.c
index 0368ed4..ed0485e 100644
--- a/refs.c
+++ b/refs.c
@@ -3623,31 +3623,8 @@ int ref_transaction_create(struct ref_transaction *transaction,
 			   int flags, const char *msg,
 			   struct strbuf *err)
 {
-	struct ref_update *update;
-
-	assert(err);
-
-	if (transaction->state != REF_TRANSACTION_OPEN)
-		die("BUG: create called for transaction that is not open");
-
-	if (!new_sha1 || is_null_sha1(new_sha1))
-		die("BUG: create ref with null new_sha1");
-
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		strbuf_addf(err, "refusing to create ref with bad name %s",
-			    refname);
-		return -1;
-	}
-
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
-- 
2.1.0.rc2.206.gedb03e5
