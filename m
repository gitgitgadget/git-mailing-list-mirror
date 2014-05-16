From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 20/44] refs.c: free the transaction before returning when number of updates is 0
Date: Fri, 16 May 2014 10:37:08 -0700
Message-ID: <1400261852-31303-21-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:39:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM6b-0002KJ-NC
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758139AbaEPRj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:39:26 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:52971 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757900AbaEPRhj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:39 -0400
Received: by mail-pa0-f73.google.com with SMTP id lj1so521267pab.0
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ionvpc9g2ipoJvzNksuSRCQ9NNgck0tTsvgWuhKqyfA=;
        b=gSkgB7wKq7ETpvmSIELlf7R3t/tfLV/Jbes6468Ux12qclraDqHnFbyZM33W8g7jEs
         4OzP6jEYhNVgrebvBqPUiUuDzMf0BLbilDmS5oSEzTDDNu9J/M/l7CFRBmra0leIgNfU
         F0hVb5jQHg1tlcFNoWo2bf3QWDgErQC/nPHiQu9acPROZfhQBOB/T9mFq9k0+JbHz9H6
         PC2EITl3yFAJw3ITxnAWvivuTzJjG2lhX+jvA4zkULY7TnPth1iLS1F/VhKXG9H5gL/Y
         pG8bIKrln1N8+wWyRyyS7Y/IWK1BsN07i9NB3df1re0aRf5PhRNEgQ2b5UKKtW/qW5nW
         BVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ionvpc9g2ipoJvzNksuSRCQ9NNgck0tTsvgWuhKqyfA=;
        b=cNHB6O9RhqJJr1yH8usqt+Om5AiA0KnGIvk6t0YgCBUtiyt1wOcVFeGvYtz/dtR0U/
         A9fs43bShTG+bXxXNfk5RwZknPwZzbDjls7BaInbR2nhIxb2Vd5GfusntGlIJdk0RaNM
         ScZAi0Eh3bojAO/wvBOQHBRavvFJSIzZWhkqA1Jt7fKMcFAUw+DL6db2GjP75pwK2Xsu
         O5L99jig1ykWVINpdcmSuHs4IAtoVf3bNDcWJdEFutZEs4eaXvGIUOW/5NsjIOZcGyEH
         ONi9QerEMSxXXYuVMlg61unJahQ94Y7lJBfACDeCm4mb0QyMfa7MOjwNUMfRawxtbz7p
         EWGA==
X-Gm-Message-State: ALoCoQloeNawXZKJoedxu98MaRH3wHprHpDGtrtfJ40tCL/PAK6KVvHFGFkzx7cToJSuMNakywcA
X-Received: by 10.66.234.39 with SMTP id ub7mr9431689pac.26.1400261857664;
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id k43si442530yhq.3.2014.05.16.10.37.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 77FD85A427A;
	Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 51918E0746; Fri, 16 May 2014 10:37:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249387>

We have to free the transaction before returning in the early check for
'return early if number of updates == 0' or else the following code would
create a memory leak with the transaction never being freed :
   t = ref_transaction_begin()
   ref_transaction_commit(t)

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 78312b5..2c3f070 100644
--- a/refs.c
+++ b/refs.c
@@ -3497,8 +3497,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 
-	if (!n)
+	if (!n) {
+		ref_transaction_free(transaction);
 		return 0;
+	}
 
 	/* Allocate work space */
 	delnames = xmalloc(sizeof(*delnames) * n);
-- 
2.0.0.rc3.510.g20c254b
